Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9034AAF2
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187524; cv=none; b=RgvNSwTKZSTRtqlBHAyNvRDRes09vOi4FJHzvxDV9h3aPnB1xOeUgZyUIGUwVmjyRBocaOv3y2GQuWCIPBZAZ8qVTLN+y3Fl0lhffLBKoFQsPl5NV1JG1bgjRd0yaq5UwcAhLWSLl+SBfevKnD2ipXN1FAsIqwCGFIcnOdP72B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187524; c=relaxed/simple;
	bh=rR3Sx3eq26oG8vFg+ttxzg4Q0S7O5ujIoOxehNo1UPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UM6F8Gnr4bDU4zKtQIldpxLpfm2FTIiVORwJFrI/d++1cn8tIglwizesG0xSJ5rXXhIiCFkoHG6P2TjyMSlNSbBxRIjwij1P9MIf0JV0KwSSTGZn6OtTNh1bjNlx5DZma+3vT5vtwJ39tczWTKTjEuFuINMiX+826GLatlmwvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUnBXikW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUnBXikW"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso1010193a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775187523; x=1775792323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5dKGzqotJR8s6VIPztuh94aYfR2JwQ+zNu3iYERQ30=;
        b=WUnBXikWFB4ZbXHhacdUCSvTQerDrroE5htgkI6yUyavts5bX9x2Fbb+MkcilD4tKA
         v8GiS41cJs2gLBxAQzyLLYbNki0eZbqCjg7znwALiczRtczz9bni4UbQc2K3iTWWGH1V
         YSgWtO0NyhU+BYF57uraYfbArEEHEDS/2UOZGXMrmO8eV3x8nKUcKRI0v4Uf2x3vGc8I
         EHKVgOvyUgmHYt/OQ0BRcm27+k8QgqF9I6PAL8XeTpMFYq/QjfdGShGYUb/4mQWoRIz4
         QCVlvS7ejc0S8rEdUdxY5GbF1X9hWjbwM2+m1MqYIyfYE/fA2QDp46/7FM4ZhM1x9uwM
         g1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775187523; x=1775792323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5dKGzqotJR8s6VIPztuh94aYfR2JwQ+zNu3iYERQ30=;
        b=UCrMiRLsZgIn1xQkyLeDrr23RS8BLj2EzxO1NUePXuepedPXMk9ukdeWz9Oo8i/11b
         nlD4kG54/sekQR3KBq8aR3Rra7pAQtF8WyfkanK7UvkyMviXBkplZ8zpHFqSYvFqLXJh
         i50f8yKZpYggH4j0nRl1N+kv6QHbkv8ZU4qX9E1MmBiTSFwMP/gWvzpVIcDkXg0AEcUU
         fOpb7rmujfO2L9azryLJFhbPz94qILTU2P8/+OiDtGKhl/NZ751RVQF90SU4iX+6W9DT
         gizdDFnXH0QQK4l3EIWJAovRauiIb3UGKDX72pdbUgo+RtXwltndBNDYpch+Z8i2nZ+5
         ndwg==
X-Forwarded-Encrypted: i=1; AJvYcCVF9Vd4V7Bw+ezcosTExMNIRinanHaefLZafbhHwpiwIwkjjQdK4K4m690Ut4fzwjdiHHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyisSN+6UwKML7gIhBMKJGZWzfJY9VvaET+knlhpoI2S+kpg7b0
	Goh4XUnYjHyxAb609eVpYzXJYFQX+yQ8/jpQfIB1duv+wnFbKn3p5Zvs
X-Gm-Gg: AeBDieulMsUvFWxcnWBdEIgKggILQCLxeYDEcGMPNoRpKKueaBa1Bq1uxJ9GoU7sW0h
	kT0ORySskWZv7gVf1eoiCGCxm5Zzs3bHHlEdkWWXR372JPBwBz+JHyuyCSabjS7dq9BHK/H5ezk
	G7MpzVax8IpIvMaO9e9L0ElU+13FAns/F3IEq6L1ysuEfAOmeLtkrdtY8V4tckbtHaWty81HR+k
	SJV8oR/oY+wAY9K9p6qMiL09/qI+TdsTIuKKZrsQlFPqnZiPDUqcYmZrIve47YYVWYgviLNbRzr
	xBLDlKbc1EBpP8dZ5zdXPMfaJN3jUjiKsbdXJjUE8e11LCtmu/zIvfwSfBnzk2g6gkGaCo48OXC
	zkFh1hl/WnwtRVtDyp32RWEuprPzlJk3i3PQ0sTm7988WffwuMNSaaJpKhC2rFrcqVBCYCJult7
	Kz0D5jTe7VvH+zXIM2aclDWf/HPzPSLKchupA=
X-Received: by 2002:a17:90b:2ccc:b0:35d:997c:8ebd with SMTP id 98e67ed59e1d1-35de6973c96mr1157403a91.22.1775187522941;
        Thu, 02 Apr 2026 20:38:42 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659a218sm4172659a12.29.2026.04.02.20.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:38:42 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH bpf v4 1/2] bpf: reject direct access to nullable PTR_TO_BUF pointers
Date: Fri,  3 Apr 2026 11:38:27 +0800
Message-ID: <20260403033828.18529-2-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403033828.18529-1-tpluszz77@gmail.com>
References: <20260403033828.18529-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_mem_access() matches PTR_TO_BUF via base_type() which strips
PTR_MAYBE_NULL, allowing direct dereference without a null check.

Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
On stop callbacks these are NULL, causing a kernel NULL dereference.

Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
existing PTR_TO_BTF_ID pattern.

Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 937c9adf1b3d..17850836943b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7905,7 +7905,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == CONST_PTR_TO_MAP) {
 		err = check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (base_type(reg->type) == PTR_TO_BUF) {
+	} else if (base_type(reg->type) == PTR_TO_BUF &&
+		   !type_may_be_null(reg->type)) {
 		bool rdonly_mem = type_is_rdonly_mem(reg->type);
 		u32 *max_access;
 
-- 
2.43.0

