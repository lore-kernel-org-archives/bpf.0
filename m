Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B5449B2C
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380310; cv=none; b=jjY8AcvV3mm+DrblBKLVc3nCzbEHe601NfohL5bx64mNtWfYDzQOPB7Rld99xg3ntxQE/sRtG1uXEj/RVIUy6wpuHfnibCLW0DBUjAA2C5yWBXJcHU2R70mSa4SdmrTzNT6hJ7eNs4XkzDZ/+CK2Z3h3FxpNduUl7E01jg/Gdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380310; c=relaxed/simple;
	bh=tzw+aCcv3UQYtzkDQiX9ynkaGvSmqn6LNADjaXtYzwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiTfMhevoNyiD+MmUlZKB8b6au/+MMPeEYeFE1n+XCJsbfB4Cksm+5eg2chyREmgV27L2j+y1AT0eFmKc65wt/WXyky2lJDXHXcZoBIXSud5dFN7PQ2hePcarxTQCWEyrZUiRi9pWt/237w6Q1WL5bSldXZfEj6wt4jTVjbJR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGXXHvCK; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGXXHvCK"
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-47bb3ddaaf6so1036986fac.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380308; x=1792985108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kh+n6U5ggjpSUBE8mowdMoP3nwWk+nABuZj9uU6qz8c=;
        b=BGXXHvCKg+haOi0jHenrCvxMLnfgDQCumHKA6InaZSlpUFH7PcfZmdnuR0RRd72zUz
         IyjpLcoqEPkpshchK9THSVsO2juInwTxrelOxbRy0maYN7NzQNPJkRQrNShao4ST3mmr
         B54SuJ0YOqM2v+eNAnd9s+NQQ2RTpWrc/83uc9pgKHmrWk2Po7IDXokFPAcUbWxlpxHr
         yQM5jx/D/FWdi1fMtj89JD7v33mRC8BssLWtwMdfIf+DVcsIlPTOxkXaTy4Z8BmOs/fG
         C+PX4K1bO9nV+muBx8d7e7Wi0WXivZL66VQx36rVFqlZsFMfIGk/7z5reH4OcYL5d18T
         olKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380308; x=1792985108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kh+n6U5ggjpSUBE8mowdMoP3nwWk+nABuZj9uU6qz8c=;
        b=UoG8p156dbbSzz1e8B5rSKK8qix1A0E0t5N9x2YAVvLBTapwIhzK5tvD7CtZLeJdQd
         9gCyBfnWX3bjioorCHXJZNXyn/yAUG4t+wWLVVYgyVSO03dmoRB9K6olUoWnEw+T6mYx
         Qpv5hFE/d+ZsWM8kEX73s9Fr++KDe440vwrOrcnlSp2CSNc7XCvOTyEuvfIQkdGUcVZ5
         C6TRN5JUD979uTTXOeYCA4qg0vOfoBuf7Mm7BuNjjr55ckt/vjEvpCjN/AmvgEzZK4b8
         fyfY+w6k/ckMx+Lj2lBDycAKF1ev61UJWyX4WAz4SH/Kt5a17QuaoIQuoyuFg9g00r5i
         LBHw==
X-Gm-Message-State: AFq9FYIBAw8XC5d9zYNsmaMJxzjJOfCkFgTyt0ndpEem7DPBOqjxva5N
	TjaY07Buba9pKKWlM4abY62q0bQJsLlCe3rbfFbD8xp6dzc5/ngjTVpoOENYTmhBIlg=
X-Gm-Gg: AYBFou33lissbY7mskMGzRW/cfylGPlKAsJ0lkycbHMQwn0T9A2Uk3F6+3P9OrC+DgD
	+ANdwGqnoRK3uu0PAsy1gm9Dr4h8SkKpmY9CFWagfqm41GVX/zwqziLkgh0f+9jdabQmUHnLZPu
	c+hlqLYwUZKdZHnw4v/Z/hGLBrTO8d4zaoiVY+LEonTh2dyHYWUb2cwXVm/KSzHXfUMTXytYOYG
	VL0l/yYFxkw9H8Uo2jogFkRFACa9/9d4+8iMv93l4j0e+9+oxNNxUrMpiwJxwrnoaMxB2kN8ru5
	6wPu/jnMcl64VxbdByR4vqo7EdsMT0j4j5I0wa6t8zRiyU9MnhBKilVpYFhu7SEuPsBGqFXvxbS
	CjlnLCdZ4gcB+qzrwlfKDovTbdB7O4SRtB7hGPkUm1kcSDc39nvNMBPGC5yRVntpJ9lcGJV0CaQ
	cNeHqYTm4ExNkqiY+q9e54wpPAVfousQtXbLKKU8Svs9gezq/CqaXpZaApt7Qn6zPEhrfYlUNDU
	N2WO1RaXhvwjr6cXp48waSymjuITKAk46mpePGa4lBROS9U/M4lNwcYQPtawMviKV5+QW4KVLcP
	3iFkqA==
X-Received: by 2002:a05:6820:168e:b0:6f4:87df:79b1 with SMTP id 006d021491bc7-7035598d0bbmr4070327eaf.21.1792380307985;
        Sun, 18 Oct 2026 20:25:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4f::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b640adesm7471839fac.10.2026.10.18.20.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:25:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 16/16] selftests/bpf: Test an arena kfunc argument passed from a subprogram
Date: Mon, 19 Oct 2026 05:23:56 +0200
Message-ID: <20261019032401.2302823-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; h=from:subject; bh=tzw+aCcv3UQYtzkDQiX9ynkaGvSmqn6LNADjaXtYzwQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr57tM8df2VmyFtsXS3Hd9ly4cVrMnrpjjiYPqrisW6Q1 xFQ6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJG7zxgZTrjIev4ukPlz0qNnw/MPlm 37bM3Uu6rEH0i1hE3ZcNa+lJHhQUmVXGV33yZfg60uaiJf5Xc84dd/sJb3vVjljM27zxnxAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Call a kfunc with an __arena argument from a global subprogram that does
nothing else with the arena, the address arrives as a number and no cast
is involved. The subprogram needs the arena base set up by its own
prologue for the JIT to rebase the argument, which the BPF CI review
found was not recorded for it.

Pass a NULL constant to a nullable __arena kfunc argument as well, from
a program that touches the arena nowhere else. The verifier takes its
early exit for a NULL argument, but the JIT rebases the call like any
other, behind the NULL test the function model asks for, so the arena
base has to be set up for that call alone.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/arena_kfunc.c | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index a049d6371d09..5d1cb1a7e8ee 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -192,6 +192,57 @@ int arena_arg_unpopulated(void *ctx)
 	return 0;
 }
 
+/*
+ * A subprogram whose only arena use is the argument of a kfunc needs the
+ * arena base too, the JIT rebases the argument on it. The address arrives
+ * as a number, so no cast marks the subprogram either.
+ */
+__noinline int arena_arg_from_subprog(unsigned long addr)
+{
+	return bpf_kfunc_arena_arg_test((u64 *)addr) != 41;
+}
+
+/*
+ * A NULL constant for the __arena argument takes an early exit in the
+ * verifier; the call needs the arena base all the same, the JIT rebases
+ * the argument with a NULL test.
+ */
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+int arena_arg_null(void *ctx)
+{
+	return bpf_kfunc_arena_cap_nullable_test(NULL) != 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+int arena_arg_subprog(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	int ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	if (arena_arg_from_subprog((unsigned long)val))
+		ret = 2;
+	else
+		ret = *val != 42 ? 3 : 0;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+	return ret;
+#else
+	return 0;
+#endif
+}
+
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
-- 
2.53.0-Meta

