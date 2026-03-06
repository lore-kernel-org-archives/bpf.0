Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAB34F27B
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792211; cv=none; b=ljygElcTSq6mn7Bm746fObmNaDhGmRXEkRqb5L85toSGKmZZihZzpWgGNd3IsootuJDboqIXkBW1E6l/1SFnXC8pM+pUbZ/pXTqbTRKjbo6daMdbB/t8BzsU95CoBKrcJjw2e/KDRmXm098lcXfwwilyRQgQ32orDPWdNjjQiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792211; c=relaxed/simple;
	bh=eqRzykego2MLlRAnYvQi+UEz4h+ScCa06dnsZyL8PFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1o0kSR1xJYqx6DSGgv6b9eW2iJvjrT684QmZ6dmJJlZU9rrNoN2gGbQ+qSkP9pJq0iD0wClJWQ7aeBrh1zZsLI3OkNzrGgNCNDUP+QvXOkviT1AtVX9UUAkkAaZn/CInhv+dxJn0oN7Mk0n6SzAXTM66cKuxNAUIkChSZz4urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B16TGlwc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B16TGlwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772792206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fN1qnMrpxHuOaJT9KMih6CCtkcnqC4H5nMTRTsSxXE8=;
	b=B16TGlwcpUxmeSe/KWcEIf+70EMi+AukByiK5PgHsKLrkXDDOZXRDDZJWj+IW/E2WWUWxs
	8u3q0iF6Zw8Jy0ZI8kEovjGi9J+x2sKzPQibP6W3h4Snaz039W9IKamXecgSde/Ktc4ahq
	/+TkcLemIq+dtB9cBvrepRCedvf/T8w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-X6cHNnplNNeuzPeZ1rokcw-1; Fri,
 06 Mar 2026 05:16:41 -0500
X-MC-Unique: X6cHNnplNNeuzPeZ1rokcw-1
X-Mimecast-MFC-AGG-ID: X6cHNnplNNeuzPeZ1rokcw_1772792199
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0DED18002C7;
	Fri,  6 Mar 2026 10:16:38 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.32.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80E6E1800673;
	Fri,  6 Mar 2026 10:16:33 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Shubham Sharma <slopixelz@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Speed up module_attach test
Date: Fri,  6 Mar 2026 11:16:28 +0100
Message-ID: <20260306101628.3822284-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The module_attach test contains subtests which check that unloading a
module while there are BPF programs attached to its functions is not
possible because the module is still referenced.

The problem is that the test calls the generic unload_module() helper
function which is used for module cleanup after test_progs terminate and
tries to wait until all module references are released. This
unnecessarily slows down the module_attach subtests since each
unsuccessful call to unload_module() takes about 1 second.

Introduce try_unload_module() which takes the number of retries as a
parameter. Make unload_module() call it with the currently used amount
of 10000 retries but call it with just 1 retry from module_attach tests
as it is always expected to fail. This speeds up the module_attach()
test significantly.

Before:

    # time ./test_progs -t module_attach
    [...]
    Summary: 1/14 PASSED, 0 SKIPPED, 0 FAILED

    real        0m5.011s
    user        0m0.293s
    sys         0m0.108s

After:

    # time ./test_progs -t module_attach
    [...]
    Summary: 1/14 PASSED, 0 SKIPPED, 0 FAILED

    real        0m0.350s
    user        0m0.197s
    sys         0m0.063s

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/module_attach.c | 2 +-
 tools/testing/selftests/bpf/testing_helpers.c          | 9 +++++++--
 tools/testing/selftests/bpf/testing_helpers.h          | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index 67763f609b6e..92c336333fcb 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -151,7 +151,7 @@ static void test_module_attach_detach(const char *prog_name)
 	if (!ASSERT_OK_PTR(link, "module_attach attach"))
 		goto cleanup;
 
-	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
+	ASSERT_ERR(try_unload_module("bpf_testmod", 1, false), "try_unload_module");
 	bpf_link__destroy(link);
 cleanup:
 	test_module_attach__destroy(skel);
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 66af0d13751a..6fbe1e995660 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -368,7 +368,7 @@ int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
-int unload_module(const char *name, bool verbose)
+int try_unload_module(const char *name, int retries, bool verbose)
 {
 	int ret, cnt = 0;
 
@@ -379,7 +379,7 @@ int unload_module(const char *name, bool verbose)
 		ret = delete_module(name, 0);
 		if (!ret || errno != EAGAIN)
 			break;
-		if (++cnt > 10000) {
+		if (++cnt > retries) {
 			fprintf(stdout, "Unload of %s timed out\n", name);
 			break;
 		}
@@ -400,6 +400,11 @@ int unload_module(const char *name, bool verbose)
 	return 0;
 }
 
+int unload_module(const char *name, bool verbose)
+{
+	return try_unload_module(name, 10000, verbose);
+}
+
 static int __load_module(const char *path, const char *param_values, bool verbose)
 {
 	int fd;
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index eb20d3772218..2ca2356a0b58 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -40,6 +40,7 @@ int finit_module(int fd, const char *param_values, int flags);
 int delete_module(const char *name, int flags);
 int load_module(const char *path, bool verbose);
 int load_module_params(const char *path, const char *param_values, bool verbose);
+int try_unload_module(const char *name, int retries, bool verbose);
 int unload_module(const char *name, bool verbose);
 
 static inline __u64 get_time_ns(void)
-- 
2.53.0

