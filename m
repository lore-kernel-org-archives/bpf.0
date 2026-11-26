Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722235;
	b=Xt5QJNSBcVJdoH7zangHkEewVgUhucOt+pDODCincr5erEVEjsW8bn/8cMUC+yQr6w+V
	 0vIYZYDblZRHn8WfrNGL4z+PkzXE5pL6ziCSJF/Oau7PlgznnxFFgkgtMB3H+H8i8PWla
	 TTvI/cMEGc0QHRA8c+nb7A2GiJW45P7OLMX/DRU2eGnWJq+SOuPQn0x2Co1YzbtsQ5c7o
	 aT9rAjmvE9valP8mm5fVvSP79AlAMdaYO+gHRTv3CKaVSUblxHmo0STiGn/zmOHkGaCJ+
	 o/MdCCtxPXUcRAdB+zlP07Zdqn65dRKSdKTPVGEIzr/cocSyJ3fkQfSMDzAYAZSI+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0P+afiYP4rfSnxzXHVdIh7omPyidFVRRqauBrgysGMg=;
	b=OG5ckuoui37Fm0oeJotfSA1C81N9kqXjfdJXjbcMncjTQAvW09purnnRHPd+GBQiS1o5
	 rxyjIc6TeHDbGguUb1r7C8zy1BvrrMd8ro+x0JkQNwfPBDK4ZHlMT39AgaIncJbw46QHp
	 EAyUZBypPEy200u9LSxoQwQEp2ozqILRk6dDn9JvZulJnWQGAalMG7Ze9IjIwXQK8Qe7N
	 KUzaJDLE76JLyIPycv8NIdKmrCX9VkvtrXLM3yGn04LpKqnzOdRDiM/FAp3IJrnV97C2e
	 qs2/ljLeV6W+nH69CspGYa+pBIOhQx3iV3g4d1xLXGicgYvKnSCsfFN3AbMKR07v8Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhdSYHug;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBB606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 19:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7EBB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhdSYHug
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so73240995e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 11:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795722233; x=1796327033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0P+afiYP4rfSnxzXHVdIh7omPyidFVRRqauBrgysGMg=;
        b=fhdSYHugrQHo09L4nLloEF4mk3hkzNwZBp9BAGnhIDY3iOWaBFG7EKz+9dqkISQJqv
         nmVKFwfaud19WOASH+xfGC4xeoRLVJaxxLdOURer63seqUvIi6aGkz6zxSNgvSHtwz1/
         W5zdi9Fbto0rMKrLe5cIuWrXHOLTDNlanztZD7WJp1QSTFg4dwKeTrxalfZzt+Z3TadO
         15HdPtkmZm5DJmLgqYEZbUjjij36sjBB2IhoiijlPy5DWgTti+gDfRfxyx/RoD9V9oV2
         tEKnE3gcWLEgP1vqxbeYEnTwFd4Gf9Y+DygwMnFhkPSeH6pAOhQ6n6zqB+YiT1MtPTXX
         DCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795722233; x=1796327033;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0P+afiYP4rfSnxzXHVdIh7omPyidFVRRqauBrgysGMg=;
        b=teIXwSToI14JvejchG2EsDCjA9YZyIEMOhxNnszbfqWo0Kq+a4Ods59OW1HDlbrmLh
         qG3I/nnK2AXejZ3yfcbO3lk4IeJzXQqCILShcNxsDe6+d706iksdesxNbwz1GTj7JoQy
         Ddgfhr2fNuaFia3MocirtfrzSgFKePp9iORun8jg90NnSgjvJrvASzKLdnRgoRm3OqGr
         Ng14dwGnRhWwvp6NzxFwi5BlojtdgoyUEClD76tAHrubOWVs2A6MsfRSz9MirrPTFfjV
         KbE44baYlnAlPmbwhxdgPYbqjI3EzT+NRtrLB6tJ8G1vzUOX9O1EVBFfyt0iOqXTTATd
         q64w==
X-Gm-Message-State: APuU4Z/cX60shXxWXONAHSBHfV/lrvuIwwrhC9iPCs8NiUhLc0p9DxAa
	KqyajibL2clJdUUB1UlMjuceGLptSMABLT2CkyRhd6LHZuchDVQEY/LYrYh3mNk=
