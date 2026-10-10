Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC643546D3;
	Sat, 10 Oct 2026 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626999; cv=fail; b=KpQNqVXfoyuytCJ+4FnAh1HJuBwbiquL67JhBWp1OpyIi36enQ8OSoVWVDfMFhscOUMJa82YwWa33ViwRsHsjVXvvWmPuZvcekg7ZGRHQoUZVuMo9M3QnmLt2Eg84DJ2rBSp2E1MMq33mnKCpDJibTsVUFO6nFHgwHiDi4bt05Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626999; c=relaxed/simple;
	bh=S26IuWG2ZDyMtiqtKL8qJJndM6ZcanpeZpS+6WKN6JI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dycwvymok1Z9ee4mumjT7Wp0QNvMfvc/Q3FhB6m3RkRvwaqXD0g3g8xKltHOVkuvzV84bOBGh/dwbquZPWlzMb3VxEZ7drjYGUgKR/2Gdd02Sqa/skX/h0hym6QQGuZRgjb+fsT8HciCr3/1gdNcnV75lW9vsGMX1c19nt8qFQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rvxJkzYF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nvRXENNZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rvxJkzYF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nvRXENNZ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69A8j1Rr835431;
	Sat, 10 Oct 2026 10:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QUOBspzdSg7MM7/Liraj5RqQJDOYiJI3lfGiW4aWF3o=; b=
	rvxJkzYFha9lytkueup78v5RKWIgSTDuU6qKF0Me/1Yc+wZEhtgluhSQZMIOToj5
	0u2zuOz8WVjOkD6KCK5hhbaP1BSp0cUXIRp7fsLxoaJo29gq/jIJUYgZNUQjQCuO
	jf05D6swe9SdlzZIuWbWL7pWZzfrUWm0EsrCEoCXtQYiWgBd/HdKPOYvsm2jlhbi
	XVDt1d9B90zp56jx6InExtXA2F6NzXypsqG3vx/qoqdfXR7RAynNeHjb2lkrXekG
	r6aMoauz5iI9pnpqxO6SUNBE2SWBG1uca4/409Op/ri+aQCEtU/4hURkz+3jjp0l
	Lz42enGiB4MFuFg0dfI/oA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7ddgg8mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Oct 2026 10:09:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69AA6Hw7033080;
	Sat, 10 Oct 2026 10:09:23 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7bt690qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 10 Oct 2026 10:09:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8wv+9DKFwo7VrPuroGJilz/FboBY3eHAaDAKS6xlUEsvpcQ5Aut/0h7nTYUgNxtB63vKrbSR+zKRyihc8HtKikYqTDe3dswdZsH4rClqdCaYhShSiK6J4MxkI79UZAhm/NEiO1oiJJG2g4CCVYgMnQj9dZqYdyWZyiko95c6MEDqMFmF6Flke5lQONzzR/h0Ip/RniB/Bra4Tx+v69HOj8gHhVRGKD546ALJFmg8KfXUu9vGZgS4G/G/Id2EaDoj1G2NDUrdlZTR+RiSDBqO6ju5gdNk+j5zqmU4C1FXAY/RUmx9bl2GfMTfUuFYKG2If3ONjD1PrO/Bkdf2D8y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUOBspzdSg7MM7/Liraj5RqQJDOYiJI3lfGiW4aWF3o=;
 b=WFnhfRGEI3spunPtiWLj7b6QNf6yO0nKYH6TPyZEjTYraTTMxC57Du0o+6A+HcoxyPUxpid/dIw7AZPmfXTwa/dA9te857crdUWE7PgfWUO1lWhFDWmn0BkNccUGPUVNX+VRoApTnwC6LrKy0UVhPv6WAnyjd98AoqO6PthafVbierokLxLvbG7YRn6nUSoavWeDQ2WJYTEstSd/1NBIxgHX7lUQfCpfkgsdB30mhww1Qr0zm0i8kwRhold9TLDVTuy3lh8rH6VZoaL7l+wQe1h6xW1zWbzMjIVmhaHE0EZgnQAGyCnYaSXki1zNRndvR0inKCGrbR0irnzLOYg4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUOBspzdSg7MM7/Liraj5RqQJDOYiJI3lfGiW4aWF3o=;
 b=nvRXENNZQPGcg01VwBBK/zP8PO5OyBKClyc1Nh4W3HDWGrtx4j76w7nMues8UtmrK6GMjdvAUAQ0knNsjMd8tXf3qGMYZhrFKpsXSeULkfq0rzZ0qXN2SfnGxxyVXitHRGdeopKYVQgaVfnSev9kB5CDonz+r7sBbEj+BAi3w24=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Sat, 10 Oct
 2026 10:09:20 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0522.002; Sat, 10 Oct 2026
 10:09:19 +0000
