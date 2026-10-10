Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34436F8F0;
	Sat, 10 Oct 2026 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672556; cv=fail; b=OephJPqa2HnTxM3KPv5bjpys/qBkB7BPpJMF8lHihm0A5xYvhxJ2RPvsth+41YjEef2kEBQ36OnMZbRtReoYbtRuP+139lBSL5rUbtrQHIXrI9U3bydb33fnAKxuSmE8LEvRBud1E3QFJiePxFW1gw4IL6i1BNl3dwAAdT3UTdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672556; c=relaxed/simple;
	bh=AuhmrbnQWWn6tUJtIYozfsq0TL39wykDNXqWKzlRcug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khQ93JZQJBFRMT7yODKNEQ919kwRvSLulqtA9Hg+LiPk2MB77ZTZ4N57fPFqW/LdH3vqnssGyZhvAjd/Tqe4ZVORBA8PIleQBz/cKHFQoxzWQHl7jDdTnwuc0Kg+jXKyQTrRX+D6mXpA+5pDQ/W1zhW4MFyiSm19g4Tl8KthT5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iiig+2rt; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iiig+2rt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAxlf1YUFmqqGHInakJlg/xl8FEjeQ7nKk2vdM/Gu6xKYNXtsFYZ6GrzbRUKUjCatR6VYZlI6MX17d1jRnoWSHaYh7atwgeskHjq1UbMIeLyZR6Mry+DMOs652d8KGQvg9+s7Cze5xKgM517TCUYtRRN0g9S/uqGEpmHKVYpTELMj5PSAiMc0egGCwAijbN/9s4GN2rGt2UESttNW6se/2f4SMdSFytZDwKRQoMcZ8ufm0UqqoRdTevCl5mDiL3TT8kUi+mvUh3at6cTZ+w2xSgX/ThnsexrsXbT47HpWJfLJExdPCAWSQ1Lpbfqbn+q/T+HLIFz8RKoAFqxPruTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UODJsQJdabpvkgu6eZVL3qPBdSTHRl13g4obDudNsNc=;
 b=ZPfpGdzFNrZd2M3SUgIQL2W2/7gPTz0DenahYUpEMyzCCU33bJEmzym0zvnmN91nU25waOU8JZlNu2L1WyYSGHg/4rGZOFp1CnXE3Uc8DhSRJ3ylTp14w1kyUmTgtVgrRsFuxuLn5C5pA2a/DmrDF15BjC7x3ftMLUOGu8pGkvEV8eQLKItDDi9Avpa8LOMIpqENCkAbhJNhtMmhJ7ovBPSWtEEkx+OotGB/b9bXdLtmSMonCek1PrPhsPLz2ujtox7Y+n45h3bMWsKFLeDINqVzCEJBR32pmxtsVShi53plQ77pXOR4OuQp3XfiF8vGrYUPm7G9SA1I1mo3mbBJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UODJsQJdabpvkgu6eZVL3qPBdSTHRl13g4obDudNsNc=;
 b=Iiig+2rt66zsN+LAKk1kGFpwvbHEhoGa/1avBD1BMiCOO1hxgYW0XeNM3VouqCeXCR+POsnv7jx0KbS2T41KoO+sRTewF0Frc21UU8Kp1QMvSpT5lio5Zulbo6BTZATTk2L/reSJ3fN9edKKAxu6UZX5/gJvvTPq+IEXzQk3tlSMfd2fcU4tCpqEUqEgdxQVLzVdJdMoF6D1/qOS0cObzsceEL62cDrvLLFZMlp7f4AXIh9bgURWwO/4DEgY369vYjZlu246TsT6y9t6QneuhAOqg6IizLxeX563k8N42k+UmRijtL34VHKpCk+xXTITA0NQ68XJFhv1ENZkqXOLgg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 22:49:12 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 22:49:12 +0000
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
	Josh Don <joshdon@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] bpf: Add an arena flag to retain allocated pages
