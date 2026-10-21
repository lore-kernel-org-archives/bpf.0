Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603067;
	b=qrM292cJpUOaNp6w3X+D7KItt/pp1pqE8+6sH0JsHv9SRI1Umfd1VW5c3x91skM+hNsK
	 ys0MfLkR0fuM6hcICYn24bY0yjLLx7R9axOJ9kf4sMwg+YkBNRr0Vyxtl9mFjeQXamFUD
	 e97vP2KwzjbMZLaM9erTrTsi56UnnfR3KlquXhPNloPywAoXyxn1cKa6T9LTQ6yXywcQv
	 VgwF7mJr9iP9+adDiZjZ6p54RnskAN21OvcP9gO5j7FSIpH4eclSd3nEnAk1KnAydikjE
	 0Z93N8sx4CPOIoMoRrfDf1vC2N4u5efgQzkoJ/sr/m/0r97veK0fY0SSU6MKlyfujpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s18p6ABSRGJ/UxVSqWCBTz6bx2WQqcF10z8V9BS39Q8=;
	b=M4YwKB0yGC2Jj6PuytRoyyo6vbHsW7+VKvO/H3ZSb6C+/GL4zpuYgGZ6LbIToluG7m+X
	 Z6NvJV5XabsloC7SKglPuCGRjP6FIxifpaWYB1RpxXWiyXk39iva4Xahvd24Bcz/PFhO9
	 vfrYrqPcC1E/v1R6s8pB7hq6pOMlgY/YR/r94YJ+ZpDWar5TMrwDxynvc6AzmYRZZF9Ly
	 lZmXdOWUbXmxEz62zAPg1Vfc38wMy4cHHB2mzr18EXu3rpnj4DyaTtF6R/NSJI3GWGFBz
	 w38+L4H7wGm7MHIkKVg1SXF3LtSWgNMpGybZDyX9Dwj9IxAHMymxu7BMo3269V8GRLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Jz5VKkJ5;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20465606A331
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20465606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Jz5VKkJ5
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1847362eec.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792603066; x=1793207866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s18p6ABSRGJ/UxVSqWCBTz6bx2WQqcF10z8V9BS39Q8=;
        b=Jz5VKkJ5ki1POVc0ACWEJ+WCtbCo14qie6gLDrZc2KlkQLBROIfXQ8NuX66MUvAIlI
         hq6wIPUQcbcO6fJy3Ob0V0Pa9PpzPmSkBKu1kP1y5NvredHIYviXEQqulk3f9TVbyBEC
         m2W01IFBGi18VKS1/c0by3+YIjfTag07ELRegp9PeqQoQv/W1F9pHZ/BWn6FjTwWCrX+
         6HFgJeL+6xhkHNYqhn3EGL7eMm0TSLBR4OPVFm73RQifYPTpdzhJp+0LyUJYxh+J+Rif
         epCI1INPp9a3i+fgbkYpZYB0M64+dmY7wu411aRwVReuxRAEJ6WJCLDpAba3V3kot9EL
         wxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603066; x=1793207866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s18p6ABSRGJ/UxVSqWCBTz6bx2WQqcF10z8V9BS39Q8=;
        b=Aja3llkrW5nn6u7liwTxR6gpFLEpbBTXqxZJWWgwdjmtAbWIrHcKF0RpEFaj8Fymv/
         nGavfqfnpeLLQcT6MGm95cCLfzo1rLfNiWYTi6scgxcpB+6kj0B4ryMJT/O0jA+FACDq
         DBHJA02d9T6JTStwQlK0/3M07VHNUDsHXkO5XA45AUK7hR6azDjAxo8O3Pm0mzeEcHA9
         wn+JTpobM31o7OhSlD884xMzguYdETxwrSnvftMa6jTx3U8fDXK/xYSmcB/E3K6wUKRU
         P0IKVJr820u+9HljIw7aI4ArsVHjp1Q5097EwJsoKM4svd0ScbkeV1e0hA8WsV2P3xm7
         TqBg==
X-Forwarded-Encrypted: i=1; AKwUvBxTm3beCchFPtVGFw5udyVzgN0tuUwRK8daVG8WFfnoLZXErjRTwYOf77NM7x7raHMGCXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXxpSQ3JXfL4UTLo2Drmr7Fk2AjPKZKTdQLZFzTYRBDgu3A//O
	Otyw8pxzjFpeMFI1S6FA4porcWNFTLY31BTIVRJs+nsBlTTVFessWJ4Os2x4GRAFMZw=
