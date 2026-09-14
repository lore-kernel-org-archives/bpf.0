Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C648F85E
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405421; cv=none; b=pDi0Bpp6v4m6VaFnA2Q1Uc+jXdL22XJyDlXunBhBoj8tEcOMaVMgc+rdO3S6OPCX4UlcG1ISRJ3lEdD8qFYjV4Cs68oMttjI6CMJ2MkVnZhPN+033rT518fMLlMQZhEGp228nsIHVAASORBxQap1nTf5+KZ3u3o6mvFdqeWDevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405421; c=relaxed/simple;
	bh=0IeAcvglTBInO3lOYp2l+0nM3OxA5ilCi7gkKgSva28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knzjHK+vi/t8GM2XmGELBKwcjUVq5GUb1Oo8u3nfu/n5NUB5hbFwAad50ePKL1wrLZj8TcHCD/dnOB0jASXT4GygSFIn//9t7GlHmPZ1k4Npp8h7XA+n9KrQDcGQGshvPPkp30kxhxcHIqluNnYvK48lhyeglPbrx5PIBec8+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lLRyLKB+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lLRyLKB+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HFb24XXU3zbnGgQ1+MohY2DXMXM5uvY2yMUETH2Riqw=; b=lLRyLKB+kdl+HfmRxHuuG4ZJbL
	EeQJWr45VNkukF+rpsTmYNbQl9KYLpC6iyIrQp4oMPxDhLJl9bOAjmkjwuGl95Xk/9k9lgVOfjyB3
	uA2ezufUwRk84M7KmGBb9Red0c8yQzWJyBD7Jbi10xYxU5NayAdxUxX79e209/BM0xVRbqDGbsRb+
	RU9a051q8ZQeZ/BuEUZ99xZijQRrw2kjDHmWux247pFGkxRtOCOcCCOmv/jD32KNyZCEAAJM09V/U
	XBBieo93cvclgzHcwwAj1XlOkWB28B0uhZQFYoRwEzHGUxKcvwRwuaPB3TdAkJJxUb1uil8Si4jul
	nL1S9ckg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5a-000C8u-2e;
	Mon, 14 Sep 2026 19:03:30 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	Sandipan Roy <saroy@redhat.com>,
	James Burton <jamesburton@meta.com>
Subject: [PATCH bpf v2 05/11] bpf: Don't remove indirect jump targets in the nop removal pass
Date: Mon, 14 Sep 2026 19:03:20 +0200
Message-ID: <20260914170326.249953-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170326.249953-1-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28123/Mon Sep 14 08:24:19 2026)

bpf_opt_remove_nops() drops every ja +0 and may_goto +0 unconditionally.
A gotox target may itself be such a transparent nop: it is a verified
entry of an insn array jump table that is reachable at run time through
the indirect jump. bpf_insn_array_adjust_after_remove() marks it as
INSN_DELETED instead, and bpf_insn_array_ready() skips INSN_DELETED
entries, so the program loads with a hole in its jump table. The x86
JIT, for example, lowers gotox to a raw indirect jump, so executing
that index jumps to the zeroed ips[] slot, that is, to address 0.
Fix by keeping an indirect jump target in place.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Reported-by: Sandipan Roy <saroy@redhat.com>
Reported-by: James Burton <jamesburton@meta.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/fixups.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index f3cf66b8147a..aa3fb7b87fb0 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -599,6 +599,7 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 
 int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 {
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	bool is_may_goto_0, is_ja;
@@ -610,6 +611,8 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 
 		if (!is_may_goto_0 && !is_ja)
 			continue;
+		if (aux[i].indirect_target)
+			continue;
 
 		err = verifier_remove_insns(env, i, 1);
 		if (err)
-- 
2.43.0

