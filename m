Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B232E141
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480077; cv=none; b=UpcNNUD8S8OPDlmfE/KrI0eK4qbp5Gv/2i4VMA3xZ7HlZ7OW3z92/L9LiXpMlwjxQhtljh42cnqyE0hpnlI3e7fZEfhg/QXO0Y8XU6nDa1fpMjiMrLlrFxGtpkK+Q1+K/Y+LaH1RF7TsG/i4n24shImbK4Y2tQ5or23pSDJQbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480077; c=relaxed/simple;
	bh=sgZBvOXxJcuZCSylrS+zVTzd+4sieqVZlU6ATpdC9xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9V3exerbQsllZ4zxoahMN540qr2zDqooDi6rCvtT6YDwWW78NkVP61w+JLWFWohpDIPdhdWQZ+MNfErEJq8AihozALj77Q9WvtYz7rJt5/rUqLxAyl+28IIfujrjef3H3WAHR419Q0yqa5QZo7X9EGyoPfuVfxUSDscnOghOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oix3fkCK; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oix3fkCK"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47033972bfaso33617f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 20:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480074; x=1784084874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VNeM3h3TtPJ22j3vlXJjNhFHTJSaXpnltI+peQnqspE=;
        b=oix3fkCKs9r/NEDydT6Bqwny25Ygz7eq7MuqzYGChEHvVboylqvV52TztYgM7ZW6ow
         CaDKEOKED5hoJrS6Q6ToiN5ggKhsJcfgYDhVqGpQgVczaYHn8CpQyiVXeH5XzEW/lOsb
         WXbFLvpVFNcFrTiF6siqnndClk/msPXbvkPCZ65IwCx54SNAZkPTI7dT34zdC+S1Vl34
         zw3wm9APGOrMU11zuEsHyu3/ZuNEX5iUW/ERDp9N7P+zRuDPqitWcSorudU4KZoKEjqM
         JD+l+69uLr2mYnQuyiLJ8jyTSdtKyF3BMR+NLjynRm4n1pjwGvKOCRPR2ut7GBz0Pepd
         VQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480074; x=1784084874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VNeM3h3TtPJ22j3vlXJjNhFHTJSaXpnltI+peQnqspE=;
        b=Qs2+wzTTf9+KmwiuHIxdqUwovIX0mFHDknGnoFLRHjiIobTt6umxWBoyrc90e8Zotq
         JgyMWQVCBjabO3UitObBB5JTnVdDgZ4Ys5GyaUmA0Y/o6rGZ0nMmbxrHbWhUNKioK19x
         iYkDj9pPcpzKKenyNdQzXbW4V95fFxioLwSYke1T6lQa+RgnHM69k9RSpPHVSD0Rhtho
         xBPojLvxoEFvwagyDB0y2wn1QQbTxLagdmDs2znl+U31WMcD9K3rr4fkHPyzADKLZaLe
         dGb/3PfUdm12skDWDqdIpxbM06kM//TsFqXD7EUSmhLVb5uQhWHYLkoHLgR/6om8UnAN
         TNmQ==
X-Gm-Message-State: AOJu0YwyO4CQ+khQUBDD4ovaYEZe0t+/Gy7WiRWThK3HfqV/GDRPGRfY
	V6Z0HtdvO8Cm5+wO2jcsNCKJAyECD9k2jKAuTajASNbmZOPNIkLkISJIPc4dWiaU
X-Gm-Gg: AfdE7cl24pQAj6noFFW6wmeqvPhTnFoGA+XaXrOskdq5vz6TGMRWc+3qXClifTzOIX3
	NG3NC7nrHZ00bJBb5hshMvOyKn+WxoXfG++Lke5AY+Fz9IL0tKxyvrUCY/2LU6zjRlA9zcK6/cR
	ZVYBpRTN2Wt9AyABoIjDhO521sERz6RPMG8JBaD07rPFqA6mbOxybDlWviKQrxoS/yBeG9FCOQD
	0JNmOLcj3qZXRabFvETAs3M6Q6XTb10W+QRw9uKZFkAD4h30L11YcIW/3p/L03oZrYTnsPrT9JG
	aLkN5FLmUjOZSsJOKx2rOkR5CelgIU2fCsG9V29xF456kdPIJHaVaH9iaDd5u5VCbjcWJI+qKMr
	sWFcRTopNNP3X3poIckFu3z9JBCTAidoZih26XwW2Mt6ZL1r0Bw4bxGdb6hbeI3Q4rsaCxCYPFQ
	3aPO1bzN8lu+UV5fFu/quem7x6gUi4jqjVMq31obk5I23qfVcojY1lWfqNUojv6CMlc44kGni+s
	nq+1jYuUsBFIAyOrjA/bY26nmc+Rt2tDQTCHFC+nkx+5ykn5m1ksmU4g0fkWiU4Aw==
X-Received: by 2002:a05:6000:2f81:b0:46e:230f:d095 with SMTP id ffacd0b85a97d-47df07a9757mr310918f8f.7.1783480074383;
        Tue, 07 Jul 2026 20:07:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm41839004f8f.1.2026.07.07.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:07:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Nicholas Dudar <main.kalliope@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: Reject writes through untrusted BTF pointers
Date: Wed,  8 Jul 2026 05:07:50 +0200
Message-ID: <20260708030752.2503467-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708030752.2503467-1-memxor@gmail.com>
References: <20260708030752.2503467-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=memxor@gmail.com; h=from:subject; bh=wunzVa7XcBhilVf7ythKHmpm8F0EBKdXqCcul/vVt+8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct3372XaTt3qfj3BknIvL4kuv0o81Zh/rQbWjenM1xhW HBV/B1vRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACaSy83wT2fjr+knWyxWiTHq uJ/XafEXOf5oy8Lpkfffs87/XbPgQx/Df08tCQa/LXZbEr6uvNK0x+j6lPRDF/22aAQJWPGqMhm FMwMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Nicholas Dudar <main.kalliope@gmail.com>

check_ptr_to_btf_access() lets program-type btf_struct_access callbacks
validate writes before the default BTF access path rejects non-read
accesses. That bypasses the read-only policy for untrusted BTF pointers
created by helpers such as bpf_rdonly_cast().

Reject non-read accesses through PTR_UNTRUSTED BTF pointers at the
common entry point, before the callback branch to handle all cases.

Fixes: 282de143ead9 ("bpf: Introduce allocated objects support")
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51f7965d42e3..4f42b4e929ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5790,6 +5790,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	if (atype != BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)) {
+		verbose(env, "only read is supported\n");
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype == BPF_WRITE) {
 		if (!btf_is_kernel(reg->btf)) {
 			verifier_bug(env, "reg->btf must be kernel btf");
@@ -5802,8 +5807,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				reg_arg_name(env, argno), tname, off, size);
 	} else {
 		/* Writes are permitted with default btf_struct_access for
-		 * program allocated objects (which always have id > 0),
-		 * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
+		 * program allocated objects (which always have id > 0).
 		 */
 		if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
 			verbose(env, "only read is supported\n");
-- 
2.53.0

