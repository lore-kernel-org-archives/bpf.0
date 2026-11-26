Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701207;
	b=R+2CiMNBeVlaOmOwbQGk3wIsEigdQV8M0OFQ9S22+jxJx590abF5cLVNVVnvQzv1EKXk
	 GlLIpSFAL8RJa927LX+t/tKf8RuEhRzYh0pMwE5qJSFLDrpskZmcoq3Ce+b1NYpFGarVo
	 7AeV5XT4cwgmC3R+nnQLQfPu6hUg/cpnuL9OcUafXq3YWCLfcqV/nh1O3YONtyPxXVqTv
	 O0dJC01cHbWfpSyUmt4SAgr7rHtAxJUYduabCu8l9R8Upf5biIgWZ80tNdzrTH3IJJ4Wu
	 EMDfbLIqXLpb3ra4cVhTKLKXSc/VUGj0WVIChZNuXeNFa56dQtfzmNebW0v5/ZDZnkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701207;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=JDMNTLmWZnwJOZm/HJsmS0F4vjK45oBHPZNuOCeSZfo=;
	b=dgJBcnQIA+GKml4nD5Fhl3ktjrhgjCqEKwQgZQhT8nLnPzvj/CpmfgvDovYc/Ddl2gCa
	 G/K4g9Dem6yVHh+IXekkFGvG2bwNDgEEc9yTL8gkC/QYGSGkIlFaYSJMAi8DeLWVtGAyE
	 8/Kcxg1xmr90ZEcKO7Wv/ADA92IvuG0Ee1GetgPOHGj4ODnRncsjip1+9Zzf5SuIPRBBi
	 HICDfp2YPGhe1NX5hwSOjr00fSRzu/HXIDc6Ag4VP72sAIzsOc/bTXui2USjo2nrXbMRn
	 ZoTcCUDkhwVqZ4nGqWwVVOJ2VoMxiBzC3/jnuzAUP1+aQ7E825baMVTF3/hvcZRrqZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHRyBuMY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1B606A33B
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHRyBuMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215221F000D1;
	Thu, 26 Nov 2026 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795701206;
	bh=JDMNTLmWZnwJOZm/HJsmS0F4vjK45oBHPZNuOCeSZfo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YHRyBuMYRxuHkG+GKOCQY3OX3NdSnSeKXMM6sgm4L4tNgunBrj9LR8BEph7Bnk/+s
	 s4Iwjwp5APlsD/4JbX0IZvBrdX1ncKo2MT3J/plhE+4mgVX2hHPhEpOz/5O7Pag5QP
	 QjWR5AQZglDzxpK+ELZvults6XyUGSlU6w1/WhVuhm63TuPFyr4wDxcDh86v94Mr0a
	 YEfEF3u5IDVtCyR4XQa9XAJN5M38S/XpU5NOnKlDuGtwE1OqUa64U5ZSP95ODp0Zbr
	 Lt6PaY+fCWcQFlaNnibQIhAUrKwP/7RTn63+P+qLdE3tONhJSbMPI9JvZgg7PK8JQS
	 ULqyqe19flTJw==
Content-Type: multipart/mixed; boundary="===============4309586512296835135=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4ea70da792203f6a0d189b7c97a20c0efd0d65f08b87dbbb7d4b953b566bd04c@mail.kernel.org>
In-Reply-To: <20261126-bpf-relax-get-next-id-v2-6-039e92757f9c@toke.dk>
References: <20261126-bpf-relax-get-next-id-v2-6-039e92757f9c@toke.dk>
Subject: Re: [PATCH bpf-next v2 6/7] selftests/bpf: Explicitly disable token in token/obj_priv_freplace_prog_fail test
From: bot+bpf-ci@kernel.org
To: toke@toke.dk,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,toke@toke.dk,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 13:53:25 +0000 (UTC)

--===============4309586512296835135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Explicitly disable token in token/obj_priv_freplace_prog_fail test

TL;DR: Test issue in token.c: a stale comment, and the positive freplace test
may no longer cover getting the token at open time, since the failing test now
runs with the token disabled.

> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c

[ ... ]

> @@ -830,7 +832,7 @@ static int userns_obj_priv_freplace_prog(int mnt_fd, struct token_lsm *lsm_skel)
>  	struct priv_prog *skel = NULL;
>  	int err, tgt_fd;
>  
> -	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd);
> +	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd, true);
>  	if (!ASSERT_OK(err, "setup"))
>  		goto out;

This isn't a bug, but the comment above userns_obj_priv_freplace_prog() still
says:

  /* Verify that freplace works from user namespace, because bpf token is loaded
   * in bpf_object__prepare
   */

After the libbpf change in "libbpf: Move bpf_object_prepare_token() to object
creation", bpf_object_prepare_token() is only called from bpf_object_open(),
so the token is already present when priv_freplace_prog__open_opts() returns.
Is that comment still accurate?

The positive test also still calls bpf_object__prepare(fr_skel->obj) before
bpf_program__set_attach_target().  Previously
userns_obj_priv_freplace_prog_fail covered calling set_attach_target() with a
token on an object that is only opened, and that now runs with the token
disabled.

Could the comment be updated, and could the bpf_object__prepare() call be
dropped (or a variant without it be added), so that a test still covers
getting the token at open time?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45831277005
--===============4309586512296835135==--
