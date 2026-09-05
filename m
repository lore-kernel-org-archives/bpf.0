Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1F190462
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566779; cv=none; b=hU7ggx41JPlwgzpi9aIxporQ2ibYMlMrBgKCExQDEjHow2bYt73eH+qxta842tjbeb1ihox0S6iMhDHKMOwZcqpa6Nt6f/y8SKsxw/iBXEkTbv2Mv6V9upz76dNUu+ABuqc55wvXXkjkcRcsJmgokGb3RxK8gvhubMFSQ7J0bdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566779; c=relaxed/simple;
	bh=Dk50IKCC/oMjLnABy3/dUsgLUiS5wf8h5/Hcr99VgfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEej7x7qX/eLe3R8X5Aq4EWipHxEwHJdsFqOX00P5cKLTOHzZE5SObVYxBV4m1Z29tN+zyAzg5rbWOy5Q4OEDmd64zZ+x3917/uv95cs9KQMVcI5Xs/3Wqm7aajVF2Mxtz0MpXlbw8uE1YVQA7u8DAbRlWWxJhhvYimY6HPE4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij3B2hXn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij3B2hXn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d72ae08fa1so15322675ad.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566777; x=1789171577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGGayUq1fHfFb7U9tjVKRyLypA43Uc0Cqzaq25U4zSk=;
        b=ij3B2hXnDzas6b7X/PtuZQuA50kWIogm4AmqFt8nKgpSytw69Hs/hr/RlHKUR6WyAt
         XJtwDMPXyAsKWfbIzuobFbLfnEWyEL3eecvK812iHtZcTvn5OjjY5RbmysfV/UxUxeI6
         nfauac98nTUI3hKg/LmTzi1mFZQmH4Ggpo3cVlLFH19NW+LbwFGb39yDeKUyV9SAleQX
         G2FkI+kN6pi8P9BhOJIQjtHURO/7vORltKJ6OV28+ffKnJ5iGufnDoRbZEs0twmNASl5
         wIKDDuG0UNKmdYqRuhaTlM415eoRc0RVxFx2rGU1IrN0rwS0DaiPT9co0B4IOjyt1DIE
         /Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566777; x=1789171577;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGGayUq1fHfFb7U9tjVKRyLypA43Uc0Cqzaq25U4zSk=;
        b=VzXTVj7Bu4DaCMLmK2ZkwVpdoz0L1TTgfiwhhucnqEjgBMThXPID35G72CRQ991O9h
         I85SdCD2bLOyqO4eMtfezeJ/0N4yyRmHBMGCLLugbyqUCbgMUKwtMQ1ABllXw04Ho399
         Vp+LJGF7VmU9SAwryuS2VAEZzEjzA2Oif1C3BvsuWs2EYA3pugJmRRlO/eNVRg8RaEqL
         Cdaw2Q4RKJMfbBqi/jx/1ACvxdHTorzUJs95nAHMP+Y3LOfJB9FnD2YfT78+XBqdDvrs
         v+oxm1c/MasnQDzI65h3Eb32/1ICTZLDlobhPOGqA150qGWFrjq2GuSpw1xldfusqQIo
         wl5A==
X-Gm-Message-State: AFuF++nDQ3JwIDSb1VlvHZo8zWL7AzWiHFg3TQwXTH3KUkumthKNv1Iw
	gjqZfQCVhRXVZBA8nGc0AwWdK/RYnS9MVlB/HWpVaIDenlXff/2H9pFS7PTWiMtEIR0=
X-Gm-Gg: AYBFou2jlp9V9NC1zqtWOIkYdLPgy4TIXfr5dQ48Xva4OO5OHsDtgOpb2EK3yOO4rGd
	n1S1SiW4JzLkAV1oIvf4xh1akkzTSiJCS4qb8b0uMRIlTXMxSu1ne8cQqnESFsuaHtMpekfWHH4
	Y9F3zYtvVH0tFwJUSSXVjiWjt95ba1mVNb1tJVAfDWEpwnBVL9ev0ISdbSJ3YxIYrBoTkCLRn7h
	kiTESSx0dqSyOJ6a+16IwROTdVIO6c1wmaNs8f30LAaMOSj0ODclDXnmCOvbkn1/g1jobVKCUhz
	vSCH2DZH/egTerp8yRI3StFni6bLib45Iqp+BzU0uUcehSNbt6CO+KmVuJMjNUoe/ytW0n2L/TA
	x80Mp4S1Xb8J+ERj5PYFy0YGWcotNdAyPSeNYpHr/TOrVRfWQr4Ago8KM/CYuG9dcdXN6aq6GE5
	k8K9HWsRxd6oSuc6RL+zoKwtxXy9jirzyS1ikBi6/Bt+gXCf8MdyhEw3joXgrzJ63vw65FiOOaw
	oQ7jslyv5NcC94Tj9fZwGPW10BTzgoLCSmPdioGPkoiJQ==
X-Received: by 2002:a17:902:d987:b0:2db:257c:9fd5 with SMTP id d9443c01a7336-2db257ca020mr55609135ad.16.1788566776914;
        Fri, 04 Sep 2026 17:06:16 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:16 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 02/10] selftests/bpf: precision of a NULL helper argument
Date: Fri,  4 Sep 2026 17:05:53 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-2-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Check that mark_chain_precision() is called for a NULL nullable memory
argument and for the zero flags argument of bpf_get_local_storage().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_cgroup_storage.c  | 29 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_precision.c       | 34 ++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c b/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
index 9a13f5c11ac7..884080a5bffc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
@@ -305,4 +305,33 @@ __naked void cpu_cgroup_storage_access_6(void)
 	: __clobber_all);
 }
 
+/*
+ * Verification takes two paths: with r2 being scalar zero on path (1)
+ * and with r2 being some other scalar on path (2).
+ * Check that the verifier does not use checkpoints created
+ * on path (1) to prune path (2).
+ */
+SEC("cgroup/skb")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("get_local_storage() doesn't support non-zero flags")
+__naked void non_zero_flags_on_a_pruned_path(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	/* r2 is 0 on the path explored first, 1 on the other */\
+	r2 = 1;						\
+	if r0 == 0 goto 1f;				\
+	r2 = 0;						\
+1:	r1 = %[cgroup_storage] ll;			\
+	call %[bpf_get_local_storage];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_get_local_storage),
+	  __imm_addr(cgroup_storage)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 6f325876efdd..3e290b07f672 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -642,4 +642,38 @@ __naked int bpf_atomic_cmpxchg_32bit_precision(void)
 	: __clobber_all);
 }
 
+/*
+ * Verification takes two paths: with r1 being scalar zero on path (1)
+ * and with r1 being some other scalar on path (2).
+ * Check that the verifier does not use checkpoints created
+ * on path (1) to prune path (2).
+ */
+SEC("?tc")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("R1 type=scalar expected=fp")
+__naked int null_mem_arg_zero_size(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 = 42;"
+		"if r0 > 42 goto 1f;"
+		"r1 = 0;"
+	"1:"
+		"r2 = 0;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"r5 = 0;"
+		/*
+		 * ARG_PTR_TO_MEM | PTR_MAYBE_NULL parameter can be NULL,
+		 * but can't be some other scalar value.
+		 */
+		"call %[bpf_csum_diff];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_csum_diff)
+		: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.55.0
