Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983769;
	b=QTk0Uzmid56Ngt+ed0LFO3b8jCdxVKWRV75NoijoCa5nZwXTvibVb4GGaMdq07EbM4lE
	 yzkbSWM3kuLMVBVf2sTnJH1ybltqWDROgDfYgRKBxB4dP/nB0aF1a/dN97BgFe61c/1eG
	 0G34P8Pvc0OQWSLIXHefeef6Txa+vCa00EAmXeZzy4KA3O/V2DQlpUSjcyoPP5RUEEH/k
	 84ki5T9iOJL/2Zot7okzefWyJ9mbxfOjUgRWZjwEfuEYgbml3IL5Jbs+zLISDpM7vnxoV
	 Ohqw54FlDGjyGqcVY/QL/yxcTuFNzLKXliHXFKd/rd3oMuKXskr+n4mu6W3dw1deZNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O1ACOA+TRX2fthfuFKfYCBkx296setu6abs9DUXIDbg=;
	b=kx35qeOijt57dejsOrstyptqHL05MGKBYWLMjKfD2mHC7sAYiqjSa/ym5rBB5vUGFnqo
	 D8MJ9vzcjgS0yz/67K5l+EQxqQmO3FWcss/rQ/MSZl0wwkjhBBueMKKwyhekqI/Tkp0jQ
	 FfJdNQ39bgB/0FGFKrSZdi4VnRIbzoQHTmaxIeIbe+KcWTB0zSp5mdjF6AH6B32G+4x4l
	 LbzBxfOU7qmUZF6I7Fmoj6GOp8WhgAVz/orw4Q7fSs5xmgeqFRAdCltGymCKyC5Id69nC
	 7SOsuwGystt3moUvzJuQRYC+Z4niQ9s+E7oeETyDq459q89al4Muz7xl0nkyv4fYgtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E53ecHP4;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6C606A31E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E53ecHP4
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e5fb79ce82so15853615ad.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983769; x=1793588569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O1ACOA+TRX2fthfuFKfYCBkx296setu6abs9DUXIDbg=;
        b=E53ecHP4q7BFDFdeBDknQphhYHXcLDHHHiA6sxUATbLNX9i0/l9KAriuoCUoryak9v
         ULvTp58MD/IVJoA7EyyzQzIHjSEpxKXZqcQkw6lWTXRU9IOO6tFPEcdW/D9O3mKL52Na
         AvQv6VSvPesO41JIJbp6OdZbjyeB47e8u5sC+7Vth6n5YTMBRaLxN7Ob3kOIv13fYr1k
         MpbgGQsGsPhhLk5ap1RN5ZAKYb471oQEQrMQmPdeCl3plz72JSOwFnlO4ry9ltG67OYq
         pnSkIhMhVQUf27uF97bfacAxan8T28UqUF/np0H9pDogmtX/X9C/D8EHFTFAk4p5u5li
         G1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983769; x=1793588569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O1ACOA+TRX2fthfuFKfYCBkx296setu6abs9DUXIDbg=;
        b=lfNxjVuBKxNxqRlx8CirJznOBnU6wxMmngnZCy9A8qodxFhSebvMEM6F0Ahgi/ULBp
         trdebSTNM5sovJ8BZ9KuA51p/bprp38h9lYE56zzykOtss96nw+jYVie+2WjfViOiuH4
         NdbjMrDny3Fm1aqk9buCg7c3feLM6F4qRnk+L8Tm6GizOIM04s8FS17FrqDO6A+2w6c/
         voIx5ww5BTzxwKXXBWiU3BCjVQOnGLj76Xm/h1Q3aZF/JiJaU0YTuLXFK7QRx1IHkNDM
         WNOjyOH+HtrhMbWdFIflGMQtOZgH4CVoQiYwqFcyf9MFnKsbx8CqDb65aWeGczFxrFXS
         RUTA==
X-Gm-Message-State: AFq9FYLc6D49vvo4AwvQEbvTyd+SrvY97GqzJnGbUpb++npWorAWZJf8
	+hfXSUtn+dNXE6VR1FAWz7LX5wBr+3GhdM+mYGC8t4K6HJ6S/cFiqXhj1qnGHw==
X-Gm-Gg: AYBFou3uHPdrMEisQsKWbKMnKpvmNrRVjtegafr1R1kKOz0uCz2D0qzc6y402R586pr
	DARALFPF2fh2zLxU97X4HWESfSegUumDKRJ55t8tjKblnMniMEsEp4JsnbH96McLL72skF9t3Re
	jkX7CFBFAkQeg0s5pbDKmOCZY4cGSJdVmqy2pt+NQeC4FM0f4u2tVVIOkSX9gHn0TUCUSrEMRbM
	x6Q81wBPkKFSqQS8gJ0108pW2051gVGi0UkiwTkxwMt+kxwxDmAeHv+v4XQTErI6h0F+56jLcG/
	tzRQzgmzYICZGA9XAGYa4Pql0Ash5FURlNUHgAlSjx6rsw2x1YAxBcgDmW5mv9Gf/PEznv00lvG
	rJSkgx0FuWTHt35ZWoYQeiFh1YhcJUbDbW2PKKSzmjgth1vjWZDQWZqBPXnhO/ZVL2CdfXgfpKR
	wuyk3x3DlGRai2ZLbtp98BEfH573QvEmSeujiJCr2XysxYpKUiiS94j5JVgsKzMP/BBCS9wSDfj
	HzD/4QrYOVpvvAT241vDLEMILITdGdTWfAXnkbLJO3kuwtsFv7lXSKnzhTvAueiZ9oQMHgGKcF+
	b/knlkZwORUR5BnKzOdOrfhvHw02wxpIu7ho6BNfbMPGL1mRlh7dKIGRt47Fz4RDHJ6+YGwevS5
	cMU+BBSmQjZmBSG08Ruw017O9vRECUnTcNDUtqA3o67knHQ==
