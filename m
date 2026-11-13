Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611347;
	b=VE5e/s7vCkK1W69CJCRqlsrHZfQD9+WuqNU+WoumoDsEEsw/KJRsFPdxHljMaVn+3Hnw
	 l/7T3sXApgdwtZnYjThTAes+4OL+J1sfiNjVtIWonXDMfJvSPPaTVF0rUbNLC3W+6P0Mq
	 kdHLr5Mz86QCGDkGwaWo/0hlHpT6aj+eKG9ZuRV+HznRYjG3U8pracyjKaK3y8eWPLn9X
	 FOjKTQhXn7HjbDXIrdL0Kk00+lGQevInVCO6dwEa3PkdgVDXD73V1QfVmD87tMkhYzg7i
	 qs9QZ2lGUW/FcZPfKaNjnnXy3KaJLa8vijMTWD+Fo94TFl9yPojLuZCfOiz3NNaUWmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=r3SZI0Hjej5NLMbProZSX2SrQnMIxL7PzVKpEjEUJFE=;
	b=2aSF3zaJ+s0RQ542zmakdADBip1rfeMdMqkS/KCppPyMkHA8BXDt7oPRJfJh/JFUYtfM
	 yFXzi1Em6SiM60tI9xN9nrRhoy4Vh8iB50TaxeXrGy8HlIltk6zeYho4yYP/XIqPOF78n
	 XWC5Rl1aM6wCDCom/OruboVCTaDz1omKVaBi6o4jkYwz+Fr7GZ/vjJgw1jtGD3zdt4gTr
	 oVOpzj4WIrGRKDbdrGkFYwsvEdHYEx0ElS6WnyeQLCdE9bdSO01BFlCZoos0MEo328YAj
	 y7T3K2sRfHWCnIOW5lQAxW/jUX4IPV98cO9cWt46OLehoL2BEsD1NQ63wkjUl9ve5nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3YqRnAI;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A07606A332
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33A07606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3YqRnAI
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b305e10ac7so17997427b3.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611345; x=1795216145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r3SZI0Hjej5NLMbProZSX2SrQnMIxL7PzVKpEjEUJFE=;
        b=v3YqRnAIhfmckBStlBkPJkBo0H+IVlRcPqFYq51oIyK60Aeh20esuXGxEB6EYTcI6R
         wPWK1PhbNAdCVejZdhQvJdgY7FtwU+d/qxisnLy8KrjSvsF++QT1KIm0Rcg+Ecrry5cI
         B+Cz9DjoKCeoQX8Z4Yg24mADmFa4DtXNW8P01B01LiWybzrWNv1p297gFj7Hyd0xDF/g
         m8tqhP0sdwjpmxKOyuEXHGgBib0GYODfDiA8aLiR/usI78U8cUtiUmW02khOGxXSrZ1Z
         BV3jSSiMNmOdcFQd1tbA19v5D6nEaAVuaUgE8RAQ9kz8RfZMLQIgPs37iC4Q2MhWjbVC
         pfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611345; x=1795216145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3SZI0Hjej5NLMbProZSX2SrQnMIxL7PzVKpEjEUJFE=;
        b=0Rujq8o9TC7NsM8DkgYCsKMfiMI5e/+T1V6QyLECZCSf6NPd8FyQlcNVGaSa2QnxGw
         oK17cB+huAn8Lr0h9Hruub5HTelajMP5EKB8f6L951MnFl3nx07WyjAWaoAfXLrgetjZ
         jR0xp9yglO+XRqQ94B+Ii4QJvQSQeeauf2wgWLxuXJ88OLhrIQfgnXlmaEyViWM6ctYE
         nT2bDo5+X1xFIeaDoZx1Q6duH/9n6eqLItQuwAwYHbgGclwMDaNsGKQipJe1/rlp4qI0
         dHgBfeQOr2vF59oF4Xw6uXPPVWBT38wso+GWC1jVphw/IXlAgcCAgQvkMpU+G/OxSkE3
         fQDA==
