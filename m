Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23E38645C
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653833; cv=fail; b=OeZ7YYTv5XAQcPg/mGA6MSRZ1AtLyQQvteIza2LFAgAaEY82jspV8/bH51nT2pB8Aze51uKEIKPHB656I/oH58LO594uqHp1zQPVzFhD9hTVP7fWqFB4+pahzGGbIbN8A4kzzbxyvEE3pF8rfzg5BvwNe9s3mUSZf/MaY8Q6Xf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653833; c=relaxed/simple;
	bh=47lhnAZrdhfxgRe2Iwj6Qqfq9D32MqWGdafF+hX4dLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Llr7UQlViz6UFZfuys7tZLEQIUtgOwQFcfpl1YcVnqXkK6LJwVG9voVVn9EIv++FG3S7BOn4ZW8k1hLLi48KggQQnbmR4ZzGPGnnNkmVrKOx2hE0u3LJ60sizoaNX3qKKZex3MAc9Qga1TIWWpb5A1sF7Hms8SgJoCm/3l0EwBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mg1fFDIb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JPhvMf6V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mg1fFDIb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JPhvMf6V"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624JmQAv2480739
	for <bpf@vger.kernel.org>; Wed, 4 Mar 2026 19:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=NfI3qBOWCCMx5ICP
	4swlqO0vS4E2gHx3Ke2MZhOhdvQ=; b=Mg1fFDIbk+NpuiTEbMu0O3wRhKe35dFr
	plmy69V/lyMXx1J/NzisXXFc52SaL4UU0cOz9oGZETDnojsTVnXL6R+YmDGBtGdO
	cX8p5mm9wziTNqSKKZmXQBXRjGJlTgY/6qAoZ52ceKQi/MtWaL24uOz/9RJn99vS
	3UW/gkt4LSpqjIQM9gk7jO4D9N5TIoOd53mxqmc3Vr2W9vX3FKC0v9cWfp2syOjN
	LoC/SjwWtfoFpWeMwSpsCbY8aDqpZzoorvLhzibvy7D9qpgfK/90aCOdG8gcshVP
	zc6/YD40JxZshf+6bO3bCm54LITayjpzkXdi0u1W/J1fP1rFjs9rgQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpu75806y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:50:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624IJiTY034715
	for <bpf@vger.kernel.org>; Wed, 4 Mar 2026 19:50:30 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptg9dbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sF6p9pZLh5JghwSpbm49gKYMmJ8ewhtvC08gN1eMEprjb9rbISsD6OnQI/kLDdWj05b54cxdoDCQubOC7oRdOwJajSBgIR2UR3eCiRejAloq14WyQfGZsT7ojx//RXgSV+DVjtLnDwZZ+PpdlV5Scyg0P/1s8hQqHGpLgkCsi8JHkJhNT6JmriHdL9fd9Gf3Kn9F2+ekwYD04YGLkGkzxZq8tJGV5SEN94ZUxCjjIS40Nhn59mdUqOHmNserlU/phAWL+H283V7QcSeZY1u3PK7ifz7C1rJl3nPOGOGj9imiuozH41SnCj2yxGeCiBlcXrdox6TwpPMHFwhYt4XNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfI3qBOWCCMx5ICP4swlqO0vS4E2gHx3Ke2MZhOhdvQ=;
 b=twlApglh4/xVFcqQrudocYlFNQ9RTcvibnbF/TZcD1gmLclWrG6vIqbp79aip+6UtSh8DQef+BD1AsSuRdD7BKzaP+ka3TnQq0hh1tXpKAtsqxhknSOmu0yrYVrwkqxFP26oHZcMTTiqHBwvmlhuP6wOzijpwcTOGUbrUy0eu20phtxjtuDdAG6OSAoDyFD1qLei5VFjwxFeB51/vw+xHAVu4QuJHyBZngVdtjR8R22mNnRCw0C1DGnpZEQE0gHojxSUxc5nwmwJfLz3U58WwH3NNiqb/Gsh2On+JrUJNHhbavoOycFTbOjTCyp6fV0hepBHmHgZlgmoRH2+Zsqfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfI3qBOWCCMx5ICP4swlqO0vS4E2gHx3Ke2MZhOhdvQ=;
 b=JPhvMf6VRoszINgg1OI+kUKymmDCuA6cuaTqQDQvwnegSIfOrfxLhtDB+I8reWyyhoytLYP2L1O+3L6EorsZH5wDoJKIrFJASGcSpxQkeAhrbzVEhVagvnVhXyM5hKGLSmw3oawxh0pImV1fslf1718iIWBJsFUIcqm0lpt2orw=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BY5PR10MB4146.namprd10.prod.outlook.com (2603:10b6:a03:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 19:50:27 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 19:50:27 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH v4 0/2] bpf: support for non_null ptr detection with JEQ/JNE with register operand
