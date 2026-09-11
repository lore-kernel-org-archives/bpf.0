Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA294BEE35
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164263; cv=none; b=Ls3pDY7F836ShFMFJtn7OonM99byvgJ2DD5GkFgsIpbb888CHzsGZ93U54BsIKAr9Th7g9F8P9NqNr8WK35mj0SXI6FDvZUHGUBryQlPHpTeGfnuy6JxmNxkKVaXmODnviN1fju1ZmY8VVv3AkcXLzbzhiqjOktSX8fYd3wCmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164263; c=relaxed/simple;
	bh=GGSEN0GYe9K4pq1s+IwsKZSqboWkkQwVm3gJGSvQsfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBSurOIkQdV1fq3au2S3EFj+8xtpo2h7YHCMpikU4OEW61FRp3Ro+BdpbXXX5iR7oHtm00wpLjG8cDte1gSYZxaorOan1V1KjrrBVQ0PmnZmW/jpzyl1MYYTykvQRRDGquMSeOu0Hz4oDu8m3gC6MefciieG0c4pWVkUDHys2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdq01Czw; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdq01Czw"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fc4034841cso342674a34.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164261; x=1789769061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2XseL1F40Xm4KTsPlTqrRjr3hB7DGmx0ZK4P2JrhWrA=;
        b=fdq01CzwpORx3NiMvFTALYuA2Rosxdw6b32yA5wK7H+bDxWVK8qmVyaipIfEGhYaUs
         1s26RajdWrkAnDuVheZccMiwJKqFjBFIASYdIhzMr2lOfB+ywTDItFgzwoOZIC0cUwVg
         T+lgAhJA/7r/yCMuoH4dDeZjw9oyn3t4/KgXnCeEaCqvcgMlLwzhZ+i/ILDkLa7f3Rqq
         Dyh9IEh/cirTddn/HIfvPbRHuQRfrzfZqp8VyflEvT33yU8xo9TPdeLVRnKxYbFiTCvr
         Y7CnYkecBcxnIJftVLq6CS2Len8WexUIE7n0PAyk4Zyxw7FRQxr7UVvQL+J2kaPAWU/C
         2SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164261; x=1789769061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2XseL1F40Xm4KTsPlTqrRjr3hB7DGmx0ZK4P2JrhWrA=;
        b=nhlZAQcdlXe7+aFIPeMn9yedN9X9ABtZD4M9Z51O7zRZu2NNvUhCd2cB1ya5qWHZUi
         FClp6hPig4S5KMaw21lbFV0GWrR0SofwmAOn5c6a/NUFbhjtE7vT77niIvXB9F7uhR0E
         0wGKG5jRrLFJXH2vMucex5PceXNNBj5Xm+m64UQ4jEppuQddZaIDcKBp0hxMBlQemc16
         l/rH6KPWZR2waJmXqr/LDmNfQ6Xd+NtfM4N/LcBmDxP9f0uXPYM7bEGvLrqFJ+8KvY61
         +83coWR0rsnkg6/XUEA0H4R4unpJ40KaiSpaR5+uxIDoGn5qJXUlHwtq2fDkok3x7/xj
         qqDg==
X-Gm-Message-State: AFuF++n15STB1qwMtZ3I4o5Znb+ZpvBpqhPzIyv2Rh8Q46FMEHuTLCFA
	CaqmFSn4FmtQf6KdyfWwhkD6ZDX3bEt7BwLPvYumsXhWEknVxNyjF4M7+Gg6PQ==
X-Gm-Gg: AYBFou2xx5t75B4vIDsj+I3A3xZ62h4IhP0D43OS/kFvygE6yKwC29StmQVC4HFx5xH
	6KW9J9/EUGhf+LDDSaxGYaAs7LJj6RBGqkPgU4ndQCHPJTuDPl5ch5NmfP1vvLbrL/H+rV3N6iy
	OIuK5jiXqTZ1s0QYG16EN96q5WmR3WIz129cjlSPJA6IR6ZfGmC+gSbXt0PRAiW1koSu5L5IdzJ
	hLudAlySRaP/Hz23U+J1sFOec8x98SGwdXyixWAK761KLjt35vTy8AMZ+rMevs9nX6rD3UqyE7j
	SzaYV9rbFlOnZ2cMGU5XjnfLwuKc2ZE370/gEWvsewUuNqYpxK1r0+NaEzevdguRdBBy3Wy8BZP
	5lRP81m/+N6DCHgpSkOv7A2fv01l/ppIOpPesfzCScIywOdsU8GFqnsi8KpS4KKiqlxiycefkja
	ZgzoH/4+5DREUGxVPt6xpJ/G2nI6NBCVFmJnrFjS9tMITwx0TCd2tPvt78RDe4ew==
