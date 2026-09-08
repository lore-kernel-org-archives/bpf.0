Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD655293F
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876458; cv=none; b=jNMmGVqZEu5eGyOD5O3/apylgGzQ5Z4E98w0KmNSo3lp+GvAWb9S9xnLii9IbxZ7cu/4gtiUTxJO/qA0od1SUIbC7astaVRnQDmPu26j+opikHcTNlx65wD1B4QMpr6qaANfPxXeGMmQB+3vzLlAuuRJiW7tquBDMOkj2lGXw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876458; c=relaxed/simple;
	bh=pnz1pAF9/JuGVgO+OJDQiXYexhpnnNBMYG3lj1jHBKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cpJ3XTTCm0Edfgk+C+ImgaaioVlzBxPH3i7CbD7/ItY17MaDWO95zg1bmO9fMvDWx+oopu4ZM8YvwP4TEBmy/aObvyAQZhQoJuUrmQ8kY1Mw4xUCOCrMKJa9WdA3/RePw6t7hOnPNDkv4/j21p1Fd3qMeYFOH/03itaN357aewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDF91F00A3D;
	Tue,  8 Sep 2026 14:07:20 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 2/5] exec: Clear bprm->mm before dropping
 its reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260908135302.74963-3-tasos.papagiannnis@gmail.com>
References: <20260908135302.74963-1-tasos.papagiannnis@gmail.com>
 <20260908135302.74963-3-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:06:57 +0000
Message-Id: <20260908140720.1DDF91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch clears `bprm->mm` to prevent a BPF Use-After-Free, but m=
isses `bprm->file`, which is also explicitly marked as a trusted pointer by=
 the BPF verifier and is left dangling.
--

commit 1aab8d32effa684f8b1839f59b3ec045d0ba2d6b
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

exec: Clear bprm->mm before dropping its reference

The patch ensures that once mmput() drops the final reference to bprm->mm,
the pointer is no longer accessible through struct linux_binprm. This preve=
nts
BPF kfuncs from accessing a freed mm_struct.

> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e6..4ddd403fd91c7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
[ ... ]
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

[Severity: High]
This isn't a bug introduced by this patch, but while attempting to fix the =
BPF
use-after-free for bprm->mm, could this leave a dangling pointer in bprm->f=
ile
further down in free_bprm()?

In free_bprm(), the reference to bprm->file is dropped, but the pointer is =
not
cleared:

    static void free_bprm(struct linux_binprm *bprm)
    {
        ...
        do_close_execat(bprm->file);
        /* An unconsumed PT_INTERP substitute from a binfmt_misc loader ent=
ry. */
        bprm_drop_loader(bprm);
        ...
    }

Immediately after, the globally visible bprm_drop_loader(bprm) is called.
If a BPF fentry tracing program is attached to bprm_drop_loader, it receives
bprm as a trusted argument. Since the BPF verifier explicitly marks
bprm->file as BTF_TYPE_SAFE_TRUSTED, this exposes the stale pointer to the
tracing program as a trusted argument.

This could allow a use-after-free or direct memory load of a freed struct
file if the program passes this dangling pointer to kfuncs requiring a trus=
ted
struct file *.

Would it be safer to also clear bprm->file after closing it here, similar to
how bprm->mm is being handled?

Note that fields like cred, user_ns, and old_mm do not have this issue beca=
use
they are not marked as trusted by the verifier and are treated as untrusted
PTR_TO_BTF_ID pointers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908135302.7496=
3-1-tasos.papagiannnis@gmail.com?part=3D2
