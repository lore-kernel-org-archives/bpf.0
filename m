Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612F3CD8BB;
	Mon, 14 Sep 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400388; cv=fail; b=LD2TEJCQSK+XYb1m51xkQAR3sPgQMPzySNZyH/hqKyNyAxftGR8ZSjB3ssKV2iJyu2JzNxrCJoPcem6obAqXL3DqlE6oB4mltNczRuOWsbExCQkYomRzURz9MMkvyAL5QlsErjHHNitpm5HbZMJ/YwMaUbfVr7eCjsHqr3RRAEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400388; c=relaxed/simple;
	bh=rhugXFagAkJqXGLg39imjlujNZMY6rj7Lm4sBbnnLoo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RmtL4UAmMzYEqeKT4yVb0NBm1Ari/EV2mAn2CP2SRNgvlEdIAygcRevuqWz7ktMOmzXJw48feyZDUcVO3hTmA61167HsQn8tkGp4QYklj9n4uEozGpzSRW1gKckGO9qhMYkC/eeAqZRuZMTG2saVPm3hYoWnoHACSXps5L05fzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sdr7C57u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aa8NZH7B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sdr7C57u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aa8NZH7B"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EER3HI2340841;
	Mon, 14 Sep 2026 15:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=puBS373wTtFZMTFqZ+B5XelgzaxdTY7cN/jE4Jr8fos=; b=
	sdr7C57uItpofUP806ZZAVBfYJq8yB2hqbVU+iRVkpNGDpWRGfPXWB6jKmm0VPX3
	1t+MooRjkHLsnGfFZHaExbVAg5X9+vNs4sgO5P3TEMmjU4cPqSaAWPt+ejarbUYz
	zJqdoALTieTu4VHE7L1Jfy9XguMG/0348UCJPjeYAx7ccEeIWHAcYoBDTnVrh53J
	Nr9xG/z76Q+UU5Q/VpL6dPuSUgp+pPNbZaSehFYhytGMH/HT+Jvw0vygIdIBz6PW
	SOsLDkFYsgl+e+q1IE+NBfpKZwCQiZ1vygn20R+Yo6Ix5F8VdfF0GvmFozabkYMH
	4uCMmiWbOJf9WA4BhLIA1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwn923qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 15:39:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68EFZQJL014784;
	Mon, 14 Sep 2026 15:39:16 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6n0cev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Sep 2026 15:39:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmw1n7wbfxUhhU9UV+2u85eXomUpt7vxmdlrq7z54CR+nELrteUY8joSlBRfF4git6Xi4vTj5C9eyfFgKAGnhXcDWaLu6iDoPpBU+KGwYqXsRa5oOpskFQjJBFkRNgpPIK2/YL6pPIZ0BUoj5brOnUUVpOIHGG8gdclA4yqlPtabcqQtk6kxmowaV30Hu7qlE/kNw4SFrfqnsJE/ZVzn3Ad2o0pix6xQ66bC715e2lTxoPPO70/MHbgyvsX3EnrUFQfTedhXFKRcgb9iGNlAtvHSnt7p/KbpKoQbdaZYH0eG7mBCklaajVCle/hbhvqRF3oZCjD3ZYP11jRYfjbjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puBS373wTtFZMTFqZ+B5XelgzaxdTY7cN/jE4Jr8fos=;
 b=MUmIb8rLvG+lCy0b6W+7/v7JjgCVLi4rmdE35bbJtdvn/eJllhSN9707Om1/gcDyGanWbnrD7ICMUiXj2cRx5uOLNk7bVbrSQccys3OyygcCAwByMHR2hfIJ45TbIvHFvmDN9QGikSq8mw4Jl+QRwBeoSZEMj+Pn2A+MGLVhUnSh84bt8zgloW9qjOcYKJq7SdNk38qEoVffnkTmgkbmz39efBy7PGRjLw4Q4YC6G4VeuiqXa98Cxi6PQ7b09gT1JU2A5mngL9Dj47hcGu70EAKw0xzofl7QUthnQIO4MovTUMLULMaxrFyrX1ukV5hSQAYpXk/wBszec0dLF2EhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puBS373wTtFZMTFqZ+B5XelgzaxdTY7cN/jE4Jr8fos=;
 b=aa8NZH7BjjibkQhM+m/EploZayqBIXOie99KFw0Uj2dBxVnTGAbRKyhmD+0ffgFdocmIkqI4kai9nFN1HXLrky2kgLr7H+OVdDFSXPunmL39EMPl5kJfesEv1S12pUGpmwxnseWqhh369taV1CSOimn6Fes7udqDzDps/xct2mg=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Mon, 14 Sep
 2026 15:39:10 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 15:39:10 +0000
