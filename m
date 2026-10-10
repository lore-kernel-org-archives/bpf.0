Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E1EECB;
	Sat, 10 Oct 2026 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672554; cv=fail; b=FqpWuyUR0kM/zNL7teSwESRSD23qqbWQ/G3MAVVIjlyHfgJAe07tfshz+ZVzvq8queZddw0cu27S5nvvgO+afW+LOK9T5nyiJc2OBT4ZgygJ78/blHDOycpS0uz2E3i4AKB5VIS/DG4oaW+grcKBvBT52Tk4zkHdxjuzHtxpt9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672554; c=relaxed/simple;
	bh=DIAfH0tkLhsP/RE6o9Mt+y+lOZIorTjEwjGVRLH1XDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OqXHv+Gu/NqTAS+aiHisgPs5ShafBEek188gkKa+w3dPqGwGWHrcBdh6rfYWHbAa24ZIxUSk10frhCZ7VAPEu7VP3THGYtFCKjjQl8I9242fL8zxLxbt2fkOG1SxLUcrwlCGTU7H0PwRqKiOg2eObOAEQKyMGNKjFb6TV2rlEL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FmNJbA62; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FmNJbA62"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBkF+GdceP2Q+eq39a+YsuoeMc1jXca85FtTXjA2zc3fkdJwA5TnNC95UCW51p9Xq4LpBUyEjQFjGx3AHo5yv7bXZQEUFGnco5SfKxyi/ReyZX5NasTMrUdbIL/FxxiibWRQS2ie/eHsDRNy6gKOzCFm1wo9Xl3Kx0FHSqfifhwpIEWFpjOeVFDuMAOwx8P3VL/B5YIU7yXPecUIis4kmukDv6/TdjOR4/IMXbL/XXaamORxJLZwYy4exvdCrKtn6sewRBKW44k41t1UDLMeoTaBzPkTlygGQNQyhuMOr9S4cfLATPgQRvPhegnUnoToErnEhy3Zabx//6KUIibhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h5wHWJXwUFiWvB/1E8Ij8bMLx0Jskh82pwiTpencos=;
 b=U+eiwFSZNUUxdLGqhB5BN4L5UH8tZhhjw7HLItU0ErJF84CbVifG5RkRSc4wefqkMDAsp+lfI5JiYWbEfrlMWNxhzlAmjideFUtcgr/jxheMokT5hu2+Zu08Tig1tndTDkP+sjNjeHDaFwor+1fG3sZ5Pebh9iVmzuUIReNw8YJ4za9tFt10pYHVwdTgXfpV5IR6UN/gJEWDtt8eVqSoKmAxyOJUgojuLodV1I9OnXKkPKgI4wyTN60ICLBb021wgCKFpOCoGUwC5zkKy6/o/CXGUp2CqUO4o9ux8f08e2oc3SKVx29LkWECy8z3CGzkg2/mirEh97Mc4bWbjnYDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h5wHWJXwUFiWvB/1E8Ij8bMLx0Jskh82pwiTpencos=;
 b=FmNJbA62ZazKuxcShieLzQOEejRlZmrIFQum69a1lcPPrvMpKrDLrllsOfVFEREXbSH1lwTu7aM9Wfc91B2VliPnAfk57LWM42d47Mdqfs076AYluQ36J/3egl07EEQFLG1dhcIXCVROovBRQ1Tvfn6tuM2SYLxOTrceIJZCA2sgw2cqKAho5FO2hFeDm9M8i7ztipiZZBzSxLwsEy0v1Hx7TgUCaDNJDKfYRNw/fulnl0xukxhVAWSA6X8pbjwSPzpBldwqm0+UzD8SZXgGgldgtX+3pZ/6VXBpCVUYPT8W5anUDy2QKJVQgDMnL5WRS8E4ZxSIZoxmUXzENG94DQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 22:49:09 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 22:49:08 +0000
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
Subject: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs files
Date: Sun, 11 Oct 2026 00:45:55 +0200
Message-ID: <20261010224902.1232178-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B8D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::414) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aed92aa-6e5c-47ca-7600-08df2720b1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|3023799007|6133799003|18002099003|11063799006|56012099006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ld4W3OF996TMLJFRxdA6PB7UdvdCMlbVHTMtwzHrxGmFtfG+iHCjlOwosUczcBDuIOOSvWI6m+7k/Rlt3/fYVdPMbTRpMB6b+o7LQTQeSgbHTV8WXKudAGMqxry+eIY0oGKLO0NtmfSBCgpCMS13I4xgQCzEsVhFnuYW9LrWMS7yfyqJly4+gWQLUZdPUeRF8+AFt9gECpbq5+tPatAyydjSVY7w7UkY4K5+ZTNEArNZuoWbdwsBoZYYa22RumwFd2xcpEDBWilu4HnpKzqIbMpFkSiRJpuIqf6+/7jynqSGvCws2FieQG31f99u11Q//Z2hVimKoFLDzuPUBqKwI2728FAzM4eOdwOuZxcvW53u7g/xCNx4MASjC1zhr4TlJQXE/991fLrGjFhobYEMn3i8pT6wHTC4M30AZsLoaItQ4/FURtHQAJFr0AiEGdiaQ+na0pRwOxBih6yUlHVB/3RbzhuB6oFR2If1Eu3iXhJzjoIHc0a7mNTCP2YvaXdRcHPYUPJl8b8gJUifbql/WRH8bPd28UdfpwM9k/ikGPBDpnx4/j4wzSK7fDHG1QsImrcqJfwAwhi+CaNQ1vcFRZaV9upqg4gaL/dQ6FGgdAYFR3V9ePkaJ+caBxnQ6oxzHbWUpVHN9/EkxJISeBHen/Rhd7Q86ATCLEqA28sYMP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(3023799007)(6133799003)(18002099003)(11063799006)(56012099006)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OCpizcwkOkz+nXv8Zw3ForXB3oHvKWWQWp4V+n0HQfLYgMD3f6oKCUoMWNo7?=
 =?us-ascii?Q?YIxejzJNlB5zYhqWPRh1gm8eLgrwbtpmgUmL2UZyjya8r8bdIX9mFXi61vqx?=
 =?us-ascii?Q?mbur/DQxk9BB3crdIbJSyKGDBEHrmw2+5lDWYnarPEJXp8NEGS+Y0Uhi2aTm?=
 =?us-ascii?Q?lOwThl+0uQcfIFFZv0i1NT0/MH7PcQ55hs+ziK1aG5/c/ft/L1OBhRoHk7ME?=
 =?us-ascii?Q?1cC/rFtTpj1Gn3hn99ulB7hSe9SBCmNl43x3aWOmp2QoaQuPWdtPuZ1vXSRu?=
 =?us-ascii?Q?VmdVqX3LPZbWbSqPvDjhAS/56BFaDj9QkRxO6RX/YFlowyrtBQ8hVxBApboi?=
 =?us-ascii?Q?JB/dIoGd7c7GRC1AsEekOaNmVSIYBrKO+vSID/v3snoLhGgSr7m+2/9ZQv0T?=
 =?us-ascii?Q?jOYi2HnA56pZx1s/3QY22Hsi+08rLGik9i1HH2KzMC8h4FGA5ijiFfB/bZRu?=
 =?us-ascii?Q?bojzjhh9duH8VUloTheHHSLQRmJmpQ4Zs8Rm8+uVGwMlunUVWJusX+RqLDfZ?=
 =?us-ascii?Q?kX31qXUlZvp9JpYog80MIXudQxG33G80CCjLvxaoOxd2XeqRrczKjfcbmCpr?=
 =?us-ascii?Q?sEDtQQYAzIAzmsxZgGhUbGwq58fYCI1rlF//9TB8TmNnUFFr5IhRjZp00ozf?=
 =?us-ascii?Q?EFmHQ2PlS0hZbYN94RIX+jTw/C5keiQY8W3LbWe96ohdxSegw+QuQ7OrP4tE?=
 =?us-ascii?Q?KT7sJM32e8kLEsyU3CLFAPz3idwB6jWAyV6c0URleReCeoZGsYTcQxss+7Xt?=
 =?us-ascii?Q?kDqtB2yvPVLrMQbmQDu8Mm12S17jDyWIPfh7WojOfLjXd1gxk7bXSO2wsDpH?=
 =?us-ascii?Q?wt57LyKH9GtD9J9j88IwgjKXO80M7a6rh4fUPGIc/2mCA8YpIHrSqLS2ftRs?=
 =?us-ascii?Q?68p3b/L+UbboqpTtWoJf2FaEIIMxcBW8jn0ToL4GJd5rdSfdFv4810Y/pFka?=
 =?us-ascii?Q?1kyxuZUcTWk3zrMXjvtTR5fNXPuw08Xir0O9mE+hlgfCxRDJM9kebafWxeWV?=
 =?us-ascii?Q?tKaXfvEQATTyXus6WW77OFP7g2g0K3b4t52pPLosB19niw1KtE3+d2OZ96XA?=
 =?us-ascii?Q?x4w8NOPCCG2ixUJ5pu+8as9M6/oSAwW2GspjxExpk84KcYnJpTiOqWhBxHUj?=
 =?us-ascii?Q?N807GvwCeOp8G9VAX4dotsmJdm5CsJGbbeT9H6wL+aw27ZJ1wVVsgUxhi+Vj?=
 =?us-ascii?Q?DK71yU1rTjYR1o6Jy9Xp0dJor3CSbgHXZZUsryg7vT1iDwVJp4nrOuPBUh3b?=
 =?us-ascii?Q?wVlIvZqUi9rk+UOdAcahR3QqCQIwIEhE8zvN+DXULQUbL0JgyiV08KujggjW?=
 =?us-ascii?Q?gZPC2awPaaXmPOOrK9SjEAmVm+gfI78ts6JLMGjNgYO2gb4FCKjKMFtXoGxf?=
 =?us-ascii?Q?og+U4ntITyCsIzooPa+5Erq7KF2PXRVZ+q33+TfruF4s9/03TnbbVOnH4LdQ?=
 =?us-ascii?Q?YX62JmHrUs1GNSW8fYvgL2g+nVCR8kVUxHJfSYVzWP73uOgqtqc9X4+3oixK?=
 =?us-ascii?Q?SgNgVKldMGUxzds2gbPn10LNzeplugZMTGWZKu3xkLioLxmCwWbX/e4M5r6X?=
 =?us-ascii?Q?K4AiGp3VLJt1q4EBdeDnfJz4pS29Z2Ww0vUqXkI3mhXOlG9OGsvZZJT7rm5w?=
 =?us-ascii?Q?wwzuZPWe6MFEHvS73o5Yz/YiWs3Zqp1oWeM8bBIfrn9d173J/5H7N2LV5WYK?=
 =?us-ascii?Q?J6+nFObm4saZyvyBacczqRYvsMz/72e9biKSy9b7g7gObTZX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aed92aa-6e5c-47ca-7600-08df2720b1a0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 22:49:08.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+g3qUtXX9JOpPPfSuxIGPQ/uhUq0JSYiszYSJQZKrIIzzfDioroelCQQHUm7Lv6Y/J3upApmNtzF8sbBAqYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

