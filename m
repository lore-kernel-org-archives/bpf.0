Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43563F410D;
	Wed, 23 Sep 2026 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157756; cv=none; b=Rjxzlsd7T8BgK2kCNcxu5qU448Eu4ZG8F1h+rhRvXyOkFUMhQnmvkhlLAh0cRoilVSpP02ttEbPTGYi4C+cw/W0cK2k7dAFRRdSJn70kFeJPZ0kqKKI7beApO6G7Jcn1YD3idR2El3cKVvphqx6eqilzvyMxKmsmBlfLXlXVPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157756; c=relaxed/simple;
	bh=iOD3PwH4qwahsgETt1kiYgDQbW8M1f2vcyjKv9K/0yU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tQWJ5K4RXit2O/gQpMrsHXganHt5/23lheHz/Zz35sA2xKnJafAxE2SROYrkt9IqoARR9yQRFmcz7s//Z5yyL+QF1mNthOq+KOdfHc9tW5TwF4cPD52v7CCCOboS9ae8NjCby6XgnieTtPRD5ttz8ApKjIkZzdXHAXwvGU5SaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7DQQSxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7DQQSxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3251F000FF;
	Wed, 23 Sep 2026 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790157754;
	bh=ANJRHDY6wuCQqsDJ6dO6555qMtOZWbhayloXTSeZhGQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d7DQQSxXxrrPyH5RPCDJgFQ1MdEzHgh8a1AgDJqT3aur/cAxYAbwEe4FEcUU8SlBC
	 i9lBl8gTkPxIEPhkBhu2vtyZgOnTx3WQUeHRzZcempM1TmqRxPLe/6YaKlcL+1RJO3
	 tUETiZYPLuqNTwcYT+cTCZjMZajxE46GPX0W/nODY+l7UjBEhmjjN0DfghTA81fE2d
	 Xe9PZ2zjWFAdFkE9CzpuY6gmNSg9BBAKyG6rrwI22esRzVETIkOkfktcOIN5XjmG+g
	 KGOKt6gV/T6PymmD3AYJ2L9zbPf4TBeN4dFoylrzcv/yT5hwdH0CBwt8+AMrOsWPwI
	 kTTtaDFJKNikw==
Content-Type: multipart/mixed; boundary="===============8539735582135443100=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa9703467e35f52305c33ee831cfcf56d9b9237ada65eb942e19d44b78451020@mail.kernel.org>
In-Reply-To: <20260923090635.368488-2-chenyuan_fl@163.com>
References: <20260923090635.368488-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Keep target extended until its last freplace link detaches
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,alexei.starovoitov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 10:02:32 +0000 (UTC)

--===============8539735582135443100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e7c5e203eddd..d5a20974a8aa 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 0ce26b538075..0fe9afd4a591 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 90b70ea0d370..f6e6533deb0b 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -843,7 +843,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
>  	}
>  }
>
> -static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
> +static int bpf_freplace_link_tgt_prog(struct bpf_prog *tgt_prog)
>  {
>  	struct bpf_prog_aux *aux = tgt_prog->aux;
>
> @@ -857,7 +857,7 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
>  		 */
>  		return -EBUSY;
>
> -	aux->is_extended = true;
> +	aux->freplace_link_cnt++;
>  	return 0;
>  }

This isn't a bug, but would it be worth keeping this fix minimal for
backporting and doing the rename as a separate follow-up patch?

The rename from bpf_freplace_check_tgt_prog() to
bpf_freplace_link_tgt_prog() is independent of the counting fix: the
only functional change in this helper is 'aux->is_extended = true'
becoming 'aux->freplace_link_cnt++', which does not require a new name.

Since the patch carries a Fixes: tag for d6083f040d5d, it is a
stable-backport candidate, and folding a rename into it adds conflict
surface for no behavioural reason.

If the rename stays, does something like bpf_freplace_get_tgt_prog() or
bpf_freplace_reserve_tgt_prog() read less ambiguously next to
__bpf_trampoline_link_prog(), where 'link' means 'attach a program to a
trampoline'?

>
> @@ -970,7 +970,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
>  		/* Cannot attach extension if fentry/fexit are in use. */
>  		if (cnt)
>  			return -EBUSY;
> -		err = bpf_freplace_check_tgt_prog(tgt_prog);
> +		err = bpf_freplace_link_tgt_prog(tgt_prog);
>  		if (err)
>  			return err;
>  		tr->extension_prog = node->link->prog;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35842777159
--===============8539735582135443100==--
