Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16269413D76
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103157; cv=none; b=nY9DmbTQ8UIerWpHvq0tZKvNh5T3AErZ+j2EHRnQouSVH+WjtDS5wedYlE0zIzjvwn8MYKoanUNW3uHhJlVzedI41TKwY2ncmD6bmdrszd9hX1SltQ2Xr54kR7eqk5aNGwYq8yrqyp3917UrOOkbVLM23y3CgdOnw3VRtUFLiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103157; c=relaxed/simple;
	bh=NIqL+/Psa2BSaLYgRiaFw3Gfbn5MnYhXu6Kl4g+ExWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H22uo0yb+6eJ5C4/vlgpenwGl0B4NGyMYRcAmDDMOuNRyhtd4mJ9MWOivmBQDsDCH2L2lsFUzWakbwLRgdmmltWmMB0r2jeeZil+eHwTIUZYTR5Je8O1WWOtUdOI+NjbCdeOrkgnuq6AOIq93mORBKW1CHdcWxYp2lvgVI2Uwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kco8/5pU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kco8/5pU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1441F00893;
	Wed, 10 Jun 2026 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103156;
	bh=VoNJmO4pgeFkdjPFuk/UygI6OjUEg8suGaKswyWopLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kco8/5pUGqkyMlOpEA9TBUBMTPQk61xM87ta9qZMfCR5V7uhilyAfIiqBqL0oLvq6
	 +0WAEX4j+t4P6ae3Ft/5N807O9PF2FBoKW+wlPKOF1B9e/G42gHNbrg9hi/B//Mwv2
	 YrwJ+KK8110gqHfCPIdOirMIahII7SeF3EL0DH/ddyFxADWauLX12m44NFDpuhoXy8
	 hG3WZ+RwnHmO1dP/Y8B+YzO6c61fDqVIVcb1hME/PxBTNmbaBVlFmPWgA5NEpxe9Q8
	 aFLLz5F0OzDCorkvHe9a+urk/S/kLgjR+YyXvwNopenan1c+3UvkIJUnB3UzM0ib4w
	 hFWFZ3OZGJiCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 1/6] bpf: Use user_path_at for path
 resolution in uprobe_multi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610143627.804790-2-jolsa@kernel.org>
References: <20260610143627.804790-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:52:35 +0000
Message-Id: <20260610145235.CB1441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing `access_ok()` checks before calling `__get_user()` on =
user-controlled arrays, leading to arbitrary kernel memory read.
--

commit e18574361f20d4f27005e4d927610e3ce16986dd
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Use user_path_at for path resolution in uprobe_multi

Resolve the uprobe_multi user path with user_path_at() instead of copying
the string with strndup_user() and passing it to kern_path(). This removes
the temporary allocation and keeps the lookup logic in one helper.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 90432f0fc2a8e..970ce7bbf99e1 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -3261,14 +3260,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>  	uref_ctr_offsets =3D u64_to_user_ptr(attr->link_create.uprobe_multi.ref=
_ctr_offsets);
>  	ucookies =3D u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
> =20
> -	name =3D strndup_user(upath, PATH_MAX);
> -	if (IS_ERR(name)) {
> -		err =3D PTR_ERR(name);
> -		return err;
> -	}
> -
> -	err =3D kern_path(name, LOOKUP_FOLLOW, &path);
> -	kfree(name);
> +	err =3D user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
>  	if (err)
>  		return err;
> =20

[Severity: Critical]
This isn't a bug introduced by this patch, but while looking at
bpf_uprobe_multi_link_attach(), I noticed the user-provided arrays
uoffsets, uref_ctr_offsets, and ucookies are accessed shortly after this
path resolution:

kernel/trace/bpf_trace.c:bpf_uprobe_multi_link_attach() {
    ...
    if (__get_user(uprobes[i].offset, uoffsets + i)) {
    ...
    if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_offset, uref_ctr_=
offsets + i)) {
    ...
    if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
    ...
}

Are these arrays validated with access_ok() before __get_user() is called?

Because __get_user() bypasses the access_ok() address-space bounds check
on most architectures, could an attacker supply kernel addresses for these
arrays, causing the kernel to read arbitrary memory and store it into the
uprobes structures?

If an attacker retrieves these contents by querying the link info via
bpf_obj_get_info_by_fd() (which calls bpf_uprobe_multi_link_fill_link_info()
and copies the memory back to user space), could this act as an arbitrary
kernel memory read primitive to bypass kernel lockdown and KASLR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610143627.8047=
90-2-jolsa@kernel.org?part=3D1
