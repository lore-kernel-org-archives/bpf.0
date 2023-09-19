Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C45237
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:12:07 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC63BF
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:12:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JFtYig005785;
	Tue, 19 Sep 2023 16:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qi+JDenCjtjr8dP5sT6OZBTg6+SKqHUbmUxWMervSj4=;
 b=wkS2wlh1Qz1/ReX9hQUOM6bD/oVNQRv7xElpf4OTubimv36fbwed4rn+eX12Rgif97Wr
 mkCJL/lJUpLrC3vUFj0CXYUkeJfUeHg+AfYRsH0CM8ZpxLeEBukxbODMNRYx9vuzP4/t
 dumnQ49gjX3xyMSUOlKnzUGaB1m7Sh4hPT8IrPPyjwOel4JRnawTtpoV0yT20p57qN22
 346DAZDWFeND1MfryzJ7p9QmwrKjVRC6iQd29M5hMJxJxL4QevJCFhCWex9vflyUMZTB
 9uc9vzzQSlsxxpQB4Va909kNlXd3GreCGuiEHMrAUKFmVJ8tBdz0i8gUMbmRKT423/XX dQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52y1wbjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 16:11:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JFPBQn027199;
	Tue, 19 Sep 2023 16:11:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t64kpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 16:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pmc/Dj/nmqfJnv/ule76g0o2KSYLDR2OdC30rQ4quVzCDTCTNYHFsvLnaS03uek4a5PHxV71FstE6ALRpT0IZL7oy0q/Iql330+Rrpu3DCs+d43E+BVm4X329zwNSA2hlPC/3y7ONkFk0oSzPhpzfhVG8Nnk/QCDGHi9L8A0aGVwhDFwYHu0YE/CdjICU14sCWYsxFLHYKqBWZRIi5rMdEHvrv4oJDGoFztha3Drt24nBHdFwjnlPtIZxLJ4trlSb1GiYh5kjjqgRamZfY4Dof7Uh2YxO9/2e7IrJDZazUgil34/ocK/VWFmO57pdaWVm9KEA1WzOnVVRbb3N7UTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi+JDenCjtjr8dP5sT6OZBTg6+SKqHUbmUxWMervSj4=;
 b=e0UMWpasenOGuThTVmLspuz9DCHXIpSXiv2Al1Sg0VXUZXZIe3LrOWOMyfBUCM9FxvmcM5ys1x5slEAl9ayg7j5VSe9Xw7m6ZyzKBIowNnTAzY4QAN02I0crG7GbrQ/5VkaJS7Zu2Ah+8wwVW13S3S0AlPHG+l5vkVFtxd1PU+1qNwPGPqRZNBC43UATbAelJcj0U8OFvZr9e05E/iZp+Q0x120xcnkXP7jDhmCUl/HLwi7UMEuuoplOWKsDp6MkGCER6V4nyMoCLB82jnSgg1bfdN3WXk29YyoF0L6G8xDjUmC3aevx8JrH9nR+AiJ6PteAj2jSaUEgghik4S3zQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi+JDenCjtjr8dP5sT6OZBTg6+SKqHUbmUxWMervSj4=;
 b=QDvwxbAcqKobVOoPD4j0BpztZQNd6Tl/hvVLbqDLStiF4XULXRFvXVZdV3QT1By0eLabxPqZHm/P/33Ta+hDaSQdhk2Wq+S75JASbal67mRvLAZzfb+XIG4lsMku6VhG1uJNi6Oh0nCRHtn0b0WbcymEhW3Zo7m16Ozc71Pu5Yc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 16:11:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:11:54 +0000
Message-ID: <26d04fc4-0645-2abe-8aa8-c3682b6fc3cb@oracle.com>
Date: Tue, 19 Sep 2023 17:11:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Is is possible to get the function calling stack in an fentry bpf
 program?
Content-Language: en-GB
To: =?UTF-8?B?5YiY55WF?= <chang-liu22@mails.tsinghua.edu.cn>,
        bpf@vger.kernel.org
