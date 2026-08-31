Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B273DA7F6
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171906; cv=none; b=qreuehD+Me3Wv38vhIff+cVFO5w8WoKc7bQB0RfYfeCoaQeyPHxScsG5G/0fTIOYEpYezq/fuDte1AzPRG1A1NMaLvzN32ILnCJMgQnJLgOD55aLw/wnsC4oGC9y92o0FHNUdE/qmycuwb1iZFFSyI9pKuv1HDUg3bAhuagzK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171906; c=relaxed/simple;
	bh=8AICESHFCdA2g/07BWN0B0oHErLx/U3/yekOw2J318w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YhFU+9ACYF3e51empFB/Vk/rEyLyVa7khvStgSS8R1PxTTrQSFNdBcYmHdklg/ci88BGU9oDRqfmlEcPrNaTK+KD9wkbbCzWJsiECqEkEsWnCdekUdW8OCg9sOCAMTYgX4VWGoWzQnReX3zfQFuaWxgLAL1fqS1YqlxvAVIOm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvoyez3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvoyez3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC8C1F00A3D;
	Mon, 31 Aug 2026 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171903;
	bh=O6TngbIvm3sOJTAJFQfxhc3KjhrKAM4+dDfd9T0abjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvoyez3jPtqIX/yBRPRTzIwT+o/DRKRfFgVbiMYOhJ5ucOiP/tFuajlDy5cRoEtvE
	 WXxQvWHUU5pfQUoqXc8B/vTHoGXTAcCnyqGVbcZZX/utQllB0NSJ2RLo3GfC/lTKBQ
	 aEDIy0mm/nLf31eZQLhBeXNcesNbXbrCPYNW2i80MfHl3oW2RrzGgU1KGF229I5OVh
	 k1E6/1yrdz+Q27dgcvIy0gPWfiSSepvKGM201c0DX8dsIy11uN+wUSio3GxQ56n/4i
	 3oW7n0/dTF2P3ImChIURn+Di6K+3DK7mNxygLrd6Wrnld0J74PxdICM9bv1vD5Gatn
	 zt/W3W9vSxHwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/7] exec: Clear bprm->mm before dropping
 its reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
 <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:25:02 +0000
Message-Id: <20260831102503.4CC8C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of `bprm->file` via eBPF kfuncs due to dangling tru=
sted pointer.
--

commit ac94f9ff4f270354d3714d4162d6adfa946a8fdf
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

exec: Clear bprm->mm before dropping its reference

This commit clears bprm->mm before calling mmput() in free_bprm().
This ensures that eBPF programs cannot access a dangling mm_struct
pointer when hooking into execution paths.

> diff --git a/fs/exec.c b/fs/exec.c
> index a14f28b15607a..4b4d8f0627a7c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1453,9 +1453,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
> =20
>  static void free_bprm(struct linux_binprm *bprm)
>  {
> -	if (bprm->mm) {
> +	struct mm_struct *mm =3D bprm->mm;
> +
> +	if (mm) {
>  		acct_arg_size(bprm, 0);
> -		mmput(bprm->mm);
> +		bprm->mm =3D NULL;
> +		mmput(mm);
>  	}
>  	if (bprm->user_ns)
>  		put_user_ns(bprm->user_ns);

[Severity: High]
This is a pre-existing issue, but since this patch addresses dangling
pointers in free_bprm() for eBPF, does bprm->file need similar handling?

Further down in free_bprm(), the code drops the file reference and then
calls a hookable function:

	do_close_execat(bprm->file);
	/* An unconsumed PT_INTERP substitute from a binfmt_misc loader entry. */
	bprm_drop_loader(bprm);

When kernel_execve() fails in a kernel thread, free_bprm() is called.
The do_close_execat() call drops the final reference to the file.
Because this executes in a kernel thread (PF_KTHREAD), fput() queues
the file for asynchronous freeing via delayed_fput_work.

Right after this, bprm_drop_loader() is called. If an eBPF fentry program
is attached to bprm_drop_loader, it receives the bprm argument.

Because the BPF verifier defines the file pointer within linux_binprm as
BTF_TYPE_SAFE_TRUSTED, the verifier trusts the pointer. The eBPF program
can read bprm->file and pass it to a kfunc like bpf_get_file_xattr().

Could this result in a use-after-free if the kfunc dereferences the file
pointer concurrently while the workqueue frees it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831092305.4206=
2-1-tasos.papagiannnis@gmail.com?part=3D3
