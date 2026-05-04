Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B4345749
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884877; cv=none; b=HZaGNOgVZUMZJOB2QjLu9JotB9QhFKBu2HaYGRTjDbo526XO+MIj55z5WhfM4WUNRRH5APaTZQWUVAnrkqAtHTShHpz8//9qd3wIQYf2UalYg+gWU70rFGDxGnkjKGnh5Q6s1OqCX3QCo2EbmK3ddzhA8ruRe4hGVorO8bLmhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884877; c=relaxed/simple;
	bh=m51BE5xu9tYTJWCXNokpbtjF8j89fIqe1H8+UUGBWRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bWTNP30miUB4O7ohku+JQHhKy4Jj5nf40HFqvV6G5G3KJDYSQW23ghQo9kyCX68aNhWN0qXaduJ0hWDJpOEqG84GTvgXvIvQlLwxzDMGU0xmgdNG8dcGN/pNDah6PzR6CFhNHvSzVvL3mSLHc4+S9WHRkbsEoCdMS3huGFMBDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZOKWQttA; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOKWQttA"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66a3c95958fso2814010a12.2
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777884874; x=1778489674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s87gtrtiXFkbi9Y0q78P/MHG9DQCDVYI7OQAeToShwc=;
        b=ZOKWQttAMlj7XK1UO082uyJQPJu1meQG6aWKdr8STG7/xOkaqbnm3U5CXhhFocQ7dt
         6pBcei3l8y8F7VEVKF7XeXTYACc2Pp05f6whxfYVElsv8ebvTb0vL++mhtFBYyTShIUY
         KVrSEchgo6b+RMTmdYH22ijg3fj+sMCdiLN2LcThKSSQUJpPMzJwr5WdVpqSZ/HtoAFh
         ROVxVOnnUIlfokhTYpPloP+tiJ4BVtnTGr57j6rXgVsBt64dZ5cCrx4ZvqBNztVrCF14
         cwHFq2YJfhTs58e/ZMCwNhVcZ6740X6K/UJZxbo7eykPLSsx/TFpr3UAf9Kof1UmhpNC
         XkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777884874; x=1778489674;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s87gtrtiXFkbi9Y0q78P/MHG9DQCDVYI7OQAeToShwc=;
        b=IDVWC3tigSb70M+XWRjERwPx+k2Pados7Q05BpWxkR+dpY4DSYoleIERV3S75mvXIe
         8uNNgTvQAR1NvZk1BgU+II7Sxezro+VNuPjYtmGDFKsDNhZYuP5nbv4DthsDoh7ankzk
         AcF4GCSnljxGtb5W8ht9VJw3awzOXwlLx7ELIeNIRHlz80fSY41yumlJ7O7k89LKm3rD
         poehwDYQo98XigADk0sT2YfeIZ+TzG8c9AFzNnoizwYhxcJeCa5c94zB0k3PoKpK4TXk
         LMrkOl6pUr1lKll9IXBdbxh4EWfivU0FqOLus7lGt+tPRuqiEIs9rrzYHIHBuM8/qFbl
         hB6A==
X-Gm-Message-State: AOJu0Yz7/18YibUtvR75d4j3rVRNemJEwvDaT+Evgx3Bxw2JoN2p5E9g
	o4g5ZqQMgu1vQt4IPoo0u0mX0Y5lu1SZ1rdoSrWNHaoOxnOheecOgtQJujiWa+KLuUmx1UvI7ax
	F2f2JsS/NFvnlDcl+lRRHCZqZAnuFpG4q9LfajoId2uX/PJCvvjyxijRLuTuxGDDniZrgsvLbg5
	Iho6/HgsyBX2Q79D9w1sepIL2IdjW65zaZg737q0iIDERhy5TPsBBf2k7taFq1OL/bgi+zxA==
X-Received: from edj4.prod.google.com ([2002:a05:6402:3244:b0:66f:96f9:b2c6])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:194f:b0:676:9c6d:5c4d with SMTP id 4fb4d7f45d1cf-67c1a6bdf2cmr3759765a12.17.1777884873557;
 Mon, 04 May 2026 01:54:33 -0700 (PDT)
Date: Mon,  4 May 2026 08:54:28 +0000
In-Reply-To: <20260504085428.2865671-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504085428.2865671-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504085428.2865671-2-mattbobrowski@google.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add new negative tests for
 xattr related BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a set of negative tests to verify the newly enforced constraints
