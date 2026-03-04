Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E80288514
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653861; cv=fail; b=UG/385FyV7jnI+0R9mXIPi30XCDT3MyKq36bkTot00lYZG4s13zunUW5KF5vQOjK8tlOLpTAVBYTkvFgFMbZPAwWU6KVur8aLHVcs9rUyFKQ3MSrTkX1bFIJUS9FnAhW9r6H/02AkqZvujs9JV2eJ29dsNQ4a6W1eDKx764Bx2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653861; c=relaxed/simple;
	bh=jfFoMHW0XJrkHhD2qi7iZjzWduNvbYW/paTIKA9975g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7WuRtStRiOajjP5iWcU2CUkFqK692mAB0im7WUd7gauDqaOyxTgymtrPX2KQT7Z27AIINqF59bQjKO1At7co44aktud0PaPdXVqNyeP+SyMaLlZpDj6XpcIackCJ8yTLCB9Zy31BLn3F9E3Fu0EVwVYVGfEQCqbDxWtiakLkSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZGHRfZgP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KgI796ev; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZGHRfZgP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KgI796ev"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624JNF3U3503998;
	Wed, 4 Mar 2026 19:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jhu2h9E0WrtS2KCKCcj2Wwi3/l3SfrrbFTg1GWaAGgc=; b=
	ZGHRfZgPkiSEKoXggkxDE+zAxymA4IdUzyZz6jQoIxZ03mmfn8bOIas3pCYGWrSk
	jlMj/85SNauGTnFZzN0VmwzN52LgdoKXJdVLwAX/a7RSQqrZOp4KI9gdt6qp9ceG
	BWTP7KGZ4r8f6tQNw2kyn4aEFNZL7k8ucZ5qAPP/umMzJ30VaaGyuFIKmoNoNLJd
	5kVOOLpz9P5IrKpUb1VSh+ENIdFAH0eJMHMFHvbGo6jlj35x1NcKJriLgGT6dZAA
	7KKiPVdgL9/s6zQTH3M74h56qYBQ5Du+pYw7jrPB5B06WCu81ayq1b7mEgZOEqi1
	cNK3P1bNTigv89i0yuslyQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cptunr1hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:50:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624JloHO029986;
	Wed, 4 Mar 2026 19:50:57 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptc85aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhtC2LQaOdAJi1YbTFCDbuFyxulkxetqRi19UnbJalsitahQdxemCl5oq+IbmFiPxZVAyNHhe1FDg+nCtR6fVRdKn1Ckj4/7VHk7vJFgUI5SKIBSe+xFjCnNjbtXP1TwnbgbxH82aZpNkXB79wdcrn2NN+lVE0DWPcJtkm+c6TduveMvH4PmKdbEc0CeSMQyZA3zjYelwsTY5USkb1QkLHobEuqY0e4e8hLLCFQFnZud33KXxTdNCsgkv22dWq26Kfd/fmFC0T3aw/dL4NpK47FbYUGvGj6yLC/65LaV0MhFVcaCOj2c8ubDbgLS0IAZ4xY8mVs3h5+Hq24kbp1Ekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhu2h9E0WrtS2KCKCcj2Wwi3/l3SfrrbFTg1GWaAGgc=;
 b=GJaKYcpWQHwpkHTlbYKI3CLMFdD9luxn61itX4BNmTQKWz4eULwB4y+YnaMFJWlmQ24WWLAbyR+zH339D/k4LQn+vr/rgjf13BpFueen+5LW2Zmp7TAUjxeIqSr8fWq7OLa5eM0kWZ6GyjH3/sDUuP7KkSBOngYiRoRgrvb1wEZ0c2d3b/t2aYeL/ZDaDlcsvyiufW8A+ce1E/MkmhBdLozfeIiDz5N2hgra1fIWOyvwm5Chlg5ljkppI8vxJA/E8y4t6oxPdiL38caiPig0pzsP06mgJh93GwhMciUavDV9b/IleQpjW/eQyvD5u19WV2evBxdcgIaXWPhIaWPmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhu2h9E0WrtS2KCKCcj2Wwi3/l3SfrrbFTg1GWaAGgc=;
 b=KgI796evlCFUd7KjLiFUToSsQAt25o8zBW4uJ69YUalSlJL8oXDc3K/eq4gvivmvql/lwybve5Pf4YpYulSzB/EvOyolv1/u0USyx2I07T2EANPND29LA+8eQKj8708TbspGSnq4G+K+ZSJd3R+BhFhgWtJHKqeSN5hHEMEBlA4=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM3PR10MB7969.namprd10.prod.outlook.com (2603:10b6:0:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 19:50:54 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 19:50:54 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v4 2/2] selftests/bpf: tests to non_null ptr detection using register operand in JEQ/JNE
