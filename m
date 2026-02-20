Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92D2FF158
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622455; cv=none; b=H8qnqMr8q9RGU4uqesa/hTLzbnAW14ycw3GSEI39LY2megt1EZezoRQowalYJYJVVALTxNiAOYgfUDeVaVgE4mpbBqYEFGfZfUwXOPK9PIt1ZGa4/KbROmKdzVPzwUBchVQZi6U48gmFEGRGpQlRI28z+5GdN6ZbwUqSIVZEJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622455; c=relaxed/simple;
	bh=Yz9Sm1Pigbp0x0Xq+BmYGc5QGtObX5Ti0HhuIX+L76U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lif+uk28+8a0a72dQF6x12IiE56Pa6qUj6/26221MjEgQKScWWIxlYbJnZ1hw/PbplZfYjCftFCvN3ndFMW4jcBujotXn+L4gxvM6/nWWbvkLOqypjd1qVWZsN80Yt1MOtsTI4hT0tV5XJZfLLHfRYR9hxAKMKzKZiTkHYM1Uh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=LtJtEsw5; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="LtJtEsw5"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64a28af2f4cso3559767d50.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 13:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771622452; x=1772227252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvoCyWolkLqNmEVIN0WGOVDTJPmsg0Ed0I6I+AIM0Uo=;
        b=LtJtEsw5g3wDU8hbAJrOUotDaB9XwpDGIjG0umOX8yoDEm4JECBM/kB5zljrk4tz5g
         x/qzn5eOZ4+NdMtqXQdv+UkRsrIjW1878krjIHKFbCTl36qFqUFerEI4ulhacoAWNwm2
         h4DvVbiT4O6s5i/xdTw/9UOrMgrmU4+uBCKyMumXgljWlk1effGCiz/+iLg0zhVL+CHM
         SQA6rk4l8FFejEE+3CrQVQtFgyyeFTAPeTa1VVhcPqrCbbLPA7CL1KwhRsjm0FZW6CQp
         ct/AIEogyprmzN3etTlg+LUmCBPDIf15XfPmLzveAHm/4qx8eCNGa4YJpk9Lo33Rncr1
         T+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771622452; x=1772227252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TvoCyWolkLqNmEVIN0WGOVDTJPmsg0Ed0I6I+AIM0Uo=;
        b=t+f/nSntXz936h1DCDqFY72vw0QVNGWalmER2D2q6Kh0cZJc0shjkrxMEeA50IenVe
         GbfIKTsO7wFy9UaSGqoARtn1TDppxqXBmz5eLiNM9YVcH0rrjSvSSrUR4dhVmvP3wBm6
         naPNveIYUyC5y+WlevFiPFznhjojiYEqHNiPTbhK041K4TCp23Hcofz47unyPpZDDHI/
         KBrLF2Rvzp/2S5Gja3vMdAVj5Mi77CszLPeosTIhDZhl9MwRaGbwH6q93Z/CTFPjoBej
         yGYphL7jP8hTo7qWSAM0Hn6S9RSufqGT3xE5lfciwAf1bzYINgCKwVaBh2vJojgTZCEW
         NUjA==
X-Gm-Message-State: AOJu0YxNgziixLHQg5F73ff4G2IGV2xAKaqV43nmTZCx/ikXd+EvO/At
	PiKjOefYggmm3LbZh4AoetLnza6/DCyf9SN5TYGGqpTIPzRSAwcdpszeMTOSNwI8Yxm3fay8rZy
	pDl1kJDcxSHbT
X-Gm-Gg: AZuq6aIiSpX1qEwYvtr31Xdt3e6XCSv8uGnNfPO/KoFHfJxBPXBcZ7iDTt0PJ+6FBdL
	3ZX5Eu5ToUegCLbEi2JshIjsakYujbXK2dTumZxhQmDatQiVBRX56XrhJg5RfS+dm2mW9zWEkZV
	tKwIIgCmrTl/sXQebFt7qJqaQ0pNDbCcii1JpimdCvzSTe9alQ/NlHJ8Ux3lBdv3UoWOjp1XNLw
	euxjrJK7QGNwF5JmYkTLZugKDoXdF5+Z8gGnGC1amyYOxichUAapg9DA/bNi5we2UzujMCkVCkF
	q4aU+u4+Kvi6Aj9K9td5yH3vz8CZ0od6s85+9cH4+pAQsK2avWKCw74QpdFsksiIjcK1fzqhS2t
	Tx2dJjUOCk/D7FPTl7I7Q/EzDnKNqYfMNtlUgbPR5N5x2CxfmbQEjA2yF6lwoMgl25ZgK0vve4d
	wPnrxjqGRg61kOINTdae3W1cWt3w==
X-Received: by 2002:a05:690e:1904:b0:64a:eda9:8ea9 with SMTP id 956f58d0204a3-64c63fe785bmr5822718d50.2.1771622452549;
        Fri, 20 Feb 2026 13:20:52 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a39bdecsm193058d50.22.2026.02.20.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:20:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 1/3] libbpf: support appending split BTF in btf__add_btf()
Date: Fri, 20 Feb 2026 16:20:42 -0500
Message-ID: <cc99c07d83640039d170d20ab57c83bb7cfd2398.1771622266.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771622266.git.josef@toxicpanda.com>
References: <cover.1771622266.git.josef@toxicpanda.com>
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
index 83fe79ffcb8f..cd71a1173099 100644
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
+	if (src_btf->base_btf && btf->base_btf &&
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

