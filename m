Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBC6088D
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721957; cv=none; b=iMPiXvDr7feXm6msv3VQoZebRoMT3I/foY6v/sbtrml/4nU7AGgyPHrpxEdYdl6ifkkHPccuFIO1U/l00mfW03VrhGxDeX+gtilY3xQW7xDNWMFaasBJ39x/BeVDdNnQm0Gdi9NFI2sNrJXg8fmeMm8/m7ZAZm3xaFRftzIMoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721957; c=relaxed/simple;
	bh=tZnEqdsal/o/rqDi6IjS14FUtucitKe1FHu6ezz6Lwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/BfS9czuDI1rQtOECqOdxZZGNZCNoT5cJqyWVEep+55aCKOS/BQhSIRMzwXuCUDtiq0oNgSyCNDaX0mUF8tAvFxywoz5A3pciFPzUQ7PO6UhWyHE+YfjE2eMn4Z63WrucoxaVpt0Av6jkR4ohPoxaFz+cneNdlMoRcNsmcOdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mms3iSyh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mms3iSyh"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4429c556efso889892066b.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721954; x=1710326754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHgo3qNc7kN9i7+sdJw0Q+Ih9OYuF4pyHBnj+/ISHjw=;
        b=Mms3iSyhTiRA6V+lYcLbafgBRQjYLmhbgCvpdWmoNvzhZIrdLFjKyedXpUeLroDaTD
         ghHi32u3uHiLPRibTRK1dfNlV+A0rZukTj23irnCiUoq0SY03D1+FHqxyrxj/6HHaaZe
         npY6ZjBg4QVVbq3sX+QEaFh+rclRSA04crR1j+7S6q2RbTBb/McIZgR8KdqacgOmCQ28
         6lRSEnksI94h1dcN0dPFbtrJ3wgy39XFNV/QklIc4xCAEjIuH7ddujL6/95WP8Pr3rrN
         HoEh20cmom7/wAvclsWvJZllf6AlLt+kB1B2+lj9kEfRgcGFxXShSy25MzRDi04X4mfI
         jxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721954; x=1710326754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHgo3qNc7kN9i7+sdJw0Q+Ih9OYuF4pyHBnj+/ISHjw=;
        b=uxCg2qHR3R9CGakk5nmHT6b8BFaU1khWKW4yO7OwyCL+wcNEul1WV+vD9SXOH7ShHh
         31Dac/AwnxM1rjj7BFfNw64H/8af7K8thnLsz7Mwj3RQ7buuy3dNghqAvrGwp84pndYk
         DPWNzJ/0JwbeQ0iYyXlfKyvrpv6ysD31aSiB4hMISI4tZRVgpKlMtl1yAX03GI5AGsdY
         1mgWxgElOM5yRxJV4FgrjuyPyi8oP5uw/tUePlU+Zk9KABhaDqdyuUJOgiA0DZprlcl8
         F6z7rhicugdwpLNLt3sGoA8m3e5/52pszWrKnGF3HkvN5Y0jCiyzx2aydsVrTEo4Z3Zh
         0jZA==
X-Gm-Message-State: AOJu0YwvgaRvtsBClfTEaMVNofPdSM0zgilJte0C/Vu63nW0ssDG5Bs+
	fQQycD7I9pDQKizfZDDXDHBySUV8xDAsuEY3LfeVqmvlFj4+FDccbjDnt8ia
X-Google-Smtp-Source: AGHT+IF6JnEvqQ9ZmKxkQpw4iX3L3ZYt3bCDPWLaeOl9DSEHAlRqteB7jbTVKt05JIC9KvDdDzEGYQ==
X-Received: by 2002:a17:906:b24a:b0:a45:a845:7f91 with SMTP id ce10-20020a170906b24a00b00a45a8457f91mr2721473ejb.45.1709721953684;
        Wed, 06 Mar 2024 02:45:53 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:53 -0800 (PST)
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
Subject: [PATCH bpf-next v4 12/15] libbpf: rewrite btf datasec names starting from '?'
Date: Wed,  6 Mar 2024 12:45:26 +0200
Message-ID: <20240306104529.6453-13-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
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
by replacing '?' with '_', e.g.:

    DATASEC ?.struct_ops -> DATASEC _.struct_ops

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/features.c        | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 19 +++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 41 insertions(+), 2 deletions(-)

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
index ec0f508b853d..672fca94ff53 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2869,6 +2869,11 @@ static bool section_have_execinstr(struct bpf_object *obj, int idx)
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
@@ -2878,9 +2883,10 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
+	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag || !has_enum64;
+	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec;
 }
 
 static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
@@ -2892,6 +2898,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
+	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
 	int enum64_placeholder_id = 0;
 	struct btf_type *t;
 	int i, j, vlen;
@@ -2918,7 +2925,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 
 			name = (char *)btf__name_by_offset(btf, t->name_off);
 			while (*name) {
-				if (*name == '.')
+				if (*name == '.' || *name == '?')
 					*name = '_';
 				name++;
 			}
@@ -2933,6 +2940,14 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 				vt = (void *)btf__type_by_id(btf, v->type);
 				m->name_off = vt->name_off;
 			}
+		} else if (!has_qmark_datasec && btf_is_datasec(t) &&
+			   starts_with_qmark(btf__name_by_offset(btf, t->name_off))) {
+			/* replace '?' prefix with '_' for DATASEC names */
+			char *name;
+
+			name = (char *)btf__name_by_offset(btf, t->name_off);
+			if (name[0] == '?')
+				name[0] = '_';
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