As discussed in the BPF track and the sched_ext microconference at Linux
Plumbers 2026 [1][2], shared BPF arenas can provide a generic channel
for bidirectional zero-copy communication between BPF programs running
on a host and its guests. One potential use is to exchange scheduling
hints between host and guest sched_ext schedulers through shared memory.

The goal is to let both schedulers access the same underlying pages as
BPF arena memory. Exchanging hints then requires no copies between
separate host and guest buffers. With the arena file interface proposed
here, the setup uses existing QEMU/KVM memory backends and guest NUMA
interfaces, without further kernel or hypervisor changes to implement
the communication channel.

A host scheduler's userspace component can create and pin an arena map,
then use an arena allocator to partition it into per-guest chunks.
Userspace passes each chunk to QEMU as a shared file-backed memory
backend, using a bounded offset and length in the sized bpffs file.
QEMU exposes only that chunk as a NUMA node inside the corresponding
guest; the rest of the host arena is not mapped into guest RAM.

The guest scheduler can create its own arena and allocate pages from
that NUMA node. Those guest physical pages are backed by the host arena,
so host and guest BPF programs can access the same memory through their
respective arenas. After identifying the corresponding arena offsets,
both sides exchange data through direct BPF loads and stores. Arena
pointers are not relocated between mappings; a shared protocol can use
validated slice-relative offsets instead.

