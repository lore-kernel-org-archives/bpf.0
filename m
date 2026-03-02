Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85F2D063E
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468288; cv=fail; b=SGhw39XKidsf868pX4FSgi/APBpSOmzf89rWFedhPt3MpO6LPUn70KhhiNxEExZpAvNZNelLK/J+fhMA4h9sSVFx2B8Qgxfxd8G/lVQ3CzzZU8ELWTg+blGf6sBUT4dk4NMFj1swKul2TrfDp2lAxHztmDRtm5kJdL29WCwIX98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468288; c=relaxed/simple;
	bh=7msflbgtQ/F/8om0nJBDodFIQs1ljpLHmRUnS4iHg4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+mKcUbo1YoFbahLIcQuM4GkSWxhVGB7IitdgdE+J90ADGmWRo7lyPDx+v/bPcCYOjJw1xV81wpmcTQqYjdgTKKnTsLiHr4AbTb40vpf6klJWU16XyqIFk+SurQQ3fa0M8DWCLW2Z1vh02/rXcIAFXzOUjt+PQUVUGfTzV+IQus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m7hJBM39; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fDPCNNle; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m7hJBM39";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fDPCNNle"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EQvLw1327157
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 16:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=laa1mwKjYwKLMfM/as0fd0Lt5S3J7hbjCtCqk4SFU0Y=; b=
	m7hJBM39iZROKiGe2u9A6XsJVVlxcaTMF+0aXA0ud4h63LYGzghUh28ux8eRn1T2
	+Ho7WC5c9SvaFNnZA9rMyvBGNe1+AYOD4nB0psPstYGmHfj4mwocReGSMky7sBwM
	g1TTztssOxpzyoebWvpBGX1ARcNVOfg5RgzVmiS1vE+sFobk78EDMGc9GpBuFVUC
	sfFRe8D4/eAlnxgLYA7OmJmZn343UFsIUxJpGlF6T+4LYnpjuz+zwXPs7f6c3LwO
	1m/CjIDYF63k26HCZChPk2Y1r6Lrefwhu35KqVAXlTuAzYRTsznORxDI+pqf0Wxj
	W4TnjkUHzH7a7v5VvRkKyg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnbw308w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 16:18:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622FG6bZ023038
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 16:18:05 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptde7g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 16:18:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXHE1JshpMBrJvJq1qnNEYy7LFpwcnOyUzTsZP+PABvwqFuqat0uPQ5Kxu3FinPlnKURzgCBq2obE8z5p5egZyGmzlc9KIWeY9kdVWS8n1UGIzGIfCfyE97I6MqcUsT+5FgDhdogrOS0Ue7Ec4iG6bpIk+4DnNm4/bc+rfDveixHTFyQI9q8kN9kkOZkWBQ71vn6hHriFePu/WXfp2EPBxuTV+LAvsTIHS9WR7q6Iq2G+6am06zHo7H1MubgHp2s5D+uQsVbHCXpO5x6vvBD21f83jWVuTrGJyxY79Qy7P/j0vo/3mkcdGd0UpFUH9cyxJ8RVzmJSUjpjrrxaKczsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laa1mwKjYwKLMfM/as0fd0Lt5S3J7hbjCtCqk4SFU0Y=;
 b=qgD6IqeYF4iesb6nKXX3ij1z381n6ME1h1esiI0iaYaSkeNxdttjf5CQURFCMgEISgt5UT2Kf0wdH67WXi4U7NzAyXz8jdqHYCVB1BiUSQQNHYomU3lenkIoo46n19Mm6CanMWzO0pPik2/+lMymz0ftoqVHv9I/O0KYURRimFKcVewInnjdTAnjmlWA7fRwvGZ+F2KvM7S0o5MsM5c9EcGe4v3e/RFFZzTY/UyOB4iXK5FI3d0oKYjiO7AD/P+v3xdxQYDSu+sxdDepNiXZPjigaBSiQHDPjUpLPRbH+DuIU+kZPJYUQkiXp1h+2Eh9j6LZGy1NE1YgXCfmqDzKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laa1mwKjYwKLMfM/as0fd0Lt5S3J7hbjCtCqk4SFU0Y=;
 b=fDPCNNle8nhcoJvo8pdKt9JuFM+PJqfDgrP/ZM++1j0QXvSNKpKiKCzeiFVIH8WZc7pIJvOONQ4IUYINvk+CceoF++WD8ibw6AZ4jK1jPE7qaA5l+vOeqHpPtMf0jgQO0lxJVt4V59CDbwdp0UAsYwHO4YHbQSQ7sgIKtSLJg1k=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CY5PR10MB6213.namprd10.prod.outlook.com (2603:10b6:930:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Mon, 2 Mar
 2026 16:18:01 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:18:01 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH 2/2] selftests/bpf: tests to non_null ptr detection using register operand in JEQ/JNE
