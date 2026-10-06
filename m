Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352C34D389;
	Tue,  6 Oct 2026 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310391; cv=fail; b=lezpJFmvHfdggehP++3SiZci7XtE0V15AtejzrKd/i50UdmPhXS8No75apCaFpcZeA8LcIW4k8l4YReJlwVDXorMBoUWgj9oZlnLEQv9Nm2+CUfdbFqzATu3vXYIRXUORV5+zs5ktP4OJDZjo/hGTNR6lNsZHHwk3Vwyq3HelQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310391; c=relaxed/simple;
	bh=W02ef1DXCVH7H0lPcf0fxlIEsoF+lALJpBeho0gkAmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WnioFhy3vFkHln0M162lufgoE8ZuEb1twc5h9Ef1wMtmN/Ij4mcNDuWYfpUMcBKFzu/pHqWjFpSA/ZJfx/mdtjLkDw7RGjkuPBxZ/ENZD3xaEznK0h2ZG3ZK2fMznlYejozvpLp+5asXZx597s9borUsLlNW3EROi4Sc4ZQUF6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Anjgh7xk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NRUn5lUZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Anjgh7xk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NRUn5lUZ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696FXseZ2734005;
	Tue, 6 Oct 2026 18:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yuTbbHS9IU6rVc4fpELxr8wubWXwcgSbQFtB3t+mYPc=; b=
	Anjgh7xkE3nUM4ruukxYzaWB0fj/fpRl+7GWKrDeZADn/1LlOigiF4AY7K6qwTIS
	o4dNVcyIMFo9Kb/EQe73yghQxIg+e3uQ6lnfK7aoPaHNgbbpOkF/G9qgqz4hn3Ku
	WG4R5DRVvOgPX6ReB1aevqUgLzkLab5Df1D3SNIjnIuwQb/6TG9iufqoe97uUNok
	G114VEGpdnEisRCPG/mQm6iYYRsXwaRyDSzuEPGylmEi19AZEfSaVNjM4b1S7N+Z
	gJSXgvpSjDYgg/OxBg97RkbcJ79y8ENnMXawGZ0O4msCc7rMtfH1t5xMmjtQvtTW
	6fjNjPBFIpNUNSrtz9KR3A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2r9xve4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Oct 2026 18:13:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 696I6fjw022939;
	Tue, 6 Oct 2026 18:13:05 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h4d4vyus5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 06 Oct 2026 18:13:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqqp5rAcFN3uvzx+pZ+dW2VG19EsghB0JDnKZIogg5hzjrPI7nwIwQHop5mplTR141f5Bj1Zeh+5Kfoj2Lo9zDMFm6dXgzNgfJcPSHLSG/amwWel52czvRkWHPsjAXgaYw2iyuYPTiSv48yrNOKES7YWAq5ZWTEzMklmFZJJkoV6zOUVGX2S5hY7vuKVlU1CsqpVSF0CtKv9IRoQNWLYNrEWffOk0JUKIyP8KLhYFs1gkeTmuA5i9X6dGjhkafz4DGvIzqyfD4vEd45Zgx5FryEURRx+rk13n1Cdjl74sPwGtETECyJJ9XF8RS7bqs65rXqs9gUj6q76zGBDae8rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuTbbHS9IU6rVc4fpELxr8wubWXwcgSbQFtB3t+mYPc=;
 b=Z7e5git6bk4jElrrDQgS8u5xML+GEES5/3kNhIbWhINOisKx7BHSIny0uJS1oxXLUOuKhDYeN1vYaZvHL2Xe82ex4NdgGIo6bLYj5ERiBASLjtoQYW3ljyN0k2gvrNyf6RtIlpeePAcIVjQBAT5DlisfIrVx5rKZwJrr+Osp6xpIAyMa2jHlmyCwoIV+Kb19Vkap5sqdOlIt/nl/YpV22IwZezdUGOu+WmPLMUHkowCGqprPqmxBgOIxi4BeL5vQ8CSdWqaLHJayWiptev1Ic32/JcBIcCK4EXPfkmwqjN5Xsu4j0T9VrIU7YeLy2wCI7U1xeQvjag5HuWeFWi8KDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuTbbHS9IU6rVc4fpELxr8wubWXwcgSbQFtB3t+mYPc=;
 b=NRUn5lUZlpRMyARCU+WztLnqmK6WIfZnl3mMNdnZbLTpjBn3CmJla+ONZ4fvPOlyTyOj9tNpezP60L5h4RoEss61H3yEH4jBtPH0rLptJJ1nY8gMYBP6Eq7y7EBlGd+gUp40LqsDxX5vlHMtctjnCC6RdQUE5EC3P1nictGO1sM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA1PR10MB6025.namprd10.prod.outlook.com (2603:10b6:208:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 6 Oct
 2026 18:12:57 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Tue, 6 Oct 2026
 18:12:57 +0000
Message-ID: <354a661b-3fc8-4e9e-b3af-fb871375cc26@oracle.com>
Date: Tue, 6 Oct 2026 19:12:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 3/7] kbuild, btf: Expose vmlinux inline BTF
 through sysfs
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>,
        bpf@vger.kernel.org
