Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFE3932C3
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845479; cv=none; b=dA1ez9+twdOHNMCWXyWg2PvBcs32zwK0uXZStOesrWyAn33XAuk5U/oNELyVVmT1/pTbjw0GutdDBXpwe5bvVSy2SvJyHwWghfYbgjP+3sncohr0EJlO7PTGWHHXJsZOnUkfGmKywhv3jd5tnXnYNXXp2Yk5+l+tbJHPTBQFMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845479; c=relaxed/simple;
	bh=PEMagL3mLgUbTuGxKztEN0bameyjWAmZV5cU8WLuseI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6sMrVo+F/L5/mMmL8UzqOFQixdqkMYLH9foAjAG8/YxloekxyzI9Wj8RPMT0h8tmdlBhC5lv1F9BZEhso1XuozrD5slPtgYHk6zdo3ELa1dVh23raycEi3+n2ip6rpdBp+wPxO5t2sG+gOzd6rCXLFZfbr53AuphMNbJoHETSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkZgdOY6; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkZgdOY6"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fcb9d4b33so958483f8f.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845476; x=1787450276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BG4qz6jTNkyaOKyV5eTnTjsTD3XfNZYK/5zqAUZmzck=;
        b=FkZgdOY67tqJW4Ls9om0jkxuPhvx8osgYZquVUsYqQNSWrt+vr5YtrTp68ZGHih4X2
         x6QTzTmzN4LiUwYjDoJ8/pMKPt8Sw9fNLAl4pTgMMbHcbnBAqglSGFjf1FtQ4WNzkcA/
         nykTcsFJ296KG7lJp3WsCgDa8sN8el4t5t4t2qSiZWd73cIHRsCkFDVob67x88Ups5xd
         Q6U/DdKOfD6l8j/DQgyIDvykXsr3XCRjF0QZHyuvk0nQq7yG4a+PdMe/j/4nVl7zNUeR
         PvGnhz6MpxuJiX8swmGTZggvqp5Sin6U6IYRHhFyoz2XNyNkXKEs0I0+HGR4sA9j5KIP
         9PiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845476; x=1787450276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BG4qz6jTNkyaOKyV5eTnTjsTD3XfNZYK/5zqAUZmzck=;
        b=o+vnk5A/rrTO2cnw1qbfAFV99wmJx/LJgBSWxH2B/89vKtUW5IhHiOZ+Yi87wcIxMD
         RjsmJQT6SSiYTip5PjBfvOdQ6t5LKWfE+5cuoZ1So90piG3Wnvuams68W5l/vAJHobMI
         BqgJjGB4IZRXbopmnR8w9I8CGhKeH0U6LD7/AxPPVg0RLimcjNmFODu2HIQieNTVYEBo
         HDEJwKYgSfJpnL3FhHyqHZSSTLX1PlTbfYpXSkw0Rar9+17vei/OKW5JsDiFzFTmVm5a
         OIkZOsevuvAmX+ox7OuI14fGkZJ/uSEb4wNjpVrMiCR+k38se7N9K2eG2+mRL/PSSYO9
         NRPQ==
X-Gm-Message-State: AOJu0YwFCw/lHu/HELew+WRVWX4FQ0L7k+LZLB7vfavpo5CpTogLxWsW
	xIs4IikrH9Meti/BLEqC52uV7REmsFsn3c96R46yUwZF5Qj86lb8IW8MRSJ1EhuV
X-Gm-Gg: AR+sD13q6h94lz4LmcpnZD/87fTD3ZeJvDauIScvlOcNYWmiNLSN+N0JeKfW6E82aJR
	6AyiYeHrsWHG5zZKY1n/NhNgYgtrOWErEgpnFZLDj93pW7QnVmliwNH78X/5cO26vDrAYUKzl7+
	BaVPoE0liATTFIigww8nRkKv4Qol5CrYXwIPAzFw0mt+qI/oEl1I65wBS4hlEtuwx0c/X0dLfNP
	nx90qohxwvVFIRxI6rP9Wrjrb7gCmCThkdptCZAnMIRKJb5vW3oFmkGy68/U/z/HpRKPM1JMbus
	PpPibtyVTHB6uSUT/Fq5RovtPrI5VIaKBIfD1QFRstXdtf38C08z2T6q/KVrG8G1BYdG7ofnsur
	Lges1LiRG6Pj2T4U345xIvVrkZbCSoFkJkm31OjWl6I61tDLwbTmDWAfdGjZO7t84809igBzX4F
	U98U33j3RhhgZEBbQhqASZwh67QwRvXe74Fhnn3+UL9qYsmbzRcBqFwQdRJaVOhnOQMs1q3hGsT
	B85BnI6cmHCTy2H8cxFd+nBEyEd486iBNKWXb0g7D2eIHhJMCjLnu0v8NdRFwqyiHRsVub3nEJK
	O5Kxhas+UxmmT7NwMbs8N0kzZrY=
