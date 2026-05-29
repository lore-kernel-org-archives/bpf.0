Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06F64AA4
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021569; cv=none; b=FsTDLbqK3fTLRVeigBtwSDL7plkuAUIdJMwB9GhphJVs8CTdSXLCZ3o7pNeROEx5N6YAfs7zNCxSv3DkmQx7cG+51FszIBLLmh0eQbaVYRUG3i5AXDoGmBvprzXAOtIuSPDhknd9oe4xTYitOxHHkbQdTZPxVPsa6XPBlkp20dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021569; c=relaxed/simple;
	bh=Mi/b0UK1xOV61XU6rtEWoxPHmaM2jE41wj1pe2Rz4s8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NcbtV+fTzWUMWg7vsriE6kQWrvK+/s2qrNNX8NjN+eLxddC3Ih036Hcpb+yG//GDOBdVIo8UZK9tBKdxSLj/XCnRYsPKfOEU++EpKmedFTwLHXTepF8ieU45c+Sg3b4DOU06wea2N5UECbJOYQccMnv/TXttNOSO/Htq0Ole4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipUM5dAU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipUM5dAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966371F000E9;
	Fri, 29 May 2026 02:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780021568;
	bh=wr3zgQ7NjQnVDoUDg4cdCgcTyXk/1kpRwMqt2keJpWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ipUM5dAUZILJzmyueidfWmzWmL3myCl9lwgQXyyS0xapxMk7nTB/ljwnIJp8YFa3i
	 RTp+QQxZnd/lhJFDp9G16hFq2jcrNfisd6/CuiQHRYOBs/G12e7exJ6dBSkUKInbn5
	 W3yPQYpV0V53P3hadCkO9XAxqyaUix/1jiciaRTeK472sJwLRKlGSZEjkqMJvfTVTK
	 f1u++x6BZUOkU3ZrsYcUO4XRfsnjPBHUUH5iD0as1KaTWfdQDedAue31plxIj9MrQE
	 yBVy61FIxpPVZ0WpfFca3MFOZH7vEcrqE8VmtQD7Gm+fXckj21D5OtS4G7jJuEKbzg
	 TNEyx7JqNDJyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 02/13] bpf: Unify dynptr handling in the
 verifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529014936.2811085-3-ameryhung@gmail.com>
References: <20260529014936.2811085-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 02:26:07 +0000
Message-Id: <20260529022607.966371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() do not assign a=
 ref_obj_id to their returned slices, allowing use-after-free on refcounted=
 dynptrs (e.g., ringbuf).
--

commit eeb57bbf5794cf8b41c585dbed5238392c9e5bcd
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify dynptr handling in the verifier

This commit simplifies dynptr checking for helpers and kfuncs by unifying i=
t.
It remembers the initialized dynptr passed to a dynptr kfunc during
process_dynptr_func(), saving it in meta->dynptr to avoid redundant helper
calls in check_func_arg().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12867,11 +12753,11 @@ static int check_special_kfunc(struct bpf_verif=
ier_env *env, struct bpf_kfunc_ca
>  			}
>  		}
> =20
> -		if (!meta->initialized_dynptr.id) {
> +		if (!meta->dynptr.id) {
>  			verifier_bug(env, "no dynptr id");
>  			return -EFAULT;
>  		}
> -		regs[BPF_REG_0].dynptr_id =3D meta->initialized_dynptr.id;
> +		regs[BPF_REG_0].dynptr_id =3D meta->dynptr.id;
> =20
>  		/* we don't need to set BPF_REG_0's ref obj id
>  		 * because packet slices are not refcounted (see

[Severity: Critical]
This is a pre-existing issue, but does this code leave slices of refcounted
dynptrs vulnerable to a use-after-free?

When bpf_dynptr_slice() or bpf_dynptr_slice_rdwr() is called on a refcounted
dynptr (like a ringbuf or file dynptr), the returned PTR_TO_MEM slice is
assigned a dynptr_id, but not a ref_obj_id.

When the underlying dynptr is later released (for example, via
bpf_ringbuf_discard_dynptr()), the verifier calls unmark_stack_slots_dynptr=
()
which attempts to invalidate the associated slices by calling
release_reference(env, ref_obj_id).

However, because the slice does not have its ref_obj_id populated here,
release_reference() fails to find and invalidate the slice's register. This
allows a BPF program to retain a valid pointer and safely read or write to
the slice after the underlying memory has been freed.

I note this is fixed later in the series by commit 94d3da1c0d85d ("bpf:
Refactor object relationship tracking and fix dynptr UAF bug").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529014936.2811=
085-1-ameryhung@gmail.com?part=3D2
