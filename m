Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553082;
	b=EPX9LPZq8vnCXzhYBMs2RU5iTmc6lzKEAAo0RzL3GBvXF1FQzlYoUVEHdl+Ckd4EAV2c
	 o5QlNcrVK+GtO3kmY98vVh/9jMt+HWE67q01rcfTde3Y2EiFT7mm2aEEa/EWpJIWIcu2A
	 l1uv5TAX3mz4CtCV80cxuYt39hFtkQ/I/XpBAiJeW9GQvQkOA8dq0SftV84f7iEiaen3J
	 CuhtnslviP7xREQ/4bT8lkgrVqGBVYnZhdZlAbedpxAZH5b7ThsnolbPutIfMAJzIvoVF
	 cuJf9irQdUIPnzFF580MwlJg/pZ0Lv1pjjCm5AJe/tQShU+1VMiAH/HvMF6zPfsXoFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553082;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Y2xBaCv7C9LFY/85L35mXA5VLHNpjenLMK+EzJusRMw=;
	b=faN1nraYdXoD0xLbW4vMFrsSDqNBCyXpe7hkF9Lmt8COA5lAxeBzlq1Jhwp53ujZOspm
	 VL0CF/uY/UkybkLdF70PmSyiilykGSRdxy2MZaL2w4BfKSjF/lH48LCELW2dvUP6t9LKS
	 18oMl0AS+S1JLz7A/+uPcxiwqgtseVaYRzCGRI0GLs+TW8yCsKFBS1utJP+v9VRjYwCqv
	 SDspTK1ISR6etc7+3WoBSe2qI1g4s4+fNkO95QBhFeNGBdSc0dmZx3KxLAB6Tw8EFk8CP
	 Vw5Q0WPDUroRuoUEUhSVjngJ9QL4PZaDujWJhgzWAtvWvh+uJV4pqgGzyyqcP3A6H5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=i3Wkk50Y;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D027606A321;
	Fri, 13 Nov 2026 06:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D027606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=i3Wkk50Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Y2
	xBaCv7C9LFY/85L35mXA5VLHNpjenLMK+EzJusRMw=; b=i3Wkk50YGAyAeRMMvC
	1bRTlqWnc5x4M0ncSrDM4538XkvbYb0FQMg7hsIiDpENRPvFm/0/qOvcMUQnpvXz
	jaRMZEsDfL6qyA85iOd73g1Od01PpB99sRxw1jwh9SGxkMDAyj1+BaTrdEGqkzb+
	3xR9LjcarPAbtcZM++UeBfr7c=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnj562tPZqlabGGg--.28272S2;
	Fri, 13 Nov 2026 14:56:56 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	mason@kernel.org,
	mathieu.desnoyers@efficios.com,
	matt@bobrowski.net,
	memxor@gmail.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add sleepable version of bpf_get_stack in raw_tp_prog_func_proto and tp_prog_func_proto
Date: Fri, 13 Nov 2026 14:56:54 +0800
Message-Id: <20261113065654.523979-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b7b3f0926c35e8192180326438de9b6c119125a50ffb23b8d5754f31f47a999c@mail.kernel.org>
References: <b7b3f0926c35e8192180326438de9b6c119125a50ffb23b8d5754f31f47a999c@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj562tPZqlabGGg--.28272S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrWUWF1kCFWftry8AF45trb_yoW7GF45pF
	1DCFyIkr4kJr4Sq3srAr4kZFy5Jw4UX3y7KF18CryF9w1DXr1kKFy7KFWavFy5ZrZ7G34I
	vFy0vF4qkw4jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFkshUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RizLGr2tLjUlAAA3m

On Fri,  6 Nov 2026 08:50:02 +0000 bot+bpf-ci@kernel.org wroted:

[ ... ]

