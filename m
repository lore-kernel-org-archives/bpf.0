Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AA218ADD
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606156; cv=none; b=Pocl42a00LPkXsXJq/KC4Sl3GKFMugSZJFFTy817OOoIoMK0zauUY8Kwjr24r95tbCcEtkPZ/kkOvO56UJE7YbHjTMGWDO/7j3Y3FkelkOexuueRLnvTUKjbtoqytC4t1I5bH8L8R5U+bq8qBo5CpoBtbdRO0aen8Fzf4Eb+EVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606156; c=relaxed/simple;
	bh=4X5CyQ1OZYBBZQNywkCndcVwCXKcxbnM+ivf7Lddx5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6mVHwjuH8TmDmpUatR52w9UB3DlzJzL26ZmGrwgVEtvpTYwK3HDHw7meu6psuihdxLH2qOU/luLPDKgAkyr00TCsIXAWgzLWVPixZtGK3sL/7VjwjSC31lCzgogJDcROhakPPuwibVQw1ixjtDJ0EuuyJDJfsCpl+iwnMBmGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=km8uAVsI; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="km8uAVsI"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7982c3b7dfcso678257b3.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771606154; x=1772210954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1h5URSDY+zsMI/2OWB7AUQuFyjabWE8M4l6yXz00dU=;
        b=km8uAVsI2DEwN8q7fLd2/Kwlc3Tnd2rxjFwHvGaynUZVxPJ6PqIy3UPmCm0Wa+NOdt
         Der7q7S0UhtPx2O6LOPulwl1PrqN3VpN6amm/Sw3GLKKh032YPVqtlGztSiDiCuRnpMv
         1XBZwukqJtGbr78KwELmKowaKRPAlFBGmRO3ILuV1IDK9iY3bojaXdutSoNu0aT18ILW
         pxAAXVz4KdjwGW5bNoi7BgZTEjowsd6MKlqbvETyy3ACYT+eqjsrASWeZyPE0CitDuJO
         DMJH2cUgrSHvdu2uIV+9n3/OQsRUj3dTqDi+txkJrlR07YNoIwwmHiz2Y3OMPcMMQ/eR
         YZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606154; x=1772210954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S1h5URSDY+zsMI/2OWB7AUQuFyjabWE8M4l6yXz00dU=;
        b=udAVESJFgx5ipyiKn9MkhYEYD00O7eBRBnuDA6jzw+xzjlgCe+ExV4VJ6DVm54g2Hx
         38uCqhsUkSRQVxZWTY3++MgO4CzKQrq+YMrz5u/8W4bmLY8TDOqU5cugn6WX2wjyMn8M
         jSI5fzM92KodDD9WaY/N/DZRee73267tMmQ4JcG7a5wPMar3lBTW4hwbcjB2ScBXk8JG
         3jxece9P1vQxPMPDhp6qJmGCmhrYnrm8YWUvuZ2GJCyqOmRzBdwuVALNSEi0D5l1tbhI
         I9lEzgSDAIi5XotdtQuDWVXtAQTT8ZgVUI1JUWM1NYhX3NIzITaIq7t8oI+m68bnUv0J
         AopA==
X-Gm-Message-State: AOJu0Yw7+qrxPhPsEYiCQKky0ki0V8EewGe0N1mZxPaihfh7PUXIQjoi
	19o60bucKZKB9+33+cscAwuVqHhPP3mRgA6Ivd0uuAiLcvie04WiiDHCb7mCpUYfZCD9mTJHNZ2
	DUVAL3/KJF4ss
X-Gm-Gg: AZuq6aL5dsiPPXmMIx1SKxnKhh6bRyJX4lYUbCOLY9SPvUp9aFuOOaq2oedOQn7nKcS
	QkD/9lOptfsXyP4Gj2Ahd7VLbndipKImAQZJ5wi7il2hP2ZjBhYQoKgPGkUuaAwPsntMKUoDKIW
	8W71OXRF3bL/FkCfArzfNFF+0eooLBdQ0f2qoc2TVs2beqQ33DKZ4WTUuv+bSCcgYRJyyRCX0QC
	Ifm5bu9/O39S9NTDPMbOJCuOnzySKnWbqFexJSYPpRVCPqWw3AZEIjw+5EAZhxIm5989wCcIuMF
	oQ44qJqGUMFFXrodtXjSPqDzzbZD4VrRSKuHwRXJ72SD7kr5apq2Ha+nJbUyioS6l1F4nM1pRBm
	vWe35WBTQAWG39I6mjl7TXIpiHh7TZNE9qeut6dRjHbhnm20O28hgVZ1FA5au8gaDYnnv8IXFD3
	K3ZeE0AK/cBy+59N5rqn29vocgFA==
X-Received: by 2002:a05:690c:c50e:b0:797:dd60:ac24 with SMTP id 00721157ae682-79828f11d63mr5371017b3.14.1771606153809;
        Fri, 20 Feb 2026 08:49:13 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c023be7sm143246897b3.0.2026.02.20.08.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:49:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 1/3] libbpf: support appending split BTF in btf__add_btf()
Date: Fri, 20 Feb 2026 11:48:45 -0500
Message-ID: <826ddc79db2a7c1e473615e9cf85c921a32b4838.1771605821.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771605821.git.josef@toxicpanda.com>
References: <cover.1771605821.git.josef@toxicpanda.com>
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
 tools/lib/bpf/btf.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 83fe79ffcb8f..0b0bb5cba22b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2004,24 +2004,41 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
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
 
+	/* If dst has a base BTF, ensure it is modifiable now.
+	 * btf_rewrite_str() resolves strings via btf__str_by_offset(src),
+	 * which for split src may return pointers into dst's base string
+	 * data.  btf__add_str(dst) then calls btf__find_str(dst->base),
+	 * which triggers btf_ensure_modifiable(base) and may reallocate
+	 * the base string data, invalidating the pointer.  Pre-emptively
+	 * making the base modifiable avoids this use-after-free.
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
@@ -2074,11 +2091,16 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
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

