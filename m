Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B6331ED0
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476180; cv=none; b=IY7yDDsjHOFl7yERo1vJsg/d6D2uaV3FeQKS/zYrzt9+dzbRdWwmbsv5KBDoP9TVbkoDMDBesDUeoeDONVXsxLlUYtYPZfIPMS12kLvHXwV4ozFxj4YyAWseBfKZBs4xEg8YlIU2ERKsvFLRkesaPqVpNwcwdzCLserHIThNuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476180; c=relaxed/simple;
	bh=F7xj5ZYQP/YKirHeuiJpqCvSmMagzRUvAznirSYzkF8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D9DpPErTQ7wIFF2F5siRl245WAIO3rPi83wLX/6fuIFvlIX70Pl9FRPWH3DZI7yQVFBkLxVPp3Mb968GkoST7tKytnotjvyxyfIRKgA4BLTD85UamBKq+DfZtNFxdJDbPX0VvgP3LzxrJ2+ZQc1dJY3U+usyIL0WU4WOvqkJkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw7mUIi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw7mUIi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664E31F000E9;
	Thu,  3 Sep 2026 22:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476179;
	bh=XAasNDdwgz7k8i5AGHGZ/ahUPTZvj5zKKPMU20axFoU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Nw7mUIi1EtuO3TRJ2noz+Qg6LDd9SKYo7841mtKuFmSMJh/RqwFV2IeN61xpf/1KX
	 v0JISq1X+SVTizf6oseSGyuHXrP5wczmu5rqxwyGSwNrrlK8Qqd/TtWotpJba4tQDl
	 KyCC4HXv4Ub5TqI5KhoZWkNdB3yPaAdvt3/7mu2Ve+odksOoXzL+lkPX+6TX4RrR9s
	 a5/Q9WrgExXla7vgA1kYambInHtss8YV2OsWPFzSGf3X114MW+IZfBd0xAJbP8giJN
	 xVMogB+b4M8jY40Qh2Mb+fyGCEZczN3Sy424Va9EP0bE0XmhklINBstUMqJg8Ft365
	 6ZlxnRd1/5fcw==
Content-Type: multipart/mixed; boundary="===============0050628592573822471=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <461693fbe4e4fcbf0c32d5cdbee372330f84fb6a188cb3a97b6b5cbcb98f6fff@mail.kernel.org>
In-Reply-To: <20260903214758.2727663-2-memxor@gmail.com>
References: <20260903214758.2727663-2-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 1/8] bpf: Check ancestor frames for rbtree callbacks
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 22:56:18 +0000 (UTC)

--===============0050628592573822471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 32d31fa67036b..26139fa09f12d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10235,9 +10235,10 @@ static void account_current_path(struct bpf_verifier_env *env)
>  					frame ? state->frame[frame - 1] : NULL);
>  }
>
> -/* Are we currently verifying the callback for a rbtree helper that must
> - * be called with lock held? If so, no need to complain about unreleased
> - * lock
> +/*
> + * Are we currently verifying the callback for an rbtree kfunc that must
> + * be called with a lock held, or one of that callback's subprogs? If so,
> + * no need to complain about an unreleased lock.
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   */
>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
>  {

Does this comment accurately describe what the function does? Looking at
how in_rbtree_lock_required_cb() is used in verifier.c, all four call
sites treat a true return as grounds to reject an operation, not to
suppress a diagnostic:

  check_func_arg():
      if (in_rbtree_lock_required_cb(env)) {
          verbose(env, "can't spin_{lock,unlock} in rbtree cb\n");
          return -EACCES;

  check_kfunc_args() [non-add branch]:
      if (in_rbtree_lock_required_cb(env)) {
          verbose(env, "%s not allowed in rbtree cb\n", func_name);
          return -EINVAL;

  check_kfunc_args() [RES_SPIN_LOCK]:
      if (in_rbtree_lock_required_cb(env)) {
          verbose(env, "can't res_spin_{lock,unlock} in rbtree cb\n");
          return -EACCES;

  check_kfunc_call():
      if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
          verbose(env, "Calling bpf_rcu_read_{lock,unlock} in ...\n");
          return -EACCES;

The comment states the function exists so there is "no need to complain
about an unreleased lock", but verifier.c contains no unreleased-lock
suppression that consults this helper. The actual unreleased-lock check
in check_resource_leak() operates only on frame 0 and never calls this
function.

Should the comment explain that the function identifies whether we're in
an rbtree comparator (or its subprogram) so that operations which would
break the native insertion's raw parent and link pointers can be
rejected?

> @@ -10245,17 +10246,19 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
>  	struct bpf_insn *insn = env->prog->insnsi;
>  	struct bpf_func_state *callee;
>  	int kfunc_btf_id;
> +	u32 frame;
>
> -	if (!state->curframe)
> -		return false;
> -
> -	callee = state->frame[state->curframe];
> +	for (frame = state->curframe; frame; frame--) {
> +		callee = state->frame[frame];
> +		if (!callee->in_callback_fn)
> +			continue;
>
> -	if (!callee->in_callback_fn)
> -		return false;
> +		kfunc_btf_id = insn[callee->callsite].imm;
> +		if (is_rbtree_lock_required_kfunc(kfunc_btf_id))
> +			return true;
> +	}
>
> -	kfunc_btf_id = insn[callee->callsite].imm;
> -	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> +	return false;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33811770362
--===============0050628592573822471==--