QEMU is one potential consumer. The interface is generic: it exposes a
pinned BPF arena as a sized bpffs file that ordinary userspace consumers
can open and mmap, including consumers that require a file size when
setting up shared memory.

The series separates page retention from file export:

* BPF_F_ARENA_NO_FREE makes BPF page-free operations no-ops, retaining
  allocated pages until the map is destroyed. This flag alone preserves
  ordinary arena pin behavior.
* BPF_F_ARENA_EXPORT exposes the pin as a sized file and requires
  BPF_F_ARENA_NO_FREE, so BPF programs cannot remove backing pages while
  external consumers may still use them.

The map FD retains the canonical BPF address range. Exported mappings
can select different virtual addresses and map disjoint slices. Faults
resolve by file offset, and page zaps cover only the overlapping range
in each exported VMA. Consumers establish the canonical range through
map_extra or a full-capacity map FD mapping before mapping the pin.
For exported arenas, the canonical range matches the fixed file size;
ordinary and retention-only arenas still allow shorter mappings.

Pin permissions distinguish readers from writers. O_RDONLY consumers
can create read-only shared mappings, but cannot request writable
mappings or acquire write permission through mprotect(). Private
mappings and file size changes are rejected. Open files and mappings
retain the arena after unpinning until the last reference is released.
The capacity is initialized before inode publication and can be queried
with fstat() or lseek(fd, 0, SEEK_END).

