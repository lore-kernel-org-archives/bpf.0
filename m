Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313126;
	b=Ef4CN6pStlQYE5gmRDWLjLKMdb3esVuKYMvOL0Nydv3mbrYohvoh3H6Bq4FKjmfZATkL
	 4Qv3/4x4UygN/A/AADAaRotv80kr1gvn5+xSqTumAelY/c0dTRpsHyuQRge59QEtzVPcS
	 YBTQ2gkXSzU65zmw6MQvAK2OPsDaNmSoI83mWKDhkr1YkSgJs24u6hgFpLgiWvZaM+2Na
	 BIrlalQFzvb715ftW+p/KHCf0ol4Kbp9i4FghjYs+w47sFuLRbbS5egYLgX0tMuojuzlu
	 ncbdaQaL9b9Yyjlxg+ZXde/IVivaYp5hfRFRT6JBMT0fUEf4iAzSv7oPEBCQ0thxyXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313126;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=PnZdqN7YVfod3XTPPe7pH85dZfOUEl0xdGXQRdrN5P0=;
	b=hPXKLlhZnEHfy1JqVhsZ9B4E255UngkSoDwuXAZIaZzT7wDToj/uzjFbg58IO2JezXmt
	 q5x8PkC60wZdffcEbu5bXz3lnzei+D3Jd4S6W6odooWDHzyslzsqcgXz+Xkcfdf7A2H/a
	 J+biQeD22pj7dr0oLo6FUQM2k0YtkQ7FDCBaI5BTj0e5ouVIRCqc4dlZIessqt98h0tHO
	 jYvyZaaozNDfQjCZF41+S5iXxG8zzt6cwYeB2zcTc8JfleboxQYo6WFucsdu7kaQ/VAF/
	 yGm/Yx31UqwaGl6WUFphDFMSc5v7dV2dNjtERts7LEM1X+U3S2/CnEwj+abCu1MULoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ELQZ59BG;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC7606A321;
	Tue, 10 Nov 2026 12:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0CC7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ELQZ59BG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=PnZdqN7YVfod3XTPPe7pH85dZfOUEl0xdGXQRdrN5P0=; b=ELQZ59BGDHyPKNOtS9iVkmf3+b
	yMQgWP7nx5/NJ7FuTpUHOKQabMJx9NBYZQo3W0iGwgUMy0tfGjZARgTEHmAc9gUepVSu4JKS4pFgg
	o9N/5UGZxCgJe9+yvhMXvyTljfkUzclCn45BNte1VxDWVmZb7yHKc/AtzNNM6XdwNJQSrA+Zqa7rc
	f5dhQEozCol2AYbIg/uehfZzQN7LeZ95aFo/f0sfA5y0+UPCrly0XsNTb3QIbiWhWPd+PHpnwjpwU
	SkH9UgZ01XwPSLR2fTx/qK4h4Ypcc795gOMnjmCHbhFeUhnqe2m6N4Dv4p/ricvr7UCSeD0fTdOk3
	mkyoRCrg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQkoC-00COW0-2G;
	Tue, 10 Nov 2026 12:18:40 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Nov 2026 04:18:32 -0800
Subject: [PATCH bpf] bpf: Report RCU-tasks quiescent states in do_check()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-bpf-verifier-rcu-tasks-qs-v1-1-99e8f798a6dc@debian.org>
X-B4-Tracking: v=1; b=H4sIAJcL82oC/x3MQQqDQAxA0atI1gbMFAV7ldKFM2Y0CNYmOhTEu
 ze4/Iv3TzBWYYNndYJyEZPP6kF1BWke1olRRm8ITeiIqMG4ZSxusrCipgP3wRbDr2GMbXgkyhy
 5B/ebcpbf/X6BM3hf1x9kO+LrcAAAAA==
X-Change-ID: 20261110-bpf-verifier-rcu-tasks-qs-bb523c1febe9
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 paulmck@kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=leitao@debian.org;
 h=from:subject:message-id; bh=njfHvcNv1uYoTbhkRrJyJ5ytQ82fBSWXSapr6BPDnSk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8wudQKG/DG+AgSbgzvbYLgjtdkL3lYMKEkb/T
 5qkL3ncjDaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavMLnQAKCRA1o5Of/Hh3
 bTaVD/0awCdqrFDDQHZAptK18QmBaa9NqSONw90EjgEj1fa8q9vabGu6t1TEyzQKlP4l2e0V/U8
 RfrYeZ9Tm982dJXr0svu6Vr1FlWZrsffB1JHZbUcnZM0eslMx3tmH3nQRwz2DhTWdde4nQGoSvl
 hNarPoSSwuRw4FCepHzldcKlnri/nx6M4st3QWl3WNywnfA0UL8JcvZXG76Ckt+GLur108mesTq
 JCIjUw6G+CtgR2WBRQm5/oiUhKnitHJ2bdjOXm+Qc82kssvhaPpbEy1qHicOta/fmtcKYJBSmel
 m2j4su7o9CHiq4XdBkYy51epwRpNwhEffa6o5LXU012xCylC5YHSLz+p7xlP5Zvj7ydr5gS3oiS
 +reBR0HtkVW4jaCq8KJIMIZjEEmL2Beco1hn0ESNXD5unBGoJoktmqIDJ5+eCdKfz9givC+Kbm0
 hkGqLkx/A5gaxjxPjgeKAjth1b+Wkr1J08OgapPwM05i7nAjqvByPptXxDQqoJjutVTt6ebTl2h
 8Fpl+BYh8zzu2z+oa6TaYolO2lfpUZab6NWkdYmpZb/EM7VapXR7vERqgVUP0znkTPmAnUPEK4B
 ul1LPBVF9PXqJkzYKsYuR6+plNnFz6ghJb/bC83Qvp5Bh2UvyuaTn+QudZ8kARb5jyakNm2BJUs
 5v+JM2n663ehdrg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

I am seeing rcu_tasks stalls in the Meta fleet on debug kernels (KASAN,
kmemleak, lockdep), where a task loading a BPF program stays in the
verifier for over 20 minutes:

  INFO: rcu_tasks detected stalls on tasks:
  000000000cc1a43d: .. nvcsw: 4/4 holdout: 1 idle_cpu: -1/91 task:GlobalCPUThread state:R  running task  pid:175256 tgid:169948 ppid:1
  Call Trace:
   __create_object
   __kmalloc_node_track_caller_noprof
   krealloc_node_align_noprof
   copy_array
   bpf_copy_verifier_state
   bpf_split_cur_state
   do_check_common
   do_check_main
   bpf_check
   bpf_prog_load
   __sys_bpf

The main loop in do_check() only calls cond_resched(), which is a no-op
on PREEMPTION kernels. Involuntary preemption is not a Tasks-RCU
quiescent state, so the loading task never reports one and stays a
holdout until bpf_prog_load() returns. Meanwhile every
synchronize_rcu_tasks() caller waits, e.g. ftrace_shutdown() of a
dynamic ftrace_ops.

Upgrade it to cond_resched_tasks_rcu_qs(), which reports a quiescent
state even when cond_resched() does nothing. The need_resched() check
goes away, as cond_resched() does it already.

Fixes: 3c2ce60bdd3d ("bpf: adjust verifier heuristics")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e4700fda66b9f..232551fd7cefdd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20627,8 +20627,7 @@ static int do_check(struct bpf_verifier_env *env)
 		if (signal_pending(current))
 			return -EAGAIN;
 
-		if (need_resched())
-			cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent = NULL;

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-bpf-verifier-rcu-tasks-qs-bb523c1febe9

Best regards,
--  
Breno Leitao <leitao@debian.org>

