Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C692E7370
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348484; cv=none; b=f7F87NISZl6Ncjbv/hVjAkdVw/ey14Bu95V9G2W1ve8cJPVVkFke2sJHDcoyCzd61nb4jHY72XTXniFrTuUd9mQNgi1GuwTBOAT6rhzGaw8IfXvvozglXSK+C883+OKL5MJ8u7RSvQIiyuaNjLb5WuegdLZ7nY4misNaW3QPJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348484; c=relaxed/simple;
	bh=SDYL4zTPv0ybx0By0fWXiTQKbp+0CfUdjVQIV9quL6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6ucYBhJa/HXpOYJXWNE5Abrmt5uYexTbXmNpayniV82OL41+TJB1cPY3hPritdT5YvY3ZRjfSo3ltVvSzuGu55Xihhjd2eFDAkQgMdk78HnGC3g5rWd5geOuk1/lMwbxwqcY0fsDMHvtNLrynXoFDTOW5Gj2VSwxZ1LouWJ4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OUd1JTQC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OUd1JTQC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=psr63aKTcYv7JWfL1Fgtj44z4nsWaxIOCB1rrrNFgaA=; b=OUd1JTQCNEiuwL7+207Blkt8gO
	EdkLst32kUobaJ4HPj6paFK9yY4IAM37Q+Pn36wH0fmsnrdElIoQBaBDcTneG2V0RvEFeQNPkH1Eh
	O7zzC5qGj3pkHjJdyfYhucO5bxGzcKUbkCL3PaxiXsoYi/ljjQeDGzZH2EJ0ltHYqf72GkARiwC5v
	JGFUGNfo5oUWdqHuMbwIAG1VHVUUqzx5c3rFzZZOoUDuQVV+Rj+fNwUBcV+xakCw0ByjyWi/WB22A
	f2CLl+dJDNmV3BYpQIPNF7UTppj1drX026NsfB8EwYLGljEju80UO+OprcyRXsNQWOfFhooNfK1tr
	IBRVtoaA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzD-000Mpq-0s;
	Fri, 21 Aug 2026 23:41:15 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 04/11] bpftool: Support ML-DSA program signing
Date: Fri, 21 Aug 2026 23:41:04 +0200
Message-ID: <20260821214111.1120748-5-daniel@iogearbox.net>
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

Add bpftool support for ML-DSA program signing and drop the flag for
ML-DSA keys on affected OpenSSL versions, the same way as commit
0ad9a71933e7 ("modsign: Enable ML-DSA module signing").

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/bpf/bpftool/main.h |  2 +-
 tools/bpf/bpftool/sign.c | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 78b6e0ebb85d..9315a1db1f7c 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -57,7 +57,7 @@ static inline void *u64_to_ptr(__u64 ptr)
 	})
 
 #define ERR_MAX_LEN	1024
-#define MAX_SIG_SIZE	4096
+#define MAX_SIG_SIZE	16384
 
 #define BPF_TAG_FMT	"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
 
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index 88726a6db6d0..818a4f900bbb 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -130,6 +130,9 @@ __u32 register_session_key(const char *key_der_path)
 
 int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 {
+	unsigned int signer_flags = CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
+				    CMS_USE_KEYID | CMS_NOATTR;
+	const EVP_MD *cms_digest = EVP_sha256();
 	BIO *bd_in = NULL, *bd_out = NULL;
 	EVP_PKEY *private_key = NULL;
 	CMS_ContentInfo *cms = NULL;
@@ -167,6 +170,21 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 		goto cleanup;
 	}
 
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x40000000L
+	if (EVP_PKEY_is_a(private_key, "ML-DSA-44") ||
+	    EVP_PKEY_is_a(private_key, "ML-DSA-65") ||
+	    EVP_PKEY_is_a(private_key, "ML-DSA-87")) {
+		/*
+		 * ML-DSA + CMS_NOATTR is not supported in openssl-3.5 and
+		 * before, so fall back to signedAttrs. ML-DSA does its own
+		 * hashing and ignores the CMS digest, except when signedAttrs
+		 * are used, where only SHA-512 is permitted.
+		 */
+		signer_flags &= ~CMS_NOATTR;
+		cms_digest = EVP_sha512();
+	}
+#endif
+
 	cms = CMS_sign(NULL, NULL, NULL, NULL,
 		       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_DETACHED |
 			       CMS_STREAM);
@@ -175,9 +193,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 		goto cleanup;
 	}
 
-	if (!CMS_add1_signer(cms, x509, private_key, EVP_sha256(),
-			     CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
-			     CMS_USE_KEYID | CMS_NOATTR)) {
+	if (!CMS_add1_signer(cms, x509, private_key, cms_digest, signer_flags)) {
 		err = -EINVAL;
 		goto cleanup;
 	}
-- 
2.43.0

