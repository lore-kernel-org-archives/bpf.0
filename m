Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740423A35A7;
	Tue, 20 Jan 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946318; cv=fail; b=Fy6eRNbCLQ/jaUw91Hgc6F9KDMaWUC2YGv5VElHKRsiP4kdWu4fJYwoh5CH5RuebYxLZOEU3sBNhYtH22bRWbNTdw18Vg2u+XqKTzkL2wsrdUG9qb4siikZIAQr1snNMYgTpSZJYr014bsZoC1UK3VjR9XQsuGeS8xIOhin4CKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946318; c=relaxed/simple;
	bh=dz4CWaZHc7PgIdwodp2Gf+mhrA4y4ed44UMEU5xSuGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSf9cx08tnsYIZfNdVh6P7fk4IU/WPfHSSto81lVqXMJ4SCpeNYoxofARDARkFwS/63/8SsZ4fNSmpqp1PqU29Fo5xfkY6tnw4+apvkcbuOoVvVTtIN+MXDDHy2GBYmFIwiCMniF495qJwPD1QA30+/BAYtTu/JGwwJkb9S0vs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HaBBY/42; arc=fail smtp.client-ip=40.93.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HaBBY/42"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otQDx2DlHE2yyX1IFUAdlu4kUzKskAncstxIMi7jd+SQYgR+gUiQ/4Ll/1s1GNJRJxgrsJG/RsGZ8vVXyDKNqLHXE3GqI54ndPuXrMqcD9fLJJtX8Wb8lm01oo+FT5SAj/5d8GliyidYIc+RGmC6OKM94ApPEwEWTVkZKDUFR7QOhmizdW8fj6hYKHbFVazoNmUxlZ/2w6O6bixSDHpJ86uOCjMRwJOI4iIyFhzcoSxBAh/9DPSbpdDs+ANI98m84nl8jOqyMKdQpbeZibuS9dbIbXzvNQCbm0KXihSlvtpYK5kaj4coHH1LC90WvjGBazBtXKDiDXxf7rgMBOSIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2BxfgOzb/ZUKZIrqisDP6iZ7FbikcBBK8ABH+EaAPg=;
 b=LHvEJQDNwTvXk8XirP6ujKANvoYmIVek6QVCPpvYlFSuOMIKhc9ZS56ICEtQHIrvqMg6xmpmlZ0z9HoFVXCnQZt+5/7TyhcpTevrm8FJnWoDNzALV8rAZytaffzybA9+9tZL6im096PmArYuxrvLx3OHKdd6Pq0N6euGJPsOeEZJKQ/X9sw15wFnX/Vu2T2L5LMMaKjQRE4Ufs3JjTMNb2+7cXZJCAVDHpKEBFPTTS8o9Ww4Juzh3TY5Tfw2gtV68Cg+cMgMKXjLwf2v5pUWV+u7Zqx8d7GvggZnsl4456ciD+G4wGcgPfFmZdU4NWJvKR1El2aaqA2v19DtUYgnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2BxfgOzb/ZUKZIrqisDP6iZ7FbikcBBK8ABH+EaAPg=;
 b=HaBBY/42yvmclA3am9KI9TwJm/AjXCiUQQQSwANDaq6IKzqXZBmn/PVGrB+xBwW3ZHPU1MbLTmQdGaTUasMUAer8hYumdwvwIjANDBe0XaOxRmwij+Kd05wFZPxB9BJjU+gICZS4z3HcZXl75Cx/VRC/fFrRVawVl2kB9HaUgVm0CAMPsUkckw0KOE90ZqKaJ2MFMQtTABLgai/dw483bseucaXTgoidslJ/8YiznD8mJfPRU+KnQgMDOVB4TICpvJ/yqABZpSYxmsziXc/G4lmLui5mLh39vNMLiyGsSekjJ7TqNrn/gJOb3BRnIXZILMmA7L+TEJX7evR6aqf4Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 21:58:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 21:58:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Date: Tue, 20 Jan 2026 22:50:35 +0100
