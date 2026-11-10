Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270483;
	b=el45vfqg3YhX/bFHa1cvN/gobxxQmpZwUSj+HZ825JOpOMvxhDW+lX6bXKEKzj2v0eeP
	 lemg1w37Cn8TZW/2ZOIvVmU+bBmMasPPCcDwnFEfbWXH1x6SFJ+GJKkgoqC70T44A590O
	 4z44X9sezVEd33wbtneZ2Wb7DdEQqskRylQs7P+ILDbNA3jXEv4uCCAurTzmEY2q4FqTh
	 dE6ha4aqpTgWj7UvcP3qWey4JTsdMM0Jo0b1WPP6D5W8p9Q4I0JTUDluXvyfUpY2/zADc
	 Q2cNuznx6ajZcKnuH+ix2q3GnAZFLCOFsrB5/+YxyZLDUdb4AxlUzaFcQdn5r2pZROg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=yeJt95dLPr0+zkactBORZWM016xjbmZmHJOlxxmhc74=;
	b=qQbx67cKFT53Dq38CUb04hUgzAVFBB8qqpXQ+F9heXu2z2hVTuMU5YxLt8lUINdUbeQR
	 mSJXN2bf0yr6LbLHXszOMv9DAVE68Zwo0mObvrOUN7Ql2RW+sjpSglAkavcRkntsM1FF5
	 t6IeUhSoW2s37Hov1IXz/8mu4JAVkFXb/Q3e7B6mW0yw80RdECJD8BmLNjMY+EOQ/wAbF
	 665s/u6QRF23IrTJpqOaaEpt2CnL6xuv/Id09x20ZP97k6MMv+Raw9BFk2hrVicDDiu65
	 XpSRZnwDKsS1CcrbgUKFyoooLluTQU9lKLrqhnIEkGLs9H1FHhkBLCykD+I/RasLp0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Voqdi5ja;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0A606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C0A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Voqdi5ja
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b76ade741cso6212865e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270481; x=1794875281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yeJt95dLPr0+zkactBORZWM016xjbmZmHJOlxxmhc74=;
        b=Voqdi5jalG4P0FIz2si5+mXB1kGiNoYeFMUCiETXhblxuDzZ/QN2hLHlWfQ6XVxhLW
         MtiZwanEYsH/F26uVfbVILnsYUrDNB1ZWhvdFRMHjsz13A+3m31o8UmOAPqlq8fz/kQ5
         qC0pSYu9xbrW9fLlHCxUpz3JwdMXyzxcHwIMBnl3s46rWfSmtcIO23SoUN19npFrGQNu
         lGXc016xWViNHK61qqqF9QrerhScqMSdK6oMT0/YBSG6s6R0hr/7TukrukPOVWJGL8gY
         obRObwvDhW8VZTcviC/P2Pkt3UckB1JoYo6OKB9d+OGJnasROamFahG2jtOh/LDKAFNn
         2V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270481; x=1794875281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yeJt95dLPr0+zkactBORZWM016xjbmZmHJOlxxmhc74=;
        b=ucFJqJqz0JAiRjiJur2eHkm8ED/xmf5t8zxv2fY4FZxN9ngs+X5Ma8AFk4tTf+pGVO
         wDPYgkP2a/snfJuiVxKll1q8OrOTKyjWOikRtD0t41hQPtugboF2DHC0bOMHdjpGc+MB
         ZfTo24/zsK651am9hpcCtKV/QO9u3vZrZ6RbsigHZF7G4eISu44sdJ36sEa94gSlgLoE
         noafFQuThxZizCrgUzNDHw4htcWwQU79uKBYVrpwlSca1u1h/d6F62EKo7aoTOhWN3ej
         KCYe9coz0sb4eUxGT3xNfZYTQsXkK8fL8K14DfAt6XGjKwGEvIp5eX7KXFet04JQjg57
         ObVA==
X-Gm-Message-State: APuU4Z+/xQ1VswUl27JOyqU6O2yfiUElo8LBy59IbUDXuEL+nGXEFaVu
	sPGTjoyt0xTqCub09Pjb1Xfqol4YQmxRviFxpNpSai+syj16cPjfU/Q8txrL8VMt
X-Gm-Gg: AYBFou2wlrWsBY6sH+YiRxEVnC8iwI48iVRFpTQcTbecLrbKVV0MZb60srt3yAUM5OC
	S+pslQoJQCf5G5cx3RnNvmlzZKmMFF2AOTnCyOpuc0naUIs5mSe3M4J7xm2ayteYmtlkIp5OQdS
	0/4LvBrGViJfZ4nRz1fSeZMZIKs/2oD/fh11T611gvtO/ZIqu3G7mMSLKLczEzPz16BwKOat18b
	yXQlO5x97yjjehkYLRRUfkMj8BWyWoy46V5fQjAy/Gi0rdutBIiku6k9l2c7HCyhVPXDhMjTv9r
	/W9wLO/gYpBiVZutV1WdKE3Jjn+GuQZJZ0plu97nIKlLYZaOG2oJvuNztX5LLCOAFU5KYTpdzo6
	KoRldFGpnxXBhnOSSrqdfdKT1VqXFeSoSPFrWaHqSJ0SdTIrLgcoLIVUHLDLYkUdDxPAK66xzKd
	LzaanpOIEzh6u7oJD5NUh/J6b142kY1J/hTsicZNnGxrAlxtJ0LN2jLGMUiwY3tEXpGxRIFoiYR
	EujQqOGCpwVcDMze5Jhydx1s8s61G7/u46LheLj4Nz8ohAO03OniMcUwiYvQMew9BZqgCK6udct
	ycXPzvMe+G1WLXKSw38iShl6E1RWJDDrUhrUSowXm7awJZuGbDSpHrXf4qpl6ScIJDLyZlD9hNP
	6FacqJD1wpaLxxPe+feIA/wQeKtQV145adXY3gkMkdnvldmq22CGmdYIrzixXNZqenq2W