X-Gm-Message-State: APuU4Z9MGneGJKSwTv+vaz1VUAeYVCXyNkv/FXzGvg8imiqKdnmssg4/
	gyLlw7l883dDvTxpco8fCsCAJYBK2//eSUw2L2tzXg9Zna0s/xrRK9SP
X-Gm-Gg: AYBFou3xUUVd/8p26i6mKq/2MN5DDqHBeA8UHQ4ZqCuAb6NBzyL4IBd0vPwaqyJbK6J
	vdVQYoJullfJiXxoChCWV6Cbt/bX17wpMNny/RJM5TMxJ06J36tEC59gg4WrVYUMvEeRpxPKMe+
	Iwv5bVy6+CMolFery6p3vYepNP+C6zP0E5lVKPKWXVG3DsVl18/eyDy1wXW+HmlA6UKfDp0jTPR
	F3pEJ65RpomFKwMtpMhl2nF7Mc3XCLmFyqpgwSAHERVnezmvpf1G5AJJtHUvWk+1dRHHAqwgZA6
	Hohj436NLwUDJy5Pvw1pvvoKi8VBS23muoiRdxZRWRwYqpOpiHPejA77UHsFGSWZopDEQoz8GH1
	oQoWWLt15cuzGOZVGFLdS/Xs+dsHkrBoDLPat/2hv1kjudgPwXyz2EfSNuZ/mpB80vBROf7eqpd
	muAw6RAhgDY9qI0tsPcTViGcQaDq7Ytnm/phMNUozYGhjluCq6vv5UdOshOvLBwjEIeqOGbdkSY
	Mk7Un1Xcz1B4EnXmevTZdKAYnjrkB9jHml6fEkvlz+gFOBVTjF5fWdz4XHNgbkzp/3pQvqaDYYv
	O8CvNYivND/7aiT+4kfi4lV2vP0csOcsSTXGtBbh
X-Received: by 2002:a05:690c:60c3:b0:8b0:ce77:8dce with SMTP id 00721157ae682-8b4aa3966c0mr29018727b3.58.1794611345167;
        Fri, 13 Nov 2026 15:09:05 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa98caffsm32053847b3.27.2026.11.13.15.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:09:04 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:34 -0800
Subject: [PATCH RFC bpf-next 11/13] libbpf: Do not retry local storage map
 create without BTF
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-sls_f1-v1-11-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=1797;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=jlUF/BmUaNKH8JvQzLKoKoi3VKb+Jd8fLJBqFCLVsfA=;
 b=FSMv+AAMRlqair3Ldba09QNi9ACdesKeuQnSAb/X+Z9vKMKLeoUEOWdirVlHziSrkxTk7ErnY
 m9Hn+n3xINECG7Axl7PfhdmMWoryx+260KsUodR7NVfVD16kpaRChJT
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Local storage maps need BTF, so the retry without BTF always fails with
-EINVAL. That hides the real error, for example -ENOSPC, -E2BIG or
-EOPNOTSUPP for a BPF_F_INLINE_VALUE map, and the application cannot see
when to create the map without the flag. Return the first error.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 44134421bd7d..680025281315 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5531,6 +5531,20 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 
 static void bpf_map__destroy(struct bpf_map *map);
 
+/* The kernel refuses these map types without BTF */
+static bool map_type_needs_btf(enum bpf_map_type type)
+{
+	switch (type) {
+	case BPF_MAP_TYPE_SK_STORAGE:
+	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_CGRP_STORAGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
@@ -5631,7 +5645,8 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 					def->key_size, def->value_size,
 					def->max_entries, &create_attr);
 	}
-	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value_type_id)) {
+	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value_type_id) &&
+	    !map_type_needs_btf(def->type)) {
 		err = -errno;
 		pr_warn("Error in bpf_create_map_xattr(%s): %s. Retrying without BTF.\n",
 			map->name, errstr(err));

-- 
2.53.1-Meta

