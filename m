Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8647426F
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252985; cv=pass; b=CAdUKqTvn/H3jVbI9ESICQXQnXX3BeK9DIpLdaSv6r3d75VxW457vOgsnpspyrUX+vEdWnj4rWg057ICFvcDtCo1K2Q3cCExatV4s8AeEDYeoPuCyn3tI1qISxEZKybDl+sc7PVjILiEUA9r0197dbtHPgAyUhggeVTAvYRayIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252985; c=relaxed/simple;
	bh=LletibnuH2tAiJ9V8HhgrPH5FkIQeE7tJMeW2gZ4zSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xq1zBEUbrLqR1osnh5zIoX3E7OBlG0F2BEQSvFubQ6ak3UQzvOUBwcpRMPbuNbES57ki63t0AQduBdmyl4fxpwP2fqLHQeCdw10C7OfX4fENBdAIWsrB/QEtwtA4y1M22evPQ75vAWXohjbXGnFx4lgCGfidQjDiLTncSmGr4HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPpbl+q4; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPpbl+q4"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66c7e3a2332so760529d50.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788252982; cv=none;
        d=google.com; s=arc-20260327;
        b=K1JCgeZLykVOB1eIffkb97bZhUZ1+CM604rQ45mwzTU6PdaIxJ9RCbtqbS+3zRVG+G
         fDRKEjn7/BOC6J9fYEwemQ/+yvbLUDrWZLx+bzxUWjczQL5glFBNf+H/Z5vRJmR62BBP
         PZglivKQ/uOvHVYC6iQSNOnULTiQKiHEVQfsLp/znKwSFpwDHxJLB1MEfJnLvQSXDtD2
         RajLEEuQE9KtSYHeUelviCyivv5y2s6Ema+PMtqhqBiNrLAy+D/9xQ3sctEh6WngyXws
         8JRyWFiFiBnJB9KcFs/1KN5x9b4arTNbknsOMXxDhMW3MNRxBBiO3gjYKVyfid2OUwMt
         0Zow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b0cVoKLvyKRi4arSpTI3Loc6vRV6gV/RZyzB2+ewkXs=;
        fh=WV/XN5X1oEf527+V7W8SMtugzL9N6qpwP4JTepq8Hy0=;
        b=QUM9BhP7s8lE5Vv5C+wRFlR1yALr3Aj3hgeaUJSWxzW/yX/RKB7OA6nWRe6lfcvmPE
         51F3gIbeZuHuh+E57Y6cdrP449xcPskTJ9w30lNTpbuovxdVMmJSkegLVCBR1mOgHxfR
         6qNGZXbUfmx7vHhmqAJ3Lnvji9JaVfdFf93Dx2NcJRKIQ5+2/m7AN2iuE4DNiUQhT+jy
         ECTneHj+82MJceSDphY7Onb5NVnNGPsyHTzoEb8GaW3s8CgwRQFzhaQCm60nSQ4SinUL
         IC/fcGnB5QHegXPwYngEttHF0162AiHQx8quZBYWqSIHcDoFPk87GRhnKfWHYqLHe022
         AAlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788252982; x=1788857782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0cVoKLvyKRi4arSpTI3Loc6vRV6gV/RZyzB2+ewkXs=;
        b=FPpbl+q4x6/SIOBPYNFuv2Z3YRe+EwR3/LFV+mvFBaMSnB3CiMLbQUa0KuMcTBm8H0
         l6XzsGWn0N+jwNm0PsmZ0U2YeWdhOb6DYmFVWYZvcU+NNUZrkfqi+97Y8ay/1aYLSFKf
         rLgNF/v8VNc8IorSh66O7Mq4LPMETRnl/SGnmJiCMOtJ87NZOzrVcG1YnECfs0l1V+VO
         cRt7RiI/YAn44U9hsNmNlkGQ5UtgVcZF78Wu3Pui0tl+i8eeBOAD4YE/svrqti5mx4IM
         k3eWn+zCKXC0rJ9duqg7q4Eah+mdvn/3DW6MTyYzTFBn83A2vVYo1QuL2tmd84ZqJb/f
         6uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252982; x=1788857782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0cVoKLvyKRi4arSpTI3Loc6vRV6gV/RZyzB2+ewkXs=;
        b=mulMICde8r1P8ZGI6yFqxLJIqKI9e16nn0WIWvqh/RjG6fBNH/gJy7b1UDiAtiERo1
         1is9Za61FZxUd5r7tC7+NSBrpS4MNg8tyLOdhRdGOwTQYyzhdVMprvJ1Y+QenxTXuZKs
         Ep5ogOFYP5VzOtYppOp5bQwjUVxBqbYYcR/pzBNRsMEvNQ9FU6mZpgrqMIJDOsNRY5Zl
         iPx2++xzeTfmVwn25ZYqtH+xKa4K2p/dkNKWGON0OSRE6mWDiSrYE4BJ6XlJRVahavGu
         R7udnit/1erUloxZapg+adDLNXWK3NKsTrNPNeRlhles1ghlHmvvdigZKlcxpE90NjvM
         Chxw==
