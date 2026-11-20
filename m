Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211476;
	b=dZJnuuc8KuKTt4ssYyHpQJsnOt/eGAxkWiuRjEY/CtpWKF37Q6gu7+4Z+nF7PIKtbhRL
	 NW4ht/XvCLkZo0en33yNxzsw2g51abxvYeWWtk5Nxo+mZIiwBxSCR/K72Rye1XUmZl93j
	 xpazKaXkiVtHDRs/ynoupTVnUs/apAmVL58GSso6taWSFCCAy1IHNpN7tIEOHwErTHsyF
	 iJ93FuLyQOEhzX4JqxLyUKS+AYN0Dryb+zAGGpeCGvmt7T2oQyRIsZKhpXFuCJ/9qvCuO
	 99rBfS7Rqmy4Djv3QAtUGqU53ekRs01IUcmfFcSM7f+qu94BRmjIMaoxzf07wQsamOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211476;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=MsQ8valteIZ5FAN8NIHPhJwbS+ZgnCghMv51/bhGm/o=;
	b=o10Vu5Ednul2DiPN5zhtE1y8sSnrF+bIIu1jBBqScuZCZOnfz4qjt2ziUWDlpMWg37Py
	 xPmyJrxwYrdyaVj+g5XNfzWuMte1WaAbNXmDY3ES7wjnoGTFdvG0c0LXDQNls6nVbHaRW
	 5kIiRj3mMTOqgoDOrffEpgUYXtPs2ixTd57QxGHXOlEh/sTDG0HGaLtnjE6ShJjA4ZAn1
	 Si2WQ9oPz6TnwGwwuxcbp6+FgtrGWRV3qbJC0duVZ9Ae4meRJptxjka2JsFHhHfLvaPfO
	 lHM2jE78LGrVBVATxQ3dYIryvexs2dW5uAckd/Ye3L5CSOy3V/8nbdzF23SvbmI5EJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iw8vScn+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C95606A68E
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iw8vScn+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9F31F000D1;
	Fri, 20 Nov 2026 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211476;
	bh=MsQ8valteIZ5FAN8NIHPhJwbS+ZgnCghMv51/bhGm/o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iw8vScn+I8sZLVmFQ+/HIsyjHa/1666nJwTTbd5ww/kMOElMfkqq+3vt0WwvSwZZI
	 qszfZwTeNIM/a9ZVM0ioM1QSQh5240zugg5D1a7vdRUCxVU7P8m0UTuUUqxk9aePED
	 wRWEV/GkR6X/rdqrvLP6iywzum9+Oy37lva+Hg3VZX/35V5sleNpcXfrsZVDnQEz/h
	 3uaAZ0qumtKVE6KiARiEFlP7rym8SIhVe0AnPopseZ86Hr307Waw4zGaH0JXWjXW1D
	 YVx+kK6OnADeSQkQog1oJNL+Ns9BWZcUCmOGpciRocRIw1INiXh6zIn2vSFgoo40x8
	 lemctCgTr4FpA==
Content-Type: multipart/mixed; boundary="===============8017673217945945158=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5225b8e7bf006b35bdd1e703126228199682afe318c3b0557bcd02c5e964a312@mail.kernel.org>
In-Reply-To: <20261120204959.614908-45-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-45-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 44/49] selftests/bpf: Adjust tests to the new log text
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:15 +0000 (UTC)

--===============8017673217945945158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests to the new log text

TL;DR:
- Selftests: LOSES_BITS var_off pattern in verifier_trip_count.c may match an
  insn before the loop, so several tests could pass even if the verifier
  regressed
- Redundant ONCE (duplicate __not_msg) in spill tests

> diff --git a/tools/testing/selftests/bpf/progs/verifier_trip_count.c b/tools/testing/selftests/bpf/progs/verifier_trip_count.c

[ ... ]

> +/* No may_goto. __not_msg() searches only between the __msg() before it and the next one. */
> +#define NO_GUARD	__not_msg("has no trip count")
> +#define COUNT(n)	NO_GUARD __msg("has trip count " #n "{{$}}") NO_GUARD
> +#define ANY_COUNT	NO_GUARD __msg("has trip count") NO_GUARD
> +#define ONCE		NO_GUARD

[ ... ]

> +#define PARTIAL_SPILL_TEST(name, sz, count, expect, first, body)			\
> +SEC("socket")									\
> +__success __log_level(2)							\
> +expect COUNT(count)								\

[ ... ]

> +PARTIAL_SPILL_TEST(partial_spill32_inc, u32, 10, ONCE,
> +	SPILL32_0, "if r6 & 1 goto 2f;" SPILL32_INC "2:")

Since ONCE is NO_GUARD and COUNT() also begins with NO_GUARD, this expands to
two identical __not_msg("has no trip count") in a row with no __msg()
between them.

match_negative_msgs() searches only the first pattern of such a run, so the
second one is never looked for.  Because both strings are the same, no
different pattern is skipped here, but ONCE adds nothing over what COUNT()
already checks.

The same applies to partial_spill16_inc, partial_spill32_inc_in_nested_loop,
partial_spill32_two_slots and spill32_large_step.  Could ONCE be dropped from
these rows, or could PARTIAL_SPILL_TEST take the whole expectation?

[ ... ]

> +/* [0, max] that loses bits is in [0, max], and a bit that is 0 stays 0 */
> +#define LOSES_BITS(max)	NO_GUARD __msg("R7=scalar({{.*}}var_off=(0x0; " #max "))") COUNT(8)
> +
> +NOT_LINEAR_TEST(and_clears_a_bit, "r7 &= 255;", "r1 = 1; r1 <<= r6; r1 ^= -1; r7 &= r1;",
> +		LOSES_BITS(0xff))

Can the R7=scalar(...var_off=(0x0; 0xff)) pattern be matched by an insn that
runs before the loop?

The pattern has no anchor to a state or an insn, and match_positive_msgs()
searches from the start of the log.  The init insn ("r7 &= 255;", "r7 &= 64;"
or "r7 >>= 8;") already prints something like:

  R7=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))

AND and RSH call scalar_step_reset(), so no ",step=" suffix follows var_off
and the closing "))" matches too.

What is left is COUNT(8) and the absence of may_goto, which depend only on
r6.  If the verifier widened r7 to scalar() at the header, and_clears_a_bit,
and_on_the_right, and_0_or_64, zext32_or_nothing, rsh_on_one_path and
rsh_then_and would still pass.

and_64_to_127 right below uses RANGE(), whose "to N: " prefix only appears on
the state lines of the loop.  Would anchoring LOSES_BITS the same way make it
check the loop again, e.g.:

  __msg("to {{[0-9]+}}: {{.*}}R7=scalar({{.*}}var_off=(0x0; " #max "))")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============8017673217945945158==--
