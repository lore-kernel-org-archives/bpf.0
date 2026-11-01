Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559969;
	b=bIYym2Rb/8z0n4ak9Ao2/nM0hPuVeLm6dJjcdUgAmFz8mEX3+1lsm6sq1rhZ1u2ot6zg
	 9aH032lMYJbXeIe0Z91VMgU+mD/90jAPwBo6+bsQMcozPBAXwgu2akVpqa5XirAGmcrw9
	 TbddDSLf6bDI3kfJF6Hnn3hFETpMJ+tzIoKSlLGpBAGu3E9VrC+8vGxsAFd/jJJlIlwTy
	 woR2HMVm29FmlZRHR9Rf25hEPGlLsosqX7tlxP+f2caBkRx1g239GrPd3fzNY4Rrh0TSh
	 zb7GrC+gfdnMqAU74tUWF96Uj2BHrcu0yzNRjuz9exceo/yn2QnbbSRwzBswl8/MbMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M92D0oaLFXe3ISp0B/6fuOAUn1w++UPKBGzm+YeQP7I=;
	b=Vq/CBhfLeywHQLQPgZ133EaR40NdnAcEuu+h0fR8tisj9X1nqxb00r+lQFeFc15E6eip
	 3gonuR/cf8oW7HFFoDv56PZqppV3ldtiC0oPV6H27pL2/K5B9y6wr3tA+oovksdL0+Zff
	 U/Fi6TLzsRIESq/rzUGmyPT6UY55/Y3wePc5iUA5HliF+kvUi/lqO8TFHe3MDLNNOiWIh
	 9c0ckboKJEt3nXe67pwsD1Om4hKiitZvncSB3FqdPgNTS4wZmqqitz2XQ/1WYKykTAVjA
	 kq2eNyq943TYbN8flYev1pZooX3FRJkM0kZH486h20mbGnrfLbAzIJRC7ZNXRQ+4d7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nxl/5xth";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62F606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A62F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nxl/5xth
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so776654a12.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559969; x=1794164769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M92D0oaLFXe3ISp0B/6fuOAUn1w++UPKBGzm+YeQP7I=;
        b=nxl/5xthgg0w5npd4lHvSSM8fhMi7K1ZX49keEuVom4+wET5EIPKCAqQZFJYWJSpen
         N9nilKp9gLife4t/pMZB1cPP2DhexRjjyB2zXYL+wlWoTRKsAoEOKcjpBopCd3RRejr7
         Mvi0evL1CE2xRED9kL1bd1UelHWF6OgZ+Tw1xDV2lJqFalOiykR1q02OuVK4FkcLKphV
         kbkTB1UOBdUiffdcsFCcbXOAffO6JgopwSwViPVq+H8zIKgkakxxlhdKEGloUVUAjYyj
         AUORNj8uTgh0ymoinrLtdY0moEkWXCoahCC3Eyo4Qk0k8jj3yhDYKOqHj42DYKn37XBF
         /v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559969; x=1794164769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M92D0oaLFXe3ISp0B/6fuOAUn1w++UPKBGzm+YeQP7I=;
        b=jn61253LhdCOOwC5yXLKT47IBn+A1oL2ExMcpfZYVLrRcFIhWpV2MJVKJjBQKlGgwM
         JHPIsZh02jfIblUuzWpAkI0jBxBj68UYBwx5M5cSGtO0Ky0kXgmmrnVCdpc+FTpZyHVH
         S0WGZfdJtIcp3T2vcZBJW+yNYokdZlmHsCtnPA0chWipW37BOostsyLcAJ3ClyTXiv8T
         LJ9BsdfGf01yoBTREEZRy2tW8jQVa9zhLqZn5+Y5T5Tdzpduo1VovmeSW+wfc/3WDzbO
         KDZWbRiIfVWnFm0b58kfpqxqudXUgerLV92D+9XdLA6akWioTtC36XfAbzWZo85FpE4s
         XI6w==
