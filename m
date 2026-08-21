Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96973D810C
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348485; cv=none; b=I1YCOueVgGcp/K1Ov193EMgQNZK3i2ARoL1tkQqozqxBBK5GjdQ4q1Gt87EQ9Dax+v4xaqqCygKxMgCfpG6GTOwpdN6GZZW7Y/PAOk/BWQlIBB7sku8x8HcyMlROkIxcHF5vPVVAmDaVBA9gCONMjjggQjir37Hpt3h7isHoIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348485; c=relaxed/simple;
	bh=22Uq6icUCH58x1iuoJu7FyEOZB59Uiau1d4PlRlwiCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGkTKJgDXwIVRz4BlyHCYvQNJvR8HWjyLpNyfp9GIZB8952XuBEyPASFj3lPk/vXiaBgcPOEhHQmvgeiG8WSrt6CdnArussdsgthCiEAS4rt/B+UPt+wtLfnwTSA8hM0KPJ/zFn7Tko0Db4+s22Jq03kke45KhIJ7xHpyxyk20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VW+lgJei; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VW+lgJei"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zjwi+kJcEp/3VJd5u4WhTHr7qXPFdc/2xlyBrgI7Pk0=; b=VW+lgJeiv3jrOm1cq/Ld1N62Vf
	JtRXiODABCb/RGYF1waKSqNemKvorEMvhyhwgsYQnb8WlMjhkZg6+FJzq2gYXxyEmTPQavSFDXme9
	lJN20ZSA/Lg+0vyJbgfE2V863UT+zrW1DHFXl8timlB+PHSM8LOYStY04QsT/ua5YnPwI1bZXzB9A
	hm2rD8NVLrvpQ1uD2j52OmmkzT5og+zBgXzFtXIxaC5Ay1Z7LNL7onKKG3jTqkgkLMwZofJT25yVT
	kNw2x7nVoB4TY4iX/r7ELQfxIx+OtH7YqZlh5QzOrNUC9rZKrkv/quw42niH/RbJXYavhQEJ0HtCR
	8vnYjdIg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzD-000Mpz-39;
	Fri, 21 Aug 2026 23:41:16 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 05/11] selftests/bpf: Add a test for the sealed bpf keyring
Date: Fri, 21 Aug 2026 23:41:05 +0200
Message-ID: <20260821214111.1120748-6-daniel@iogearbox.net>
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

bpf_keyring_sealed checks that a load naming the bpf keyring fails with
-ENOKEY while the keyring has not been provisioned. It uses a junk signature
as the size check and the keyring lookup both happen before any crypto, so
the error under test is reached without a real signature and the ordering
is what gets verified:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  [...]
  #424/9   signed_loader/signed_module_kfunc_rejected:OK
  #424/10  signed_loader/signature_failure_logs:OK
  #424/11  signed_loader/signature_too_large:OK
  #424/12  signed_loader/signature_zero_size:OK
  #424/13  signed_loader/signature_bad_keyring:OK
  #424/14  signed_loader/bpf_keyring_sealed:OK
  #424/15  signed_loader/metadata_ctx_max_entries_ignored:OK
  #424/16  signed_loader/metadata_ctx_initial_value_ignored:OK
  #424/17  signed_loader/signature_authenticates_insns:OK
  #424/18  signed_loader/signature_authenticates_metadata:OK
  #424/19  signed_loader/hash_requires_frozen:OK
  [...]
  #424     signed_loader:OK
  Summary: 1/30 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/signed_loader.c  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 0c5294738d6c..94b57e7cdab3 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -32,8 +32,11 @@ enum {
 	BPF_SIG_KEYRING_SECONDARY,
 	BPF_SIG_KEYRING_PLATFORM,
 	BPF_SIG_KEYRING_USER,
+	BPF_SIG_KEYRING_BPF,
 };
 
+#define BPF_KEYRING_BPF		3
+
 static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
 		       const void *sig, __u32 sig_sz, __s32 keyring_id,
 		       __u32 fd_array_cnt)
@@ -627,6 +630,28 @@ static void signature_bad_keyring(void)
 	gen_loader_fixture_fini(&f);
 }
 
+static void bpf_keyring_sealed(void)
+{
+	static const __u8 junk[64] = {};
+	struct gen_loader_fixture f;
+	int fd;
+
+	if (gen_loader_fixture_init(&f) == 0) {
+		/*
+		 * Without bpf.keyring_unsealed=1 on the command line the bpf
+		 * keyring is sealed empty during boot, so it is never handed
+		 * out and a load naming it fails with -ENOKEY before the
+		 * signature bytes are examined.
+		 */
+		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
+				 sizeof(junk), BPF_KEYRING_BPF, 0);
+		ASSERT_EQ(fd, -ENOKEY, "sealed bpf keyring rejected");
+		if (fd >= 0)
+			close(fd);
+	}
+	gen_loader_fixture_fini(&f);
+}
+
 /*
  * A signed loader must ignore ctx-supplied map dimensions: the host cannot
  * resize a signed program's maps via the loader ctx. Drive a one-map program
@@ -1806,6 +1831,8 @@ void test_signed_loader(void)
 		signature_zero_size();
 	if (test__start_subtest("signature_bad_keyring"))
 		signature_bad_keyring();
+	if (test__start_subtest("bpf_keyring_sealed"))
+		bpf_keyring_sealed();
 	if (test__start_subtest("metadata_ctx_max_entries_ignored"))
 		metadata_ctx_max_entries_ignored();
 	if (test__start_subtest("metadata_ctx_initial_value_ignored"))
-- 
2.43.0

