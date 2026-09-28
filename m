Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CC49363C
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589093; cv=fail; b=sQKxX1Xmb1FuUjPga8lHaWbTODALHVoG1sNcibnRJcDUh9vh1VYaKUq7Ur63sUISmS0e2qdcJXyf6EYIoNX3gmjL8wVBZ/sRIfOZkA77RhQ79wCRRps2mJpbVSyTg8aYQaHbbWp241H1qZbR3BjclF34HdQ+AMoiKoAiBWCeELc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589093; c=relaxed/simple;
	bh=GuuBlPTNl7uAgRqHtDlMuLSEed04cfRKJSc/Elr/mOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W9XUtrTtYtcdtSeHBty6L6YR0nNgo+qPVDHFsjksYJDcEk4qpZ0E43JLqhhttYymEsjRO3ZhSIyG8cquvXCxX2V2W8zrTRrXnykmXBVE9pVgEpzDX88dx+Kio5zCp7e+rlgS62/PGenruuH38s5qjfoJYyVUUslIsUBzYL8YgYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GPB97rxX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m1PVEkoE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GPB97rxX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m1PVEkoE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S80wr1113592;
	Mon, 28 Sep 2026 09:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rc5AzA8IHFfZEvn9u0fHNuKiLoIVY2C8i095+QFb0Z0=; b=
	GPB97rxXhD/lnwx1NiRjY4Eghe/tQgWFun1601EPWmgmi2ez+VETJJKiM8NXpAam
	w9M8zbipOANJJKixs55V8n5kXgUgrfWDEiGFEUV6eNBEFeSuVBwegnlCgTCNLKmk
	AB0nlZTKrxugfxjtfYZ7Zv7WLDSl0CKTfbZZU151F/h6bX0Mse/Ks702ve6A00ki
	dqSk/PHobPWERlcnMeu5ilvih3eE9jGWWp3Ly4dv+eJ+Q3EdyYuyjBz5TqwFLOb5
	rQDz+CUz0f0epxgead0N/spWNoGjlrNklz/VG7RTmnzh6FgEGSFYBkPRA7LOgzqs
	bUFjtFczGekkBfaj/9CgEQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbacwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 09:51:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68S9o8c9038958;
	Mon, 28 Sep 2026 09:51:02 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gaec6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 09:51:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee9KGPQ8sR3n3Zfzsndfq0NEGyciLPdhz3JlAynDs94mF4cPBP1l6dNpzKyXWmF1TZGmvQ4VAZ3MRHRmYl+shUyb4FtVHGooqPn4HMOa/pZbAp71cUIbav8rotA2pJ55pfC98j/9gt76AeDcXxuxbL4zCujQLGFLKIqdBA/uEdUyKfHyGCJxkwins6rnLGuIYOyH6jAOJvkeHc8LiuC0rob2DyJLPaWzlhWrMtL7weS5t4GRzxfovs3ywfR5mvYcQazS6CJHlQx6Ro2QCy8nx5KOYhnivGOmW/xHSP0kYYFt/Y38VBXxX9IF8ZGH9BJF7mauO67QVkhoNfAGhfOdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc5AzA8IHFfZEvn9u0fHNuKiLoIVY2C8i095+QFb0Z0=;
 b=El2+mek1/TKkeHbbHlFeHpt1hGbtG7NvQ/l1xlWWwZAsDj2XURy9WqP1XcFWSGUv4ixYnxqcX9rJ42b+U4NOp15464VDrh9c0uipyx/MOjJZrXRH/cBoIKCb5q1zFZKWJSRJ68Mz+9Rk9GNd+7mJ1Fg+aPozG/T3lDlWOFkuCLCqatWxBmmOPlM2lg7DBF1sRnGO0pxdATUNQo4zXXHgO/HLbgyGGwYWFxxbLvKPd4Pkm6pbBfCJDdSM7TjnlpecNJvcwOgXobGTryFa+GQKsm3khB4qAl3qWR1l1Ux02cJd8K42ghazaD75Ud7PYQ4SqaJVA++SglKAopfnDvu+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc5AzA8IHFfZEvn9u0fHNuKiLoIVY2C8i095+QFb0Z0=;
 b=m1PVEkoE8A+mimBE/FhFG1yU36H/UY91KuB4QCSAue0Q7700JpBuF+OtRsduHqqMEgddl/ETG29eNSZSKQcMwr5eWGTcOnkzu39qFzWKptPp5SQZWND04buKzJmX1utk4hAQ6cG9r7Ad0Epesr3Ov69fWcieO0Snp2x73L7oXWI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 09:50:57 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.005; Mon, 28 Sep 2026
 09:50:57 +0000
