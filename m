Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794893203;
	b=KQOvui+1imx/pUS4LADZNCONOrHygirL0T5qU+o1IYZ5JHfRvUhGmUFLspJTHuuYrSUC
	 LgvgjSza9z5vvQIFnfvPhFNxlIL1q6MgB3dsjIVONWm9bAj8Qg6nznsuiA1ZvKZdCVxW+
	 DcT6U6GI/SII5lniXA6JtPy7tQLSg/x8kTiMoONK2cBmzkzjQAqbXISj52HcW+3x4QrFn
	 z4LNOAW0sp4ZPJcQgcyeTMKJcJZxSY3ThjP8KkAB4m84DWRy9QKo6qr/aB4htAR7YvDXg
	 Q9JfmzW/euYsTibgh8uRzsejHc0fyslI6KxlM9N07V7TMHuD0LxAVdHOizOpCaMIpUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893203;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:References:User-agent:From:To:Cc:
	 Subject:In-reply-to:Date:Message-ID:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info;
	bh=VymPxr3B2iuR2IRYxmXCbgYkYlcWkvXiAEWH2BRmWxM=;
	b=E8Sse4ymwYzyAbIjzxfU4jTZzil3FRBxq1+pcNjC4mzFU9xOoIuMv7Rib8NonN0SRAK9
	 UiHmsc/AGQ8TcIR8E51QxpMAqsIMr2qAwEjA+SJkBXxvhB4xBSu9EX7L0Lgkyd8E58nc9
	 jQniuhny9gvvuep7ffECyjZiR6RoR+LIFr/LjoyaLSpzaZ4dXvDVNByCZfEPQj2q3zCn7
	 Fm4agqzV76wfOhbz+u4w8dbIjzGF0yjT9LpL5/E7wv3FenUUriw4lH66/fwPyePQZ2+T0
	 I+gWGrzXNz5hXcLb+6dcicqMGn2qBrrL1ZKByqhoLkYmhOokL5WRTl5oP02VNxceB+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=sR34y3h8;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Rv19oWpU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E0606A330;
	Tue, 17 Nov 2026 05:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED8E0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=sR34y3h8;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Rv19oWpU
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLcFaQ3073092;
	Tue, 17 Nov 2026 05:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VymPxr3B2iuR2IRYxm
	XCbgYkYlcWkvXiAEWH2BRmWxM=; b=sR34y3h8CAEvjGaQK/NPsB0UYu4Ivr8PZO
	6A+Yg/v78M1Cty/U6qm6cJZKFCxUFfSaovuZNP3YEgTcxICMUThTUDbH3UHh2ZeW
	cxHj115EmxLua5neL1XVb6f6ddmh8tKyfrqFy5NGZE3jQu23Jht1NghZzbSzMPVi
	0+7do6eYgACOt9bHUsbXKAhBBYXOZnfmRntOP6o4yk2/c1/+MJ2flVy+m5LjecS5
	0azpHnm8haESTS2gHaJd6ITGjSpYKFlfHzHssTYniy2LjVkSlRnWaB5p9aWEmhy/
	Iz82zdXHqD3ZUvZL/zyrh+rO08n3f3d9SnrW3zM3+HkcYBG0NFsw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxfh9k9cw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 05:26:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH3pjsE1731141;
	Tue, 17 Nov 2026 05:26:41 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013057.outbound.protection.outlook.com [40.93.196.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4j0fcyah8t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Tue, 17 Nov 2026 05:26:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAPtryrVen48ZOKhJSq+3VVRUXWagkaLgY188u00XzVJuI2ytjKa3XxBo17HPhQW11uMhk7pRGo289cCpC0EV8N3SCGbj19CLFQpKNXhR+kir1lj3uwnsyCcYfsRs8K/A6gZ59mQHAeMLZM2ZFKGvLw2PKZUg2hXER1nxKtq3yLwQ307CzeME2nEl8MAY/FrFiQl75EAKzXXheZUeMThqPg623z3DYO2DLzoojqoO+eZ/tb46HNt7fkra2XPuEoKlbD+e7/kQIE1EhIit+jxyAO5e/ytJ+ruOfwIBzDL4I7/dPD1i7DFvS/Yz3TXAf/FNGDvUDdAfrNNbxGAMAdZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VymPxr3B2iuR2IRYxmXCbgYkYlcWkvXiAEWH2BRmWxM=;
 b=UGqJbSVDV79jUvKloVYc8s1qgdCUbKsbrIWPEp6L9FzKTvTVAfqgcsTswXnoQoI6nOb0Rhf5lc4WjFIrJlNZGztM72B8SDNho+Uu0d/LzLVusMVz65nkqBGT1sFzS2pti3B5AwCpP4UPDh1E0f7Efk2sRw+q7VOsV+lL4PMmQvIBWlySwi4nwlMSO3rvn2PVtrF4yRMgI9d2RsSw8PgqwGOLbfFCm1C+KJZxv//Rgqq5pgnRcYg1sHVISHaonkyRKsdurz51ygyAIAWREuzy3qd/MEadrVbsGKOQ+vb+cmBYQL4eUWUW90DMEaaSDdDdDy41FqCUU9dMWFFtXHz74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VymPxr3B2iuR2IRYxmXCbgYkYlcWkvXiAEWH2BRmWxM=;
 b=Rv19oWpUDhGgI2qI3KbLXhJ5N1oi+bE687G8bz8bstGffeoU3Fa6yYiIhO0Kw2XsHapM6OXy7spmamZu5HcvPH5shbCEgtixPew5ZZr9Lgxv/j0eCzn14DsFjHNDyskRV2eog97CIXTGf3zNBAh4bx4EtrR4cFaFD062Hf1DjU4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:136::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 05:26:36 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 05:26:36 +0000
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
 <20261116082437.66739-16-ankur.a.arora@oracle.com>
 <sashiko-outbox-216561@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ankur Arora <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v17 15/16] barrier: timeout validity checks for
 smp_cond_load_relaxed_timeout()
