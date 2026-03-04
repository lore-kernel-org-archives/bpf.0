Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2137F72B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649686; cv=fail; b=Ta0Vk6bO0P+l4VhZqGRLmlS2Tk8McxByPffY/t359FfETGR7FblK7/bKTq88QHNdaVUHfQkTXli60P3Rmy9GpvEW67WzMEm9Kl52rL6y3VtwaBuE3OKolpVGrmi+NQf091VHkJPMJUswnxUWLvmUDDmg2o0bKMQFRhMgc2QDPLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649686; c=relaxed/simple;
	bh=aLxjWFfnL/v/CYkCJM5JzO5mebmdHAkbIqJFbOvPZbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=am6w6LEFw7b+cbALYAcvGLI0Jn9srwJg/9BWNTxa5Ta08UI7R5KSbMATdwcjhbNdJ8bC1DYQW2MqKyyu2mgKByCnE/IKp8MKoaCPQk/3ZWxFJ4+W4i7SQtctgIULESe7phpJouWenFhZ2PHF1PsWmNMFnHjkCfxV5WuP8c4wqOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MR4SPgFA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wHStMAcO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MR4SPgFA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wHStMAcO"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HqKA2412089;
	Wed, 4 Mar 2026 18:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tAF0SKpboitN2o+0zlKyjgF394L0jltQXEgvWPtsAZw=; b=
	MR4SPgFAnlHaQTTy225kHfe6W8qq3H32Vuf+eAW2kAjJLqGpz+VTgYqGbMM/NLGv
	pavFEqnDoKaPcoxMnF5atrtbXcOQyMPzAsHkCk9iI8dqKfNN85eMlCV+EXoaLfyM
	jlRl/UKgd53f9JF4SPpWVzcKN6BVQZuzjx05uV8NsYDrmQWrs/pvfrQNh2Cgnzfn
	WAp5QLsJB1vjamnKabDStJj5wL1JJ/CzstgkJhYvFtd+/58KLnwMv6Xy1ssfSgwV
	yMFmZaEDiky9D5yySjeFrUHM8hjFZwaELwAIxGZatpCD3PDDsOLdfQyLtBpIz6v0
	+9TjBhGzV97uhi2F+qTsSA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpsgy82x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 18:41:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624HA3mb001438;
	Wed, 4 Mar 2026 18:41:20 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptgfmb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 18:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgQYjNV69K/3koA1gVIH9eU0pnAXQFvNsEf0zxORGGYRFjJo8JM8MXX5xNcu4yPH8uz6fueuwksLCzovylGMhaEB2pt6M+ZN+ptCQIhMsQaHjMjoTTEHb2Z3UFSuE9Q3hmsWIvGk4npP5ZUR/oR4D7BPu+zK0oz7Vl1AdEZY42Vpn53YDO5iMh+vMjmHLc3jf/CdLWoSOllQitx9qe/haWIpSeStLbRksIyjaq1ohWZmcvpsu65FvmyUg2nii7JbJm0UCGDP7qwd1QZnqBqW5v6PEKc5w6EIyLuwy061XAIu56Y0n3Kb8x4d6lYyF/WluA1faHNjSCYC6mkY7bFNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAF0SKpboitN2o+0zlKyjgF394L0jltQXEgvWPtsAZw=;
 b=ZIrRw9utCajy4kKX4IcvLlnV+i2zmM1Tz/vdnUggjBz1/xlekoLfWbaFdiapEsv1h+Bz1kCuQWW16suo6CTzIRltHi5OymKqPmKqo6owUakKMXVEl20DvGARPItuQcY8NaExfpS3aCY7ejsG7FpTBPBkxORB5quut8I8k7oIRp6sIbmE9DQKs59OavhFUjWUKcXxg3slbV4UnGiH1WaAOr/q3vPvKuj9iroCthh1a9Ja35NXLGfYMqKQwmnoaaKPM8QiVbpisc55B37ZGBj8tTFsRUVzDdt5m+xfheuZbkeZfoY3OrBg1APl7C/ZeckkU/lwK+P78C29nk3TS57Vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAF0SKpboitN2o+0zlKyjgF394L0jltQXEgvWPtsAZw=;
 b=wHStMAcOr4iQejG/0BArO2xecp8g63Lws+mc2TqcWmLcW8dQFjyumwGXNQWU892XVXbnMFyohUa5FPBOOlGCGRnaqGPp3D10ijYbZWpHqFz+pOvLYMHi5P+BOk5aSwMjtldmU3YF3u785TWdSUWZcEul+9ohC53X4djvzx90yUw=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 18:41:16 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 18:41:16 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 1/2] bpf: detect non null pointer with register operand in JEQ/JNE.
