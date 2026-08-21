Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05B3A545E
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355322; cv=none; b=AaM9CAIP7grFecDSOdrgVC/AfIoW6PG8aIxhtQsb4bDpFo4wUrTt+xUxcP2e5oFw4yIuVQuyDfzwXSyMke8UOqev/PgwAd5yG+siJ0+GKDt/pHs7exJCh7wDY71EiUlaa1+fV4f68V+q9jjCB9Ghk9/R8bOpcjxi1VLUIS0SJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355322; c=relaxed/simple;
	bh=9JKQoIx00bYDmFnDi23tdvUgM3shjXaf0VAbtBOOsKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mElTDgPmmh11SdaFry87NHvZV6dgeXyxbw5g0ihab62dwBjj5rL8ibwyhgqUzWz8DwpjYZmUNRJzHkE4oudkHIhaRu5NnqVy9YDl1aXah1Fhwrz3ZaswT+ZQJTOmpwY1NGOniPHXE0sY28cr4F65v6g2IFla9eUmoitFcdJhtVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4AeqIOw; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4AeqIOw"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15ef474e72so69751066b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355319; x=1787960119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYeajw39SnHRCVQ6rJV/zyugoN4pKQnmWaQlbU7H+Zc=;
        b=n4AeqIOw9sTblHhmUM8Ve+lpjzmX1DD7pvcL1OF8rXoZmjfr4ozLxQelyBp4+NN9TC
         ISFxIOLjQjxiYp9Pd/hYPhedi4yYdJrdUtZZKRku58LEDp1y4/4dsHWr7psqlAS/Czd8
         2K3eWNiyxOp7NseNYmd1ByLrHgQP/RdOltKarl0eDj6NMrlFRhdfI8VZsQReXPI9A29N
         BIOGUfYfeg8rxAjNyrH2ynbQ4iNv6rY8NmLlY591gm66l9W9XZUc6TL4/HCFnW3NGaUC
         TAnTtAsemq2uDR0GuVPPZnYEZzTu/H8Ggo57ObnoSa+NuuJxN3NP+ztgtWdPZPMU6QGV
         A53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355319; x=1787960119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MYeajw39SnHRCVQ6rJV/zyugoN4pKQnmWaQlbU7H+Zc=;
        b=WpuY3jO1SPPMkP6UGX6AOkvvxoTWNEgo2xv5XP3ShvHHRP7j/7j6MOJI8mJJdaUAIW
         6AV7TEBFE6VzdB/uoHC7dl+3p9ZBcXvdPZvmdhppBy84VokkEQAzGMFnNfigj4z3je1s
         7c6zOWFqZMt6n2oM02/SS4BmjWJyV4xa7lmkqBAhF9vRhwW4M3VIr6S+Eus2jA+4Qo5D
         JwWkomTKY3AkwNCZhHUiOEXWo9g/13tMWF5TLz2PVGSBJr6pCbXR1zxWy8EdglE2A8nu
         ROAiHuIii6fuO4mXGhcKOT7OtewYzp5SYwMQDlR72VZ6UxqGc6BmmNckx2nboYI8HsbK
         mKdg==
X-Gm-Message-State: AFuF++kjywoylPrqocwrxDnMAufDWlnfwPrUvLssKfmUWr261j5n9Fly
	MP3XB2EMdsi2vy2ZxhsOPD4/L5/7qYukiJRUjHtcc599VsyhYzHewJrog+fUB0NF
X-Gm-Gg: AR+sD13feES3BUy2qVN21FRlPqfKIALLzpungG5R445zHbx/cwlpFascmrL1HhaF4o7
	JhZEm4oWuD0rMcqT0X4ypPuMmswPM8lt1+bZsFFkUbI1MUcxVTEYrTAPDe7sLFJk+CBLIIleMXu
	B2r97+ZFWQBynGUbOi9VxymzXTWKB2o3gjlTmSkrw3HhNuy3Ux3qeTS14EJbs0f7wK6nwJPM5f4
	298ussub7ZSp03uBT7gYfatvUwzeZHlEaYw4Op2kMBZOl0lsdjocgqQyC0aj8KVcBjmyUoa3jB2
	yA4JMBnnl+u4gNForsZTtKOlQOFUTGiUO/zeAi6wlVKs2p6ry8BQ8f7ZhzQ+WB3DRzqoLsOKpuy
	QUK4YrC+ZJfsQiGOYhN3eZleIyi49RntFIiCx5cq7z+1Jl+LKdUfiRVIg3pG2saw/1zGiHaPTkz
	BKEz+hMEfunFUkRoluYLm1P4ApoUWJKnRXOcTZVArz3Wncs1W/h4+CUg3IbpZkAhEoQ4qYNpoLH
	uMPBou5SMc34T1AzZgLO6Sb6onqht/zyN27MdrzPf3r0y6NYUtviOatgg782Oz4mBxMudg7jpAu
	j+nQQD8PoLuL3aIbjhD4CGzq8bEPpf7BCTz/tw==
