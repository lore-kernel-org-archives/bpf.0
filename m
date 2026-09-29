Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E26519E19
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679097; cv=fail; b=DU6VBatl8NHO85sLQpI+fqtGeNWCkCIS8xncmjXz/4n7/S1LW8QjVE8ic/LxwPQXMopEmN8X7yn034gw8IRqgABCQHvXYydqIdiHhcgGWBfBw+llYS6+IJdce/Vx+2HU7T6xXiyJZfbNi8O8qj54ozZestBErif1RkYit6pDwFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679097; c=relaxed/simple;
	bh=slX+3pss52IyvSmz9gJCJYyApr8/JIIHg/a8EIuj/S0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KBqWkYiEG0zp9gc2spmHRuCo6pRYWqQXBu0Wn8SllpY2plL6BpHFsz7Q806cv8oLJDZDzZ5B1FXy+DHEu0w+kuGkZ13RR9EeYC/W3zcdOb9aZO2QIbhEZpcYe+5yenvcg1f2Iyps+SkXycewWuT84QNcv0YKLeb/Q/3K4z4HvJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DKnGt9Tb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1PqT2rz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DKnGt9Tb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1PqT2rz"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0FZCu025849;
	Tue, 29 Sep 2026 10:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=s98RLHbZ7O4ete9+XHq/kE/N6ZYHEXfNZYngvYsALRM=; b=
	DKnGt9TbVbbteSHMJQt2ECuK0bGZh6emLrd57JTw7ku5D4UFHncplXXDqZIuieIq
	J541kKgkyMaUCVdis87ZWhU9AHegvfXbCDblO5xIUrmaXUckNIDfoPVFF7bWVf3c
	vfw9VtgoRgQVKiY2XdCcIFoL0u87sRveRpfO3LuNGPYsfbTiWaFP3LV9dVYqD+S1
	WB3yBUobpooxflqLnz1805V6/EltKTrNxC8nECWoeBMqJOOfq1WrKB8Rr0S1Xj+O
	/VcEpfDirYVVHiOBPEzGEzaielKVtyMf7EqO5GtpwFKqn+je99c/h24amlA7FX3C
	UJyOtsfxEkA8QZrH1mP97w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4mycegq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 10:51:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68TAo0P6038769;
	Tue, 29 Sep 2026 10:51:00 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gbsgxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 10:51:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlm3p8hO8kO8ro83v+YoI9OmZNm7wbwfdZD4VqHrgpqz7UIT89iw0MHhzuXx+fGevAyZIUIylRldTweeFn7vOFbcfK8fkzuIN2dIW8eb9vxSvW7No29dcL3H9Khr5FIKKfEQXBGxcYszKuJTQqvz94aQaWSSpwKQrtrlbtBR+EV1XOlYBxI/H5JERM1czwf1s4fFeEweHTgvZQHG9CTkP+fXO05BrvF1vg9Nu+n6CYpHkMACeImHrkkZJkJaLCAimopR65bboKL84vi53to5nNHGmUleOdreDkYtWQ7HdL3gr/nvGYOLZSrpeJGmV9/+3HH2ZJva3A3isLzKkfZPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s98RLHbZ7O4ete9+XHq/kE/N6ZYHEXfNZYngvYsALRM=;
 b=Cwl/T/OShrjEpdpmXH/MkTuNGMAQJiI/IgtvqIZJrz3SBB2F1tZ06GKw01rrvuzLgDrvixkeCCQQidxNLk3BexoOyCFHCS74UXPlzQ6+wWvPXBs7MdhV7/+YVZdreS/Wfmer+k1xyQ1265cEoSdRfVQckxYq8VpIGCVYJgBpmIxB2D0IVmCBRNhbhhHiaVH0bNvzEHWTBnKqVYUV/VXN/dgr22dK/t0rzffH1MYX0FhmMgVmG74le26WJHl4nTDXtf0Oy6Z4/iCIwMz6T2lmIkiZwFBE+vGjgDvyrNBHsWIdbkO+BOVj0xKVo9KSchmCLK2JZ33uVFduhd08kgGgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s98RLHbZ7O4ete9+XHq/kE/N6ZYHEXfNZYngvYsALRM=;
 b=n1PqT2rzc5KQm61gf1iXYbz4YvjnAh5rm7j+RRtAjYHn62J/uSzttXYXIbxvOWTzUtDp3jscLIXec6kH2YnS6oDrdVMUlPxAe8NzhT14Z3YVEO8heLGRrI76ZQBDpBGOdhDRDsCJrsyJknMtNxqkRoxljg+ApreMmFsrEPlvtZk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by LVWPR10MB997839.namprd10.prod.outlook.com (2603:10b6:408:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 29 Sep
 2026 10:50:57 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 10:50:57 +0000
Message-ID: <06e079bb-8e00-453e-8df2-47539758bdcb@oracle.com>
Date: Tue, 29 Sep 2026 11:50:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Verify BTF_KIND_LOC_PARAM vlen,
 flags
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, andrii@kernel.org,
        eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
 <20260926175113.2368566-2-alan.maguire@oracle.com>
 <DLRQL3VZ2FRD.2JRCFNKOLT1P8@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DLRQL3VZ2FRD.2JRCFNKOLT1P8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO2P289CA0011.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:6::17) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|LVWPR10MB997839:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e49628-6d93-4cb7-4e47-08df1e178b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XQv4fDGJBmyo+UMVKvYI9VPTqvv9x8qjk5NTIF1OpX2w0VxxemMAvnQj9EGulMQ+EENBLza0AJzaIkDuO07W7Y60OTPZ+RcBjR88Z982mSruxKE0kR2sD7Ut+UNWMdY68CEyOOm/iuEEdi6EY5WqYtep8vdQOw9xQa4ASTo/J6OUPCkcGhF7X2Q06Jh5xjjT/fPDKkdXJsq3y97mElhZkqLbJkoqvVxROwo4y2+hBcltvmE+p4F+FZ6f89ThPlRUxGybmjLVzkvwKFxLzrAlZha772UPCSFDOZrsfW+/A5TxIO0PFyomWeM9rWmaIcYU1rYAnk8MCtjH/mJ+U1aRQJPp4nl8toPdDMWcl27SHOfOW2vRiH0dkdocJFbe0TyOKhvbwn8xKIA5vIIheW+8WtUwyVD7+BEGlmEh54k5ccY9NKj/aZzXddFHq2mTf6tiGuWxDUUEVUOPIR5Rl93AJnyNXeFlPQuWBQv180qdQF6ZpvokSOzuBhImO9BHO4t+cwWlE5/rGvsTFg/r+Crrhwd4R5b9GjuFvg+1fxIYQTJ7CjDTm1OCXwE0WHL6Kb4Tg66O2NfiTP7SivynqIG8hx2k5hAhcMJv9thg4AQSJ8GaZFSknykssr2/JDSJCn61lIU6v/i3t0IDDEyHwb5KAgnfVbR8SDbUzUoIWspFI1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0tVVTNycVI2YXBJN2Z4dG05TnRFazN6MEFqWWFncTNmeXBlQ0E3QWRHeFpz?=
 =?utf-8?B?am00UlV1QkwvemxucFQzY2RuNHZVYVh5dnpMRlJEa2x5WWxTYjRzamJvTE5t?=
 =?utf-8?B?STZhbU1OWTd0ejJsdjVVbVZjVGJGS096QzJWWHg2VFZmZGw4ZkoxbkI5TVdi?=
 =?utf-8?B?cmhkNzNaOXMxMG1GbEpTTEUxbnBidmg4ajdWWjJIZlJBRks1QTF3ZHZvaW4x?=
 =?utf-8?B?TGZjdE0yaHFYRloreDRNUkFlTXA2S2lLQW0vNDgwNTVFbG43UHA1bEp3cXRo?=
 =?utf-8?B?L1lxdm9wMGRZSGc4SU5GZDNDeDlYNnNkcCtIWXNXdUUrL0RORVE0T3hyUW1t?=
 =?utf-8?B?dE9JMTBtcnNDSElPYldJWnhwYTF4L1NBYm5BOWpJY3hmaFJGOWpPZmt0NEc2?=
 =?utf-8?B?UGd4czVVWXVpbVlLemYyZVNWcE0rZmY2cGZuTTZDSC9mRVFpOTQ0UUVNK3hI?=
 =?utf-8?B?bDBnRlErRlRENWxlOTZQVVVsa3NpMzhtdnpDUFI4KzBIVG0zeE9QWXJFS3Qv?=
 =?utf-8?B?VkhQWWJhQmlsQkxqQWtkTk5TTHFqZXcyR2JyR2RVbitkTURWS3ErYWovelgz?=
 =?utf-8?B?S0NocTZiUm5UL2ZHRkZXOVQzNFI0UlJZbzJsaTNoTjFWd1hCbWV3L004THVV?=
 =?utf-8?B?YWg1NUxaRWpjTUhLWFRWWXV1am1IeGoyYTVncHJVSjVZdVl2bzNhZjNhNkRG?=
 =?utf-8?B?QThlTk43SGZ2YkVnaE9EODZKSzBMRFcrcE5mU2w5Tk5seFpVckY4N2N4ZDhE?=
 =?utf-8?B?c0J1eGwvTGRBUU5QNFdhODhSWGFlMnp6eGlGK1lDRm1VaFByVm9EUis0L3lO?=
 =?utf-8?B?Tzhad1d6S2o0WGl6WVNVellXangxeFpjR0xWM2lsaW9rYU9NUG02OFRuZGVJ?=
 =?utf-8?B?TkFpMmJCQ05JdFMrUEs3a0p1ZTBWeEJMd0IxWktHS3YrS3ArVUlHckd2bDdT?=
 =?utf-8?B?VEIrYU9LRURnUEJoaVYxRC9EWmJBRVlVTGVpdTJTUWcwMTBHUTNQQ041ZXhk?=
 =?utf-8?B?aEpmdVFaY0Y0WDMwb3hiY3p4cjVvaFF5UUNDOFJNVGhoRnRPTDNVdTZ4Mld1?=
 =?utf-8?B?R0lMaTdvWHd4Zy9kS21nTVNYYmI4dEtrOEZRSkF2L1J1Y01qT09nL1dZRDhm?=
 =?utf-8?B?dHd5bE1qQUozb0hVU0ZodFYwUDFoeXBlWXhxY3NaMnEydFl2WWhidk5zeTB6?=
 =?utf-8?B?cjd0NzdiQkQ3b3VsOE44UGdHa3BoNzdsU3RvY2RSWGh0dExUZDdsNjZYYlV1?=
 =?utf-8?B?MndBSEk4MlV4NnNTS29kMFVEUFluUGpmYmQ2UWlvZzY3MXhyNjMzbmYvMDJW?=
 =?utf-8?B?eXpqQ2pqYWU2bG9PZUYrNEJadDNTOVBOSS90dWx2WHBscjhzUC9nQjh1dnNK?=
 =?utf-8?B?WlIvS3l4UW9FQVdnQ1R6QS94Nlg5aitFTVRjeWVTbHE2a0dCUnpncHBjeHh0?=
 =?utf-8?B?TDhPYTMydFhockIyQXJ4cnZYNWwzMk85OGNqWXVrbk03aC9hSllqanlTNVF2?=
 =?utf-8?B?emtRSXdlb2plYTdCRXRhRldqcldpZ3VJSG5aTlpsemorMDZzWTJEMldzazFs?=
 =?utf-8?B?SCtrTEU3cUtFRDY5VWx6MmVRVVhVN1FVcFh2eldFY2pjQjBHRFJwT3VRS01s?=
 =?utf-8?B?MkYwallyajZsRW41U3V3TTU3aTd0NDRvZHZ1SS9CbFF6cHAvU2RvTTUvSmEy?=
 =?utf-8?B?aUxZNFp6Z2xGeXRGenlmaXZXY1hJSEpKSHljWEErUTVkcTYwdi8zQldzbVFB?=
 =?utf-8?B?b0Q2dmE1RmY1VFdXMUxRZXBuWGxKSVY1N3VHSnhlc3MyNjdHSmt0bFJtYU94?=
 =?utf-8?B?VS9KRy9ieVM5TkIxUk5HeUFZK2FYdnVoNTQ3aCtOQnhYR3hhd1ZJdWh1dFpC?=
 =?utf-8?B?WTFtQXcxL0l6Q09pZ2xRb3VsNTNGWnZtQlgrbHNmNWFHZldZNzR3cms0R0hq?=
 =?utf-8?B?VFpuaGdaalFVTzhYdVlLWVVETm1mY0dPeFRpU3c0YXFoV3l0eWFIaDFmSGlY?=
 =?utf-8?B?S3lZV29lYytST3BCU2U1Q0w0OTBZWGVjU1ZkWE42d3FvS2dESFBYOHFvUXpG?=
 =?utf-8?B?OVVsZHhLY1BNMUFyd0s3V3VLYnIvNTZJdnZBUGpueHhYMEVSVjIzZlV3ZzdT?=
 =?utf-8?B?NGpKWG5sVy9uMGRMbmFqdElNV2ltZDlTV0RYSUdHZDdNbzJwSHg3OXdqOVJI?=
 =?utf-8?B?WVFtY2xaWFhUYk44UitGdjFwQUNJdmwxVHVxWmhnblJZU1lETHJnWUVrbnhv?=
 =?utf-8?B?Q0JNWTkzNmRFbUFMVUxRVXhRY1F6eXNDVlovUFY0cGYxL29tV2RtQlpJTGda?=
 =?utf-8?B?NUVJUU9RMDgzRGtmN2E4c090TncvUG96cUVzZG0zRXltMUViZjdsdz09?=
