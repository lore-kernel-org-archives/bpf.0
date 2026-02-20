Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D93115B1
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627449; cv=none; b=pnpbL+24kjpEN9Tqpr4a19q1OT20ekdf30kPbBeZiDRvUhEyTnsIUFo4yqdnqo3VG6fk/lvVYERMogiLGlUtM8t2is3e0a4yYjMYHGD3FpAVEIgveP0mp2MO9n44yZk0aLR+OyHikt8Jb0a6+75+jaaYQoLnTpJvki+GWtqTRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627449; c=relaxed/simple;
	bh=hMR9IAQwhkGqCy1oREp82WSjMX5ExMyDjl9mLlBO0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwMMiBU/T3ZQjAqOe2mazFFDu/rypbu7AormVT9n1gkDTFE6phhIZwLXzCaVBXOv3EqobzIWNvhO99bedZ8fWt8E06OHfUc5vOlWq2BEwkvboEfgVu5codn7oCLPlC8I9Az9xA3ejFN8CooeuYFOui5Wp/N0E2QNvwCnaS9r2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=F3QTFqb6; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="F3QTFqb6"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-794719afcd4so26071657b3.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 14:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771627447; x=1772232247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYQ5IAubDMdLPsVFlzdChYlT28VXOg78XPNK14nREYs=;
        b=F3QTFqb60ztIMlrvc3r91Yy9kioz19XNpb4fuKR4VXRlvg+t48c2WDuT7FJmGLRyDz
         rVWP1cxumQW1bhGwMpbozHwHS8qUvV4c2PLsMp0FyBDK7K93ArSk5v6eUWMi77HHCA+O
         wC7urybVqM48H+XsB7sTWMCCnKfcmSLNOUd0nnTqT8wsiSk38Yd4Kz1wUmzeycD9il9C
         4np1UmPABz3aC/Bx1SwDB45GO01lb4HIX+9GcMo5B91fs1Pgi52LsUNVljTUDRRQWUAG
         HtOO4cuXRIOXg5gC/soskHgEiG81Fk6eHUQl0DP2VyAQ4sW1MAcjRsOK/iLTUEQg1DBI
         68PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627447; x=1772232247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYQ5IAubDMdLPsVFlzdChYlT28VXOg78XPNK14nREYs=;
        b=Oa3zcTDcTY28MEDi+uj8xjCZzg+5ARpM0G9PCRVwzzwX7/C6t+cqD9jXesyqOFtC9s
         RKUSQQx86lhvpNLHjFiK1N8R6L5VqjIqasyG9dK36mO0YO1tZRsDOy7S5MvKVs2GZVv4
         2WrDzk/j6j2saeWVIXl1qr5SlB2nLHOGjykCPmp4/VJ0CGxtCCCmoGJrKQOKu69EC774
         wTT5UzX6ZUE8v6UwbIPxtdvD8jkBwFXNfMdGMYi0mM+vK0Zww6N3D8x4Qauw54ypbnxz
         fYYPWy+5QDH1g/CtMZMa90XXbmRSSQzXAyIXdQwyFcgh6rCm6WYwQC04xBOaL3j0C1FK
         dE9Q==
X-Gm-Message-State: AOJu0Yzr6YxGnz1qd36l0VNpoeT+c8Nh5r0kG9XReWZIO3oSSY3AMho1
	1/OnjmaiJw83uUV+HPOiNZLGKykieYycFfX282qnaMFJyxEpvQDewkZ8ycLiKK9CBCGZ1vQgOiA
	Xnxtr/I0fplrP
X-Gm-Gg: AZuq6aLJanPHNRvytoYBtY4FXNp84Gr6Ie1QfwOI7NAKkWdqhMDtOVc+Y0Rd2rz6rxD
	nOXp32y7TRZtGE2fvV8+IE3eiQtozZTV2Vj+y16c04z7spTgT7AC/zBtcQTcIy4QFA6H1HF1C2k
	e5yp7QNW7bfRWQFSYycvV+w9sPcg4rfswQ5TqYzaRPTGcfdSYCP4jEymk9K1uI2SMkx9wEUeWjp
	Jsp7TerM45jlOvTTKg6UAfPDwE7f2dw1r0TTOOynECDTZjquw1r1PI1LMc+jY4IEr911aex6GcG
	vPtIkblrY0vwOFamsuWigPSWVhjKGg6SS/ZWl+eykcpselAb1g/ZYGIdRPd0hLeRr2oZY++010M
	eZknwbivUs6h9iEP8f2LJuFAH+Tv2cbg8ftJYYzD9JPPR0pnZNbb9eqwb849Gw/ODZKUd04cqMH
	wwPuxbS5MuiUsvubaq3IZklcgB4qOJyZQqKxg9
