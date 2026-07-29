Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A38242D65
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306082; cv=none; b=I9ySyYZIHWqdtwHmwOzQiBWkL32nMqI9XvFfkq27EoyBlJ8SRLsU5NMm2MU2zl3k2MLVlWA83NoxVnPiVGhsbmbDstkXVcKvQfPrIxNLLKleI1e9FnimIvbujlCipdlEQ2PZaXA6Tp7TH/cFgJFpbnEjdbOo4OAPfnoOrSphjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306082; c=relaxed/simple;
	bh=3WBsiyY9qUufI0RlY+S1NJo5l3NON9wsCYHvoOzrRBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZXhywPwkHxZJUpvU6xX4Dcw+EQYKeKlg8arBrglP5KwAAHiD3OyF2TOAiFuRwVADt/uLpjKKcKSCsEM0ct3n8hHFYGs9kPU1fxi2Y2tvdQ7kckFTzsH2e/CrSBRMhBECy24bBXOiAg7tXjozrqAIQ4agfFHY2WqcA/37SZmiu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVwNNIRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVwNNIRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A321F000E9;
	Wed, 29 Jul 2026 06:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785306081;
	bh=yoZAAQIijs7R+9k6rTLsJ+snQrUhI1oZsUSJ8Vc6pDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QVwNNIRrnnMiI18BmKkYkFb0rSVrxlIRrOH2u3zHXtEbK4ZcX+mTMV4qK39smqUbI
	 67EqEfwZeSfNs+yDgUmh1GMax2I0VjOL0uRh2EotXnNrUfV71UkyzSYN9LWiSPQ3/K
	 eTAQYXgk/N3BXOir68HbWPgQFZwhdLTecukb24J7XkYa7mOtgMokfGipRMAlJD6UIr
	 NhFLba3y6fuKWpZ1P9Bk+jvKw5qjxeEP1Ne+grP2Ghhk5UN6EY1GTmzO6cMb4BJwrw
	 ov4ivf49MVhCkhyMmMEmc/lkikLaWwq0FOZ6cq7bwaKXORdrYqSA3cjMdkhjMKqt+C
	 mUoMIdgBUbM0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4] bpf: log error code on trampoline unlink
 =?utf-8?b?ZmFpbHVyZcKg?=
Reply-To: sashiko-reviews@lists.linux.dev
To: xu.xin16@zte.com.cn
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn>
References: <20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 06:21:20 +0000
Message-Id: <20260729062120.C9A321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Preexisting Use-After-Free vulnerability when bpf_trampoline_u=
nlink_prog fails. This problem wasn't introduced by this patch, but the cal=
lers unconditionally drop BPF program references even when detachment fails.
--

--- Patch [1]: [PATCH bpf-next v4] bpf: log error code on trampoline unlink=
 failure=C2=A0 ---
commit 04adb71914e050f3eeb5224ff162eb88dcf506a9
Author: Xu Xin <xu.xin16@zte.com.cn>

bpf: log error code on trampoline unlink failure=20

This commit replaces silent WARN_ON_ONCE macros with WARN_ONCE to print the
actual error code from bpf_trampoline_unlink_prog(). This is intended to
help debug race conditions and use-after-free crashes during link teardown.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ff9e3aa293d5..b4b4fc49bba79 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3547,10 +3547,12 @@ static void bpf_tracing_link_release(struct bpf_l=
ink *link)
>  {
>  	struct bpf_tracing_link *tr_link =3D
>  		container_of(link, struct bpf_tracing_link, link.link);
> +	int err;
> =20
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
> -						tr_link->trampoline,
> -						tr_link->tgt_prog));
> +	err =3D bpf_trampoline_unlink_prog(&tr_link->link.node,
> +					tr_link->trampoline,
> +					tr_link->tgt_prog);
> +	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
> =20
>  	bpf_trampoline_put(tr_link->trampoline);

[Severity: Critical]
This is a pre-existing issue, but does dropping the program reference here
lead to a use-after-free if the unlink actually fails?

If bpf_trampoline_update() fails during the teardown process, the active
trampoline image retains the call to the BPF program:

kernel/bpf/trampoline.c:__bpf_trampoline_unlink_prog() {
    ...
    bpf_trampoline_remove_prog(tr, node);
    return bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, dat=
a);
}

When this error bubbles up to bpf_tracing_link_release(), the active image
is left intact and continues to jump to the BPF program. However, we proceed
to unconditionally call bpf_prog_put() shortly after the trampoline put:

kernel/bpf/syscall.c:bpf_tracing_link_release() {
    ...
    err =3D bpf_trampoline_unlink_prog(...);
    WARN_ONCE(err, ...);
   =20
    bpf_trampoline_put(tr_link->trampoline);
   =20
    /* tgt_prog is NULL if target is a kernel function */
    if (tr_link->tgt_prog)
        bpf_prog_put(tr_link->tgt_prog);
}

Once the RCU grace period elapses, the BPF program's memory will be freed.
Could the active trampoline then jump into freed memory the next time the
targeted kernel function executes, resulting in the UAF crash mentioned in
the commit message?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729141159128mE=
JmS_aujBKr-cBu1p_UI@zte.com.cn?part=3D1