X-Received: by 2002:a05:600c:3e14:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4ba0233fa1dmr11074215e9.9.1794270481044;
        Mon, 09 Nov 2026 16:28:01 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0236bb1asm12781895e9.2.2026.11.09.16.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:00 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/20] bpf: Register bpf_task_park() for syscall programs
Date: Tue, 10 Nov 2026 01:27:30 +0100
Message-ID: <32ccc244a112dffbd5ad415cc1b2a652eb344c24.1794269506.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4935; i=memxor@gmail.com; h=from:subject:message-id; bh=ifgZz/LNCKfmrkO7HNBVMzUulfKbjpJpSNISUwC7v0c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTotvam+zOk+KXCF3WfT1tY5fEonUN+dmKDNyc7Rvl/ HpLP5zpKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwER4WBn+Fx07YcklZrapUj7h 3OL8/cc+72jasJ+5csuEhwYPC9fEhDL8ZJyQ7Sh2+GdHBtMb1ofWb/8o/d51otZL7hx/j5DVyuC nzAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

With the verifier rules in place, make bpf_task_park() callable from
BPF_PROG_TYPE_SYSCALL, as a sleepable kfunc.

Syscall programs are the only type for now because their runner,
bpf_prog_test_run_syscall(), is the one that has been audited against
the sleep. The syscall holds a reference on the program, and through it
on its maps, for the whole run, and the runner copies the context into
kernel memory first, so neither depends on the Tasks Trace RCU read
section the park drops. The run path keeps no per-CPU state across the
program: it has no recursion counter, and __bpf_prog_run() samples its
stats only after the program returns, with migration disabled again.
Helpers confine their per-CPU scratch to the call that uses it, and the
verifier keeps the park out of every region that pins the CPU and out
of every callback. What remains is that the program may resume on
another CPU, which the comment on bpf_prog_run_pin_on_cpu() now says,
since the pin it promises is lifted for the sleep.

Other program types stay off the list. A trampoline-attached sleepable
program is freed after a Tasks Trace grace period the sleeper no longer
delays and keeps a per-CPU recursion count that a migrating task would
leave behind. Each new type needs its runner audited the same way
first.

Deferred:

 - A program type that runs with migration enabled and without Tasks
   Trace RCU, so that a BPF thread is a plain kernel-mode function of a
   user thread and the park needs no bracketing at all. It needs its own
   runner, since __bpf_prog_run() asserts cant_migrate(); an audit of
   every kfunc that relies on migration being disabled, starting with
   bpf_mem_alloc() and its users, per-CPU map lookups and
   bpf_this_cpu_ptr(); and a verifier rule that confines map helpers and
   map value pointers to bpf_rcu_read_lock() sections, since the helpers
   assert bpf_rcu_lock_held() and nothing else would protect the values.
 - Registering the park for further program types. Each needs a runner
   that holds the program across the sleep and no per-CPU recursion
   count.
 - Allowing the park in further callbacks whose kernel caller has been
   audited, beyond the body of a BPF kthread, which a later patch
   admits, and retaining dynptr and iterator stack slots beyond
   bpf_iter_num whose state does not depend on the dropped protection.
 - The stack in arena, the timed may_goto and tail calls in a program
   that parks. Each relies on a run staying on its CPU or under its
   caller's protection and is refused for now.
 - An opt-in flag to park with migration disabled, for per-CPU worker
   designs that accept the CPU offline cost.
 - A per-task marker so that bpf_task_wake() can only wake a task inside
   bpf_task_park(). Today a wake for a task that is not parked may end
   an unrelated interruptible sleep of that task, which the kernel
   contract permits.
 - Interoperation with user threads blocked in futex() on a word the
   program can also reach, such as an arena word.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/filter.h |  6 ++++++
 kernel/bpf/task_park.c | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 61448be53f8d..c30d05a5c26e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -883,6 +883,12 @@ static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog, const void
  * This uses migrate_disable/enable() explicitly to document that the
  * invocation of a BPF program does not require reentrancy protection
  * against a BPF program which is invoked from a preempting task.
+ *
+ * A syscall program may call bpf_task_park(), which lifts the pin for the
+ * duration of its sleep and restores it before returning to the program,
+ * so such a program may resume on another CPU. Nothing on this path keeps
+ * per-CPU state across the program: __bpf_prog_run() samples its stats
+ * only after the program returns.
  */
 static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
 					  const void *ctx)
diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
index 5043ccdfc0b8..0e3d7f3ec597 100644
--- a/kernel/bpf/task_park.c
+++ b/kernel/bpf/task_park.c
@@ -276,3 +276,18 @@ __bpf_kfunc int bpf_task_wake(struct task_struct *task, u64 flags)
 }
 
 __bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_task_park_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_task_park, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_task_park_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_task_park_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_task_park_kfunc_ids,
+};
+
+static int __init bpf_task_park_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park_kfunc_set);
+}
+late_initcall(bpf_task_park_kfunc_init);
-- 
2.53.0