References: <20261003194323.817885-1-alan.maguire@oracle.com>
 <20261003194323.817885-4-alan.maguire@oracle.com>
 <20261003195648.25B841F0089C@smtp.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20261003195648.25B841F0089C@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA1PR10MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: aeabed07-29e4-4283-1282-08df23d572c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|260925021311599003|260925022911599003|10067099003|56012099006|260925021911599003|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yBRxupZNw4TdxSyV4Pvd+DSINrxg4TVEgyUqTBbFvlg4mp9dJm1qW4OAmFq3txmdOXMYm10gZ14mhCi2h4J+4x9ZDTBOC3xUOvIcsM10wqRkG2DxeTL/ha3WElAX9Q+3hWZ2SYG3gx3jlXYClp/TMc0b3inWvqw7Kegh/W8qcdLciVtmTUq8WP5KMHfgQfVUCkajjPUNTUltu1p5ITKFo20T0wibVrHjDxWLqQgN8u5XXht+6Q+QZiQDU76G7lkxONo9x6b+Mvrw68yk6gb3H8g9Tjh/05BuKu+t/SGUg7dPBg5EDCAdTMAm55fIpr61k6OzTmIhLBjaPqjUUQ9ByR4l+A9y1wSaqvlOHKGK7GVLKM6n9Oax+Lws8AwfB80j6o1ln7HO7S/kJduq9PTjr5yX1PIqrbxRkMvDwy8LCvQWTOn42Y0BFD8rHeSss7lBmx2YDpckT+qkBU1zGRukYZcRGE3XCcqEqFyGELGD4sq+nQzcUvC0TNWXvFJ2d8ks68bY+tmaDPJfJWsLsFXWskM5wTu93tNPo22GN1l8DbCjZkfTsh8HdFGD/AqONVAUVKifZT+J9Hn1qaJhaXQlggA3gRmsogps293xsyhm03XnAhZzPVwCD0fLlmUrzMbkuvmenZRrhz2JY5UtxpIgA28taoOHglE7sopSf01TY70=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(260925021311599003)(260925022911599003)(10067099003)(56012099006)(260925021911599003)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTlDTHRPSlRGRTRxK1crMll1dFZsUVZYaCt0cHVNNTFNUjZWTENuUGhiU2Qz?=
 =?utf-8?B?eXFpdTIxMDFycGIzckxqeG10Z2VLSlV1U2hpd2xhTC9HVUx2ZGJLejB2bzVE?=
 =?utf-8?B?Ny9sOGpkdEltVWI5dUJBYjFHMDQwdGFSQXROVXE2ZFFNaklDVUprTmxJWGJ6?=
 =?utf-8?B?c2JSOVJMTm9UVWNGUzZBVjFYZjBXQkJKVnVPMlpXUEVFMy9GZ05aQTlBbGdS?=
 =?utf-8?B?bTBmZjc4ZGNVd1YwVGcybEF5RTJtSzJuc0VQL3FOSUtTeEhORzJPelAyRVFo?=
 =?utf-8?B?TnhhTlk4QklSWmpFbGNqYzQzOStLYU1tNXFBUTJLWGxHSjFZb2NBTURGTGw4?=
 =?utf-8?B?OGEyalFya0lVVjRIWGNOdjJsWTJ4T3BOYTJtYzdlTis1a2l6SWxlSWdFU0VP?=
 =?utf-8?B?cHJITEFWSjR5R2Vhdk5mdkwvcm5Qc0h4VVF5bk5KaEFTb0cwNm1Yakd4ZW94?=
 =?utf-8?B?SEtmaVFsM0dyL1JHZk10TVpZNTFjTDhEYzdtL0taRncxOS80RjE5SmZGOWZ3?=
 =?utf-8?B?M1FVNDFWSlNwUmUyTXdZMFRGMVZENVJTTGtvTWFuSnNtZEtxTXlvTjM4bG15?=
 =?utf-8?B?ZnJLYW9BdkdpclNJYWtnWUN6N1l2WUhUUlByMlVReWpTUkR6SjlubGFtZEQ2?=
 =?utf-8?B?L1BYRjI5dDhZSmRlN0V6Nnc0RnZoOEVWY2MwTjdHR1NQRTZ5VFM2M01VOVpa?=
 =?utf-8?B?V0gxVWFrZUZiQitrYmlVSzJ0MTBGSWlISVlGKzBjU25FL09vdHNWb21KRWRr?=
 =?utf-8?B?TVFKUjFmU2dhTnZIVmxFNGNUT2dpcENHb0dyeDBLRytpaW1lejFZMFZOczZF?=
 =?utf-8?B?Y2FCL2R4MERzeVFveGsySVNwdUlMK2d1MGl6bzhEcjY0VW5xNG5lN0ZoR25L?=
 =?utf-8?B?ckNJYjRBU0FOWjVjQnJ6dm1pMk95RzgrWFhpYW5CV2VMUDh2czZyYml2VEZs?=
 =?utf-8?B?TFVsU1B6SjNXK002NG56eHVzcnVsbEc3M1BMQ3prOGthSGNPRWZoeCtxMmY4?=
 =?utf-8?B?dGFTMWZqQzRGWlFYc3ltTWxEcjk4UGtsLy9jR1ZXeWt2bGliRHlucFMrRmhO?=
 =?utf-8?B?M1VpRTFUWGRteHVVYjdYdGk4YUMzRm9DSG5PRG83SHgwYVRUWHJMdVY0NTBY?=
 =?utf-8?B?b2EwUTVqQkpHN2FweUEyNTcwM2VJQVJBTVVsWHJNeUIzdVNsMWV0bWlubU5I?=
 =?utf-8?B?eXoxTGxIWHpEQUpJVndHdndqNHJseG9aY0VzSVNIK1BCeDZuakJ6Z0lBU3JR?=
 =?utf-8?B?MGJyWFFZclI5cGh3NW1FMm1SQjFGK3hQbEpoWmpjbzV0a0NORk13SWt2SG1S?=
 =?utf-8?B?TnFIVkZ2ZFJDcFJBK2x4REM0dXdiWkdPNjg5NlQzUm9PdlkzNWVveGJOdzFv?=
 =?utf-8?B?RW1pTm9relBPdHNOdURNK2J1VjVXZWVEZTk0QUEvaUZFRTNYZXRuaHAyN1Zx?=
 =?utf-8?B?UlMvTHJ6QjVhaG5HcERxQS83Q2x2SmRxWDB3UkFNWFJnUjlCeVFVRzRmdkNN?=
 =?utf-8?B?N0NrbXcxUVQwWVJiWGpCNGNNSUdmVHRWbmVnTEovTkFVUWRlVG0rSWRvMHdq?=
 =?utf-8?B?SHU0ZzZmNU02U0g1VlA2RkY2anEzcWlrQnRyYUVYa1V0dmU2V29IM1FpOFJ3?=
 =?utf-8?B?UnRPUmNZSCtSQ21LZlZkMDZmTXhBWi9laGg2UVlydVlpSTNmdXROYklnQ3Rp?=
 =?utf-8?B?eXBaNUJ2ZnFpdVl4aFZsNExabGIwby9hc1pZRmM1aHN6ajB2MzVsMDJQZFVT?=
 =?utf-8?B?cEZZUEpsRW9VbS9Qci94YmplNk9OSDlDN1ZmWGNvN2hhK1BwTjdEZWhHbG5D?=
 =?utf-8?B?ZUpObnJyNnhLVEZPRDJlM1I0SmlBRDFGSldLbGxuRGhCemdnRmFHUG5SSlJx?=
 =?utf-8?B?R095VC9iYWtJWEhlV2g5NlVjT2RBUHIzSXorZXdQZm5KbSs2dXFSd2FSRHJV?=
 =?utf-8?B?OFdIVnU2cHBwY0hXY1B5QXg2MWdONmREWnFQVStaRDBzN0lYSXQ5a05ZQlJo?=
 =?utf-8?B?SklsRkcvR3FrRTlmN2Fqbm83RGRMY3pVUFQ4SkF1MlpTRzBEVGMzbkZQeDg2?=
 =?utf-8?B?Rk9YVUxjbTVNTzNiVU1NNmwvcjdHdDB6bnNEcElKaWxKQmYzVkROckZKR1di?=
 =?utf-8?B?NmtjQ3JzUGtJRDh5K3hXTkZQa0lwVFpYeTB5Wk94TVFtZE03Y1JYbUxtcHNR?=
 =?utf-8?B?VnBUMlMwb0ZjREFYQkxxOHVmcDBnaC8vdkVyOGVsMFZ4Y3VCNXFrTmlIa25X?=
 =?utf-8?B?Y2pHQTE2UGNvbGNQalZmVXgvZ2VZZnRiUnhBNkZDQ3VpV3FLN09OY2RiSG11?=
 =?utf-8?B?YkxyMHhJN2FMdWh3OWZTSEVpVVZQUTQ1VFBCOWRhRmlpNVBEamw2QT09?=
