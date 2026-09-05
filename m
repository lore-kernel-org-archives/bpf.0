Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273932E06D2
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569513; cv=none; b=IUO6vDMY6NXGDx67mexnFVIMmQHt46NJcroLwamNsl/lYT0p822+2ftpER6VonDXPBaG5NLK6WWSshBg0wVPail+dZxURoI2oQ7OwEOM/HUFbMfVd4f5VzpOYqeKHXpja4pDghWc6NFroPoiQEGwvTV0u9UPVzFxB1zSXQcUnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569513; c=relaxed/simple;
	bh=QCVzeezZhlosxASj25WsVlNwLf2bZ4bX0eprxNEnhqE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Rt2dhhqAdT/pOZAhm0qWrDTmFxuTYI/q+oeAWQmfS+t28mxyKzW8PyGhI7E3fYXSn5a0baao2yixiBogmYsBiyBBcN9j6/uGDTaDR4MnlZMnOgIGxI4eKXA38BFELMKFqpMblb38f8hZhaq4Jmu1wAQ4fPp2jqAua+u0vjCFccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+TpkW6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+TpkW6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DFB1F00A3D;
	Sat,  5 Sep 2026 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569510;
	bh=qX9YdiP4sPw3E+R9EzY0ClsuUn7KVKYOdn1BB2xO21Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K+TpkW6VBm5/FzlJzfp9+hDmgaIIn1ZTQL+wNwfcSpeVS8aLf2D8g5ET6VtqQfwdI
	 1fB1zZaN72ypvZvKq2uHo+GsVrITZv+s8xoJj0rSH6xgx7676GgP2sAd+Q8Ffif68A
	 3WYaeNrV4YLzYbyl7OE7OiemUZ3/DK6VuGI2+rHheK07FXUw7dTyPzefKonutctYQd
	 DMqBru/MspytyyK+zqUO7pQwMYBcGM7dKh/23Qf+cuyIjCkL+3uKnkS3cmgUH5SwxT
	 ZhUz/OavXe4WGELk+DDpNAI2H/U85ItZHGZZP1hCJCjhjfnCKPy8bnE6H86iWwPcr/
	 PBQ7TewsuNriw==
Content-Type: multipart/mixed; boundary="===============6905752161653878596=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a641b37e4e3e21ef926438d6da0a33ca798a0d327a22f2ab8be2918a86ebcfb9@mail.kernel.org>
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-10-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-10-0f5a360ff15d@gmail.com>
Subject: Re: [PATCH bpf 10/10] bpf: use mark_arg_precision() in check_mem_size_reg()
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 00:51:49 +0000 (UTC)

--===============6905752161653878596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e8af1d3dbdeb..1c3039f3fc32 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7160,14 +7160,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>  	if (err && failure)
>  		*failure = BPF_MEM_SIZE_FAIL_MEMORY;
>
> -	if (!err) {
> -		int regno = reg_from_argno(size_argno);
> -
> -		if (regno >= 0)
> -			err = mark_chain_precision(env, regno);
> -		else
> -			err = mark_stack_arg_precision(env, arg_idx_from_argno(size_argno));
> -	}
> +	if (!err)
> +		err = mark_arg_precision(env, size_argno);
>
>  	return err;

This isn't a bug, but since mark_arg_precision() now exists, could
process_const_arg() and process_const_alloc_mem_size() use it as well, so
the reg-vs-stack dispatch lives in one place? Both functions still
open-code the identical four-line pattern that was just replaced here.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33932783420
--===============6905752161653878596==--
