Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44053A8F7
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521430; cv=none; b=ZjxM50x2Ir4ClM/85BCS2es7BeysDKjXz6maKetOEG0JBrrM5pQItq0BxWQcj/031ZdyzaBvTTrzjuNy9DFXI7SZW5kf6+QIOp2in8DY3OkuJduKct/fMjX/VE33lMQYeFmvuE7WF8YyL13gyjVFoYM7s2tCMMsTjDxAUoJKEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521430; c=relaxed/simple;
	bh=swoGWtPxWdBqA+i2KY/EelaD6HswZMoIq5wLswSJWWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8qpIURRdmHzQujsbMWEEys9l4L4h1rehSwEHkU879DUzSF4mG/PW2UtcgR8srKhPYpJtw0MsJlNZh31hjA75S11qTW6vjpvRWylD9RedVHYVa0V1iI+mPlwXzmN4wfic10Z8o/ejvv/SadHEGWnJ/8Bs9sbRWoEGRaVbtZt3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LmkN9mQZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LmkN9mQZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=BOiD8qEUKs1uhCIleAzX0HfdvOl3A4yF0zootYdTHXo=; b=LmkN9mQZFhfYNHroGYgKu8RBf4
	Bh58RtK74DMTWIB9fXOqGRp3ZH7jE0aVbbxxiUnu3/6FMRWLS5YOvKe2tizgKL7K5OD2BuVDTU/1Z
	s6ZtSe+qiaKuvradevz3DBxILQXvszB+WyIyGC6gN4wIE3yKW1JXhxApatcQz0336L0rcjhKFctGe
	kxAgjeTVwHTgTNOxpKRrGdOblX0XXsnzynzfUFHkSeKcrzvzwzBOos6T4knD+Wmz2ZpaffqIkK/Zd
	RZyUTJ1yL4bWPzzE/U+b+Ex9NDpCvjM2WAV+YCUGYBmT3PXWFQzpbKQqz1HPmTf1ggF/fkcR4IzF4
	k7JGsQzA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUsxP-000N2h-18;
	Wed, 03 Jun 2026 23:16:59 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: kpsingh@kernel.org,
	ast@kernel.org
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Cover exclusive map create-time validation
Date: Wed,  3 Jun 2026 23:16:57 +0200
Message-ID: <20260603211658.471212-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28020/Wed Jun  3 18:10:41 2026)

map_excl exercises exclusive-map binding (allowed/denied), map-in-map
and map iterator rejection. It does not cover the create-time validation
of excl_prog_hash: the kernel only accepts a SHA-256-sized hash and
requires the pointer and size to be consistent.

Add map_excl_create_validation to check the rejected combinations:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t map_excl
  [...]
  [    1.780305] clocksource: Switched to clocksource tsc
  #215/1   map_excl/map_excl_allowed:OK
  #215/2   map_excl/map_excl_denied:OK
  #215/3   map_excl/map_excl_no_map_in_map:OK
  #215/4   map_excl/map_excl_no_map_iter:OK
  #215/5   map_excl/map_excl_create_validation:OK
  #215     map_excl:OK
  Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/map_excl.c       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/testing/selftests/bpf/prog_tests/map_excl.c
index 3088668e2e45..3f4422b9ffa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_excl.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
@@ -126,6 +126,41 @@ static void test_map_excl_no_map_iter(void)
 	close(excl_fd);
 }
 
+static void test_map_excl_create_validation(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, o);
+	__u8 hash[SHA256_DIGEST_SIZE] = {};
+	int fd;
+
+	o.excl_prog_hash = hash;
+	o.excl_prog_hash_size = SHA256_DIGEST_SIZE / 2;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "excl", 4, 4, 1, &o);
+	if (fd >= 0)
+		close(fd);
+	ASSERT_EQ(fd, -EINVAL, "reject short excl_prog_hash_size");
+
+	o.excl_prog_hash = hash;
+	o.excl_prog_hash_size = SHA256_DIGEST_SIZE * 2;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "excl", 4, 4, 1, &o);
+	if (fd >= 0)
+		close(fd);
+	ASSERT_EQ(fd, -EINVAL, "reject long excl_prog_hash_size");
+
+	o.excl_prog_hash = hash;
+	o.excl_prog_hash_size = 0;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "excl", 4, 4, 1, &o);
+	if (fd >= 0)
+		close(fd);
+	ASSERT_EQ(fd, -EINVAL, "reject hash pointer with zero size");
+
+	o.excl_prog_hash = NULL;
+	o.excl_prog_hash_size = SHA256_DIGEST_SIZE;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "excl", 4, 4, 1, &o);
+	if (fd >= 0)
+		close(fd);
+	ASSERT_EQ(fd, -EINVAL, "reject size with NULL hash pointer");
+}
+
 void test_map_excl(void)
 {
 	if (test__start_subtest("map_excl_allowed"))
@@ -136,4 +171,6 @@ void test_map_excl(void)
 		test_map_excl_no_map_in_map();
 	if (test__start_subtest("map_excl_no_map_iter"))
 		test_map_excl_no_map_iter();
+	if (test__start_subtest("map_excl_create_validation"))
+		test_map_excl_create_validation();
 }
-- 
2.43.0