Message-ID: <45621ec4-b13b-4c75-a46e-63ba73b1d417@oracle.com>
Date: Mon, 28 Sep 2026 10:50:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 2/3] bpftool: Update func representation to
 include function signature
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
        daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
        puranjay@kernel.org, yatsenko@meta.com
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
 <20260926175113.2368566-3-alan.maguire@oracle.com> <aro1veHZThxBJbhF@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aro1veHZThxBJbhF@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO3P289CA0022.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1e::16) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH0PR10MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 762dc614-4d36-4c21-cfb7-08df1d45fea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|3023799007|6133799003|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k92VfKILHE2H7jvpaQ8iWJefyjeLj5ALeoUWOuZOdcgae4PHTNW3LnO4ctgGEqqY0CMkHZT1CLQ5aUHvS+qMA1bYLpf3uU0qmxawJivj/3x3pRWALquZrjhnSrP/ZlthPkTXQ11ISAM41pBXQtjfeHbm/JJ//ij07pjqFn1Gw5W7Quz/yl/ydFFZeGhLka2iYk6CEASgVdmHBsIHsFzvVmeFmd4+Z1QLSxS2AkBVfk3wRq9JwVM8CbpGuFuWElzwFMwwjsGjCHgbr9T2wv/oJ+DLH3sWAGOS7yzhVl/NCzOPHEYjUJwc6GqvwsysrY38GLIRfx9TTpSz6tr2wpUsoQptpzXfdTLt4rwsFaBWMySxt7VIRnn2GBjqrumx+UsQ6Wrpox8uI34+Lq19XfxfnsBuMV0uryfiHKkRBcXfFhE1/M9WiC6FSLUxnrNA17fCpxzFG1ZLoTD/3vdgC6o0lIncC2NNKmxNkGmmvjD5eQo8Qas06O0q/C0/fiQl6DA6rzVyMWFqGqixGgqJ9KgTwIpAdfJO0kNyVRBPlngpze5D2ZWPylxLFnAIANFLb9gZ8XpCZIDp8l2LtCPuyiMd3Xzh3K11+hQHUVk7OKZ0p0tRvNO59f8Mw4uHYwulgGVLvizmTmvSzFFZIHnj5auiUbVnuV2dvsJB/13IIA2pEE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(3023799007)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGs5ZUtOdGZNNVNxSDhSOXBhUEZrZEc2eXJURkNKeHB0eUkvaHQrYnUrVWNi?=
 =?utf-8?B?eStRd1lRNHBkbm0xdS8wdVNsRWMxRzNZTjVEQXhTMGdpSDJpOFNza0dobG41?=
 =?utf-8?B?NnZKdVJ0WGdrVHBMZExTbnFvY3pVNmZXdnVhVWg0VDFnZjZNVWN2ZFZaNmw0?=
 =?utf-8?B?bGJtUTZlNGVvMnUycE9TanhNa081ZXAzTUF3aUtzL0hPdEp5MTVLanh1UmJR?=
 =?utf-8?B?VFk1Z1pXUSt3aHowRXA5cUtITXoxSXI5aHppUmZXUnBKVVZhcUpESFRoVGhi?=
 =?utf-8?B?Um5KTWxGZG9oZVo1Q3BhUTJkc1g4NG41bG0vSlhKbE54YVpwZmw4TVJhbDI5?=
 =?utf-8?B?RHVrOEFzY25qRnZvME5OYTRJWlVpa3Y2ZW0vZTVnK09NTndEcTk5UXFYckNk?=
 =?utf-8?B?WDNZNFlrclpRUDNrMStGOElJZVJMcm9GWXluY0pCUTlZbTBTcTUzeFZIdUJI?=
 =?utf-8?B?OENUZVRpNDVPMEhaSG9DVTNBMWRKSVpIYXJ5UURXdDAydEc5SGNHcDVtV3I0?=
 =?utf-8?B?MHNUaGlDZ1NXeURVNSt3N2laSFkwWEc1azI0bnYzVTRROFJ0bEd1TCsrYUhC?=
 =?utf-8?B?ZDdBOGNLemR3dGszREVPTFBQKzBzRkZudVBPVXZGbldDK1VBaVR1Ym1tdjNz?=
 =?utf-8?B?SEYvYytHMVJuVlBNQkRtelFiSmYrc2JVRitDM2x1cjBObDByd25HRUxSTWZ6?=
 =?utf-8?B?UmluRXJoRDl4bld4bSt6cnRjSE1vMVVXaG1KMlNBUmNSU3NzUlRMb3RkaDRQ?=
 =?utf-8?B?b1Zsa0RSbXVINHFkb1RhMDAzc01zRlovTTUzazhwMHFLZUZ0R0c0WjhZWTFS?=
 =?utf-8?B?dUQzSytOWmdYZHBnV3R2d3htQ1FJanlwVkRyK1RKRGNXVWgzcmR1MmgvZk80?=
 =?utf-8?B?ZGdyd2RkelBUYzhCQjFiWGNLZGlYeDJNa1NXSkFMYmdtRmJmS2xVUmpaREpR?=
 =?utf-8?B?TW1ERzJsU1ZnZStabHFNQkxVd212QTZoRGwxOFM5cWJOU1FZSmNwSm1RRnRL?=
 =?utf-8?B?aDdRd1ArV3g0dnNCbE15dmZQSXJPaGtpeEw0Z3U1b0JoMVRiMTBrWWtFelkr?=
 =?utf-8?B?bG1wa2FvbTdJZVBEZmNCdmFQQjc5OTA3TktBUHN2TlhSM09mV0tRN2xzMTNC?=
 =?utf-8?B?SUpCRHBxSGRoUmNta2lmOUFDYStTWjlldGg5b2tFSmdyR2JJZXY5VGdXUEUw?=
 =?utf-8?B?ZkhmOFF0VnhIZzBaam1IUm83dnJZeUQ0YnZpZEY4MmpQVktwdWdMZ2R5M3kw?=
 =?utf-8?B?RGVrZHVmZ1hPeFFWSldSZlNxQm9HT09HaW1ad1JMbjJSMGxPSmxscjM1QlpS?=
 =?utf-8?B?dnVyWHVMSU1XSmRRMHZjTU9wUytkUUlLNzk5T09vWHBsQldEbStFOTdmNklt?=
 =?utf-8?B?SDkrVVJGNE40TVVoZElZMEc2bUJ6dUxoM21DOFdUTS9xRHFEMVIra280eDJk?=
 =?utf-8?B?dU9mZUhlMzJHVlMwWkxOUVpRR2dBTWE5dzRVNzJjS3o1YVBYMXZaTmw3bWov?=
 =?utf-8?B?Y3pRN2svdXVpQS9pUnFiV3p4RWE4blJTdnNzNzhVT25YZGU2WDVDY0RQR1RC?=
 =?utf-8?B?SVpzeVRLMENVVjBoSm1EU1Rlbm9jcU4xazRMbXQzRkpjY2p0MjZGZzJqQUR3?=
 =?utf-8?B?bWpIbExQa2M4dHlBeW5hWEhpODF0QkpGWUpaS29JaXB1ZExYSHJ6ckhwSVZv?=
 =?utf-8?B?aUVseXVvblNtRWNIa3hkVytDc1N1ZDlhNjFhNXgyVXFWVVJzaldxV21FL2Mx?=
 =?utf-8?B?VC9RRHg5MUxLZ0pEN0pQVDJHdUg5VWw1RVUwNjJOTnJ6SFkrSjB5dmtGMTI1?=
 =?utf-8?B?S1QrUStkZ2o1Wm5EaWxTcUNnbFF5SS9mUWkyeFNaUFl2K1dSV1NNUEhQaTB3?=
 =?utf-8?B?emJQSUU0TW5IdmVudXQ0OTMxNTVnY09YdzQzQk1NZXpZQjJsL3BYYk05d0JQ?=
 =?utf-8?B?OVplNjdUYmg4SEQxZGtpSlkxczZFdXhGT1d3cGxBOWQ0UVZYc3RoNnJQa3hz?=
 =?utf-8?B?R0QyYmFYakQ4clV6L3ZzeFN0U2UxWWRmQ3NRWkUyaUY4U3NsZlFGWHNhOUhl?=
 =?utf-8?B?cEtybVNmZjJTZnRjazhOSnU1RXRVY2RSSWFDbnZlaE1pQjRaV2gwZy9OZWVJ?=
 =?utf-8?B?Mlgrb054VzRVd0VKS0RwYWhKZ3QvZzNScWFMMWZGd0J2VWJBNU94STRaczNX?=
 =?utf-8?B?VkVDYVozME5yZmtEUWQyYjh5MitkR3N0NmlVcEVsYXErb24wOU82d1cxVWlT?=
 =?utf-8?B?eGd6M0lJKzNwcDZ6aUcrTnNXbzNpbnpadG9HN1RWYUNGYzJXY2NSN0hVNUtR?=
 =?utf-8?B?d0RmM0hvNjZ2MWtVVG1yZUUvb0UvbUpmRXpqdkhzVG9FSnRRcUsvUT09?=
