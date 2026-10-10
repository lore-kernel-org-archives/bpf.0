Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6F3630B5;
	Sat, 10 Oct 2026 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672575; cv=fail; b=j6o3XwwZTt21AZOLftmthrVisWhBj/PSwRvFCbgzciGi4DsLhV1A1/oxQ3Xbu2Cxa639LEA51Tu3XWz6UegRQppXwHoMGkLyl1f6MYYznlt38we7rxSXopLdw/332ffTF7sIe/kDwm5wuOO/FO51CclwhsyFVC8SLK7J8nGAJzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672575; c=relaxed/simple;
	bh=wrHoJo1xhTUCmFaWZDTXC4WXcb15nuIUoP8qu7IjHp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFK9LW5ejtYEfSlHp84l8j5oxJmN7CHXrDqnIwT4hE873zYttevLIya5djx1RVwpgtNIPUJljoZ2ECSNdQEC6dwu7mxaSIvPqBIyyw7XP3sgRv5RZmubTzuZrJYzWE+2h1W0XOrn7QGZFpcAgwFi8LQkYYe142K019Qs0MxHH+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FqwhJpLF; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FqwhJpLF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEjeLpZyoBQoZPCNwkwZXbdLff4E+O4fhlND06mLCNe51W4wUE7tzZq6OtV5lFg9xTvbCTik1XIbjl7Omzy6LA217NfZKA07AsPTarkY9MFq2A1sDpzaSEWRyjsB/fqaRIQT/32i/2MDxwwHK7TvH2eCR2VnzbYXPyOXIrVka7mzAGh2QFcf9aKusvK0x9ZDYzWvFRq+SBiSOSjiRnPvMCFLYWxe5HJt2tj8SARdUwYP9ksq/5R/rtu09rwJClSR+wS7NdeN7r1Rx11eYMhrWXZ5yONQpHdF335hk8Fo/3OwDoIA4HGMSo5oiHeCXwyftYc2IlofUfysmgAg4iUGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYr/CxI4C7ht575xCS5/iseLeiIZSXIeE5MZXhpd+tI=;
 b=nUnS3uL4SrDwgZy/3ZgDcYBAKVtlw0NH7e8mT5GJuvZJiYPfAu1cMPpv7JyEkIMFroEhupYujNPIRo/56nWJPYEkAqQtYck4toQ3ZZBHN76dbc63lRxvnODwEVPqpR7+J9jzGFs7bcR/5IfNH051dBviNQOaF9TvvzVZckHPN2PS2q6GqtHUYDIGlRnnJRLGU5+dtpaIHvdkWahudmuSPKDTGz6Qr2ti3ZktP1xcVe457TW8rigLI3L73eD4sE40k9fD/M216JeGvmWhV5y7hsbeVyOb9Im8pAMYUZ15JAJ/yLmxn/gptANISYrTekFzpFWJ4SCuEBNmvsg2vMmSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYr/CxI4C7ht575xCS5/iseLeiIZSXIeE5MZXhpd+tI=;
 b=FqwhJpLF9y9Ryd0CiXL+8YE/PUcuFDzTkTBYzcdHhABDLY/CHiVkmOJ6tWbQiyxVXhBaTgWbfTUTeJBwiz/X9vpVqLKsCr1mZRVpQKXJHJNNlWqT1feJdEcrTxWmh6UTDFgWRvIxe2m/dZzVzu1R20S9aXJbgA6o41DPZ4MMOAkswrhO4j/bGVHDBhmUikQkIB7Z0rUx/rlE6lcCegY/ZqvGPN1XNRmRuhzWZHe8Qowpqb7+gvU3HY5+V7sSUKZ+9Gun85V3Mxo6TNlsK2AEVEmD1zYpEBoY2XtskmFlSUsmCsoTyXCAs0KdQPCVU/8gJAWbawIIYjpA/8dSR6J0Ew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 22:49:26 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 22:49:26 +0000
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
Subject: [PATCH 5/5] selftests/bpf: Test two-way arena access with two guests
Date: Sun, 11 Oct 2026 00:46:00 +0200
Message-ID: <20261010224902.1232178-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010224902.1232178-1-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::23) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2c9a5a-c267-4f65-105e-08df2720bc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|3023799007|6133799003|22082099003|20052099010|18002099003|11063799006|56012099006|260925021311599003|10067099003|260925022911599003|260925021911599003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	0hC8KnK62Go1QeVGS2zC7o8vh+lELKvKpTiqLVNIvB5kN8xORwwPEM+m707l9PH9uZXAlHfk+hmoBvp8Mim8a2ujwpi8LciIDkB8lXifgOjK26tH7vXuCPruRraqIKmuGL6u8UFXDiGNkaAXTxTjXUB2CHeXWm1UXUYfu76ovvY5wEijWv/WwUIe55UlSSpFwEFb0FTny4BNaXS40XKUQKUGyUiJl/o8IBandcQtpC8ogN0936PvG8F1NWc/cjRzPHCKwgKRve2PSdvjr4IWESQEjn444u0ZWvGGaaXbWVjGWtfoO4CPaI87Fa0qZORwd4hnjFVgNoqmla7X7zYJuTW1AoLaOZfIRsY9fM4IbdBwULmVgCIwPHPb9jQkBnfZ02Irj5Ul127GJxYhYJPlwDOAFoA2DQHVrB3+AIK6JWIGFKzE/Xvu0uyq139W3lTjfGQWvZY82sJHrpTWbgjU5LAZKSx4rlK2sE/ONLAxLiB2lh0RH0dw9IrDaeUiA25e5z0+yWIxxXttu2DAd0PChI2iTOZREhBhLHqIbmVg32zlCIP7x25L9tRsc38jjzDqk907SJISpuj3rTd9Ta90ZEUkZZyu4V54hS7CNL5EU51O3R6tD95mvQTB1k6MnFxyMgvY0MKpXBojtDhuwIrY+iktBWwjCBNQllOvETZhFp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(3023799007)(6133799003)(22082099003)(20052099010)(18002099003)(11063799006)(56012099006)(260925021311599003)(10067099003)(260925022911599003)(260925021911599003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6tntG7oK7Oz6TMDljSGwhVm43mSe2KwY9JIRhCNQuWetqA8gWIzqAhQELdv?=
 =?us-ascii?Q?/8m7/zCqDqVnOOfZdOelZcn4SNwvRhrlcMbNdIHxcWKqLuAeLJGOjGUBamXU?=
 =?us-ascii?Q?jyUgPsPwfCUrjNeulN9deh5j9g8gRsd37GZoZlZdFZ/u6/+d7L1bUhWOSN30?=
 =?us-ascii?Q?95WiTDohd0FXM2T6jmHZ4BagV7VqNcBrY8dXzMo05j8Uz2lDmRJ+4YtI+9P+?=
 =?us-ascii?Q?S8jleH0ts1+dQ1D091FdYPEbc6TcelbmgxXtHnkgwntANXyJmG5C48gmQAwY?=
 =?us-ascii?Q?ATtY/yqsYQrKxzrEG2xmI9paLY9IoZ3zVO+bSdRSZm60vFRv2AU0quOqeJQj?=
 =?us-ascii?Q?dbzw996fJc6z+jWqLNE1QnFJw/RUvGrWtWHigcBGfF6QOFDUQ/C8NP4C0/Ia?=
 =?us-ascii?Q?GK2f8OoI4Qr5k0DOtSGg5Rp91RcyL/AzKz0OHyZ8nZd6N0/6cydC5/GNt0h7?=
 =?us-ascii?Q?B92VwQE67M+NDqBgmw1gnVSGUQm9g9xU7wmhG8gcjcO/vSQz5ipRv7BoLmG/?=
 =?us-ascii?Q?iNtAaJ1HBw/EmF1Kfdv7C0eNjVmz+tSpK6efJ6IVmu3k4fa8gorChbx4y0ng?=
 =?us-ascii?Q?8WjlRT9CkDqpqOGpma7GZ2WKXPSmUZD5nP5KiXLbTYgx36wV5NKVQeyoxIjo?=
 =?us-ascii?Q?8wQgCaGiE/4ohvh0lmWHuqZHhr0XO0BvdvrgSj1e184p15PI90c1gB563iRi?=
 =?us-ascii?Q?0zuhZNsLL5k9Sd9pYVb8fQw+DdqecOle4BUK+Uq43126SERhoEZh1hq2p9Y0?=
 =?us-ascii?Q?+P5FvdxcsFpRvhuw92Tx8aEI/pHR0kW6q6KxchGEWx+NV8bb+c2OuSYSxPTK?=
 =?us-ascii?Q?snXMiXCWIDz3oEa9jloQthQ+b1K0Pt2KUbLaTBOOoisTACpcNjj+iC7AZwju?=
 =?us-ascii?Q?iIl5qaGeX2wnJgDBwR9HMnvwHIlTCa4SX9J4dj2es7tHtfEZgLE/ufq1wwLV?=
 =?us-ascii?Q?UwdaZh5xT8/TKQGUDSBudtxtx7sG+xsPL4zFEWEkpZICkC5cFLNj+H+9WnPh?=
 =?us-ascii?Q?M3eV8g4/oNRKmS/nZhdPExZGSOCJwsKr6LLi59unRt0hySDM0UMg2Kcpi3Hf?=
 =?us-ascii?Q?qNjhUFA3XJ0jD6F662tZYrunTO04gnDLCnX51OHMOQIB15Wc5+del5id8L8+?=
 =?us-ascii?Q?1qk9+5UjF3MxL7a27IOiqWcUHwiRUuBcCCVjv9U/oPIZHGBjZ/xlIKjPQqZQ?=
 =?us-ascii?Q?7slHpxLlAnANKZvxPgR1+EdngMMDmSUylYoKrmFcaA5kCOxD2fG3PEGBczvU?=
 =?us-ascii?Q?425cicXOjFLtpGQ5a42RdJoJiibI2wevE4IcjBFDlL/n7PCAjaLEAVCLowk9?=
 =?us-ascii?Q?p2mFEWmOc8JoIyjoepdA9E93JfQO/60hSoczV/5QrPESRUD+qU/evqrEL5nm?=
 =?us-ascii?Q?TK4wL1Pss3MHo+OqPmyk86pD1Ct+Aq5dRcudS8SQvDJ6i68kKozXw73YxH6/?=
 =?us-ascii?Q?C9hNMi98jTPiQsdDStD4ArriWbYGBUaxnsRn487prxKYxKzTYnprpBo8+BDS?=
 =?us-ascii?Q?272ojilz1JHujWQU3uNGFlcf9/fJrijC8SHTCzQHbhXl37xyT3HkN7mhTPTS?=
 =?us-ascii?Q?dlwyaTB2bhBMTsczopRyS4XjgMlvq9bSsBDNOynUUf4DnCeMcZk41pdPhjIr?=
 =?us-ascii?Q?/YegVp5aJB/80WW6b0KVHBVSpxzw96SfJKx07fE5X4tYmBPWGH92Lipj5rLh?=
 =?us-ascii?Q?VswaA22nDwcfzQhUxhqva+NiX6RRSjVu02zJAfHBFG9ujP0z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2c9a5a-c267-4f65-105e-08df2720bc34
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 22:49:26.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsjlUrMLzoAXpK6aIKQaaAUH5L2ZtdawTuvZwAgZkGx+8yWP3pAjqQZUQbMG1RvI/QYBaI32gRnZGhESVU5aqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

Back a NUMA node in each of two simultaneous virtme-ng guests with a
disjoint slice of one pinned host arena.

Create the host arena with BPF_F_ARENA_EXPORT and BPF_F_ARENA_NO_FREE.
Guest arenas use only BPF_F_ARENA_NO_FREE because they do not export
pins.

Exchange two values in each direction with direct BPF loads and stores.
Check that a write to one slice leaves the other signal untouched. Unpin
the host arena during the exchange, verify that neither BPF side can
free the shared pages and keep one guest active after the other exits.

Let the host launcher own protocol deadlines, so ready guests can wait
while another guest boots or completes its exchange. Bound host helper
calls and register guest ownership before starting output readers.
Handle SIGTERM and SIGINT through normal cleanup. Act as a child
subreaper and kill and reap descendants with pidfds across sessions and
process groups, checking that readers finish after process cleanup.

Inspect compiler support before loading BPF or booting guests, and skip
when arena address-space conversions are unavailable. Supply the new
flag definitions when building against older kernel BTF. Use the
barrier-based acquire/release fallback on PowerPC, whose JIT does not
support these atomic load/store instructions for arena memory.

Honor the compiler's v4 capability check and permissive BPF build mode.
Give shared nodes room for boot allocations and allocator watermarks.
Check the allocated page's NUMA node and skip confirmed fallback, while
keeping physical-address bounds failures fatal on the expected node.

Assisted-by: LLM
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  27 +-
 tools/testing/selftests/bpf/arena_kvm.py      | 448 ++++++++++++++++++
 .../selftests/bpf/arena_kvm_guest.bpf.c       |  89 ++++
 tools/testing/selftests/bpf/arena_kvm_guest.c | 224 +++++++++
 .../selftests/bpf/arena_kvm_host.bpf.c        |  89 ++++
 tools/testing/selftests/bpf/arena_kvm_host.c  | 147 ++++++
 .../testing/selftests/bpf/arena_kvm_shared.h  |  60 +++
 8 files changed, 1085 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/bpf/arena_kvm.py
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_guest.bpf.c
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_guest.c
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_host.bpf.c
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_host.c
 create mode 100644 tools/testing/selftests/bpf/arena_kvm_shared.h

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index b815bf0d88774..9747ad37d698e 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -47,3 +47,5 @@ verification_cert.h
 *.BTF.base
 usdt_1
 usdt_2
+/arena_kvm_guest-init
+/arena_kvm_host-runner
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a22be7efd1fa2..29fffa7857c19 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -42,7 +42,13 @@ TEST_PROGS := test_kmod.sh \
 	test_bpftool_build.sh \
 	test_doc_build.sh \
 	test_xsk.sh \
-	test_xdp_features.sh
+	test_xdp_features.sh \
+	arena_kvm.py
+
+TEST_GEN_FILES += arena_kvm_guest-init arena_kvm_host-runner
+ifneq ($(CLANG_CPUV4),)
+TEST_GEN_FILES += arena_kvm_guest.bpf.o arena_kvm_host.bpf.o
+endif
 
 TEST_PROGS_EXTENDED := \
 	ima_setup.sh verify_sig_setup.sh
@@ -94,6 +100,25 @@ BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
 BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
 
+# These helpers are installed beside arena_kvm.py, including for OUTPUT=.
+$(OUTPUT)/arena_kvm_%.bpf.o: arena_kvm_%.bpf.c arena_kvm_shared.h \
+		libarena/include/bpf_atomic.h \
+		libarena/include/bpf_arena_common.h \
+		$(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) | $(OUTPUT)
+	$(call msg,BPF,,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) $(CLANG_CFLAGS) -O2 \
+		$(BPF_TARGET_ENDIAN) -mcpu=v4 -c $< -o $@ $(call skip_on_fail,BPF)
+
+$(OUTPUT)/arena_kvm_guest-init: arena_kvm_guest.c arena_kvm_shared.h \
+		$(BPFOBJ) | $(OUTPUT)
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $< $(BPFOBJ) $(LDLIBS) -lzstd -o $@
+
+$(OUTPUT)/arena_kvm_host-runner: arena_kvm_host.c arena_kvm_shared.h \
+		$(BPFOBJ) | $(OUTPUT)
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $< $(BPFOBJ) $(LDLIBS) -lzstd -o $@
+
 NON_CHECK_FEAT_TARGETS := clean docs-clean emit_tests
 CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
 ifneq ($(CHECK_FEAT),)
diff --git a/tools/testing/selftests/bpf/arena_kvm.py b/tools/testing/selftests/bpf/arena_kvm.py
new file mode 100755
index 0000000000000..552bfcfb80ac8
--- /dev/null
+++ b/tools/testing/selftests/bpf/arena_kvm.py
@@ -0,0 +1,448 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+"""Exchange values between host and guest BPF through NUMA-backed RAM.
+
+Build with the BPF selftests Makefile. Helpers are found in the current
+directory or beside this script, so OUTPUT builds and installed tests work.
+Use --build-dir to select another helper directory and --kernel (or
+ARENA_KVM_KERNEL) to select the kernel booted by virtme-ng. By default, use
+the source tree's kernel when available, otherwise the running release.
+"""
+
+# Dependencies: Python 3.9+, virtme-ng, busybox-static, qemu, util-linux (script).
+
+import argparse
+import array
+import ctypes
+import mmap
+import os
+from pathlib import Path
+import queue
+import re
+import shutil
+import shlex
+import signal
+import socket
+import struct
+import subprocess
+import sys
+import threading
+import time
+
+
+PAGE_SIZE = os.sysconf("SC_PAGE_SIZE")
+KSFT_SKIP = 4
+HELPER_TIMEOUT = 20
+GUEST_MEMORY = 512 * 1024 * 1024
+# RAM starts for virtme-ng's PC/q35, virt (arm64/riscv64), and pseries
+# machines. With 512 MiB of RAM, the last NUMA node follows node 0
+# without crossing a machine's RAM hole. Skip other layouts.
+GUEST_RAM_BASES = {
+    "x86_64": 0,
+    "aarch64": 0x40000000,
+    "arm64": 0x40000000,
+    "riscv64": 0x80000000,
+    "ppc64": 0,
+    "ppc64le": 0,
+}
+# Leave room for guest boot allocations and allocator watermarks.
+# QEMU's pseries machine requires each NUMA node to be 256 MiB aligned.
+SLICE_SIZE = (256 if os.uname().machine in ("ppc64", "ppc64le") else 16) \
+    * 1024 * 1024
+ARENA_SIZE = 2 * SLICE_SIZE
+NUM_PAGES = ARENA_SIZE // PAGE_SIZE
+GUEST_READY = 0x4152454E414B564D
+HOST_FIRST = 0x123456789ABCDEF0
+GUEST_FIRST = 0xFEDCBA9876543210
+HOST_SECOND = 0x1020304050607080
+GUEST_SECOND = 0x8070605040302010
+
+
+def progress(message):
+    print(f"# arena_kvm: {message}", flush=True)
+
+
+class TestSkipped(Exception):
+    pass
+
+
+class TestTerminated(BaseException):
+    def __init__(self, signum):
+        self.signum = signum
+
+
+def terminate(signum, frame):
+    # A second signal must not interrupt cleanup of pins and descendants.
+    signal.signal(signal.SIGTERM, signal.SIG_IGN)
+    signal.signal(signal.SIGINT, signal.SIG_IGN)
+    raise TestTerminated(signum)
+
+
+def enable_subreaper():
+    # Adopt orphaned descendants even when script/vng changes session.
+    libc = ctypes.CDLL(None, use_errno=True)
+    libc.prctl.argtypes = (ctypes.c_int, *([ctypes.c_ulong] * 4))
+    if libc.prctl(36, 1, 0, 0, 0):  # PR_SET_CHILD_SUBREAPER
+        err = ctypes.get_errno()
+        raise OSError(err, os.strerror(err))
+
+
+def children(pid):
+    # /proc/PID/task/TID/children requires CONFIG_CHECKPOINT_RESTORE.
+    # PPid is always available and covers children of every parent thread.
+    result = set()
+    for path in Path("/proc").iterdir():
+        if not path.name.isdigit():
+            continue
+        try:
+            status = (path / "status").read_text()
+        except (FileNotFoundError, ProcessLookupError, PermissionError):
+            continue
+        for line in status.splitlines():
+            if line.startswith("PPid:") and int(line.split()[1]) == pid:
+                result.add(int(path.name))
+                break
+    return result
+
+
+def stop_children(processes=()):
+    # Kill direct children, then repeat for descendants adopted by the
+    # subreaper. Sessions and process groups do not affect adoption.
+    # Reaping until ECHILD verifies that the entire owned tree has exited.
+    known = {process.pid: process for process in processes}
+    deadline = time.monotonic() + 10
+    while True:
+        for pid in children(os.getpid()):
+            try:
+                fd = os.pidfd_open(pid)
+            except ProcessLookupError:
+                continue
+            try:
+                signal.pidfd_send_signal(fd, signal.SIGKILL)
+            except ProcessLookupError:
+                pass
+            finally:
+                os.close(fd)
+        while True:
+            try:
+                pid, status = os.waitpid(-1, os.WNOHANG)
+            except ChildProcessError:
+                return
+            if not pid:
+                break
+            if pid in known:
+                known[pid].returncode = os.waitstatus_to_exitcode(status)
+        if time.monotonic() >= deadline:
+            raise TimeoutError("guest descendants did not exit")
+        time.sleep(0.01)
+
+
+def getq(arena, offset):
+    return struct.unpack_from("=Q", arena, offset)[0]
+
+
+def wait_reply(runner, obj, fd, offset, guest, lines):
+    deadline = time.monotonic() + 20
+    while time.monotonic() < deadline:
+        result = run_host_bpf(runner, obj, fd, offset, "check_reply",
+                              timeout=max(0.001, deadline - time.monotonic()))
+        if result == 0:
+            return
+        if result != 1:
+            raise RuntimeError(f"guest BPF reply is wrong: result={result}")
+        if guest.poll() is not None:
+            raise RuntimeError("guest exited early:\n" + "".join(lines))
+        time.sleep(0.001)
+    raise TimeoutError(f"timed out waiting for BPF reply at offset {offset}")
+
+
+def read_lines(guest, messages, lines):
+    for line in guest.stdout:
+        lines.append(line)
+        # Serial startup may prefix a message with NULs echoed as ^@.
+        messages.put(re.sub(r"^(?:\x00|\^@)+", "", line.strip()))
+
+
+def wait_message(messages, lines, expected, guest):
+    deadline = time.monotonic() + 45
+    while time.monotonic() < deadline:
+        try:
+            line = messages.get(timeout=0.5)
+        except queue.Empty:
+            if guest.poll() is not None:
+                break
+            continue
+        if expected in line:
+            return line
+        if "GUEST_BPF_FAILED" in line:
+            break
+        if "GUEST_BPF_SKIPPED" in line:
+            raise TestSkipped(line)
+    raise RuntimeError(f"guest did not print {expected} "
+                       f"(launcher exit status: {guest.poll()}):\n" +
+                       "".join(lines))
+
+
+def run_host_bpf(runner, obj, fd, offset, program="exchange",
+                 timeout=HELPER_TIMEOUT):
+    output = subprocess.check_output(
+        [str(runner), str(fd), str(obj), str(offset), program],
+        pass_fds=(fd,), text=True, timeout=timeout)
+    return int(output)
+
+
+def resolve_vng():
+    executable = shutil.which("vng")
+    if not executable or not os.access(executable, os.X_OK):
+        print("SKIP: virtme-ng (vng) is unavailable")
+        return None, None
+    return executable, os.environ.copy()
+
+
+def start_guest(pin, build, kernel, index, vng, env, guests):
+    node0_size = GUEST_MEMORY - SLICE_SIZE
+    base = GUEST_RAM_BASES[os.uname().machine] + node0_size
+    progress(f"Starting guest {index}: {SLICE_SIZE // (1024 * 1024)} MiB "
+             f"slice at file offset {index * SLICE_SIZE:#x}, "
+             f"NUMA node 1 physical base {base:#x}")
+    qemu_opts = (
+        f"-object memory-backend-file,id=signal,size={SLICE_SIZE},share=on,"
+        f"offset={index * SLICE_SIZE},mem-path={pin} "
+        "-numa node,nodeid=1,memdev=signal"
+    )
+    guest_command = [str(build / "arena_kvm_guest-init"),
+                     str(build / "arena_kvm_guest.bpf.o")]
+    command = [
+        vng, "--verbose", "--run", str(kernel), "--cpus", "2",
+        "--memory", f"{GUEST_MEMORY // (1024 * 1024)}M",
+        "--numa", str(node0_size),
+        "--exec",
+        shlex.join(guest_command),
+        "--append", f"arena_kvm.base={base:#x} arena_kvm.size={SLICE_SIZE}",
+        f"--qemu-opts={qemu_opts}",
+    ]
+    lines = []
+    messages = queue.Queue()
+    guest = subprocess.Popen(["script", "-e", "-q", "-c", shlex.join(command),
+                              "/dev/null"], stdout=subprocess.PIPE,
+                             stderr=subprocess.STDOUT, text=True, env=env,
+                             start_new_session=True)
+    # Register ownership before thread construction or startup can fail.
+    guests.append((guest, messages, lines, None))
+    reader = threading.Thread(target=read_lines, args=(guest, messages, lines),
+                              daemon=True)
+    guests[-1] = guest, messages, lines, reader
+    reader.start()
+
+
+def stop_guests(guests):
+    stop_children(process for process, _, _, _ in guests)
+    for process, _, _, reader in guests:
+        process.wait(timeout=10)
+        if reader is not None and reader.ident is not None:
+            reader.join(timeout=2)
+            if reader.is_alive():
+                raise RuntimeError("guest output reader did not exit")
+        process.stdout.close()
+
+
+def exchange(pin, fd, arena, build, kernel, vng, env):
+    guests = []
+    try:
+        for index in range(2):
+            start_guest(pin, build, kernel, index, vng, env, guests)
+        offsets = []
+        for index, (process, messages, lines, _) in enumerate(guests):
+            progress(f"Waiting for guest {index} to allocate its BPF arena page "
+                     "and check that BPF cannot free it")
+            ready = wait_message(messages, lines, "GUEST_BPF_READY", process)
+            match = re.fullmatch(r"GUEST_BPF_READY (\d+) (\d+)", ready)
+            if not match:
+                raise RuntimeError(f"malformed guest page offset: {ready}")
+            relative = int(match.group(1))
+            if int(match.group(2)) != PAGE_SIZE:
+                raise RuntimeError("host and guest page sizes differ")
+            offset = index * SLICE_SIZE + relative
+            if relative >= SLICE_SIZE or relative % PAGE_SIZE or \
+                    getq(arena, offset) != GUEST_READY:
+                raise RuntimeError(f"invalid guest {index} page offset {relative}")
+            offsets.append(offset)
+            progress(f"Guest {index} ready: page offset {relative:#x} in slice, "
+                     f"{offset:#x} in host arena")
+        # The QEMU VMA and the open map FD retain the arena after unlink.
+        progress("Unpinning the host arena while both guests retain mappings")
+        os.unlink(pin)
+        runner = build / "arena_kvm_host-runner"
+        obj = build / "arena_kvm_host.bpf.o"
+        for offset in offsets:
+            if run_host_bpf(runner, obj, fd, offset, "probe_free") != 0 or \
+                    getq(arena, offset) != GUEST_READY:
+                raise RuntimeError("host BPF freed a shared RAM page")
+        progress("Host BPF page-free checks passed for both shared pages")
+
+        for index, offset in enumerate(offsets):
+            progress(f"Round 1: host -> guest {index}, value {HOST_FIRST:#018x}")
+            result = run_host_bpf(runner, obj, fd, offset)
+            if result != 0:
+                raise RuntimeError(f"guest {index} first result={result}")
+            other = offsets[1 - index]
+            if index == 0 and getq(arena, other + 16) != 0:
+                raise RuntimeError("guest 0 write modified guest 1 signal")
+            if index == 0:
+                progress("Guest 1 signal unchanged after host write to guest 0")
+
+        for index, (process, messages, lines, _) in enumerate(guests):
+            offset = offsets[index]
+            wait_reply(runner, obj, fd, offset, process, lines)
+            progress(f"Round 1: guest {index} -> host, "
+                     f"verified value {GUEST_FIRST:#018x}")
+
+        # Guest 0 exits while guest 1 keeps its slice mapped and active.
+        for index, (process, messages, lines, _) in enumerate(guests):
+            offset = offsets[index]
+            progress(f"Round 2: host -> guest {index}, value {HOST_SECOND:#018x}")
+            if run_host_bpf(runner, obj, fd, offset) != 0:
+                raise RuntimeError(f"host BPF failed guest {index} second value")
+            wait_reply(runner, obj, fd, offset, process, lines)
+            progress(f"Round 2: guest {index} -> host, "
+                     f"verified value {GUEST_SECOND:#018x}")
+            if run_host_bpf(runner, obj, fd, offset) != 2:
+                raise RuntimeError(f"host BPF failed guest {index} reply")
+            wait_message(messages, lines, "GUEST_BPF_EXCHANGED", process)
+            process.wait(timeout=15)
+            if process.returncode:
+                raise RuntimeError(f"guest {index} failed:\n" + "".join(lines))
+            progress(f"Guest {index} completed and exited successfully")
+            if index == 0:
+                progress("Continuing with guest 1 after guest 0 exits")
+        print(f"OK: two guests exchanged BPF values through arena slices {offsets}")
+    finally:
+        progress("Cleaning up guest processes")
+        stop_guests(guests)
+
+
+def skip(reason):
+    print(f"SKIP: {reason}")
+    return KSFT_SKIP
+
+
+def create_arena(pin, build):
+    parent, child = socket.socketpair()
+    with parent, child:
+        result = subprocess.run(
+            [str(build / "arena_kvm_host-runner"), "--create", pin,
+             str(child.fileno()), str(NUM_PAGES)], pass_fds=(child.fileno(),),
+            timeout=HELPER_TIMEOUT)
+        child.close()
+        if result.returncode == KSFT_SKIP:
+            return None
+        result.check_returncode()
+        fds = array.array("i")
+        _, ancillary, flags, _ = parent.recvmsg(
+            1, socket.CMSG_SPACE(fds.itemsize))
+        for level, kind, data in ancillary:
+            if level == socket.SOL_SOCKET and kind == socket.SCM_RIGHTS:
+                fds.frombytes(data[:len(data) - len(data) % fds.itemsize])
+        if flags & socket.MSG_CTRUNC or len(fds) != 1:
+            for fd in fds:
+                os.close(fd)
+            raise RuntimeError("host helper did not send one arena FD")
+        return fds[0]
+
+
+def main():
+    parser = argparse.ArgumentParser(description=__doc__)
+    parser.add_argument("--build-dir", type=Path,
+                        help="directory containing the built helpers")
+    parser.add_argument("--kernel", default=os.environ.get("ARENA_KVM_KERNEL"),
+                        help="virtme-ng kernel path or release (default: source "
+                             "tree kernel, otherwise running kernel)")
+    args = parser.parse_args()
+    if not hasattr(os, "pidfd_open") or not hasattr(signal, "pidfd_send_signal"):
+        return skip("Python 3.9+ with Linux pidfd support is required")
+    machine = os.uname().machine
+    if machine not in GUEST_RAM_BASES:
+        return skip(f"unknown guest RAM layout for architecture {machine}")
+    if struct.calcsize("P") != 8:
+        return skip("BPF arenas require a supported 64-bit architecture")
+    if os.geteuid() != 0:
+        return skip("this test requires root")
+    if SLICE_SIZE % PAGE_SIZE:
+        return skip("arena slices must contain a whole number of pages")
+    if not os.path.ismount("/sys/fs/bpf"):
+        return skip("mount bpffs first")
+    directory = Path(__file__).resolve().parent
+    build = args.build_dir
+    if build is None:
+        build = Path.cwd() if (Path.cwd() / "arena_kvm_host-runner").is_file() \
+            else directory
+    build = build.resolve()
+    kernel = args.kernel
+    if kernel is None:
+        kernel = next((str(p) for p in directory.parents
+                       if (p / "vmlinux").is_file()), os.uname().release)
+    vng, env = resolve_vng()
+    if not vng:
+        return KSFT_SKIP
+    qemu_arch = {"arm64": "aarch64", "ppc64le": "ppc64"}.get(machine, machine)
+    for tool in ("script", f"qemu-system-{qemu_arch}"):
+        if not shutil.which(tool, path=env.get("PATH")):
+            return skip(f"{tool} is unavailable")
+    for name in ("arena_kvm_guest-init", "arena_kvm_guest.bpf.o",
+                 "arena_kvm_host-runner", "arena_kvm_host.bpf.o"):
+        if not (build / name).exists():
+            return skip(f"missing {build / name}; build the BPF selftests")
+    for name in ("arena_kvm_host.bpf.o", "arena_kvm_guest.bpf.o"):
+        result = subprocess.run([str(build / "arena_kvm_host-runner"),
+                                 "--check-bpf", str(build / name)],
+                                timeout=HELPER_TIMEOUT)
+        if result.returncode == KSFT_SKIP:
+            return skip("BPF compiler lacks arena address-space conversions")
+        result.check_returncode()
+    if subprocess.run([str(build / "arena_kvm_host-runner"),
+                       "--check-kvm"], timeout=HELPER_TIMEOUT).returncode:
+        return skip("KVM is unavailable or its API version is unsupported")
+    pin = f"/sys/fs/bpf/arena_kvm_{os.getpid()}"
+    progress(f"Architecture: {machine}; "
+             f"page size: {PAGE_SIZE} bytes")
+    progress(f"Creating and pinning a {ARENA_SIZE // (1024 * 1024)} MiB "
+             f"host arena at {pin}")
+    try:
+        fd = create_arena(pin, build)
+        if fd is None:
+            return skip("pinned BPF arenas are unsupported")
+        try:
+            if os.stat(pin).st_size != ARENA_SIZE:
+                raise RuntimeError("pinned arena has the wrong size")
+            with mmap.mmap(fd, ARENA_SIZE, flags=mmap.MAP_SHARED,
+                           prot=mmap.PROT_READ | mmap.PROT_WRITE) as arena:
+                progress(f"Populating {NUM_PAGES} host arena pages before "
+                         "starting the guests")
+                # Populate the file pages before QEMU uses them as RAM.
+                for i in range(NUM_PAGES):
+                    arena[i * PAGE_SIZE]
+                exchange(pin, fd, arena, build, kernel, vng, env)
+        finally:
+            os.close(fd)
+    finally:
+        if os.path.exists(pin):
+            os.unlink(pin)
+
+
+if __name__ == "__main__":
+    enable_subreaper()
+    signal.signal(signal.SIGTERM, terminate)
+    signal.signal(signal.SIGINT, terminate)
+    try:
+        status = main()
+    except TestSkipped as err:
+        status = skip(str(err))
+    except TestTerminated as err:
+        progress(f"Terminated by signal {err.signum}")
+        status = 128 + err.signum
+    finally:
+        signal.signal(signal.SIGTERM, signal.SIG_IGN)
+        signal.signal(signal.SIGINT, signal.SIG_IGN)
+        stop_children()
+    sys.exit(status)
diff --git a/tools/testing/selftests/bpf/arena_kvm_guest.bpf.c b/tools/testing/selftests/bpf/arena_kvm_guest.bpf.c
new file mode 100644
index 0000000000000..461562149c57f
--- /dev/null
+++ b/tools/testing/selftests/bpf/arena_kvm_guest.bpf.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+#include "bpf_arena_common.h"
+#ifdef __TARGET_ARCH_powerpc
+/* PowerPC does not support arena load-acquire/store-release instructions. */
+#undef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+#endif
+#include "bpf_atomic.h"
+#endif
+#include "arena_kvm_shared.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE | BPF_F_ARENA_NO_FREE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+volatile __u32 signal_offset;
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+
+SEC("syscall")
+int allocate(void *ctx)
+{
+	struct signal_page __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, ARENA_KVM_NODE, 0);
+	if (!page)
+		return 1;
+	signal_offset = (__u32)((__u64)page - (__u64)arena_base(&arena));
+	smp_store_release(&page->ready, GUEST_READY);
+	return 0;
+}
+
+SEC("syscall")
+int probe_free(void *ctx)
+{
+	struct signal_page __arena *page =
+		(struct signal_page __arena *)((char __arena *)arena_base(&arena) +
+					     signal_offset);
+
+	bpf_arena_free_pages(&arena, page, 1);
+	return page->ready == GUEST_READY ? 0 : 1;
+}
+
+SEC("syscall")
+int exchange(void *ctx)
+{
+	struct signal_page __arena *page =
+		(struct signal_page __arena *)((char __arena *)arena_base(&arena) +
+					     signal_offset);
+	__u64 seq = smp_load_acquire(&page->h2g_seq);
+	__u64 payload;
+
+	if ((seq != 1 && seq != 2) || page->g2h_seq == seq)
+		return 1;
+	payload = page->h2g_payload;
+	if (seq == 1 && payload != HOST_FIRST)
+		return 2;
+	if (seq == 2 && payload != HOST_SECOND)
+		return 3;
+	page->g2h_payload = seq == 1 ? GUEST_FIRST : GUEST_SECOND;
+	smp_store_release(&page->g2h_seq, seq);
+	return 0;
+}
+
+SEC("syscall")
+int complete(void *ctx)
+{
+	struct signal_page __arena *page =
+		(struct signal_page __arena *)((char __arena *)arena_base(&arena) +
+					     signal_offset);
+
+	return smp_load_acquire(&page->h2g_seq) == 3 ? 0 : 1;
+}
+
+#else
+SEC("syscall") int allocate(void *ctx) { return 1; }
+SEC("syscall") int probe_free(void *ctx) { return 1; }
+SEC("syscall") int exchange(void *ctx) { return 1; }
+SEC("syscall") int complete(void *ctx) { return 1; }
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/arena_kvm_guest.c b/tools/testing/selftests/bpf/arena_kvm_guest.c
new file mode 100644
index 0000000000000..da6586ae660d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/arena_kvm_guest.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Guest helper for a BPF arena allocated from shared NUMA RAM.
+ */
+#define __EXPORTED_HEADERS__
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/bpf.h>
+#include <linux/mempolicy.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "arena_kvm_shared.h"
+
+static int signal_file_offset(void *arena, uint64_t *offset)
+{
+	char cmdline[8192], *arg, *end;
+	uint64_t entry, pfn, gpa, base = 0, size = 0, *value;
+	ssize_t n;
+	int fd, node, found = 0;
+
+	/* The launcher supplies QEMU's guest physical base for this slice. */
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	n = read(fd, cmdline, sizeof(cmdline) - 1);
+	close(fd);
+	if (n <= 0 || n == sizeof(cmdline) - 1)
+		return -EIO;
+	cmdline[n] = '\0';
+	for (arg = strtok(cmdline, "\n "); arg; arg = strtok(NULL, "\n ")) {
+		if (!strncmp(arg, "arena_kvm.base=", 15)) {
+			value = &base;
+			found |= 1;
+		} else if (!strncmp(arg, "arena_kvm.size=", 15)) {
+			value = &size;
+			found |= 2;
+		} else {
+			continue;
+		}
+		errno = 0;
+		*value = strtoull(arg + 15, &end, 0);
+		if (errno || *end || end == arg + 15 || *value % getpagesize())
+			return -EINVAL;
+	}
+	if (found != 3 || size < getpagesize())
+		return -EINVAL;
+
+	/* Fault the BPF-allocated page into the guest user VMA. */
+	if (!*(volatile uint64_t *)arena)
+		return -EINVAL;
+	if (syscall(SYS_get_mempolicy, &node, NULL, 0, arena,
+		    MPOL_F_NODE | MPOL_F_ADDR))
+		return -errno;
+	if (node != ARENA_KVM_NODE)
+		return -EXDEV;
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	n = pread(fd, &entry, sizeof(entry),
+		  (uintptr_t)arena / getpagesize() * sizeof(entry));
+	close(fd);
+	if (n != sizeof(entry) || !(entry & (1ULL << 63)))
+		return -EIO;
+	pfn = entry & ((1ULL << 55) - 1);
+	if (!pfn)
+		return -EPERM;
+	gpa = pfn * getpagesize();
+	if (gpa < base || gpa - base >= size || size - (gpa - base) < getpagesize())
+		return -ERANGE;
+	*offset = gpa - base;
+	return 0;
+}
+
+static int create_arena(void)
+{
+	union bpf_attr attr = {
+		.map_type = BPF_MAP_TYPE_ARENA,
+		.max_entries = 1,
+		.map_flags = BPF_F_MMAPABLE | BPF_F_ARENA_NO_FREE,
+	};
+
+	return syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+}
+
+static int run_prog(int fd, unsigned int *retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err = bpf_prog_test_run_opts(fd, &opts);
+
+	if (err)
+		return err;
+	*retval = opts.retval;
+	return 0;
+}
+
+static int exchange_once(int fd)
+{
+	unsigned int result = 0;
+	int err;
+
+	/* The host bounds each protocol stage and stops the guest on timeout. */
+	for (;;) {
+		err = run_prog(fd, &result);
+		if (err || result > 1)
+			return err ? err : -EINVAL;
+		if (!result)
+			return 0;
+		usleep(1000);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct bpf_object *obj = NULL;
+	struct bpf_program *alloc, *probe_free, *exchange, *complete;
+	struct bpf_map *map;
+	void *arena = MAP_FAILED;
+	uint64_t file_offset;
+	unsigned int result = 0;
+	int fd = -1;
+	int err;
+
+	setbuf(stdout, NULL);
+	if (argc != 2 ||
+	    (mount("sysfs", "/sys", "sysfs", 0, NULL) && errno != EBUSY) ||
+	    (mount("proc", "/proc", "proc", 0, NULL) && errno != EBUSY))
+		goto fail;
+	if (access("/sys/devices/system/node/node1", F_OK)) {
+		fputs("guest NUMA node 1 is unavailable\n", stderr);
+		goto fail;
+	}
+	fd = create_arena();
+	if (fd < 0) {
+		perror("create guest arena");
+		goto fail;
+	}
+	arena = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (arena == MAP_FAILED) {
+		perror("mmap guest arena");
+		goto fail;
+	}
+	obj = bpf_object__open_file(argv[1], NULL);
+	if (!obj)
+		goto fail;
+	err = arena_kvm_check_features(obj);
+	if (err == 4) {
+		puts("GUEST_BPF_SKIPPED: compiler lacks arena address-space casts");
+		bpf_object__close(obj);
+		munmap(arena, getpagesize());
+		close(fd);
+		return 4;
+	}
+	if (err)
+		goto fail;
+	map = bpf_object__find_map_by_name(obj, "arena");
+	alloc = bpf_object__find_program_by_name(obj, "allocate");
+	probe_free = bpf_object__find_program_by_name(obj, "probe_free");
+	exchange = bpf_object__find_program_by_name(obj, "exchange");
+	complete = bpf_object__find_program_by_name(obj, "complete");
+	if (!map || !alloc || !probe_free || !exchange || !complete ||
+	    bpf_map__reuse_fd(map, fd))
+		goto fail;
+	close(fd);
+	fd = -1;
+	err = bpf_object__load(obj);
+	if (err) {
+		fprintf(stderr, "load guest BPF: %d\n", err);
+		goto fail;
+	}
+	err = run_prog(bpf_program__fd(alloc), &result);
+	if (err || result) {
+		fprintf(stderr, "allocate guest page: err=%d result=%u\n",
+			err, result);
+		goto fail;
+	}
+	err = run_prog(bpf_program__fd(probe_free), &result);
+	if (err || result) {
+		fprintf(stderr, "guest page lifetime check: err=%d result=%u\n",
+			err, result);
+		goto fail;
+	}
+	err = signal_file_offset(arena, &file_offset);
+	if (err == -EXDEV) {
+		puts("GUEST_BPF_SKIPPED: allocation fell back from shared NUMA node");
+		bpf_object__close(obj);
+		munmap(arena, getpagesize());
+		return 4;
+	}
+	if (err) {
+		fprintf(stderr, "resolve shared page offset: %d\n", err);
+		goto fail;
+	}
+	printf("GUEST_BPF_READY %llu %d\n",
+	       (unsigned long long)file_offset, getpagesize());
+	if (exchange_once(bpf_program__fd(exchange)) ||
+	    exchange_once(bpf_program__fd(exchange)) ||
+	    exchange_once(bpf_program__fd(complete)))
+		goto fail;
+	puts("GUEST_BPF_EXCHANGED");
+	bpf_object__close(obj);
+	munmap(arena, getpagesize());
+	return 0;
+
+fail:
+	puts("GUEST_BPF_FAILED");
+	bpf_object__close(obj);
+	if (arena != MAP_FAILED)
+		munmap(arena, getpagesize());
+	if (fd >= 0)
+		close(fd);
+	return 1;
+}
diff --git a/tools/testing/selftests/bpf/arena_kvm_host.bpf.c b/tools/testing/selftests/bpf/arena_kvm_host.bpf.c
new file mode 100644
index 0000000000000..9c1c535fe429b
--- /dev/null
+++ b/tools/testing/selftests/bpf/arena_kvm_host.bpf.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+#include "bpf_arena_common.h"
+#ifdef __TARGET_ARCH_powerpc
+/* PowerPC does not support arena load-acquire/store-release instructions. */
+#undef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+#endif
+#include "bpf_atomic.h"
+#endif
+#include "arena_kvm_shared.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE | BPF_F_ARENA_NO_FREE | BPF_F_ARENA_EXPORT);
+	/* The host runner reuses the map created with the selected capacity. */
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+volatile __u32 signal_offset;
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+
+SEC("syscall")
+int exchange(void *ctx)
+{
+	struct signal_page __arena *page =
+		(struct signal_page __arena *)((char __arena *)arena_base(&arena) +
+					     signal_offset);
+	__u64 seq = page->h2g_seq;
+
+	if (smp_load_acquire(&page->ready) != GUEST_READY)
+		return 4;
+	if (!seq) {
+		page->h2g_payload = HOST_FIRST;
+		smp_store_release(&page->h2g_seq, 1);
+		return 0;
+	}
+	if (seq == 1 && smp_load_acquire(&page->g2h_seq) == 1) {
+		if (page->g2h_payload != GUEST_FIRST)
+			return 3;
+		page->h2g_payload = HOST_SECOND;
+		smp_store_release(&page->h2g_seq, 2);
+		return 0;
+	}
+	if (seq == 2 && smp_load_acquire(&page->g2h_seq) == 2) {
+		if (page->g2h_payload != GUEST_SECOND)
+			return 3;
+		smp_store_release(&page->h2g_seq, 3);
+		return 2;
+	}
+	return 1;
+}
+
+SEC("syscall")
+int check_reply(void *ctx)
+{
+	struct signal_page __arena *page =
+		(struct signal_page __arena *)((char __arena *)arena_base(&arena) +
+					     signal_offset);
+	__u64 seq = page->h2g_seq;
+
+	if ((seq != 1 && seq != 2) || smp_load_acquire(&page->g2h_seq) != seq)
+		return 1;
+	return page->g2h_payload == (seq == 1 ? GUEST_FIRST : GUEST_SECOND) ? 0 : 3;
+}
+
+SEC("syscall")
+int probe_free(void *ctx)
+{
+	struct signal_page __arena *page =
+		(struct signal_page __arena *)((char __arena *)arena_base(&arena) +
+					     signal_offset);
+
+	bpf_arena_free_pages(&arena, page, 1);
+	return page->ready == GUEST_READY ? 0 : 1;
+}
+
+#else
+SEC("syscall") int exchange(void *ctx) { return 1; }
+SEC("syscall") int check_reply(void *ctx) { return 1; }
+SEC("syscall") int probe_free(void *ctx) { return 1; }
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/arena_kvm_host.c b/tools/testing/selftests/bpf/arena_kvm_host.c
new file mode 100644
index 0000000000000..90a77a54bd6f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/arena_kvm_host.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/kvm.h>
+#include <limits.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+#include "arena_kvm_shared.h"
+
+static int create_arena(const char *pin, int socket_fd, unsigned int pages)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.map_flags = BPF_F_MMAPABLE | BPF_F_ARENA_NO_FREE |
+			     BPF_F_ARENA_EXPORT);
+	char control[CMSG_SPACE(sizeof(int))] = {};
+	char byte = 0;
+	struct iovec iov = { .iov_base = &byte, .iov_len = 1 };
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = control,
+		.msg_controllen = sizeof(control),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	int fd, err = 1;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_kvm", 0, 0,
+			    pages, &opts);
+	if (fd < 0) {
+		if (errno == EOPNOTSUPP || errno == EINVAL)
+			return 4; /* KSFT_SKIP: arena type or flags unsupported. */
+		perror("create host arena");
+		return 1;
+	}
+	if (bpf_obj_pin(fd, pin)) {
+		perror("pin host arena");
+		goto out;
+	}
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(fd));
+	memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
+	if (sendmsg(socket_fd, &msg, 0) == 1)
+		err = 0;
+	else
+		perror("send arena FD");
+out:
+	close(fd);
+	return err;
+}
+
+int main(int argc, char **argv)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_object *obj = NULL;
+	struct bpf_program *prog;
+	struct bpf_map *arena, *bss;
+	uint32_t key = 0, offset;
+	unsigned long parsed;
+	int fd, err;
+	char *end;
+
+	if (argc == 3 && !strcmp(argv[1], "--check-bpf")) {
+		obj = bpf_object__open_file(argv[2], NULL);
+		if (!obj)
+			return 1;
+		err = arena_kvm_check_features(obj);
+		bpf_object__close(obj);
+		return err;
+	}
+
+	if (argc == 2 && !strcmp(argv[1], "--check-kvm")) {
+		fd = open("/dev/kvm", O_RDWR);
+		if (fd < 0)
+			return 4;
+		err = ioctl(fd, KVM_GET_API_VERSION, 0);
+		close(fd);
+		return err == KVM_API_VERSION ? 0 : 4;
+	}
+	if (argc == 5 && !strcmp(argv[1], "--create")) {
+		errno = 0;
+		parsed = strtoul(argv[3], &end, 0);
+		if (errno || *end || end == argv[3] || parsed > INT_MAX)
+			return 1;
+		fd = parsed;
+		errno = 0;
+		parsed = strtoul(argv[4], &end, 0);
+		if (errno || *end || end == argv[4] || !parsed || parsed > UINT_MAX)
+			return 1;
+		return create_arena(argv[2], fd, parsed);
+	}
+	if (argc != 5)
+		return 1;
+	errno = 0;
+	parsed = strtoul(argv[1], &end, 0);
+	if (errno || *end || parsed > INT_MAX)
+		return 1;
+	fd = dup(parsed);
+	if (fd < 0)
+		return 1;
+	errno = 0;
+	parsed = strtoul(argv[3], &end, 0);
+	if (errno || *end || parsed > UINT_MAX || parsed % getpagesize())
+		goto fail;
+	offset = parsed;
+	obj = bpf_object__open_file(argv[2], NULL);
+	if (!obj)
+		goto fail;
+	arena = bpf_object__find_map_by_name(obj, "arena");
+	bss = bpf_object__find_map_by_name(obj, ".bss");
+	prog = bpf_object__find_program_by_name(obj, argv[4]);
+	if (!arena || !bss || !prog || bpf_map__reuse_fd(arena, fd))
+		goto fail;
+	if (offset >= (uint64_t)bpf_map__max_entries(arena) * getpagesize())
+		goto fail;
+	if (bpf_object__load(obj)) {
+		fputs("load host BPF failed\n", stderr);
+		goto fail;
+	}
+	if (bpf_map_update_elem(bpf_map__fd(bss), &key, &offset, BPF_ANY)) {
+		perror("set signal offset");
+		goto fail;
+	}
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (err)
+		goto fail;
+	printf("%u\n", opts.retval);
+	bpf_object__close(obj);
+	close(fd);
+	return 0;
+
+fail:
+	bpf_object__close(obj);
+	close(fd);
+	return 1;
+}
diff --git a/tools/testing/selftests/bpf/arena_kvm_shared.h b/tools/testing/selftests/bpf/arena_kvm_shared.h
new file mode 100644
index 0000000000000..63aafac25efc3
--- /dev/null
+++ b/tools/testing/selftests/bpf/arena_kvm_shared.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef ARENA_KVM_SHARED_H
+#define ARENA_KVM_SHARED_H
+
+/* These flags may be absent from a pre-series kernel's vmlinux.h. */
+#ifndef BPF_F_ARENA_NO_FREE
+#define BPF_F_ARENA_NO_FREE (1U << 20)
+#endif
+#ifndef BPF_F_ARENA_EXPORT
+#define BPF_F_ARENA_EXPORT (1U << 21)
+#endif
+
+struct arena_kvm_features {
+	unsigned int addr_space_cast;
+};
+
+#ifdef __BPF__
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+const volatile struct arena_kvm_features features = { .addr_space_cast = 1 };
+#else
+const volatile struct arena_kvm_features features = {};
+#endif
+#else
+/* Inspect compiler support before loading maps or booting either guest. */
+static inline int arena_kvm_check_features(struct bpf_object *obj)
+{
+	const struct arena_kvm_features *features;
+	struct bpf_map *map;
+	size_t size;
+
+	map = bpf_object__find_map_by_name(obj, ".rodata");
+	if (!map)
+		return 1;
+	features = bpf_map__initial_value(map, &size);
+	if (!features || size != sizeof(*features))
+		return 1;
+	return features->addr_space_cast ? 0 : 4; /* KSFT_SKIP */
+}
+#endif
+
+#define ARENA_KVM_NODE 1
+
+#define GUEST_READY 0x4152454e414b564dULL
+#define HOST_FIRST 0x123456789abcdef0ULL
+#define GUEST_FIRST 0xfedcba9876543210ULL
+#define HOST_SECOND 0x1020304050607080ULL
+#define GUEST_SECOND 0x8070605040302010ULL
+
+struct signal_page {
+	volatile unsigned long long ready;
+	volatile unsigned long long h2g_payload;
+	volatile unsigned long long h2g_seq;
+	volatile unsigned long long g2h_payload;
+	volatile unsigned long long g2h_seq;
+};
+
+#endif
-- 
2.56.0