X-Received: by 2002:a5d:56c1:0:b0:481:57f7:6015 with SMTP id ffacd0b85a97d-481606fbc2cmr19758559f8f.6.1786845475890;
        Sat, 15 Aug 2026 18:57:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c07d2sm20721341f8f.30.2026.08.15.18.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/14] bpf: Correct kfunc argument diagnostics
Date: Sun, 16 Aug 2026 03:57:34 +0200
Message-ID: <20260816015746.2632990-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4612; i=memxor@gmail.com; h=from:subject; bh=PEMagL3mLgUbTuGxKztEN0bameyjWAmZV5cU8WLuseI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQixXOy8gn2kXa6WvoUde4KTEiV/mSe889WPbg7771 U4bs992lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJOxxkZ2m5x/RGey3hbLnR1 uONuhQy2lFdfZ99ZE3fzwhq5qKiXexj+54scedFUv6XSd3/DtLATGtEGS8WYzE/rvJLW2t09e+s tdgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The Call Type Safety diagnostics mishandle three kfunc argument classes.

BTF type ID 0 represents void, but btf_show_name() also uses zero to end
type traversal. A pointer that resolves to void therefore loses its pointee
name and is rendered as "()". End traversal directly for concrete terminal
types, but resolve referenced types before testing for ID zero, and name the
void terminal type explicitly. Format the complete parameter pointer type
for nullable kfunc arguments, so void pointers are reported as (void *).

Also add the missing structured report when an __szk memory-size argument is
not a verifier-known constant. Describe the generic bpf_refcount_acquire()
contract without deriving an object type from its void pointer prototype.

Link: https://lore.kernel.org/bpf/668871823f90f69896d3db27b56db2f53e481162.camel@gmail.com/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c      |  8 ++++----
 kernel/bpf/verifier.c | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5b9d767895c9..6967d48bba49 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1169,19 +1169,19 @@ static const char *btf_show_name(struct btf_show *show)
 			id = t->type;
 			break;
 		default:
-			id = 0;
-			break;
+			goto resolved;
 		}
+		t = btf_type_skip_qualifiers(show->btf, id);
 		if (!id)
 			break;
-		t = btf_type_skip_qualifiers(show->btf, id);
 	}
 	/* We may not be able to represent this type; bail to be safe */
 	if (i == BTF_SHOW_MAX_ITER)
 		return "";
 
+resolved:
 	if (!name)
-		name = btf_name_by_offset(show->btf, t->name_off);
+		name = btf_type_is_void(t) ? "void" : btf_name_by_offset(show->btf, t->name_off);
 
 	switch (BTF_INFO_KIND(t->info)) {
 	case BTF_KIND_STRUCT:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7ef324e384f4..da2ec0655b17 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12653,12 +12653,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		    !type_may_be_null(kf_arg_type)) {
 			const char *expected_type;
 
-			expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
+			expected_type = bpf_diag_fmt_btf_type(env, btf, args[i].type);
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
 				reg_arg_name(env, argno));
 			bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
 					      "Add a NULL check and call the kfunc only on the non-NULL path.",
-					      "the pointer may be NULL, but this kfunc requires a non-NULL pointer to %s",
+					      "the pointer may be NULL, but this kfunc requires a non-NULL value of type %s",
 					      expected_type);
 			return -EACCES;
 		}
@@ -13095,8 +13095,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		case KF_ARG_CONST_MEM_SIZE:
 			ret = process_const_arg(env, reg, argno, meta);
-			if (ret < 0)
+			if (ret < 0) {
+				if (ret == -EINVAL)
+					bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							      "Pass a compile-time constant or a value the verifier can prove is constant at this call.",
+							      "the kfunc requires this memory size to be a verifier-known constant, but %s is variable on this path",
+							      reg_arg_name(env, argno));
 				return ret;
+			}
 			fallthrough;
 		case KF_ARG_MEM_SIZE:
 		{
@@ -13160,15 +13166,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 			if (!type_is_ptr_alloc_obj(reg->type)) {
-				const char *expected_type;
-
-				expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
 				verbose(env, "%s is neither owning or non-owning ref\n",
 					reg_arg_name(env, argno));
 				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass a pointer returned by the matching BPF object allocation or lookup operation for this kfunc.",
-						      "the kfunc expects a pointer to BPF-managed refcounted object type %s, but this argument is not such an object pointer",
-						      expected_type);
+						      "Pass an owning or non-owning pointer to a BPF-managed object containing a bpf_refcount field.",
+						      "the kfunc expects a pointer to a BPF-managed refcounted object, but %s is %s",
+						      reg_arg_name(env, argno),
+						      bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 			if (!type_is_non_owning_ref(reg->type))
-- 
2.53.0

