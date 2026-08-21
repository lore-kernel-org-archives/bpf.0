Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12B408614
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348486; cv=none; b=RXoqoZ5Pts5hV9uODArx1EZceBk2qRD9fhA9rDpaDqoaUzjstyfZAUfBeQBrVd4jmIn29tLxzrogfFl/fJmLUENl1HET1MtGPFSsFtWRNd0C9cwzXBxGCKjQhna3yDkEQoC0hExUHSy8ztJIeKNj1YHEBghrSOIBHBb91J1GzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348486; c=relaxed/simple;
	bh=iCWAmQytAP3sAM/+d3rY04J7npjkq2+mQy7dZaTePvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUgM4ypimIsVK4vaS0EJjUahQpNDlf6pOJ4er2LKv61ItKQ5brIcIcn0WkvFIy8mzrxVQWgSQDRAQlnYfYw3KxifSCMOBCDGQluevZE7MzWfmeqQTE7u9k/GmFY6ibBAoQyI0TQvIh8hvas0zOSVi5NW3uqqXjsAWARZa041dmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DD8NzFqo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DD8NzFqo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sW7R4OS1SuntzdojsaFlbSJlrU1Xodaf1wZ2CmmOi44=; b=DD8NzFqojfowQJtGPzgstNmxGz
	sY9ldSTpTkyObtru91zY4EucQOsASPXvjihS9dN9FfFm71ReCVzQVlGHZ5zDcL9zfD4sIJ5pxTeRx
	/N461pv1KiwkZCHVaOjPNNmWEUcFTzjx60dt6rEqXpFqCx85bo+7hMnD4/n7ASIkvn+awjljHUrEe
	ri7b86wyJuP0FnFwxN6tTOcWcJbV4uX9o3dp87hmku1uiLOdyG+ebsVbQc5PAzC/3sryYId0h5bGi
	pMPAbtfCS8CBrRpJPkYEp0cXiexexBuSraOThcVo+PBW+RYqZHnXcKJKz62IDkU6J2lni5cFGs6Ne
	vbd5ReZQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzF-000MqM-1W;
	Fri, 21 Aug 2026 23:41:17 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 07/11] selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
Date: Fri, 21 Aug 2026 23:41:07 +0200
Message-ID: <20260821214111.1120748-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821214111.1120748-1-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28099/Fri Aug 21 08:26:38 2026)

The script's "setup" action generates an RSA key, enrolls it and builds
a keyring around it. The name says nothing about the algorithm, which is
fine while there is only one, but we'll add "setup-mldsa" soon, therefore
rename the existing one into "setup-rsa". No functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/signed_loader.c   | 18 +++++++++---------
 .../bpf/prog_tests/verify_pkcs7_sig.c          |  4 ++--
 .../testing/selftests/bpf/verify_sig_setup.sh  |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 94b57e7cdab3..4b2416903d90 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -460,7 +460,7 @@ static void signed_btf_fd_array_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -857,7 +857,7 @@ static void signature_authenticates_insns(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -957,7 +957,7 @@ static void signature_authenticates_metadata(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1293,7 +1293,7 @@ static void lsm_signature_verdict(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		dir = NULL;
 		goto out;
@@ -1476,7 +1476,7 @@ static void loadtime_verify(struct bpf_object *obj, int expect_maps)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1574,7 +1574,7 @@ static void signed_no_fd_array(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1645,7 +1645,7 @@ static void signed_map_by_fd_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out_map;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		goto out_map;
 	}
@@ -1707,7 +1707,7 @@ static void signed_sparse_fd_array_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out_map;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		goto out_map;
 	}
@@ -1761,7 +1761,7 @@ static void signed_module_kfunc_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
index f327feb8e38c..12b146d205d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -257,7 +257,7 @@ static void test_verify_pkcs7_sig_from_map(void)
 	if (!ASSERT_OK_PTR(tmp_dir, "mkdtemp"))
 		return;
 
-	ret = _run_setup_process(tmp_dir, "setup");
+	ret = _run_setup_process(tmp_dir, "setup-rsa");
 	if (!ASSERT_OK(ret, "_run_setup_process"))
 		goto close_prog;
 
@@ -458,7 +458,7 @@ static void test_pkcs7_sig_fsverity(void)
 	snprintf(data_path, PATH_MAX, "%s/data-file", tmp_dir);
 	snprintf(sig_path, PATH_MAX, "%s/sig-file", tmp_dir);
 
-	ret = _run_setup_process(tmp_dir, "setup");
+	ret = _run_setup_process(tmp_dir, "setup-rsa");
 	if (!ASSERT_OK(ret, "_run_setup_process"))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
index 09179fb551f0..202e6e6418fe 100755
--- a/tools/testing/selftests/bpf/verify_sig_setup.sh
+++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
@@ -28,7 +28,7 @@ authorityKeyIdentifier=keyid
 
 usage()
 {
-	echo "Usage: $0 <setup|cleanup <existing_tmp_dir>"
+	echo "Usage: $0 <setup-rsa|cleanup <existing_tmp_dir>"
 	exit 1
 }
 
@@ -47,7 +47,7 @@ genkey()
 		${tmp_dir}/signing_key.der -outform der
 }
 
-setup()
+setup_rsa()
 {
 	local tmp_dir="$1"
 
@@ -108,8 +108,8 @@ main()
 
 	[[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
 
-	if [[ "${action}" == "setup" ]]; then
-		setup "${tmp_dir}"
+	if [[ "${action}" == "setup-rsa" ]]; then
+		setup_rsa "${tmp_dir}"
 	elif [[ "${action}" == "genkey" ]]; then
 		genkey "${tmp_dir}"
 	elif [[ "${action}" == "cleanup" ]]; then
-- 
2.43.0