Message-ID: <20260120215808.188032-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120215808.188032-1-arighi@nvidia.com>
References: <20260120215808.188032-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: b93979d1-2355-47b1-9df7-08de586f0ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXTbLRa+fx6r8mMRZa0ORIT5RnpeElE2PjEekEigg439G8cYb8+j4l2X8II5?=
 =?us-ascii?Q?1fVz3BXg9DZx0DU6jJHS+6FtPtkYgn+m/Jt3MxfpNw2lzn4Jq+0te2fNl0Vs?=
 =?us-ascii?Q?aWR8ntdzNPxraD26XhPps1xTHVdlqxjliL4X1leY/6hplr3myX4imB1KTqIl?=
 =?us-ascii?Q?HNQ2uUJFWp+DPwnDZBIjxBgMnJ4AohVQoS4Yp3CVC9bGuEvoqgiPEq80uAr2?=
 =?us-ascii?Q?ELXWJUx5n6/W7aW1byvWeR3fxvUZzqbv5qcvltLwWJl8T0BC3/1rsiePbfNd?=
 =?us-ascii?Q?cZO6BxPWX628OqnTsvg3jEXDyrPYeLYLDUYmvisuAPj9GEW7hRAHEsE71tzZ?=
 =?us-ascii?Q?B9fc9INTROQcb1hjoqdN47Tvfhl2r/bjYA6YUYDCAbF2tyH1lc4ovwB+8sSk?=
 =?us-ascii?Q?MbSgAxZmhVSGKxS5DHFcoy8i+fNOc960kkJCEgCIub7Y7XQnp5xUlYNp9ZKP?=
 =?us-ascii?Q?XeTG3cGUPG65zBcXHtFRfca0h4RVpt8SuzTSQF5TLxdisTNdTqnDZnAQDyhZ?=
 =?us-ascii?Q?ULApuRM/FeGC3mnfudKkP7BeOlmN/CyvL8Ty6/IpPq7gZaJ80xvcaiZZMm+9?=
 =?us-ascii?Q?OS3s7u4k1S68hv/JloTynLgDY6p+ztOfBLI/uaRh7yW+KVdb/MyRU49xMZMJ?=
 =?us-ascii?Q?khUfLG8OH6CdDeTUtrtdS1yAqMTG1Wk81sW3ac7ITFkR8qU+fQjdT7h2tf03?=
 =?us-ascii?Q?GR5cw8W7TaRYyNEyE5sX9mYl0+sG23RNuOk04ppjlEeJnfCfvqVsFVNhtss9?=
 =?us-ascii?Q?OezcbGVWMgNu0CDvtUuFmMdgo41FEM+Vc6FhZL0pMJK0jAS2scaH3I4sDQfe?=
 =?us-ascii?Q?cvGGAyFO+x8s4Q9nIHwk5E7ErjtMibenUaIHtlJP5Mo0D22v+ci2QVE5mLZ6?=
 =?us-ascii?Q?G0DRTAeU196kVctNKVVZ4Pid4eD5TR1ZEm22l3zFJZFaQC2RBbyZXws5WzEP?=
 =?us-ascii?Q?QgFbePyYW9FojPT/Vv074l67/3FBu/wO3GgSwlGVqK8gYeIQBspgm2LlO443?=
 =?us-ascii?Q?stDGYd5Ju1uODAOw72qMtpN5onSsh1a1f6sXADgtcMsWPcKNNSK/1nPtF9k/?=
 =?us-ascii?Q?j+TYAak1wWYEZ1iK9RPG2wP1egXeENkyeVU+mZ5qsbZ174/ldXglcXJncX1d?=
 =?us-ascii?Q?ddd+XTBxiSIyyQozXKbaLBQU4WnLRLvCGATd+XXgUDOB//v7WeUuzu5hKiqr?=
 =?us-ascii?Q?EsaxHUBzsZGa9mSkPBjXZgTLgGMGJb43IjI+2D2kEPl03Pdmmudh9YI+Ok3A?=
 =?us-ascii?Q?5Dmqz/17qAbnAkFqf9GgiIBl6d6n5BLtAPV7JW+o2a2y2m9YVzAG1nui0pmJ?=
 =?us-ascii?Q?1z07J504G72Jg3Z5jDLmW055G+EyqsB4JMBITGuKQR7y+FH/QVurQqydMlqk?=
 =?us-ascii?Q?bmIeWczMGIDOFFt5BGBSV0d7IdKo44aSCr9VF8pc7eDKt8D2OrFEAuuF7wAz?=
 =?us-ascii?Q?OymIMiOjTLsZdUoo4TA6n9ukUZdh7Xc+hbXuRqeuCPJJUIylnDiYN8Il29Mb?=
 =?us-ascii?Q?MGl2GAFeKdxjtLMHJfGEkxd3Hyl90BIwFNTR+YJduH4xFywZP2ePGtI2VJm4?=
 =?us-ascii?Q?UXRvrolo80nomEiBzJaDypRiTkFJHRJBPrqIFG++9JKordj6CHWnNvYAd9vV?=
 =?us-ascii?Q?vA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PuFM5aUVH4kKjP6MPq4F9JQgRzzzTLQT+YzWP2AnnoNc9s8NwPs+fgr89kPj?=
 =?us-ascii?Q?bwXsgOfn0eMBolbPwWMj/mb2Qv0RbMo7OmftFny5o7nkPxucq5Ej+NGckHCx?=
 =?us-ascii?Q?zo4ET1oxdhD/1sDT1I/8EY4TE1ZapkXPXu8psVCqiC50umOZyxY2eFDwRKWL?=
 =?us-ascii?Q?aYj4w9ti2Hl6jJr2KIDSUomEQka42s5y6+ewaqw3VT8XF08NQiCEiiHFS6mg?=
 =?us-ascii?Q?tomZ375ltEiQH18o4XYeN0QoVM0YzYxfu1uaktAWhS3oLY5HxYRYY7n9zz6m?=
 =?us-ascii?Q?ws5tM0Y2auCkXhUTqXs+mei7VAiXEgC8f8xKmnmskPdk2KNoN0huGyyvB57t?=
 =?us-ascii?Q?JIaDU+O+brip8US7j8YTH1s6XCMlAlPnF+Y07TxkvOO5DpAEJ/IvqnRH38pK?=
 =?us-ascii?Q?AJJ41inkan9qupZMyMDyiDruHzAyxNi7Xljh3/H9xAPKlMPer70+CFUh51M3?=
 =?us-ascii?Q?S/xdK39JkTcm88mTeTLThzxApYIEKcJGlCgRzbdO7nGauGC6z83vdIDLqsv1?=
 =?us-ascii?Q?+hJVexV14Sg0weTh7TaDbjXHITpxO6yu3a4S/AVUUA1o8QMUDCIrlU40sk/U?=
 =?us-ascii?Q?aX2Ct8V5NEVFJztGpa/0zOLtLpVeHN2pxYtjZH/sTFJ8Cl54DLg8Q4xrlX+/?=
 =?us-ascii?Q?Os/0Lf43Zby29hcr+ScuG/d8xw3Kr5hUywn/S+GXoPl0ri60OX/y1fdZ+8JS?=
 =?us-ascii?Q?46X8A2vrmQL3tkA8H5Em+DRxPtffPChpteA8qu5GfLnqw2/PaCaObbQ8COPu?=
 =?us-ascii?Q?xNso7D/gJ8WZU2yY+thkEGu2CzcWN5fOYEfBDuZeo8zBEXG85XZCUUxy3beu?=
 =?us-ascii?Q?Dtb0Yy7qOyORHnuq56e8Xgi2cisTKuw2ZauFU/q3FkbYcWEd7OXl7pnlnaYk?=
 =?us-ascii?Q?qTXziJrlS6eTlU1bxMGIVFB6trzBFPp3nns1btf1BxE/MBzK5fxs4WBgbd0F?=
 =?us-ascii?Q?9hm8OJwVctHnXJpCo8LIM2CATufSVTPkc2aR8NTzkBrHPKWyqw7eY3RwT0ml?=
 =?us-ascii?Q?hCuQj9Vzl4JGO369N88D0p5CiZf0dZZX3nd2q6w13gW61U0GYD4m2dOmUTlN?=
 =?us-ascii?Q?CXXPvoSlGNsLE//cCqIFVoTOiHagblDVXT8VpW0Fq0EWCJGU2CIlF+doqr4E?=
 =?us-ascii?Q?8EtSkWf/yqI94H4rUV/Aeb2MC/4GBctr7SttX4KaHIYcAVpmZTUYHXrl/gLp?=
 =?us-ascii?Q?bi+WIjWJ8Hvnw1jIdEUHFVdhtxQchTnnQzqIcx3Z61kXStMCy/vgraC276xR?=
 =?us-ascii?Q?QC8OSo1o0zF6DkY3ioZeTltE6/aZwDX6vxBE+d2eP5w/CglCug+0buNo2bZR?=
 =?us-ascii?Q?OPisGB3cU3ELZenb2T3wUhein33MbIoIK/1qPY6VRTlXj03P1FL4utTlsooo?=
 =?us-ascii?Q?EtFon/ZIwJcSMJdQZuB3Ms8aajf1BwTWqWW8PFioXIxVwhAHD5ngbukcJcTv?=
 =?us-ascii?Q?Njj4kNOl+/9Y7YReJadMVUHZrePCnIiUjg5mloItqFyMAnIqQPncuHUdDkt5?=
 =?us-ascii?Q?NZLMFvJm07KeZf92Nvm3D2XHBLhaOPtduGOBdJ0mTunBSlZNxLZUb2N4XV1z?=
 =?us-ascii?Q?7OB5h444OvoGYImNiYn1bu52TQa6PORGexkhYFtu/LymGb9SH/62MLyig0wZ?=
 =?us-ascii?Q?wMq/Rbft6lLlzuB7fOrq+zzhdXESosOPLX2sYceR1OvS5F2DEmmkGd0toBqN?=
 =?us-ascii?Q?TPSq2yoDOwT0AJ6Mchf7kMOI1MAe3sUtdzP99u748MT3ap5j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93979d1-2355-47b1-9df7-08de586f0ac5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:58:27.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ+38KDHH3Cb3lZJf2UbVcEzTSrmjY1NKpfzez6fV/r1ua4kGdRr/VdqYFtt+UAxFWerQ971GVWgf6oRMBdUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also included later to confirm that both DL servers are