Date: Wed,  4 Mar 2026 18:40:57 +0000
Message-Id: <20260304184058.180310-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260304184058.180310-1-cupertino.miranda@oracle.com>
References: <20260304184058.180310-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 923a96a1-6e53-423e-d531-08de7a1d9de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	+fBAAOlq8hxkvY9i0J1ZW/osI0jfkK73fGCv2h1dOse+wGgiyck1OJmSFYukMA0O+caETVyA4KFW4z7BcOAxuN8VHSBLpR4GhbwXuRwYREW4YQBoebHfKA+GsuHr+3MlemsJyxrparZgwDd613AaT+SpdmH8Dcu7gej+QUZzaMqRIX4BAezzHhPc5+1/uO+bdX1tUsVq0hmkqMIj0TMmM/axekpF3ZdONhluV4p5w88YJCmsHpHeE5JPZGVSagTzBoQXNZbQIvlMo+B+kRV84IiO9Z/eQtYWVAeYRqk3HUZuTBttbjuKqL6UY1nzqfy7YTVoESOsJnEtzKVIQR6Jt13F4E6y8UwH6soGbAZGjhWzUYcDaDZ6N01ZOiIuURCDw5+Z5mC+aR6kDyVrRUEZTQF6I/ukg3w7whfAX4qrFMkbrdfOUclD6YrcR2O3uzPb8sArriAxrwWPeD+D264RsE+rpATPf5MuLflSVf0bHrpA548/oXSEYZWAYRLakzl2gP8igTfMUEkcmX9tPnb8O3MZDoopje3zp1GkEXmvxaErzT/zYQwA7RwV4l83cZBujIpLyi2K5hbcnlOASwDW8jcra5OriSP+6kIhh9QhJ3rIJpf1jmO5yKqTXx1cJZq8M7g7Ywrv2YpGuHjqDT0syuJsaTXYg4FaNCuJ5B2TVPWNWMtJMugm+7qL/5/z6U/BHHxNxHPvEkryRFB9tan28cZj0jTBFHXcFdv+Hxmm9ow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UJsxvobLIaQuR+nG1TEUTTC+HoXA5Nls8vSoBPDwJ+f0+XiJn++AEHBASUge?=
 =?us-ascii?Q?jgSgfS8S39jJoi7vuLzuhiJ0Zz2UpYF5Wi5AOQ/Qf+7KIlSbDwIhXAwxsGnB?=
 =?us-ascii?Q?EDKSiNtFiCGKAEvqUEQ2xS56/2CyWIDIFFZfc95HwGPsX5U4W7oplNRwMd3t?=
 =?us-ascii?Q?uFOmaTJH1MgqohBMXqYEF7WvTXW18jJNmMikX8s8MBJpD178HHgfZ9/V/nuw?=
 =?us-ascii?Q?lhZSQxfHHWOxttLl60j4z6kdmu5BfLYIgvrxcC6+wHXMG7Eq9qc+d/OU1Vek?=
 =?us-ascii?Q?ar1npvXPhCLWMraPPLF/2mYAN2Cm92nfuP4gfNg3zEEj2P+F+P82OnDrYQaw?=
 =?us-ascii?Q?+KfmWxrE3VV8fHA+rs1aMbdIzTWdWairvUo3xxYoBeCAvMPJD6VyMt60ioJo?=
 =?us-ascii?Q?kSY0Cghkq6sOxo1Pw6Ux8panDx21BWqyI5MvIpVjy5r/iEXvp3ttTRzx57iJ?=
 =?us-ascii?Q?HqjfT4XgQ60So3SXfypZhVLKtWCRuG0t2F6VYogy4jE8px0Si/klbzZFay2l?=
 =?us-ascii?Q?8ccrh7dTVyzZVoqmGmyrOKZuxJxSXpKFvkKq/8nenf+3zJYnjsYm3IcA+1yf?=
 =?us-ascii?Q?jqL8jb66H1lzNFW+mvWO8KggaV5UBftdsDDtP1Lt1Rqd3QgEoSmbLTtQzJav?=
 =?us-ascii?Q?gPHo4sNAVdfMMsDyhbwGfEw37t5TSLYuyZPOSpdM1gqfSB/GvPoq7osWzHds?=
 =?us-ascii?Q?vZFgC1ssdhFCkORT3nSONQa3q6ka0iHsXEOp/8R3L4FCaQNi5vuoRzcLQvmT?=
 =?us-ascii?Q?wIDJMk5VdFqOnr3FYfOLZkFBaxtWBIKdLg+/CX4FSMPHo25ghHnH0IDc73/T?=
 =?us-ascii?Q?7dc5Q0eoSMLMcdCpmWAfCIKmi1+cP6cTUFM+scCp6nX4cxRVWwJBKSNCu3H3?=
 =?us-ascii?Q?qy1+6xkZpTxS2ZR0W93Gx7P49Fvoxy1Q0Kv4qu0DQwKDiyFAA+TuXxk2r0Z4?=
 =?us-ascii?Q?/9SelFBpixYedE84g6nC+L/J11XCzjXc7p5SdlsT42rvIH9Zqspt6hYJQYUb?=
 =?us-ascii?Q?kSyudNYk6042yZjt+zu7LCvqYoJI4lmM/PUNKBlCetzwSOr7qAhmq+K217w9?=
 =?us-ascii?Q?KcCOrmUTFkSzfqcSoX6fpn0Ksbz/zi8gr709zW9vDb0N0za1hiJfW8C71Cha?=
 =?us-ascii?Q?GWFRhO5umBORe/Gw+pPXeeUgaU+rXPEUey267tWd2XyP346k280uR+OQMCdq?=
 =?us-ascii?Q?YD34n5rprSLQuBFI5fZ3ABHt1hW1ewfaNJ+20eK0NtLGUFAa9sn9GduBw55U?=
 =?us-ascii?Q?lAvwkQGI0F80zhIVHNkIZBYwpT10yX2a2hIICgs52Fkb6D5uC7PjE8VIhd5G?=
 =?us-ascii?Q?aCe/WfXvSXZN/XE/Qt7nUmGKXLL30bdPpD9+MQAFWAtZRDCNzy6gzQnuQnVq?=
 =?us-ascii?Q?saO7j+eiOh4VmYt3u4hfwTlYXp9s3/dZgdRP6elppztDzhO990kDTU8gwsey?=
 =?us-ascii?Q?XbKsh5HIixODmo2Ac4irm6QouBc8hLeMY54moRJMYON8VL1ax7gPquZu0zyq?=
 =?us-ascii?Q?Zh1NbLy5G6tgizHS2DyVuK23RWeMiFEwtYFtDJ9Vgzkc9MQQwBFfOL7b6v/e?=
 =?us-ascii?Q?d8zUQDkQsVps2q9CsvCDn5Ziwo9TfUlc96dWDShvPmIh33UgDLPS5Qq/6R1P?=
 =?us-ascii?Q?IJzoqSpCs7oOCCUOBPIklKqYuP25ZS5ZWEFu4Pj7fraLUYTIYzsrdJtiTlYF?=
 =?us-ascii?Q?G/1JO5MWeNzSBqlDmXhGRsaXcQi935Wn3X4Ixb8BteZkXbWyJ3hiaZRlStj2?=
 =?us-ascii?Q?FhSVeRYEAEug4dc+382zYKa+Bm+T4JY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	77AZ603bD2qLzqOZ8y9lSE0LtW0uyFL8EKI2nrzN8Wx9+wdYbJIPDOu0WRmh0S4Wa1A0hzJGN7di8EezKScoSBGJ1fvfShhXd22zktjC8Byl7Gw66EeBb30iN5qjpFUlFi0pia7bNGNR/bm/TKLcDEyme+vyMgGa8uqGGJKTsZefoUKF+n+scsIuajFVNm/tHM1ihtu5JcKMCqcR5N8N/RCg7hlLjsIhls+0eX964HcmJXBQnFySAZrszCCazR8QGTTmgSJnswCASxvHbz7lpX759Z28aLVvo94URPoLBP2W8h+a/cUFZCVqrogLbqfUeXx0OVnm8M35oy/QzCygI8YAhVLEDUhkgKTUEuDZg82Cgo7DpIqZpiUsf1MtcPyfsSXNIWDquMgK+t6eevZPgxATo2mHrspq82cCptcnnZDUKk8UdTt/iqPRSxE3rTJrxfvEOtBbsmb6PHGoBP7Zg8muwcOLaOQGtLTghTSCDw0XpflAU4CBXfDCtR7JQP72+4YU+8v6u/Jt5Vf8GuZ8eaDwRpniF2mHU1u12yva+eawTJrtSd567Mu85SFqw0yszqeCjqp9mff3ooFnmDq14esGRDzNUcB5Wv4q+54ZI8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923a96a1-6e53-423e-d531-08de7a1d9de1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:41:16.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnmxC/31U+ZrkLPJSRMLN9OTC4iocHbB5+/GY8mB5Pg3pVFzvkox103OUWiIJ2UakHs1ePA3sRy+/KSQfboc7Sq8fe2aji5iw5FD7mebUK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040152
