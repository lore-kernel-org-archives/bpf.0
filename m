Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234693D413F
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641075; cv=fail; b=DmWdbUz3BmNNNjWJXhxVzlB7TWMSuqOCiIwdPqrIMq74c0Q5W3EDFOOlCn0WLOwmHI3JByx97zs4q+XLjF1XIYEzttFDA0he+12mcSmkhl3zNKu1yI2RfsxA5q8TlsYjKLQ8H9U6ZewzVlpdR5wP9s+DX+If43MI4wfO+dEUy50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641075; c=relaxed/simple;
	bh=cFgF3koD3AbssTNp78IOgbLaKy7EEX+LW6C4iBu2FyM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8oa05D8DYc0axptUXaaLjTOUVuua/HlOk6k50r17ejNNGaMAwKU0QtihZ+5pIH/cCEGl5AXvO3be6rkZry5GiOFnR9+4z2onkEBFHPve5bbdqusBY/1aIP8+FUSdPKz5K1BkBa3OYMm8sog2ZDjSpgOckXRB4GqVHAhwa5XzUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XhAUiMS6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jcjD+fe4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XhAUiMS6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jcjD+fe4"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H8tmIa4184014;
	Thu, 17 Sep 2026 10:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NBgNQjrkKsV+x58hEZCXShkgJ10ABf75R+sjt0b8i7k=; b=
	XhAUiMS6xH1wzsmiT5jNY88SncpVK4MzXb3FQzRzXJN/pnUUzaMARlvngbzZs1pc
	thnQ+ZTbf4imSlyQ3SySljcumZe4m90ZMpdlYcEcNO40Krr35PFmWUD+8oEwkDS9
	BQW15Xqr70dG4z6IM6rFya2Zxcusfh39QmU0+UZxcuupF5t6D2xAoxanJKRqFBEq
	7LvUk8fdVVAO1UL6STrQJGxhf7IPVIfy0GOJuqF6lgYZm1sUb66Bm1hYm4RojLBk
	M73D5VEMyuxkH3p/Qx1WHgLVez++i+3KK8KM0hVj5a5b3RTDAogdrXHrHlzbvD+y
	oruvlm34kamYev8JfY2+8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwh1q6dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 10:30:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68HAUO1s036066;
	Thu, 17 Sep 2026 10:30:39 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6ryq5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2026 10:30:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dw+wEhxyHGxvVC8QrLvgSkixvRee8oVZau1QGxLoWSfVmZr1jqzSbjuDX8w9+5C4xeMvrJ2M6H/EAPHJVL5kLMXaj7WP6UEE4Z+RDjBJ8fLFxYv/MZL8WCBElxiCUHo+qv+c1/x77MqJYapmHlIJI0x+etR5+kBvjN/qnBGn6K7xzzp7ObYs/fEO0PqxoXRPktoknZ6vaFGb3CvRogVIs5tZnr156PKyPXBGPkOAdm06prgcRXYpb8uu5OelWKEqplWQCeajcUDSYlUq2d8583Sdng8fTYgqFz0WJZparq/2MtGwRyWqsCtf4i67gEzk84Kv0cH43ebPYuIZ+lW3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBgNQjrkKsV+x58hEZCXShkgJ10ABf75R+sjt0b8i7k=;
 b=eM3+8Z69gFRA5a4gA4WNifRv+bZMBYpJrBflB6MXuncYRv6h49EfQiuPL+MiuOFWJZ604Ukf50mBEfynjQ5x+UmfANzgZtXdhsf7WZTR1olCZ0mqpOiQD1ZtBkHYoeg5h72wZuyWZR6JmC6IR0JarnN+f9MWN8/dZXrar3DjbPU4TaKXSfhHNlV4l9f99AKPhcDxddNiSdVhlqj2WaEvBgrhqiAF1QoBWlnkpOg+RQylsDSy2SwluWY0Y1/FYn+A+JAPsnqsYWHM3xTKv7Zh5gB3okVsNoOYF5zcXtipUvTUl9ifL3SGWRVzZjYWe1TILDBuQVPKPJVPEYwioCx1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBgNQjrkKsV+x58hEZCXShkgJ10ABf75R+sjt0b8i7k=;
 b=jcjD+fe44+PiIpHVlgGA1jElEobiU18bLqQE6SOn0uro0HM8ZNyY3+HK/2SIJPnERES1cPrp56ZEY9dinXs08yoeYuYOyOGkzQ3s9hpuRB53XeXJPG278DrzVjnMsUB1oKjzyOTYXYzvDFDUu9+oiRbYWoLjEA3WgdEQ7hUisx0=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by SAWPR10MB997813.namprd10.prod.outlook.com (2603:10b6:806:4e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 10:30:21 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%6]) with mapi id 15.21.0451.004; Thu, 17 Sep 2026
 10:30:21 +0000
