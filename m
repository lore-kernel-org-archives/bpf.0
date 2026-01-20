Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF333B8BBA
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943389; cv=none; b=NoTIOnCj4ALD3Si2OqzreB+EZrA4j0o4ztGkLCnpK9B08scgcVW7ohiJxhC9lXmhbsMVtBlTwVyBGSDLmeAzrv9loOTFa0ir9O/ZtvTE/nIDJOeCgKY430aiCjS36uWO06W9NpKD1c2q/tRlY58z3l4/lP0eU3mFDEOeRxGAL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943389; c=relaxed/simple;
	bh=sngjmQ4iBJSRj/SCuh8hbVcfAYBnepT6/IoEwkQOI9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0/v+INDQ8S1aqCw6PlFltmSGXt/5jfQ47ZUoal4A1kz9hf72ez9yVuhvsA7JXUCSQuhkrfrG7WioPyotIBylaJrArgArM+vHVJb3CEzcIXSfyRXpYkXBeft3luPdtJ3o+smMqFeGuiDpI5A/IdQhdDPbegPmtImq+WXHOjcmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E1A111945BE20; Tue, 20 Jan 2026 13:09:30 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Amery Hung <ameryhung@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Fix xdp_pull_data failure with 64K page
Date: Tue, 20 Jan 2026 13:09:30 -0800
Message-ID: <20260120210930.2544950-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120210925.2544657-1-yonghong.song@linux.dev>
References: <20260120210925.2544657-1-yonghong.song@linux.dev>
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

So for 64K page size and selective run_tests(), increase
buff size from 9000 to 90000 to ensure enough buffer space
to pull.

Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/xdp_pull_data.c     | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/too=
ls/testing/selftests/bpf/prog_tests/xdp_pull_data.c
index efa350d04ec5..32ac99406d28 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
@@ -8,6 +8,7 @@
 #define PULL_PLUS_ONE	(1 << 30)
=20
 #define XDP_PACKET_HEADROOM 256
+#define PAGE_SIZE_64K 65536
=20
 /* Find headroom and tailroom occupied by struct xdp_frame and struct
  * skb_shared_info so that we can calculate the maximum pull lengths for
@@ -114,12 +115,17 @@ static void test_xdp_pull_data_basic(void)
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
+	if (pg_sz =3D=3D PAGE_SIZE_64K)
+		buff_len =3D 90000;
+	else
+		buff_len =3D 9000;
=20
 	if (find_xdp_sizes(skel, pg_sz))
 		goto out;
@@ -140,13 +146,13 @@ static void test_xdp_pull_data_basic(void)
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
@@ -154,7 +160,7 @@ static void test_xdp_pull_data_basic(void)
 	run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
=20
 	/* multi-buf pkt with no space left in linear data area */
-	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
+	run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, max_data_len,
 		 PULL_MAX | PULL_PLUS_ONE);
=20
 	/* multi-buf pkt, empty linear data area */
@@ -165,7 +171,7 @@ static void test_xdp_pull_data_basic(void)
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

