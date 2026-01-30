Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E2341660;
	Fri, 30 Jan 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787984; cv=none; b=MrD4/JwVbkJtV4Go+u6q6zyA4gj5oZxzpJB/JdeZ8lx6Y1IkpkpPIVY/4CtLy6vebWvsFcu7GcVNbQIrkQ5CO7GYHnVrBvgLTULSVt9uFZinjKWnXdOSucu1qjhZ/qCiakooi3uSAAKdEYf6p0PVtCEI7z51BsPCfwnMxLTKIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787984; c=relaxed/simple;
	bh=JInSuttsgS1tOFQAYgB1DjT9Hw8RRyZ3iLDPsXSvK0w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m0PvceDAseR7txz5bVs8Z62hshXKXqg0YC6PrB8DuX8o5eEk1c4P0/DiLh3SvoW3e1hruZ+2K2X7zHY/zqkoXvzdxknWS7YEUA0Z8HrN0C1GiuM3ZY0tC0w01jFGyg5eb6fkaa0p6j1AP9f/NG3Z8sENetwM17d8SwZV6D4azDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnmw/88h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnmw/88h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F89C2BCB0;
	Fri, 30 Jan 2026 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769787984;
	bh=JInSuttsgS1tOFQAYgB1DjT9Hw8RRyZ3iLDPsXSvK0w=;
	h=Date:From:To:Cc:Subject:References:From;
	b=qnmw/88h5fWh/+pFStNKkfloWOmKCbCsyEbL3Wusb2BNawUGAOOQguUGWqfChMllO
	 GC3IIF2BUYSMWEvVqmWedT/cCandlgG/5d2UcZui/mGl+20qVbkoYLYjTqW4Q3gyqC
	 pipgPHqFf3K4nPx9jmcSK+uaevNL8rzcR1pMPURgtUj7aBXZARHaDDjaZIxbtUKd0C
	 bwzCnxoguz3YWqy5wZk55/A7pLSoREYivoBBLFV4PV8uEobquOnhVZHN7n/UJAY9GE
	 qICejj8HgL54hfWHBwefU6R31onsfD4ExuGpb2Gw7K6HniCWTh8UawtMb6BIdjGkqJ
	 FYio/NLXXgvmg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vlqhk-00000001gVx-07rK;
	Fri, 30 Jan 2026 10:46:40 -0500
Message-ID: <20260130154639.883617005@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 30 Jan 2026 10:46:10 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org
Subject: [for-next][PATCH 3/4] srcu: Fix warning to permit SRCU-fast readers in NMI handlers
References: <20260130154607.755725833@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Paul E. McKenney" <paulmck@kernel.org>

SRCU-fast is designed to be used in NMI handlers, even going so far
as to use atomic operations for architectures supporting NMIs but not
providing NMI-safe per-CPU atomic operations.  However, the WARN_ON_ONCE()
in __srcu_check_read_flavor() complains if SRCU-fast is used in an NMI
handler.  This commit therefore modifies that WARN_ON_ONCE() to avoid
such complaints.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
Link: https://patch.msgid.link/8232efe8-a7a3-446c-af0b-19f9b523b4f7@paulmck-laptop
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/rcu/srcutree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ea3f128de06f..c4a0a93e8da4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -789,7 +789,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	struct srcu_data *sdp;
 
 	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
-	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
+	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
+		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
 	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
 
 	sdp = raw_cpu_ptr(ssp->sda);
-- 
2.51.0


