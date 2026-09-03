Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE723859EF;
	Thu,  3 Sep 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436051; cv=fail; b=UrScqiH/igmudjoYZgs7MXyphCRaqEpuhzs2lHgKiSib1dzntLOGXExqHZ29bCGgHlNTiS9Krc6YsKqJ97q1CU/VtRhR/x3jrNVhLYo5tQdj3vXACpoCUvEULFkP1TPMde8Q2gGqmVTF/VlWadt+mS1boff8m0KRLejQ/581yoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436051; c=relaxed/simple;
	bh=pEkd8m6J0UxiI++BtdE81wMkidVpVzixfpt1NRD6Kfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TNTGVf9ghS2YIpCxZCdjopRMVuNI7Jk7yAiWTfs6Ln6FrGpqPTfKBm8Scn1+TOgvQvfto59chwrzwbfAnlolpj05mwsf+0ZOZ+M11LANkopq6P9ECdeSKqS7dS42/+2HBbyYr4hLX4KMszcn5WtGqptQWptck5zXugbP1xVZsYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F9xytvMe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MLkNiAzx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F9xytvMe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MLkNiAzx"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683B4JJr108843;
	Thu, 3 Sep 2026 11:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EPj3do34+VPlrK3Id4o0gUw6/jgFxjYOGxy1bV492dk=; b=
	F9xytvMeOTfHCLUjVVSpVh/nLSn520RgihxFAfeYwVkLaFngZZadHJhrtN60v7s5
	9ZQUTcHf5UZQaeZ2lpRB230Z5K87ZYxmMuNFV2gv2v/mXA0l9PNq7Hcr67kfEdWU
	Ah6jQ8DAWzyq4zq5x4BJkDYZI9kRLPOxUjQD9e+dXC0XkT6FN95Y9uAzqdpChJW7
	cC1A7rAgkp84sE9SvRb/ciBHbKRjUyWOwDFv0f9syvwhJJ5JDDsP4IX0NtDEpbO9
	2FeD9bwxFjGwRQmKWsKisXwNJb4Tt+gBPCkhxnmOQ6qvRUciTHLwc+hS65gV203n
	/lnzHwVADHM0ovY14FBiVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbnubgm0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Sep 2026 11:46:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 683BjX4p013354;
	Thu, 3 Sep 2026 11:46:43 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvswyhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 03 Sep 2026 11:46:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZQ4JY9eD/ec1/7uREmpkXgp+vN7QtPHdhe8oL1m/e8Sm2TqFz6h0WbA9CAnhRnkb1cPG08McotQjgPKCw6T2nqG3BR+SzYlD8RIiQZNNd+pyv71Nbc4AMTqBWN3C5p+7aZCjglVpxZ0d8WlydHa+BpI41RN0llx1ZQ4GS/Te7zmPI5qGvkgrS8ogMJzscbbrPkKj8ZhelxTFBlraFy7wQQzd4YomeBZg28gl62TYkZDU/HyO+XcHhYosNT/7bW+pNRiJX497rNk6xOoXY8LTglh6rdRCJuxEh/zuVL0WKbesZMcX0zxL5X00fUcIzi3J0Va/9aLdWcXlU+se6r7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPj3do34+VPlrK3Id4o0gUw6/jgFxjYOGxy1bV492dk=;
 b=Wql/2sf6xC0i1KUZUa0qtDpso/fxePoy510uX4jli8eD2a3bP0F691W6s21VFufJ1Yi29uFQ1IZJwZILPoC0SyDE8cDZYhzzyypJnbbZgXLON8XyTV8uoSPpX2qXZWcjpgkZsd6O/LmV9zGJqtCoSEa9oExloU0MIF3UgYIZr/dAmw8e+kRY3Vp0PkY5NFkvK4Pb5cMh1dSRxG/fpT7JlUBy9ysg7pK8qGUYCI745V5TZIqwaD1pPrB++hyT0sbXjD/KZfNHnMtrSnog5hpiVBe9O0STGqqVTf/s1YmG1XkLRFi5o3m772/daEh4HPXokF7EDLNlilsEfSxBhgvtIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPj3do34+VPlrK3Id4o0gUw6/jgFxjYOGxy1bV492dk=;
 b=MLkNiAzxYUCdMsHTydM1sS4r2mlUGdu6v8fcyFY+fvx9nwLgsgXGt+4h7fTTkipvLQLoBqMblUSsfz/8MqEMUed4oRRpNkAR7C0vBlYvR5E4A9n3vMAgCMKPOC3r0rcZ/a0XccNPMD0EJ6g+t8fPJJcWHrE80hK42GVYKDLbino=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by IA3PR10MB8465.namprd10.prod.outlook.com (2603:10b6:208:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 11:46:38 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:46:38 +0000
Message-ID: <3f676dd5-729a-4461-98fa-a76093412fae@oracle.com>
Date: Thu, 3 Sep 2026 12:46:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: say why a module BTF mismatch keeps the module from
 loading
To: Paul Menzel <pmenzel@molgen.mpg.de>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902225829.131674-1-pmenzel@molgen.mpg.de>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260902225829.131674-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::15) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|IA3PR10MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: f21a77ed-ffe1-477c-38f1-08df09b10311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|921020|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MXS3CPZibJJ3KIu/e987NOddhGadFjEPeUSovv9Ey/BjeB5pnMcG+Lib2X6n1HWmq1YGidpLzvykBnGXLfqHlSC1N7M/tJ3tN1gfqjYJnFmT4Okp9WoTOKjCmd5Hr7HnfNpW8ZsslnvrS0gQvYna22lYlSOc2ciNh5F9hhohvvL1X8ETYVklaQWMAEzwd2l3N/KSMiop8cXuhW3yimAZNArmsw9Y2k7U+ZtE2ENVFXzZ3wiVZ9nIlJ+8c3Gu97d8ejSUl8VDP4n55VA6D3JRDai3XOSA+kAqCGQb/HtRZo0qiYY0cSW6Q6JiozbcRsKP60Hxl6+efaSw1AUGRY2niULzMu+xFw7WbJff7ralfyFaaYDTghhyf7e6sZ5/5/C4izHIm3usGh4w9j6bZyXY/ZH3dRxmsp7HclPinpLq16mmqbwx06bIPxleFi4hf+nsY7+ywdzqVHduNP2mHcm/glbVRxmV6bNH2NdKqk6I2CGjsxZL5DnZorlwlOqjpmZQi9M8uzWB0gE6E9rHeAH7v1ambYxwzzyEX5ihcodGxxFgIxsfROM6sIVn0qmjBvHn7n+Ko4WTin4kiFcx5hioHmUFd+XPgGX1bmjEqtnplHdm3brcCd0gFIqid5n3r5qSNYD9itV0OGqUq35ZpzDiJYr0AE9n2Bz+8Vsix1QTxZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(921020)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OS9uZElZOEhjYkNFUGZONDRIU2JMV0NXQlVFUGh6dHQ4TC9BN2YvSU1NRzBH?=
 =?utf-8?B?andTcXVDV2kxQ0wzcHQ5WFVkRHpRQUh0UXRacnUrZk1aL0JCNDZab2JOck42?=
 =?utf-8?B?V1pDblhZcHJ6eGZnSFlQRlhmNTJ1NjJLUWI2ZjNhN2ZTcWxoSWNka1hRN3VQ?=
 =?utf-8?B?TENnMzloVTJhZ0w3M3VYS1BvNTVCY0ZTTHdUaVF6Q0FpTmNNRDc3dmRqTWdR?=
 =?utf-8?B?Vnd6SVlZd1M2VytqTXBwNUk4WXNmaVR5aGdOVkhDVUExRlNkaysxNkpSODNv?=
 =?utf-8?B?N0FNb1BQOGduUDB6UVpiNGEzaGZjazZiVUpwM0w2TTIzcEd2YWlqNmU4RjVv?=
 =?utf-8?B?VGZrVUhyK2l3c293aGxUTGhhZWNMb3N0ZkMzYjRKQ2w2YWtvWGpzSGl3QUdE?=
 =?utf-8?B?cFZsSmEwRy8vb1JSUG5nYlhtVE93cTRVR0NkdnY0S2dMSHY5RG5wcHEvREc2?=
 =?utf-8?B?WnJTU2lMNDVzOGpqWGIyWGd4aC9UR2xiSmt2RGd0NUhsdnBJck5DK2VRdzZo?=
 =?utf-8?B?anl3aHNyamlCcVZUaVY4d0NVL1JjajhLRStuSnRFWVBvR05TRzJKUWZ3dFp4?=
 =?utf-8?B?MU42MmI3MEJnclpnZW5OdjNZdkcxLzZUbU9paGFyWHlYb29xK2JEZEM4TlpV?=
 =?utf-8?B?eTdzSlNHWndaSVM1cS9oeDFUbDJ6SnV3dThaTmlwWWN3YlpkaHJQWTRQWGFj?=
 =?utf-8?B?ZEg1cU10N01KL29QazgzQ2dwY2IvV2NVQjdNSGZ0clB6UGRmTFM2NFp5RjBO?=
 =?utf-8?B?bTZyNFdEcVIrU3ZoWFpCNzk2RCtPeEE5aEg2Y2pHQTJGbkJ4aHFtVUE0N0tJ?=
 =?utf-8?B?WjQ4N3ZidCswbzNudXBqVGMvVHR0RXRUUkdaTU1sM05LeThOOG4wNG9QUHUw?=
 =?utf-8?B?eGpSQlozbVZrbWdsQkl4RS9xZHdVU2pEYTV4Z1JEMmxHeHQ5VEhsWWY2a1Ar?=
 =?utf-8?B?M29Kc21Sc0RZUXB5S2xQbHJJK3ZDdDFNeTlqYVVCTFNMbzIwbUJ3YWxIS2t5?=
 =?utf-8?B?ak5aeXZTYzBiRy9Jd1YvbHdjZWdIZDU2WklaR20vdlJZVHI1WGk3TlVtVHVY?=
 =?utf-8?B?K0p4ZW1MdnNOaGJobXNkc1VDMWJOWlIxejJLaG5zbXM5ZkM0K1JwVjlnSlFr?=
 =?utf-8?B?RmxvT1hvUHF3SDhjK2JTMDVRL056eTczek9OVWJTcUUvbUdUb25wRG1HWE9h?=
 =?utf-8?B?WTg5TncvcGhWbTNIK2t2Q1kyc3hsaWVmbjJuclhGb2NJZXFXQWF1c09yVG9i?=
 =?utf-8?B?Rko5U3pML3lPanR5am5hS25aTmtBdmlsdzBFU0c4M3ZCcUdtNnNuMlovWGJJ?=
 =?utf-8?B?dWdxWjkrdklJMXprK2R2Wk9EUkJrdmdqOUp2alE4TmpncEp1dnNvWWhJTGhz?=
 =?utf-8?B?T0pVOFVCaTA1M0w5ZGVVYktmMFd5Z0FHUENqV1NyNVJIb2ZLUFhHN1hXZ0Fm?=
 =?utf-8?B?UlhkVS94NWVTUVpPZGphNU9iVmY0S1RnUVgzQ3lJcjBLQlI0dThyOXdCVjM5?=
 =?utf-8?B?dXFtcjIxdmppMWttbGtVVzFFME9aUTlBbThVeG51d0ZDUTZ6WHNnUlJzVExx?=
 =?utf-8?B?b1RTc3pWVkNRRi9mdy9rY2l3ZlRFekIvSm0yQjFVSklYMTExNmpSRkFHelEw?=
 =?utf-8?B?MEhxVHNib2FiR1hzUkdVK3RUbzNYbUNRT0J1dG0rQkY5VFl3OE96QVZ0dEQ5?=
 =?utf-8?B?dU9NR1JGdkhNUmdueitrUmF1eDNrZ0trZ1NrV1luRzd0cHVNaWhrcTVSYUsy?=
 =?utf-8?B?ZjZucFdEaGhGMkxXeUd4Sm1mZ1pOSVZKSVlJMFRVL1ZSQjZnbThsSnpJNWdx?=
 =?utf-8?B?Z2JpR0htVHoyVWdsMTRXR25uNG13K2NNa2p5eFo1TVZqNXZIbFh6aVBWeG8v?=
 =?utf-8?B?ZmU4YkFSOGlKcFdHVFBUTnRPdk40NXZJM0VaOU01d0ZCM3dLNFQvMXZYSVR6?=
 =?utf-8?B?TklHc09FbjkwYzVFQW52QTlhNi9TbDhPMVNKSEVHTytKVEhtTlNLUzhQMGZm?=
 =?utf-8?B?Ty9zVGxRSkVTNkZHZHlxUVJBdDNocDhBbWR1TDdib3J2clFLVm5BSnB5QTlM?=
 =?utf-8?B?TlVSYjFOdDRadEVlQTB3dW5wT0U4MENNQW9OWkhEM0MwcmRCTCtEeDN4YjJB?=
 =?utf-8?B?cjNuZjZEUzF2NTdaWG1zbWFxZmpLQVZnbXVaSWFFVG5jQlBja0VDV1d2THBB?=
 =?utf-8?B?RWU5UElTV0FjcTR2Y0lZYnErS2U5endzc3JrQnVKNXRwZkNLNU01TkViTldG?=
 =?utf-8?B?T1VENDI4Nlg1WEtzNXJaRGJFZmUxMEVJMUFSQU9zNzF1U3VGcENjMEpkQ2w5?=
 =?utf-8?B?emRuUHhteG0veXVHN3hmMTJzOGI1OUhsSzZ4anVhTHhJTXdFTUQxdz09?=
