Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8893C28
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592731; cv=none; b=DMYWvZisxJq7M2U09sb131kynKxUiRyTQ79G3egzudge8BuphkKo/im5sUlQoFVlOQzH6bpkj51td2kGkKWz00eNS1W6XgBthfD7oIlnbojEGC9xivC5F+dbMBuJotw6ADG/iFgPe23uQgeWD7vo1vLIJtKWKydV+kiDuPceXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592731; c=relaxed/simple;
	bh=u/1jTp2CttH5gxlhCHQfZKsq9FO8kAJbKLWIR91fUBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK7gjA1+sKzyN4epOBR5uXBKo828Tmxcr5Tw2ywsPXeEHsPb2fNl6Y9julAhBSp8k1Ud8ByJSBBFYpuiDcb/CiXULbVGsC7cJ2RpkUV/zZ1Rz1u8/BqKhaMCr0MX4Cy/jHEBuNqKCMuu/MUitMhIzAcXc0fUEfWdVoF0DBEOWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvoDchRM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvoDchRM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4595bd5f8cso51405766b.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592728; x=1710197528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ghBbmU7JgmzNE0IDgqQ93JxAVATdz4P5/PxXkAkYZ4=;
        b=HvoDchRM3kczg3QwlSjRzambSyVb8P6r2b4ykCA2t+zMCtpDliHdgNvoXOPZkEJkNE
         xCeVse0MZhsnt7wPhb8kDvZeOksnVITNQzko3GbbM8DSWt7O6zdpcAjA7CpG8tM8JnX5
         +x5VQD4bvPopDdKC2Fa1ExXXQ2Giejw/yQA/5YlGuJMDWm8Vck4EM4RDQ6w3M6+R+REm
         WQccWqedMnXZHuH4gx+jeDVvoZCOVGHwP6jwTwhWTxx68iqwkTdRNNm2RP8FRc+XmVUO
         cQ6fKR/Ty7/iGTzIU8t0yLp1Vay6Donbw5IcLvgF+ou8J9IoCG+0dyuL7vMQVW1k+eQC
         H2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592728; x=1710197528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ghBbmU7JgmzNE0IDgqQ93JxAVATdz4P5/PxXkAkYZ4=;
        b=CrcjWemQCMP2rNUWqWPT1a6OYY/qyW8MlQsZG677bUf9jjpi4Gz5l+mrjQoAjdQep7
         KhQTmgBQq570W4pNhyZnrvH4RPTHL8NjzqH24qaDWnhsMRzvfP4SlAgcIZo7cPjcmVVI
         IyeAced0smgbsgtvjWuNxq2zCrIdpxQFFwrSydp4+hSQ/VTHdvAT5cTqnhbiCCIjhR/E
         gOx1N6w9ayvdwhaUhkbq3Hjm8E1hEnwJ28W9ZyJsz0ojWHHZt2fBcZXz1e+S9HGp/Fn3
         2kqxHWbgu5R0VmGCFgbramJF8hIRhb2II2zY2IgTMGj1ukbBWphvVwIBMmJlXkc4a3b+
         0nwQ==
X-Gm-Message-State: AOJu0YwgeFUwQjqlcBgAoZ5jHo5vWiyx4AoXOGtd1ciSvz5qn79gcXCe
	rqLiNLoAtS9I76afEtP907jPvlj+0MArin8FyxEOOwuvU3zez2o2C38DErXl
X-Google-Smtp-Source: AGHT+IGAb4EgNl97zuRuvVQP62LAqq3MLOW0U7WGCOfbBuLgeguI7qKwlwcrmmhk3G8PqTVNQLRNEA==
X-Received: by 2002:a17:906:1153:b0:a44:86d4:707e with SMTP id i19-20020a170906115300b00a4486d4707emr6836454eja.29.1709592727684;
        Mon, 04 Mar 2024 14:52:07 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:07 -0800 (PST)
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
Subject: [PATCH bpf-next v3 01/15] libbpf: allow version suffixes (___smth) for struct_ops types
Date: Tue,  5 Mar 2024 00:51:42 +0200
Message-ID: <20240304225156.24765-2-eddyz87@gmail.com>
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

E.g. allow the following struct_ops definitions:

    struct bpf_testmod_ops___v1 { int (*test)(void); };
    struct bpf_testmod_ops___v2 { int (*test)(void); };

    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v1 a = { .test = ... }
    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v2 b = { .test = ... }

Where both bpf_testmod_ops__v1 and bpf_testmod_ops__v2 would be
resolved as 'struct bpf_testmod_ops' from kernel BTF.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6c2979f1b471..e2a4c409980b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -948,7 +948,7 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind);
 
 static int
-find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
+find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 			   struct module_btf **mod_btf,
 			   const struct btf_type **type, __u32 *type_id,
 			   const struct btf_type **vtype, __u32 *vtype_id,
@@ -958,8 +958,12 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
 	const struct btf_member *kern_data_member;
 	struct btf *btf;
 	__s32 kern_vtype_id, kern_type_id;
+	char tname[256];
 	__u32 i;
 
+	snprintf(tname, sizeof(tname), "%.*s",
+		 (int)bpf_core_essential_name_len(tname_raw), tname_raw);
+
 	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
 					&btf, mod_btf);
 	if (kern_type_id < 0) {
-- 
2.43.0

