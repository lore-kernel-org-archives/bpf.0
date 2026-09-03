Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049B4D8DBD
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449507; cv=none; b=Ot3tsV+VWXZiIGA87/zrrpXYdnQDs7Ldxevq3Mzn1HT5KkNzd4YBCKRTGUtyjVnI1fHeKf2KDw+pjvJuTSh+IrbRLVtooi72IrSCuF7Lz/hrubh7R6PguwCNpmtFj4yNtIzyFga7cWGU36xugaoygFp/tB4fitNjIBIOdCDAgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449507; c=relaxed/simple;
	bh=eUlW+RZz2Ce7/idL6hj/GaeZYK2spWwEfbuHrX9BiaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VIrRNAHO8RPBPz9H5mqIC5n4dpdlnvkaXJ4WKyzZ+hRdasPzx+OG2CZo9XHR2mrrVAs0G7N+6dfOeHGGO2aiDAX0u3i9kq7GyIlfRC47LmOgAVJHvKQ4EIG80ej+kYJV8QWEgZYKi/mUaWbsQQTR7SlUixFR8f+7G/nNb0W5N/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSvpAb/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSvpAb/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A81F00A3A;
	Thu,  3 Sep 2026 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788449506;
	bh=EQOrnDcmZWhfuNcuiez4n2sfxveYLEs8NYujwDE7C9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gSvpAb/AXzMOfrbQ0P5bmkEj/6172Ve8TwFOKRjogO7CDJJ8OmNWdz/qWN/UJhLj1
	 t8ziSayKIPQQdsvzgr/VRAMcFbK+t25v3zsPQLm8x2MaRWS5CsKU6ZAqUKJSlLJBTb
	 oB4GuXTmF9/yhMmTEURsu2vxCPcQyg17SJZk9SjLvOkXzInqQtXtY02/0eZwdqRG18
	 auZfbjlWWPserhkDQGBS9ZPFhbXUOZKRN0ztSVNXgOsRBgzr0SimVb8O9n6uAW3E3k
	 GlAE6PtJYhfyYtZIOhrCQLYwS8l1Ab5t/Trv3Hn186H4RgMFzyMFsLp3qw6KocIDuu
	 ZwByLeTwKPQTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 05/10] bpf: Reject resilient lock operations in
 rbtree callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903144433.1716731-6-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
 <20260903144433.1716731-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 15:31:45 +0000
Message-Id: <20260903153146.2C3A81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The restriction against calling lock operations inside rbtree call=
backs can be bypassed by nesting callbacks or calling subprograms, because =
in_rbtree_lock_required_cb() only checks the immediate top frame.
--

commit c5914f67e15078bc12af13429620d2a2a4de2b11
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Reject resilient lock operations in rbtree callbacks

This patch attempts to enforce the root's lock requirement for resilient
locks in rbtree callbacks. It aims to prevent use-after-free conditions
when nodes are removed and freed by other CPUs during the in-progress tree
walk.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f540279ff4abb..32d31fa67036b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13241,6 +13241,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  		{
>  			int flags =3D PROCESS_RES_LOCK;
> =20
> +			if (in_rbtree_lock_required_cb(env)) {
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does
in_rbtree_lock_required_cb() fully protect against this bypass?

Looking at in_rbtree_lock_required_cb(), it only checks the immediate top
frame:

kernel/bpf/verifier.c:in_rbtree_lock_required_cb() {
    ...
	callee =3D state->frame[state->curframe];

	if (!callee->in_callback_fn)
		return false;

	kfunc_btf_id =3D insn[callee->callsite].imm;
	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
}

If a BPF program calls a custom rbtree comparison callback, and inside that
callback it calls a static subprogram (or a nested callback like bpf_loop()=
),
would state->curframe's in_callback_fn be false (or its kfunc_btf_id not
match the rbtree add kfunc)?

Could a program use this nested frame to successfully unlock the resilient
lock via a global map value (BPF_PSEUDO_MAP_VALUE), temporarily dropping the
lock and allowing another CPU to concurrently remove and free the nodes bei=
ng
traversed by bpf_rbtree_add(), leading to a Use-After-Free?

> +				verbose(env, "can't res_spin_{lock,unlock} in rbtree cb\n");
> +				return -EACCES;
> +			}
> +
>  			if (reg->type !=3D PTR_TO_MAP_VALUE && reg->type !=3D (PTR_TO_BTF_ID =
| MEM_ALLOC)) {
>  				verbose(env, "%s doesn't point to map value or allocated object\n",
>  					reg_arg_name(env, argno));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903144433.1716=
731-1-memxor@gmail.com?part=3D5
