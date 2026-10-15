Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810B55C1A6
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087750; cv=none; b=AqnMo2130nosrMpQHjyJ8kRTCRxSeUsIOjjOtrmH2NBWNh58NmBcjBfGwO/0DXaCcjUWUOR9N/dyVyvQWhxVhPM9kbZ3tRKZR58JG6ztVhTPfQisUKDYXuqauimx8JoAqWWrWh/5uHU1LpkYPIqQPE/FPFaTRCjGgPCkkM8oVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087750; c=relaxed/simple;
	bh=Krc7OIN6OGfz1+MXYnfl6dz7HcGZHERCMp0IOQrtlOM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=klH3bpIoreIQz9vi+CG2Kbg30G0I1jcN8OdTZPUwAe4YkZRxUK+jR6tHtjQm5tEiiXcJHUpBxh0hKR3tvaCWHtvLkq/f8oR5z1NExP+4WuMKgiZVeh4bBaZdxPVg/uA7pn0XVN4BqRREv5JA+00UZliZtSNX3oJiZ2DkVmV4S0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKnhyoKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKnhyoKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180EF1F000C5;
	Thu, 15 Oct 2026 18:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792087738;
	bh=z9SKNL+qwtokUMn+mo0n4grGnLvK6rNf29EQn0lgshU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FKnhyoKwxathH3poc5M/AcQS/cAHz633hRD527Ik/DOEWmFF7kcJFcTMwuw8QiSXd
	 WNAUsJijDrs0ZtwlBsVaT21vK+WrnzXkVTk1qiY938DoXLQ0Z4IyCFeO7QtuHpwJI1
	 Ik9sBNNKBFPByVluZAXdRlfHIob49uPwWjRqwMtHi6mrBG4zj5nC7AmcDb6C/lk7XU
	 J68AtubgghW3dIJuJjfRl9q8sTGQSL3eP5eB0XZSpMTJ60pIAAwpXLANp8LcxEQ2VI
	 CNwa4ZBNotWg9VRxr47ZDNowVxTMkMiEge1kEtcths9gaNK3b+jkHldsw6jC/MCcCW
	 pgL/bpxDpS2eQ==
Content-Type: multipart/mixed; boundary="===============0059690514135417836=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <05ad306999c7990c577cbd4335f942f4eb8b385698af9144e2565878b0636a6d@mail.kernel.org>
In-Reply-To: <20261015171917.599025-2-daniel@iogearbox.net>
References: <20261015171917.599025-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add JIT cBPF-related instruction tests
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 15 Oct 2026 18:08:57 +0000 (UTC)

--===============0059690514135417836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add JIT cBPF-related instruction tests

TL;DR:
- Test issue: the 1820-MSH jump case may not catch a JIT that mis-encodes the
  far jump
- Nits: hand-rolled netns setup loses -m traffic capture; silent skip

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c b/tools/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c
> new file mode 100644
> index 000000000000..5471c06605fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c
> @@ -0,0 +1,2620 @@

[ ... ]

> +/*
> + * A jump over MSH loads, each of which becomes 18 instructions: the
> + * converted offset has to fit 16 bits, which 1820 of them do.
> + */
> +static int fill_jump_over_msh(struct sock_filter *insns, int nr)
> +{
> +	int i;
> +
> +	insns[0] = JUMP(BPF_JMP | BPF_JA, nr, 0, 0);
> +	for (i = 1; i <= nr; i++)
> +		insns[i] = STMT(BPF_LDX | BPF_B | BPF_MSH, 0);
> +	insns[nr + 1] = STMT(BPF_RET | BPF_K, 0xabababab);
> +	return nr + 2;
> +}

[ ... ]

> +	{
> +		.descr = "BPF_MAXINSNS: jump over 1820 MSH",
> +		.fill = fill_jump_over_1820_msh,
> +		.data = DATA(0xfa, 0xfb, 0xfc, 0xfd),
> +		.runs = RUNS({ 4, 0xabababab }),
> +		.flags = CB_NOBLIND,
> +	},

Can this case detect a JIT that mis-encodes the jump it is meant to
exercise?

