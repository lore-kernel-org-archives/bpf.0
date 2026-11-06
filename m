Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925267;
	b=o2LO67ng0nvpGIHVJvUB4wH29Xfp4q/gHk5YEJf8S46hxhIkSlkYwjXQ+sBEdePERDUp
	 YWxtMIItcYVk/ynYujdfqh41YGW0bXWGnUIRKnu0IyzyLb1qJ3NJs49+xmyInijNyZZqY
	 xU+9HPpGtOy0UIBn54IxwrR/R9VW8MZMSpBKfjdqF5NxVJYuV/zl6047YnKxpU5nzViF5
	 6ANa5O4cDa5p19eubWzYKvRmZGctqIzLljzZtYY8iEme0wWgYqjCTn0xiNyiL3u4DqKjH
	 7Uqy1X7w6c3Fn93f8SS6KHj9yGWVp8CrLhOGfR3ng5aiAmmCUvWlKiC3M7KRIqEcE8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=K+Ut+xx++cvoD54kULsxZTzAT6QhGrXt9ToGo7GaMtg=;
	b=wBYzlVO/s0D24ORWWr1Plor5HepykBmz6dWdzbTIBKdeUqQYMfWf0xbw2QrOLU2vlEUx
	 LmbiTIEWeiDUFMWqUjFfObuatzRfriXcKvPkO8g1vFUYs1hKWj9OLYVY6jGP5k65h1rom
	 EuUTB7A6wEt6sZSRxqPixHA4kI7q5j2lzsPSTHNAl2GR9GpGSdxpXnuBLA7nlWD0qAcZz
	 ysIIcCu6T2aRqjFvhfhoeFCaMab1ZL3x4AtX0FY4WD7wnWo6TSmQo2wSYkwhqIvuC4+P9
	 V7AWUXUuLVoLBl7u7YNz+/XIVHmojZeZUgpJ+KY/VCVupHgcCXUxJrX2G9kmU4Zm9Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Lc8IYh/J";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E2606A32F
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B88E2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lc8IYh/J
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e946155442so581285ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 16:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793925266; x=1794530066; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K+Ut+xx++cvoD54kULsxZTzAT6QhGrXt9ToGo7GaMtg=;
        b=Lc8IYh/JEFcZ5uh2Ls+Le80EEY2gnGXQdTVHDzN6DPOly4eHyo3KoZI3fDTzGoLoHR
         xGGPgO2tDV8BwCERad176J71IXuf3spMJ8aBsRqrML3fYjIg27Jujv1DjrPkZuOnI4gW
         OFk8WoT1iNo9K+KpPkTISsmb13lIOYUhem5F3+Nkihj8lPrvlVQV/oRXelqpzzn7kuWR
         L9ZpYZ3VERSxO7skHMNzuf9AaYJkYqZra8BXqnVa4iySl0X4CFca/ZHzummiCnf/0nTZ
         LZkUG+xRFmu4jIW2SFZR0tBailTDBsgEZ13gaZyytpb6WPKHLwfv3KEWqG5rH6RvxsVs
         TZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925266; x=1794530066;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+Ut+xx++cvoD54kULsxZTzAT6QhGrXt9ToGo7GaMtg=;
        b=0015Co4mgEUmKTxYh7Q0+zOKr+SqDApScRP9tOu0mhmDlq+xIW5ca8UffU5Dygad32
         fBCU5oPsmlKksyKd2I+sT1XqYffcBpa3RqLxPfWL24deE6v3OEAI9NsqFwrrfubhRMXN
         peutFMLUtdprHCF9LfTtb68PitUO97WNFIk7eWHa9sAjP4+qyysElj3KQF4IV09rkivR
         qqTIbyEGiX95wgYm1zikJeu1la4PJBLcGrcHm754RTUCsggSjvS84COTYylGISddo+Pv
         05q294o9sVKutQ8flO1t8dgTx3i8n9aqpRiWSurqVkbpveo5BRjrq4ZGHTWKLDi0pjBW
         QN0A==
X-Gm-Message-State: APuU4Z9mwh//tLZVcTodN9yKvUTF/nE/aF/MaCaPRjqpRdFIxmJOvG/c
	0EvHmEWxL2HgJDvkIhKPVxxthw6MwDxArYj+l204ZrEp5heEitN0dGYHBdZCzQ==
