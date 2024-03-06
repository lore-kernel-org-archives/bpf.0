Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA15604A7
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721955; cv=none; b=kqUMsYETfUn4NfKrFAHi4afaD7OM94j1EPdH2xuxwdje8iZxIOyY2nuEy+h3zSHzDqsXUQ2ssIE0UcrzA86/My9W/bfAvxj0haIk93HrpbrggtHo7ucg/PrMYM/cLKWjvLdC5FQfVhYXPAgxZ0vHvKBnc8vUGvqcl6dcq/IGeSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721955; c=relaxed/simple;
	bh=liT2Bf2pYMcGiLNQzN3/ZVAPOpSd4cYypNOz1rx5Ruo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urFoMPJew8kscG06SZSpgav9ub170ntAyavzDjMCeUWZmLQ13TdbMLfT07e+z6qalJSTS6seGqFp0l58HmANjY/MT/2mXfPaOP25l4ogDXpMDKrMrwgxa0gvV8WNYred+k6yVTtSknhjuL4UN2MD15j2bwxn4aXQ9QS+KOsLGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJO40U//; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJO40U//"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-567fbbd723cso222547a12.3
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721951; x=1710326751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD4CwcZkWrmekfCA2TcuuBFUVuij7VezMqcO0//4liQ=;
        b=DJO40U//y3FobJHDqfHXEd034p0jFramAnbftN1VVeLmnf1V2t6OlTMd+UQl2qiBwt
         sDZ9KTFzlvhyA1QEhucUbjPS6z8hTRZzt9N8uOZCVi05S8X5+y82T/MBkvhaLxlI5iql
         tkH8Hy4fny8I/lTxceDfAuzJVBAm9fP3znmV5AjqKJRpSRolKssnNNYe3vS9OVKaiGvc
         ArNuhcrkfV4RBHaYHeMoa7+959CbTJJPUr9Cl9SzIbt5gyzCHa39CM3wVn2oZ1hvoTB8
         s142MegH3YVM1DX791RTz3wvn+TNPGXBgi1fXovYXFRJvoWxv5ewFcrS9t08076Z+Uap
         DnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721951; x=1710326751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD4CwcZkWrmekfCA2TcuuBFUVuij7VezMqcO0//4liQ=;
        b=U4XfHOLoMDkLcCDkldCuG3oxqM4Us9d+QB5h4qBwiu/7tSwJ6omvIvjT+x+haZmIs4
         M0OtOpUSlFJy5qP6s/BXMq/tO/JnbtM+KevBryP+kxP1X4aHwh4ToG/DctnXWuEfaNQ/
         6p597W/IzZ8A87dRpOTB7z3joaaUwSNo3OdD/yN8X9NA4vzLlerCJWVlHokpu8F+nCf+
         Ee5h/mQ8ONaHvMWsw139ipog2Cq6I7vQjDPzxoKJsuJ1//NbWvKcaD/iqEwO2TM0i4DH
         ZU6MalLzaoC1EiXVueTHcwxxjzlCMmoeLmzIp8AM4R1fNkA2K1nPjJzVVPro3mOXTHKY
         8WFQ==
X-Gm-Message-State: AOJu0YzFC6ifbqR2bXhsxhFWlYoexIW0+0b0opdqUL68iDe9Voa/lRSm
	qpaU8OnlkCNvRFD+DqoKm6KdT76iVSB+f5goLAdln61QuDbaN7VXvuK5ZFW4
X-Google-Smtp-Source: AGHT+IHzD6NUj8aLdE/2DC0NbrDALtmfkuI4JxElnyjTmKC+OP3dFWyontdry8wyWT5t/+4Fhqiwjw==
X-Received: by 2002:a17:906:714f:b0:a3f:4596:c3c8 with SMTP id z15-20020a170906714f00b00a3f4596c3c8mr9509729ejj.53.1709721951408;
        Wed, 06 Mar 2024 02:45:51 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:51 -0800 (PST)
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
Subject: [PATCH bpf-next v4 10/15] libbpf: replace elf_state->st_ops_* fields with SEC_ST_OPS sec_type
Date: Wed,  6 Mar 2024 12:45:24 +0200
Message-ID: <20240306104529.6453-11-eddyz87@gmail.com>
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

The next patch would add two new section names for struct_ops maps.
To make working with multiple struct_ops sections more convenient:
- remove fields like elf_state->st_ops_{shndx,link_shndx};
- mark section descriptions hosting struct_ops as
  elf_sec_desc->sec_type == SEC_ST_OPS;

After these changes struct_ops sections could be processed uniformly
by iterating bpf_object->efile.secs entries.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 61 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 595c287d84ef..cff72de42bf4 100644
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
@@ -1266,7 +1264,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 }
 
 static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
-				int shndx, Elf_Data *data, __u32 map_flags)
+				int shndx, Elf_Data *data)
 {
 	const struct btf_type *type, *datasec;
 	const struct btf_var_secinfo *vsi;
@@ -1328,7 +1326,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		map->def.key_size = sizeof(int);
 		map->def.value_size = type->size;
 		map->def.max_entries = 1;
-		map->def.map_flags = map_flags;
+		map->def.map_flags = strcmp(sec_name, STRUCT_OPS_LINK_SEC) == 0 ? BPF_F_LINK : 0;
 
 		map->st_ops = calloc(1, sizeof(*map->st_ops));
 		if (!map->st_ops)
@@ -1363,15 +1361,25 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 
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
@@ -1409,8 +1417,6 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
-	obj->efile.st_ops_shndx = -1;
-	obj->efile.st_ops_link_shndx = -1;
 	obj->kconfig_map_idx = -1;
 
 	obj->kern_version = get_kernel_version();
@@ -1427,8 +1433,6 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 	elf_end(obj->efile.elf);
 	obj->efile.elf = NULL;
 	obj->efile.symbols = NULL;
-	obj->efile.st_ops_data = NULL;
-	obj->efile.st_ops_link_data = NULL;
 
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt = 0;
@@ -2973,14 +2977,13 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
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
@@ -3681,12 +3684,12 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -6999,12 +7002,12 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
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

