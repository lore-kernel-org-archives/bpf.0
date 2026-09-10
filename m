Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C258B6A8
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066570; cv=none; b=qAEbVFazjGWpQI2ldF2459nMKnrgROEWx3EyhIoi8PXDI7ykcXDSmhV1Z/FO7jynbYVLdaS2KY4+M+ZVph3M+U0u2ehku3FFShtrXop8GXIINHgxBKlq06DvpxEasWpEz+rg45DDwxOU8/e/Ix4j6G1wAQKtIpVt7h1s7ZkDAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066570; c=relaxed/simple;
	bh=JQ998THgG3JSYDErd8o5Rly6uWLnLuDaYV1GoE2uXTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fykvwWVhGSB+2kbs4AQrsQhkLIsmmWlQVqhcvpZv9M1q9JGtrwu9MYFbQ9jo5BBCdfO/kyVJjbvRVYSPgiJx55yKifzfXT5sGggbpJ+mzX3xzQ5Bx/w3iI3TP+DZHOfNR13mUV00aylwNS/VSYLKLnfB0mXOxvVnf9bh1v04sCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=S7yTtV/K; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="S7yTtV/K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=hPM9dJKTrcfB4wA7wyRnQ/pyVzbcTL8h598zq1LNmK8=; b=S7yTtV/KgLKRwtRSV/zyLCZLZ3
	KoFWfurp8T9t40C513JYMPWggVsgr90uasEsCUQ6BeeFQOQlpwp3vSJB2p71Q5UamwNVEzyXljivp
	/uYEs/5JWOUT6J2KR5/CCL/C5nP83cmzzPaq9X7tyhX0A+vzVgAvBp25uTT9KNAXRYXG+xmKasDLL
	oVAKCdgFFxVLc1haxQBBsuLhkf1yfl1UuB+ijFW5uElYToELedFB0+ZdaRvJJ0/wKEhv+bPaNhjo4
	+hsnGrFqs8fhEQIX977PPrfXERddAy3YOaq2V6R51o0QxwRej5JJk2HDnppiL9RvSs/7j9guBxJvr
	RRKapzxA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4jwK-000Ezt-39;
	Thu, 10 Sep 2026 20:56:05 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf] bpf: Clear scalar delta on narrowing stack spill
Date: Thu, 10 Sep 2026 20:56:04 +0200
Message-ID: <20260910185604.44949-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

check_stack_write_fixed_off() breaks the scalar link on a narrowing spill
by zeroing the id of the destination stack slot, but leaves the delta in
place. save_register_state() has just copied the source register verbatim,
so the slot keeps the BPF_ADD_CONST delta of a register it is no longer
linked to. This is the same shape as the case addressed in 1b327732c846
("bpf: Clear delta when clearing reg id for non-{add,sub} ops"). Unlike
the latter, no miscomputation seems reachable, so mainly consistency.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 [ noticed while reviewing clear_scalar_id locations ]

 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45234e2fbee6..3eb20e54eced 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3582,7 +3582,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (!reg_value_fits)
-			state->stack[spi].spilled_ptr.id = 0;
+			clear_scalar_id(&state->stack[spi].spilled_ptr);
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
 		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
-- 
2.43.0