Message-ID: <7828e856-a925-49f3-94dc-ba91a7eb17ac@oracle.com>
Date: Mon, 14 Sep 2026 16:38:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF
 location (inline site) info
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, jolsa@kernel.org, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        mcgrof@kernel.org, petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org,
        bpf@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-2-alan.maguire@oracle.com>
 <791206dfa4759027377273185e3940156dc9b976.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <791206dfa4759027377273185e3940156dc9b976.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DO3P289CA0016.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1e::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 759be4d1-cd30-4869-33dc-08df127651d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|3023799007|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XynNYvwFMPyAXdgh5Z3ogTrCmBsL/qLvu3XXs+9r6++fsOOFgxjiVFQUZovgY6yJx/egVQgrNI8MOku1v3UIBE6LvZYOhKbrxP8iHsefs5fjKP1Has+uMoL8CG8W6khwwxJYMoCJaqB2qnr7/kWrkQrJU6p7Npsvctw3ds6/OqHpM0KfgFU7OVzqaStiZfRgvMI+8v4ir87CFkAqJcPWsOKqonbScie7QC2mYJP1PMQEZUs3B8d1SDi1DCxQWQ+C5QXQ1dNtjERqivQWtqxSE7TaO7WPhpxzarpoa3+8ty0rzV0VKoA7bBSn831ETuOJ0QoMTA4QNq1f87R8AkzNiLJxmoJw9/Ll+Nh+tdkQg76mFSJLATfmDdWEdWyB8wOejIUcTGA0Gvy+H+imrAzPhgGVIAN1eYeGvmmPXC3/0JYnBtWhk6pmatYo1ckzabhbA0wVVvb9OkonhHy/mytihEVw8uslHwwZXNhXPsJS2ze0KwhcUYTT7j9NC6nWPSZ2Vet9JXcVRPL1sL32H9xWbQMDHFvDijieesQ4fFDJxtpLYGRrBKgHLRTSlnCoY5kmRabr3e7CkLDN2E+zUF540k1kM54hMaaR34OHIKyKQk7ndLC02BAd+Xa1AWE9YR22fzKH8/yUnbC+j3tLEHXLBrujXAAjygE4L9MJvJzBEh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzdHNEFDUE9HSjFGcWNyZkNrYnJZMTVRS2tjckhhd3hnZldXUlluWXpDdXJG?=
 =?utf-8?B?OWNpY1RWMUhGcXI2cnRHVGx1RnV5TXVhVFVqdGVOaWhQaDV1em93VHl2djhZ?=
 =?utf-8?B?Yi9UdTZsZUhEN1lSWitCUnVhL09BdjA0L1N1LzNSa0dGV2JxeFdVd1Z2dkRV?=
 =?utf-8?B?LzFuWlVWSHd0eUU2anQ5NnNVU2FOQVlHVDN4TDloWS9uUDdTRGRKUXFPdEJx?=
 =?utf-8?B?VE1UN0QyQlJNU0w4TjRnb0tFVUlhTlNObGJvZEZRUzB4VUpCV29WZC9aR3g5?=
 =?utf-8?B?YXQyNTNtQ2tLVnlFTERiWFpsSytsd3JXYW1iNjV4cmNnU0RJMWJOMURMZ3g4?=
 =?utf-8?B?dkdnRGhZTjdjSXE1UlVFclh1a1BGQmxoaDJGbzAyZ1hKRFFSbngwSWRydXp3?=
 =?utf-8?B?OU1oNzV1RThxRjFBWWlFV2djb1M5RGp1SmUzRE1kR1NjR1U5Mkg5Nk1Cc0g1?=
 =?utf-8?B?TjVWRzZwNmRXVmFGSXp5QkN4dk8yaWo2UGRyOWV1VmVWc0t5NnpoL1RxWE41?=
 =?utf-8?B?dm8wUWNLdmRETWRsMVhCT29VU29TTkVxUC9vS0dJRjdubzEyMzhyQ2o0bmtj?=
 =?utf-8?B?RDk3SVpnWGQyL0VIMHVIZTlLZUtDRDd4V1o2R1VuM3ZKaU1GZ2RFbVMyQVc3?=
 =?utf-8?B?ZWIrQ0hnYy9OSXIySEZsTkFtdEhJQXNkdzBaVGNzTDN5MnZhV25pZjdtMCtK?=
 =?utf-8?B?R0I3Q1AwcURUMDlSUWlNWmk4MDI2TzBCWjA0YjBIeTNiSXNWMkUrL1FkZGJI?=
 =?utf-8?B?L3dla0xWWHpJdmdma0VtclU1bGRaaVpMRFNDOWpJQ1U1S0cva3JEaWJ3NVNF?=
 =?utf-8?B?d3M1SzYwVlp6VzZWRjZIRDJtSnJtN0U5MGMwblFiUloyZEVKNmhDTjhLcDFV?=
 =?utf-8?B?ZHpqTlBlQkVxT25lSG5zQkRJS3FBMnpBT0gvWG5hdEkxNWRFMjMrZTdrUTRr?=
 =?utf-8?B?ZjIwWEdoV3ZFTHdxTDZvcElEcG5LV2VnZlV5VW9mNE9CeXN3dFI3aXpvTXpC?=
 =?utf-8?B?OEZPNXdqQmxCMkRXOFREZnB3MG9TT1oycXh2VWh4MGI1V0pZaEovdms3VjA3?=
 =?utf-8?B?eU02bTd0NlpNdnRlWXdjQ25DM1dpdWViZHRoaVdDUSs4czhUb0hpKzhPazc2?=
 =?utf-8?B?M0RRa0lXclNkQWlHTVhzWXdzZ0tFN2t1NWVYTzExRUl6a2Mrb1I0Z2R6WDJC?=
 =?utf-8?B?aE45Wll5QjBMbjVmMmhURlNwSUtpRWk1Y0tOdFE4TWhpc2NGNkg1emVhTWhX?=
 =?utf-8?B?K3d6dURndkpRKzNTL1htWXBpQ1VnVUdDTlA1Z1MzbWNZM3VWUVV4UE5lSmtm?=
 =?utf-8?B?ZWZ1MTV0angycXZkVC9tcVpTRDVjTWFyN3ZhT2prYUJyczZ5cVJnNWZMbTVw?=
 =?utf-8?B?NzA5cTVKa2tkOFFGclMzZXNEbmRjanF5a1ZaV3lMSSt3V0VNSVljRzg5dUY5?=
 =?utf-8?B?ekVla0xKNEE2cUM3NzZONDlPREIvNm94WXNmVUR0ODc0V2h6eWYvOU40c1Mr?=
 =?utf-8?B?bnBzNHF6Y0czOForRDNYOXlhWkpjamlHcmVtUUlRK0hPd2p6SzRQcHRQZ2Rh?=
 =?utf-8?B?R1dlNUZRQ3RGTlBUeTNnZTNUQWkzdXlpV1VRVERTSy85a1kvb24xQWFCSGx6?=
 =?utf-8?B?L2UxNytXeUV2VXVTK1ZEaW1ZVVdCWHNmY01JWjVISTRQM1UrUzN4QjBqMisv?=
 =?utf-8?B?TEJMWVpWVkJZMFhzdzBNb1FMVjVwb2VJemRhRHNINjZsKzk5RkNqUXo0V1Jy?=
 =?utf-8?B?SHBtblJVT0Y0T2xzcUNKNHkrU1BBSEpvcFNNaWdRdzJUbndudGh6NzBDT1Uy?=
 =?utf-8?B?Tlg3MnlYcnROaCsvTWJ2RzB0bHBvN1NmSlhjamVybDN4TE9IM2JUcXpnZTRl?=
 =?utf-8?B?SU5KK1lGKzkwczFxdGhMQTdVcEoxWlJUM1NERGNYR3BlOC80d3l3REJwaXps?=
 =?utf-8?B?bUE5MHZoaHBPQjFJY2FpVzZFWG1ldFZkYkpCZ0pUZk1QKzJHRGd3SU5JK2tp?=
 =?utf-8?B?RnpobVRVaC9ycmJUUkU2UFptNmhHUmdZdC85VGxPdW52R29pTTRmemZER2ZL?=
 =?utf-8?B?cDhKQmNXbHN4Y05ieEIzd1YrdThLWXNpd1IwTXpwMm04K0wrNXlFeENvc1lZ?=
 =?utf-8?B?aktpbGY1dHJLdkJRV1pxTWNTUjVCLytRbzN1VDlkcWJDTG5xV3ZEU3FxZFFh?=
 =?utf-8?B?dE81S3RrbVFjMi9TcFBPY1MyVEpEdkNMUUtOV3VSRmN6UmkxeUo4RVh4Q2k2?=
 =?utf-8?B?LzBrUDViMWh5ZDF6ck1zb2FtUnFQeVVEd0VMOU9WVkRTcGo3Q0ZTTit2VEVI?=
 =?utf-8?B?L21STDFFTHhJK3MzV0ZRN1p0Ym4wdWhQN24zemlvcmNtUXh5dWlmZz09?=