Date: Sun, 11 Oct 2026 00:45:56 +0200
Message-ID: <20261010224902.1232178-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010224902.1232178-1-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: a8393ec2-d801-4b6b-51a7-08df2720b3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	AZF5gNTcFj78GO5YKmLq1J0fVDWHaBbRPa837qVi/zlBCub+o95pBcsRnuvDHU3IsZtfwzpPTwJSHfFwOzxqhzW5ZfBMOWroZj7Qj4lSjlL9ncbykDIpy9tJNKVChR8DO4TyQ5FGqEYgcfQPd0tq9pndstv6NWMxkB7f6yJlTQrQ9e6Ta5z1qpoZhpt9/kyDiFyp8bgAs+M/lor9UdSvdgMQCbPP3Cmca7WhsdyeVaVKwBhD/UV0qYc8u4iYCeGz2XmYx1fqVlEo2b2jDVAiOn1kD685noGFkyqkI7DORHGw8e0oTwT2IAu2nGTpXAgpMPp9XRWa8Zkc9+2x4euQ6c2h11WES8Io6HoL3OYKjUUlPs8DvZzqDzIAtbj0z4MIk7SczrlUPUcqwVI5CCAzJkqYSytpZlpmZePVqSMgRAtPMLERqQf6tMi08XpOaLRbpaF8FWJ0FYXxPEx04NOCenm+41+MRpG/3DiUUL0+0UWpSfmRRPJ9LZijYl3yV59g2lIbRZNjnvETRsGqci7cFVB/HAunx+t1iNYwgT3+ImxRhEPAW/dfIUqVPuCATIQekQ6T6Fi1ze5yrUKwrinUWGC4dH8JdIA1xgE9VwXxowi5tO1l82PVaQ+9PPpkLC0YaW2KVStyryyVRAikOasfqqWrO8fqPIiM+tsfX+2mZhY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pbs+2n8SUmB+IkB/IUawvNYnmkeICOBlGUhr7GrCUTrRKEiUPNsZy58RvQYk?=
 =?us-ascii?Q?o+d4CC+5IvTk2GuPhzS95bx1OvEC+3RPc5gHWeOspJPCSrHZSyIvbK120Ojp?=
 =?us-ascii?Q?vUbeD3rbL68uEwF6USL1QjFGXx/xjO/NApfTQQLl+NoN2uPvuETA9ehRfEy0?=
 =?us-ascii?Q?GvYa9ewXmNUoEr3Wzs6U3b4AtYAcdaBy3l764T/RQqTT4q3thM0VgpBROgYY?=
 =?us-ascii?Q?7qCzrjEGktDfyIVeDtuYCWYteXeY2ced/ZuoOmuKHwKyQjQBL1QlGJhrkYG8?=
 =?us-ascii?Q?JM6jsC7h7I25qtbOs44FQLIRoaAi7f1ixZ/fxFTrZDL8IVo3ulKvDLGbxfnK?=
 =?us-ascii?Q?wW/pt0sjxTeCfttO1WMN9013KtztOrxq70d5SYHUHP6Kq4MSCVRMrrtKhmQQ?=
 =?us-ascii?Q?vbSGgjuNxP60CNP7eCcJn/BN0rOU70Yx0hztNWUShUKmvKwPhXXU9FLAf5zV?=
 =?us-ascii?Q?QI246Bteu04npTftO2gdJJFp1sMJ/YRy1xn0uWscFz6Pfl5Z3gYJRpDXPEwt?=
 =?us-ascii?Q?zowdtI/RvGVNsmbaR6A4JQoebVaYIpH/BC+tYep1CbcP8Y7fq3ddTP+5vH9z?=
 =?us-ascii?Q?UuEfsl5smtmwxn+jobgWa6F4HfAxUfS1aBKw9f1gSh7c7EKMiSOoWP1CYVgQ?=
 =?us-ascii?Q?Dr3EBWivzzqY4UNX+PV9Tj690pnY5ZyajFv5b+2T/422+FyMkZmbbCoRUeYD?=
 =?us-ascii?Q?r+P/2TUW26msIY99RLzd/RgHzMOb1GegWIiuD8+PLXzd5r3qKAnFLvW8M0uJ?=
 =?us-ascii?Q?2C6QMXBgcDJet0thwYlMoy4mWUWxzercBL3Ifyz2nS1wgZRQgdjbar6u5wwT?=
 =?us-ascii?Q?REunA0aKbKjrttrE5wmGedlhjTWLAmOB4dAmO2H+ZCYESM54uvBeOSFUXIuw?=
 =?us-ascii?Q?3EEUrBIcZW2c7qCKxboS5OxBS0aLMj0gmPbgQpjGXP9a2j8bPQfCGahn+rmS?=
 =?us-ascii?Q?uW0liVhss/nT6R7VarQxbHlmc03OUbXhM18uOSucOeSa3hSBTMY9j6WEb2s5?=
 =?us-ascii?Q?f7taCxQPp+XF3mWwlvA35y5/sJ1JgfReo0YaSuYkYTSR6wPW8dzcD9suqOmJ?=
 =?us-ascii?Q?goSPCbE4On8EhteKvAtd+IBeLM92neVVlMIO++PTDFBZce5fR2lC3GXicQwm?=
 =?us-ascii?Q?R/L6/CCejYWOMI4ahJUBTlHQ8uU+CYrFCLnPlJL82N82pzpFpJVLMBod74RH?=
 =?us-ascii?Q?DIFgP/1TQe7omMABPnRvvlAse4gIRYOmmFl+GjiH0XbbYdnvNiuqXlvxh71r?=
 =?us-ascii?Q?GRWe3GZKCXFo8c+Qjm5akYpQ5doyhm4S339rYuUY736N3wptrbV4/Up3g3Jn?=
 =?us-ascii?Q?3YKuaK668wXNBL2jnLgTmJR49VZpSI3G+aQW8ilnlfWJqWYQuoNKOdLb+nsw?=
 =?us-ascii?Q?nER56HcastwNqmxJk+uNVHgrqk6pxIBMQTyp9G9F5ioYeeVZq3MnmJfHLWL8?=
 =?us-ascii?Q?OEcaY8VkULJy4dtxZElG4sI4hiDoIUO2Hubco0Du+1q1oZknn2PdsNoShq2K?=
 =?us-ascii?Q?i7srmplPYK++PjPLffcABg0p8lFhv/tvBlk7JcTsABpf7++ag4FnqC70BN1N?=
 =?us-ascii?Q?4PRicllH4feIjV57xSKUpkVAqfb+QQaY7o1zUQYg1DnMQYJIoZltI3f2PqS2?=
 =?us-ascii?Q?1NYllVOAI3ROqBhfk3e1ndtXAK3pkCg72uoAR35JlsrqabgDHUkgn/A7Yg2Q?=
 =?us-ascii?Q?5sRSUFJ0Jnsu0GAf8VVBIOvEog5wfYAvCNQSL93j26JUoTbY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8393ec2-d801-4b6b-51a7-08df2720b3b8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 22:49:12.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MELVze6yHK5d7i1WHCJxGwvjWx6KV2JeJTP7GwIppdXcHq0I0g2ACUlGKyRV1XBccbbQgOEkLRLHK5yjt5KDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

