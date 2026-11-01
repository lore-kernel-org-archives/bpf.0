Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559987;
	b=lO95YikKafQR28PoCb0WdO58ufiFDVaSU/XxV4jVz42IUBao7vtbUw7J0WAUcAwkaVmx
	 SfneIB+9rIIXlQzT8USxmzoU5/yyP76dZJ5IQ7tJVVZQiJp7Cj4lb1GmqdatwD6tPIud6
	 m9HgaeV3UnIa21noZG/QIrWDvwEsaqVU5jsXf3bFKsQaq/1hGz9NtYI+remsWzfojKN9Z
	 7wiFJhFGs+RatSZf45jZVqW4odmi5VevAA+ojrhqGs4Wo23MJlriFVpIloZw8aY/Enn/4
	 9Y5RAHafm85ZLsYjISy+3Kpc2WjnlP+VlUV++LM71hskt8FmSnU+imEZPprRvukbm7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kYlJ0iN3+bIdrZcrpJOswolp96cgw2ook/zkH9WCZzs=;
	b=VUCl8Q8SihWinMcMm5Cx2BYcVk7MEDc+bSf/TgfLd6eWpXSyx6ZEEhzQiVQpb6U0IPON
	 lWO/WtEPNz6cmy4msHpOTSVyxuhDW74I+QD+fD1e1BOjD2jTEm4H4xGB0NFGK4HpXJnPK
	 FBv7cZ+vKBZLRD3fxuB+lEdtYg9FishE82a0oBWZSlOk8wguAPStA81k8HZ90F4WFH2HH
	 iZugvYeKmDzmsOck+2PEFue2FE2qKAr9ERmc2VYHTeq6ivtvjuFS3oPRtbaEm6a/w308p
	 Toz68jZLGZ24sNElAyWI9vfvhsqWdandRjr/GQk5AdTrHqpD8myii3fK6N5ACb8l3UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0FtctUmA;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46842606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46842606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0FtctUmA
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso12922175ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559986; x=1794164786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYlJ0iN3+bIdrZcrpJOswolp96cgw2ook/zkH9WCZzs=;
        b=0FtctUmAdZi1fMWH/ht4EDDuwsiRBMbwzDpgZhFOZ0J8n3QgsuPiOi6+6dKVyWT60g
         AsFjM0kdn/N36E6Ww2osLXBEB/Zk5hfZbyr1pj2oinw8EbESAC1rs1AFqY+RmKjUCwYk
         GUsjP5C4kNWJDOMnKjMeUsUlfowOJC3vB0W9Eif/rRUo6qYxOziMTStdFBOHMQbC31mt
         qMaUvnyJ7YYsfoAoEcegvspToHzmSc1mi/76F2HVQe+Rx+1VMMAp1zMre9bSITy0HRnn
         lRsA5mi2ijdN7YMObWIZOjpycwcsM4MA1uj/koDEXO3c+6Y0jxPsMyErcJxkAD/4Hs6U
         2lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559986; x=1794164786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kYlJ0iN3+bIdrZcrpJOswolp96cgw2ook/zkH9WCZzs=;
        b=jZC2tQME+Sztg/Irfytte4zZNmDB1Cm/YNM3PNDo1kCW3JS2lGlDT3GS2kiRMBqZXW
         vbdGJc1dII7eADH6DGkxroyvl9Mb/GokzaaH/5cp+xRZicKbzWDmlNPp0laz8JfrdKUA
         y39acianQ5fmBaxqg0UMD3bVZT1V4wgq0Xe4dpSF6yIOKAfubZH0YIskAEFdnaTeddHw
         uF0VLaxadPi0TFo5ejcctgfh7hg8YgXg1lkr8PuT6ipysKu3X4L1O/Hpo1pDN/i51uKC
         rJPMtwVOOVj/yPWukLmDmdsO4pohOYUY5itt4Qez9YBCiqPI3of7FvAzpnPGQDtlTlMc
         umNg==
X-Gm-Message-State: APuU4Z+k0/RuOli4KMxVG15KLE5tyxEG1Tgfj/6QzIcrLjLVfJSA0i8A
	Q1I+jIRzOL3N/GU2Gtx01DfChQ4kj95pWi5I94fYiMsPjXdlffotuXC8oQoHtQ==
X-Gm-Gg: AYBFou2MSZVDfaVdNg8wnko2Uuj90BugZyqsC6cC5PD01MwTvSlIOesNC1pqRphFFHC
	9sBYndYBnz0bdiCpH2mAT6ypjcveTVqvF+27hFw+9V24eFq02a1vvQlJXlg9RldWJAPiHhhf6ND
	FKXsYncNfUnRDThyKvmuelFZW22jPJ65pAklPdTUd2SWJTIjvQgxHpZ1i/2QE+TSMPNim9hesVa
	HiSr15ixDId0URpz+eItZ7KAbQ/vkYrVCPRoorNVRY5wLBnK8tWirajDDXTTQZDM8YsG4lUbCWI
	bwl+XOeAOwK/Kf/9c1q+Hn7WCkLz9W62JPe3kmN8zs2CBd2Q4MsU75Z1OcD1nLn9NSWsrteGI/v
	s39F1+cCX8TZKSxO/yydrdsbsC4vE1Vun0K21exWDpjk6wTbv9Cuc1iibIy0FEjk7DlOVgGnUcM
	5gR43x2sPzqEseRqNGJ3PZS0OBkBVAF899Ux8S+md0csrOoS5I2F8yNBGEdm+UiGcXSswOX1XdC
	NUCNOfZA37VMQLKoPeif8HNLeyVw18EOjskHtPw5P0zSP0AGZyJH03/BLC8ujCKv9+t0c8NCawH
	qAK5VpdbLBA0zJFVaZr+U5IF1JhR0Yy/Gmag0P7sOsrwMj58+vZzmwH8vYexvkpbeXsCRDlTcst
	AD5uVxGfLqhnrI3j+4+lnjrY58Euh83JF+gigs2dGq7IN1546ecRGDJU719szWdcU3KvXsh5+mA
	==
