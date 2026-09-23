Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983D340DA6
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149842; cv=none; b=muiFAPazfmnlVbAODyMGBqd/tHYmRNgsokNhGjOvlucGTSxN9GMlHdhZULxuUuELH7cSzvVh6RKbJ+cex8t5a37PBO8df58/8SDMcKZ45MYCua7mk2XPLjAmb7MHTnR+uivhCVufKzGq5vMcbdgXdTPNZE05dNCQoMmU+/mG5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149842; c=relaxed/simple;
	bh=tWEavWP7C+eVqML6GHRGcfZQls7UDbjq5K8agM3HI1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NYaKCfk3VfwNzNwWs680KoaQ43B45/ve9Sc22SSSRbtH196+P86ENjLANnJXBucCzRUJNlICh3tphMg/Q2WnZj7XZb5I7WNk2FP0Wh3CeO/Qr/NwFvwwadAXZ3fHiM43Ot86jV4p6OemJ3eu/0MqJ1ZEbjn32QOjovKRIqJ2VgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1syA7e5; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1syA7e5"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso554305a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 00:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149840; x=1790754640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ahtvEkCP/PgR1Ld+mM6QGdnoQFvRl0qwkSiq3q71yPI=;
        b=X1syA7e5u8CO/JoYG0uVxM1R9moTmKFIGY5CokFQYSw5RxpO08PLfUwREpbWuE7/qn
         HbEpo/NN0zZv5OmENK2EWU6nj+Mzw+re+vTBdGcy90vjubqxVmXbWMtalfJKUAAWUmFy
         9EWhh0FE5h+/3hKyklO3rmTz90hpDN5hE0OeSUlnX0B6WBVJgpeshOgq/VxV7NW/FwXg
         dbocFjbUUnfBCdg9TrWhWgMtYnq78cRLxfY8nx3JxMUVOjLBf1mvdVPuJtCdhFLBKXgc
         q/nut3cudqtEQP/qKSKTbUbn5a39gc4PGFCXGYpMtGW88zN8rUM/bn8qkArqElnicwoi
         8e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149840; x=1790754640;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahtvEkCP/PgR1Ld+mM6QGdnoQFvRl0qwkSiq3q71yPI=;
        b=wEOvDps/gzM4tetutcErafbnzHQ2ty8OtZRIGa5WsFa0eycO8Fws0eGizdTLjbvjpj
         XDCAVYgU2t69E2SW66W5D1dn5WThrcTtOz5F1+biIJBQakViHkoM1gFNCxafAVIMtzha
         YnhSqevQMHqIvOWRak107cgUKcOeRVdxopVcIommkAVvyjOO0ww/SzO/vgWkZg941hwJ
         6ZDupn+bM7SXs6lyxTnrLNB9K80CXlrHnPmEv0WNe8Nd58HNhJjSXjPoXy9we97jD7D8
         AT4xM432pu2d7y1Ei149JclwhkHIAZdjw8vBCx+auRcuv8INTSySsaLdTtCWPV8CiBMI
         khow==
X-Forwarded-Encrypted: i=1; AKwUvByZvu0iYnZRMGgkkGZwY+x8EYmhVAY3lOhSD39aTcv4wzCJIXzBI++iOrWihx7THKZPjgg=@vger.kernel.org
X-Gm-Message-State: AFuF++nACQTGgzTZXOYFPJl2xk/lsZDth8C42dMNzWXxoD2yf2lf8vDu
	TzGbVToGHegGn9cmCojoRMaU23ru7fFzUNbpLesT9EuuQNrrnhZn/5WE
X-Gm-Gg: AYBFou2fxYrmxGi1MEhpgWxUPM7DVRLpv3ejvByHpULmt0kQ9lHchW6CWSt3cSgGRSQ
	nm96sAtY1jdrPVzK/H8NM81hMS3i2mqK3LyJe6rj7Zj3rX6P/ew9kXuntirdbcMUXtSN2Zseoxn
	3aDJFVnMpqdsvTI1iXWVMVskSrwuJhEToorMhP8vjDOLm1njHJc0TDsP6ohBG9O0hqfr9olVnVB
	SB/UvhEDo60FNBbrhvUSuhqsUl/0F/yQQQFCds0D0SqB2UVs/FpgwiGkKsjPgohzDhGFJkoN3/L
	htqQD+OLtDxDqne2FppOah6LgwhFebXpu/XCBRwpxi/VV1/BKkW3WE9zb/WsyaJsXi66YO4vA2d
	u0JMSas+MaT4nmPVuz+4EHfPBGRxH5ea0E6YBQiXNV5mPIC4T5sZasEQuwY3im4y6LJ/ncFe5za
	BpKeacGipV9Y250KEHDY4/wOlqyZuZOG6bdVjl30aern1HLIegUDrBh7NvR5BX1gkwmnb74f0h3
	kPIYmdjRLucEf7Pq6AkL4hWFhIyo+grEIkZ
