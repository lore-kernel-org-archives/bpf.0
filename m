Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD133C345F
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047685; cv=none; b=c/H6vobX9QxX9cCT61drTmd8W9wowGSXClhDE5UDgVvn5mfYAjzDuYi9KwcFAAo/0lcvv3f40swIz4ko1/HGr4oGlrceH939ZbG6nJIwl/NyD5lZV86PmFvbmc8kM9PzVWnCACP/p7C4pJTcoFqLeF53erMHI9xfB+5IR/kYjFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047685; c=relaxed/simple;
	bh=Qv8aseMka3dhCo+avANhm+gQuodimzdnodc/tXA3sgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGMSS7478OBFJPQgIlGrm4i1XykHsqs9Wd9Wa9FEYuKwzhR2DbyQDtIvTxwvZFNLoT6tn9vniGGm20nSpXwtfZIHHBUpjaPnPVkGnIEEMiDa/hTdFV84pSV6hr7h88UnLmQBHSZ7ZQrxxg1v9rdvGsUFIl2zZY8/w92l1IplGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZESG+Upc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZESG+Upc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=cyiiv9ZEY68WUbFHBQNbiYl1IEjmi4sXkVsAmcUnh3M=; b=ZESG+UpcQ9dwicA4SY5xB5vmfG
	UCoiIQrvfdXSUEP3Jbbz1XVo9XSVDeAlaBUL4bHgv6SYvK5mu1hmRFz9S8sVTSA86Y2zvKyaUA3+H
	oyhAAt0zDBdbfufMnp9FUPxSOgrKplgAX+V67olJS1emmykKruy78FC+fUiJdTeoH4AvzE9MtCbHB
	xHcMnt387IcIwMdfL9xxIyt4j3qE2CxFdCKMVbsnCMFgx2VsKzJC1dAXnUZLLLH7cv0oE0YRwqibL
	NXr9oBfO3DgI+H8ETQdSNDE6pnaKtY7FgtDuJblO/JFPy50pLuCHgZVb+m4+5UubJ0QoNz+JdaW4T
	jArXuMFw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wStiR-000LAI-1a;
	Fri, 29 May 2026 11:41:19 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kpsingh@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/3] libbpf: Drop redundant self-loop in emit_check_err
Date: Fri, 29 May 2026 11:41:16 +0200
Message-ID: <20260529094119.307264-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28015/Fri May 29 08:24:51 2026)

When the cleanup-label jump offset does not fit in s16, emit_check_err()
sets gen->error = -ERANGE and then emits a BPF_JMP_IMM(BPF_JA, 0, 0, -1)
self-loop.

The latter emit() is dead: gen->error is assigned on the preceding line,
and emit() then bails out early in realloc_insn_buf() the moment gen->error
is set, so the jump is never written into the instruction stream.

gen->error alone already marks the generation as failed. This is a follow-up
to 7dd62566e0d1 ("libbpf: fix off-by-one in emit_signature_match jump offset")
which removed the jump in emit_signature_match() but not in other locations.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/gen_loader.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 9478b8f78f26..7b95ced7bcba 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -293,7 +293,6 @@ static void emit_check_err(struct bpf_gen *gen)
 		emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, off));
 	} else {
 		gen->error = -ERANGE;
-		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
 	}
 }
 
-- 
2.43.0

