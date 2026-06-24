Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3D397694
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285663; cv=none; b=PWp/8UXZCj8Du2+pn0PoCcj5cGMmCvg5TMx9NMI9iXV7MEYjfWd6UGeWb01vuBRKvFPwbaTj1s8WZTenqx9H+oR+Eo/35hJzs5SuxgavioBT/NGeMMS9+sOiI86nYR7kNTJ/bFL4fG4KR8qUt8ItNr9palQPxQJlilJCazUbVh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285663; c=relaxed/simple;
	bh=pVd11EH3T/mNIRJabrh1Cdzac8ikx4GAtiYQD2B61tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtzZpG+Y8X6suHdOCKd8oL2YFeIdjAkw1qWuxmwYfeE0GQQbDmiYf4m3//QNixjSgCZ0yvxRJEa664nc+EaZU03xXXCHFEgM6q24t62/XW2Y87etM2hJbKJMGmRKyEcHpCI3ta4lvn7YtonCnkf0X6FiVD+kzcev1VMiP1Uwg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbSXct2G; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbSXct2G"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84594492c26so711589b3a.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782285654; x=1782890454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgCohTv+MX28dL9XB70gpLT76ubfXGom7LP2yheQ7Is=;
        b=dbSXct2GkyWFYmc9JJdArBbvNkGvtnlDdrTECP2rkYhcHrfjM7wNyAOpLYXhxpwf88
         07zVv6C4qoMoKFDA+fXQcB9vCNAQNSd3opZ679Iho9Bc61vSGSFVMmZlkPDzYjRhn/2I
         wbYrwiVJ7hLSCu05oGa57+7ju+hvrH2HXANOHuQUECzZcS30BdHEW/8x1Wr+6lck/tXu
         rARkykTMnODykxd/XCvlBcQ9XVykASIVzMBKF5gWgGPRpm0wiVrySkpRzjqplpCJ8tKn
         /rvT8+v5B0TMWDYadGD1vCPUdoIa4iZYZIkJHz8eRCHnbGTmxkoN6lkRydkMdO7sSHn5
         t3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285654; x=1782890454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgCohTv+MX28dL9XB70gpLT76ubfXGom7LP2yheQ7Is=;
        b=cHZy33vRowE+dztXjGbY5Kdrc/pkFYidfB6Gbe2yU+6OVeWPG90szYJPndu3l9HLdq
         XTF/MWdAvDLoN9LtT3tjuznHT9ZOgpP3OxJEpSs4UU2KnYAEVFpI2f1aXi03Y2GUgxxX
         RS2JWYeWWHbOEdVGZLejlQXjODVtS9Sfp9DPi3GD7h2ccH6cjR9TRdJYJ5V5eRwzlmPW
         iz8ECIHEz0a7JmQf/1ixBxChDvwVr1eylT/l6B4bbGJNjrtMxK17+VQEjPVjjehXFB7Q
         +FHcXthA3SSO29UmzuIc5b9dKN1EX5zyKdcbjJKAax8Umm2VDlfKg4jsa/kiLXhx/ZTo
         7JCQ==
X-Gm-Message-State: AOJu0YxLLCtYcZw+cgNAdg/4eTRYesrqGt1UUeEV7AUi8eRQJ1e4C9gH
	41ayKWB1eRW9yrKpkk5bR6M0DUzQ3lyBJhhqkiltA7J4z+nhbz947sl7W1bMmaQ+s9cw2A==
X-Gm-Gg: AfdE7ckyIuCdGVnYOXPIq2UHEKSIPTHvJ9B9sHbzVWmV241Q+1IsuVwA7OnIrBBPIwX
	sWs4QjrrrHgA/g0WiF12OaqVvupRnD1x9Q4z01sqj344ptc0ArYSKU1Wm01aMAwHqhceqf6vrTD
	HQ3vDmHsR4l1wBd3GZKbStFqV77yQFCzMk6Z4oSuCsRO5GETQCjlUaAO8o8P3YP/Y9YsU9/H7Rm
	qDWZEGh/1BcN89zVDPB6Q7Xpu4b9q5EKYe95CfZK1acuTQiEd3eDCn9EtAvvRwYM86em1yrVkYX
	0uB+TSDOTlszq/NXSA8hyJ6R4AekOKaIaOyHvEAjVOmLNd6ScwgrzijDu11IPK1eHKnfq3qrVLh
	61P7YwZneH1+eQ9oxw8codwvnm3MZmDLCph3xBpImWfUl4064saGYS511vRr284EGWjYw74LTYc
	PDtLnN2Regjo3Jx9qcsGMNFN/le/kSjF/qYdUbB1Ukn89RKXhWFhfJCwRT43WbLcKiHKSOB7g7d
	CmvO/hfSWQyxmucBbxmQGJPUz0=
X-Received: by 2002:a05:6a00:1804:b0:837:e9cc:d474 with SMTP id d2e1a72fcca58-845952107c4mr7570210b3a.2.1782285654414;
        Wed, 24 Jun 2026 00:20:54 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([202.8.105.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413c7ecsm1498555b3a.56.2026.06.24.00.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:20:53 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: sun.jian.kdev@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	dxu@dxuuu.xyz
Subject: [PATCH bpf 1/2] bpf: Avoid eliding lookup NULLness for inner map templates
Date: Wed, 24 Jun 2026 15:20:30 +0800
Message-ID: <20260624072031.735846-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d2102f2f5d75 ("bpf: verifier: Support eliding map lookup
nullness") allowed the verifier to elide NULLness of
bpf_map_lookup_elem() for array maps when the key is statically known to
be within max_entries.

This is not valid for array maps used as inner map templates. For such
maps, the template's max_entries is not necessarily the same as the
max_entries of the concrete inner map used at runtime. As a result, a
key that is within the template's max_entries can still be out of range
for the concrete inner map, and the lookup may return NULL.

Do not elide lookup NULLness for array maps used as inner map templates.

Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..3f38f85c3cb8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10590,6 +10590,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
 		    can_elide_value_nullness(meta.map.ptr->map_type) &&
+		    !(meta.map.ptr->map_flags & BPF_F_INNER_MAP) &&
 		    meta.const_map_key >= 0 &&
 		    meta.const_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;
-- 
2.43.0

