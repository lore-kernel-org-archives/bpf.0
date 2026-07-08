Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A337BE75
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545349; cv=none; b=oJxrxotFjecHYTdlQh1xYE4rdGAMqXIL6fI+kXVKBHWbtAeu8s1/8d44xc6zNfSMtXqHKj5XUUuPVnKpq7T98k0p4ZKc8mYPUTXjVcK3b4/F2Ge9s6kPMcGg0okp/5MUDq3dYN8fLiHlQoOxeoRBysjXI9alxkrUj9YckLNwa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545349; c=relaxed/simple;
	bh=40i9o1xgkT7lEZ9DQ5ji9NvMiYUf2azh8bGmhc2Jdhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5A4AVlziwgAEr2D0oAsG/JuGrPDyfcVOhDdWD0e5fsxg8ah14ASX3IG1RjXS30S3p+Xw/EcrA1zxg2QWz5wXLIZrbLhqv3/3gseR/uDmWzKUJje9Ini2aY/mscxUHkhwmiW9PG6tINDApSsaEmJeZ+THzfitn6fmCBH4bvw+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=L7yJPCur; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="L7yJPCur"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H/Mx5W8k80wvQRonuyc8uXS73adKeJ0HEQnwk2dJYgU=; b=L7yJPCurGQMMBoaBOAwg2/QpoC
	aTiU/liSs5zIZiO8xUECN+/sxi4/7DdJ4v3/yWQWyIP8Sfx5HDMC/iXHYpaoa2j2Pk4SRBDP6n1B4
	nfPuSLwTPKskG7ta2F6sL/B3M71mO4bOJqIUaiqP7DDMakNJQnSf13fHNwJAWTV+vE39gBXOo+V2F
	JrATI/GWlKQdZePUKP0nSSSJpVcN1B5WBAjuOe4DM4RS+WPU4HEvp27xVKERk0UY4KO1631/cAYaJ
	qLmGG7fTHW8dS6/VSExZZ9nTH6AGBCgttZ2tm5LzlGZS9hjltv7uK1W6Uf+nDzfeoKTqG/laP1TLl
	Kl3vRPJA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whZcJ-000OUb-1j;
	Wed, 08 Jul 2026 23:15:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/4] bpf: Give vmlinux BTF init its own mutex
Date: Wed,  8 Jul 2026 23:15:35 +0200
Message-ID: <20260708211537.371874-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708211537.371874-1-daniel@iogearbox.net>
References: <20260708211537.371874-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28054/Wed Jul  8 08:24:53 2026)

bpf_get_btf_vmlinux() serializes the lazy vmlinux BTF parse with
bpf_verifier_lock, the same mutex bpf_check() holds across the whole
verification of an unprivileged program (if enabled; it's disabled
by default). The latter can potentially stall the mutex holder for
a long time (e.g. via userfaultfd), and therefore block first-time
bpf_get_btf_vmlinux() caller from any context, including privileged
program loads.

Give the vmlinux BTF initialization a dedicated btf_vmlinux_lock so
it is independent of the unprivileged verification mutex. The parse
only needs mutual exclusion against itself.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/btf.c      | 2 +-
 kernel/bpf/verifier.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dff5c0d91641..8c04c340f499 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6451,7 +6451,7 @@ struct btf *btf_parse_vmlinux(void)
 	if (IS_ERR(btf))
 		goto err_out;
 
-	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
+	/* btf_parse_vmlinux() runs under btf_vmlinux_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 	err = btf_alloc_id(btf);
 	if (err) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9217e0f87cb5..40e20dfa3212 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -324,6 +324,7 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
 }
 
 static DEFINE_MUTEX(bpf_verifier_lock);
+static DEFINE_MUTEX(btf_vmlinux_lock);
 static DEFINE_MUTEX(bpf_percpu_ma_lock);
 
 __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
@@ -19563,7 +19564,7 @@ struct btf *bpf_get_btf_vmlinux(void)
 	struct btf *btf = smp_load_acquire(&btf_vmlinux);
 
 	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-		mutex_lock(&bpf_verifier_lock);
+		mutex_lock(&btf_vmlinux_lock);
 		btf = btf_vmlinux;
 		if (!btf) {
 			btf = btf_parse_vmlinux();
@@ -19575,7 +19576,7 @@ struct btf *bpf_get_btf_vmlinux(void)
 			 */
 			smp_store_release(&btf_vmlinux, btf);
 		}
-		mutex_unlock(&bpf_verifier_lock);
+		mutex_unlock(&btf_vmlinux_lock);
 	}
 	return btf;
 }
@@ -20089,7 +20090,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 
 	bpf_get_btf_vmlinux();
 
-	/* grab the mutex to protect few globals used by verifier */
+	/* Serialize verification of unprivileged programs. */
 	if (!is_priv)
 		mutex_lock(&bpf_verifier_lock);
 
-- 
2.43.0

