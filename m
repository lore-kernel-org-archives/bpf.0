Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2053C09E7;
	Mon, 17 Aug 2026 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002623; cv=none; b=uhu8ioku0jMrnjkpfykqxs+OpZ6+U1HdjGXTA+XlWlw4Db11U/CAjbuFxl4+xmtqXzYrh7FBOl8ZKvSGXP/ou2oEZyz6zXiLDgA/xVZuviirwsOoshemsv7ZMhhI/Mqj3yrmJORkwzL/sqrro+h469dilQetXNyVCdYIw1m2+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002623; c=relaxed/simple;
	bh=TOh2twL5Fhvhio7Uj36AhvthP9inb4OGQEsrWcD/jE0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g1wQDlI46VTu4K9YsfrfjZDpZNewjbL0bGWyZSRkdzs61kw7faW+BBCStsAeM85DPPWh3gx0Oitge6fEjsZ8G1UOm92Sx87b1TYKLHKluI2mRELbjU3GI1YreTy5NtMgyUxIeqw5vo32vSKS/Pfd742yNeun/3nszGdvMQPRnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9spCsA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9spCsA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D0C1F000E9;
	Mon, 17 Aug 2026 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787002621;
	bh=8YeRVvb5fOWOBDUhPCq8cNtQ+K3tbVVzmgfC5QhPf58=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X9spCsA3Q0NVjGSoItOxM+E+wy018EIGXSjwQX0OSUyZHbOI4KBuH8u8lkBrW/uu5
	 Rwicq/qkWZ8CyIKm63qdsMqotjwRYK0kNrQ5GCtDOLEy+Mbh+NeTubNxJYKfPOqtvZ
	 1jhBCcOVraBs+aEpK0EbBOdRT+0u2i6Rm8IKoSR2zhSR1xWMX5QhGN/dFYerbnnBlv
	 osJFYxbWjfCrkQmjjSAs5ZkOF5TAPwIK4sR958O/sq2Xe0GRAUISN3BOrWBr3RssIg
	 3vPDfDJLtQlGBbtS+77IkvjcdeiSCueQASi7olX08Jq0/TbggqR0jT9YOQMUjCsYs/
	 vyMsilMasuWzQ==
Content-Type: multipart/mixed; boundary="===============8031173725188166952=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e304b97889065108a5b2a41908329bb9d38a7c23837a6861ce3b21302aaf7eed@mail.kernel.org>
In-Reply-To: <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH v2 1/2] bpf: reject stack-argument callback subprograms
From: bot+bpf-ci@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 21:37:00 +0000 (UTC)

--===============8031173725188166952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e421ea2b80c3..6f6e35bc7c97 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9785,6 +9785,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>  	err = btf_check_subprog_call(env, subprog, caller->regs);
>  	if (err == -EFAULT)
>  		return err;
> +	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog]))
> +		return -EINVAL;

Should this rejection include a verbose() message explaining why the
callback was rejected? Currently this returns a bare -EINVAL, which means
bpf_loop(), bpf_for_each_map_elem(), bpf_timer_set_callback(), bpf_find_vma(),
and bpf_user_ringbuf_drain() with a callback that has more than five
arguments will fail with EINVAL but nothing in the verifier log shows why.

check_helper_call() propagates the error silently for all five of those
helpers. Only the three kfunc callback sites (in check_kfunc_call()) add
"kfunc %s#%d failed callback verification".

Every other stack-argument rejection in this feature logs a message before
returning: check_stack_arg_read() reports "invalid read from stack arg off
%d depth %d", check_stack_arg_write() reports "stack arg write offset %d
exceeds max %d stack args", check_outgoing_stack_args() reports "callee
expects %d args, stack arg%d is not initialized", and bpf_fixup_call_args()
reports "func#%d writes %u stack arg slots, but calls only require %u".

This is the path the patch is meant to reject. For the other outcome (the
caller's outgoing slots are not initialized), btf_check_subprog_call()
returns -EFAULT and the existing message is printed, and push_callback_call()
returns before this new check.

All other error paths in push_callback_call() also log: verifier_bug() for
the two internal consistency checks, and verbose() inside
setup_func_entry() or push_stack().

>
>  	/* set_callee_state is used for direct subprog calls, but we are
>  	 * interested in validating only BPF helpers that can call subprogs as


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32068993990
--===============8031173725188166952==--
