Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391971F4176
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649676; cv=fail; b=HFd12PWiyUJgu2LG8Rx7nbUIHdfDTHgtGprHzdcBN1uPFT7uurtShdFL2q6+PgDfE5nNLwf3NBo3PZh+N7kirSIA54X5kwIRi0wCeApFZNwEA2R4nwIJuwC0dd8MKbK7viF+s01aaOYVQmL+3fvXKvEQcSWJeQ33pMxr1JaL96s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649676; c=relaxed/simple;
	bh=bfyhAhNYh/M5kiN3t2QxRc6kZwlHERem/4ph/CJAOhE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H8OQ/S0YY1duOureCrxctcD+wnZzOAk1EAvnirM8iU66lYGYsLe/zkjMN5riSIUgDDBpRNBGglQo0423vqTNHyHkAbl48ukR1BxOMSbK+BYbyr0YZmcBhOPsLcF9EynSSm6MxkYRe+lFn5DNykpMOatHqMfEiR/H460PZTt+6Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gp6dnDva; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cHZ5XAXP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gp6dnDva";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cHZ5XAXP"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624I8D9l2915497
	for <bpf@vger.kernel.org>; Wed, 4 Mar 2026 18:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=DD9nnKon6avDEExh
	yipem+QATwXI0IhdkxW6o5ZLyac=; b=gp6dnDvatw5RFVLaNQV4dYdAxuhPFqKU
	mD8tEReb374yrSUbHNwPK04IKN8wAD5mXsKj0Nd5TVbe9gLJl0/gNlL+dXHls9Bc
	VwZSUn8x6OtKcZCz/e9vwvGO8gV/4cfLVhL06wf9/RbRWq3ZrPbeBJwkgQuzVY23
	+zr2V6YtiWDIbshD7xDW9bkiNREJJUZUfKM29ThUWwlMr+M1/5Hv+3N7wvm6bo+5
	FTXJsYor5FWAx9eFDpt20kyLfKSljod1Ak8rhESPLuH0S1m1mE7MFI0ZexUpafwf
	1wi69ho6XpkGTcg4Dvdl3LVs2jh4jF17KEKeUGYnmRiw3m5etWm56w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpsrfg1ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 18:41:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624H6qlT012659
	for <bpf@vger.kernel.org>; Wed, 4 Mar 2026 18:41:13 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptgfm35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 18:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ng0V7cE6/s1McsVG8PHsXTLe9qiohiTCP3TpFTcsxaXPJ52eBN2Q3jCkR13Pk+K2TC54VU6kWHanMOy/+xpAwIYlvXv5Sde3Dpro5T9i3RywS9PLd9RfD+sNqWcxlyk+vrdgdbhv/Ezn1yroOre50l4j9fvhMCoCS+D4RtoTvSI/E4M7oT7EUmtQerVDYnheJLRnGWOEnVGg188CzUh9i3eST4RVegPLbFAFd9Qduv4zsFEUU+p6bB1VNPD/2iP7uvbQ8EIrfyHc5nnktRCgqbkdN1R7HmlAJiMdkDK4ESLeaseFadDrGqFKLIrEMvCmgk4UNz6qcLmqsKLxYuo73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD9nnKon6avDEExhyipem+QATwXI0IhdkxW6o5ZLyac=;
 b=tzEb3Jv1PZ2Rz1t+f67SCVmpbfTLO6SudH8pSeen+FiVl5OfKwBhtWvxQ/qu5ieAv23CCaIQnBRwRDtdqomNgGy1oNTCzWABL6WEitIHzZcUlw8N662mSIcwoTcz23Q0alo8og6TPRswJr4z9ITxgggY6T6KNAkSy3kdfJ8LHZcCHv2S7+Z/e3EoLkTuqpz4pSG5heV2wSxv/0pbxwlGlTjebcko7HCwf1AQJZfzuIprl401N00vS7FjPdgyOLbofItg7gbcgUf6fTHV9nnsd7Nb6mnIfRDf7SS1t54HdxH8+ioxS+PArLTxdbq4zz1xlKGSX644KYHbTqhcXODnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD9nnKon6avDEExhyipem+QATwXI0IhdkxW6o5ZLyac=;
 b=cHZ5XAXPpAXKphWctyDhOp0NwPJxcuyd3n67SQkgTxQBdMy9l6Nd6Q0Fyjaf25e1B3yZSwc2RVN0PwFw/EDhZqKtOO1PVcirgudoRvOh97Dq5NWLkjTKY3R3lQtf/c2VKLt0nGcdefityk+UKq+ZZP61xESrPwhGiUJ2B3v44v8=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH7PR10MB5816.namprd10.prod.outlook.com (2603:10b6:510:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 18:41:07 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 18:41:07 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH v3 0/2] bpf: support for non_null ptr detection with JEQ/JNE with register operand
