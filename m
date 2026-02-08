Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0928725F
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770547973; cv=none; b=ciAI4p9M/B/9aYzJ6fJRIEFavzglZRTyWtbK/MyU9Vnfox8YuE/Zdz2O3tRf065obu8zn9MSH3VblNo5Yg3cSIMf+p1nhGS2TsoFopg6/6uRXY2LHJyOozKstYmLex5bZ6AXPqOjEQfhBPA8w570yVuI81yrajhAT6KMqYwepTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770547973; c=relaxed/simple;
	bh=0VExI0SEjJo3SF54AFoiMTAyRRM24mQmZhByR0No9d8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JZNyaMiRabBx4BqRwNKWdFLcPaOuCwat0BdGYobbcibFpz726tRaFJnbfmOaPHqOa/a6lS9OZTBr3Nv7okNzdanSu7AvBF8dBrF60uBd84n06caZMFUVA7gSkZTvwiTIEzaAjad38A0JQol+KD0yj/QB2qxu9+zvg0OPjXEgcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhXvZdcR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhXvZdcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4231C4CEF7;
	Sun,  8 Feb 2026 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770547973;
	bh=0VExI0SEjJo3SF54AFoiMTAyRRM24mQmZhByR0No9d8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WhXvZdcRnkLOcMV0T89/MkDwmp5GqGPEcjg35L8R6975sE6Ksh5SN0lZ9dbF04Bb8
	 3sU9ORcgVIXDVIKBxvnQ1vJnf7eYgPD8MR96j9UoThXQ96eE6PPG4uCRuVqIej+J4E
	 5OXt/UUp2E8xP4q+hHNc6EqN+hYQHnBSbfMY8ygE1wh95TonQ/CUZHW8/U9jmtCW97
	 WjhE3+3GRdvB8qwkaI+558vQyF3JLjdIir1wr5zC+bWDYzdgAN2ggarwJwziTBWlKE
	 1L8Xb1tFSVp2/r7513I9S8PLYh3PmGlZMNSu4auFDt6bCvJt8F9bxhoKqnQx796hRS
	 gZE3pvi9fn4lQ==
Content-Type: multipart/mixed; boundary="===============2923070129947316635=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <620b07ccda2db959a07fd2fc81c6cb3127dddfd17c64ef6dce63113c8eb30f37@mail.kernel.org>
In-Reply-To: <20260208103240.6268-1-a.s.protopopov@gmail.com>
References: <20260208103240.6268-1-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Fix a potential use-after-free
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: a.s.protopopov@gmail.com,aspsk@isovalent.com,syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  8 Feb 2026 10:52:52 +0000 (UTC)

--===============2923070129947316635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21466,9 +21461,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
>
>  	btf_fd = insn[1].imm;
>  	if (btf_fd) {
> -		CLASS(fd, f)(btf_fd);
> -
> -		btf = __btf_get_by_fd(f);
> +		btf = btf_get_by_fd(btf_fd);
>  		if (IS_ERR(btf)) {
>  			verbose(env, "invalid module BTF object FD specified.\n");
>  			return -EINVAL;
> @@ -21478,17 +21471,23 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
>  			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
>  			return -EINVAL;
>  		}
> +		btf_get(btf_vmlinux);
>  		btf = btf_vmlinux;
>  	}
>
>  	err = __check_pseudo_btf_id(env, insn, aux, btf);
>  	if (err)
> -		return err;
> +		goto err_put;
>
>  	err = __add_used_btf(env, btf);
>  	if (err < 0)
> -		return err;
> +		goto err_put;
> +
>  	return 0;

Can btf leak a reference here when __add_used_btf() returns a non-negative
value for an already-recorded btf?

Looking at __add_used_btf():

    for (i = 0; i < env->used_btf_cnt; i++)
        if (env->used_btfs[i].btf == btf)
            return i;

If the btf was already added to used_btfs (e.g., two BPF_PSEUDO_BTF_ID
instructions reference the same btf), __add_used_btf() returns the existing
index without consuming the reference.

In that case, check_pseudo_btf_id() took a reference via btf_get_by_fd() or
btf_get(btf_vmlinux), but the "return 0" path does not release it.

The original code before commit 76145f725532 handled this case:

    for (i = 0; i < env->used_btf_cnt; i++) {
        if (env->used_btfs[i].btf == btf) {
            btf_put(btf);
            return 0;
        }
    }

Should something like this be restored, perhaps by adding btf_put(btf) when
__add_used_btf() returns a non-negative value indicating the btf was already
recorded?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21796744040

AI-authorship-score: low
AI-authorship-explanation: The commit has standard kernel formatting, addresses a real syzbot-reported bug, and the code changes follow conventional kernel patterns without any AI-typical verbosity or over-explanation.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: BTF reference count leak when the same btf is referenced multiple times can cause memory to never be freed, but does not cause crashes or security issues.

--===============2923070129947316635==--
