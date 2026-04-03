Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAC382F1C;
	Fri,  3 Apr 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226651; cv=none; b=r3CZWvdNHPaDesRYFBWROIG80qchhMcfdQXIoUK+ynaOT/o4ol1hnIx5+X6c7eSHktAHNtvaOuwTQDwwKmwhrGCQxE+1dYPdfI8jlAhWUjSRYN5xy2gXe4yHBvMONGt8hIGjb4MOFCL7vyEgowmbmPSlVcT5IVoB8WMl0WFkIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226651; c=relaxed/simple;
	bh=EG/4+EnjirMkDZg/s2AKKf6fVlqgREOm7zmiAunJsOk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jZg2L0Fo+vmMP0P7haXiugaMMwB8FyPeQxPm9A8EqHSYacfSvVzwbkV/2pgENH/cL9cyXywdHIkMNEJgo9nHjETqv4P491dxPGRPvJMZITVkh+9a6UJWKDzepGV4juY7pl/ugfZDagoq8tO0KrpOFngizvp1b4wS8Q7r8YgL4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF5oKMIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF5oKMIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA79FC4CEF7;
	Fri,  3 Apr 2026 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775226651;
	bh=EG/4+EnjirMkDZg/s2AKKf6fVlqgREOm7zmiAunJsOk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hF5oKMIpkSnVzJ3WsKgH/PKmqSjD1zMtFEPF0s6EGi4R1o3Q9JQIMZHd45Db26d9j
	 WQGO5XHcHtrh5DEGn1aBhnCHm3Ogjl/RrKAig3gh/fOmIXM7xAgDGOWGsQ5QIleq7O
	 QOL6KHuRrvmt+w5O4vG2F4MiyxGHSmGDec8OD1qgueiMmzpRsSzIwLfFD6fXioscRM
	 n1nnbxgbd8UK3T0bcj8UfcZ/aML4gpNI/Rrvy6s+AMil1i8M75Yp3ac5Dr0DZpoXWl
	 USWvfIVrCIWgqQh9vI7sZB8LUIjli/nfjkqCVF+A3UwuzQ/6zSmFS195MwPQ5PTEGe
	 NB/KiYZEZyjQA==
Content-Type: multipart/mixed; boundary="===============2451143287243483675=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d7d0c76305b07ae5d485df56061925b95bc2206ad3fe13fb62d4567e51800f46@mail.kernel.org>
In-Reply-To: <20260403132811.753894-2-xukuohai@huaweicloud.com>
References: <20260403132811.753894-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v12 1/5] bpf: Move constants blinding out of arch-specific JITs
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 14:30:50 +0000 (UTC)

--===============2451143287243483675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a431b7d50e1b..66cef3744fde 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static void restore_insn_aux_data(struct bpf_verifier_env *env,
> +				  struct bpf_insn_aux_data *orig_insn_aux)
> +{
> +	/* the expanded elements are zero-filled, so no special handling is required */
> +	vfree(env->insn_aux_data);
> +	env->insn_aux_data = orig_insn_aux;
> +}

[ ... ]

> +out_restore:
> +	restore_subprog_starts(env, orig_subprog_starts);
> +	restore_insn_aux_data(env, orig_insn_aux);
> +	kvfree(orig_subprog_starts);
> +out_free_aux:
> +	kvfree(orig_insn_aux);
> +out_cleanup:
> +	/* cleanup main prog to be interpreted */
> +	prog->jit_requested = 0;
> +	prog->blinding_requested = 0;
> +	return err;

Is there a double-free of env->insn_aux_data on the out_restore path?

restore_insn_aux_data() sets env->insn_aux_data = orig_insn_aux, then
out_restore falls through to out_free_aux which does
kvfree(orig_insn_aux), freeing the just-restored pointer.

Later, bpf_check() cleanup runs:

    clear_insn_aux_data(env, 0, env->prog->len);
    vfree(env->insn_aux_data);

which would be a use-after-free followed by a double-free.

The out_restore path is reached when bpf_jit_blind_constants() or
__jit_subprogs() fails while blinding was active, which can happen
under memory pressure with multi-subprog BPF programs.

It looks like out_restore needs a goto out_cleanup (or similar) after
kvfree(orig_subprog_starts) to skip the out_free_aux label, since after
restoring, orig_insn_aux is owned by env->insn_aux_data and must not be
freed here.

This regression is not fixed by later commits in the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23948799625
--===============2451143287243483675==--
