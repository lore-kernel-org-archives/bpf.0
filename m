Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B63FE35F
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380256; cv=none; b=l5yGHQ+PmvQ99onZfxSB0gV3O5NBv35BB+oWWU8KqBvTJWFPuuwqRPzbLiisrUExAYIL1zw59bMsrmyirwIevl3My7L9V6qbzAgHSCaHRzQPwg/XdniGl9TE7BtUKpBxiGmy1ZvZtVouNHib2ZG5P10GAu5N71LHqiyDpaZgzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380256; c=relaxed/simple;
	bh=ZShGeNanuUHY02XvT1kzHAY3uvJYW5ICW1RCSkEOQh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh47yDEbfYV58ivGBuuS5ERd0haAYU1lZ50pWPgUcFCUMlW2GEa5U89FQ5rnOIxb8BH7uj0gM1fiH6lRjK3GIsMl+YcSJ2sLNxM1iKbgJr1B4Ygvco+w+XBL3hX9tpGbsTeVWIqvZjcfSQR4Zsx1/AizlGe9sDXvbKPXiqsSjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEj2CWK4; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEj2CWK4"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so1074774fac.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380254; x=1792985054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/ZBbrRIm9FYkp5XjwkBgtt6mE6SxTN/jj5SC/UXAfk=;
        b=dEj2CWK42nH8Q2irJSIQYQhmCxiOQJ0kDyxbIqo5l4m5Od2ZU48JQNXlnpWs6bLGBd
         lqavpxSrC+opEbz+VOz9cFKeacHPkLoJa0VGIg74VMIA6fleSmqqTVKpRKobsm6xuBpT
         EH0cbNfLBnu86S8rIO4OpF8z0pnD727FCXIOMNx7lz5yPKGwhmATxfcYu023ZPRsVdYb
         UetSNu6mNH1z+mq5LqSHNl8Vt2ffsmZe2sFUh3VracKyID0ANVt4snr1WPbImp38FDCj
         0gJsMmpVNY0O32iOZ5O71rQ6NnkSm9fcShnuTtg7FAH4YR6pewJe6zhP1Eh6t76Z1sNe
         CImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380254; x=1792985054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4/ZBbrRIm9FYkp5XjwkBgtt6mE6SxTN/jj5SC/UXAfk=;
        b=BcEfjaELa7hQE4PJT0r5Alqg7E77d1Xkd9EkX9G1l947zsQsC9jQIJr8i/nwi9VhEm
         m8C62LvPtBRf6CgLAGUeRwX8PO128TSKj3j9FHS5kxqKz10dnYaCGjbNJyNhoKdbm7I1
         IbdhWa8ESdr1o2SvNryv61OZYijQ4Y3wYDLcSoYML6eB2mZvUxkr97MB9sRfD9gfCy41
         NLthtdXYjQgDwJsU6STqkUZ0+YAJgRYnauUeaUNczfJBJd/7f//LLU8GhkRmLanSdEm4
         RrMWm6S70PYXP51tfDPkO8quGtY89TtDhYopv68TQMRfHxjPLkkuBjIemuBsJBu0sEyR
         3JtA==
X-Gm-Message-State: AFq9FYLBWUQ7FMnnkZ5seSWcitIqmZZjoxeXFJlgl01qX5sHlpSHi5O9
	F5RG3IakPTlbO3Tyy98gn7dhV4yDbg2W2ETS2yYrlplfDVN6Xpu98yd0Xhq/0J0jFnk=
X-Gm-Gg: AYBFou0aTyQCW8RaRzcOKvSKV/3wPd0WzNSl5XEpTdj8+jIuS3zD0zqA+lSkptMkkp8
	OKVyQ5mikTANW6gznU2qzQW2padHFudh5r2ufPZdHk81rotlyoIGhfqPdhQAcA60/AIWm7xz0Yf
	iht8BfHP/j3YCtaM3//lGGwGuLAJgP8dBXFIuXcwRDv3f4rPBHOjAz3/3GjQsp00AwfBikoTOQ6
	+d72tqww2/2KkGTIQAQg3KtwtXQlpA3qw9l0LSHV9M9JsndaVvPLS/otR0FQiwfimUzfvoQfvi0
	eEhbX7lunT/q66uqkvItxMnzTM+bGwAXRr86U3y0hMInh5gOhX8s0yTGYMYV13vhPJI3k0x7SNq
	Ulw54obhSPFnuBxft4x4nReWVw4tEEz+fRXkyZsqkCubrkm0dwJQ0dhABUSYXPMYpzrwpSCstI5
	C6uRh2G5SbO2v4GSKFOzySv+l/9t67rhlsQMttH/HTpIH1br99Vnb+U68S/3T+bnkT/a8LeP211
	Nq29w5JHvn9/89Wr9ZxgvUtp/K9RjYiwrh5BlaXWhNk18Yc+e5REvuw0yUFWSjCn0GTtOwqumHD
	W3JmB/k=
X-Received: by 2002:a05:6808:1392:b0:4d6:92b3:5c84 with SMTP id 5614622812f47-53cd3ecf953mr4640078b6e.65.1792380254150;
        Sun, 18 Oct 2026 20:24:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388288ad5bsm6672664b6e.2.2026.10.18.20.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 02/16] selftests/bpf: Bind an exclusive map through a continuous fd_array
Date: Mon, 19 Oct 2026 05:23:42 +0200
Message-ID: <20261019032401.2302823-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; h=from:subject; bh=ZShGeNanuUHY02XvT1kzHAY3uvJYW5ICW1RCSkEOQh0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr+5n3VNrVx7Y+NK59rvj5auTFAQXfdu8c2p/nhKrQl2j cfSVjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwkdCPDP90kgxi1SDP7f4/m3DOXsD raset+v5mzfLd8c9hlYRfHl4wMTU3PzF9n6Wmuynrcuu//0T3lFmxhedWiFVFzf9pNTL/NCAA=
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

