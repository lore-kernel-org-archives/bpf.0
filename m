Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914542;
	b=NER+qR7KwRvlw8LfSvj6mMnQ+l8sahslAMqOaDMhNyZgACOqem5ytr48cm6+zhWNRc/h
	 t9LIRaqNB//zqeOyY0q5UWavUF+FhH254x2Z2F1vkaguXQj0BjTzk8LWe/lDn2A+LCUxo
	 pWIWlV/RguhtBkh4V5137O28zEZZCBoF5vqqOIL9wFxXFqNUEdXfN4Edht2Xi4oiQVW7V
	 OCSJllWSuzxvL12z2Q03zCXp2naixwOwTH/DDPBsrspKoIiQIcCVOJqnFHMN/xUGgxiOF
	 yY1rPqDVIsPfk9zAJU4V0DG/jO5fQRRUiWDBD8637j2a67+RJbXIR8WrxVo0xxnfbZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914542;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=4jvn3vOSu80JRnNu6U8X5A+jJZMAeVQda0w01DHIgUk=;
	b=wG+17JJ1Oe1MVjtkO6MXkxkvxMhDAXw9LX6I+ZfjG5RUroRkl9SqbpBp+1b4xpI/CXGk
	 HjXzmzX3WMA+ACUahWdiKbeVqbuXaBYdegclUYyM964bfm+VLHAj9Abv2+M8d/wvUi1C3
	 1IV+DHBua0896Pf4966++r97mGj7xgjN0tsTYdEPH/FAoo4H1tEyRjrTekt7WYN0JhkQD
	 UULDNoWoXkv42DbDIie2tSW+hbLnRxbAYa/4dcPhTbwlammtKF7d8awCqUnJdI3KqC3BO
	 ho9M7WtglgkiTv02Kf9FeVaZRp4rrO/2tEBS0q54Msnh83MihUJifT5HarKEioJ7CVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAzKsoOW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A26082BD9
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAzKsoOW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C0E1F0089F;
	Thu,  5 Nov 2026 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914541;
	bh=4jvn3vOSu80JRnNu6U8X5A+jJZMAeVQda0w01DHIgUk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jAzKsoOWsNfS7P8qKicWMvs2DzIZhDO4LNpH/YChg7kreLH8RF/3y8G3hmNGLUOV7
	 iRrdx23S+VYXQ6i4cBuUOGQvcJUnH0FTZLyMnW+TA6YOy3SZ42kvMmOjCbUBaHwC7b
	 FYAdhDREh98D7Y+p31gVOoI+X7entYQlbEgB32Nu6wqbrIJbG7ew9X4rjb7wmNj386
	 o081sirg3eMlEFdexpas2aVwJy70LEeVDDXL6HaoSt9SMz2cGAUgP63bHXRJEDWrxr
	 y2VHSGBzZqEQNTm7Vg9WECERgLuxsAhUmK1th3L/wR9u0J3qNQpNGlt0C9W+/c+INV
	 cOg2RRRdz65lA==
Content-Type: multipart/mixed; boundary="===============7884880621416362325=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5f9121450ff35836bcb6d503a67c7d8a3784bab624f4d903c65ca0807d1cbf3b@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-3-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/35] bpf: Limit depth and time of recursive subprogs at run time
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:41 +0000 (UTC)

--===============7884880621416362325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Limit depth and time of recursive subprogs at run time

TL;DR: bpf_insert_recursion_checks() may raise a recursive subprog's
stack_depth after check_max_stack_depth() ran, so call chains could exceed the
kernel stack budget once recursion is enabled. Unverified; no overflow
demonstrated.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> +int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
> +{

[ ... ]

> +	for (s = 1; s < env->subprog_cnt; s++) {
> +		if (!si[s].recursive)
> +			continue;
> +		if (si[s].arena_stack_depth) {
> +			frame = DIV_ROUND_UP(si[s].arena_stack_depth * (THREAD_SIZE / 2), room);
> +			if (frame > env->stack_limit) {
> +				verbose(env, "no room in the stack in arena for recursion\n");
> +				return -EACCES;
> +			}
> +			si[s].stack_depth = max(si[s].stack_depth, frame);
> +		}

This isn't a bug as such, but a subsystem guide flags this pattern as
potentially concerning: a rewrite pass that adds to stack_depth after
check_max_stack_depth() has run, where the program is JITed and the added
amount is computed rather than a small constant per subprog.

bpf_insert_recursion_checks() runs after check_max_stack_depth() in
bpf_check():

	if (ret == 0)
		ret = check_max_stack_depth(env);
	...
	if (ret == 0)
		ret = bpf_insert_recursion_checks(env);

Here si[s].stack_depth can be raised up to env->stack_limit, and each
frame is checked alone against it.  Are the sums over call chains that
check_call_depth() accepted with the old frame checked again?

For example, take a recursive R with stack_depth 16 and an arena frame of
4672 bytes, and no other arena frame.  Then room = 32768 - 4672 - 2 * 4672
= 18752 and frame = 2041.  If R calls a non-recursive leaf X with
stack_depth 2000, check_call_depth() accepted R(16) + X(2000) <= 2048, but
the frames are now R(2041) + X(2000).  env->max_stack_depth is stale as
well.

The comment above the function says that below r10 there is the frame of
the subprog, then "a chain of calls that check_max_stack_depth() looked at
together with that frame".  After the raise, check_max_stack_depth() did
not look at that frame.

Once a later commit (cfd0b02db6cf, "bpf: Allow recursive subprogs") sets
si[s].recursive, could the lower half of the kernel stack hold up to about
3 * stack_limit of BPF frames (the last frame that passes the check, its
chain, and the frame that fails the check) instead of about 2 * stack_limit,
plus the bpf_prog_report_recursion() stack walk and printk?

On x86-64 without KASAN (16K stack, 8K lower half, stack_limit 2048) that
leaves roughly 1-2K below the frame that fails the check.  It would only
affect recursive subprogs that use the stack in arena and whose arena frame
is large compared to the room left in the 32K arena stack, and no overflow
has been demonstrated.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============7884880621416362325==--