functioning correctly:

 # ./runner -t rt_stall
 ===== START =====
 TEST: rt_stall
 DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
 OUTPUT:
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1511) is 0.250000 seconds
 # Runtime of RT task (PID 1512) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 1 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1514) is 0.250000 seconds
 # Runtime of RT task (PID 1515) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 2 PASS: EXT task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1517) is 0.250000 seconds
 # Runtime of RT task (PID 1518) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 3 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1521) is 0.250000 seconds
 # Runtime of RT task (PID 1522) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 4 PASS: EXT task got more than 4.00% of runtime
 ok 1 rt_stall #
 =====  END  =====

v5: - do not restart the EXT server on switch_class() (Juri Lelli)
v4: - initialize EXT server bandwidth reservation at init time and
      always keep it active (Andrea Righi)
    - check for rq->nr_running == 1 to determine when to account idle
      time (Juri Lelli)
v3: - clarify that fair is not the only dl_server (Juri Lelli)
    - remove explicit stop to reduce timer reprogramming overhead
      (Juri Lelli)
    - do not restart pick_task() when it's invoked by the dl_server
      (Tejun Heo)
    - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
v2: - drop ->balance() now that pick_task() has an rf argument
      (Andrea Righi)

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     |  6 +++
 kernel/sched/deadline.c | 84 ++++++++++++++++++++++++++++++-----------
 kernel/sched/ext.c      | 33 ++++++++++++++++
 kernel/sched/idle.c     |  3 ++
 kernel/sched/sched.h    |  2 +
 kernel/sched/topology.c |  5 +++
 6 files changed, 110 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 045f83ad261e2..88476d8b4e3d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8477,6 +8477,9 @@ int sched_cpu_dying(unsigned int cpu)
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
 	dl_server_stop(&rq->fair_server);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_stop(&rq->ext_server);
