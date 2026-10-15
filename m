Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD24A0F0D
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107699; cv=none; b=PFuCBeT2oW1cMg7sy8h+JtYmjWCNrTFSCnYONT33ujq2Oa8ioFSU5uDcyeesJ1rdfaMNC0PokHwHtsGAwi+iW/ZZipzVl3udxdQItFjSS4iwb8s1pbrAqJtSu7T57Fwnf7z85jPhpky8GUfIvlg9R1dnodBNJy6uolDFkl5++JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107699; c=relaxed/simple;
	bh=PmO1l0PLdB7eXJ43mFPtx6Q4fuO/1OSOPZjMHGx0Ljw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw8HXCixG4xrgulsTLBCNO1exSAmm+MxCmQBkG4tU3gM6WbEEsTvSNSD+xbCi35t01bnNtmE2qEFPzccCOvjtUaWxhnF5J9s4sAlJcx5vkTLgi0oIJ4+AYjfwRNXZ4hczpIlVhVn8fGA9GNlGUS5qA0brNuFt2ru0iUu2eEhDkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBw0l/Ht; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBw0l/Ht"
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8217177c5daso995875a34.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107697; x=1792712497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=momdpuLInhdM0wk9ViDq7X2iD3Kg9pzN+2p8awG8zcw=;
        b=oBw0l/HtIS/Tm6AKTZ1ApzboFDM8MAj9+AFs1mwJ6YbjKgwd8ygy3F6qlqTa6v2NnU
         msQAdpomArWdAtkcrsGVYFsxc2iJ+ZvznCgKrr/m7dctupV1LI/uguhpOECMAZHILRa6
         DxzLJTMkn/1uTbPxxr2Yf5PzmfWgh3Ocz+39JerbH3R1iXtAorEMz5EVd+/3vgpqg0RI
         +HcydiP89uYW4gf6BrLtYWS/v7fM/qNS1B3FYvd2mCiBlR404J1nLOuvSYgIqHzyl8yj
         T7A/Ar0iatZAvqX3ri/fcsmt7k/bPEU4MBRB9va50ptn7srO+w4U12cXoWEFIkQFZcOE
         hG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107697; x=1792712497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=momdpuLInhdM0wk9ViDq7X2iD3Kg9pzN+2p8awG8zcw=;
        b=N4/X+0ZILjqV1VIKZTbeyiUy4eUV7r30XVmdnuTiJOdg1/c0tLyf/yk5AJ3r8yW5Sq
         5iQQ4TuiwEbH99Q29awu7tMbggAECe2FO5SMZ4IZyTP7PNkETSRXivnhOVBX/wA+9XXv
         eCi+oiYrXXmDYq1eSMPIQ1VfbhNDDv74ulp2aJfYrCewn5rkO1iYeWpfPxR3ISHrOM7O
         LIZep8UD/gdo9MAUqRKnz2jgvWZK3qkmfXM9feU/4O9nTMdLmeyfODC44RzGgTOwNj/Q
         5P4alWNmaq00vPmfGT8E2CuMEJfSkpkboPpE7ZaQ8Tt5PM35RMYxBb6nccE/QDgrpvU9
         PcOQ==
X-Gm-Message-State: AFq9FYLKI1pF3CiFOnAXm4Pc27WMFZi+6cW0kbBFAs35I1Wdth2D3Zt9
	KsC+PFNRlxRGmuTJa1M5En9yWDObmpdelTqn/aejVPyAjWNTIajVzKb2qyy39J/WBuk=
X-Gm-Gg: AYBFou2SmWPYsN049U7+qeQgSWrfPeeFD3RMH7O5YYL55choqDu6yywGLUYeNwC/5iW
	pMr0cyMtOu5DC+FxwvhM9NqCbw42T/ZmGelX+TamGMPa8BNH4PRECK6NM0XDLMzL4FegOk8G52G
	WKXJwbuStKE/m0sXc70d5DTtmrJsX1ppVsNpGaHrH5LSbZjWYyY/Hg8hdeV2islZeJU/LZcv+sH
	saMPWl+PPe1jipu8wpUjeNMIk2ezJOo3ApdqkzCWqxY3QTOdFFJgyjLSks9uUgQPQi/OT+yj7a2
	ZpyQZu99DZBp6opLQOyCWqjzoOORR/OFyXovtjUQEiq7GSELOVQ7UAVWSJbHC46dvciah6v1/UR
	7qE31LIJRvOeybE+PYTzrODB9vmI97eS0GN76oH1QsODhBaWET44v3VrYpfbXwAJruarEcUNGQs
	xJsJaxpPSmLzwMHCEtXfbVqF4rAIuAenijE7P+w/Impj1NZF/1vR/xnpcMday9sgmhw+m/IqIYk
	1rPtoKM8oKDPjH6H7P0A5KiD8RpuiUyQ+1Ux4VQlrkFAocZovwwkdX547es1YyAKTv4XGfNbng4
	sxIeIw==