Date: Wed,  4 Mar 2026 18:40:56 +0000
Message-Id: <20260304184058.180310-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::7) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH7PR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fead72d-c909-4a8b-b9dd-08de7a1d98bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	dfByM9IfaV1PrDfcFUod5c0ICxINgnez5UHYAWBiDTxm9/KPc7q5L+uJvPW0U+iUik3c5L7bYR6BMO2bCZLOVgSPhv7kjlXrgDRksVPPhvUDPrIcGD/daFHcrLjOpsz7wDK95GvV6QgAAQYnZoHFrSSEtZYXkR7Obu7Ip4B5TGzU65JhqUn3pnvSISBvCTJ1LUlLep+L4B6zAj72qk+ETRMDItZmFvmtokRDbS0Sor8dCeE2EQMkwmiM5cL9Ja1BRrmJH9cv5s+G/9Dj5nOzWcLOvGkq1L3c5QXXEbH8MQ7GVFguGRbemNoWeuZKwDIbOe3TJjmN5kRo3Rkt9D+3I4FjJK4gbyIbvdU0GAIXJOVhMCnaU6WTTDgEn1rlVGlmd9xWqrXCn4iCb7oHhff268j/BpXy+c4GxiSPtg0qN0TIy/9iiL0KIGYSSafXu1pkMqcEXPUn3jhS4Hp+nnxDLPRLFrVCztgedenHZVNlNX5n73K/sjdCQMb1esKBqA1Xdu2DNaQof4BxF8qHVaoOq0hfwCPcK+qHpw4POLx0O+85HYNJTJfwPJZqsE8j9LCOuVGF2hX+R+iSAhrCCrpYEU/OdEdr7husq5H3jfzmP7bCTV1q36xWV33gBhpAIpw2OczNppNaDkI5uEN2YFio8onayAA47/UqRETgGVvucTgt6avlVcqILP9cnxznos0u4/7G2tKbbUE0DOL0yhYIunABrBCz1Xgu6WiP4U4QXrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eXLyTlCp1FyeSK1izl01dSWBP3qYTOyAtxLXxUMhG+/FczBD/KcTSM3guxuk?=
 =?us-ascii?Q?h0sRWGjOeT6qgK6x3i3yzwFnVyRgNWMNSQD8FLEO9bzoZcCJAoZ6tuOCAcNI?=
 =?us-ascii?Q?xbu0PKwEhIYgzFoODIHn8uLi1CNo+kakXM22/6ETzTPBO6PPJbVlASt8rxL7?=
 =?us-ascii?Q?GgkUWkw5BqW85Gr7/ISefKyJ3NHPGXofEv0kFcmPDejiQOiEjeqpludgp2vq?=
 =?us-ascii?Q?6aoB91hN99VPtRoINxbDap5hzuRW5VNnNeYqbfykDQWhtKzqMfpiPkeLSidT?=
 =?us-ascii?Q?TCkqxUlf5vNAsXxnZZyaPjuH8uUpLhuLOfzYlJ7aJ07pXiZ50vDqCJdS0oJR?=
 =?us-ascii?Q?JmTj0V82ZJyaPviM3qNyag1GXgzMmvTqMfGYBdPL0NJzdrOArpKlTVRwrert?=
 =?us-ascii?Q?+dwkG/4sqKx9Ifeh7rn1TnKqtzCgqVhwlYLHww6NUgTcYlc3r5MTTwI7FLwd?=
 =?us-ascii?Q?mcuoZQhC7AIMpn4ZhdwPNBMR02vpmao1tAJOMOJ637KRebWigq6svtdR1Iou?=
 =?us-ascii?Q?ySVwGdfgp3UOH/tsj1Ghh8IhZ9kLzAEKXdtrrVkrxRAnuDjPvsIwvI66vLUq?=
 =?us-ascii?Q?5KaDkQW2zSBjHevx/3SYTkmZ1r4MyLSJwqq12mbMbRUdD73Ivzn62d7v/Ctq?=
 =?us-ascii?Q?iUk69ALex6pK1lPIr23uJCtUKz3R8zQgA6Jvwij86e6uORtRZ8KuBj+QT8ok?=
 =?us-ascii?Q?ddVDl2BAvmoNFq8g4mW6gP7UwvkfoCpGHw11DDOysynEEJXI0iXxcHDysW/n?=
 =?us-ascii?Q?PlWci9Ztb1hE+RzppLh6GNgeREn5Ch471FoHhEpx+YzHhTL5Rc7birB0piER?=
 =?us-ascii?Q?Z2N+oPmAI7A6lGgL3vBgc3rZTqU4mRwgLTSfiUwzAB4ClW9vUmTLOblnbHQb?=
 =?us-ascii?Q?9sc65/pzCBM/3TW/7QcwWMIBSBC649fOrufSsjK6VIrd642vula16j99uGqg?=
 =?us-ascii?Q?AIe7vYnwXrbmR3uy7FHw20JOnEIs3gak5xyoY30GPYe5tGmbxHnICicoksel?=
 =?us-ascii?Q?7upG0RHcPrEDzN/5uOGND18hvVr8WFdJk9FbFGeEkEx9jvZq1FbNi9UgheT3?=
 =?us-ascii?Q?h78NFoGJd0iARt/KycNqslPB0Uhq49iodijTofOW1OTdwvEQUfERMlUCz0Yb?=
 =?us-ascii?Q?e56lLlp8N0XT6I9baIkomESN6/ovyC6MbWcRpoTg+laMKclCIpxsfWQRzkaV?=
 =?us-ascii?Q?CsbAYKGpPcij/lOjL1kqBmR8wVzkXgkh5MeU0Z2m1ls32zeJ2/45HV7aG2eD?=
 =?us-ascii?Q?HnnXWmevtbKLbgaQ8HkFycK+Rrmc0DT14IqpevY/T17rnkyCOfYIuZGZ+dBW?=
 =?us-ascii?Q?m69CRgCp63f9PqySBZmQleeZFYhy56is2iCorA/canXx9e5SqSfYBZCmUuBB?=
 =?us-ascii?Q?/65OM2wUNmOroEH639rqWG9/GecGldIxVrIwyQG2QqAc/QJfabs/qFZfNdC4?=
 =?us-ascii?Q?pUIjljBl5un5P8bDYyP1NcqN2xxMTBBZU1C6HF6XLVGIk4oKrq5dxNNT5moa?=
 =?us-ascii?Q?lsamX5iglNCjZ7frmwPChXspelhoTKxtJHSG1k8UXT3l/tAztZ1LBR2IMlgA?=
 =?us-ascii?Q?u7cANjOcCnkKk8lbhTJfMwk1LchDSsaYWJtjLdfSL1go+ULayGwPF8TYDtwp?=
 =?us-ascii?Q?8hmiVre0O+2459lCfOULA0S0Vss9qeZ39hmIX+W2EXylUTPLG0SB1epVlzIT?=
 =?us-ascii?Q?MEJKy/3uRPkVvy78DuPG+DOrGYTedXtBrZB5astKwQ6E49CEeWZ9/ClQsGL7?=
 =?us-ascii?Q?54fXcXfl5Ku2DRnEJg5Mal6rpaLuVoM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R5wbW8XCz5FWakBQIrznUelC3zIJgV9k8y7Lv7LN/Xo/IWgyYCsoFxLAx0brs6s1GMvzlDLq/h0bALefW8+DlooZsNHhzrW8bsxmXieT/J/48u8xRcyjF2P51+ORb6DFaRxfSoIPIdytqrtaDxjWJbfU3wTuGJmnLqDXmCkNaX+m+oMhh9P2/hQ2kQRjTpT1H4STDgbSYBMl5Pj0U+UCMI0PJRs3ZZLSb5Du0cvmbeMpUbsDY8C3efRBdavzii6MBZpWJgXHVSDe9zqxRxF6H22J7bpc51+BK36DxBkGRY1CuCpk+LTtseKDJJAGHVfavLNChAs4dliJkV6tunCsXIfWmaeT5jjWaEg/Ma0sD5LsLY24r6QVWFv292rhM4cSHCTWDJsH21fP9J9YiJU2LjWWCzV/DzrGucxo2MXCO4n/bie6nZP03M9PEkKor/uYKhF3h8S5LvmCAbhwWhAAjxvOZnYScc6XA8VwXch1dScRyAuGsQW1sBNS3iHqQP7H1yW6sOlowAvFJp4R+1nvg45hvSyO2LmcudMofvAlbtojRSAT9Qw47PIjUnTJupD/uv6f1Ez4/JSmoPfQkfUQwOtjwu5zo7RfqtahnhS6EOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fead72d-c909-4a8b-b9dd-08de7a1d98bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:41:07.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6l37Y5T9+yFSLt9fGt/+U99hZ3sCduoDOqUWIAQL4v7yXLml/WdgA5EUG03zE+KWbnCrtrpeyRBCWA4FETPXhKaIPR1hcn6h3CgnAr0+vXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040152