Message-ID: <c090cb17-9bed-4742-a1c1-92cae6ee239e@oracle.com>
Date: Sat, 10 Oct 2026 11:09:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: Resolve typeless ksyms in the kernel
To: Samuel Wu <wusamuel@google.com>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ihor Solodrai
 <ihor.solodrai@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Nathan Chancellor
 <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Cc: kernel-team@android.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20261009130708.1370675-1-wusamuel@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20261009130708.1370675-1-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0331.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::24) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH0PR10MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 7213dc18-8ef1-41d4-712a-08df26b68c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|921020|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Yf0jFDG/M18E6Osn3iyF4dKnc03wQMjFj6DtQBYmcb5klBCKnPUOvY23DvlYAYYS76yq/NoWNJHwSXTlBqPXNGNmXPCfZHhU9wzJK4GM6MRb5bFQH7FXiIb4/p1wYl2CZVpye9LlIWIUl3IYBa8vcph2jAwergEzcwmZ7STvK+tJ1W5d/BNCZTYXPu6soOsfiWbQQGSuDJnfpEHFwrx+RDttsN+O68FHmB7pDEtRTob7CiZXa/NtX9yRMTDoSu7W5pXR7APBrtRTVRLKoAuybzaP5vzfaThVucGNLcZI1ZIckNfnopbLeh4KLJcW9X5bn/L9gQqwzswbN+eyAzJt2rjnxqm5QD0FP9ZQ7vPqvDGspmag2fzyTV0Xqj6lY1yZf8vNlquxApCeCxnoZt8pst6wfKzWhYOgeUqIVNB6p0pygc7zO1K2/uTEn+hliD7MokHjdV+gldI18+g3VYd22bXAOs7iuqi0xvqahj2aEapUoHQpcBK0N03zP/e1Cz7+yefXR88c8qPDr0OXrA4dB981GhxbP4z0ixV0BJ46fATJGMEVr9GJS16bp11sOJ/UTSMF5tODgmhNVdorj9WCcaL68DoaFuuNXGvnMRe+bZYxxdAuhie5Duwz23QzT1+m+JcykA+phFOmYa2Dqaifnj2D4Umz55pmMmZ/HSKPNdIKVJifS0iqe/HMVfaZS6YgLTkW8gXICaOs+/Z82Uwrng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(921020)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUVQVm5kaFpzTXRKaURTbWQvQk9SdnNWM1Z0VnZ5cXhGWnJlTklWNUlHZVp2?=
 =?utf-8?B?SFN1R1ZrdHdaYUZxdlFWL3JCUXVYRW1hSXBKb2pBU0JOTnp1cFhZVUlRdmJj?=
 =?utf-8?B?MlR3MUxnd1ozVVQ2bFZyeEdtMW5Ud3d1UWdUMmVINWxXa2V4SVpVWUhRK2dW?=
 =?utf-8?B?UjZFc1dQSHp6cXdobFcxVnZnbnhTQXNXZ3ZIWFgzOFdlL1BrSXc4VHNROUVu?=
 =?utf-8?B?SFVQVTFxNW15bGR2WHlSZFgzU3VLSmRzQzJneGU5aEJoL09wR29wNDJ0Z0Yv?=
 =?utf-8?B?YnNTOFQxYmdGMHJrOEVCNHRBUzJndkY0Z1F4dUJrbHlOS1BVUjRXSDU3dlB3?=
 =?utf-8?B?STRqcW9OdkZ6U0ZqOC9UbUhlVms3UVBjYnEwRlVid3ppUUlyWEVyVUNpRmRC?=
 =?utf-8?B?Qkt1WmtPait5RkdCZHRIYUlXOHJrWTR0aERNamg0Vm5hcGJCK3p6T3hQQkNx?=
 =?utf-8?B?TjRtUHM0WEM2cERIeHM0V1I3MGFldFJsSmRSUzB1R2lLL2lSdFpDTFMyTUpC?=
 =?utf-8?B?VVhsWmNySlVRa2VnWFlCL0N6OC9qbVV5aWpwdCt5dEEzcmpVWVNORTVzMHBa?=
 =?utf-8?B?ekRaazRZR2ZwRXZHaGZXYWZzOTJyKzZLUkMzMHJtYlcyaXBFZ25TVHV1Y1JC?=
 =?utf-8?B?ZVZlVS9IM241YmlBU2hUZ0tPWGZhdmFpQ1Vzd3VseEhpS2JqbHVtWDRPNkc5?=
 =?utf-8?B?QU9LZzM3Y2xLN1ZqUW5ENDhKUVpVNDNkczgvemszWmlIMXhacU5ac042aWRi?=
 =?utf-8?B?eEZXMm5FVml2RlRMTkcvVU5zbk1kS1VsdWErMTgvL1lzSFVqVkxFclNOcW5F?=
 =?utf-8?B?V1d1d2RwMWdWVTJNY0lxRVRPeEpNcFd6UUIvQ3VGTVViT1FVVm9VbzhwTHg5?=
 =?utf-8?B?ckh4b0ZqbmJxZU5hM1RVbzZDaXJjTm9leTNwdnpuQWt2bXNsa2dFSGc5YmN4?=
 =?utf-8?B?dUJQazVHS21DSjlCa3VGdmhERVpZOWQ3eTNOb2VVbklKZlhoQzBENVY3Qk1a?=
 =?utf-8?B?bFR1S2pvN3FXeWI0K0JXeEJqelo2cUlFTGRmUjVDaWk1UWM4UDkzWHJoWjFh?=
 =?utf-8?B?MU8wbHVkZm53YjVmTHBuUXBQTFBzSDdQK0haa0kzUmZETFBsTnpPRVpXTU15?=
 =?utf-8?B?bnBnMm84YXFhWUVqYTBKeko2cUNwTldLUHNzd1BqTVVCdW53R0o0UFVzeWpn?=
 =?utf-8?B?MzdYbzBvQ0NPL25FWjRJNGRFeGJ6UWZVUWM3b1poWGxNeW90b0pmaEV2Nlo3?=
 =?utf-8?B?TlpyVmdTYUVpV0U2M0lGWlFYYjU0M1lHMXZ1MEFFdXY2dDZqdXpCdXJHRjRT?=
 =?utf-8?B?aG9GZG1CczFLREplT0t2QVAzaDVCV1RIUy9XOFgxY3JpU1E2eTlKb2FmMzdm?=
 =?utf-8?B?WnBhSGw0VFAxMzFHODE2L0drYU1OakNZakM1dGhsZ2ZXVWRQZk1BdHMybnVD?=
 =?utf-8?B?V0VEUTd0K01NZkg5dDBzaEExcGZ4MHh5TGV6ZUlZR0J2VG92OStmeGV4Ym4y?=
 =?utf-8?B?TGxobVlQaGREZVB1c3ZaVWhZdEVxc05aaFp4ZTRiMkljdGttc2l4YTRTRG9Z?=
 =?utf-8?B?cUk3RFVRVUpVMEdYa0VZNjlZNzk0ZlNQdVQ0RW9qZzdUTVJMVTBEWEFYeEZh?=
 =?utf-8?B?ZDJwR2luK2tyZkJoTGgxM1FrQzZWdWdvRFpDeldibTk0UEZTaFliV2Rkb1ZE?=
 =?utf-8?B?Ynh2THlJTE43LzJJdzlJTXhJcm9yQUdUZDdVaXZYQWFLMjVybEc3WForUnJq?=
 =?utf-8?B?SEhacUZnRUlRUHZIYTlhYlYxbDVHbnlFN28rVmI5Si9WSmJaenpja29kOFh6?=
 =?utf-8?B?M2d3VDYwTUZJeXFBNGJxZGtSMnFpdmVQczRtcXpvK3pnRFBOSWNZdWdkUGJR?=
 =?utf-8?B?RDY5T29DVFZpZEQxWWZRTVZndU1xQjc5cjlmK2tzK2haY1luczVvSElLL3lm?=
 =?utf-8?B?UHRXUlFSSFAxcWkxR25tWXRMQm9vamFpblBxaFNSVWl5Tit2RzN2bmxZNjV0?=
 =?utf-8?B?WDJ6KytDTlVjODFyRWx6cktRb2IwWVRYWXZacUhHL2VaR0IrRi8ySkJhOC83?=
 =?utf-8?B?aG5kajN4YUFiZUppM2NZaW0wOGdzZkxiOVdWWGx2dk13K2F6RjJKS29YcWNO?=
 =?utf-8?B?WXNyTTRsaEY2WThBMEthdDBVRjJPMk01eEdQczVza01UN0VRWGw1MDZ4cFpW?=
 =?utf-8?B?ZUhNcWJmWGZTRUt3V0ZycDF5YkpWb05RUVFwWndSNi9MMUQ1SzBWdEg4Yk1Q?=
 =?utf-8?B?Wjc0TWUrZU1FY0V6ajZScGlock9zSnlFakJRV0Yvblg4M2Mrem1xWmEzdzZL?=
 =?utf-8?B?bFk0WWFod24rWVR5OEZ3aWd5VSt4aTJ1cHdkZjVIUm9oTk9hb3U1Zz09?=
