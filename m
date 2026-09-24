Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4153DAACD
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219455; cv=none; b=SxuLhoWJtK1Ynq9FDZhcsMR15FDeNOVEzSJbbbjyX0eHepPQuGIGYYgZBP3mTr0bp4DYk/Per2u9CKA65qFP8tkIhtEyKTXNFCbkzkXMcNtWI7BF+4gvGFzIDHl2vPASxoBWYGZXJlc2t1ZuIT8PYsEmImru3eFo3PxCcDS2Vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219455; c=relaxed/simple;
	bh=6MPv1v8mFaJ7hWL4Erlfc2pkcb2aU7wQJUl4ghsFhFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkHjRrOsisjam8muu2UAuNh4J0ggLMXv+WZkawr5pfQ1bxAEoTOUhZKBxS8/G2r5bMfZ5/8HHS9ldRoBikfY+53NkcgkazoQe5z7Uu9bAN0/B+aQIl7Uw6xOkmbyazcdgrBthK3Omkn1IqvWljziME72EhLFcFF7fspIu3BaeyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edT2wl8m; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edT2wl8m"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so718924a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219453; x=1790824253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOb30dgaSLoeeaRuzhX+9sNJPD8P8kM5wAZCsI/iShI=;
        b=edT2wl8m7fwN34ZhYF8LpXRUsvzJWrzmQwMctwLGScz/4gAeSs7nuH2BN7SuxZEYcN
         hnGoFuu+kyt76oJpLbi9g22I0Phg9CON3E3MRZHDKRZmbt6hkT0yYXQoDlCIBAPfcrJz
         bQZ3z7Ax231HM0gSE/BNZq1p8twylf3VA+R//v09mZ14IWQIEvugbxUBZMrcEfssYpES
         Lk/usoT1Ny2xuDgK0+M5C4Yul5nl24o/aCxhycAFEIukbCFPm4yYgNY03VihjCkne46M
         dopWfO/7sbrONK2pkQ0KpFMI8dI8sMcmjJhC9xirKAETMWm3/fAHQJZWAjtQd6DlbiT8
         sfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219453; x=1790824253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HOb30dgaSLoeeaRuzhX+9sNJPD8P8kM5wAZCsI/iShI=;
        b=XlQ1FyZ/AF6GLx90lQUQDQIEgxkcIpTzIexPcTq29rtP8rYaSNLNdfFRsfwVys6aFU
         lWIM5+WQotuYxnAj9G+nUdtU4YfD7xcHTH1uQQ5GMld2bPddd8cy04pKQwqw/peaWh9t
         L+kgo5W55M9JCXxHyxMWQVgG6CucsnZcm/4zuD1/+F6rPjZhWIzbT5kQ7G3EexVkwmB1
         jcmiDaj+L9UmDYCUYv1OgNRsreFGEvyk/DsrV6slEvs7SwmtWVQYndQAkWWzUs0N/hnb
         v+jt/kNDQZaiQjtWNZBouRKSmGjJDg9Qh/jE0p6HT7TCl3bHNwZU0ccjTXJ01lnZKZil
         jv4Q==
X-Gm-Message-State: AFuF++kEGQqW3i8pf74WJK3+vd1sg0gnEBkbWRQ1TVQpvMvzk+WRPtfg
	z6UMmJ/DEtLtHkcBAb1i4JAvKU8kL9mLREue2/ghMVoLFChM7iJX6sqE7RZ9FQ==
X-Gm-Gg: AYBFou0+jK9DvbuABd/j1BpZaCAcD2OCY2wxA3qLpYfbUPW/RMHDhDV+jYTbvF1L20d
	5aV1WN1Pk5lffWn3CUmQyh+io7TMKe/rdQhUMpgBanWKOoc/nQHmtvx3/PMN+Sy3dGqwgJK3BBj
	kGBRXwSiRvFclwG94adFp6ptQKb7geSsoenTAxWqvJVVsCI4XCiSkdAb/0OucREz463N61SBIUi
	1w258Wk8gEHET3DRd54iN8rU8l+Vty9fcdZTfUyAd9S9yoD00vJghFlrFXM8s52rDfxcgJvldO5
	2b3Vrhl6MRuVx1RQedEpY1BL15Y8c2kaBp+4QSBwnH+72eAxJslT1jkClxlGIY9hP2AgErRy3Y3
	vXUm2q96oLPGwhfqTm+CEcYLATsOS+TGILjyIVCBVYv4nxeO4PSTza+MFpEuBWOamb90oTyREdU
	gtMCi1OBNLSklHSDz7JonJ6VmKE6CnJjOud+rZZ4tXyd6+snb8vnh7J1+ZNKRZLRN6zzwwQ4zK0
	Mft8bBKgPTGaWSqWTaTltATemJ4aGv6/LH9XsNfnqeBOT27k0bJXqtYiFiwqC/3KxYHNGXlVN4J
	L6dqYrp7ZTskWj4VaThB+JuQBX6SZ8u2xsk50HTWKj8=
X-Received: by 2002:a17:90b:4f89:b0:39e:6c68:fd92 with SMTP id 98e67ed59e1d1-3a098b92d1bmr607206a91.39.1790219453249;
        Wed, 23 Sep 2026 20:10:53 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09766210bsm1967456a91.8.2026.09.23.20.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:10:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 02/17] selftests/bpf: Test recursion through a global function and a callback
Date: Thu, 24 Sep 2026 03:10:27 +0000
Message-ID: <20260924031042.1690890-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a test for recursion
callback -> static func -> global func -> bpf_loop() -> callback
that used to hang check_max_stack_depth().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_global_subprogs.c      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 966f49348787..27fbe54e8795 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -536,4 +536,35 @@ int return_from_void_global(struct __sk_buff *skb)
 	return 0;
 }
 
+int global_calls_loop(int x);
+
+static __noinline int static_calls_global(int x)
+{
+	return global_calls_loop(x);
+}
+
+static __noinline int loop_cb_calls_static(u32 i, void *ctx)
+{
+	return static_calls_global(i);
+}
+
+__noinline int global_calls_loop(int x)
+{
+	bpf_loop(1, loop_cb_calls_static, NULL, 0);
+	return 0;
+}
+
+/*
+ * loop_cb_calls_static() -> static_calls_global() -> global_calls_loop() ->
+ * bpf_loop() -> loop_cb_calls_static() is an unbounded recursion that the
+ * main verification pass can't see, because it doesn't follow calls of global
+ * functions. None of the functions use stack.
+ */
+SEC("?raw_tp")
+__failure __msg("recursive call from global_calls_loop() to loop_cb_calls_static()")
+int recursion_via_global_func_and_callback(const void *ctx)
+{
+	return loop_cb_calls_static(0, NULL);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

