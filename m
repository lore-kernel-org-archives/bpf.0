Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4A28002B
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692817; cv=none; b=PuNtp9qS/es4yqeOHLm6BL3qDwJ1+vruTTtal6/fYoS9FxcgZJ8pxTbs5UgUnmiH++sItMd/q6kyHwhYqncFY5+PXv8QKHEp9VuKBuj2ApaKew8fUY2ZXfCy2u2myGG7jyuINKaPl/4LautF44Kwz+6ZPnujRQrjomOHj9Wfxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692817; c=relaxed/simple;
	bh=7e3Jv1hIBDXr8+1tQjy6HqPVRAwUWQkas33WNmF25rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ns/jythJHAClYafBBbYUYDgRauUumw60FAisBaslH6q1274MWJSUSN4SPMMmsPP0AlZ4kFdV7ZjG+Wn4SN4JcOsAcdLiaz9QAaIsYGPHFOFHx+F2IGywpQHp31EbUVBNSepJO0FgU0cZIgojj5duA9REdW3oO1sywgbpeT9Qg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhgJntpa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhgJntpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776692815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WSlaPufJUm31B5UrUIPJHDj4SD8uuuIu+HPiYK3Sn6o=;
	b=PhgJntpajwE2naDETREkXrCRohZVXjWZb2ttlV1cRnl+X+mraXJ9fVIHEYQxmpLyHPABb6
	Co233IHt7ltX6w/BakP2+qLwU6Yoemey2X0p6LMZJUrZHVQcTZmYjDdjgtTdlpLTma/Px+
	ynIlx+Yrvpex1uvjB72tU6dd+mGYLfY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-e2TyLXTRM9-8PWHrrVAy-Q-1; Mon,
 20 Apr 2026 09:46:49 -0400
X-MC-Unique: e2TyLXTRM9-8PWHrrVAy-Q-1
X-Mimecast-MFC-AGG-ID: e2TyLXTRM9-8PWHrrVAy-Q_1776692805
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C82601956067;
	Mon, 20 Apr 2026 13:46:44 +0000 (UTC)
Received: from fedora (unknown [10.44.49.212])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D886C3000C15;
	Mon, 20 Apr 2026 13:46:38 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Mon, 20 Apr 2026 15:46:37 +0200
From: "Jerome Marchand" <jmarchan@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Jerome Marchand <jmarchan@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Page out as late a possible in file_reader
Date: Mon, 20 Apr 2026 15:46:37 +0200
Message-ID: <20260420134637.2513867-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The file_reader/on_open_expect_fault fails consistently on my system.
It expects a page fault on first dynptr read of some range the exe
file of the current process because it has paged out that page range
earlier. However a lot can happen to that range (which depending on
the actual memory layout could contain text section, data section,
sections )related to dynamic linking...) between the moment it was
paged out and the moment the bpf program expected to hit a pagefault
actually run.

A bit of instrumentation with mincore() shows that pages from that
range were accessed several times before the program is run. In
particular the call of file_reader__load() seems to fault all the
range in.

Move the call to madvise(MADV_PAGEOUT) to just before attaching the
program to minimize the risk of having those page pulled back in from
under our feet.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 .../selftests/bpf/prog_tests/file_reader.c    | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
index 5cde32b35da44..48aae7ea0e4bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/file_reader.c
+++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
@@ -10,6 +10,7 @@
 
 const char *user_ptr = "hello world";
 char file_contents[256000];
+void *addr;
 
 void *get_executable_base_addr(void)
 {
@@ -26,8 +27,7 @@ void *get_executable_base_addr(void)
 static int initialize_file_contents(void)
 {
 	int fd, page_sz = sysconf(_SC_PAGESIZE);
-	ssize_t n = 0, cur, off;
-	void *addr;
+	ssize_t n = 0, cur;
 
 	fd = open("/proc/self/exe", O_RDONLY);
 	if (!ASSERT_OK_FD(fd, "Open /proc/self/exe\n"))
@@ -52,16 +52,6 @@ static int initialize_file_contents(void)
 	/* page-align base file address */
 	addr = (void *)((unsigned long)addr & ~(page_sz - 1));
 
-	/*
-	 * Page out range 0..512K, use 0..256K for positive tests and
-	 * 256K..512K for negative tests expecting page faults
-	 */
-	for (off = 0; off < sizeof(file_contents) * 2; off += page_sz) {
-		if (!ASSERT_OK(madvise(addr + off, page_sz, MADV_PAGEOUT),
-			       "madvise pageout"))
-			return errno;
-	}
-
 	return 0;
 }
 
@@ -90,6 +80,14 @@ static void run_test(const char *prog_name)
 	if (!ASSERT_OK(err, "file_reader__load"))
 		goto cleanup;
 
+	/*
+	 * Page out range 0..512K, use 0..256K for positive tests and
+	 * 256K..512K for negative tests expecting page faults
+	 */
+	if (!ASSERT_OK(madvise(addr, sizeof(file_contents) * 2, MADV_PAGEOUT),
+		       "madvise pageout"))
+		goto cleanup;
+
 	err = file_reader__attach(skel);
 	if (!ASSERT_OK(err, "file_reader__attach"))
 		goto cleanup;
-- 
2.53.0

