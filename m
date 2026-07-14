Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF90327C18
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051328; cv=none; b=QMVcBDs6ZIoq0vg5sxM00pekGW4QOG2NZt4DC/3gubpdlmm/zzwd7NSJgUZ26EqAarg0mtrdwugIquGYiuPlGxUBR91rAkDCSILFeO0lRwhQfWBQg7BLqWQw1ScV/gmJTu03J+yeXcmTpc/Ltt3SaQmlVlN1vSvdGWaN+0QD2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051328; c=relaxed/simple;
	bh=8e6hSHdI724CwWnH0GaeVjz34PTzNe4kgTZ9OdXxjt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6h9BNMnNk1ZO9ekSqeTLbyEnULaIAFpGMwwC5T73sXN+eAxx+ftmDMAbPLe7pWKxaqWjza8p+lnvpOzkf5TBS+zZi7DA/dF4UannNG48mOvY2f/9BrGhXtRF+XxVX0e1tlK6os2TgVQoasnsOhDuOqJMXUN1ePKNMT0x15XjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YmKwBtKK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YmKwBtKK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso2876528f8f.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051309; x=1784656109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnbOgZY6mix2R8qxVZm3ntkswSOtMNcqG52n3byUMp8=;
        b=YmKwBtKKNI31nt33hUMyAvAXSbsDXbVKkqOG9+b4QX9o5ZROREIVRN1KmVwVJgJws1
         6XjDqu+l2e/FefhpuC6KyPz6Q9yxDf8gHXZgmXCJQfWLbeYrxv+i5FmTz1CPIHc0dW6E
         L0q0Jcj0IAfkgkaeR87T24rHxwSaqJ5WL74EaEqXfrlHqeaYDMGthn6KoJSul6Xe+Ht9
         jD+6TlcGxAX2Ory+wZZrpo4VWQ9VZVu9r2wog0A+/05rbYgu0PioiANnoNyxrQD9chSQ
         nMfLzttNTmZ5URRVXK/e6bSGthREbKtG1FsDLmMxhCxEgcTPN16qZBgUbJFqO+Ve13YM
         eHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051309; x=1784656109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnbOgZY6mix2R8qxVZm3ntkswSOtMNcqG52n3byUMp8=;
        b=p3ZchepcbuoxaCEbdVI1n0zuczFhx/yK8/UETgYmRZB6LI1nrlABQE5DOWTWzjHFkm
         dhh/G5GzhSqOpbDH6t05JSN7ykFhApALVOJ5O4BdFXds52GVDuWldKsnGsNM9WU52FOg
         CWGVHUcW4pQbOsPE3fmNJihHphOY+mxuOyazUShMwhRVyenVTQjY14DGHV0hFMcnBk3/
         Dg3sZK8F2O/9JrnhFlfK4lfsSdPCRi2KkR6Ur/M5e1GIzmNf0buyLlQaLvwUvFDPCZxZ
         I/0elM3bDbPHi+oK9cJDtGMOldQhUy1yLM88Dpr3dZAhcC72rDmUUW7IYpP10PPgQ2qU
         8Pbw==
X-Gm-Message-State: AOJu0YyhIEdDRFugs0ALHDRkGpvEWYpcmZ+GtjX8hx3l7Woe0wAIV4xP
	gwRuj224IbfeJJLNFbcTmgX0x5kSae71qaI4JHL1YVkTfnLCogClqMbpLuAXGHUrYlLKAzomI7f
	aC4BLZ1o=
X-Gm-Gg: AfdE7clv43fUE9+XsfsWB7k8Is5816jLS6CvTvfmP+VAU3O24TiIJoDzoMClKDVWmrl
	kGrvZohK3VcfVp88J0ikOJwTHaVsBqXSS53o5NLbJOx+nHLzeLuCXaPs73LE8WLeEdowOKZrAsD
	L6eE2mHsory/CQ2UmQGQ5Dy7y8Pzsy/BjarLddzE2iqS37jRZZInqeWfWvX5S2imuw58Daw8J1y
	Jc4Z41Mya9Os2MmNUuMvlblFIJ9q90jEckWDnRNUW6zMG4gN9ZO5zh1w8mtBtmzlQ12z81/RSkN
	n4WwymdRoa88fXxhzWCs1fQf3f38GQDiPuQWi8fL7qxemvCjbxqv2XC6KvSemjsl+0UwthfO7dI
	GD4iVkIlejyPUA1X2ujdf7FE6F9iMowkJ1MKKNfrLZfRsjUgbr2ajZ9Urx8Cq8YVaqJbT7K1Ruo
	XFIFvfyBBNvcM4Twopnnsc8tzKgieuwCCvccyR0B06bcIjADA=
X-Received: by 2002:a5d:5f49:0:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-47f4886edc6mr3882336f8f.4.1784051309376;
        Tue, 14 Jul 2026 10:48:29 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm10826048f8f.22.2026.07.14.10.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:21 +0200
Subject: [PATCH RFC net-next 2/6] bpf: Allow access to
 bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-2-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2

sock_ops programs receive bpf_sock_ops_kern as their kernel context, which
holds a pointer to the sk_buff being processed. Mark bpf_sock_ops_kern->skb
as BTF_TYPE_SAFE_TRUSTED_OR_NULL so that BPF programs can dereference it
and pass it to kfuncs expecting a trusted sk_buff pointer, such as
bpf_skb_storage_get().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a78ef1e37f24..e10886ca5089 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5675,6 +5675,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -5717,6 +5721,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0

