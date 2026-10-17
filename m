Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF83939A4;
	Sat, 17 Oct 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257442; cv=none; b=IShM2FAhWlcSFZmaskz5XBeKj6Nb/KU4xYbdMnsoCeBNnpvO9s9aSgiWCMlWFiQ7TINrZp3T8r149L02EKI3HLl72kWWJAqFzGyCQmvE7n36NnB38UQ3fgKAtajK4b3s/PL458QrQE412apgjGSbW33z6/tjNriaJP4zDa1olOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257442; c=relaxed/simple;
	bh=93xnn34tD+1XhQ9yTePvda+bIbodSFjxFxIIFWJvP7g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=j+9h+GpVOw9BGu3dFvHHrSwBIQHQQWJIHgheLkE/TImhYyKeebVKOXaLxjp01BZDg2giy46QBTZ7has4ufWa8zNzjIkMZkdC5H5tIh8FmCXVojgcJBvUS+tTB94l80YMVKsoWM2X8Q1yXyaTt+lnNOoByVLh4iVTKmq7wd3jJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4HVdP2h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4HVdP2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980951F000C4;
	Sat, 17 Oct 2026 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257440;
	bh=clYl2oitVIcGRNdQXZuYf5YrawBK2Fa9489eSey5IDs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y4HVdP2hXsu0SNMKUOZ6ku7d4JFdFjzdO+Aiq9xqYut6ACmJ6pcmOhMC88nL2GLqa
	 298RwTWIhLkqlqATf0ju3STimjE0+T66/bgTiytcne15UcLnYo8lj5V7wInKprORHo
	 tTc7k7bPcCICQjAMz+yGUrt13cpVA9beEjGlUf0DmZxtiQNRTTx4vYr6JxnWjrkAH1
	 bVi3Lp2w8WZ55H8JvuNHH9NRp4YCZu4weCcRS2UYHGQBqZW7k7JjqwZn+sgUvPecHG
	 PMOKR/SIz4UF2kP2UJMF7DoN8OsEI/L0YR//UvIpI+KF+8FV5U6rzN4wnrbwWrGUSg
	 OaUclVs0/XCXA==
Content-Type: multipart/mixed; boundary="===============8715040808449314494=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c329f56d6d0f92d47cea5feebeba1ff70e395d3dec507f6073db340a41e943c9@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-39-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-39-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 38/43] bpf: Don't take a dynptr argument for a local dynptr
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:17:19 +0000 (UTC)

--===============8715040808449314494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Don't take a dynptr argument for a local dynptr

TL;DR: Treating every CONST_PTR_TO_DYNPTR as an skb dynptr also hits the
bpf_user_ringbuf_drain() callback's local dynptr, so the verifier may falsely
reject valid programs; nothing unsafe.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8416,6 +8416,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
>  			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
>  			       struct bpf_call_arg_meta *meta)
>  {
> +	bool is_arg = reg->type == CONST_PTR_TO_DYNPTR;
>  	int spi, err = 0;

[ ... ]

> @@ -8502,7 +8503,12 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
>  			reg = &bpf_stack_slot(state, spi)->spilled_ptr;
>  		}
>
> -		meta->dynptr.type = reg->dynptr.type;
> +		/*
> +		 * The callers of a global function may hand in a dynptr of any
> +		 * type. Take it for that of an skb, so that a write through it
> +		 * and its slices are treated with care.
> +		 */
> +		meta->dynptr.type = is_arg ? BPF_DYNPTR_TYPE_SKB : reg->dynptr.type;
>  		meta->dynptr.id = reg->id;
>  		meta->dynptr.parent_id = reg->parent_id;
>  	}

Is is_arg limited to global function arguments?

It is just reg->type == CONST_PTR_TO_DYNPTR, and global subprog arguments
are not the only registers of that type.  set_user_ringbuf_callback_state()
also creates one for the bpf_user_ringbuf_drain() callback:

    mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);

and the type of that dynptr is known.  bpf_user_ringbuf_drain() always
passes a local dynptr over the ring sample (kernel/bpf/ringbuf.c):

    bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);

After this patch, every consumer of meta->dynptr.type seems to treat the
callback sample as an skb dynptr:

- bpf_dynptr_write(sample, ...) in the callback hits

      if (dynptr_write_changes_pkt_data(dynptr_type))
              changes_data = true;

  in check_helper_call(), which ends up in clear_all_pkt_pointers().  The
  callback is a sync callback verified inside the caller's state, and
  bpf_for_each_reg_in_vstate() walks every frame, so packet pointers held
  by a calling tc/XDP program across bpf_user_ringbuf_drain() would be
  invalidated.  The dynptr-writing kfuncs (bpf_dynptr_memset(),
  bpf_dynptr_copy() on the sample) go through dynptr_write_type and behave
  the same way.

- bpf_dynptr_slice(sample, ...) now returns PTR_TO_MEM | DYNPTR_TYPE_SKB,
  which makes reg_is_dynptr_slice_pkt() true.  In any program type, that
  slice is then invalidated by a call to a global function marked
  changes_pkt_data.  Since c84400f5fe42 earlier in this series, that mark
  covers any global function that calls bpf_dynptr_write(), even just to
  fill a ringbuf record.  Passing the slice to such a function is also
  refused ("cannot pass packet pointer ... function may change packet
  data").

- bpf_dynptr_clone(sample, &c) now makes an SKB-typed clone, which carries
  the same effects.

For example, a syscall or tracing program whose drain callback does:

    m = bpf_dynptr_slice(d, 0, &buf, sizeof(buf));
    if (m)
            handle(m);

where handle(const struct msg *) is a global function that copies *m into
a ringbuf with bpf_dynptr_write(), was accepted before this patch and
looks like it is rejected after it, although no skb is involved.  Nothing
is unsafe here, but it is a false rejection of valid programs that the
commit message does not describe.

Could the SKB assumption be applied only to dynptrs set up as global
subprog arguments, for example by marking them differently where the
subprog argument setup currently calls:

    __mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, 0)

and leaving the type of the callback dynptr as BPF_DYNPTR_TYPE_LOCAL?  That
would also make the new comment match the code.

None of the later commits in this series (222dc092c64e, e17707d54c68,
0bd8e7a834ac, c04474b8dc8d, 64e0b112d688) change this, and e17707d54c68
and 64e0b112d688 add more consumers of the SKB classification.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============8715040808449314494==--
