Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901584;
	b=OMFuOwYMINZmdggwaORFNqQUKTzQ3t7y4Bdz0NBqzRlXximb6PwMBOCBMApvgkx4nIow
	 NgydbG3EImaz8He5GObDvomu5J0jkQ8tR1GRnwllvx+vsHBpnVJKMIBNwbg86G+VA9GRd
	 7pQyTDolN4Hqkpn5JnH0j6TrlSAi/pr484PQaGV021nahetNXUhWmthX5Tnu99HRpBS7h
	 90HR4l8tjoAOwrdxQm6pr0HZ18P4feHpwiGXG1mOQjbyJYA03CewyqbZ4TY/fy2egyI3m
	 HNI8WTXQAYxF8U3xD2z4P+jqeM98GYvZ5aKVV+ani04t3pCa0dmr2waGlJUZvqpYn9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901584;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIKCJu6ljpBXczjdNPbuEPQhM0otlUPVEMeKO8PLkgI=;
	b=RuDVsLdTGN6apyX83/Dj+FBppyXkw3QY0n8elprjUbo7dmajdYD7Nau9Daquh0B6KpvM
	 +Xcq/Dk0mrRNYIGS7ybsvgxbwvNG0NBWBez+BtbvkaBsA4GmXvEV41PtB2LkT9t9hcjyE
	 v+dHhwvgRBKdfgAVWzuZ0Z5kF3ksbzylVkyPEMnqq2SSBfbYlOezS3zEHuiIUUMT87AeT
	 W30LCZ5EGviFoiWzF+pwm1tZqV0Jw9eNUGcGg7yOv0jbl1pZUa1jZWY7wJFB1Pl9cXwYe
	 HkRDY+aNcp601NZvta2QkwoLTQTrTquId6qq9LPVPhCjDdTNbrk9r4okqJXnayccPaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mC8cdsn8;
	arc=none smtp.remote-ip=91.218.175.230
Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569D606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A569D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mC8cdsn8
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GzFxxxWh5GWJNdL/eGsakxecqc26cMhVVcrNltS8a34=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901581; v=1; x=1794506381;
 b=mC8cdsn8UtN4BUaHsEwNxyvLnFIxEW/aQ+rRM/5IulHCx2QeG6E4hD/jynr8nTo5asp66Oq7
 LdrfQswAgOTHyq9Q9rM/xaDWEseN6icxx+NoRyLRrQjeSMqawmkmve6B6gO4zyTO4G3jJxb6xE5
 7f8vXaoyEYh3yYyJQFkHmbOI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5ea389abcde12ec7;
	Thu, 05 Nov 2026 17:59:41 +0000
X-Mizu-Trace-ID: 5ea389abcde12ec7
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
Subject: [PATCH bpf-next v4 04/17] selftests/bpf: Build BTF fixtures in btf_to_tmpfile()
Date: Thu,  5 Nov 2026 10:58:32 -0700
Message-ID: <20261105175845.30357-5-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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

