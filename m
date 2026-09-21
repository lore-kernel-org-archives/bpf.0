Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96C4F55C7
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016513; cv=fail; b=KkWt6sUwlpnqTbVdQKdF62jEDgK1QX69Blu9L9BrNnL876t+5vgGRGHpDiJGo7PG6eQtUZ6zfbvPzF0IFGhNe3RGuwDOyU7j158I/ul+VFQQtOXNvxbYOwb4+GbzsXhxSUm4SJ8iITDCGRijD2FiP7RTVwOmYXBX5p7uU0x39K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016513; c=relaxed/simple;
	bh=w31cQp4EVstC4D4xQMjdk80Vp9QX9ODCHFxJsKb7yV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oYkRu0qZ8zIz0yHJCAi7c4P9X3+DhuXwES/QQacUhJYBFlxzD+q0L2gTdgpMjv5vv7oBbniWVEJptE187WKiIKgouQOtEfjm/F/1y1m7UT/bukTIydnQw/dxltpsRjLBwL6CV19UjxAoOaE561pnGTE8iMsKg7brenuv2+aO1PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BAxzJqzo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sTBeC5tu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BAxzJqzo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sTBeC5tu"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LDtuhA2444400;
	Mon, 21 Sep 2026 18:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kZnmIarzwFZHBKGuVYAWAZheiaKMEchtOMaQR4lYous=; b=
	BAxzJqzooa4nlW+siA51s6r4rPYeVTBZLA/hcbWSCmjcXaXrqc72zomyJnnaWCZl
	G0ofTG/k7RcGEQmlOcId/JCokT2Ve5Wi9f1Y5GyBBsYvcNgygetBfWeJetXRNt89
	Qg6KlpwAvwNoNEcvAm8Or3r0ksk+sasK7m0y/gTP9+WvRGQmgYmziZfm9aCXkZEO
	F3oXZ68zF36T8VVSB1OMCaJkoHJSkoCfWtU+GSfEbsnH+9JNoc+Y1uSyD63ZoDqE
	hWJh+tylye4kZ5OiufwzsbhTqnBgnSQbNiEFCKvr3b8NKpDxwXrRFCfpLgcNG4cv
	8GmLTVsgk4Dt/8B9ZkjcUQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qav98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 18:48:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68LIj3Rg011355;
	Mon, 21 Sep 2026 18:48:08 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gtej01ak5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Sep 2026 18:48:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0FlpEPTmyG3wpAYSmMGZrwRDW41mvcYubkQbyZ9zPP7/mGEibe2AeCW8vqofz4yiPYLwVNJqsGKww2hILekdZG8CuQiafQkkiWaAlq8EyCFKaB6gCoSQN2ZQTjhmOpmMmR9ug0xV9wjq3rdzZDFW21/VMlP4W+LqURXOTQeMLuLKPVt9itdJeG4Ps7LXhbxuDJmtJPWvvmEoS6SVupnPP7pCJzASrNy0OmpcTjXk/+rHbA8Nvei8I7gremicBWlt+La8dIpzYggXkpLtxoTw+uD42KPypHXy0v1y1EpJSQ+FaWt0AEzqFiCDu3D8y6AugRaVytDdypNa6fEoIbePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZnmIarzwFZHBKGuVYAWAZheiaKMEchtOMaQR4lYous=;
 b=Yseato9yD2c0VVKSeNeyPIt+Ku7dWhFPiA1rutoLd+MN/qbmKeUMogozWBb7KosZnFGnt/U739jyGHx4HVaBW+kseiVofWIbW/PUcv3Z3/R7f6wln+7SR7sdTbN1wb2ES1FJwbrkjZJ4az2ZRRX5N3z9pd9OmDFZiHAfGG3C/TT8PYv9ZSsims+x8ZEsSnFh2aP0tL6LxDlbfx1tf5EFkopejquaf0VsK+GHio24Hp8lmv8PwzrgR+jGQFKmjAeNGYN5Y9jEQalqiABlWSYj2S2tio7Df3sx4moEsEC8KkkITNkeL4GL3V/w5Is53+SQGUgLA6D3HFzBSx5GrvomWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZnmIarzwFZHBKGuVYAWAZheiaKMEchtOMaQR4lYous=;
 b=sTBeC5tuoywHVmAJ/9QSvWjMq14eioNih/8SmUnN511aqexpH02AJk/Y2Bks0N9La9yP9z8Jy9HZt4snT41QNa3YuxnmnwHZT0qBGLB6O/vBcfAXW52Gwp9LPELIOgJ2WWDsfwxnO4vYrhawrZzvIMg3KjAuXwLlcz4d/yaCt7w=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DS2PR10MB692458.namprd10.prod.outlook.com (2603:10b6:8:70b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 18:48:03 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0451.012; Mon, 21 Sep 2026
 18:48:03 +0000
Message-ID: <53e01dce-efdc-4e8f-8510-e23cba17c429@oracle.com>
Date: Mon, 21 Sep 2026 19:47:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, andrii@kernel.org,
        jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
 <a53eaf9758d1110ad7a2211b55533ffd470e083f.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <a53eaf9758d1110ad7a2211b55533ffd470e083f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DS2PR10MB692458:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dbe025-a3a7-47c2-cbf4-08df1810dd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|3023799007|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nJFkDriCq+CKpsOSKpK/AL+oeF/9bNfzYl3WvZwDFzpMxtkeNAy53JblgnMTb5lcKi97tl3xXVju4NrAgdK/bT6LezefKqm9BFnHzZ5FhJu0tYDHZLDq0EOWd7Yu4g4iLsrTkTxGAdWLCGibv5W4e4Wi64t7mCV3qhKDBoEeHNYaoVg/rnAt6i/SXPSbCeFe/JBaDzX+sv0q6pK3kZn5fgWcn2LAow0G7wJij33JVcRGD0Pxe7t8FDrPa0udiW0vpJQtQW7WSMfXDaGLkhB1DrThnhZdRwTx7uX/gKVfxpVVx/Cn6p5+8+cMsfaehMMOShKDXN4lmj9LJJvR5SVle7SgyPTR/MmLdnWiVBqpPh3t8dPJeJTLfFyfG5MeC2Su8qAu7HwXFNmAhbuPXL7FXWh9zDK9fj0IPscHYfqkTrAvHfBgf6Uz+fx6BOvYK+SbwWIxNn69m/pYZEA/lHRZ8R5yO9HPRVQ34WrTKLq+k6zBkeFNWIMkA3sTM1hQ8tF7qiJ46vIkwR/+lOIw+eGalgSeb0MWayqNepu41RyRSsy5IhAGtEbTe8Hx+3f5DUbx4uw/sDaK7SpDBqX7NNWvVydTWhA7Vuyw+xrjkGpMy93fA3FazX43KJaGDzIPqAghXGelqJ4JT9TxPGnVrCo4EgCtgwX5dvJmpm8ah/gLQ8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(3023799007)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2E2cjNZY1BBZHRCTHBaTURKQks3NEtWbmEvU245ZVl3ZTR1Z25kZTNYMXND?=
 =?utf-8?B?VEtsNW52K2NQRzZKRGYyZFRwNkpSR2Z2VDJuWGZsWDYzaDZYOWk0SGNMR1Nv?=
 =?utf-8?B?UUFHYWNsWi9FNmpGRGVSTCs1Wm0rcTlVTHNuenFQMzVjOUo2UTJUK1JQaTI5?=
 =?utf-8?B?Mmo0eGROTy8vSmVrMjl1a0xJMUFqajhaL3dDYmRHbTUvVE1FOFFLM2NVNkZj?=
 =?utf-8?B?TXN5bm1BbHRYcURwWFFNZ05zNCs2dXp5dzJzZmhFb2wzdGVnNTF6QURyR3VO?=
 =?utf-8?B?cURNVU1QdmxIV01mZ3dQcDQ5NjFDWGxCek5vWHRrUUVZSDBjUEU0eGNqSkFL?=
 =?utf-8?B?Nk44UE9zY0ZiT0g2SnZyVUU4aFhOaS9WNHBDczRmc3dJS2M1ODUvNjI0NHlV?=
 =?utf-8?B?ZnZuaExFSDlpRGpzQTMyd3lZWDdKZ0RuSmdqOG5ZYUZwa3A3eEMzdmRuWUdI?=
 =?utf-8?B?b0o2OTQ2azQ5Rm9aZDJqT2tmZStVUW83RFp6N3QxZXpjNEdGYzJiT1M4TnY0?=
 =?utf-8?B?dW9zdkdoeDY5dURWYlFIanU1cGhXRzV4aWtpdFE0VVpRQWdjcWxlY3B3eG9t?=
 =?utf-8?B?dEJ1dFQ3cTZIdzNoQXVqTG9na1loalZVa2NQZGtKZE94NWNRc1U3RFU4clBx?=
 =?utf-8?B?TjBHZmxqRVFVUUpzdCt4NjB2dnNLTU5YZkVOK0dQMHBGYjV4Lys0TWxXS0dv?=
 =?utf-8?B?b0d4V3h3SktNVW5RTEJtRm1IalFIZE5OaDZZMDFrRVMyZDJCbm1OckFUVVZI?=
 =?utf-8?B?dHRwdmhFVjZjb0xOYUxuWWxkMWdDRVdBZG43QVQzTjEwRC92UzVRNHFHT1Bi?=
 =?utf-8?B?Nko2eXBJSUVWTFM4SktBMFEzYkhDZG9BWUJQOC9ydG9FTFNuUjZLejN3aG1t?=
 =?utf-8?B?Y0pOUW1kWktvbGNKYm1NWFY1Z1B5RkZqTkt1eGUvd2dGUzJOVTNZOGkxTE5p?=
 =?utf-8?B?Mk5teFJmcllKQkVjOTdNdGh0VXlKVUFBQjZKa2NobEJzNFpWeUJlQmk5MS9M?=
 =?utf-8?B?eHNWOTZrK3YwYk9yRmwvMnpOZ1oyRS9aUUxEaURPMHhwbDVSanVwQzJaZENC?=
 =?utf-8?B?NkZkQVhSQkRVS3lZMkpWM1l1bzlwMkJFMHBCWFJ2cGJnNGM3dzBUUFdKVzFw?=
 =?utf-8?B?KzFqWTZQa2RuNDc5QzdvM2FIcmp3OHV5VUJWWEplb2twczNPdzV4dmpXWWRC?=
 =?utf-8?B?REFRSTF2Qnh0YXkyRDFnYW5qc1RFN3dIMTRER3RFT2VqU1FyN3FpcENESkVD?=
 =?utf-8?B?L2d6T08wQjBlSGZmRnRNY0djVHlaSjNQRGpaSFpkY2ZoL1hnOHZ6WjFybnFY?=
 =?utf-8?B?K05mSm1DNVFHUkdXd2lPM1piWElob0l5WW9ibWVFNnNNQWsweFNrTjJ2QzI1?=
 =?utf-8?B?YW80cGJNMTdzMGhBS0wwK2FjeXhNTk9uQmJsZjdzcWpEL0hSUFA0KzJaSWl4?=
 =?utf-8?B?SU1HRmViZ0dNUTNIMHdiM1ozV2ljRTNCcWw3QjlWV2JhVFJaYVd1ZDdHSFkr?=
 =?utf-8?B?ZVFmdjVUNFgwYkRXczhJR05qbzJXUmEvdVBpSTAvNjdwY3dqU2tHeHNrcFhy?=
 =?utf-8?B?bTh2UlI2RWRBWVZhVjdyK3I3UTUrUU43Z0J0ejh0V3dQeTdBN0oxMDFjdUsz?=
 =?utf-8?B?SDl0WVpZKzFhNHVIczdZM2drUXUyWHlYaC85eDJvbHM4YnVGbTlSWXJsVmUx?=
 =?utf-8?B?VWtRcjA0NkFaNEdqdUwzWVZNYUk4Rk8zMDVHSVVpaCtzYnlpRUt4U2hwa0VP?=
 =?utf-8?B?UG56azFaQzZTZkRsWFl6dFMraUp6MDJRM3hjY21aZFlDa1N6Q01NNXFzdzA0?=
 =?utf-8?B?NU5qOG9UREhIQnVxRW1udjVrek1YZmxRKytaSnp5ak9nM0R1UnU3SDZFTzVI?=
 =?utf-8?B?RjVhWmNBTzAvSkNXeWNoeUt2WTgyQ1A1T0xVcFdCTzAzVm9ZVTBsbzArRE82?=
 =?utf-8?B?Mm12ekJhMStna1cyNGNLb1lpMk5mYmtZdFQ4WHNnaUJJWWw4N2tEUjlZQzll?=
 =?utf-8?B?aWlEVGNiNzUvUm1GNmFBbk1vTmJUTTZJRGhnZzlpaXNSOXd1TjVSNHZYTUJ0?=
 =?utf-8?B?VkQ0SlRZMVFDU3p1aFl0R0Y1R3I1MjJvYk5TdGZ4V0Vwamc1eEJEaGpiQXFX?=
 =?utf-8?B?TC85SXpvUnNPdy9ZdVMzQU8rL2RFM0FtaEFJOUtrc25WdVhzRlFBdkkyTDBS?=
 =?utf-8?B?VzZSdzByUnFBSFRuNzFPL1dIU1p0Qk9CZnpaRmVuT0ZlaUFBbVFKYWdOY0hD?=
 =?utf-8?B?L0poSUtGSnRmWUlEQWFObGJEQ3E5MDF2alk5YkVvYW96eGRvYVpRS2ZaRFZG?=
 =?utf-8?B?c084eE9RQXcxRmxQMDhUR3o4Z3RiTE4vbTJHbFNlWlljb0VHcjZFQT09?=
X-Exchange-RoutingPolicyChecked:
	uEt2jR4urOsMOrAIwQqBN1nJFWZNNSs6fHAbpEgl550WeDbg7vqdlB29x595qrDw+ahSIE4y8A6iBajxSoXnsqfGlKendvMrCCanTp33DAfBQsST0JjmYgNLGKogp72QKFROuz7MVlJ9CuO/8Vrus072sJ+bJ+qRvcHZJjAmK+24RfFORp9tpayZkd9sCL6/jiNeAqt+XUpYe40q3hUq0jYIUkS8LWFbfE66WoWSDIl5zKdVktAEBCaoDwzpT2OUxoMTQrZbB+pnjdykTNoNEgAKvQ06butDS3+Hp6etrVw3xQ6tcShYmKXWLkl7hZw8s5MenLgUXSWwMaaywDzjAQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J6U+m1VtWnrInW0/vR0PtobkaHjiWaeUzWYKhr4LttCi0XJj37nZtyExL4z4TckmBiEzDQgUh7cLiANFiTR8XIN9lRp6eQwrMMA4f0mPUDfX/jgl1Dyh8ONye5R2rZTmL//CM6Q/VZ1ltVecGIjBzo524ynPRSiYvwtIiJoP4u1l51Bj0PLBSCwqTW6Zym6Ra+IZ0aKW/xuk4WPgw/jDRETCknvGJD1FXkenKVtgr1ycvVayq8THKqQkqz/muIY0VO1f3xmGWFBVwM+ephiBVndtOCrr+8KjbZOD5BqWIM2fKFlqCIpHbqaZ8pjzhMYVquj7hVhGizX2U97wQ00IRtC4L9500xhr2WoErz9YWFp/NAyGKRKiyYp+cmnqmIptm+jNpbXOqU8k2o8aea0Wbdz3WFXuyc9RxEtlz6fktXII0yLOiaIem9MDWS1wDY0dY1aecnYO+SjiKhYvPNejQaRVJpfDi4Hc4xQLJeCes0cnByVIezlQptdJI50Vgwux82S+3CPvd6BLDrXcFzbIBDsAJ1A3tvrnoxs74muhLYp3fjDEJERXtCB/Ij+UsQOhN3ADtJrDnlJmP77Bi/C/qPu/zB0JEoAYAsGMDhXbXWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dbe025-a3a7-47c2-cbf4-08df1810dd7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:48:03.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Junnh3u/DD1X3aU1jA5hPk0d9KfCvuaskkejWbxMhRmhIVcevUPQn9fqHRTPPZN7+eEK07Mt1PoEh7Ee0cHrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB692458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609210274
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3NCBTYWx0ZWRfX5i6uzSHdYova
 qPRR9X+DX22vum/JEjB3NiOzpdDvDnT4ywztI03UAUp8aL/rhuP9Awn2YBdEbFIjjlK2oet28kU
 zE0l+e9J/9IvaPsmFvhQN4Xsq7nTpfUHFQWRmKYrj5VuMXjaBZnP
X-Proofpoint-ORIG-GUID: 6_NeYQqqr4JZ6_qXno80BFULgNQnKodn
X-Proofpoint-GUID: 6_NeYQqqr4JZ6_qXno80BFULgNQnKodn
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab17be8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=HVfyyZH2AAAA:20
 a=BT_Iqad_AAAA:20 a=l5SL_8w_xKDRc-QDV4oA:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3NCBTYWx0ZWRfX5lTilw1n6WOq
 alveABWDhFqu1+JD6FJPGnhAzIGUdcSRzs/rcJf5jVo2HEtxGGiT7MSJ8MFOHkK8tCOS54Y4UMQ
 5kdcpm95FP9UVIDxSHRHfWOQs1HeD8G175YDu+zkiXbGWDOyPxln2xA/Nt5W/a8YD87zfvneeYP
 JC5ZbcBPXDamlAqpurphNhLe9Dk8AQEpTsaTJo7+puESaHsapCDwUU+JPQEgqXnkf5ysPaUpHa8
 S/JJ50l48/sAjkbM8ZDZN8xlFDb21QPIENz5U+3tm74ioJpE2BBfDVnRId7gWTyWttUQCCxBEhY
 Dgs/dUtONOzZv2irRKmkaUbki31It4A279ktYhK1TaiFm2mPlQHmUBuwPY+kOnHR+04pslzsF4s
 0X6Mk5qSLDH5XP10rFoKW6Qb42AW4pAQ91h65IGZ7Yxl83lxeX6DH5bTfGDuHfhV6HO0nh3Dyxz
 ULLenCmHgtaHQ/CiQhw==

On 18/09/2026 21:51, Eduard Zingerman wrote:
> On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:
> 
> ...
> 
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
> 
> I agree with Jiri regarding the register names. It's not a huge table,
> e.g. [1], 20 lines for x86 ~> 100-200 lines that would not really
> change to handle all architectures that have BPF jits.
> And it would be very convenient for those using the tool.
>

Yeah, it's doable, it's just that it is more portable when done in
pfunct; we can use dwfl interface to get register names [1]. With
pfunct changes in that tree we get output that is either arch-independent
(standalone BTF) or when combined with ELF info from vmlinux
gives us the arch-specific register names, containing function etc.
To see the inline site for ip_send_skb for example:

$ pfunct --inline_sites -f ip_send_skb --elf vmlinux /sys/kernel/btf/vmlinux.inline
0xffffffff8201f241 [ip_push_pending_frames+0x31, .text +0x101f241] ip_send_skb(struct net * net [%rbx], struct sk_buff * skb [%rax])

(above does not need DWARF at all, just BTF + ELF info, so will work with a
debuginfo-stripped vmlinux)

So for me the tool to reach for in understanding the raw BTF is
bpftool, whereas to apply the arch-specific transformations, locate the
absolute addresses etc I'd use pfunct. But that's just me; I'm happy to
go with the consensus here. Given the current library support, I think
maintaining per-arch tables in bpftool (rather than introducing a new
library dependency) would be the way to go if we do add it.

Quentin, what do you think? Are per-arch tables for registers in bpftool
ok from your side? Thanks!

Alan


[1] https://github.com/alan-maguire/dwarves/blob/0da899665b04f16c3f68c0b736834a15e045c3c9/pfunct.c#L95


 
> Also, it appears that simply enumerating all possible flag
> combinations in a switch would make this function easier to audit for
> not-handled expressions (like ADDR), or plainly reporting that the
> flags are unknown for this version of the tool.
> 
> [1] https://github.com/eddyz87/inline-address-printer/blob/master/main.c#L107
> 
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
> 
> ...
> 

