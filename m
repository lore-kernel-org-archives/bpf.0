Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F230DD31;
	Mon, 26 Jan 2026 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769469173; cv=none; b=A942lV2DjJ4D1gAzwAeGWA2t+r6XCR7e7EiDDbcbk/g/U2CVFb6GF3RiJdheubfST/hARXU7ZABrfw8wscO0m3BpeRc2cEkF6ZkYv7152Sa8VDNR7BLzCG9xqcdJoH7XSaYTxyZ2btKKtjO0QnZJv6mnCqqVR9G/Zrx/kUOzn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769469173; c=relaxed/simple;
	bh=Btlf+O4AfMiaH+Tpkc8CIcpEHiL8iAmq3ZoEmAb2gv0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fouRd2ciIBiLvdjZ7kX8dP9YE4NjP8sHwrTQR2tPIFWQs42tTJ51V62Sg8DWBHKATT/XozMOAEf6mn4r+aH7nzEWvNFJg/PFTRgOqa28f4it6kpbL5y12tI6JeZy0D7MsDqX73AaL8eEjvCWdM4kgKBoaOQS8aOwiE5Ypc80oAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukLTe/M6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukLTe/M6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41CBC2BCB2;
	Mon, 26 Jan 2026 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769469172;
	bh=Btlf+O4AfMiaH+Tpkc8CIcpEHiL8iAmq3ZoEmAb2gv0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ukLTe/M6RA57QeBDYaGRFsS143CWJq9ZGx48JoI8CVHjJteczIcE3WXi0CoUgstg3
	 Mnd2ec/rv4VJ0r3u945EMlW2uFrZ261gRp6uDLrHr7lu1jLxOvV2cK2F43/dKijglA
	 nPXbBL02c6ygNQRzcgg5kC3m2zxvV/X9n9dPtUtOvimHIxA8r9WNgt/mMgats1Oy4+
	 1asLUClDXL3XStu10IJ77j7aNyqB76rnuj0WaWU3SI0Iz1501QmbVx1USrxCdNEOc5
	 wxFDLql+p/zKj4EoIW3L8V3TRDUMjYHQOMhmlYfouDSfbduhyNqa/l5xfiHQyzVjZM
	 NnTT6IjD7o3RA==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vkVlQ-00000000C0m-20cu;
	Mon, 26 Jan 2026 18:12:56 -0500
Message-ID: <20260126231256.335034877@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 26 Jan 2026 18:11:47 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v6 2/3] bpf: Have __bpf_trace_run() use rcu_read_lock_dont_migrate()
References: <20260126231145.728172709@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to switch the protection of tracepoint callbacks from
preempt_disable() to srcu_read_lock_fast() the BPF callback from
tracepoints needs to have migration prevention as the BPF programs expect
to stay on the same CPU as they execute. Put together the RCU protection
with migration prevention and use rcu_read_lock_dont_migrate() in
__bpf_trace_run(). This will allow tracepoints callbacks to be
preemptible.

Link: https://lore.kernel.org/all/CAADnVQKvY026HSFGOsavJppm3-Ajm-VsLzY-OeFUe+BaKMRnDg@mail.gmail.com/

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/bpf_trace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fe28d86f7c35..abbf0177ad20 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2062,7 +2062,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 
-	cant_sleep();
+	rcu_read_lock_dont_migrate();
 	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2071,13 +2071,12 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	run_ctx.bpf_cookie = link->cookie;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
-	rcu_read_lock();
 	(void) bpf_prog_run(prog, args);
-	rcu_read_unlock();
 
 	bpf_reset_run_ctx(old_run_ctx);
 out:
 	this_cpu_dec(*(prog->active));
+	rcu_read_unlock_migrate();
 }
 
 #define UNPACK(...)			__VA_ARGS__
-- 
2.51.0


