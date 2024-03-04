Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB67C6CC
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592743; cv=none; b=fMpOcfRR/eFTmf91yrplygqb43eWu9aT9PdN4d/cldS/XFZHiqg10bBWAMNpQ+t17qlwJ+fhkVwD+uUQEjO9mWYmk1BOIRguSQGPbmjljwF1/qdz2vc/61uFobAFLxHfUAHEwX3mbVISfgxzaVhJlVs59qIEB8KsMhr7wRcfHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592743; c=relaxed/simple;
	bh=rgeR5HXu6PVieluBU162i6nCCXzBbmEaYvdlsL5tCIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmyeMyBAib2mnDyQHdqknANhUc1vWUzQdSWdW23lkVQYlIjGRwMUskNszWyBIO5woEV7tM+3n0l4DsLk6AepXMdn6oHTJ0HBuVR8JqHz3TfEeX3QyB4xbW0AlXXvVJxCsOtVHEziK73L7w1iQ3NqWhmRYVlpRiPn240YV5TZ0es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9m5jBkQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9m5jBkQ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso32930a12.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592740; x=1710197540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD6I0hZklvWavGPzFQiptXUz9ryuUA4HQRXZZhbveEQ=;
        b=N9m5jBkQT7oPz4TgM4oJKOKa61kWPH7W9hvZjdKo78n6/fNpdeCFI0kgLCJ3MGHK65
         cPtdo7EPPBYiS5pYW3Cp6xjI0BEHohRbNiTqlujLmGsT2sUH32SFNLsVMwXEx2Wn4phE
         XrZ78kpNaEBgIApIMFn86kdyiI0WsWbfA+VzGgcJcsjTLYe9S2iL366+TlEuqexWSu7S
         ncMSylHBx1xJqRu0OEFKCPUcATMrrP+0R3wMehxL4nlQrUgm6xX08YDzJZ9NW8aRbwri
         xuXrH+ZV0KKyoU2k3/5+WnpnvALKeppDeR0G+O1qc5lNYb1I3wXtTwAG6N0ZwgwTKemB
         nlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592740; x=1710197540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD6I0hZklvWavGPzFQiptXUz9ryuUA4HQRXZZhbveEQ=;
        b=XgbBYDXMFCT1M95AKHFnLoW7wU1Z9IPGt4p+zagYCQeilgUGtwb7iDGOwCt5wTzxhs
         DDCpjPSKi1rSHsJxOUtIe1B1nmqJcPbOfrY0QYCtrGiPK3tT60rdvfZ5XPBUPanA2yF0
         AyVdeMh8fWqZ1tAJcpmq6BG5UXo9OSCNoEp2qop2rwVyIm50Z9274kRzwmdQhiFYQy6s
         ezX/tYkVsA5yyKRoerRCg+FOH4fPLKwU73kSX+P0QXt9iDlZ0wKa9r4BgeUUsQ/qLtB0
         d5Q45AdOuP0j5Dnig1//RxWkC1uSVmYATU5EgWBr0yOC6nJ6lBJuJjont0iBAnlwx+6J
         OK4w==
X-Gm-Message-State: AOJu0YyB/iuBJSIxR5xkhtuET6f0OGc8IMtfzz5BeIjc1YjCCkAhV4Rh
	zfkUpmpyjPUafdTr4ccC9wI4YfSuSOgcJ2aMj3S0cyCGyrBBQXQUlYJrYQvZ
X-Google-Smtp-Source: AGHT+IGb+FrI3+cKGVuARdasJN2MBQYW7adUbqqhUKpRCyhvVwmg8A2f+ZzzeKRuIO/DCEywhavEPA==
X-Received: by 2002:a17:906:4108:b0:a45:4416:1fa4 with SMTP id j8-20020a170906410800b00a4544161fa4mr2784010ejk.40.1709592740408;
        Mon, 04 Mar 2024 14:52:20 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:19 -0800 (PST)
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
Subject: [PATCH bpf-next v3 10/15] libbpf: replace elf_state->st_ops_* fields with SEC_ST_OPS sec_type
Date: Tue,  5 Mar 2024 00:51:51 +0200
Message-ID: <20240304225156.24765-11-eddyz87@gmail.com>
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

The next patch would add two new section names for struct_ops maps.
To make working with multiple struct_ops sections more convenient:
- remove fields like elf_state->st_ops_{shndx,link_shndx};
- mark section descriptions hosting struct_ops as
  elf_sec_desc->sec_type == SEC_ST_OPS;