X-Exchange-RoutingPolicyChecked:
	zMVejqmeDwweICLWtp+rbkCbsoyWpnDXQvJAUZFoVL9LDGgsI68nGjkto+eBOn2bexBSJHZAS4aQzojnBiEzXeNV6AHeUmbOAQ1Knqel94Fi8S480IHehHrAipnbyI7EKcBKli17/WKZtl31dnEpZKufeZD4N5FCDdwnJgA/87LMncEqJF6PdNivGmIVaWyOBPP8Tm6cWnEIp5jPdkMHIfFC2ipI/aFpBFBgwFzztEKVd/QaDRaEJMkKPDPFK60ZRaENCRHZjJDqBRpHf6HFc2fkBDQbzPY778bnnBjrarv4uiM8RNXhpyUfgSXkeg1xA1Gac46Sm9j7fah59GoM0A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hmUu+lyyGNXm8U3bCQOAxDHCva8jtj8aG+LXJ+dSgADDDFSXcVSdKKUBwXBpOhIINT/v9/1E4Kl0Rcinksa6NKL+0NrrO9Y+SxLgEo57vDHoPia+/zsHpRQhHiE+llUd4t9nl8qhrEuLkUDFYtfiWDz+8wdrmCrqWqo3rJhq2fLWkF4Xc6eSfE6nbG6qnbMqhh+gLmHPZeeYuY5beMbg/Mkxwhfuz2Ltp77FffBg7XBha1k+ysr6Y/qXvN/pA5xZPoRQ3enlL3jZDCx0VLOkx5CNise6O5Wk0oCI4lxIlem48iKU+zy7hRfYLBFcdu4EVU5QeqI7j4rkrzm7Baj1m/CoQYkkCBTagkeH7ejZ97psYFNIaRsGUoKdIKVFR6n56rGJRg3/n7lRABEWHJz/O1pkvF/1p/mftOZ4E79gY9ZdRzJmABMe0rXEbnmbSQavEUJualzpAHCJ5n7Dai9gdyxf0F8Bj+C8Netw+HmVa5aG6VO+pYS2ko146KmHbGIUPzvgZYqgF/LPSkS/91AbX7zd0nDCCcPNtj/J9nXNtCN1UH3Sh7zKig6DwzS9Y8hGgFtnducIsrcwKcE1n7kiycgFkzra+5ugSHftpm/i0JU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759be4d1-cd30-4869-33dc-08df127651d6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:39:10.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmvXuM7a4745pbv3xznH/xK+5QjfVmxTn+h8d+og/qf1IvBBRmPeGlwA2ea4WCwAbRPO2f3uLToerIGCeiACOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2609040000
 definitions=main-2609140224
