Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793936231;
	b=xpYBhJx0fjCTkRGGjBpXocqfqU4gKrL3a+1XSJIxkaueEuo0qYllayDr7nJS9BzQTsSr
	 CU5R3j9cuNuno3/rQP1Ey2clvzFx7eDrSJMesjDh5mv+lQpk2h+/AapbCdStsoM6UZH0C
	 9DpP6jAu2yoAz6zObUGcHTCbvDW/2YOYMzEIbZkc2568ATEwA3yhLjON4iGrIgKt5vA2A
	 rhGvqFThRMsk4a44oCcs67ylCFgMfWDf0x8SzJjXZkpqmPUEWC+aOcOx866w7v/SRNJwd
	 2XxpPy+U9L1+I8fIHkU9bRPZPaB2V9v7LGDnOfHO4sTagJBVJdvxWQnRXg76lxMUCHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793936231;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=76hWV+OVGnZnFr9U2L/ksGDotrMEpl3bfcMbRasEyC8=;
	b=XqC400c/SSiB8x8T45cjED5G1CeMTIf1+4gAbMDxPy8kHwhBm40IlewzVKzX1ZLFxkaP
	 baGGb9eDGi3l8QFiG2yA+m1Q5lnVA2x961PR9wudZLiamgdvjzXB2Q+KnRokypnhhIp99
	 R6gd8R/WrNfD7rv+2lwoIEWaStsiigw6S64GjXsooxBmhr5xVHFBcLJ6zTv4KP4wbvoqc
	 SKjIX140rQVQBKTeCJ6nbhmyUgeQ3KawLOO1mrheVc0uW6A2IIv+hZrGzpySA76ezBHA8
	 0wsZkH8o3APjLWHOs/rRRdxr4u1OgZHsiumb9J0zl3f8eki8vGcokrgobjIDl8DGjhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hI5aAykh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4B606A326;
	Fri,  6 Nov 2026 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hI5aAykh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793936231;
	b=hHzN/JbMPDU7wlT7o4Pk6ngue4qpHbEywpDbi0LVNewk70qgRw3sQDfo2oWvUbhiwVD/
	 Dldn+1JUJisx7BSISU7pD0tBGb042j7rp6dRxnv7Bc/Ohxb4p/kkrTDcST2FiLTnDW7rA
	 vii5qOlMBTCpk6Oh4cVfATlxTlvetmq30sie0BtJSpOk6hCio10plfkyRk6Xo/nzaNRZ2
	 DeT84kIrB3LtZ6vpQg71fGay38wtQN8+ahqYYVN3Uh/2IsmE964VwKOlMHa3gP/G9LXSp
	 AmwP2OnJ7XlxYSdazlLV9Gf7Dt+9W7y+0a68x7p2oxRhB3C/hYGdwe6lESp/WI8h7gg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793936231;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=76hWV+OVGnZnFr9U2L/ksGDotrMEpl3bfcMbRasEyC8=;
	b=xvmbMh/YSsjaRQxqfxebA9Bl5PP+tlUEIW6Bh2QfJ2Z9V1iDy7N/HmjvV1Gximfi+Rz4
	 38Ay5iKsqjdZjpCvfOVdpm3jU+Y9bQpbUr3yerGlYaFeEjavXUMpTDZV1ipENh75+SVXV
	 vNsVf/rIxvs3YNYA9Qn2BOPOagMD9Svy+Zm68+mZ6gr100pBpZhPKGhanB2l2sl6rnaC7
	 GQkuqkb+hZPgN66i+R5U6Tba5R2Wm2/u0R6uqZPN7Ksm+EAY2zddtNqjXQ5LrkmjBmUwc
	 bac0zhQ3l+XlPZUqzyjt6SsxJTi03vaI/InMOm3RZ1kS6pm5h2ne8QDU7WfO/QJcyUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 430871F008A1;
	Fri,  6 Nov 2026 03:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793936231;
	bh=76hWV+OVGnZnFr9U2L/ksGDotrMEpl3bfcMbRasEyC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hI5aAykhIbq1y16Tz/u2XnrlKgQnit1IaSOKoqsp/LZ9P7GJOjwzWH4AZ0Sf98g/s
	 pIYQJW+oDJwlHNlc1wXxYhEzMYFrSZT2YvUqikvdDv2NVmMcAeMShIL7gf65aBA+Hh
	 SmS6f4Vb75QcXgFvDyA+OJv/yD2yVsPQK31XnE/VTFsWZgt6SDehf20lWfALVcAVW6
	 rqQYQ9CGLqouqoF+DRjZ1cvg2P2OVZmB3CwfYxiranDOYAlIVICZdiBDce11wXIKoD
	 C1eETbrfO2ZEAFWdYjdQqvN3PT4gb/lwkqIXWT6ix+VIFOkUIGB0vb/aj4TDfBJf0w
	 uFZNKUYElhOkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B975745BA6;
	Fri,  6 Nov 2026 03:37:09 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Fri, 06 Nov 2026 10:37:09 +0700
Subject: [PATCH v2 2/2] selftests/bpf: Use memfd_create instead of mkstemp
 in d_path
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-dpath-memfd-v2-2-1dc0799b4aa6@gmail.com>
References: <20261106-dpath-memfd-v2-0-1dc0799b4aa6@gmail.com>
In-Reply-To: <20261106-dpath-memfd-v2-0-1dc0799b4aa6@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793936228; l=1757;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=alou4cuIJ+oB76ZkZMUDEGCS67LRRaNUDOwQBWbIbMg=;
 b=g+JlCapFuWchf5QNuE7dfcj6YN5orNFWBIG7ivFHngGurbPwKuJWuiPHqAKyX2bOGCGyVsW7s
 Krx+xvbwCY5DXyn4Y0j2ZL9tTXEeuK/mCyjTAlhS6LhPF/QD554DB30
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

check_mem_access currently creates a temp file in /dev/shm, which
isn't mounted under vmtest.sh in local runs. This causes mkstemp
to fail with ENOENT. The fix is similar to
commit 47687a29b2c3 ("selftests/bpf: Use memfd_create instead of
shm_open in cgroup_iter_memcg") where memfd_create gives a
shmem-backed file with no mount needed while still reaching
vfs_fallocate.

Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/d_path.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index b7998606aa98..ec73291ef060 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -4,6 +4,7 @@
 #include <sys/stat.h>
 #include <linux/sched.h>
 #include <sys/syscall.h>
+#include <sys/mman.h>
 
 #define MAX_PATH_LEN		128
 #define MAX_FILES		7
@@ -201,7 +202,6 @@ static void test_d_path_check_types(void)
 static void test_d_path_mem_access(void)
 {
 	int localfd = -1;
-	char path_template[] = "/dev/shm/d_path_loadgen.XXXXXX";
 	struct test_d_path__bss *bss;
 	struct test_d_path *skel;
 
@@ -211,13 +211,12 @@ static void test_d_path_mem_access(void)
 
 	bss = skel->bss;
 
-	localfd = mkstemp(path_template);
-	if (!ASSERT_OK_FD(localfd, "mkstemp"))
+	localfd = memfd_create("d_path_loadgen", 0);
+	if (!ASSERT_OK_FD(localfd, "memfd_create"))
 		goto cleanup;
 
 	if (!ASSERT_OK(fallocate(localfd, 0, 0, 1024), "fallocate"))
 		goto cleanup;
-	remove(path_template);
 
 	if (!ASSERT_TRUE(bss->path_match_fallocate, "fallocate path"))
 		goto cleanup;

-- 
2.56.0


