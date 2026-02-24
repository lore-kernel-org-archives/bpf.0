Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA43A901D
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951266; cv=none; b=AAS1aWBVEYz3N8iP3qONAkOMCkHkyP35oYD4gZCDsDp7Ni3BOt2uZzZgRphrKcRy9F3VFKT4XUWPmInJj9uRBP62X0M+wuVTa3yjQ9x4W2OtvFSAAHzo/p8SakaP3j0mLwasbNRmJT/pY3xKa85L18BYQFGjB85H/zuhT+Chy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951266; c=relaxed/simple;
	bh=5aCJSzV3+Lbq/24jXrwP2oZSaTLmZ9XEZgvJCmt82Yc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2NcJY0WK534oCrMcP+HOVv2eAqyhIKK4Ug5/zXiVdMF82YLEPe+lyQfo6UO2yJsd8Xo9xH/I/soH3/Wu45/R1+DkfEI++i3o3khqm0WEixL5yok+X9yt8SFNhbM1zwJrzbr2lqXF8BPYFSYqQr0nVj1eLTjzwoPxE0pJR5SK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Tn2aNchj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Tn2aNchj"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8947404b367so67963346d6.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 08:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771951264; x=1772556064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMVA5Pp6pmHLcr4PzXdMp7dIT7+UaJHRQAx2hVlucaY=;
        b=Tn2aNchjjdL1lB/zdJaxP8QorluOD/JV8JPY4Vwyg+zjKewN53vY8il/+FvMPpx2Ff
         j1QmOpuoBz0SYmFHzAyUEeoeP3ebzG2zpD+Bt7jB5yILAzC43qX2sQqCL07RP+e7pv3T
         AghahS6aTESyQKvMGB9txpR9mTo9x/GAxj/aG3mhkQg0rRigaJaV79ezhpBhWdHK/Fgb
         zEffNwnv+HBR3mjuT+UOYYn0uxkwzjgx49jjH42+MEXc9Ntj6vuITBBLGcdZUMzmli0r
         YqC4WodtYT1pmwd6xstBdg5YfTrDwuNkPYYUZy8M6zZ48ezWGPSIQMQe+pCmMcI7xSzF
         Uf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951264; x=1772556064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vMVA5Pp6pmHLcr4PzXdMp7dIT7+UaJHRQAx2hVlucaY=;
        b=NCflXMJlytPHa4JUi+MJcnfVGpqyqymPIz7p738r2W3KKKOid3QPy3sbcprmPM2IKY
         mcx1VVDQ7CtBjya+igzSNU7qsfSl+XCcuc7/Nlwl9TFoMoIZcnUQ7dQLB3O9a5MgyCKV
         Lq1o9uCkK8Qp97RERz3kGX+if3HBAYWr0RO0zqz/XLtjDT4XsugC9ih9Ca/ghg76Orfx
         LBcJ3bWOM6/5hudVElqiWOzlM+KVVIiMFPxOgYqBzbA3yU+zTI9WQNR5rstJ3MVwmy8d
         E7qQZsXIsWNp4RD/W/ZZuWcgDNFJ+d1N74jGOsoV+lW5tK6+eDZfW74x4AEEBDexgngX
         Z1LQ==
X-Gm-Message-State: AOJu0YwDwBOh2gxqZEqIPePqI8O+sUhAil8Wdkg8qSiDt760ERhJA6SB
	DxG7a0/jsBIzm0eXxKAo6ipgJACE63afgVFiDLdxp0hCljKMkK8iCkSBpOJbQGXqqObbTGlNxZ+
	hsArPsXeTnCKs
X-Gm-Gg: ATEYQzwmqRLe1h8SXRfXqOzVgltIbMyV9dQ7ixvMvsgPSZrKPX9HaIelwVJWoLJGWY1
	lf9zWIcdZdlneUp7SxVpZcMPh3bkMKFCBLu0p2laXrkx7DFo5FJu2ZheNyDXsxPyCNLH4oYKG16
	YyTxvVq2XOyq6GQYMMPUjV6Zpttr4ov2HRFuzkTFp0Tlm9KssRZPBc11SLAaUiDpA+01nMuuf94
	eHIoKCOKXfZBJeQArmWU2XRdL8H+kllClmm+ktw/w2sNtykwKGuZQYnoQXs/tQEqY/dXrWYfTWU
	LwuhAXVnuS+V3H6Sy9jB6oM4dLB2iONe1RCG26x5IqbRkIdFvQeG1VLglUGM2oaQTyM215EAz2Q
	RP/gU5u3PpLRq9sThx6EzzSHECESUET+Z0iXvWtBxep1NNfSTebCAZgAERxgMsOqdIxlXNgm2oH
	5UuY6Uj9mfXbQTXWF1b2nciHbUsw==
X-Received: by 2002:a05:6214:21a3:b0:896:f42f:bf14 with SMTP id 6a1803df08f44-89979d96b89mr202501096d6.60.1771951263321;
        Tue, 24 Feb 2026 08:41:03 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62ffdbsm107838496d6.43.2026.02.24.08.41.02
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:41:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v5 1/3] libbpf: support appending split BTF in btf__add_btf()
Date: Tue, 24 Feb 2026 11:40:52 -0500
Message-ID: <c00216ed48cf7897078d9645679059d5ebf42738.1771950922.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771950922.git.josef@toxicpanda.com>
References: <cover.1771950922.git.josef@toxicpanda.com>
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
  share the same base BTF pointer when both are split, returning
  -EOPNOTSUPP on mismatch.

- Computing src_start_id from the source's base to distinguish base
  type ID references (which must remain unchanged) from split type
  IDs (which must be remapped to new positions in the destination).

- Using src_btf->nr_types instead of btf__type_cnt()-1 for the type
  count, which is correct for both split and non-split sources.

- Skipping base string offsets (< start_str_off) during the string
  rewrite loop, mirroring the type ID skip pattern.  Since src and
  dst share the same base BTF, base string offsets are already valid
  and need no remapping.

For non-split sources the behavior is identical: src_start_id is 1,
the type_id < 1 guard is never true (VOID is already skipped), and
the remapping formula reduces to the original.  start_str_off is 0
so no string offsets are skipped.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tools/lib/bpf/btf.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 83fe79ffcb8f..be8cc4ee83fe 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2004,12 +2004,18 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
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
+		return libbpf_err(-EOPNOTSUPP);
+
+	src_start_id = src_btf->base_btf ? btf__type_cnt(src_btf->base_btf) : 1;
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
 	if (btf_ensure_modifiable(btf))
@@ -2021,7 +2027,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	old_strs_len = btf->hdr->str_len;
 
 	data_sz = src_btf->hdr->type_len;
-	cnt = btf__type_cnt(src_btf) - 1;
+	cnt = src_btf->nr_types;
 
 	/* pre-allocate enough memory for new types */
 	t = btf_add_type_mem(btf, data_sz);
@@ -2060,6 +2066,16 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		if (err)
 			goto err_out;
 		while ((str_off = btf_field_iter_next(&it))) {
+			/* For split BTF sources, string offsets referencing
+			 * the base BTF (< start_str_off) remain unchanged
+			 * since dst shares the same base.  Only remap
+			 * strings in the split portion.  For non-split
+			 * sources start_str_off is 0 so all offsets except
+			 * the empty string (handled inside btf_rewrite_str)
+			 * are remapped as before.
+			 */
+			if (*str_off < src_btf->start_str_off)
+				continue;
 			err = btf_rewrite_str(&p, str_off);
 			if (err)
 				goto err_out;
@@ -2074,11 +2090,16 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
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

