Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2E3EA967
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466643; cv=none; b=fzmvmNcg2cEjh6PBRcu+umjmxJ81ImDchwZ95ky5v9AK+FF/+k9ZXhzTq/SQPcQ0/uAiI01HLz7oj3zAORtCJqbw4sSSVl1voi0d83gf2v5QI5yu9g5bheme632/BGSOse1H7BFsw0X0GfuK2wJBk/n6yMoN/Zfc6QdwEAKS+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466643; c=relaxed/simple;
	bh=wAdP2dNa9K0OXF4MmUNwh+EUc6Ki9ARACyVNvzD1aYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCs8LlrP2OlqZermLU2mor3FWbHuS6hHQycPJsw1jAkrFM/2iL2dUyDjfynB4F5isFyjak85oTaufskZ5XybZkVGawXEO2vL6LjSJ+5xcVUBWPd7jKyPMWjWP5bpsMFJH7krNr3iV7ITsiUPbrNQD2+0/RAnFfN9DbjeIY+BH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ7aL0Mk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ7aL0Mk"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845438a46d4so328932b3a.3
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466640; x=1783071440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1nVl0CR/TNTjqUh/8bIepselsffkgGeGadN32cKwfQw=;
        b=aZ7aL0MkuKn2RsuAZjFsvSHGLXZjC23y/cftkUyRfdBCNj9KAsJKOpFfi6Ddg2VIgV
         zepuMXNUnqMMNoyOqutYmEzPCWVvJg+G9jU73pkr0e+POQe5BkOSgHTxtBqa/y2CfVPr
         B/4QtG7sC3+lNPg1Bd66wzubpP0n1Yupx+Bxv5ccslvgtKKvqDWg35prhIDicUkxh4+B
         MZ5vVKx4N6u0+IfZnmoIzTZILJS1m42JIXps7auNbvyxhj79AIPiUYkPsnUIZufDld6V
         ci8BadHy81pSbYucmkxrQ2LGvVfMB+4PTb75qKnvtmRmvK+6YRaVG7mR8aBfO2Sziy7d
         JpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466640; x=1783071440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nVl0CR/TNTjqUh/8bIepselsffkgGeGadN32cKwfQw=;
        b=LgNnQpjxs8rLWb80qClkVG17TvpRhiE2+UQz7ymqBVilF0a52fE4QeOSJ0yrG20rf4
         EDaKGToNTBaqMiZfXxzhN/Zv2VXm/C26mEy1N0Wal4YqN6SX2exwqZ+TMbtmkEZF6yuY
         KBId9E/s0lfXqRrjf2biyaA2r/dVIfd+wgUcr+QliscD3Uoq7tUQQ8R5CTku5pOTNLnA
         k893Noz6ctHtnCLEcgOXTblyEu7s25hkZxEVxJHPMO/0e6GkwOy39GBoY0OdQuueaX69
         zrJULFvGzOx4ie/savThKrqoF4FR+56gxrLx25y6MFEqfnz3fvzVtkbHlb9r+pmdW2CM
         Uk+w==
X-Forwarded-Encrypted: i=1; AFNElJ+cLMMBuoqeK40GrNI5W3ikhcOWnHOlkhF5aQ/e9RvzKNqAR+dxrTX5DmzKes0cxmRjq9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaA46mR8zGK+z3bfS7FjOgGeaO6H6qMZILiD0keEnTh2JgsIq5
	Qw8C3rLxz9BTruHdNOxk5XyHtb2uR6G1FyHlvEKUG9zXMzOQqEY5U1plvAxbdQ==
X-Gm-Gg: AfdE7ckRmes3eUe7bUNMkPVGPryGINE84K/JCgYjMgWm0c9EIP0qRDcY2vg6jC6adha
	PZe5iVOqdb6J33Ff6gnznXXFGrES8fhCsgWewz0ks4uM2itn54Sv6e3Q5zbMjBpXHvhp/I8Q7+/
	oxBfdtlxJw6mDmSKpvI3Xe0FaS/zK2VVJfRUa01NHH0HsRaZRR1oUPEc/nqrPB2c7nIm4VPiABv
	kesO/51yQ+AeY2uPavQoVVe8LIsjgFe9xReAseXdQcnM/zk02cLsHAlWnIZtwpHa3qnPNCXCCaZ
	nDz2puvUtF9JRkVmzr8/aF/3Z9KN52qCtCzf1pjW+dUi/jMVTfqIvZhU4xWBmDZSVowomvtyi2e
	yELdYG7R9jMdPQDlsGqs9TZP6m1JBak4lJEFsAZGPk6ffHIA5O/8o6nWkWS4HMtyckkCMVwo2Zf
	rZlDEGo+0ShrunkuuNgwD7eQZ6Ab2MiNFlY2DXBCtCBgrEe6AyhGY=
X-Received: by 2002:a05:6a00:1990:b0:842:4e43:6f6c with SMTP id d2e1a72fcca58-845b3aebd1emr6922152b3a.39.1782466639818;
        Fri, 26 Jun 2026 02:37:19 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a412e5e9sm6335793b3a.54.2026.06.26.02.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:37:19 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: move security_bpf_prog_free() out of RCU callback
Date: Fri, 26 Jun 2026 09:37:03 +0000
Message-ID: <20260626093711.2969648-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__bpf_prog_put_rcu() is the call_rcu() callback for non-sleepable programs.
security_bpf_prog_free() called from there fires bpf_prog_free in softirq;
if a sleepable LSM prog is attached to that hook, might_fault() BUGs:

  BUG: sleeping function called from invalid context
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5038
  preempt_count: 101, expected: 0
  Call Trace:
   <IRQ>
   __bpf_prog_enter_sleepable+0x1cd/0x320 kernel/bpf/trampoline.c:1255
   bpf_trampoline_6442549705+0x53/0xd7
   security_bpf_prog_free+0xde/0x130 security/security.c:5465
   __bpf_prog_put_rcu+0xab/0xd0 kernel/bpf/syscall.c:2365
   rcu_do_batch kernel/rcu/tree.c:2617 [inline]
   handle_softirqs+0x236/0x800 kernel/softirq.c:622
   </IRQ>

The call_rcu/call_rcu_tasks_trace split reflects the freed program's
sleepability, not that of any attached observer.

Move security_bpf_prog_free() to __bpf_prog_put_noref() before the RCU
deferral.

Fixes: 1b67772e4e3f ("bpf,lsm: Refactor bpf_prog_alloc/bpf_prog_free LSM hooks")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 630d530782fe..f14c3f0f8827 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2362,7 +2362,6 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
 	free_uid(aux->user);
-	security_bpf_prog_free(aux->prog);
 	bpf_prog_free(aux->prog);
 }
 
@@ -2378,6 +2377,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 
+	security_bpf_prog_free(prog);
 	if (deferred) {
 		if (prog->sleepable)
 			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
-- 
2.43.0

