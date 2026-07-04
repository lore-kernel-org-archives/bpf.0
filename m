Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C23238171
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783141470; cv=none; b=i3zdi3qNjpTb8cXEh8ihGYvCpNWltsnUOf4ZXuA3Pry65ciQXUsADRxLB774VufX0zNwgdHcGTU1aB/NFiNF8m6/Cr6ZHJda2rtnUgzG3dJQ3C2EDECu2eIfZtpbkmrD3iNgfcIARzv9OMLWYGoaLO8LIYqZ37DQXih3ymEsEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783141470; c=relaxed/simple;
	bh=+IXRDFCnFo4dZr75mm9TjRMs+Uq3MaeuBC063EFbFIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Deq3yoVCDOr3UzPbUMlV5/zZMpY92HMStLYq18vFwSx6i9jIYA/DfDQydOMlJLCPzalLcX/XTDWKxzxpDgVduPYMW2JM+XYPhLGqci2DL0XjLE3N8AccgpXJotn6anK4URH/McvcVTvEIR0cfIO8exT2HshkQCfvHNoxALz3myo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROdKaTPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROdKaTPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328271F000E9;
	Sat,  4 Jul 2026 05:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783141469;
	bh=xZMswnoSHoXM1YCdu7Ie+wyI4armVuIim/B/UNkfA7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ROdKaTPiUxwRr6KHxmDBXSY8DXzhUPQeDDEVvtNYatXh14/4UhmYkpFCnUbGi16qB
	 H60VZrDhV3+o5Y60iy9QAwfXMAngggReXXkXczPAKL4SmiZTMMttuQYHgR+zT244BU
	 DxlRnTz3J1q9aLk2bGk4/Mu9CsO34xkWyBQukIltwjOCQDWPWo0QiMTdZoTbcmIAWU
	 HDwGAoyPf3yemwWJ8+jvjzAQL1f3jznCAmUWw+wn9fxH7VcciMJTzjZo+5btKHc0Hr
	 UU+VrTXMG5aVU+kXLlCwF30+Q64bMXWhgujt1jDghKDMvjh/Xu6dk/4hHC4G/247CX
	 LnhzYE5Qqnu4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] selftests/bpf: add memcg_stat_churn_percpu
 BPF-vs-memory.stat benchmark under cross-CPU churn
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: mkoutny@suse.com, tj@kernel.org, hannes@cmpxchg.org, bpf@vger.kernel.org
In-Reply-To: <20260704045617.487664-4-ziyang.meme@gmail.com>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
 <20260704045617.487664-4-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 05:04:28 +0000
Message-Id: <20260704050429.328271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Forked long-running child processes lack a parent-death signal, =
leading to runaway CPU-bound orphans if the test runner is forcefully termi=
nated.
--

commit 0078545540e155786a22dbc2aaffa44f31944e3b
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests/bpf: add memcg_stat_churn_percpu BPF-vs-memory.stat benchmark und=
er cross-CPU churn

This commit introduces a new test_progs benchmark to evaluate memory-cgroup
statistics reading under cross-CPU churn. It forks multiple churner child
processes that migrate across CPUs and constantly allocate and free memory.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_stat_churn_perc=
pu.c b/tools/testing/selftests/bpf/prog_tests/memcg_stat_churn_percpu.c
> new file mode 100644
> index 0000000000000..16c3f261c8780
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_stat_churn_percpu.c

[ ... ]

> +static void churner_child(const struct cg_node *leaf, int base, int k,
> +			  size_t region_bytes, size_t resident_bytes)
> +{
> +	int c_pool =3D n_cpu - n_reserved;
> +	void *resident;
> +	int j =3D 0;

[ ... ]

> +	if (write(churn_ready[1], "x", 1) !=3D 1)
> +		_exit(3);
> +	close(churn_ready[1]);	/* so a sibling's early death yields EOF, not a =
parent hang */
> +
> +	while (!ctl->stop) {
> +		void *p;
> +
> +		/* migrate to the next of our K CPUs, then dirty the leaf there */

[Severity: Medium]
Will these child processes run indefinitely as CPU-bound orphans if the test
runner is abruptly terminated?

Since the loop relies on the parent safely executing the cleanup path to set
ctl->stop =3D 1, a hard crash or a timeout (like a SIGKILL from a CI system)
could leave these processes running forever.

Would it make sense to call prctl(PR_SET_PDEATHSIG, SIGKILL) early in this
function so the kernel automatically cleans them up if the parent dies?

> +		pin_cpu(cpu_list[n_reserved + (base + j) % c_pool]);
> +		if (++j =3D=3D k)
> +			j =3D 0;
> +
> +		p =3D mmap(NULL, region_bytes, PROT_READ | PROT_WRITE,
> +			 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704045617.4876=
64-1-ziyang.meme@gmail.com?part=3D3