X-Exchange-RoutingPolicyChecked:
	y97v3t1Oyq9t0S1CBOuVhONZFjuALFRAFh/AZuE/NIoLi8rwM+DtCS0bUlZN77QwKTaZEW6q9jKjNdUu8J2ozM5K5bDxFNoZWhts3GzSXwU5MhhpMD/QeslvIlHAbFlJZviEXzFj0Armr8ZpTTZpAu63K5OjCX5VvzSqmqyvocsf1cg9vFaIrupztnv+OCbsbfSpecJzvJ2siyiK920i9tUOjnZ9Epra+kfkhB4xlrDyC2gRxBDhE5Rkx+oM5dtRZRXohRNp6Dbaks4ShDsr9SDMEQxPo02B3hyqUQnBBvH/sB0jZhhCvg8lFg2JcEpOUQsVF+mi9iFYAJrREu1Krw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HtG04uX50nCk/ElDKXXWtafYq5OcFIUrBgwHIGEQhT8Gs3vNmIBDvumfAFo6R2oGvDZHkgRifFzbLLxCy7xJofbOycWodBJkOt8+gl9MUVWCXsEyB6uJPUievQ7KC8MrqiH/o4J7P9rV4ao1yyUcNNNkOPbjkEptlDdI8a9nFxKNcpBw23gCjrvZFszgy4Ckh6AjpISHIYJZ8k81e5oiNxKSHuXdkhcbIOf3IRUmhBe40kYG33m/4VLMhb6JWZRxVRTRUE/V02zcxRv+pFY/hFlJWvXe7c8Z0yaKOSvu5+szUE4voOn8fkF+dRe8RHjom53AjpNo+PHxZtbs4EfY8w2n1RF7DVOZ0ocVHPo0cy0RlUrqsMCXxgYwLKJqW+m8zzenb2mm6GiBGIKvAwO6T4828x3dUOS1BaSujy/a+f6lysQg9S/zg3q5IbIeI//C9nWoOOdqva2O6oTkoxFqkoIdALQJnaObO1Sbo7I4SvXLDJdyojROVEyBGirKmtsZs6g2NVfXqYSSq6DFEbzUpeGcEXVKgqCR/1n5o/GRAlT787cxQf1Kq4jkNIrpDSyx/vU1y1SJYXeEGdIoKLeFkSEooueJwSt4WCBpAkMJe2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeabed07-29e4-4283-1282-08df23d572c1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 18:12:57.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTkA5Q44FOrIB/xFtrvNVCpXr96HF2UxzEZPthdApSLxG9YE9ClDvMJ+x0dXGrwBa+We0l8t4OtJagC77xYM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610060072
