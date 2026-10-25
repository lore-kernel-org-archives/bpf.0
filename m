Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792926251;
	b=Dch3v3eACBpiOzJQ3KHsN4nH1DEDXd4WVBbDA3jfO7jaTO4JrGsAIjPvBN8bkvFKxdif
	 GcFsjUthi8cvBXb4yniRRs3YXkqgOGVRhr5p8sJ5c+FoFY/QQwKNGzbZ+aLTDRt1Sv9uk
	 ueFzQpb1pAEDKW6jd/4sIYkXbWEOOXMA6bUQsSHGiMjS8lSc4uF/Fkib2rJI+pyI9CurP
	 shwxRwdiX2SDQcl87BxYc7YAP8QZmz3JhPztRMIFboe2uX2RwJ+QREhUo0Q8vcFJvC4e6
	 Y8UTEn8PSKRL8Q+Iu2fNW+7/eoVIxfIP+p5/kfLWmR8jpfoM2CW87wPrfHM45upssqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926251;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ISuBoUvMJ7kEOnnLWzxJks2SuDZwYGjQZJJOiq9GIfU=;
	b=zO8XAfR75qZc6meHj/B4eKLvAtkL27S9xm8/iQ/hujRp/TCIveA34oSFWRaRO8DC2CCK
	 3Z16FoO1JG24fg0xwkSb4lPLNPa1IQWRnP3xLs1eUQ25NfSVAhC0N6jHPYocHVZhEENIV
	 T6W6o8yywNBGN/1nRW0IFxi/KBxdx9vEsnCIocV/011kQDuiC4U3yQ4mIb8t+z8yj+dsg
	 D+7sk9/EyyZ5jVdDc2Zdt/G6ApEbxI2Xzi4ytVlysG/dR08YkLMf3f8PW6Fy0sgEweg4b
	 7x25z7LQXWOeI4jkuUm3mBZVtVhl+NmeJTi5/9Ypqf5YgHAzprjOnQyww7WJkH/Nz6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgS9Gnag;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21244606A320;
	Sun, 25 Oct 2026 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgS9Gnag
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792926245;
	b=cDGEu7HVkh/nV0lIcfZZAc4gDkZk0DRpamesdHGYBSJduUJoCIOfvUyQQ2bsy2yKAUrf
	 we7OvrntBxe0LLn/JIM325FeFz8Y2+EFO3zzUpjzNwm0T5VAHDYGmXLvRgGcn+v2X6m4R
	 mJLdnvxe/u7wvwR9o0cYePLc3Iopb/qnYb0sho0i3CiCl8xz40RHVqwbH3l9VaxwIYNu0
	 VD2hJjy1+Jx+cgIEbuTl3wxswpezI3NpL9VYFBNK/AEfSzReaexktLQITl7KMnJPFMDBW
	 omSwIhenyMn8SAJDefIQPrewBt940+ATyG2/STReSXv5MmchzKsbrtWUKcda9o0bmuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792926245;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ISuBoUvMJ7kEOnnLWzxJks2SuDZwYGjQZJJOiq9GIfU=;
	b=qguA+Z+O8EEBPeDwco6f+HBwwV963+Skn7gbusydN5JsQCn3azl8pKpgkGRme7XyMuGs
	 XB4//7ykO627/hQBYY7MXWAbThQDHNOAgMk5WF5MpL1Qun+J+2mx2SiuYhntoytWCnJzs
	 wOZGRqo+x+jI5NTVDGsihLd5HBgmk10v9e0c2R+/JBlZiZEJa50jENmWiaNHeTKAHyxt8
	 t9VmHb0sr1ZCebcaaE7KfH7RCHL5D550wYYL/tcGEP4V07GU9P5oNltnGlaWrQ/T5R8TY
	 jR31MgMK+CmdhzzTwM4FrSy3MllUx37y0TS5y2h+XUveGobRLUh9/RksRB7Fd1I+rTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8F4A61F01828;
	Sun, 25 Oct 2026 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792926245;
	bh=ISuBoUvMJ7kEOnnLWzxJks2SuDZwYGjQZJJOiq9GIfU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XgS9GnagqR1ifM5j3z/6PnsICs3XEV6r4nDIDoJwwcrIJ6d3JHj9qqN5RVWyE/oSa
	 WXFrF4guytrzZNrjE8Z/mQzzaXnTiFZJXbN+H9vA1S7PGIQjXviQ2c0bnuPdn39p7a
	 4VU0IxkB11MysUnxcyjG5o9aE0CauTU3SScaitEWeXZfV4VQEreblrngsiUL9W1o7Q
	 6WlE1NPOFw8PLatq5/lILFmyWsV88BkKCnrBWqZd1Lquri1MvBMsq9s5A+ynMgKrQe
	 CKTmTCwRO/Tb65xm3BPCwA/wQMJEM1nD+EIwPz4GBim6JvS4b4yodbwtVcohJStC3f
	 kQzEGEdZe1teQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F3729449B4;
	Sun, 25 Oct 2026 11:04:03 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org>
