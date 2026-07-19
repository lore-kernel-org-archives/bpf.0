Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EBA399D00
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471048; cv=none; b=RsXiSjwbSoVJ/+v8mvmDewUXz4pbEVI0JulPySLLL1rbbXIRPZaFetxSP7EFRo6P/BbbbN9UrqsCQUzfBed7aZgF1o+itHDpnbGGYsnEMlJuMxrsS6HwoXlNpEmHWkxJJrDE0a3m/urFepDMhnE98CLXhdwNrviKpVwQfOf64J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471048; c=relaxed/simple;
	bh=Rdd4aKhp3IWKemKhAOEiHlsZbX+489/SFdRJzRG6mmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9YFwLiFl7YFkefKu6s7fA9JzubN5ElgyFP4u+C6ZbozcPnewzC9Sm9G/jSeTpVmojumq3dSulBPVrt6kvANT5tlh1CnesuWzTQ+F5FfRfxe0i+bMN+eDMsVQtoixD65sfrUXsz5+nYZVlW34KrUsHHLVatmPOiL6Hq/R2GnkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+K7RcH5; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+K7RcH5"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so2459335e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784471045; x=1785075845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMgNtgCgM7WI5KnVsw3gdGXTAR8zPI8BgPugHXQIxf4=;
        b=h+K7RcH5UodeZ1fWmdRtHkgm8bIAF7dB+24aJbrHyFoC5txSj2KxedLJF5gJn6SoxC
         XBBBRjup+FRqWk2tEWu1C0hVk9yT2Vl0gNLDzYQ6qGac70GwldvNw+ihB0NP/UhZkzuy
         LSHhkXHiWRObF3FjSKxYUapyPsMvMyvvq65dvHzscN2Dypuxph7d7bHhdOQwZ5vr/agH
         qB6XZyL8WtXYdOaZ5hXK+hdKhEF/A170qQCv0xf+F0GVEOrv+zapxgh+pSFTAi3pvdOy
         vSdZWx3ZRuncov7T3pM1MS+w0xdgr4Ua93QnvnWhnvwpd0iEs9sg7eRhtpoUgYHvnEXM
         H9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784471045; x=1785075845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMgNtgCgM7WI5KnVsw3gdGXTAR8zPI8BgPugHXQIxf4=;
        b=T4zvpj7LwsMGFRuMQ+YKB1ZEhYIuAGUFSMj53cmlhxJ1XdewgK0EykB+hRtjuk1pWR
         ouzSLsqz5YWNh0lWKGEYW0BuAqZaZFPU+F6asv9HRPUBnWvOjYYoVS/+FuS4wr/3B7ta
         ZBh0Eisv4GhNVs5900AeZr3AV50gGoeq2AE1eNd2QarD+9fb3sxeTKZyK5T9UrUpq8Dl
         mNPk7bHUKSOp+wmWxRJ17TKwDbAK1JEMquDcl7zDok/UQcEJAPYMV7/k+2dXX3kuRW5f
         9yeccCbx+usK9ZAh1Rc0oY9A9KywSNJTN5ZoHDb3Ace8ZDPxM7qnwLwblraQVdpehgpl
         +4sg==
X-Gm-Message-State: AOJu0Yz7cUmN/vlx9A4pKA6Mvw8HFI7PwxwaFTA+qlG5UJfJ6paBDbqx
	uEWKFDXiQKy88Ia6QgPShknXUu96mIgMyP0WOGK89n2KCUZnsgt5BwwubyfdogM7
X-Gm-Gg: AfdE7ckNcMFqusaZ1Vhqf5QefFApCA38nsb5XZnLux5HsPVOHXJHfPlH/RjwlD4WSVq
	c7vbuE6vo3oELelhN/+4miQk+1KGWAQIUVuEE34f99ikqGbT1ndc8GBDmI8/biF7mjDMzDR3vnC
	lLxZu+imqABL1DWlPqOIDtD+oEgaroeUh+U4Kl/v7NBojKtdc4vnK0FpggiqqPTNWXudC9K4fKZ
	cTz2ACLPJAXu5mwBP9ZtM1UpbI6Tc9YzHAbzi9B8WdR0b+h5R3CrFwkj1Fv63CEYYJev47NdlvE
	2eWpFtniD7XwjUW/eP9jKiPCbORjyyfmJ8N6BfI0zOLMCn6mcpRusnwIDdwx5eaNO+cdNdFRsn1
	eb2vmRInl2ZIRMw+mkHZbC6wKTtXTpVIXHE31hofWRE9Tp/BksE92OsqpUzrL63dPC7DTLjdhjL
	AFeU/QXos7gjh3cYa7cDqVZCu/l+5q2UISrUnV/fXNLGqJ28TA2yHtPWb5DB8yVPeY7ypweu6eO
	daHqIoFr0HqXnozZptyzvnWlJBd2tmsh6HEs+qy96vb
X-Received: by 2002:a05:600c:3b91:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-4954a3d0065mr140895085e9.3.1784471044516;
        Sun, 19 Jul 2026 07:24:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ce4sm21801563f8f.8.2026.07.19.07.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:24:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test duplicate unique fields in nested structs
Date: Sun, 19 Jul 2026 16:24:00 +0200
Message-ID: <20260719142401.2420111-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719142401.2420111-1-memxor@gmail.com>
References: <20260719142401.2420111-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=memxor@gmail.com; h=from:subject; bh=Rdd4aKhp3IWKemKhAOEiHlsZbX+489/SFdRJzRG6mmk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvm+tMPV77l7nT+rs6b3v33yeOTIdlGv/i2tkYe/NzZ7 Tzlhcz9jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk8QyG/z7rXZs8Ek8FnWXZ tF7k5ca82ysPM5xaMLf1Z/LxtLUX2v0Y/oebLumrW5JS87OkfyXH57OvdimuP7R0O5snk++E69f nbWQCAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a raw BTF test with a spin lock directly in a struct and another in a
nested struct. The duplicate must now be rejected during BTF loading.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 66855cbd6b73..02c4c60c841e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4250,6 +4250,32 @@ static struct btf_raw_test raw_tests[] = {
 	.max_entries = 1,
 },
 
+/* struct inner {
+ *     struct bpf_spin_lock lock;
+ * };
+ *
+ * struct value {
+ *     struct bpf_spin_lock lock;
+ *     struct inner nested;
+ * };
+ */
+{
+	.descr = "struct test duplicate nested unique fields",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(NAME_TBD, 1, 4),				/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_STRUCT_ENC(NAME_TBD, 1, 4),				/* [3] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
+		BTF_STRUCT_ENC(NAME_TBD, 2, 8),				/* [4] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 3, 32),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0int\0bpf_spin_lock\0val\0inner\0lock\0value\0lock\0nested"),
+	.btf_load_err = true,
+},
+
 {
 	.descr = "struct test repeated fields count overflow",
 	.raw_types = {
-- 
2.53.0

