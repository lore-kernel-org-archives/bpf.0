Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E832134AB
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916549; cv=fail; b=K9bEowl2LBaTq1m8EOIbREo33IeJRw3Qm1AEleas1k7nVu5QbDE82M/egXb5cm0VgrF1NW5VFN4IzXL9oMtMKCy+zBXOFASDCse95MCKw67lslNBLxCwJwbkx5L6Le4YxfWMHuNHNa4Kwx6ZOiItIwuJ9Ive5pkumgOZWI9b6DM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916549; c=relaxed/simple;
	bh=4Er+m21/MX9H5Fe7Jpz7QtZIt/4sk3OI8/PY3amAXxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TLK8hS4YvIVkMSKRj2IKeSi5lumgfOUvKcv2rPigSr3Tl1TTRyDaindCSf5OUFuNaTM3/cVtK5GjmicDjlaAtEE+UcB9HPsnq4b3gFXBGQY9aIC6o11YTZFkwvthuAb3RitjltLzTdujhBDARipNyqGwfDI6bc3XQ4SDUyGyY7A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jnmtte1X; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jnmtte1X; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jnmtte1X";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jnmtte1X"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=iPwCrarGlMpYUS/O2ZuGh30zs9Lh/Xj83EuHlMayIgepmMN9pgoyeshm1smxMkZkFbMJXbLSzTUULz0e6iEdtlKsNQMYQGJFjfWFl3+xibc24LNuuCg622VHDzqM+pAKCX01ZIFIugG9cc4g5Ibk3y8CxxmBl4ez+LDo2owaYRdmlft1SkEbd3rcRpE9FLT2P3edLxo7pivYpVINh2RDyYfDevYDgYpmFMCdFKv1Motkl2QS2hYEvE16gitfxkgkteLJUHcTZX9Lhm1N3md74RWa9LUACQtiHH1cFWSU62L5Tlccrt/2lSKhHOCGbD/jnQxPzeLFDvKYP9qQEoT6ng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4KITi8w1ED3WUyFYlQminu1HKB35REd5XRAh01dGLM=;
 b=W8Uf+7zF+9oW3Y1aX+oaPyVtUVEAARFuKXb2kOvydhnByPBHKsl7wO76Ytj3UQ1YOkdK2nPotOhZPmu/ERInxOm/odUCVKCSMnQYbrc1otWWiX2GEYxoS9w+IHwWfmSgtQUerE0ErZbjfMeJvi7ui0HNnZmlPWb0sdx0A/gaCnlsvce1UHFZADRCCiO5LWQCuZGoXuArPSfytKqCVv5nALacyF7/VAytlvOr4mIBODaLnXFLsohPHqdDP3CLbC06cieBRUnORAkMDaX+09hl5HNqn0+XFhhTDuVJibvRoaSaY4v+E1xNia6v6wl+ltjEBg4O5uvTY1gBHAv2jNXFjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4KITi8w1ED3WUyFYlQminu1HKB35REd5XRAh01dGLM=;
 b=jnmtte1XHl2R6ibtXVXIy2feXrCfLVK+KJOAmG202VyKCeEIKXd2w6k5auYfSB5eoPBZBx+ZCKpkYTVbfCJZ2NfmhJT0otVHks33xjidyO9/DvqnTU2Clur0pVwJGXlgVdfcIQCh4TETbx8LE54H71XijWPEyi+Fqr2S3FEYyfg=