Date: Mon,  2 Mar 2026 16:17:36 +0000
Message-Id: <20260302161736.156685-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260302161736.156685-1-cupertino.miranda@oracle.com>
References: <20260302161736.156685-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CY5PR10MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adf093c-f611-4dc5-120b-08de78774653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	y/r61oI25dwYt9LSEhWTgWUJcaIz4jy1uVqQh4ai6NuvJyETmxzizLZfG3htNaDyto+fKxj5uRhhex7M8Zt04WSmgpP0PKHdhqvZmWL9Rk89jBnRR6DMj4Y88sBGYxRHL1RYcTi8erVCoJkS6jQX5t9Z7x6gO95mpzfkIExVQTKT2/07PsbvTr7gWWY+ZIxyzi7/5rxHbm5AqQTnVdxelpKo/xhZfJ0xfYpA1RsGI0MKp5uuYUnhEfNmVltDX1N0PohMczSzDh9ch29bNhSClfu2viXJPOGUOx1VsXQpOicRqwWJbxED1RJtPNR3dk+HZw1svrF3ZdwdO6kDstPcASVlSSM9nr9fhg1ecRF1dMcEBreDjaO16OB+F6X3C7UBaeLaVEL0odN5tKJHF9shr/i1eL4bmmsktr1uJ5MQdVpjQMJOSW0x7c04DG6aW+ho47pi3lKRRvI1wC0qWDtqBIOK8uFcEzOFP9+OP4rlexM5G02XwtU72GJJop7ISmZxq3i8vUgD0pRGSyQ3Wwn0npp/g8TFbC2IfiPxRTed86Bta2pxWVd1dAxa59nI1eOu0SFdgh+ddc5f2nv3YTnfprRLdrKoZ5NuOgX+Z7XqNGccCSoD5Y28tDhvkTrJlYUUgfyVTRzujYuLZa0gljW6P5GYfClu09I4cELZl7xvsJ+TjcOsTWbNvc2nF7oCkLrjqQ9d5lVhBS2w1J6LY77RgqkC5hgd4C8FQTOZu5LmbiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6lvPJ0K86wnNgHcQRM7Ygzu9s1IuEXnHrHVG5fwr0xe1Q6tnR0jX4pAwAVR?=
 =?us-ascii?Q?sNIqFRw1tpn112gDAgKtQXcRvgDFS8J0/yoWfTPoU0Ext2czrbsq1U17ixW8?=
 =?us-ascii?Q?zYXHbV21NLVt2o13x1H+sXWtXib0wLvkV+qOAA8aiR25Ss6a2xJe2sPjtyPU?=
 =?us-ascii?Q?SIMuF3VYSRHQkCufT+bfAAGsbsFDKIunKE5GnV8VMU87z614oc5pUdctNcrd?=
 =?us-ascii?Q?X8q7+5hsCBeGhqj7+bmW1amREd96+NRiYQ13a30yE9iBO6aMpkgsozxiloIc?=
 =?us-ascii?Q?h5bhJzkRvmtpBwXa6h1p2PxpUTb54Ljt41WZI221xk7GD3/sDLOLzi931Lcy?=
 =?us-ascii?Q?/s+U1Gzj6Qx9ApnlEuvdoigH80O0C5Vfss/hxYZQLOsUoyIL7dBn9b0DVMjc?=
 =?us-ascii?Q?AzODLBSnKN16+Eq5ul3ei3qrG792xQaApEsESg3LZVm82kRSJTBB+SR7M0JC?=
 =?us-ascii?Q?w9JtYnrkwg4UV0C3f69M5ClYpOsWkW88Bw1y/J83gZ7tu5kLFtF3OKuPUVf2?=
 =?us-ascii?Q?5NKF+4J3rHFxfvnENKOBvxj8AvZORvlznhnEzg6TAuB88lNvG4aWTNogBTnF?=
 =?us-ascii?Q?YYNCOsIlTc0DTGImKADGsXLhXT9HQc7Igi/EclcAF5OKxJWbvay6aQuaUWIJ?=
 =?us-ascii?Q?iGSpvJYgofiarMpc3l8ePa58DHqo50FKpXtP9A6yRM3WImu23rpsObl/TQKx?=
 =?us-ascii?Q?An+YBx+2qF6hIdE4d4Szp5amk9vC4ine22Zk1OdoiRIAcDUNgZmbpdWw4rlX?=
 =?us-ascii?Q?+CJrMPe64x162OrBcu5R/HY2PR+dJXT+tMLRlg8pmTYDINejbQqD39dTrttK?=
 =?us-ascii?Q?dNdjTTWuHqFt+W9+cJ9uT/AF4tu7gTxedEw/QO10vN/bnFDgh8g5xaWtYCCS?=
 =?us-ascii?Q?hZD/6AaGmhZfRyOUWnrq3fwvcztZ1FM7c9MKpoFFRAASiEtvQIrJwynSOxP9?=
 =?us-ascii?Q?WCqwPr44cdTCwsPHuGA+BqZY9okBrAdsTHEtXN/IA5oRk2Ae+GRJTde0OwwW?=
 =?us-ascii?Q?YV71wDVFKmWUnbtkTs2fRcU6vPqmtr4SeoQ0g6krbPwGd2I4/8wWJhg1SAFl?=
 =?us-ascii?Q?nKELPX5CFBbC74YALaQG/GWxdbXwVqgnavibsH5vynSEQmfNskewLUP28Pn3?=
 =?us-ascii?Q?O/aOaNemT2yUdNM86pup+kwOTxTY47ew4E0YoKNHDX3IQ5RyEfu7/HCwW7Rs?=
 =?us-ascii?Q?cunvuN8eVmMgVOFWYLO8D1qTB0KjmRDda0prBj309jm3pZ+GyJZoNyk45T+0?=
 =?us-ascii?Q?IziNB4DLzi8xhSaxdfXDd8dxILcRMb9cvScOiFKUkg0WtrCEfJIi/7Xapwcv?=
 =?us-ascii?Q?FyodVmvWFai4DUHpcci/H6Jv5KSxjRPPTJUcEw1O4gR0Gx8QjwYogYQvGkZk?=
 =?us-ascii?Q?qoTFVSA6J7eS3jctN/lcOWLK9b1F86ai1fAyKkXb8gfHjXt3y7svCWAsMdgN?=
 =?us-ascii?Q?GS8k+1KzO8qCD9A3N+2BB3JnLa7ugzNQ9vOhbMaVILau6llLZ812PNEqrqUr?=
 =?us-ascii?Q?YlWCxWJdywDlU1pAWybRjP9g43mPOoTrlbHGadbkKzsRBeErPgWbgCU19HHI?=
 =?us-ascii?Q?6d2gBl4BLbydtxIZ6RqZyhqH+OCQjp0e2IYcDuticsrLkLKgkPl4VYednphj?=
 =?us-ascii?Q?5vp8lNZyMLrSn5aEXw2OPF+NOiszJhlOx/DfyFByJMQ1ZsKln/CNalMCkK1i?=
 =?us-ascii?Q?mWnnCmij8UuDjjZyNTMsaW6vUWO3Vro8uvo58YcYiMh3mSTnC42vIhqY8rvb?=
 =?us-ascii?Q?i7EkWXQFOxL9Ay/Mo7Rtm8siMODCd/g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lf2L+CmX7oONlPQOnoLwoDaorlD6j37os4PlZeNST4fGA6UF4X0DuunesVThLx/z9UskokjAZvSVEcOfJvDHvEDLM91rg0MZTps7Sjk+AhcL0byRqd+ivp0lgVyvScGvHGwjkRWxwUaWuAeQsAUzJ5d1KuvH7slQgxAQ3yLmf4F8pbOIn83QyG9fKtmOnWP+nO9k8d7Un4WDRtnwxHd5z3CUH+nGzTqr2CUCx3AC8rUHdon9v/CWXtWYluEYuDrB69qX5GN955rgCHoRtOrfb4aH1GRkrx6jGkE05L/eyNKXDWi4bswqREXhzGQQXfjt/5OONXYsljX9rCrXqaGnGo/Y6K5ODLpHPSmO538KYNZhJPAiWc4jVnKHN60FH/t7WnBSxAeA1JsELoT8QIrTt8zXPNFbgG8v+oIUK2gbIguvx+XcQaWjbMKa2sQ7lIk/wTPn/RfvkyTKzZnjgw5X9LKCyp9Ml6jhXLw6x35B3fIDyLAMEfeXMXrqHhreLZtu62ZCreJjYQNNhMr3VLzPRyu3mLhbyoPHVTJX5Wq9K8kPAUyNxuc1g1GfjsUXNfprVRNmpz9zXdw9RhdB6EqrPPAq5iK5BVV48t8/TLj3cCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adf093c-f611-4dc5-120b-08de78774653
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:18:01.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5pdy5MOHaLoCFDv1z6ABaiJzN05xjhKcFkvzb+l5Nkq5kJgo5dgdX4NK3shyaYVDhfoP3qbwBqae8cMhmdrHHpTrXrD2EfnzJEHnkcCBys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzNSBTYWx0ZWRfX10K0sZdAIked
 5KoT+EJ9ZD7w/4S8/jWi0auzLjqWENy7EseFvZ3JIHO68XqvMny3Ox9XhImwiQ2pxZRbn+rKA5T
 bHYWHc/Jy3cTqCYc9x7fgQ5PFRfY+HkH6eFzjUPsmQQcQJBEHlyRCbWfeVFlhTI6jzlQoIagK6h
 stwF48km+rWgofMy4MZgEkb/b61GL/PGEwLkRbX6Yvl+bEsvh4eHJUAlOwphTpLFhlTbHK0x3t0
 4ny+fTM2ByRKTecs0Q1ogoGjel7ZENqNUNY8rZV+H55bGPxZxk9D+jMgVp07FjqnADHn5Dy91j9
 IYg0CPpzRi00b3duBCnZcB1wuLBoX8aZCwa2aV4R5j7vSw+t4ya1x0Rm1b7GjN2fkMj8acdcrnO
 52ayljxlGALy06sQ79Kbh2RV0tahn+L3mqvDp8xee3eX9R+g/Kk7nNx+ckmLpvfnMDJoRSinP2p
 FtljKzS1O6YtWnawSSrxA/iW8kuWEtLl2wRwrGFA=
