Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE01E520A
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255302; cv=none; b=NB3D7tY/v4GnGUfVR0rcAZQzj/Pmwq5H2rNNxNhnpme+WK69CBK8kMEbw0KJnkS478TzzjL19prRWH4awR0ziqPxBYfwN30Qbio9N0xrEOwibG688nkypv07UVGYs3gRsbK4g2V0jaoMwY/Skk5ei8mNBHgia1IPwxj07QuuuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255302; c=relaxed/simple;
	bh=tJigTw0JH8PMkS+hFVeAA3nZT+Ia4ZT+mat4RhnpN/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey1xlxMlB3VWc1XFQ4SJxoviE+SRnGLk1UqYyRnbT8EclgpQlIOhtl5dugZOT7mQEVdE/yKiJmv9ALNfE8Hdt01gi/9S+TWJ9x96uS63LJ4ZFuE+XizdaHVpgajSayp0oB8H1563/yDGNaIlfTbFUwnHUwM8WcVB0z4Up1pTFS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3gZZSoA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3gZZSoA"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a706146559so708313a91.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255301; x=1792860101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFKA1h6lBnJi01euuLf1SIEyyzMcQm/kiIVNIE10hfU=;
        b=Q3gZZSoAoiryygmvXMeoO6i8Q7nWpfZX8YwLINhQEzoCDFkYOoke8+RqwuOJ/WLuFL
         /eiAI8OA2BTHE6yXEb7b7cNies2iX0QTEh6HMgPUXcKyrv6do1STEHW1hOtdWnqrwDs9
         PoB+sTFIJgbwfIdGEaxK4dUXHEhaAzZBJM12s8OGUfxgIQPppSXgoZb/PY6DlJr/SA+k
         ZyuXr+7czGh3cHaZ7Omx22tdlYn+6c2Sk14ifciRSrQe08pf5HnNs6XCkbfd3hdP4dJS
         WqbmqoLSGwp13GjdaQsYXzLW0z/IJ5V1r5gldHLReixWhuRtGjoa627CapLJ2nIxzBXM
         ImFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255301; x=1792860101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zFKA1h6lBnJi01euuLf1SIEyyzMcQm/kiIVNIE10hfU=;
        b=Zd9TpfM1XqP+VjjsKN7uMutyKzceBBtbKf2RkqBsRX5Q9ws/1Ll3uBNFKQKZwC+Lix
         OrwaRNAg+ZtmxRDafFZHoaSEGVXyF7xAU3YWhPKtGcVIbmmKbz6862zEn9Hv/gyQwdWa
         GTOIK7M0er7CwkCCywmOYK9fo1FXcINv0D47j/Nt/6JmUTwPcp2KkiVaCpAwts0Oyf66
         SI9+CtfcN7ZK5ZXzmIywLkkgg4VeFRY1M4QYW03/2o38YItes7anoTBohCWByyKir/7c
         dYc3CT7lLjRzcLS3+vShwwrEkWaThzRSO67q+tp8KS/Ura2JNFh1te6KAK/pkCPk9WDy
         Fb+A==
X-Gm-Message-State: AFq9FYJyTow38/G2q4FCsnlxbfJa96y/VgyGhSakcRfSrZTm/5a0hYSO
	db66PdmqjJGE9ttw593hJg2RuRJdOUmUZ281UWlIHaBJWzHGKXLjlrjE8zH/DA==
X-Gm-Gg: AYBFou3I5OfAP1vnRHQbcPIsJTRLxnDdWUdRKe9EwmeXuzyelgBLR/9+Mi3uifK4IGS
	uWGASsFWNPlE0n805lqiGSV95xg9dy19gJzqZkGFZQJ1b6aJrk0sIEh815ONdrKAetn77nxZY9x
	GqBq2YtvmCqSZmgpaw1F5LeRed/Ve+RkZSp9JtxF5sbIwiq4UtjVAqTsUD4IWG0gsOm5DLT+Drp
	CPMOZHhmaFrWZPJ2/hemjgOfsZ0g9kU4s5RAZcR4/g9imIMtn4NrMMafsMlEk0TKFxj++UCNVxt
	60ct0KclKGqxCX2ValxwDAyxqSJ+ZiefyZLVqvInDmqnezoQfp2djH09HeRzuZ5BImF9WYgFZ7H
	Xb8dxOuu/bGmjwLwfJYQR0+MDTr5x8des5/80TDDC1HYJj/mMtquclSpCGMHAL1o4BwWCHPNVIV
	Om+m0EcNVR3Z0uwGOZvCnPjNe5wiV4LNoQqylZ21AJYiokqcSi/SIrt7uHLSyZm2wENkMUth5TE
	x9cSWMJ+AjO0YQpworHDnYj4IG0UR80CS5+kK5FBAou/xpnHb4G631/xICV78CIy4iSGpN2jMxw
	3GgVw1L2qYUTr1Cj2DyTWIiIfjzTMKamjWFTPVwx1f5vHUafJSO70MI=
X-Received: by 2002:a17:90b:2e90:b0:3ac:8ee9:c8ed with SMTP id 98e67ed59e1d1-3acef101ea9mr2886999a91.13.1792255301041;
        Sat, 17 Oct 2026 09:41:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487e509sm8699361a91.9.2026.10.17.09.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 38/43] bpf: Don't take a dynptr argument for a local dynptr
Date: Sat, 17 Oct 2026 16:37:40 +0000
Message-ID: <20261017163745.3341787-39-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
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
index 597302cf7086..d384b9ec3d93 100644
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

