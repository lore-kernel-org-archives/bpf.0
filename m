Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462284A92F3
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269069; cv=none; b=sq/nxUE8w9PH3zg67V2MEy15i1z3sqc0i3UWa7eQnN7ex5b0wEpp94fI1+FT/3P9lRSZfaAWFcBIPm8TyVf3G5n5dXWvAjabl49V9p+KW0GBSi5ru8yb/VOO4kJUD9ucCQvDsJ7K5prr9VyjAysurBAY9HijkLN7Fqo5GMzXnt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269069; c=relaxed/simple;
	bh=0ESDQBDfRXSZZH61vTmawj4Q3IFYsAcQw0JuSOssXgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9K+mVTxs30kKLtc0HX7Z7RPdZhXDjvBhihnnmHo04WxUGC30fXNFX5cMoeI/wLp4tgXg5cMLHb8j2a7zkVDiJe+QXgK7VtCwJGVf5058ONVx5QXtO6xcQd0xWYU7A4veNYTq9wdtaqfEiEXI+orXCU1yLxS0l1HrwWw3jdJVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyzdWD9b; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyzdWD9b"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48437576531so5208f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269065; x=1790873865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YruC7842uzBR/Kg+1Sr+RiRz1q0ty44zwjzCjfpv108=;
        b=QyzdWD9b+NmvLHxFZBN0t3QuAaiod9hYtwDcLdAyLH5Gxfig56bh9Bdd3Y58c4WqJr
         HV6GLYdpOVfyFbEuzBL1CcBh6zFQ1yqMKz1aiYj4YT1vr28Lczci0vUgohguQH54P5xe
         bTtClIfa1Qymteu3+RKn02PFyZg6JqW9oxchssz9vc/Fmak22GAagOIBld9lP2fgaKLT
         gCULUKUJfd4rYo+JQrK8Fxrup0b0QxuEKPR/pUnyRFDlvWJ0TGuRlzox+dx11+i16uKf
         hAgk/9alZx3PrbYwQSLh/PwsGbzYFWB8bWP79mpSFEs1q4GO8DYi3DaLAd9sMzlaV9El
         Zwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269065; x=1790873865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YruC7842uzBR/Kg+1Sr+RiRz1q0ty44zwjzCjfpv108=;
        b=wkACUj+zNiw8OlEfD1lOmKPxNzPkwbEijm1q1zUiOxLjI21Aopl4xpfxiohkG1/Ys4
         za68b4r38Rd7bzxGFuZxzVFjDfRYVPa4dtxKPbDo+wYqeABzYy9hmAOD2D25C1+G23d4
         vdAxiZ0PexpxqFA3J7wcPQYZMUbpqzX6rtDjzbxOxBt5wOjg+vrmwU9imdkRxQpRJl8F
         gP+/YM5M3SfJwL5HG/e0mWEuMos+p+pQkTa0HlCLimxKB0gqSxHCkcSVRYRfojOlhnFp
         /xZYB/Mo/uHBkXl/kiud+gZNbuPaK92fFRfYkp3EFioZTDLZNbQd3AgkBjrIIuNuXaRs
         L4PQ==
X-Gm-Message-State: AFuF++mx4cMX4QW5A4p9rqSNGX48h5t21NrcsWBGpUyGuvrYoDO1UbKE
	DTjAiuLeqHHrmrSA6M/JLzVTzkVJdUz6JqcQkzFrGJw+cf2DHmgrPSVrW9uMx9FH
