Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28F48E0C6
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839630; cv=pass; b=SKciPRrgRzs3LGWAeq3UxIISapB432ooe1gLX1rW1Kt2qWpP0WnHz9N3uRq1CHcRGVf76kJHSfxTHFZ6MmwKE96O0pjnj/mNGY7v3T2WyFK8L60PeywQGXA9YOAbP+PLqKos2ISrZxkraTv1kzz4YhVY0jl3Q3PL2uqgeRX1RK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839630; c=relaxed/simple;
	bh=eJWJB0H9VEmdFvt7JdLn1cb+jNxA3rfMaBb9MNEK8Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7L1nflf7fYB1c5QrzNopPvsTUOfM1UNwGFaFFmSm5Dii0Y+oiBX1mlRg77WOMwi3/p+XGbaHGeOsv+22ikm0Tz5QS+C0O3Yg+xz7sZQlasSO4lHs6WvP9IsOkKl1atDj/XHxvsHcvJ4FQ5gZnxDF2hFlL3F+v7QkS/OmpjM+qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=Em4/zbh7; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="Em4/zbh7"
ARC-Seal: i=1; a=rsa-sha256; t=1790839548; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=Js5gv1tKRCvM5GZJ48x18kZfc1ILec3CSoaoEXg6Jv8aJYA44pfQuNWmvogNL3Ro1B4D/w07GKu2bq8dZhke+JheaxdRM5B9rrjK47x5QNGjQYdikf1oOUzrQvI3eEceufCmYMyltaYsKTnxTjUpvpJHMtuy5DJpvyXiVA5MVUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1790839548; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pyWpbR5qhAlwkofjRKC2L8fa2LYDr/4E5RqDvdpLEM0=; 
	b=NmaznjWntl9KVEe2TmJvZwx57xK2PyqdMg/zAtZfTh/qE8Wc7QUXM/SVesHO8eFAMaLVMWhUJnNbc3S2MiHsFIz3D4wn4PY9kIIVIPTBX/tWLrhdYDoZj+5GrdR2uz2PaoFATPqU7B9+iFnaVif760VgsfepuvD3kPqn7Ay+rJA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790839548;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=pyWpbR5qhAlwkofjRKC2L8fa2LYDr/4E5RqDvdpLEM0=;
	b=Em4/zbh7bltJFiDOJNpuNKBJu6QtGJ6QLrdStMK81z0B85vIGLPAZOX1ESrFIb5b
	xlCFi5aJ3gE9GvMJw7Qfj0DhsgsZfNvrDHYQdzOsvUIOyayKoGRVz5JjB+ftENRsPST
	xJblg0zexbniNZWjP8S3rHYHl+2IfEjPOIa+5fDo=
Received: by smtp.zoho.in with SMTPS id 1790839546031530.9137311836425;
	Thu, 1 Oct 2026 12:55:46 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	puranjay@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [PATCH bpf-next v2 1/2] bpf: Remove nmi_uaccess_okay() check in bpf_send_signal_common()
Date: Thu,  1 Oct 2026 12:54:48 +0530
Message-Id: <20261001072449.1377267-2-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001072449.1377267-1-adi.sharma@zohomail.in>
References: <20261001072449.1377267-1-adi.sharma@zohomail.in>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

nmi_uaccess_okay() takes no task argument and is a statement about
current. When commit 6280cf718db0 ("bpf: Implement bpf_send_signal_task()
kfunc") made the PF_KTHREAD/PF_EXITING and is_global_init() test the
supplied task, nmi_uaccess_okay() was left testing current.

As a result bpf_send_signal_task() returns -EPERM whenever the
calling context happens to be a kernel thread, regardless of which task
the signal is aimed at. The same call with the same target succeeds or
fails depending only on what the CPU was running:

  bpf_send_signal_task() from tp_btf/workqueue_execute_start : -EPERM
  bpf_send_signal_task() from tp_btf/sys_enter               : 0

The check was carried over from bpf_probe_write_user() when
bpf_send_signal() was added in commit 8b401f9ed244 ("bpf: implement
bpf_send_signal() helper"). There it guards a user memory write, but
bpf_send_signal_common() does no user memory access, so the check has
nothing to guard here. It is also already a no-op outside x86.

Remove it, and drop the part of the comment above it that described
the memory access checks, as none remain.

Fixes: 6280cf718db0 ("bpf: Implement bpf_send_signal_task() kfunc")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260819124324.43162-1-adi.sharma@zohomail.in/T/#u
Signed-off-by: Aditya Sharma <adi.sharma@zohomail.in>
---
 kernel/trace/bpf_trace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 195f78db9bda..f6e335a37a91 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -864,15 +864,12 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 		siginfo = &info;
 	}
 
-	/* Similar to bpf_probe_write_user, task needs to be
-	 * in a sound condition and kernel memory access be
-	 * permitted in order to send signal to the current
-	 * task.
+	/*
+	 * Similar to bpf_probe_write_user, task needs to be
+	 * in a sound condition.
 	 */
 	if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
-	if (unlikely(!nmi_uaccess_okay()))
-		return -EPERM;
 	/* Task should not be pid=1 to avoid kernel panic. */
 	if (unlikely(is_global_init(task)))
 		return -EPERM;
-- 
2.34.1

