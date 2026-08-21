Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D063C196B
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348484; cv=none; b=HOfYRakvBaxBnhNbKgLjIJRqsu+Uulvi/5xuiurg5FSvAir2BXPEsyLcmqMe2L31oMYR0e2zlXvM7sWHxM+uORo6T3duil6EDumGPmaxDaa8DGyM16N3JUJhybR+U6PlyxpIOA+jJ0nY3qqc11GYJlgCZiM+jJEY1DRQOQXkJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348484; c=relaxed/simple;
	bh=VboGFFFrLwYtTBb5wYm3g1xEt3QGZbEdtcitgeCghHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrHGa4tSocHU/YqHpEt/Vn/LuO85D/Q21OxqEwWxuwa3fYItMx8It5fMAD9JbkuSf/Y7mRaLfWrhqvyk9y9mhLKAFGy2UIuRaCrBPYxLhNH4RvIff6n0CvZ6n1U6IU55jBxUPQusEP/pLgiw/wF98PK46ONHIwgcflGzqCF8KfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HpV7SUnv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HpV7SUnv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xJINMvmrDTENbzN6j1NqwE34FpwAn23X3FGrIHP0Y4s=; b=HpV7SUnvHGsLIgK22EqEkAWD+O
	kjLq6iXuKXm3NPazd97xOptK1NugEtKXUMNB3udQnWNzX5VNfJzxb2fZZsjndsPI1DwKebNBw3C7R
	yea/WHxzWxRyUCvtRcv/56858AkKhwHtFnvUl9HS3xGDJLmOW+A7Iusxy6csx8lvRjfpmfGr/l+ly
	LxGEjdJNrNOYjxFL/bR1haQrsBm8VryzpG+Fd3QK722wkktYguPgNjk3Cx/sBJ5MoBgb/eFeE4rgz
	k3V7hygHrPBWe6OBNubydRs5J/PdFFKv6qMo9XNZkY3Iv1FjDT3+O7SxihEqYyTRCIBWUTD7TX6fP
	nC/YKWpw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzC-000Mpk-23;
	Fri, 21 Aug 2026 23:41:14 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 03/11] bpf: Raise the bound on a program's signature size
Date: Fri, 21 Aug 2026 23:41:03 +0200
Message-ID: <20260821214111.1120748-4-daniel@iogearbox.net>
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

signature_size is bounded by KMALLOC_MAX_CACHE_SIZE, which is 8 KiB on a
4 KiB page system. Back then we chose it somewhat arbitrarily and was
picked when a BPF program signature was RSA or ECDSA. ML-DSA (FIPS-204)
verification is wired through the X.509 and PKCS#7 parsers, and BPF
reaches them too via verify_pkcs7_signature() without having to know the
concrete algorithm. The bound becomes a bit too small, thus add an
explicit BPF_PROG_MAX_SIGNATURE_SIZE of 64 KiB and use that instead
to cover all options.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c                              | 14 +++++++++-----
 .../selftests/bpf/prog_tests/signed_loader.c       |  5 +++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a93a8dc427d8..575c4e5e4443 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20972,6 +20972,13 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+/*
+ * Upper bound on the PKCS#7 signature blob passed with a program. Comfortably
+ * above the largest signature the kernel can verify, and far below anything
+ * that would make rejecting a load expensive.
+ */
+#define BPF_PROG_MAX_SIGNATURE_SIZE	(64 * 1024)
+
 static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
 {
 	switch (keyring_id) {
@@ -21011,13 +21018,10 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 	u64 data_sz;
 	int err = 0;
 
-	/*
-	 * Don't attempt to use kmalloc_large or vmalloc for signatures.
-	 * Practical signature for BPF program should be below this limit.
-	 */
 	if (!attr->signature_size ||
-	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
+	    attr->signature_size > BPF_PROG_MAX_SIGNATURE_SIZE)
 		return -EINVAL;
+
 	if (!system_keyring_id_check(attr->keyring_id)) {
 		key = bpf_lookup_system_key(attr->keyring_id);
 	} else {
diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 77381d345435..0c5294738d6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -571,8 +571,9 @@ static void signature_too_large(void)
 
 	if (gen_loader_fixture_init(&f) == 0) {
 		/*
-		 * signature_size beyond the kernel's bound (KMALLOC_MAX_CACHE_SIZE)
-		 * is rejected before the buffer is read.
+		 * signature_size beyond the kernel's bound
+		 * (BPF_PROG_MAX_SIGNATURE_SIZE) is rejected before the buffer
+		 * is read.
 		 */
 		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
 				 64 << 20, KEY_SPEC_SESSION_KEYRING, 0);
-- 
2.43.0

