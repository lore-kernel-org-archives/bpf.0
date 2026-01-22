Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284837472D
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118246; cv=none; b=LidHYN1pElCk0UjBAx5EcM5asKItfH/1tuNpAjwPCG42AEfhWdU5ACw6SuBU6gZ7v57u7mf8X7jLEedFGCTTZ0fdsMM8njaZKy4t6v3ada1fR78KaHbCMbz8YEj3JhQz0TxBQ1X61/UPw60TRdEDsFSPwB9OQLXSWkiqBPwHikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118246; c=relaxed/simple;
	bh=uQ+8MuRvPU3xdXMoMpS/PQrUS9u9S3jUrtlY6aNSX68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSgI+6tyd2hqZ7KAJPRvWlA4qR3uTL5JgkICwAQyYCO4n04BVnVVpESRy73cpBJ7o8sK9acMiKvG6lFomqXtCB8Vhp2Td4G0Aenh3w76mIeY4GUTV+j6CO1z81TnEVc1ybUqnp2JCILUTlCkTHToXAjLO6lsZ0r8EeX6scnrShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 06285196E38A9; Thu, 22 Jan 2026 13:43:46 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Amery Hung <ameryhung@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Fix xdp_pull_data failure with 64K page
Date: Thu, 22 Jan 2026 13:43:45 -0800
Message-ID: <20260122214346.1458329-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122214340.1457621-1-yonghong.song@linux.dev>
References: <20260122214340.1457621-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the argument 'pull_len' of run_test() is 'PULL_MAX' or
'PULL_MAX | PULL_PLUS_ONE', the eventual pull_len size
will close to the page size. On arm64 systems with 64K pages,
the pull_len size will be close to 64K. But the existing buffer
will be close to 9000 which is not enough to pull.

For those failed run_tests(), make buff size to
  pg_sz + (pg_sz / 2)
This way, there will be enough buffer space to pull
regardless of page size.

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/xdp_pull_data.c     | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Changelog:
 v2 -> v3:
   - v2: https://lore.kernel.org/bpf/20260122162621.3579387-1-yonghong.so=
ng@linux.dev/
   - Reduce buff_len size and cover the remaining two run_test()'s with P=
ULL_MAX.
 v1 -> v2:
   - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghong.so=
ng@linux.dev/
   - Use pg_sz to simplify buff_len calculation.

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/too=
ls/testing/selftests/bpf/prog_tests/xdp_pull_data.c
index efa350d04ec5..910dabe95afd 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
@@ -114,12 +114,14 @@ static void test_xdp_pull_data_basic(void)
 {
 	u32 pg_sz, max_meta_len, max_data_len;
 	struct test_xdp_pull_data *skel;
+	int buff_len;
=20
 	skel =3D test_xdp_pull_data__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
 		return;
=20
 	pg_sz =3D sysconf(_SC_PAGE_SIZE);
+	buff_len =3D pg_sz + pg_sz / 2;
=20
 	if (find_xdp_sizes(skel, pg_sz))
 		goto out;
@@ -140,13 +142,13 @@ static void test_xdp_pull_data_basic(void)
 	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
=20
 	/* multi-buf pkt, empty linear data area, pull requires memmove */
-	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
+	run_test(skel, XDP_PASS, pg_sz, buff_len, 0, 0, PULL_MAX);
=20
 	/* multi-buf pkt, no headroom */
-	run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MAX);
+	run_test(skel, XDP_PASS, pg_sz, buff_len, max_meta_len, 1024, PULL_MAX)=
;
=20
 	/* multi-buf pkt, no tailroom, pull requires memmove */
-	run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
+	run_test(skel, XDP_PASS, pg_sz, buff_len, 0, max_data_len, PULL_MAX);
=20
 	/* Test cases with invalid pull length */
=20
@@ -154,18 +156,18 @@ static void test_xdp_pull_data_basic(void)
 	run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
=20
 	/* multi-buf pkt with no space left in linear data area */
-	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
+	run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, max_data_len,
 		 PULL_MAX | PULL_PLUS_ONE);
=20
 	/* multi-buf pkt, empty linear data area */
-	run_test(skel, XDP_DROP, pg_sz, 9000, 0, 0, PULL_MAX | PULL_PLUS_ONE);
+	run_test(skel, XDP_DROP, pg_sz, buff_len, 0, 0, PULL_MAX | PULL_PLUS_ON=
E);
=20
 	/* multi-buf pkt, no headroom */
-	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, 1024,
+	run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, 1024,
 		 PULL_MAX | PULL_PLUS_ONE);
=20
 	/* multi-buf pkt, no tailroom */
-	run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
+	run_test(skel, XDP_DROP, pg_sz, buff_len, 0, max_data_len,
 		 PULL_MAX | PULL_PLUS_ONE);
=20
 out:
--=20
2.47.3

