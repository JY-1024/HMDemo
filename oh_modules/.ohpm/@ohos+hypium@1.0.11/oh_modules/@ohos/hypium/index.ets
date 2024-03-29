/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Core from './src/main/core';
import {ConfigService} from './src/main/module/config/configService'
import {DEFAULT, TestType, Size, Level, TAG} from './src/main/Constant';
import DataDriver from './src/main/module/config/DataDriver';
import ExpectExtend from './src/main/module/assert/ExpectExtend';
import OhReport from './src/main/module/report/OhReport';
import SysTestKit from './src/main/module/kit/SysTestKit';
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, beforeItSpecified, afterItSpecified} from './src/main/interface';
import {MockKit, when} from './src/main/module/mock/MockKit';
import ArgumentMatchers from './src/main/module/mock/ArgumentMatchers';

class Hypium {
    static setData(data:Object) {
        const core:Core = Core.getInstance();
        const dataDriver:DataDriver = new DataDriver({data});
        core.addService('dataDriver', dataDriver);
    }

    static setTimeConfig(systemTime:Object) {
        SysTestKit.systemTime = systemTime;
    }

    static hypiumTest(abilityDelegator:Object, abilityDelegatorArguments:Object, testsuite:Function) {
        const core:Core = Core.getInstance();
        const expectExtend:ExpectExtend = new ExpectExtend({
            id: 'extend'
        });
        core.addService('expect', expectExtend);
        const ohReport:OhReport = new OhReport({
            delegator: abilityDelegator,
            abilityDelegatorArguments: abilityDelegatorArguments
        });
        SysTestKit.delegator = abilityDelegator;
        core.addService('report', ohReport);
        core.init();
        core.subscribeEvent('spec', ohReport);
        core.subscribeEvent('suite', ohReport);
        core.subscribeEvent('task', ohReport);
        const configService:ConfigService = core.getDefaultService('config');
        if (abilityDelegatorArguments !== null) {
            let testParameters:Object = configService.translateParams((abilityDelegatorArguments as Record<string, Object>).parameters);
            console.info(`${TAG}parameters:${JSON.stringify(testParameters)}`);
            configService.setConfig(testParameters);
        }
        testsuite();
        core.execute(abilityDelegator);
    }
}

export {
    Hypium,
    Core,
    DEFAULT,
    TestType,
    Size,
    Level,
    DataDriver,
    ExpectExtend,
    OhReport,
    SysTestKit,
    describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, beforeItSpecified, afterItSpecified,
    MockKit, when,
    ArgumentMatchers
};