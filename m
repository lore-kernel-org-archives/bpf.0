Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5234575F
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616415; cv=none; b=Ch+b/4nfF1/UtTNZpyPBZ8Q2hwy2nPp5Jxq4V9vTab5MMP9hveyPnibYxKnVU3/IvkF+12/PZEqLaN/Y+CX1o3gQyCaDNVhbACsFKuQSJaoyKhfaYAbP7Tb6U5+AOoKXrEsNsPUEnPOpp/v32rfHhSJA5pSwcQDb2F+UFw4xOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616415; c=relaxed/simple;
	bh=4X5CyQ1OZYBBZQNywkCndcVwCXKcxbnM+ivf7Lddx5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfgQRYfUzcR3Ui+NovJBaD7FORe248394lzE9qvwwfd1/nw0CmEKKSDkVCpsTVrwplYzg8zzP3ohbuYp2U/YgZSotAxVNJc2CpU1oUtDFAT4mbM8j4Smec7ebxu9efjRitkLquhua0mw9ybctXVyXr5FRoC/MMLSGGXMBKB73Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=CcK+LqaM; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="CcK+LqaM"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89464760408so15459636d6.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771616413; x=1772221213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1h5URSDY+zsMI/2OWB7AUQuFyjabWE8M4l6yXz00dU=;
        b=CcK+LqaMEc5MkPPtgh/xAWMmoefzo2xvaAlkheOhHcPuTjeX9nd2CsYPBTnIuRDIK4
         QrJFNSbgWvKjbb4nRSs/OznuUuLILuUofMTZOQKDTtFBL4CybSg/6gggf2VLMj6sK3Zj
         mVENt3aXdiZ0wzAn70p3erJV1syZHflLhPtt4sq3a+FDviKjZ2BkavBSUz11+TcQIwjM
         qN/AdPIRIuus3MgjiQHGE0j8nM9VNvfNIc3Lu2Vna1y7TEM0LogMJHZM2RLEqcfeqQmP
         4Cr0Hsa8hKjYmsS0+3lzLgZ4AjmqZ9SqlM03I0Z0X8+JkbMmytcUb6REXyQjClzhpUyN
         RpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616413; x=1772221213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S1h5URSDY+zsMI/2OWB7AUQuFyjabWE8M4l6yXz00dU=;
        b=CYysD8SxcxEb4VqOOOgsTsr3RNeLKvkuGbvPBOLW/7djDaQp1pTEMmIHVmYAK63bW8
         PDjB/zsi+WISx8ySAZaPg4R1hUPGLH2FXG4SBJ22Ipj0SA7BqogBZGarjKZx/ttoSNRM
         56LOJIvMak0rEgkvBSs/yR8tCep6AH+9c0iE4ADCzydKyQ2vhMUTrxvKFlnyP//tHWsB
         +e9j3lrLiLa9UrrHBsc9ON72tSgscm77SNI3oC5BzIxMB5j14cXN2cP7iV1zIxsxLsSs
         AidCaZvvrZ2/yB6yxJP/IEREoirFAXH3pzp72lzum7HJQRrXXRGwobqmT/yR6NWNOcbi
         cQ6w==
X-Gm-Message-State: AOJu0YzudhL8T5AZ5CtEVw8OnbTbUj0eTwfASGN+vWPlgTdHEBaJgC+h
	ucX2SKDc6WIWjlJW5IzR/QMI+Sl+mnefy1/ueP/oRRINlC1VQWAKdp3M/N95CBBvm83v+zlUkOu
	Y0xcOXET8cGHo
X-Gm-Gg: AZuq6aJgLmlUuBS+FIt2IJe1gzNnQgP6FOXyB07Qhty6UP1QjDWf53aGLPyp57njCeW
	qgEP2dy4nCKheTEpdpVgxOHGSzsg4c1fej+lPoCuBNOpadPCr/ohU14FbNSetMTdu7jy1wyf/+y
	Beg414yfEkqK1gs1YI4ZF/lIv2cVOuVURjN4zsPEF6LkdfHma41MOJxMz9Lj/gC8Kj/QbFYK6x0
	NgPcQjtZ1/Vxy3IDUkCW9VN3zteU/aBwe+OI4ldCA9bE+gm6nijhondbbZRVVStmC8TZPBVf5xa
	z3ikBH7Y/iF2jsfN2VeNc9l/LDPetz9udl2AiJTqTRd04rTU7ZmRx5Sa+M7shcMJjSPODSLDCmO
	LHWrA+so06hbgWTTUYu9QSrZBqWEiDNaKAz2zlhthnwOIPCWMdTYqQzqFcMInOTrxiN/0wVLCKq
	3GglfRY46AI4OVC72Nf4t5xGCvOQ==
X-Received: by 2002:ad4:594d:0:b0:88a:2b3c:463c with SMTP id 6a1803df08f44-89979d37de1mr19411876d6.37.1771616412538;
        Fri, 20 Feb 2026 11:40:12 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6bb2c3sm793776d6.16.2026.02.20.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:40:12 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v2 1/3] libbpf: support appending split BTF in btf__add_btf()
Date: Fri, 20 Feb 2026 14:40:01 -0500
Message-ID: <826ddc79db2a7c1e473615e9cf85c921a32b4838.1771616227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771616227.git.josef@toxicpanda.com>
References: <cover.1771616227.git.josef@toxicpanda.com>
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