X-Received: by 2002:a05:6938:a090:20b0:c21:2c32:e2e6 with SMTP id a640c23a62f3a-c246a60cfe4mr765646166b.10.1787355318751;
        Fri, 21 Aug 2026 16:35:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f8f08sm39423666b.35.2026.08.21.16.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/14] bpf: Split arena kfunc and struct_ops JIT capabilities
Date: Sat, 22 Aug 2026 01:34:55 +0200
Message-ID: <20260821233516.3426127-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4106; i=memxor@gmail.com; h=from:subject; bh=9JKQoIx00bYDmFnDi23tdvUgM3shjXaf0VAbtBOOsKs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQXeS7n1fzm8T3H5v3B8kpfFnz8p9YokstY9+L1NL3 d+gkTevo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNZkMbI8HLKR9lwlXUfm6Yr q/Ctd99nHDrd5aO+1azD8jInFZ9dEmdkWLxAwltP+cdq+3nbJSo6Y8pvS79/seq96Qn2emEtJm4 xHgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Arena pointer kfunc calls and struct_ops callbacks need different JIT
support. The former rebases BPF arena offsets before a kfunc call, while
the latter converts kernel pointers when an indirect trampoline builds a
callback context.

A single bpf_jit_supports_arena_args() hook forces an architecture to
implement both paths at once. That ties bpf_arena_alloc_pages()
conversion to struct_ops trampoline support and prevents the paths from
being enabled and reviewed independently.

Replace it with separate kfunc and struct_ops capability hooks. Make the
verifier query the hook for the path it is checking, and have x86-64 and
arm64 advertise both capabilities to preserve their current behavior.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 7 ++++++-
 arch/x86/net/bpf_jit_comp.c   | 7 ++++++-
 include/linux/filter.h        | 3 ++-
 kernel/bpf/core.c             | 7 ++++++-
 kernel/bpf/verifier.c         | 4 ++--
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 3aa3ea0bc30b..eecaa0027a95 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2398,7 +2398,12 @@ bool bpf_jit_supports_stack_args(void)
 	return true;
 }
 
-bool bpf_jit_supports_arena_args(void)
+bool bpf_jit_supports_arena_kfunc_args(void)
+{
+	return true;
+}
+
+bool bpf_jit_supports_arena_struct_ops_args(void)
 {
 	return true;
 }
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 48429fae0641..6e89f1c8738b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -4174,7 +4174,12 @@ bool bpf_jit_supports_stack_args(void)
 	return true;
 }
 
-bool bpf_jit_supports_arena_args(void)
+bool bpf_jit_supports_arena_kfunc_args(void)
+{
+	return true;
+}
+
+bool bpf_jit_supports_arena_struct_ops_args(void)
 {
 	return true;
 }
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6e746b0a0930..907d774fd355 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1239,7 +1239,8 @@ bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_stack_args(void);
-bool bpf_jit_supports_arena_args(void);
+bool bpf_jit_supports_arena_kfunc_args(void);
+bool bpf_jit_supports_arena_struct_ops_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5db77d7915df..92b0a3bf27be 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3297,7 +3297,12 @@ bool __weak bpf_jit_supports_stack_args(void)
 	return false;
 }
 
-bool __weak bpf_jit_supports_arena_args(void)
+bool __weak bpf_jit_supports_arena_kfunc_args(void)
+{
+	return false;
+}
+
+bool __weak bpf_jit_supports_arena_struct_ops_args(void)
 {
 	return false;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..6402e94c2097 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12013,7 +12013,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
 		arg_type = KF_ARG_PTR_TO_CALLBACK;
 	else if (is_kfunc_arg_arena(meta->btf, &args[arg])) {
-		if (!bpf_jit_supports_arena_args()) {
+		if (!bpf_jit_supports_arena_kfunc_args()) {
 			verbose(env, "JIT does not support kfunc %s() with arena pointer arguments\n",
 				meta->func_name);
 			return -ENOTSUPP;
@@ -19778,7 +19778,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		if (info->refcounted)
 			has_refcounted_arg = true;
 		if (base_type(info->reg_type) == PTR_TO_ARENA) {
-			if (!bpf_jit_supports_arena_args()) {
+			if (!bpf_jit_supports_arena_struct_ops_args()) {
 				verbose(env, "JIT does not support arena arguments\n");
 				return -ENOTSUPP;
 			}
-- 
2.53.0