X-Proofpoint-ORIG-GUID: SrQclA88FCZPiehhf2A8b52tfzb_uNaI
X-Proofpoint-GUID: SrQclA88FCZPiehhf2A8b52tfzb_uNaI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX4KHsU+HNGZS0
 9RaXU2s4OVL3tcdlBpAGQLCB66doEHGy5hTpgQCk3RMK0OQw/f6XKgDVI6Z9CRpEpxlvd5/dtg/
 UWWuA7+aT4Qlkfg2F+k4wRQwUPpBchr/kpBFGWLOKr7ZX3vCAgRWasmQaJHd0jLaqTnMtatsDjE
 TOZ+F6aycPsU6FdPjKxuEqiE0kk7Amk2mDgemppTxoZs3IVzARu5vUN7gNquQgckBXhRK3gAzZN
 obv0/c3ws2WxNd24+nj6UaEWE42RoSzWDA05FBh8t8f2C6ivk3MGHlYsZtD8XkbmydEJJofdGaX
 3tOcUYVqmMbZIVCfq9m2WUibm9psjvcM0/qIewzH6Rel+QYTLlTFC2xSMuDhdJDWSJwgCOwAVpB
 Nb9UWvHu/8E469gCZnH7cvI3PjZel5qqmLgkrQc5r6PadUuoGM9w1WuHMA6azphQ0Gzl+LUq20a
 CspcJ+2boNqcBTiMfLkVexYkU2xOZivIdd17ctpE=
