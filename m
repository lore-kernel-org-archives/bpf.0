Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D52311592
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716671; cv=fail; b=GwumALyMMk18rjTepHnZzoJql8+2pO+5HCqJMHIPy8hyDJ9OxVbC+vPgXDpnLBGH/vYFDiefRyMZo55AqGlAOTB2HoGSDM2vkxNPVENAdWLblMGCg9N7C4P0IkOafUez4uQ+Gu2tJRUuX9lgoSHAKgKNTx+ph9KJb8hpcp7WoJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716671; c=relaxed/simple;
	bh=J92wmGacCBOxP0Vzn9OfdxFNvxVGhoWpvDIAHAR0Z5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRhkqbbNKi2/6iMJKDspkQGZdZTw88B1UR++rURPvzQRW03h8rEeVyNJu22caucBLQ9mnXgTzyTzAXkN1XI2ufE9uh1wszKrC0CFiocDHOou5EbQxpyjCnD9bhzV+4TekfBvN3hVCjd3SoZ5jNViIKZewdME5M//mJh/6VB3IvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QKMN0pZ9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wp8cmgjP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QKMN0pZ9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wp8cmgjP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I3txIf1932960;
	Fri, 18 Sep 2026 07:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DUcqAm3+UfL+GB5vCs7C6gQbL0qVC4LbOKrVuRNzfHg=; b=
	QKMN0pZ9RsblZOD9ShhYh/LXLApASfXfQcWkBy9N7AlFazFfdoDlMvdbpZRzAStE
	A4K7eFa6FeFARDXB5QF8bUFWai2O3riYSYJx0qpe46ItLweAl+tTBnxbDuaXKSTr
	cJe09xYqHtEjkNFt+Z7VZM9ZoPoug1DA1QQU7YulAS6Dh8c9Mfop6Zd1JyRed2+g
	2ObYFMmertREUC3fZdlTKGDK+X1XLS2Vzc3ErtTtFLrxGFUfs8aPVkgeANafLXEI
	iV8QsSAEI5WV3lN7EXwW/cydPQFIsxtaiGPQgRXA+qMouaXOv+yFA26+7EBiGTTb
	fbSSukI1K6t4C0kP9Mxz4g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmxbs8ywe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 07:30:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68I7U4IX033534;
	Fri, 18 Sep 2026 07:30:43 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6e08et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 07:30:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt6GOda+9J4p3PGrxKU7g2mV6JrvDOB2WYlDCnnO3FrgENVhBSFNb1rAuHXrnex3r1R6S4T/01hWnK30+xDNKtBmL01S0ey8KIb2D1YptzLxu2SFPGsey+JsM+U4k64+My5nWzswblHaCZrETwMntBGFgCQLeZRRjArJw2IlThxVKtVoTOWDMbwwku4JP6YJhQJyUy+/G7dw/WGflG8UXs2YYPR1SxsiVaT1aRSzkxnagftWjRYRtgBp6a6k1S0FIkVEjzNajgeM/w7HQe/LFo13neczY+cZKqqCLuJVUiN42bsAHfz2/Q+4Jv6aTo+dY4uholwsKAY3vrHnMHnbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUcqAm3+UfL+GB5vCs7C6gQbL0qVC4LbOKrVuRNzfHg=;
 b=owpGwMTkCNtwJv/PfGnn71FkCqrUsFF0Nqk7cXCQFD5RDX7Luvovxk2S0B6rSZco28BCpMjOPRJ6ZQ1WXD1ShIg061FWZpS4H0Ztxlf4lpvTY+so2+R8O0/fnqyeHWQaiopP8/Gb5SzdYHUAC2NJ6ifc5B7N56AsKIVIPwqehEM///KIB5L10um9ywveiRTUANbfFcWv3NkQt9aLFb+LwHOWWLLxylaqPlM9m3nXW/rF3HOG0TasN9NooASV47ZlPHMwX6ukEJY/ejpKI4Oyd99RadvTI11L/tc8HrsHCDEoW3MhiLHy9wJJkNV7cSTFt6Kj8qHPfg0AcyQc1dCzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUcqAm3+UfL+GB5vCs7C6gQbL0qVC4LbOKrVuRNzfHg=;
 b=Wp8cmgjPtf34x2m0M/vcPUATB5vcjjdfJfP9YdrbQMUmFJFfGWdRnRBVmpDt0tWcqOROoZvefmO110k/U81TA9aEXY5SPTr7VCp01V3oKntTuNPeK5XF1mexjV+r7CUk1y2ZK/F5ZJvgX4ISO/fV0KBoJON0GQYWWprPa+xzPfw=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by PH9PR10MB782475.namprd10.prod.outlook.com (2603:10b6:510:3e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 07:29:37 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%6]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 07:29:37 +0000
