Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705268;
	b=GWeqjSFeqpcr1kbz4DeXCcJqDBC3YHWSXAuvYs5NOGJCYH+wgicxgK+BQQidlFd5+1uQ
	 iHp51WzSTOLH1X9JMbA37BaTfJy8cThRSRiuVM+VTctA4mZSyd0fXJjNp4E0+icFuX5Dz
	 n4mLsVIaGtk1jK2CfHAbEmE9+0VNtY7X0UzJpZccUfopyjVt7G2Sweab8EX0w+gEbLNOd
	 uGy+8kmAH3//8JSDJzDPDnpspglawIrAvcwe8bvJhFS2/5XTrfsE4icNq02fXD5fK0knQ
	 i4jJGVQ/XxLQbhAfmV8r3lJnJiGqtGlRzSu6GMjS3hPHjSLo4MbMw7AHDRrEH5r2eCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705268;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=rej7/JvN/0xSPLoF9hd5aEjNjTkh5KlIlhWtUoj0QBo=;
	b=yRcEGOiAseU6DetOjK5uJQWHKt/uNCxDGrR1JKNEa77g8+8zq5B1Qi4pHOIPQ8NUmvbe
	 yefQHj7WTLhj8mteOeeJC/kyQQksAeypgTugIuGnwmwBpr+yDKRvMy/gDjncSPJGgCKwz
	 ZgiKcC54q5gm8YzsivTFITPlWSJnsIkMw16QUFxAS3qcqi4pKmUAa4FE3SO3T0IQi1wOI
	 VERgd6Lha9uWAhWvx6oujueWx4Dx/ihXm3mqVP84Aj1Zmzq9Ow0Srknqde6S9ig5YovB7
	 GG/FfxioX319O0o9ooHYPJhUMQcAe5SZIbBCMhjNN4jhEuQcecJWDHa+0UMjUBVomvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmKEGKGI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20222606A327
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmKEGKGI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6FF1F000D2;
	Thu, 26 Nov 2026 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705267;
	bh=rej7/JvN/0xSPLoF9hd5aEjNjTkh5KlIlhWtUoj0QBo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NmKEGKGIu2DEpPRs+1uW7AHTgLe8gWcQpaDfEa/ZqK+oTColWzumSA2lHoiiAiGDN
	 /gd8Quq4UNvQgOyA7byDedCS7NFTLdutXLwQ0EzH7F7um61EanAUqVl3GBw0v7+9Y9
	 ic3ZTVePWkIqNL9VEnfbUimZDW4BipVgKkzklPc5+zchPe00h8SsEMvhYnlPr0ej36
	 mn27uUPyBb1rrkRnpqjvmVux7MEv00zSjscrJ1WeqyUxzHyRrm7/05mI8Cu1qcggCa
	 1nLPYdXZMT3Up28JXazijX9aiDF8+7l3z3fw3p1JUPRdzA2jgwni55RHGQb2ClVIhU
	 g43hdnOjCXNOA==
Content-Type: multipart/mixed; boundary="===============5566463461957794927=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <94179833c6a4aab3dd44ee9d28f3f25f9e912c027ab41e82c254322c8dea91da@mail.kernel.org>
In-Reply-To: <20261126142915.1106330-6-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-6-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/7] resolve_btfids: Exclude bpf_*() and __bpf_*() of vmlinux
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,almagui@kernel.org,john.fastabend@gmail.com,bpf@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 15:01:06 +0000 (UTC)

--===============5566463461957794927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Exclude bpf_*() and __bpf_*() of vmlinux

TL;DR: Comment and commit message only: the code also excludes _bpf_*() and
___bpf_*() names, broader than documented; the review asks to document this,
citing _bpf_getsockopt().

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> --- a/tools/bpf/resolve_btfids/fmodret.c
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> @@ -105,6 +105,12 @@ static bool excluded_by_name(const char *name)
>  	return false;
>  }
>  
> +/* bpf_*() and __bpf_*() */
> +static bool excluded_by_prefix(const char *name, bool vmlinux)
> +{
> +	return vmlinux && !strncmp(name + strspn(name, "_"), "bpf_", 4);
> +}

This isn't a bug, but the comment and the commit message ("Do not tag
bpf_*() and __bpf_*() of vmlinux") describe a narrower rule than the code.

strspn(name, "_") skips any number of leading underscores, so _bpf_*() and
___bpf_*() names are excluded as well.  In vmlinux these include
_bpf_getsockopt(), _bpf_setsockopt(), ___bpf_prog_run() and
___bpf_copy_key().

The broader behaviour looks right, since _bpf_getsockopt() sits on the
chain the commit is concerned with:

    BPF_CALL_5(bpf_sk_getsockopt, ...)
    {
        return _bpf_getsockopt(sk, level, optname, optval, optlen);
    }

If the compiler keeps _bpf_getsockopt() out of line, an fmod_ret skip of it
would bypass the memset() in __bpf_getsockopt() in the same way.  A later
change that makes the code match the comment (for example, two strncmp()
calls for "bpf_" and "__bpf_") would reopen that hole.

Could the comment and changelog say "bpf_*() after any leading
underscores", and name _bpf_getsockopt() as a reason?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45839706175
--===============5566463461957794927==--