X-Gm-Gg: AYBFou1A4OxobdJ2nIHBZXwoZkWFpV0B4SMdhFOgWAkHXr2s+b6QM7mqYQiOh+cZlJi
	Rs2+cidEZcnDLvd8k4EgkHnBfjAyKcmJy93o2LLYek/uYnEtphPmXZTcRqWY8rvNGETxiXlYFFU
	6lSdBuEO4kcKFUSOtIGP70tglaAIoXi7bHamKsVW8a6EocdtW6tQyzb3n/6pJ1hrl9SvZFKI+JR
	p8pp1G/1pb0ei5/gGGxJKnoQePuUml4kaukKFm9tfLRGHaY3xGi2jfBeLzDsn9XgKgBUwwg07z1
	h9MyJoFzctcH0mBQsmWdvFShJFdfMqadQPZuYbEK5rdW3Pt10pC+oHt47OetV0hWYtsEzT5Q3O1
	HJ4C+XrPS8Fe9i2MNgbjwmjliiFgcmoko/Z+X5xXTXjxvBvXc8JIU/FJtwD2IdOId4wVcH+kBbi
	CNtArERRDfeO7opG7MXA33boz+JarwmHXQVZM7RJ43gysqx5I5UKZz7an8XnghXOA1F4OLox8id
	m628o86+VaorWSw1+onQeuU5YSx8MJ6pIeZQiXubKWzyyiUzI84LHMERMPoMTPtS+VF+DhxUw3G
	Rn5bpmWAdZBp+jIRcYdhkR0xRPXPblIPvLET7C1S7f7nAc4vy+RYL5BXvt4l6NIf99d0rIPYRtV
	XcIOIq9qNWBckjJz7pH73E7y1eQ7dZFc67NLTgoANw3xRfx0QgC005DjT
X-Received: by 2002:a17:902:e809:b0:2e9:5eee:e071 with SMTP id d9443c01a7336-2ed41c143a4mr13452565ad.57.1793925265801;
        Thu, 05 Nov 2026 16:34:25 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47da3e33sm344865ad.76.2026.11.05.16.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 16:34:25 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 00:34:24 +0000
Message-Id: <DMNPFLLMPZ4K.2G7GCW06P0T72@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 00/35] bpf: A verifier that joins states
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bpf@vger.kernel.org>
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

There will be a v3.

Real bug is in patch 21.
The callee gets wrong bounds, and an access out of bounds
loads. It has to be clear_scalar_id().

patch  from     what
-----  -------  ------------------------------------------------------
1      sashiko  * Messages print the index of an insn after may_goto
                  is added. It has to be orig_idx.
4, 5   both     * join_reg() drops delta under explore_alu_limits.
                  verifier_bug(), -EFAULT. No join in this case.
                  It takes CAP_BPF without CAP_PERFMON.
5, 19  sashiko    join_func() refuses a join when only 'b' has stack
                  arguments. It costs one more state.
9      both     * What bpf_rdonly_cast() and bpf_cast_to_kern_ctx()
                  return counts as a number. A valid prog is rejected.
9      sashiko  * ctx on one path only. The pointer to the packet
                  counts as a number. The pass ends all the same:
                  flow_kinds_meet() only clears bits.
9      sashiko  * A pointer that store-release spills counts as a
                  number after the fill. Load-acquire from a slot
                  gives FLOW_IS_OTHER. That costs states at most.
10     bpf-ci   * BPF_END | BPF_TO_BE counts as 'dst op= r0' in four
                  tables. It costs insns where r0 is live.
13     bpf-ci   * flow_join_makes_up() reads the ids of 'a' only.
                  The join drops a link between two numbers.
19     both     * bail_insn can be an exit that is dead code.
                  r0 is not live there. A valid prog is rejected.
19     bpf-ci   * A loop that only bpf_throw() ends has no exit.
                  For the graph bpf_throw() returns, so what follows
                  it is in the loop.
19     bpf-ci   * The order of nospec and the added may_goto.
                  Only without CAP_PERFMON.
19     bpf-ci   * -ENOSPC at log level 1 for a prog that loads.
                  See below.
19     sashiko  * loop_guard stays when all is verified again.
                  Harmless: 'r0 = 0; exit' that nobody jumps to.
20     bpf-ci   * A register that only the loop sets stays NOT_INIT in
                  the state that covers all iterations. A valid prog
                  is rejected.
21     both     * bpf_flow_return() drops 'speculative' of an exit.
                  Stricter than it has to be. Without CAP_PERFMON.
21     sashiko  * has_rcu_read_lock() is false in a static subprog
                  that a timer callback calls. Stricter, too.
22     bpf-ci   * Marks of recursion that only callx makes reject
                  progs without recursion. No released kernel has
                  callx.
22     both     * A subprog that is not live keeps the mark. Its
                  frame in arena takes room from the live ones.
