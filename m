Received: from mta1.migadu.com (out-214.mta1.migadu.com [95.215.58.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA744F7CA2
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569827; cv=none; b=IpNJzquPPnjjMAFVjttust5TnjA+Ez/XhxeA0G4BXM3jq6/iOUUfz8yCwuWTfkGhYCrK1stQPraFvJJ0Cx8fz1/8kMSONJOcwdYW0a1JKwBF2au7mlHbtXTh31y8T4vtt73xHZcS18kIi9PKCzRajr4xpSmqg0vQvsoUPvzsWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569827; c=relaxed/simple;
	bh=J+idAlfV4VCSk+4Nw+eKsOkr6Rd6ft46Ii2gPOzw5uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCAP3UBKnXxLdzlDr0D8yQQmJAOR/1E/oIHk0bUMy0N6SEDN5U2B8fVcE4sfxIBdXymhy1jOdyFHtqPzJVuddz7TfTwHYcHUb4YQIoqP9mEmV73yvStE4p0a5oSQG2JrrzrBc1+0HTWfyxNDGhp6UjOj0kN6Pt5F5ohEZLkiGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C1gS9RBL; arc=none smtp.client-ip=95.215.58.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C1gS9RBL"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J+idAlfV4VCSk+4Nw+eKsOkr6Rd6ft46Ii2gPOzw5uA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791569823; v=1; x=1792174623;
 b=C1gS9RBLh7vq9ncleratQOXT+Ac1j/gAExT6es5o4rlE87zXrbptqbHrqz8vU2bDNza6YwGX
 6RS1PxL9vV3B0rDCK3KGOs0ofs7RhfdVdSAczYnxXavHF2VKKsgGq0Fxox/M5TuOsF+V+v5BWyF
 KAwxqJyK6c2vewPAVeZ9cMWI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f209e4267be9a5bb;
	Fri, 09 Oct 2026 18:17:02 +0000
X-Mizu-Trace-ID: f209e4267be9a5bb
X-Migadu-Flow: FLOW_OUT
Message-ID: <1f003770-d821-495b-b471-ba1e3b83d9b0@linux.dev>
Date: Fri, 9 Oct 2026 20:17:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Test trampoline args of a BPF
 function at an odd slot
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261009064233.1241063-1-yonghong.song@linux.dev>
 <a1a3ad8ec645f448311f5b01ed6bd8d4a4bec70c459e2e6c4e4b0026aadb3ee1@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a1a3ad8ec645f448311f5b01ed6bd8d4a4bec70c459e2e6c4e4b0026aadb3ee1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/26 9:48 AM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Test trampoline args of a BPF function at an odd slot
> TL;DR:
> - On arm64, the callee_stack case may read an uninitialized stack value for
>    h.hi, so its assertions may fail
> - Silent test__skip() without a message (nit, matches existing idiom)
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> [ ... ]
>
>> @@ -162,6 +164,76 @@ static void test_int128_args(void)
>>   #endif
>>   }
>>
>> +static void test_int128_tgt_prog(void)
>> +{
>> +#if defined(__x86_64__) || defined(__aarch64__)
>> +	struct tracing_struct_int128_tracer *tracer = NULL;
>> +	struct tracing_struct_int128_tgt *tgt;
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
>> +	int err, fd;
>> +
>> +	tgt = tracing_struct_int128_tgt__open_and_load();
>> +	if (!ASSERT_OK_PTR(tgt, "tgt__open_and_load"))
>> +		return;
>> +	if (!tgt->rodata->has_struct_arg) {
>> +		test__skip();
>> +		goto out;
> A subsystem pattern flags this as potentially concerning, though this isn't
> a bug: test__skip() is called here without any message, and the #else branch
> for other architectures does the same.  When the target object was built
> without by-value struct argument support (a GCC BPF build), the run shows a
> bare SKIP with nothing explaining what was missing.
>
> The pattern says a test that skips silently with no message should be
> reported.  test__skip() takes no message argument, and test_int128_args()
> and prog_tests/stack_arg.c use the same bare test__skip() call, so this may
> simply match the existing idiom.
>
> Would a printf() of the reason before test__skip() be worth adding here?

I will keep the current way.

>
>> +	}
>> +	fd = bpf_program__fd(tgt->progs.run);
> [ ... ]
>
>> +	if (tgt->rodata->has_stack_arg) {
>> +		ASSERT_EQ(tracer->bss->stack_g, 7, "stack:g");
>> +		ASSERT_EQ(tracer->bss->stack_lo, 8, "stack:h.lo");
>> +		ASSERT_EQ(tracer->bss->stack_hi, 9, "stack:h.hi");
> Does the callee_stack half of this subtest pass on arm64?
>
> In the BPF convention, callee_stack(a, b, c, d, e, f, g, struct int128_arg h,
> i) uses argument slots 0..6 for a..g, 7..8 for h and 9 for i.  The arm64 JIT
> passes BPF slots 5..7 in x5..x7 and slot 8 onward on the stack, so h.lo is in
> x7 and h.hi is at [SP + 0].
>
> For a BPF target, commit 0ee21f37b2cb ("bpf: Keep the BPF calling convention
> for a trampoline on a BPF function") makes bpf_jit_place_args() return the
> identity mapping:
>
>      if (fm->bpf_tgt_prog) {
>          for (i = 0; i < fm->nr_args; i++)
>              for (k = btf_func_model_arg_slots(fm, i); k > 0; k--, slot++)
>                  pos_of_slot[slot] = slot;
>
> The arm64 code decides whether an argument is in registers or on the stack
> from its first slot only, in calc_arg_aux():
>
>      if (a64_arg_on_stack(a->pos_of_slot[slot])) /* passed through register ? */
>          break;
>      slot += slots;
>
> h starts at pos 7, so it is counted as a register argument (args_in_regs = 8,
> regs_for_args = 9).  Then save_args() handles h's second slot with:
>
>      reg = a->pos_of_slot[slot++];
>      ...
>      emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
>
> with reg = 8.  That stores x8 (BPF R0 in bpf2a64[]) into ctx[8] instead of
> reading h.hi from the stack.  On the call-origin path the same loop reloads
> x8, and the stack loop writes only i, at oargs_off + 8.  The outgoing slot 0
> is never written, so callee_stack() would read h.hi from uninitialized
> trampoline stack.
>
> With a clang that defines __BPF_FEATURE_STACK_ARGUMENT, should the
> "stack:h.hi", "stack ret" and "stack fexit ret" assertions be expected to
> fail on arm64?  A leftover kernel stack value would also end up in the traced
> program's return value and from there in a map that userspace can read.
>
> Before 0ee21f37b2cb the AAPCS64 placement never split an argument
> (arm64_arg_abi has no split_at_boundary), so the per-argument classification
> was safe.  The identity mapping, whose comment says "no split refused",
> breaks that assumption.  x86 doesn't hit this because its
> save_args()/restore_regs() classify each slot.
>
> The commit message describes callee_stack() as covering arm64, but only the
> x86-64 failure output is shown, and no commit in the series changes
> arch/arm64/net/bpf_jit_comp.c.  Was this run on arm64?
>
> Either the arm64 trampoline needs per-slot handling for models with
> bpf_tgt_prog set, or the callee_stack case needs to be gated off there.

This has the same issue at commit 2. Will fix.

>
>> +		ASSERT_EQ(tracer->bss->stack_i, 10, "stack:i");
>> +		ASSERT_EQ(tgt->bss->ret_stack, 385, "stack ret");
>> +		ASSERT_EQ(tracer->bss->stack_ret, 385, "stack fexit ret");
>> +	}
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37897160282