X-Proofpoint-GUID: s4c7QWN619G16O_Fk9EqaHhP-EGqEpi1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNSBTYWx0ZWRfX8+s92MapRWM5
 rQGn2/9gq8Oi7KAoZkAeyvlH2gm4aRrMA8KhyAh16qdwmLTqR9a6SveUpsVSeRjbC36HsN4qbBJ
 kWPKeHenlWMav5iY6SJX+45e/YyI350Apk25gpNaPh36h7jWMRLY
X-Proofpoint-ORIG-GUID: s4c7QWN619G16O_Fk9EqaHhP-EGqEpi1
X-Authority-Analysis: v=2.4 cv=c9k+0h9l c=1 sm=1 tr=0 ts=6aa81525 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=tBnixQJTkrW0mMJ6N2MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNSBTYWx0ZWRfXxeVT6pfL3MVS
 6Al8HdB8yHnMexqMWaKx/NzhSwHqj183mreEyeUE0YvkBJTZSs8HJY5OOFUggWDv4H6c6giWtsE
 /lDJbtu3+JyR3hvWYStJHr+gP9P/tniVtu700kkpO/u2Mjr2bX8Gshhl7EoHwGX+Ynpluow6yKp
 2Zl2nyHvTzrVTODfDCz4c9m5WUewMRUSrOIPZGu/O0+dzoEplfVh00Kjkw1e0DWfpSw83l6+eXa
 6hsZ49aBYdxkycJxmdSxkGd+34g5FIVs2mRwQAPq0UcS0L96fUtTAqB/P9edK267dYdTMOPK9Vf
 jgJawYV2L1UsjIQ3Ada+m4x2vfjKh3Bo0DqHNAfNm/Nn3cmVX3g3sI0H7TC00AZuH0o1ScSLmCm
 qSSz6yHIPRUKJahhcDqcapVNSFZ9YGW7cISIa95N4L7ZVWb8HQJ7zT1zvwckRWVJlaEbHTx8ka/
 AoxOtXM+huLhp6iCtsnM99BvyaEoUx4qVGgl3IDU=

