Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49230C629
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198540; cv=none; b=gD4pYAfVsIA7v1jXNOMbwugGIWJUg9HgP1qQ26/fSgw8KKV6zq9kFLr0Z0MYAZczx4o3wP/2OO9SP9FZVJahswmfAEMBvtifVEH9YwxhPwrwRrMrd/BIuNH7jWaoLpzxFxE1T/RUQNCOsJ9NonaDp8Cu9n9U/v0slBgLy9rVKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198540; c=relaxed/simple;
	bh=gwUrvQANOrl5+hIYKDoSKc3QbIN6SXai4MjyVD4XqPY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YlzBo0t7++ho1EqDes/XE8dz1dmbzbBc+chuU+7Q1+NiHsEhEjm+DZeElGCxhY1z6FaU9Woe/gpUtCxo6+NVzYvL0QWryCUNHuD4oVyRRgtl6iv9HAEL44h9cCaiKAOQlrHGLABJOUaD799GrMLRHyE2DFriPUrqAaZSTyfswXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmVqr0f3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmVqr0f3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1882C19425;
	Tue, 14 Apr 2026 20:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776198540;
	bh=gwUrvQANOrl5+hIYKDoSKc3QbIN6SXai4MjyVD4XqPY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dmVqr0f3mHKeei8uPwOnfPoHBGpPA6U8+ScyxwHPUuLnpQDEWF5ho/TCqJCiOcLAb
	 dxaKHk4TmEgY2BHFB0Ezd0dXKJpq3LXjLm32OILff7ak4P0JOTabHVP4p1GrWuGY/O
	 T+WvDVRmphAADAjVzfLV356gtD8Vnw57Pl0fisyV/Hvk32fqWphVD8JyGdU0GCnxen
	 7NTRw3/7SnDY+LgMuwl59PvwdjRuQuX8TC61kfFuC8Lq8qCL9IFsfQvZdbi6HYtytb
	 QQD71tw5Jn2jJmBxVDtGLijP3DzvDJxwvYpOXVo8Gf85JKTHy0/F1IbrNrZZDGwYRe
	 FBiGbZQsSbGfg==
Content-Type: multipart/mixed; boundary="===============3782200397955678187=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83d5ae9a86ff32e179554c24e012a6a1af045faf164cfd059a7e683615e6f76d@mail.kernel.org>
In-Reply-To: <20260414194804.1428676-1-jolsa@kernel.org>
References: <20260414194804.1428676-1-jolsa@kernel.org>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix btf object leak in load_module_btfs
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Apr 2026 20:28:59 +0000 (UTC)

--===============3782200397955678187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5771,6 +5770,8 @@ static int load_module_btfs(struct bpf_object *obj)
>  		return 0;
>
>  	while (true) {
> +		struct btf *btf = NULL;
> +
>  		err = bpf_btf_get_next_id(id, &id);

[ ... ]

> @@ -5837,6 +5838,7 @@
>  		continue;
>
>  err_out:
> +		btf__free(btf);
>  		close(fd);
>  		return err;
>  	}

When strdup(name) fails a few lines above this, btf_module_cnt has
already been incremented and mod_btf->btf already holds the btf
pointer:

    mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
    mod_btf->btf = btf;
    ...
    mod_btf->name = strdup(name);
    if (!mod_btf->name) {
        err = -ENOMEM;
        goto err_out;
    }

Can this double-free btf?  The new btf__free(btf) here frees the
object, but bpf_object_post_load_cleanup() will iterate btf_module_cnt
entries and call btf__free(obj->btf_modules[i].btf) on the same
pointer.  Similarly, close(fd) here and close(obj->btf_modules[i].fd)
in cleanup would double-close the fd.

This is addressed by the next patch in the series (36358f0b8f1b
"libbpf: Prevent double close of btf objects") which defers the
btf_module_cnt increment until after strdup succeeds.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24420241619
--===============3782200397955678187==--
