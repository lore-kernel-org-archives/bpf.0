Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83A38553F
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657824; cv=none; b=LszoTHeZZ4LTeaWZNRJBJwceHNI2zOhuFCABifxwvRKN4jMRBd1KLaYYcFYzK1y78Dy43MS7aPkIGsTHs1k5/LYeTUWiU/qGs3j0U8E+k8p00/hGg1nd0wRKBwprV8MMi2L+Jd7vPSNHBFnpGJoB6/S1K45/d48zlaHVU9Q3oGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657824; c=relaxed/simple;
	bh=5aCJSzV3+Lbq/24jXrwP2oZSaTLmZ9XEZgvJCmt82Yc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug18vBR6cA9pmEyqHgfXpeUuPu28IyTNcTpyeoz3L9iinLWUMEbFOnPAGNSc8mscP+oZGS5uz8WQWeIGipCK0CN6JT2FMbNFjzOccf8gwXd+/OFq39pzk+Lc8JKPgfkrLBTLfHMXoWEKJZGC0lUHN4BfSeku/8Cj4JaFNQSXTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=KhdHpKeN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="KhdHpKeN"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506989e8516so63047701cf.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1772657820; x=1773262620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMVA5Pp6pmHLcr4PzXdMp7dIT7+UaJHRQAx2hVlucaY=;
        b=KhdHpKeN1OxxMvqfqLkpVK9Ls2s75u3tW0Zq/R04OPsjPO3YrmxdPPpK4eOaCn0pBx
         IdkEeqwEs5pc+sv6Ll+ZJJEy+oG1rFR8O5dLKijnmYuLPB4S1fS3RPDMjpQ1RuRP3qA1
         RUNKho3yujSw7UMAONy2qPKLKO3QEjOhJXAaYVJ6f6lGh+b0+qHFOn99fbU7zcZ7cAxF
         Ehbw1nUTxl87ecMLpFlMlqALYvejCDz2LI0Tzr4Mb9wNY1NFXgTotP/bsQN39rDDoNsw
         kNA+jZubBcJZVAInbln+PmxUd+A13Fy+EiKxq9LF1x5fK+z8/PY+D90CapbOECnrIYLJ
         qjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657820; x=1773262620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vMVA5Pp6pmHLcr4PzXdMp7dIT7+UaJHRQAx2hVlucaY=;
        b=pdN1uqGysNOdMDry9defvJtoGDXPXoJFmM4xMO4V9SBN37vuGpeyNiU2pOlifruVrC
         /XvBxMl1uARaJi+er6R25oqxfutwx/5e6W1nwvoWUl/9Akg89RxRc+R43u9c0tOb8sjq
         QhnYiZhac/rsMQQeR6B6/GyRKFJ0B9KbqwhXM2rpNV+y22RDaxc/9lMM1BsjkRmgNH7J
         6tGb7a6cdA8W1VyLFqzAAgsZ4Wtj6KY8Z2a6prThIyAbRK1H0hKXHN2lGay+kwgS8bKf
         Lqc0j1Fa8h54+FExuAb+DXpT4JaTgoN56itFTvrjhtIJ/pwelisnYrjUlZoAfr3cv9PV
         0Vjw==
X-Gm-Message-State: AOJu0YwhqWiiXAZ+4EiVBhpLnN6gKnsPO1irMk1kJ42QBMX5LMuPfTbm
	RojFw1N4FxUYFQ7lQfz+kysCNV555eZTJdP14TtG+sbasoPqCtVGY/siDwE9Q0bifnSWMmSx+xR
	66xGRcMvaTQ==
X-Gm-Gg: ATEYQzxhurH2XPFej1l9vjL2aeYXiM0OjNKdQNdlyp/1+2I+ch+wwSWqpTrmScIaGwo
	i/R702XIVKlh2mFsSCRiJtuWbmVEHUEpz9C9R9PLtFoKAFaTOx5BirFCT1PCNb6eDZrIitHe/Mj
	10gJquwmxYX3HOKPipanNKKEu0L2Qvb+AbPAj2yXnMpW7LZjoAdxv6J0In+8Ly3cS8WKT9HJazU
	mE/5i3X2T+s5LlySvJmuNkAI1UScM5mcFXfvCp7Jlf+M8xXWF9kb1whYc1L+a6JvEOx2dNuc05L
	KxLRrLn/q715nN0hLMdBespxYQQ3T8vwmXtSyErqwhhVL57pCoKj2QnBAomCKIlBiyqIQ6CZrzr
	JVILtuYxcIywh1UvRnCAOIMTwmGSqJTYVwbx8Mhrj+hKuiW2ERkQWlb0/3XrSUK/UJwwxoSdxS3
	XbkOQgr5bXP5xziMxmeVxk3X4VRw==
X-Received: by 2002:ac8:5a03:0:b0:4f0:131f:66fe with SMTP id d75a77b69052e-508db3f8c56mr42191331cf.59.1772657820201;
        Wed, 04 Mar 2026 12:57:00 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899e7627b69sm107430496d6.41.2026.03.04.12.56.59
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:56:59 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v6 1/3] libbpf: support appending split BTF in btf__add_btf()
Date: Wed,  4 Mar 2026 15:56:50 -0500
Message-ID: <c00216ed48cf7897078d9645679059d5ebf42738.1772657690.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772657690.git.josef@toxicpanda.com>
References: <cover.1772657690.git.josef@toxicpanda.com>
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