X-Exchange-RoutingPolicyChecked:
	AGcqx+bqY4QavyrHwl9w9Q7QaOvyUlWR010sKZS1094mz6HD4TCt1dlUDUlsy4FcIjalX4iVQhiHtsZzQbRFKsugEOHxQxYT5HmuZg8TD/CMTYuPuw2dzRtOw3Q4joJVDZYMo2ro2I6mzfuN7FGOdnZU99708oyDieKafuTs6aNCfAGWYterIqD68Bi2KhZix0HB8bZq+wF9SVOzqGun9kzMyaMRV52hRUns8PW4r+bak0TPpUXwdf+sNYSflsrQ6JbCcotR0iSxNaWPerjEl7q5uFJZm/2bKslbL4nIk/wmTiLP1Z4tfLJM88oCZH6c/yOIiSgwjvFhk2Fj/vL0nA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	72Vh8vAqZKVraEbm/kd2qp5UDN5QBwP0KUh2lEmQyM9lrAHLdo2ErTAJE/1/zkTcEU522MIE6qkjiLuyZrMqE5KLGRkH5t853RRN1XHLsnZyUJz6CsbrKS3ymRVQmZ3+BKjd1fync5xWytL/8mxKNrrj0hORVbypy36sqRP3cjjGGWOSrE0Rr3/STEbhZadEPnKUZFj2jsOEXeVtl+pPqx+QsyGn5rzkbZgCo5bgNstFiYY6fiiXnrZepfCKKFn5U7VA/fjoZYIobkhKHcTgBzZ1Q52jkyhEQDGOrUlHmKVQk/0l7MzswT6jDvWa1eAjGucXIYOrQr1ygce4Bx1FZOvnOsoVZ3DcZcqj1S5Iso2NbjrTbpDLnFpl1Ms5qtmFgKoNusSPMTBSYnEXdJ+DngrYBG3uQlnmMM1hIwJNveq0YPdR+k3y3lO2cda5w2Ken003BcOziPEaXwZzzqipWoVY9LPHPZ1eswdLHxol1pJpaSaLvD5PzoJWuFr9+ewarpAN0DuKGSTOXb51+pE+GW8lcmx+d9Xc+0PNcudzEMyOuIsw+pnsLtv4MCLF1JNSA0D0T5isqCbAcqInxjWo4VzdFYJt3gaBD9gKUP6OwAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21a77ed-ffe1-477c-38f1-08df09b10311
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:46:38.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhH4hLQ+G8JNtHLoAPIEOfqRR96Blwgoo1gTBazl2fOcOkhL15PwhvkTM0WDSq2aBZoCsoZFxAbBLEtq+MTpsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609030102
X-Authority-Analysis: v=2.4 cv=QoJuG1yd c=1 sm=1 tr=0 ts=6a995e24 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=sUAJiXQJb7M84e9sDgwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-GUID: ESTEbLNF4S7mlqkkz1tTONLvHDEEIfaQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwMiBTYWx0ZWRfXzPBwlx4UL+P5
 6un9hWMfyKr/2RuMTkBIIq3wsyEE7bKmtGD91Bi8XvXiEPWapqJ9KExi83tbMC28Xfs17zJZMZa
 5B66Ed3FDSDIaqFQEUWskXz9j76sf78ZTV8drcZe4qn8viUF1iLPyXVRXf19szBNs6FIAtcLQaj
 2ChXAANVtulZRRMe54RH4Exh2xSkMfzSJz0oX0RwnOb755iDy9qKaYB23OojIbWIc+Zc3LFpxvJ
 dvxl06QgAAVrnxHC+CYv/qDnFI//SoTJ8CJXPvX7mH0vFtRgCArk0mdRqkl/cDFfiq0gdEpcc4L
 gTfGpBXn7oN0cD/8m153lTVcjmbreJsLpWd1XLEdRBNTL0Nj8OHtXDVfyWEIsEvZmshV2YuQp7I
 dhSY1lS0LL0FwRoaw1Gj0hal0pA8DBTly5o/6OhqWclVZ9x8J5z9Gq7/JYPrpUul5X1PDO5CQl8
 HyCvZDYwDYeZL+kIaKjjMM/3e4gJVMfdbNFNiPzk=