22     sashiko    The guard of a recursive subprog at a back edge to
                  its first insn. The extra edge can only reject.

Patches 2 and 22, both: the padding of a recursive frame comes after the
check of the stack depth.
Right. The check has to see it.

Patch 2, bpf-ci: what comes after the check of r10.
The lower half of the stack is the reserve for that. For this reason
recursion is refused in tracing progs, in progs that call
bpf_clone_redirect(), and for an extension of a subprog that is called in
a recursion.

Patch 19, bpf-ci: log level 1 and -ENOSPC.
There are no paths, so there is no position to roll the log back to.
Level 1 has the blocks of the pass, in the order of the pass.
log_true_size tells the size. libbpf grows its own buffer on -ENOSPC.
The follow-up: the log that is dropped when a prog is safe does not count.

Not bugs, or not worth more code
================================
Patch 1, sashiko: 'gotol -1' that gets a guard.
No. Its loop has no exit, so flow_place_guards() has no place for may_goto.
loop_stack_push() rejects the prog: "loop at insn %d never exits".
Same as for 'goto -1'.

Patch 5, sashiko: join_func() and a slot that only one state has.
Right. Only without CAP_PERFMON. Not worth it.

Patches 18 and 19, sashiko: update_insn() has no edge to
bpf_head_guard_target().
That's deliberate. See the comment above bpf_head_guard_target(): stack
that is dead at the head stays dead. A read of it at the target is
rejected. guard_at_head_dead_slot in verifier_budget.c tests it.

Patch 19, sashiko: loop_stack[].refs is stale after a release.
Right, the count is stale. Not a leak. check_refs_taken_in_loop() only
reports early. The reference stays in refs[] until it is released, and
BPF_EXIT rejects it. The report comes one iteration later.
Not worth more code.

Patch 19, sashiko: a nospec exit and the states that the insn pushed.
No. Today's do_check() goes to pop_stack() there and verifies them.
The edge of check_loop_guard() has to be delivered: the added may_goto is
in front of the barrier.

Patch 19, sashiko: do_check_all() goes on after -EAGAIN, -ENOMEM, -EFAULT.
Deliberate. A signal is still pending in the next round, and flow_merge()
returns -EAGAIN for its first state.

Patch 19, both: offloaded progs.
Yes. A loop of an offloaded prog has to have a count. Not worth more code.

Patch 21, bpf-ci: insns_total counts some insns twice.
Yes. insns_total of a static subprog is an estimate. The main prog and
global subprogs have exact numbers. Not worth more code.

Patch 22, sashiko: compute_call_depth() is one frame short.
Nobody knows how many frames a recursion has. The check of r10 limits them
at run time. The arrays of MAX_CALL_FRAMES have their own checks.

Patch 22, sashiko: the edge of an async callback in build_call_graph().
Not from this series. bpf-next has the same is_async_cb test and the same
"recursive call from" message.

Patch 34, sashiko: 2^46 iterations in the interpreter.
No. All may_goto of a subprog use one slot. BPF_MAX_LOOPS is stored there
once, at the entry of the subprog.

Patch 35, sashiko: __load_if_JITed() for callx_one_of_two_not_written.
The test is built for x86-64, arm64 and riscv64. The selftests config has
CONFIG_BPF_JIT_ALWAYS_ON=y there. Without JIT this file fails today.
CAN_USE_CALLX is the same three archs plus indirect calls in C. This callx
is in asm.

Only in the middle of the series. Not worth it
==============================================

  patch  what
  -----  ---------------------------------------------------------------
  3      The prototypes of join.c and env->join are one patch early.
  5      iter in bpf_reg_state is 8 bytes larger until patch 23.
  9      addr_taken is set by patch 28. Its log says so.
  17     per_trip is read first by patch 20. Only W=1 warns.
  19     id_gen has no bound in patches 19 and 20. Patch 21 adds it.
  29     The log does not say that for_u32_spills_u64_fill() has a new
         prog.


Nits. That bots should stop repoting
====================================

  patch  what
  -----  ---------------------------------------------------------------
  14     flow_merge() takes a double pointer. A plain one is enough.
  15     The comment of bpf_flow_exit(): @st stays on the covered path.
  30     __not_msg() in correlated_regs() has one line in its window.
  31     Leftovers in SHAPE_MANY(), three redundant externs.
  32     Dead 'r7 = r0' in TWO_INNER_MAPS, an unused __imm().
  34     The comment of counts(). RUN_JITED(). loop_in_main() and
         loop_in_main_rcu() leave the loop in the first trip.
