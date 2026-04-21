Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A1931E85A
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776804409; cv=none; b=tvdJyK2I81kK+9DciGH75CvB5DX6VRrvgGO0OZeOziDn8izpljncJcrQFM6I4ESntyzFeAxXpdj47WZBnUR/WBdE37mVk0N6GG2Ryx0JWZNrdr82ysg+hdAjxqynl5486GN1am1TNhf5oMDbQ9p6TYrGAgzPK4TI+UiTl/ETHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776804409; c=relaxed/simple;
	bh=zjxsuTErD8bHnj9rIuoDLCPCXrSJnjxWzwSJrRiMAUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIeCM5h29FgXTdsvwymnReL0TIrwxGWi3mMTn9Eog0LOPQlGS+EXwn+Nak1GP3ORwUzzXciaOeRFZIO1D6Ge4hsz0oluX1y9OH7hhvqOckqYFXR1/yWXLL9U2kA76Lr1+aHvLDdP7jmTwzWviuol4u2q1lq1C8edHV7/b0HQ7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSN31VfG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSN31VfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B573FC2BCB0;
	Tue, 21 Apr 2026 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776804408;
	bh=zjxsuTErD8bHnj9rIuoDLCPCXrSJnjxWzwSJrRiMAUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JSN31VfGR0GwacZN6L5LJ9ttREQdR0rPYnVnBM+BaqNvWIDd6vVdO3xYkyu7Q2Uos
	 ndZq6dXyF3e2ltkqhAs2ZyIrsdCiCE0TEIsAj1M8J0HIJMMpdE5q7N0tXg1keGVrC3
	 xCN/WKI8udNGreHxv21nRjWxllZTpa4C714VJ8E0/CQ1WntUnj+qF2bC67dDZHtUnQ
	 YXM4807FYfKuYBD3k3pMabbXsaFc2NcD0SEeSylxtif8sn5mUF4C6G0qkbAZf6//Ou
	 onhdEj1iSh8yO38BByjGFB0bmOzZ8EzGmXsEjDM4WBc6j1RUgp8KqnaiNMaxp1NEa0
	 8P0WJZpCG9WDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
Reply-To: sashiko@lists.linux.dev
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421144504.823756-3-tangyazhou@zju.edu.cn>
References: <20260421144504.823756-3-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 20:46:48 +0000
Message-Id: <20260421204648.B573FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] bpftool's control-flow graph generator (cfg.c) was not updated t=
o reflect the `insn->off` and `insn->imm` swap for BPF_PSEUDO_CALL, which w=
ill break visual dumps.
--

commit bbf026d16d77a3e1debc60ea3a7b2fef7d7def5e
Author: Yazhou Tang <tangyazhou518@outlook.com>

bpf: Fix s16 truncation for large bpf-to-bpf call offsets

This commit fixes an s16 truncation issue for large bpf-to-bpf call
offsets when JIT is disabled or falls back to the interpreter.
It does this by using the off field to store the interpreter function
index and the imm field to pass the original offset.
The related dumper code was also updated to adapt to this change.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 300e4e2519318..8947ef74f6a88 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1250,9 +1250,9 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
>  		}
>  		if (!bpf_pseudo_call(insn))
>  			continue;
> -		insn->off =3D env->insn_aux_data[i].call_imm;
> -		subprog =3D bpf_find_subprog(env, i + insn->off + 1);
> -		insn->imm =3D subprog;
> +		insn->imm =3D env->insn_aux_data[i].call_imm;
> +		subprog =3D bpf_find_subprog(env, i + insn->imm + 1);
> +		insn->off =3D subprog;
>  	}

Since insn->imm and insn->off are now swapped for exported translated
programs, should tools/bpf/bpftool/cfg.c also be updated?

It looks like cfg_partition_funcs() currently relies on cur->off to
calculate the target subprogram start when generating the control-flow
graph:

tools/bpf/bpftool/cfg.c:cfg_partition_funcs() {
        ...
	for (; cur < end; cur++) {
		if (cur->code !=3D (BPF_JMP | BPF_CALL))
			continue;
		if (cur->src_reg !=3D BPF_PSEUDO_CALL)
			continue;
		func =3D cfg_append_func(cfg, cur + cur->off + 1);
		if (!func)
			return true;
	}
        ...
}

Because cur->off now holds the subprogram index instead of the jump offset,
could this point to the wrong instruction and cause a corrupted graph or
out-of-bounds memory access during bpftool prog dump xlated visual?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421144504.8237=
56-1-tangyazhou@zju.edu.cn?part=3D2