Message-ID: <e4b680e7-5829-42c2-add1-f2b5199ff7b6@oracle.com>
Date: Thu, 17 Sep 2026 11:30:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 3/4] selftests/bpf: Test btf_dump rendering of
 decl_tags
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
 <20260917012037.1396254-4-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260917012037.1396254-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO0P289CA0005.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:20::20) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|SAWPR10MB997813:EE_
X-MS-Office365-Filtering-Correlation-Id: 4755d54f-6373-4126-c42e-08df14a6ad26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|3023799007|6133799003|56012099006|18002099003|5023799004|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kkYRMO+BcAuuoHbd4gV1q81GtvUqfIv258iRIBMA7vLkbd8qvakuzdO/LxXTLg6mgRg8PNBBtUsV6c8yR7vSf+lKzwB3XbrcFuUGpzcGiiOjRyp3qK1DS2slCJIoW9HLrGN2/MUFfqVZwDFrJb+MttBFmGlvLX1a69PLpTJLpmomuCdQO/3XduCoy3Ixf+zlgTpLrUT253LCmtstChytYQX7GnGKG0nBt9r8mCLvCTbwDwES5AKUI5cgxeMjFEXTKREXZRtQrjIaQ4C5PgkbL288n1jdMzUeo0Kw5R5XFr9SreyulkYB/A1pLixv1VsIp9klcnKSvQ/+CDLWGVzq7OwkKblVQ++u1owTvMNLqzplQHEhGAJfNw6hGZ8tQicGpqgC/9ETrp94wfGr2p8fEBb6fUMzd9Wpy0aN1DEaJSyIdwyZZkTsZiu0GSXd2ui6w/cLjQ8UqIsm0AzQV3zsOZiAD5G1HsdcQqEOXZSA94OI6+xxu0U5L7kiMn+Lm1ptfjWa10K0I1FPKUihmw1gQxy1yKbIqXq0WpAcNrTiX5UJMVaVjddvh5Npj3qlEObxzFWwjwqJeDLJWm6wI0gvI9pLQWc4+UlAjZA750F2H2mh0E75OIJsySRjBtFmk8p5Lkny1oMe8d0axYhQ42jD1UFHdaI/OjLyypJn0s+iTmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(3023799007)(6133799003)(56012099006)(18002099003)(5023799004)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHBTQms5dGY3OGNBL0M3dXYxVDZwMDBtSFhXZ1FtNEdybDFEa3ZtQU4xMU1K?=
 =?utf-8?B?cnFWTUd0eG9YaHBLYmtJS3lpZE9nYlpYVGhuU1JJckFQYkdSOSs1Q2lpRTFM?=
 =?utf-8?B?dzJZU2VjNDFwQkxveVpWc25vdnZ5VkloV0pSRVJKeTBBU2FJQTRnTFJwZDd4?=
 =?utf-8?B?dThWbWtkOFBISDN5NlQyQkJSWWJSVkp1Tm8xZmV3cXZpd01WWkNETjVuTDFQ?=
 =?utf-8?B?QWR1ODgybFNsSlkyV3pUTkkxbjBkYW80bTBMRjlTZUxObFliRkFyWVFUL1pZ?=
 =?utf-8?B?V1J6bHJZbDBDZEJTNng4Y0RuNnF2YWVWY29UVzlJSzBpOUFmNGN0REphSlVj?=
 =?utf-8?B?eUpRelhKZ1FkRGxnRjdELzUwQzZqTjVaVjhuSFBEVGJ1bGhQV3p5eDVCNThW?=
 =?utf-8?B?RkZEdGh4YjE2eGVITUJ6QzZaRFhMaTZZQlo0dmt4dlNNQm02VUM5Wm84a3dU?=
 =?utf-8?B?WnJBSGZybk4xVVEra2dYRWM2dEtpMkJQWlVVZzBhSFJnNkdYVnB5bkN3QzBi?=
 =?utf-8?B?KzdIcFI5M0czNHlBajdIYzNTK3I3SEtLOWk1YzJ2aW1EU2FPYTM0NmYyVmM2?=
 =?utf-8?B?QzJSaFhlZzYwaFAwUkJGU3BVRnRBY3pNR3dvM0dGbkMrcG5vcUd2bi9OREdK?=
 =?utf-8?B?N2o0eDQybzdmWDVkL0VvYm5sV25KeUdGS3lWOCtyVmZlMWR5U2tkemlLTnBU?=
 =?utf-8?B?WnFxRmt1S2ZYbWFTYm5NQzR6VDVMek05eFNObTh6THJwNEdNMDBVTmIxSFBj?=
 =?utf-8?B?bmU5c3RBdGNPc0x0OG8wc2MwT0kzU0ZraEo1bFFFYUI4MDEzNnMxQnFnM0Vy?=
 =?utf-8?B?TTVibk1lMUZwb3I0R2krQk13L3hhSE9RQVhQdWx6MjJremRzQ0tTbUFxR1RP?=
 =?utf-8?B?dEhLYU9hZjRtSndac1VnbzVHMGlvaVRKREZmWG15MitnSDdNVC9GU3FpSHJZ?=
 =?utf-8?B?ZXRZd2JUQUJhOGY0M05iQjgwckN3S0NaRkpwZEh6QlFQOWxYMnJBZXgybmJa?=
 =?utf-8?B?b0Z2RFRrN0RidUxKZWl3SVJubVQzeFRCZ3Z1eDB2cWI2TlE4cVJzSHp6dUd1?=
 =?utf-8?B?djZMcDNEVVRCY3ZKcDlQcGE4NXhacmI2N0RXMWdZNEZwYTdhSHVkaEdGVG9G?=
 =?utf-8?B?NGVVM1BVay8rUTNXbzd5L2JEc3BCRk4wY2k0T05saUJTQXlrU2czamkyYjdU?=
 =?utf-8?B?SWV0OEw3WGllV0J4WlRCdWZCblJYcFc3Sy80dzg1bWV4b3Q1RmJrZFVjMG5E?=
 =?utf-8?B?NG5pQi9PdVNad1B0TmFQSnlMZ2RITWMydXphNndHNmJBUkRJQzdMOEplbm9P?=
 =?utf-8?B?QVBMQ0F0QUowRkpaemxZVnlJQU5LMmlNRk0wcFdLQUNnMkFZYVA4TGZvNWVX?=
 =?utf-8?B?cExGdmhmQmpTL093MGtjRlNic2sxMDZUbmEwNVNBS3JJQVJwaTlUVm5nK3cy?=
 =?utf-8?B?aC9DTXFiSjNMejU1QWlIUU1mZUJsMThnYU5QZ1czeVRxSURiY3BGYjNLdFR4?=
 =?utf-8?B?S0hwRGJkOXhOeEFlenNwMHhsN1NZRjlML08zQnZpa2sxczhIeXlPa1BIRG5D?=
 =?utf-8?B?RWRHaXAvUkNrRC9xblJkNGpiQ09QU1VZY1pWaVRnS3RwcG53N2ZMU3VJMU40?=
 =?utf-8?B?SDZ1OWhXZm9IMTluWXVCdjQ4WVhhVlZieGZNeVFpK2V5R3lZbUlxOEdDT2lO?=
 =?utf-8?B?aUxnbTZRcXRnUDBXZktvYy94dnZVZFYyVnNyN2Q5bjQ1aUwyanlYUUw2UTVV?=
 =?utf-8?B?dDBwM2NHdlBRMDd0aWVrcElzSGlIZXVMdWpIZHdwYVZuTDkvNG0xK1JrK0dT?=
 =?utf-8?B?TzYxNi9YbC9vVW93bFNEaUhCNDZsQTdzeThucWNyZWFFTndRQ0RxWjdOamc5?=
 =?utf-8?B?Q09qMytkcHhSVllQc25RdWQ4R3o4K2Y1YWhsYm9HK2tEQStaWnJvc2pWaFYy?=
 =?utf-8?B?TU5hVUptMVlHRys3QlhvK0JiNWJaSVBZUjIvT0E5Z3kvU2hVbjllcExwZS9V?=
 =?utf-8?B?UlBDQk5ZN08vQVE4SnNZNUVhNkNBV0NseGVSZmY3UnpWeFBYSDJnbTFHd1JE?=
 =?utf-8?B?T1hFR1JFVVY4Yk8vS0hFVmNFLzVrOWtyblZlVFNERGJIZDR4NlRBdHdJZ3kw?=
 =?utf-8?B?UjhSUlNDL2lGQkpjNHROT1ErVjNaUlpHYlZxMUtHaGIrcDlTaEVxS3p6NStO?=
 =?utf-8?B?cjNwRTVLQ2Z6TG15TXB0N1RDZ0NidFV6RCt3ZzNXWDRrMmdZS0VudjZvR2dr?=
 =?utf-8?B?K3B0QjhhLzFRTXRnZ2xQMlZHOER0VlpoVEpCYmVGUm4yRVVHUW5kcVM1NnBY?=
 =?utf-8?B?ZFRuYTdqR1YyS1dMMm16TmJjWEZTck5zYVJvZm1vUVZDcWFzOXBSdz09?=
