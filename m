Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8995328AD
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190709; cv=none; b=d3f61R6NpUoyehVDSujcDNaCBY8+xosH6ogdQU7osMyxbQ7ouxjG1p2Qrz2vACKTridRUhuCcqwF+++ebaXw0ACSmoTWgTtPwzYB6y6tfmx4t7SsQqYSW848ayhyYbUoBd0IL3LUd9MjElQ6I5tjpgB5i0oGneyan15aEbARW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190709; c=relaxed/simple;
	bh=YsaXVuWFzVdH4R7CpK/TNxOX6xP3adSZLquic/EznZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btfMa7owKsjrjZCAd6rJvq9stvPpbvGnpvTRjiA0+UMWEQHU74MEnLAjXrtPf7yu/RH4ESO4Y1dewtRdqBmg1Re4HHG82gkkktcVTrMZ4C/1CE/gU1qy/ZZbHFZXMThYNRD5O61E8mHMXcqmKT5wQ+k1V7RuixIDlDFRAqpAUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQuSiMKM; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQuSiMKM"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4843147998cso54195f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190705; x=1790795505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoLIbkiEqwoQ67Df9ssfLSqnnsuughpEtt998ehDZfA=;
        b=AQuSiMKMfgnl1sciRFOExKq6nnexerbKjcfmBWyR8jmZpa/S+zykeVXTAQJkUHRQbM
         QM3Lt1Ak+ttJksOlxNXkZKfaKfEoWHg87JSxb1GIOa8aojU+wSC/neUsMOGNWFk8EycH
         k2hdIp/h84/w27C6ZmWJhLxIxba0DbOOQ0Tu1keTTqOz2YLaIAKrjdHQRPAYvT4NnAYj
         QhUSGlJHSy3n1B1uB66r7fdJY3mRg0XlMMIA6OVRRzZs2O9jnODBjOPrKOnmtBtfFp7X
         uS7eU5r18RsGQkW7JecQLmeGqfBAtIuR3aV2x+rKzsKFeGjHitMXnBeyZJ0TdpZKvWm4
         l06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190705; x=1790795505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoLIbkiEqwoQ67Df9ssfLSqnnsuughpEtt998ehDZfA=;
        b=sZpH5iK4949idFBTOd+9zvTzSNtDJJPPn3/Ws0zV03RwSVTtrUoArCTW2VoSkt7VGg
         hbn5Pw2iiTgsW5Y79C+gvJ3da1PzpAxOmT5E9tH8AUKeUTYO6Knhlp+tXU1g95mmO+5U
         mTUI1G7vgtKwHG+vVYGVfmyiwuadVu7rhDV30SZ+SLQzHXKtoJk4rCGudCK+j7qDDxT5
         Wyy1oDwRykcB6QEq2P4UnlWAPo/dhu/UyM0e8dL19PXiw58gO4TM8GZ0moULwk9oeMtE
         FmJ9W1e6kEBQkUYldEzSBBexfuw1PVC7XnU2ZCsQjrRWVgMLOuJSC00giD/5yPqxUwMt
         Zxug==
X-Gm-Message-State: AFuF++lX1ZZzDX06RosWEcxDP27vLMQZHQ5aI4Uf04/GOiY1+p+28ksu
	1pvyb082FsgWmYmeVUIEFQm7CuwMAI0jS5GLMSKR+I4mTR03qv8QDmayF0zrVMgo
X-Gm-Gg: AYBFou3WIM7i+kNP2rckMFd/qiFd2rUTKBOEmZe+IuU/FG5p01JImxl0C+SSDOyLCqs
	r/zvk6Z0V+AWYl+VdtBqnwwxxHiQJIEmkPLC1No7hdN/+sozqa8bsdUWuvKeBtD8N6Qb80cjVyT
	yPn8xwiBohkswbNVF3irTfRdPyE2dGQ+HJhzdP2+QV7bpZ3X2+QLRUn+EBOvpXzFXQT9q650OGF
	BteYNkOhftxBRVfZpTwpcryfSFEUF3Ttw7Pw4uCbHdCA3C1S9XuN1BwGbu0bcjswohXgqokAMCZ
	hmgdaQD1vefopNLKU0VHcgT4fBfCf1I4K97jD98NyMlVeuyx+olY2LO3BChHXe7a1JOjyUCL4lN
	UxMwNtmc2c0MHHrrg5e2lEXLw2/lDWYcCm+Mymngw8MR0hEHxEP8057VLql9qCWVgqV17TV7OcI
	5MH9T4zAe+1BrPFJcCTauarwEn1xsqwzR40DaifEpfaWnBKruVMY4DOEik4uGLao9m2gvWMhXKs
	JvgzgIGw2hYe5fPn6ppo1OKCVIWeu8KSbfohZF850ymWXtafjWD93aaLNnbOs0K8RUGOzIOUUMo
	APciLRNM92u3T7xwK9j5bb6E4Z7mFWqzRaeDAQ==
X-Received: by 2002:a05:600c:1f83:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fe66c8087mr2937845e9.3.1790190705372;
        Wed, 23 Sep 2026 12:11:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe1432362sm44685145e9.1.2026.09.23.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 02/18] bpf: Widen the stack slot index in the jump history
Date: Wed, 23 Sep 2026 21:11:09 +0200
Message-ID: <20260923191139.2816206-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=memxor@gmail.com; h=from:subject; bh=YsaXVuWFzVdH4R7CpK/TNxOX6xP3adSZLquic/EznZc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4hejx88dptoIXO5esj3ssGyfir0UxxIug6DCe3l7N wU9nnCqo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABN5q8Lwm+VvmoiB65QTukul Yu7tFIp/6Rz3pShHRC+VbxPLqc03TjIy7NsaaHis83D65LoXfKLnxO/tV9+sv8xMSXZxuUnD370 q7AA=
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
index 36e0c6b97533..b1c0f981fe68 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -242,6 +242,14 @@ enum bpf_stack_slot_type {
 
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
@@ -424,12 +432,11 @@ struct bpf_jmp_history_entry {
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
@@ -438,12 +445,12 @@ struct bpf_jmp_history_entry {
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

