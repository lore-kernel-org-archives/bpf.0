Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911469;
	b=LO6Kq1t3MQTu6804LVOd3kG6OfK40f3TAEVnYdit3xVzcZgTbWk0SoK+LXS4i33HAfTM
	 QTLu+bMEPlrBReQqz6/4YEX2Dq3/++hxYV8HI3ejpvq0Ym350j6UK9UeX80E5UWgqoAwA
	 fjUJaLQ1EMLezesLCNzE/5Nj+Zi81em4BErIRyMC4H02fmJqAOYLmVV37yGaK3Mg36VjA
	 9R4jOue8qhZgL57FWZfMUT8LVV9Apo3/0NvNz5d1vPeyJdr95BPvH4KM+/1u77ps5Xyca
	 9afd7f1OihHzb4Ngrw6rLpdmQFLUoH1YtcxEn1xGZUcOU5lCSwsaG9610a15M+y0C5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911469;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8tjgMnV7vc1cazJn97XnF/RT7CnHOXJb8Vx3nA/7Z64=;
	b=lSrGBUoCLjMIkxAmKeUh/4cNNAWj1d9yodqduVZ0QbrvgMLEchexm67I9dkUKzTShWZb
	 9RKOB6TVE6HgBRfqoDf3+vdvOonghbZqmBwNoJBlYs+OvhSzv6ma6yKQKcYVDQFIy/AhU
	 qZKNb2x+ns1ovwX2VtyEkmaalJ8bpcm0t4g637uVB7BZ9cCDmCGe2xOlNnBWC4BKTtfgJ
	 xPk1k7XUSqZwkB+lEFO9c2ZtYcF6DamxZdRIzLaxbZ0ll3Qw2AZWl3RTJct9Lh5dAxYtG
	 Qhc1VMEFzd3eiZ6Gts5ieu+00z/Lo/F0Tkm3UZMA5oDkVIUl29F+j1mj8RbQK+Ba8RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GEWLQ5uY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.25
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754E606A886;
	Tue, 17 Nov 2026 10:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1754E606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GEWLQ5uY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZd4nyTU+hyvkzrG179qCJqof32zH+RU/S6svdn6cPKmxjWTfAFCmDkTCMaJwvSJa307cO1tGBjbneFQHKLolc9NdzZjUeZw4YMBg2x4+UF4O1GtYZZkEMhvQDCj3XmEvB3LzcUmKzkHhE0cdsD9AVfkPnZKAM5pX8t9HhCMpOeb1hFYDg/m5bkuoBarxwKKeCtBKQlwlrJuVr1jqY2kMC39A+5aGhYtZ1Jk2H5O7WL0gMbkYcv4zPTnoCyeY6hqfN+Mb6/dNEiJ3uQMdSBh5FujZ8pr2E9li7XWEMehlNaSoEeWDxTRnnMzwWDmPjZKClRxftkm4ob8CbVWXQqhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tjgMnV7vc1cazJn97XnF/RT7CnHOXJb8Vx3nA/7Z64=;
 b=fe7eFZyUhVNeNcon312UduxSIy1GApeuLFR7Fo1sBNqr0W5KAp4lW6ySbEvEB/76AXzjPsFaY2Mth2AUR2WpnV/d60BuO5O22ymZWK0CHyXkVWPrlBWaqB6Sc8sC/JiOAroIq1Gnw3FoZ4rFVdusemszQA4WkdcOSW7SSgOMRyyE7IhUNckSrbZKSLIMFyLqafFyimpAsZ4t0+FF+RA0xp+T5UJmTYGlyEFGohCeJ0j5EU7rZgVkrivBYTyWc225ltFLJdIB4RLF+fa6dHHv2toclGr8KNqkqm1WnVb21z24xtTeKPmVj6IriUV29zeasXTwMZzCFu9BL/byESvQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tjgMnV7vc1cazJn97XnF/RT7CnHOXJb8Vx3nA/7Z64=;
 b=GEWLQ5uYctiYmize84NTpYMHqKN3XIVlp7n619TJFOjWW1S3pFBUX/gSolbnr6KqaNobcwUkgbccfOe4cStyJQtZFO1R1x/Cm73+N6LrUe2IWZBEeo4x2DlJv5X991Q79Rvv0ZdeP+00JPRmyNGzSMM0JGu/v+P8Q1I8KrlAdOD4mFSmE8Gcr9KRdPuKCmeMffSd6KedelUSURvzJlYq0MYcif/xXmJ0Ebn7zhZrkkyPJh45vxvP4yI+Ed+t8qwFEAeW4KlYlQKJ2REK0ldhPMAK+tcJtSF55lQ+Lo5/IGccVvLvknIV60DhenLuBtREDFcgiNNZY+fNYzcMcacENg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:31:02 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:31:02 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Josh Don <joshdon@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Peilin Ye <yepeilin@google.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests/bpf: Test importing pages into an arena