X-Received: by 2002:a17:90b:4ecb:b0:3a0:7cbf:b8cd with SMTP id 98e67ed59e1d1-3a07e4f364amr1689848a91.14.1790149839802;
        Wed, 23 Sep 2026 00:50:39 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5f965esm6392265ad.75.2026.09.23.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:50:39 -0700 (PDT)
Message-ID: <962c001bc6497234e5ee66353e206e6c2f38834f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 20/21] selftests/bpf: Cover the exception
 cleanup shapes the chain does not reach
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 23 Sep 2026 00:50:36 -0700
In-Reply-To: <20260923050029.2427329-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
	 <20260923050029.2427329-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 22:00 -0700, Yonghong Song wrote:

...

> +static void test_shapes(void)
> +{

Maybe consider adding an annotation __retbss(var, value)?
Similar to __retval(), but checking the value of a variable in .bss
after the test execution?
Similar to how veristat does it, it can:
- look for a map with a name ".bss" and enumerate
- look for a btf_is_datasec() with a name ".bss"
- iterate over variables in the section and look
  for one with a name specified in the annotation
- read the value if it is e.g. u32
  (we can limit support by u32 or u64 at the moment).

This would remove the necessity for test_shapes(),
as generic RUN_TESTS() would suffice.

But also, Yonghong, this series adds 2.5K lines of tests,
are you sure all these tests are necessary?
Is there a more compact way to encode these?

> +	struct exceptions_cleanup_shapes *skel;
> +
> +	skel =3D exceptions_cleanup_shapes__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "shapes open_and_load"))
> +		return;
> +
> +	/* The frame loads at all only if everything unreachable in it went. */
> +	if (test__start_subtest("sweep_no_throw"))
> +		run_shape(skel, skel->progs.entry_sweep, 1, 0, 0);
> +	if (test__start_subtest("sweep_throw"))
> +		run_shape(skel, skel->progs.entry_sweep, 101, THROW_COOKIE, RAN_SWEEP)=
;
> +
> +	/* The covered call unwinds to the pad; the uncovered one walks past. *=
/
> +	if (test__start_subtest("shared_callee_no_throw")) {
> +		skel->bss->outer_input =3D 0;
> +		run_shape(skel, skel->progs.entry_shared, 1, 2, 0);
> +	}
> +	if (test__start_subtest("shared_callee_throw")) {
> +		skel->bss->outer_input =3D 0;
> +		run_shape(skel, skel->progs.entry_shared, 101, THROW_COOKIE, RAN_SHARE=
D);
> +	}
> +	if (test__start_subtest("shared_callee_uncovered_throw")) {
> +		skel->bss->outer_input =3D 101;
> +		run_shape(skel, skel->progs.entry_shared, 1, THROW_COOKIE, 0);
> +		skel->bss->outer_input =3D 0;
> +	}
> +
> +	/* The pad only sets its bit if it got the frame's own r6-r9 back. */
> +	if (test__start_subtest("pad_sees_callee_saved"))
> +		run_shape(skel, skel->progs.entry_regs, 101, THROW_COOKIE, RAN_REGS);
> +
> +	/* Same check, with a tail-call-reachable callee: its spill moves. */
> +	if (test__start_subtest("tail_call_no_throw"))
> +		run_shape(skel, skel->progs.entry_tail_call, 1, 0, 0);
> +	if (test__start_subtest("tail_call_throw"))
> +		run_shape(skel, skel->progs.entry_tail_call, 101, THROW_COOKIE,
> +			=C2=A0 RAN_TAIL_CALL);
> +
> +	/* A region around a nounwind call: no pad dispatched, still loads. */
> +	if (test__start_subtest("nounwind_region"))
> +		run_shape(skel, skel->progs.entry_nounwind_rec, 1, 0, 0);
> +
> +	/* A pad in the main program's own frame, not in a subprogram. */
> +	if (test__start_subtest("main_program_pad"))
> +		run_shape(skel, skel->progs.entry_main_pad, 101, THROW_COOKIE,
> +			=C2=A0 RAN_MAIN_PAD);
> +
> +	/*
> +	 * The same call site either way: the subprogram's throw unwinds into
> +	 * this frame and runs its pad, an extension's stops at its own boundar=
y.
> +	 */
> +	if (test__start_subtest("freplace_subprog_throws"))
> +		run_shape(skel, skel->progs.entry_freplace, 7, THROW_COOKIE,
> +			=C2=A0 RAN_FREPLACE);
> +	if (test__start_subtest("freplace_extension_throws"))
> +		test_freplace(skel);
> +
> +	/*
> +	 * A tail call that is taken: the walk ends at the target, so the cooki=
e
> +	 * comes back from there and this frame's pad does not run -- though it
> +	 * is reachable, so a walk past the boundary would find it.
> +	 */
> +	if (test__start_subtest("tail_call_taken")) {
> +		int key =3D 0, prog_fd =3D bpf_program__fd(skel->progs.tc_target);
> +
> +		if (ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.taken_table),
> +						=C2=A0 &key, &prog_fd, BPF_ANY),
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "populate taken_table"))
> +			run_shape(skel, skel->progs.entry_tail_taken, 101,
> +				=C2=A0 THROW_COOKIE, 0);
> +	}
> +
> +	/*
> +	 * A throwing subprog named by a BPF_PSEUDO_FUNC and handed to a
> +	 * bpf_loop() the verifier never reaches: the callback check has to fir=
e
> +	 * on the helper call, not on the ld_imm64.
> +	 */
> +	if (test__start_subtest("addr_taken_no_throw"))
> +		run_shape(skel, skel->progs.entry_addr_taken, 1, 2, 0);
> +	if (test__start_subtest("addr_taken_throw"))
> +		run_shape(skel, skel->progs.entry_addr_taken, 101, THROW_COOKIE,
> +			=C2=A0 RAN_ADDR_TAKEN);
> +
> +	/*
> +	 * A record covering bpf_throw() itself rather than a call to a frame
> +	 * that throws: raised, caught up with and delivered in one frame.
> +	 */
> +	if (test__start_subtest("no_subprog_no_throw"))
> +		run_shape(skel, skel->progs.entry_no_subprog, 1, 0, 0);
> +	if (test__start_subtest("no_subprog_throw"))
> +		run_shape(skel, skel->progs.entry_no_subprog, 101, THROW_COOKIE,
> +			=C2=A0 RAN_NO_SUBPROG);
> +
> +	/*
> +	 * A pad that calls a subprogram; with a throwing extension in its plac=
e,
> +	 * the nested exception has to stop there, not restart this pad.
> +	 */
> +	if (test__start_subtest("pad_calls_subprog")) {
> +		skel->bss->pad_runs =3D 0;
> +		run_shape(skel, skel->progs.entry_pad_calls, 101, THROW_COOKIE,
> +			=C2=A0 RAN_PAD_CALLS);
> +		ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
> +	}
> +	if (test__start_subtest("pad_calls_throwing_extension"))
> +		test_pad_calls_freplace(skel);
> +
> +	/*
> +	 * A covered throw the sweep leaves last, where the default exception
> +	 * callback is patched in; the pad's bit needs r6-r9 still spilled.
> +	 */
> +	if (test__start_subtest("pad_before_throw"))
> +		run_shape(skel, skel->progs.entry_pad_first, 101, THROW_COOKIE,
> +			=C2=A0 RAN_PAD_FIRST);
> +
> +	/*
> +	 * A region whose last instruction is a 16-byte one, so that end - 1
> +	 * names the half of it that is not an instruction.
> +	 */
> +	if (test__start_subtest("region_ends_on_ldimm64"))
> +		run_shape(skel, skel->progs.entry_wide_rec, 101, THROW_COOKIE,
> +			=C2=A0 RAN_WIDE_REC);
> +
> +	/*
> +	 * A pad that reloads from and writes to its own frame's stack, which a
> +	 * JIT addressing the frame through the stack pointer gets wrong.
> +	 */
> +	if (test__start_subtest("pad_uses_own_frame"))
> +		run_shape(skel, skel->progs.entry_pad_stack, 101, THROW_COOKIE,
> +			=C2=A0 RAN_PAD_STACK);
> +
> +	/* The same, with an uncovered frame between the throw and the pad. */
> +	if (test__start_subtest("pad_two_frames_up"))
> +		run_shape(skel, skel->progs.entry_deep_pad, 101, THROW_COOKIE,
> +			=C2=A0 RAN_DEEP_PAD);
> +
> +	/* An extension program with a cleanup table of its own. */
> +	if (test__start_subtest("extension_carries_table"))
> +		test_ext_table(skel);
> +
> +	/*
> +	 * A pad terminated by _Unwind_Resume, which libbpf maps onto the kfunc=
;
> +	 * every other program here calls bpf_unwind_resume directly.
> +	 */
> +	if (test__start_subtest("resume_alias"))
> +		run_shape(skel, skel->progs.entry_resume_alias, 101,
> +			=C2=A0 THROW_COOKIE, RAN_RESUME_ALIAS);
> +
> +	/*
> +	 * A pad that calls a subprogram which tail calls, array empty and then
> +	 * populated: the tail call releases only the callee's own prologue.
> +	 */
> +	if (test__start_subtest("pad_callee_tail_call")) {
> +		int key =3D 0, prog_fd =3D bpf_program__fd(skel->progs.pad_tc_target);
> +
> +		skel->bss->pad_tc_target_ran =3D 0;
> +		skel->bss->pad_runs =3D 0;
> +		run_shape(skel, skel->progs.entry_pad_tail_call, 101,
> +			=C2=A0 THROW_COOKIE, RAN_PAD_TAIL_CALL);
> +		ASSERT_EQ(skel->bss->pad_tc_target_ran, 0, "target not run");
> +		ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
> +
> +		if (ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.pad_tc_table)=
,
> +						=C2=A0 &key, &prog_fd, BPF_ANY),
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "populate pad_tc_table")) {
> +			skel->bss->pad_runs =3D 0;
> +			run_shape(skel, skel->progs.entry_pad_tail_call, 101,
> +				=C2=A0 THROW_COOKIE, RAN_PAD_TAIL_CALL);
> +			ASSERT_EQ(skel->bss->pad_tc_target_ran, 1, "target ran");
> +			ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
> +		}
> +	}
> +
> +	/*
> +	 * The same, into a target that carries a table and throws: that target
> +	 * is a boundary, so the outer pad runs once, not twice.
> +	 */
> +	if (test__start_subtest("pad_callee_tail_call_throws")) {
> +		int key =3D 0, prog_fd =3D bpf_program__fd(skel->progs.pad_tc_throw_ta=
rget);
> +
> +		if (ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.pad_tc_table)=
,
> +						=C2=A0 &key, &prog_fd, BPF_ANY),
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "populate pad_tc_table")) {
> +			skel->bss->pad_runs =3D 0;
> +			skel->bss->tc_target_pad_runs =3D 0;
> +			run_shape(skel, skel->progs.entry_pad_tail_call, 101,
> +				=C2=A0 THROW_COOKIE, RAN_PAD_TAIL_CALL);
> +			/* The target cleaned up after itself, once. */
> +			ASSERT_EQ(skel->bss->tc_target_pad_runs, 1,
> +				=C2=A0 "tc_target_pad_runs");
> +			/* And the outer pad was not started over. */
> +			ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
> +		}
> +	}
> +
> +	/*
> +	 * A pad whose first instruction opt_remove_nops() deletes: the record
> +	 * has to follow the pad rather than be dropped with the nop.
> +	 */
> +	if (test__start_subtest("nop_at_pad_head"))
> +		run_shape(skel, skel->progs.entry_nop_pad, 101, THROW_COOKIE,
> +			=C2=A0 RAN_NOP_PAD);
> +
> +	/*
> +	 * A pad that indexes its frame's stack by a register the frame set
> +	 * before the throwing call, marked precise back across the unwind edge=
.
> +	 */
> +	if (test__start_subtest("pad_var_stack_offset"))
> +		run_shape(skel, skel->progs.entry_var_stack, 101, THROW_COOKIE,
> +			=C2=A0 RAN_VAR_STACK);
> +
> +	/*
> +	 * The same, where the throw is in a global subprogram, which the
> +	 * verifier walks without a frame of its own.
> +	 */
> +	if (test__start_subtest("pad_over_global_subprog"))
> +		run_shape(skel, skel->progs.entry_global_pad, 101, THROW_COOKIE,
> +			=C2=A0 RAN_GLOBAL_PAD);
> +
> +	/*
> +	 * A pad that indexes its frame by r0, which no insn in the frame
> +	 * wrote: the precision request for it must not cross the unwind edge.
> +	 */
> +	if (test__start_subtest("pad_r0_precision"))
> +		run_shape(skel, skel->progs.entry_pad_r0, 101, THROW_COOKIE,
> +			=C2=A0 RAN_PAD_R0);
> +
> +	exceptions_cleanup_shapes__destroy(skel);
> +}
> +

...
