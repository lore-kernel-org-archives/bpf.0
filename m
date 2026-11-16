Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842885;
	b=Ef4c7hAK5kkiTMsPPZBejXR78x9BZEtN47r1Tg1l67bNKErxmkJVsL78qWAZX4WIFcxr
	 qT7gPGiW//xLDRBiiUqbYTtezkoc31ZVquX2V/qoBnqIn/q4uJbNR0acVd0JMH7v7VYgR
	 5/EeTrBPxMdj1DNVFMr4EF8AyVDj9OdUnM/DAUGHOFB0y6nLF/T510V2JA7xz2fzLAYRI
	 3wT/EwFeZfJ3cnnvxLKA6g5A9TSvsi5bN49o72MCZGUvFMl2LBmz/uFB6rItfbvYrHng3
	 f9JRgYaHy/lFthMucKrDiR84ujSXRoXZl3p4xT/M+dSMaMil4Fcn1knVPI68lpO6sPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/Rl6rpqCgINMnR0K8FGj1qRIflM9SM/kIkQeoCq0DYE=;
	b=TpYMOQRlyzI33+We6945sv730pkSVzhuM6najXJiD43OMSegO4gXgDbdFijCtRSU+FoY
	 v8t82I66HbQxsc7oyV55lJKSYI5SU6BOsVfNriDV1hmDoYH8nPu2hb4JgFPklM/M4U5NO
	 Xm2pDN0qZVtgGYVxhTuCqNYNZF9iM55s7qWvznwSuRIczGcY1D9pYYkFkMWg+rA/hN8WF
	 hMORWOFKEf5yBt6Pns/lgkKkVoA2ED1rT3RDrI+olevQzXq+mLhIUyLG/YXp3cFPDcsos
	 ExwvsO5/UCkgY3L8MD4Bi8zPd5Kz5+SGkrtk3gIC9oOlqWAwBS5roH6u2wnhtgjkTzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CJhIfkgL;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3071606A33F
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3071606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CJhIfkgL
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ee1b65fdbcso10811085ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842884; x=1795447684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Rl6rpqCgINMnR0K8FGj1qRIflM9SM/kIkQeoCq0DYE=;
        b=CJhIfkgLW3VD7sG3sBqK715PId1XI5Fa74uPz5dg2MKE4YwkreVkjKRPAxT/uPlcBd
         9rYMugjo4MANfH7GRzvv5OEPHC+C1ZCJ9zguD6nwGBeV2CS5JModTr/bqqp3uHQTa8km
         RpVTtgEZ0hEcP8s8ohN4HsHU/aJqRRtYIbOhXJSQuIzl4wRPxvuDGF1fpyiD810LhLQV
         Bs6EjGQKmyfNs8sLRLkmB/InTpIVuCOzqOmGbHZe7qC7X/Rr3FzVUbD08kD0ys7+7bGz
         YHlB0OKn70oHmTxqwjdMH7Fkaypd4f0gAmnrfuauokVdr9If5WPLVl1ltTM2f4XRLzAf
         vk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842884; x=1795447684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Rl6rpqCgINMnR0K8FGj1qRIflM9SM/kIkQeoCq0DYE=;
        b=qpQu5tqYvOaRs2w5+j1zN2HU6vfbGs2RO9JLEoLaPwdhpauObJ2CU1N5w8owXEzx8W
         j85n5N8u8dAjoWW0PnXGUeeajyeW8U425+Nb+b2rS2ch0yaLVx/jwT2MvQOm6T0sCH/n
         bIJFZOzEsxHMqzUIHjuGP+WS8YidxzSMS+LJEccJNihGzg/+qHb5Rx/D5bG63VwhumWd
         j2kuvlQloPlBOA4zkCydxb8TS+vaHnfDKZ6kQfKbdDPa8PrWv8FjxIxI1fQxt+4wGS4r
         qzV1XeXhkFn3VUpsIV/zX8IBa2BrvxrTBZsZPWrD1U8HLJPtwTX6m8ox2uHIPOEIEc6h
         iQUw==
X-Gm-Message-State: APuU4Z/fDlhK55vfF+pdL7ckOCt9xSpMxVbvNzvSK/2YhZtxklmCYJex
	10RhmBmPHVksydpgiHaKQusCxqziuDDNlNM3sAszteGyrudmoxdIsMdywy9OoA==