Exported mappings retain the arena's lifecycle restrictions: they are
not inherited across fork and cannot be split, expanded, or relocated.
The documentation describes these limits and native tests exercise them.

Access through open() and mmap() intentionally uses filesystem
permissions and the applicable file, mmap, and BPF map LSM checks.
olicies specific to the bpf() syscall, including seccomp filters on that
syscall, do not govern this file interface.

[1] https://lpc.events/event/20/contributions/2429/
[2] https://lpc.events/event/20/contributions/2482/

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git bpf-pinned-arena

Andrea Righi (5):
  bpf: Add an arena flag to retain allocated pages
  bpf: Expose pinned arenas as sized bpffs files
  docs/bpf: Document pinned arena file mappings
  selftests/bpf: Test pinned arena file mappings
  selftests/bpf: Test two-way arena access with two guests

 Documentation/bpf/map_arena.rst               | 131 +++++
 include/uapi/linux/bpf.h                      |   6 +
 kernel/bpf/arena.c                            |  75 ++-
 kernel/bpf/inode.c                            |  95 +++-
 tools/include/uapi/linux/bpf.h                |   6 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  27 +-
 tools/testing/selftests/bpf/arena_kvm.py      | 448 ++++++++++++++++++
 .../selftests/bpf/arena_kvm_guest.bpf.c       |  89 ++++
 tools/testing/selftests/bpf/arena_kvm_guest.c | 224 +++++++++
 .../selftests/bpf/arena_kvm_host.bpf.c        |  89 ++++
 tools/testing/selftests/bpf/arena_kvm_host.c  | 147 ++++++
 .../testing/selftests/bpf/arena_kvm_shared.h  |  60 +++
 .../selftests/bpf/prog_tests/arena_pinned.c   | 442 +++++++++++++++++
 14 files changed, 1819 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/bpf/map_arena.rst
 create mode 100755 tools/testing/selftests/bpf/arena_kvm.py
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_guest.bpf.c
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_guest.c
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_host.bpf.c
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_host.c
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_shared.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_pinned.c

-- 
2.56.0
