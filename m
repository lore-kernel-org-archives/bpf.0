Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05E7CF0B
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592747; cv=none; b=B/bEeZjxXmk++rfIUWGgbscEfqiEflko4SpPNB4xEYoXYzoFF90a053rerHCg8CXha8iAihKEOMKbBX/Qg3M2vheWfGWMPFji/XjzBGtRj01zIOHdFaE6daKLXULDhS1GEQYYTbsYdN90AjnJLy8dIlXbYMcKAjPbth6RsXBM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592747; c=relaxed/simple;
	bh=UOyotS1BYRsSd5KZlhgQA45wkirr1R6UKLzxX09/m5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRSb1pYTyPU/j2413XgXHEpcDvtChQRMcWjLUzZbJ4l827hN8JPmJoL7dUM3X7+XiyArJZrta/C8iZay5zeWqPGyUtL95VP0oYo+I/RagK880vP8t5u1fpSWnH3GitLFcqb/dtypbb1IdWabgD4FYTyaxPVBpPvgF4n7CJpWG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjDox2rE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjDox2rE"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51344bebe2fso1624524e87.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592743; x=1710197543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J5Oq4avgTnUiue5ull73zk/v5Sx9caqkhc4270Z+44=;
        b=MjDox2rEXD49CdaLePv7bDNGkltAZx7d72cks46blbGmeQgfEgaUEGZ2BEZuuwWb3Y
         mtal0Vr60tkvqOXeQANmkc34WzC0x3/zteGY2Jja/DSFLQF+SfQ7BtslWiPXEnkEMzqO
         20KJEEiGGEA7+dxGzq4XIRhlgPpkkPNnQL8GBg3hVF1txmpENw2iCcSte4AxjYXahvlq
         gRkMSys9A5ZDw/fSCOCcQqTX7SkIggbI/rEiH0IkN9V2sO+DucWFY4bRPWcjXudPVm+e
         fX/hXYHpKMufyz9lz7vWEho6q/Qdpjt3lg2v5IKXejlrT+UXV1WNPu5kBqDl40T/xKDA
         aMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592743; x=1710197543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J5Oq4avgTnUiue5ull73zk/v5Sx9caqkhc4270Z+44=;
        b=M0St60me3qXqog3C2tHGKcIPtJAnbnVsTUIUlcwK/tneyxgSH/z+wgQ8Hw0bhT37fi
         VtXOpKq11+vuDcLu51NQJuFfBYWKJOUxiY/HLhHeqHEmKx+ZMBpHJk8zy03oMSFOppnq
         LTElWhhMG7GLNXWIzezhQjVE1qiXkwUDR4Lz9Vc2OwPpAa/WL2NxfCpY5SeIAhHzdHSC
         6RP96jQnYFp38hM28AsdNNOOSYH7gaZHc4vm6IhNAu3ThFJd7YFS0tbaUwXWre7+txfR
         j4MRD86tOYZYlS4OdeKEaWECYVUcI+b7tmppPqkJqdZdEf9Bhwz4Cd8fXrDjwUu1CLcu
         AaWA==
X-Gm-Message-State: AOJu0YxBuyQwAbIVPqlYKKn+lqJN9S77GH86E074tZj12YV1EGjepfAn
	BKN3rsjydZw2ldl/TT7t3FwiUS2KT/Ak5rtoGxHLENYisLXyGrR+kGJB+IVn
X-Google-Smtp-Source: AGHT+IEtEokyrTwum1XfI45OCvMG7I3qQMV8p3hfeqIqeZy0s3TnBIZ2R8YuP3pZDEysXnXiJCfjFg==
X-Received: by 2002:a05:6512:546:b0:513:1ff9:2bb4 with SMTP id h6-20020a056512054600b005131ff92bb4mr106072lfl.30.1709592743129;
        Mon, 04 Mar 2024 14:52:23 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:22 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 12/15] libbpf: rewrite btf datasec names starting from '?'
