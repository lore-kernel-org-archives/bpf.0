Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64030567D
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466015; cv=none; b=DNTGIrhLZXf5GgXoNHpWpnAgNnzwvUAPEZId3YVksozOKgIborE4xeZXnHL1s1DSKtM0Ah9FwE8Ign9CLCifu3jglapxkeCxgHEiFA3pbjA68yaFxP9e23U5rbDis32KgG/7N3mxr+W8q6VIbMmWl32jJZv0ZLHPxXXGGhdim8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466015; c=relaxed/simple;
	bh=L3TruuEbj1BOmNLrlLvJ8rZoVPPdMjfR27jkcwBsexk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IApwgnB63BWFJQgmx1m81dC/yviUMB8pwIIvFZatg1AuaD1IiWz7523XWpMhYCynZrN8CInRT+ac8TXpweiB9VAH62LCYtKsW0PKI37w8jd4o5eWDzKe6EThGPSVYSs9rjNeXPLaznvK1MOF2+nKQN3krZp/OPNyL1zxBtzeyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq/rDcKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq/rDcKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F2E1F000E9;
	Fri, 31 Jul 2026 02:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785466014;
	bh=iYsHEw3yn340H5GeUlCnzUMfTjzKVoC/t9JvtGe4y3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qq/rDcKp69zBfJ1LeVyQEbcu/gmT1ldGCp6PWafU80vyg8tioFxS/rIU7NCfnbYUi
	 oRxvLQR0tJmn7WcrAwDIrL2R6MdRvil6yE4Jy4c2w3WX6zz0j+5eZdtaNK6P/j1gH8
	 mpTA4J7Ag1ruMt2CahZKmAnPuc3Jx6jBskpCvwpfHFtADEM5nAs+KcgAFnF4oUIL8P
	 5Rbjav2JazUkMId5wMJLzkLLj4nxysnvfdtBMLEmPqonqweR5Fs4bVJgbjyQWDPj3u
	 viQKR6nL0KkJJvBNnXXcapB4YKBS9fgtUq1+eq6O9iqdPxG+Db7Za9j8Sf6M28vbcC
	 gM0MiiUZGqaxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 08/13] bpf: Add the bpf_landlock_put_ruleset
 kfunc and ruleset destructor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731022047.189137-9-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <20260731022047.189137-9-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 02:46:53 +0000
Message-Id: <20260731024654.10F2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf_landlock_put_ruleset is incorrectly restricted to only two L=
SM hooks, contradicting the documented design.
- [Medium] bpf_landlock_put_ruleset is marked KF_SLEEPABLE, which breaks kp=
tr semantics by preventing non-sleepable programs from releasing acquired r=
ulesets.
--

--- Patch [8]: [PATCH bpf-next 08/13] bpf: Add the bpf_landlock_put_ruleset=
 kfunc and ruleset destructor ---
commit c8093884a93ea01a073e8cc7633e2b790c416510
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Add the bpf_landlock_put_ruleset kfunc and ruleset destructor

This commit adds a release kfunc for Landlock ruleset references. It provid=
es
a way to drop references when handing them over through a map kptr field,
registering a destructor for map teardown.

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index dd58c5bd01193..877dd03526077 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c

[ ... ]

>  BTF_KFUNCS_START(bpf_landlock_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_landlock_kfunc_ids)

[Severity: Medium]
The commit message mentions that "the release path may thus run from a
context that cannot sleep". Does adding the KF_SLEEPABLE flag here contradi=
ct
that requirement?

It appears this flag will cause the verifier to reject non-sleepable LSM
programs (like standard RCU-based programs) if they try to release a ruleset
reference they just acquired from a map.

[ ... ]

> @@ -498,6 +540,17 @@ static int bpf_landlock_kfunc_filter(const struct bp=
f_prog *prog, u32 kfunc_id)
>  	case BPF_PROG_TYPE_SYSCALL:
>  		return 0;
>  	case BPF_PROG_TYPE_LSM:
> +		/*
> +		 * BPF_LSM_CGROUP programs run under classic RCU and
> +		 * cannot sleep.
> +		 */
> +		if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> +			return -EACCES;
> +
> +		if (!btf_id_set_contains(&bpf_landlock_kfunc_hooks,
> +					 prog->aux->attach_btf_id))
> +			return -EACCES;
> +
>  		return 0;

[Severity: Medium]
Does this check unintentionally restrict the bpf_landlock_put_ruleset kfunc
from being used by other LSM hooks?

Because bpf_landlock_put_ruleset is evaluated by this filter, it seems any
LSM program attached to a hook outside of bpf_landlock_kfunc_hooks
(bprm_creds_for_exec and bprm_creds_from_file) will fail verification if it
tries to release a ruleset. If an LSM program on a different hook retrieves=
 a
ruleset via bpf_kptr_xchg, shouldn't it be permitted to release it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731022047.1891=
37-1-utilityemal77@gmail.com?part=3D8
