Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC8330D50
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637598; cv=fail; b=fy7jU6Vb0QE2TCE5dy4tW6JrORFhCyrPvlLZzf5U6TMwc2nOzwIJ6ncqlWSYGcpGiiu64JxIsxslk0ZBqCULDgHYlkqttIeVlfXknWXJCjbc114aNM6rE7DCLxfp2IFzbJtH4gYatmudhAL6DmgYAo61VhkeRNKAlLpgay5ppOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637598; c=relaxed/simple;
	bh=IQuWzLtztXvY1HgbrmHcIDh1fRbP5VtFtpAv8SM5z8I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=P2tWFykUEj01ctkAQvr2b4q4xjQKQznMUfHdY5mRPUcOjeuLtCzI6SwBBjYfEsAN+vOr042PEKluSOhCnSdtHCKGv8VM9Vd52qvhcWg8aEYSjaxJAtQf7W4E5Pj2w3FokuVgP39g0m+gjHYX87oYr5f7Pn3nl/ObRDn6bj2QXmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lFIezHxW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z3am/jC6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lFIezHxW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z3am/jC6"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624ErfRf2574809
	for <bpf@vger.kernel.org>; Wed, 4 Mar 2026 15:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=fzxzMJv2Ena6ssPi
	U3AaV3yxCVI1QI8dLmpmUY36MIM=; b=lFIezHxWFEQv68HE5ihEkUf2XfJ5eqwY
	qyc1sfsrdkoJ1Xa13Ymu/hIkjLqTakhgoMlsfROPJmHPgZr/sYYWQupY0YZR+Ces
	YdXHjv8ehkxK0IOOAbmekfXhDg//D73uQZzn5/hUcNIi7839mEg8c0tiETDesQ6u
	iJUZuj6ZFt/3+MBwFAyXavLg1OohoOR1DCKQJ7AUEApjkiLfHbzFMU89yXVCPoRS
	B4BFPdjOcJt41Qr0tFTYznOmD5b309xRQVfktW4ncZzee5fT1/dqnsdpCG1zbypP
	EGjzszdANFFYxWWQHugVKq0MLZ+GuZ7ZgcAR5f61mZ6CGWo0kRFwgQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cppw101yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 15:19:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624De5Uc027513
	for <bpf@vger.kernel.org>; Wed, 4 Mar 2026 15:19:54 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptbp1br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 15:19:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXLEp00xt4skTTyTAMyhd/OkvZQoW8ALkt/yxi/8LivitwIx745cspnIVqhjBDCc18FrBkB7fakR6uvb5Lm8r+cE1BnjYL0KLUCPuRP33E1FtmtJdpwn4CduPCsmdYwwV2Tw+LkNP4YifZYlrs1+v7GLJn7b5xhH0T9t6tZgkwtMDfIqR92aICwYAIIVw6OJ+vtEsdYxVqAvSapjeUeYpO1qCugVPPxMTE1nadzwXvQnB0YPVyx7Id0oSF+hc2JGp/Cwm2EtryRGie3tnf+ZVIsRdKohSnCGFWGHoLyzq8XQNKY0zOUvbcHMx2kQg/FSjgnWt/NIPT3UwwgrcY6EgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzxzMJv2Ena6ssPiU3AaV3yxCVI1QI8dLmpmUY36MIM=;
 b=HxNWUNES2QdNjwu6+jsZgWVYRg/kq4VznZOGaGkz7hgY3vR9gh9rSlq0E4Iv7vNOU2T8MxWt8H4oYw28RrZvSKyjZPZmmJSTDFnZ2V3izEsWxt2F7G3uOku9Krw69FFEKR97FumqNhLT2JSqRoj1ZqIALKKXMP8mALu7/Jiibe81gSBK1kFy3qMUjwwYeS7Z2t0vJOIX/nd2ssbRosyFDLNcnphiAC5wlKHMwg2C/hSMc4R/2myjD2LGLTvd1DMlAzzjbBRcaD8tj22FgrGlALQ79lEIbmFLD7Y+aAxXfzsg1+YzKV2Iq/ItSErKxyyhw9otSZaXpK0GTtmvjlTM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzxzMJv2Ena6ssPiU3AaV3yxCVI1QI8dLmpmUY36MIM=;
 b=z3am/jC6Cz6F8qX6XaIgjRTVHjuLKMXpqQdrJmrtfTRo8T84JyfrmdlIco8uUdV5OuQgcae4A5ZjpZ029diFWHwvi+EUJcxgV0+OdvxMd8gdlcyonwnTQhg/4kRNg4+9TS50D0+p0GGhMTblIzZeQC3rOCy/On7FnaxeNJpXs3c=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH0PR10MB4954.namprd10.prod.outlook.com (2603:10b6:610:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:19:51 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 15:19:51 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH b2 0/2] bpf: support for non_null ptr detection with JEQ/JNE with register operand