After these changes struct_ops sections could be processed uniformly
by iterating bpf_object->efile.secs entries.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ce39ae34fec0..4ef3902e65db 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -612,6 +612,7 @@ enum sec_type {
 	SEC_BSS,
 	SEC_DATA,
 	SEC_RODATA,
+	SEC_ST_OPS,
 };
 
 struct elf_sec_desc {
@@ -627,8 +628,6 @@ struct elf_state {
 	Elf *elf;
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
-	Elf_Data *st_ops_data;
-	Elf_Data *st_ops_link_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -637,8 +636,7 @@ struct elf_state {
 	__u32 btf_maps_sec_btf_id;
 	int text_shndx;
 	int symbols_shndx;
-	int st_ops_shndx;
-	int st_ops_link_shndx;
+	bool has_st_ops;
 };
 
 struct usdt_manager;
@@ -1268,7 +1266,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 }
 
 static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
-				int shndx, Elf_Data *data, __u32 map_flags)
+				int shndx, Elf_Data *data)
 {
 	const struct btf_type *type, *datasec;
 	const struct btf_var_secinfo *vsi;
@@ -1330,7 +1328,8 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		map->def.key_size = sizeof(int);
 		map->def.value_size = type->size;
 		map->def.max_entries = 1;
-		map->def.map_flags = map_flags;
+		map->def.map_flags = strcmp(sec_name, STRUCT_OPS_LINK_SEC) == 0
+				   ? BPF_F_LINK : 0;
 
 		map->st_ops = calloc(1, sizeof(*map->st_ops));
 		if (!map->st_ops)
@@ -1365,15 +1364,25 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 
 static int bpf_object_init_struct_ops(struct bpf_object *obj)
 {
-	int err;
+	const char *sec_name;
+	int sec_idx, err;
 
-	err = init_struct_ops_maps(obj, STRUCT_OPS_SEC, obj->efile.st_ops_shndx,
-				   obj->efile.st_ops_data, 0);
-	err = err ?: init_struct_ops_maps(obj, STRUCT_OPS_LINK_SEC,
-					  obj->efile.st_ops_link_shndx,
-					  obj->efile.st_ops_link_data,
-					  BPF_F_LINK);
-	return err;
+	for (sec_idx = 0; sec_idx < obj->efile.sec_cnt; ++sec_idx) {
+		struct elf_sec_desc *desc = &obj->efile.secs[sec_idx];
+
+		if (desc->sec_type != SEC_ST_OPS)
+			continue;
+
+		sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
+		if (!sec_name)
+			return -LIBBPF_ERRNO__FORMAT;
+
+		err = init_struct_ops_maps(obj, sec_name, sec_idx, desc->data);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static struct bpf_object *bpf_object__new(const char *path,
@@ -1411,8 +1420,6 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
-	obj->efile.st_ops_shndx = -1;
-	obj->efile.st_ops_link_shndx = -1;
 	obj->kconfig_map_idx = -1;
 
 	obj->kern_version = get_kernel_version();
@@ -1429,8 +1436,6 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 	elf_end(obj->efile.elf);
 	obj->efile.elf = NULL;
 	obj->efile.symbols = NULL;
-	obj->efile.st_ops_data = NULL;
-	obj->efile.st_ops_link_data = NULL;
 
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt = 0;
@@ -2975,14 +2980,13 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 static bool libbpf_needs_btf(const struct bpf_object *obj)
 {
 	return obj->efile.btf_maps_shndx >= 0 ||
-	       obj->efile.st_ops_shndx >= 0 ||
-	       obj->efile.st_ops_link_shndx >= 0 ||
+	       obj->efile.has_st_ops ||
 	       obj->nr_extern > 0;
 }
 
 static bool kernel_needs_btf(const struct bpf_object *obj)
 {
-	return obj->efile.st_ops_shndx >= 0 || obj->efile.st_ops_link_shndx >= 0;
+	return obj->efile.has_st_ops;
 }
 
 static int bpf_object__init_btf(struct bpf_object *obj,
@@ -3683,12 +3687,12 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->sec_type = SEC_RODATA;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
-			} else if (strcmp(name, STRUCT_OPS_SEC) == 0) {
-				obj->efile.st_ops_data = data;
-				obj->efile.st_ops_shndx = idx;
-			} else if (strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
-				obj->efile.st_ops_link_data = data;
-				obj->efile.st_ops_link_shndx = idx;
+			} else if (strcmp(name, STRUCT_OPS_SEC) == 0 ||
+				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
+				sec_desc->sec_type = SEC_ST_OPS;
+				sec_desc->shdr = sh;
+				sec_desc->data = data;
+				obj->efile.has_st_ops = true;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -7001,12 +7005,12 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 		data = sec_desc->data;
 		idx = shdr->sh_info;
 
-		if (shdr->sh_type != SHT_REL) {
+		if (shdr->sh_type != SHT_REL || idx < 0 || idx >= obj->efile.sec_cnt) {
 			pr_warn("internal error at %d\n", __LINE__);
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
 
-		if (idx == obj->efile.st_ops_shndx || idx == obj->efile.st_ops_link_shndx)
+		if (obj->efile.secs[idx].sec_type == SEC_ST_OPS)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
 			err = bpf_object__collect_map_relos(obj, shdr, data);
-- 
2.43.0