On 09/09/2026 23:26, Eduard Zingerman wrote:
> On Tue, 2026-09-01 at 17:57 +0100, Alan Maguire wrote:
>> Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
>> to help represent location information for functions.
>> 
>> BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
>> location; either via register(s), or register+offset, a dereference
>> of a register+offset or a constant value.
>> 
>> BTF_KIND_LOC_PROTO represents location information about a location
>> with multiple BTF_KIND_LOC_PARAMs.
>> 
>> And finally BTF_KIND_LOCSEC is a set of location sites, each
>> of which has
>> 
>> - a BTF_KIND_FUNC function associated with the inline site
>> - a location prototype specifying where to find the function
>>   parameters
>> - an address offset relative to the kernel base address
>> 
>> This can be used to support representing
>> 
>> - a fully-inlined function at potentially multiple inline sites
>>   with potentially different parameter availability
>> - a partially-inlined function where some _LOC_PROTOs represent
>>   inlined sites as above and others have normal _FUNC representations
>> 
>> Also BTF_KIND_LOCSEC struct btf_loc will have two type id
>> references; one for the associated func, the other for the loc_proto.
>> Accordingly increase the number of m_offs references in btf_field_desc
>> to 2.
>> 
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>

Thanks for reviewing all of this, much appreciated! Replies below..
 