Date: Tue, 17 Nov 2026 11:28:08 +0100
Message-ID: <20261117103028.4105609-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117103028.4105609-1-arighi@nvidia.com>
References: <20261117103028.4105609-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 150838f1-3d7b-43f4-b8dc-08df4495e0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|5023799004|11063799006|56012099006|261026140227099003|261021121427099003|261026121527099003|261022113327099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	H64wNv1S5FDdngBQJNkp5/1/JA6QbtFDyna3sT+POhCCt/xv4Z0Y1B9LtBKEPlBelJj7HoSwwCfj5oW547tkagDvEq30C16D8DTxuSOjVD2no6ZKoXx29N/wUFp5SlNuMAHw8dGWhxvZ952hU5Kpp+L+ulAcG88+lVRGDoR4SBlG/DJMfvIwc3nMB//yjtXfPClbt3nqbEQrgdygICwgFrOmHV/u74HnItmvAdFkTmF+1RI/gUIVUzqIIJrP0Ogw1b23PgbX1Yb+T0D15AhKBnZ5Gg56alJyWQZHRfExvkG88UpgvR4dzWKBVVDqgqb7gwVRtJM0MMR287u6EN6+BbyJuS/l27IJwYu4MxurEklYed0r7zW4VE1Bt9Q6js8hIBgODNw32Mc0o/Oyq66IE9iQ748UqwCQbT+7nXrdG/ZSpSWuD+osYCX3WWSoNidhuZjEn6uEhgwSD2xk1q1bTWqHHOs/o9PacG8TD2ClqHl3tlIsM4N8W8VKOdPhftvMPKpHS8l/4GWgapVEBzb1nLsuZSGCuwA1/dbJso0ZHRYi9RKJKhyYH1w8Iz0bfPcGhmpg3teeExv/WP+Fo0zySINMcWtGo6oD4HHGj51ponms8lL1gogcbgesL3NS1j13hDl6uSadWpy3+Ya5TiNzKyZmB4yeGS1u0j+qCIBhvPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261026121527099003)(261022113327099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XuBw2TsNn3q0sT1yLw6hVDZrqgMtIEdTWg2P4ygRiIBuS7JheeMtoBtIGV4r?=
 =?us-ascii?Q?Lc+im+QCzrwYJ+p9bWd8pIED3tfc13dBEK6lLjIS6i9AWIZZLTFtDg9+d4wf?=
 =?us-ascii?Q?vzqNULixmNXZu0wQizJzQDxxSEXStK0uPaP6y8DqlwlTHAsbMUatK7lA5D9l?=
 =?us-ascii?Q?gNfUsTJAdYAndWaU2wlQKd05uJ+k/Dn4qh0k8F0fHP0y84e2tDL/2JIJig0/?=
 =?us-ascii?Q?fks1F6FB01yUViRQik5HdxxO1CGK3DdlpB0wJbTtZtbKirsEPywb6o5Oen1c?=
 =?us-ascii?Q?GDPRDZrLPqQM0PdcLSuHv3hqjc3RrSsc8+w1xDYWTwW70hMbZ/TiC4lE37yT?=
 =?us-ascii?Q?eKmPx8mRU1CsIj74N+lUtHfWB+Ryq421J85PpopRCH6eWevEiahb6Vekkuvi?=
 =?us-ascii?Q?/HjVYCGgVanuBdfV1A9qTqQVKuriZovpTzFHBRRqchUfJzAsfSc40QELb2cM?=
 =?us-ascii?Q?NpM5sGbQoh8T7FDZyUYMjrMeLEV0rhPmKvbGfVd0+ls5g1dPyc/GT4Psj2in?=
 =?us-ascii?Q?C6Y8yhDzZFtjj4V0XIPNWVHDr746o/dOR0ktF2rtU4Gtde0W33eg2ic9dmHM?=
 =?us-ascii?Q?8Xxl7QP7XMfr4NQtLVmEghoXw9QfcSJW5kra+YANzgLjyA65kiL1rbwT63ys?=
 =?us-ascii?Q?LysMtouU1TpZk457EgY5qgoeJ4iVG4ZxROGzS9AD/xN/Apq6YWGgfc5pR7MW?=
 =?us-ascii?Q?LWgYKfFQ6n9LsuCu1n22dykB3mKLDu73dxQ9sWrU+S67gaH9E1N6DTkyKfGl?=
 =?us-ascii?Q?JurYvc0dEFI6QaX7vBhuRYdmoYP+pzekY1XfDD8ozTtTRs9fXU60jbso9rah?=
 =?us-ascii?Q?LUJvw2rU7EjXs3yYbnqJDKbSCgqPmi5TsTUeNiEhxgs4qb8F0cFA9eDWwiUS?=
 =?us-ascii?Q?2fepigqVjBAkNak6UK+BKF3y3Exu31upEc/QaLJBs4rx0WG1po8G+itVF8IW?=
 =?us-ascii?Q?e5xI2B1eBx/5uXnt7AlvMVNiZY2iv/wiH1wFxRSA7VXpPEJfEd45lfGMB3Y6?=
 =?us-ascii?Q?BtVpLNIU/kldmaoiwPQnJmIiecLB4gM+kMKZ6jwyh7c7cvrYaKI28ATnip19?=
 =?us-ascii?Q?C8jupF6733B93jRZaLp4lznRsvZaf9m27ZtdgmierYnqzaQTx9p7fI3ukv4T?=
 =?us-ascii?Q?r2JveU9rubp562VJy/uTTnXGBHzZT0mXsl9sbY6/oAjDw1JDk1DJHiAbTTrb?=
 =?us-ascii?Q?lUfm5N8ey6ZL3qR6rDc6EHbIzangpgVtgYn4Gq02peU0Vitc+hdsP7ZfqqnB?=
 =?us-ascii?Q?zPkBr3bCTT9p7u9xydByrlqfVy79OBCZldPSE34MIiRt79A5vsgDxZSqc7tE?=
 =?us-ascii?Q?D4ZGxLCBmMfkm9bueWQGBSU0zJZ6ruJMLn0B5Kut2tS8McutQ9MHQLxTf+2F?=
 =?us-ascii?Q?OhwkerkLwIZdZND42fdbJo9JoRrylz/JKh8aCkbwY4w5oIJrWQcqzhAvz4Bq?=
 =?us-ascii?Q?Y30p2vfr/qCTpoV2arMo6fH5R0GfBn1hzOKQPmgoTUa4BJLZs3JYGyZh+r+q?=
 =?us-ascii?Q?cCOtYbAb1POP5656PO3JtA2LOSETjK1Dd3d24nUIzr66g92u8b6ud/yFEqdB?=
 =?us-ascii?Q?4HpSahVOO/bXGQGnR8/hDtluHfgudWJ1vW8Oym2E3Qf15H6pSNQ/p7PntsGV?=
 =?us-ascii?Q?jFHK6JeT70IvCwg6v3+OsyaF8XBQIWx1yVFgeZFcM7/DNcUeGsN2FFCStPYT?=
 =?us-ascii?Q?xaVhAp21nFrq8pjnJ/sqYW7RbridBx+/L5C1D4LAG23rmrUO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150838f1-3d7b-43f4-b8dc-08df4495e0e8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:31:02.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xyNyFDjVtjuiWRXJqWb19NnEt9Hes3uFXVQRn7gGD9hD8i8duaADvBNqfhQD6IbrVmc7oxVK6gB06VPthMbDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

