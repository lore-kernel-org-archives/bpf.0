Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7133ED3BB
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931612; cv=none; b=BRgAGMrM+Qa1/sojVLTaOEcwBPu7gLgcCkeKfmu/PXIWvHk6RgtQQn4ETNy0gXP+LX2ASgNu/oHoBhCmnF2bhaHg1i9uyce0+xxpnkpgUP295p/0AJxwNYRxy4Ucdm6Jqmb48Z9P+cTXVgEcFQMT3C/pnmApJUJFQuiRJazUgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931612; c=relaxed/simple;
	bh=PDGOGwNyvxwNHGYfEd4yH5vBevgdDQR+TfpgiMpAmKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YdMLBg9TKAunhoT+YpPlmxDF3FnXE81jqXtM2qLValPK8C+VDlHTFCMlByWrLTAUdTfbPDMV6xrQVb500H2t0c6uOVrwA9Xc5DQNIZuYWV09kQ3IT8RsGPWcapQKIRHFp4YtJ2xZUese9/m/Oh6aeHKP0r4pD3Q33GDj6PshDDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/1J0VYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/1J0VYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730D81F00893;
	Mon,  8 Jun 2026 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931611;
	bh=kUCBROqQWOKxcqa/tHac2i3i7tr8p4yrPGmpND/ilEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/1J0VYwuZRr4odXLVHPI+m57EpZYVlbVZWOvGxeaZzWRbdRRqhkH/OpQbVQMx89N
	 UP4o2IcH3eN3159QppfxQLkDbmwk2xe/aamu1D0KdMazMZxB93cRto1R/a1TJkc91O
	 ry2vAk7evBB0QpbyUI+qCr0v0w+88p890C/WJx3ebV1XQf8pHUqRoPAnJ1ZRSkGrn4
	 kSIW0AmARub85DwjN7QUC+F1k7cJwpjAURAsz6eC35WhG38k9Pta8NhxA8MCKvxc51
	 152VjWBBJRCMfxKsmDRvgwqLjkT43T7ztk+QbUzR6hU0+c7qC/PVIPOKNKHv6znCIh
	 bC14CePWwcmLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/5] bpf: Treat non-iterator tracing progs
 as tracing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608144841.1732406-2-memxor@gmail.com>
References: <20260608144841.1732406-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:13:31 +0000
Message-Id: <20260608151331.730D81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Tracing programs can deadlock the kernel by acquiring `bpf_spin_lo=
ck` via `bpf_map_update_elem` with the `BPF_F_LOCK` flag, bypassing the ver=
ifier's safety checks.
--

commit 0ab13739c010beba3fc294b839936a5123924643
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Treat non-iterator tracing progs as tracing

This patch updates the is_tracing_prog_type() helper to include non-iterator
tracing programs. It modifies check_map_prog_compatibility() to defer rejec=
ting
tracing progs that access maps with bpf_spin_lock until their first use,
avoiding overly conservative rejections.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce0..26bfb44657253 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -17697,24 +17712,16 @@ static int check_map_prog_compatibility(struct =
bpf_verifier_env *env,
>  		return -EACCES;
>  	}
> =20
>  	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK=
)) {
>  		if (prog_type =3D=3D BPF_PROG_TYPE_SOCKET_FILTER) {
>  			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
>  			return -EINVAL;
>  		}
> -
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> -			return -EINVAL;
> -		}
> +		/*
> +		 * Rejecting tracing progs accessing maps with bpf_spin_lock in
> +		 * them here would be too conservative; let's defer rejection
> +		 * until seeing first use.
> +		 */

[Severity: High]
Is it possible for tracing programs to deadlock the kernel by acquiring
the spinlock via bpf_map_update_elem()?

By deferring the rejection to process_spin_lock(), we prevent explicit
bpf_spin_lock() calls in the tracing program. However, tracing programs mig=
ht
still be able to call bpf_map_update_elem() with the BPF_F_LOCK flag.

If a tracing program passes BPF_F_LOCK:

kernel/bpf/hashtab.c:htab_map_update_elem() {
	if (unlikely(map_flags & BPF_F_LOCK)) {
		if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
			return -EINVAL;
    ...
}

This leads to copy_map_value_locked() which takes the lock:

kernel/bpf/helpers.c:copy_map_value_locked() {
    ...
	preempt_disable();
	__bpf_spin_lock_irqsave(lock);
    ...
}

Since tracing programs can run in NMI context, if an NMI interrupts another
context that is currently holding this exact spinlock, wouldn't it result in
an AA deadlock?

Does the verifier block BPF_F_LOCK dynamically at load time, or does removi=
ng
this map compatibility check expose us to this deadlock vector?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144841.1732=
406-1-memxor@gmail.com?part=3D1