X-Exchange-RoutingPolicyChecked:
	Vu9VlKvd8L4kj5i1LAazEQ+WyukUuJ51l3gSGy0mqvZR4VOV2Uuo/eEL4e5Y2Etk9zrcq340uf0ndi5ltTJqhFFZnZeKaSg9rhXAh3xYTRcsqQwgrAB62LFZaarNVNdq62rSyp0jX5xFxNosaUUxbjXwYs8N8HdeKGBW+O6TzgA0CYMVQBc3H2X4WyCET3+ZpJwAbFIycw0z8FqMY5MBoHQp8hbS3HuwvdAxQoZckK7MedC/Andf7dMPFaXfljtmshxpZA4vcXM3y+0hcx0/fJZPaRwuV5NJo40IsNixXrO91ZKkpg+lDiYKhtxYmKYdHhxFQdpJQ+POhUDXuWrVnA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QTHsUOknT2HolqMGzhPmxgcO4EFzmR3L+vkHPsdCE9BQpsMRS0oMPIcMi3r8ImIl0/+hWjq8U6XFFz0/+iXv/xt/mtKRxr63g5sVJKeoNYFx3L9LakphM75y/p1gT7+cPk3I7IJwwakPjrGEgzQqVocCBFdpKqaF5WfWUTmN2kE+Fc4Ob9Rf4N6loXQyXP/4BHBqCn8nnLd2pV2XxD3lImbMIWa7sLNNVZjTg95WVwPQW0sNol+wK6Ooej730i/Pa6H4UOOUMNoq2HlUmuitKvp+K6LBz3GMNHOgDqecVzHb3UB0eMmMZjr0QShQJHPfYf4xLR5HEDy1/5giu1x2LNmRk6pIW1BqyoNeMicSXlp8EJV4jQ7PSuURuNIyL1pj3vhhNyWe1bcbRd0kPdTYkquABpzTyd2tRY4Hiz7YcYDN/R4g1R2pOAqmDkMH29Cl8pIL541DfJKZpba28lo4ORdrCYm6L/19hA/R0EFHDCMpp8JUXcIftvTZLgMThzQB9QcDiqlN/xnKbARPZZEUUzkNg5ImDefBoCFSimMvY9ZUofGPyf20IP8lZEN13wHg9HBMk3gMUC3pmjxPkyM5GDRXZbmgi0GL4uRG+svM6Jg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4755d54f-6373-4126-c42e-08df14a6ad26
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:30:21.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqPj8qD6tVvV46HbYIqLEnK6UtbNNLU52U6SGG5uuZzlR40m4qqaMPYdZzczfcFG0xwqon+OxPpcxP94pdZBvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=889 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609170145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE0NCBTYWx0ZWRfXy21kX6OZ0qlS
 2jpX8pCMC0WuswbQtooEoAYUXM6MCXKymTGG64AxJO2aiybBJ6Ok5aLKTeB3kPVCrgp+FruHDvJ
 CnTtTXD7XkQ+T/9m2i2+RpEMujIumEBw9X3PIalcWj486aNUQKlmsA4LZRTwhDUBrUP4dlRlkk0
 Qo9JC5ss4CzubOAO49ZP8FflFVrlX/p457AFcQg29E467cTnHA+O6eyhQClhEGzP0nD4ZoC0PeK
 +W3OtFjxX3h3VQ6/hUlHQopqfGtDToYYi2/zPveWfr4Qgmta/K7pBEbx0JxQjjiSGVJ77+QwdQW
 p+oXqGnH/Q1U8qAjlmb2Av9YIx7gKpamHH3gIEyvp1hQhnRgRqMlGUvmcF0Xu2pWIl6PBnLLFU2
 ddgT4H6l5osFPhjlAonZAMk+czcYcKOhkWj4201PELJX1zublwljIQOthqNslfaxVIPErpO7oZq
 fiaRZJIC9Ojz63iteNupm0iiyxB5DIZcGJ7ADrsY=