X-Gm-Message-State: AFuF++mg2Q0CJbqrKbDcopN/EfNAkpDEOXhkH65z7f5a60bpOSqs07vc
	5sfHK9J1DjE0XJpwjUXQYeQUivnjn30HiFppSK3MYbYbHnql59TWB84fWxNaWTBEfiWoydbmkiQ
	hz6OxgjHkPQZblIv6lNngw5NzCw7zHP8=
X-Gm-Gg: AYBFou2i9ryvQVUBR9UhTczrQpbBYnqzKAs0KnA0khFEz++fTKDQ66sojxmVXQm5NuM
	Ga3sX/ViMN6IdsxluGJXtCbqX+q4nKJzmKdX7MDtsutTkNLxcbFmcCTXVMclwRlrgMwkj8nRpVT
	MBGso+N9HqFXFkPyrcRABgPnViM6lTDt8RgfKovuMiRUcub4m0dC340dqhE1cdLYpBeVBDYeCnV
	6hw0E/TZEPZ8rJCraH+2fNmC5okc6IvpSEGjemx2XMqED7ErFKiC1bSyp2R5j5KlbPzvLUoQ2nY
	k9HfLgUaVqOQ2iX0cqoeYhsA+0e2tBzMkG0v4o57a7Eq+5Xa2ECeJh12J6LmyGCYPEG+J+wuAoY
	56l2z/zJ7y6hvgTsRM2cAofQ=
X-Received: by 2002:a53:d7c1:0:b0:66c:85e3:7f28 with SMTP id
 956f58d0204a3-66e4c7cb058mr7321594d50.48.1788252982426; Tue, 01 Sep 2026
 01:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com> <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 1 Sep 2026 16:56:17 +0800
X-Gm-Features: AcwNN1XIzpApr53ZwDAkoriLyAfCiPBC9rJXu6HlLdHYqQbCNPiAd7kuMexr5Xk
Message-ID: <CABFUUZHEJ0Bbu9QvT3AVkxAY=kgFzSA6fDj0hOwgQJ==bEaA=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] exec: Clear bprm->mm before dropping its reference
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net, song@kernel.org, 
	utilityemal77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 5:52=E2=80=AFPM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Once mmput() drops the final reference to bprm->mm, the pointer must no
> longer remain accessible through struct linux_binprm.
>
> The successful exec path and the bprm initialization error path already
> clear bprm->mm when ownership is transferred or released. Do the same in
> free_bprm() before calling mmput().
>
> This is required for eBPF kfuncs where bprm->mm is either NULL or points
> to a live mm_struct to ensure safe access.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  fs/exec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index a14f28b15607..4b4d8f0627a7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1453,9 +1453,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
>
>  static void free_bprm(struct linux_binprm *bprm)
>  {
> -       if (bprm->mm) {
> +       struct mm_struct *mm =3D bprm->mm;
> +
> +       if (mm) {
>                 acct_arg_size(bprm, 0);
> -               mmput(bprm->mm);
> +               bprm->mm =3D NULL;
> +               mmput(mm);
>         }
>         if (bprm->user_ns)
>                 put_user_ns(bprm->user_ns);
> --
> 2.55.0
>
>

An automated review by Sashiko [1] reported a potential UAF involving
bprm->file. The report identifies a real but narrower lifetime issue.

The specific PF_KTHREAD/delayed-fput scenario is not reachable through
the current in-tree path: kernel_execve() rejects PF_KTHREAD before
alloc_bprm(), and usermode helpers use user_mode_thread(). In
addition, bpf_get_file_xattr() is not available to TRACING/fentry
programs.

However, free_bprm() still drops the reference held by bprm->file
before calling bprm_drop_loader(), which is instrumentable.
linux_binprm->file is marked BTF_TYPE_SAFE_TRUSTED, so a tracing
program attached to bprm_drop_loader() can pass it to the common
bpf_dynptr_from_file() kfunc. Once the reference has been dropped,
bprm->file is an unowned raw pointer; the dynptr retains that pointer
without acquiring a file reference, and later reads dereference
file->f_mapping.

This is independent of the bprm->mm change in this patch. I plan to
send a separate fs/exec patch against the current bpf-next tree for
this issue.

[1] https://sashiko.dev/#/patchset/20260831092305.42062-1-tasos.papagiannni=
s@gmail.com?part=3D3