Date: Sun, 25 Oct 2026 13:02:58 +0200
Subject: [PATCH RFC bpf-next 1/2] bpf: Keep recursion-checked trampoline
 programs non-preemptible on !PREEMPT_RT
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
Message-Id: <20261025-b4-bpf-trampoline-preempt-v1-1-198dcdc0c6ac@sentinelone.com>
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
In-Reply-To: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mike Bazov <mikeba@sentinelone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792926242; l=3369;
 i=mikeba@sentinelone.com; s=20261022; h=from:subject:message-id;
 bh=im30M5hxZEzaHqyEhAAnmhe/8ENnb4qNYKDcXtbtVVo=;
 b=GrLfHA1TCeRD1/d8BI/1u+pE6udJo7/utUi8Et3C/aczd72dGCkpJjvj6+21yG6GPVJsVToff
 tgyp5k/12nuBMhR/8xDWMNTdHniBbK+QYY7GABsqk2+s73MsjpXNA9f
X-Developer-Key: i=mikeba@sentinelone.com; a=ed25519;
 pk=DBXcQ0qoCkgacRsRwT1JU7oOWpWSYuTyLiXMfNLcP+A=
X-Endpoint-Received: by B4 Relay for mikeba@sentinelone.com/20261022 with
 auth_id=1284
X-Original-From: Mike Bazov <mikeba@sentinelone.com>
Reply-To: mikeba@sentinelone.com
Content-Transfer-Encoding: 7bit

From: Mike Bazov <mikeba@sentinelone.com>

__bpf_prog_enter_recur() acquires the per-CPU recursion counter
(prog->active) under rcu_read_lock_dont_migrate(), which disables CPU
migration but leaves preemption enabled.

When a task executing a non-sleepable fentry/fexit program on CPU N is
preempted mid-program, prog->active remains 1 on CPU N while the
preempted task is off-CPU. Any unrelated task scheduled onto CPU N that
triggers the same hook observes prog->active != 1 in
bpf_prog_get_recursion_context(), increments recursion_misses, and has
its BPF program invocation silently skipped, even though no recursion
occurred.

Before Linux 7.0 this was mostly masked on distribution kernels that
defaulted to PREEMPT_VOLUNTARY, because non-sleepable BPF programs
contain no voluntary scheduling points. Commit 7dadeaa6e851 ("sched:
Further restrict the preemption modes") removed PREEMPT_NONE and
PREEMPT_VOLUNTARY on x86 and arm64, so every distribution kernel now
runs with lazy or full preemption and triggers these false recursion
drops during normal multi-task execution on the same CPU.

Simply switching prog->active to per-task tracking is not sufficient:
since commit a76ab5731e32 ("bpf: Find eligible subprogs for private
stack support"), recursion-checked trampoline programs also rely on
prog->active to guarantee exclusive ownership of the single per-CPU
private stack (prog->aux->priv_stack_ptr), as well as per-CPU scratch
maps.

Match the guarantee already provided by kprobe and classic perf
tracepoint BPF callbacks (commit 16718274ee75 ("tracing: perf: Have perf
tracepoint callbacks always disable preemption")) by disabling
preemption in __bpf_prog_enter_recur() / __bpf_prog_exit_recur() when
!IS_ENABLED(CONFIG_PREEMPT_RT). This preserves preemptible BPF execution
on PREEMPT_RT while eliminating false recursion drops and protecting
per-CPU private stacks on non-RT kernels.

Fixes: ca06f55b9002 ("bpf: Add per-program recursion prevention mechanism")
Assisted-by: Devin:gemini-4-argon-high
Signed-off-by: Mike Bazov <mikeba@sentinelone.com>
---
 kernel/bpf/trampoline.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index bf4cb3dd444d..632c104112b2 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1339,7 +1339,15 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
 static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
-	rcu_read_lock_dont_migrate();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		rcu_read_lock_dont_migrate();
+	} else {
+		/* prog->active and the private stack are per-CPU: don't let
+		 * another task run on this CPU while we hold them.
+		 */
+		preempt_disable_notrace();
+		rcu_read_lock();
+	}
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
@@ -1388,7 +1396,12 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 
 	update_prog_stats(prog, start);
 	bpf_prog_put_recursion_context(prog);
-	rcu_read_unlock_migrate();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		rcu_read_unlock_migrate();
+	} else {
+		rcu_read_unlock();
+		preempt_enable_notrace();
+	}
 }
 
 static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,

-- 
2.43.0


