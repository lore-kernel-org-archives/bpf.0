Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33038237A
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200860; cv=none; b=n6r12rKA+IWpuiHGaWngRDLbX3E6YE5ekspzLS162cLc3MRdu/NeXcKc1dNv3tv5F48rUmiqEkXVWF9z7yGZMSvI3x4HhPz8FJDBmVIsDphM00+JUG6nTflCiigJEollhn5VBzYsCnJWmC0HsQSz0B/Cm9HNDm2HcRJyIMrAPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200860; c=relaxed/simple;
	bh=aTaSwBXiFPJGfMOKORCSl0P+VYBCDi5c6LtT14QZFGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA46g9U1wGLfD/I57uM8g5SVneBWZAtz7SRjQZWo2YbwmnfnkV16DnBOWwlNjUWScdOxRMIX7n6o5oxCVZw6ZZ42LGzBaJv/wE5kATnkV+L4Dl461xSE12lYlbKmCcSMDrBCe0GpWgGY4mMX8Dwy2mEKsvHQafLWvEb6MetAtLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO82XsB4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO82XsB4"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1065966a91.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200856; x=1792805656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uSZz9osrcHkbeopspOUDH6W8q4pgQ/Sm9caGkNs5pPU=;
        b=hO82XsB4FE6as2PKDeHqyAXy2ZyG52ao75iAKITzZlzPa9U6TCJXeINN+Mk+xYvcfE
         G2twXAiWXM+67lCSHuOAz6IQVnIjL6+cH6qAOMjKQGCqrA/i4mt0P6dOW80ac9ES+EII
         3PWqRVXM0jueVr4Fq11UaUDx2PYbId0v1Tu+h8LNmqO6qoL/8bS8010Ag/qhkiEzR6bf
         w6HFdgJlOWH/ce6Wogs+gp666b8qcbAyZWwwPiIlMbERxblWe5pSeuJpjbSBv2SJpGmM
         Wzr0w8z/4b0XivjGtBOmG2EglcK2MUf0CypLsXUoMPZPSSbNanSys8U24J7iIIML5Q0M
         KHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200856; x=1792805656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uSZz9osrcHkbeopspOUDH6W8q4pgQ/Sm9caGkNs5pPU=;
        b=H88IOR9pFGlUpJkZwANPI0VJlxur7LBMsaVxSuGe2mqJcbjLMZawvYPEkpsrqUYPP6
         cWx2RXxAYPp/e7FIB15PvTduG15f0uiXW8NG89gOGmBmfPoZ1oWrBgrF3phsI9oxijH/
         MRIg1cv/e9s7DvcYd5sirrP4z377nLkT4WyFeqtVweWAl5e8RId5uvXB2J74xZDzua7u
         wwAKjIi1sCa75n4sBdrM3Ee4y6Oxi9bA5IraUcS9vQN6g4Ww9AopD+fhXUW15VGeuR8m
         WXkxMRkmLKXVp5SjFht3M9tIkxF/pjU0pD+A+7eNC1kARHYyCWTBliwPtENUzjQD2fXk
         JqaA==
X-Gm-Message-State: AFq9FYLJVMKpoaKpMtRcCH7N8nq07ztftNwCxd1l4i4IdE7DY2Dwc2br
	CSl/aehFUEXX/veQbPRH27UXC7ppa/mLu6vzmDS8LBpstmw9akCgCMJ/J2aI5Bby
X-Gm-Gg: AYBFou2kr1kUNN5y8CBV5nvKf/Qzdh7Rdkrnkr45ww4P/Mn6eEiJbRvEQJ52akiS5uY
	OcEZHDS7m3xv2iQbFAqlJd/Nk2t17k+oz/e6vbxZBPrPq77ySCbbBuCNN2Nk25xmuHlrRYuXB1E
	LnfaBNvqRLlYZH8YBCcG3S0zq0pMMmqDd2CixWYAQBMWDGraDQ6JaOVdbBKimy1WBTp9x8FECaJ
	nfRNn6Vsv5Ah2fzn49XDcAv3IZYJMV/HR5jLqpu/Va4JQOKyg0TZWpn4HYy9zz5B+2DToL5kleG
	iZZUhm6BY2mWbwlD3tSw6cBww5jNHHqKpFWShLR5SY4WwPmzqceJ6xMPi67gaysCh50qZcJ6KGt
	if5WDPOP7mQAWijquFl0cVF6z/sQ3tolXnUN7hJYmuqIR8Ui9ok8Esxz1YERNeHBlbcVre2659I
	geIbv0rt9M83OYBYXxH+y5/c+HLh7vAXOiglmctmKyOLAJ8brlEJP9W3Ibsbxr/yfJqXaPDPvXy
	+f14aSCknly5tfSmAuLY/JrN1v12+fillsTtS3LcLkkCgwIlKcN8EPll7TZghTO9iVhKr6fcWTz
	sO5vSZxNMPiGSOQo6y1f0m9n/MDrbcTE+NBxFCfWZj67lg9Ee7chYQ==
X-Received: by 2002:a17:90b:2f07:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3acef55d707mr927516a91.37.1792200855783;
        Fri, 16 Oct 2026 18:34:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ebe40sm6304979a91.6.2026.10.16.18.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:34:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 35/38] bpf: Don't take a dynptr argument for a local dynptr
Date: Sat, 17 Oct 2026 01:24:48 +0000
Message-ID: <20261017012451.364800-27-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A global function is verified on its own. A dynptr which it gets as an
argument is assumed to be of type BPF_DYNPTR_TYPE_LOCAL, but the callers
may pass one of any type, that of an skb for example.

The type decides whether a write through the dynptr invalidates packet
pointers, and whether a slice of it is invalidated together with them.
Inside of the function neither happens. It can take a packet pointer from
its context argument, or a slice from the dynptr, write through the dynptr
and go on using the pointer, although the write may have reallocated the
head of the skb.

Report such a dynptr as that of an skb to whoever asks for the type of the
argument of a call. The type in the register stays as it is, nothing
becomes forbidden for the dynptr itself. A clone inherits the caution.

Fixes: a64bfe618665 ("bpf: add support for passing dynptr pointer to global subprog")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e002728abd04..03b19829f27a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8416,6 +8416,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
 			       struct bpf_call_arg_meta *meta)
 {
+	bool is_arg = reg->type == CONST_PTR_TO_DYNPTR;
 	int spi, err = 0;
 
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
@@ -8502,7 +8503,12 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			reg = &bpf_stack_slot(state, spi)->spilled_ptr;
 		}
 
-		meta->dynptr.type = reg->dynptr.type;
+		/*
+		 * The callers of a global function may hand in a dynptr of any
+		 * type. Take it for that of an skb, so that a write through it
+		 * and its slices are treated with care.
+		 */
+		meta->dynptr.type = is_arg ? BPF_DYNPTR_TYPE_SKB : reg->dynptr.type;
 		meta->dynptr.id = reg->id;
 		meta->dynptr.parent_id = reg->parent_id;
 	}
-- 
2.55.0

