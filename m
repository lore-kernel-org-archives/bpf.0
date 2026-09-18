Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27372347533
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707580; cv=none; b=frOZHo3lm1CBrZH6B42HWi5pMm4dtqSDgZ3acLbMtAoms7eIusRmJD/Rox0Oo5hJ2/LkTbpMn5NIp2wKX6qjJwUdVm7AapeHm9+sUGkJ8/ORAwBzn5GVSPm3V6R4vUF17NB1iynxZs5znLpvwWSSuHVPJQ12jRrp8gPIFyTzpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707580; c=relaxed/simple;
	bh=Hs3UDn2brMaHQhTqia0pSEM21Ku/o3apGuWfBRRhMrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WP5jf9v3uzygQxce+J/rD6zqdUHxTjLX4CcREdChN9o+hqpnOYmXXIJnVL/I13W7lYJBRm9TReykUBCFXtlV/aot/BlMBLhV4uleke/WXnxl0dG5evurmcK2iPLMPqzSUQMw9rBktWkkonTyQnPJO8fBkB7PQKAgICZwXkKGIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQp+AV2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQp+AV2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2F31F000FF;
	Fri, 18 Sep 2026 04:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707578;
	bh=VgrNGblQYiLcHYjY0i05T0CENURR12zYlCC8knzwAT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQp+AV2zlDGTHYtInzb8bZ3yqJozfsOrmQvyt5N/HYIgkUggwoUTjk3ddsr0BH5zO
	 iG/InVAS3vGgmnLDHz8n2NxcKt/uUkdhjRJ1Ko8UOTTWYm19Gnb8udfy3fvdNhcdOM
	 24AfyhIB50nnqQ8fHXyyEeejjbRcBgorTNNNXfPJTxJMhO5kxDNaeCWfyoj3UiWVZF
	 hXdqY96dBSpD+rMSlJaduofRpgoR4ks4nPDabvi9bPpFO2V2TtdHtT4oYVN0vwi0DP
	 CzhWl2gASUq8QBCbDzB6XixT+83mMtgOkhTSoR/8bh3caMHKOPZGeBaiyTKLYve/98
	 bZqBrffVrjwww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/20] bpf: Make exception landing pads
 reachable in the CFG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918044221.3287431-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044221.3287431-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 04:59:38 +0000
Message-Id: <20260918045938.AD2F31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing prune point at exception landing pad target
--

commit 4fbd0e36862ba7e3ee8480e535068a6821d5cad0
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Make exception landing pads reachable in the CFG

This commit updates the verifier's control flow graph and liveness analysis
to properly handle exception landing pads. It ensures that exception throwi=
ng
calls can reach cleanup records, and prevents outer frame stack slots from
being read incorrectly when control is transferred to landing pads.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 842c7d1eabccc..9f8b8b54d5ea7 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c

[ ... ]

> @@ -158,17 +159,57 @@ static int push_insn(int t, int w, int e, struct bp=
f_verifier_env *env)
>  	return DONE_EXPLORING;
>  }
> =20
> +static int visit_cleanup_pad_edge(int t, struct bpf_verifier_env *env)
> +{
> +	int *insn_stack =3D env->cfg.insn_stack;
> +	int *insn_state =3D env->cfg.insn_state;
> +	int w;
> +
> +	if (!env->cleanup_info_cnt)
> +		return DONE_EXPLORING;
> +	w =3D bpf_cleanup_pad_of_call(env, t);
> +	if (w < 0)
> +		return DONE_EXPLORING;
> +
> +	mark_prune_point(env, t);
> +	mark_jmp_point(env, w);
> +	mark_jump_target(env, w);

[Severity: High]
Should mark_prune_point() be applied to the landing pad target w instead of
the call site t?

Because w is a branch target where control flow merges, it needs to be mark=
ed
as a prune point so the verifier knows to check for state convergence. By
marking t instead of w, the verifier will evaluate the landing pad and all
subsequent cleanup instructions independently for every exception-throwing
call that branches to w.

Can this lead to combinatorial path explosion and result in the verifier
rejecting the program with -E2BIG?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918044156.3283=
973-1-yonghong.song@linux.dev?part=3D5