X-Exchange-RoutingPolicyChecked:
	yovAm5bxML317gelYsih/aMHLDkWmTk1kuC5oSpV1BlfWEMKi3cOr7MGPLJI9edj7UGIuWpVGObl72YPP1obFRvilx0BVEjXaPFaIMkl8agvS1CUbwocZVbgGQAgirIyvSpXKq2Pu9cByp7+Pu2I6F0Fx5rjizxAw7dfZSqwMKXeG0G8V3Xj02oDf/NQA/Vt8YwT2EN9mPBtpDSBl290zfrxn1f9Hcr6MUIzFC+X8v4IJrixhbveY/z0syEFXM5M6t0YUN2iKnEfpYw4MoNWYTpgkFeHNgntIYjmmd/4nf/v1InZiN3IprYmE0JHzGXFBY3WSiWh1+CX1CKQyk3rbQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o0XiZTrBAh1XQFareOVemLE+GvcUpikdFbE5Ntrj9+cH2meuIdBQi6bYX5Zyp0Tn4BQvmaZ/q4qkQRJWmrXWU3UK7s/UYeY1ZoJyVTOvrPUI+7xQfAGIGgPxp+VQ3PEED4rdaw9WyXawVHi0UmShovJIMVoC49QU7WD/nsA6kUsFy1lILTUvg+QD1LnLXuMDacuEkDpbXqkE3iLlltfFyJ5BZfTfWIi6fvfQPmc+2ieYdfxAdV+Lw48VhNSzgHVup2+CDwo6cT7v/RPTXjKqa/1UdcKlbtQFTM/2K5PvCcMaqBd9hLrqpxH4rbWhXlhKrK74xoRiInxEpIYTkQbgvCJbVCQVZNCuLVv8PVjDxgqKiL+VHAQV6TQa+ZTzywB03n8uDfHFIgKf0NFCoPjRaBigwhUQgssDB9zSorXHHv48XblE66KzDSJZ89qmbd2jI9URoFykEEPBMY2hBBvJ857bOrG1GyqB2S4Yvh9BF/SKxYXrWRHgJbxFDAwZ22xcBDfwCowC2T0Xs6fxrOerGDjwHBlmN6wh7U0vMp02L8tMwNJsEW4IKkA74pMou4JGGw1l3gSyIpj3Xv/562x+yYl9jk79WVV6vaxJzsbSWvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762dc614-4d36-4c21-cfb7-08df1d45fea9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:50:57.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDPAelRsLZXc09Z2iS1Dpi1fpQcJ/ntYW76DhTxXWRQleUgWNZnCvNounic+wFwRQAD39uU7A0HanO9nAhSHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609280039
