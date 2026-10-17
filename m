Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD78356A12;
	Sat, 17 Oct 2026 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257414; cv=none; b=Q8TJHgXSDwWn1pa27WIRftukCZ/Z0hSFtSkjYHfdjwXXRE2pFBO1ER4letv/fr3j26KNLzjQ33YTUbm+muQwA/P/E4a8RdvT+tXFcwhWSe7SlsvpzxPVcOd542pnhkuSxwQQ72yZRRYUjUwCZxca7jUch1mech38s6f9dbpSjSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257414; c=relaxed/simple;
	bh=Q41Ybw1k4VKIjaRSUUV8F+/62zcRBThJnlOFy3KuaLA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xm9pgfnWgN4Tt6NSb1o5wUKxP6AJFnawrdrLZt5lD3Z1Ugc84Chs5AH9DPyIKOKub/0Y+rr/ZNqsUKxA4jFmEVM44fl4I6IObyevq9S0z6I5SNQ14uoPdwt8VhwfXhoFNV0xA3/LPK7Xw1em0fI0o3WxryqOWCmLSWlVQGPT+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRHvdlau; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRHvdlau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D30D1F000C5;
	Sat, 17 Oct 2026 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257412;
	bh=7Mr89M+4c0Iy4BE/6gRRHnO0mKczHTgsXhS3+XlxzXU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bRHvdlaujDqJY9GNO7X+mT/zHcHSOk5R6Ht7RhKqfArVyj+qIIq++EjUXdSunKtoB
	 5uC9PfpfgFTcI7IuugNi7Y0pvMhFtUK14kuqldMMwBMDzIehNhX5OXKXngnj2eyjGk
	 BlTb9eY5HNKBSCAU3Lxo1H0Z8C3b4SN2VEyMX4fcD1FAhSQGeVWCcxaUjsv1+eRt4+
	 dpY1UZE4lnbluwk5Etw3U10uvbKO09ymqbBiex60ZXym5uSwd2ej3XfNjStDx1zm/y
	 d+plXwVNBmGU5IUPWEGgu+fiDWkl2r5HOuwaSkIlKAXNd//XkMdM0NiTj+DWiIlEdo
	 5mdt+CCbKD53w==
Content-Type: multipart/mixed; boundary="===============0799593762278955704=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <76cadfaba65da05d53bfa78e022e2032e74d5f9cbf0579ff67e06e0e49a93875@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-40-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-40-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 39/43] bpf: Refuse the prologue for an extension that cannot take it
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:16:51 +0000 (UTC)

--===============0799593762278955704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Refuse the prologue for an extension that cannot take it

TL;DR: The new check may wrongly reject XDP, SK_MSG and CGROUP_SOCKOPT
extensions that write packet data, since their prologues emit nothing.
Programs that loaded before could fail with -EINVAL, including on stable.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -909,6 +928,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
>  			verifier_bug(env, "gen_prologue is null");
>  			return -EFAULT;
>  		}
> +		if (env->seen_direct_write &&
> +		    env->prog->type == BPF_PROG_TYPE_EXT &&
> +		    !ext_prog_takes_prologue(env)) {
> +			verbose(env,
> +				"Extension writing packet data must take ctx and scalars only\n");
> +			return -EINVAL;
> +		}
>  		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
>  					env->prog);
>  		if (cnt >= INSN_BUF_SIZE) {

Does this check reject extensions that never get a register-touching
prologue?

An extension inherits the verifier ops of its target, and
may_access_direct_pkt_data() sets seen_direct_write for SCHED_CLS,
SCHED_ACT, LWT_XMIT, SK_SKB, XDP, SK_MSG and CGROUP_SOCKOPT.  Only the
first four end up in bpf_unclone_prologue(), through tc_cls_act_prologue()
or sk_skb_prologue().

XDP and SK_MSG use bpf_noop_prologue(), and CGROUP_SOCKOPT uses
cg_sockopt_get_prologue().  Both return 0 and emit no instructions:

    static int bpf_noop_prologue(struct bpf_insn *insn_buf, bool direct_write,
                                 const struct bpf_prog *prog)
    {
            /* Neither direct read nor direct write requires any preliminary
             * action.
             */
            return 0;
    }

The new check runs before gen_prologue() and never looks at what the
prologue is, so for these types nothing is patched in front of the
extension and no register is read or clobbered.

An XDP extension that writes packet data is now refused with -EINVAL if its
first argument is not the ctx, or if any other argument is not a scalar.
For example, freplace of:

    int f(__u32 idx, struct xdp_md *ctx)
    int f(struct xdp_md *ctx, struct cfg *cfg)   (ARG_PTR_TO_MEM)

or of any function taking a struct bpf_dynptr * argument.
check_special_kfunc() also sets seen_direct_write for bpf_dynptr_slice_rdwr()
on any dynptr type.

These programs loaded and ran correctly before this patch.  Since the patch
carries a Fixes: tag, the load failure would also reach stable kernels.

The commit message says "A program that writes to packet data starts with
bpf_unclone_prologue()".  Is that accurate for XDP, SK_MSG and
CGROUP_SOCKOPT?

Would it be better to run the check after ops->gen_prologue() and only
when it returned a non-zero cnt, i.e. when a prologue that assumes R1 is
the ctx is actually emitted?

No later commit in the series (222dc092c64e..64e0b112d688) touches this
check.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============0799593762278955704==--