fill_jump_over_msh() emits a JA over nr MSH loads to a RET K 0xabababab.  An
MSH load only writes X, so neither A nor the return value depend on it.  If a
JIT emits the JA short, or drops it, the MSH loads run harmlessly on the
4-byte DATA(0xfa, ...) and the program still reaches the same RET K.

rewrite_returns() leaves RET K 0xabababab as is, and run_case() expects
min(0xabababab, 4) = 4 bytes either way.  So the run of the 1820 case can
only fail if the JIT crashes or jumps past the RET.

The bound itself (1820 accepted, 1821 rejected) is checked by the converter,
and the 1821 CB_FAIL case covers that alone.  The 1820 program is converted
with off = (8 + 1820 * 18) - 7 - 1 = 32760, which is the kind of far branch
where arch JITs get offsets wrong.

The previous patch in this series fixed the same gap in the eBPF tests ("a
landing short of the target passed with r0 at zero"), and
fill_jump_over_ld_abs() avoids it by returning 2 vs 3, so a wrong landing is
a drop.

Would it work to make the skipped loads observable?  For example, load X
with a known nonzero value before the JA and end with TXA; RET A under
CB_RAW, so that any MSH that runs changes the kept length.  CB_RAW would be
needed because a rewritten RET A would itself be a forward jump past 32K
converted instructions, which the converter rejects.

[ ... ]

> +static int net_setup(void)
> +{
> +	struct ifreq ifr = {};
> +	int mark = SKB_MARK;
> +
> +	net.tx = -1;
> +	if (!ASSERT_OK(make_netns(NETNS), "netns"))
> +		return -1;
> +	net.tok = open_netns(NETNS);
> +	if (!ASSERT_OK_PTR(net.tok, "open netns"))
> +		return -1;

[ ... ]

> +static void net_teardown(void)
> +{
> +	if (net.tx >= 0)
> +		close(net.tx);
> +	if (net.tok)
> +		close_netns(net.tok);
> +	remove_netns(NETNS);
> +}

A subsystem pattern flags this as potentially concerning: a test that
hand-rolls namespace setup and teardown instead of using the existing
test-util helpers for something they already provide.

net_setup() and net_teardown() pair make_netns() + open_netns() and
close_netns() + remove_netns() by hand and keep the nstoken in a static
struct.  test_progs.h already provides that pairing:

    struct netns_obj *netns_new(const char *nsname, bool open);

netns_new() calls make_netns(), starts the traffic monitor when the test or
subtest matches the -m option of test_progs, and then calls open_netns().
netns_free() stops the monitor, closes the token and removes the namespace.

With the open-coded version, './test_progs -t jit_insns_cbpf -m packets'
does not capture the veth traffic of the packets subtest.  That traffic is
what one would want when a CB_PKT case fails, for example to inspect the
VLAN-tagged and metadata frames.

Could net_teardown() reduce to netns_free(), with net.tok and the NETNS
bookkeeping going away?

The failure paths here are correct (tok is NULL before open_netns()
succeeds, tx is set to -1 first, and net_teardown() restores the original
netns before remove_netns()), and seven other prog_tests still call
make_netns() directly, so this looks like a reuse and consistency point
rather than a functional bug.  The concrete loss is the -m traffic monitor
integration that netns_new() and netns_free() provide.

[ ... ]

> +	/* The constants of the conversion blinded, which takes a JIT */
> +	if (test__start_subtest("blinded")) {
> +		if (!is_jit_enabled()) {
> +			test__skip();
> +		} else if (!sysctl_set_or_fail(harden, old, "2")) {

A subsystem pattern flags this as potentially concerning: a test that skips
silently with no message.

The blinded subtest calls test__skip() without a reason when the JIT is
disabled, so test_progs prints only 'jit_insns_cbpf/blinded:SKIP', with
nothing saying that bpf_jit_enable is 0 and that constant blinding needs a
JIT.  Would a short message before test__skip() help, for example:

    printf("%s:SKIP: blinding needs bpf_jit_enable\n", __func__);

A bare test__skip() is a common idiom in test_progs (jit_insns.c,
arena_scalar_blinded.c, callx_rodata_lskel.c and kasan.c do the same), and
the harness still reports the subtest as SKIP, so this is a diagnostics
point with no functional impact.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38779093397
--===============0059690514135417836==--
