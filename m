Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E37E3D9674
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222187; cv=none; b=cdMikbrk1wTSkNn07rrRz/jz4akVYD5lgLH6/JCaSxvaTy8IwqVR/4A5csPP3O8PB7VzERmFi2NA2nLT01+TN7TZQltPg0CpxG53ws5BM2jPg0qKNcieCQuCLrif8GQmkmfwbrXKnf4WJ8MmhRaMat5caUodfD8D1sNIMfYlNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222187; c=relaxed/simple;
	bh=JKRgj8ZEUEFuVcv0I5nauNwdfend54k/MwOz5VvInhU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iTm3yZGtDgD0/ihHO4tMVHQQ8Ot5u2eoJy/I6VDEOPmA5w3YV3GhMLBz7KY0ocd07K5xBAeYrskgXHGGZdxS4AMBoXM9yany0kfXlHOAKadE1RxLyOsQBoatTmXG3W2fouxhVG2qtISWU677wrL3qZZSZjy/GQczVhnSp+1Ery8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M69Xz4ko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M69Xz4ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9381F000FF;
	Thu, 24 Sep 2026 03:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790222185;
	bh=hqd5lheG4032mnB2rsV+bHqfLJtTxywU0n2t8jMZrqI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=M69Xz4koF4PbCCu2PtYTNA/Gfrwl0gm/bRj+RApicjLc1QlrAOfwF+GzS12d4NbkX
	 D43kBx9OiFNnMYCJnKrKGoXuop5raY2lX3SdurtrNdkVAWKIDkX79SpJxfdc4bG4ma
	 sc9PmipWwtyNsZMMiftOuvp13hkgLqRYvMy0R9WcHr+Rhx+zBAXy8loKXDQUa7zDaG
	 CmXBxMWFAaRhsBNaW0fLwHZRgoT2dQhnu2asGqyZGe7rEXTMTGFxeDm48coQBmsC2n
	 8ywX4k+qY/noeB5w9OqPPHWdMeqEXMjzvM+3GzxId5dIebUopQR7AQVjUAlAvtVp4P
	 ryCX8gvgr22Zw==
Content-Type: multipart/mixed; boundary="===============5623308181778460454=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4a58d29d46c559a643c5dc1fd859d7ec93482705257cc92bcc86f8d1f4deeff2@mail.kernel.org>
In-Reply-To: <20260924031042.1690890-7-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 06/17] bpf: Add callx calls to the call graph
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 03:56:24 +0000 (UTC)

--===============5623308181778460454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 6380c851ed24..931f305fa440 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eb014bf6a2e8..d00d0ecab17c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10615,6 +10693,15 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>  		return 0;
>  	}
>
> +	/*
> +	 * The address of the callback might be taken in another function or
> +	 * read from a map, see check_func_ptr_read(). Like with callx it's
> +	 * known here what is called.
> +	 */
> +	err = record_callx_edge(env, caller->subprogno, subprog);
> +	if (err)
> +		return err;
> +

Could the map part of this comment move to a later commit?  The comment
references check_func_ptr_read() which doesn't exist at this commit.

Looking through the tree, check_func_ptr_read() appears in a later commit
(0ff120b53396 "bpf: Recognize pointers to functions in read-only maps").
That commit also enables loading PTR_TO_FUNC from map values, which isn't
supported here.

Until then the comment has a dangling reference and describes a capability
this commit doesn't have.  The address-taken-in-another-function case is
the only one that applies.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35951148075
--===============5623308181778460454==--
