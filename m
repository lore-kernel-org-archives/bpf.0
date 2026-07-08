Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1793F44E7
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545348; cv=none; b=XQDaTLfkHN9maxP9Bh7u0xQOdan/pEZUfRl/BgvfUiOfDPpXB28zaaMk08MYBpvCxk5bXztB5nFYNtpd8GFMJ/H37prrG0l2XZWLGfy6UVeGcH2Mzv+XnOG9OWWKpA9FE/kWTGlKOhWqkvDOaRtFz7VuLMQuG0vKOvk07M9GjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545348; c=relaxed/simple;
	bh=xSNujJDz8eJ5WLz970eORmRM2PN8lXB4dEvLbvHKcig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfiZ+uz8iEVDPibSmqtM2gr8VRQHVqjbdkZTFlyMrA6f8HevVz0x1M3CbWKUn0Wh+IUJWe06L7nAYJsXFpOLc2D6bhPCWWyfhXG1M4NGpyiEiVObP31YwWAH1KWyDd3qy+s+/WQuuPEbUbS7eGxVSY0zejNPtuEYU3SZteZS1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DE0QEO8A; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DE0QEO8A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tQ6+Emjh5FL/GUCTI/nZQNa+XUc2fjkv157Qz/cftsY=; b=DE0QEO8AomTF5d2boccaMeSq3Z
	DkNpGf9BlgNaDdiVvB3q9HSNHEjXX8PLb8FQPje5bAK6UKcTYcJGrpprRHqUzkGjS9YoxLMJk5RCY
	oV8EQGRDQrE0uEGt4AbUKTDhqeCMm9QJk0xyCX1lCdZN/GOJ2u1wwNRNN9vLPaniJP4yMJeYfi4mk
	3bQKwKodnHXNtoO/MHxTewkcRTK670V72aMyE+PONcx48qF0fhZPE0kulrsWxey1LWi/vLw/zET0P
	SlNXTQ4uXMt3j9cVlXvjhwpFknrzzhGCj6cZM2R9ryaVpwH3Er5BoXunUjtagee5ee3diEhJA8dKg
	xL9J+cNg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whZcJ-000OUW-0B;
	Wed, 08 Jul 2026 23:15:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/4] bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
Date: Wed,  8 Jul 2026 23:15:34 +0200
Message-ID: <20260708211537.371874-2-daniel@iogearbox.net>
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

bpf_get_btf_vmlinux() lazily parses the vmlinux BTF under the
bpf_verifier_lock, but publishes the result through a plain store
and re-checks it through a plain lockless load. Nothing orders
the stores initializing the struct btf inside btf_parse_vmlinux()
against the store publishing the pointer: On a weakly ordered
arch, a concurrent first-time caller taking the lockless fast
path could in principle observe the pointer before the parsed
contents are visible. The mutex_unlock() does not help such a
reader given it only synchronizes with a later acquisition of the
same lock. Thus, publish the pointer with smp_store_release()
and read it on the fast path with smp_load_acquire().

Acquire semantics are needed rather than a dependency-ordered
READ_ONCE(): btf_parse_vmlinux() also populates globals outside
the returned object (e.g. bpf_ctx_convert.t). An address
dependency would only order accesses performed through the
pointer and not cover other globals.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 001ac53825da..9217e0f87cb5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19559,13 +19559,25 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 
 struct btf *bpf_get_btf_vmlinux(void)
 {
-	if (!btf_vmlinux && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+	/* Pairs with the smp_store_release() on the parse path below. */
+	struct btf *btf = smp_load_acquire(&btf_vmlinux);
+
+	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
 		mutex_lock(&bpf_verifier_lock);
-		if (!btf_vmlinux)
-			btf_vmlinux = btf_parse_vmlinux();
+		btf = btf_vmlinux;
+		if (!btf) {
+			btf = btf_parse_vmlinux();
+			/*
+			 * Order the parsed BTF contents and the globals the
+			 * parse populated (e.g. bpf_ctx_convert.t) before
+			 * the pointer publication. Pairs with the acquire
+			 * on the lockless fast path above.
+			 */
+			smp_store_release(&btf_vmlinux, btf);
+		}
 		mutex_unlock(&bpf_verifier_lock);
 	}
-	return btf_vmlinux;
+	return btf;
 }
 
 /*
-- 
2.43.0

