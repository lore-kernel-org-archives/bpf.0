Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425F3AE195
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744392; cv=none; b=XZ+bwfQAkcbWJcBOLG6uUFPR1a0l4hsDYJUOxzG7zZbY+aUJ7AOst3yf7k+hN4gySCzfGEYKttcYympCkN9RV7IH/QGHOd0YJds3oAjn6qlDA+u9XE8YKU6w+rJs/9bGXfoL0RLL32+CngZYeTOsdF32lpA74BRa1e3G4XFbIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744392; c=relaxed/simple;
	bh=cr1O0I0Qt6xys5V/3AcBeShvEjyI53SmIkAK8pjIPKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoK5arRI1geCNZFxWlSD8CgQl3bIKKi8/OEoXTUDjOMu6Dz7ja4diYdICDr0LQTBbjkniGRVs/zT8AqgXJWTv+DnBWwC7WUv5sSJP0iaED0w/dExTPYtGHhlcdl8sU85TliW1IzZGS3S6B32yHMZsbpiyZZhFO/Rtw8ejx44aRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LozN/KFQ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LozN/KFQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BiS+ZhMVoi+LgKBZNj7IAPtAfMN+422Ye53DKA3T3yU=; b=LozN/KFQYVFSsxmOReQGbB1kiV
	yz3en5pJFgEsQ9weB6W+niU2LQaYW4F19X8Eklj1KW/6W2EtgJZ5If3exVTIcIrkRktuu2kmrgzgu
	oPfBjuFN9P144pPVe5ES7VPO06r0HmkfnlcfiwrncWX/K3KQNwOeiv6wuebTg5el4oaw2Q8LJ8qGs
	Vm6BL1UJreZtw6LvnYXELSGhdBGyeR+dVgWI3V5NSfBsX8EeZypv46NmodxDyOAoWRXlwZSZkuOTp
	nAj96f+gqRL9xVFxD2Ol6xJAi7z1oGK6N/I9pqC4QGA5eItOy0LvANuG2rarG3K9P9SQvOvcJqr58
	3kelsfnA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wuzpm-000F9B-2v;
	Fri, 14 Aug 2026 23:53:02 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/6] bpf: Reject a store through a fault prone pointer
Date: Fri, 14 Aug 2026 23:52:57 +0200
Message-ID: <20260814215301.709827-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814215301.709827-1-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28092/Fri Aug 14 08:27:02 2026)

check_ptr_to_btf_access() allows the program to store before the default
BTF access path gets to reject a non read access. ac65c710cc64 ("bpf:
Reject writes through untrusted BTF pointers") closed that for a
PTR_UNTRUSTED pointer, but a bare PTR_TO_BTF_ID may fault on a dereference
just the same and is let through.

A BPF_LDX gets the BPF_PROBE_MEM rewrite in bpf_convert_ctx_accesses()
and a bad address is handled, but a BPF_STX does not and cannot, there
is no probed store to rewrite. The store is emitted as a plain one without
an exception table entry and a bad address panics the kernel.

A bpf_qdisc program can reach this, bpf_qdisc_btf_struct_access() permits a
write to Qdisc::limit and Qdisc::next_sched is a plain struct Qdisc pointer
which the walk turns into the compat type:

  struct Qdisc *next = sch->next_sched;

  next->limit = 1000;

  BUG: kernel NULL pointer dereference, address: 0000000000000014
  RIP: 0010:bpf_prog_c6e14e7f32c8e325_bpf_fifo_enqueue+0x3a/0x12b
  Code: [...] bf e8 03 00 00 <89> 7e 14 41 8b 7f 14 [...]
  Kernel panic - not syncing: Fatal exception in interrupt

Fix by widen the check to bpf_may_fault_on_deref() so that it covers both.

Fixes: 27ae7997a661 ("bpf: Introduce BPF_PROG_TYPE_STRUCT_OPS")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - new patch

 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2e6992569187..6610e2437047 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5789,7 +5789,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (atype != BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)) {
+	if (atype != BPF_READ && bpf_may_fault_on_deref(reg->type)) {
 		verbose(env, "only read is supported\n");
 		return -EACCES;
 	}
-- 
2.43.0