Date: Wed,  4 Mar 2026 19:50:15 +0000
Message-Id: <20260304195018.181396-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BY5PR10MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e60804f-d946-46db-c5eb-08de7a274827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	g/m0RpO5vfeYy37HfdauKeGgw1a+Np9xDm6+EBlhRgknQepmfKVq0xAglzEgkPqyX5m8dsh58EA5PFzUIHCpqjRLK3A9m2aYCXDiR6faWec3jFDZyG5eFHPUKzhAAVJxib/+jgsdcvlLaACEs636jfVVo85U0HC+RjY7Z/1/OgWvXM5y0hU/XkXAVCVZArdMfUwUzGbMjBe5Qe3mAwct/AkTT4v91Ur/vISVu9rQxi6vaZfQKiqhIqhZV6re5A+ijyZjelv7GtK49CrinHTVAG2Wcpia/Zbcchq9OKbfbrDI965b4v+ftilX01KnV2+7/xoGfh6uj6/RitQSP31mtKUkzdQ1tfk7XgmjGen2eDB+9y1udUC6rpL8gaNESdocFF6hF04sG4MlarWiZGYPwQD98tpSEYpIldiNk5YPgq7cm1mc+LnmLz/50MxiH7W0jaDixvPhzyrJxPTLkRPj3GxQAC04TRNRmGZxYpoE5+9ghzRKsLW0r7b6cJENW0l3ecJwEzUBOQ81tlEtC7FCv4QHLpe7721HPky0+NWRgrNNfXDA3YlISkkjDHjOvzYx/5F2DpifDsMOg0i3xivG5yyhKANdVAW+JSnQ0QVI5kTW5b/h4J/5lSjov8OYIPPHQxlh8wXIbSbx2mK228gnG2gH0OwrkXuDj9vuHGROegwgi7WuadGuT/GAbCLv8FNm3VX517ty4p6M7jO8hFfwncbnkRi2EfOwus/Q59b23Fs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9IKoqcANk7OhBkLIAP0HsJxQMwI14N38KlutncnKrp8quzej1lGtjZABR6D?=
 =?us-ascii?Q?gesOYwmrLgWAWyImyXMQPaFyFwnXzSYfYp00wbH8MNFgJl2AUxs0hTMI8YMx?=
 =?us-ascii?Q?wyoNEAH62Kr/jCq4ojPtFo9xHbrhauS5TYF4tVaKsDZD+//nwwFZFVE4lKqj?=
 =?us-ascii?Q?HYHkymu3LiPQVY43jyv7avelMcW8zGSkZUHQn9TJyyHzQ2FdC/5lI1LrFUMx?=
 =?us-ascii?Q?UaZtO6BaXPJ0IVXL2R2S94h/76Ztqx7eAeXWtIOrZ4N/VsWlikeEVFhdg4HF?=
 =?us-ascii?Q?SmcGDyaUA3dIJT7P1P3KQQzrQl3QSJ0akNz5jVXmnmosR1bgbHPvgC7Y1QgK?=
 =?us-ascii?Q?sgBqpEpKc9aLyQnev1S3ZsOZyRuwFQKiCREuVUFqQKQSvDOYM5LGIo0YjUhk?=
 =?us-ascii?Q?JU/+cMt1ApQKAx1SdZGOKQmZsmfMxtsH3q1kyrQf9SYi+pYG68n/lHr4pvmI?=
 =?us-ascii?Q?/870z+7WlTLShJj67vLweO5gP+AHBXLSf0uo4zh15fI3Lld0Jsz3PoRTxs2Z?=
 =?us-ascii?Q?F+Eud2XbIbOtMTmWkioFChs4fHbOUWdOcovmAWcazFkSzQUYv9Amj0Vr8vCA?=
 =?us-ascii?Q?NqKchQSsuDuITvWQRg9TQ1yWPgPLTQZNi3w7ivvim2FDbPzIf+P5H0S9nnuU?=
 =?us-ascii?Q?JHm7ceXPHMbouJWeJJuM/6CKZkGvWrs2jTFnuKJykMK8miBaX0DqcYI7LPTX?=
 =?us-ascii?Q?+67l5i0bkI437Cvi3K1ZF60pYF7ebOL9FQZpWJsZoi1t4yrqi+qbyJfbvJ2K?=
 =?us-ascii?Q?WMUISwzgn0IVyB2CpAGYz7LkYrI6f4IVd8UPMJoMzY2TQODGz9qB7FIFBvjG?=
 =?us-ascii?Q?J8zsYgALdNsByHN6qo23z6v4BADKrmCyEw8USTBYrlc62pBgWWMXJ0D4onNn?=
 =?us-ascii?Q?Ds7znSMKRFyFe2/QcR1gqX9NnojRVc53fYz9VmPFwwTJO0kgpMFPZBMN5uQh?=
 =?us-ascii?Q?e/wWo8JYNh4MN4J3vd+iv+QJEuYMnO47E9Poo9ZPhqgigh9E6hml9gXbyXJ5?=
 =?us-ascii?Q?gOzGgKZwM42Z+w6rdizusfgOyw3+r1e+vSHZ/5VWJ0yLSzwcWaaaQ1C222S6?=
 =?us-ascii?Q?JwBcX6XXhD2kIIRyKIjjmZ5SSRNKBYk932ibBb4jf/SangEtGgnsa61SN8XT?=
 =?us-ascii?Q?mA+2oa4b2++ohAdvvnR2Ne8TH59IkFQqwb9XImaex44Fs2p6IrpjOEQPz9hf?=
 =?us-ascii?Q?F76gAa5oUZXvP8vEirBQ3kVZ7IycjAsRd6E5EJz7gOncKcTwFT7sCoTeXEiG?=
 =?us-ascii?Q?8yY51gvS2Mdr5vWMImrwxc44MGx697aQTP0MD89b1sbH3iHaHNhAvMrihXiv?=
 =?us-ascii?Q?C8N8SslbObEDOMAAAU0rkgmt/Fdt9VXWgTuD+saFtXpVxO4VEATWCbIMpUQ2?=
 =?us-ascii?Q?G5bRvjAvZRyX2C7wC48nPjSvJpKS0tyQWq0MuwN5a1wbis7+IpOKqY2725cD?=
 =?us-ascii?Q?s5miVmpjLRct184Qk1+eT99nZGnnAeM86Rpcxg7WFh7J4k1tLY7FIqJC+b17?=
 =?us-ascii?Q?QoCUYe8xTqUAW3lKKPrXY2CQ1gXLb/wdOth01ljkJfzRnPxZn/RinE40c0h8?=
 =?us-ascii?Q?zdeETIK2eeyxiK/wcFc0tLeg7Ba90c6+dPd8ZLz0esqLa729clHeSMiRaDbP?=
 =?us-ascii?Q?5YLKW3KxStNQjoGGJA+dttVqlKr/dprNsgZb7JEgAuMCl9++aMuioMp9PIgx?=
 =?us-ascii?Q?33KdLSRZYkmfzCz6POVZfVZUdAVjApE5MW3JEKgMjTFfu3PsJ7cR6qdXQvGu?=
 =?us-ascii?Q?6zhbKwZQdihrNT5ofCVcJpBALulZt7U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I5jDI8qNXzSGNwq6gphpoYc8SHdwN7hJQxnuXhVXmnpOnQ74qiF7ZNh28AEfzN0IkY2siF/SH/72p98b9JVv4P6Zolwgmz73oB3M3v+iriGU9DDJSwa83vGS0XUaC9hRX6Nnowsn5RLOBS45gIeV4jif0ZH2Oq0QEKW3KGNTHIMy5wl0Qc+ZwHBZA5BA6v13xhUty1BKoQ7B2SO0a1/rYj3WAe7yql9qeS8FRDWfy2vFGoSgrgo/+8fNjG6iOYbY9UQWhix95AJiB4wF37nAgyFoK94LBdc4SpZ7ZgxeiZI3tBK2HFnzSmn/3TtcjpFxWgYeC3FjlX92RzwID6+IchRIP4azdEVXrGpjNBi5CllR2rsT+XLWCjNaAtcWDJePHMEFuKx9ClaR1pwl8CKfAOZ1rcFQnxftqpJuGZmo2X1UTCK+nDCcheUysc4lKMYTBxryDGDrjvCjKDeWBzoklzRvggA8N1kpnZiB9y3MV7i+zFxvFSX0BSjjEbdJN1+xH1srApDQJUq91giXi11rrhRDZIpu4yqTMLwlYKSPm1kfE+JokVsTZCx3+SmOaLwG68FO5dRQaKIUro8WL7Kp1NiOA/1+N1EHnPhzTcRCzQc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e60804f-d946-46db-c5eb-08de7a274827
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 19:50:26.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnzNic38lGpYLfGTXTkmSoqwgoBwLasixNXBZk3tQk1xA5keVNq+V+W8SCiYxeNpGT+mSrakwVw3vHezeCmf2V23FgMX95xxL9mITkUpWPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603040162
X-Proofpoint-ORIG-GUID: 4SPgvNfYZjxp-UKS2CxFjEYomHnGoaR0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MSBTYWx0ZWRfXwoVRF+5JVZ2M
 vUXSD46Pf7BdNydfgSlNDvtAdrq1UUQ/PG2rYaW1JeFAsc1YRwgGjxLHF3T1zElyFcNQYguAi7w
 Q2shdftsSfjb3tcMfbskNxQBzqHuSZiPnwnRReuHxCWWMs/qqNObz5eS27+4jdaNFSxQZWlTvow
 ZjuEZHe8LkH3g7tfv+X9X8VvmPr5SbWH6/Ks90MWyTwTxi5gpr2I3rkpIsc7UbDIgcN/Y8kBrRC
 ZZnRqr6kMtjjbLzUtMYtV/j4RjebGgX2joOLxeG9rIC2G5n6lFrQ1qtCxYN0pYe19WQdx24cNbb
 U9vGDt3cgOO/ZY8xBbydtGKwwNQGZgczP7cQheYb+7ZIYbIdJL2Td8MEovayxsrMqbfqnXC7J+K
 Jb+7GM36lvGIPdfT6CwzUL8ICnbSm/xrp6GYMyUaZwBoxALNBg3xooITdc8CDhk4I1I9LShddEZ
 QswmsDpb6YoSaO8NpgWmH1Guk2Q/VrZ4mjq0VDd8=
X-Authority-Analysis: v=2.4 cv=V9BwEOni c=1 sm=1 tr=0 ts=69a88d07 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=UYU2QljogtbhK2u58nAA:9 cc=ntf awl=host:12266
X-Proofpoint-GUID: 4SPgvNfYZjxp-UKS2CxFjEYomHnGoaR0

Hi everyone,

Apologies for last version.
I have no idea how I added the spurious log file. :(

Cheers,
Cupertino

Changes from v1:
 - Corrected typos in commit messages.
 - Fixed indentation.
 - Replaced text by simpler version suggested by Eduard.
Changes from v2:
 - Small fixes after AI patch checker complaints.
Changes from v3:
 - Removed log file. No idea how that got added.


Cupertino Miranda (2):
  bpf: detect non null pointer with register operand in JEQ/JNE.
  selftests/bpf: tests to non_null ptr detection using register operand
    in JEQ/JNE

 kernel/bpf/verifier.c                         |   9 ++-
 .../bpf/progs/verifier_jeq_infer_not_null.c   |  54 ++++++++++++++++++
 .../bpf/verifier_jeq_infer_not_null.bc        | Bin 0 -> 13560 bytes
 3 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bc

-- 
2.47.3