X-Exchange-RoutingPolicyChecked:
	NcyzAE4BK48Urc1PnfHMi8SGGqQc8MaT0ImDwBLmwUUFJkcMWYPfgkfnQxDOOZRLUHId5PPSmWs51Klg/aEe4+YREJIm7wRR2wokCZBzdylFedGLveWAo2QBWNlcx0miXTv34OhlxLlByQa+ANn+mEUHouH12ER2qeFQTxV9M+x0YSKJhoc8Uz28IeJnIfd3NlJfplEP9/S4iVqkNYsY/yro1vaikzztohYYPYMwZ10eUTm6iVuA2ah7T6A1fX4T5/L3iMt91tvjMyz6VB+VfMAxcKqrIV8bGNdfDy00K/5IchHmjlep0JeCaN9ti9XpDk4IXxq25s8Yy8u5qWFfHQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H31tyJ8uuxQFDWfhWSGPnufUmjQGBkk65CUsuWjG3YxtvkWQjW53pBnlQqcMRJFCjBjuE15MCAN5CCtFBn1HusS+kLqbLe8pSbeX+NaWT6/Co77ZYU1nwUP0lg6sXXCQKJbCgiDdDQURvGtJyjyc21H4wiNu7nci4m4pbHp9ikgN/Y4wapJeGQua1r8yL/KQZ6yNSM1raoDD/PwCiB5fNxXstxNmLC8dpGTQrZObUOC8nu//cXQoA/yw4bnV1gQzPg4yUzHmGbDGef2uXUUeE8r6dRCGKwt0JBatbgDimApizgSgVtRHNYiw1uSBSLKXbbYYFtLH0ZkkAw1h3m6zu+Mduet9Z/icB9l1QLTj591I8GjPAoqMnsdxz/CzB8ZtYWD0oegOr5Qhmq6NADda8yQRMxsQHW33spL+kA6ow5rezGsNyftrpXIg9rns3XiiU2mgeGzUO7g7xj+9LljJ8sUJtxEAIJ7uGPrpDdAaFdlxObx5xD+HYZCcrvW9w/wV/tlJDGrmoXjVF30rLviBbMfEjNZs5LY+3q1WJXTVjL1atwCqIf9c8jOznxTZ+6VIlujz5o09tyAib90rSaREesOlheBdxALhIYAe9qtMt/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7213dc18-8ef1-41d4-712a-08df26b68c88
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 10:09:19.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzW5xaQ5pkVBFUMQxFz5ymIFFsHsiSXH3/pF/ZrLaSS4TKscd1TFeLQqgyhULGQEy07JevysgSjnu71kVD970w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610100040
X-Authority-Analysis: v=2.4 cv=EeZd0/mC c=1 sm=1 tr=0 ts=6aca0ed4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=1XWaLZrsAAAA:8
 a=wqqnTD9vQYNpvhSuOh4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6jBrrSYrlCjt6-mmJQOrlkpFdn4e4q5c