X-Gm-Gg: AZFdTZcFrtZ1LdjmbE4La7Jr66jnZ7h4RObwJiPcy0HLOX/i4xlFuBjdLQ9PLmSDPj1
	jbUgQTDnlsNqiTOnbO89bu47gogczSYN5X/TtoQ6jVGPvsZiboR2KoANbFPz6isjIJPm6mhZgvM
	GsdOBuUfRES+QbfCWFuda26E3EyETmfXFY3AZhXq+HMEopYJPYyxITMyOKe+8VL86krDXb7t6pg
	SmhzOQTxRz1qKZ+vc78+p6eOtaOaHO+pxCnZliZBrCxQDYaXuKFQpyuuiUJlUvm+djqELSGZOB8
	cAqeZAYV4CARBpDaOo6ztdugNVgppoBaURZR7PyImDMcXdw7EDknMmDBdW/r+j7gOVaOL+0ZUUB
	AJgw/FEnX1U6tXSnpav+00ONWiHTYsF5eK0xhPSCvftwpruWcqfevrqK/YsTPw+2LSTdTFqh3s+
	HI0wOqVGoYjM+EQq0b74O4NW6sNP29SIYqBa+0GMUz6nQTMi9TEEd7emBoade1usX1Bg0SaZ+q3
	GOq+lOSh9+ufsF57odwe2MLTnoKnVxZZh/HQ7r0olZ0NFIgp5PDUVC6sIXRjW3UCJbmmhynFUWC
	2jCT02BxyoLdWrBRYoSv0xZOlQd/vMCq7jCYCRUfWFcd1AgxA1crWhzQUSmN9cKoe4wZ5uTaBgZ
	xrh3+KqNFcA1bo3afZ1Dc7uwtkaQwGjWBJkhz1DjIUC1drjAbm7UDM5Pl2J/nUSPU8htaGFC2uO
	MfOlzfpjSCIGUPOj05vcLM2h3AhwfDD/Sk
X-Received: by 2002:a05:600d:1c:b0:4bb:9dbd:feb7 with SMTP id 5b1f17b1804b1-4bb9dbdff35mr194083605e9.9.1795722232705;
        Thu, 26 Nov 2026 11:43:52 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-2317-a900-4811-d431-309f-6626.310.pool.telefonica.de. [2a02:3100:2317:a900:4811:d431:309f:6626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm43663924f8f.3.2026.11.26.11.43.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 11:43:51 -0800 (PST)
From: Tobias Philipp <tphilipp@gmail.com>
To: bpf@vger.kernel.org
Cc: Tobias Philipp <tphilipp@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	=?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks@slashdirt.org>,
	Stijn Tintel <stijn@linux-ipv6.be>,
	Daniel Mack <daniel@zonque.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/4] bpf: Fix 8-byte alignment of map values
Date: Thu, 26 Nov 2026 20:43:43 +0100
Message-ID: <20261126194347.42466-1-tphilipp@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The verifier checks the alignment of BPF_DW atomics and 64-bit
load-acquire/store-release on PTR_TO_MAP_VALUE only against the offset
within the value. It assumes that the value itself is 8-byte aligned.
That does not hold for all map types. Address of the value mod 8, as
measured on bpf-next (see Testing below):

                                    64-bit    32-bit
  lpm_trie, key_size 8 (IPv4)          4         0 (by accident)
  lpm_trie, key_size 20 (IPv6)         0         4
  hash, rhash (BPF_F_NO_PREALLOC)      0         4
  devmap, devmap_hash                  4         4 (harmless, see patch 3)

On arm64 the JIT emits LSE atomics or LDXR/STXR loops, LDAR and STLR
for these instructions. They fault on misaligned addresses; with
FEAT_LSE2, LSE atomics, LDAR and STLR only when the access crosses a
16-byte boundary. On arm32 the interpreter uses atomic64_*(), i.e.
LDREXD/STREXD, which require 8-byte alignment. On x86-64 a locked
8-byte access at 4 mod 8 that crosses a cache line is a split lock,
which is fatal in kernel mode on CPUs with split lock detection. None
of these faults is fixed up.

Patch 1 is Felix Fietkau's fix for bpf_mem_alloc on 32-bit [1]. It was
posted in July and is not applied yet. It is included unchanged apart
from a rebase, because patch 2 depends on it. It fixes the hash and
rhash rows and the node alignment of lpm_trie on 32-bit. The Sashiko
review of that posting points out a pre-existing 8-byte load of the
4-byte percpu pointer in the bpf_per_cpu_ptr()/bpf_this_cpu_ptr()
fixup on 32-bit. Patch 1 neither causes nor fixes it, and this series
does not address it. Among the 32-bit JITs only x86 supports kfuncs,
so only x86-32 can reach it. Using BPF_SIZEOF(void *) for that load
would fix it.

Patch 2 places the lpm_trie value at the next 8-byte boundary after the
key and shrinks prefixlen and flags to u16, so that nodes don't grow.

Patch 3 aligns the devmap value.

Patch 4 adds a selftest that checks the address of the value returned
by bpf_map_lookup_elem() for lpm_trie, hash and devmap. It executes no
instruction that needs alignment, so on an affected kernel it fails
instead of crashing.

Patches 1 and 2 have to be applied together: on 32-bit, either one
alone misaligns the IPv4 lpm_trie value (see "+ patch 1" and
"+ patch 2" in the table below), and both commit messages say so. I
kept them separate to keep Felix's authorship; they can be squashed if
that is preferred.