+#endif
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
@@ -8680,6 +8683,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b58a25e2a91..56c7c99a1067a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1443,8 +1443,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		dl_se->dl_defer_idle = 0;
 
 	/*
-	 * The fair server can consume its runtime while throttled (not queued/
-	 * running as regular CFS).
+	 * The DL server can consume its runtime while throttled (not
+	 * queued / running as regular CFS).
 	 *
 	 * If the server consumes its entire runtime in this state. The server
 	 * is not required for the current period. Thus, reset the server by
@@ -1529,10 +1529,10 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	}
 
 	/*
-	 * The fair server (sole dl_server) does not account for real-time
-	 * workload because it is running fair work.
+	 * The dl_server does not account for real-time workload because it
+	 * is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se->dl_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -1567,9 +1567,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * In the non-defer mode, the idle time is not accounted, as the
  * server provides a guarantee.
  *
- * If the dl_server is in defer mode, the idle time is also considered
- * as time available for the fair server, avoiding a penalty for the
- * rt scheduler that did not consumed that time.
+ * If the dl_server is in defer mode, the idle time is also considered as
+ * time available for the dl_server, avoiding a penalty for the rt
+ * scheduler that did not consumed that time.
  */
 void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
@@ -1813,6 +1813,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_defer_running = 0;
 	dl_se->dl_defer_idle = 0;
 	dl_se->dl_server_active = 0;
 }