X-Proofpoint-GUID: 6jBrrSYrlCjt6-mmJQOrlkpFdn4e4q5c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA0MCBTYWx0ZWRfX9rWPbcrzAES5
 0Aj0UNarF0Yt/LdUoiY07tf2c+bsFHl6bUrJjLNpFX65ECydh8hPWlKtATZ9lA0muEIL/5zGvjh
 Zkxug/sTJmxH/ONzR/LUEsauEYP5LAR0W4M8druyysO/uKJ1ZN92
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA0MCBTYWx0ZWRfX0F3JpmMxWT5O
 +M2yH87f9vZD+hLEhPtCx/9KZQxpXvSbiGMhEqUJdDKcOKyQBcLXtGznQW0YF623HnHkpSpMi8r
 9hfN8w4pqdfSCWWsW3S50vpjWZV+XrqVgCePbtNuS1V91PooDN5dXt+rkriXW3sdjJ4Xr4IjRZ4
 UZczN9VC8DHZVsLuF0RnZAqlDcrSmsTuhrdIeBd2UzDFL0LihnjMyk1UqN7COB4P5hYbKljLz1g
 47rH70EZpM4dawIH5OP9Us3UtpAMNTnNTtqCuffxnL1wjWLijMdQLN8MVRSBZULwfjlTjV5pAdc
 Pi8rnyme6PrQ+JW8Hpiwh0gkcN8STxFwBupGzbhCG8H7Hbiv8uOTC23dX/A5zoEx52wJ9lrKzf0
 AyOQHkXDvp1GvlR+G/gRszkq+ibog4b7fa9PkLaMVgxaY9IM26OE77UKpui4Mlwqm5B/rFRYEsX
 98x1rvQD62VZ2uUPmWw==