References: <49b9b6f.1279.18aadb90e05.Coremail.chang-liu22@mails.tsinghua.edu.cn>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <49b9b6f.1279.18aadb90e05.Coremail.chang-liu22@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0042.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa67465-177a-4f2c-735f-08dbb92b240e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GiIMQCA5JdeM4DrJ3d3ke9prX2RhDpgn77D8Rsmz5ku6pIAXEo7IS354U87Qnz0xGSbMhM+YJwoc8Oi3DBLiWfGW2BafkLko4qYR3T2fbsOPvwAK61kA7qdspa0pcPdrE2gdLrtWjfuqmvRgx/yUnqtaukYr+Fmtf/ejJPe4xLwuWLZ4k793e1gUKU9YJpKgk30F/ml0+RQl+/8FUIAmI3Nj3DF1XKOip1ISG7kEqBjgq5df75wAMSVK/cDuR5ZRdaRC9sKkLWhVEdu5D0uBNoZk4pXVRF4eMrt4UVlSbcyEdLRqDVE0MZKVIk/q0lTuncbJqh2QCNAPngXj3zUfgceRrtyIv+T40Eur1PtLvXqY7BRfYeFF8zMCr1Z6h6HxYWnxOWTl8WbowQIjJDE/newazOEkfZM6xTNL7KABxDZMMj4d1/WvKTh+P6AWOYQA2KxoJxxhPmCCZM0YLkbpF+a4ariKg46HODsaMPZaAyHticq7J3dNGfzQpuIA6zJLx8QU1VqjFsnkJFGWukbq33xLf1Goo7SxMoF30y3D4dWX38if4471JMOrO87toRllsriN40qCx0xH4uIR9euaDKSLSZZ9Coz1lx4j5P9qc/9wAgAMfHadZJPiun066FO63I8z5u7xilStiNp+A+DbXgcGjzEDz+FfugHhMx3iKYI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(186009)(451199024)(1800799009)(316002)(66556008)(66476007)(66946007)(478600001)(38100700002)(2906002)(31696002)(86362001)(8936002)(8676002)(41300700001)(44832011)(5660300002)(83380400001)(6512007)(2616005)(6666004)(53546011)(6506007)(6486002)(36756003)(31686004)(15583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U09xM0JvSHQzSFUwMGU2YTZjZ3FpWFFFbU82WGJuVVk3RTZsQjI2OEdyUmQ2?=
 =?utf-8?B?U3hlWEFuRytxTVNZWkdSQWtzL3FaSGx6b3lYelB6S3RPSlI1WW8wRjZSWWV3?=
 =?utf-8?B?UmJxcDcwQ3pYNGxWSE5lQ1hnSC9jcDBTeHRMMllnQW9mUjhBWHp1ZHBIWHNT?=
 =?utf-8?B?VTduN2tJeFd2bVZzNVkyM2ZhejkwNmh4VmVxUDh6dGgzUXoyUmtFRkZqOFZG?=
 =?utf-8?B?Q1d3SmhtZnNWQXR5WEFibGFmRjhHc2owTGpVQm9ZMzlhNW9jNFNaR2JGd2p0?=
 =?utf-8?B?ZXVyeG02Y1dVaGdQS3hzWGp5UzJENVhMbnczanI4Wk1Sc2NpcUdpSVdoTnpu?=
 =?utf-8?B?b084ZS9vVGpWMWQxRnVjSmdXYmRYTTI1M3puSmlYYmZ0akVPUVpZN3dwcG9Z?=
 =?utf-8?B?c1pJL1EzU2dUcURIUURKOHFldDlMUXBWQzJEMUVHeUxGL3hwQlNBa0xFNDRp?=
 =?utf-8?B?TDdhRm55L2UwdkFKd0VjWEplOUxCNGtiSHkyZUllMjBoQnpWclJTb1dwTTVN?=
 =?utf-8?B?TzVaTUxvYzVUc25pMHY5UzhSUGd4LzdKKy9tdUhIUkZ6bzkvV2tJbXdRTFRm?=
 =?utf-8?B?WllxVVFFMGM1UFg4bEprcWZLbkNWT05BT3dzeTVYRWFCMFd2N1Z5MVRCSlBF?=
 =?utf-8?B?QmRscWU4YUpTZkQ3d1JTeHhsQ2N4anZ6WFFxUEpFR0VNdUlxMi9lVUczOWN1?=
 =?utf-8?B?ZGRRMDdQWEZkbnJyTjBoWG96Q2lLQy9rdnNmTExrWmo5NjdDMzg4SVhNdkxC?=
 =?utf-8?B?RkdNWkpKY1VGdG90ekFXNTVyenlQeFpuMzVhMEk5ei9jVEF2WUJ2OVh5QThm?=
 =?utf-8?B?dEd2bVhMWGlicDc4YmRQUTFBUkQ4OWNWMnRDbVhST0xITWtZaWNMVzFERUtV?=
 =?utf-8?B?TUVkMmk4cm54OU5zNzRVb0dGZlU4SnFSU3orWGFrdlR0a1QrRkhZQ2MrWFFZ?=
 =?utf-8?B?RHpOYWt2N0kyNHR0WFFUZndXMnZCRGsxRGtwNktzMFJxN3FZcGJsTEVWUWVW?=
 =?utf-8?B?YmpQV01jUzV4U3JvVEQrQmxMbk1zajF4cFNHTVQxaHZOdHpoNFQwTVVDbkla?=
 =?utf-8?B?bTdmb0ZudVJQdDc4NVBqWWptY1VJamhjMExnVEpENktGZWVNZnlaNTNCYmdG?=
 =?utf-8?B?bkpvK1JRNUVrckZ2UzBWSWw5bFZ6NHcxSytiRHNjL2lGMXcreGh2V0Vxakpn?=
 =?utf-8?B?a2t1LzlJOTYvRHVsRnBDSXhvWHFhVmxqaFpreW1GVUdIeEV0WFhlT2R0Zi9h?=
 =?utf-8?B?dmFJamtubVNjRDhNWnZtYVZnaVEvS3VxTTJ0c1NNTzlxVmFZRGo5TGh2UU42?=
 =?utf-8?B?dk90MEp3VWFpWmwvS1ZBOE56Skk3YTFHWkNqV2FtZ3dsWnMvV2JtQ0F1ak1O?=
 =?utf-8?B?cWZaV01kVHhSRFhVNWRHZkhmdU4zY3hhVytQa3dMYXFWRGFGd0VsLzUrMndj?=
 =?utf-8?B?bmxlbTR4VWp0R3I3RXgyUWNvNzBZbUFjRnVnbEN3ZjJDVlVCNCtxL0xKVFg3?=
 =?utf-8?B?TjlqcGIwVVpDRXlkWE16TEhsbGRsMXJxQk4wSmFqREV2T2pESGtSV0ZtOXky?=
 =?utf-8?B?M1FsNGJnc2VNQ2JZR0VQTzE0aDN3YUR1TzZmbWpLZlFoMzdjUXJEa0J1ZGVl?=
 =?utf-8?B?UUU2d0FQNEQydHpSREZ6RzhFZ2plK05XY2RnNDhrR0RXWTMzdTc4amNXSkh1?=
 =?utf-8?B?UXI2WU9yU3pvN2RpckZocGNSU3pmN2g1WDlneVRJZ2RvZWNGR0VjVkt6Q3Ez?=
 =?utf-8?B?cHVTdGZiQlRzalcwdTlFb2FRR2JJUE55V2JKVTRleGZkV045THllRm1KWGpS?=
 =?utf-8?B?dmdOOEhZM0hmeFdYQWp4NGlSdGFRMnlCa1ZkZllkMHlxSVJxZS82U0txcG4w?=
 =?utf-8?B?WnpmY2pYYk43ZW42YkpjdFVrbExXK2JYQlg2TXZQazFFcjN2YVV1d1RTVVBa?=
 =?utf-8?B?N0lTQmhZU3JpWkhqRXA1aXBLY2hoOUx5RnJJeEpRWDBCL1hCNVJWS2tWOWFX?=
 =?utf-8?B?STh0WFh6NlNlQkRzZUpCdW9zKzFlV1IrMER0TTdxMFZtQ1pHSFJUcDExdzFP?=
 =?utf-8?B?UlNWa2J6RVp4a2hjemRJVXA3bFVpQVlvbkwrNWw5TE5XSEExYlNVT0wwVkFF?=
 =?utf-8?B?L3pDMlY3eHRmYUxyWk8vRkZqZU0xd1g2Qm1FYWFPRWFHZXVyT1FFcUFuS3JY?=
 =?utf-8?Q?oPnOMGqfg60MRKabQLg7aJo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/NZRAfbqoOw4URkvfu8ibx6JehZeci7SMaNhOfmy59b79aF8f5I0Kr/6HexgN4x9IyKgIydXct3QoGHWCIyfpER0dhWYdXeJOgA06m4ovv9So8LyF+4QFsmAKm0qf+3uB5DegNAx/iJi0lh5XPldfEFWk/IMmM4WDUvE5cGeK59b4dT47eNklW/Sdx27TVYCrJHL0da6V7QLlT220une4SY7UscfWJ694pssDZ4KxGLA7kVC3hKQt0ZJQmPs6FbqTEbbdX2RPw1cAY//J4aKV5m2X04csdBmsNDtNfbEH/ZVyGFS8LZKoRALGIKJce29LAWeD/1P9vpm4TF7+PxZ2BJYj/cvsx4J2pn9oRi9Brl/klekt587XDGaoJ+2sfDGYSSTb+5Nb2K1DLbncJWXBE0pCC8JE5RHrNB55PWgqRIF183QDhHpbLryn+zkg1GSxUfRLtwvliVeFE7Gp7R6faSwvGc0LaYeKfZPIzhckh+CIvJh9FFQbRW8eSQyMkhUkuuvxahlKsLaRDS3w/99QB6X2JmuZd4qFkC5J2flafhtk9gY0QK2XB66rmFyy859y/csfZCECnCtzUbcNNbBm5LJCwtGslz6cjKjNwldXUTgCpvKyYPsc2lf7kGnGWhKtkWr2EcH7gxcmrGFMkSrRnWPepIuap0fOpgiUyOOcMbj6Ltry3Ax4QwVETOmZXnkdxVEfcVx2Qhi4VNeu/Nk0Yp4e/9082rzrKyEdm/MqLIcFTobC/xgZvYVquccFxMnMpcvzpyMwnUFr+seI1tOdSVHGWTw3WAIoR1giVFGdZf+wh+R08/1RfxGwPAEh9MP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa67465-177a-4f2c-735f-08dbb92b240e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 16:11:54.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSmMtTqrLpqyFTRFrKzaO/Mqa87b3RsgKcw15xfooOZIRNhsR+oBhVpZUhRnnp2k/OQpJ1/hj/4qKBUzlgTo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_07,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190139
X-Proofpoint-GUID: GQUPsdK-GepCqm-NW3gLFFQayxx96H6Z
X-Proofpoint-ORIG-GUID: GQUPsdK-GepCqm-NW3gLFFQayxx96H6Z
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/09/2023 14:55, 刘畅 wrote:
> Hi all
> 
> I attached an fentry eBPF program to a kernel function, i.e., tcp_transmit_skb(). I want to implement different logic in the bpf program for different calling stack cases, e.g., __tcp_retransmit_skb()->tcp_transmit_skb() and tcp_write_xmit()->tcp_transmit_skb(). I know that I can access stack traces using the bpf_get_stack() helper function. However, in the fentry eBPF program, I don't know the value of the RSP and RBP register, which means I can not locate the return address even if I can get the stack traces. I want to know if there's any way that I can get the return address and thus get the function calling stack in an fentry bpf program. 
> 
> I'd be appreciate if you can help me.
>

Note that fentry programs can access the ctx pointer; it's just that the
BPF_PROG() macro hides it.  For example, see

tools/testing/selftests/bpf/progs/test_bpf_cookie.c

...where we have:

SEC("fentry/bpf_fentry_test1")
int BPF_PROG(fentry_test1, int a)
{
        update(ctx, &fentry_res);
        return 0;
}

SEC("fexit/bpf_fentry_test1")
int BPF_PROG(fexit_test1, int a, int ret)
{
        update(ctx, &fexit_res);
        return 0;
}

Once you have ctx, you should (I think) be able to call bpf_get_stack().
If you've got a limited number of function callers you could probably
search for their addresses in the stack data returned without having to
parse stack frame boundaries.

Another less tricky option though is to trace the calling functions too,
and use a hashmap or similar to map from skb to caller in the calling
functions. Then when you reach the function of interest you can check
the map to see which caller added the map entry for that skb.

Alan

> Chang Liu
> Tsinghua University, China
