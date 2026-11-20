Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163143;
	b=i1eaRQECfErq2R8pxWUauUIRKOEP8Hr5omHknA/nnmbwwwTe9cLchBjOFk+Xu1bmQdFo
	 ocdZRmeXSpn9ytCDu6GggVIAqqoRMJtpI/FANQQw7+g8hxgeH1rxj9I5bcP70/Y12KctT
	 LPct5dE61mOK1GixVKGoEl0SlTxra333LSjsORwlKwzbmlu7vL5f0HGEU2DP7UTEZrQGX
	 xcq2VFat7wY34y3vbtbHE+/3LAkxjktEyo7K3VbujxaSQFRVP/6kRd+P4VivzTCiaAQ0S
	 B99NzWfz70Ht0JRhcOUilFo3mry3NFgMA/j9w2COKhYZNPUFgSQraWTuRLO4UeJHaRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163143;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pdPyhUsK30b9rpr31WRJwqRTUUJEB8eBDJfjvzcQnrs=;
	b=Hf6GS4XgAX1uGSjhXIa/w2osJPETPiQuMXLZZ+dVaBrytwoB9J7hFoCdIWhKrv6XeRKc
	 JjBHmPK4LjoquvWauCeegakVX59f9BJeygnGp6fd/RbsHcSgHrlR8UUTFdf4XzlF59qPL
	 aQ4DsVRQNjMdZOv9bp3RgYErMdzraWq5QCif0dFl2q/A/ILn0fzwf1e3EEcpM7/m3Znuu
	 PUIuPdtEtWq6CmTovSQd89ti3aBxiPvKw6O6w9XxTK30ZsiaHZB4WruUhhUzHloqUCD1H
	 WEgOYEBTACZguJH7EOdgzy+c0Ii2rTvlguMlE2JEGPC18RVHX50cA65dsyQpKePblPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auz2NdJN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB9606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auz2NdJN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2F21F000C4;
	Fri, 20 Nov 2026 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163143;
	bh=pdPyhUsK30b9rpr31WRJwqRTUUJEB8eBDJfjvzcQnrs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=auz2NdJN2P/mzmjGROI+Jrs4dAfs8cym6aB1OgbjlPFdJRvgBhXa/twsZZN1xTRfq
	 Mez5bWDe/ccmb9OhPFOPY+H3dTlY73esczH5fB8UN8u9RC1Nv46K/z8lNJfbaWmGn1
	 ILGomri7OfCdJx842Si6/Xr7nxzT8A4LowHh8Qgt8UspO47g37Y2H1SydbmxHgt77/
	 NztFrn1q+fmCGk2+EznOhRwc95TWsRe3PuDG9ULq4AIASW99p7LavSO86gnhXPEm0g
	 z4lZxgJzBLWd+FFuvlGLXkErGwQl7+yTAg9cdhaQqxc7yeyYF4eAcwDDDd4EJaVQr8
	 4EiSvHuvkCOXg==
Message-ID: <sashiko-outbox-224728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 25/49] bpf: Join any two states that have the
 same join_key
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-26-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-26-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:25:42 +0000
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
- [Medium] bpf: missing env->mem adjustment on error in
  bpf_loop_collect_thresholds()
--

commit 666a19a48516a34b60842263fb6f1aaa87b240b3
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Join any two states that have the same join_key

This commit implements total state joining in place for any two verifier
states sharing a join_key, along with loop-constant threshold collection for
scalar widening at loop headers.

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> index f8b2f8befa601..23c443ab3a23e 100644
> --- a/kernel/bpf/loops.c
> +++ b/kernel/bpf/loops.c
[ ... ]
> @@ -555,3 +556,109 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
[ ... ]
> +static int add_threshold(struct bpf_verifier_env *env, struct bpf_loop *=
loop, s64 k)
> +{
> +	if (!bpf_grow_array(env, &loop->thresholds, &loop->threshold_cap, loop-=
>threshold_cnt + 1,
> +			    sizeof(k)))
> +		return -ENOMEM;
> +	loop->thresholds[loop->threshold_cnt++] =3D k;
> +	return 0;
> +}
[ ... ]
> +/* The constants in the body of @loop and in the functions that it calls=
 */
> +int bpf_loop_collect_thresholds(struct bpf_verifier_env *env, struct bpf=
_loop *loop)
> +{
[ ... ]
> +	err =3D err ?: add_threshold(env, loop, 0) ?:
> +	      bpf_add_cost_and_check(env, loop->threshold_cnt * ilog2(loop->thr=
eshold_cnt),
> +				     BPF_COST_COPY);
> +	if (err) {
> +		/* only the pass ends, the next pass starts again */
> +		kvfree(loop->thresholds);
> +		loop->thresholds =3D NULL;
> +		loop->threshold_cnt =3D loop->threshold_cap =3D 0;
> +		return err;
> +	}

[Severity: Medium]
Does this error path leak loop->threshold_cap * sizeof(s64) in env->mem?

add_threshold() calls bpf_grow_array(), which charges the allocated capacity
to env->mem.  If bpf_loop_collect_thresholds() later fails (for example,
when bpf_add_cost_and_check() hits the per-pass cost limit
env->pass_max_cost), freeing loop->thresholds and zeroing
loop->threshold_cap without subtracting loop->threshold_cap * sizeof(s64)
from env->mem leaves env->mem inflated across subsequent passes, which can
cause a later pass to hit env->max_mem (-E2BIG) prematurely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D25
