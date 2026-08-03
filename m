Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62E32D7F8
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726904; cv=none; b=iHLl/dlhIowWqjWKjnqfVBu1vd1lci+DNfb9N0S37TfSZ7qDRaAB/WuXM1dq24Ft1P3YzSRej0sBzSY1OVdhsMAdev3lYIoYDXod7YCH5rg2y7/m+sZB31k21GqXgmbviB4K61iTtgLqi4lxWPkW0j4YDSIfIRm+r1gX2KLPhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726904; c=relaxed/simple;
	bh=YaD6RUxbooAFyVNAUjaitE6hvIlZXLimx5nLk7lP1Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSR25pgu0Yfqg44So5Hhb0bTiqd5E2bVekXPf7+b284mE4+uEbuXT3A1BybeoOUAleBjDiO7/LD3U7Yu8OtYZAc9gjPB8vU/ZyZMz0mW2ePa6jYhOprczCrU7J0EUA/Ke88KMCl/0uPDL4W7jx4rvE4XFZ7u8a+M0WgFcDT3VfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEiqGrRq; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEiqGrRq"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4700bd8aed1so218399f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785726901; x=1786331701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gv9RWj0Z9j7Vt7yBHkmCGBMZ3OGPiuLSZW3DpjJjkHQ=;
        b=WEiqGrRq2c1SVqZKGbE2BhmprN5RsORQ24IKVFfcQ2ODWw+fflK+f/viwOBOq6J0eW
         ZVV/N52/tJe2RfATHu5ERQOI0KgaimeJqvMkeVAL/E7odj+Pjpeapa1Aaxb3s9BXnk8I
         xTrAFnsKK3/aW3g06UvS/ThYWMTUBk7IfXYXvxuE+xMPirMNr1lDIgOpF+/KmZNeBnRd
         6TqknbHjFfaiXE6NXYmZvkyMVgCVOrbkeDASwFwDhlJJSwTklBbLnkt5/L7sm5+KSlBF
         Q+1yvvhyw6uqgwUnwEnOxv3xK2PAtc/DBV8WqDq0WywJsg/gamfh9nRrVSNOxxAD4eFc
         JUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785726901; x=1786331701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gv9RWj0Z9j7Vt7yBHkmCGBMZ3OGPiuLSZW3DpjJjkHQ=;
        b=mR3acQM4uV2qmU8oCgVD0J5DXSTXvFAVhQVnmcq9oRGJrTjV4DBKotDrINg9u+uBIp
         wmw9dWlL9MNd/LAmgLTwrdYyH66m8TFZyjl1C9b4EMZ+bFeNoioN+6cXLyhOCeNBaE46
         pTVURt6zJRS3nwtagOaD2Vp8m8zLgSfySppCIRkZPCMIZQBoXFTbiWV3lJ+ms/Wwv/lG
         iBHCY0TxKFCMtPexj4BeQgXGgvyBI6u8SZbsCj/8ps7NWkXVnjnnhAjFWapT1a+0SSl0
         TvaeeRT1fRxngO1JA/NuR3WRwBX0sIGJ/LvM5H5zKySq3JMWFDrzkiNqymrHu5jKPg3m
         SBWQ==
X-Gm-Message-State: AOJu0YyKLun9CwuTd/ywKDO9OaiSCKQQ6yE8czFIASbKLaYL9FsM5jRU
	yB/9uobGU+dOZqO2IBQCwhVxBhhxUnY6Fs865BxgTeZZY4KsC24Tj4Zq2qO0kvm9
X-Gm-Gg: AR+sD126tJ9bIM+QvkeD60xz+NEwLaQtBW3mCddOztky8WaNLu3Da0jbRPqU4DCnRH+
	WUIeoshMbXxpEs68jkBlC2rNvgjFnhGKuc25w0cfOtjHgktKwoBy/1w+fBs71fcCG7737DaL7h5
	3OdiLqM2GkeMXHWVsJTwStUhvM6ZRN7AkyRAkUTc4rWDIQqo+WPaBUMPah/22Ha4bPKeF7RQIxD
	snhB9owVKZ/Ep4tA9gRPlwmhVqEyTreYOt62NMh9KilISsQYumTfWDImKbllPkaPRyG3ao4Z4zq
	OabWnQVQhPzV4KFA6ArQ9xMisd5er1MWB7aq3wF4Mxd3TamTm7tJhHsEL6YriTaFncpFfFC13uA
	JWsZaTH9bKutCkwZA+rMnUblZam1CuFX06qPpYNx8WYbeI8tQz/CS7qw5hhS9vaE+N0hWn7st99
	XhA/9hHIUyQrqhsTFePxinSBPnbGP3DNwjQl0XOo9NRQKa/DZu++uz7yhy0uNu+yvmATZxspShL
	Qbae9V/6j0/gfZPQDhHOjc67kAKyJJ6xFmfUJOkRATCZCGrjv1lwQP6tG0dZQRcW8sMteC/vFvV
	kkIwlNZHPAQ/C96MKWf7Lxv5n7zI+mX7PdXpyaE=
X-Received: by 2002:a05:6000:22c5:b0:47f:90f1:5dda with SMTP id ffacd0b85a97d-47fd725b1d0mr16359481f8f.1.1785726901215;
        Sun, 02 Aug 2026 20:15:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b05fsm28978941f8f.28.2026.08.02.20.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:15:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Test stack depth stats without BTF subprog names
Date: Mon,  3 Aug 2026 05:14:55 +0200
Message-ID: <20260803031457.3115812-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803031457.3115812-1-memxor@gmail.com>
References: <20260803031457.3115812-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=memxor@gmail.com; h=from:subject; bh=YaD6RUxbooAFyVNAUjaitE6hvIlZXLimx5nLk7lP1Nk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauAffYL69MJM7x/9yziP6YqeZShds0rzb2K/F+rfCP0p 53bEbelo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5tYjhf8CyqVws+xaE8az8 +9HLvf5UbMCP4jNrZeMCG3MdY6929jAyrNuteObBqwuzDAMvLby96g3vdZmcSQUHrYx7hIu371o /hQMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Test the stack depth statistics emitted when BTF function info does not
provide subprogram names.

Make VERBOSE_ACCEPT request verifier statistics so the raw-insn test can
validate the <unknown> output without a test-specific log level.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c  | 2 +-
 tools/testing/selftests/bpf/verifier/calls.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a8ae03c57bba..bffb7360434c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1560,7 +1560,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	opts.expected_attach_type = test->expected_attach_type;
 	if (expected_ret == VERBOSE_ACCEPT)
-		opts.log_level = 2;
+		opts.log_level = 2 | 4;
 	else if (verbose)
 		opts.log_level = verif_log_level | 4; /* force stats */
 	else
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 8cd626e04551..14f6f260b88b 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1091,7 +1091,11 @@
 	/* stack_main=32, stack_A=256, stack_B=64
 	 * and max(main+A, main+A+B) < 512
 	 */
-	.result = ACCEPT,
+	.result = VERBOSE_ACCEPT,
+	.errstr = "stack depth max 352\t"
+		  "stack depth subprog 0 <unknown> 32\t"
+		  "stack depth subprog 1 <unknown> 256\t"
+		  "stack depth subprog 2 <unknown> 64",
 },
 {
 	"calls: stack depth check using three frames. test2",
-- 
2.53.0

