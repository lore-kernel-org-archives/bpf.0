Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0D2E9729
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933478; cv=none; b=JQFaDsbUvE+VVwMaZgUz92JWAczL1VXm1WFZeSOlkybwR1EzEYsoADIVMeEdC4H/v4CLOLVrhKFP8tVfbe+O/vh7D8R119FXEo+rPRpWNDCXKJ2WoXrhUOhvPWut96ebHIT0F3dsBSW2K3EBlcEakJqtvqkYLZZ1nAk1VbeAB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933478; c=relaxed/simple;
	bh=rY/R8NHX5B58eju/P7vWPvPmeD3t7bmhli3x0P6LxwY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f9khxiyuY/eMQAhzUXcE7uzG2YEBHzZe8TicaDz5F9kV4/9TB1wX9I6Tn2zrvtK67F/RNh5krieyR7vxZmw1Z7ExP917WDCl701nz/j6tSXSg3CiiSTjLQrLkbPEOmeSu84GP+ceoS9xPbXaydUwCuNp8dLW0Ak41abRCKz4fTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFKuZZ9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFKuZZ9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1691F00893;
	Mon,  8 Jun 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933477;
	bh=T21Z5+pC2iJEzM1TWC/18jDu7ERaQCxJcWbNpZtT3rU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oFKuZZ9HcUupU5Q9oLhbJuX5F1tWYMGn4tUXa9dQCRLASaKkKSu0dEvjiBBF2YCaT
	 iSIiTRq5HUmQj525Hce350By1pcWFGIxcPhoGrBbx4IkwDcab29s+TCmYqSE9l2sRV
	 jg9T2i2ERiz0hjEjNv3O0buUPGukoAZac0z5ZtikAX0iaBJGGI+UXYM+qNYG4lih1A
	 kt/9KmPtfQR7YVWqbaXRV7TCqixp3IISUxYlsi/6QaDRXyijWbG4b9BX7HIDwqUxts
	 HltPjip+27EvIwbnwRUjst5xzbDtDLtGY7eYhAAGFIW1neoEbY1Uhtev30Hzko8kGd
	 A5BUvM0dir0Ew==
Content-Type: multipart/mixed; boundary="===============3917546861797218486=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b7e6ff96b3a39b6f9738de78f9f31382d93501aa956df8d94831b35a6129432@mail.kernel.org>
In-Reply-To: <20260608144841.1732406-2-memxor@gmail.com>
References: <20260608144841.1732406-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/5] bpf: Treat non-iterator tracing progs as tracing
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,utilityemal77@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 15:44:36 +0000 (UTC)

--===============3917546861797218486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce..26bfb4465725 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17697,24 +17712,16 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>
> -	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
> -	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
> -			return -EINVAL;
> -		}
> -	}
> -
>  	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
>  		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
>  			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
>  			return -EINVAL;
>  		}
> -
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> -			return -EINVAL;
> -		}
> +		/*
> +		 * Rejecting tracing progs accessing maps with bpf_spin_lock in
> +		 * them here would be too conservative; let's defer rejection
> +		 * until seeing first use.
> +		 */
>  	}

By deferring the is_tracing_prog_type() check to process_spin_lock(), the
patch prevents explicit bpf_spin_lock() calls but may not prevent tracing
programs from calling bpf_map_update_elem() with the BPF_F_LOCK flag.

This flag triggers copy_map_value_locked() which acquires the spinlock via
__bpf_spin_lock_irqsave(). Since tracing programs can run in NMI context,
if an NMI interrupts another context holding the same spinlock, it could
result in an AA deadlock:

CPU1                                    CPU2 (NMI)
bpf_map_update_elem(BPF_F_LOCK)         bpf_map_update_elem(BPF_F_LOCK)
  copy_map_value_locked()                 copy_map_value_locked()
    __bpf_spin_lock_irqsave()               __bpf_spin_lock_irqsave()
      spin_lock()                             spin_lock() <- deadlock
      [NMI arrives] ------>

Does the verifier block BPF_F_LOCK at load time, or does removing this map
compatibility check expose us to this deadlock vector?

This concern was raised by sashiko-bot@kernel.org on lore:
https://lore.kernel.org/bpf/20260608151331.730D81F00893@smtp.kernel.org/

The commit message also states:

> bpf: Treat non-iterator tracing progs as tracing
>
> The is_tracing_prog_type() predicate omitted BPF_PROG_TYPE_TRACING even
> though fentry, fexit, fmod_ret, raw_tp BTF and similar programs have the
> same execution-context concerns as the tracing program types already
> covered by the helper.
>
> This matters for map compatibility checks that reject bpf_spin_lock,
> bpf_list_head and bpf_rb_root in tracing contexts. BPF_PROG_TYPE_TRACING
> programs can run from arbitrary instrumented contexts, including places
> where taking these locks or manipulating graph roots is not safe.
> BPF_TRACE_ITER is different: iterator programs run from task context, so
> we continue to exclude them.
>
> This can reject existing fentry/fexit-style programs that use map values
> with these fields. Such programs were accepted only because the
> predicate missed this program type; their use depends on semantics the
> verifier already rejects for equivalent tracing hooks.
>
> Move is_tracing_prog_type() checks from check_map_prog_compatibility()
> to points where the fields are actually used to avoid preemptively
> rejecting tracing programs that use maps with such fields but do not
> touch these fields.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix for handling BPF_PROG_TYPE_TRACING programs.

Should this include:

  Fixes: f1b9509c2fb0 ("bpf: Replace prog_raw_tp+btf_id with prog_tracing")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27147105932
--===============3917546861797218486==--
