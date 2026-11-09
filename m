Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246150;
	b=izv3TZkvgh1Mpa2LPPv+Ws5JnnAMADU0xjhYpn4cCSrwV8XjnIXSORhSqBvg8aRUQHuP
	 /Ev7HafphkEBgmXpDO+3UTXlTEyVupXzP16cv6etvd7zCzz2atRvcYTfeRFx5HuzEzks4
	 FeydkpL2JQAVwyaq2jPRM4+wa9jgDpFgxNei2iblKk1HNPARJW7K32WjVzvJuofbZoFqq
	 7/oHdkWtA3Ca/an1bLuJmTBYnB3vHjZmkc65S7iVA4+4hObGNpMJG4Zv00kInm9goj/iN
	 /jEYys53L8EeYsxIAXRQC/I7dsxzxM/78lrhpjx0U9M2kgxHBoddiJB9KYxU/IhB6lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246150;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=tHJx1/FOrLGsR7N77Cqpc08GgZQWrWPpNrMcrbbn7BA=;
	b=d/oNK1DDSbJHJuExHELumTNuGGZPAIeU+knSRlv/WOPVTrQyVTZCoJWg4dwThBfiwcqy
	 3Cu5DOmlaIbrA4rMi/k8xyBjxRYe1eBXMKsLhnJe9NyCQJy0Ky6hY4fRhk4NbKQLe476p
	 516vUR/sdFEmj02mGUhq4NFrb3gZN3RaeBON4Ft1svBeERFZACWuK63CPmEgNdmr9OV2i
	 pSf8JIUPu2a1BR9eXkT76/3zJsk3QudM/22v8PaX4RJ9VBv8ViZmKjW4IDQm2ulL2RLHa
	 dhV67FmNlPfWdBGMWUEet7j2TuyG0pJqMnvmmGYV2wuis+1upCPiEln5QePqjuVcPXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIerO48x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D1606A33D;
	Mon,  9 Nov 2026 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIerO48x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4AB1F008A1;
	Mon,  9 Nov 2026 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246149;
	bh=tHJx1/FOrLGsR7N77Cqpc08GgZQWrWPpNrMcrbbn7BA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EIerO48x990RBuV1/ovX0R0OO8EYullDHg6+20mkoG7Q7X16C4HL91XDBwmOPnSET
	 8QmojDgnAVnFk25q7o1sLl6XPijs85J+Y1kbICZFy628cQG2doDeyJ1tkdPK1y3Q2Z
	 gqeKFw3jppAFerpJZHQkb7zsOYYu/QbbmaLMFbRKCflUDcpTAkVZ0m0iYuSS4DsYus
	 aZMNSQaoO8DbgvIaqqKOSh9xzIpj1xRkTLB9M7DkXne03dq72S/OtuKOyjc9S9rVS7
	 VNgLgDryjQNPYs4Gg9UtBhDRaC4BCl1d6l4/fpucRd4zQBnxEquHnj+pbDWJgKtN8k
	 3sDX+9dmz+m8w==
Content-Type: multipart/mixed; boundary="===============8466003635842146715=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <069d59babf1ed531e1a5c1bd4ec0a943f7e8f12fc1e18f0ccc8b4edd032974a0@mail.kernel.org>
In-Reply-To: <20261109170550.141443-16-a.s.protopopov@gmail.com>
References: <20261109170550.141443-16-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 15/18] resolve_btfids: Tag fmod_ret candidates as targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 17:42:29 +0000 (UTC)

--===============8466003635842146715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Tag fmod_ret candidates as targets

TL;DR: resolve_btfids may tag KF_IMPLICIT_ARGS kfuncs (e.g.
bpf_wq_set_callback) as fmod_ret targets; the trampoline may then clobber the
implicit argument, and the kfunc could dereference a garbage pointer.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -1841,6 +1888,16 @@ static int btf2btf(struct object *obj)
>  		}
>  	}
>  
> +	for (size_t i = 0; i < obj->fmodret_retvals.cnt; i++) {
> +		const struct fmodret_retval *retval = &obj->fmodret_retvals.retvals[i];
> +
> +		if (has_set_func(&ctx.fmodrets, retval->btf_id))
> +			continue;
> +		err = add_fmodret_retval_tags(&ctx, retval);
> +		if (err)
> +			goto out;
> +	}
> +

Can this loop tag a kfunc with KF_IMPLICIT_ARGS as an fmod_ret target?

The kfunc loop earlier in btf2btf() has already rewritten the BTF
prototype of such a kfunc through process_kfunc_with_implicit_args():

	t = (struct btf_type *)btf__type_by_id(btf, kfunc->btf_id);
	t->type = new_proto_id;

so the BTF FUNC no longer lists the implicit arguments.  fmodret_collect()
ran before btf2btf() and compared only the return type
(btf_func_int_return_size()), never the argument count.  The only check
here is has_set_func(&ctx.fmodrets, ...), which does not consult
ctx.kfuncs, so the same btf_id still gets "bpf_fmodret" and
"bpf_fmodret_retval:...".

bpf_wq_set_callback() looks like a concrete case.  It is built with the
plugin, has an ftrace call site, and starts with a side-effect free
error return:

	if (flags)
		return -EINVAL;
	return __bpf_async_set_callback(async, callback_fn, aux->prog);

so it would get "bpf_fmodret_retval:-22".  The kernel then adds it to
BTF_KFUNC_HOOK_FMODRET, and bpf_check_attach_target() accepts
BPF_MODIFY_RETURN through btf_kfunc_is_modify_return().

The trampoline model is built from the 3-argument prototype.  On x86,
__arch_prepare_bpf_trampoline() runs the fmod_ret programs and then calls:

	restore_regs(&prog, pos_of_slot, nr_regs, regs_off)

with nr_regs = 3 before calling the original function.  rcx (aux) is
caller-saved, so __bpf_prog_enter(), the program and __bpf_prog_exit()
may have overwritten it.  If the program returns 0, which the verifier
allows, bpf_wq_set_callback() dereferences a garbage aux->prog.

The same seems to apply to the other KF_IMPLICIT_ARGS kfuncs that return
int (bpf_task_work_schedule_*, bpf_list_push_*, scx_bpf_*) whenever the
analysis finds an error path for them.

Would it make sense to skip retvals whose btf_id is a kfunc with
KF_IMPLICIT_ARGS in ctx.kfuncs, or any kfunc whose prototype was
rewritten?  No later commit in the series changes resolve_btfids.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554
--===============8466003635842146715==--
