Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DD372B5F
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092529; cv=none; b=XPj2r61VqmKT6wXpdsNnOgYcfCKgxBWieLIfCxDulapumI4x2kBn/U6CFqIlynFhWTi5fkXWZ7fhjGmlQgiG2qy80L4Rce3GxXsGQgz1nd2Amdkb9IHGHHhzReeAO3skFa27nNbaNneD58OctzumJoxeDtIGWZYJq5DbV/OCqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092529; c=relaxed/simple;
	bh=WWoRQlnVSoM/Txr2XJcS8xWlmEru57uc31Q/owghoZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SUyyfmwIu4gQN+hsEyY0zncRS6HW23jGDDNahV0OWj93F8+GFg7RVu+AV3yb0I2MwWHGqCRu6SZt6YnaqKEtc12c1ho+dF0s3WPbXC2/g/cvw/zRPlmqF7czJ99BX02qyhWspBLVPnQdWoB7XllxDFkwD6ReknqzW38kpgt6s9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NC/oEqAL; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NC/oEqAL"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-65fbad80d95so312763a12.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 23:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772092526; x=1772697326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMHrV3EDqeB76tWITQKDIWbxOYh777AARVef/M6xYas=;
        b=NC/oEqALimixetXvUi1jlsHgKeuFCAIkb0YnCr7rQf2ZAZTbgaASJXox9w7ZVdzafN
         3K6ImDpy2IkZq6mNzGZeNY8knZGXG/tjttxrR5ozbMICrQG50ol2daxnoRC9IsndcnhP
         ecmxNokw64Voipdu0GPotTrP8+FuLM+5LY8bAd70u6tj8RLiA39/5EGQEZutcOaLYbQQ
         KEdzaiaA3hC3VYvju7NHzm3YvMStQzfmrjZk9diRHF/Gb2XZJyLnH56PHS61agrr1qj5
         1LCWKzFVnjp89uH+0KP8BkEo6HNHnoV3iv2n4yUU7sjuq4xZoEUbgQ8Plr4YQGrNuWZ1
         sA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092526; x=1772697326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMHrV3EDqeB76tWITQKDIWbxOYh777AARVef/M6xYas=;
        b=kdwDY1MfojS4bKRNyKkW2D369OVvuxxrijqeaIp8ovezeHojV15uCVg4idHW64bCaz
         qZC2EgKAR7xO1ooajdfR/Yv3zp5wfbk6dUwtP4eInVk14WPihUm3rbG+YpGRuQ9lYKW9
         Es+vHH3yrn/CtQIpzApiaI3yRe156abB0EBxNsSh7p8u+Bp5TNCEHskQ4VGCscifU6nJ
         klGfxdG7f2HreGoNd73VwNNYRxIIqWH26cHG09IzrKFGhpJAJ60A7i+d0AgcWaliqSqj
         Gx1Qby3/SqDdS6GNXGOI5CfYvtSWI+RNBPnMKW3W4fSAMmBwG1x2mEm/pirGyaGEyF8H
         TT0A==
X-Forwarded-Encrypted: i=1; AJvYcCXrroYJ2jdD8Tkh8d6S6OAFr7RE9Lb+s/rSDwL2e1keZ2ykQXjpLe6WahygiBKBo1kXbiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4aoL8MsunVc+kLhdIpcKgKYInFUpBA56qXxRfTu/LfhzjzBw
	c8nG0NY1G2t3D3AkA1D7Qhm8jDHsKC5IWk0TKIjxIONJmabTJdLR/Xc+0zkn9iTIOug0BGgAHg+
	0tg==
X-Received: from edty12.prod.google.com ([2002:aa7:cccc:0:b0:64b:8c7a:2c9c])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1453:b0:659:3ed2:13dd
 with SMTP id 4fb4d7f45d1cf-65fa47703a5mr2009610a12.4.1772092526117; Wed, 25
 Feb 2026 23:55:26 -0800 (PST)
Date: Thu, 26 Feb 2026 07:55:25 +0000
In-Reply-To: <8b7050b7-f2ad-4237-890c-76fc13dc0189@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8b7050b7-f2ad-4237-890c-76fc13dc0189@huaweicloud.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226075525.233321-1-tabba@google.com>
Subject: [PATCH v3] arm64: bpf: Force 8-byte alignment for JIT buffer to
 prevent atomic tearing
From: Fuad Tabba <tabba@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jean-Philippe Brucker <jpb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

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
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 356d33c7a4ae..adf84962d579 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2119,7 +2119,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
 	image_size = extable_offset + extable_size;
 	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
-					      sizeof(u32), &header, &image_ptr,
+					      sizeof(u64), &header, &image_ptr,
 					      jit_fill_hole);
 	if (!ro_header) {
 		prog = orig_prog;
-- 
2.53.0.414.gf7e9f6c205-goog