X-Received: by 2002:a17:902:e88f:b0:2e8:6540:11b0 with SMTP id d9443c01a7336-2eb36464449mr81099925ad.38.1793559986339;
        Sun, 01 Nov 2026 11:06:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392ae011sm18689745ad.69.2026.11.01.11.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:25 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 08/27] bpf: Reject memory for kfunc projection type args
Date: Sun,  1 Nov 2026 19:05:16 +0000
Message-ID: <20261101190535.1454146-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

struct __sk_buff and struct xdp_md are projection types of struct sk_buff
and struct xdp_buff. A kfunc that takes a projection type casts the
argument to the underlying type. When the projection type is the ctx type
of the prog, the verifier accepts only the ctx. In other progs,
process_arg_ptr_to_btf_id() accepts a pointer to the underlying type.

But this function identifies the underlying type only by its name. A struct
of the same name in prog BTF also matches. Its objects are memory of the
prog. This test also ignores the offset of the register. Thus the kfunc
uses memory of the prog, or the middle of an skb, as an skb.

Accept the underlying type only from kernel BTF, and only at offset 0. A
prog that passes an skb of the kernel sees no change.

struct xdp_md has only scalar members. Thus in a prog with another ctx
type, resolve_func_arg_type() changes ARG_PTR_TO_BTF_ID to memory, and the
verifier accepts memory of the prog. Keep ARG_PTR_TO_BTF_ID for projection
types. The first Fixes tag is for this change. That commit merged the
conntrack kfunc sets of two prog types with different ctx types. Thus
bpf_xdp_ct_{alloc,lookup}() can use memory of the prog as an xdp_buff.

Fixes: a4703e318432 ("bpf: Switch to new kfunc flags infrastructure")
Fixes: ec209ad86324 ("bpf: verifier: Relax caller requirements for kfunc projection type args")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/btf.c      |  9 +++++++++
 kernel/bpf/verifier.c | 16 +++++++++++++---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index a18254b7521b..87fad4076f0e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -631,6 +631,7 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
 struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
+bool btf_is_projection_type(const char *pname);
 bool btf_is_projection_of(const char *pname, const char *tname);
 bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			   const struct btf_type *t, enum bpf_prog_type prog_type,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1be30487a2fa..fe24e459c1b1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6590,6 +6590,15 @@ static int find_kern_ctx_type_id(enum bpf_prog_type prog_type)
 	return ctx_type->type;
 }
 
+/*
+ * A projection type is the view that programs have of a kernel object with
+ * another layout: see btf_is_projection_of() for the two types behind them.
+ */
+bool btf_is_projection_type(const char *pname)
+{
+	return strcmp(pname, "__sk_buff") == 0 || strcmp(pname, "xdp_md") == 0;
+}
+
 bool btf_is_projection_of(const char *pname, const char *tname)
 {
 	if (strcmp(pname, "__sk_buff") == 0 && strcmp(tname, "sk_buff") == 0)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26a5ee0708a3..53272f50226a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13585,7 +13585,13 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 	ref_t = btf_type_skip_modifiers(btf, ref_id, &ref_id);
 	ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-	if (!btf_type_is_scalar_struct(env, btf, ref_t))
+	/*
+	 * A kfunc that takes a projection type (ie. xdp_md) casts it to the
+	 * underlying type. So memory of the program cannot stand in for it,
+	 * even if the projection type holds only scalars.
+	 */
+	if (btf_is_projection_type(ref_tname) ||
+	    !btf_type_is_scalar_struct(env, btf, ref_t))
 		return 0;
 
 	resolve_ret = btf_resolve_size(btf, ref_t, arg_size);
@@ -14340,9 +14346,13 @@ static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_re
 
 	/* If kfunc is accepting a projection type (ie. __sk_buff), it cannot
 	 * actually use it -- it must cast to the underlying type. So we allow
-	 * caller to pass in the underlying type.
+	 * caller to pass in the underlying type. Only kernel BTF has that type:
+	 * a type of the same name in the BTF of the program is program memory.
+	 * And only a pointer to the start of the object points to that type.
 	 */
-	taking_projection = is_kfunc(meta) && btf_is_projection_of(arg_tname, reg_tname);
+	taking_projection = is_kfunc(meta) && btf_is_kernel(reg_btf) &&
+			    !reg->var_off.value &&
+			    btf_is_projection_of(arg_tname, reg_tname);
 	if (!taking_projection && !struct_same) {
 		verbose(env, "%s %s expected pointer to %s %s but %s has a pointer to %s %s\n",
 			meta->func_name, reg_arg_name(env, argno),
-- 
2.55.0

