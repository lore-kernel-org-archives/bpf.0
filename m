Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F13254B3
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662647; cv=none; b=VR/mYE/VwvK6cyhloOgHAv+slCIS5DPmQkEbrJfZlE9AQxCvd1zMirDTct5uLxtDezuSDd341a3gQmCOEd+qALQJaNh/q1UR654jJd7PchSl7Z8NCmE4Td1fhPGMi9cI9qty7zRquQXOjZu4cXwQC3aqcBOZlf1dz1rqujwKw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662647; c=relaxed/simple;
	bh=Ftyot/ZqvjfQvF995Taxfe0yqAjMM9pcWEkF/L7if5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lib46ysAmU+l3s2YnJB8ykh0c7wK4CVOPdMbTxc3tlOU1Ps2gZbi78/gtOw8hewv4Q8SDzIgJAP7nNHNl6q2bUYaQoGQ/7NtsXqvjJisk+TcNp5pHwaP3Dz9C188xO3466zc+wOIe1h2o7Z2CXQAEJ/KxJG/xS05cnJdGaCmEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JJqUqs1x; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JJqUqs1x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jF2bWZd6v0l8JgBtNN7s5j17ItDfJKumvgdSUFL+u0I=; b=JJqUqs1x4eeFhij5y42FH6aU/q
	nNe01OP539nIUwwbq6XxDFoI8By8t9dVZt2v3u+0bCM9HvqCzQDNcdUUGSKfFfG/iUgWO+EOs6c5g
	wmI+7k3cdI+T+wwN2Hn+/3f1lwCzB/EALRYVQQxCXj0xfb01qnizCVAexozAlmwCGIT/lP9HLQSDm
	HOJMd05GCHfvpE3N6LiAQrN9U+c1KFtzykBRlGH0LA2BNXAMRyiAkfhWjENsVJNU1J7veQ71JrX3+
	N3YKtFexyqZ120DAcwL73M4Dhw9B9M0obo8q8ADn1U45OvwuE4QSWEsev0Ux+EjfWnuwx47s7V0Qw
	hfcDXVqw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAUxu-000LV2-2a;
	Wed, 08 Apr 2026 17:37:14 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next 3/4] bpf: Remove static qualifier from local subprog pointer
Date: Wed,  8 Apr 2026 17:37:11 +0200
Message-ID: <20260408153712.523124-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408153712.523124-1-daniel@iogearbox.net>
References: <20260408153712.523124-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27965/Wed Apr  8 08:24:37 2026)

The local subprog pointer in create_jt() and visit_abnormal_return_insn()
was declared static.

It is unconditionally assigned via bpf_find_containing_subprog() before
every use. Thus, the static qualifier serves no purpose and rather creates
confusion. Just remove it.

Fixes: e40f5a6bf88a ("bpf: correct stack liveness for tail calls")
Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 46f55ea6684e..6cb54764d452 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19224,7 +19224,7 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 static struct bpf_iarray *
 create_jt(int t, struct bpf_verifier_env *env)
 {
-	static struct bpf_subprog_info *subprog;
+	struct bpf_subprog_info *subprog;
 	int subprog_start, subprog_end;
 	struct bpf_iarray *jt;
 	int i;
@@ -19299,7 +19299,7 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
  */
 static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
 {
-	static struct bpf_subprog_info *subprog;
+	struct bpf_subprog_info *subprog;
 	struct bpf_iarray *jt;
 
 	if (env->insn_aux_data[t].jt)
-- 
2.43.0

