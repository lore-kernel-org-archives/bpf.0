Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CCB67E
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675566; cv=none; b=sWmi1aIpl+hm3lQwq2SXnT9wbRIJHpd5+Ys2ZWpCzyvjqorxC+Yv2Yx0u3bzVJjzgtv+iLB+w5KcrHs5MEdYW9TwKuLePUnMiePppm17hwaVSHJWdqAbMnjwBSBnouO7aHaACy/fN9DTXLQbagTEawOZGkcg677CmiJXTfrpIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675566; c=relaxed/simple;
	bh=MqChf+ALn1FjIp2Md1NdOC0keWiUSyKNhOFB1yLkyMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6OXt+8Za3UrAd49xjv+dYSem3cTYYQSuO5030smYPP1xL5V1/k1QYCKq8fUsYvs/vJOTtSBcaSPpNL5ExkFAZ7mgIYj/xPZgs53Wft4GwCoL7m3U5koRUMRb3DBEG2eRX5ZaFoAVJZnbeo8OEXMhpFYEjwg09fpv0235tjMRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nB82acp3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nB82acp3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=3JOOoTlTr+JJCa8rsgtHIt6k7WI9k2JPCT0HgTU0IY0=; b=nB82acp3NsupeaQPhtnq66MBNP
	dF3f8NmfKeGCz24Z7pV/xsJ+VjabYnQ2HTov28FN64DEh6im90xOdIC/NbH0qLWfnel0VtDpQKotw
	NaFKYAkKCyjxfYE6BWYP7aLZZCy/bz+4zMmnIUtQBT4WBhzuzH7Gq5ZuN7bfEuNOJWOCMSq1x+uo7
	6gCgUP3IZ3jOpz11dTjGHYY/H6zekzSVH85EADcEZbEv58Pb+x/ze6o9dxNySZ8pE3bnGyfVz4tXz
	yeI0Mom2VKPFkxO6i2KvQu8cNdZ0rTz3eqlG5NRgQ+HIaH0on9c5URQLZfLr9rZ7+xu+kp6AouK0g
	sdlWO7eg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAYKR-0002Nv-0S;
	Wed, 08 Apr 2026 21:12:43 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v2 1/4] bpf: Propagate error from visit_tailcall_insn
Date: Wed,  8 Apr 2026 21:12:39 +0200
Message-ID: <20260408191242.526279-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27965/Wed Apr  8 08:24:37 2026)

Commit e40f5a6bf88a ("bpf: correct stack liveness for tail calls") added
visit_tailcall_insn() but did not check its return value.

Fixes: e40f5a6bf88a ("bpf: correct stack liveness for tail calls")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 594260c1f382..db009d509ade 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19355,8 +19355,11 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				mark_subprog_might_sleep(env, t);
 			if (bpf_helper_changes_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
-			if (insn->imm == BPF_FUNC_tail_call)
-				visit_tailcall_insn(env, t);
+			if (insn->imm == BPF_FUNC_tail_call) {
+				ret = visit_tailcall_insn(env, t);
+				if (ret)
+					return ret;
+			}
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
-- 
2.43.0

