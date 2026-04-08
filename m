Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F903AD539
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662645; cv=none; b=gS8Elh2FeV22fx2HlGF0Nsp9gT7heUNtKsra+AW17+8r/bIh1DRPVHR8jpLB+EAQclXhWA1A1pPHRWFRIIltlS5JUzrJ/abtuvtBZCvMKFZi0W2Mr0Vf797aRQDjb18XD6VrrK6PYoNh0+3sQP6IePs51WE2/z+aIgyXupTB+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662645; c=relaxed/simple;
	bh=MqChf+ALn1FjIp2Md1NdOC0keWiUSyKNhOFB1yLkyMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6RQxPOJ9x+FyyGYqrwB2HUKwz4oMmCZJBKeUoWR/eCNh7mRYVsoJhixUN3VRUUMFKH1o+gVxZEv0boMExuZIg/X0qMZlK+iDHfgychvxnnoyt/QciMY/ErAWgQD3JhlCBEf7Dip1ZMhsg8216Itb1FozFy97rQgD0ZNzYEusjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=l6ZHtOsB; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="l6ZHtOsB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=3JOOoTlTr+JJCa8rsgtHIt6k7WI9k2JPCT0HgTU0IY0=; b=l6ZHtOsBC9mKV3bc0Sf6HPHp0R
	qA9e6lLnEPxBdJW3FbKggoIdHOdMIm2m2BLwiFKxDymWRdKvozLC8/iIPBARplEgFkkF/IjmVP1yp
	7y+1V4yFs0J7jKe4lSZCgQEne67LxajNsYw4dvk8hpsm/eyL9VBALSPQkNLkV1lZ0eGRa7R79bPvI
	mVIpgFZq9saNCYl43zvZtxA+8TVtti5qVbPbmtimQDNu3b7ClR+N6wJa3qFH/eCrV9BJOoqbMcAt9
	fMHcIJrengJfTxsYUkuHKCVBENqd9+HOtDJbjWKLWDM9dxTtI2QgoBZ93LtFyN4qEqFuD7urVfXH9
	KGpGuLUw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAUxt-000LUs-1F;
	Wed, 08 Apr 2026 17:37:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next 1/4] bpf: Propagate error from visit_tailcall_insn
Date: Wed,  8 Apr 2026 17:37:09 +0200
Message-ID: <20260408153712.523124-1-daniel@iogearbox.net>
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

