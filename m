Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DD2E546
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781163; cv=none; b=EfzxLdTNeD34bTjXV4/rIRaTkhqRQrGP9xa2grtiTmDEw3vnRk3QhpnZ5QH8cUwdVBm2P92hkQ941fQ2pDqwLuJrGkUPe/4OI3N2uh0qA2O92WGiab2HVew+MzmTI0qQYPjqDv/ZT3ZmuSNuc/8caifUbnzi4zPOiO7FR4Mtn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781163; c=relaxed/simple;
	bh=XnlsoQFXLM0Vve6a0zyaM47X1FEn0VJgXz3p8HUxRnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RN1DYFuPhGgY9QxWUL3BCWjRlMCXyl13SkdStxDkmLRdSLu3ByutpOsJKTcCMdmBi5KDf88NiVWTDQVmht7Zc4iR63lyyrZP5JpqnUOiUlBS1sV0JycbcwMqbCGSAKRrzjsZD4II/0HAawhBBH9rKBS4DiI+TwmC+ISCyNoB5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvuKv3Af; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvuKv3Af"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso339296b3a.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 19:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781161; x=1710385961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QXi2fGy0WO2Juk0nELFlUaJBHD5vu1E3qVS4jPD92Q=;
        b=LvuKv3Af6DO0uiwjBwy3QMil2kvhtcJo2oxmwl0OKM2X7w/n3zQqMi7ACvES+4eatG
         6Mn1Ss5/SG6bbY0XWgQZjkBjjfI4av4ObxViAj0LR+Ik4B6VQBY8krEeLhrITgRbM2Tm
         YrI95FU2cfpaznTLAlowEJws2s4N7kzvj87ihlc6bltNsQ6Pl0fwbXkUU47Lnyc+WUic
         Be2WE90LNkXbI2xH6a3fBKuFdyLDPWA5ueWHtXn+fZi7VDvuV9CVLfpkcxURBsBs9ruW
         Zk8n7l32knbFxAd0iqjV2Ms7E/E+hcSkxE3yRkAASufGQGjIGwKbVU4EOdZlfAmiGPYo
         t15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781161; x=1710385961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QXi2fGy0WO2Juk0nELFlUaJBHD5vu1E3qVS4jPD92Q=;
        b=VlT4mIaxMNV4U2pnqdsJcVxMcBGJdVuTFnbH5v9kGkduXGmiYWWeR3ZjhN4OG+uj7X
         wysP3SsZVvaexitv4Vv9ydf53mXrR3BfBa03BuEFXFDKgNMPZOLjkDim0spmYhY/jCLZ
         uGPgkPWNYoCGANDJQJXzxFlpVdiZze9a+pLZg6/5Ot4vgM7Pz58N9pVyTLEe7i3b2BZB
         6i0RxOiraadHghKeK2TldR5MDb/Jm/3beLNnsYkFDb0waWsKgiOW1N8lGj32pQASe32/
         VD/fckXlW8/Ei6zoRCjdjXJ1tNsR4HhLX0jC+vIbZeyU4QL2J0X2pKlXQSb49iYxaVTt
         XskA==
X-Gm-Message-State: AOJu0YyJjql1JTsfryGu+B3UYnaTI8kSiWsKSWR0sE336rlcfqS2LD6p
	4HlBfj9blHaa3ge9wwUC5WX+770li56Cxc5dfvaDpN6cNm1NDuUFD2Ov+JT2
X-Google-Smtp-Source: AGHT+IHMGOhk1GfbygH0Qr3N0moMlk1VqsYYl2kuzPDD4e1aETSEADSJHw+dFZ452WQMtUUScu57YA==
X-Received: by 2002:a05:6a00:4f96:b0:6e5:3b8e:bb6b with SMTP id ld22-20020a056a004f9600b006e53b8ebb6bmr18698706pfb.7.1709781160775;
        Wed, 06 Mar 2024 19:12:40 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:dd40])
        by smtp.gmail.com with ESMTPSA id c9-20020aa78c09000000b006e56da42e24sm11464986pfd.158.2024.03.06.19.12.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 19:12:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 2/6] bpf: Recognize '__map' suffix in kfunc arguments
Date: Wed,  6 Mar 2024 19:12:24 -0800
Message-Id: <20240307031228.42896-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
References: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Recognize 'void *p__map' kfunc argument as 'struct bpf_map *p__map'.
It allows kfunc to have 'void *' argument for maps, since bpf progs
will call them as:
struct {
        __uint(type, BPF_MAP_TYPE_ARENA);
	...
} arena SEC(".maps");

bpf_kfunc_with_map(... &arena ...);

Underneath libbpf will load CONST_PTR_TO_MAP into the register via ld_imm64
insn. If kfunc was defined with 'struct bpf_map *' it would pass the
verifier as well, but bpf prog would need to type cast the argument
(void *)&arena, which is not clean.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c2a36b1373b..bf084c693507 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10752,6 +10752,11 @@ static bool is_kfunc_arg_ignore(const struct btf *btf, const struct btf_param *a
 	return btf_param_match_suffix(btf, arg, "__ign");
 }
 
+static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__map");
+}
+
 static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__alloc");
@@ -10921,6 +10926,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_RB_NODE,
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
+	KF_ARG_PTR_TO_MAP,
 };
 
 enum special_kfunc_type {
@@ -11074,6 +11080,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_CONST_STR;
 
+	if (is_kfunc_arg_map(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_MAP;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11674,6 +11683,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_NULL:
 			continue;
+		case KF_ARG_PTR_TO_MAP:
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
@@ -11890,6 +11900,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_MAP:
+			/* If argument has '__map' suffix expect 'struct bpf_map *' */
+			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
+			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+			fallthrough;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
-- 
2.43.0

