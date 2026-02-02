Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9D3659FA
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033683; cv=none; b=eZKx/OB1Ry53BHYgCsYoyMdw/f9yFtThxDWfnrb7obFck+wPhIPkdrdlyEe/nF2n3bSw0zVVqkr/+xTwD0etfr0GnpqLIxKnK24rwj21iRUI4HYPhctc/voKQSQxlmlPJkITdj1s8KpGLxDQTsRKbxy3p+Hb8DN0e4HFug4cxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033683; c=relaxed/simple;
	bh=phaOpdqIarl8hHXtCzg9w9twE7EScKT68aPyG4AhU1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNjyR5WXystwSdHBZhAMTl1gMaf23dFovdGpi1iExXgGYSiWE/cY0UPVub2Qti0NyRwxB4kpo9wc6Yyy1X6Va5AkzEO+EpOX6U8ejxcgeWfMjfY8MFBhkv7MtVa5PVkkydnwtJWKsLfYnIHBfVva1+mHjcTOzIPveM9eVNx862s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i910Grbf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i910Grbf"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso2477046b3a.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770033680; x=1770638480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ynDhirwXFFvXF2jupXnRd7MMm674ZQYfVTP9bwD8e7A=;
        b=i910Grbf1u1/Mauqtg8U6f418cZjNZ1geyMes3uzSZTXfFLH6GwtsxHMrp3dKX3ciE
         rJbyAPjhAo6DTOuxk0APnmKQQ2pSALwWbrTIkWR2EvXrwGMTYEy5tYJXDLKP7JYU33vt
         OcJ74W8RwGIB+8z8gjSfL64oA6zY19Zw1Vnn4p3/QgVm3MAdxaLBS1mD9L8e/VI+zbEm
         iJGaWLhFn/fxEinngvPJBOa56EgKOKJ4Ay5pr5z3bCBQaZcMXeL13n5mPeoMXgKhG1bD
         3C63tJmGPHAYzpLA1nDnVpGt56h/VDjSfHZzR6KcGNRYeGGBHyyGWM/KhGlX3YqybQfZ
         wShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770033680; x=1770638480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynDhirwXFFvXF2jupXnRd7MMm674ZQYfVTP9bwD8e7A=;
        b=qoaXh2Vr/q+I2eYV9S+7slG9DFHFtvpoGgdbQ/dfKCgG59F3s2HZ880uKwr/JgTryr
         MZZlWyNnxH0axbjsDvJSeSnBExPIrFs1zzwplbXHu6X1FwSCY0ySHaEcXUK4fZipUwg2
         kN5N8BEhIETS6y4u27lxxv8xmFnFOTqkWdaxPgOVIxzsRIIsPe/i5TnHt9EYY/Q1DUyp
         c2H1FfIfziIF8tKltEe+CUbBZ/E4zirV5hw4dy0NYH2FryrKZgMGPyCbFvIDqlaqCuev
         +msvNqhuebDgbFLkMmaR6IetTMyS62ERRvN1TFcuoBupo2FUalEYpBokYjiM6oDQ8X2b
         PiCA==
X-Forwarded-Encrypted: i=1; AJvYcCW8fMTB7CKXOC9ZnTw/TAi0bFJWau5oHFX5RwsQNPxvQaeduprLjXn6NmgnHJNhIjzVgwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJgj66RSpc+VioOASOALPO076hmJHj/fIA/YTAzoARtADJTyB
	SpIaCoJ7eqHV+M6JvO7erzXRe14Zs7RCetwqsJNOiqbiccpvOsCQHVP8gQhD1jxTDAQ=
X-Gm-Gg: AZuq6aIKrBuF23fIuzUPCNJoA4+afjH0mGYkcv3n4PryG3S1hnzF8ogZGwBB160tP4t
	VZ75/keUOs/9xYi2mMJF+JKfMIHeinkngZkBw8TvBJMeQhmMtXwWMb8oz4XPVokNYtOIz53FqCh
	S4YHYXXdG98KJvn+TER7Ekr4VqfvrF9uWTbkXcKSCTicjY+lNJiZdkF2tbghvvHpRkyqN8h8seA
	YgQuu2CGZpz4GJSsyuyNov8NH6jpvUu0XbJ1HkpciKgya0haIY2S/pwKWck9/v9NmfDMALhfQmS
	LP4EjboN62E8FBaPJx52f51OejZZMnJtzFZBY+oe0oxYUzGdEEzCbyjCeJm53MoXMzFLBDsla1M
	JNMkmYSwuf2d/sWSltEW+JqWnu1tLJs/UxAEhAksQje9H8j1SXM015t3KnGnjEsEJlzm5adIzGI
	/1MfknP2m4ceqdKaIcadvmnaeHG+A=
X-Received: by 2002:a05:6a20:258b:b0:371:7f31:17f with SMTP id adf61e73a8af0-392e01b30ccmr10452068637.77.1770033679554;
        Mon, 02 Feb 2026 04:01:19 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64283710e1sm14471720a12.14.2026.02.02.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:01:18 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH] resolve_btfids: Refactor the sort_btf_by_name function
Date: Mon,  2 Feb 2026 20:01:14 +0800
Message-Id: <20260202120114.3707141-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Preserve original relative order of anonymous or same-named
types to improve the consistency.

No functional changes.

Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 tools/bpf/resolve_btfids/main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index db8d1554bdcc..ca7fcd03efb6 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1226,22 +1226,26 @@ static int cmp_type_names(const void *a, const void *b, void *priv)
 	const struct btf_type *ta = btf__type_by_id(btf, *(__u32 *)a);
 	const struct btf_type *tb = btf__type_by_id(btf, *(__u32 *)b);
 	const char *na, *nb;
+	int r;
 
 	na = btf__str_by_offset(btf, ta->name_off);
 	nb = btf__str_by_offset(btf, tb->name_off);
-	return strcmp(na, nb);
+	r = strcmp(na, nb);
+	if (r != 0)
+		return r;
+
+	/* preserve original relative order of anonymous or same-named types */
+	return *(__u32 *)a < *(__u32 *)b ? -1 : 1;
 }
 
 static int sort_btf_by_name(struct btf *btf)
 {
 	__u32 *permute_ids = NULL, *id_map = NULL;
 	int nr_types, i, err = 0;
-	__u32 start_id = 0, start_offs = 1, id;
+	__u32 start_id = 0, id;
 
-	if (btf__base_btf(btf)) {
+	if (btf__base_btf(btf))
 		start_id = btf__type_cnt(btf__base_btf(btf));
-		start_offs = 0;
-	}
 	nr_types = btf__type_cnt(btf) - start_id;
 
 	permute_ids = calloc(nr_types, sizeof(*permute_ids));
@@ -1259,8 +1263,8 @@ static int sort_btf_by_name(struct btf *btf)
 	for (i = 0, id = start_id; i < nr_types; i++, id++)
 		permute_ids[i] = id;
 
-	qsort_r(permute_ids + start_offs, nr_types - start_offs,
-		sizeof(*permute_ids), cmp_type_names, btf);
+	qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_names,
+		btf);
 
 	for (i = 0; i < nr_types; i++) {
 		id = permute_ids[i] - start_id;
-- 
2.34.1

