Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312903C5550
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800847; cv=none; b=fpYpI0yBWhofXmJq4vXE/zu9lotTU/s+iqP25KDqwxu0mjH9GR/ROZi+Gv5CU+U8eugr80mi/xqEE80m56OyTTrL84FaYCUDU75B8l0+H9XcBs1nb1tM3ONgPHUYtp7WdJb3j9zAzAkOD6B91++XgB+CBOdQuDCqJKmF6VQQ6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800847; c=relaxed/simple;
	bh=M1ZcqLcx6Ie8YRFRRt7nPNQ714Uw+6JGWjg39ZU+e58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKWPtRj8iNNmocaybbJChXacmfv8WtvV0LLgVSAMe7ZLRpba4bFOjCIuQ4+lmzizRPrxK8y/or4a08GsE2kgn0tHrDTgeunjhaQf/bUAPLxA7C6rqtsHjU8JoloKv8cHml1DecGZx22t4Bi+5A/X8lzHN3qPdz+MWfDZfeoeHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONfW52Y7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONfW52Y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC261F00A3A;
	Mon,  7 Sep 2026 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788800845;
	bh=glKS5R7KqtZRbfKy6MQPncRKS/E7Dhav47Y0Y12//CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONfW52Y7b2wx4hAIXMnAJ8vEIf+K1u/ZI/e91KL8x7OqNLsQTDrjBgG4R4jqUZThq
	 AdCUdWHE1RnFSbMvqfiz4m3g/Pv/YApFKEuQ37rt8CdXuaqiDEpMD5UU2dTHvfojeO
	 SXH4tMux9Cj2YCegB0/XjZeFEn8W51BQVDc7c2JGH1fTfRfS2/y4MFJRTBm7ElrDrI
	 OeI/8AL80nOq06Rssg8QQUAaDB7PAhhN+sYkwTQ6D7NI+5v5mXKq1TviooZo3uepZT
	 H93252Klm8b7l5S/jYKYnNAucTA50CiKgHriUNxamWsYefGlMeRIUmf02kRwS5d+k4
	 2fdntBmx8tiXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/7] exec: Clear bprm->mm before dropping
 its reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907165220.52431-3-tasos.papagiannnis@gmail.com>
References: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
 <20260907165220.52431-3-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 17:07:25 +0000
Message-Id: <20260907170725.9EC261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch addres=
ses this exact class of BPF Use-After-Free (UAF) vulnerability for `bprm->m=
m` while missing that `bprm->file` suffers from the same flaw. The BPF veri=
fier explicitly marks `bprm->file` as a fully trusted pointer via `BTF_TYPE=
_SAFE_TRUSTED(struct linux_binprm) { struct file *file; };`. In `free_bprm(=
)`, the file's reference is dropped via `do_close_execat(bprm->file)`, but =
the pointer is not cleared. Immediately afterward, `bprm_drop_loader(bprm)`=
 is called, which serves as a BPF fentry tracepoint. A BPF program attachin=
g to this hook will receive a dangling `bprm->file` that the verifier incor=
rectly considers `PTR_TRUSTED` and completely safe to pass to kfuncs, bypas=
sing BPF safety guarantees.
--

commit a611d673e7752074063d4d9476d61d335949964b
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

exec: Clear bprm->mm before dropping its reference

The patch clears bprm->mm to NULL before dropping its reference via mmput()
to ensure safe access from BPF kfuncs.

> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e6..4ddd403fd91c7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1456,9 +1456,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
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
This isn't a bug introduced by this patch, but while it addresses a BPF
Use-After-Free vulnerability for bprm->mm, it appears bprm->file in the same
function suffers from the same flaw.

Further down in free_bprm(), the reference to bprm->file is dropped via
do_close_execat(), but the pointer itself is not cleared:

    do_close_execat(bprm->file);
    bprm_drop_loader(bprm);

Immediately afterward, bprm_drop_loader() is called. This acts as a BPF
fentry attach point where a BPF program can access the dangling bprm->file.

The BPF verifier explicitly marks bprm->file as a fully trusted pointer via
BTF_TYPE_SAFE_TRUSTED(struct linux_binprm) { struct file *file; };.

Because bprm->file is left dangling, a BPF fentry program attached to
bprm_drop_loader() will receive a pointer to a released file that the verif=
ier
incorrectly considers PTR_TRUSTED and safe to pass to kfuncs, bypassing BPF
safety guarantees.

Should we apply the same pattern here, storing bprm->file in a local variab=
le,
setting bprm->file to NULL, and then calling do_close_execat() on the local
variable to prevent BPF programs from accessing a zero-refcount object?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907165220.5243=
1-1-tasos.papagiannnis@gmail.com?part=3D2