X-Proofpoint-ORIG-GUID: xF9CRqtsFdrqbh3dyTHnSVBzCXK1XPzU
X-Proofpoint-GUID: xF9CRqtsFdrqbh3dyTHnSVBzCXK1XPzU
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6aba3887 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=rh6YSOAhL-6xKYQ2ofMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX1R8JjNZGFBqZ
 9RHKgbnusW7TH7h3AfX+A8ZSPdGRDdyaZOFkRba1B5PRtUj8BWywlmqoska16U8wbpim79kOSuz
 2HxyDb3ce1eg7Jl6uAdw0RyHwWNzzE/99+S+QWqteekLf/NoHdQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXx5GCPhng1xVC
 RjTGsxf2TQ+6qOcxvRMsqiEnowmdi1utwYCvQuFerHNvNlGP5UeE3A2ht+fNtcgftY0bGCWOonm
 iofhK/c1/LDerbcKQ3ur9yY/z1KrlHgc7PbB1E2pnxdp91Nkp6Cvi/ResXfOv3ddO4gLZLhvm3t
 1XPm4FYNDlNY8bsht6wvutTQ9vmB5pHdE/4UZBUfian4JZIJtDbr6DWjejoHKmxjjGbgGeRYU8a
 PlNllitg7nNubuKNErncC1fgLvdDC1INZuMRRCAfb5E0xC8qZ+28Emouz+b2uISvr2pUhHKrxVy
 Px08ngpxaXyUXyHSbUuXuZ0WjDKeFpdbk0AAMhbt4TotgM8+NNWLwUJOa52f5IDpXS0mVWzNWdd
 AIvqbvopQ+Pu4dwqQITmJjRfW4gs43cs2DNbDAZWrPZ80SzTpWlzjSO+8YUlT0o6PLXqDeivCre
 Bm++T80QBSfXthVytaQ==

