Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717E32A3FD
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786538; cv=none; b=gX17fyI/CYRo95zbTgFtr4MBAcWR1y7HAt+bATJF/LdC0froYI6yKQcCHtfCGjKDSK6RjDCGCdnvUq5XGxP607mfFLE4NgUWZmmnFH3AlnQaj7lIduwEUqA3nQ2OdXKb8zdi36tPQ3hfYiEUhDVKJUa/UfYgjuySyUzl8wUfzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786538; c=relaxed/simple;
	bh=9v8q0Q600lEC+iOUd94NV9R0YrhqjOZEQaQmFrj0Clo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Oq0avzfKJzEWbf+wzrKZkzHLE+4giREshmwWhsQZxw1OKNQJHQ9pg/8wa7beH8Jpgy0LUQHRHV16CYQuqfLw2kEBKemjs6yS6iDuLjnEHH1kywtNmU7Ydb3LHmfewpEQfWpn+/hfGAdZpzQA2FJJo0VGcOurS2B2j8q5F3X6rWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErTwp3hD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErTwp3hD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30273C4CEF7;
	Fri, 10 Apr 2026 02:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775786538;
	bh=9v8q0Q600lEC+iOUd94NV9R0YrhqjOZEQaQmFrj0Clo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ErTwp3hD2JfPjDDWFo5kiGVEHt4kCCriPR3fwbaCEJ0ACgh+c+vwMg+lt2/qcWkR0
	 LcZxKzIS8JQ/WLNuBwGySlkyeFhBQPWd9ucEYr8e3aK6FvOWK5ZlM4cHGRIQye5uDH
	 YqQ1b21Tu68Sk6iZyu/YMeV+WK14wv04ir7l/aUiUzKDXVxGIqyZxmOeiz7YdTo8RR
	 ExMjnPU2pJr5o21W8l1aDSutdsUjR3ElCFdCnBjLs2XdgoDh3wdM5RKhM7U3BIlQsk
	 ujYkq6pAxhRGzxnC163BrIuMVEDLVuNwqSrRENNsdbRANvdme//R6GIYT3kUK3/Gce
	 SJkLR7dfILPow==
Content-Type: multipart/mixed; boundary="===============6201246043053022045=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <38436bcc948cc2118d4a93ffc0f524680592314bbecd71c598505fd0455ce10d@mail.kernel.org>
In-Reply-To: <20260409-patch-set-v2-13-651804512349@gmail.com>
References: <20260409-patch-set-v2-13-651804512349@gmail.com>
Subject: Re: [PATCH bpf-next v2 13/13] bpf: poison dead stack slots
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 02:02:18 +0000 (UTC)

--===============6201246043053022045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f639f0eebebb..11df478dc106 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -1390,14 +1391,14 @@ static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
>  {
>  	if (*stype == STACK_ZERO)
>  		return;
> -	if (*stype == STACK_INVALID)
> +	if (*stype == STACK_INVALID || *stype == STACK_POISON)
>  		return;
>  	*stype = STACK_MISC;
>  }

The function header comment for mark_stack_slot_misc() says:

  Mark stack slot as STACK_MISC, unless it is already STACK_INVALID,
  in which case they are equivalent ... we won't promote STACK_INVALID
  to STACK_MISC. In privileged case it is unnecessary as both are
  considered equivalent when loading data and pruning

Should this comment mention STACK_POISON as well? Unlike STACK_INVALID,
STACK_POISON is not equivalent to STACK_MISC -- it is deliberately
more restrictive (reads are rejected even in privileged mode). The
existing reasoning about equivalence doesn't extend to the new type,
so it might be worth a brief note explaining why STACK_POISON is also
preserved here.

[ ... ]

> @@ -5588,7 +5589,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>  		 * that may or may not be written because, if we're reject
>  		 * them, the error would be too confusing.
>  		 */
> -		if (*stype == STACK_INVALID && !env->allow_uninit_stack) {
> +		if ((*stype == STACK_INVALID || *stype == STACK_POISON) &&
> +		    !env->allow_uninit_stack) {

The comment just above says "If the slot is STACK_INVALID" but the
condition now also covers STACK_POISON. Should the comment be updated
to mention it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24221779050
--===============6201246043053022045==--
