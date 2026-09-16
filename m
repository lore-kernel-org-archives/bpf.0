Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76643488213
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593692; cv=none; b=kmYMpFc8TtHnG///KY3hZI6WhFlo9D0b/1e+9EY+w6Qdt5oFvWzdU8gGEp39ekiFaFx43Nwdwe2ImAN9NEmUK9sfWQq5icLeRKcN4PmIovSO8th/78Zi3w0i3ftcs4bQQgqXDcYc9nJFKhe/cyhXcvv0Cz4Pni8WGHhV1qN2o7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593692; c=relaxed/simple;
	bh=EZ2KQNFt3MIQocc/C2AENiz3+DuBF60LG8VnvN6AbOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhVx5/qRyn5t8uyY6ntIAx0bUJ0+d9YMqgdk5ftOCJGepilII2oYT0qgUPMujaSInO6+x5YQmSNg8A7NDncLVG9Tb1Ikq5YFacPIwNG6QAwflnBnx+TqbklvhILodiWynpOkzrzFj6VstG+A5kg9z0aNrJs50eCvzgv58CFt8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGxTY7En; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGxTY7En"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so699985e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593671; x=1790198471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/w7WRSqa2VcLYmjVEt6DtySdOTf6Xd2WsLOvO4e8qJU=;
        b=kGxTY7EnEDbfztavJwNgbtNPOVGhFf/lEDgXb5cjs+4US8W7M/I0nbtCjt3CIASa1l
         WNP1nlDa5CiVc3m2Mv+ZX813dOZhXjhZZk9CO1iLFMuOqzVrDsG130AV9zFbXWAUu/HI
         G+XCQLqGMQpbdqILvoWwfdRKq9AcpAte7pXM/GBTJeh/FSZKws/3ejbiUKBVo151MGFd
         7iJ7DA5LgwoW5opB0PuGozt1XEyhFx8KVDYyehi8mSJxUYUvvwCgyfviZqnvwsLu8VSh
         TN5+JwooCcXcAlsPdAacjRaN2vXG4eIcS3S4HARtuhtpxOzxSaS7geSuCdUdW1kJ/a8n
         gNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593671; x=1790198471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/w7WRSqa2VcLYmjVEt6DtySdOTf6Xd2WsLOvO4e8qJU=;
        b=OzTNm4T6OpPbSiWpbuAPDsGqieGJE4KPR61L0W35+JHi8MKCNvpTf0sKNclO1SYbL5
         w6EYQLwE52avNsIBl4CfUM0XdrPbKQ1IuxFFuEmeMoNaC9UppEDnYLjuX0uTNPvaX+yu
         5p04vbF5o5af3vt3al+EWPhH8tnKs4V6rS6w89sCCD7KFKmeNKW3hivg9xCdqFqQ729I
         vAGF5c00fGS3r8kQmJrNwWsh80O3dorfU5hnWQlgqVswXEYtypUOxaeuYRdLKyfwOGOq
         q385Oj5SaHDpzgQXAw9I+FAC51osK6T+tc9rPehrTkPhKLcGoaIc5VwifPAwythsYwr4
         gKiw==
X-Gm-Message-State: AFuF++mRaw8FVADpVXdva1/4/ijQVYn5HE9NpxVmqfmAh3166klKTheb
	ZlJnScwJ3pO589I5YeBb82niTFZbwGIcY+MyC83xHUesL6JxBZrBt5bwbkldquGj
X-Gm-Gg: AYBFou2T4PRnw1bBiIL6dP0Sim7OtwaN8pre0+k4kczI3RCJV3xBAT+rOEul/EH1t4T
	fLlJXVdrjHSytcPcj2yCSPhGf46GDPFWUIZ7RL7Ccnw4EG6m9WVhXOknA20M7N0CVuf2qQWasLz
	7NpbeL545nahgc+YdsS6liaqjRWXKIIrCoHUiSu2hF/TzxCbK76VKrkNBpJ1Cy1XhRM9+TjAmPJ
	sbHPS3D8FD5wWY+2XMpiBCtiswZrmpQFtow2IQqQYQQUmY9O5tZt7w3rU/2AsxB2syYmJZiUAaL
	odLVKB/b4s3xAaSPUfKD6q3808vZ37TmaUi7RBxgU7EK4BOwpUJpRfLqQ1xeK3KgQS99qCEuvpr
	porW/sM2r2DkCJMQKvLe5Mm5HrIIjVKfI1SHuCYc8wglgqNMoLLKymRJhmHMpE68cnMlScD0dYZ
	3TeGR62XkXO5bHFkVsqVup3spgkZwhpcIfKJXLOVgpiUu04v099nNKZMQFaqMQcTH9Q0wG6Hgtv
	zDMLQowSw4ASoTV7lrcHxMC7NAaEidbv+T6ZQLdOdnYkY/qV3hjRvSvNk6u219ZQZTW4sVQspFD
	11bKld4d7YaXQ5cOcauEfJwWTtjcva6wjGjxHu/7dmoYwGa2
