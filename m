Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DB426EB2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238383; cv=none; b=ZiDrNnpPYgEYIIdAQ0rdd+PQYWVkAD/su55fE1qcDz4btnd7LxGKAzTMpLkSFHUeWzX+5HxUnXWtMIkKaydlaQgRqGSedbbSlHJ8fh3+jpzNAHS5zFxsCwmQgF6us3Xyp70oFv5B5YWMv/be46KA7le4wWfMhfRy6X4PY6exbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238383; c=relaxed/simple;
	bh=GW7GMDBQ5Qken6g1nF56AQpuH8eRYs5NQwIqnMqlH60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPoVdtwPL+KxIt73tOnAlI+uOb9p8CToU0gNymbUca1KHMzswAhqNc91LhpwNHlS2920WJHf8pYs7JcsOSOCZkw4vc1tR6HKeGx88f8Xql+Lmo3s3/q4YhDwMjQLfFMZq1gXtrtHg/OO9Vzaola7xfG4oNyQqXBdoIYEeqIvqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTBzHBAm; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTBzHBAm"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe4ca1052so2119805e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238380; x=1790843180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ghZRCdQuXk2lzUzZs1aPjhJu769WxQwHh1zxmSDhl0=;
        b=LTBzHBAm5cHmVAv7jeQ02Q7+Czxika6qgj5ThuoEr4WNGKXaiCNr4xXlJdTKdvbHA9
         B50fbAnr42lePoBJZJzuhx5gUheJpJO6RtpHfl6C0U+0GcEOq4uCqOkWe7fPAg9il/bK
         cxIf96IQxeEuSxHpE//PRBMd4O6zp8jXVPDyVvjvjPJiCIGdXvNnHZF1Ez+dlOKS573c
         m9oz3O7Iz8OYgyQTnIgq6XF1xw7c3dJZZ+918X382mVC+qGroGaGVK005l1LpRBxu1LR
         86v+Dpmc/OeIkYJDXu6u1tYVCV2FTjf5v7sZWM1BtpPJerq0JbOSmIi6ptJfO04iIKu3
         ShXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238380; x=1790843180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ghZRCdQuXk2lzUzZs1aPjhJu769WxQwHh1zxmSDhl0=;
        b=bt7TdN2ne8EMXSOEOJjc751rLROZlgJBmzOnCgkedysf7vRqtZ0pzIWZTbQwTqbw2P
         /vtgdFgaqAowPfkYfKqLQjIPyEXzvEh34bHll+weMpRjFaTfC6zFzxmQgvFejXkklAth
         MtEFcG+EN/ofFBoUlBFQMSdkeFXwf6tKI8deVDm3FMpxZsNaZ6L+/6KzkWui5oUJVT/g
         RDgC8rEu8dhen+oDPV1FCSjv/tUM7NYyiqre+M7lDVxCUaLsi/GnidiKzs1vwuGD4cwG
         p7U7SNxaTWAZDnIpZLsq+0apVAflNsFTF4WCQwUXY0oPgd6NIkFA26q45/thZ1VhSURA
         zajw==
X-Gm-Message-State: AFuF++m/m0DR/AO7b3gVzycX9tr+qgM+5tRpXfHcM+5Cy+Ts/aa5RG+K
	53oHyxEs4ApDgC8R4RC7iQch+4lsLgWQpJ1hLIkvzNDcoPPbjGiC3G5ZIBnGgu4N
X-Gm-Gg: AYBFou2uyljyC07cLuOctb0NLhxgJKjr6S/RM2JXYu4/ToRn9yIfdNaGEGzqcGPbeZ8
	G5AA9+8tMfHcur3FZWKMTqKK6hLZTUcDZaXUjXY2WAyx/AvxOSZMf3+IvUQrVwzO+GxwUAAZ0/I
	T9bs5Gmf29vTdnucdhqbT+rqBg1Pi5QdDbMnGtmVCpkR/TKgWdoMLhI27p5yfl9zgszhTOZmZ5Z
	nrSGtnoGs9wIfk6MIDbwLyDWAZSIfy4by/k6R8tnhuk+TvIEC2gt7aXPaH68uDXWQDEFF4UJMek
	5VBGR0vhjsUdJDHotpqlktl19DeQVOE54U3t8w6+eVrV7q2lU5F4272QP3x+aHbji92xn0E/MYy
	IXUDCSbovTrLKNjm4Ne6aVVD27LuD14zih9gvqj35PaUHOHr+Rt4DVHqWXuePBtUoyskRvyRSqQ
	tyIGaEzbs/xDls5zm/dp0KhkFKus6JKk8LqPuBBC4gbURcz8q8s899eDLF2zzCJf1F8ralOsA7J
	GgwMDGhxyPdNosRUY4H/yZ+LlkJvIP+akompG33pRBMathvhfUbyJangsCUuwyCOP9WLdcuB98Z
	2oC0lCI018zBEwjl/tnw7h2Ymb8lOff5EOp1LpQuFXPYJwyp
X-Received: by 2002:a05:600c:3510:b0:49c:fa20:cbfb with SMTP id 5b1f17b1804b1-49fe66eaae4mr27458335e9.18.1790238379926;
        Thu, 24 Sep 2026 01:26:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm62225275e9.3.2026.09.24.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 06/18] bpf: Treat unknown-size stack reads as reaching the frame top
Date: Thu, 24 Sep 2026 10:25:42 +0200
Message-ID: <20260924082607.2695649-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=memxor@gmail.com; h=from:subject; bh=GW7GMDBQ5Qken6g1nF56AQpuH8eRYs5NQwIqnMqlH60=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvSTjaxbaJxdbV8en1YQvFS7kV4hZsf8r98NP+Z8sl 6rM+Pmto5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPx0mb4K/TkpEjPtC1SL9Kv 9Sje6wv6e6RGvDbyX9nXqdaP/PJsFzH89/gYpP18xj2PSceuJQr8UslZdOt0M+Ob5L0G6rapv2U +MwMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When the size of a helper or kfunc memory argument is not a constant on
the path, the stack liveness analysis is told the call reads
MAX_BPF_STACK bytes starting at the pointer's offset. Clipped at the
top of the frame this covers everything from the offset upwards, which
is the intent, but only as long as no frame is deeper than
MAX_BPF_STACK bytes.

Return the "unknown" marker instead, which the liveness analysis already
turns into a read of every slot between the offset and the frame top,
independent of how deep the frame is.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6e2db8e5de2a..8b7f2c283e5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14352,11 +14352,11 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			}
 			/*
 			 * Size arg is const on each path but differs across merged
-			 * paths. MAX_BPF_STACK is a safe upper bound for reads.
+			 * paths. Reads may extend anywhere up to the frame top.
 			 */
 			if (full_write)
 				return 0;
-			return MAX_BPF_STACK;
+			return S64_MIN;
 		}
 		return S64_MIN;
 	case ARG_PTR_TO_DYNPTR:
@@ -14442,7 +14442,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 			size = (s64)aux->const_reg_vals[size_reg];
 			goto out;
 		}
-		return MAX_BPF_STACK;
+		/* Unknown size: the read may extend anywhere up to the frame top. */
+		return S64_MIN;
 	}
 
 	/* fixed-size pointed-to type: resolve via BTF */
-- 
2.53.0