X-Authority-Analysis: v=2.4 cv=B9S0EetM c=1 sm=1 tr=0 ts=69a87cca b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=UYU2QljogtbhK2u58nAA:9 cc=ntf awl=host:13812
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE1MiBTYWx0ZWRfX4qavHo0ww1SB
 Cp88t03pn7YbijaVQU74xG8dNvH7/ovieYhxvtC5ogsn8acwklZM/39rXb/zdYEw/ENavXfEmtl
 xx/bCa+YJdvjBCablbUo1wJkUl3Afp2Paj0DB/aiSoZa03HQwGXe6cHVtaDe1IlQfVJOeBmo8H5
 w3leQcPTSA9IZ7PebIplkqxgAoAKjcRqGMgvyLmunSrrVaSD43u0mK9X6ucK41eLaLtxwTIVEXX
 ZQQFAhHL+64vN2h38MxunwXP8dftktv+i9KroEg9pNTeXuOxzV7KRvsd6TQKs9MNzO4pBZurOVD
 Zh0IYdCGuBybgbiOqpAKK4N67dONSDQoh9baNyYajTMy15+DlFcA9Y9XyWO4PwsNRzZOeoakLVz
 Z5xqSLSOKh3iwhTpcK/FGHnqclhxHlV4ffmbaggCdcyZGgNKVY43x4O5Q7tsFcqdYnt2deJPR9Y
 2TbCT/keVulKNy/j/YzXVCU8FcHxh87jSGezIP00=
X-Proofpoint-ORIG-GUID: JfsgKvUruy0Gj98G1B_r4gtpPH2NyyeV
X-Proofpoint-GUID: JfsgKvUruy0Gj98G1B_r4gtpPH2NyyeV

Hi everyone,

This is v3 for this patch series after patch checker complaints.

Cheers,
Cupertino

Changes from v1:
 - Corrected typos in commit messages.
 - Fixed indentation.
 - Replaced text by simpler version suggested by Eduard.
Changes from v2:
 - Small fixes after AI patch checker complaints.

Cupertino Miranda (2):
  bpf: detect non null pointer with register operand in JEQ/JNE.
  selftests/bpf: tests to non_null ptr detection using register operand
    in JEQ/JNE

 kernel/bpf/verifier.c                         |   9 ++-
 tools/testing/selftests/bpf/log               |  28 +++++++++
 .../bpf/progs/verifier_jeq_infer_not_null.c   |  54 ++++++++++++++++++
 .../bpf/verifier_jeq_infer_not_null.bc        | Bin 0 -> 13560 bytes
 4 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/log
 create mode 100644 tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bc

-- 
2.47.3