On 28/09/2026 10:39, Jiri Olsa wrote:
> 
> On Sat, Sep 26, 2026 at 06:51:12PM +0100, Alan Maguire wrote:
> 
> SNIP
> 
>> +static void btf_locsec_func_str(const struct btf *btf,
>> +				const struct btf_loc *loc, char *str, size_t sz)
>> +{
>> +	const struct btf_type *func, *func_proto, *loc_proto;
>> +	const struct btf_param *params;
>> +	const __u32 *loc_params;
>> +	const char *name;
>> +	__u32 i, vlen;
>> +	size_t off = 0;
>> +
>> +	if (!sz)
>> +		return;
>> +
>> +	str[0] = '\0';
>> +	func = btf__type_by_id(btf, loc->func);
>> +	if (!func || !btf_is_func(func))
>> +		goto invalid;
>> +
>> +	name = btf_str(btf, func->name_off);
>> +	func_proto = btf__type_by_id(btf, func->type);
>> +	loc_proto = btf__type_by_id(btf, loc->loc_proto);
>> +	if (!func_proto || !btf_is_func_proto(func_proto) ||
>> +	    !loc_proto || !btf_is_loc_proto(loc_proto) ||
>> +	    btf_vlen(func_proto) != btf_vlen(loc_proto))
>> +		goto invalid;
>> +
>> +	params = (const void *)(func_proto + 1);
>> +	loc_params = btf_loc_proto_params(loc_proto);
>> +	vlen = btf_vlen(func_proto);
>> +	if (!btf_locsec_append(str, sz, &off, name) ||
>> +	    !btf_locsec_append(str, sz, &off, "("))
>> +		return;
>> +	for (i = 0; i < vlen; i++) {
>> +		const struct btf_type *param_loc;
>> +		char param_str[256] = {};
>> +
>> +		if (!params[i].type) {
>> +			/* Handle varargs func proto, must be last parameter */
>> +			if (i != vlen - 1)
>> +				goto invalid;
>> +			if (!btf_locsec_append(str, sz, &off, i ? ", " : "") ||
>> +			    !btf_locsec_append(str, sz, &off, "..."))
>> +				return;
>> +			break;
>> +		} else if (loc_params[i]) {
>> +			param_loc = btf__type_by_id(btf, loc_params[i]);
>> +			btf_loc_param_str(param_loc, param_str, sizeof(param_str));
>> +		} else {
>> +			snprintf(param_str, sizeof(param_str), "<unavailable>");
> 
> hi,
> I'm getting many unavailable arguments, like:
> 
> jolsa@krava4:~/kernel/linux-qemu-1$ ./tools/bpf/bpftool/bpftool btf dump file /tmp/vmlinux+inline | grep func | grep '<unavailable>' | head -10
> 	func='cpumask_test_cpu(cpu [reg0], cpumask [<unavailable>])' func_type_id=171851 loc_proto_type_id=171852 offset=7674
> 	func='instrument_atomic_check_alignment(v [<unavailable>], size [const 0x8])' func_type_id=171855 loc_proto_type_id=171857 offset=7681
> 	func='instrument_atomic_read(v [<unavailable>], size [const 0x8])' func_type_id=171858 loc_proto_type_id=171857 offset=7681
> 	func='variable_test_bit(nr [*(reg0)], addr [<unavailable>])' func_type_id=171860 loc_proto_type_id=171862 offset=7681
> 	func='arch_test_bit(nr [*(reg0)], addr [<unavailable>])' func_type_id=171864 loc_proto_type_id=171862 offset=7681
> 	func='_test_bit(nr [*(reg0)], addr [<unavailable>])' func_type_id=171865 loc_proto_type_id=171862 offset=7681
> 	func='__srcu_read_lock_fast(ssp [<unavailable>])' func_type_id=171867 loc_proto_type_id=171868 offset=7691
> 	func='srcu_read_lock_fast_notrace(ssp [<unavailable>])' func_type_id=171869 loc_proto_type_id=171868 offset=7691
> 	func='class_srcu_fast_notrace_constructor(l [<unavailable>])' func_type_id=171871 loc_proto_type_id=171868 offset=7691
> 	func='__srcu_read_unlock_fast(ssp [<unavailable>], scp [reg3])' func_type_id=171873 loc_proto_type_id=171875 offset=7727
> jolsa@krava4:~/kernel/linux-qemu-1$ ./tools/bpf/bpftool/bpftool btf dump file /tmp/vmlinux+inline | grep func | grep '<unavailable>' | wc -l
> 157950
> 
> I found on the pahole site 
> 
>   /* A zero id in LOC_PROTO represents unavailable location data. */
> 
> so I guess it's just not present in dwarf for some reason
>

yep; this matches my observation; of about 600,000 function I see around 80%
have all parameters available, so ~120,000 functions have one or more unavailable,
either due to missing location info or overly-complex location expressions.

IIRC this fits with Eduard's observations earlier on. I tried exploring adding
more location expression supports (logical operators etc) but none appeared to
add enough additional sites to be worth the added complexity. 

Thanks for testing!

Alan
