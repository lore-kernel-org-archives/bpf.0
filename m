Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96135BDC9
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649692; cv=fail; b=gTPZmGrBMfdMtccuIjoAu5Ny6zg8lnE6Gt39TyRyiAoIbx0MOrzOqw9OpDqzmR2EKcHGOz25eG7lIScn+BivKk2hkHISleBzyJLw8yGbssPWHRlQwgauIk7j7PjbQZTwYZ5Dqak24H9wQvafImVbOnCP5HIXaRvXEZVUqPXjrwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649692; c=relaxed/simple;
	bh=jfFoMHW0XJrkHhD2qi7iZjzWduNvbYW/paTIKA9975g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U42uadPAZbSDx0mDHejdKPVtaZV4QL2HOAuWcExYSMZhlFMGU+ptsG6Uym4jKcza0PFhkqqfKDYka3Hxw8H9EGY/WO3tu/BC1zQufR+rDXi6/wC9yvO/wxljiX+iMIx9nY9YxIQB0tCYMrnUB2qFrtLTZJW/NwsXiX72tW+EBfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RfSV0tgl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CsDz7T0E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RfSV0tgl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CsDz7T0E"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624Ib4l63316049;
	Wed, 4 Mar 2026 18:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jhu2h9E0WrtS2KCKCcj2Wwi3/l3SfrrbFTg1GWaAGgc=; b=
	RfSV0tglPjFVf6uYLTNcDLjuTEjLypT8rs5/6kBpnEtvK/BFpjcTUhbWj8ZXqtgG
	1Lp6TvY6ygNzlHSJb1twDsB1Z1grCA1PifIHvWcUsr15Va9VxPONmOlzJaN001XY
	ZR/BtS4tSggHCML0vqcVKi7WsamNYF0LeNtG1JkOiBAkDHZTY5XvxLO6Vexz6TXU
	s+UkPbt7mk3fmeigWpwiPE4ubMYFnWHz+FiafFZs8LlISksrOw+uBhWmUtPI3/AU
	5su35fuWTC71pljdm2tnrnPz4jzdWd2inOCSFgbU5MOuR8D66ptIl6fqV4eoD0Ph
	Yvs0p5OZJyZLyhbdK4YA3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpt63g08a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 18:41:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624HaHxF029777;
	Wed, 4 Mar 2026 18:41:28 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptc5mma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 18:41:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8n43cxQb5AHv/p5xBb53NBVB0GKdPBf6YtazZCZvKEQrrygH2zsw8DC3P5wNvIzj+rQs3YBqos4wQFiNl/vlrriBR0EZ5++sLv/xh7EoSmMRI8++/u5KSRFyNM3fCZC11Oqd0ca9ZdwOWCxHRUoTNs28yYSELx9wS+TNUNMuJQrr60T5fHmTN4LjnJu5RQdSVSDOz8HJYjdtfwIR5lvDv5yRGeh5hc65rtKAdm6aMOvkqv/IFnWgCue10kH2CjEZuN10r84zNlSDwKgMNnsAAWJW7MR9oz8pEckcdw1Ugr75kX5/ZiT37wl4njvgHETDuiwFv/E5OiGK8wDaXU1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhu2h9E0WrtS2KCKCcj2Wwi3/l3SfrrbFTg1GWaAGgc=;
 b=O2DD2+DytbuHG/ufTVRp+chYrSLxDuf+U3E66gnJKdu5Dts7cl62W8z4CumiItfEvgjMmy/AKSEsH39cVQJ3VUJGKFoGcY5fqOFiUp3fykC5ATybB6IOKAfQIAcm02uTpeVx45v9JWw2b6oUYSxCSrW9L7OEJYNVvyQF8Y5oZF5I3aiVmlEevgN8n3uizASQpudlwGC9Q80eZFV2MZyBhvEimLa8NYZT+PvGT8NSekebIxXuHJoR74IpQoh8ESd6DMKQUypFco5Hqqn9Gmren6KfLpg9ZDORR6VE13ZgLPMuMIbtRT15gQNN67Nv+xTyjPUeYvlHzAHI56xmV1n6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhu2h9E0WrtS2KCKCcj2Wwi3/l3SfrrbFTg1GWaAGgc=;
 b=CsDz7T0E7TztHBJ/duGZPv+Q2yWiomt9PuioUNJI4ZGBFyC5taRByPp/tGYXcVZOFO4edG1I3+z5CJfAEEli0J7q54hmXTpXxoymBNzysgcO9Ih7gGoVLVcZmBaclnagPW7jjKYr2o290NeOao7AWkq3HSM3ykpjeE8w7o5WcMU=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 18:41:24 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 18:41:24 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 2/2] selftests/bpf: tests to non_null ptr detection using register operand in JEQ/JNE
