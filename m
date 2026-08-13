Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CD352010;
	Thu, 13 Aug 2026 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591594; cv=fail; b=gu5UyuZik8sc1cvyaFXsUAnUKeHK7X/Os0krnPmi88GZLqERhFJdS+T5+9Xx8gx6on7Kt79y+1OeDNiWqCVwtk/nUw2S9xPCjSgp4Kdi1OcjzzEc7LBkKsFdA1H6i93w569L4prT+/MJQMvXYBzSRp9Zwb9ctnYCbh5771PpUVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591594; c=relaxed/simple;
	bh=iyVBGq0trRMHHME0mOMCMktunvkG17EqEdFdqzAgx64=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=doX0MOHZpl37OZyV7FrWchC8UiGSC8tMs6yx7Mg447uY/Vr53Pa/ajY/1R3s5Yp8wDl+GBQoL1kVHH76eH7q6e2/wLrKei84D24M28yz19l44PvRKKdKkiO0Rbmw8o7mkmwHjMRRTFNrTeGMOyWgyS7gNtx0Djdl6+693ZXNaU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pDLgC2jo; arc=fail smtp.client-ip=52.101.126.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pDLgC2jo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=of75sVF+KVEkKOsklNG4DXwJMEK3GL440n7/vEnYIDKizqSZWUu/1T6Tt5FoU90JPlRYIhXYviFxj8k7MfKAYxd1QHPtl/0I1GCpVRYejkX5SveMKfX4mNXgx56G425IVm9L0QorH296Yj2N8VLIfwfvsz+Fnqydm4uYJGAXwsWL6WUApdN9oi41IbI9kDDjvbu8bsGt5qI3sAiJt1zqq2JmkMLhu9a56iN3QE0dKYtNoYOTLt3PJz2DlDoBtBF33yZMkUaVr9X7+cKpteTgzgaA9AA+ITVRG6eEbmszFq2BoyhiypY34A4YULB514hlrqAQKi4XcT48s2JzmZvX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9erInSdG4TcsUtHrOVPL8kIm/fd31rlxna2qZhM6zU=;
 b=QXW4+l5/nBu1v5cTiGC/pCJbw8t6l0kSEvCK0MwigjqOp6hrGI37jAmQYMPUqWGbMNmqqk1NqDkHIKKOhgNxZmuGs585upKcZ2S5EXBGflU0IOv9cB01LRCdKly/hCQQRypXnPXbZQRWsDuvmR1pJjaKKvnzCdRwsRxWLKw5KAbWGe57a7FFmW22VSXBCpXcsfJ2vprbIqdzKVFS1/l8CRZY7LjEXxzcfwj6H9Ps74N3K4Q1QEnntVhxx+JZ9sjATqsGz4OYmgkg+maumUI3lSeOtqk3fWPIhCRRpjUal+1RLK/hr0KjIrTLJxNfJNo9RG1GXSUrwz5ETqopc0N3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9erInSdG4TcsUtHrOVPL8kIm/fd31rlxna2qZhM6zU=;
 b=pDLgC2jogGVDUct4/E8hcHL5WKkWmpEy4k5tDwFTWNfrbdjpAQFF8jEhkTwyPd00+8c0zALLf9itIWqJ7KdiuG0fJeT9bUugdrCmfPpJVGK43kfEPC8/yKJrF+0fETjg/EyANotcTmeaKvtrCb2ZOBovWRv4TYzmS8H8kAl+0w2i8xf4WzUTKE3votxbyCBRkrVUS/pcbS+dTHuWu9Rjpybn7HiSzMIxwDfBoiTqQ/NcDAY+7NMJHoDMkYsIXKn2KVv/U8MnWliermLz2hXz5ua+7+z20f6U6GnCdEE+dbQo5pNtutLtpvJpOaPzvJ/TTqNnhvfEcPihyZex1pbulw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB7024.apcprd06.prod.outlook.com (2603:1096:101:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:26:25 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 03:26:25 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	yatsenko@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [RFC PATCH bpf-next v2 0/2] libbpf: Improve BPF load performance by selectively loading kmod BTFs
Date: Thu, 13 Aug 2026 11:26:11 +0800
Message-Id: <20260813032613.2755-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 918106de-7fdd-4030-022d-08def8eaa7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|18002099003|56012099006|11063799006|10067099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	GlDbAHpMibnMEjGEHwuiFI/s7kBO4rLfkOgrKNLXAIE3Jjb+ekfXIFZEqoTHpTZn1BU54FEtcKTGQEFZKjakiRYdM1ZOKdbJp3CtN4laadfOQmQE/RlWRhrvyEpfeCN8r6xapa8wMFjM3JMN38I0YWLgHQI8EqYbCirWUrAVxhU6CrlVJiXkyGbnmcfVlvDAPcpjkiILlpA/MDjU8B/9+vQ/QFQ+DR7Y+VdxO6hj4cxf+CtfKDThRKO3+XTh3udK7pXrmlN7yHpxn2sHCo22qN2fDjHwPyF3h2RLetyMgC9jP96kuxKyr/4WuESp8APsnXeJXc2rxXa4GN6B0ro59CgFWjsViE9KYQy1VvaoW3GiKEs8JRlyMRWSopWds3JXFPZFKFKiuO86eprP2uLE5gqZOHhC5BLVdA4TnFr466kdXHyxNj+Z1M/InrIH4LiLezElv6+G+QY6YaxItEXLo4l0DJm0QzuyGSI65ltWF+ahB4Upv7F1G/rlZLOcyzOzNRPnI9H0QoGW6PE1v1gTs/ULYT28I5MHUgNkpEcBvy8mInO7YmYBzR8KOsoX7xH70lvSqHRmDtjsE3/djw0SyJwi+U+uezk0H/xYWZaSiTMPDRCv+5ULUziwJ2PszapbyGmILIWStjtGE5zfuEgcXgogyLMmONVT1LiWZeSqGfujDGAUwdgk71J1O9BjFWo6ItdBrAxSMYXXQRVkdRVR6terKbqUib/+exYlDKiZh9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BM2bIwhk/FhrPqkCD9sLaYKpzaLFpmwn7MInh0bQxRnb0MoNkoHXAoJ4k1QD?=
 =?us-ascii?Q?qLpVGf46L1DbvQTZ0cYrieIPwgRUkHsx8nAkAhG9L04LtHmPAtGwjjmMbIwr?=
 =?us-ascii?Q?ARHoO3j3gToHo44MrleqeuBTHD7x1RnZUCuXyZJRM7nVxCP56RIgeDRUKgUs?=
 =?us-ascii?Q?Q1V69MeyDZ51cVaacYSCdOiX8ZXFdZHIVVtz2xAkCCuWSGXrXKnrruzASpXf?=
 =?us-ascii?Q?YqifGnqdUJAOgpYL6JWKhNl6ChzG9RnFFQleN5cetHjOEIcPL6QsM5SUGDDX?=
 =?us-ascii?Q?iyDN9iTSnc9IiHQh+5oC++zJhHUpY4AkhFfCeM7Rdn8wDit0/+r3iLOQE4q2?=
 =?us-ascii?Q?zxPxXbRXqlaVMLBvUESMB3ZZeLDjjd9eDly8bdYec8CokyWWt5wwVtla3f/G?=
 =?us-ascii?Q?pwFA8ZVc9JPkns2zaZ6cOJYlkhKUSR2wV3XiA7IDTB+kNbdpKsNoJr2eKYIf?=
 =?us-ascii?Q?IeyctB+n/EDYCOYyirQE0xCSuAHuNKDlwONUwxnagWiNqXt/YPMdKPMciyal?=
 =?us-ascii?Q?E6mUGiQuVnBpCQ5qlZc339l6mvvf9mFraCbRXIUL0cxwYIQDy1jepgoYS6wa?=
 =?us-ascii?Q?wlxqdFzOKBgrG0vfxPZ7zaFeu1UyEwcxsgf5DsJQgc6M6C9awUWlbrwXH3ej?=
 =?us-ascii?Q?2dTknTxnwRBt1EOinq2MZs725uk8sAocscEpqaewtxbYbV/6ZzJAWy0IyZbF?=
 =?us-ascii?Q?oJRLAHe/XQSKO9RB9r+jhLp/pPNlDzanfHBCgx3z134KYO9yRi3oNUOSbgCf?=
 =?us-ascii?Q?ri1w9VufKxoQyeRmsIgXORcKRvqHZO+mWzRiAwAFELXl3WzKuMmYNMdmXgf0?=
 =?us-ascii?Q?yd61nOjvk28I884UUGtJtFsPzeLSiGD69XMYuLU457U2Y6k5WfT6eeCojt1y?=
 =?us-ascii?Q?oAkaOrBYG6TT7OTg6kMnRq2LFHsinoXmFDGtSoIjfUO17+IkYujBN1jK6A7T?=
 =?us-ascii?Q?qJ/x4DwEmD3mZSBwdGNn7V4eCmetgF6Hs4Y6VEv2Y4RWNstT9k30KEyL9kMF?=
 =?us-ascii?Q?+jpYPDmmNzsV1DPygJuEGkUB/9mhqcBYgZqoE6GUtD0/lHZnlvKOt2yAaVoe?=
 =?us-ascii?Q?ZKqQZKNDUA+nKQVTNDizWuPWUFLd/xN7yvfn0sh9dVeSfmSsMqjPDWnHCqnz?=
 =?us-ascii?Q?Ch9Z/PLXrgTyVx8ojJp0Iw6P1PaLOR7MDCsoCwLtuUxVhB5STAGKdd62FH5w?=
 =?us-ascii?Q?j7gaGi8hrF6sIjqae7HN5M5JI+QRa3pk2L796CG35NIa2KgGnsDz3ZtyFsm9?=
 =?us-ascii?Q?vOtvHgE7hA+RRItXlNChWIzOOGDN5G99L1PTtFTNRd8mxlXyQ0ngDYsIdjnC?=
 =?us-ascii?Q?tbXAtOoXIRzomBTOWUjhX9+pCxXVFKS8sVVsT1CAGcMScDjFxIDk0fk6GxjD?=
 =?us-ascii?Q?cjKTXnaxDbjHVlKmO1NXk8kqzLCqS/vliR+wljLnZCyu2aL71y+OamHdbp34?=
 =?us-ascii?Q?wKYqy8RQYmyEuxAzegsRWA4lejk9/OniJXyDUXk4h34z7YyRkLzFHulgkHDY?=
 =?us-ascii?Q?D+u4XtXAT2PqWPcd4r65z7sZlzonhb9OvhTkxcB8aOWzvcM6XB/x09m54Jp0?=
 =?us-ascii?Q?+ovZcKWS7ii7t/UNHCkvwslBKlnaDZg7shMQxXMsYmnhL/REMMm66a3mNVqv?=
 =?us-ascii?Q?J+DC8eiU0/1yH+TlwWbbu7VUQ6JzcYan0dohk76iR1/2ki3f74RtiMt4vnuI?=
 =?us-ascii?Q?Zcgfvm4M3w5+/x3CPdru3kJDifRAZVc24ajKuy11MRRqGDnTDDSriVdDwt+O?=
 =?us-ascii?Q?Q4PTVBjPTA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918106de-7fdd-4030-022d-08def8eaa7ad
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:26:25.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/+BUBiye1rPu1MZoF9UWA5Q42bdhWvLwlsTG7o2tlqrRw9AmiNqXji3+rUW8AMvqBSKl5kRuG0sk9Cs9Pisiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7024

Currently, during BPF object loading, load_module_btfs() unconditionally
iterates over all module BTFs and loads each one. This introduces
unnecessary overhead when a BPF program only needs BTFs from a specific,
small subset of modules. In environments with hundreds of modules,
loading all module BTFs can measurably increase the loading time.

This series introduces an optional ".kmod_btfs" ELF section, allowing BPF
programs to declare the modules whose BTFs should be loaded by
load_module_btfs(). libbpf uses this information to skip unrelated module
BTFs and stops the iteration early once all declared modules are found.
Without this section, the existing behavior remains unchanged.

Performance impact (<skel>__open_and_load() time):

  Modules loaded | Without .kmod_btfs | With .kmod_btfs | Speedup
  ---------------|--------------------|-----------------|--------
  1              | 35.0 ms            | 35.0 ms         | Baseline
  10             | 36.5 ms            | 35.1 ms         | +3.8%
  100            | 46.2 ms            | 35.9 ms         | +22.3%
  300            | 65.2 ms            | 38.0 ms         | +41.7%
  
There are use cases where BPF programs are loaded on demand rather than
as a one-time setup. In our Android testing, the impact is even more
pronounced: the total BPF loading time exceeds 300 ms with 93 module
BTFs, with loading module BTFs accounting for around 69% of the total
loading time. Preloading all BPF programs is not suitable in this case,
as unused programs should remain unloaded to minimize memory usage.

The existing module qualification in SEC(), such as
SEC("fentry/mymod:foo"), is only supported for BPF program types with
explicit attach targets. It only guides find_kernel_btf_id() to search
for the BTF ID in the specified module after load_module_btfs(), and
does not reduce the number of module BTFs loaded by load_module_btfs().

Changelog:
v2:
- Addressed issues with allocation error handling, multiple .kmod_btfs
  sections, the transient stack pointer in is_kmod_btf_needed(), and
  selftest dependency and comment formatting. (sashiko-bot)
- Removed KMODS_BTF_LOADED and KMODS_BTF_UNLOADED and simplified the
  related logic.

v1: 
- Link: https://lore.kernel.org/bpf/20260806042042.3239428-1-zhaofuyu@vivo.com/

Fuyu Zhao (2):
  libbpf: support selective kernel module BTF loading via .kmod_btfs
    section
  selftests/bpf: add tests for selective kmod BTF loading

 tools/lib/bpf/bpf_helpers.h                   |  14 +++
 tools/lib/bpf/libbpf.c                        | 106 ++++++++++++++++++
 .../selftests/bpf/prog_tests/kmod_btfs.c      |  52 +++++++++
 tools/testing/selftests/bpf/progs/kmod_btfs.c |  14 +++
 .../selftests/bpf/progs/kmod_btfs_mix.c       |  15 +++
 .../selftests/bpf/progs/kmod_btfs_nonexist.c  |  18 +++
 6 files changed, 219 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c

-- 
2.34.1

