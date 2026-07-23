Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42053DDDA0
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838301; cv=none; b=emuo+xie1pboaXwsVqY5gI5rgH88hCxZpJO5ZZ/o33prfh0m+9LPEfDLgd5Z5ihIjMNWaurS/z3OxsNpdJY95wCs+2zADWSg3P3gSbLKn7iD/htU0Ko5ixJmru04Qe4O8rMGHjDLVA3hCIrpAVguW/dK8ZuHtfIoWSnTvv3kJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838301; c=relaxed/simple;
	bh=pGEDJknprXPvyzikPszEQwez2US0q5OprTvUgKzonng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTx3tAp40P7eEL26PZaeBPFX/3vf0Ia8VYA/aZA0cGEgJECYY/JO947hGArXOFMFc4Vs/N0/rMhDU+kULNfFdiQiRFOPs2Q3kgQFFUHzBWdWw+twRpczZkgYJpMS5aHaJMHVoqyjuEUrLrUbjpXvZEniIRxQeT+XpGL2+V5CJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndtK+i7T; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndtK+i7T"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848743155bcso511056b3a.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784838299; x=1785443099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5gWhDKCNXRwjPIixR6RbpktLj7ni0khxS64iqWLrpOU=;
        b=ndtK+i7TZ8L6DfZJRTiSKagRpkae1PhDcTuigjD7rZxnRVyfZA2J3svZmCKFScZMfJ
         BWk2Q19jrR8NViQTrN7aIhPLRM7Z6LVieCutITVAGLsdF7FXBpF2IfNR5d7yZOGCv5Iq
         V7uKVyx5fxByZ+xqZgEefK4Zn+2QBN0Bk9co0OtRET9l4P3j62UY7XTUSXV7UF/hlfCA
         vl60kTLK/sCHyrf77cOgeM9m+J5nEItGsrJYYLQqeiT6gj1Xwy3IDFaNe9ZzlRhEg3n6
         7rISVXhNmPA1H5M2pCmTn2yHbTdjs7PAYXx+WHrBIKY1t/U8cF98iOp3JNpqkwpJZnDt
         vDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838299; x=1785443099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5gWhDKCNXRwjPIixR6RbpktLj7ni0khxS64iqWLrpOU=;
        b=lHMEx60vzKz3wthZDw0BIcWiL92fMmi0ZTasYNSiEW7yAfP9NvRUMl4uc+Jvv1aucc
         /pLvEizDXQBm5IuAQ8Iq/OzMs7b5d59UxSgA75FxggjIxgxrvtsMKjwBTjBThhE2FzMR
         vYk0CZnUtTClGe3xLmvU/F/kSGDxvezrwjIRLwaqN2dpykDDF9tuzlFw+dPQad3zO4hX
         qaDftT8CAcVkWhttdDnJ1SaWI79MtDURK0eDRGke8y8qfg7iDNz3cfIFeY0ORGAE+Z7v
         AP4CRRVJkghJ4Iw/joXNATYb5lIyDTiexmOvjKP29D6jCeX+BNP7OEST8fUiDyMdrwoG
         zYGQ==
X-Gm-Message-State: AOJu0YwwW54NjXkq+j8uud3mKQwInNCNcggbFy7tCgEuduK5KhXl7u69
	6qgsDlnXovbXH40Xc+DJNjQUnRkUOMC1K86S+9kXWWgXO8BZHLAhrS9g4CpNgQ==
X-Gm-Gg: AR+sD10dhEvgyL0le33ARml0BKuJ7CIBitVVJeMRbj+aC6VrMuFObNtnCAhNU7ivpu2
	oxhIyiU2KJ0i4hAEsT0UIlPg04jHUgp7PT6wDd+Hs8KBcDOfar+z3dxxZis47xW38bKCczo7YrP
	TqZu+ItOZLHj+pwS2GHehR1zwvv+d5p9r9sHRfRLUKeNyruuXfcD3fYJtCbOpCVGNcKhfQaa3Aq
	tYFba06B4w0DYjBwd6e3Nk2KLtHLq4J8Q6iJHRPS0uG66VI9BPrd4Sgt/edB1v9cS/DkOfzYuAr
	jaAoPHIZmuHQfEDwK/XiGohsP7kQwKWVy2KiUQykhWT0WFA7OceSQqpcLvKMlPwnDpt9GVJaEZA
	PzrBND/4CzL6Md56bx+Cr5BJdXBU3bKAyLHZTiwrw1Wh7XsX2AUbIo7Oe3ky9GGoTSMBq
X-Received: by 2002:a05:6a00:2d1d:b0:84e:1da9:6a29 with SMTP id d2e1a72fcca58-84e2bb1d287mr5289252b3a.50.1784838299168;
        Thu, 23 Jul 2026 13:24:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e2c36b12dsm1863903b3a.45.2026.07.23.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:24:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: Test passing scalar NULL to nonnull global subprog
Date: Thu, 23 Jul 2026 13:24:56 -0700
Message-ID: <20260723202456.3754267-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723202456.3754267-1-ameryhung@gmail.com>
References: <20260723202456.3754267-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the verifier reject passing a hardcoded NULL to an
__arg_nonnull argument.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/verifier_global_subprogs.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 75a2e3f48d0f..71acc087e3c1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -185,6 +185,19 @@ int arg_tag_nonnull_ptr_good(void *ctx)
 	return subprog_nonnull_ptr_good(&x, &y);
 }
 
+/* a hardcoded NULL is a SCALAR_VALUE, not a PTR_MAYBE_NULL, so make sure it
+ * still gets rejected for an __arg_nonnull argument
+ */
+SEC("?raw_tp")
+__failure __log_level(2)
+__msg("R1 is expected to be non-NULL")
+int arg_tag_nonnull_ptr_null_bad(void *ctx)
+{
+	int y = 74;
+
+	return subprog_nonnull_ptr_good(NULL, &y);
+}
+
 /* this global subprog can be now called from many types of entry progs, each
  * with different context type
  */
-- 
2.52.0