X-Gm-Gg: AZFdTZdwOWAW9DVsG53c59tJghkEK6NL5FX1bqmTASKf3oFIw+1jSGPQFOSW3CiSdHn
	lbuxUwzsgJHTu/dgYb0x+LLsZw2B30i+QRiCzgGEU+w+s6KGDKwKodiRWw+2QBbmyBeOETaWSUo
	uF5s2qMQX0PdRhJKugyVM/BF55MwQZ+MmZ/wJ5PUZ0C50HMPYtpSuIyStiIPOLFI2bYKneZUjAz
	O5ZacH0YUI8fOZtLkCMNX9vIqkbtSDpmG34XIrwJeMtJTB/0F5LGf/Zv6BtAQzjmX6pnnuAf8wx
	Hj/iIK/7VQjbKiA8nXA34edL9SXd2oCYEx0F1mviXLxrrXZmLOBSuI+/FI7alWa9urWmEUfKFld
	Q7/FVeeKja/NHrieqx8gq6l6SGYgSOv5QLcT86/MgLGPN++yMMOmhca5R3pPMLeyEmxwbJ7I995
	UMaUb5TrfQA7z+NzvpIiSvTSxK1y3dq4BOQpoZxoSQ/cnotGWbAn4XBHBnHT06we8uivha19tQg
	nS0gfc1g0xcnpuCMywxhm9u6GgXqrrt0jZXDneg8G6GqcVCVvAi7ExzwWcktoTmlcOC0keG1IQ8
	ebrS9GY29aF52733Rp6eFIs34E7fYJ0UGtSp0PnLKq7iyn+mN5XRkPb7NNlx7SDChPOZbhknccp
	ccN7nrjJALCCQ+CepjxyQdScgAmsHtYPW9Sn3cITrt4JJiNFWBNCWEYSRrlAkqW3Fl6qzzwlO9w
	==
X-Received: by 2002:a17:903:1a2b:b0:2e9:460e:ca57 with SMTP id d9443c01a7336-2ee0da968b0mr110284255ad.15.1794842883764;
        Mon, 16 Nov 2026 07:28:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a11c4asm1043885ad.22.2026.11.16.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:28:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 15/21] bpf: Link the decl tags of a type
Date: Mon, 16 Nov 2026 15:26:20 +0000
Message-ID: <20261116152626.4032587-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The search for a tag looks at all types, for each argument of each
subprog. That is quadratic when the number of subprogs has no limit.

Link the tags when the BTF is loaded:

  next_tag[func] -> tag -> tag -> 0

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fffde271bbd7..9bb98a1c1072 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -281,6 +281,7 @@ struct btf {
 	char name[MODULE_NAME_LEN];
 	bool kernel_btf;
 	__u32 *base_id_map; /* map from distilled base BTF -> vmlinux BTF ids */
+	u32 *next_tag; /* see btf_link_decl_tags() */
 };
 
 enum verifier_phase {
@@ -1907,6 +1908,7 @@ static void btf_free(struct btf *btf)
 	if (!btf_is_vmlinux(btf))
 		kvfree(btf->data);
 	kvfree(btf->base_id_map);
+	kvfree(btf->next_tag);
 	kfree(btf);
 }
 
@@ -3636,13 +3638,45 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	return BTF_FIELD_FOUND;
 }
 
+/* For BTF of programs: next_tag[type] -> its first tag, next_tag[tag] -> its next tag, ... 0 */
+static int btf_link_decl_tags(struct btf *btf)
+{
+	u32 i;
+
+	btf->next_tag = kvcalloc(btf->nr_types, sizeof(u32), GFP_KERNEL | __GFP_NOWARN);
+	if (!btf->next_tag)
+		return -ENOMEM;
+	for (i = btf->nr_types; --i;) {
+		if (!btf_type_is_decl_tag(btf->types[i]))
+			continue;
+		btf->next_tag[i] = btf->next_tag[btf->types[i]->type];
+		btf->next_tag[btf->types[i]->type] = i;
+	}
+	return 0;
+}
+
+static int btf_type_ptr_cmp(const void *a, const void *b)
+{
+	return cmp_int(*(void **)a, *(void **)b);
+}
+
+/* last_id is 0 for the first tag */
 int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
 			   int comp_idx, const char *tag_key, int last_id)
 {
+	int i = last_id ?: btf_named_start_id(btf, false) - 1, n = btf_nr_types(btf);
 	int len = strlen(tag_key);
-	int i, n;
+	struct btf_type **p;
+
+	if (btf->next_tag && !last_id) {
+		/* the types are in the order of their ids in btf->data */
+		p = bsearch(&pt, btf->types + 1, n - 1, sizeof(*p), btf_type_ptr_cmp);
+		if (!p)
+			return -ENOENT;
+		i = p - btf->types;
+	}
 
-	for (i = last_id + 1, n = btf_nr_types(btf); i < n; i++) {
+	while ((i = btf->next_tag ? btf->next_tag[i] ?: n : i + 1) < n) {
 		const struct btf_type *t = btf_type_by_id(btf, i);
 
 		if (!btf_type_is_decl_tag(t))
@@ -3665,8 +3699,7 @@ const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type
 	const struct btf_type *t;
 	int len, id;
 
-	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key,
-				    btf_named_start_id(btf, false) - 1);
+	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
 	if (id < 0)
 		return ERR_PTR(id);
 
@@ -6519,7 +6552,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	if (err)
 		goto errout;
 
-	err = btf_parse_type_sec(env);
+	err = btf_parse_type_sec(env) ?: btf_link_decl_tags(btf);
 	if (err)
 		goto errout;
 
@@ -8677,8 +8710,8 @@ static int btf_scan_decl_tags(struct bpf_verifier_env *env,
 			      const struct btf_type *fn_t,
 			      u32 arg_idx, bool is_global, u32 *tags)
 {
-	int id = btf_named_start_id(btf, false) - 1;
 	const char tag_key[] = "arg:";
+	int id = 0;
 	static const struct {
 		const char *tag_value;
 		enum btf_arg_tag arg_tag;
-- 
2.55.0

