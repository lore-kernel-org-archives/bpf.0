Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834099;
	b=nIOkhGJtHAdMeIB91quZhdysV22pPyYBAcfZ1nG+jTuak0aN4NjnJBlnADaDxVq7A28A
	 Hza5ETp8f2MYPyGVT+uy2vp+XIkHLYixzWA01kwI6POYnaJDC9sWff0kg/r3T5Chl7DRJ
	 bXYRzRDBTp5rBZ8UIUDgC//lAVLUV8lq69eC2StUTSYbQ0PRtT1WNze9jGGuhIyvQSyyF
	 YbUWESxullPhCSu048M3whjiBR6G5MYRgsaCBnoLfkjWrV/z2DkHbYKWtb/+0B9gaFOBc
	 57zgiYbZJP2o+8+9bDgu8bmOI8W2AWDZkFNT+fxSftGo1imcOXW7s+7zZBDzLaqq4WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=64Kmwjd4qcYgR0POkFaJ2RJup2bAmi9Lok2+15Er75w=;
	b=uarc7ngO4qkd+l6HmTZ8B6eAwIJ38OxbEQg6nv65X9smfzxosCsi50QvwLFx2VLVMJy1
	 nWeKNrjjoy0rELIGl9C413IRjPn3bsu59h/n0HC3uBAxBn27SyCeTxulr8blP1ViBKJkB
	 tEerMdrPqd8AC619OXSACZ8NNDf7c7UwP7R3Sbh8vS+rmqqFdLk4M5kLl9mZCwzqIjfJo
	 TyF+N3rnGYaMXwORv6tvwyx4aVwm1+thudpNdB2xiNYj9WorVFqtXmrlOJrqCzPzhDPg3
	 aFsSrf/51WZ/e+BSH0iE5qSfTHVLg/3IEVBX0BVQ+b1qwD3BIvCMahaLabfITB5ccuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="C5/RMUaE";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327D606BF35
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 09:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4327D606BF35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C5/RMUaE
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-353804b591eso2790169eec.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792834098; x=1793438898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64Kmwjd4qcYgR0POkFaJ2RJup2bAmi9Lok2+15Er75w=;
        b=C5/RMUaE2YPhsn4PJiAKT/SVNqQ9rE4NfM1j0lrb6VAkEQ/GHd+yqTuZDjShe6G7XW
         SJFEoDDWzMk0YVHPN7ILJkvxekfzh05lvR5nQkkdLdu9+AClxHsRjDqWERlI9KWgw3i3
         Gphv74TM17r1F6HB6euLEd0ZwSBCdUu4gd+9/EBd3QZXqiVt/BlkxqsuLwIoH7mzvVfE
         OXdnqbhDTLHB4njOiA/G/cEkFzTtm1czufx0rwCNUJtccJRRvOE7C4D2mAgZR9doMsuA
         wFv78n0MaJ9b09kjf+r5yQ2udXYn37hNBHx2EhiRQhNpPvA03az5BrOQOdEvc492jhmF
         nyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792834098; x=1793438898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=64Kmwjd4qcYgR0POkFaJ2RJup2bAmi9Lok2+15Er75w=;
        b=Djr1U2oirnM5bnnQtZ+SM+/azPFdAT1+pjjkehcdVswflX5fZxZtD/90PSW3B+02JY
         UeohvnR5LtoEhdTi/Mqs7fIgCuYkN00uouvwDswb3Lskj6SXo5HwzrAbzBjZsfPjF1gQ
         pSjDbN91OVm2mbGoUoy9GQMP3KGm6vZ4ApupNwYD/4GlIL6ZMvvopW78qb4bFljrhB1D
         DvsZF7SbVzW0KROTqj/3cNNKH9mY6mIiWYf4WEbrdMw6ejSpdDbeoMjfCULpiMCsr18j
         EFBkcezTQMkNhD6tUYOGHeo5JdBvUMIG4MztA4Qbz87mM3Q5Oo5kL5hKVbSm2KJJW4yS
         R5Qw==
X-Gm-Message-State: AFq9FYLoJbAg6Vx49qCb+vhS9VEl8kGc68fHklZ8+zySVYuCPRwEScar
	845X7YJ7sTSGF2FnDd7Awer12bQ5TPtStLg97g3rkfSNOF/iqZS7gi1JlT/96N+X
