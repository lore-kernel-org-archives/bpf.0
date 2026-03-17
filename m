Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0722A817;
	Tue, 17 Mar 2026 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709377; cv=none; b=o8OmfWWiSJZyd84IiOO9Q1b1WhQk3NHfpZxadW3ZSA+E20T80FpqqNufgopgzpqGKgh5SQcYNgFw46ZxoTQfO7M+k1rk3BCeS64nwXiDrkJldNU0OUrMm0a/vHYKNul0EtWIOmkxbZJx/ox7hCJ9d7z0FyFK35KRf4tEPZ/TIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709377; c=relaxed/simple;
	bh=SrcCaq6L3HGGbHtyXg0kmVc5GtQLy0x7JiHa8VogZjE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AesoqrYlNxa7W3AnrpCcpnCS/pdVSWPIRq/gi1pWJhyKM75zK3BJAw6GkFP9P7l9sOOR4CEDNiZhgBfnslGTtCUuHi8FHJ8pzrwtYONmg64MTtkaPLlKiZyZmcW7bkqW+0wASGG2aH1/T7kT1/OOWefP4iFsbTTvmk0eKcEiSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbUfAJba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbUfAJba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96312C19421;
	Tue, 17 Mar 2026 01:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773709376;
	bh=SrcCaq6L3HGGbHtyXg0kmVc5GtQLy0x7JiHa8VogZjE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LbUfAJbakYtMbAr0N8p/aFs4TgbarPyBp/C1nO1citN2bdoC38MLB0LlRh+hVXRB1
	 soMlAw5KyMkN4JVxFCbETTtUBx7ko860xMYLeNdD0+X30cBCVyZHuC4kHzfQQ1iWPA
	 nA8OQxpWN5tQ5A03BD5xTEcdvDignmOD5lP27bGiqEPGRfBjF7HfwHIit0hai8nyUL
	 HmoYGOG3PbnM9fCGeVlwIH++pb1E3i4RGFNX2KiSMeO6119K9/nUS0SBcgyX7Gu3hL
	 7nTyJIE5D02mswk9O+UD5IP402ApBjBBWaTO2/plo1FmRV/h7m6WEmMwXx1yeiECf6
	 +VxMuGmkZtzeg==
Content-Type: multipart/mixed; boundary="===============8741893278361517158=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cbc753d17a4e0037aa7e0711ef6cd3a34e7e82dca5a3ef445b7d78af51e5a1cb@mail.kernel.org>
In-Reply-To: <20260317001325.318004-1-ihor.solodrai@linux.dev>
References: <20260317001325.318004-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix exception exit lock checking for subprogs
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@linux.dev
Cc: memxor@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Mar 2026 01:02:56 +0000 (UTC)

--===============8741893278361517158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20911,7 +20911,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
>  	 * state when it exits.
>  	 */
>  	int err = check_resource_leak(env, exception_exit,
> -				      !env->cur_state->curframe,
> +				      exception_exit || !env->cur_state->curframe,
> +				      exception_exit ? "bpf_throw" :
>  				      "BPF_EXIT instruction in main prog");
>  	if (err)
>  		return err;

This looks like a bug fix but appears to be missing a Fixes: tag.
The buggy check_lock = !curframe logic was introduced when the
inline code in do_check() was refactored into process_bpf_exit_full()
and check_resource_leak() in commit 2d419c44658f ("bpf: add fsession
support"). Should this have:

Fixes: 2d419c44658f ("bpf: add fsession support")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23172639489
--===============8741893278361517158==--
