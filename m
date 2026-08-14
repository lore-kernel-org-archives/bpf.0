Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6171A9B24
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676562; cv=none; b=GYwc7qRWtn/7HIBcNtut/wgS61xF0CvcdjyspDzNm2SisigEvbPMTyWHLeAo5WcJsSBMzMDM5/XynQ4cpTwCOmzPuHkDgZD23lk2XF839AUn4NucgQER8bWwHpxCf++6tGiv5GZldV4cD2ssS8Nrg3IK39YBaqqHXpxJvrPt/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676562; c=relaxed/simple;
	bh=yC5Hqd7WpP8xTto5b01ibbH4NuR+I9X5ZzOSnDJ1Mkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eMu18NXbSWb/V5La3lKhqt2xm/85DbphikkFyABdscbp9TCtWVfCY9WPaNiPN9TWUla5GSXKCNsJiN4iFK7CAF9piJC9KFjN68YqChVsL8YPngWav44z+1R4JxrPAiQ9npD+aKKeLZiE1Px/tN+m5kDRuoXr7hWuiP1W+zA/52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4d9fLO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4d9fLO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9981F000E9;
	Fri, 14 Aug 2026 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786676560;
	bh=vabbb/RPG/mQAoeskokW/7FdTh63iZd/gESOydAkRAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4d9fLO7KTss4iNWmkJe08AbOjX656J3OpgdvmNIP6tMPjY97QCAvOGGsorY44Upg
	 EW0AJxlyEDsRnL5vNsawSPEWFgYTw1tSfy4WCoPeM/kgfxO+ehxXfaH0xUnQboDIS6
	 NB9uQFWVZMmKUVv/f7/gTD1/ax2O/tGgWoh/oVlPmMjSJuLBoeTTl2TpMz1nhsNU6m
	 MOnnNor2yCYN+dPjHzdqKXPDmTAltisFhA1sa2aqYeUSf5sPUDf7H3NwxMfTHaEKtU
	 UPjkpRhkV6ufhDvmtcqM6IuDjo3FEFd46/FdX/5k0LqDvJpP8Q+IQonZwgUcaSzBc6
	 jg1ZH/Sxs0VUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 08/11] bpf: Reject register-pair returns
 when the subprog BTF is unreliable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813200250.1996395-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200250.1996395-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 03:02:39 +0000
Message-Id: <20260814030240.5E9981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] push_callback_call() incorrectly passes helper arguments for BTF v=
alidation, tainting callback subprograms as unreliable.
--

--- Patch [8]: [PATCH bpf-next v5 08/11] bpf: Reject register-pair returns =
when the subprog BTF is unreliable ---
commit c1362d6d7ccc6806c96ffe9fc78804a2b8b6f1b9
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject register-pair returns when the subprog BTF is unreliable

This patch rejects return values larger than 8 bytes as soon as the
subprogram's BTF prototype is marked unreliable. It adds
subprog_ret_pair_unreliable() and uses it in check_func_call() to
prevent tracking R2 based on a discarded signature.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b23be0fa95af4..0ffb3bed1649e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9527,6 +9544,12 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>  		return 0;
>  	}
> =20
> +	if (subprog_ret_pair_unreliable(env, subprog)) {
> +		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable=
 BTF\n",
> +			subprog, subprog_name(env, subprog));
> +		return -EINVAL;
> +	}

[Severity: High]
This is a pre-existing issue, but will this new check incorrectly reject
valid BPF programs because of how push_callback_call() marks subprograms
as unreliable?

Looking at push_callback_call():

    caller =3D state->frame[state->curframe];
    err =3D btf_check_subprog_call(env, subprog, caller->regs);

It passes the caller's registers (which contain the helper arguments, e.g.,
the PTR_TO_FUNC for bpf_loop) instead of the actual arguments the callback
will receive. Because these arguments don't match the callback's prototype,
btf_check_subprog_call() fails, sets the unreliable flag to true on the
subprogram, and returns -EINVAL.

push_callback_call() ignores this error, leaving the callback permanently
tainted as unreliable.

If a callback subprogram returns >8 bytes, won't it be incorrectly rejected
here if it is also called directly elsewhere in the program, since the
unreliability flag was set mistakenly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813200210.1991=
507-1-yonghong.song@linux.dev?part=3D8
