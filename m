Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7F5650F1
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190716; cv=none; b=XZB/UAq4fZwbj3rDKuZ1lUI5MNdR3Pw1QIN1f2bAk/Tl0Tc6rsG6cA42MYlCS3RZVZCokLJOfTYdsmp3+Z4wo6dr96EVmoLuyErBd3C6LwN/D2CqwEOd5MYt7DMquy6HKnC24LKVJYL17IoEYJSmkdphVk7tCOgSpk2IN5RUKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190716; c=relaxed/simple;
	bh=P2m3sFD/nnHd6R++jZHlINNVU2fhep0mcLp7/16E0ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/4WxaF0FbNz8hkk+vdvi8heIS5xYcQ6XJ74oWb8iH3N2cPZ14Fymq00JAfvyllyuoQTp0v/e8BNpjyhVmFGcQNdh5llUnPe5ZW5D44hMXcM4aVgyte00uo0l/usZh2TEACrvbxYMzMl0iOGdCxNkxof+YDRu0nYOi7S4M0lTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0luEgTS; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0luEgTS"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so578196f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190713; x=1790795513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WL9rZdCk5Sc9TTT152+kql/Hi4Wy/KN4YVYdUsyX16k=;
        b=k0luEgTSMBPfwpIjsh3SHOA0hjXSnRNyxFmhNR0nR7b80X4AdPxeTOy3S7yvUTIoDh
         BBHGeovhF+o2pVub5ltXGkXThXhWK0kj2xnP4eJ9ZykC005y6AZxGB+ZaQXbdA06MGoa
         JPsxBzrzdzf1BPSJ4vsrGDHNET/Lk9N22N3eLcAZVyzpSDcPfzzJFY/qmnHf7f6NoXc/
         ouPTcxsZ3u8VQGJeDv2q6x61RcONbdRAn0cM1QVbnR5OwawwNVXvBI9ZKFAFTsJIeh72
         pFejxkO5By2sZa3PLkVO9mFZTGOUMRzwwcvHzX9UxFWMKk1Ln6t9bNQ8pgWVMDKZXW2V
         43ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190713; x=1790795513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WL9rZdCk5Sc9TTT152+kql/Hi4Wy/KN4YVYdUsyX16k=;
        b=fEY7FJy31FexMmpKmUoVFQ2EyOl4SEZ/Tmu8glm50Z65g2gGuMj74BqKMBzgNrlFlk
         DBNi1BDXMBjzaa+ippIZ+UZXDVnIAwn4a72scgAyblL2Be5hSJ+diRmvVtB05xuzBYb2
         DAgIMo7EKMBLeYmqhfz037uXfl8FglSrWgETvF4zMk5rXj3OVjhiWVfacNX3XsymMBUT
         NzgU7VgC70Fugndm6XKdd0+4xYpc2ycaa208GXoXEtaDtgxksK/48uSnMzSFlym9HbxY
         Wdknvvv0wqdGXKkgS5UNV4vGbPJzU9V8Hl5F5bSqUz03vBxdYRiMm+RQvnsZ/X8nx9a/
         Db8Q==
X-Gm-Message-State: AFuF++nIWv3dD1lq+96r/UmmLsn11FPefbllWyucNPfT5idvEh5/D29c
	Z4rWM/BZiIrmK/7JlxdMsECIvqg4hv9SJEUAIJY4A28YDKf0LifaW2gImjfDRd+R
X-Gm-Gg: AYBFou2UsMdCflR5pP8Wv0R2f27qHhOruy/oZGqBLx8Nm4G0ol4MvqCIubAwLrCcC0i
	Trk+9RFm5b1w7o6QN+NGRv8oGhZqTBDm+y6DqcGCBf1oB06Pxig/bojyJEW9tH3ttvPTIQfiV77
	8KuoFqWj7YQ4b7LP+F/iO/2mCniIgE+UCWMYjlGsXosX302uY3KXNflto/THRxyyog1kUAJ9ddP
	P2Q1I3+szQhL8tklRWo2/UixxYxMoLJSp+EdAnjU2wn42IyEXVnDOjcqKhvQQtAZowhC4m1mj8a
	6Z3/u3bv2FTaZ0zlKr9N2NNx8FVh2GR5Y4asGPNY+nlz/QJlsOYilqzbDRYZnfDjPWTgHaLaQJA
	QfipI4tbRvBi+ixuoF/OG9Qaq4MGOcE+Uw5gz74oZvLm+kFwUdbTxB8z3AfH2E9rDmo0tcPtQ7p
	7yAk8iPs1Tfljf57ylX781R+HpQCPEI+nPsGbgB+MnlkDfqvqnnwCXJMxaoFEfvRbZ0QamP+lRm
	Ky1R9cSUW50OSYRsagT3lZG7QfqpZcN3CZLqTUFzwBtUwZViFJjeAR/2HxZ0MhiQT3K7qwzqdhc
	Vkg7lZAYiwpUUr4fqvgL1E6dbLpz6hilCxdddg==
X-Received: by 2002:a05:6000:230d:b0:487:36b:1816 with SMTP id ffacd0b85a97d-488716b3281mr236932f8f.7.1790190713248;
        Wed, 23 Sep 2026 12:11:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684863d9sm8903864f8f.12.2026.09.23.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 06/18] bpf: Treat unknown-size stack reads as reaching the frame top
Date: Wed, 23 Sep 2026 21:11:13 +0200
Message-ID: <20260923191139.2816206-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=memxor@gmail.com; h=from:subject; bh=P2m3sFD/nnHd6R++jZHlINNVU2fhep0mcLp7/16E0ko=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4tdLc/8yiBvI6WXeT97mti9KWVhkzzaD/HkSRTMrX pY4Zzt0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIKNQz/dH4EZayN9pvQpVyn 7qN8PujV9g1rUu7G75p8PmHJw/CQFEaGHeK23964GO59+CNGWe7P7IrjuS3Ggb47Ap8+KJ+8R3w WIwA=
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
index a66f1688407c..d8f43f3a8991 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13894,11 +13894,11 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
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
@@ -13984,7 +13984,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
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