In-reply-to: <sashiko-outbox-216561@kernel.org>
Date: Mon, 16 Nov 2026 23:26:35 -0600
Message-ID: <871p8k2flg.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: c8db14ad-2dc1-47ca-61f5-08df446b5992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|5023799004|4143699003|56012099006|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/McOId+7Qb1uq9jcw37NoYp5iG/FFV4VQwnM20FjSU4/b2TeuzWQK8IZUIoSX+kRnCX94Bdku+yNNVFC8Du9zHJUXRVIOxLUCTkAGaMmOzQxEZ8RwUtG3Bla9QpilJK2nSsEua5jTfvs3EeFKMCyT5l4b4dvp3MycDyPQV1dTv7z0IHZC1nrZsHGz2LKgZBjCPW17TQZnqxUyV4iL0FAbnWu/HKHUH4PgvqEgKjuSnSpvAGfVQmVYSPjWO0u1bmb1X6Z6YcQ2jQP8pGPN82Gx9bC+QfgS6+dyxxeWGOfjUb5pRWKIKjofGn7mBxAFn06AYnghLbQQ6oPeiEyDd7S+q4RryAD7KfV2U3/q1CLxRbVS9hxIjTigj4fOOU/tL2Jh8jktfEOF+UZzdGD+64mVqSiIDvzkQwshVoWdzuQlezXdmJv4L8gbW+dwUtad2XhEZgApfFHn3p0Fthh1JzlEKq09Sz3XFTg0FKzcH1nKSo1WrjZ5RD8+LX0fqzc/wcmYpBp0Lt7nFTsQ51sqDknH8ESJj7ApPffYQ+fFFlu9Y6YCixmVzECI7ObJSQkqfplujv9y5tgdYvIF+vpI+qBDV5YTXBuVbfOVdbhmePVhfkk0Zu2X6lAYjbGRMmFBslTyZvE4zTDUnf8hr8Cf5IRS6ZUfigoQ3TGVWX0unUbI7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(5023799004)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrQQvotSwNBY7QHMOKp9ZlPNgZ3iN2ZqGGXpcnvLsx69p3bWuRoMy4ey0vXI?=
 =?us-ascii?Q?/fjSwVCBsYvp9SQZzXr3Vt4owPTOolqyBUbiTSaPFhsdUhYQQqnsxQy0fJgA?=
 =?us-ascii?Q?dZBIsAs3WdJf0OvAuChF84zJn6EUjitVnPHHyPtYEK9JccofrdbwlVVNQtHY?=
 =?us-ascii?Q?FUts8Orxp6SKFuaSshyt0BwFJHVmbNnmF/jLURlWMgdFyxhmTJg5+wIbUlmi?=
 =?us-ascii?Q?la+qbIyqr//RWzLz+TPXPEFDIugxUXlKyqxQ8Fyeuh0jrGbW133UaKGXfW/m?=
 =?us-ascii?Q?j2PHwPzTfFQo9vsvkSNBtVgAbKdJjs2GqP8OKll2nx7c66DLcrEVIpeNKiY+?=
 =?us-ascii?Q?9d1vh7A1oUUdRvS/uR1VClaKM6Sav4rU7CL1jlzTCGpQGgrrBS+dhH1sexSG?=
 =?us-ascii?Q?pKwpnhYzaav1HntXIuV2P1CiWg62lz6/ruX6wmz9imMCFD+LlSCn3WZOiWV6?=
 =?us-ascii?Q?5SlUfTfhj3EOyqU45io10H9chI90o3JDkB/ekGDAI590CHeKmRcP8cdqFQ48?=
 =?us-ascii?Q?0yFrh05AfzGlL7Cx9mnHrMrFgjrZi8oJgkBTmzbDjvIK+AN3erGr2lHHp+7q?=
 =?us-ascii?Q?B6P6M0cDrDIzw4Z+2oMoeN7a5/9eYdr0XIzMRVL8K5OpL+0m6fJQCYwMxKGs?=
 =?us-ascii?Q?gEkTsdiBjjL5GmUrZmzLeAUKIrdw8U/O+W9laj1R3eWmitezjdeSG/KYg/YH?=
 =?us-ascii?Q?S9dZ/d6+7hJT8ZdV7mPR173T3Z4TAQ2I9xVs9WjzDB148mA4sTTPIKfj3bXw?=
 =?us-ascii?Q?2RrQexvCfcyr1iquFumFhHMsnXFTJ3MQ2NYJ8Ymu3uIqCotsPewo7YHQP9WZ?=
 =?us-ascii?Q?xhtQZKG4sw5SVY69nlVGa58CfCujKTGDTzQBaK9v3XSJ11GY1kFSXqAalNwi?=
 =?us-ascii?Q?w9Phq3uBYJfpfu3x1OQUBAy1aXlRaRb+JvwltflsaQ4/QYtic+C6S1mYo4Cu?=
 =?us-ascii?Q?VgZPqD7pKMuyLb9ZS26U82iyjHzetUeWJAaE7/fEBkRy2nC2GXR8VNScnByA?=
 =?us-ascii?Q?6PyPMFsts/BD05mKrCdV0pW4tLIQsOt/BBLf+EPIn7oOzp1I8Hv7iXXJ3bkx?=
 =?us-ascii?Q?bXqc+s58s0ySLujI1La7FOZnMjBIiJ9C7d71z1gSdINgf2Q7KT8kQZpvqxxO?=
 =?us-ascii?Q?dMXwXgCj84fSVIVyg8lHpLlm1IQSv3mgmSH5Tq3imAssg+V5g4jguAxzgcxL?=
 =?us-ascii?Q?4PVVlxYsapIYicHAvBQ2gfxHYzvIG2VatzJgY3CvoMd+Xr0opelZQTCoKkLJ?=
 =?us-ascii?Q?loL3c7U2A8Z/KLthstw/BIqDF4wrL4f1w7use2MENB8tVfe8Dy0ZtiMd0Pz1?=
 =?us-ascii?Q?hG+jOx6pPp02+VQ/ku0owlc5K9ts3gdk8RnMc+4XDdIb51o48Sn3Kt8Pxu8C?=
 =?us-ascii?Q?MMcwbOUxxV2qoxxTUYxWKH5sL7j6qrD/303ESMUXeCjsM64vk5fFkxN2tK9r?=
 =?us-ascii?Q?l/OPKLj2FES1883wW8gONEu25infmrfTqmi+gOC1tF+xDZGvbry2YizNB0P8?=
 =?us-ascii?Q?R21rNKzCkiuvaoSodZkW5WWXaLzpd+/HARNhNasXQo1PTAtK2ffu7Rq9LcKx?=
 =?us-ascii?Q?NJVYGn6oTh9AuzfZ5IaIQHhEoTVPq7aS0kG0d3sSyMGMWzO+3sZx1+bgFpJc?=
 =?us-ascii?Q?S1tarKULmJBg+FFHCBsxlSEuGCLhKvgyRRDluFC7G+M9wG9ZvJyYML07DqA3?=
 =?us-ascii?Q?a4ygh0aMhvgF6+RNw98DjImJZiLmlIHc7om6XINfzMVvMf0LpG5IUo/kNrBV?=
 =?us-ascii?Q?xV/gGr+q+uCc4lZR+LSRf4sxkbcuVmk=3D?=
