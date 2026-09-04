Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213A35DA64
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535219; cv=none; b=RQnOLMd0W1tl0xdfba7a08md5kZZp07fxbD53wv7TTcF8M9hg2PxRmWdRlLk7O6btuwr6S/642L/nfnAbzUmBTjamHuWwjFr/6w+k9HUzqTK3x3Bkh62WGiWdQ4nh9PEWyZjTtYtxOPBAiIUL+smZtab9lna7riThmkm7jBdYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535219; c=relaxed/simple;
	bh=Bly8xzb6TssB4SJd36ITp4Ey+saQACqPVdYcTL+GIM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfR+d1r9/c9NGTJDjTGZUlLHRxgR0uSFuVgrpxa81jlpVPssDksn870+RzY10kJQICcOVmRF5gPcyFHiwDJGjOdDfYkUZ2uWlD36qgq7P8p0sFHL1I/ztqsUDm2NzypheWJ2gbXUklWr0umR0dEq2CS7WkP4OInYxTaNbj1Q5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJH3DGdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJH3DGdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7B11F00A3D;
	Fri,  4 Sep 2026 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535218;
	bh=tIHcDcAadkLfIF3ucbuDXUIja3TxelauokcIXeyCFU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJH3DGdyQEA5n94SFeuq45CU63UnvfBTu7UMYQHp+siiFdPLyXLCdrlhsz8qFSgnS
	 xFKaGtP7hE5kQz8nJ2/hTwIAwVNziWqNCwGUs8ZIJCjZxYUt0y/8d5pRl6Icxw42mJ
	 V8SakOvUpe4eDyuh1XYaIW3sOAGTo0l2e9SXKDyUi1jVhAnNTxAfP9BhvVlzKuwy9N
	 ExKNahpHy6QVbW7YHNk9TcVoj66BcHFp/iTMRiXoy/poKObzbsAYdb5ETO9x2y3giy
	 HlrB9MfVRxxhjbh/WlyZBUUzE1fv+wbt12CvLbMBnmN3wNPI7X38EsXUjs4VONnbCE
	 ufAOSLJ4DhnSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/7] exec: Clear bprm->mm before dropping
 its reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904145340.40212-3-tasos.papagiannnis@gmail.com>
References: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
 <20260904145340.40212-3-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:20:17 +0000
Message-Id: <20260904152018.0B7B11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: `free_bprm` leaves `bprm->file` as a dangling poin=
ter after dropping its reference, exposing a Use-After-Free to BPF programs=
 because `bprm->file` is annotated as a trusted pointer.
--

commit 4cbe3f184f9ef608b904d3293b9a6181c4e399fa
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

exec: Clear bprm->mm before dropping its reference

Once mmput() drops the final reference to bprm->mm, the pointer must no
longer remain accessible through struct linux_binprm. This is required for
BPF kfuncs where bprm->mm is either NULL or points to a live mm_struct to
ensure safe access.

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
This isn't a bug introduced by this patch, but since this commit prevents a
use-after-free for bprm->mm, should we also clear bprm->file?

Looking slightly further down in free_bprm(), the reference to bprm->file is
dropped, but the pointer is not set to NULL:

	do_close_execat(bprm->file);
	/* An unconsumed PT_INTERP substitute from a binfmt_misc loader entry. */
	bprm_drop_loader(bprm);

Immediately after, the global function bprm_drop_loader() is called. If a
BPF fentry program is attached to bprm_drop_loader(), it will receive the
bprm argument.

Because the BPF verifier explicitly annotates bprm->file as a trusted
pointer in kernel/bpf/verifier.c:

BTF_TYPE_SAFE_TRUSTED(struct linux_binprm) {
	struct file *file;
};

Could this allow the BPF program to read the dangling bprm->file pointer as
a PTR_TRUSTED pointer and pass it to kfuncs requiring trusted arguments,
resulting in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904145340.4021=
2-1-tasos.papagiannnis@gmail.com?part=3D2
