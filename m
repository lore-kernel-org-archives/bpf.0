Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF312D9EC2
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468278; cv=fail; b=htNbgLawQknRC0foPm08iP+Mo8oXMvn3ytgyihaZOm8tVnEQLpR0QY28KwqhBoM4EnkQ62mvScPxR8syK0eWodUIYCth5Axa/jCs1tHlEj+JAf3qKYOCXYI75Ssl3AXmQ/y5qxD2YsBk2Q1GfyZc4Ufb+sUlcfsUedkFVvHqVKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468278; c=relaxed/simple;
	bh=MhVNIGNNEy92LZYaqXIjCxavMtwSaelvLPIgRF1obIw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lq+xo7djH+rLm0N9sMqtt0HpaR0h67Ru5DcSAaAlQsk6mi5LTkap2JPcLLrmIEni4n7ymUALJehTUDXTABz+eYUKLqFRSDb8g1z0kBQtxbAELIjGuM9EOXSjingSjzYsK501i420AVmGDhDUk2jAJzhe/Yzi4kGrJWutSdQ1610=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OoFjPrYy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AQoM5cZT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OoFjPrYy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQoM5cZT"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622F0FLL1297059
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 16:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=c2ACvm+Sjsa8C/kS
	eGwoRGMsEw6inRa1L2MKXsv/rCw=; b=OoFjPrYylbZzSvmFft4Ka5ZKxhfdg43X
	D6FMckE4vm8zrPkaYnFx1RsoIQMmvhBoY6BgIOPd48NpDooSqSJBRHkqLg2dMUML
	GLnQjTyyzVxsclsYNFLmXL4MrKZ21aujmAF8i86kpqRVwwVkTkxTYoJxFCgk77KA
	D8UPhVrqbQ4XhYtwRDg+FYA5Z1zGdBu/t6JKqpGDrLsmSPbBN7je5OPxf1TWA+EJ
	THqxPwU1QG82qhcTVy3Be4wlbtrj58QN/Ac4ZwWtgyDyH/gwQwyIFN7dmKWS8NH8
	REPUETyN3Sg4HWOmS3GPDtqcBxipItQvz9e2L6xNikWzkdqJKbXlAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cncdc05yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 16:17:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622G0651034759
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 16:17:55 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptd5bhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 16:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNir1yRy6ESEQgaMIauPMYP6o/h8cOuQXg4VkcPsoDd1/O9yo/2rf7XO3XQOp5YJ7FFnBDXJZ4zpfjhikp29mQ05/qggzmmNqZHBp8j8oFXHVvHL7Jws1A25pnG+YPshFxWqouUrFwNxgr7uWRZCbIAIwrrlcn8ehu1Zl5/TclDxdgNzytLUsyeFsqyCNVy8EWTtMjBtSxJBduu52DnR43BfCgU+dvYVPm8RZScIoxBfv5yLYihNGVj/KIukV4PPPzj+yCzRBhpHIOoiXk0aEHr0c/oMCKnxeO9+mb1Ao80Q7CRyZZofBV3ak11hU5ZcgGzKU7kmz91jwGQIcZ0vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2ACvm+Sjsa8C/kSeGwoRGMsEw6inRa1L2MKXsv/rCw=;
 b=VfhbpGAMWK/Ec0PflsskBEl9QciwTI4/TH1skdbZnJ7sRZumMK+q+ik31jBW5n/DDGKGCT0Q/AT1Tv0UCRNB7yv7UHtZTJCO0lQuEhgjaOuWvhsTaxcQc+64sa4daPQxU+7aEfdOlHEUjD4b+W+iNljv5ooaARKd9ugMDU60sQ2ubEeeLF3lj7vVVY+N/urxkKYsC6Lswz/c6ltfOLKew7mgwOC1/RzBrrnCILw3BgZp77IxIRlz6ljMJBgPaSVpxM5YtTOjo3aRJp9qHeKVuD8tSDGElSeDD2IWy9ZM3YQi5eAz/8zIhzysJ51cd1GJBCcLGOcbxnCf6kgRIfipmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2ACvm+Sjsa8C/kSeGwoRGMsEw6inRa1L2MKXsv/rCw=;
 b=AQoM5cZTVpjW0b3wYOumCHOq+AVO+EnHF5mFcPRLUhDQW3g1ty6sbgWWrYlddiIZdyJB2FX+cirn1wSZE1CSvTLBlwseHNk8wj+AJA+w12KBU0VxTLL6fIboM/3Ny+FGCRSoW1TRjHqwOae84WzQEVpNYwnkB9RJNVJOB6iGuoA=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA4PR10MB8424.namprd10.prod.outlook.com (2603:10b6:208:56d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Mon, 2 Mar
 2026 16:17:45 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:17:45 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH 0/2] bpf: support for non_null ptr detection with JEQ/JNE with register operand