X-Received: by 2002:a17:90b:17c9:b0:3ab:9f89:e1b3 with SMTP id 98e67ed59e1d1-3adeafc1f30mr4556832a91.40.1792983768522;
        Sun, 25 Oct 2026 20:02:48 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb82761esm4755001a91.0.2026.10.25.20.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 31/81] bpf: Add bpf_alloc() and bpf_free() kfuncs
Date: Mon, 26 Oct 2026 02:58:52 +0000
Message-ID: <20261026025943.404450-32-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

This patch is a placeholder to start the discussion about the allocator for
Rust. It is not for merging as is.

Rust needs a global allocator for Box, Vec and BTreeMap:

  fn bpf_alloc(size: u64, flags: u64) -> *mut u8;
  fn bpf_free(ptr: *mut u8);

This is the simplest implementation on top of the pages of arena. Each
allocation gets full pages. A header of 16 bytes before the memory holds
the number of pages. The prog can write to the header. Then bpf_free()
frees other pages of the same arena, and nothing else.

The problems of this implementation:
 - A small allocation uses a full page.
 - bpf_free() only queues the pages, and a worker frees them later. Thus a
   loop of bpf_alloc() and bpf_free() can use all of the arena.
 - Each bpf_free() causes a TLB flush on all cpus.

The cost of an allocation of 16 bytes on x86-64 (Zen 5), in nsec:

                                        alloc    free
  bpf_alloc() and bpf_free()              250    780
  page_frag allocator written in BPF        3    7 to 8

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c6c13dfa1102..d6c0d816849c 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -1385,6 +1385,62 @@ __bpf_kfunc u64 bpf_arena_memcpy(void *dst__arena, const void *src__arena, u64 s
 	memmove(dst__arena, src__arena, span);
 	return span;
 }
+
+/* bpf_alloc() keeps the number of pages in front of the memory it returns */
+#define ARENA_ALLOC_HDR	16
+
+/**
+ * bpf_alloc() - Allocate memory in arena of the program
+ * @size: The number of bytes
+ * @flags: Must be 0
+ * @aux: Implicit argument, set by the verifier
+ *
+ * The memory is zeroed and aligned to 16 bytes. Every allocation takes
+ * whole pages.
+ *
+ * Return: The address of the memory in arena or NULL.
+ */
+__bpf_kfunc void *bpf_alloc(u64 size, u64 flags, struct bpf_prog_aux *aux)
+{
+	struct bpf_arena *arena = aux->arena;
+	u64 page_cnt;
+	long uaddr;
+
+	if (!arena || flags || !size || size > SZ_4G)
+		return NULL;
+
+	page_cnt = DIV_ROUND_UP(size + ARENA_ALLOC_HDR, PAGE_SIZE);
+	uaddr = arena_alloc_pages(arena, 0, page_cnt, NUMA_NO_NODE, false);
+	if (!uaddr)
+		return NULL;
+
+	WRITE_ONCE(*(u64 *)(long)(bpf_arena_get_kern_vm_start(arena) + (u32)uaddr), page_cnt);
+	return (void *)(uaddr + ARENA_ALLOC_HDR);
+}
+
+/**
+ * bpf_free() - Free memory allocated by bpf_alloc()
+ * @ptr__arena__nullable: The address that bpf_alloc() returned or NULL
+ * @aux: Implicit argument, set by the verifier
+ *
+ * The program can write to the header that bpf_alloc() left. Then pages
+ * of arena that the header tells about are freed, nothing else.
+ */
+__bpf_kfunc void bpf_free(void *ptr__arena__nullable, struct bpf_prog_aux *aux)
+{
+	u64 *hdr;
+	u64 off;
+
+	if (!ptr__arena__nullable)
+		return;
+
+	hdr = ptr__arena__nullable - ARENA_ALLOC_HDR;
+	off = (u64)(long)hdr - bpf_arena_get_kern_vm_start(aux->arena);
+	if (off >= SZ_4G || (off & ~PAGE_MASK))
+		return;
+
+	arena_free_pages(aux->arena, off, (u32)READ_ONCE(*hdr), false);
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
@@ -1393,6 +1449,8 @@ BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_arena_memcmp, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_arena_memcpy, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_alloc, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_free, KF_IMPLICIT_ARGS)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.55.0

