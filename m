Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD9363C77
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777823641; cv=none; b=EDV+rrfRln3h+lexbxxKBqenD68wqY7mxUVkR1Fbl0la8yJnncua6v9LSFUAHuI6HMNK4zgXxeGZn2YpVOvqp4QODd1s63BsZw3VHmI92dpAn2a/Iheit36vAdX+YZdFKX3nNrQe2FgYau7Khyswfy9eCooiy+XUjkDOUc/zhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777823641; c=relaxed/simple;
	bh=0xfqIZmjySdMAQr056w2EhnKa4+/XNRWMcCvS+17AWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRSgOeorc255lvvZ40ecdWzmFANTJ8UXpnndHqHyIkb5L6BntX3TF48TZxuGrbpc0ku+OX7gDxO5Lk0p2vHlBxG2tyNVj6RXayy+7FfmNj3Fht8D+R/dlCwASHtrFGkw7ZyhZPxzkI3R7U4u3dL/RNPf5LjIcbv7vJaJyhQIqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Imtb4TzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imtb4TzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE68C2BCB4;
	Sun,  3 May 2026 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777823641;
	bh=0xfqIZmjySdMAQr056w2EhnKa4+/XNRWMcCvS+17AWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Imtb4TzEbB7fgSFvUzIfShvmbwJPyHUc+StFugJcNXcINL7moYR7gi8WtxChvKJ0M
	 Wy5CCCs7wxGrJ8dRsh8MGeMs6qMkvpyMKRk9NlZ2iiPb/VeEf8uDAJysnxprIM8+tN
	 CPAaEWWNkW1/LG0Ja8S3u5mdrQfJ1JhoRESeL7giAOAM6PkwQiael9pkQcnSme+h1n
	 YxQu/7z5WqnLuc6WwAp33zffbjj+7o3mZEoam1zy6mzTYzFscwwGlcCi05RXAkkDGP
	 kR0e+4SzbAvTAACoH5M377R6ZTmohGOmvlC412foPglLRSwNTMoJn3mmomXxRPZiPU
	 3bCAVD/TI4pZw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
Reply-To: sashiko@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503153730.541685-1-atomlin@atomlin.com>
References: <20260503153730.541685-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 15:54:00 +0000
Message-Id: <20260503155400.CFE68C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The kernel is prematurely tainted during the BPF verifier's static=
 analysis phase, causing false-positive taints and potential panics for rej=
ected programs.
--

commit 58605e7e9b9266affb08aa0c20744ecff2dd01d4
Author: Aaron Tomlin <atomlin@atomlin.com>

bpf: introduce TAINT_UNSAFE_BPF for mutating helpers

This commit introduces a new kernel taint flag (TAINT_UNSAFE_BPF) to indica=
te
when an eBPF program utilizing mutating helpers like bpf_probe_write_user()
or bpf_override_return() is loaded.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f..cf0634d8901f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10287,6 +10287,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		return err;
>  	}
> =20
> +	/*
> +	 * Taint the kernel if the program attempts to use mutating
> +	 * helpers.
> +	 */
> +	if (func_id =3D=3D BPF_FUNC_probe_write_user ||
> +	    func_id =3D=3D BPF_FUNC_override_return)
> +		add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);

Is it possible for the kernel to be tainted here even if the program is
ultimately rejected by the verifier?

check_helper_call() is executed during the verifier's static analysis phase.
If the program fails verification later (for example, failing the
GPL-compatibility check immediately following this code, or encountering an
invalid memory access), the program is safely rejected and never loaded.

Because add_taint() synchronously modifies global state, wouldn't the kernel
remain permanently tainted in this scenario, falsely indicating a compromis=
ed
state?=20

Furthermore, if panic_on_taint is enabled, could a user trigger a panic
merely by attempting to load a malformed program that contains these helper=
s?

Could this be addressed by recording the intent to taint within the program=
's
auxiliary data during verification, and only invoking add_taint() once the
program has successfully passed all checks and is definitively loaded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503153730.5416=
85-1-atomlin@atomlin.com?part=3D1