Message-ID: <c2812ec8-29bf-4e6f-b2ca-8b96fe058a05@oracle.com>
Date: Fri, 18 Sep 2026 08:29:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, andrii@kernel.org,
        eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
        puranjay@kernel.org, yatsenko@meta.com
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
 <89767d7c-c622-42dc-a820-ead87ed3e2cf@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <89767d7c-c622-42dc-a820-ead87ed3e2cf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::16) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|PH9PR10MB782475:EE_
X-MS-Office365-Filtering-Correlation-Id: df715f65-7e2f-4ca2-836b-08df15569839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|6133799003|3023799007|4143699003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	dhzKkTPC0zzsqkfBwgcB36oWAE10KO/aZBe/orisQQcSAby67AIkauX3UUxNJltTD9wMXMNgykJj4yoGaWhSAas9R53+6Wgk9kmbUdkTJ+yzwhy2P7XGa4nGrPIaliGvVP978c9eK6nRGzeXv6s2xdu7pbgLSagtcM8jzgGjQf5BFOkMyavXYdyQvoV8516nyFbaDrAJ6Gdp6QpMNZ8KsFHw29IKqqGUUH1wlwgBbEZv0eUROI0Tqd2LpjmZrg2VJc1hc6VuxORfWYznUro8tUyL4i6djgDnpzqRhVhvGftjHqKm4XWx7kmkQ+Mxv1J/Ki0W1RUiyH2KxAByUaMovlqzv9y+yx9FetNhi7JtqcfdfThMM/oHOOBzQCcCct50HcIAuCA8bZgtaX3F+Gtx1zcu9Z+EUwxuERoo41oCysSuwRGHDRKaxDqYOVjJ13nL9+fteQiheOpbXwX/TEhZaDXbjilm3Yc2EaS0uES7WGAt7y9xvqEbf/wtQUXzyQEEK8t2GoQgqPm+rbDeBPcXHjXqBvW32BBP426QeCs3mZTZuUJBC7Vl+VqWMsQoMKg/uLzrwlVgDPu50J0RKMoVLPhNDqBd3KnvIHogJJPt8wOxEhg1MUOhUoK8GU58nfnu0BRc46OX0iZKBekyyOeKNiud8JwlwqbV50NRGXGoPIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(6133799003)(3023799007)(4143699003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzFOUEttRkJaUGcrYjMycEE3RHVqU3Y2RjdTeUh6VVVlMnM2bjAyS3M3SC9z?=
 =?utf-8?B?Q3NqcVFQN3V4WW5MYWNndEdCL1BOcXN0SDBTeXVHUVMxcGFPVHBHMDI4WVhi?=
 =?utf-8?B?NTBYeE52SnhZWWw0OHp1MlM1TWszRlB4Wk5JSGJGQ1kwVnJEdVY2bE4rTVc5?=
 =?utf-8?B?elpvbW5kUDR6ZUd4cjNnamNyRkRvUnk0dE1UbTVyWkc4WTVhY25XMGtqQUJv?=
 =?utf-8?B?bldiQ3ozaWNJcFV4aHNScnJGcnhTRVgzc0ZLL25rRFdSUStvYWdTR1diZ1dS?=
 =?utf-8?B?dWxBcndiWWtaNC9DY3lyVlBsY3NFL3FDQW03ZUdBU2FkYmx0Wi9aUGpORjFp?=
 =?utf-8?B?cy94UWpUWU1OQXhzUHFlT2lhQjFMNDRrQ09YZUpwd3FxQlhhMVdvUVBybFRi?=
 =?utf-8?B?aU9kdGZ5NDhPZG9WNkxJaDMwc2lyaitFbC9Sc0xIMVlYUXcwdVhqWE5pbWx4?=
 =?utf-8?B?UE9TYklDVm1NV0MwVGNtNmg2QVpSalk0a05aU2ZJcTJUNGR2TGxCd0RoVytr?=
 =?utf-8?B?aVBmdFA4NVFlbEhXSjNOVmRlbTZXS3YwazA0bFQ3ZmpFdVE0MG1sOE1sdSsx?=
 =?utf-8?B?dCtsWEoxTVBwOHArZGpPN2ZwdUFGNzVOUzZJaVlQN3B1dFZaY2VabUZBUlg4?=
 =?utf-8?B?dDA2ZWpSQXQ4dEtuSWpuZFdVbEd6M1gyTElCTWVDcGNIZWtZYkFXM3RzalEw?=
 =?utf-8?B?UUwzK3pHcjJRRnBDR2RiYnlIZlVUU0tRV0swRjU1bDhQdFluWDZqTnJ3dHlk?=
 =?utf-8?B?NGhHRmVpZWVlNDMwaGw5OUVFbHJHR21Sd1FnRFFnN2xGL2Vxd0I5QkthdUNu?=
 =?utf-8?B?OEZDVmdOeXRMTnNxSUdRTjIyYkc3ZFJqeTZHSGt0WStMWkVZYWxMVnIvT0VR?=
 =?utf-8?B?MER2V0szcHNpY0hPemYxQmF3bWV0VDhsMzVJTkdUZEwvdFRKQXBsaEVVOExq?=
 =?utf-8?B?NzVTdFNqNGVhMGdXNURzSG9ERHVkRlBZMll5d2JiTFRoMDlZdVZ0OG51SWNt?=
 =?utf-8?B?ZSt0eGh3blRuOHlEWVlack1yd1JPdTJ6OTg0bW5VaGRYU3BMWngreHVrTVZN?=
 =?utf-8?B?NVJSeVQ0OVl4bnpBL3lDV3ZOMTd5S1N6UFVLbmRwVkJZME5NVkVFSmovc3gy?=
 =?utf-8?B?ZkRxOVc5QUxxZ3NNU0xScXJEczNUZElDYi8zcWp1NGNoNWhnb2hrUGc4WEJK?=
 =?utf-8?B?WEhaQzdpUmZZQ1NBSHdkTElIWmpPaWQ1WXhtNnNLR0NKOFlZRFFIWTIzcHV5?=
 =?utf-8?B?aHJTZjV4dFk2cFg3bk1KRDhNaHBidTZqLzdYV05XWUxTRmFZOFlmMzA2WUdw?=
 =?utf-8?B?ZDRzc3ZHSzBCOC9SanBjMEk1T2xNbm40aWs1Rm1YM2c0UjBDdW9BMWxZbVhT?=
 =?utf-8?B?Mm5ucER2bkw3Q0pjaFJhM3ZuZEQyc2VnbS9OaGovckY4S3d2OFlyV09FVGI2?=
 =?utf-8?B?UTNJcHc4ZCs4NytaVGlQdnhPdlZpTHg5WWs1R0ZjeUFrdEpDK3h0dy93OCtr?=
 =?utf-8?B?a3I5Q3B0MWlRQzVSOXkvbXk0L2FXQU5qWHVMVlp3M2daU1VTaS9hcjJKeHpU?=
 =?utf-8?B?Kyt0VlI3VDYvS3dQOW1ncVd1TUp5TDhMTmN0YVRHKy92TG9HYmMzRkdNeHpU?=
 =?utf-8?B?b1N4dnczQ2kyZENFYmgzWDg1SVc4ODVETzhndkN4L05kVWJsMDhYWjFjTTZr?=
 =?utf-8?B?Rmhab2I0QmRub0F4WG9LdG15ZWpGclowTW45K3hwZnFEK09uUndFY2w4TnJq?=
 =?utf-8?B?K29jdWJxQkF0UHl0cXMwaU45QS9wWVVqaUczWjZEWWdtd2dlODByYnVlZ20r?=
 =?utf-8?B?SE95RjNTSGpKazlyQURxRGJlTERnZTZvcFB2NFBUT0NubEhheEJZOHN5RW9h?=
 =?utf-8?B?WmRHSVpwSWR1MURsRE9WTUZMbEtiNW9tMGRKUXQxaWV6ekVVZWM0dXJ5T0Nk?=
 =?utf-8?B?L1FxZzJIVjFDV2FKQWZaTVhnU0prdHpGSEtUUEtHaEx0dUlueG1OTyt6NHZN?=
 =?utf-8?B?OFRiYU1jVFA5dHhYcE5kU1NyaytoR0dwYk1TSGkxOXY0SndVcXJaYTFwTStG?=
 =?utf-8?B?OFlzTE52OXp3SUltQUwzTlN3ZWxJMEdjRzZ3bkRyeVNON0VMQ2hQc1JqS2xL?=
 =?utf-8?B?Z0NlUWI3eVZUYjZqNUdXYzlzOXZjNmVNZHdjYXhKZmwzVEpPSnNnSnR6WlM0?=
 =?utf-8?B?ZXFybitwbXMxUytMOGQ5QVFWck1Od3BUTXVSdWs4Vk45NjdOM3JqYitGbWI4?=
 =?utf-8?B?RENqYVJPOXhrd3N3QUE3ZjBNV1hxRWdHZUdOQW9Dc2NzTU43Rm9kd2pwMUF0?=
 =?utf-8?B?QVFkdVJydEVYQVFkR2tqYVR0bEhMRXZHZ0NOWWswOXRISjJNWUltQT09?=
X-Exchange-RoutingPolicyChecked:
	ku80VuRaxR0bRGE7ZIPJMxUeSAR+D6pNsaJl+Lk6rcdyfvWxOjF/PV/vmbKMQCywWGyhfSFA86U7qdrBUPyRmb9uoB3BrS4i8fCoM04h40anwuWRJ2l3g7GKWUQtPi57b9UKe0Ha5sU/XHwS1xRMhmqJXhSWMSLjv7Xej3d96lBC5Ri0TzOPAHE0atMEgU8sPKHXOKDXcbpP0vVCgO2u548wsLVz9oEd16zUZNHUsoD98VoFxhvkMBBor907wa7P4oV/dAkfSbbeWOQlghj2l51UNbZn4ue1YlSkfgJmzsQqPkRZSkYC1XqCDEfydZ7FEBH4G//I5g5pCwNCbw9TIQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T1466uYyVFiP36UZs9T53M69Pm8/BsuP2gKo7VZF83vEpHA2WFjuPVm4ofPo9Kj18ZdNkDPiqHMIurrr+kH9ibg8WGCNgFURrhCnBITmaroxB1ZNceEyrISbg2NB6llpjEjE7wxfdBh32aXbgcY9q+gc540qMHkR86tuK0QzDeMm5QdwoqVtlZWZsQGwocMMyXF7gc56zL6/NpAsxcYYqvfs0hksziEXaX791h/xLsz+z6qHLms/PMWqC5aUYaJuuU9M+OX86SL1U9uHK/AivRRx0AYoCY+qavhpAzbRVrH5NhynZAQfW/sut8xJquF1bWwk1nSjbYJFglOw/txZxxVgvJWNLc3sbjH5ZN7HqwIvskvTCmqqmfn71c3cQ35M4b6U4CQh+kzz3VpL07vK7x1jZtuujEpxP7YKE2ILud6YQJHHCLAnffNCY2SLsYnnZ2dEIUMSYv936Hia5Mn5/diT0Izh7W8xlJhIELHLD0/OTWyb/T/UEviHxWJGU3LMDvHdFqfepkDdNVrPLjcvNiEAfutz/E/nw1oV/X4ol47rd+tdqKEXqd+R8j5OHw6L5MX/qJm+qS/BurJaNIsipdZ2bt82fpzSWtn173IHwLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df715f65-7e2f-4ca2-836b-08df15569839
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:29:37.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HvltZt6SykV88Ux5Z4fgFatrXUrgUnG86gRxRCIIz2AGG9+T7GiAkf/RwSW6fgagHgQ53PrKebyJ1MTt+2kRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR10MB782475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609180101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMSBTYWx0ZWRfXz8+MpLPLe4jd
 mjbptFMQvn3RcMXE7lN0unNcWiWwWSEgWCsj7Ry14Tl4Nqo5jEwgoXhLTBKOdvMCCnTjBvatygW
 uuuwn7fVJ/5aA3A/yQRbUw/UucEPPIKif7VSvZbLerOvj26s/PO0EsNteSwUhow4SrTJjO91pBn
 Ij703iAuXCL/SHDtsKCmI7QKjVaPtHqBZS9cHxaT0BsRmzoj+ioXmK9L9NYOpbtSQff/qqV14u/
 PHw87yjhacoSRa6ISLIuqIuE+hVIQhAJt1EHmv0Vr6mqAj59eL0NFa37gK9t3Nk55HS0mj5wEPz
 SNi8YcmZPwtAtcZhDMu+J4JF8l050BtXexklEz1UUEqmAT/ZlhJjcb854KoXl4aGzKlNR0FeuPf
 urUodE3gRwMxswNlE1rboQ+sAHpbdAYsYhW3sPfUKbQ3UmdwGT/YjFutLn2cAVE398PqjuyEZSA
 QBNCpzYmYK/dd2+MgAw==
X-Proofpoint-ORIG-GUID: GvWRdfdjg2jzE4vczMyNHwUV5jPAMzMu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMSBTYWx0ZWRfX1bIn5bWWsdGI
 tJtOT+FnxGBEcbo0PFYBCA64PQMJEuS4CVQd+bSwq0k5GzxlvVHoOKJFvV4dHoAxfLwKnJdZyOY
 jirKvse4e0ZtXT9nzcnagckXZcd5SHNMMySIttVUUk/lib2viW4I
X-Authority-Analysis: v=2.4 cv=DIYacCNb c=1 sm=1 tr=0 ts=6aace8a4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=k8p2YUJgWV_7gAfxYP8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GvWRdfdjg2jzE4vczMyNHwUV5jPAMzMu

On 17/09/2026 17:06, Quentin Monnet wrote:
> 2026-09-16 08:41 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
>> In raw mode ensure we can dump new BTF kinds in normal/json format.
>> BTF_KIND_LOC_PARAMs are rendered as strings, for example a
>> const value of 0x2a and a dereference of r10 + 0x20:
>>
>>   [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
>>   [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r10 + 0x20)'
>>
>> LOC_PROTOs render the associated values of each of their
>> LOC_PARAMs for easier readability:
>>
>>   [14] LOC_PROTO '(anon)' vlen=2
>>   	type_id=12 value='r1'
>>   	type_id=13 value='*(r2 + 0x10)'
>>
>> and LOCSEC shows function name associated with site:
>>
>>   [15] LOCSEC 'inline.text' vlen=1
>>   	name=foo func_type_id=5 loc_proto_type_id=14 offset=64
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/bpf/bpftool/btf.c | 169 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 169 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index bbe8f9ea144f..5e0cb5862811 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -51,6 +51,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>  	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
>>  	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
>>  	[BTF_KIND_ENUM64]	= "ENUM64",
>> +	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
>> +	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
>> +	[BTF_KIND_LOCSEC]	= "LOCSEC",
>>  };
>>  
>>  struct sort_datum {
>> @@ -117,6 +120,83 @@ static int btf_kind_safe(int kind)
>>  	return kind <= BTF_KIND_MAX ? kind : BTF_KIND_UNKN;
>>  }
>>  
>> +static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>> +{
>> +	const struct btf_loc_param *p;
>> +	__u32 i = 0, vlen;
>> +	__u64 value;
>> +	bool negative = false;
>> +	char regs[32] = {};
>> +	char num[32] = {};
>> +	const char *op = "";
>> +
>> +	if (!t || !btf_is_loc_param(t)) {
>> +		snprintf(str, sz, "<invalid>");
>> +		return;
>> +	}
>> +
>> +	p = btf_loc_param(t);
>> +	vlen = btf_vlen(t);
>> +
>> +	if (p->flags & BTF_LOC_PARAM_REG) {
>> +		__u32 nregs = (p->flags == BTF_LOC_PARAM_REG) ? vlen : 1;
>> +
>> +		if (nregs > vlen) {
>> +			snprintf(str, sz, "?");
>> +			return;
>> +		}
>> +
>> +		switch (nregs) {
>> +		case 2:
>> +			snprintf(regs, sizeof(regs), "r%u, r%u",
>> +				 p->values[0], p->values[1]);
>> +			break;
>> +		case 1:
>> +			snprintf(regs, sizeof(regs), "r%u", p->values[0]);
>> +			break;
>> +		default:
>> +			snprintf(regs, sizeof(regs), "?");
>> +			break;
>> +		}
>> +		i += nregs;
>> +	}
>> +	if (p->flags & (BTF_LOC_PARAM_CONST|BTF_LOC_PARAM_OFFSET)) {
>> +		switch (vlen - i) {
>> +		case 1:
>> +			value = p->values[i];
>> +			break;
>> +		case 2:
>> +			value = ((__u64)p->values[i + 1] << 32) | p->values[i];
>> +			break;
>> +		default:
>> +			snprintf(num, sizeof(num), "?");
>> +			goto done;
>> +		}
>> +		if ((p->flags & BTF_LOC_PARAM_SIGNED) && t->size &&
>> +		    t->size <= sizeof(value)) {
>> +			__u32 bits = t->size * 8;
> 
> 
> Hi Alan, thanks!
> 
> In the case of BTF_LOC_PARAM_OFFSET, what do we need "negative" for
> exactly, is this supposed to be the sign for the parameter or for the
> associated offset? My understanding is that "t->size" refers to the
> parameter itself, not the offset, so we would pick the wrong bit if
> trying to find the sign for the offset? But I'm not sure I read it
> correctly.

sorry, my previous reply had this wrong, I was mixing up an earlier
iteration. The idea here is we display the offset in hex but since we
can compute the sign it makes it clearer if we fix up the value for
display based on its signedness.

The code above has a bug tho; the size actually represents the size of
the final value rather than the size of the offset; the two can differ
for a case say where I have a REG|DEREF|OFFSET|SIGNED which has size 8 but
only has a 4-byte signed offset. We need to compute the signed value size
based on the type vlen, not the t->size since it is the overall size of
the result of dereferencing via the register value + offset. I'm fixing 
this and adding a test covering this in v4 and updating the UAPI to explain
it more clearly.

Again thanks for catching this!

> 
> 
>> +
>> +			if (t->size < sizeof(value))
>> +				value &= (1ULL << bits) - 1;
>> +			negative = value & (1ULL << (bits - 1));
>> +			if (negative)
>> +				value = t->size == sizeof(value) ? -value :
>> +					(1ULL << bits) - value;
>> +		}
>> +		snprintf(num, sizeof(num), "0x%llx", (unsigned long long)value);
> 
> 
> Looking at the different existing flags and their docs, I see:
> 
> "a BTF_LOC_PARAM_ADDR|BTF_LOC_PARAM_CONST is an address that should be
> normalized with respect to kernel/module base address."
> 
> But I don't see the output accounting for BTF_LOC_PARAM_ADDR, is this
> expected or is that an omission?
> 
> [...]
> 
> Please also look at Sashiko and bpf-ci's reviews for patch 7.
> 
> Thanks,
> Quentin