Date: Wed,  4 Mar 2026 19:50:18 +0000
Message-Id: <20260304195018.181396-4-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260304195018.181396-1-cupertino.miranda@oracle.com>
References: <20260304195018.181396-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM3PR10MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 841585e4-7233-4d52-4a69-08de7a275844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	cyZt09/OfhHyAMhvQa+kdx8PdJtVX5Iu96gXNVEZyD8o9PE/HsHZSGJgCxJF/odFDnKwSHdzn84X4deU2/fmGCJ8WPrLoIfD+shfu882Ph5FWekJS+3f3gUO+Khk4DRD3oba2T3FGuJ4xQqT5XTsIc6ut76yKIMphAZtI+bPv/m9pTEjggElaA809R+XCvBhU9qc1Cqe4IYAoTL+9jYoMhj7K7tMz6iTEgW7dtVHK2N42gDB2LCzApknn7K2FTwh7kimecKAKsnANx3H0IbHXpXNs4OpdpunDriBa+pT5JdfNT4QQjMI6TLnpCZi0Uj36D8foTCurIEYzDo6KioG5z97NFsMQzxsVroBgRqL0BNUrQ2/2DZyGHcw/V34BgX+pik+V+W0AaT608K3/n1lU67GgRBVoQDykuMVEtHWL5PtPUgBhkn1IcNkoogreKNShZDvqXFBqgzJfk7dDTuDiRp7VKdGsQ7jYtFkkYFjp0TDLno3iJAxGNT9zc75xXwW8ffT7QH003CLAZ9CWzkNotsPUinxEBGncP18Mn9o8HQs4+b7rVnfLrAWGY027cbABUUw9388OozK4N8X/rYah+JnhhtbfDEnJ79VspPwfYQaaw5z8RgTQWtqunf1bhR8dZlZOD4xSVnkybmVNSIPCsGLKueN5ckHz3cKkTcTEECNqTBqVIkQsg8fumIg3J0Tm4x8RtjsQWwXDvvL+gNDDwN0qM06QS4hg+DZx45iIow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufXYoBysOkIX/tKMjn0pcs9ktRpgVBOkkvqch3wSFDlFOMZxaD50HngU2DVp?=
 =?us-ascii?Q?WYVbLBctIedxOtS2sE4dDLIJqvV5w0dT30x3VtEH/2OPdmpYNT3T5QeRKs3T?=
 =?us-ascii?Q?9g02aovgw7v+8wSZuq/YMKsB/tqnsJ9fBe8Uzt91frn8XN28i+3c/2nm0Dfl?=
 =?us-ascii?Q?A8e3h3PS1tfm8gt5Q1Mg9gnkj6+O7Phqu+hT6nAgeKB52Vrm/3pKHrF9qukq?=
 =?us-ascii?Q?zzV52kiyYWBlSAjKfexpD/Nzt0Mf3/pRO5mZvZPoMoH4B6VUG8pkkS0aXOxe?=
 =?us-ascii?Q?VIa5koor6BOqKfXaZ7RJUSAayn8GChLjIpydsDAvpwFs/DMEGIWi7euCyACq?=
 =?us-ascii?Q?a7B5E8e63kqKXheX5yc/sOTj/q2SPf8EK/vU9iR4oQPzsz6svyAY6CcecZ7l?=
 =?us-ascii?Q?YEjZGzDfmtzjT2jb+7i8EuJa+QlqV3rOQlDTxRtoeNeiwwhDd+0NebsB0SVt?=
 =?us-ascii?Q?EfxDw5S5VmbfwNnbf0Vv0rFqYsbE++VTeM8j2sS16wOJ3u7yQGZB3Szel5Tz?=
 =?us-ascii?Q?b7Np1V81zZxbXw0jvvx3KmrrgAuv7ZfU3FXeVEurTwpUNrENcQAgG56+0F2T?=
 =?us-ascii?Q?wbfZZN7fOiv+uWEh8ZPQWyVHrFWSi92GTUC2MBLg8K4ms/OUgUKeWI7yryQk?=
 =?us-ascii?Q?trfRDJI3boTv0xaH8LDluu1wjPmbpVimmtUxuwZoOD+N4zfi3sKpNhZZCojy?=
 =?us-ascii?Q?hNiLfceVKTen7PphoFMIjpp3mFvjowSFoTbO7ioVGlARer2XkH29iK8XjYyL?=
 =?us-ascii?Q?zJZTXV5Lqc968bUFSq70S3FFYqjv/02Wb//d+9kH9X0iKrV/oYM/GUvmOGV0?=
 =?us-ascii?Q?AgX1nwfPH+uXyMnNhOK0W/eZv8rG/INf0uek7irz1NcPTKy9XQ684zTzqcms?=
 =?us-ascii?Q?4UMat374MFF84V7V/HFbV+tMCL6lj6bet6OxsYltEUqnWU9CWJ916DU5E8qR?=
 =?us-ascii?Q?6tUrVO8ugytvqu5K/KgAph7y7F/CJRLjy5Y95BFgY5a+dIK2mprgfavUSzeL?=
 =?us-ascii?Q?lwyiJn4iVKupfRcCFvE1NhLC+6RCf1kVi3DzTPyL0cUFW5jMkJ5lFO2FcIy9?=
 =?us-ascii?Q?JUqg0FB88MrJJMIed3BXBqWn3+SRfo++yczUuYTBfZjrgYQBH/MjFU0dbBv6?=
 =?us-ascii?Q?mlZP+nbJrUmuKPvsggWawMqbDmTe/jquOHAtkaYS3aDUQqaCLQ/S+dwBKIkm?=
 =?us-ascii?Q?ilWRK1N9fkpdXa7OOqlS2wtk3BJwtMCqo3Xkb3WkH1LnMlzmIpH8PflSAzM5?=
 =?us-ascii?Q?UtRejEhJthJ/ELD/LE681HU9VsESOTXzix5XMkY5DUoaDKlNuHpkvUiqJzO0?=
 =?us-ascii?Q?sLmxnKl52S6UH65NjuazyCxaVV1uCryGT5QJnsOM4BOmp3Sk+TnWBUWFgC4D?=
 =?us-ascii?Q?GJc6GU9Lj3cVhZI+HHoY58Cy7VzZ4FHFUWTfe2LP5yJ2rp6NyTY9fZ39l1Kj?=
 =?us-ascii?Q?OpcurhlTzloEDGs3CuxfzqV1ff3XWsK/C3K5xXt/MxqyzM0SS3ahSZrxGW5M?=
 =?us-ascii?Q?Ti0PqYhIVrLoqx5yOqJCjUJlpqMd0uTSU390M/YdjDwYHmy4slZi57KHPzVI?=
 =?us-ascii?Q?ZP1XDxXfLwdFV1YwEDVLZUGL59NC2K9HQoZUdnzjihSl7X6Pz5I2luOTJUXi?=
 =?us-ascii?Q?cT9u09uiXm3slORgEG5NwjsQNm8gtGflacnsapLcbbnilBjo86eUHK2CJs+H?=
 =?us-ascii?Q?kCvVw0TEFdj05OLvFz9fUP2HWTSW5O3bqcz1qRS4enAmyAlL5xHLbffAkvO3?=
 =?us-ascii?Q?tu3f2FXKMIGa4FFtuJq98VAsm9HY6Cg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EUcuG82ty9/0XKRJt2eQldKHFwip23EwB+hQdRP7bb/zVybJ5+v6oOV7rFwLcJwcaiQNwWw289VD/eZZqAypOKsFBVZFCyh/p+GltWjgtEREr1Whgv6LrurBewd2MKXoPROCHx3yqJMvD34AsIhtYrHI88T6ub/fa3ffF01+VhX0vVJHC8jGVtrbQjTJuObEkag1gF6HUl3Hh1Tk2Rd5xHkTQrInToFV0RIQ9NW3QQyn9+7A0KG+Q1+otbLbzuGPNxPNgZUXoLzH46ybLhTYw+fw6t3gvpKqe3Krci+KObrQpW5puseU/Mc6leIz0qvC11PMuOrpkrKJxTNSyzD5Yf/xDB48GD+pBNnd9g0N+5ta6Yrj0JHb9gJqGUy84qJ6G5XFvX24gQFwwLnm9TSSOruNWS2RTfUc1/ND3aYG7mbxytFHhSud9UhII/JMvY1Li1y7vcunUbDhbBNYbY2TEbcv2Gxd4ecBUfz8gWGiYzoZ1JBQZWEdv+d/1/sWDvAUMyzRo7g+4OLpOEGp4A+f55rkJrjwzA3UyMZn2gqfJS8QraOnTh7TBgn7NdZYFlX0pnMqw8sNvWeYcdMft8qkVtugpVsNzcwdYJa2JEZYAqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841585e4-7233-4d52-4a69-08de7a275844
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 19:50:54.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxLMaTL0xI5NsAgM3rD3XI1PQ9xXQKVETwOM6PB9hHrLcznEoqQYzNe1f/5Er5/DS//ePg1pGvEVN0Xb5np/i/o3qMyne62K6g/LmUMIBxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603040162
X-Proofpoint-GUID: sJ7OXAfWpTde_TfAA_GxO64LF1UFkTv3
X-Proofpoint-ORIG-GUID: sJ7OXAfWpTde_TfAA_GxO64LF1UFkTv3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MiBTYWx0ZWRfXyQ1I7JWTtG9b
 xSrJzhezEcmQBQSHMF00vol+skibcuEdZ/1eVyevmK8nRJF7eEkC37WqYmOB2jTzewUsljjtsVR
 UxgF2Mb89GngBxxh/ug3j1ldJJ9Xz7Gv/o0tPYPtE1+vIa5m7MsnGNvdjMOxKVJezTtjIIz8ijz
 5f1IR9sIPfwz01zQ/scTNu7r01Jrbz+eD1oxtk9CDenH9rRTeDyS7B4At0gXM3E3ASzYDdu4ZXx
 FCubx+ntSXOHfqqZAGoN580pMOYF7TjtwVsKvUMYMOWbgTegHX1BNPB6pUvCsBzKVQCcEvg6TQ4
 O/vluRR97N6C4P3kX3k22fZujXpjIinIcttJtZptg9LXah33/o/11tto7PQke19vfkH+Qu6bE6m
 NPwBqMh6mseCY2ojxmAar1rDh+up8H4IESyu928ieOeBR/qWkPcEMF8rYRWYUK2/rsGh4YJSIy7
 BMoSpabHLaXk4FHBE7g==
