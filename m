Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B6367B7E
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920104; cv=none; b=p0AaW0Jho+Rm1zLKdWBX/yjfGeyfAVaw+NiYf6ET3rTgQ8EX9hdcH+ZOvhGyDed6SLxkBQZh0Fykv1zAjbikfGU16ZXA4EilvuZkv8A3cEeSmnix/ezRtUXFOPAn+IHvFEC58nnSKLEH6YgYGkfUMR5lK9bHujbsAgNpO4D7yyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920104; c=relaxed/simple;
	bh=9jM432h8QeKmTaCgcntIPWnywJSB7UX2Lnehf2ziuM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN0irrEpj/pHHuFrox4TqFPt/IMe5lvhFcvZjYzqOBcS65xy4Uctu2tc3c2cZdzaMZz1DFgGdbvl2IrrEdCGoj3KoKjIvf8CryComQEjerBrwIt9J5T4+TwjkxNujKHbVZUYlvfTEyhrwkZ17OrCkPMBT2+hfQR6I50I05hJwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEyhhUy9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEyhhUy9"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845c92bc464so684873b3a.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920102; x=1785524902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OzcDmoNzjvomJFTlX+Cj7O7w5fwfM5j9KIzyhA4XZA=;
        b=PEyhhUy9amSqaXTym/VRencpktyBkjLRw+klp8VB1/yeZes4ghGj8qymdnXiUwQBcv
         MfcsoMXWWNr/PHBenUtesdmufgBGFNyizXRSRS5SVg9ELai+FElsr1UCixWE4AEfa8O8
         d3KmHBcjleVoGbeJk3nB7IkPTlGIVPaGL3DV7F5Rn/ZS+15iPqGnfHdDgF7B15Co3Y25
         QuBLOjrgIDdI4YWdSSx2XhV6Fh/5pzwOMRhlSJHzDykuW9nk1Nv47JQfd69WkfyYJEXJ
         9KIxu8bMMqkcx6fLDblqnLfJmtWjivLAyPko795ad1hk57sgO1B8ZntX85MKfZkxiPCK
         lzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920102; x=1785524902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OzcDmoNzjvomJFTlX+Cj7O7w5fwfM5j9KIzyhA4XZA=;
        b=dKH/Bexf5/CZTzSCRiPqUTjE44UAoRtgGTXuzHdCJ6s//fnShmAiq18SFAaueP64MC
         X9NcBGxmRw1XCclqAOpARsfW2Up+/lbNL/frc/l4sNrKCezIRdqqvglQsD5W4SpxwkuS
         nIPB7+BsI0N3pcpb+FzAfh67eUovmobevYlJYBGbqa7OxafxBWNuHL8CGR2nvTVp8CpY
         r+t4qqkVVLfnYE07BkbIrqM3AtQOrt6SbN2GJT+kliW155OIR1AGN4TdTM2YkdXx85Bd
         8SFuBFszO4YltpGvHV7wn5spD9nCycjxFJ8Qwug/o4+XbrOsxHL2VS0a9t8mE8Wgs/4Y
         6QyQ==
X-Gm-Message-State: AOJu0YzEki245YhZRbqsBmUY2OXIqMnXaHV3XCW33Pq8Y+ubp8W3KAPl
	qM2wbjAgBWFrUNvT6HIXet/tSnyf482M9RtT5bZcjlg8q0PZrwktU5U3238ibw==
X-Gm-Gg: AR+sD10SWfapdble117td6yJwsZByxZtra9JDhkWFqbHRyrmnPVtTjTX9y6QYCeOl/u
	FKFYdwft7ksB1AgJ3dHGUsEkY3m3NdP3rG6p71tSLDO+9cdRgUseETRU5jMVD+Hxy9JjPoHjfy8
	EERyI2mchKXE9S7rpu+kKnjDvtZYzZvj+ev12j87xJDFoP4vKLnZYnrMI8EM9jubIrFsNR7oNpB
	6+dfmxOmrYsE53NZwfORHuE4o4ppQgKM0isVk6iYbNC/Pf0MkVhliv897X1Js0l9arcO06LXZhh
	j3E9NDfwAGLoTITTQweDyQhymL2k1dIOnMqbFP+rmovS/SDjVqSLYdmyucWmhMIuceS+WinPLHo
	t3Cnpg45mga/aP8aoSRH7gYZ2bO/izUMxz7a/sHjKrDCWszBtuYUGIkVXWdIL8ePL9s06fNZZB4
	Lmk0Q=
X-Received: by 2002:a05:6a21:110:b0:39f:59c8:f302 with SMTP id adf61e73a8af0-3c44b1ecdd9mr9519199637.37.1784920102194;
        Fri, 24 Jul 2026 12:08:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b2838sm444143a12.21.2026.07.24.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:21 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 07/18] bpf: Check fixed-size mem args of helpers and kfuncs the same way
Date: Fri, 24 Jul 2026 12:08:01 -0700
Message-ID: <20260724190813.1458271-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed-size memory arguments went through two paths: helpers called
check_helper_mem_access() directly, while kfuncs and global subprogs
used check_mem_reg(). Route the helper MEM_FIXED_SIZE case through
check_mem_reg() too so all three share the same check.

This also fixes a bug in the helper path. When passing a NULL to
PTR_MAYBE_NULL | ARG_PTR_TO_FIXED_SIZE_MEM argument, the program would
be falsely rejected by check_helper_mem_access(). This is not
triggerable since there is no such kind of helper. Also, note that
check_reg_type() still make sure NULL cannot be passed to an argument
not marked with PTR_MAYBE_NULL.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2e56f726c12a..4606294e444a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6941,11 +6941,14 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 }
 
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			 argno_t argno, u32 mem_size, struct bpf_call_arg_meta *meta)
+			 argno_t argno, u32 mem_size, enum bpf_access_type access_type,
+			 struct bpf_call_arg_meta *meta)
 {
+	/* meta->btf is set only for kfuncs; a NULL meta means a global subprog. */
+	bool helper = meta && !meta->btf;
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
-	int err;
+	int size, err = 0;
 
 	if (bpf_register_is_null(reg))
 		return 0;
@@ -6965,10 +6968,12 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		mark_ptr_not_null_reg(reg);
 	}
 
-	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
+	size = (!helper && base_type(reg->type) == PTR_TO_STACK) ? -(int)mem_size : mem_size;
 
-	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
-	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
+	if (access_type & BPF_READ)
+		err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
+	if (!err && (access_type & BPF_WRITE))
+		err = check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -8477,9 +8482,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 * next is_mem_size argument below.
 		 */
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, reg, argno, fn->arg_size[arg],
-						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
-						      false, meta);
+			err = check_mem_reg(env, reg, argno_from_reg(regno), fn->arg_size[arg],
+					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta);
 			if (err)
 				return err;
 			if (arg_type & MEM_ALIGNED)
@@ -9251,7 +9255,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
+			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL))
 				return -EINVAL;
 			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
@@ -12397,7 +12401,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
-			ret = check_mem_reg(env, reg, argno, type_size, meta);
+			ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE, meta);
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.52.0