X-Gm-Gg: AYBFou2j1uQiKxn9v9voQlE9vJ/wWATvAr/ChwlJb7s4NkZZRLgaKNapQfsiIRvMSEX
	ku++LUFlVDY1NUbpLDtVnT0ImWBFKSIYF2CBNk5UskR5rJJXOnTp05iY5IPZOvYOKqBHovSPhyD
	SF6tf43H6BGIBk6arGOHZlTD/2INz+7g6lnZdQd+LkPBySyz3Wc+MznLOX4TI0sJtHAzXgAD3+U
	roaxPh1qwZWIsFN8M6fBd/uJYiWrryogRqEhaj6BKlpMtXZAfjqe/w/tUUcXpoUcT5LSyV/P0/p
	l5uHMLJF2YSpwnZsHkXjGRRQjcfMTwn7s9t54LD7PqdmYnMqUThb+rbxpsYVgsLBYu+BlVvDZ38
	neM/nalhvGhwm03V4/2vD8AqQZlkXeRWA6p9sr7Il7HHk/zf+kO6FFwbvXCA0AubhEGRkUib3+x
	Ip16kfBkOSEioNKntv1qbcJH+aq8N7q7OT+VXDwXPxEg29hwuAr2r6WYz3ooB/uk3EX/VsI6xHM
	egrtJkSspwWbgNq5wtn90TXkpJNC39g0gFIpC4i/2fa6Iexi3asNjcLe0JjkiU2SlDjJUitHSa1
	lOD7jkolr/BxQTjtBcKV2ghjKxBRZWXnKqj8CToQSTOK7wnn/NRYLpmCgjdPGrWGcprKk0W9Lw=
	=
X-Received: by 2002:a05:7300:a206:b0:35d:8c39:b314 with SMTP id 5a478bee46e88-3674f22497bmr3602008eec.37.1792603066175;
        Wed, 21 Oct 2026 10:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367412b24e3sm7811387eec.19.2026.10.21.10.17.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:17:45 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	fuad.tabba@linux.dev,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	martin.lau@linux.dev,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	will@kernel.org,
	xukuohai@huaweicloud.com,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf, arm64: Force 8-byte alignment for JIT buffer to prevent atomic tearing
Date: Wed, 21 Oct 2026 13:17:42 -0400
Message-ID: <20261021171742.310-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fuad Tabba <tabba@google.com>

[ Upstream commit ef06fd16d48704eac868441d98d4ef083d8f3d07 ]

struct bpf_plt contains a u64 target field. Currently, the BPF JIT
allocator requests an alignment of 4 bytes (sizeof(u32)) for the JIT
buffer.

Because the base address of the JIT buffer can be 4-byte aligned (e.g.,
ending in 0x4 or 0xc), the relative padding logic in build_plt() fails
to ensure that target lands on an 8-byte boundary.

This leads to two issues:
1. UBSAN reports misaligned-access warnings when dereferencing the
   structure.
2. More critically, target is updated concurrently via WRITE_ONCE() in
   bpf_arch_text_poke() while the JIT'd code executes ldr. On arm64,
   64-bit loads/stores are only guaranteed to be single-copy atomic if
   they are 64-bit aligned. A misaligned target risks a torn read,
   causing the JIT to jump to a corrupted address.

Fix this by increasing the allocation alignment requirement to 8 bytes
(sizeof(u64)) in bpf_jit_binary_pack_alloc(). This anchors the base of
the JIT buffer to an 8-byte boundary, allowing the relative padding math
in build_plt() to correctly align the target field.

Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
Signed-off-by: Fuad Tabba <tabba@google.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20260226075525.233321-1-tabba@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
[ Backport to 6.6.y: Request eight-byte image alignment from
  bpf_jit_binary_alloc(); this target does not use the upstream pack
  allocator. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-23383 to 6.6.y.

The backport requests the same eight-byte JIT image alignment from the
older allocator. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: the ARM64 JIT
object with BPF_SYSCALL=y, BPF_JIT=y and WERROR=y; no runtime testing.

Thanks,
Artem Dinaburg

 arch/arm64/net/bpf_jit_comp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 9fd0b658e4602bec2be466665d880a355e5bac1a..c5f7276ad1af7e32b69eb9bb5c0f14c3feaa74e8 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1648,7 +1648,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
 	image_size = extable_offset + extable_size;
 	header = bpf_jit_binary_alloc(image_size, &image_ptr,
-				      sizeof(u32), jit_fill_hole);
+				      sizeof(u64), jit_fill_hole);
 	if (header == NULL) {
 		prog = orig_prog;
 		goto out_off;