Date: Mon,  2 Mar 2026 16:17:34 +0000
Message-Id: <20260302161736.156685-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA4PR10MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6a12f2-c7e4-4f00-0550-08de78773c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	sx9Z5Yk7jtMgCC2CM4WTGz8MTTcyNOPPk+8yVBt0EHuZH6syqnrbe586GOrCkXwJuTsdCRHDzkWyPN/Z4etgLGKPPhiOpMrOXO9FQxGoc67up1T6pTYYTa1XkJbvnLlq5r35x1j78pDKUGRhpAS9f6soCN786Md9RzSAO9Hey73W4LIHfXtjytS+a/JPnTNmf7n+vas5lXeqJhde6D/xK7IPBrPitrGuyQJKBdudIGAuDTl+n157t7HipFERbuT5Yd1Nlc+pGuSkiG/D21tik8owfFfPuDYs6Q3+L3RtGIKnxLJHWQ3S6WyM8RfHHin0ZdijA9ANYCogI9Anl04n4fKu+bYBTS1faN+RLrZS4Dc4uJPPNvz0wDlw9tnAEboYzsHBKrozmVGVM2iq0qKhWyt6ZNRRcfycMDDxm6xP6G8o2W12qu2DTPgSzumsfhWOiKckQNnwHzx2l4vZlqAmVzA8BvXn58Kp+4kdZ8SkEzhj1THDEsM87Ij1/Ddm1MqtNsBcSotWef5rkLb3SyeI3F+u+S3h8dYJmKsbksshQ9MQl86dO/OvbvEKjvJw9yRzwmH9sE4hvcYMi7TBJKyPblfri/7ud5MihfJrnPGor486XBLXkSZrfr196b8l0p5XlO+v5vnAo81FWXAw+Jwi9xrYlYGBzmmGl4+2ZcOg/VkzNltGzP5Wujo3JmMNEw1sAeW5s+fSqQFdOlm6qHdnYw1bqXuCJJ2l340mDcds/wk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qtpgFQJoC6xjix1ZiBF83SpYG2irPXTkct+a4Lm/RsOh4GN8MOQ/6k/pfkL?=
 =?us-ascii?Q?H4LJlj/jmIJaHZbt90rrwMTef6NFjdVfA+Z1Rikj8xnPxra2Ls1kMxNE5i7s?=
 =?us-ascii?Q?lyofsUifOcoDyWAQcOwY1960HFhN2H/hJuXnyGsACLMBBLs7kHsCAUY5m+lY?=
 =?us-ascii?Q?e/8te5zCBs46Z0NjmDgvcFh6WLKkFqBdVBfcbG2MG2uCj3gTJttzIUNAo4Cd?=
 =?us-ascii?Q?1yXjJAaVyd1tw641UCjIjifKt+DyTQGi5u8oYKi0SVu498Fo29Y3nfjeE8Ue?=
 =?us-ascii?Q?86v5Gw3OuAwcdJEfKRqD/fL4a7PmvlmKj3CGVZ2UwvpV3rVOUD6fIMO3wRAs?=
 =?us-ascii?Q?VwHBDuwJ5Coaal26fpIJIex1U5VnXxg/n7CpKDA6H7jwmbiHVmNBegKUQlSr?=
 =?us-ascii?Q?2Lv3DfXB1ThnDdGxqn+qCvUtdLrhMPSZ3wjNfxz+bW/9Qf0w0zA41PWhlDKh?=
 =?us-ascii?Q?4iAxJaFTVMWitvzld+SpWsqvZ2w9LHQLqTsDQRV8+ir3p7hiJqKqnpxZ44zp?=
 =?us-ascii?Q?Uk0QKTh6CMZWRNmXLDxYsFAlYJQGQngNBWWgYM0EqNH4tTBO5egUrD3Eg+gC?=
 =?us-ascii?Q?YGNHG6WC+HGq3SRjTS9IrN3gsh07L38NnpoIh0MYu4FMVpDlZDeiOsxjxmOA?=
 =?us-ascii?Q?oYiw7jhOC1kWZ8E3wqOFnG01rZqWM4cvgXjhstb7TPaPL7wUFdv692f2b/Rn?=
 =?us-ascii?Q?mzhRW+3sxZsWKQvp1KPS3OCRmRvEbEmZMx4PD/ISACXeoRJJgSJurrPkaIiW?=
 =?us-ascii?Q?nTSIbqMikZ4N2WL58SVSSxI6unZJfs2PLiZtNZ77BqZIja2h/tZOs4iSYd1H?=
 =?us-ascii?Q?zwjGmoUsoNXeLUkePr/69U2qsgAEGnRNu8NGy8sTvOxIKUSUvoT+1kh0oICJ?=
 =?us-ascii?Q?mymFOXgbSxxYGruP6OXnqizbz1hTJzMCX2EaAbpN17yiPNFFpQp5uqVF01/+?=
 =?us-ascii?Q?rAbmMF813jI+hBWDKcUUIhQZlZ2UPhDdpJShEsExBkWuGkmebdKy7SgE8g0c?=
 =?us-ascii?Q?VxtGDbc+2QTs0fwuwIz84/Rwa7dZdjEiGe+mw6THxpZRUfAGqdpxSoxSWr17?=
 =?us-ascii?Q?r7/aTx0Dc1kh2F7EfvbgFgW2QM3yiXZ1N3EYRwJ9l5GUH5VgKM9SAwdjUgmt?=
 =?us-ascii?Q?3QVhm0e3ypv0OY8md1Sa5nRqoJdh87P8YoxCAhN1MHb8+fG53DHkydUsiQA9?=
 =?us-ascii?Q?1YqjNRbAshp/YK3Nwj9KG8u9dKIQh6XtDsZXqUVo+U/DVvKpfq05e8+PpYJ6?=
 =?us-ascii?Q?H6fxWVhaj0NLRyU/RAlP0Dt3U6/Nq86yx0P5sOTegvvkIFhZnVKhZvqufImv?=
 =?us-ascii?Q?7JfZ4nSNpyzZ3toYHlemt7ZBfsND25QyebrY+9xJfn31rF3A+cP2LUBDnhTf?=
 =?us-ascii?Q?qnHXGMcfAtdD/8Ta1mz3CUeWzkwncH/Wy/2WZizyG1TKAc+MjlnJYd2Dl7Fc?=
 =?us-ascii?Q?fP2OEizIToDDUO3ErVPeUVa77d0oNZdItQXL2SnB9Zodoz7+4FL9vCxuNvMw?=
 =?us-ascii?Q?v4WX11i4gatuym+7jyR0rKKSNN9VZZYmoRtPkay55yfsTV367O7cA29VzPSQ?=
 =?us-ascii?Q?GPavYfEo2Q/yGpPGZfTrycjSPvGS+Sb0in3AHRdsiCqSlv9bH16Ic+jZFfkN?=
 =?us-ascii?Q?KIPqyo+sHkaoxNekQWDlLOecEIVl8iKK1TMsyVwftJAb+nduJbRTHFiicRd1?=
 =?us-ascii?Q?1QpPJtFBJu0jqN42jdXu7zvFcoQ4yLb5s4boaCcyfiYuN+zADd0g13ZufNI2?=
 =?us-ascii?Q?t6JHY2SHK9hejDLsJH/1fn5vtCjoJOE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WlfWS+YaSiIuyB0VMAQjQe8t6fcaG1r9UKOJMefakUhwt0SbWGyXFmI4a/ezB0PBvtOuKCeZp3aKUDlH0qFK8SfzczEs4LfpysNiwj9Nu/W0zLvLo40qkq3fjkFt9y4Cg200zM/cyalfnI3uBG/L51FatZvC47fWWmrB/X1QLC6wKmDRdBKspEV5ukZPnwyA1zPlFnHUokcDQRUtdG2kAdVHy0W9y4N4S2MkijXSVDvXVI3af7pTZNtKNs4P0LUIaKg8lDQzTNAyFdcJ4oPUghEOazpsJBhP/vhxz4M0qq2XhCdYDprsPyXlnOvTzlOM9hrEhdO3bsvLJ8nkVkvaOhuAUd6bYjI2Qsulfe7peVJhnJonB4oivAePzbBgUtYi93tWdvhThsRJSIHfZ2sLCOH2zMfRaBzfWI4mbkWTZANb8Mfuu4do6vvD7vqV+Vlurm2aT4V5y3evGgzY9UceA2Bz6So+ovIOR2vyBmRXIKbF0g7cYiQIGfjrdWuOrx15K3E/2N01KkjzrgSiiNGayeO7uRO7Th//iBVp4ZYQSsxkTWWuMtPsvZ32r99QkoUTjfk3JbT3pPNNxx1/GOz4/LXziHFZ9SJWFZgGNJy+UIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6a12f2-c7e4-4f00-0550-08de78773c94
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:17:45.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwDSt+au8m31PKd5W79HxIjAIWUvOoVxEl2WepFdAiAFzblOoUHD8S68+bBPhc6fVAsv5g+rhX4iG4g30SCjFU/mXyIuqOE50in1uRNntdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603020135
X-Authority-Analysis: v=2.4 cv=R6kO2NRX c=1 sm=1 tr=0 ts=69a5b834 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=LLVYic1nEcGT0CbThS8A:9 cc=ntf
 awl=host:12261
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzNSBTYWx0ZWRfX35iaf7q7Q5e+
 okpZPcgzEoNGGMw63U6yCLMY06zHji8gZW5ec1h68Xt4qSFZCDoOw2Hgt0G1SCLoS24b2x4xXUq
 lWhzHpxwzqQk+8FPrKQHtdaZgqh7UezvOSHlT9H5WaEHaJvkWYQd6mSwuViju8BU2XZIBU7sDn9
 yhOBf6oqPfqdXCb9FIyBhxrqI4qT7bLU3GdFiVRQDPRqL9zcJ61XgcfH1PV1SbaDyhqdb14nd1x
 sjlTDJ4cohm3lzGmSDuc2oYfnNIC0qVleCqfXn2cSJHONlTtzyX4/DVkhvqQ3h3BVQNMsXMtPda
 cOHiwl3pxV011atB8GTEbLzmKjbltrWOKtt21RB75a6jGk3qYqUvPpXKW+yv/CrNW1vPuMkhR06
 KB2PNDiWBR/Ru2PlHHy0tQ1Cv3ahB/EyO4aZ0teNfRdUS3FDZqRAW/sychXPzXSYgFYCPW2pL55
 WC69xGKFqzJUifBnh0MVoCL0CGb51tAX49zr6FjU=