X-Proofpoint-GUID: Dvj_cNroWaWcqEom4va647l1n2Z58C26
X-Proofpoint-ORIG-GUID: Dvj_cNroWaWcqEom4va647l1n2Z58C26
X-Authority-Analysis: v=2.4 cv=EIULElZC c=1 sm=1 tr=0 ts=69a87cd1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=zH4VN_oi8f_2PAip9sAA:9 cc=ntf awl=host:13812
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE1MiBTYWx0ZWRfX6XdME9INzi5d
 vXTywwF/qVo5MtS1l9GI/Z/wFlprwfTEgHW933FeWdycRSuoq9AuwjonqQdREdzPrRBZt7nv6y2
 QVD5D4S7uhB7beLdzkZKazP+61QD+wG0eyy29CQVOeSs+8MlsUv4Ntms1QLgapW+CUOnKe4qhLX
 TmvZgDO6LoQqWIcHBwqOMjep1du44zelXhStgS1tBnHgu4mQideLIQOA7qWd+TWXoyhTdtaMNIx
 46WJWd1dxaALFeZPWa0GPtIRItGc5D5T9TE9UgiqrA1f7zgVIqMoS8ZbcaNgv7NExUxP4aobms2
 7jjQkXHdc8YqEMry6BEig35XsPj8Ekqf80MF4ml8mCV1ncvflEbyJu00Jkmqa6I85K84A+7Zgm2
 1m6lpuF7gmumCLFIqRu877z7Ah7SXJB1Zm6Tr+t87t+7juJI/JVu7i4N5DkrHYsoanHADU0qkWF
 Ut8t1tntfm90rxdip5ZrgpU2gyfeRl3GMfaPPTxU=

This patch adds support to validate a pointer as not null when its
value is compared to a register whose value the verifier knows to be
null.
Initial pattern only verifies against an immediate operand.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                         |   9 ++++--
 tools/testing/selftests/bpf/log               |  28 ++++++++++++++++++
 .../bpf/verifier_jeq_infer_not_null.bc        | Bin 0 -> 13560 bytes
 3 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/log
 create mode 100644 tools/testing/selftests/bpf/verifier_jeq_infer_not_null=
.bc

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc4ccd1de569..41a9a99ba7be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17608,12 +17608,15 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 	}
=20
 	/* detect if R =3D=3D 0 where R is returned from bpf_map_lookup_elem().
+	 * Also does the same detection for a register whose the value is
+	 * known to be 0.
 	 * NOTE: these optimizations below are related with pointer comparison
 	 *       which will never be JMP32.
 	 */