X-Proofpoint-GUID: 56qh1Aeqo9vNSORG9LTcWZ5wlwsBc4-k
X-Proofpoint-ORIG-GUID: 56qh1Aeqo9vNSORG9LTcWZ5wlwsBc4-k
X-Authority-Analysis: v=2.4 cv=DcMaa/tW c=1 sm=1 tr=0 ts=69a5b83e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=uPfecO2ul2VNhPxu7BkA:9 cc=ntf
 awl=host:12262

The 5 added tests are copies of the already existing tests in the same
file, but changed to use R3 instead of an immediate 0.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
---
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 187 ++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index bf16b00502f2..6253d48566da 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -210,4 +210,191 @@ l0_%=:	/* return 0; */					\
 	: __clobber_all);
 }
 
+/* All the functions below do the same as above but compare with a register
+ * instead of the immediate 0.
+ */
+SEC("cgroup/skb")
+__description("jne/jeq with register infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JNE false branch")
+__success __failure_unpriv __msg_unpriv("R7 pointer comparison")
+__retval(0)
+__naked void socket_for_jne_false_branch_register(void)
+{
+	asm volatile ("					\
+	r3 = 0;						\
+	/* r6 = skb->sk; */				\
+	r6 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	/* if (r6 == r3) return 0; */			\
+	if r6 == r3 goto l0_%=;				\
+	/* r7 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	/* r0 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r3 = 0;						\
+	/* if (r0 == null) return 0; */			\
+	if r0 == r3 goto l0_%=;				\
+	/* if (r0 == r7) r0 = *(r7->type); */		\
+	if r0 != r7 goto l0_%=;		/* Use ! JNE ! */\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+l0_%=:	/* return 0 */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("jne/jeq with register infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JNE true branch")
+__failure __msg("R7 invalid mem access 'sock_or_null'")
+__failure_unpriv __msg_unpriv("R7 pointer comparison")
+__naked void unchanged_for_jne_true_branch_register(void)
+{
+	asm volatile ("					\
+	r3 = 0;						\
+	/* r6 = skb->sk */				\
+	r6 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	/* if (r6 == r3) return 0; */			\
+	if r6 == r3 goto l0_%=;				\
+	/* r7 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	/* r0 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	/* if (r0 == null) return 0; */			\
+	if r0 != 0 goto l0_%=;				\
+	/* if (r0 == r7) return 0; */			\
+	if r0 != r7 goto l1_%=;		/* Use ! JNE ! */\
+	goto l0_%=;					\
+l1_%=:	/* r0 = *(r7->type); */				\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+l0_%=:	/* return 0 */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("jne/jeq with register infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JEQ true branch")
+__success __failure_unpriv __msg_unpriv("R7 pointer comparison")
+__retval(0)
+__naked void socket_for_jeq_true_branch_register(void)
+{
+	asm volatile ("					\
+	/* r6 = skb->sk; */				\
+	r6 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	/* if (r6 == null) return 0; */			\
+	if r6 == 0 goto l0_%=;				\
+	/* r7 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	/* r0 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r3 = 0;						\
+	/* if (r0 == r3) return 0; */			\
+	if r0 == r3 goto l0_%=;				\
+	/* if (r0 != r7) return 0; */			\
+	if r0 == r7 goto l1_%=;		/* Use ! JEQ ! */\
+	goto l0_%=;					\
+l1_%=:	/* r0 = *(r7->type); */				\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+l0_%=:	/* return 0; */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("jne/jeq with register infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JEQ false branch")
+__failure __msg("R7 invalid mem access 'sock_or_null'")
+__failure_unpriv __msg_unpriv("R7 pointer comparison")
+__naked void unchanged_for_jeq_false_branch_register(void)
+{
+	asm volatile ("					\
+	r3 = 0;						\
+	/* r6 = skb->sk; */				\
+	r6 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	/* if (r6 == r3) return 0; */			\
+	r3 = 0;						\
+	if r6 == r3 goto l0_%=;				\
+	/* r7 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	/* r0 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r3 = 0;						\
+	/* if (r0 == r3) return 0; */			\
+	r3 = 0;						\
+	if r0 == r3 goto l0_%=;				\
+	/* if (r0 != r7) r0 = *(r7->type); */		\
+	if r0 == r7 goto l0_%=;		/* Use ! JEQ ! */\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+l0_%=:	/* return 0; */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("jne/jeq with register infer not null, PTR_TO_MAP_VALUE_OR_NULL -> PTR_TO_MAP_VALUE")
+__success __retval(0)
+__naked void null_ptr_to_map_value_register(void)
+{
+	asm volatile ("					\
+	/* r9 = &some stack to use as key */		\
+	r1 = 0;						\
+	*(u32*)(r10 - 8) = r1;				\
+	r9 = r10;					\
+	r9 += -8;					\
+	/* r8 = process local map */			\
+	r8 = %[map_xskmap] ll;				\
+	/* r6 = map_lookup_elem(r8, r9); */		\
+	r1 = r8;					\
+	r2 = r9;					\
+	call %[bpf_map_lookup_elem];			\
+	r6 = r0;					\
+	/* r7 = map_lookup_elem(r8, r9); */		\
+	r1 = r8;					\
+	r2 = r9;					\
+	call %[bpf_map_lookup_elem];			\
+	r3 = 0;						\
+	r7 = r0;					\
+	/* if (r6 == r3) return 0; */			\
+	if r6 == r3 goto l0_%=;				\
+	/* if (r6 != r7) return 0; */			\
+	if r6 != r7 goto l0_%=;				\
+	/* read *r7; */					\
+	r0 = *(u32*)(r7 + %[bpf_xdp_sock_queue_id]);	\
+l0_%=:	/* return 0; */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_xskmap),
+	  __imm_const(bpf_xdp_sock_queue_id, offsetof(struct bpf_xdp_sock, queue_id))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3