X-Proofpoint-GUID: l9CpBi4cV80yrLQKGAR3TYWUmSiJ_XDY
X-Proofpoint-ORIG-GUID: l9CpBi4cV80yrLQKGAR3TYWUmSiJ_XDY

Hi everyone,

This patch is a small extension to allow the verifier to mark non_null
pointers as such when the condition that makes the runtime check uses a
register with the value 0 instead of the immediate 0.

The following example, is the output within bpftune when compiling BPF
code with an earlier version of GCC. The same also happens in BPF
selftests with latest master GCC.

  bpftune: libbpf: prog 'probe_cong_iter': -- BEGIN PROG LOAD LOG --
  0: R1=ctx() R10=fp0
  0: (b7) r0 = 0                        ; R0_w=0
  1: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0
  2: (7b) *(u64 *)(r10 -8) = r0         ; R0_w=0 R10=fp0 fp-8_w=0
  3: (79) r1 = *(u64 *)(r1 +8)          ; R1_w=trusted_ptr_or_null_sock_common(id=1)
  4: (1d) if r1 == r0 goto pc+9         ; R0_w=0 R1_w=trusted_ptr_or_null_sock_common(id=1)
  5: (85) call bpf_skc_to_tcp_sock#137
  R1 type=trusted_ptr_or_null_ expected=sock_common, sock, tcp_sock, xdp_sock, ptr_, trusted_ptr_
  processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  bpftune: libbpf: prog 'probe_cong_iter': failed to load: -EACCES
  bpftune: libbpf: failed to load object 'probe_bpf'

