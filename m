Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F336F8F0;
	Sat, 10 Oct 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672564; cv=fail; b=sOWjIh9PLKZYZVrwKtrS6yatUZJsQmAaespgJ9bnwh9a+AR+Yfp5mQXLJOlly/MuE0rUHObH0Tvr2noZhxcybvb1jE/wwIxarYpmUwk/gKUJvUQkcmHcCwsfkj7YxQLbDwFO/X6o9xKBeFAkyWEWDecc4SXY7F1LjsGPg6jPUX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672564; c=relaxed/simple;
	bh=Jvwv66Sb0bdgsG1L22D9HQlMAgEJAnh94SC9Cm3CwBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVhJTDruTTFbNmSK9GPAmDeYKjjVn26+1zxLxVvigouNPyP6esTzuADBQREV2qvEhjvqqDn51U/AyHcf/qnM5ACNpHjUR91fGGLJXvlNa+NEQefzzPWtUyO6gmIyarHTVRi/MyH94PkYIfBRP9N1pYRkvjTbEhPkuHU7b/5ge2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0IKLlLn; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0IKLlLn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CljYe9Fs4tzCDkR6Ej/8c6Qfm/yBwBBO3+T8K02VEYpJi/qPfL+RaL+Ytf/+lH+HZyZr1tOwR0NZil1z+33ponp3UjdT5i4xTkWFyF/cGUar0ezR7ajAyu+uXDg8D5pNdjCKsP5nrkGsYmTIirLwUc4iI0VjquSRZn0ST2UNATuFbIBPRssLIw/bySicmZvacL1Gx/5sAJNZP4F9ilsG/2higvo7Rp/TfcQB8jKszzimySHpp9DrkgSGytD7CI9HbxDc+qh5eJ7GPTewOXkh7xSrVsL49B88AKbWv4gQCkNJn3mdEQ4k9PBu1yS5rQi7jUKWR3B/fxubYfbQX8aafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bE9yN0jR5nhmsyNVRLxmxz2m3Ygbc9msyMwzU6ygyE=;
 b=xCjSXn7ZS19UHWtAk/KNtTklXjKckUmGFbNUJiDWnELh9VsjhsD/D3Cytrwzmwh4mz390al/fYAXTsd2hOo06WKP0SgOoOvVrYZOWlSM7JBz9jY8DvudOzx2S73CqOp5cOPy6Xx5uk5T8O3/jNptc+qL4thiOTN6GPAz+J5MclT9ZbyDJRGirbRPE2V2q1YTocB3ruqPd78ty56UmlMnlelNYYT4JONh0a0CwbCiNdjzPZMlTO6hC6AdBsvPaIHr4sHwXBBjaTFyZ80FZfhB1lq27wkN+1Ff7/7O+FMbXhk+nV4dj7IyEZkh/79OKbLEDIIFMUuQ3M/V2fec3/SG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bE9yN0jR5nhmsyNVRLxmxz2m3Ygbc9msyMwzU6ygyE=;
 b=R0IKLlLnYaAwyM3+//Vs7yJzf7CkeB/306fcNFB4h23qyzNPZdT8RzbBSmO20qpkxH7vzgzaXtnMuvrB0/AzP746bErxph9ozRAI45O7KNGEcPc2OYK6A9vqgKCk+M6pgrmZVw3Zv/CvB+8Erzz8MT3dZCY5jLor2EPSHeUnznAoZigHSmsIj8Id80gCwaPLpBNeF/JYt4huzkoJGGXzUbQnzkSwJ5OYUfcjsHw85Zjm26/1Dy559o9mVqcB8aWLKLLuD+Fn8IS0ar2zSgMztDHZ6c1Io3FV7dRjHsYFfCaS9NToNzXu8jLH2964mqkmQQPt8YnOOhw9pEfNgjcmmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 22:49:19 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 22:49:19 +0000
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
Subject: [PATCH 3/5] docs/bpf: Document pinned arena file mappings
Date: Sun, 11 Oct 2026 00:45:58 +0200
Message-ID: <20261010224902.1232178-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010224902.1232178-1-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ace6adf-fcba-4234-fcbe-08df2720b7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|3023799007|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	GbwI5uRQyzJAps2aLdZSdzo7nzytLPB0RvHL801eZLx2GYjdNLyNFY9ZTMTsrmxZso7itnlf4iyn205QG2ArifVdbYcOYBPZdQ+n3kr3tkBpYHY2CCBfgf0bXqKnRA6rqRgFOThHMM8OJyUd5QHy+lKnJE2gCnU8G/j93jborLBBgGTYRzSqEs51wCTkKHpOrF/np0dHn/DWrtUn1s9QQAPb4CxUnuOPA2cBFLmgxV1e2LI7qhswDIT3fBAAyVszqDHxoqYjpT0v5xY5APYzFxF0MH2RFCy3EiMcgBib+ze1vxRKaZWj4oEQXFoJt+hepWAMd3TYON5+Ftxb73eRzkgWBaLR3ncfFkHOSpEoGwKG8PQLR0BAwsRWxMjt02e2VzY4D80enGFRvUh92yGrVK6iHafn+D7QJs6aKrhsQY+qSw+dpUghT7zCrg1UnWNK38ewBdGy5TQfBX2nBFa0jxnRz4aOi8wAvJ9gIYP/QzPBne4qCwxP+xhXawezMDvP+3D3DQmodHIU0nHCSwPXHkHzTB82cAIQot3dP0OpGgaLj7Uaclmm5MXiwh+pyDPCXEAOpJZSKDXT+FRJ03BSy2a+PejJdZNhCwRyU9ihxYEtxocPGRLCINs4BSy+ZUr4tderwwdqD8Z8QjqO3jn4eq5gqgAR5tj7Se93c0y/FY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kTDQlZclccbGcoIlnvEYlNLNqgvOiXGTlq7C8WoiMs/WUeIvTmBqeNXP1ng?=
 =?us-ascii?Q?wSDq3tNSZry5jR9ho9KXfbLRKglgJsJeIdK3WT/XmC4Y+wNGFF+5J/rFIhX7?=
 =?us-ascii?Q?DsOvMu+Z7KHczNW8jHBW0slndo7BU46LvGIcFam1Z+LtVZ3MycLrKIwmnWio?=
 =?us-ascii?Q?ZtKsCuMc/DUXiBP7mimiNlk6vAdq0FdsTQABpp8uZDTwpkkjoOTyztdFS3lm?=
 =?us-ascii?Q?Mjso8gXcFpUoqOXuFbU7t1oKnvU7vaA14JBxPOiTOLFFtpBmiFIZdZQUPejm?=
 =?us-ascii?Q?gIDryezMLtDwZDsvssDktnucEcVS/eWVNdWxn8Dc7a7dCEsGnN2UVXd8TQ3k?=
 =?us-ascii?Q?Mee/y3ZHE+CPodD2IvVd+3vojOLWHBMyC4+u4VSgSIjQDJpMWiJ21CZDrVmn?=
 =?us-ascii?Q?rxi9WSQLWJDB5jGi0GC5Y+tvb1UIgbSJG6LBR8CttLEjj4hQiR68fePUWSrv?=
 =?us-ascii?Q?l1OWYXmKZEKKMNV4USR+vKghyr2Rf5BdAaukq7gr3OCJRyoI+BOoGOV0ue1D?=
 =?us-ascii?Q?NkVh3bZ0nhFZJFnwPNDE9XwfCwwQQicQMtrCotT/mtZlba7irnhs5Opnjcor?=
 =?us-ascii?Q?gmpL8RznESa8OZ+Yn6pH9nULCyzwa2HyHJZbnvl8hsF7ZY+DPfeNW9uU/3Ba?=
 =?us-ascii?Q?ZcyL4na9w0aSLrUVRTQTdp9enyC3sVfMNOHJfayJel2D0O2UhxNTfkF2Peog?=
 =?us-ascii?Q?1ixwxZ1v70FVPYBnp19P5GwNSsLn16VepwhB6QiKv0TkB0iaCqRHc7wsIEbu?=
 =?us-ascii?Q?oWW2xM2qzGhVDjzPDcEHHxY+7/zMXZK/5/rj5Hf5bTKfcu6d18Iz4fNnri7u?=
 =?us-ascii?Q?F3mgDzshUP77ic7hMIBa51/xJVMHwrA5kPTabnBhO2YEJhWno7K9Z5FBkNcQ?=
 =?us-ascii?Q?SxVvMGu/nhfk4pZtTJrS/5vN83ldLRxBCe7ePhn28Et/l37RCibKte3kSo6A?=
 =?us-ascii?Q?NnbFSFiADPboC09+/Txis1N4VHQHyodfeHDl2G2wii2WP6TBvQ6kGyGsN76K?=
 =?us-ascii?Q?s0+1PQPrJEBXBSdT84tjm6OE9yJE8BzqobTCvJFtfiHsjOFpv0Ck3tc1D94j?=
 =?us-ascii?Q?FIgndG5HoDlgRRcYCh0dOp3aW+umJUJBg/apLXPuHwNt7akHhqmo+ai58Id/?=
 =?us-ascii?Q?ItctKgo7lQ8WYsNJOBlmw42IEqvGYsNwzyqc6/zu3xA8214t0YYgCTbQMDjQ?=
 =?us-ascii?Q?7vxXtwk0ac5qP8L/sEz4KTo6XPK3+EtdE6iUnO15RG6vqPAoPL/p256FVEsP?=
 =?us-ascii?Q?7G7IL5vzubZG5Xs3uo6k9xp+OHTAB8VReQ+7ucT0Qb8CWkuS20oEjk0BtUaR?=
 =?us-ascii?Q?e1C+EZblsozeC4cRszIQK7AoYosQJNDf9lqe1gx9P9CLp+7Kj7AepQLa7STk?=
 =?us-ascii?Q?RgLT1+5NUJMunY2vCcY8Ae8LTW7A1ZToEgo0fvYW5v1BV7wkPSLKViJrGRLd?=
 =?us-ascii?Q?G/u8/Jz7mIRMIFttJIttbASmxqJrDClPhFOGgITCAa9XR6NA9nueTI+Xh3NR?=
 =?us-ascii?Q?YM+mnkyj8FcJ1pCAL+1hWQSRefNrlXt1Gb0XGw0FoUoP8LxC54VdXpuOWFum?=
 =?us-ascii?Q?AvBsD3nNNiqKL6Ce0vv0LKoCmWnmdaLZVRI6FRRhaIl9yMYIiWabQlue5AAh?=
 =?us-ascii?Q?Wu/AMKCk1owdbaHdLlrnHN/o5ykzmCnwnMhd9HMhOwIZC2QCTYNs28ZXuO0c?=
 =?us-ascii?Q?B6EQVZ5ceImvt1lFEXYabDCVYJPp4vkNVw/pYQ5MPcqgyRBp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ace6adf-fcba-4234-fcbe-08df2720b7f4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 22:49:19.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2U5D/6JrEyu41gSqgPAfEyQNhh+RbHlqvP3uvHnm6hCiXALfqNxuG7PBOpK2i8OXyWDbwotLEZPlupuw9vmM1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

