Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161703;
	b=wzcVg8g0sVyB4hlrR5jmtdHohOO4GR+KSFqYZnt948XqGSoXtZEiQGAzCx3BhGM3F3Y5
	 P+YAA/+QsBCZwsmszkoUt93FyDllJs8mQRVsBGKDnb53VWmE6Fw8SwBr9rwIMU2IWwR8R
	 38jW5jW43c/X/0lD3gNnU1kc9Eg+3md1O9FAsAdnX4ze66AscHi7j3jUgJyTPw8M1bbD7
	 k7skv90fcEnxK48lsoY7+5JzwRfKJ2wCilly6jMF6B5BRuef+6F075SzyRrOpe/fKU+U0
	 guVIpARF9cBTmzk6+XmXjpj6fL4UCVrfzDuZlNbrfkyZ3tNYV+/ECfSCd7eWf9GBI0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161703;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dgZ6iZshEp0n7RwGN3da93wNmRA9hZ6YAlDpq86d6cI=;
	b=OIeaPvpen/e8ntjBY74XSme0jYnFui7JI97B497RqVzLTQFPHJ4hUEMnEEm1ysQMj20W
	 CgY1ogARuT7sPpVMcrew6AbJ3ruJqlrAI2RudynvTKMIwwpTgam0O1Jn3u5tnGeTL7MUE
	 M+BLEAtUYEYsv8eaCk2NLtRsHrvfjuBn5Oo+G3bCXtn8szuelK49oKdfKXbHzpgOOU/YG
	 mTNfzQXDABuYMyleSoNuvVFKAJuri2KopndLRA76kVYslzu+wcjr8xGr01ewXTRoG6dan
	 4wBF5+GpGmorWHARfjUobTIfaM8cqcurQqnhpF8Gvk41dW1XswacjQ99pDgNCoBsLTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oRXTYa8L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CBA606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oRXTYa8L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FBF1F000C4;
	Fri, 20 Nov 2026 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161703;
	bh=dgZ6iZshEp0n7RwGN3da93wNmRA9hZ6YAlDpq86d6cI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oRXTYa8LoHp/Tx04404NAhSNwigN7iEGySADYKwvV+UtqFbF0zbI//1cMs1sp8Qfw
	 bHjdSLgyqnUy9sTm8g0wvbd6kioO6JdV0sVkL8igURbW0bPJWPCaW/zIXXygkvU5Hs
	 yf2F5rZPSZDKAPRfB+KrIW4LxFDUtDZpxMFbESqUHJRBRge338bzRbeNfHc9UUaqxK
	 1ikVlgSnzwGVlC4GimAXq9LzuuABHunXg4SqH2EnBWbs5biaiCb64xRLdY0GlWoQSw
	 yfGGCeKq23mFq9bnFfdryKsoU8d8ZZcTcEeK8GAD07cOgY8w1zsRcERbr/ZWpwqShS
	 Kfuk/PJ79ALLA==
Message-ID: <sashiko-outbox-224675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 02/49] bpf: Make stack liveness faster
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-3-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:01:42 +0000
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
- [High] bpf: build failure in arg_track_join_all() due to undeclared
  identifiers
--

commit cea430c3bc4cf95a99331bfb62eb0f7db9d5efe1
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Make stack liveness faster

This commit speeds up BPF stack liveness analysis by visiting only
instructions whose input changed, using memcpy() and memcmp() for slot
joins, and converting half-slots to slots by words.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index cfa416f762097..bd186d3c201a3 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -1103,9 +1111,18 @@ static bool arg_track_join_all(struct bpf_verifier=
_env *env, int idx, int target
>  	bool changed =3D false;
>  	int r;
> =20
> +	if (!arg_is_visited(&in[BPF_REG_FP])) {
> +		memcpy(in, out, MAX_AT_TRACK_REGS * sizeof(*in));
> +		memcpy(stack_in, stack_out, nslots * sizeof(*stack_in));
> +		return true;
> +	}
>  	for (r =3D 0; r < MAX_AT_TRACK_REGS; r++)
>  		changed |=3D arg_track_join(env, idx, target, r, &in[r], out[r]);
> -	for (r =3D 0; r < nslots; r++)
> +	same =3D !memcmp(stack_in, stack_out, nslots * sizeof(*stack_in));
> +	/* a change pays for the next visit of @target too */
> +	bpf_add_cost(env, MAX_AT_TRACK_REGS + nslots,
> +		     same && !changed ? BPF_COST_COPY : BPF_COST_XREG);
> +	for (r =3D 0; r < nslots && !same; r++)
>  		changed |=3D arg_track_join(env, idx, target, -r - 1, &stack_in[r], st=
ack_out[r]);
>  	return changed;
>  }

[Severity: High]
Does arg_track_join_all() fail to build here because same, bpf_add_cost(),
BPF_COST_COPY, and BPF_COST_XREG are undeclared?  These identifiers are
only declared and defined later in the series in commit "bpf: Limit the
cost and the memory of a load", breaking compilation and git bisection at
this commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D2