Check that pages imported with bpf_arena_import_memfd() are shared
between BPF programs and user space mapping the memfd, that they outlive
the arena, that freeing any of them releases the whole import while
their data stays in the memfd, that invalid or overlapping imports are
rejected, and that user space faults on them through the arena mapping.

Also check that bpf_arena_import_dax() rejects anything but a device-dax
mapping. Importing device-dax pages needs a device-dax device.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 .../selftests/bpf/prog_tests/arena_import.c   | 451 ++++++++++++++++++
 .../selftests/bpf/progs/arena_import.c        |  93 ++++
 2 files changed, 544 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_import.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_import.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_import.c b/tools/testing/selftests/bpf/prog_tests/arena_import.c
new file mode 100644
index 0000000000000..1ba2c45d122e0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_import.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 NVIDIA Corporation */
+
+#include <test_progs.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "arena_import.skel.h"
+
+#define MEMFD_PAGES	4
+
+#ifndef F_SEAL_FUTURE_WRITE
+#define F_SEAL_FUTURE_WRITE	0x0010
+#endif
+
+static long ps;
+
+static int run(struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!ASSERT_OK(err, bpf_program__name(prog)))
+		return -1;
+	return opts.retval;
+}
+
+static int do_import(struct arena_import *skel, int fd, long fd_off, __u32 pg, __u32 cnt)
+{
+	skel->bss->fd = fd;
+	skel->bss->fd_off = fd_off;
+	skel->bss->pg = pg;
+	skel->bss->page_cnt = cnt;
+	skel->bss->ret = 1;
+	if (run(skel->progs.op_import))
+		return 1;
+	return skel->bss->ret;
+}
+
+static int do_import_dax(struct arena_import *skel, void *src, __u32 pg, __u32 cnt)
+{
+	skel->bss->src = (unsigned long)src;
+	skel->bss->pg = pg;
+	skel->bss->page_cnt = cnt;
+	skel->bss->ret = 1;
+	if (run(skel->progs.op_import_dax))
+		return 1;
+	return skel->bss->ret;
+}
+
+static int do_alloc(struct arena_import *skel, __u32 pg, __u32 cnt)
+{
+	skel->bss->pg = pg;
+	skel->bss->page_cnt = cnt;
+	skel->bss->ret = 1;
+	if (run(skel->progs.op_alloc))
+		return 1;
+	return skel->bss->ret;
+}
+
+static void do_free(struct arena_import *skel, __u32 pg, __u32 cnt)
+{
+	skel->bss->pg = pg;
+	skel->bss->page_cnt = cnt;
+	run(skel->progs.op_free);
+}
+
+static void do_write(struct arena_import *skel, __u32 pg, __u64 val)
+{
+	skel->bss->pg = pg;
+	skel->bss->val = val;
+	run(skel->progs.op_write);
+}
+
+static __u64 do_read(struct arena_import *skel, __u32 pg)
+{
+	skel->bss->pg = pg;
+	skel->bss->val = 0;
+	run(skel->progs.op_read);
+	return skel->bss->val;
+}
+
+static int make_memfd(unsigned int seals)
+{
+	int fd;
+
+	fd = memfd_create("arena_import", MFD_ALLOW_SEALING);
+	if (fd < 0 && errno == ENOSYS) {
+		printf("%s:SKIP:no memfd_create()\n", __func__);
+		test__skip();
+		return -1;
+	}
+	if (!ASSERT_OK_FD(fd, "memfd_create"))
+		return -1;
+	if (!ASSERT_OK(ftruncate(fd, MEMFD_PAGES * ps), "ftruncate"))
+		goto err;
+	if (seals && !ASSERT_OK(fcntl(fd, F_ADD_SEALS, seals), "add_seals"))
+		goto err;
+	return fd;
+err:
+	close(fd);
+	return -1;
+}
+
+static struct arena_import *open_skel(void)
+{
+	struct arena_import *skel;
+	size_t sz;
+
+	skel = arena_import__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		printf("%s:SKIP:no arena support\n", __func__);
+		test__skip();
+		return NULL;
+	}
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return NULL;
+	if (skel->rodata->skip) {
+		printf("%s:SKIP:the compiler lacks arena address space casts\n", __func__);
+		test__skip();
+		arena_import__destroy(skel);
+		return NULL;
+	}
+	skel->bss->base = bpf_map__initial_value(skel->maps.arena, &sz);
+	if (!ASSERT_OK_PTR(skel->bss->base, "arena_base")) {
+		arena_import__destroy(skel);
+		return NULL;
+	}
+	skel->bss->page_size = ps;
+	return skel;
+}
+
+/* Imported pages are not allocated by the arena and must not be counted */
+static long map_memlock(int map_fd)
+{
+	char path[64], line[128];
+	long memlock = -1;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", map_fd);
+	f = fopen(path, "r");
+	if (!ASSERT_OK_PTR(f, "open_fdinfo"))
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "memlock:\t%ld", &memlock) == 1)
+			break;
+	}
+	fclose(f);
+	return memlock;
+}
+
+/* Data written on either side is visible on the other one */
+static void test_share(void)
+{
+	struct arena_import *skel;
+	__u64 *shm = MAP_FAILED;
+	__u64 val;
+	int fd, i;
+
+	fd = make_memfd(F_SEAL_SHRINK);
+	if (fd < 0)
+		return;
+	skel = open_skel();
+	if (!skel)
+		goto out;
+
+	/* Import memfd pages 1-2 at test pages 2-3, see page_addr() */
+	if (!ASSERT_OK(do_import(skel, fd, ps, 2, 2), "import"))
+		goto out;
+	ASSERT_EQ(map_memlock(bpf_map__fd(skel->maps.arena)), 0, "memlock");
+
+	shm = mmap(NULL, MEMFD_PAGES * ps, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(shm, MAP_FAILED, "mmap_memfd"))
+		goto out;
+
+	do_write(skel, 2, 0xcafe);
+	do_write(skel, 3, 0xbeef);
+	ASSERT_EQ(shm[ps / sizeof(*shm)], 0xcafe, "bpf_to_user_pg2");
+	ASSERT_EQ(shm[2 * ps / sizeof(*shm)], 0xbeef, "bpf_to_user_pg3");
+
+	shm[ps / sizeof(*shm)] = 0xf00d;
+	ASSERT_EQ(do_read(skel, 2), 0xf00d, "user_to_bpf");
+
+	/* Pages outside of the imported range are not shared */
+	if (!ASSERT_OK(do_alloc(skel, 0, 1), "alloc"))
+		goto out;
+	do_write(skel, 0, 0xdead);
+	ASSERT_EQ(do_read(skel, 0), 0xdead, "allocated");
+	ASSERT_EQ(shm[0], 0, "not_shared");
+
+	/*
+	 * The data outlives the arena. The arena releases the pages after an
+	 * RCU grace period: sealing the memfd against writes fails while they
+	 * are pinned, so wait until it works (no writable mapping either).
+	 */
+	arena_import__destroy(skel);
+	skel = NULL;
+	munmap(shm, MEMFD_PAGES * ps);
+	shm = MAP_FAILED;
+	for (i = 0; i < 500 && fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE); i++)
+		usleep(10000);
+	if (ASSERT_LT(i, 500, "released") &&
+	    ASSERT_EQ(pread(fd, &val, sizeof(val), 2 * ps), sizeof(val), "pread"))
+		ASSERT_EQ(val, 0xbeef, "after_destroy");
+out:
+	if (shm != MAP_FAILED)
+		munmap(shm, MEMFD_PAGES * ps);
+	arena_import__destroy(skel);
+	close(fd);
+}
+
+/* Freeing any imported page releases the whole import, the data stays in the memfd */
+static void test_free(void)
+{
+	struct arena_import *skel;
+	__u64 *shm = MAP_FAILED;
+	int fd;
+
+	fd = make_memfd(F_SEAL_SHRINK);
+	if (fd < 0)
+		return;
+	skel = open_skel();
+	if (!skel)
+		goto out;
+
+	shm = mmap(NULL, MEMFD_PAGES * ps, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(shm, MAP_FAILED, "mmap_memfd"))
+		goto out;
+
+	/* Allocated page 0, memfd pages 0-1 imported at 1-2, allocated page 3 */
+	if (!ASSERT_OK(do_alloc(skel, 0, 1), "alloc_pg0") ||
+	    !ASSERT_OK(do_import(skel, fd, 0, 1, 2), "import") ||
+	    !ASSERT_OK(do_alloc(skel, 3, 1), "alloc_pg3"))
+		goto out;
+	do_write(skel, 0, 0x1);
+	do_write(skel, 1, 0x1234);
+	do_write(skel, 2, 0x5678);
+	do_write(skel, 3, 0x3);
+
+	/* Page 2 only: pages 1-2 go away, 0 and 3 stay */
+	do_free(skel, 2, 1);
+	ASSERT_EQ(do_read(skel, 1), 0, "pg1_unmapped");
+	ASSERT_EQ(do_read(skel, 2), 0, "pg2_unmapped");
+	ASSERT_EQ(do_read(skel, 0), 0x1, "pg0_kept");
+	ASSERT_EQ(do_read(skel, 3), 0x3, "pg3_kept");
+	ASSERT_EQ(shm[0], 0x1234, "memfd_kept");
+
+	/* The range can be imported again */
+	if (!ASSERT_OK(do_import(skel, fd, 0, 1, 2), "reimport"))
+		goto out;
+	ASSERT_EQ(do_read(skel, 2), 0x5678, "reimported");
+
+	/* Across allocated and imported pages, then the whole arena is free */
+	do_free(skel, 0, 4);
+	ASSERT_EQ(map_memlock(bpf_map__fd(skel->maps.arena)), 0, "memlock");
+	ASSERT_OK(do_alloc(skel, 0, 8), "alloc_all");
+out:
+	if (shm != MAP_FAILED)
+		munmap(shm, MEMFD_PAGES * ps);
+	arena_import__destroy(skel);
+	close(fd);
+}
+
+static void test_invalid(void)
+{
+	int fd, ro_fd = -1, wo_fd = -1, null_fd = -1;
+	struct arena_import *skel;
+	char path[64];
+
+	skel = open_skel();
+	if (!skel)
+		return;
+
+	/* Write seals are not allowed */
+	fd = make_memfd(F_SEAL_SHRINK | F_SEAL_FUTURE_WRITE);
+	if (fd >= 0) {
+		ASSERT_EQ(do_import(skel, fd, 0, 0, 1), -EPERM, "write_seal");
+		close(fd);
+	}
+
+	fd = make_memfd(F_SEAL_SHRINK);
+	if (fd < 0)
+		goto out;
+
+	/* The memfd must be open for reading and writing, like for a shared mapping */
+	snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
+	ro_fd = open(path, O_RDONLY);
+	if (ASSERT_OK_FD(ro_fd, "open_ro"))
+		ASSERT_EQ(do_import(skel, ro_fd, 0, 0, 1), -EPERM, "read_only");
+	wo_fd = open(path, O_WRONLY);
+	if (ASSERT_OK_FD(wo_fd, "open_wo"))
+		ASSERT_EQ(do_import(skel, wo_fd, 0, 0, 1), -EPERM, "write_only");
+
+	/* Not a memfd */
+	null_fd = open("/dev/null", O_RDWR);
+	if (ASSERT_OK_FD(null_fd, "open_null"))
+		ASSERT_EQ(do_import(skel, null_fd, 0, 0, 1), -EINVAL, "not_memfd");
+
+	ASSERT_EQ(do_import(skel, -1, 0, 0, 1), -EBADF, "bad_fd");
+	ASSERT_EQ(do_import(skel, fd, 1, 0, 1), -EINVAL, "unaligned_off");
+	ASSERT_EQ(do_import(skel, fd, 0, 0, MEMFD_PAGES + 1), -EINVAL, "beyond_memfd");
+	ASSERT_EQ(do_import(skel, fd, 0, 7, 2), -EINVAL, "beyond_arena");
+	ASSERT_EQ(do_import(skel, fd, 0, 0, 0), -EINVAL, "zero_pages");
+
+	/* The range must be free */
+	if (ASSERT_OK(do_alloc(skel, 0, 1), "alloc"))
+		ASSERT_EQ(do_import(skel, fd, 0, 0, 2), -EBUSY, "over_allocated");
+	if (ASSERT_OK(do_import(skel, fd, 0, 2, 2), "import"))
+		ASSERT_EQ(do_import(skel, fd, 0, 3, 1), -EBUSY, "over_imported");
+	do_free(skel, 0, 4);
+
+	/* Nothing above may leave a range behind */
+	ASSERT_OK(do_alloc(skel, 0, 8), "alloc_all");
+out:
+	if (null_fd >= 0)
+		close(null_fd);
+	if (ro_fd >= 0)
+		close(ro_fd);
+	if (wo_fd >= 0)
+		close(wo_fd);
+	if (fd >= 0)
+		close(fd);
+	arena_import__destroy(skel);
+}
+
+static char *fault_expected;
+
+static void fault_handler(int sig, siginfo_t *si, void *uc)
+{
+	_exit(si->si_addr == fault_expected ? 3 : 4);
+}
+
+/* User space accesses imported pages through the memfd, not through the arena */
+static void test_user_fault(void)
+{
+	struct arena_import *skel;
+	int fd, status, ret;
+	pid_t pid;
+
+	fd = make_memfd(F_SEAL_SHRINK);
+	if (fd < 0)
+		return;
+	skel = open_skel();
+	if (!skel)
+		goto out;
+
+	if (!ASSERT_OK(do_import(skel, fd, 0, 1, 1), "import"))
+		goto out;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+	if (!pid) {
+		/* The arena mapping is not inherited, map it again */
+		struct sigaction sa = { .sa_sigaction = fault_handler, .sa_flags = SA_SIGINFO };
+		size_t sz = bpf_map__max_entries(skel->maps.arena) * ps;
+		char *p;
+
+		p = mmap(skel->bss->base, sz, PROT_READ | PROT_WRITE,
+			 MAP_SHARED | MAP_FIXED, bpf_map__fd(skel->maps.arena), 0);
+		if (p == MAP_FAILED || sigaction(SIGBUS, &sa, NULL))
+			_exit(1);
+		/* Test pages 0 and 1, see page_addr() */
+		p[ps] = 1;	/* allocated on demand */
+		fault_expected = p + 2 * ps;
+		/* Set before the store that faults */
+		atomic_signal_fence(memory_order_seq_cst);
+		p[2 * ps] = 1;	/* imported */
+		_exit(2);
+	}
+	/* The watchdog of the runner interrupts system calls */
+	do {
+		ret = waitpid(pid, &status, 0);
+	} while (ret < 0 && errno == EINTR);
+	if (ASSERT_EQ(ret, pid, "waitpid")) {
+		ASSERT_TRUE(WIFEXITED(status), "exited");
+		/* 3: SIGBUS on the imported page, 4: elsewhere, 2: no fault */
+		ASSERT_EQ(WEXITSTATUS(status), 3, "sigbus_on_imported");
+	}
+out:
+	arena_import__destroy(skel);
+	close(fd);
+}
+
+/*
+ * Only a device-dax mapping can be imported by address. This needs no
+ * device-dax device: it only checks that everything else is refused.
+ */
+static void test_dax_invalid(void)
+{
+	char *anon = MAP_FAILED, *shm = MAP_FAILED;
+	struct arena_import *skel;
+	int fd = -1;
+
+	skel = open_skel();
+	if (!skel)
+		return;
+
+	anon = mmap(NULL, 2 * ps, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(anon, MAP_FAILED, "mmap_anon"))
+		goto out;
+	anon[0] = 1;
+	ASSERT_EQ(do_import_dax(skel, anon, 0, 1), -EINVAL, "anon");
+	ASSERT_EQ(do_import_dax(skel, anon + 1, 0, 1), -EINVAL, "unaligned_src");
+	ASSERT_EQ(do_import_dax(skel, anon, 0, 0), -EINVAL, "zero_pages");
+	ASSERT_EQ(do_import_dax(skel, anon, 0, bpf_map__max_entries(skel->maps.arena) + 1),
+		  -EINVAL, "too_many_pages");
+	if (ASSERT_OK(munmap(anon + ps, ps), "munmap"))
+		ASSERT_EQ(do_import_dax(skel, anon + ps, 0, 1), -EINVAL, "unmapped");
+
+	/* Memory with a file behind it is imported by file */
+	fd = make_memfd(F_SEAL_SHRINK);
+	if (fd < 0)
+		goto out;
+	shm = mmap(NULL, ps, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (ASSERT_NEQ(shm, MAP_FAILED, "mmap_memfd"))
+		ASSERT_EQ(do_import_dax(skel, shm, 0, 1), -EINVAL, "memfd");
+
+	/* Nothing above may leave a range behind */
+	ASSERT_OK(do_alloc(skel, 0, 8), "alloc_all");
+out:
+	if (shm != MAP_FAILED)
+		munmap(shm, ps);
+	/* Both pages, the second one may still be mapped */
+	if (anon != MAP_FAILED)
+		munmap(anon, 2 * ps);
+	if (fd >= 0)
+		close(fd);
+	arena_import__destroy(skel);
+}
+
+void serial_test_arena_import(void)
+{
+	ps = sysconf(_SC_PAGESIZE);
+
+	if (test__start_subtest("share"))
+		test_share();
+	if (test__start_subtest("free"))
+		test_free();
+	if (test__start_subtest("invalid"))
+		test_invalid();
+	if (test__start_subtest("user_fault"))
+		test_user_fault();
+	if (test__start_subtest("dax_invalid"))
+		test_dax_invalid();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_import.c b/tools/testing/selftests/bpf/progs/arena_import.c
new file mode 100644
index 0000000000000..db9cac832a043
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_import.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 NVIDIA Corporation */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf_arena_common.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 9); /* number of pages, page 0 is left unused */
+} arena SEC(".maps");
+
+int bpf_arena_import_memfd(void *map, void __arena *addr, __u32 page_cnt,
+			   int fd, __u64 off) __ksym;
+int bpf_arena_import_dax(void *map, void __arena *addr, __u32 page_cnt,
+			 __u64 src) __ksym;
+
+char __arena *base;	/* in:  user address of the arena */
+__u64 page_size;	/* in:  page size */
+__u32 pg;		/* in:  arena page index */
+__u32 page_cnt;		/* in:  number of pages */
+int fd;			/* in:  memfd to import */
+__u64 fd_off;		/* in:  byte offset in the memfd */
+__u64 src;		/* in:  user address of the pages to import by address */
+__u64 val;		/* in/out: value written/read at the start of page pg */
+int ret;		/* out: result of the last operation */
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+const volatile bool skip = false;
+#define ARENA_OP(stmt)	stmt
+
+/*
+ * Page pg of the tests is arena page pg + 1. Arena page 0 is left unused: its
+ * address is NULL to the kfuncs when the arena starts on a 4GB boundary.
+ */
+static __always_inline char __arena *page_addr(void)
+{
+	/* Programs that only dereference arena pointers must still use the map */
+	asm volatile("" :: "r"(&arena));
+	return base + (pg + 1) * page_size;
+}
+#else
+/* Arena pointers need the compiler's address space casts, the tests skip */
+const volatile bool skip = true;
+#define ARENA_OP(stmt)
+#endif
+
+SEC("syscall")
+int op_import(void *ctx)
+{
+	ARENA_OP(ret = bpf_arena_import_memfd(&arena, page_addr(), page_cnt, fd, fd_off));
+	return 0;
+}
+
+SEC("syscall")
+int op_import_dax(void *ctx)
+{
+	ARENA_OP(ret = bpf_arena_import_dax(&arena, page_addr(), page_cnt, src));
+	return 0;
+}
+
+SEC("syscall")
+int op_alloc(void *ctx)
+{
+	ARENA_OP(ret = bpf_arena_alloc_pages(&arena, page_addr(), page_cnt, NUMA_NO_NODE, 0) ?
+		       0 : -1);
+	return 0;
+}
+
+SEC("syscall")
+int op_free(void *ctx)
+{
+	ARENA_OP(bpf_arena_free_pages(&arena, page_addr(), page_cnt));
+	return 0;
+}
+
+SEC("syscall")
+int op_write(void *ctx)
+{
+	ARENA_OP(*(__u64 __arena *)page_addr() = val);
+	return 0;
+}
+
+SEC("syscall")
+int op_read(void *ctx)
+{
+	ARENA_OP(val = *(__u64 __arena *)page_addr());
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.56.1