X-Proofpoint-ORIG-GUID: db60oJBRZtc_8SDROiTHiXvYR474Av0O
X-Proofpoint-GUID: db60oJBRZtc_8SDROiTHiXvYR474Av0O
X-Authority-Analysis: v=2.4 cv=HPhWhYtv c=1 sm=1 tr=0 ts=6aabc14f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=OPo4S5L3qrPxq8PiP1sA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE0NCBTYWx0ZWRfX7skNFDAEvV+L
 RG2kA0KGNR1Cg8k51GOASOdC4CBT4G2AZ47m1rBJJ94sV+YGUpt/sMUivMr3/AA96VE2dt1/F8D
 gczMmfN/4CPtG4TAht8Culu2fJNvDtggnGPAd9BmyeMEsDyVKQVL

On 17/09/2026 02:20, Ihor Solodrai wrote:
> Cover the decl tag rendering the previous patch added. One subtest
> builds a BTF with every shape that renders, plus two that must not:
> 
>  - a named record with both forms of tag
>  - a typedef'd anonymous record, whose attribute precedes the declarator
>  - a union
>  - a record that also carries the derived packed attribute
>  - an anonymous record inlined at a member
>  - two records whose tags are added in reverse target order, which is
>    what pins the sort: without it the earlier record loses its attribute
>  - attributes on a var and on a func, which btf_dump never declares
> 
> A second subtest appends types and attributes to a dumper that has
> already run. Its last phase adds an attribute for a record emitted two
> dumps earlier and checks nothing is rendered for it: an attribute is
> part of the type, and btf_dump emits each definition once.
> 
> A third covers members. A member attribute and a record one share a key
> in the index, so it checks they do not leak into each other's position,
> over a function pointer, an array and a bit-field - declarators the
> attribute has to follow rather than precede.
> 
> A fourth covers typedefs, including a typedef of an anonymous record
> carrying three groups at once, binding to the member, the record and
> the typedef.
> 
> Switch test_ctx__dump_and_compare() to compare_text_to_expected()
> while we are here.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Small suggestion; while this test is great at exercising the btf dump
internals, adding a bpftool btf dump test to prog_tests/bpftool_btf_dump.c
might help illustrate the change end-to-end (if you're planning this
as part of the work to eliminate the push/pop attributes feel free to
ignore). Thanks!


