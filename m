Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939917;
	b=eqNo+Zy9kA+WXdqezl5HwQYABPstgI5V4K8WTHU/xHlqVQ3lDhKqZqWxduphMyqMOHLO
	 9YfND5GZrBGLzL9L9Bofws7OS+trZBDHGpjsXrxLkR3dur18OrCl1bgVTbr5v6eHDoBO+
	 0wy5w6TrZH7sIYYDfWq1NPKUROAF1rttX2gRVat7OWwyddzUHLuc+ptKs6Sv44fSPwHHK
	 JQKuIlBTZonTnN0k3jSNyVhSxZ5aPZt2/7+IBQeFLtZ4/u79Ue6FohmeJGLbif3pSozyG
	 c3r6JLXEfCl/yaiT8McSNgdPsbPBCdZqS7EKvKEF87/TiTN6E7CQ0t65NMlojxKUWaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939917;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=+tt0W4639uJckaBvutkZdzsb/m9lflVaXgSzvKEDMy0=;
	b=oyjgXVMtRLvTCnpohXZz0D+6rbzwY3RyKpeogZWreKzBblHAB+EKJyHY1NVuby+2t0RA
	 jA4tZYaOQvcH0EvwwaLsIhghj0A45kodkGp4iPTxK5G/7822D7+LaXizZOZVQ6CmCLrEK
	 wCQjDiJ4EoUU92RA7CEP80Yw3bMuwCGRCEjzT8Oa8HFUIIarh3HWQOxy1QA4lJiAomAIJ
	 b3Reru0LZ/bVddQBoXSNVqymb3S00HFbSkRh2ECsnARWgSWTEkqGxPk0+4LoeTj2VGVdx
	 oCKMaIXCfbzsxrQIhGBQSt2G0K/yxY8FlaGsfza9EZxLqeuutOkiM3HUvhbNV8WOtFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWXQ0NTP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A7606A32F
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWXQ0NTP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6E21F0089F;
	Fri,  6 Nov 2026 04:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939917;
	bh=+tt0W4639uJckaBvutkZdzsb/m9lflVaXgSzvKEDMy0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dWXQ0NTPk+EqrCNxDMVDSOKp0xI1lst5WAXxQUdGaZkuH0wjmvG0Gbpyp2VRvIE1V
	 OzKqxVh6b+EZW96yviEfergH6gpfDLkKmcqD6EnpfyriQlDdqfDrHtFOO4pYgjTOdU
	 qqXr6U6j6gvrtlx1ddM02hpd8LwXaeZRMj9taVc6hGAKtimnXS5teIyZ/MEnq1THfd
	 69o+2YP4GjyxOuBp33NtNnh+QdoPdqq8sQimZ/hXKNrk/xNnCvdWOtze2wFpKIfm2R
	 /dN54QuBYRDstOyMoCNyng/X25NIDDYbZTw0i5ASyH5SXerce4H15hECWZtpiMU2ag
	 V7WjjC8aRmUTQ==
Content-Type: multipart/mixed; boundary="===============1150289174205268579=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <19e3280680aa046388274873789d649eac600b99eff2633376ba2a073fd30acd@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-37-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-37-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 36/45] bpf: Keep the first iteration of a counted loop apart
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:36 +0000 (UTC)

--===============1150289174205268579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep the first iteration of a counted loop apart

TL;DR: In bpf_compute_loop_iters(), treating loaded registers as fresh skips
the walk decision for short loops, so the verifier may wrongly reject valid
programs, such as a NULL-checked kptr loop.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 147a2fa9aea9..0cbf158dae6d 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -3520,7 +3546,23 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
>  			walk = true;
>  			continue;
>  		}
> +		/*
> +		 * What is loaded from memory in every iteration is the same kind of thing in all
> +		 * of them. One iteration tells what. There is nothing more to find out when
> +		 * iterations are looked at one by one.
> +		 */
> +		if (expr_is_fresh(env, header_env->reg2expr[r])) {
> +			__set_bit(r, iters->fresh_regs);
> +			continue;
> +		}
>  		__set_bit(r, iters->forget_regs);

Does this continue skip the walk decision for short loops?

Before this patch, a live loop-carried register without a summary went into
forget_regs, and if bpf_flow_is_needed() wanted it, walk was set to true and
bpf_compute_loop_iters() returned 2, so the loop was walked iteration by
iteration when it was short enough.

Now a register whose reg2expr is only OPAQUE (any load that is not an fp
spill fill, for example) never sets walk, so the function returns 1 even
for a short loop.  The comment says there is nothing more to find out when
iterations are looked at one by one, but that doesn't seem to hold when the
loaded value is combined with other state.  For example:

    struct foo *t = NULL; int have = 0;
    for (i = 0; i < 4; i++) {
            if (have) sum += t->x;
            t = v->kptr;              /* reg2expr OPAQUE -> fresh */
            have = 0;
            if (t && t->y > 100) have = 1;   /* reg2scev ANY(have, 0, 1) */
    }

Before, t is in forget_regs and used as a load base, so walk = true and the
loop is walked with exact per-iteration states.  After, t is fresh, have is
a widenable ANY, and err == 1, so entry->first is set.  The state coming
back from the NULL path (t = scalar 0, have = 0) goes through
bpf_widen_scev_regs(..., back = true), where union_any_reg() makes have
[0, 1] while t is still scalar 0.  The next iteration takes "if (have)" and
dereferences a scalar, so the program is rejected.

A loop that loads from a frozen read-only map at an IV-dependent offset
(cur = tbl[i], used in the next iteration) seems to lose precision the same
way: the walk keeps each folded constant, while the summary folds only the
first iteration.

The follow-up commit 01f19b3a79be ("bpf: What a call returns in each
iteration is like what the loop loads") makes call results fresh but keeps
walking for them: "A call can return NULL in one iteration and set a flag
with it, so a loop that is short enough is still walked first."  Should
loads do the same, setting fresh_regs and still falling through to the
bpf_flow_is_needed() / walk decision, so only loops too long to walk get
the first-iteration split?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============1150289174205268579==--
