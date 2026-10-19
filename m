Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6C4F390B
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416136; cv=none; b=OdPsUL39JYUR67RTvoUG5YiiW/OtOC6A1T14j3BrJuwXzRm/rA+NlkSOq89hq7/aDIzADTFwTRuhx6kPBpcb+sXuaiBSQBOABHRnoswtnh27LPMNnFQPD8ycxKFUwBHCdiyOiqJI8KWYDVtnFdxXTJ31Kq2IJYd1MrR2MyWw9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416136; c=relaxed/simple;
	bh=ZShGeNanuUHY02XvT1kzHAY3uvJYW5ICW1RCSkEOQh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKNjPC+44ziC4DvNj8ISTQ86d5EM3hkp3hvuT69pyrju9JDb/w62L7DpLxyUeKvU97oIlh2jZwT6miDyN1caNSTbnLH/I9vrDQtCpjCpv0IQx1Cvtr2l4SZOGKbM+K5Fz8FVzy4gFm4ZA7rvZkfG6TKjeas2OEJOojqPpmgkRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVJPq2Dt; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVJPq2Dt"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-448a12ddfb4so1344257fac.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416133; x=1793020933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/ZBbrRIm9FYkp5XjwkBgtt6mE6SxTN/jj5SC/UXAfk=;
        b=fVJPq2DtkIz0ySAH+ibDn6XzQtfBjq+d/X9nf0usB2FQ1qh2AS1hhWFB1CdTXme2No
         lR08s0WZ1raCxjEulMnTeBXcTv6aR0Ah4dJetWFwRkOnMA5nhf/BZeHfnH9fAxGvHiGG
         yh2xDhNVI3CHKWULkjXRx7OwTFQJYP61HpIdjG+0tCMe185wl8iEaBM/6J1vwFOPjPxX
         8uv1ww0QxfcCIwX5YhumkUZs7mU11LDgYZ1cR3sgXw/k3PWFkFw5d01R3rqHIrj7HGqR
         7Nr4VKZYMjHiwrnJUjHV63Vbz50CDvSS2AQFGmy6+5hGh68MasdNu2w3fzAJyyfRKPlA
         ld9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416133; x=1793020933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4/ZBbrRIm9FYkp5XjwkBgtt6mE6SxTN/jj5SC/UXAfk=;
        b=MpZFsOb8X7qpxifMhlVTr71hVNTODQ/R0/kEBay0YXxtH2PMDOYUCBfD82mpaT8vYG
         PEoizVQvga3ms6qogDntUtE1wT7lXD97NfzcHJtTDDVPN8TZe0sOPsHrblb8ZwBX1eqX
         Nwr5upeO9SP3QsNiaL6a78u3jJ+RWoTltUBUMSvCJme+xUegb7ODrL/rZwlnHGr9Ohtj
         P9YCOliigm+sdoT8KEKKk24KuTVR6HHZQj8MMZVsjHVcXA+IlTJiVWiMqipebWRGesQA
         Q7CGAQyHkYQaaLdUcUu+TMo0VqCr7RogykgPmQud3PmHPd3xBhY8o2jMWzelbQZLycG7
         eT+g==
X-Gm-Message-State: AFq9FYI0vFjZqzGkD5BCxwSgNFfJWTQ0G6Qh1Lj+v2UZogkCoL0Y2kzU
	akR7LQPyynCNWWcsN0UCFyqyPX616Y7oIvXkR8red2huQtZjO16dehut4XEfLMVyHxA=
X-Gm-Gg: AYBFou1Ew1vgrZ5JOV8EPBL6poXNmyHMthuyAlaLUMdAFuT5LkaUrS9zyDfK6Kk4kER
	+kUfjH1hzCIJ0bf13TAAYC4m9t3voRrZ1zLAkojg6dyJp78I1gsRle08bQ48BRW6CFZS1QhNClN
	anUeJetRiDwfC6yhh46TeqUVDblOe4SjRaYOi8xHuU+Whc8HD7aeYnJ+xLeJL847Pd21ADLeVYj
	ycp7lyWF4MHxuWvHVaceQxNOllUOPwtZZ1jcbpU5i0D9FUDX8RulNWMBol6a+U8hXzhyM7ZYXcA
	9LMIjYPZdoG0L0iC7uUQLFIuPggQJOyNVC+RvAyjNQhLcu6oOjn05M6qfyK14E7Urium3DLosdn
	3EbqEcOYWAMW//AxfthWS0vc2ms1zvsST3sVGm1LHRk9gI7tuJqWO17XUdt8+SxZvra0x7usAh5
	2f8BZAQndDr3jtyIDLWgt3qP7EFRcBNrW6HqgEdVzmwHKknusbMeG9be1VMzDXoZhV5b/JkV9mE
	g4VDz9rfW0j0UpdIMVnxKjlWlKDXZB3Y7t4/hxXkG3oeXxKTupCP1ihl1CBcEZN0wJz4MsQUc+/
	xlBuddqfYyDXmSM=
X-Received: by 2002:a05:6870:d68e:b0:4a6:f698:df8f with SMTP id 586e51a60fabf-4a7579fd791mr6752863fac.42.1792416133367;
        Mon, 19 Oct 2026 06:22:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b640adesm8385305fac.10.2026.10.19.06.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 02/16] selftests/bpf: Bind an exclusive map through a continuous fd_array
Date: Mon, 19 Oct 2026 15:21:44 +0200
Message-ID: <20261019132203.3034698-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; h=from:subject; bh=ZShGeNanuUHY02XvT1kzHAY3uvJYW5ICW1RCSkEOQh0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxJHPuqfWrjyw8aVz7XfHy1cnKQgu+rZ559T+PCVWhbpG 4+grHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiIwwqG/wlm1a8UrtTb1u2/fuqE/Y 55djNvy2tfXjkj/tpbCY6LD80Y/krLSB7QFBBWr48LuMXNc64mnltqZeaT7AVmhyYdS84vZAYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Load the exclusive program of map_excl with the map in a continuous
fd_array rather than through its insns alone, which has to work, and
the other program the same way, which has to be refused. The two
programs used to be identical and so shared a digest; give the second
one a value of its own so that the kernel can tell them apart.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_excl.c       | 37 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_excl.c  |  3 +-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/testing/selftests/bpf/prog_tests/map_excl.c
index 3f4422b9ffa6..9ff4cd3de2ec 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_excl.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
@@ -161,12 +161,49 @@ static void test_map_excl_create_validation(void)
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
+	if (!ASSERT_OK_PTR(skel, "map_excl__open"))
+		return;
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