> > @@ -1725,7 +1774,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  	case BPF_FUNC_get_stackid:
> >  		return &bpf_get_stackid_proto_raw_tp;
> >  	case BPF_FUNC_get_stack:
> > -		return &bpf_get_stack_proto_raw_tp;
> > +		return prog->sleepable ? &bpf_get_stack_proto_raw_tp_sleepable
> > +				       : &bpf_get_stack_proto_raw_tp;
> >  	case BPF_FUNC_get_attach_cookie:
> >  		return &bpf_get_attach_cookie_proto_tracing;
> >  	default:
> 
> Can this make sleepable programs that load today fail to load?
> 
> The new prototypes set .might_sleep = true, and check_helper_call() rejects
> such a helper whenever in_sleepable_context() is false:
> 
>     if (fn->might_sleep && !in_sleepable_context(env)) {
>             verbose(env, "sleepable helper %s#%d in %s\n", ...);
>             ...
>             return -EINVAL;
>     }
> 
> in_sleepable_context() is false inside bpf_rcu_read_lock(),
> bpf_preempt_disable(), bpf_local_irq_save() and lock regions, and inside
> rcu callbacks such as bpf_for_each_map_elem() on hash maps and
> bpf_find_vma().
> 
> Before this patch the same call resolved to bpf_get_stack_proto_raw_tp or
> bpf_get_stack_proto_tp, which do not set might_sleep and never fault.  For
> example:
> 
>     SEC("lsm.s/file_open")
>     int prog(void *ctx) {
>             bpf_rcu_read_lock();
>             bpf_get_stack(ctx, buf, sizeof(buf), 0);
>             bpf_rcu_read_unlock();
>             return 0;
>     }

This patch is effectively d4dd9775ec24 + 9d02927fdf4e applied to the remaining
program types in one step: the resulting behavior matches uprobe.
If the rejection is acceptable for uprobe, we would prefer to keep the new types consistent with it.

> loads today and would be rejected with "sleepable helper bpf_get_stack#67 in
> rcu_read_lock region".
> 
> The call chain is bpf_lsm_func_proto() -> tracing_prog_func_proto() ->
> raw_tp_prog_func_proto().  The same applies to sleepable raw_tp,
> tracepoint, fentry/fexit/fmod_ret, fsession and iter programs.  It also
> applies to every BPF_PROG_TYPE_SYSCALL program, since check_attach_btf_id()
> forces those to be sleepable.
> 
> The rejection happens even when BPF_F_USER_BUILD_ID is not passed, so the
> helper could not sleep in those calls.
> 
> The commit message acknowledges this ("such programs load today") and cites
> commit 9d02927fdf4e as precedent.  That commit fixed prototypes that could
> actually sleep in non-sleepable regions, whereas here the old prototypes
> were correct.
> 
> The verifier already records per-insn non-sleepable call sites in
> env->insn_aux_data[insn_idx].non_sleepable, and specialize_kfunc() uses
> that to pick bpf_arena_alloc_pages_non_sleepable().  Could the non-faulting
> implementation be selected the same way at fixup time for call sites that
> are not always sleepable, instead of rejecting them?

If we do need to keep the existing unaffected behavior, would this change be similar to
the operation below?

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 1d33a78d9373..d91211b15770 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -3416,6 +3416,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
                                     func_id_name(insn->imm), insn->imm);
                        return -EFAULT;
                }
+               if (fn->might_sleep && env->insn_aux_data[i].non_sleepable &&
+                   insn->imm == BPF_FUNC_get_stack)
+                       fn = bpf_get_stack_proto_nosleep(env->prog);
                insn->imm = BPF_CALL_IMM(fn->func);
 next_insn:
                if (subprogs[cur_subprog + 1].start == i + 1) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb1659ce7a5c..f73dd67f523e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13107,6 +13107,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
                return err;
        }
 
+       if (fn->might_sleep && !in_sleepable_context(env) &&
+           func_id == BPF_FUNC_get_stack)
+               fn = bpf_get_stack_proto_nosleep(env->prog);
+
        /* eBPF programs must be GPL compatible to use GPL-ed functions */
        if (!env->prog->gpl_compatible && fn->gpl_only) {
                verbose(env, "cannot call GPL-restricted function from non-GPL compatible program\n");
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1229ee06dd71..9eed63059449 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1765,6 +1765,22 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp_sleepable = {
        .arg4_type      = ARG_ANYTHING,
 };
 
+const struct bpf_func_proto *
+bpf_get_stack_proto_nosleep(const struct bpf_prog *prog)
+{
+       switch (resolve_prog_type(prog)) {
+       case BPF_PROG_TYPE_TRACEPOINT:
+               return &bpf_get_stack_proto_tp;
+       case BPF_PROG_TYPE_RAW_TRACEPOINT:
+       case BPF_PROG_TYPE_TRACING:
+       case BPF_PROG_TYPE_LSM:
+       case BPF_PROG_TYPE_SYSCALL:
+               return &bpf_get_stack_proto_raw_tp;
+       default:
+               return &bpf_get_stack_proto;
+       }
+}

