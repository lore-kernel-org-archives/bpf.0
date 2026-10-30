Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364301;
	b=cKT6yGZQqpdi1+WDcWCOZA6fD8rE6c+9+0xiAB4CAmosu0i0Q1RARAp03EdGganzPHDb
	 oAfarAqJQW+OFJhzhfA7WaIRjGQj4hKDe214sNUcpqLAuo63q2xU7TW8elyIj9yuBkeUX
	 M+QnmnlJoLxilhJbWUNaP8lRkVradCQnEsI5bVYd+QfyzyLsLt1ahaY+aqqZ4V5ZeFF4l
	 wXVqhxWJkM0f+XeQa8H23aUkCyoZkcHXT8YtOkJswRDYG3qw1CvxURxa4zsGFyAlEG8Jg
	 FtVYi9+PHCmKE2lT4jaLAnfTR7wt0O0lkM5FRfLGyZlwtEDPWBfX4qT+2S2VY4Ow4bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364301;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=kR0m/tHdiKoAlR2zhUrYVArbIFJ+8CIvqWPBpm03vDQ=;
	b=VvBCzofuROEhrzBLicoLXF9rJYdyKBIjzNSlSN1O9AF/SmzgNNiIOrL8X00n6778ltJl
	 X4SIcHYt2CwOpqLkFTVEJol8oPb+n54DSGWc2lPmA0l5687HuGhYAAb5KK7RPT921dAqq
	 6wiJdt8HiRJDcVSiN2iSaGdcBXMyYTMfTsajfI4fPKPtaWdW0xbzrjUGBVlxCNrrNUwnc
	 CiydoMGIcF57bunmfXO6JFbN1R3oh2MmNCyluKdJpAAHiMiUrhltY7Shb1OKIKkS4rVYi
	 srXjm7gZb2Vpz5Mg8FE9EUpb9YnAx4dWFDRwPTAp4WwGLTksOqbJ2/zdswg5ZOkwi/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oa8fQRRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12FF606A32C;
	Fri, 30 Oct 2026 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oa8fQRRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE35D1F00A02;
	Fri, 30 Oct 2026 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364300;
	bh=kR0m/tHdiKoAlR2zhUrYVArbIFJ+8CIvqWPBpm03vDQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Oa8fQRRljtEpSoIbxzK+j8b3t51lILlHrzY7OZNDjZKy4FzG14UmU0VFIjolXZljx
	 irzMT0IHgg81ZlhRZ9F+snoxo+B1HbyVme4/DLP70tAJPDt/i4KjaAhPGp6y28RJUW
	 WNTD+4zG0teXJJmfskgt+UTSiQqGRtKR3Rm1PWKWfBo3/ZHIpm8bnxn+oMWfMirLen
	 uUiGmO90TGRn6Rht9+8+fcs+C2Ur8H2HAGsACHs9sUIr4j3WwZ/vEt4/e0KFKubpnm
	 s4UHfPhVKXKtClKwRN2arqd6jHf6P9Mfqt2JtFQvffo1wUukVCET4QRpC/n8QlLIug
	 FAY9crvs1naWg==
Content-Type: multipart/mixed; boundary="===============0415965614649796748=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d88762ffbcebc2b8b7ab9acedabcabb0bf30976db16b19a8991bbbdd03b3b507@mail.kernel.org>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-19-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-19-55cd43439f7c@gmail.com>
Subject: Re: [PATCH bpf-next v2 19/22] bpf: Blind constants through the patch list
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 12:44:59 +0000 (UTC)

--===============0415965614649796748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Blind constants through the patch list

TL;DR: Nit in bpf_jit_blind_constants() error path: the comment about patching
repointing aux->prog during realloc looks stale now that the patch list
reallocs only when nothing can fail; "clone = env->prog" may be a no-op.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 10d2c37f8128..7d58c47b73f0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -1990,47 +1990,52 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp

[ ... ]

> +	if (err) {
> +		if (env) {
> +			bpf_patch_list_free(env);
> +			/* restore the original prog */
> +			clone = env->prog;
> +			env->prog = prog;
> +		}
> +		bpf_patch_list_release(&pl);
> +		/* Patching may have repointed aux->prog during
> +		 * realloc from the original one, so we need to
> +		 * fix it up here on error.
> +		 */
> +		bpf_jit_prog_release_other(prog, clone);

Does this comment still describe a case that can happen?

Before this patch each bpf_patch_insn_data() or bpf_patch_insn_single() call
could bpf_prog_realloc() the clone, which does fp->aux->prog = fp, and a
later patch could still fail.  The error path therefore had to point the
shared aux->prog back at the original program.

With the patch list the clone is only reallocated at a point where nothing
can fail afterwards:

bpf_patch_list_commit():
	prog = bpf_prog_realloc(prog, bpf_prog_size(img.new_cnt), GFP_USER);
	if (!prog)
		goto out;
	env->prog = prog;
	... (only void steps follow) ...
	err = 0;

bpf_patch_list_apply():
	new = bpf_prog_realloc(prog, bpf_prog_size(img.new_cnt), GFP_USER);
	if (new) {
		prog = new;
		bpf_patch_image_install(prog, &img);
	} else {
		err = -ENOMEM;
	}

So when err is non-zero the clone was never reallocated.  aux->prog still
points at the original prog, since bpf_prog_clone_create() only memcpy()s,
and env->prog is still the clone.  That also makes the new
"clone = env->prog;" a no-op.

bpf_jit_prog_release_other() is still needed to free the clone, but "Patching
may have repointed aux->prog during realloc" can no longer happen here.

Should the comment be updated, for example to say that the patches are only
applied once nothing can fail, so the clone just needs to be freed here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41053659762
--===============0415965614649796748==--
