Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D599283C93
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927940; cv=fail; b=cofD/mYqBt5m14xyXr6aLYmZ2LSOiNHDRFDTHZE15tk1R+iNk/TZLZMSsYzgPGfREvU6QuKLmeuEJmTRtrGTl9Ze8E5IE9QJurq5rMJdgaayfx94ZwsQc9W9uirckixrlxM3Um0uuWBJk/yptZq2aV5w4MzpYYNE4bwaf4dnOtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927940; c=relaxed/simple;
	bh=SXFdZ091wfVOdcnyrm8xc/q26B0MDPYnLYhrFi1Ukg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVwtUTqwfNKyaQ7Wd/OtbP7Ilc/JK0lbgQTKtdnbkI3r24UoCCnKJcJIYRb93G5xW+lwBIQkNNVjV3HjTzG/sZ8q+IjHkDycLvU9JD+EtGgckNbdzX1VJKqf1f1rL8RRz3r895AFecRKCOuW3EoDCAXRQ3jZ/38DxLgS6jBJIWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fjbCWmUE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lI5nzJgI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fjbCWmUE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lI5nzJgI"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J5Jql82168015;
	Thu, 19 Mar 2026 13:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cJTkv57dk/NRCw2HHGIRZf8rm3owReDKPuJaOVt8098=; b=
	fjbCWmUE3bE/3vNEosQHlQZIVldMgHFjdEx827g9Kgnzoss1RkiheSJYl/vZ8/Zi
	Fp120m5WO/cbYA6eSLmb8XpCstla+dhBuNVCWo3pr7bUYZEvOXvg60gHNSzmz0Lk
	rYE3jAe7CR8eWZsjX1VeaOg1n2AKdHv9AtNPNjeSES4Jv7A9tvD2Uw6r0psMXSaE
	snRjCHsp3gWdYegJBKK/ogr5SfWYrBj3pTdgyB8dfDcDXfC/wl4Iz9GQMONV/Vu8
	hkW3OAZp8+HdVDS0uoroo6a+lX1G1R5E3R6c2L0tcrLG7QOcJGG4+IMWoKFAU590
	Vt98QlhilGfhuRro/OkZcQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b7r0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 13:45:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JB2a3t017867;
	Thu, 19 Mar 2026 13:45:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qhfxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 13:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWH+1ixPODZSTml2VaJAO6Lim5i7BCKT6F5LupVmR9CHuMKXmVdJtH8+WdWFCFYaaWju6t7rMPc7n8+u+yhDQikivEnb/e7oWdnkapm5PqAHzUHzG5I+pi96Q92KqzDdzaExCDSQ66WKJT7ZhfJv0BjzpdpPD9/+3G47bmb3xfh9hFt+tdpnYBbqda2mxZXG0llprzKgKkZ9TFRw0CMNl56V8sE90QNkfwWSf3RamDDR2UL+maX/V1PnfdkIxw6Vc/033L5EZX+IOTOmk1IVlPFOMTcCsuw3MHbFL5C4FJON9RRl1Cp3huz+Xx9qEuYTGqCqaRFnaHGXD71Zi7BSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJTkv57dk/NRCw2HHGIRZf8rm3owReDKPuJaOVt8098=;
 b=l7z4qx6k/5RlVBAbqY/1BhQ4bxLCBPvztvL1cTcF3xE9zM4R7+uHmTb9rq94zYfCH18NNYMLpaWEX0AdhWp5gm2whq+AxaWZLV1tYzGKRKGE+FHG/MeiRGU+/BL5jzpT72i6qjQAvQ0H37T4gCeYjOLtEu9LfQ29nR9BE8IIIkA1MLh4haGf8gWDW7FLqW5O+jUrfdhoEOZoqa59FVVWr8Sye6HuzaqGZSjAy2eu/y2Dd+pkA5NT7gU//TKp+gZZfqWrkVztFOVl7du0ptp/QRaJffnoInvKibng0eimhX0dcRNA02j+xxxbcwrwI1vpd2KGsDX8b8akIrONGtXNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJTkv57dk/NRCw2HHGIRZf8rm3owReDKPuJaOVt8098=;
 b=lI5nzJgICd7mhrCukZMe8XELRv8NzNCF8N1ZXAie2Ra6wrmdvOHW6t4yE32iu2MrBTWJhuy53mEjNq4305J+oyXxSypsXQQpfPBrWnoh5c/qPGuDElSr6hiYyhYuWmAdEEorWFZPJGYlxTAhZXrMeCrm8HLgpRi2ikoANMhbv3o=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Thu, 19 Mar
 2026 13:45:31 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 13:45:31 +0000