X-Received: by 2002:a05:690c:60c7:b0:797:d286:2cd with SMTP id 00721157ae682-79828f2777fmr15384777b3.18.1771627447314;
        Fri, 20 Feb 2026 14:44:07 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982de0fd63sm2251797b3.46.2026.02.20.14.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 14:44:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v4 1/3] libbpf: support appending split BTF in btf__add_btf()
Date: Fri, 20 Feb 2026 17:43:57 -0500
Message-ID: <c0c2c805042fe889daca6dd43b86ba5e18725021.1771625484.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771625484.git.josef@toxicpanda.com>
References: <cover.1771625484.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf__add_btf() currently rejects split BTF sources with -ENOTSUP.
This prevents merging types from multiple kernel module BTFs that
are all split against the same vmlinux base.

Extend btf__add_btf() to handle split BTF sources by:

- Replacing the blanket -ENOTSUP with a validation that src and dst
  share the same base BTF pointer when both are split.

- Computing src_start_id from the source's base to distinguish base
  type ID references (which must remain unchanged) from split type
  IDs (which must be remapped to new positions in the destination).

- Using src_btf->nr_types instead of btf__type_cnt()-1 for the type
  count, which is correct for both split and non-split sources.

- Pre-emptively calling btf_ensure_modifiable() on the destination's
  base BTF to prevent a use-after-free: btf_rewrite_str() resolves
  strings via btf__str_by_offset(src) which may return pointers into
  the shared base's string data; btf__add_str(dst) then calls
  btf__find_str(base) which can trigger btf_ensure_modifiable(base),
  reallocating that string data and invalidating the pointer.

For non-split sources the behavior is identical: src_start_id is 1,
the type_id < 1 guard is never true (VOID is already skipped), and
the remapping formula reduces to the original.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 tools/lib/bpf/btf.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 83fe79ffcb8f..654fb9ffa01f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2004,24 +2004,47 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 {
 	struct btf_pipe p = { .src = src_btf, .dst = btf };
 	int data_sz, sz, cnt, i, err, old_strs_len;
+	__u32 src_start_id;
 	__u32 *off;
 	void *t;
 
-	/* appending split BTF isn't supported yet */
-	if (src_btf->base_btf)
-		return libbpf_err(-ENOTSUP);
+	/* When appending split BTF, the destination must share the same base
+	 * BTF so that base type ID references remain valid.
+	 */
+	if (src_btf->base_btf &&
+	    src_btf->base_btf != btf->base_btf)
+		return libbpf_err(-EINVAL);
+
+	src_start_id = src_btf->base_btf ? btf__type_cnt(src_btf->base_btf) : 1;
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
 	if (btf_ensure_modifiable(btf))
 		return libbpf_err(-ENOMEM);
 
+	/* If dst has a base BTF, ensure it is modifiable now so that
+	 * btf__str_by_offset() on the base returns pointers from the
+	 * strset copy rather than from raw_data.
+	 *
+	 * Without this, the first btf_rewrite_str() call that encounters
+	 * a base string offset resolves it via btf__str_by_offset(src),
+	 * which for split src returns a pointer into base->raw_data.
+	 * That pointer is then passed to btf__add_str(dst), which calls
+	 * btf__find_str(base) -> btf_ensure_modifiable(base).  The
+	 * first btf_ensure_modifiable() call copies strings into a
+	 * strset but then frees raw_data via btf_invalidate_raw_data(),
+	 * leaving the pointer dangling before strset__find_str() uses
+	 * it.
+	 */
+	if (btf->base_btf && btf_ensure_modifiable(btf->base_btf))
+		return libbpf_err(-ENOMEM);
+
 	/* remember original strings section size if we have to roll back
 	 * partial strings section changes
 	 */
 	old_strs_len = btf->hdr->str_len;
 
 	data_sz = src_btf->hdr->type_len;
-	cnt = btf__type_cnt(src_btf) - 1;
+	cnt = src_btf->nr_types;
 
 	/* pre-allocate enough memory for new types */
 	t = btf_add_type_mem(btf, data_sz);
@@ -2074,11 +2097,16 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 			if (!*type_id) /* nothing to do for VOID references */
 				continue;
 
-			/* we haven't updated btf's type count yet, so
-			 * btf->start_id + btf->nr_types - 1 is the type ID offset we should
-			 * add to all newly added BTF types
+			/* For split BTF sources, type IDs referencing the
+			 * base BTF (< src_start_id) remain unchanged since
+			 * dst shares the same base.  Only remap IDs in the
+			 * split portion.  For non-split sources src_start_id
+			 * is 1 so all IDs are remapped as before.
 			 */
-			*type_id += btf->start_id + btf->nr_types - 1;
+			if (*type_id < src_start_id)
+				continue;
+
+			*type_id += btf->start_id + btf->nr_types - src_start_id;
 		}
 
 		/* go to next type data and type offset index entry */
-- 
2.53.0