Add BPF_F_ARENA_NO_FREE to retain arena pages until the map is
destroyed.

Make BPF page-free operations no-ops in both sleepable and non-sleepable
programs when the flag is set. Programs can manage reusable objects
within the retained pages without releasing their backing memory.

This provides a page-retention policy independently of how userspace
accesses the arena. It also supplies stable backing for external
consumers that must not lose pages while they are still using them.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/uapi/linux/bpf.h       | 3 +++
 kernel/bpf/arena.c             | 9 ++++++---
 tools/include/uapi/linux/bpf.h | 3 +++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0ed44b1bbcb7..75101d602bd32 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1500,6 +1500,9 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+	/* Keep arena pages allocated until the map is destroyed. */
+	BPF_F_ARENA_NO_FREE	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0ff707707da04..343e84139ec29 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -283,7 +283,8 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	    /* BPF_F_MMAPABLE must be set */
 	    !(attr->map_flags & BPF_F_MMAPABLE) ||
 	    /* No unsupported flags present */
-	    (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE | BPF_F_NO_USER_CONV)))
+	    (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE |
+				 BPF_F_NO_USER_CONV | BPF_F_ARENA_NO_FREE)))
 		return ERR_PTR(-EINVAL);
 
 	if (attr->map_extra & ~PAGE_MASK)
@@ -1134,7 +1135,8 @@ __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt
 	struct bpf_map *map = p__map;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
-	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
+	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign ||
+	    (map->map_flags & BPF_F_ARENA_NO_FREE))
 		return;
 	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
 }
@@ -1144,7 +1146,8 @@ void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_c
 	struct bpf_map *map = p__map;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
-	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
+	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign ||
+	    (map->map_flags & BPF_F_ARENA_NO_FREE))
 		return;
 	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0ed44b1bbcb7..75101d602bd32 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1500,6 +1500,9 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+	/* Keep arena pages allocated until the map is destroyed. */
+	BPF_F_ARENA_NO_FREE	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */
-- 
2.56.0