applied to xattr related BPF kfuncs.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
Changes in v2:
 - Fixed leaking of test file test_progs_fs_kfuncs when the
   __open_and_load() helper fails within test_set_remove_xattr()
   (Sashiko AI).
 - Fixed invalid global variable name references within fs_kfuncs (Sashiko
   AI).
 - Modified global variable long_name such that it is initialized with
   a long hardcoded string to satisfy the verifier (Sashiko AI).

.../selftests/bpf/prog_tests/fs_kfuncs.c      | 16 ++++++++++----
 .../bpf/progs/test_set_remove_xattr.c         | 21 +++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/tes=
ting/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..37544c6fa9a6 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -115,18 +115,18 @@ static void validate_bar_removed(struct test_set_remo=
ve_xattr *skel)
 static void test_set_remove_xattr(void)
 {
 	struct test_set_remove_xattr *skel =3D NULL;
-	int fd =3D -1, err;
+	int fd, err;
=20
 	fd =3D open(testfile, O_CREAT | O_RDONLY, 0644);
 	if (!ASSERT_GE(fd, 0, "create_file"))
 		return;
=20
 	close(fd);
-	fd =3D -1;
=20
 	skel =3D test_set_remove_xattr__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_set_remove_xattr__open_and_load"))
-		return;
+		goto out;
+
=20
 	/* Set security.bpf.foo to "hello" */
 	err =3D setxattr(testfile, skel->rodata->xattr_foo, value_foo, strlen(val=
ue_foo) + 1, 0);
@@ -188,8 +188,16 @@ static void test_set_remove_xattr(void)
 	ASSERT_TRUE(skel->bss->locked_remove_security_selinux_fail,
 		    "locked_remove_security_selinux_fail");
=20
+	ASSERT_EQ(skel->bss->ret_code_name_empty, -ERANGE,
+		  "ret_code_name_empty");
+	ASSERT_EQ(skel->bss->ret_code_name_too_long, -ERANGE,
+		  "ret_code_name_too_long");
+	ASSERT_EQ(skel->bss->ret_code_value_too_large, -E2BIG,
+		  "ret_code_value_too_large");
+	ASSERT_EQ(skel->bss->ret_code_invalid_flags, -EINVAL,
+		  "ret_code_invalid_flags");
+
 out:
-	close(fd);
 	test_set_remove_xattr__destroy(skel);
 	remove(testfile);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c b/to=
ols/testing/selftests/bpf/progs/test_set_remove_xattr.c
index 6a612cf168d3..e69a5c51c60a 100644
--- a/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
+++ b/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
@@ -17,6 +17,14 @@ static const char xattr_selinux[] =3D "security.selinux"=
;
 char value_bar[] =3D "world";
 char read_value[32];
=20
+const char xattr_negative[] =3D "security.bpf.negative";
+int ret_code_name_empty;
+int ret_code_name_too_long;
+int ret_code_value_too_large;
+int ret_code_invalid_flags;
+const char long_name[] =3D "security.bpf.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
+char large_value[65537];
+
 bool set_security_bpf_bar_success;
 bool remove_security_bpf_bar_success;
 bool set_security_selinux_fail;
@@ -73,6 +81,19 @@ int BPF_PROG(test_inode_getxattr, struct dentry *dentry,=
 char *name)
 			remove_security_selinux_fail =3D true;
 	}
=20
+	bpf_dynptr_from_mem(read_value, sizeof(read_value), 0, &value_ptr);
+	ret_code_name_empty =3D bpf_get_dentry_xattr(dentry, "", &value_ptr);
+	ret_code_name_too_long =3D
+		bpf_get_dentry_xattr(dentry, long_name, &value_ptr);
+
+	bpf_dynptr_from_mem(large_value, sizeof(large_value), 0, &value_ptr);
+	ret_code_value_too_large =3D
+		bpf_set_dentry_xattr(dentry, xattr_negative, &value_ptr, 0);
+
+	bpf_dynptr_from_mem(value_bar, sizeof(value_bar), 0, &value_ptr);
+	ret_code_invalid_flags =3D bpf_set_dentry_xattr(dentry, xattr_negative,
+						      &value_ptr, 0xFFFF);
+
 	return 0;
 }
=20
--=20
2.54.0.545.g6539524ca2-goog