X-Received: by 2002:a05:6820:a283:20b0:6ac:8e23:3078 with SMTP id 006d021491bc7-6c0b9a5f10cmr3485532eaf.5.1789164260838;
        Fri, 11 Sep 2026 15:04:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c09690af1dsm3750011eaf.1.2026.09.11.15.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 02/23] bpf: Address check_func_arg() arguments by argno
Date: Fri, 11 Sep 2026 15:03:54 -0700
Message-ID: <20260911220415.1396439-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_func_arg() derives every argument from BPF_REG_1 + arg. That works
for helpers, which have at most five arguments, but kfunc arguments
beyond the fifth are passed on the stack.

Switch to the argno_t addressing used by check_kfunc_args(): obtain
argument state with get_func_arg_reg(), use argno for diagnostics, and
call check_reg_arg() only when the argument is held in a register. This
prepares check_func_arg() to be shared with kfunc verification.

There is no functional change for helpers. reg_arg_name() renders their
register arguments as R%d, so the updated diagnostics remain unchanged.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a45e0478f23c..d5e885435bb6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8815,10 +8815,12 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  int insn_idx)
 {
 	const struct bpf_func_proto *fn = meta->fn;
-	u32 regno = BPF_REG_1 + arg;
-	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_func_state *caller = cur_func(env);
+	struct bpf_reg_state *regs = cur_regs(env);
+	argno_t argno = argno_from_arg(arg + 1);
+	struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, arg);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
-	argno_t argno = argno_from_reg(regno);
+	int regno = reg_from_argno(argno);
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
 	u32 key_size;
@@ -8827,14 +8829,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (arg_type == ARG_DONTCARE)
 		return 0;
 
-	err = check_reg_arg(env, regno, SRC_OP);
-	if (err)
-		return err;
+	if (regno >= 0) {
+		err = check_reg_arg(env, regno, SRC_OP);
+		if (err)
+			return err;
+	}
 
 	if (arg_type == ARG_ANYTHING) {
-		if (is_pointer_value(env, regno)) {
-			verbose(env, "R%d leaks addr into helper function\n",
-				regno);
+		if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
+			verbose(env, "%s leaks addr into helper function\n",
+				reg_arg_name(env, argno));
 			return -EACCES;
 		}
 		return 0;
@@ -8954,7 +8958,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		break;
 	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
-			verbose(env, "Helper has invalid btf_id in R%d\n", regno);
+			verbose(env, "Helper has invalid btf_id in %s\n", reg_arg_name(env, argno));
 			return -EACCES;
 		}
 		meta->ret_btf = reg->btf;
@@ -8991,7 +8995,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 * next is_mem_size argument below.
 		 */
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_mem_reg(env, reg, argno_from_reg(regno), fn->arg_size[arg],
+			err = check_mem_reg(env, reg, argno, fn->arg_size[arg],
 					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta, NULL);
 			if (err)
 				return err;
@@ -9000,14 +9004,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_MEM_SIZE:
-		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
-					 argno_from_reg(regno - 1), argno,
+		err = check_mem_size_reg(env, get_func_arg_reg(caller, regs, arg - 1), reg,
+					 argno_from_arg(arg), argno,
 					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					 false, meta, NULL);
 		break;
 	case ARG_MEM_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
-					 argno_from_reg(regno - 1), argno,
+		err = check_mem_size_reg(env, get_func_arg_reg(caller, regs, arg - 1), reg,
+					 argno_from_arg(arg), argno,
 					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					 true, meta, NULL);
 		break;
-- 
2.52.0

