Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403271;
	b=PhYLiGXVW0Un+UFD1PtBgEkKQ2ywPwhGX1GUgVM1OAKzkdjUqkJgbBeMdg7AP4MmRouq
	 mKJYAT/YKUvkOWiqdXGMOaRInHCs0Osmyk1rd9HOJn6NMQoY0ATkw1bGN1uLuZrnKytJF
	 gg0B1MSgy7qkm8azqi1PZmoDAKyf4BIdhsfIRfB7TBaUcWtfK5Dvj/hqUYRDPrUm1H/cQ
	 vRmPqDrM6d/LSoRz21PmlMv+D7ln/cfSZVvjBiCdR7VRwJax8JvDe/BIliXeYRhWwhSjb
	 rbpZGiKYl/++En02YtS9UaYZ3uXv4rB4wBdwHV0DaABsCTPmTRxI3kqGLxVot/NlgaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403271;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIKCJu6ljpBXczjdNPbuEPQhM0otlUPVEMeKO8PLkgI=;
	b=DrfGiYALN6084MV5L5ZXexQ/QBxPC8WLvZtK69jwLUxDCbTuu45g72wPzEMAuwGGBPZN
	 JsAtIruGzD0SYrYrYI9PMlYVJL+8yp33LfxPh6AxdrzuswMxugBbO5da4ry4AlOExDpji
	 4rpVzODHj/n1iEhIL/eM7bwun7c2VM6WZO3lO97Nc8sb9cnSX3yaZ2vvVvmBIYoN6hjqM
	 gN/JV1hQgrmN+4VXyGWHhBSEhHZcNY/GAGhf6dThBeuEKiaNMr6nuT6QKTIbSdCbVymY0
	 HC/X6QeTSwdzWvYa8yq2OG6NW7wFbGNNO1fDD9v+AcYCogSKs+FyZH68yommHNP6GoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="oL0+/6P0";
	arc=none smtp.remote-ip=91.218.175.4
Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E849606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E849606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oL0+/6P0
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GzFxxxWh5GWJNdL/eGsakxecqc26cMhVVcrNltS8a34=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403269; v=1; x=1794008069;
 b=oL0+/6P0VkqeV7HLOQzB4jsN6MUhaBTAfAPft615ywgcH23HmVWk6J3zu/KpbgbnHcnGjUHW
 wgVgWm0pQA5BWJSHIgzKR06W8p3Oil9WO+y2UhzWfw/Io4myeYaajOvLO1VGWwU2j7ht1B59qGO
 F7xTVT37I1xsE0D+oBUGTsPI=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 93b34caae9373f06;
	Fri, 30 Oct 2026 23:34:29 +0000
X-Mizu-Trace-ID: 93b34caae9373f06
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 05/13] selftests/bpf: Build BTF fixtures in btf_to_tmpfile()
Date: Fri, 30 Oct 2026 16:33:47 -0700
Message-ID: <20261030233355.1836749-6-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_bpftool_btf_dump() builds each BTF fixture, writes it to a
temporary file, and frees the BTF after the subtests on that file
finish, although they only read the file. Each fixture repeats this
handling, and one that fails to build skips the subtests of all later
fixtures.

Pass the fixture constructor to btf_to_tmpfile(), which frees the BTF
once it is written. A fixture that fails to build now skips only its
own subtests.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 58 +++++++++----------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 534aa79a4278..80e8e435d702 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -109,30 +109,39 @@ static struct btf *mk_loc_btf(void)
 	return btf;
 }
 
-static int btf_to_tmpfile(const struct btf *btf, char *path)
+static int btf_to_tmpfile(struct btf *(*mk)(void), char *path)
 {
 	ssize_t written;
+	struct btf *btf;
 	const void *raw;
+	int err = -1;
 	__u32 sz;
 	int fd;
 
+	btf = mk();
+	if (!btf)
+		return -1;
+
 	raw = btf__raw_data(btf, &sz);
 	if (!ASSERT_OK_PTR(raw, "raw_data"))
-		return -1;
+		goto out;
 
 	snprintf(path, PATH_MAX, "/tmp/bpftool_btf_dump.XXXXXX");
 	fd = mkstemp(path);
 	if (!ASSERT_OK_FD(fd, "mkstemp_btf"))
-		return -1;
+		goto out;
 
 	written = write(fd, raw, sz);
 	close(fd);
 	if (!ASSERT_EQ(written, sz, "write_btf")) {
 		unlink(path);
-		return -1;
+		goto out;
 	}
 
-	return 0;
+	err = 0;
+out:
+	btf__free(btf);
+	return err;
 }
 
 static char *dump_c(const char *btf_path, bool sorted)
@@ -265,33 +274,18 @@ static void test_loc_dump(const char *btf_path)
 void test_bpftool_btf_dump(void)
 {
 	char path[PATH_MAX];
-	struct btf *btf = NULL;
-
-	btf = mk_btf();
-	if (!btf)
-		return;
-
-	if (btf_to_tmpfile(btf, path))
-		goto out_btf;
 
-	if (test__start_subtest("c_sorted"))
-		test_dump(path, true);
-	if (test__start_subtest("c_unsorted"))
-		test_dump(path, false);
-	unlink(path);
-
-	btf__free(btf);
-
-	btf = mk_loc_btf();
-	if (!btf)
-		return;
-
-	if (btf_to_tmpfile(btf, path))
-		goto out_btf;
+	if (!btf_to_tmpfile(mk_btf, path)) {
+		if (test__start_subtest("c_sorted"))
+			test_dump(path, true);
+		if (test__start_subtest("c_unsorted"))
+			test_dump(path, false);
+		unlink(path);
+	}
 
-	if (test__start_subtest("loc_dump"))
-		test_loc_dump(path);
-	unlink(path);
-out_btf:
-	btf__free(btf);
+	if (!btf_to_tmpfile(mk_loc_btf, path)) {
+		if (test__start_subtest("loc_dump"))
+			test_loc_dump(path);
+		unlink(path);
+	}
 }
-- 
2.56.0