X-Authority-Analysis: v=2.4 cv=QbrzLcbv c=1 sm=1 tr=0 ts=6ac53a32 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=M9kKf4efZPKQg2i6puEA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX/MGRwizYd63b
 P5EKpS6fpPE/tY4vWhuiJ2TawjZmiWKS+zDWvvOg3pcYx2N4sk8r9gsgfh2fDgN9E9iTaAXt0BI
 Jzqvkg9pFTuE4M/3tS6y9Klr9OKsLTn/uqtcMD4v+cPFl0Z4UgDn

On 03/10/2026 20:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] bpf: btf: Unvalidated zero-size allocation triggers WARN_ON_ONCE in vmalloc_user
> - [Low] bpf: btf: Linkage fails for sha256 when CONFIG_DEBUG_INFO_BTF_INLINE=m
> --
> 
> commit de2bb52fc001c93d461a0839a26e550f67f5ecc2
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> kbuild, btf: Expose vmlinux inline BTF through sysfs
> 
> This commit introduces support for embedded and module-delivered vmlinux
> inline BTF payloads, making them available via sysfs. It also sets up deferred
> binding for a module-provided .BTF.inline section.
> 
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 134b15a44625e..24abfff1ddc3c 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -432,6 +438,19 @@ config DEBUG_INFO_BTF_MODULES
>>  	help
>>  	  Generate compact split BTF type information for kernel modules.
>>  
>> +config DEBUG_INFO_BTF_INLINE
>> +	tristate "Provide information about inline sites in BTF"
>> +	default n
>> +	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE && SYSFS
>> +	select DEBUG_INFO_BTF_MODULES if MODULES
>> +	select CRYPTO_LIB_SHA256
> 
> [Severity: Low]
> Does this cause a linkage failure when CONFIG_DEBUG_INFO_BTF_INLINE is built
> as a module?
> 
> Because this is a tristate, selecting CRYPTO_LIB_SHA256 here means it will 
> evaluate to 'm' if the inline feature is configured as a module. 
> 
> However, the crypto library is called directly from the built-in core kernel
> object kernel/bpf/btf.c:
> 
> kernel/bpf/btf.c:btf_verify_link() {
>     ...
>     sha256(data, data_size, actual_digest);
>     ...
> }
> 
> A built-in object cannot resolve a symbol exported by a loadable module,
> which will result in an 'undefined reference to sha256' error at build time.
>

Given that CONFIG_BPF (not tristate) also selects CRYPTO_LIB_SHA256
(making it y) we can simply drop the above select.

 
>> +	help
>> +	  Generate information about inline sites in .BTF.inline sections.
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 0630675377aaa..732ba06846675 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> 
> [ ... ]
> 
>> @@ -9015,21 +9016,122 @@ static DEFINE_MUTEX(btf_module_mutex);
>> +static int btf_module_handle_vmlinux_inline(const struct module *mod)
>> +{
>> +	void *data = NULL;
>> +
>> +	if (!vmlinux_inline_link || strcmp(mod->name, vmlinux_inline_link->module_name))
>> +		return -ENOENT;
>> +
>> +	data = vmalloc_user(mod->btf_inline_data_size);
> 
> [Severity: Medium]
> Could this trigger a WARN_ON_ONCE splat in the memory allocation paths?
> 
> If a user with CAP_SYS_MODULE loads a module matching
> vmlinux_inline_link->module_name, but the module has no .BTF.inline section
> (or its size is exactly 0), mod->btf_inline_data_size will be set to 0.
> 
> Calling vmalloc_user(0) here happens before the size is validated against 
> link->btf_size, which causes a kernel warning in __vmalloc_node_range_noprof.

yeah, we need size checks here prior to vmalloc_user().


