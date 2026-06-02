Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25493D1CDF;
	Tue,  2 Jun 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393454; cv=none; b=AZBLlZl6zPERVT7zZIwexzo3JqAYGUGbTdd7+85Gts0jQ7B/8BpsZmex41zbfdLypHU9yTFOruWyTOcvooPzaOZ6S6cF2wxPfpq5oyJOiByPPw9WNjMUckY9+unFPQ3ubnPEe0tt8l5rQkKnrFJghl+91vFYh+0jU+w518FmPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393454; c=relaxed/simple;
	bh=rtrofUJ06GV4rW1M0py9xFfcvN3PkZbFhV0NM/mAzB8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uhiBSr+VrMlEcIhrsGxiv42guGfIZ2NRaYz5P0PBGDQTodRJB7vBhuoe25rFUreiR1sIb9+F9N1VbsV4p5itVJue5IAj0u6ISKzfFBx4qjTwjoSZbFwD3caTig9Fco4AZIljPcJrEeR2gUWDpPPnwRfxFudosz+cSIseIlaMRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5TUEavU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5TUEavU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16AF1F00893;
	Tue,  2 Jun 2026 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780393451;
	bh=EsgTolSX5y8SbF+6hIjaafpP7/Aj01SDQVYMej/jY9E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O5TUEavUFwYvJ0C94aRwQ0ukKG6go09V/8/R4PAcM6U9rx8BWFIuTJVhyxBFNUcmj
	 dn+geUvesa7Gqqv8cAaVlgVDkzvnzmG/C8yRnKKyLYWdxvHg6CR4QpVOr1vb3AwYs8
	 9ZraeP9exi1AEbl3A2ZOSb3Nh919SK4XHnsG5lgqE0YgtQUpREUzwxyFdjHkmYrxzK
	 ZY4tvj2ZBKGd30eboIqHl1fvNRGJqv+HdB/ieXmOdpwQov9RCZnI6dASqbBevHWJmz
	 xmGluTHi5jUrdVpIs7uXQL9uyD58s18Sa4hi/Z+ZMbScUj2LAIBxoPLStTSoJnxk+P
	 jlGuEXuF4gv1w==
Content-Type: multipart/mixed; boundary="===============7971710810333173780=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6906a2ff0ca3e5e6a696f629d481326071fb63cde814e0c61954257aeb6091a1@mail.kernel.org>
In-Reply-To: <20260602085827.2562222-2-chenyuan_fl@163.com>
References: <20260602085827.2562222-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,eddyz87@gmail.com,yonghong.song@linux.dev
Cc: andrii@kernel.org,ast@kernel.org,bot+bpf-ci@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,chenyuan_fl@163.com,clm@meta.com,daniel@iogearbox.net,ihor.solodrai@linux.dev,jolsa@kernel.org,linux-kernel@vger.kernel.org,martin.lau@kernel.org,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 09:44:10 +0000 (UTC)

--===============7971710810333173780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..57e5fdf9f7e0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12082,9 +12082,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
>
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]))
>  			continue;
>
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* list_push / rbtree_add kfuncs have implicit args
> +			 * (e.g. 'off' parameter) handled during verification
> +			 * in bpf_fixup_kfunc_call().  Don't flag them.
> +			 */

This isn't a bug, but in the v2 review Yonghong Song asked for a comment
explaining that this code exists to work around the pahole 1.30 BTF
mismatch, so it can be removed once that toolchain issue is no longer
relevant:

  https://lore.kernel.org/bpf/7b3ba4a8-a785-4f70-879d-50e63d6de787@linux.dev/

  "Also, please add some comments in the code to explain the reason of
   this code is due to pahole 1.30. So later on at some point, this code
   can be removed."

The comment block here only documents the list_push/rbtree_add exception
and does not record the pahole 1.30 rationale.  Was that request meant
to be addressed in this version?

> +			if (is_bpf_list_push_kfunc(meta->func_id) ||
> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
> +				reg_arg_name(env, argno));

Where do reg_arg_name() and argno come from?

Grepping the tree finds reg_arg_name and argno only on this new line;
there is no definition anywhere else, and the enclosing for loop in
check_kfunc_args() declares the register index as:

	u32 regno = i + 1;

not argno.  Does this compile?  As written, reg_arg_name() looks like an
implicit/undeclared function reference and argno an undeclared
identifier.

Should this use the existing regno instead, for example:

	verbose(env, "R%d unrecognized implicit argument, possible BTF mismatch\n",
		regno);

> +			return -EFAULT;
> +		}
> +
>  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>
>  		if (btf_type_is_scalar(t)) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26810234837
--===============7971710810333173780==--