X-Gm-Message-State: APuU4Z+3T97Ti3Zq9KTZ9NPyaeOekYAKfUinvU7ZQvLcRY/sWY1btRQT
	PynlRqz5n/5prR5KeRTFxlnPtonTQv/tigLS8dme/4Luc31o6rAKlfGPyhECsA==
X-Gm-Gg: AYBFou0IsXUlk7BLOLT5NQcGO4TAfZuPqsPv9KxjkrbctaXMP2p4fuwzluUtYHn5amz
	pzfaM1xQ1AKEysphDZ4GNTdKS5esFD3HVtgn4LZIeUB99di6VfgY4iqj6i0gTVbVUwZW/vHGz+H
	6DPgNmy7ezkumqN/GsDRG8CeyTZZ62a+VKZmYnKSN1v9I8i5AmSaJP1ubkuQ1MHC4wmdaB/tvuR
	CKJtFNy0OUAShXWlhEZlRArFwFzdNYhvABuBTpMEiiItFKmphG91/wvKN3f7VGy8u4KSre+DK20
	o1yT63+5VS+dYWIZSVBjqZlyqJ3d3CnwuqrtDkQ7QyPe78R+gSQ2VwWc5DWHG4+1q/a5H/G5i0b
	2ylFhDHgZCzkZGE5GKa8YomhE1dZFlMNghLISK3om9o4q7/1VU8MdjeLuApU0O3s9RCViHUSvbi
	6QiSH76WiYNmUIofdU310UlnYe9DTnMgpK/l/HcfV4wCneoEHuJPM4cb6Yl9VL1Bb4ZQN+y7m0z
	McvL/FsvnY4Abht6egaXjR9pvPVh2lfPwQAKW747IFBe5hrtyaEZfI4o9pLew32DstWJAiD15Yo
	bHT3d3DWr3Deb22PMZ1jbCxSWgzCHe3phRiyr7y1iAzd/qzn9NaBaa2hcq0TZq7ib0f8bKI+u8o
	UjgFaegpIawlxz8ifuOkOO/Jdzr7BWAMQx9CUcabjanfxELPWPqNt9EYWpnf34XVIMOre+svlCw
	dFGfk6m+udlnX92EBAMOE=
X-Received: by 2002:a17:90b:4a02:b0:3ac:6fcf:81a2 with SMTP id 98e67ed59e1d1-3ae89821660mr6006321a91.57.1793559968690;
        Sun, 01 Nov 2026 11:06:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm15778671a91.1.2026.11.01.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 05/27] bpf: Refuse an arena mmap() longer than max_entries pages
Date: Sun,  1 Nov 2026 19:05:13 +0000
Message-ID: <20261101190535.1454146-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

arena_map_alloc() puts max_entries free pages in the range tree of an
arena. But the arena kfuncs check their arguments against user_vm_start and
user_vm_end. Without map_extra, arena_map_mmap() takes both from the first
vma. This vma can be up to 4 GiB long. Then arena_free_pages() also marks
pages as free that were never in the range tree. Thus max_entries does not
limit the memory of the arena, but these pages are inside kern_vm.

Refuse an mmap() longer than max_entries pages with -E2BIG. With map_extra
this limit exists already. libbpf always maps max_entries pages. Replace
both SZ_4G checks with this limit, because it is at most 4 GiB.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index e331130662be..c35b82f44f66 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -634,7 +634,7 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 
 	if (pgoff)
 		return -EINVAL;
-	if (len > SZ_4G)
+	if (len > (u64)map->max_entries * PAGE_SIZE)
 		return -E2BIG;
 
 	/* if user_vm_start was specified at arena creation time */
@@ -682,7 +682,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 		return -EBUSY;
 
 	/* Earlier checks should prevent this */
-	if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > SZ_4G || vma->vm_pgoff))
+	if (WARN_ON_ONCE(vma_pages(vma) > map->max_entries || vma->vm_pgoff))
 		return -EFAULT;
 
 	if (remember_vma(arena, vma))
-- 
2.55.0

