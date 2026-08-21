Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972E3D813C
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348485; cv=none; b=Mps0in5T7w0d8iZSDUiZoITHjdFXYNR6QQzmA56btdgfDhjvRxu/t2tYdU0m99LH7fprKFg/sCla3rUddPJF99q7xs3fmv6t/UNNO2CY8O3qpl0UkETNzpMz/vqh2c4/6CprdR9cVQZ7s7YiB4XMo22D9vtfLoTdYEPSkp6kxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348485; c=relaxed/simple;
	bh=5GZWTRj7yplohetEmsgkZZyftn52XJ69moZ1IMxtf5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJUs4E19AZo8lBgAf33xBh0lq0daNGA0bx0P1qw7b8cJ5AWiyX45BRZJa5DKEj7O8Ry/xlCqvNjgJyXSdsDeBQR2ccRp1pNUs4yKGXjQ2CE5Cz6Uv54tsrWLs8sjy1AHf7A6dIovpwFfga9XhG5+YiU0gikF2xBnE06ukAzZBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WToRM7kj; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WToRM7kj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=giaGPwAFTktmgiR7kYIsQwUaOPVHTJFYj2+LWiXvA5o=; b=WToRM7kjmlx4Enp7TsQGYJ4NRT
	Kwbkd+u0fr0n7Znfoq3M+Gzplhj9jVw+svhGNSwckm5ikBtvgbiLzzfKbAElop9WiuNmdsLQ++Jxh
	1RSCO3qts6tX5iSiWE2V0P9G+j2xW4GM9UwEHfqIZ49ngFGxZClrgx96QdcKY6MPMn2zFqSwdhHUh
	61H39cIQh96ehkbJsd9qfFuAsWumJObzOXPUoHrJtE4INNYnw02QAFrD6G9pibc/9UnjFE8PgpaqL
	o+AbwapBvewSge/72xj/1ibkFHga1RyY+JyGP/L66WPowSeFlPCgr44Gw/mBII4F4/OcFPblLoxxi
	XJ2ByWFA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzE-000Mq5-1y;
	Fri, 21 Aug 2026 23:41:16 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 06/11] selftests/bpf: Rebuild signed lskels when signing key changes
Date: Fri, 21 Aug 2026 23:41:06 +0200
Message-ID: <20260821214111.1120748-7-daniel@iogearbox.net>
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

The signing key is regenerated whenever verify_sig_setup.sh changes,
but the signed light skeletons only depend on the BPF object and on
bpftool, not on the key they are signed with. Thus, add the certificate
as a prereq so a new key forces the skeletons to be signed again.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5f1a3bfc0569..05b3ee64290f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -663,7 +663,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	}) && \
 	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
-$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) $(VERIFICATION_CERT) | $(TRUNNER_OUTPUT)
 	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
 		$$(RM) $$@;						\
 		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-- 
2.43.0