> ...
> 
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index ddd0f4f32d24..a4412bc16688 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
> 
> ...
> 
>> +static inline struct btf_loc_param *btf_loc_param(const struct btf_type *t)
>> +static inline __u32 *btf_loc_params(const struct btf_type *t)
> 
> Maybe rename the latter to btf_loc_proto_params?
> 

much clearer; will do.

> ...
> 
>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index 618167cab4e6..6062c9958034 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
> 
> ...
> 
>> @@ -212,4 +214,65 @@ struct btf_enum64 {
>>  	__u32	val_hi32;
>>  };
>>  
>> +/*
>> + * BTF_KIND_LOC_PARAM is followed by a single "struct btf_loc_param"
>> + * that contains flags specifying the contents of the vlen-specified
>> + * number of 4-byte values that follow.
>> + */
>> +struct btf_loc_param {
>> +	__u32 flags;
> 
> Wdyt about adding a flexible array member here?
> 
> 	__u32 params[];
> 
> Would make btf_loc_param_log() a little bit easier to follow.
> 
>> +};
>> +
>> +/*
>> + * The combination of size, vlen and flags gives us the means to interpret
>> + * the following vlen-specified set of 4-byte values:
>> + *
>> + * - a BTF_LOC_PARAM_CONST is a constant value; combination
>> + *   of size, vlen and _SIGNED flag determines it. If the value requires
>> + *   64 bits it is stored in {lo,hi} order.
>> + * - a BTF_LOC_PARAM_ADDR is an address that will be normalized with
>> + *   respect to kernel base address.
> 
> Nit: pahole generates ADDR | CONST.
> 

thanks, will fix.

>> + * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
>> + *   with vlen 2 it is a multi-register parameter.
> 
> Nit: REG | OFFSET is not discussed.
>

good catch.
 
>> + * - a _REG | DEREF with vlen 1 dereferences the value in the register
>> + *   number specified.
>> + * - a REG | DEREF | OFFSET with vlen specifies the register value in
>> + *   the first 4-byte value and the offset in the remainder.
> 
> --- >8 ---
> 
>> + * - binary logical operators operate on a combination of register
>> + *   number and constant value, aside from _NOT which operates on
>> + *   a register
> 
> --- 8< ---
> 
> This is probably a leftover.
> 

yep, thanks for catching; I was experimenting to see if adding logical operators
bought us anything in terms of being able to encode more locations. Didn't really 
help so I left it out.

>> + */
>> +enum btf_loc_param_flags {
>> +	BTF_LOC_PARAM_SIGNED		=	0x1,
>> +	BTF_LOC_PARAM_CONST		=	0x2,
>> +	BTF_LOC_PARAM_ADDR		=	0x4,
>> +	BTF_LOC_PARAM_REG		=	0x8,
>> +	BTF_LOC_PARAM_DEREF		=	0x10,
>> +	BTF_LOC_PARAM_OFFSET		=	0x20,
>> +};
>> +
>> +/*
>> + * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
>> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
>> + * a vlen-specified number of __u32 BTF type ids which specify the associated
>> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
>> + * location.  The type should either be 0 (no location info) or point at
>> + * a BTF_KIND_LOC_PARAM.
>> + */
>> +
>> +/*
>> + * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
>> + * containing location site-specific information;
>> + *
>> + * - function (func)
>> + * - location prototype type id (loc_proto)
>> + * - address offset (offset) relative to kernel base address
> 
> pahole uses loc->section_offset to create LOCSEC entries,
> which corresponds to an offset within an ELF containing
> the function section. Would it make sense to rephrase the
> above comment a bit?
> 

yeah, adding a note on location naming would be good. I think it'd also be good
to call them inline<section> e.g. inline.text since it's possible locations could
be used for other purposes in the future.

>> + */
>> +
>> +struct btf_loc {
>> +	__u32 func;
>> +	__u32 loc_proto;
>> +	__u32 offset;
>> +};
>> +
>>  #endif /* _UAPI__LINUX_BTF_H__ */
> 
> ...
> 
> 