X-Authority-Analysis: v=2.4 cv=V6lwEOni c=1 sm=1 tr=0 ts=69a88d22 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=sH-hGKWHxpH7UWFcF14A:9

This patch adds two tests to check non_null ptr detection when using JEQ and JNE
have a register in second operand, and its value is known to be 0.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index bf16b00502f2..3d1e8de4390c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -210,4 +210,58 @@ l0_%=:	/* return 0; */					\
 	: __clobber_all);
 }
 
+/* Verified that we can detect the pointer as non_null when comparing with
+ * register with value 0. JEQ test case.
+ */
+SEC("xdp")
+__success __log_level(2)
+/* to make sure the branch is not falsely predicted*/
+__msg("r0 = *(u32 *)(r0 +0)")
+__msg("from 7 to 9")
+__naked void jeq_reg_reg_null_check(void)
+{
+        asm volatile ("                                 \
+        *(u32*)(r10 - 8) = 0;                           \
+        r1 = %[map_xskmap] ll;                          \
+        r2 = r10;                                       \
+        r2 += -8;                                       \
+        call %[bpf_map_lookup_elem];                    \
+        r1 = 0;                                         \
+        if r0 == r1 goto 1f;                            \
+        r0 = *(u32*)(r0 +0);                            \
+1:      r0 = 0;                                         \
+        exit;                                           \
+"       :
+        : __imm(bpf_map_lookup_elem),
+          __imm_addr(map_xskmap)
+        : __clobber_all);
+}
+
+/* Same as above but for JNE.
+ */
+SEC("xdp")
+__success __log_level(2)
+/* to make sure the branch is not falsely predicted*/
+__msg("r0 = *(u32 *)(r0 +0)")
+__msg("from 7 to 9")
+__naked void jne_reg_reg_null_check(void)
+{
+        asm volatile ("                                 \
+        *(u32*)(r10 - 8) = 0;                           \
+        r1 = %[map_xskmap] ll;                          \
+        r2 = r10;                                       \
+        r2 += -8;                                       \
+        call %[bpf_map_lookup_elem];                    \
+        r1 = 0;                                         \
+        if r0 != r1 goto 1f;                            \
+        goto 2f;                                        \
+1:      r0 = *(u32*)(r0 +0);                            \
+2:      r0 = 0;                                         \
+        exit;                                           \
+"       :
+        : __imm(bpf_map_lookup_elem),
+          __imm_addr(map_xskmap)
+        : __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3