X-Gm-Gg: AYBFou18kGNfzH71CnhHgoonauBMl9v4HYkhLSHvbh5eHvndJGsoUojIyRT2j7jeog6
	MrzfvQFOia38+c0y3GFdTWdM+mIZyHj7RLmjy4Q92PxMNtG3AQZUrsdAzGxyqRA5aphWLb/IE2t
	4qtm+eUbFnhPvWV0I3x2PeQbu3qz+KazIwwJxr6B/85MMhNfBrKuvrGiwRvI2HgBKEdEh6vuJ9F
	yiAD8VNyYQ/I4vPHe9TdS+XJjcjS1M2rERieLTB2o/QjZFGu2dgMN5KmC7fx2dUtWxDZz/IWBZ0
	lrW3pmE+yD0waP9HeEX81ZfCZRlQOCMTqXVewkoXeVhKUwu8yQexNic4av5DvF28u4tnTfM6aOK
	FGE1ACJRNKLYQjSe1s381lYL4+t2V/bARXyvLGrXsrIosDYejKGTotNxxtr8pxHAncsxzFbVMbK
	E2/OsbYB2dsA1fNg5VQNvWGypbYLkOhgyGNDBj9GhSsyjz8swnGEfbB8VkQryDM2PUKfVq6TflS
	yD9bOgMtsFKYHMXQuKJqDqbaat3cuZNor8pYn47Uf3luIfeSpGK77+MbLMT1OPxhkHRxZ1bxOu7
	GI6UjxQiuuzhJ/DEGw0ccYfuZdfqWbhfrLel2vln+M0fovpx
X-Received: by 2002:a05:6000:260a:b0:487:144:ee60 with SMTP id ffacd0b85a97d-48871725478mr5297854f8f.19.1790269065279;
        Thu, 24 Sep 2026 09:57:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm438958f8f.0.2026.09.24.09.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:57:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 02/18] bpf: Widen the stack slot index in the jump history
Date: Thu, 24 Sep 2026 18:57:03 +0200
Message-ID: <20260924165740.2146806-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=memxor@gmail.com; h=from:subject; bh=0ESDQBDfRXSZZH61vTmawj4Q3IFYsAcQw0JuSOssXgM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraJ6RTGtG2h+5VRwrMxe/qF+37lbYkc1JEseTvsue9 NYU0DzWUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImsN2T4K1Q5w2ez3C5N+Qes oux1hRIzjKbbCFXPDy1fec32RLZtLsN/9zr+DdVrnZplutjkXCtio8OkFbnZRAQffz1w8ZAYtw0 HAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Jump history entries record the stack slot touched by a spill or fill in
a 6-bit field, which only fits the 64 slots of a 512-byte frame and is
pinned to that size by a static_assert on MAX_BPF_STACK. Move the flags
into the first word and give the slot index 12 bits of the second word
instead, so the entry stays 16 bytes while frames of up to 32 KiB can
be recorded.

Introduce MAX_BPF_STACK_SLOTS for the number of 8-byte slots a frame can
have and use it for the static_assert and for BPF_ID_MAP_SIZE, so the
verifier expresses per-frame capacity through one constant.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6f47a3ccde86..b1e88016edb1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -243,6 +243,14 @@ enum bpf_stack_slot_type {
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
 
+/*
+ * Largest number of BPF_REG_SIZE stack slots a single frame can have. A frame
+ * may use any part of the MAX_BPF_STACK budget; check_max_stack_depth()
+ * enforces the bound on the combined depth of frames sharing the kernel stack
+ * and on each frame using a private stack.
+ */
+#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK / BPF_REG_SIZE)
+
 /* 4-byte stack slot granularity for liveness analysis */
 #define BPF_HALF_REG_SIZE	4
 #define STACK_SLOT_SZ		4
@@ -425,12 +433,11 @@ struct bpf_jmp_history_entry {
 	/* insn idx can't be bigger than 1 million */
 	u32 idx : 20;
 	u32 frame : 4;	/* stack access frame number */
-	u32 spi : 6;	/* stack slot index (0..63) */
-	u32 : 2;
-	u32 prev_idx : 20;
 	/* special INSN_F_xxx flags */
 	u32 flags : 4;
-	u32 : 8;
+	u32 : 4;
+	u32 prev_idx : 20;
+	u32 spi : 12;	/* stack slot index */
 	/*
 	 * additional registers that need precision tracking when this
 	 * jump is backtracked, vector of five 11-bit records
@@ -439,12 +446,12 @@ struct bpf_jmp_history_entry {
 };
 
 static_assert(MAX_CALL_FRAMES <= (1 << 4));
-static_assert(MAX_BPF_STACK / 8 <= (1 << 6));
+static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
 /* Maximum number of bpf_reg_state objects that can exist at once */
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
-#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE + \
-			  MAX_STACK_ARG_SLOTS) * MAX_CALL_FRAMES)
+#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
+			 MAX_CALL_FRAMES)
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
-- 
2.53.0