X-Exchange-RoutingPolicyChecked:
	jLdGHnFUoX3l0EpyzcgVahPAKKp6xKRiSLITh/tye5VHVlmUB6s58cswox45ReF9kQZorbLMfeyJXRrZxPCRj6mr43JB7Ee256Uitb+R34eVpotgBxYWO57w6JY4rYkd+VEC+2M1iMPV1jsvUFZeX5Spc7vLAWmYdfISLrfXn6Y8jDongYXO+1tqOlxd0SAwvwuQAl/5JbepbUvFGWnk7VJJFvtu3avJjeci5TwCMb7BMzULjMgI79NLyOOXPak3Cgonn73PNEW6iqwCGHykklDlAH1/Jrhb3co8GFAOMZ00yBj6r2E81/Y0FfcOJ79fnPZqo5PmGPblRFp8BCPDPA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	loLll0clJPhOYgT9HVe1XVkPJs2/e/rcSb5QQsSQcJg5ZOzvxgksnG6s8UidYovRKUq/V0mRl4imvFKFPnE1V0UQfjNDLl/5eThBusOsrgTzeJ/lV05eJw7i6VQSpmRihSl0UNT5sTpnupJ45iCGkx+qGseFWrQg+wtXumBG0hC01Gxc4tIuOToof2yFgdLtXzZGu9IFmoC/YNsOhAARJU0Q+i7FB4HZUvwGJY5Ui1/RWeUQff2n5RZn/BFqJtWGnytkuHb+OGzvnZ4F5BPZeIjkC0DAyo42FPMDVZHsq4A43Vid/wWBim/8RJJl+RaGEiVHTzTnxgf1SHTxBWLEWgyX1GfJ37tN7a5AqPcyAnLlmYcAecAXpRQ62jkic2qgTh+QzfF1h6UVZ5A8SYd/uAhP3dfOtfYVWgk18xXKeS2FaJWv2uoi7r2bZrkK4ri3n4SuQHb+VlWNsufbrZ28Kcs5dfHFuopU5Qiuh4kvzseuskc9u+VUeivuOHIYxUFx6914CBm5bSJAhNCx9x7ecwQ3H6Hjl/+arFqj0bsnWHx2glv5lAc9Ri2jJO2Zk2v8a7PR5d5qY3rNxP1xqhW1TUkvOWf8ahCz4FR6hv3wziQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8db14ad-2dc1-47ca-61f5-08df446b5992
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 05:26:36.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSRe4EYgyl6aQQfdrwyjyjptWBYLhO221eooBIc6zk2oCDGd1nw4tGtDym1agxTf2kpsi1EbtQ5pHsWlimWYZk3xqozCjzWogpPqGY3VKGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170021
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyMSBTYWx0ZWRfXy5HxlKkF2NCt
 Rj04gn+/ClFPdQeNEQWSOXFO+YaTPvNW1cbUxggdXiseFMrQXaKcRLQzlVXEFy2rg1tbXZaF7x8
 +6w06bhNaFhiH4q9x82h4L4HgcM2gBUo8Xzv4c+UFizRoVt07+zRwelaLeXD/nqAtIoOmxWzTAG
 JlnK/skCxqOJelMijfwAR4Zr61dPCblC015H3WcWT3/H4ZOPEGpiS4oyTPm5BuV9spD62E+9Pe1
 oOBqwx12TOzz4L4d9RhhER5cN1nz67WCJ2KkipPMLzqznW1MENs+0uNc9WFlPft85hVLFt8FLu9
 fH62cFqlrVUV3AVU9CE5MatC5XoQk4HUSS+BKPRQT45euXwrR5DH/RRnYsAgFy6Tsd0BQVXaIer
 WVe4dgOUz2q0x1Ku0T2ktvtGty+QZID+Hf164i2JAaGLMdUWfPgVq+AeJBD2uaIuJbbdoUt1smT
 qfs3c03CgdFhUJJeyJg==
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6afbe591 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-M87PEicVO11dq7NBX8A:9
X-Proofpoint-GUID: ae9m3e7K6-HxzLGaT34Sl0ez7slHgxZT
X-Proofpoint-ORIG-GUID: ae9m3e7K6-HxzLGaT34Sl0ez7slHgxZT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyMSBTYWx0ZWRfX5XaAYiGNvDwd
 NHFC/SiNy8X0quTNGEPKRRzVFPxoEa2C5S6MdiFWc0z2yTCrsAyYFlcA3rvqf17yvXKhJa2sFyw
 5x9ivcrvNrpy+FZlPJrLexzwHaCWgeb7X5OU64/IPYlbb+/ZiWav


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] kunit: barrier: expiry_skip_test() skips invalid timeouts on
>   arm64 WFXT
> --
>
> commit b346a6c0c892c3f1d3df9f9238d93e9e4a6dba04
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
>
> This commit adds KUnit parameterized tests to verify how
> smp_cond_load_relaxed_timeout() handles invalid, out-of-range, and edge-case
> timeout values using a synthetic clock.
>
>> diff --git a/lib/tests/barrier_timeout_kunit.c b/lib/tests/barrier_timeout_kunit.c
>> index 63d82f05ca596..b6cdecf295747 100644
>> --- a/lib/tests/barrier_timeout_kunit.c
>> +++ b/lib/tests/barrier_timeout_kunit.c
>
> [ ... ]
>
>> @@ -113,8 +115,118 @@ static void test_smp_cond_timeout(struct kunit *test)
>>  		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
>>  }
>>
>> +static s64 synthetic_clock(struct clock_state *clk)
>> +{
>> +	clk->end_time += clk->extra;
>> +	clk->niters++;
>> +
>> +	return clk->end_time;
>> +}
>> +
>> +struct smp_cond_expiry_params {
>> +	char	*desc;
>> +	u64	timeout_ns;
>> +	s64	clk_unit;
>> +	s64	miniters;
>> +	s64	maxiters;
>> +};
>> +
>> +static const struct smp_cond_expiry_params expiry_params_list[] = {
>> +	/* timeout_ns is invalid/out-of-range */
>> +	{ .clk_unit = 0, .timeout_ns = -1LL,	.miniters = -1, .maxiters = 0, .desc = "invalid (-1LL)", },
>> +	{ .clk_unit = 0, .timeout_ns = ~0ULL,	.miniters = -1, .maxiters = 0, .desc = "invalid (~0ULL)", },
>> +	{ .clk_unit = 0, .timeout_ns = S64_MAX+1ULL, .miniters = -1, .maxiters = 0, .desc = "out-of-range (S64_MAX+1)", },
>> +	{ .clk_unit = 0, .timeout_ns = U64_MAX,	.miniters = -1, .maxiters = 0, .desc = "out-of-range (U64_MAX)", },
>> +	{ .clk_unit = 0, .timeout_ns = 0,	.miniters = -1, .maxiters = 1, .desc = "degenerate (0)",    },
>> +
>> +	/* timeout_ns is valid */
>> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = 1,		    .miniters = 1,	      .maxiters = -1, .desc = "1",    },
>> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 30), .miniters = 1 << (30-28), .maxiters = -1, .desc = "1<<30",   },
>> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = S32_MAX,	    .miniters = 1 << (31-28), .maxiters = -1, .desc = "S32_MAX", },
>> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = U32_MAX,	    .miniters = 1 << (32-28), .maxiters = -1, .desc = "U32_MAX", },
>> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 33), .miniters = 1 << (33-28), .maxiters = -1, .desc = "1<<33",   },
>> +};
>
> [ ... ]
>
>> +static char *expiry_skip_test(const struct smp_cond_expiry_params *p)
>> +{
>> +#ifdef CONFIG_ARM64
>> +
>> +	/*
>> +	 * WFXT waits for the full p->timeout_ns so limit it to a reasonable
>> +	 * duration.
>> +	 */
>> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT) &&
>> +	    p->timeout_ns >= NSEC_PER_SEC) {
>> +
>> +		return "runtime duration too long";
>> +	}
>> +#endif
>> +	return NULL;
>> +}
>
> [Severity: Low]
> Does expiry_skip_test() skip the invalid and out-of-range test cases on
> arm64 systems with ARM64_HAS_WFXT?
>
> Because p->timeout_ns is a u64, values such as -1LL, ~0ULL, S64_MAX+1ULL,
> and U64_MAX all compare >= NSEC_PER_SEC in an unsigned comparison, even
> though smp_cond_load_relaxed_timeout() casts timeout_ns to s64 and returns
> immediately without entering the WFXT wait loop.  Casting p->timeout_ns to
> s64 here (or checking p->maxiters != 0) would keep coverage for those test
> cases on WFXT-capable hardware.

There's no clean way to test with synthetic timeouts with WFET: unlike when
running with WFE, it waits for the specified duration.

In any case, the loss is not great: we test with WFET for small timeout values.
And, a fairly similar path is taken when the test runs with WFE.

--
ankur