Describe how consumers can access pinned BPF arenas as sized bpffs files
and establish the canonical BPF address range before mapping them.
Explain slice bounds, access permissions, fixed file size, and mapping
lifetime so consumers can use the shared-memory interface correctly.

Document fixed-size seeking and the inherited arena VMA restrictions:
no fork inheritance, splitting, expansion, or relocation.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/bpf/map_arena.rst | 131 ++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/bpf/map_arena.rst

diff --git a/Documentation/bpf/map_arena.rst b/Documentation/bpf/map_arena.rst
new file mode 100644
index 0000000000000..1b9eadd5fb3a1
--- /dev/null
+++ b/Documentation/bpf/map_arena.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==================
+BPF_MAP_TYPE_ARENA
+==================
+
+A BPF arena provides shared memory that BPF programs and userspace can
+access directly. Create the map with zero key and value sizes and
+``BPF_F_MMAPABLE``. ``max_entries`` specifies its capacity in pages, up to
+4 GiB. The canonical BPF address range must not cross a 4 GiB boundary.
+
+Pinned arena files
+==================
+
+An arena created with ``BPF_F_ARENA_EXPORT`` can be pinned in bpffs and
+opened as a sized file. Its size is ``max_entries * PAGE_SIZE``. Export
+requires ``BPF_F_ARENA_NO_FREE`` so BPF programs cannot release backing
+pages while external consumers may still use them. Creating an arena with
+``BPF_F_ARENA_EXPORT`` alone fails with ``EINVAL``. Arenas without the
+export flag retain their existing bpffs behavior and cannot be opened
+this way, including arenas created with ``BPF_F_ARENA_NO_FREE`` alone.
+
+Establish the canonical BPF address range before mapping the pinned file:
+
+* Set ``map_extra`` to a nonzero, page-aligned address at map creation.
+  The canonical range then covers the full map capacity, even if the map
+  FD has not been mmaped.
+* Alternatively, leave ``map_extra`` zero and mmap the map FD first. This
+  mapping establishes the canonical address and must cover the full map
+  capacity. Shorter canonical mappings fail with ``EINVAL``.
+
+A canonical map FD mapping may start at address zero if the system's
+low-address mapping policy permits it.
+
+Mapping the pinned file before either step fails with ``EINVAL``. Exported
+mappings do not establish or change the canonical BPF address range.
+
+Once the canonical range is established, it covers the entire capacity
+reported by ``fstat()``. Consumers can map the full file or smaller slices.
+Establishing the full canonical mapping reserves virtual address space;
+it does not populate every arena page. Arenas without
+``BPF_F_ARENA_EXPORT`` can still establish shorter canonical mappings.
+
+Open the pin with ``O_RDONLY`` for read-only access or ``O_RDWR`` for
+writable access, and mmap it with ``MAP_SHARED``. An exported
+mapping may use a different virtual address from the canonical mapping.
+Its offset must be page-aligned, and its offset and length must fit within
+both the map capacity and the established canonical range. Consumers can
+map disjoint slices of one arena. Oversized or out-of-range mappings fail
+with ``EINVAL``. ``MAP_PRIVATE`` mappings are unsupported.
+
+Exported mappings share the bytes of the arena without relocating pointers
+stored in those bytes. Arena pointers produced by a BPF program use that
+arena's canonical address representation, based on ``user_vm_start``.
+A consumer mapping a slice at another address must translate such pointers
+before dereferencing them. A guest BPF arena has its own canonical range;
+sharing the backing pages does not make host arena pointers valid in the
+guest arena, or vice versa. Communication structures can use offsets
+relative to the shared slice, with each side validating the offsets and
+translating them to addresses in its own mapping or arena.
+
+A pin opened with ``O_RDONLY`` supports read-only shared mappings, which
+observe updates made by BPF programs and other writable mappings. Requests
+for ``PROT_WRITE`` through that FD fail with ``EACCES``. A mapping made
+without ``PROT_WRITE`` cannot subsequently acquire write permission with
+``mprotect()``, even when the pin was opened with ``O_RDWR``.
+
+Pin permissions can grant readers access independently of writers. For
+example, mode ``0640`` permits the owner to open the pin for writable
+access and the group to open it for read-only access, subject to the
+applicable LSM checks. Changing permissions does not revoke access through
+existing FDs or mappings.
+
+The file has a fixed size. ``truncate()``, ``ftruncate()``, and ``O_TRUNC``
+cannot change it. A truncate request that leaves the size unchanged is
+allowed. Permission and ownership changes remain available.
+Consumers can discover the capacity with ``fstat()`` or
+``lseek(fd, 0, SEEK_END)``. Seeking supports ``SEEK_SET``, ``SEEK_CUR``, and
+``SEEK_END`` within the file bounds; it does not enable ``read()`` or
+``write()`` access to the memory.
+
+``fsync()``, ``fdatasync()``, and ``msync(..., MS_SYNC)`` succeed without
+performing writeback: arena memory is volatile and has no persistent
+backing. These calls do not synchronize access between consumers or BPF
+programs; shared-memory protocols still need appropriate memory ordering.
+
+Exported mappings inherit the arena's mapping lifecycle restrictions.
+They are not inherited across ``fork()``, and ``MADV_DOFORK`` cannot enable
+inheritance. Consumers must create their own mappings in a child process.
+Mappings cannot be split, expanded, or relocated with ``mremap()``.
+Partial unmapping and protection changes that require splitting a mapping
+fail with ``EINVAL``. Unmapping an entire mapping remains supported, as do
+protection changes that do not require a split and satisfy the access
+restrictions above. Consumers needing independently managed regions
+should create separate slice mappings.
+
+Access control and lifetime
+===========================
+
+Opening the pin uses ordinary filesystem permissions and file LSM checks,
+as well as ``security_bpf_map()`` for the requested access mode. Mapping it
+also passes the ordinary mmap LSM checks. Writable mappings remain subject
+to the BPF map's frozen state and program-read-only restrictions.
+
+Consumers use ``open()`` and ``mmap()`` rather than ``bpf(BPF_OBJ_GET)``.
+Consequently, seccomp rules and LSM policies specific to the ``bpf()``
+syscall do not govern this file interface. Grant access through the pin's
+permissions and the applicable file, mmap, and BPF map LSM policies.
+A process prohibited from calling ``bpf()`` can still access the arena
+through this interface if those permissions and checks allow it.
+``unprivileged_bpf_disabled`` restricts unprivileged map and program
+creation; it does not generally prohibit access to existing maps.
+
+``BPF_F_ARENA_NO_FREE`` makes ``bpf_arena_free_pages()`` a no-op in both
+sleepable and non-sleepable BPF programs. The free operation returns no
+indication that pages were retained. Programs using this flag must not
+rely on freeing pages to restore arena allocation capacity. Arena pages
+are retained until the map is destroyed. Open map and pin FDs, mappings,
+and other map references retain the arena, including after the pin is
+unlinked. Removing the pin therefore does not revoke existing mappings or
+free their pages.
+
+The retention flag does not itself expose the pin as a sized file.
+``BPF_F_ARENA_EXPORT`` opts into that interface and must be combined with
+``BPF_F_ARENA_NO_FREE``. Retention-only arenas can still share memory
+through ordinary map FD mappings and manage reusable objects within
+their retained pages.
+
+For example, a consumer such as QEMU can use an exported slice as a shared
+file-backed guest RAM backend. The file interface provides shared memory;
+consumers must supply their own allocation and communication protocol.
-- 
2.56.0

