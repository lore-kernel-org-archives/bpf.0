Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D93F9F5
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105406; cv=none; b=eaBbK9QmB8NF6s26jK5E01yJAz4dG+33wbvpzB71jF/mrQyydJNeHuA++tZpTx8Ip/s3IMmVh9GGAj0lBjnebMUJQnDxXROUaMnrc2Mg9hgBFLNP+LDcpTvsAK35dRODHqoA457az1N5SMFFfJj2OW4F+UTqJsddlGEW7Hwgxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105406; c=relaxed/simple;
	bh=rrvnVLPUooKlsjbkYu5sFGfvDWKb919vzFlZZWITuoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbM45bSWanyx4heuNUBAUgWuh0QJj9hvirel8guu5NsGVuRJsv/r03Gs2b4SlIV/SVWO6hSdRpJOzVcUnJbisHDQEzU7ADLPh8f6oaqlfKBM+xhv8lphLRsW43SZtDiuV8Y263BBt+QlIdLENf4N3M34FYuL1IPeB3INu+3XC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id AE24C226FA7A; Thu, 21 Mar 2024 22:07:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix flaky test btf_map_in_map/lookup_update
Date: Thu, 21 Mar 2024 22:07:16 -0700
Message-ID: <20240322050716.357983-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Recently, I frequently hit the following test failure:

  [root@arch-fb-vm1 bpf]# ./test_progs -n 33/1
  test_lookup_update:PASS:skel_open 0 nsec
  ...
  test_lookup_update:PASS:sync_rcu 0 nsec
  test_lookup_update:FAIL:map1_leak inner_map1 leaked!
  #33/1    btf_map_in_map/lookup_update:FAIL
  #33      btf_map_in_map:FAIL

In the test, after map is closed and then after two rcu grace periods,
it is assumed that map_id is not available to user space.

But the above assumption cannot be guaranteed. After zero or one
or two rcu grace periods in different siturations, the actual
freeing-map-work is put into a workqueue. Later on, when the work
is dequeued, the map will be actually freed.
See bpf_map_put() in kernel/bpf/syscall.c.

By using workqueue, there is no ganrantee that map will be actually
freed after a couple of rcu grace periods. This patch removed
such map leak detection and then the test can pass consistently.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/btf_map_in_map.c | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/to=
ols/testing/selftests/bpf/prog_tests/btf_map_in_map.c
index a8b53b8736f0..5d389eb16295 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -102,30 +102,6 @@ static void test_lookup_update(void)
 	CHECK(map1_id =3D=3D 0, "map1_id", "failed to get ID 1\n");
 	CHECK(map2_id =3D=3D 0, "map2_id", "failed to get ID 2\n");
=20
-	test_btf_map_in_map__destroy(skel);
-	skel =3D NULL;
-
-	/* we need to either wait for or force synchronize_rcu(), before
-	 * checking for "still exists" condition, otherwise map could still be
-	 * resolvable by ID, causing false positives.
-	 *
-	 * Older kernels (5.8 and earlier) freed map only after two
-	 * synchronize_rcu()s, so trigger two, to be entirely sure.
-	 */
-	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
-	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
-
-	fd =3D bpf_map_get_fd_by_id(map1_id);
-	if (CHECK(fd >=3D 0, "map1_leak", "inner_map1 leaked!\n")) {
-		close(fd);
-		goto cleanup;
-	}
-	fd =3D bpf_map_get_fd_by_id(map2_id);
-	if (CHECK(fd >=3D 0, "map2_leak", "inner_map2 leaked!\n")) {
-		close(fd);
-		goto cleanup;
-	}
-
 cleanup:
 	test_btf_map_in_map__destroy(skel);
 }
--=20
2.43.0