Date: Wed,  4 Mar 2026 15:19:30 +0000
Message-Id: <20260304151932.177995-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH0PR10MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: cf36f577-505b-43b4-7df9-08de7a017abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	1ddLR7GdnUy1l39UDnujZcKdDNFvuYsBGv6t0O6KbTxR11FrnEyNg6zhBhKpZsWqC8NWdi6RCaq3oZwLbPLPKfX9QkP7igfrQNDvpnkWJzsV2VklJLJVmxQNK4UmTs4kNxm+VI+XqwxnKwQzKqMtVqzW1Wx8pjhJw47dkDBe08I8Wrrq0tXqvjWQ5Dseaj5pft4LJEU30fP/KwTwoLcD2JOcq+hrjjt5JQJM85NTJ3JFbslrEckghVqKtvNBoDm8jBRX8vpw0Ay3S71tilT9Kj3h3mlUwB2USBlG/x33zuc+BiGyt+u/x0dvpLVmDnFrIu0oMvX/oN5wsPD31M8vqDCNA8v2tNFZ2wo9EqivMZLP1p/SHnkiTq/T1JnyazyiT73sHc/NEyvIOOQ2GXwpPHGNWNIfO2bstaZ2bzTVpSbZ3s4Ru8QfF2RxQAfBfh5J5CteUgyYEfGg5aFIIFthnDd7/4yrkrJIdYknGYH4DekobV1gQcVBt0QmO3N9Xgd7v5He7C/SiCDl4AsyLM4yVodl67ghV+TyZyj0Z9TmJ9dBncp6E50X9r9Mz2882vhbo3YuN1TgzUT2+A0cyWFW8fvlLu/iy0YCpl+ukiokVTG8bQhucfg7uzYSGyM2pQ1AExcUEm74TMsTMvJ/kaO+hJM24DBBug9KroeJLJ/V5Mq1XA8njeumeumwevMTo25JyNITIfd+UV98WZt7Y3hYcLKOYVDBrizKlcK6stP8EBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y2n9qe+ZZndzOpYv44K79XqoFllTTONa3bXbu444udM9o6fzXfeMKC5Z4Htl?=
 =?us-ascii?Q?W0rl/4ZDXhi/A/jG+UnkneHJHikVeeI6eWDlVJxwtIULkeVuUiu2lXdEVzpf?=
 =?us-ascii?Q?gWJ9Y9TdiqBpl+FHTWCbBQ2aM0op6/3QtKbY/rEPIajFdkp7u178kg43cVr9?=
 =?us-ascii?Q?FZymszwdKIkAW1xZO8WIgqTcVagB4FsJ0FkifInUbY2/wxhefeS578dRbE4K?=
 =?us-ascii?Q?35bwLa0RXcncsm190ZHzLduad81CevGPrPYyIovHRrM9oThi8sEqDCD5ePBg?=
 =?us-ascii?Q?BC5j6TWDO2yExao2tgN17tHC49oNkvJDDH+WQuMNLfIqp4T1aDBfrctkZpSv?=
 =?us-ascii?Q?6Sg6GK4tj9DCNvjyyQt+WAugtkAKlUJHt5bWT/3UjXZfz3gtRZXExnifWEAQ?=
 =?us-ascii?Q?N0wVN3dW0oqBQFhlhYCPBLuTfyCxal4zSX6TXOuvBxNyf9YWQLJqO1aNwlv+?=
 =?us-ascii?Q?OqPd2SE4abmlRgGbh9DOqQhm3n3wCkYPHPYFWqIa2IT3kJYobK8tdeQKcwX+?=
 =?us-ascii?Q?7ngGXATsV3nD9LIsau9hK4szlzNOXw8YjpHXSPn6ap2KhuhnmSep3H8cw9lu?=
 =?us-ascii?Q?jO2HvUUCMhBXyJarZQVx9hHH+ZN7taAY1dTRQj6HH+2x1PPqOvI0Uxo1Xq7E?=
 =?us-ascii?Q?QKt88de7LDIlB4Zt5SCGTcjDK841C4S5nRU2AIKZMU/neN+3VrIHITJU0ACI?=
 =?us-ascii?Q?jNGtWqLOCBxMuemcfOD7cWj9lI5YnlLqRIyPE5sNw5ENgIuzHcQdxpwj+VNS?=
 =?us-ascii?Q?WMkDW99PCQwdqBpDC0IV5tfLeDOfFZkwHdCPutLdD9cHmvwgSweGLAeHQmSr?=
 =?us-ascii?Q?cGEFHuzGpHWmi6ttRxRQqNzazhQpDrlymQGr1hgCjHYooGNrsoV4r3WISepR?=
 =?us-ascii?Q?PQx4tZkoUcIgl+N7X30II28c7whmL5Km2qQlIvSpDUpmDqUw8T9O09OLGzws?=
 =?us-ascii?Q?jrPHtdFh0z3jn4S72YoPhxiVI0pAJfMW2exCNvH+wwJ3x1U7ZJNGhhLfJrRL?=
 =?us-ascii?Q?W2dmXHHpqLh4kXhx5LBQiwDEw5DMtsnjPKd7kc1q7M7N0L0vHIBNIOdQYFvJ?=
 =?us-ascii?Q?q0k4jz01dpZGw8wTs0bXsbDnl/2BTlnjK7MS/pcJlKNeoq4SRHLwcmMWH1VV?=
 =?us-ascii?Q?sHlAyPr0OpVWpV0aVPa23zozsS1bLp9tE0QtjDnw3qKt/pIT3ypc/JzKLqlS?=
 =?us-ascii?Q?fbvlxSQjdl3pU43wNyX+UnOVjct28N2HuTKBd0CGoEGuR9MRbFK2zLfVac/g?=
 =?us-ascii?Q?9QQnK8hKMgRlG+Iejz1cxoEWEF+1A01V71Kw4nESQAPu8zKBZ/m8E0ZAjav6?=
 =?us-ascii?Q?+mFXJGDKtgTsNHXUbXIFSVuFZEKBMCYqexFwP1FM/dZ8I9rUXzidRi01vk2C?=
 =?us-ascii?Q?f0GDFGgd5fI5Ge3ZKtLuot4GSM3JtcfZeTBGlOFs5XCcz72ybg0m4fNx/TML?=
 =?us-ascii?Q?kQ85UrTun0vaTORy37BjzjRI5gXMYATJnWKQ/wcIlI3b7GQ6QvgdjZLMjsQS?=
 =?us-ascii?Q?m3aLRdITxMKGOhL6VCV9WKNX4DxXv73wSuOYWhfB9Ngwp8gktcQaqXkOTQy2?=
 =?us-ascii?Q?/1n4+fkR7Wxa6eUTzccNVYKUAkwOtn3JJYOz/3qZSPexqwAjEJNNb/1cudRM?=
 =?us-ascii?Q?9BvXzZl23CCKo4JUKgFHwl9ndyOWBuu263PnC0F+YvxHA5e+RiubiTAP7H/K?=
 =?us-ascii?Q?DiLCIH7mIf1Ci/5nGlK2v3gWlTkya/dcqtPPU6Qn53Pn7EM/yOBXMHQe2D/a?=
 =?us-ascii?Q?PWsrR6uhCx4E0B8hmFMDo4fXWoqCBm4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AU8HWe6imNBQDd2ugdq62mpnhCiexIMhRggmEnbtDMndfYnVQe6GG0Gbwpv5ZfL29uaBJxO8XcjGEFqypxcJYageAj3PFRhJurwNBzoyp45FYfYF6qVvH9z93vPvoYFECXcaD471Gm8Q9NOb13GV7iVYrQ4yXGPXhlUELAPLuyqi0w0LcvbWzWv0F6+36St9VkynTxNLimEbzzIcusWEt3jnR9UK+V79QO93K5f4uvjStDpWQe6hZEH9/ONJ+QLF/GHqUfSw7sO4ju5mPxzRNV5sRhUi78d4EZQSbBUSDkxQxYuUurpILx6VoQ5I7HZpQy+/pGkhUSnmh4KfayApRJf+/tPNnNWjKHGluN5aPWY73b0+g93xmTE10vHjrPVdoyG5dpuOvpUvMgfOJD1C/3vGWqDNbhsfFkEga7qPzzSfBWNLZr8seUYnnetJ+8m7vmK1eslUmL0r1bj5tSo6FsXHAuNypUbK0qV0/4DJC1M2gHOISjDx5P2lXeC/IsxhneMxJ0CdFn7r1SEqlsEhnuLoIEACaNEp9wlmTNqs5yAIXkWOHI9X5P0uREyWpRaz/KBEQroNg8y+uBuz+AvbyD+Rj6ZUwBFUkVc2qRmz09Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf36f577-505b-43b4-7df9-08de7a017abe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:19:51.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjfCNmeVL6KsEUUMmxGg+g+h5n9wCD+O420CD+yEqMPevnV+LewlJq9JUflwvdjNKcWkCStkYet6X7uXvwFjtXGOnYepfVTFX0e84kTlXpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040124
