Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F324330B22
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473138; cv=none; b=cuCmL5erlkheLFjZX0BXKx/uerp+JY2dOCJgcn02kRHBLQS+qGpXn+QtoMgUWXpAiGPdlw9d2goOddmMOeodvjly0m0tP4qASdDYsWKt3Mq6Sv0+6CSISIssiwWy5D9esnwzstTP+VZNnnhxxgM2iK8shraspM52p1rE28iNdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473138; c=relaxed/simple;
	bh=IF4KA0Mvq+5L9IJ07tIVqZX99ud5VV8hLozJb4M5UQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCpIAgEBxTy8diUKnesb52otslCWG09biTdxkIxI63HnsBkFjS06SswxCeiEvHseo5QbQQcW8grF9zfbI2fNhp1m8xX0YErJoE1+yd9w15FR9cMZoogM1kFjlkkqqIZxFkjPalg5c9HNq4AzbLSoh3kAo3FEcJrwX0FO9tnMDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFw8FDIT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFw8FDIT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so2705325e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473136; x=1775077936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8lrkJsI7aJNEpeY2Gnscrm3wUa+iUWTpcYPWT4v/lM=;
        b=iFw8FDIT6PIzainiG/xoAJMidmLu4qNjGfJPXx0wXtmjIfAyOxCUGw1+MBYtmm5Vq9
         TJPiRO+SYcSuoXoZe2G/s2kFRu1kTTOZsGC4HOrUb8Nbq8cLDBJi8zNl1/ZGfikSsWN5
         7lFPXNUm4akJV9no0iu/Fsdelt2WbboNH84ibpUGTJ+knkgSkbdeH+kGqQJnQzlZ+xaj
         NjOcuUpnBHAJ1aid8AigbD1VBJ04xAZv9flemx76J+T6Igx7M3jnE4MNE9PRGkO8XeJQ
         XqIUiJCuVnx0mWnGFOMyTc7lRz8DpaKEGv5lJ6y2Av/liLS5DrTqdqG55iM4qTvFV3IA
         7eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473136; x=1775077936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8lrkJsI7aJNEpeY2Gnscrm3wUa+iUWTpcYPWT4v/lM=;
        b=PODqgsUkghfpniXj1dE+Gh1VbuEKWyK150g4c3NuI5L4phVXf6XhOvfWL7LceO03yP
         5ngYRD/9GxrOvWNQEW12A8iU7jrARxb+1ZDJZiTj70aCKaUuYrHpIbyNTW41thOTl2iK
         Pb8DEkoVft+NbIvSVPvOIlPJCDZrVxRKeSYGG8KiVtFJxpqrOPnxgDzUl5ekSg4N6DFP
         hAjDHICxm5YEo/5bqX/HVJPe3bim3NZRRmB0ixKk9fuEN9nn3sc0RBuRd1AEPiDHSnWP
         SflY6bJCye4vipszewav3vHES0eJ8BS6cgPttvjRErqkNR48P5P0JNuDLeRHgMJHujk0
         wf0Q==
X-Gm-Message-State: AOJu0YxsL1oYIyASfifsQ4n3WFknd7oC5uFFGXz1AWdtmoP/JzJnMQ6F
	i3cAlajlJp8hmbS5yijIV/O5TDkiFKn/Sl32oYkxCtKx9vZbASUR7qAC
X-Gm-Gg: ATEYQzyIrW90vc5/ia/J9F2b2dg/k1yW9PRKKfUyG4UcJVfCd8v/VV1sOA6V3FPeof6
	SwdX0oHZj2PNFVU8bN+oKdO9LO3yF3PomeXdf1w2pcBcUq4ISUqN96Cc321unZ7EGQVKj50zC1z
	Mh9TdTpf+g+b9tDPCIRCsGryjplI6SoSW4tp9vITG3U/FJdSJfZEoBBJJO5Mys5fKJN8s0kfEa3
	kfQBq8AzbWXs71/K/bguhvdFXgeoHoMDPpu1KgbyhMoK+T9ux6c/62aPIakYzVTvMpYmTQCQrZT
	MazG47rNbFgHSLd7zwmhxTLpLy6ec/CRXxwTwq/3Iv9sGzj7Aj+T36Uo2iqur9XgVkDKxw5gIZ1
	weBN63z/cBtxFAyK0gMLycbS38Z/r8IoMcG1p4OyEj3UeHGyTMsMY7+1HnblQp7U/eupmhF4P8s
	l44w0aVaCG9mRD
X-Received: by 2002:a05:600c:524b:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-48715fea90amr79115165e9.11.1774473135508;
        Wed, 25 Mar 2026 14:12:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb4bf57sm4407955e9.0.2026.03.25.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:12:14 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Mar 2026 14:11:55 -0700
Subject: [PATCH 2/2] bpf: Migrate dynptr file to kmalloc_nolock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-kmalloc_special-v1-2-269666afb1ea@meta.com>
References: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com>
In-Reply-To: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774473130; l=1580;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Kk6kZbtQgLcY62heetG1+4JoLdQz080DI0Odld8eGtM=;
 b=dnFLfEEWLEavPpES9wKrWaShjvllvZLm67TcVGXeKcrTq0lG8Iq4fr0i1UvjFBq3pXRNZRYQ6
 HprgVhqYDMnAsAdQa7o5uG0PlroxfOnmtuGp0xF7drT54eR0ZRcscdx
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_rcu for
bpf_dynptr_file_impl, continuing the migration away from bpf_mem_alloc
now that kmalloc can be used from NMI context.

freader_cleanup() runs before kfree_rcu() while the dynptr still holds
exclusive access. kfree_rcu() then defers the actual free until after
a grace period.

Add struct rcu_head to bpf_dynptr_file_impl for kfree_rcu().
---
 kernel/bpf/helpers.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b197b6978f1a..b349c8a34e50 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1736,7 +1736,10 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 };
 
 struct bpf_dynptr_file_impl {
-	struct freader freader;
+	union {
+		struct freader freader;
+		struct rcu_head rcu;
+	};
 	/* 64 bit offset and size overriding 32 bit ones in bpf_dynptr_kern */
 	u64 offset;
 	u64 size;
@@ -4427,7 +4430,7 @@ static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
 		return -EINVAL;
 	}
 
-	state = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_file_impl));
+	state = kmalloc_nolock(sizeof(*state), 0, NUMA_NO_NODE);
 	if (!state) {
 		bpf_dynptr_set_null(ptr);
 		return -ENOMEM;
@@ -4459,7 +4462,7 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 		return 0;
 
 	freader_cleanup(&df->freader);
-	bpf_mem_free(&bpf_global_ma, df);
+	kfree_rcu(df, rcu);
 	bpf_dynptr_set_null(ptr);
 	return 0;
 }

-- 
2.52.0