Date: Wed,  4 Mar 2026 18:40:58 +0000
Message-Id: <20260304184058.180310-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260304184058.180310-1-cupertino.miranda@oracle.com>
References: <20260304184058.180310-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: ef40abeb-4ed2-43f0-2376-08de7a1da2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	Gdm81ZKzL6rWhukDl25+1NILkEoPJdB2j5Sbzp9U/Sz0tVtbW03nd9a3g/JiLgVcm2kXYw8N2xPxR8lCtnz4mgcSVELqWRdzuk3ezNmdirC0g20qiviTm7hqYe39KDcHzVPZcG0pKE9PpR9vrUc4wnukzIjYUg5OIzHkFmVsv4TrlKwT/F0cnWuFtDu5skjh7zKAo/cUkZh2OUCJaDZhcujifbb3GnzAhNufPmFqsUDa50xcciEqjvgLQIvxbCHWexiSQzoTaDi/C5HLwoiDQmgrKHNa6FQ4AYctIfncfZiokmkroDfeZh071t6rSii7q5twC3qgEU1bI9D8pxcp49G+z94VnoUFsa+UOoZ+2Kok69h5EbcR0eyZ503I5TGH9eOa0XSxKyAUCgM7SFMU6gsdGMkeLEaQ7srBldrcjx+nHUZNQ9f6EVhuNhnHDAJ60qa/KqxvUpLU242LkCzdFW31VgxS6I7lsiQXMAkIBxZHYbeyOt9fNy90b3dR5xEur0O5QAviP1d9LJaCpXGHvIR1iGcdNoWdbvtHGHm5mzXpCyXaA/b7gg9D2mQ8STwWnV2jrWOUMEsZHm9K18R041ltTn7gFqMBMxtgoCOcgNQjoZv5rw/KgRmIURwQzCep22SQPAc1GlM2c97Nbcw2wzy5hin3yMb3kvtad9pUsU2tY2g+Gx8KWxAgiyxtsqBhnnkANEbCvxhgl8gnwFfdQViMkEGcaXYHQJ2JFsidpCI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WFtkST/ivtUwD0GSL5VBEfsDVCQUeCslVdQzMIk40CVyBgQ07t1Haj8aTgnO?=
 =?us-ascii?Q?cDSthzc/w9i0QoQiQaOxaG4Ta088yAjmecHA9uxUjQOSLAN4GGt6vMa51/gq?=
 =?us-ascii?Q?yiP2OfOy5H7Ez4bM1xsoVgdlZOzfuEJGGLNPxLMx6T512y4pkFP+wRWH5FrG?=
 =?us-ascii?Q?wUWEQW0mlV2JcrV+/e9TydPYoua9oXQCbV5vgu/+JahxW0VpL++L++hWkufZ?=
 =?us-ascii?Q?mzDVJSNwDTL8Lv3yBFdKhxsqCQuwuOS1tnKYnfWkkbdaf8KBSVdI1zGJCNKH?=
 =?us-ascii?Q?ke0GmSSl9R5xfuayzrzBJxqR2TahKHkVPAZmcgLeWLov825Sh2NwHbouNIK9?=
 =?us-ascii?Q?JSOYmWxgyPFR0LfgLOCoQp1O6+huJZ6tNHi71f92DWpDCRq0NDp471u1/e5s?=
 =?us-ascii?Q?2Zmv9T2GtnD/+6Ko7IAJV1jAxdTDa2W+KZiumpia3/fezS+s2xaKAPCW5uWf?=
 =?us-ascii?Q?pgjyBh7TP4K1Pehk/3YJd6ottOMv8Fqo7nJ49r4Dn+Kxafimp0RUXmthopKj?=
 =?us-ascii?Q?AbTuu+0WqsH1UvtmVuP1X5TW/pP0LQm53qZak3EgBkFmtJuZsxmn6wKRbDDj?=
 =?us-ascii?Q?/DA2wWLmfqaUPVUuqKu/EQ2ICkiR1n9C2Luj+XJHAvojK2v7TqXRzb9FTt4X?=
 =?us-ascii?Q?Yw9zR7d8OjS0BEXCnKvKYG4lqGg/FVoNH9FHZsZ8S3fbp6D4mgWK1CKlsye/?=
 =?us-ascii?Q?/qTRNqp/9FbL9dXiClzPmfZZVpWcz9HZqK3bhn9r/rI0JBTRW/tewURpr/sd?=
 =?us-ascii?Q?NTkR3VI2G7Uv5AhxdgE3+Lu0JbpVLgH9lnfZjPUl8aleCluCoIlB5pgGaMXo?=
 =?us-ascii?Q?vA/haUorXu1H1YedXqeLbhewrfWBFno+pFOautb3OXM7AlQ8fvdEHk53wadH?=
 =?us-ascii?Q?3BPk33SZPdFTHuzpzYntDSdlpJKOXfHQHrCmCdL1R+kr6wwhjlg+pFeXFaFj?=
 =?us-ascii?Q?PamqCdGX8vu+BBwbrzsqTLTKqResWnV9bcInaXTeXz9pYUx9hj5VenL/4NXz?=
 =?us-ascii?Q?IiIf5cFwOVS/isdi6Dh+qwZ69DnmmaosN/nIf2dE0BQR7xECNRLCz2zTTNZe?=
 =?us-ascii?Q?hFQlD/jSV0mcePBaBwGP5/imu8IFjxPwwrNK39Jx/G8lCnz6K2gp/5aN3wUp?=
 =?us-ascii?Q?20ppjaIsbzgqDzHIBpP8iHXmb4u4G2cv792NIIz3htGKRMpzHXac6gL9PNsQ?=
 =?us-ascii?Q?pd3yQ+tZ5yVo1PiL8jmMpBPlnNz6qCmNweduf/XC4IV0LXaWFAJ6r2HHvKwZ?=
 =?us-ascii?Q?kQxs5uERVCmTGtU+PUlmPsDtTgUwrlM0OcuNJnfkWWoS/zVp+kx+fmuKk655?=
 =?us-ascii?Q?BLpRQlpfFSI3f61aV3158GSAtQj6GKmNro5diSCvX3C5LzXSv3JZ+oNGimXm?=
 =?us-ascii?Q?xMCeoqCMDoSmkdO6OWWcmML+EqED/prsH134Uoam0GkzjypxM4Vxij+divyD?=
 =?us-ascii?Q?p0rXGaTZ78pzouq/1rHD0lPn6NadVELnjNOQTxpog4dJDa7in9aCeTkEmilT?=
 =?us-ascii?Q?Wd2g+agZMkQfvs80PH47DatGlCLRsuFUIBpIk4cRtLdUeiFxsmCz8u8s8ivc?=
 =?us-ascii?Q?A0q8ofItV2XjkBusfSY07HUokMfPAUgUjoikqBEYxbbW420wtRYv/6RhdUvj?=
 =?us-ascii?Q?5fLLiB4v3nFUkwOyEmIJZXdvlODFtdkS1txJWyVokuANl49jB+Y62MXZq4Wl?=
 =?us-ascii?Q?mnnJ5hDOF46MAdbUtm3EyacI69JgwMSyRQi5ZU20fVXlkMNcY6TjTb+sQCVB?=
 =?us-ascii?Q?TVM8I/0bPlkV8lE/AkH/S7nFQbVKCIA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xrXbWAu40zlCqrXcvEshyyVq7jJw9CErFI+FeQZqWShB9fxsz1APAVbE4XUisjgXidu8bMluOfkyu44GlpQ4EDjs+6KIsKtVml3eQb3yoMrQUiT4rUzi4kNOpzyMjK2PLNeTfipV+OlAppld0f7Ojy14dkSvi5QRyZpHwhMcVZ4XRmHR6lUuHKmc3bEkJBp8nPT7kdD3R6YJGXfu0OpYKQoI1X9TUtTBcD/f0dVKSQMRz+Lq/qz7yCYIE/APQhx0yXXdELdVRzUsCYhUamxnZaMdpgWRvTgfi6AD3zRIJpxI6j6tRCnLaaaSZZ5Gh03txQsmYN3aGuvHE2aHdsQ54POzCk8UGzoZUE7APzdAk8JUezOxJa+Zd7oBM/rJr4YdHbK9Tcu+84lri4/xpCsJsLJRqbM8I6FIPTRAGMvzg+b8oIGw8PG8+57+YkQWvvslbvLHbH4r5AjIySnzR1M7htYAVZ0V6XvJhZ/X/MIuhtxq8p/odaZWJeT/rnA+1+MLA58ueuyDZF5ST6zeGF/mtwTLQkbdtPc9a69OIF5IU3mmeJesLxgb4lQfezszlnM08cUXdNLnKpeEZWAfAi+HP0AUbLdS2PwdmqbQ2qyu/+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef40abeb-4ed2-43f0-2376-08de7a1da2cf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:41:24.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWezE+WO6g9yyp281CkRtzpWn4Hr+8mE2M8ODD/578mGTmwXikmFTgjGmrm56Fwsa2F+RmahbDCriGdoIMoY7nHr+f7UqoSfCwFN29/9TvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603040152