Date: Tue,  5 Mar 2024 00:51:53 +0200
Message-ID: <20240304225156.24765-13-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optional struct_ops maps are defined using question mark at the start
of the section name, e.g.:

    SEC("?.struct_ops")
    struct test_ops optional_map = { ... };

This commit teaches libbpf to detect if kernel allows '?' prefix
in datasec names, and if it doesn't then to rewrite such names
by removing '?' prefix and adding ".optional" suffix.
For example:

    DATASEC ?.struct_ops -> DATASEC .struct_ops.optional

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/features.c        | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 30 +++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 6b0738ad7063..4e783cc7fc4b 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -147,6 +147,25 @@ static int probe_kern_btf_datasec(int token_fd)
 					     strs, sizeof(strs), token_fd));
 }
 
+static int probe_kern_btf_qmark_datasec(int token_fd)
+{
+	static const char strs[] = "\0x\0?.data";
+	/* static int a; */
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC ?.data */                            /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs), token_fd));
+}
+
 static int probe_kern_btf_float(int token_fd)
 {
 	static const char strs[] = "\0float";
@@ -534,6 +553,9 @@ static struct kern_feature_desc {
 	[FEAT_ARG_CTX_TAG] = {
 		"kernel-side __arg_ctx tag", probe_kern_arg_ctx_tag,
 	},
+	[FEAT_BTF_QMARK_DATASEC] = {
+		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c0212244bdf7..cf60291db8fd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2874,6 +2874,11 @@ static bool section_have_execinstr(struct bpf_object *obj, int idx)
 	return sh->sh_flags & SHF_EXECINSTR;
 }
 
+static bool starts_with_qmark(const char *s)
+{
+	return s && s[0] == '?';
+}
+
 static bool btf_needs_sanitization(struct bpf_object *obj)
 {
 	bool has_func_global = kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
@@ -2883,9 +2888,10 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
+	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag || !has_enum64;
+	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec;
 }
 
 static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
@@ -2897,6 +2903,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
+	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
 	int enum64_placeholder_id = 0;
 	struct btf_type *t;
 	int i, j, vlen;
@@ -2922,6 +2929,8 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 			char *name;
 
 			name = (char *)btf__name_by_offset(btf, t->name_off);
+			if (*name == '?')
+				*name++ = '_';
 			while (*name) {
 				if (*name == '.')
 					*name = '_';
@@ -2938,6 +2947,25 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 				vt = (void *)btf__type_by_id(btf, v->type);
 				m->name_off = vt->name_off;
 			}
+		} else if (!has_qmark_datasec && btf_is_datasec(t) &&
+			   starts_with_qmark(btf__name_by_offset(btf, t->name_off))) {
+			/* remove '?' prefix and add '.optional' suffix for
+			 * DATASEC names staring from '?':
+			 *
+			 *   DATASEC ?.foo -> DATASEC .foo.optional
+			 */
+			const char *name;
+			char buf[256];
+			int str;
+
+			name = btf__name_by_offset(btf, t->name_off);
+			snprintf(buf, sizeof(buf), "%s.optional", &name[1] /* skip '?' */);
+			str = btf__add_str(btf, buf);
+			if (str < 0)
+				return str;
+
+			t = (struct btf_type *)btf__type_by_id(btf, i);
+			t->name_off = str;
 		} else if (!has_func && btf_is_func_proto(t)) {
 			/* replace FUNC_PROTO with ENUM */
 			vlen = btf_vlen(t);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ad936ac5e639..864b36177424 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -374,6 +374,8 @@ enum kern_feature_id {
 	FEAT_UPROBE_MULTI_LINK,
 	/* Kernel supports arg:ctx tag (__arg_ctx) for global subprogs natively */
 	FEAT_ARG_CTX_TAG,
+	/* Kernel supports '?' at the front of datasec names */
+	FEAT_BTF_QMARK_DATASEC,
 	__FEAT_CNT,
 };
 
-- 
2.43.0

