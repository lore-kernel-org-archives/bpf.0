Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27113C9DD
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268374; cv=none; b=WufuHQ+DfvdXFNq/Z8J2q9RihOS/tINh2nWIaaZCXWGdMafyMUfeKSoepKyeQN33fjK92w6tcXqLhRYMuJ//UIJlMhgl1O+gbhmvn7obtl9z3sv/QBXrzYbWP9a1E1O7fEYEDjzkopI1PGG9PtLhXGJgbKKkLWeW4JUbXjXIvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268374; c=relaxed/simple;
	bh=cBcNAwMtfRE0MWEVLd0YFM6VqthOJ1zv+n0nTlfSrO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sd1qsphRgnHtINzJAxSCOy9Po/MF+2oHl6wiFNl77buSy7jc5mDFDojegr+wmgFc/fzJuzbEFyoTkfPv57P8BZbJUVUbZciN1h8M6jjqVu5YPM66hPYOT6Pex2fhY9PU5LWpj2JlB/vGz4/6gRILvMZDSmZa2wWy+cs6gyFejOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcBx95wj; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcBx95wj"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso5384523276.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710268371; x=1710873171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85hgbrddKGD0xyBfuycyl0J/43uufOK34r5gdSmrGzE=;
        b=JcBx95wjYfatZoV7caKzbw8gOSMAt4c3Z6D+iO0e+f/q+2AfYAiyWpi6G3pVhUSbxl
         bwuc0IwVbEYG6WLJnRDn+wUvOf7S1L2c6KvbRjhGTaZNWZzFxwf9LA6tOJykqlq2r3kr
         638Ojz/vFAfWnhWwAp03pBbIurMCXpLW/VbesvZ6qFJHOPVPFtkz+pmI4Wy285YTorfJ
         TXV2Fw+oBndIbckk62KBgGcEikYr2mothUM1r7xg0ap8dYGdShajIO4rHhuFwuGcgOGD
         RxBGsnks8gEMm0KaOTOoVDQFbnbGdIAyxPRM7BNfV20fZOn+QzzXEiBrnvWUqJMT3HlH
         JL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268371; x=1710873171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85hgbrddKGD0xyBfuycyl0J/43uufOK34r5gdSmrGzE=;
        b=JUE4liWgay01EA+zLyJxiCSJ7YZXvyKlfewaSlZbj4JpaEiDAuIMqs/CHox75YlYvS
         c8xUq9tDKpdFPGjXpE3xGEqYGcWQDYkSaiitYnvRoSCpCoJNbmRGlIi8jrGup/33yOYL
         ljON2BIVM9W6uBB2GqYuIJQIiZZ/iUBRyKsLv//kHeu0QV3MlCmX9zxJ7Jj5Q4qzvXCX
         eYeWkyKZ+ZPjPJHhH9GzWPbLjadau2Q5//cQpkarjKq6CoT3Pg4pRY9DXMA2NaJUaKVP
         1B9H2ffV7s0KGHK8KhvaGqUwQLOsa3haWc94kNclRwEIzfaRjsESpjHTAjNkFqJZ6jFl
         AxRA==
X-Gm-Message-State: AOJu0Yz9p0qi77nS3tfApXGBV1WepIBLckEMYLEzsRHdU/QEYuSRxj9C
	Z3VIKC9hnHdUUu+B4mvnvyZ/3ZrVfW/4Dk44VTQl7Cn7q4dJqxky5ZmLPceP
X-Google-Smtp-Source: AGHT+IE+k5tyx/1Y1CAcxs7XbMdOyz/DoN+Hzw9EVRhBsGcqKwFgtfkYsqQkT5J1iT8d7x24VUz5lA==
X-Received: by 2002:a25:9390:0:b0:dcd:97ad:74b3 with SMTP id a16-20020a259390000000b00dcd97ad74b3mr255163ybm.63.1710268370857;
        Tue, 12 Mar 2024 11:32:50 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b4ae:c2f4:b38f:1540])
        by smtp.gmail.com with ESMTPSA id v185-20020a252fc2000000b00dc9c5991ecdsm1868444ybv.50.2024.03.12.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:32:50 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.
Date: Tue, 12 Mar 2024 11:32:45 -0700
Message-Id: <20240312183245.341141-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183245.341141-1-thinker.li@gmail.com>
References: <20240312183245.341141-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new version of a type may have additional fields that do not exist in
older versions. Previously, libbpf would reject struct_ops maps with a new
version containing extra fields when running on a machine with an old
kernel. However, we have updated libbpf to ignore these fields if their
values are all zeros or null in order to provide backward compatibility.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 35 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 13 +++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index ee5372c7f2c7..e0d9ff75121b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -93,9 +93,44 @@ static void test_struct_ops_load(void)
 	struct_ops_module__destroy(skel);
 }
 
+static void test_struct_ops_not_zeroed(void)
+{
+	struct struct_ops_module *skel;
+	int err;
+
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test_3, false);
+
+	err = struct_ops_module__load(skel);
+	struct_ops_module__destroy(skel);
+
+	if (!ASSERT_OK(err, "struct_ops_module_load"))
+		return;
+
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_not_zeroed"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test_3, false);
+
+	/* libbpf should reject the testmod_zeroed since the value of its
+	 * "zeroed" is non-zero.
+	 */
+	skel->struct_ops.testmod_zeroed->zeroed = 0xdeadbeef;
+	err = struct_ops_module__load(skel);
+	ASSERT_ERR(err, "struct_ops_module_load_not_zeroed");
+
+	struct_ops_module__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
 		test_struct_ops_load();
+	if (test__start_subtest("test_struct_ops_not_zeroed"))
+		test_struct_ops_not_zeroed();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 026cabfa7f1f..d7d7606f639c 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -54,3 +54,16 @@ struct bpf_testmod_ops___v2 testmod_2 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2_v2,
 };
+
+struct bpf_testmod_ops___zeroed {
+	int (*test_1)(void);
+	void (*test_2)(int a, int b);
+	int (*test_maybe_null)(int dummy, struct task_struct *task);
+	int zeroed;
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___zeroed testmod_zeroed = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2_v2,
+};
-- 
2.34.1

