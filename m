Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693F30DD13;
	Mon, 26 Jan 2026 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769469173; cv=none; b=tV08+zU5rEIdZHkYS8KcgYq57+LIVttAMywDvFkV3xW2DjNWwlDtPpPoMMh3TcrSCrxWAvNHkooVIB81B5gRbtEoAERyIsXqWNwPzBAJgTcwXMq/teh2stv9szsM21IOtBnpfESAF2cwWJ+iSBthSRdobibVBtqG1S7e5DVKT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769469173; c=relaxed/simple;
	bh=elb0itkw64ruXAZKFW/E4Sx35NGysHyhNQC3sZzrV9g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EQQVrENNm8iiTFGKECJqD0uTkp3/IYczyB3rCuRniuFUozD6RodPdBvNqyxN3+LC4MiFhIVNnv28NWd4IPxCC5Bqx5HIslPEQQlbmrzaEdX8vbxD2I1GT+t9Jd8NS1oa+g0ENRF7qb4FuETGPqC2Wwr59JQlLm3Phcm7PkztFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoCqedrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoCqedrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A72C19425;
	Mon, 26 Jan 2026 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769469172;
	bh=elb0itkw64ruXAZKFW/E4Sx35NGysHyhNQC3sZzrV9g=;
	h=Date:From:To:Cc:Subject:References:From;
	b=EoCqedrEyyTba4PHYbIt2s2AyKHJMJy5wldmgiA3LOVRjx8ofW8hgsx56VVwjAJNi
	 CgFZTkeb2/SHIZsjm0FwNS9kiHXVX8/QDHQePKvK1Mi4YkXEQSlfGeKU+3P0DqQ3Me
	 mV5tcC+QYR+x3LcDdqiBSMLhKyQC6o9gvvpxsz2615E+n2rFl/vxfXwXxJKcJetS2C
	 FHXfb9gMdfNiLY1u8IYseJFI9JyJ377mJ77GOkzRcqlS2qRTINLEcech8WNGMIrkNJ
	 q+nZYemJDm14tp8hvnw7qtAAa9FdGGf555wFZXhAejnDR9GoF+JCSepzlQcXC2E4oq
	 Tb5mmznQ3Egmw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vkVlQ-00000000C0I-1KEO;
	Mon, 26 Jan 2026 18:12:56 -0500
Message-ID: <20260126231256.174621257@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 26 Jan 2026 18:11:46 -0500
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
 Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 1/3] tracing: perf: Have perf tracepoint callbacks always disable
 preemption
References: <20260126231145.728172709@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In preparation to convert protection of tracepoints from being protected
by a preempt disabled section to being protected by SRCU, have all the
perf callbacks disable preemption as perf expects preemption to be
disabled when processing tracepoints.

While at it, convert the perf system call callback preempt_disable() to a
guard(preempt).

Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
Link: https://patch.msgid.link/20260108220550.2f6638f3@fedora

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/perf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index a1754b73a8f5..348ad1d9b556 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -71,6 +71,7 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count __attribute__((unused));				\
 	struct task_struct *__task __attribute__((unused));		\
 									\
+	guard(preempt_notrace)();					\
 	do_perf_trace_##call(__data, args);				\
 }
 
@@ -85,9 +86,8 @@ perf_trace_##call(void *__data, proto)					\
 	struct task_struct *__task __attribute__((unused));		\
 									\
 	might_fault();							\
-	preempt_disable_notrace();					\
+	guard(preempt_notrace)();					\
 	do_perf_trace_##call(__data, args);				\
-	preempt_enable_notrace();					\
 }
 
 /*
-- 
2.51.0