With this patch, R1 is properly marked as non_null and the call to
bpf_skc_to_tcp_sock#137 is further accepted by the verifier.

No regressions for clang.

With GCC we get the following improvements:
  Before:
    Summary: 566/5032 PASSED, 113 SKIPPED, 131 FAILED
  After
    Summary: 569/5046 PASSED, 113 SKIPPED, 128 FAILED

1480c1480
< #155     jit_probe_mem:FAIL
---
> #155     jit_probe_mem:OK
3918c3918
< #452/19  task_kfunc/task_kfunc_xchg_unreleased:FAIL
---
> #452/19  task_kfunc/task_kfunc_xchg_unreleased:OK
3934c3934
< #452     task_kfunc:FAIL
---
> #452     task_kfunc:OK
3942,3943c3942,3943
< #454/5   task_local_storage/uptr_basic:FAIL
< #454/6   task_local_storage/uptr_across_pages:FAIL
---
> #454/5   task_local_storage/uptr_basic:OK
> #454/6   task_local_storage/uptr_across_pages:OK
4011,4012c4011,4012
< #476/1   test_bpf_ma/batch_alloc_free:FAIL
< #476/2   test_bpf_ma/free_through_map_free:FAIL
---
> #476/1   test_bpf_ma/batch_alloc_free:OK
> #476/2   test_bpf_ma/free_through_map_free:OK
4015c4015
< #476     test_bpf_ma:FAIL
---
> #476     test_bpf_ma:OK

Looking forward to your comments.

Cheers,
Cupertino

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>

Cupertino Miranda (2):
  bpf: detect non null pointer with register operand in JEQ/JNE.
  selftests/bpf: tests to non_null ptr detection using register operand
    in JEQ/JNE

 kernel/bpf/verifier.c                         |   9 +-
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 187 ++++++++++++++++++
 2 files changed, 193 insertions(+), 3 deletions(-)

-- 
2.47.3

