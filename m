Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711190;
	b=lK1oeyntreWpECJt/b0UourXCP0QjX8fSxPLJD3q9+A+SV/cp7Bo8b0ulEiH6ox68pTE
	 VObKxvqRB4J+9PpF1tZepwddwcZeHz/OppBMfPMStHxGAdgmqSCKAYS0rjzVy7nfHCAQ/
	 Lkx4iCVa4yigQNOwpeYpMMyo83tpAr0hauwRz62YhhSXSFlsHA0rr5m/OWgX7XYtZyZNL
	 4JqdDQN9SRb2KSoHZYGUgaOw4O1NFNwq5fTN9QJt4XA8QeJO3++TUmUqznvJeu9i8DGcs
	 /dLHAnWGhDTDd0a1g597decV9oSpLhyWsnBMrZGk0xoI2zEGj4lJfscyoodNrngs7NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711190;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=4t5qgb3kRPkkx38LxHpP3L1ZUslZ1VfKOsMAe4GNMpk=;
	b=nivdtbs5rCz4WfLdsI3hqtLwkDAvSAtM+JC+/3yAvaLZ4PMtXO3d0a0JuTpBtlFR2Rkc
	 CxEkAL3ZwI6+L9ABHwDb21srbjdG07GA3tT7FgS2qeyNWgzF1PaeWpinh8niyXmxh2jJM
	 9xQ3oarUYBgobzatLIxa9JMCNQvUOSd8iUPrT9hNZmOGgWPRRoYbCb2ZjdPaDgzXYMESV
	 XoNQYFm/ToyTDBVU7KvZmqmnbx+/h31wwqX0hR3ZKO5hZLsHSWh1mfHtAYmaiPacGYPYf
	 zD+G3nzFqTN4iMZS9bmiCyxSnPH2CSimOtMte+TjZDNOMGVeQkx6lksNUm1ym0oR1sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/QqQ3Zp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923646083635
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/QqQ3Zp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91C1F0157F;
	Tue,  3 Nov 2026 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711190;
	bh=4t5qgb3kRPkkx38LxHpP3L1ZUslZ1VfKOsMAe4GNMpk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X/QqQ3ZpVUj/qXWcMuAp2cL/EfqG4U/8L4kVldR2ctbxhLmIM72xTo8854+nMEqqX
	 9i2P8bx11TrCUKd3TPSly99kOvYudJo9aBpkXwj8SHYY0kHiQtzw5MWJd8dpaLEmQu
	 0sl7fchg1YrH2Insj2aTnXcndSDBXz38Uvvkz1d3/c8fPlxYZHZ+++pV3vL4e5oIc+
	 SNg2j4SJu49svxwBlLQUudB+T9ApzTBnNY7lHKsqkAJom7zEuqacRlalL68eI8krjD
	 1b8F92mLyZUX9zCp1TwNHZDn5/abJ3/N1vfvanQTvcUJoZidwQ3hYQ19OW8DqS0iGk
	 PO0JPEfbIVIFQ==
Content-Type: multipart/mixed; boundary="===============5224988881577539910=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <241dc212e4511cc5c0aacd95e05d56548b14f600c345122ffe8ea54b47eb4ad9@mail.kernel.org>
In-Reply-To: <20261103122733.1383002-8-daniel@iogearbox.net>
References: <20261103122733.1383002-8-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 07/20] bpf: Move the division magic number selection out of the x86 JIT
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: puranjay@kernel.org,memxor@gmail.com,xukuohai@huaweicloud.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 13:06:29 +0000 (UTC)

--===============5224988881577539910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Move the division magic number selection out of the x86 JIT

TL;DR: Nit only: the long comment above bpf_magic_div() is hard to follow and
repeats the in-function comments and struct field comments; suggest trimming
it to what it fills in and when it returns false.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> +/*
> + * Magic number for the 64-bit division or modulo by the constant d of a
> + * BPF_DIV or BPF_MOD with BPF_K, signed per is_signed, as the JITs emit it:
> + * the high half of the product of the dividend, shifted right by pre for an
> + * unsigned division, and the multiplier m, shifted right by s, the add
> + * sequence of bpf_magic_udiv() instead when add is set, and for a signed
> + * division with the dividend added for corr > 0 or subtracted for corr < 0
> + * before the arithmetic shift and the sign bit of the quotient added after
> + * it. The dividend of an even unsigned divisor is shifted by the trailing
> + * zeros first when the magic number needs 65 bits otherwise, the one of the
> + * odd part then fits without the add sequence. Returns false for the
> + * divisors left to the division instruction: 0 and +-1, the unsigned ones
> + * above 2^63, which a negative d stands for, and a shift the sequences do
> + * not take, which d >= 2 never gives.
> + */
> +bool bpf_magic_div(s32 d, bool is_signed, struct bpf_div_magic *mag)

this isn't a bug, but could the comment above bpf_magic_div() be cut down
to what it fills in and when it returns false?

The opening sentence is one long chain of clauses that is hard to follow.
The trailing-zeros sentence and the closing "a shift the sequences do not
take, which d >= 2 never gives" clause repeat the comments inside the
function body ("Shift the dividend by the trailing zeros of an even
divisor first ..." and "Never hit for d >= 2, kept as a guard ...").  The
meaning of m/s/pre/corr/add is also described in the struct
bpf_div_magic field comments in include/linux/filter.h.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41637976292
--===============5224988881577539910==--
