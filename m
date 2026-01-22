Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735923EBF2F
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099206; cv=none; b=NeDqZ2vbwtF6AD0LsVXJJeYpUnM1Tf+EscVD2Nl3mNFJu/dy0AgN92UoJQvV92qcLZ6HhhTOgdMeMEHu3VthaL4UQVr0OqRL9Q88Zt08WUKo6pCaKsae6KTPOXRltGv7H5oENamwC1Yl9L017s17bHjUUfQgbD5PtG2B1CzrsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099206; c=relaxed/simple;
	bh=P6RrAedToicqiRTLvApvTdwaH4Iuygvi021XaIP0hVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmdc/Uv663LJKxOQuVQtE/odTzLVprMYXfmv9wWqDfeDQrdjNPPpCVY/5rm89jbqC/QtljTZyCy3v+dRXfBVTZiAhadmm47c37JpGkIKOG7OjS3eVZMasBljQIzkfJ/geYY0faqXaHrt0WaCV2dKzzm87su4l4BAEodgbRZmSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 48D2C196A192E; Thu, 22 Jan 2026 08:26:21 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Amery Hung <ameryhung@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Fix xdp_pull_data failure with 64K page
Date: Thu, 22 Jan 2026 08:26:21 -0800
Message-ID: <20260122162621.3579387-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122162616.3578898-1-yonghong.song@linux.dev>
References: <20260122162616.3578898-1-yonghong.song@linux.dev>
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
  2 * pg_sz + (pg_sz / 2)
This way, there will be enough buffer space to pull
regardless of page size.

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/xdp_pull_data.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Changelog:
 v1 -> v2:
   - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghong.so=
ng@linux.dev/
   - Use pg_sz to simplify buff_len calculation.

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/too=
ls/testing/selftests/bpf/prog_tests/xdp_pull_data.c
index efa350d04ec5..35f0eb5b43f3 100644
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
+	buff_len =3D 2 * pg_sz + pg_sz / 2;
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
@@ -154,7 +156,7 @@ static void test_xdp_pull_data_basic(void)
 	run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
=20
 	/* multi-buf pkt with no space left in linear data area */
-	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
+	run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, max_data_len,
 		 PULL_MAX | PULL_PLUS_ONE);
=20
 	/* multi-buf pkt, empty linear data area */
@@ -165,7 +167,7 @@ static void test_xdp_pull_data_basic(void)
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