X-Received: by 2002:a05:600d:8498:10b0:49e:6ac4:b76e with SMTP id 5b1f17b1804b1-49ec0543cf1mr37620295e9.30.1789593670811;
        Wed, 16 Sep 2026 14:21:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847f176asm68923325e9.3.2026.09.16.14.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:10 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 04/10] bpf: Apply CO-RE relocations before subprogram validation
Date: Wed, 16 Sep 2026 23:20:51 +0200
Message-ID: <20260916212102.597335-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4827; i=memxor@gmail.com; h=from:subject; bh=EZ2KQNFt3MIQocc/C2AENiz3+DuBF60LG8VnvN6AbOQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h9yNyy4+e37OfJB0cb11lGJvWY/DlMNa7Rf76hOWT 9UqZRTtKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETOJjAy7JcQyTAV4tjG8j7R 7sIc9rvFTYUvnnye9GzKwytP5M6IHGD4wyG4gPFfy9Rt/ybUxHcX/t/m+5PzwL+JUnkJb/38V17 q4QQA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_subprogs() verifies that each subprogram ends in an exit or an
unconditional jump before in-kernel CO-RE relocations are applied. An
unresolved relocation can then replace that terminal instruction with an
invalid helper call. The resulting fall-through into another subprogram
breaks the CFG invariant used by postorder and stack liveness analysis,
which can write past their per-subprogram arrays.

Apply CO-RE relocations immediately after preparing the program BTF, before
subprogram discovery and validation. Keep func_info and line_info validation
after subprogram discovery because those records depend on the complete
subprogram layout.

Reject an ldimm64 first slot at the end of the instruction stream before
CO-RE can inspect its missing second slot. The regular instruction validation
already rejects this form, but now runs after relocation processing.

Include core_relo_cnt when deciding whether to prepare program BTF. A load
that supplied only CO-RE relocation metadata previously skipped both BTF
setup and relocation processing.

Fixes: fbd94c7afcf9 ("bpf: Pass a set of bpf_core_relo-s to prog_load command.")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/check_btf.c       | 12 ++++--------
 kernel/bpf/verifier.c        | 12 +++++++++++-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36b65797877d..bba5a727c651 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1197,6 +1197,8 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 
 int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 			 const union bpf_attr *attr, bpfptr_t uattr);
+int bpf_check_core_relo(struct bpf_verifier_env *env,
+			const union bpf_attr *attr, bpfptr_t uattr);
 int bpf_check_btf_info(struct bpf_verifier_env *env,
 		       const union bpf_attr *attr, bpfptr_t uattr);
 
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 0e8b3ccc7a5b..4c1ed842f661 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -338,9 +338,9 @@ static int check_btf_line(struct bpf_verifier_env *env,
 #define MIN_CORE_RELO_SIZE	sizeof(struct bpf_core_relo)
 #define MAX_CORE_RELO_SIZE	MAX_FUNCINFO_REC_SIZE
 
-static int check_core_relo(struct bpf_verifier_env *env,
-			   const union bpf_attr *attr,
-			   bpfptr_t uattr)
+int bpf_check_core_relo(struct bpf_verifier_env *env,
+			const union bpf_attr *attr,
+			bpfptr_t uattr)
 {
 	u32 i, nr_core_relo, ncopy, expected_size, rec_size;
 	struct bpf_core_relo core_relo = {};
@@ -414,7 +414,7 @@ int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 	struct btf *btf;
 	int err;
 
-	if (!attr->func_info_cnt && !attr->line_info_cnt) {
+	if (!attr->func_info_cnt && !attr->line_info_cnt && !attr->core_relo_cnt) {
 		if (check_abnormal_return(env))
 			return -EINVAL;
 		return 0;
@@ -455,9 +455,5 @@ int bpf_check_btf_info(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	err = check_core_relo(env, attr, uattr);
-	if (err)
-		return err;
-
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddba53eaa333..2005a145e403 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21196,6 +21196,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = bpf_diag_init(env);
 	if (ret)
 		goto err_prep;
+	if (env->prog->insnsi[env->prog->len - 1].code == (BPF_LD | BPF_IMM | BPF_DW)) {
+		verbose(env, "invalid bpf_ld_imm64 insn\n");
+		ret = -EINVAL;
+		goto err_prep;
+	}
 	if (env->signature) {
 		ret = bpf_prog_calc_tag(env->prog);
 		if (ret < 0)
@@ -21271,6 +21276,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Apply CO-RE before validating the program's instruction layout. */
+	ret = bpf_check_core_relo(env, attr, uattr);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Discover all subprograms before validating their layout and BTF. */
 	ret = add_subprogs(env);
 	if (ret < 0)
@@ -21280,7 +21290,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
+	/* Validate BTF against the complete subprogram layout. */
 	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.53.0

