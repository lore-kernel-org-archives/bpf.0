Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F826AF4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645685; cv=none; b=q0K1TN0AXrWJfoEnhmjFdfoxPACVeO0Z/OzJENK4Ao4o9ZhAkjM8UVFUKyU4Yr622py085jAcXojmidkgI4365J76TphBwWUeVLyNT8LamH/Rmohk9m5LDAUS0AOBL6784wQtXKuJZ6FpP8JUyTEfEXknmEfNf81nSm3zLRS7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645685; c=relaxed/simple;
	bh=KBjS5Zi/uzGT3QriWViHEXnNybybspc89TaoRpB5tAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2B21+3NHXdaiWF1FIBP+fQlzMUWf3XR4CjmkTyP4NXZ8xxrG3YzXN9lxeFa5PH2PGRBoNbFmYW7PSOWqEsubdZIZu327CjdslM7489OFyC7s95MvvjZQtnh4ISqw88pwoJzjrhp1MMyWyLojYj32PjOFh2KPg0mzDZE6MTBKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhlGx4uZ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhlGx4uZ"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f4e1568932so2062567a34.2
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645682; x=1789250482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9oD4m5WS29qa9McMIAcIBj6iOjP2f81Dc79RvdV8Po=;
        b=NhlGx4uZfnk5to0VvDs4NqYAECKIS9qS89WCq+sNZ+Tzf0iPr+lNT2uaLr/ki/MHlr
         KWfiwcCyQboS/V1sqaIAUEpv0sri1EjbdUtaVgqruke2K5m3218TfWweGkacpiWxWThO
         XlyEz05g0L0PsmlXAvU/zLikcGNRH1jxnEWaK7FxkxSQSfeqZ9fRD7hd0zXQLS1tWx0T
         VWoYSssDraTmsXEpLk42Wi9pOx+gvBwa3DKQqUhtdkjKrv92RXFOrSrcta5mBqZX/kLf
         lGBbs6JHD1cej8hd5WsYvcI7iY0Jj1IZRhoYJJBjmaOv68zeREkwgm2Mk4fp8ZYtJZHB
         9q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645682; x=1789250482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D9oD4m5WS29qa9McMIAcIBj6iOjP2f81Dc79RvdV8Po=;
        b=GyR1c3B5FPD524nZCnpoPQ9KQmfmAjRgc1K92CuoKG40MU+4lvHjFwWl2nUFPmP8OO
         aIx1gtPNVrIqbOYZT/G3hk+qI3u2zLGV0zi6SVVSBCCPMpM3UAIyiNmV/8dd1QZnAJUT
         UD58h6KxH9xh//L/enTe+h7juQMtK1T7YHw3cUlG9a3vA2XzfT99MbLqiNByOKk7nSYF
         KlUEg7EdrEVG9/RxCced+TS9gGLVcHU+LZm6pgADNqwKE6jvaDDVNVrPRYg/JgeoOlB6
         iCB6D9qyVR3pZdeTkz+2k64LAIs/3TK6wOgv2f/HJmu5XxK2Ybo9sL01CatfaAnK16lJ
         hbmg==
X-Gm-Message-State: AFuF++mWOkmxxriGnJzi181FkMc32FPs7brZJ/M26bh5RtcMDNUP8aeS
	XY4A4QXZag8sROeqmmwtcvaWeyN+kavG7o9CNTxsViGwdkivE2jCRmUjeJotlA==
X-Gm-Gg: AYBFou17mshVDnk5l4XPBthTFm6quaUhA/IxOQkuE8O+iC7ZFd3cEO8Bo6TwlU5H0pK
	K1sbePLwRZdfsJyS3jEYX+Jp/PmRSwhVUHK2o1ya8x1nMLejXbRqRvkN9nbw9CEiOPV0tUB738q
	rpVsBn5V68wDsUKJ9NiqQjJCKtG/09mcbPu4BM0s5BKW5K2xUXfKZvIMqcQL+HR80Eui2XDIzdL
	wY8yWpEhOy1Jqqcq664U7+/2DnFx1ma41e/G5Dd21rJ89sR30QxPaXgB+9Ltsm3op9ivuIOw1Lt
	G04wzSMf4hLu6O7xLw/5/tqmzwW+CVEdRZfdoBl8ScgJY7Yrr7g/8jab2t4oJT+joq/V1IZyTSp
	vl9N+XaL1Mllbg2eeU1c/Pod5R5eiL/YuCaHmeqJBguV6xhTnvjmjed60ULrFn7FjhukogtQlDJ
	ar212sKzjiNo9u5SdlI1f92c8A7T2A/1nszo285emwxugsC1MeOjI=
X-Received: by 2002:a05:6820:f09:b0:6aa:d97f:453b with SMTP id 006d021491bc7-6b6fd9c68ebmr12983193eaf.28.1788645682383;
        Sat, 05 Sep 2026 15:01:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fa888f614dsm6024379a34.15.2026.09.05.15.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:21 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/22] bpf: Address check_func_arg() arguments by argno
Date: Sat,  5 Sep 2026 15:00:57 -0700
Message-ID: <20260905220117.922028-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
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
 kernel/bpf/verifier.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f49c90beefc5..30e1f7a7553e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8769,10 +8769,12 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -8786,9 +8788,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
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
@@ -8904,7 +8906,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		break;
 	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
-			verbose(env, "Helper has invalid btf_id in R%d\n", regno);
+			verbose(env, "Helper has invalid btf_id in %s\n",
+				reg_arg_name(env, argno));
 			return -EACCES;
 		}
 		meta->ret_btf = reg->btf;
@@ -8941,7 +8944,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 * next is_mem_size argument below.
 		 */
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_mem_reg(env, reg, argno_from_reg(regno), fn->arg_size[arg],
+			err = check_mem_reg(env, reg, argno, fn->arg_size[arg],
 					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta, NULL);
 			if (err)
 				return err;
@@ -8950,14 +8953,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

