Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795222022;
	b=z9zp2SiR/sPcHWYbl7AI+ePOuXF7iRlNQd7HVGGnz05a3j4DaFUJ+KDr/4ta7m8oFJjS
	 Gmye52aUrk2c4AaHX946+SA1OTQ/XqRhZHs37u4DLCHt5dE9xXdIozTpOw5PPwTtX8Iu0
	 hs4b5HmitWhaqUo7mf5H8xfFSHtlZkis9OSRP3upMXGEdnpy9Z3EmkaeyfdqNER77zVFr
	 VDmpoTdo9jlYmRLRtFgh58Jl33aea/g3PtQ6f3o1MCJdbpNFoN0+AcQ8vJ0+G819M9TCE
	 NTS3OllTIpESinirPodzD3v8Khm88wZ26vJ2POqgZMFSak/0OWR2gPY7f3sAlPwQsXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795222022;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kbRdxhX3HS305PksV3ePykfNTOcdvrwcAY3kxlJ7V08=;
	b=AyA5vKQP4b9kVzR7d+FCvfkdNjb0bwFb3bwN8MclFGpUF8dCSOtvDGJpB7iSYjC/aoDG
	 BwBL6Je2fnio6Od/+5MMfDmtFac506VZmBBolhMVEH4a7YdWDxf+KZF4IwIbNETCHWqVm
	 ugTXvjcWc/26t4XMEviwqVqKce5sv8JOtibLtqafGEJMGKkw98czywAv9kvzUqlGlGHUs
	 sk4FVS3o7w8ke2FTPyP5dkY/iNEXtlvkA69jW+Ouj85w1Po0u7a18YpSkzVojUF6LGlbG
	 NcC74jBfKhghtoaygtFTpd9rnzHhYxbRkRrcmWV7vnFH0YUrUxWnDc/KcfFq6M4O5mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LQTiYdsK;
	arc=none smtp.remote-ip=95.215.58.68
Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370F606A684
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 00:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0370F606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LQTiYdsK
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CBLd40Hx75p0dVjcIlXScTHjtjsT7X+6jtrCCJI4bIU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795222006; v=1; x=1795826806;
 b=LQTiYdsKue0X9kFaAX0RxSiEbE4J0NNupJTGgrT1IWfesxBJ3Fkz1HAZ6NyuqY4wdZZnFggo
 oNTnDd11yAXBUpHCbuzb1soIHi2cAzvl3jkc1g7wz0eyLLBS61x95znxW3UXiabscXEdhljlSLc
 9SVLg1ge1TCioRpI2Jl9+31k=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 034ee6cccfff47a1;
	Sat, 21 Nov 2026 00:46:46 +0000
X-Mizu-Trace-ID: 034ee6cccfff47a1
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Giuseppe Scrivano <giuseppe@scrivano.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH vfs v1] selftests/bpf: Match overlayfs open error in uprobe_multi_test
Date: Fri, 20 Nov 2026 17:46:38 -0700
Message-ID: <20261121004638.2973704-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
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

The attach_api_fails_ovl_no_data subtest expects BPF_LINK_CREATE to
return -ENOENT. Overlayfs commit 0d5e729c515f ("ovl: return EIO if the
lowerdata is missing") maps the lookup error to -EIO when a metacopy
file exists but its backing data is missing. This fails the assertion
in aarch64 linux-next CI with "actual -5 != expected -2".

Check that the overlay entry exists with O_PATH, then attach the
uprobe before opening the file for reading so the attach still
exercises lazy lookup. Compare the attach error with the error
reported by open() on the same file.

Fixes: d21b93ab6068 ("selftests/bpf: add uprobe_multi test on overlayfs without data")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

Caught by BPF CI on linux-next:
https://github.com/kernel-patches/bpf/actions/runs/44811929601/job/136556160720

---
 .../bpf/prog_tests/uprobe_multi_test.c        | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 907d8c6d5ec9..e0ebe578943b 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -588,6 +588,7 @@ enum ovl_no_data_stage {
 struct ovl_no_data_result {
 	enum ovl_no_data_stage stage;
 	int err;
+	int open_err;
 };
 
 /*
@@ -628,20 +629,33 @@ static void ovl_no_data_child(int prog_fd, const char *dir, int wfd)
 		     strlen("/missing"), 0))
 		goto out_errno;
 
-	res.stage = OVL_NO_DATA_MOUNT;
 	snprintf(data, sizeof(data), "lowerdir=%s/lower::%s/data", dir, dir);
 	snprintf(path, sizeof(path), "%s/merged", dir);
-	if (mount("overlay", path, "overlay", 0, data))
+	if (mount("overlay", path, "overlay", 0, data)) {
+		res.stage = OVL_NO_DATA_MOUNT;
 		goto out_errno;
+	}
 
-	res.stage = OVL_NO_DATA_ATTACH;
 	snprintf(path, sizeof(path), "%s/merged/f", dir);
+	/* Check that the overlay entry exists without resolving its lowerdata. */
+	fd = open(path, O_PATH);
+	if (fd < 0)
+		goto out_errno;
+	close(fd);
+
+	res.stage = OVL_NO_DATA_ATTACH;
 	opts.uprobe_multi.path = path;
 	opts.uprobe_multi.offsets = &offset;
 	opts.uprobe_multi.cnt = 1;
 	res.err = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
 	if (res.err >= 0)
 		close(res.err);
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		res.open_err = -errno;
+	else
+		close(fd);
 	goto out;
 
 out_errno:
@@ -653,9 +667,8 @@ static void ovl_no_data_child(int prog_fd, const char *dir, int wfd)
 }
 
 /*
- * The data of a metacopy file in an overlayfs data-only layer is looked up
- * lazily. If it can't be found attaching must fail with the error from the
- * lookup.
+ * Opening a metacopy file and attaching a uprobe both resolve its lowerdata
+ * lazily. Attaching must report the same lookup error as open().
  */
 static void test_attach_api_fails_ovl_no_data(void)
 {
@@ -701,7 +714,9 @@ static void test_attach_api_fails_ovl_no_data(void)
 	}
 	if (!ASSERT_EQ(res.stage, OVL_NO_DATA_ATTACH, "setup"))
 		goto cleanup_pipe;
-	ASSERT_EQ(res.err, -ENOENT, "link_create");
+	if (!ASSERT_TRUE(res.open_err == -ENOENT || res.open_err == -EIO, "open_errno"))
+		goto cleanup_pipe;
+	ASSERT_EQ(res.err, res.open_err, "link_create");
 
 cleanup_pipe:
 	if (pipefd[0] >= 0)

base-commit: d21b93ab6068a832855d5d9d31c4b02c91245227
-- 
2.56.1