X-Proofpoint-GUID: VA4fyH0qHezO-HY0i6astrPwjlo3i7HY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEyNCBTYWx0ZWRfX4HWB/7SzxD9i
 yHB+f5p3UmfuZy2do77pHhUpYYbjbQMuey1+F4Pchv6fEL0rPRZWgPfOHC6yL8z8E0p2aDJ6+HE
 +RrZTXG+aBmn5yityzbvvIP+NJuas/6/EBEK1VUnZjHGhaDBM0wTwTQepqhPjLk5dWcGDWta6PD
 U84JE0TeTatRYBtZdw2KPG9ZIIMnfKUuf8yy3HQDYsiwpVXlSXxS3hXDsj3IQYZEYy6w4Wx7NbK
 0rUMZLiKRheHZ/ECZQblwTOlg7tyqQ+aKsuyMP0I1RL2bAMMd4E1RJ1hPFVH1hyy7cHL2s5hOuq
 OJh3WRT+oCC5qsNVwpmuJJJdZnjSfJbGC3jEVPUokOEzYXT5HUGJy1q7HLbxNFXQU+VrnJVLdYL
 IRBLoM0zOiDTCFjHkG4/O5Ob20XfVXHknX9gdDtN9w+VnGpw+mlRNhxDbTGF2lUHVVpEdrDH72O
 L6HJhgk16cAXK+s5alQ==
X-Authority-Analysis: v=2.4 cv=Jd2xbEKV c=1 sm=1 tr=0 ts=69a84d9b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=UYU2QljogtbhK2u58nAA:9
X-Proofpoint-ORIG-GUID: VA4fyH0qHezO-HY0i6astrPwjlo3i7HY

Hi everyone,

This is v2 for this patch series.

Cheers,
Cupertino

Changes from v1:
 - Corrected typos in commit messages.
 - Fixed indentation.
 - Replaced text by simpler version suggested by Eduard.


Cupertino Miranda (2):
  bpf: detect non null pointer with register operand in JEQ/JNE.
  selftests/bpf: tests to non_null ptr detection using register operand
    in JEQ/JNE

 kernel/bpf/verifier.c                         |  9 ++--
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 54 +++++++++++++++++++
 2 files changed, 60 insertions(+), 3 deletions(-)

-- 
2.47.3