> ---
>  .../selftests/bpf/prog_tests/btf_dump.c       | 343 +++++++++++++++++-
>  1 file changed, 342 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index fe04a955d46c..6c031e83dad3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -224,7 +224,12 @@ static void test_ctx__dump_and_compare(struct test_ctx *t,
>  	fflush(t->dump_buf_file);
>  	t->dump_buf[t->dump_buf_sz] = 0; /* some libc implementations don't do this */
>  
> -	ASSERT_STREQ(t->dump_buf, expected_output, message);
> +	/*
> +	 * The mismatch has already been reported, so this only has to
> +	 * register the failure. ASSERT_OK() would append a stale errno to it.
> +	 */
> +	err = compare_text_to_expected(t->dump_buf, expected_output);
> +	ASSERT_EQ(err, 0, message);
>  }
>  
>  static void test_btf_dump_incremental(void)
> @@ -328,6 +333,330 @@ static void test_btf_dump_incremental(void)
>  	test_ctx__free(&t);
>  }
>  
> +static void test_btf_dump_decl_tags(void)
> +{
> +	struct test_ctx t = {};
> +	struct btf *btf;
> +	int id;
> +
> +	if (test_ctx__init(&t))
> +		return;
> +
> +	btf = t.btf;
> +
> +	/*
> +	 * Generate BTF corresponding to the following C code:
> +	 *
> +	 * struct s1 { int f; } __attribute__((attr1))
> +	 *                      __attribute__((btf_decl_tag("plain_tag")));
> +	 * typedef struct { int f; } __attribute__((a1)) __attribute__((a2)) t1;
> +	 * union u1 { int f; } __attribute__((uattr));
> +	 * struct p1 { char c; int i; } __attribute__((packed)) __attribute__((pattr));
> +	 * struct outer { struct { int g; } __attribute__((inner)) in; };
> +	 * struct s2 { int f; } __attribute__((on_s2));
> +	 * struct s3 { int f; } __attribute__((on_s3));
> +	 *
> +	 * plus attributes on a var and a func, which btf_dump does not declare.
> +	 */
> +	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	ASSERT_EQ(id, 1, "int_id");
> +	id = btf__add_int(btf, "char", 1, BTF_INT_CHAR);
> +	ASSERT_EQ(id, 2, "char_id");
> +
> +	/* a named record with one attribute of each form */
> +	id = btf__add_struct(btf, "s1", 4);
> +	ASSERT_EQ(id, 3, "s1_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s1_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "attr1", 3, -1), 4, "s1_attr");
> +	/* no kflag: rendered as a btf_decl_tag(), not as a bare attribute */
> +	ASSERT_EQ(btf__add_decl_tag(btf, "plain_tag", 3, -1), 5, "s1_plain_tag");
> +
> +	/*
> +	 * an anonymous record behind a typedef, with two attributes. This is
> +	 * the case that cannot be expressed by a caller appending to the dump:
> +	 * the attribute has to go before the declarator.
> +	 */
> +	id = btf__add_struct(btf, NULL, 4);
> +	ASSERT_EQ(id, 6, "anon_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "anon_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "a1", 6, -1), 7, "anon_attr1");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "a2", 6, -1), 8, "anon_attr2");
> +	id = btf__add_typedef(btf, "t1", 6);
> +	ASSERT_EQ(id, 9, "typedef_id");
> +
> +	/* unions are records too */
> +	id = btf__add_union(btf, "u1", 4);
> +	ASSERT_EQ(id, 10, "u1_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "u1_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "uattr", 10, -1), 11, "u1_attr");
> +
> +	/* composes with the packed attribute, which is derived from layout */
> +	id = btf__add_struct(btf, "p1", 5);
> +	ASSERT_EQ(id, 12, "p1_id");
> +	ASSERT_OK(btf__add_field(btf, "c", 2, 0, 0), "p1_field_c");
> +	ASSERT_OK(btf__add_field(btf, "i", 1, 8, 0), "p1_field_i");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "pattr", 12, -1), 13, "p1_attr");
> +
> +	/* an anonymous record inlined at a member, the third emission position */
> +	id = btf__add_struct(btf, NULL, 4);
> +	ASSERT_EQ(id, 14, "inner_id");
> +	ASSERT_OK(btf__add_field(btf, "g", 1, 0, 0), "inner_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "inner", 14, -1), 15, "inner_attr");
> +	id = btf__add_struct(btf, "outer", 4);
> +	ASSERT_EQ(id, 16, "outer_id");
> +	ASSERT_OK(btf__add_field(btf, "in", 14, 0, 0), "outer_field");
> +
> +	/* not rendered: a var has no declaration in the C output */
> +	id = btf__add_var(btf, "v", BTF_VAR_GLOBAL_ALLOCATED, 3);
> +	ASSERT_EQ(id, 17, "var_id");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "var_attr", 17, -1), 18, "var_attr");
> +	/* not rendered: neither does a func */
> +	id = btf__add_func_proto(btf, 1);
> +	ASSERT_EQ(id, 19, "proto_id");
> +	id = btf__add_func(btf, "fn", BTF_FUNC_GLOBAL, 19);
> +	ASSERT_EQ(id, 20, "func_id");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "func_attr", 20, -1), 21, "func_attr");
> +
> +	/*
> +	 * Tags added in reverse target order: the tag with the lower type ID
> +	 * names the record with the higher one, so the index is in emission
> +	 * order only once btf_dump_resize() has sorted it. Without the sort
> +	 * the lookup for s2 lands outside its run and drops the attribute.
> +	 */
> +	id = btf__add_struct(btf, "s2", 4);
> +	ASSERT_EQ(id, 22, "s2_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s2_field");
> +	id = btf__add_struct(btf, "s3", 4);
> +	ASSERT_EQ(id, 23, "s3_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s3_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "on_s3", 23, -1), 24, "s3_attr");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "on_s2", 22, -1), 25, "s2_attr");
> +
> +	test_ctx__dump_and_compare(&t,
> +"struct s1 {\n"
> +"	int f;\n"
> +"} __attribute__((attr1)) __attribute__((btf_decl_tag(\"plain_tag\")));\n"
> +"\n"
> +"typedef struct {\n"
> +"	int f;\n"
> +"} __attribute__((a1)) __attribute__((a2)) t1;\n"
> +"\n"
> +"union u1 {\n"
> +"	int f;\n"
> +"} __attribute__((uattr));\n"
> +"\n"
> +"struct p1 {\n"
> +"	char c;\n"
> +"	int i;\n"
> +"} __attribute__((packed)) __attribute__((pattr));\n"
> +"\n"
> +"struct outer {\n"
> +"	struct {\n"
> +"		int g;\n"
> +"	} __attribute__((inner)) in;\n"
> +"};\n"
> +"\n"
> +"struct s2 {\n"
> +"	int f;\n"
> +"} __attribute__((on_s2));\n"
> +"\n"
> +"struct s3 {\n"
> +"	int f;\n"
> +"} __attribute__((on_s3));\n"
> +"\n", "dump_and_compare");
> +
> +	test_ctx__free(&t);
> +}
> +
> +/*
> + * btf_dump indexes decl attributes incrementally, only walking types appended
> + * since the last dump. Check that attributes on types added to an existing
> + * dumper are picked up, and that one added for a record that has already been
> + * emitted is not - btf_dump emits each definition once.
> + */
> +static void test_btf_dump_decl_tags_incremental(void)
> +{
> +	struct test_ctx t = {};
> +	struct btf *btf;
> +	int id;
> +
> +	if (test_ctx__init(&t))
> +		return;
> +
> +	btf = t.btf;
> +
> +	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	ASSERT_EQ(id, 1, "int_id");
> +	id = btf__add_struct(btf, "s1", 4);
> +	ASSERT_EQ(id, 2, "s1_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s1_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "a1", 2, -1), 3, "s1_attr");
> +
> +	test_ctx__dump_and_compare(&t,
> +"struct s1 {\n"
> +"	int f;\n"
> +"} __attribute__((a1));\n"
> +"\n", "first_dump");
> +
> +	fseek(t.dump_buf_file, 0, SEEK_SET);
> +
> +	/* a new record and a new attribute for it */
> +	id = btf__add_struct(btf, "s2", 4);
> +	ASSERT_EQ(id, 4, "s2_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s2_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "a2", 4, -1), 5, "s2_attr");
> +
> +	test_ctx__dump_and_compare(&t,
> +"struct s2 {\n"
> +"	int f;\n"
> +"} __attribute__((a2));\n"
> +"\n", "second_dump");
> +
> +	fseek(t.dump_buf_file, 0, SEEK_SET);
> +
> +	/* s1 has already been emitted, so "late" is not rendered anywhere */
> +	ASSERT_EQ(btf__add_decl_attr(btf, "late", 2, -1), 6, "s1_late_attr");
> +	id = btf__add_struct(btf, "s3", 4);
> +	ASSERT_EQ(id, 7, "s3_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s3_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "a3", 7, -1), 8, "s3_attr");
> +
> +	test_ctx__dump_and_compare(&t,
> +"struct s3 {\n"
> +"	int f;\n"
> +"} __attribute__((a3));\n"
> +"\n", "third_dump");
> +
> +	test_ctx__free(&t);
> +}
> +
> +/*
> + * An attribute on a member is emitted at the member declaration, and one on
> + * the record at the closing brace. Both are keyed by the record in the index,
> + * so this also checks that they do not leak into each other's position.
> + */
> +static void test_btf_dump_decl_tags_members(void)
> +{
> +	struct test_ctx t = {};
> +	struct btf *btf;
> +	int id;
> +
> +	if (test_ctx__init(&t))
> +		return;
> +
> +	btf = t.btf;
> +
> +	/*
> +	 * Generate BTF corresponding to the following C code:
> +	 *
> +	 * struct m1 {
> +	 *	int (*fp)(void) __attribute__((fp_attr));
> +	 *	int a;
> +	 *	int b __attribute__((b1)) __attribute__((b2));
> +	 *	int arr[4] __attribute__((arr_attr));
> +	 * } __attribute__((rec));
> +	 * struct bits { int x : 3 __attribute__((x_attr)); int y : 29; };
> +	 */
> +	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	ASSERT_EQ(id, 1, "int_id");
> +	id = btf__add_array(btf, 1, 1, 4);
> +	ASSERT_EQ(id, 2, "array_id");
> +	id = btf__add_func_proto(btf, 1);
> +	ASSERT_EQ(id, 3, "proto_id");
> +	id = btf__add_ptr(btf, 3);
> +	ASSERT_EQ(id, 4, "ptr_id");
> +
> +	id = btf__add_struct(btf, "m1", 32);
> +	ASSERT_EQ(id, 5, "m1_id");
> +	ASSERT_OK(btf__add_field(btf, "fp", 4, 0, 0), "m1_fp");
> +	ASSERT_OK(btf__add_field(btf, "a", 1, 64, 0), "m1_a");
> +	ASSERT_OK(btf__add_field(btf, "b", 1, 96, 0), "m1_b");
> +	ASSERT_OK(btf__add_field(btf, "arr", 2, 128, 0), "m1_arr");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "rec", 5, -1), 6, "m1_rec_attr");
> +	/* the attribute follows the whole declarator, pointer and array alike */
> +	ASSERT_EQ(btf__add_decl_attr(btf, "fp_attr", 5, 0), 7, "m1_fp_attr");
> +	/* two on one member, to pin the ordering */
> +	ASSERT_EQ(btf__add_decl_attr(btf, "b1", 5, 2), 8, "m1_b1");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "b2", 5, 2), 9, "m1_b2");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "arr_attr", 5, 3), 10, "m1_arr_attr");
> +
> +	/* a bit-field: the attribute has to follow the width */
> +	id = btf__add_struct(btf, "bits", 4);
> +	ASSERT_EQ(id, 11, "bits_id");
> +	ASSERT_OK(btf__add_field(btf, "x", 1, 0, 3), "bits_x");
> +	ASSERT_OK(btf__add_field(btf, "y", 1, 3, 29), "bits_y");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "x_attr", 11, 0), 12, "bits_x_attr");
> +
> +	test_ctx__dump_and_compare(&t,
> +"struct m1 {\n"
> +"	int (*fp)(void) __attribute__((fp_attr));\n"
> +"	int a;\n"
> +"	int b __attribute__((b1)) __attribute__((b2));\n"
> +"	int arr[4] __attribute__((arr_attr));\n"
> +"} __attribute__((rec));\n"
> +"\n"
> +"struct bits {\n"
> +"	int x: 3 __attribute__((x_attr));\n"
> +"	int y: 29;\n"
> +"};\n"
> +"\n", "dump_and_compare");
> +
> +	test_ctx__free(&t);
> +}
> +
> +/*
> + * A typedef is the third and last kind btf_dump declares. Its attributes go
> + * after the declarator, so a typedef of an anonymous record can carry three
> + * groups in one declaration, binding to three different entities.
> + */
> +static void test_btf_dump_decl_tags_typedef(void)
> +{
> +	struct test_ctx t = {};
> +	struct btf *btf;
> +	int id;
> +
> +	if (test_ctx__init(&t))
> +		return;
> +
> +	btf = t.btf;
> +
> +	/*
> +	 * Generate BTF corresponding to the following C code:
> +	 *
> +	 * typedef int td __attribute__((t1))
> +	 *                __attribute__((btf_decl_tag("t2")));
> +	 * typedef struct {
> +	 *	int f __attribute__((memb_attr));
> +	 * } __attribute__((rec_attr)) both __attribute__((both_attr));
> +	 */
> +	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	ASSERT_EQ(id, 1, "int_id");
> +	id = btf__add_typedef(btf, "td", 1);
> +	ASSERT_EQ(id, 2, "td_id");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "t1", 2, -1), 3, "td_attr1");
> +	/* no kflag: rendered as a btf_decl_tag(), not as a bare attribute */
> +	ASSERT_EQ(btf__add_decl_tag(btf, "t2", 2, -1), 4, "td_attr2");
> +
> +	id = btf__add_struct(btf, NULL, 4);
> +	ASSERT_EQ(id, 5, "anon_id");
> +	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "anon_field");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "rec_attr", 5, -1), 6, "anon_rec_attr");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "memb_attr", 5, 0), 7, "anon_memb_attr");
> +	id = btf__add_typedef(btf, "both", 5);
> +	ASSERT_EQ(id, 8, "both_id");
> +	ASSERT_EQ(btf__add_decl_attr(btf, "both_attr", 8, -1), 9, "both_attr");
> +
> +	test_ctx__dump_and_compare(&t,
> +"typedef int td __attribute__((t1)) __attribute__((btf_decl_tag(\"t2\")));\n"
> +"\n"
> +"typedef struct {\n"
> +"	int f __attribute__((memb_attr));\n"
> +"} __attribute__((rec_attr)) both __attribute__((both_attr));\n"
> +"\n", "dump_and_compare");
> +
> +	test_ctx__free(&t);
> +}
> +
>  static void test_btf_dump_type_tags(void)
>  {
>  	struct test_ctx t = {};
> @@ -1109,6 +1438,18 @@ void test_btf_dump() {
>  	if (test__start_subtest("btf_dump: incremental"))
>  		test_btf_dump_incremental();
>  
> +	if (test__start_subtest("btf_dump: decl_tags"))
> +		test_btf_dump_decl_tags();
> +
> +	if (test__start_subtest("btf_dump: decl_tags_incremental"))
> +		test_btf_dump_decl_tags_incremental();
> +
> +	if (test__start_subtest("btf_dump: decl_tags_members"))
> +		test_btf_dump_decl_tags_members();
> +
> +	if (test__start_subtest("btf_dump: decl_tags_typedef"))
> +		test_btf_dump_decl_tags_typedef();
> +
>  	if (test__start_subtest("btf_dump: type_tags"))
>  		test_btf_dump_type_tags();
>  