On 09/10/2026 14:07, Samuel Wu wrote:
> libbpf resolves typeless symbols by parsing /proc/kallsyms, which
> dominates load time for BPF programs with typeless symbols. This mostly
> comes from needing to do thousands of syscalls and a linear scan of
> kallsyms.
> 
> Call bpf_kallsyms_lookup_name() from BPF_PROG_TYPE_SYSCALL, such that
> the resolution can be done with a couple of syscalls and a binary
> search. This is a similar approach to what the light skeleton does. The
> fast path passes the name and result through ctx, which requires commit
> ae5ef001aa98 ("bpf: Support variable offsets for syscall PTR_TO_CTX").
> 
> Any fast path error (e.g. kernels without ae5ef001aa98) falls back to
> the legacy /proc/kallsyms scan, including strong misses, since the
> kernel doesn't match LTO "<name>.llvm.<hash>" symbols. Weak misses
> default to zero.
> 
> Depending on the device, I see ~9-11x loading speedup when resolving a
> BPF program with 11 typeless lock externs.
>   - x86_64 VM, 6.18 + ae5ef001aa98: 147ms -> 17ms
>   - ARM64 phone, 7.1: 626ms -> 55ms
> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  tools/lib/bpf/libbpf.c | 59 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cb09ded90773..7564ec6bde64 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9590,6 +9590,58 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
>  	return libbpf_kallsyms_parse(kallsyms_cb, obj);
>  }
>  
> +static int bpf_object__resolve_ksyms_in_kernel(struct bpf_object *obj)
> +{
> +	struct extern_desc *ext;
> +	int i, prog_fd, err = 0;
> +	struct {
> +		__u64 addr;
> +		char name[512];
> +	} ctx = {};
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags = BPF_F_SLEEPABLE);
> +	LIBBPF_OPTS(bpf_test_run_opts, topts, .ctx_in = &ctx, .ctx_size_in = sizeof(ctx));
> +	/* bpf_kallsyms_lookup_name(ctx.name, sizeof(ctx.name), 0, &ctx.addr) */
> +	static const struct bpf_insn insns[] = {
> +		BPF_MOV64_REG(BPF_REG_4, BPF_REG_1),
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
> +		BPF_MOV64_IMM(BPF_REG_2, sizeof(ctx.name)),
> +		BPF_MOV64_IMM(BPF_REG_3, 0),
> +		BPF_EMIT_CALL(BPF_FUNC_kallsyms_lookup_name),
> +		BPF_EXIT_INSN(),
> +	};
> +
> +	if (obj->gen_loader || obj->token_fd)
> +		return -EOPNOTSUPP;
> +
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL",
> +				insns, ARRAY_SIZE(insns), &opts);
> +	if (prog_fd < 0)
> +		return prog_fd;
> +
> +	for (i = 0; i < obj->nr_extern; i++) {
> +		ext = &obj->externs[i];
> +		if (ext->type != EXT_KSYM || ext->ksym.type_id)
> +			continue;
> +		if (snprintf(ctx.name, sizeof(ctx.name), "%s", ext->name) >= sizeof(ctx.name)) {
> +			err = -ENAMETOOLONG;
> +			break;
> +		}
> +		err = bpf_prog_test_run_opts(prog_fd, &topts) ?: (int)topts.retval;
> +		if (err == -ENOENT && ext->is_weak) {
> +			err = 0;
> +			continue;
> +		}
> +		if (err)
> +			break;
> +		ext->is_set = true;
> +		ext->ksym.addr = ctx.addr;
> +		pr_debug("extern (ksym) '%s': resolved in kernel to 0x%llx\n",
> +			 ext->name, ext->ksym.addr);
> +	}

Great to see the win in terms of resolution time, but I wonder if we could
speed things up further by resolving multiple symbols at once, since we have
all the externs available (either by dynamically creating your program that 
does symbol resolution as a side-effect, or adding a more direct resolution method)?

A single syscall could provide an even faster speedup, so might be worth a look.

Another concern would be a lot of production kernels won't have BPF test run
support baked in, so relying on that without fallback would be a problem.


> +	close(prog_fd);
> +	return err;
> +}
> +
>  static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
>  			    __u16 kind, struct btf **res_btf,
>  			    struct module_btf **res_mod_btf)
> @@ -9863,7 +9915,12 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
>  			return -EINVAL;
>  	}
>  	if (need_kallsyms) {
> -		err = bpf_object__read_kallsyms_file(obj);
> +		err = bpf_object__resolve_ksyms_in_kernel(obj);
> +		if (err) {
> +			pr_debug("failed to resolve ksyms in kernel: %s, falling back to /proc/kallsyms\n",
> +				 errstr(err));
> +			err = bpf_object__read_kallsyms_file(obj);
> +		}
>  		if (err)
>  			return -EINVAL;
>  	}