X-Proofpoint-GUID: RhqSaDPX9g7EgPlDvcJA-EKotpEjXNs9
X-Authority-Analysis: v=2.4 cv=Lv2fC3dc c=1 sm=1 tr=0 ts=69a87cd9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=sH-hGKWHxpH7UWFcF14A:9
X-Proofpoint-ORIG-GUID: RhqSaDPX9g7EgPlDvcJA-EKotpEjXNs9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE1MiBTYWx0ZWRfX5kHSrvbfSL+1
 k875MpSixg6ZCiNWM4MqJBDMUXhq9lq5z/INBCVSthO9TjX3TefwAizTZRldX2REMPCAuUMEJ46
 r/BGHBuPhMhx+MHE/+ibMXIeb+IyP1LlAD+MLZSq/07m8LTAz87cd20G4Yxn4vh8hhccctNV+B9
 +PTk+I/3edAPRatffIodd3GxaeJLyZba+m6/fbEgXhkXtcV6fNt2q7PKwAM0OID4kWkf88WsiEE
 vGhgKme2fnjhJakB8NKaH2BdwdrsrYrTZqlXWdAFNOpUM4xoG/varQ4eiofwR5ERHeFRWwbm09A
 CepRr2yjVzrUPzthVj9AGTn7mrHt200Wu9JzCtEux0KtrxoborSJEXSIlOGZuT/dWB8dhbFhaRc
 /NpwgUOVFIkvsrtYL/vYKJdL3FF2CE+hhI+6og8JthWnolYYCa3rlNiAgE41f36n0oRiQz/qklJ
 l5egs3QuxAUgUeAnO/w==

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