The other map types that hand a value pointer to programs return 8-byte
aligned values. cpumap has its value at offset 20 on 32-bit, but the
verifier does not let programs look it up.

Testing, in disposable QEMU VMs:

- arm64, defconfig + selftests/bpf config, QEMU with HVF on an Apple
  M-series host (FEAT_LSE2): map_value_align fails on bpf-next
  (lpm_value_align: 4, devmap_value_align: 4) and passes with the
  series. With the series, test_maps passes the lpm_trie basic_ops,
  batch_ops and get_next_key tests and the hash and array tests, and
  test_progs passes pinning_devmap_reuse and xdp_devmap_attach
  subtests 2 and 3.

- arm32, multi_v7_defconfig + BPF_SYSCALL, QEMU virt with Cortex-A15
  (TCG): test_progs is hard to cross-build for armhf, so a small static
  program does the same check as the selftest: an XDP program looks up
  each map and stores the value pointer in an array map. Address mod 8:

                         lpm IPv4  lpm IPv6  hash  rhash  devmap
    arm32 bpf-next           0         4       4     4      4
    arm32 + patch 1          4         0       0     0      4
    arm32 + patch 2          4         4       4     4      4
    arm32 + patches 1-4      0         0       0     0      0
    arm64 bpf-next           4         0       0     0      4
    arm64 + patches 1-4      0         0       0     0      0

- pahole matches the layouts in the commit messages: lpm_trie_node
  data[] moves from 24 to 20 (arm64) and from 16 to 12 (arm32), and
  devmap val from 52 to 56 (arm64, size stays 64) and from 28 to 32
  (arm32).

- W=1 builds of the four touched kernel files on x86_64, arm64 and
  arm32 produce no warnings.

Not tested: runtime on x86_64; test_progs on arm32; selftests that need
CONFIG_FTRACE or bpf_testmod, which my configuration lacked. That
includes xdp_devmap_attach subtests 1 and 4 and the bpf_obj_new and
percpu allocation tests; they failed to load in the same way with and
without the series. Patch 1 does not change anything on 64-bit. The
x86 split lock case comes from arch/x86/kernel/traps.c; I did not
trigger it.

The lpm_trie bug was found with AI assistance while trying to verify
the correctness of map value accesses with formal methods. Patches 3-4,
the commit messages and this cover letter were written with the help
of an AI coding assistant (Claude Opus 5.5). The code of patch 2
follows Alexei's suggestion.

[1] https://lore.kernel.org/all/20260717183632.99195-1-nbd@nbd.name/

Changes in v3:
- Patch 2: place the value at round_up(offsetof(data) + data_size, 8)
  and make prefixlen and flags u16, so that nodes don't grow and move
  to a larger kmalloc bucket. This drops the BUILD_BUG_ON(), the four
  round_up() calls and the comment that was not in kernel style
  (Alexei).
- Patch 3: use a single-line comment (Sashiko).
- Correct the FEAT_LSE2 statement for LDAR/STLR in this cover letter
  and in patches 2 and 3 (Alexei).

Changes in v2:
- Target bpf-next (Alexei).
- Fix the 32-bit node misalignment at its root in bpf_mem_alloc by
  including Felix's patch. v1 rounded data_size up on top of a node
  at 4 mod 8 on 32-bit and so misaligned the IPv4 value there, which
  is aligned today (Alexei).
- Drop "data[] __aligned(8)", which changed nothing (Alexei).
- Add the devmap fix (Alexei).
- Add a selftest (Alexei).
- Correct the commit message, which claimed that the IPv4 value is at
  4 mod 8 on all architectures.

v2: https://lore.kernel.org/bpf/20261124225055.87344-1-tphilipp@gmail.com/
v1: https://lore.kernel.org/bpf/20261119155317.11469-1-tphilipp@gmail.com/

Felix Fietkau (1):
  bpf: Fix alignment of memory allocator objects on 32-bit archs

Tobias Philipp (3):
  bpf: Align lpm_trie map values to 8 bytes
  bpf: Align devmap values to 8 bytes
  selftests/bpf: Check that map values are 8-byte aligned

 kernel/bpf/devmap.c                           |  3 +-
 kernel/bpf/hashtab.c                          |  2 +-
 kernel/bpf/lpm_trie.c                         | 22 +++++---
 kernel/bpf/memalloc.c                         |  8 +--
 .../bpf/prog_tests/map_value_align.c          | 51 +++++++++++++++++++
 .../selftests/bpf/progs/map_value_align.c     | 48 +++++++++++++++++
 6 files changed, 120 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_value_align.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_value_align.c


base-commit: a58375b858fac35afb78a3dd68ad6a19c01799eb
-- 
2.54.0 (Apple Git-157)