X-Gm-Gg: AYBFou0LhXzQ0sfl4wanduPBW4Rfupqs+imQLmo/SYkfy0HJrxjSKSKiNcUNhLQKpAy
	Ybam3/hX6ogAX3n9XCFD4cFfO6utLVM6Bahpjq27M1CF/js5YpotzY5SAR79089ir9vZJfPPMEP
	w0AQWL/OZlqYQCciOVygDGjOnXXq2XGJ4rmVTKx7fyiM93OMGYfMIy9zMDu+8INNaxGFlFuw5aF
	p4MWTp+xFVhU5SI4aeB0vKkw0SRLTxGQtXSSaefPIr7DLGfPHrAxgffrImsYFV+BDQQQq6bHP7O
	MQpZADW4kyLCclc76jEHOEjslfkM0Atu3onohg6sJFQKd5EaALPOkWkrD95l2AaN+BvQIpkKoWD
	qgYZ+pjGbCMaXzKrTp+5JDa0Qx7fUmaHluu/KrnBd5YDIwr3tvMXvQ92m822/nFFCDW5vCwBiQ+
	FpJKH/Pvi/aHMwxVIAdcfJU5Ozrk8ACxBfTdGXpqZb6jrPVqgmaQ9TwIw/9Z0qra0zOEOtbuF9o
	4sY3M7Gj8U6jZwG3MUn8ifOITCxzV74A2GxUOrBiY24uHdyOs1XbnaPxUtDAVJ4HAa4VMwZl0+r
	JOP8xt7suhhNU23K3SDX1vi0CHP635kG91e63tjWnBbgplEihPTdzTt8gEIXH+/YxKEcSJP6hw=
	=
X-Received: by 2002:a05:7301:a10:b0:369:4c3f:8a0 with SMTP id 5a478bee46e88-369e84aba41mr2187644eec.19.1792834098277;
        Sat, 24 Oct 2026 02:28:18 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:e1f8:b9bb:b037:3cab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm5236604eec.18.2026.10.24.02.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:28:17 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/3] bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet
Date: Sat, 24 Oct 2026 14:56:57 +0530
Message-ID: <20261024092659.76422-3-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024092659.76422-1-ayushmanrout27@gmail.com>
References: <20261024092659.76422-1-ayushmanrout27@gmail.com>
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

When neither dynptr can be sliced, which happens when both ranges cross
a segment boundary, bpf_dynptr_copy() copies through a 256 byte stack
buffer. It copies the chunks from the start to the end.

If both dynptrs point into the same packet, the ranges overlap and the
destination is above the source, a chunk written to the destination can
overwrite source bytes that a later chunk has not read yet.

Example: a 1200 byte copy with the destination 100 bytes above the
source. The first chunk writes source bytes 100..355, so the second
chunk reads bytes 256..355 after they were overwritten.

In that case, copy the chunks from the end to the start. This only
applies when src->data == dst->data and the destination is above the
source. All other copies stay as they are.

The selftests added later in this series fail without this patch.

Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
Assisted-by: LLM
---
 kernel/bpf/helpers.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..8eb600cc9d12 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3293,6 +3293,7 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 	const struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
 	void *src_slice, *dst_slice;
 	char buf[256];
+	bool rev;
 	u64 off;
 
 	src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
@@ -3313,15 +3314,17 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 	    bpf_dynptr_check_off_len(src, src_off, size))
 		return -E2BIG;
 
+	rev = src->data == dst->data && dst->offset + dst_off > src->offset + src_off;
 	off = 0;
 	while (off < size) {
 		u64 chunk_sz = min_t(u64, sizeof(buf), size - off);
+		u64 pos = rev ? size - off - chunk_sz : off;
 		int err;
 
-		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
+		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + pos, 0);
 		if (err)
 			return err;
-		err = __bpf_dynptr_write(dst, dst_off + off, buf, chunk_sz, 0);
+		err = __bpf_dynptr_write(dst, dst_off + pos, buf, chunk_sz, 0);
 		if (err)
 			return err;
 
-- 
2.54.0

