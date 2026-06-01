Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9963D7D60
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326176; cv=none; b=iGrKSatANmVw66rWDLnzTaI44xJ+1lgZtFPKngfuQlTp7kP9pTxfFNGBvYGNTAeFkGj6xva/BGJ/ZhJkyw11OBerSl5u3FWght977X71FNoMq29zc0bKt2tmhU+BiDJ5ADpqBgyOaK+lKuR6gIhf9oLDpIY3d++nER+PmN7DN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326176; c=relaxed/simple;
	bh=vElhBUsgfKLbePo3GI6OfZ51BlBzJ36rplF/eVsQjMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cADQP7eSvdmb8gtod6pA93yqyjwM2Dmz3ZuAop4hxKiFx23JPKxYPAvMVStkNFaOmToa/9G24I/o4xDvjlONXWTtu5GoO27WKtKpeQOuRdgqCoAj2Ufjp4K8u9YG8WxFZ5c083bfbKHbaX4rjJFe1Kcio+nzPvlA8iqmDoYBZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=K4MYZVJF; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="K4MYZVJF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NUCfKsW4w5PngcDqMHSZG7kpcOaWxXS8q/uKV9nwjoE=; b=K4MYZVJFTNlhE0jO9c+kYhpoMP
	1rYhOu6+io7UBE6wg3qt5nSzuUvB6yKz6r93En3+oR+qlfhMT/msEaBRZkKzjXDVwzF/IB2y3Hroe
	+kTihAnKSb/ZUxP1Ij7EfQukwReGYhqLeJlWUK6iEGKjzUsgi9OIAAYVdhhi9VUNxtSDV+URtJfup
	ZjnV9Pb8oaPlJjevfUfsg7KbRoYYiI0jSb9FojBpfkNkHp+fo7vcBwmZ/LvY+mgzcYuSf6oqsz2mk
	/wvtUqPiUiiWb2C8SEDSSYILuTjNrFqweqd6+HdUjJDYH6aNUPqMK2uqMvKVuGzGma6/urKgBGWl/
	OT1viOSg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wU4AH-000GWy-0c;
	Mon, 01 Jun 2026 17:02:53 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Test that exclusive maps are rejected in map-in-map
Date: Mon,  1 Jun 2026 17:02:48 +0200
Message-ID: <20260601150248.394863-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601150248.394863-1-daniel@iogearbox.net>
References: <20260601150248.394863-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28018/Mon Jun  1 08:31:13 2026)

Add a subtest to map_excl that verifies an exclusive map (created with
excl_prog_hash) cannot be used in a map-of-maps, covering both kernel
enforcement points: i) the inner-map template at map-of-maps creation
and, ii) the element inserted into an existing map-of-maps.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t map_excl
  ./test_progs -t map_excl
  [    1.728106] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.730473] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #215/1   map_excl/map_excl_allowed:OK
  #215/2   map_excl/map_excl_denied:OK
  #215/3   map_excl/map_excl_no_map_in_map:OK
  #215     map_excl:OK
  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/map_excl.c       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/testing/selftests/bpf/prog_tests/map_excl.c
index 6bdc6d6de0da..a213dd559aae 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_excl.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
@@ -8,6 +8,10 @@
 
 #include "map_excl.skel.h"
 
+#ifndef SHA256_DIGEST_SIZE
+#define SHA256_DIGEST_SIZE	32
+#endif
+
 static void test_map_excl_allowed(void)
 {
 	struct map_excl *skel = map_excl__open();
@@ -45,10 +49,52 @@ static void test_map_excl_denied(void)
 
 }
 
+static void test_map_excl_no_map_in_map(void)
+{
+	__u8 hash[SHA256_DIGEST_SIZE] = {};
+	LIBBPF_OPTS(bpf_map_create_opts, excl_opts,
+		    .excl_prog_hash = hash,
+		    .excl_prog_hash_size = sizeof(hash));
+	LIBBPF_OPTS(bpf_map_create_opts, outer_opts);
+	int excl_fd, tmpl_fd = -1, outer_fd = -1, err;
+	__u32 key = 0;
+
+	excl_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "excl_inner", 4, 4, 1, &excl_opts);
+	if (!ASSERT_OK_FD(excl_fd, "create exclusive map"))
+		return;
+
+	outer_opts.inner_map_fd = excl_fd;
+	err = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "outer_from_excl",
+			     4, 4, 1, &outer_opts);
+	if (err >= 0)
+		close(err);
+	ASSERT_EQ(err, -ENOTSUPP, "reject exclusive map as map-in-map template");
+
+	tmpl_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "tmpl", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(tmpl_fd, "create inner template"))
+		goto out;
+
+	outer_opts.inner_map_fd = tmpl_fd;
+	outer_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "outer", 4, 4, 1, &outer_opts);
+	if (!ASSERT_OK_FD(outer_fd, "create map-of-maps"))
+		goto out;
+
+	err = bpf_map_update_elem(outer_fd, &key, &excl_fd, 0);
+	ASSERT_EQ(err, -ENOTSUPP, "reject exclusive map as map-in-map element");
+out:
+	if (outer_fd >= 0)
+		close(outer_fd);
+	if (tmpl_fd >= 0)
+		close(tmpl_fd);
+	close(excl_fd);
+}
+
 void test_map_excl(void)
 {
 	if (test__start_subtest("map_excl_allowed"))
 		test_map_excl_allowed();
 	if (test__start_subtest("map_excl_denied"))
 		test_map_excl_denied();
+	if (test__start_subtest("map_excl_no_map_in_map"))
+		test_map_excl_no_map_in_map();
 }
-- 
2.43.0