X-Received: by 2002:a05:6820:2019:b0:6b7:8396:f3c3 with SMTP id 006d021491bc7-6ef0e5ea35emr14333823eaf.37.1792107697388;
        Thu, 15 Oct 2026 16:41:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018e73df37sm562315eaf.5.2026.10.15.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 02/15] selftests/bpf: Bind an exclusive map through a continuous fd_array
Date: Fri, 16 Oct 2026 01:41:08 +0200
Message-ID: <20261015234125.3152346-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3267; h=from:subject; bh=PmO1l0PLdB7eXJ43mFPtx6Q4fuO/1OSOPZjMHGx0Ljw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3Ktw28fzpJruLFy+OK1lw57OR/VtzkL2rg8lLGNV5npN iznRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInsYWT4K7KXk/NhrdKEaUnKn41Xua 4v3Vq154ZRnWfmNtd9LfYnJjL8s2EVWyvRp6e5/ZFOup7LdI63TDaBtqwv3SskvN+lZrvzAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Load the exclusive program of map_excl with the map in a continuous
fd_array rather than through its insns alone, which has to work, and
the other program the same way, which has to be refused. The two
programs used to be identical and so shared a digest; give the second
one a value of its own so that the kernel can tell them apart.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_excl.c       | 35 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_excl.c  |  3 +-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/testing/selftests/bpf/prog_tests/map_excl.c
index 3f4422b9ffa6..3592f3ec4949 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_excl.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
@@ -161,12 +161,47 @@ static void test_map_excl_create_validation(void)
 	ASSERT_EQ(fd, -EINVAL, "reject size with NULL hash pointer");
 }
 
+/*
+ * The exclusive map bound through a continuous fd_array rather than by an
+ * insn. The kernel resolves the array before it verifies the program, so it
+ * has to have the digest of the program at hand by then.
+ */
+static void test_map_excl_fd_array(void)
+{
+	struct map_excl *skel = map_excl__open();
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	int err, fd, map_fd;
+
+	err = bpf_map__set_exclusive_program(skel->maps.excl_map, skel->progs.should_have_access);
+	if (!ASSERT_OK(err, "bpf_map__set_exclusive_program"))
+		goto out;
+
+	bpf_program__set_autoload(skel->progs.should_have_access, true);
+	bpf_program__set_autoload(skel->progs.should_not_have_access, true);
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "map_excl prepare"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.excl_map);
+	opts.fd_array = &map_fd;
+	opts.fd_array_cnt = 1;
+	fd = bpf_program__clone(skel->progs.should_have_access, &opts);
+	if (ASSERT_GE(fd, 0, "exclusive program with the map in fd_array"))
+		close(fd);
+	fd = bpf_program__clone(skel->progs.should_not_have_access, &opts);
+	ASSERT_EQ(fd, -EACCES, "other program with the map in fd_array");
+out:
+	map_excl__destroy(skel);
+}
+
 void test_map_excl(void)
 {
 	if (test__start_subtest("map_excl_allowed"))
 		test_map_excl_allowed();
 	if (test__start_subtest("map_excl_denied"))
 		test_map_excl_denied();
+	if (test__start_subtest("map_excl_fd_array"))
+		test_map_excl_fd_array();
 	if (test__start_subtest("map_excl_no_map_in_map"))
 		test_map_excl_no_map_in_map();
 	if (test__start_subtest("map_excl_no_map_iter"))
diff --git a/tools/testing/selftests/bpf/progs/map_excl.c b/tools/testing/selftests/bpf/progs/map_excl.c
index d461684728e4..90f127073dff 100644
--- a/tools/testing/selftests/bpf/progs/map_excl.c
+++ b/tools/testing/selftests/bpf/progs/map_excl.c
@@ -27,7 +27,8 @@ int should_have_access(void *ctx)
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 int should_not_have_access(void *ctx)
 {
-	int key = 0, value = 0xdeadbeef;
+	/* a different value, so that the two programs do not share a digest */
+	int key = 0, value = 0xbaadf00d;
 
 	bpf_map_update_elem(&excl_map, &key, &value, 0);
 	return 0;
-- 
2.53.0-Meta

