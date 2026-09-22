Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634E49E12F
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103478; cv=none; b=U/8JAF0BsnaVm2aJw+Cz05GL6xOAgH+h5s4uzMvLoYnDmlAOgW8qotuiRzhoR35/Y0RK0zDOgwCM8Io1g9iwgONKgKCv1MkOBcnQeV7zluVNq7yEXlcDqaaGuxP2+x/VbHxrhdtGqqqer1AYtx7Hj86ks4LF9JFu4qrgo6vLIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103478; c=relaxed/simple;
	bh=dwvUKl1VaOw0XfxLDMVGsFeOxFbuNJVA8/s0Jg1B8AA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KoMsK48MVcgJb7Pb44o0GczdE1N/pCa2Ytjr5rxn1mxGJxsSxThnrBMifY+HSHEUelugirqL0T8nnWtww/fh375IHWs2Np3CeVtVbYNpxoFdR2vzv2nVLQVWaKyPwzpGYXc9zWT1XDK3lh2YhUX8kWO6CnyoaCk4SF2BgLp2Zzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgHT8rMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgHT8rMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922691F000FF;
	Tue, 22 Sep 2026 18:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103471;
	bh=PxuWxibPTh8aj/6FgEnSWKew6MkoC+lO9lkVDHDtoUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RgHT8rMAUX8ah0A5+1tw/2npPZ3my+Ekxz1BzPOQVq10F5JiOG1uLlSpaSEIMFPP1
	 j9f4UjvpvDz4QVoi1zdxZu5x9gXx9jOdV3rnxkbAcOkYVi/IFu+CIt08aHTiZSreu0
	 HeGug2JGQyRtheBQuz1NWycoWl5L8GUE7ukIoxlKFPdeupHtM9/5yOUi9V8IFEXcvc
	 bqliRilnl5wrfi0TMC2JQTDqY8dkJnJQzrYZyOOmGAUfUiz8E84ZtklB+icx527uCv
	 aBV77wcuUgCyiS8iOHojR8eRfoAc6s4r3zGv6HJfwwzPmbO3+GJFvWrKSJt1IDcLyc
	 Jo9tSbC1bnPxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] kallsyms: Add dynamic lookup index for batch
 resolution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-ksyms-tune-v3-3-681a34ea05d9@gmail.com>
References: <20260922-ksyms-tune-v3-0-681a34ea05d9@gmail.com>
 <20260922-ksyms-tune-v3-3-681a34ea05d9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 18:57:51 +0000
Message-Id: <20260922185751.922691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kallsyms: missing __rcu annotation on dyn_kallsyms_offsets
--

commit 6904f1dc3af3434d5089338b55024b752738c7d3
Author: Jim Cromie <jim.cromie@gmail.com>

kallsyms: Add dynamic lookup index for batch resolution

This patch introduces a dynamic u32 lookup index in transient RAM to
accelerate batch symbol resolution during high-volume workloads. It adds
start and end routines to manage the lifetime of the lookup index and
updates the symbol offset lookup to utilize it when available.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index d18d78e626db2..06c79ad70cfdc 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
[ ... ]
> +/*
> + * Dynamic symbol offset table.
> + * Allocated on demand during high-volume lookup batches and reclaimed a=
fter.
> + */
> +static u32 *dyn_kallsyms_offsets __read_mostly;

[Severity: Low]
Does this declaration need an __rcu annotation?

The pointer is later updated and read using RCU primitives like
rcu_assign_pointer() and rcu_dereference(). Adding __rcu would enable
sparse type checking and prevent static analysis warnings.

[ ... ]
> +void kallsyms_lookup_batch_end(void)
> +{
> +	u32 *offsets =3D NULL;
> +
> +	mutex_lock(&dyn_kallsyms_mutex);
> +	if (WARN_ON(!dyn_kallsyms_refcnt))
> +		goto out;
> +
> +	if (--dyn_kallsyms_refcnt =3D=3D 0) {
> +		offsets =3D dyn_kallsyms_offsets;

[Severity: Low]
Once the __rcu annotation is added to the declaration, will this bare read
trigger sparse warnings?

Since this read is performed under the dyn_kallsyms_mutex, should it use
rcu_dereference_protected() or rcu_access_pointer() instead to satisfy type
safety and static analysis checks?

> +		rcu_assign_pointer(dyn_kallsyms_offsets, NULL);
> +	}
> +out:
> +	mutex_unlock(&dyn_kallsyms_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-ksyms-tune=
-v3-0-681a34ea05d9@gmail.com?part=3D3
