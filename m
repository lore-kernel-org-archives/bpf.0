Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01E4C7523
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358777; cv=none; b=Y7xVUQMxuZQWSAcIW8ry5uZq9e8S52C8Xm+t1ct451JBPvZd7GV8LOP+BjpfCS1qy4Ne2wnD+wT4xRlKMwnFYhF5eRGWMsc9FyhXWSbFHn7abLs5dnqeCOxNYRFKzQ6VVQvk0PXUBtzIds1GvVUuxvlkbrUs0Xl/qS1U97oMI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358777; c=relaxed/simple;
	bh=mT1atRYIL4PVO2hM2sh/uizw3vNDbmSvcYLjHEoAmzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmcwFWpasrMMcxpSZCwQs5HoODMikx3gUYvxx4I8os4GXgdnGfr5y+3F2Yr7Z2Cd6F2nvLFdD0gX1uBlASr+QCIbO/Ep+eQbEGCDTecoI/aRAP/EPA9ITTeJS/wLekFwVlz3DulYWAvtiLpVmFLW2cWWtd5POVVW+D8Id02uOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KV4ggqRL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KV4ggqRL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4rDIbU6MwVpf8mMWOqDIQwu0R7F4NnE/NtokcicJIDU=; b=KV4ggqRLQJoq0CvKMhW4wF2mzi
	OTXUH3+vsWLZlhzdf/lBiQW3o1sZgOtask25Ht1mV/L82HcFPWQKR9H+xeYvdGiW4G5LgzRfze8vf
	uSvDd3e7/v4aAPfJh48ADaFdIOcIBEuBBv99FrkCTWNXdRzjVwVJ7pjbnVBYvkTUeH21miOEPRH4a
	RAwr0uG/F6Sg4dHdiqQ6ndB6JQWmR76e3harhOLGeS9c2IKUudyA4YyDLpvLJo9SMRm/UoJSV1C6v
	a3rK5WpWWQARJQudr9MWL3UQgTDM2A2KoGeDjwX3KDAdolmtFjxZ0wFMgL/B4VRSSTsD4xLCJazb/
	0n4uEmrA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6L-000JkB-36;
	Fri, 25 Sep 2026 19:52:50 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Sandipan Roy <saroy@redhat.com>,
	James Burton <jamesburton@meta.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v3 07/16] bpf: Don't remove indirect jump targets in the nop removal pass
Date: Fri, 25 Sep 2026 19:52:34 +0200
Message-ID: <20260925175244.1136329-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/fixups.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index adc254b1a646..d4e54fa42dae 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -727,6 +727,7 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 
 int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 {
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	bool is_may_goto_0, is_ja;
@@ -738,6 +739,8 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 
 		if (!is_may_goto_0 && !is_ja)
 			continue;
+		if (aux[i].indirect_target)
+			continue;
 
 		err = verifier_remove_insns(env, i, 1);
 		if (err)
-- 
2.43.0