@@ -1848,6 +1849,18 @@ void sched_init_dl_servers(void)
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+		dl_se = &rq->ext_server;
+
+		WARN_ON(dl_server(dl_se));
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
+
+		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
+		setup_new_dl_entity(dl_se);
+#endif
 	}
 }
 
@@ -3179,6 +3192,36 @@ void dl_add_task_root_domain(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
 
+static void dl_server_add_bw(struct root_domain *rd, int cpu)
+{
+	struct sched_dl_entity *dl_se;
+
+	dl_se = &cpu_rq(cpu)->fair_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_se = &cpu_rq(cpu)->ext_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+#endif
+}
+
+static u64 dl_server_read_bw(int cpu)
+{
+	u64 dl_bw = 0;
+
+	if (cpu_rq(cpu)->fair_server.dl_server)
+		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (cpu_rq(cpu)->ext_server.dl_server)
+		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
+#endif
+
+	return dl_bw;
+}
+
 void dl_clear_root_domain(struct root_domain *rd)
 {
 	int i;
@@ -3197,12 +3240,8 @@ void dl_clear_root_domain(struct root_domain *rd)
 	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
 	 * them, we need to account for them here explicitly.
 	 */
-	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
-
-		if (dl_server(dl_se) && cpu_active(i))
-			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
-	}
+	for_each_cpu(i, rd->span)
+		dl_server_add_bw(rd, i);
 }
 
 void dl_clear_root_domain_cpu(int cpu)
@@ -3704,7 +3743,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
-	u64 fair_server_bw = 0;
+	u64 dl_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3737,27 +3776,26 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		cap -= arch_scale_cpu_capacity(cpu);
 
 		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
+		 * cpu is going offline and NORMAL and EXT tasks will be
+		 * moved away from it. We can thus discount dl_server
+		 * bandwidth contribution as it won't need to be servicing
+		 * tasks after the cpu is off.
 		 */
-		if (cpu_rq(cpu)->fair_server.dl_server)
-			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
+		dl_server_bw = dl_server_read_bw(cpu);
 
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw - dl_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow = __dl_overflow(dl_b, cap, dl_server_bw, 0);
 			else
 				overflow = 1;
 		}
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afe28c04d5aa7..809f774183202 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -958,6 +958,8 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -1501,6 +1503,10 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	/* Start dl_server if this is the first task being enqueued */
+	if (rq->scx.nr_running == 1)
+		dl_server_start(&rq->ext_server);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2512,6 +2518,33 @@ static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 	return do_pick_task_scx(rq, rf, false);
 }
 
+/*
+ * Select the next task to run from the ext scheduling class.
+ *
+ * Use do_pick_task_scx() directly with @force_scx enabled, since the
+ * dl_server must always select a sched_ext task.
+ */
+static struct task_struct *
+ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+{
+	if (!scx_enabled())
+		return NULL;
+
+	return do_pick_task_scx(dl_se->rq, rf, true);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_pick_task);
+}
+
 #ifdef CONFIG_SCHED_CORE
 /**
  * scx_prio_less - Task ordering for core-sched
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c174afe1dd177..53793b9a04185 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -530,6 +530,9 @@ static void update_curr_idle(struct rq *rq)
 	se->exec_start = now;
 
 	dl_server_update_idle(&rq->fair_server, delta_exec);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_update_idle(&rq->ext_server, delta_exec);
+#endif
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 93fce4bbff5ea..d630f46325379 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -414,6 +414,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void sched_init_dl_servers(void);
 
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1151,6 +1152,7 @@ struct rq {
 	struct dl_rq		dl;
 #ifdef CONFIG_SCHED_CLASS_EXT
 	struct scx_rq		scx;
+	struct sched_dl_entity	ext_server;
 #endif
 
 	struct sched_dl_entity	fair_server;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cf643a5ddedd2..ac268da917781 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,6 +508,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (rq->fair_server.dl_server)
 		__dl_server_attach_root(&rq->fair_server, rq);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (rq->ext_server.dl_server)
+		__dl_server_attach_root(&rq->ext_server, rq);
+#endif
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.52.0

