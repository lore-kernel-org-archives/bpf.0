Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61D1A23A6
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775192665; cv=none; b=jnNnOQGMouKc/ZNPCS12Lg/+8gUPGYqgdHF8SiIhuBfaWhdjyaZOMcdJwKHWRdgcN2tCps6SUU4I4+gOxeBhDQ/iyrR2DIVjgymNqGIDPL15h3AVz9220v/YY1Wjgmcin2/zzuMIZ1dUzA+58TwjGAgTo2PFNXufzRv1swSnTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775192665; c=relaxed/simple;
	bh=gP4xBVZxhuv7rBzpd8cmrEFIRqJwdXYxbrjsoPI2thw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r1V6iV2MdM3HcbCBJQM5qw4YJ3/q+1Wm5sYZBcCLexcsZIA0plVLUWY90WoPZWCdytq+qPqbZ+Uw1FKIOPMpn+3nVbK55eOte+n2bESGYO+zozkZZ4BqV6Cy0buhcBhs/qg1ixdvGsaRbBUdYMms1eFDcKXPaJ6NXHm7SPaGnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUfW1lKK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUfW1lKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FF4C4CEF7;
	Fri,  3 Apr 2026 05:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775192665;
	bh=gP4xBVZxhuv7rBzpd8cmrEFIRqJwdXYxbrjsoPI2thw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uUfW1lKKwMs1YAH7OEMsHzVKlrIIvduCLr2xYsZJwuqnaCGET8orDyVYPq9PvvuzA
	 pIiYdaGx6EhOs/Pi752GXyHFrceHUZ2HmKSTbgmr+wkbgkbdJFeZDAKW7cS3av/tjZ
	 3cxSuCIof9JjhDzjKhEY4c2VoHH7SFfVi7Uj1sf8KfATmEr5L2AoR2ZMQJFxlbzzkq
	 mxXlNT1HJjxD8XDzdX7j89jH7ihmlwoII8zgPvtXVqdC2BjWFjLr+LcStYmDkM1rHi
	 U1egWUMO0mR4lmQ8O8U39L1EjtRbKmFhsSdyK0AWHnXklILK6CfeTA4Bocg8c65D9h
	 cJ1fkByWxzWNA==
Content-Type: multipart/mixed; boundary="===============7925541984852719164=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <deb90258dc2746693419d66c4dda30b686a35434bdb8c1b85a6e6df059ccf4ae@mail.kernel.org>
In-Reply-To: <20260403042720.18862-2-emil@etsalapatis.com>
References: <20260403042720.18862-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,etsal@meta.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 05:04:24 +0000 (UTC)

--===============7925541984852719164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a431b7d50e1b..a0e6522833ae 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16354,6 +16354,24 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
>  				return -EACCES;
>  			} else {
> +				/*
> +				 * The compiler sometimes stores the result of
> +				 * PTR_TO_ARENA + SCALAR addition to the scalar
> +				 * register. Upgrade it to a PTR_TO_ARENA.
> +				 */
> +				if (src_reg->type == PTR_TO_ARENA && opcode == BPF_ADD) {
> +					struct bpf_insn_aux_data *aux = cur_aux(env);
> +
> +					__mark_reg_unknown(env, dst_reg);
> +					dst_reg->type = PTR_TO_ARENA;
> +					dst_reg->subreg_def = env->insn_idx + 1;
> +
> +					if (BPF_CLASS(insn->code) == BPF_ALU64)
> +						aux->needs_zext = true;
> +
> +					return 0;
> +				}

This appears to fix a gap in the original PTR_TO_ARENA support added by
commit 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the
verifier."), which handled arithmetic when the destination was already
PTR_TO_ARENA but missed the commutative case where the scalar register
is the destination.

Should this carry a Fixes: tag?

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23934176047
--===============7925541984852719164==--
