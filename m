Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354023C1092
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178905; cv=none; b=Lx+2e1NFoZ8wwW7LMsTCINB3h99iUIKj5gKSSgCTSlm2/cLdUFNJPNfPGHPxg5oWIDEcYCHzTXto9BpHuDhm6UaBi3Q8P9X0UktEFY2M/cxsiF29mWwnuiy3M/uBdC5/fhJC3c6berkQ+NT0A7mW8L139HN4IS1PRjU0QvsLsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178905; c=relaxed/simple;
	bh=F2Zu1Tr4TtzOl06Sv5NdEooRx79rvQDAa38IUH4EjGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rH8eUiOEC1w+WIiomW3tJbSwZ50APdRuuhJEqI+xL8Sb2CuYv/FlqtCX+xHbJB7Gt7qaYJ/PfDEfmDnWJ05mQ07lGv3gYV5H9YEK+GF57HgotodU8SnEyPfXcLMBsvNvloPF8Ek0u7CuY+ndYIybONp4jsH+l5h5dIKFc1Ok2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcjhXQE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcjhXQE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC16D1F00893;
	Thu, 11 Jun 2026 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178903;
	bh=2IQvPpb++A7+KrM6qmLaHey480Upfr/cqhjCCL+5mj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VcjhXQE0RqV4mGpRgoJnDLArknsLHZgrzarSCHT1JqMQmctZXUzKNrJS0iEY5D0RS
	 QxtPZPjew6PXMauSWoZ4wgjF31x0fKTKuAxEcojTT+7/uJFkXZRW0Q1A9nyVacmeEI
	 o78RkRXNVf7tjDuxVJxyp9e4xhSs35hco6ZUfg5bvuSpBZtMh+zOvWIlW1iiQtEXiM
	 6QMXJlGC4iHjQhSOypSary2dgRidUMDUVHrQy+Iquec0DyzuCIx1VkMEu6Cgj9v+IK
	 Hb5GVHsr7RGQziRzbe57WswDgLqn3Xz5Rg23HG9O4EoBajejE97ejYLQ0Hm7kGhBQC
	 K22tG27MU0Jfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 1/7] bpf: Guard __get_user acesss with
 access_ok for uprobe_multi data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611114230.950379-2-jolsa@kernel.org>
References: <20260611114230.950379-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 11:55:02 +0000
Message-Id: <20260611115503.AC16D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing access_ok() check for the usyms array in bpf_kprobe_multi_=
link_attach() allows arbitrary kernel memory read.
--

commit e5440667240e003d50bb838ad4b19e526ef6c703
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Guard __get_user acesss with access_ok for uprobe_multi data

This patch adds access_ok checks for uprobe_multi arrays before calling
__get_user. It ensures that the user space data bounds are safe.

Link: https://lore.kernel.org/bpf/20260610145235.CB1441F00893@smtp.kernel.o=
rg/

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -3261,6 +3262,16 @@ int bpf_uprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>  	uref_ctr_offsets =3D u64_to_user_ptr(attr->link_create.uprobe_multi.ref=
_ctr_offsets);
>  	ucookies =3D u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
> =20
> +	/*
> +	 * All uoffsets/uref_ctr_offsets/ucookies arrays have the same value
> +	 * size, we need to check their address range is safe for __get_user
> +	 * calls.
> +	 */
> +	size =3D sizeof(*uoffsets) * cnt;
> +	if (!access_ok(uoffsets, size) || !access_ok(uref_ctr_offsets, size) ||
> +	    !access_ok(ucookies, size))
> +		return -EFAULT;

[Severity: High]
This is a pre-existing issue, but while you are adding these access checks
for uprobes, does bpf_kprobe_multi_link_attach() have an identical missing
check for the usyms array?

Looking at bpf_kprobe_multi_link_attach(), it calls copy_user_syms() with
the unchecked user pointer usyms:

kernel/trace/bpf_trace.c:bpf_kprobe_multi_link_attach() {
    ...
		struct user_syms us;

		err =3D copy_user_syms(&us, usyms, cnt);
		if (err)
			goto error;
    ...
}

And copy_user_syms() iteratively calls __get_user(usymbol, usyms + i)
without any prior access checks on the array:

kernel/trace/bpf_trace.c:copy_user_syms() {
    ...
	for (p =3D buf, i =3D 0; i < cnt; i++) {
		if (__get_user(usymbol, usyms + i)) {
			err =3D -EFAULT;
			goto error;
		}
    ...
}

Since __get_user() bypasses bounds checking, couldn't an attacker provide
a kernel address for usyms and read arbitrary kernel memory into usymbol?

A subsequent strncpy_from_user() call would use usymbol as its source
pointer, potentially acting as a side-channel oracle to leak kernel
information or bypass kernel address layout randomization.

Should copy_user_syms() or bpf_kprobe_multi_link_attach() also include
an access_ok() check for the usyms array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611114230.9503=
79-2-jolsa@kernel.org?part=3D1
