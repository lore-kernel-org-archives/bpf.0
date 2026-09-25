Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380C3E00B4;
	Fri, 25 Sep 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377862; cv=none; b=VVxgTXKlddu8CHJZNFpL2K0zY5hYR+cBKIlWo8KRqwgtRBdpVoALuIyd38kRfaHv3seFRgW2p4mOa4dvYlv6Ves5CA6uvLK9NA/AhWZ92BjE59TNhe+3M0foajMVlBT7GT8aZtgunq1RJPTuFmFmTOHTGNP6zxAP6pIqeBLQznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377862; c=relaxed/simple;
	bh=j2LCXnq/0nvFxK7djD2qFB1ji+VFRbUMFaTrd2IvSH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S0Dr7uIxPlQB11nwcMmU3lOc+D46/4DwyV1FB9NWGIlyAMK+jh6VDQGzv5Qf75fpv2LXFZk8mp0YjMefOVfBbTZDQ0pWHYOVNwYDF1I9z3uiRW0iK3i/RMiU3h057yaht4Kpg+MFWqJLV1ykBx561yKMJU4wdDaBEgmC3yNVDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJkReceY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJkReceY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2481F00893;
	Fri, 25 Sep 2026 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377860;
	bh=1ApWPVlZwDTKbVzAx8PbdHu0DODCVzXUDaAtYdC6lvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJkReceY6W7SlJMCPE/lVl1X6RgtufaOq94Smw1IIhb43INdb4k9HU3Jsx9xFC56l
	 WEn3COAE9azdAS/i5C1YsEr2HRYBu8WWpKBi1KtDnP9CUpwGTaqaz65U25JsA83a6Q
	 ok117EV8qR2Lu8dr4dDqvW9sYWsPnPGhhBj2o2+bH6BStzejbrRL5KC71etVeCNAwS
	 Ziz79hLhuq7ERkSgvwd2yYYWCrf1KZqrgYWf8lHOG8MQxilJk/JaH36uvp/IvGgL3O
	 vNMdgGMDjCW2BxSEVaVy8QmCFSVcyCttMosYGi4V8B0B1IPWIq/N7EGr2n2vkFL2q1
	 waA3dBN8BSEQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/9] bpf: fetch the vmlinux BTF where kernel
 types enter a program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: gary@garyguo.net, bpf@vger.kernel.org, linux-modules@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260925224229.1850-4-wanjay@amazon.com>
References: <20260925224229.1850-1-wanjay@amazon.com>
 <20260925224229.1850-4-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 23:10:59 +0000
Message-Id: <20260925231100.6A2481F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: state-dependent verification failure for BTF-independent prog=
rams
--

commit f6fc508c855b2ee6adf6ef6d3d2ccfe35410bcf1
Author: Jay Wang <wanjay@amazon.com>

bpf: fetch the vmlinux BTF where kernel types enter a program

This commit delays fetching the vmlinux BTF until kernel types actually
enter the verifier state. This prevents unnecessary loading and parsing
of BTF for BTF-independent programs like socket filters, saving memory
and parsing overhead.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -22532,10 +22580,10 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
> =20
>  	mark_verifier_state_clean(env);
> =20
> -	if (IS_ERR(btf_vmlinux)) {
> +	if (IS_ERR(bpf_peek_btf_vmlinux())) {

[Severity: High]
Could this introduce a state-dependent verification failure for
BTF-independent programs?

When a BTF-independent program (like a systemd socket filter) is loaded
initially, the bpf_peek_btf_vmlinux() helper returns a null pointer and this
check is bypassed.

If a BTF-dependent program is later loaded under memory pressure, the
btf_parse_vmlinux() routine could fail with a memory allocation error. When
the kernel is configured with BTF enabled, bpf_get_btf_vmlinux() permanently
stores this error pointer in the global btf_vmlinux variable.

Subsequent loads of completely unrelated, BTF-independent programs will now
see the error pointer returned by bpf_peek_btf_vmlinux() evaluate to true
and fail with an in-kernel BTF is malformed error in bpf_check().

Will this unintentionally cause transient memory failures during BTF parsing
to permanently break unrelated critical system services?

>  		/* Either gcc or pahole or kernel are broken. */
>  		verbose(env, "in-kernel BTF is malformed\n");
> -		ret =3D PTR_ERR(btf_vmlinux);
> +		ret =3D PTR_ERR(bpf_peek_btf_vmlinux());
>  		goto skip_full_check;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925224229.1850=
-1-wanjay@amazon.com?part=3D3
