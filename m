Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163621;
	b=fps5f9uaW4fXbZe3V1URIjiKZKK3AjQ71Jv0V6vTxhW3oau/GHlFZJ0dNhOdosV74o2I
	 Ur3X/+7ISAecUAla1jYdGss3Ly3/YcRVzOcWTsgHSFlLEiKAxea/sZF5uMef8uX/xP9B1
	 z6vXk+cqsB9IHHlNlsZTiJJxrBTAbbKHyq/YDSldPdzIbs1mPPYf1jygm1Y0QZT9HLyiC
	 cCaryIxYlC4dkJLCB4zKJLJcpEc7HAgruFKmt3aXoDl/WnEpC6sdOT0wt0ZERpAwcNROM
	 nJPPpP0jH912w25S/Ftujuy/M5nX+HD05N6/7o4iypJu+pVd6HSrbGZ4BgaFKMYa92Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163621;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FEbh7yAi9iSK2V/tM2bexKGuHXhQ67O6d+UguPwpiq4=;
	b=c42ExaY4UiK2OM6eiPxdMj5ZRc6K9B1wV8tSEJ0aRlxiwWyBzkw3bW3PqZEq5B4qscXt
	 dep6N7obJQLp6mbFYhFm+Pr7GmNZdL3n8H1MjeVV8pFJv4KzIgGXMJYTWlFKrOFC/SIYV
	 roD1v2L1DQF+FYArdhCcbczI/IC/ho1C6STrlIXOz+pyQ4sT9dTv44c775ULNLuWlqogc
	 DJFVjCZyV8ZE52ErnxIioJ3znHxxzTkmLxXlfJ36ePBai65I0HV06CdNQlPkZ9yFdrHxM
	 nMrvMhILkcOWV6ytb/eWkOx0zIlNT7sv/rzWpA7oQwaOK+0tZhXXVcl6cZhVPXGb/zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIoIIHEC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026D606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIoIIHEC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6E31F000C4;
	Fri, 20 Nov 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163621;
	bh=FEbh7yAi9iSK2V/tM2bexKGuHXhQ67O6d+UguPwpiq4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IIoIIHECN9psm1niAeFDf69XidvQlIUkJNTCN+Zfm88M5J3fDe+Ml57suxCTsMigJ
	 1lViByKPLxWEMfUCtHmdYW9pqmI25H7NOqEqVb+zcAf6zNATA38Nk25JRGt7ryK4v8
	 gfoU1As+SAFW/Euv27QfVzLPxVAgw7l61+pAMRUXlYqSFkdOPKH8m48c0Zz289i7nY
	 /RqdgrTe5XnHjerhB2KCfnVxUw/CCFo0tJoDePaXWVBOC+CqkLTV8DFAPAvDsXDyMM
	 nkmSC30HXskIl1M9GA3pfpu75tDZ0SzRX9aQgCpua3gEbxWV0n8pFwvXTdIDQQ2mbm
	 HJ4X/3shnESnQ==
Message-ID: <sashiko-outbox-224741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 33/49] bpf: Verify a static function once for
 each instance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-34-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-34-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:33:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: missing early return in do_check_block() after
  check_func_callx_set()
--

commit 609a14fb5ab2e00b0fa47a3b3041980c47a05bcf
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify a static function once for each instance

This commit verifies static functions that do not access their caller's
frames once per instance, joining call states only at the function entry
instruction within a per-function instance budget.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6373505c672d9..4068014fedc5d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21530,6 +21539,9 @@ static int do_check_block(struct bpf_verifier_env=
 *env, int prev_insn_idx)
>  		from_unproven =3D reads_from_unproven(env);
>  		fixups =3D insn_aux->fixups;
>  		err =3D do_check_insn(env, &do_print_state) ?: bpf_equations_after_ins=
n(env);
> +		/* a call or an exit gave the state to the flow, the error is from the=
re */
> +		if (err < 0 && !state->frame[0])
> +			return err;
>  		insn_aux->releases |=3D held_cnt(state) < held && err !=3D PROCESS_BPF=
_EXIT;
>  		insn_aux->acquires |=3D held_cnt(state) > held;
>  		if (nospec_ends_path(env, state, err)) {

[Severity: Medium]
Does checking !state->frame[0] miss negative errors returned through
check_func_callx_set()?

When a callx instruction targets a set of functions,
check_func_callx_set() passes a temporary copy as env->cur_state to
check_func_callx_one() -> call_func_on_its_own() -> bpf_flow_call() and
then restores env->cur_state =3D cur:

kernel/bpf/verifier.c:check_func_callx_set() {
    ...
		if (!err) {
			env->cur_state =3D copy;
			err =3D check_func_callx_one(env, set->subprog[i], insn_idx);
			env->cur_state =3D cur;
		}
		bpf_free_verifier_state(env, copy, true);
    ...
}

bpf_flow_call() consumes copy via swap(w->st, *caller), leaving
state->frame[0] in cur non-NULL.  If flow_apply_exit() then returns a
negative recoverable error (such as from bpf_flow_edge_unproven()),
do_check_block() skips this early return and falls into the
error_is_recoverable(err) path for the callx instruction itself, recording
the error on the callx instruction and continuing the pass via
skip_unproven_insn() when last_unproven_left was already decremented to 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D33