X-Proofpoint-ORIG-GUID: ESTEbLNF4S7mlqkkz1tTONLvHDEEIfaQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwMiBTYWx0ZWRfX+wxF1dmHqD7r
 jCc2sjlhM0MWCtdi4KmYRRYvO9l0fqQW17821iPibkcCQ5NvpXWAtFtDfMUP6tx7fYdLbgGLYh1
 tNwK0PPomHSBFlSDsjc7KUXWYcczQ8C61TKhs7ILnHe9iulovvd+

On 02/09/2026 23:58, Paul Menzel wrote:
> With CONFIG_MODULE_ALLOW_BTF_MISMATCH=n – the default, and what Debian

Seems like a good change might be to change that to default y, given the
severity of the failure (module fails to load), along with the better 
diagnostics you mention below?

> ships – btf_module_notify() turns a split BTF mismatch into a fatal
> -EINVAL at MODULE_STATE_COMING, so the module does not load at all.
> All the user is told is:
> 
>     typec_displayport: module verification failed: signature and/or required key missing - tainting kernel
>     BPF: [124962] TYPEDEF
>     BPF: type_id=124988
>     BPF:
>     BPF: Invalid name
>     BPF:
>     failed to validate module [typec_displayport] BTF: -22
>     BPF: [124944] ENUM (anon)
>     BPF: size=4 vlen=32
>     BPF:
>     BPF: Invalid name
>     BPF:
>     failed to validate module [usb_storage] BTF: -22
>     BPF: [125157] TYPEDEF
>     BPF: type_id=125185
>     BPF:
>     BPF: Invalid name
>     BPF:
>     failed to validate module [usbhid] BTF: -22
> 
> That message names neither the consequence nor the cause. The report this
> comes from is a Dell XPS 13 9370 on Debian experimental where an apt run
> replaced /lib/modules/7.2-amd64/ underneath the running 7.2~rc7 kernel;
> experimental carries no ABI number, so the new build overwrites the tree
> of the running one. usbhid then refused to load and the keyboard and
> mouse behind a USB-C hub stayed dead, which reads as a USB regression
> rather than as stale modules. mii failing takes r8152 with it, and
> usb_storage takes USB mass storage, widening the confusion.
> 
> Note, the debug info is all that is stale here: nothing about the module
> code is wrong, and dropping the BTF would have let the machine carry on.
> Say so, and point at the escape hatch.
> 
> State the consequence on the per-module line, and add a once-only
> explanation naming the likely cause and CONFIG_MODULE_ALLOW_BTF_MISMATCH.
> Restrict the explanation to -EINVAL so that an -ENOMEM from
> btf_parse_module() is not blamed on stale modules. Keep it a
> pr_warn_once() because a single hotplug event produced 28 of these lines.
> 
> Assisted-by: claude-opus-5 (Claude Code)
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  kernel/bpf/btf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index da36d4b9d31ab..720c56e8ae498 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8525,9 +8525,11 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>  		if (IS_ERR(btf)) {
>  			kfree(btf_mod);
>  			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
> -				pr_warn("failed to validate module [%s] BTF: %ld\n",
> -					mod->name, PTR_ERR(btf));
>  				err = PTR_ERR(btf);
> +				pr_warn("failed to validate module [%s] BTF: %d; refusing to load it\n",
> +					mod->name, err);
> +				if (err == -EINVAL)
> +					pr_warn_once("module BTF does not match this kernel build; the modules on disk are most likely from a different build than the running kernel (kernel package upgraded without rebooting?). Build with CONFIG_MODULE_ALLOW_BTF_MISMATCH=y to load such modules without their BTF.\n");

A message suggesting actions is a great idea. I would mention a few possible paths forward, though admittedly it is a bit verbose. 
Something like

"module BTF does not match kernel vmlinux BTF; modules may have been built against a different kernel. Either build/use a kernel with CONFIG_MODULE_ALLOW_BTF_MISMATCH=y or rebuild the module against the current kernel or a closely-related kernel using 'make -C path/to/module' (this will ensure it includes a .BTF.base section which aids module BTF loading where some vmlinux/module mismatches occur)."


When built as an "out-of-tree" module we automatically add a .BTF.base section [1] that describes the base BTF types
the module relies on, then at load time the BTF gets relocated so it refers to those types in the running kernel.
It's designed to handle reasonably small deltas between kernel and module, so if the disparity is large it may not help.

[1] https://docs.kernel.org/bpf/btf.html#btf-base-section


>  			} else {
>  				pr_warn_once("Kernel module BTF mismatch detected, BTF debug info may be unavailable for some modules\n");
>  			}