Received: from AM9P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::19)
 by GVXPR08MB7679.eurprd08.prod.outlook.com (2603:10a6:150:6f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 17:15:43 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:21d:cafe::c5) by AM9P192CA0014.outlook.office365.com
 (2603:10a6:20b:21d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 17:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8
 via Frontend Transport; Thu, 12 Feb 2026 17:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5JKDI07wYlCvoFVUDVAepVvztrkDj05QtnlQYHnNb+U7He7O/ztCQ0IfbSgvUea0AaLH7x+PArAJdSTazDUceu1mbFYRKhQ54dGuQ7kHs0BT1wRcrqWJ1EPyDC6fSWXJr0cGpsV00nUxDV078C3+A43r3/zxnTT0qN8Wi/izgA5X5x4QSSPQrR8hAXKgGYTcBYT6y8TGjtqkDN/u2mC14cR1rtKgYUlaSA9VJE2E44DLX4UKqR/n/kJrq1MY/lBYqnPkALAsqnOHNX+tjSwThOEvWzvy5CSYJiXqloIzjIWNNGPBxqvdM11kvcWn4yUvOhF99M6vyqIaVQftTY8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4KITi8w1ED3WUyFYlQminu1HKB35REd5XRAh01dGLM=;
 b=CFIGlj7kh40m0rqyumS4EPued9V03wVjRHVnsOUo81R/oe0PrlilZmQfr2MuMkwG+nYTD/BLe6FslXEXueHug7+XFbB/51klNfNn4Zo6H3VqqDvfIshpWvoM0L3I0SUrz8hwOzVfDK5Vl6JR3lpZNAIMtF4kN65cV5OYcPor8F+I3V3MIgdefykLwRyJYebKoM037WnddASCQ9ZMUd4Zr/6SQrw2m5Pf6WRgbWfyom9atP6PvUOELaCwtK55yIQCgIpyT0FqFwQh7qkTFzYoEBGd8cAUrJNvzGIB7akSvMrp9YuITuvIjrkVkXKvPqHl+6w0Srt3VA9qfDxpekm5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4KITi8w1ED3WUyFYlQminu1HKB35REd5XRAh01dGLM=;
 b=jnmtte1XHl2R6ibtXVXIy2feXrCfLVK+KJOAmG202VyKCeEIKXd2w6k5auYfSB5eoPBZBx+ZCKpkYTVbfCJZ2NfmhJT0otVHks33xjidyO9/DvqnTU2Clur0pVwJGXlgVdfcIQCh4TETbx8LE54H71XijWPEyi+Fqr2S3FEYyfg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB6324.eurprd08.prod.outlook.com
 (2603:10a6:20b:315::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 17:14:40 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:14:39 +0000
Date: Thu, 12 Feb 2026 17:14:36 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, catalin.marinas@arm.com, david@kernel.org,
	ryan.roberts@arm.com, kevin.brodsky@arm.com,
	sebastian.osterlund@intel.com, dave.hansen@linux.intel.com,
	rick.p.edgecombe@intel.com
Subject: Re: [LSF/MM/BPF TOPIC] eBPF isolation with pkeys
Message-ID: <aY4KfM6wFaSjHWri@e129823.arm.com>
References: <aY3+Raf8eZqipCd6@e129823.arm.com>
 <f20ec2ee-90f2-4ef7-bc3d-088f9ef6c38a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20ec2ee-90f2-4ef7-bc3d-088f9ef6c38a@intel.com>
X-ClientProxiedBy: LO4P123CA0441.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::14) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB6324:EE_|AMS0EPF0000019D:EE_|GVXPR08MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7b0e65-bbbf-484d-6bcf-08de6a5a5a5e
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?t/4BXeI/Y7m1RZwBCbld7pimFP6YdwfSU7g+GBAHB3WP0UDcGIVeLvklMtg1?=
 =?us-ascii?Q?8UnOEDErXO3Hx22BTzlsCaIWyAN2FvniEjSMN+EqUHNn/myl3qjLrKH7qZjU?=
 =?us-ascii?Q?3jARqByNVsT8CJDz2vqz1vzX7yJTngmxVeua0+sqGK4fsw8rgsAAxojZpg1U?=
 =?us-ascii?Q?anAQXliSBerk1DjLnPCftxKZUkV6gF6518Dd1Ny6h4Gxrh8nbKu+zTxFPJqj?=
 =?us-ascii?Q?h4GO0LobFldPzNbObha1ipovslEci9YV+YWk9/wj+SF2J1jv2SbAKLDklNRh?=
 =?us-ascii?Q?tyoc5jItZD5EEuMzeXE/IxqyKrJ7hDg5AC46EseTULcZeSs8ralpuoEuR43/?=
 =?us-ascii?Q?BsUSE7/77xNG95/A2MVdi7oDyVcsiUQoUwtS1ptlFA5iMNjKFDi2MjRpTuP1?=
 =?us-ascii?Q?AtCwnA4rMRNlGABAWisyX0AmSoS2gUPZevebkES/LwiTmqErzlIGm+c8utEy?=
 =?us-ascii?Q?a9sBCfjC9Ln8b51jstbomVbZoG9Z4V56uNIJVDNup3mCdxn5YByk3tvNMrmp?=
 =?us-ascii?Q?XgKjrl1b/myvLNAF5mxGW/3IjRWZ4WwfnNmEvHvhXGje/64DRck86VGEjAYP?=
 =?us-ascii?Q?QFG4zRtkX67yb9/F711yom1D6PgarSBEvSSRaLkMaxDFqOUAXXaKdAMtoRPU?=
 =?us-ascii?Q?Wr8nPVUZ/ZrHRpla71UBfaP+Bf4J3ieNncZprzUtUIqf1848orECl8rLadwT?=
 =?us-ascii?Q?yKDhQEyvdLF0mCId4jKK08fcKVVknZLAr77yaKeUEbXseTwbcfqPRSp3+Snt?=
 =?us-ascii?Q?bOHM55addEWKaQv2Togq1mMFgExoP9/4lFnhkKPw1yNiPoymMm1SJEceQtIF?=
 =?us-ascii?Q?8fjADxMAOoKWiy8uFkzywOoZaV7/V5aRMKzZ+SkambrtFZVQfeYpah7o4ZRJ?=
 =?us-ascii?Q?bvwjVVBTYkdShO7Gi2fUhpUo1z2P3YO9wLfxjCSPlq/wyWBTM6KAvLuwm/3E?=
 =?us-ascii?Q?GEKmZ9tHmrS4rDMP6UMBtbLL/6ez0gZ5GJVx8EspcFVEhDIHXI3EkfEf87tJ?=
 =?us-ascii?Q?KEAsjUouSLRRzkLPbw03gaOPTRtwmsRbWjpF0fzS71/g4czp188yqzmui4ty?=
 =?us-ascii?Q?15WhnAQMmrkLwjT/+hgvBXfO17MuPvScb+Qr7plJd4audHI9LpsGDJEEgGxK?=
 =?us-ascii?Q?xhH4NV18q6yKVaQeVFJgPlsXobrP1x3nJAx4UK/xV8y+NUl2daQ63ZphO5yv?=
 =?us-ascii?Q?rs6awpVjC/pW9VnlgPgEjsYrjJZJiR/fAikt5CpcEswcERP55f57JyA84Fi3?=
 =?us-ascii?Q?ILGM6SYC4Zo18wMEBfQg59LqQsavesESOr2ZADigDOcS4rpW7Yh1uWSUHta7?=
 =?us-ascii?Q?jO1CVacoVnyRhTVWl0170WtEMb3Ui6b+3yEQs+n6ITgTm2ssjPGQbukNX48B?=
 =?us-ascii?Q?oXEStJmRMVcW/64pO/bgDA46OsOpZTR1j+NnC9ClfsrVRzAoH6DwOT7+5oC+?=
 =?us-ascii?Q?MU0z6Lolc/M6neLBTBFlkiqQfyLbAW9Bp3uXoQytBQ8xnZHwlV8R+RsVfwiN?=
 =?us-ascii?Q?/iUTudZ1SSwoWI6HVN89Z31FQYLuwWA1xJmR6PMZmBoJGCLUE2ayo3Qo/WpN?=
 =?us-ascii?Q?fq2GGd91FZY2YdsZujo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6324
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0e5f1f99-69f9-4485-bf77-08de6a5a34b1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|35042699022|82310400026|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2RI83Ba2IE0lEdCLxsX7RoaloFtAqe+Q6PE8h/eOqWybVR/VawkfoyOftQaf?=
 =?us-ascii?Q?dBVV/162BEaeZ5zsxwrgtDjoLNq44EM68r1KOQlafbvagb21Ev3Pjy7rrbgO?=
 =?us-ascii?Q?e7s+pAcISTrnkDETCQH470iJns4FO9u9Q7VolJ6C0TPh7aj96E6O43bq7s2d?=
 =?us-ascii?Q?lEZJ4AZx+kig9o4qnsoqsuOfQHE2wNoPe4vg5jUqm9VbUwm31XCHEeqCF0Tg?=
 =?us-ascii?Q?NZMIfJdgmvnzbNASAUuPYJ++K/0BjBM0gOJ4Hu9t4hf92r5s9clALb/SiRbw?=
 =?us-ascii?Q?BnKfuNiBFMeDgkY4UeQpHP10as6jlH6gnPiPlPRUEpc4twHqv7mgSZp7rjpt?=
 =?us-ascii?Q?0WQQOJD5ZcqWvFalO0UArxgwziFtfRFREX7KanSM4w/JnXeQ3d2daP0U9oB2?=
 =?us-ascii?Q?BMkG/oHq8uy1V3SenJZMKqnTggVlbVLLlPSzyMTOFnvrfGON4Pto6WPlsn91?=
 =?us-ascii?Q?s6H8nVEkddA1Ps0RqjHwOem1W4czXBkVOr9GOqELqOOi6Y+6SDUxrsoxeHSK?=
 =?us-ascii?Q?kPoC5sQTdUgpb/8J+/bLo1hVh5JvspRupgkfRbSjT/01l4AcAty95grPJAfW?=
 =?us-ascii?Q?XsTaTZnKI7rs+4l7nQpZegd3Q5UDaJdioGborgP56SQ2iBH6qKv9PezqeCTd?=
 =?us-ascii?Q?BW0I5cpnmqF3vQQEaf5NabUt3yN6Z6SrkEENkX+M6kdu6V7oXb1ZAHOnpTkW?=
 =?us-ascii?Q?y8DGEIwwJ4/vKW416o9zECasjtqUmYtUwxh5RcZd1Uro1ND+ZNR2cCKdZevI?=
 =?us-ascii?Q?UoglCuF1tdykYND3pqHQaSdi8GTlzzJYfX6fr1Xo9kS1mmwxbmbWFIGdEpA0?=
 =?us-ascii?Q?OqdjOHKDwrpzhQdwQftknfaPhbjMf+x9sOBA+JbhsxP5aT5bQhdegLw/B12a?=
 =?us-ascii?Q?kTI9kmtFuHnje1CKMbXV6FtQEK0V37jydAxGuR2Bm2tfMVi52pROHIqZXfNk?=
 =?us-ascii?Q?nr+KN+jKvSQ3AtskV8++QEA8ABRGY970EitBmX3JtUXZy+cbuofA3PBv2uuU?=
 =?us-ascii?Q?YYel2wZpukh1Ovzi6fKRTKOfZc29ydRhxhdXymf3Vj0ip+ts/HMQ5bUkymQC?=
 =?us-ascii?Q?N3EIGS9owI3OP7pE03OIrIB9p8inPF4BXW8srMlp3/P6nnWQvN14b4XkPYEG?=
 =?us-ascii?Q?C2DqYNvdu3/zfc0kAamdbv/O+YIUaWAqxNcWWPeVgc8TLhnYnJzGs6YgsXNS?=
 =?us-ascii?Q?2qLIymbKGnwXMRASfqKpksw7r1ngonC1x2H/t+eidPTcyDos4DO/pcR9RvYx?=
 =?us-ascii?Q?F14lX7yIS0nePdaGgm5vUZO50ZT+wYVNG3Z8rH2WoSXzjiBbo8RFs1spAaPr?=
 =?us-ascii?Q?N609WXiTuGjNi/NgW0sKK4ClJ1Iedmav3MFPwfR+6YntzOcj8Y9c5i9k0cNg?=
 =?us-ascii?Q?OzaM/H6/ufiBCSlKHPNXfLmNc9A7hAG28TC6PYxzO45/ZaG81sZD3e5EhMsy?=
 =?us-ascii?Q?hWdIo8iKcSQJMRCM9v0aHsmKS7ddOYQ/8yLFukpNz1vZxnupr/xRF4VEVcPT?=
 =?us-ascii?Q?KpWUctyOq5bxBDcMb4Y6EpHj9iwDc7l9GaM4vzwG2e1e04xApt5jSVGPRHft?=
 =?us-ascii?Q?Vb5Ic76oLNC0lMf4qLOignx70pk7psy8An6YEm/BMvNb34OEHodNb0I7x7U9?=
 =?us-ascii?Q?xrPZiJ7sF+l37vH1+XU6VGWQk3yOCLXVoh6NvTp12sP6YFZxWEkjlF7K935X?=
 =?us-ascii?Q?eLJV6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(35042699022)(82310400026)(1800799024)(14060799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o+fumS8cIIrBoXTyohXz80DEBBrePGZjQfUJo7cAoYEXwKvIERN2jsBPNbMhIan8I/F6xaLIUHTsUyOlILh0zTc1QqNVx3N4mdsq1P49EM90FHiPY4NdcFmLQXAAttI1w/9tC/4VoovpxNScFvvSsVMlQfHY3aD6RNNN9/DrERVxl81bDF0Tt/rl2WPbjP5RgnNOnGYLzF8yciV2jCOHde6rVWOcRJHEqI6ArSrKY7TdVxM11Ev2hWbkkrKPM7QOjESSFPR8swLQWnRNINeqh0XBi++bswhjzKg5E+QtxKPoVGxiulgd46GD6wq4L/HLnMs8GMg3P7E1ExHxGfRo27CfuvYUM2fLLA6IkwiPVfk/1TnQS6jMlc8S11BNVHL3HeSl1KSVF39zzvWBp7nnq9RuuSS0lg0gaFUlnvUwK21VtsNPsd8M8sdDq7Ty0Lpg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:15:42.8066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7b0e65-bbbf-484d-6bcf-08de6a5a5a5e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7679

Hi Dave,

[...]
>
> > To that end, this discussion introduces a set of new allocator APIs and
> > explores more extensible API designs:
> >
> >   - kmalloc_pkey series
> >   - vmalloc_pkey series
> >   - alloc_percpu_pkey series
>
> It all sounds fun, but this doesn't exactly seem very generic. The meory
> that sched_ext needs to access is super different from, say, what a
> socket-filtering eBPF program would need.
>
> So this doesn't seem to be likely to be true "eBPF isolation" as much as
> sched_ext+eBPP isolation.

Our current isolation model focuses on restricting writes and execution.
Therefore, if we allocate only the memory that eBPF programs must write
directly with a separate pkey (e.g., packet data or sock),
it seems to me that socket-filtering programs could also benefit from
the same isolation.

Is there anything I might be overlooking?

--
Sincerely,
Yeoreum Yun
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