Message-ID: <499f79da-eef7-4495-bcda-bca6c90c6f4c@oracle.com>
Date: Thu, 19 Mar 2026 13:45:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Enforce definition order for __msg macros
 in BPF tests
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
References: <20260305130035.192080-1-cupertino.miranda@oracle.com>
 <b073da2be883cf8f22a9a4c5f2dfa112d75d68f9.camel@gmail.com>
Content-Language: en-US
From: Cupertino Miranda <cupertino.miranda@oracle.com>
In-Reply-To: <b073da2be883cf8f22a9a4c5f2dfa112d75d68f9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0048.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::20) To BY5PR10MB4371.namprd10.prod.outlook.com
 (2603:10b6:a03:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b0b3d7-ad42-4aec-3463-08de85bdc8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	boWyvnTQsq+r/wYpxmjSvNVf6+hvVYCJNAKn625l4eTnGyvMDCaicaQd4jsZRE7mUjZjP6e8A3J13UteaeSnlHxXkSYnaNN6YnW1qVTFedeuMtdEIrDCMCdLq0Muf0Tv66z3uP8DMVDgo4HNmGwGdm8ODCtNDjLWt9+btfPKHwFfJKo0ayiA5QQkONmY66juJ+/0LI9BhOi2QO+K8kz2R3bcfnc81B8r8TqMbGd37EELlbWRB4ZLqd3Ftv16TuffjTQrJ56qi41dx0KC2DXkCbWD0CeIYg0Dc95Kv6bzP8+9kFjvhljTnB5W6R7uxKwu0of6MmnUl0V0lTSSX5GBdOOZ/Spx+N+fPwW8P3pAu6Bfus4PGxgSMGUq6i9SJ5VDFIDpNlEIYQz2oej8j4DMyUEez6cAxquTBIWE+iiAUplIoYVSkyz465yJczRw3qRKNwlIbwNFRldRt23DT7su+/CVr7oduKuq6IT9BA4RpK3W07jbtJs7zqaaEoVW+WYl2K6go8koIs7RaoGJNmTnxAUWtU4gXHp+FNFkd9DneATBHCotG7Uzmv7nM9DR/U4FF5qCaycxU6AjPpqIdXVXWO/WMMEI5nDGgYKtPAgzFAk3E45IKHlghhzBQ0vvkAMTbnpTVpTO6isEZOr9qXIoZoOrKMuGJnehhDA1WqYRl/M4hO2u1TruvBSzAoZc8DkLnddFKbRZI9I8eLJhMntcwnQ6N6v40H8vCOpg+Ykbepw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVdyMXdEcmtoeWc1ZTRsSnVHeVYyWk1nQ2RSYWsxK1IvRWJSbXZ3OXhDOUti?=
 =?utf-8?B?QUwwc1o4MUJNT3ZOdlcwdWp4eFdkb01LVXBoL0pTQXRlY3grWktEZHhBbmFK?=
 =?utf-8?B?dHdod3AyODJiZE5MQmF5OVlzNTk3V24xNUFxTU1VQ0I2WE40c0lzR3RjSHoy?=
 =?utf-8?B?aXQ3aWVyejJ3TWNJdmZ5T0U5eUJwZUpOTkFFYThCckpQeHVDczREKzF1MTRW?=
 =?utf-8?B?dHVCai9WR0s4SEVUS3laZWRuZ2dHNWNuVDJXMWppbmIzZC9nbk9odHBSalNC?=
 =?utf-8?B?MVpZMzU3YllzZHNoMk0xWHZWblBPUm5qbVZ2SFdLU2tEKzk1QmVXWndvZzdU?=
 =?utf-8?B?dGN0dDJwREhXMUVINGY2YnFjMDBuc3NrMFVjSGpqSjNtdWd1VGZLNHU5aHNC?=
 =?utf-8?B?NXRZRWE1d3o5WUVydzc1MW8vWHh3cEV6U2RBU2xNZEkzZEUrU2RIV290OWZH?=
 =?utf-8?B?NGpHT29lOG16UlI3SHdCeUFFNG5lTnRtSW1FU2lQc1oxa2hWbG1Kb2djS3ZN?=
 =?utf-8?B?amU4UDZ3Y0lJak1GYTd6UCtzWm5IWkVMQ0hJOENoVkVCbklmNXE1TXluUG02?=
 =?utf-8?B?MEdzZW0xa1Izd2pxMGhFS1JvWlM1SUV4T21SN3RUeUc4YWVtb2dicTdRdE03?=
 =?utf-8?B?cmhmbnlyZnRaZDVsZHVJTm5XMDFhYXFoSjA4dUFhazlJeXh0OHE0SjkwL084?=
 =?utf-8?B?L1V3ZUxCbXBpbllqS1VQTTN3cFh2djlqVHN1WDExZ3pBYjFhUThDRStrUEZw?=
 =?utf-8?B?OWFFRlNVUmFSTFdydmFTZDRFdnp2YnZTaDlSeFI1WHorK2RiMldNZVFFbTNR?=
 =?utf-8?B?b3RpY2Y5ejllUERkZ2M2blBxWEE4QkVBYldTMTk3d3VZR0kwSEt2Z1IxcnFY?=
 =?utf-8?B?MVI5NjhTZVNIQ1FXT0xTbGNUTUlMQTJWdnYyd2VtMWtwdjhmSDcvWjFxSjNo?=
 =?utf-8?B?U3MyNzV6ZG5KS3Q3MW1FL00vOExhYUFRMWdLTENTd0xsRjA5YU1Pb2xiZDB0?=
 =?utf-8?B?ZmVmVSt3N2oyczhqUjhrTFBTdUtPV2dJalJoQncxRURsZTZCV3FWWXV5U296?=
 =?utf-8?B?T1h5YUFOZ2xpQmpLMlprMkJYa1AzWGF0cFg3ZFlKby9hNkpEVFBQTUhub1Nh?=
 =?utf-8?B?V3E4MFE0L24xOEJmYTg4MWlwQVU0VU9iaWg2UGJYRVFwT2pQc3p1bzRNeU5H?=
 =?utf-8?B?V1ZVQUlXZHhYb1FERTliTzJqYy9JZTlOWUE2MWZjR3I2R1BzclVYOStiMkNM?=
 =?utf-8?B?T0RxcC9Jb2YyT3VRTWxpM0p6MDk4citkcXNST2Y3MTd5N0l4UnJPUE53bk9T?=
 =?utf-8?B?UmZ3dWJWcXRWU25Od1NtY3F3aXkzbVExL25Qbzg0Z1pZNVdjcE5TNGQ0YmZn?=
 =?utf-8?B?dHV2T24ycnB6SVB0N2ZXTWVQbXh2SmM3RDdUSElnWlJTQkxlbDNBeVN4MmxO?=
 =?utf-8?B?WS9wOWhwVzUwY0Q2ZTFHU2xEM29BdFV3YW4yellnTllLYWhON0UzYnFUU0k2?=
 =?utf-8?B?MHdDUGpzeVU4YmdDU0U0aWhVNE9tN0NxQTZ0ejlqRW5ROUtuOWxaRWZGWFpt?=
 =?utf-8?B?NzFxNS9MTEJZOEl6d0FDMVZFdjFCZHFnZnBGUmtueVVBakhUSzZUL21mTG9u?=
 =?utf-8?B?WkljNVJoTjlMOXYxdHZyZ2pQRVAvQUtEN2h1cWViaDAySU1hS0F4Q1JXMnI2?=
 =?utf-8?B?YXNFTVpEdlI1U1BmRHpZdVl3MUVUR2JCdzlOL290dXZsQkJKNmt2aUUza2lj?=
 =?utf-8?B?Z1VnM2NjZGJXb2tvMDJCN0d6eUVyTWs1SHVTcVdvL3hzSkFpZWd3SG9rcVlp?=
 =?utf-8?B?TzFBWG4rKzY1UjM3aVpWSkFQTXZ2ZUhwNzlFMWdpUWdzSDdVNnhhOTIreFd3?=
 =?utf-8?B?cnFacnNJNEhWNlZnbWQrOXFHVDN5NFE2akhwclhQWEFTRkpxeFFyYU05cDF4?=
 =?utf-8?B?ck83NWxsL3dtenlFUTZuSklIelRZMjU1ODhwYWpJU200Uys3d29hWTJOK3M5?=
 =?utf-8?B?bFhiNThVSzV2QnRIL1l6Tm80VzN1UjlWRmU2ajdFREZ6WFU5QUppc3l4WE5s?=
 =?utf-8?B?VzNvdUV1Z0hTSVVpZ2UwZ2IxbGFWSXRBdjE0bVJmaFNlZXFHbHhWR3RrRzZR?=
 =?utf-8?B?Y3MrVFR4bUhhSzhnSlRXU3B4Vlo3U2ZPV2VUVWlGL2lYZ09lajhjTWFlelBG?=
 =?utf-8?B?ckVpMTV0a2JmTGpja1N4UnB0eWZoaE95S2R4Y2tMWG8zSDdiL0IvSE1FdS83?=
 =?utf-8?B?cVhYUGlNbmxCS3hkbUhoZ1VNcmp1eWNTRm5seTNLVDZBaXlKbXhrN0NMb0Ry?=
 =?utf-8?B?M2NPWWtyVGp2TUxaMlBnTmlNWThld1hhK2dNZG1nVnhzb0YrVGNnVFNaQ1RV?=
 =?utf-8?Q?MNdKSsxa0U46cOUU=3D?=
X-Exchange-RoutingPolicyChecked:
	FdYXuHcUEBSzvdWqJQpjrEwvGV6Fx2/oBhqDVogpqwdTJkXxqm/wuPnd3F/dpU+a6ISgftmzBzck04RjcSP8JA+4+Vi1mC+ATmNh0beN1XgJYiWO6ZcHfslBQQk/ZNHX77EDKeOySueV+0q8BY19QBTI5HnFgnP3kNtTd5Q1uqfQmudZeEf6RXGawXQh79TWrJEdkF7oCzPVDY1be1/9vuDuaw7V9DLuTZLSaj0zvgimLDnEZBnvofe6I1rnXSlUqVWjy9kJ+CCkNWP9CAd8KuxMfgZdGHi7tfbzDPVByiROGVut8PN2lakyQBsl0zWuwQHqpYqhqtkZIFbTMJux1Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8MBAzjZa7jIUs4WKgXWme9Z7KLzCGVtytT8xxQL4WQwACpeAyvI9G+NBOxgOEyasLCFi0bma2nxLZd8WDmi5QRBcQ4khKULvSic+7RgtH0LH9Bu1X6dClvJEHkqiXtTjs35wAR0xSU642kpCg/E/c+CxAWM9EHUMEeJO5BJwYjWfp6e9YNbaErHcjSDlJ0ZlELsYCwShCDPt5F9CkPWs2XqYOQRb5FWzuDhjMCRGZ7LREmtLlYDXhazNXNfggIjDMugqp566LnEXbICulFFN/OVQel9y2EWwAZeA7D5zLgSne4ZCG7O24TXP9YbRlJ/xCfUobK5YmpXXDnZXu0co+kfR24KeITTSgfCuHq4G7kp4MJgsfvNEpiQ9iqGcfSeTS70T9bduEBnL9H6axUP953U/Relt2S7NU4woxh8mCjsh3P9Wkm3L43X+LKJ0zulW7r5jTqAnRtTnea9t7iK/n7GE9w4HopRFrD+SH/4oQhlrhpC2ZqhNQ2ayMxTxnZmA1crnCSH7z3GRG0F9Y+URRQQkeNOA8eFe+46ZombrhrzT2vM/Vr7JCvq0mPsO19cgw3B5jVcbWAtuXvY6/OMRLJR/nvdkiyCe5rjAfWeLtNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b0b3d7-ad42-4aec-3463-08de85bdc8ca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4371.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:45:31.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp4O0xgbwdHjp5snmvJYQWl0ntAizZA1emlX8gA8xgdFH9qmhIBg+YP0ulVcbQqSBwRd8YYtKN2Azj19PR3Tjrr2uTPcNyaUsMHZ605OVRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190109
X-Proofpoint-GUID: YkdYvbwmgS3Dhs1BTHEMK2gYslMNho3H
X-Proofpoint-ORIG-GUID: YkdYvbwmgS3Dhs1BTHEMK2gYslMNho3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEwOSBTYWx0ZWRfX0nxN/480OMrC
 SSQ4NxY1AMyqNSjHDAIa3t9ozb1AYloCh5xIflkBY1EVHWZ0iI9+3uEpuqwQXDJbJMVitoYdGUT
 q8PZBchkgjWKunYe+sfvL4Al2bI+igKLQMaOmX0p29MsaNgRVTsHoNDz/qFQXE7yIWEvA6ggQac
 AwSxcU1obcyKV1P5T9cfvXwAPuwLJjIf60yg8wsaDDpwBQmLC+DkMxRULnL3EWY5gnS+fvkxI1Q
 MnkFuyPwJEsRIYHVN4Md8+/zGu5PtrTpBly/P2eUH6VGamhw0ijo3iPFh9JRma7/asZvtif3s6D
 EjA9dcYftsSxkOQCnsrvGC8YxWXrd30RYv4coNa2gWwYwuuO1wDEeRRGVgW3x/u9SB0n+YxgK0k
 1BeIEwQHSB9cjSFuct9w/RIkiMsTlDkOGH14LCL7ZFEHT9qPSPbkPaqWBZSN4yNCU2vS8sMyv/N
 urefOor3FviJsTpR9v4JDIG243yIkK8hgRmzc6NU=
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69bbfe00 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=vkwLeJ8wrtgemI3aiHoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12273

Hi Eduard,

I might be mistaken, but as it is skip_dynamic_pfx is dropping the index 
from the string that is passed to push_msg.
This is the case since it is matching the '=' in its passed macros;

   #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="

dropping the index and the other equal in the call to strchr(msg, '=').

I know the patch is rather bigger then perhaps minimally necessary but I 
did not want to change the semantics of current implementation, except 
the array ordering.

Did not really thought about string ordering it later, however, if I 
think about it, I would personally prefer to order the array at the 
push. Ordering later during a processing stage IMHO would obfuscate the 
fact that the array is ordered by its index.

If we change skip_dynamic_pfx to also return the "<index>=" then we 
could parse the string and insert it ordered in push_msg, not really 
needing to wait for a later stage.

Anyway, up to you. If you think it is worth it, I can do that.

Cheers,
Cupertino

On 18-03-2026 11:07 PM, Eduard Zingerman wrote:
> On Thu, 2026-03-05 at 13:00 +0000, Cupertino Miranda wrote:
>> Ensure that __msg macros, and similars, used for BPF test validation are
>> processed in the order they are defined in the source code.
>>
>> Neither GCC nor the C standard defines the order in which function
>> attributes are consumed. While Clang tends to preserve definition order,
>> GCC may process them out of sequence. This inconsistency causes BPF
>> tests with multiple __msg entries to fail when compiled with GCC.
>>
>> This patch fixes the test runner to explicitly sort or process these
>> attributes to guarantee predictable matching behavior across different
>> compilers.
>>
>> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> Cc: David Faust  <david.faust@oracle.com>
>> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
>> Cc: Elena Zannoni  <elena.zannoni@oracle.com>
>> ---
> 
> Looks like this patch fell through the cracks.
> 
> It looks a bit intrusive, given the amount of places index has to be
> passed through. An alternative would be to modify parse_test_spec()
> such that it collects decl tag ids into the array first and then sorts
> the array. It will have to use strverscmp() for comparator, though.
> This way all the changes would be localized to a single function
> collecting the array.
> 
> Up to you if that is worth the hassle.
> 
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]

