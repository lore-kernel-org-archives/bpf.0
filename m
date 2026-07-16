Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80A1494A8
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784173541; cv=none; b=OuF/8fiF7q45E9HQCkfQhLTAYlnVVG0g8ohLX9iLwd9oWCiXHUf/Nn2alZFamcMfFJmPlVnXhc4Be/1RQ5lQZS89LiLiZn+dxtm9pxNFqllsGLh44aRUyoMWPCS3Kjw1uCBsoZEHWk8zq2n594ZsxOFckRZy0bHabd50355SkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784173541; c=relaxed/simple;
	bh=iH7cqZ1j8hze8lgq/nMmv15RAhiofCpPWZenuSqjVrk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PrzTIMbLXypl+FmDxjBChEAQnHkNbBdEO++dGuR/kIuGvvhQb+DXKx+Fop/i5cEzyCPDLrcG5sjYzZiDlZS5haMOTg2J19fIeIoEgAoNU4H0Xp/j3cHF82v1MjDdNiyPQSqxjOXG0NZX2ctks5z0G6g26/PLYxNh8xFUMDi0U08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJrwZIxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJrwZIxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B9E1F000E9;
	Thu, 16 Jul 2026 03:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784173540;
	bh=ZPG7eAacV05nb1b62Nx9i1XLhzDmF0Y2b9iVF595YGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lJrwZIxoli/h0hCuz0LDdK9fLXzs7o80IiaJktgnmHOgssmaFJJJ9fK8vjtCkL+D1
	 bGZFt/YS/tvgpBIL/QUkw/34e1me6Fv1100jqpze3LDMoCB7Hw2rOqKfrtpqpfy6f+
	 gHyeloGGrpleRKtq2NDnPbZaoAeJaM+ObGt+GDnCjP5/rMXKyYlafUh1KpmCRAy+GU
	 pO5d03UE0jTe9y4cMX/SXbH/NtoVzFY/fSTYEeIvstnockX5PcaAWUESVtyAXiNFxL
	 9XEvvrHEQ7/TUulXv4zBqtqOEFKFvVS5cws+Sado+cuDNXCQcLmkb9nJ69sHIUy72I
	 PtBX9hdh1CGpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf:syscall: Log error code on trampoline
 unlink failure
Reply-To: sashiko-reviews@lists.linux.dev
To: xu.xin16@zte.com.cn
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716113419588y6Ycmo7pzva8buwne9yWZ@zte.com.cn>
References: <20260716113419588y6Ycmo7pzva8buwne9yWZ@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:45:39 +0000
Message-Id: <20260716034539.D0B9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete implementation of error logging for `bpf_trampoline_u=
nlink_prog` failures.

Pre-existing issues:
- [Critical] Ignoring the error from bpf_trampoline_unlink_prog() leads to =
a severe Use-After-Free (UAF) of the BPF program during link teardown.
--

--- Patch [1]: [PATCH bpf-next] bpf:syscall: Log error code on trampoline u=
nlink failure ---
commit 14d6ea130ad662c6d03b816504502f1ebc3164e4
Author: xu xin <xu.xin16@zte.com.cn>

bpf:syscall: Log error code on trampoline unlink failure
   =20
Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
code from bpf_trampoline_unlink_prog(). This aids debugging of race
conditions during link teardown, while keeping the warning rate limited
to avoid log flooding.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ff9e3aa293d5..9cbe00bc8d051 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3547,10 +3547,13 @@ static void bpf_tracing_link_release(struct bpf_l=
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
> +	if (err)
> +		WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);

[Severity: Critical]
This is a pre-existing issue, but does ignoring the error from
bpf_trampoline_unlink_prog() lead to a Use-After-Free of the BPF program?

If bpf_trampoline_update() fails inside __bpf_trampoline_unlink_prog()
(e.g., due to -ENOMEM or -EBUSY), the old trampoline image remains active
and hooked to the target function.

However, bpf_tracing_link_release() logs the error and proceeds with
teardown, eventually calling bpf_prog_put() on tr_link->tgt_prog. After an
RCU grace period, the program memory is freed.

Subsequent calls to the target function will execute the old trampoline
image, which will jump into the freed BPF program memory. Is there a way
to safely rollback or defer the teardown when this fails?

[Severity: Medium]
The commit message states:
"Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
code from bpf_trampoline_unlink_prog(). This aids debugging of race
conditions during link teardown"

Could this change be incomplete? Looking at bpf_shim_tramp_link_release()
and bpf_trampoline_multi_detach() in kernel/bpf/trampoline.c, they both
still swallow the error code:

kernel/bpf/trampoline.c:bpf_shim_tramp_link_release() {
    ...
    WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link.node,
                                            shim_link->trampoline,
                                            NULL));
    ...
}

Should these be updated as well to ensure debugging context is available
for cgroup shims and multi-attach links?

>  	bpf_trampoline_put(tr_link->trampoline);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716113419588y6=
Ycmo7pzva8buwne9yWZ@zte.com.cn?part=3D1