-	if (!is_jmp32 && BPF_SRC(insn->code) =3D=3D BPF_K &&
-	    insn->imm =3D=3D 0 && (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE=
) &&
-	    type_may_be_null(dst_reg->type)) {
+	if (!is_jmp32 && (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE) &&
+	    type_may_be_null(dst_reg->type) &&
+	    ((BPF_SRC(insn->code) =3D=3D BPF_K && insn->imm =3D=3D 0) ||
+	     (BPF_SRC(insn->code) =3D=3D BPF_X && register_is_null(src_reg)))) {
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R =3D=3D 0 or R !=3D 0 conditional.
 		 */
diff --git a/tools/testing/selftests/bpf/log b/tools/testing/selftests/bpf/=
log
new file mode 100644
index 000000000000..c846f86c5642
--- /dev/null
+++ b/tools/testing/selftests/bpf/log
@@ -0,0 +1,28 @@
+
+Auto-detecting system features:
+...                                    llvm: [ =1B[31mOFF=1B[m ]
+
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool btf dump file /home/tino=
/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/vmlinux=
 format c > /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_=
test_in_chroot/tools/testing/selftests/bpf/tools/include/.vmlinux.h.tmp
+cmp -s /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/tools/include/.vmlinux.h.tmp /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/tools/include/vmlinux.h || mv /home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/self=
tests/bpf/tools/include/.vmlinux.h.tmp /home/tino/oracle/playground/bpf/deb=
ootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/tools=
/include/vmlinux.h
+clang  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian -I/home/tino/o=
racle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/tes=
ting/selftests/bpf/tools/include -I/home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf -I/home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/include/uapi -I/home/tino/oracle/playground/bpf/debootstrap_image/pristin=
e_to_test_in_chroot/tools/testing/selftests/usr/include -std=3Dgnu11 -fno-s=
trict-aliasing -Wno-microsoft-anon-tag -fms-extensions -Wno-compare-distinc=
t-pointer-types -Wno-initializer-overrides  -idirafter /usr/lib/llvm-19/lib=
/clang/19/include -idirafter /usr/local/include -idirafter /usr/include/x86=
_64-linux-gnu -idirafter /usr/include    -DENABLE_ATOMICS_TESTS   -O2 --tar=
get=3Dbpfel -c progs/verifier_jeq_infer_not_null.c -mcpu=3Dv3 -o /home/tino=
/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/t=
esting/selftests/bpf/verifier_jeq_infer_not_null.bpf.o
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen object /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked1.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/verifier_jeq_infer_not_null.bpf.o
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen object /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked2.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked1.o
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen object /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked3.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked2.o
+diff /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_i=
n_chroot/tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked=
2.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_=
chroot/tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked3.o
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen skeleton /home/tino/=
oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/te=
sting/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked3.o name verifier=
_jeq_infer_not_null > /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/verifier_jeq_infer_not=
_null.skel.h
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen subskeleton /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked3.o name verif=
ier_jeq_infer_not_null > /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/verifier_jeq_infer_=
not_null.subskel.h
+rm -f /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_=
in_chroot/tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linke=
d1.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in=
_chroot/tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked2=
.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_c=
hroot/tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bpf.linked3.o
+bpf-unknown-none-gcc  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian=
 -I/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_c=
hroot/tools/testing/selftests/bpf/tools/include -I/home/tino/oracle/playgro=
und/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftest=
s/bpf -I/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/include/uapi -I/home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/usr/include -std=
=3Dgnu11 -fno-strict-aliasing -Wno-microsoft-anon-tag -fms-extensions -Wno-=
compare-distinct-pointer-types -Wno-initializer-overrides  -idirafter /usr/=
lib/gcc/x86_64-linux-gnu/14/include -idirafter /usr/local/include -idirafte=
r /usr/include/x86_64-linux-gnu -idirafter /usr/include      -DBPF_NO_PRESE=
RVE_ACCESS_INDEX -Wno-attributes -O2 -c progs/verifier_jeq_infer_not_null.c=
 -o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_=
chroot/tools/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.o
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen object /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.linked1.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.o
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen object /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.linked2.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.linked1.o
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen object /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.linked3.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.linked2.o
+diff /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_i=
n_chroot/tools/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bp=
f.linked2.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_=
test_in_chroot/tools/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_n=
ull.bpf.linked3.o
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen skeleton /home/tino/=
oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/te=
sting/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.linked3.o name =
verifier_jeq_infer_not_null > /home/tino/oracle/playground/bpf/debootstrap_=
image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/bpf_gcc/verifi=
er_jeq_infer_not_null.skel.h
+libbpf: elf: skipping section(3) .data (size 0)
+libbpf: elf: skipping unrecognized data section(9) .comment
+/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/tools/sbin/bpftool gen subskeleton /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.bpf.linked3.o na=
me verifier_jeq_infer_not_null > /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/bpf_gcc/ver=
ifier_jeq_infer_not_null.subskel.h
+libbpf: elf: skipping section(3) .data (size 0)
+libbpf: elf: skipping unrecognized data section(9) .comment
+rm -f /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_=
in_chroot/tools/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_null.b=
pf.linked1.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to=
_test_in_chroot/tools/testing/selftests/bpf/bpf_gcc/verifier_jeq_infer_not_=
null.bpf.linked2.o /home/tino/oracle/playground/bpf/debootstrap_image/prist=
ine_to_test_in_chroot/tools/testing/selftests/bpf/bpf_gcc/verifier_jeq_infe=
r_not_null.bpf.linked3.o
+cd /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_=
chroot/tools/testing/selftests/bpf && gcc -I. -g -O0 -rdynamic -std=3Dgnu11=
 -Wall -Werror -fno-omit-frame-pointer -Wno-unused-but-set-variable -DHAVE_=
GENHDR   -I/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_t=
est_in_chroot/tools/testing/selftests/bpf -I/home/tino/oracle/playground/bp=
f/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/=
tools/include -I/home/tino/oracle/playground/bpf/debootstrap_image/pristine=
_to_test_in_chroot/include/generated -I/home/tino/oracle/playground/bpf/deb=
ootstrap_image/pristine_to_test_in_chroot/tools/lib -I/home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/include -I/h=
ome/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot=
/tools/arch/x86/include -I/home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/include/uapi -I/home/tino/oracle/playgro=
und/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftest=
s/bpf  -D_GNU_SOURCE=3D -I/home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/../../../tools/testing=
/selftests  -MMD -MT /home/tino/oracle/playground/bpf/debootstrap_image/pri=
stine_to_test_in_chroot/tools/testing/selftests/bpf/verifier.test.o -c /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/prog_tests/verifier.c -lelf -lz -lrt -lpthread  =
-o verifier.test.o
+gcc -g -O0 -rdynamic -std=3Dgnu11 -Wall -Werror -fno-omit-frame-pointer -W=
no-unused-but-set-variable -DHAVE_GENHDR   -I/home/tino/oracle/playground/b=
pf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf=
 -I/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_c=
hroot/tools/testing/selftests/bpf/tools/include -I/home/tino/oracle/playgro=
und/bpf/debootstrap_image/pristine_to_test_in_chroot/include/generated -I/h=
ome/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot=
/tools/lib -I/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to=
_test_in_chroot/tools/include -I/home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/arch/x86/include -I/home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/includ=
e/uapi -I/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_tes=
t_in_chroot/tools/testing/selftests/bpf  -D_GNU_SOURCE=3D -I/home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/../../../tools/testing/selftests  /home/tino/oracle/playground/=
bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bp=
f/access_variable_array.test.o /home/tino/oracle/playground/bpf/debootstrap=
_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/arena_atomics=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/arena_htab.test.o /home/tino/oracle/=
playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/s=
elftests/bpf/arena_list.test.o /home/tino/oracle/playground/bpf/debootstrap=
_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/arena_spin_lo=
ck.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/arena_strsearch.test.o /home/tino/=
oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/te=
sting/selftests/bpf/arg_parsing.test.o /home/tino/oracle/playground/bpf/deb=
ootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/assig=
n_reuse.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_=
to_test_in_chroot/tools/testing/selftests/bpf/async_stack_depth.test.o /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/atomic_bounds.test.o /home/tino/oracle/playgroun=
d/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/=
bpf/atomics.test.o /home/tino/oracle/playground/bpf/debootstrap_image/prist=
ine_to_test_in_chroot/tools/testing/selftests/bpf/attach_probe.test.o /home=
/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/to=
ols/testing/selftests/bpf/autoattach.test.o /home/tino/oracle/playground/bp=
f/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/=
autoload.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine=
_to_test_in_chroot/tools/testing/selftests/bpf/bad_struct_ops.test.o /home/=
tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/too=
ls/testing/selftests/bpf/bind_perm.test.o /home/tino/oracle/playground/bpf/=
debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/bl=
oom_filter_map.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/bpf_cookie.test.o /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/bpf_gotox.test.o /home/tino/oracle/playground/bp=
f/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/=
bpf_insn_array.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/bpf_iter.test.o /home/=
tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/too=
ls/testing/selftests/bpf/bpf_iter_setsockopt.test.o /home/tino/oracle/playg=
round/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selfte=
sts/bpf/bpf_iter_setsockopt_unix.test.o /home/tino/oracle/playground/bpf/de=
bootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/bpf_=
loop.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_=
test_in_chroot/tools/testing/selftests/bpf/bpf_mod_race.test.o /home/tino/o=
racle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/tes=
ting/selftests/bpf/bpf_nf.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/bpf_obj_id.=
test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_=
in_chroot/tools/testing/selftests/bpf/bpf_obj_pinning.test.o /home/tino/ora=
cle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testi=
ng/selftests/bpf/bpf_qdisc.test.o /home/tino/oracle/playground/bpf/debootst=
rap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/bpf_tcp_ca=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/bpf_verif_scale.test.o /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/bpftool_maps_access.test.o /home/tino/oracle/playground/b=
pf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf=
/bpftool_metadata.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/btf.test.o /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/btf_dedup_split.test.o /home/tino/oracle/playground/=
bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bp=
f/btf_distill.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pri=
stine_to_test_in_chroot/tools/testing/selftests/bpf/btf_dump.test.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/btf_endian.test.o /home/tino/oracle/playground/bpf/=
debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/bt=
f_field_iter.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pris=
tine_to_test_in_chroot/tools/testing/selftests/bpf/btf_map_in_map.test.o /h=
ome/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot=
/tools/testing/selftests/bpf/btf_module.test.o /home/tino/oracle/playground=
/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/b=
pf/btf_permute.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/btf_skc_cls_ingress.te=
st.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in=
_chroot/tools/testing/selftests/bpf/btf_split.test.o /home/tino/oracle/play=
ground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selft=
ests/bpf/btf_sysfs.test.o /home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/bpf/btf_tag.test.o /ho=
me/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/=
tools/testing/selftests/bpf/btf_write.test.o /home/tino/oracle/playground/b=
pf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf=
/build_id.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristin=
e_to_test_in_chroot/tools/testing/selftests/bpf/cb_refs.test.o /home/tino/o=
racle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/tes=
ting/selftests/bpf/cg_storage_multi.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/c=
group1_hierarchy.test.o /home/tino/oracle/playground/bpf/debootstrap_image/=
pristine_to_test_in_chroot/tools/testing/selftests/bpf/cgroup_ancestor.test=
.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_c=
hroot/tools/testing/selftests/bpf/cgroup_attach_autodetach.test.o /home/tin=
o/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/=
testing/selftests/bpf/cgroup_attach_multi.test.o /home/tino/oracle/playgrou=
nd/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests=
/bpf/cgroup_attach_override.test.o /home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/cgroup_de=
v.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_tes=
t_in_chroot/tools/testing/selftests/bpf/cgroup_get_current_cgroup_id.test.o=
 /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/cgroup_getset_retval.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/cgroup_hierarchical_stats.test.o /home/tino/oracle/playgrou=
nd/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests=
/bpf/cgroup_iter.test.o /home/tino/oracle/playground/bpf/debootstrap_image/=
pristine_to_test_in_chroot/tools/testing/selftests/bpf/cgroup_iter_memcg.te=
st.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in=
_chroot/tools/testing/selftests/bpf/cgroup_link.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/cgroup_mprog_opts.test.o /home/tino/oracle/playground/bpf/deboot=
strap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/cgroup_m=
prog_ordering.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pri=
stine_to_test_in_chroot/tools/testing/selftests/bpf/cgroup_preorder.test.o =
/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chro=
ot/tools/testing/selftests/bpf/cgroup_skb_direct_packet_access.test.o /home=
/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/to=
ols/testing/selftests/bpf/cgroup_skb_sk_lookup.test.o /home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/self=
tests/bpf/cgroup_storage.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/cgroup_tcp_s=
kb.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/cgroup_v1v2.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/cgroup_xattr.test.o /home/tino/oracle/playground/bpf/deboot=
strap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/cgrp_kfu=
nc.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/cgrp_local_storage.test.o /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/check_mtu.test.o /home/tino/oracle/playground/bpf/de=
bootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/cls_=
redirect.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine=
_to_test_in_chroot/tools/testing/selftests/bpf/compute_live_registers.test.=
o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_ch=
root/tools/testing/selftests/bpf/connect_force_port.test.o /home/tino/oracl=
e/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing=
/selftests/bpf/connect_ping.test.o /home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/core_auto=
size.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_=
test_in_chroot/tools/testing/selftests/bpf/core_extern.test.o /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/core_kern.test.o /home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/core_kern=
_overflow.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristin=
e_to_test_in_chroot/tools/testing/selftests/bpf/core_read_macros.test.o /ho=
me/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/=
tools/testing/selftests/bpf/core_reloc.test.o /home/tino/oracle/playground/=
bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bp=
f/core_reloc_raw.test.o /home/tino/oracle/playground/bpf/debootstrap_image/=
pristine_to_test_in_chroot/tools/testing/selftests/bpf/core_retro.test.o /h=
ome/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot=
/tools/testing/selftests/bpf/cpu_mask.test.o /home/tino/oracle/playground/b=
pf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf=
/cpumask.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine=
_to_test_in_chroot/tools/testing/selftests/bpf/crypto_sanity.test.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/ctx_rewrite.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/c=
ustom_sec_handlers.test.o /home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/bpf/d_path.test.o /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/decap_sanity.test.o /home/tino/oracle/playground=
/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/b=
pf/deny_namespace.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/dmabuf_iter.test.o =
/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chro=
ot/tools/testing/selftests/bpf/dummy_st_ops.test.o /home/tino/oracle/playgr=
ound/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftes=
ts/bpf/dynptr.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pri=
stine_to_test_in_chroot/tools/testing/selftests/bpf/empty_skb.test.o /home/=
tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/too=
ls/testing/selftests/bpf/enable_stats.test.o /home/tino/oracle/playground/b=
pf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf=
/endian.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_=
to_test_in_chroot/tools/testing/selftests/bpf/exceptions.test.o /home/tino/=
oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/te=
sting/selftests/bpf/exe_ctx.test.o /home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/exhandler=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/fd_array.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/fd_htab_lookup.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/fentry_fexi=
t.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_tes=
t_in_chroot/tools/testing/selftests/bpf/fentry_test.test.o /home/tino/oracl=
e/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing=
/selftests/bpf/fexit_bpf2bpf.test.o /home/tino/oracle/playground/bpf/deboot=
strap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/fexit_sl=
eep.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_t=
est_in_chroot/tools/testing/selftests/bpf/fexit_stress.test.o /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/fexit_test.test.o /home/tino/oracle/playground/bpf/deboot=
strap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/fib_look=
up.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/file_reader.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/fill_link_info.test.o /home/tino/oracle/playground/bpf/debo=
otstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/find_v=
ma.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/flow_dissector.test.o /home/tino/o=
racle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/tes=
ting/selftests/bpf/flow_dissector_classification.test.o /home/tino/oracle/p=
layground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/se=
lftests/bpf/flow_dissector_load_bytes.test.o /home/tino/oracle/playground/b=
pf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf=
/flow_dissector_reattach.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/for_each.tes=
t.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_=
chroot/tools/testing/selftests/bpf/free_timer.test.o /home/tino/oracle/play=
ground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selft=
ests/bpf/fs_kfuncs.test.o /home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/bpf/fsession_test.test=
.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_c=
hroot/tools/testing/selftests/bpf/get_branch_snapshot.test.o /home/tino/ora=
cle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testi=
ng/selftests/bpf/get_func_args_test.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/g=
et_func_ip_test.test.o /home/tino/oracle/playground/bpf/debootstrap_image/p=
ristine_to_test_in_chroot/tools/testing/selftests/bpf/get_stack_raw_tp.test=
.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_c=
hroot/tools/testing/selftests/bpf/get_stackid_cannot_attach.test.o /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/global_data.test.o /home/tino/oracle/playground/bpf/=
debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/gl=
obal_data_init.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/global_func_args.test.=
o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_ch=
root/tools/testing/selftests/bpf/global_func_dead_code.test.o /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/global_map_resize.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/h=
ash_large_key.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pri=
stine_to_test_in_chroot/tools/testing/selftests/bpf/hashmap.test.o /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/helper_restricted.test.o /home/tino/oracle/playgroun=
d/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/=
bpf/htab_reuse.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/htab_update.test.o /ho=
me/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/=
tools/testing/selftests/bpf/inner_array_lookup.test.o /home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/self=
tests/bpf/ip_check_defrag.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/iters.test.=
o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_ch=
root/tools/testing/selftests/bpf/jeq_infer_not_null.test.o /home/tino/oracl=
e/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing=
/selftests/bpf/jit_probe_mem.test.o /home/tino/oracle/playground/bpf/deboot=
strap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/kernel_f=
lag.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_t=
est_in_chroot/tools/testing/selftests/bpf/kfree_skb.test.o /home/tino/oracl=
e/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing=
/selftests/bpf/kfunc_call.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/kfunc_dynpt=
r_param.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_=
to_test_in_chroot/tools/testing/selftests/bpf/kfunc_implicit_args.test.o /h=
ome/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot=
/tools/testing/selftests/bpf/kfunc_module_order.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/kfunc_param_nullable.test.o /home/tino/oracle/playground/bpf/deb=
ootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/kmem_=
cache_iter.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristi=
ne_to_test_in_chroot/tools/testing/selftests/bpf/kprobe_multi_test.test.o /=
home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroo=
t/tools/testing/selftests/bpf/kprobe_multi_testmod_test.test.o /home/tino/o=
racle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/tes=
ting/selftests/bpf/kptr_xchg_inline.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/k=
syms.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_=
test_in_chroot/tools/testing/selftests/bpf/ksyms_btf.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/ksyms_module.test.o /home/tino/oracle/playground/bpf/deboot=
strap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/l4lb_all=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/legacy_printk.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/libbpf_get_fd_by_id_opts.test.o /home/tino/oracle/playgroun=
d/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/=
bpf/libbpf_probes.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/libbpf_str.test.o /=
home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroo=
t/tools/testing/selftests/bpf/link_pinning.test.o /home/tino/oracle/playgro=
und/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftest=
s/bpf/linked_funcs.test.o /home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/bpf/linked_list.test.o=
 /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/linked_maps.test.o /home/tino/oracle/playgr=
ound/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftes=
ts/bpf/linked_vars.test.o /home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/bpf/livepatch_trampoli=
ne.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/load_bytes_relative.test.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/local_kptr_stash.test.o /home/tino/oracle/playgroun=
d/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/=
bpf/log_buf.test.o /home/tino/oracle/playground/bpf/debootstrap_image/prist=
ine_to_test_in_chroot/tools/testing/selftests/bpf/log_fixup.test.o /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/lookup_and_delete.test.o /home/tino/oracle/playgroun=
d/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/=
bpf/lookup_key.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/lru_bug.test.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/lsm_cgroup.test.o /home/tino/oracle/playground/bpf/=
debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/lw=
t_ip_encap.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristi=
ne_to_test_in_chroot/tools/testing/selftests/bpf/lwt_redirect.test.o /home/=
tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/too=
ls/testing/selftests/bpf/lwt_reroute.test.o /home/tino/oracle/playground/bp=
f/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/=
lwt_seg6local.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pri=
stine_to_test_in_chroot/tools/testing/selftests/bpf/map_btf.test.o /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/map_excl.test.o /home/tino/oracle/playground/bpf/deb=
ootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/map_i=
n_map.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to=
_test_in_chroot/tools/testing/selftests/bpf/map_init.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/map_kptr.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/map_kptr_rac=
e.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_tes=
t_in_chroot/tools/testing/selftests/bpf/map_lock.test.o /home/tino/oracle/p=
layground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/se=
lftests/bpf/map_lookup_percpu_elem.test.o /home/tino/oracle/playground/bpf/=
debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/ma=
p_ops.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to=
_test_in_chroot/tools/testing/selftests/bpf/map_ptr.test.o /home/tino/oracl=
e/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing=
/selftests/bpf/mem_rdonly_untrusted.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/m=
etadata.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_=
to_test_in_chroot/tools/testing/selftests/bpf/migrate_reuseport.test.o /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/missed.test.o /home/tino/oracle/playground/bpf/d=
ebootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/mma=
p.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_tes=
t_in_chroot/tools/testing/selftests/bpf/modify_return.test.o /home/tino/ora=
cle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testi=
ng/selftests/bpf/module_attach.test.o /home/tino/oracle/playground/bpf/debo=
otstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/module=
_fentry_shadow.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/mptcp.test.o /home/tin=
o/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/=
testing/selftests/bpf/nested_trust.test.o /home/tino/oracle/playground/bpf/=
debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/ne=
t_timestamping.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/netcnt.test.o /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/netfilter_link_attach.test.o /home/tino/oracle/playg=
round/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selfte=
sts/bpf/netns_cookie.test.o /home/tino/oracle/playground/bpf/debootstrap_im=
age/pristine_to_test_in_chroot/tools/testing/selftests/bpf/ns_current_pid_t=
gid.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_t=
est_in_chroot/tools/testing/selftests/bpf/obj_name.test.o /home/tino/oracle=
/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/=
selftests/bpf/parse_tcp_hdr_opt.test.o /home/tino/oracle/playground/bpf/deb=
ootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/pe_pr=
eserve_elems.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pris=
tine_to_test_in_chroot/tools/testing/selftests/bpf/percpu_alloc.test.o /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/perf_branches.test.o /home/tino/oracle/playgroun=
d/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/=
bpf/perf_buffer.test.o /home/tino/oracle/playground/bpf/debootstrap_image/p=
ristine_to_test_in_chroot/tools/testing/selftests/bpf/perf_event_stackmap.t=
est.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_i=
n_chroot/tools/testing/selftests/bpf/perf_link.test.o /home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/self=
tests/bpf/perf_skip.test.o /home/tino/oracle/playground/bpf/debootstrap_ima=
ge/pristine_to_test_in_chroot/tools/testing/selftests/bpf/pinning.test.o /h=
ome/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot=
/tools/testing/selftests/bpf/pinning_devmap_reuse.test.o /home/tino/oracle/=
playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/s=
elftests/bpf/pinning_htab.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/pkt_access.=
test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_=
in_chroot/tools/testing/selftests/bpf/pkt_md_access.test.o /home/tino/oracl=
e/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing=
/selftests/bpf/preempt_lock.test.o /home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/preempted=
_bpf_ma_op.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristi=
ne_to_test_in_chroot/tools/testing/selftests/bpf/prepare.test.o /home/tino/=
oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/te=
sting/selftests/bpf/pro_epilogue.test.o /home/tino/oracle/playground/bpf/de=
bootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/prob=
e_read_user_str.test.o /home/tino/oracle/playground/bpf/debootstrap_image/p=
ristine_to_test_in_chroot/tools/testing/selftests/bpf/probe_user.test.o /ho=
me/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/=
tools/testing/selftests/bpf/prog_array_init.test.o /home/tino/oracle/playgr=
ound/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftes=
ts/bpf/prog_run_opts.test.o /home/tino/oracle/playground/bpf/debootstrap_im=
age/pristine_to_test_in_chroot/tools/testing/selftests/bpf/prog_tests_frame=
work.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_=
test_in_chroot/tools/testing/selftests/bpf/ptr_untrusted.test.o /home/tino/=
oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/te=
sting/selftests/bpf/queue_stack_map.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/r=
aw_tp_null.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristi=
ne_to_test_in_chroot/tools/testing/selftests/bpf/raw_tp_test_run.test.o /ho=
me/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/=
tools/testing/selftests/bpf/raw_tp_writable_reject_nbd_invalid.test.o /home=
/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/to=
ols/testing/selftests/bpf/raw_tp_writable_test_run.test.o /home/tino/oracle=
/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/=
selftests/bpf/rbtree.test.o /home/tino/oracle/playground/bpf/debootstrap_im=
age/pristine_to_test_in_chroot/tools/testing/selftests/bpf/rcu_read_lock.te=
st.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in=
_chroot/tools/testing/selftests/bpf/rdonly_maps.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/read_vsyscall.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/recursion.te=
st.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in=
_chroot/tools/testing/selftests/bpf/recursive_attach.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/refcounted_kptr.test.o /home/tino/oracle/playground/bpf/deb=
ootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/refer=
ence_tracking.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pri=
stine_to_test_in_chroot/tools/testing/selftests/bpf/reg_bounds.test.o /home=
/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/to=
ols/testing/selftests/bpf/res_spin_lock.test.o /home/tino/oracle/playground=
/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/b=
pf/resolve_btfids.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/ringbuf.test.o /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/ringbuf_multi.test.o /home/tino/oracle/playgroun=
d/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/=
bpf/section_names.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/select_reuseport.te=
st.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in=
_chroot/tools/testing/selftests/bpf/send_signal.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/send_signal_sched_switch.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/s=
etget_sockopt.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pri=
stine_to_test_in_chroot/tools/testing/selftests/bpf/sha256.test.o /home/tin=
o/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/=
testing/selftests/bpf/signal_pending.test.o /home/tino/oracle/playground/bp=
f/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/=
sk_assign.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristin=
e_to_test_in_chroot/tools/testing/selftests/bpf/sk_bypass_prot_mem.test.o /=
home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroo=
t/tools/testing/selftests/bpf/sk_lookup.test.o /home/tino/oracle/playground=
/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/b=
pf/sk_storage_omem_uncharge.test.o /home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/sk_storag=
e_tracing.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristin=
e_to_test_in_chroot/tools/testing/selftests/bpf/skb_ctx.test.o /home/tino/o=
racle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/tes=
ting/selftests/bpf/skb_helpers.test.o /home/tino/oracle/playground/bpf/debo=
otstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/skb_lo=
ad_bytes.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine=
_to_test_in_chroot/tools/testing/selftests/bpf/skc_to_unix_sock.test.o /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/skeleton.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/s=
nprintf.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_=
to_test_in_chroot/tools/testing/selftests/bpf/snprintf_btf.test.o /home/tin=
o/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/=
testing/selftests/bpf/sock_addr.test.o /home/tino/oracle/playground/bpf/deb=
ootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/sock_=
create.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_t=
o_test_in_chroot/tools/testing/selftests/bpf/sock_destroy.test.o /home/tino=
/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/t=
esting/selftests/bpf/sock_fields.test.o /home/tino/oracle/playground/bpf/de=
bootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/sock=
_iter_batch.test.o /home/tino/oracle/playground/bpf/debootstrap_image/prist=
ine_to_test_in_chroot/tools/testing/selftests/bpf/sock_post_bind.test.o /ho=
me/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/=
tools/testing/selftests/bpf/socket_cookie.test.o /home/tino/oracle/playgrou=
nd/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests=
/bpf/sockmap_basic.test.o /home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/bpf/sockmap_ktls.test.=
o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_ch=
root/tools/testing/selftests/bpf/sockmap_listen.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/sockmap_redir.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/sockmap_strp=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/sockopt.test.o /home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/self=
tests/bpf/sockopt_inherit.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/sockopt_mul=
ti.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/sockopt_qos_to_cc.test.o /home/tin=
o/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/=
testing/selftests/bpf/sockopt_sk.test.o /home/tino/oracle/playground/bpf/de=
bootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/spin=
_lock.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to=
_test_in_chroot/tools/testing/selftests/bpf/stack_var_off.test.o /home/tino=
/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/t=
esting/selftests/bpf/stacktrace_build_id.test.o /home/tino/oracle/playgroun=
d/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/=
bpf/stacktrace_build_id_nmi.test.o /home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/stacktrac=
e_ips.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to=
_test_in_chroot/tools/testing/selftests/bpf/stacktrace_map.test.o /home/tin=
o/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/=
testing/selftests/bpf/stacktrace_map_raw_tp.test.o /home/tino/oracle/playgr=
ound/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftes=
ts/bpf/stacktrace_map_skip.test.o /home/tino/oracle/playground/bpf/debootst=
rap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/static_lin=
ked.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_t=
est_in_chroot/tools/testing/selftests/bpf/stream.test.o /home/tino/oracle/p=
layground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/se=
lftests/bpf/string_kfuncs.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/struct_ops_=
autocreate.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristi=
ne_to_test_in_chroot/tools/testing/selftests/bpf/struct_ops_private_stack.t=
est.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_i=
n_chroot/tools/testing/selftests/bpf/subprogs.test.o /home/tino/oracle/play=
ground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selft=
ests/bpf/subprogs_extable.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/subskeleton=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/summarization.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/syscall.test.o /home/tino/oracle/playground/bpf/debootstrap=
_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/tailcalls.tes=
t.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_=
chroot/tools/testing/selftests/bpf/task_fd_query_rawtp.test.o /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/task_fd_query_tp.test.o /home/tino/oracle/playground/bpf/=
debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/ta=
sk_kfunc.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine=
_to_test_in_chroot/tools/testing/selftests/bpf/task_local_storage.test.o /h=
ome/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot=
/tools/testing/selftests/bpf/task_pt_regs.test.o /home/tino/oracle/playgrou=
nd/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests=
/bpf/task_under_cgroup.test.o /home/tino/oracle/playground/bpf/debootstrap_=
image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/task_work_stre=
ss.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/tc_bpf.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/tc_change_tail.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/tc_links.te=
st.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in=
_chroot/tools/testing/selftests/bpf/tc_netkit.test.o /home/tino/oracle/play=
ground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selft=
ests/bpf/tc_opts.test.o /home/tino/oracle/playground/bpf/debootstrap_image/=
pristine_to_test_in_chroot/tools/testing/selftests/bpf/tc_redirect.test.o /=
home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroo=
t/tools/testing/selftests/bpf/tcp_custom_syncookie.test.o /home/tino/oracle=
/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/=
selftests/bpf/tcp_estats.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/tcp_hdr_opti=
ons.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_t=
est_in_chroot/tools/testing/selftests/bpf/tcp_rtt.test.o /home/tino/oracle/=
playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/s=
elftests/bpf/tcpbpf_user.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/test_bpf_ma.=
test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_=
in_chroot/tools/testing/selftests/bpf/test_bpf_smc.test.o /home/tino/oracle=
/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/=
selftests/bpf/test_bpf_syscall_macro.test.o /home/tino/oracle/playground/bp=
f/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/=
test_bpffs.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristi=
ne_to_test_in_chroot/tools/testing/selftests/bpf/test_bprm_opts.test.o /hom=
e/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/t=
ools/testing/selftests/bpf/test_btf_ext.test.o /home/tino/oracle/playground=
/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/b=
pf/test_csum_diff.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/test_global_funcs.t=
est.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_i=
n_chroot/tools/testing/selftests/bpf/test_ima.test.o /home/tino/oracle/play=
ground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selft=
ests/bpf/test_ldsx_insn.test.o /home/tino/oracle/playground/bpf/debootstrap=
_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/test_local_st=
orage.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to=
_test_in_chroot/tools/testing/selftests/bpf/test_lsm.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/test_mmap_inner_array.test.o /home/tino/oracle/playground/b=
pf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf=
/test_overhead.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/test_profiler.test.o /=
home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroo=
t/tools/testing/selftests/bpf/test_skb_pkt_end.test.o /home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/self=
tests/bpf/test_strncmp.test.o /home/tino/oracle/playground/bpf/debootstrap_=
image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/test_struct_op=
s_assoc.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_=
to_test_in_chroot/tools/testing/selftests/bpf/test_struct_ops_id_ops_mappin=
g.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_tes=
t_in_chroot/tools/testing/selftests/bpf/test_struct_ops_kptr_return.test.o =
/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chro=
ot/tools/testing/selftests/bpf/test_struct_ops_maybe_null.test.o /home/tino=
/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/t=
esting/selftests/bpf/test_struct_ops_module.test.o /home/tino/oracle/playgr=
ound/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftes=
ts/bpf/test_struct_ops_multi_pages.test.o /home/tino/oracle/playground/bpf/=
debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/te=
st_struct_ops_no_cfi.test.o /home/tino/oracle/playground/bpf/debootstrap_im=
age/pristine_to_test_in_chroot/tools/testing/selftests/bpf/test_struct_ops_=
refcounted.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristi=
ne_to_test_in_chroot/tools/testing/selftests/bpf/test_sysctl.test.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/test_task_local_data.test.o /home/tino/oracle/playg=
round/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selfte=
sts/bpf/test_task_work.test.o /home/tino/oracle/playground/bpf/debootstrap_=
image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/test_tc_edt.te=
st.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in=
_chroot/tools/testing/selftests/bpf/test_tc_tunnel.test.o /home/tino/oracle=
/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/=
selftests/bpf/test_tunnel.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/test_verist=
at.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/test_xdp_veth.test.o /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/test_xsk.test.o /home/tino/oracle/playground/bpf/debootst=
rap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/time_tai.t=
est.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_i=
n_chroot/tools/testing/selftests/bpf/timer.test.o /home/tino/oracle/playgro=
und/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftest=
s/bpf/timer_crash.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/timer_lockup.test.o=
 /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chr=
oot/tools/testing/selftests/bpf/timer_mim.test.o /home/tino/oracle/playgrou=
nd/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests=
/bpf/timer_start_deadlock.test.o /home/tino/oracle/playground/bpf/debootstr=
ap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/timer_start=
_delete_race.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pris=
tine_to_test_in_chroot/tools/testing/selftests/bpf/token.test.o /home/tino/=
oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/te=
sting/selftests/bpf/tp_attach_query.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/t=
p_btf_nullable.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/trace_ext.test.o /home=
/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/to=
ols/testing/selftests/bpf/trace_printk.test.o /home/tino/oracle/playground/=
bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bp=
f/trace_vprintk.test.o /home/tino/oracle/playground/bpf/debootstrap_image/p=
ristine_to_test_in_chroot/tools/testing/selftests/bpf/tracing_failure.test.=
o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_ch=
root/tools/testing/selftests/bpf/tracing_struct.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/trampoline_count.test.o /home/tino/oracle/playground/bpf/deboots=
trap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/type_cast=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/udp_limit.test.o /home/tino/oracle/p=
layground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/se=
lftests/bpf/uninit_stack.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/unpriv_bpf_d=
isabled.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_=
to_test_in_chroot/tools/testing/selftests/bpf/uprobe.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/uprobe_autoattach.test.o /home/tino/oracle/playground/bpf/d=
ebootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/upr=
obe_multi_test.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/uprobe_syscall.test.o =
/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chro=
ot/tools/testing/selftests/bpf/uretprobe_stack.test.o /home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/self=
tests/bpf/usdt.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pr=
istine_to_test_in_chroot/tools/testing/selftests/bpf/user_ringbuf.test.o /h=
ome/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot=
/tools/testing/selftests/bpf/varlen.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/v=
erif_stats.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristi=
ne_to_test_in_chroot/tools/testing/selftests/bpf/verifier.test.o /home/tino=
/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/t=
esting/selftests/bpf/verifier_kfunc_prog_types.test.o /home/tino/oracle/pla=
yground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/self=
tests/bpf/verifier_log.test.o /home/tino/oracle/playground/bpf/debootstrap_=
image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/verify_pkcs7_s=
ig.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/vmlinux.test.o /home/tino/oracle/p=
layground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/se=
lftests/bpf/vrf_socket_lookup.test.o /home/tino/oracle/playground/bpf/deboo=
tstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/wq.test=
.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_c=
hroot/tools/testing/selftests/bpf/xdp.test.o /home/tino/oracle/playground/b=
pf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf=
/xdp_adjust_frags.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/xdp_adjust_tail.tes=
t.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_=
chroot/tools/testing/selftests/bpf/xdp_attach.test.o /home/tino/oracle/play=
ground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selft=
ests/bpf/xdp_bonding.test.o /home/tino/oracle/playground/bpf/debootstrap_im=
age/pristine_to_test_in_chroot/tools/testing/selftests/bpf/xdp_bpf2bpf.test=
.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_c=
hroot/tools/testing/selftests/bpf/xdp_context_test_run.test.o /home/tino/or=
acle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/test=
ing/selftests/bpf/xdp_cpumap_attach.test.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/x=
dp_dev_bound_only.test.o /home/tino/oracle/playground/bpf/debootstrap_image=
/pristine_to_test_in_chroot/tools/testing/selftests/bpf/xdp_devmap_attach.t=
est.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_i=
n_chroot/tools/testing/selftests/bpf/xdp_do_redirect.test.o /home/tino/orac=
le/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testin=
g/selftests/bpf/xdp_flowtable.test.o /home/tino/oracle/playground/bpf/deboo=
tstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/xdp_inf=
o.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_tes=
t_in_chroot/tools/testing/selftests/bpf/xdp_link.test.o /home/tino/oracle/p=
layground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/se=
lftests/bpf/xdp_metadata.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/xdp_noinline=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/xdp_perf.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/xdp_pull_data.test.o /home/tino/oracle/playground/bpf/debootstra=
p_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/xdp_synproxy=
.test.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/xdp_vlan.test.o /home/tino/oracle/pl=
ayground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/sel=
ftests/bpf/xdpwall.test.o /home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/bpf/xfrm_info.test.o /=
home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroo=
t/tools/testing/selftests/bpf/xsk.test.o /home/tino/oracle/playground/bpf/d=
ebootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/tes=
t_progs.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_te=
st_in_chroot/tools/testing/selftests/bpf/cgroup_helpers.o /home/tino/oracle=
/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/=
selftests/bpf/trace_helpers.o /home/tino/oracle/playground/bpf/debootstrap_=
image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/network_helper=
s.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_=
chroot/tools/testing/selftests/bpf/testing_helpers.o /home/tino/oracle/play=
ground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selft=
ests/bpf/btf_helpers.o /home/tino/oracle/playground/bpf/debootstrap_image/p=
ristine_to_test_in_chroot/tools/testing/selftests/bpf/cap_helpers.o /home/t=
ino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tool=
s/testing/selftests/bpf/unpriv_helpers.o /home/tino/oracle/playground/bpf/d=
ebootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/net=
link_helpers.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_=
to_test_in_chroot/tools/testing/selftests/bpf/jit_disasm_helpers.o /home/ti=
no/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools=
/testing/selftests/bpf/io_helpers.o /home/tino/oracle/playground/bpf/deboot=
strap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/test_loa=
der.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_i=
n_chroot/tools/testing/selftests/bpf/xsk.o /home/tino/oracle/playground/bpf=
/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/d=
isasm.o /home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test=
_in_chroot/tools/testing/selftests/bpf/disasm_helpers.o /home/tino/oracle/p=
layground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/se=
lftests/bpf/json_writer.o /home/tino/oracle/playground/bpf/debootstrap_imag=
e/pristine_to_test_in_chroot/tools/testing/selftests/bpf/bpftool_helpers.o =
/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chro=
ot/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a /home/tino/oracl=
e/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing=
/selftests/bpf/find_bit.o -lelf -lz -lrt -lpthread      -o /home/tino/oracl=
e/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing=
/selftests/bpf/test_progs
diff --git a/tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bc b/t=
ools/testing/selftests/bpf/verifier_jeq_infer_not_null.bc
new file mode 100644
index 0000000000000000000000000000000000000000..c9093089d133bb18ad6ac73e633=
662c0c095e842
GIT binary patch
literal 13560
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
WL42tV(7Yv@?0##5)o)GN@BaYlZxT@e

literal 0
HcmV?d00001

--=20
2.47.3