X-Exchange-RoutingPolicyChecked:
	Y6z6AjRuf6HuKYpvQOLS+JrWZQEd1NjAkLvS8K9me0DDVM+oNvD54e3oSed2u7YwF8uG9mk66UXBWYcm+TLIzYgWjfn8USj/Wx8LIp5GX94n2w8YzmhYhVzD+dmNgIlNAiy+I6mT/4F7vCqrD68Yu15G0yvsDzS0GGNzJ//3Kx4nuUaF43qow5Xc2CNqacr/muirvoliER5FoevILFPfZQHoVpq1zKb0miIZl2UCiwQzQE0fmXJuYcznoWAZTELRxXHaZapDxqChy/xGovY15A+MUbAUk0kjjLlTke8potDnSZqe4qDV6pbcHwoZ29MvbLMFt1lXWzZgQlFkJEgOSg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zY4wRwy2ZFGGUdT4EcXrkTiQWFrgYZbqVSeo4oUjtuK5T55FaKbEywPxgTUOIW+dRoCZ1McPaOnD9qybcXoGAc44UPBk6ZL0bngW05gXtEZwNM+lrHxeLNdAPp0L1MxrbMQZVxozf7+SJCiZQ2jG0c+TExw/SDfZ8jE4KK0/JBq49BuivozeHv8wv9oXAYQ/yc7glodSrnUuMBRDGt1ZmwfBGz/8O5IjeRO3HrRcHK7k2aDGnmWPbMXP6PjMrcuybIHAkPPVVX16BZOJjBTxtafzsKZcKyQmTqTTgRRKP+CWt0yq/UKaT45H/c4So3FK2srjZGbXjcfzWl7DbUqpz1qU7LoXx7YCt/sYsGKWBGH3z1m7LS7ydRU58JuFoOl8RfwTrRynTaZNLgGzvupesyQw0fc+qlrHxBLbE0tsUj1DCRanhSSKHRgxlKTSbmeL9eW3eb66s2/9n5aD4IkL/dfzF50Dz34Xo6UXDgH/li/2Id/NorUu/2OHvha+6nC1Nx2FFGhEoO3W+pzCtQDgUYOSMv2/ceVCv30w4qU1WmQP8D7MqgkcvvvCjw3mD90wE1qy1pSRQAHQsvNuBGAtXwrndVowJIc4BpaJTC1o600=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e49628-6d93-4cb7-4e47-08df1e178b08
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:50:57.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4xE95T5BLvMUbHXmMTczSCmOe9WSg4nZQgLAoOFzUlgCkmHUyl8W7+CqT1MsKetFlfi95pLwddDS0nlr6zskw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR10MB997839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609290043
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0MyBTYWx0ZWRfX0BhDkyRYi+WW
 KW2CUiea7exgWTVU2gCIPydnduaHjjax7FesMuajgRcsEbjuLsWGD9qmTc825f5YiM13Pdy0yRe
 JLMF7LMXuSDRAXaqx+UvNDM2aSOSP4Gv7fYL5CqYkpCvUjU+zGJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0MyBTYWx0ZWRfX034BTF9DMNfd
 fW6bPtLN0Lkwrbd/RH7QpgwaFhuQ0IFaFnqbp4iYFb5q0Fv2v1olmQ+X/WJ8B429yETtCug8UiO
 RhBKr+KV2PHCrvJBpXOLlh74OsqBTlk1olOKPeIh+gRT5RQm908Hvkfk3RaJGzhPfiaLB//46BO
 ikysjypQwbAB7WKHaj/7o+22/kNES6D9pQAcM0DkEPLDcUl4MZflZbfBqR8DOaIIK5+nHEmgCz9
 JYIJFqD8jhzZd41mQGIsSV0fzdf8Q2AGzYTx/cDYJMCoW0Mz5xSwC/sJpbk29piDtw9zu72u2fP
 hCrcRZklmtnnOjI6DUUZLbI78dR4OqL2G70IeOJiZYumem3AmfrWWjDpPtJ+n7ee67XoAziR8HC
 Jo5haZ+zDk9BvqbZCqG5oOBABCGi0aYHsHM5pZbtdJEY2b/sKe+wId75BL6Y+hJDkwuk6C2YsSe
 eO7rTIQGl93aIIW0qhQ==
X-Proofpoint-GUID: XNPRSa1O3_b-EOgLL5KMJisK17I7U50Y
X-Authority-Analysis: v=2.4 cv=DZmCOftW c=1 sm=1 tr=0 ts=6abb9816 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=ZYS9MeugG7lnToeQ2_cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XNPRSa1O3_b-EOgLL5KMJisK17I7U50Y

On 29/09/2026 11:43, Alexei Starovoitov wrote:
> On Sat, Sep 26, 2026 at 06:51 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>> +	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_SIGNED:
>> +		if (vlen > 2)
>> +			goto invalid_vlen;
>> +		/* Ensure size/vlen are consistent */
>> +		if (size > sizeof(__u32) && vlen != 2)
>> +			goto invalid_vlen;
>> +		if (size > sizeof(__u64))
>> +			goto invalid_vlen;
>> +		break;
> 
> size <= 4 with vlen == 2 is still accepted.
> For size=4 values={1, 2} bpftool prints 'const 0x200000001'
> and 'const 0x1' when SIGNED is set.
> pahole emits one word for size <= 4 and two otherwise.
> Should it be
> 	if (vlen != (size > 4 ? 2 : 1))
> ?
> 
> Applied anyway, but pls followup.
> 

good catch, will do. thanks!
