Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440044;
	b=jG7JGPFugQc9MlPAZTQaArfzqLugSM3087EzzYtA42HpxMkgRRfpU6x2YxQmDH48m5Yb
	 u3z/5IqNMIyALjncWV2LnXW0sfupILe1TO09/MBs2v3tdfSJAyeBO4wZ+MlHs2+HWderc
	 dC9n15cy2UksguiEKqJ18FVb4P9jxrYp6LRbfJgFfFlm2ZPztS3kim+ou5B9Ykp8v3QDy
	 QR1EQf3D1mALDxcFZGbHBR7shJao8QvalWsQRDdCom5qd9B21RC+SSLZWvxE8k99h1CxN
	 JVA/3RSw8UYBJy7xyW8lqQwMZVZLwWOlj8LLWMnyF6YgYrpdyF2Sn2m7xG9f8YMXW0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440044;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=IyJnyR+SDoNsHFXVp/2Wt9KkzpRaN5lxj9HriXnRMhI=;
	b=WGNWu9AP+ejzccH/8X4uPIp5Z1UKMr4nEfQMbzojpaEaHb3IUM20Tv0nA1XK9cSeZBI7
	 1AyNktpzyjIMX5iuJfkKii3mxIuCDyzDN7DeE7MqH2vI6GDFw+xtQ6zD9N7LTrUiqgl0U
	 GzHdQCPqs1TpxI4RzAUOIsCQvzD8WHaFdQA3MbZuZ0n+NJ3oZIS7ZbVAJ/oezFqKwq8c6
	 TeFQQi0Z3P1Guq2jwSGXqzHNekovIw022FG3fhh5QwXyRHCmPmZFY7GVjnNmE8TK7jzBc
	 GA84wK0zl9G11iy5ZDfPaWzYl+hgTHRuXePfm/3W9ux30VTqPowbm4U+xUKAI4qxePw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAIxChdU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA1606A8A5;
	Wed, 11 Nov 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAIxChdU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA571F00A05;
	Wed, 11 Nov 2026 23:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440043;
	bh=IyJnyR+SDoNsHFXVp/2Wt9KkzpRaN5lxj9HriXnRMhI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cAIxChdUeCsBC1JhUo4xDQEIvoOnch4nQks3/1Ib/V6S6rX0Sjaupp4FOp/WYnneM
	 jvrscAQcY0LFA3nmUlYC33PaLYtoTSWaSDD/5SQ4wHLVnvSREKLNK+VFBL7CtkZggX
	 E4dVOZeswNOXZCY4INLvuVz1B9jMxBha0btw/Xelv0i/fKzd+Gp20cVKiOP1gRLZhE
	 al3O8TI4wVi3T21ICuXJQgWDv2v+45YDNgKYsMqZXH8Ngt6YaL+HD3kRknewKHBTQk
	 PjScVOVOi3TrGilTH5cumyNtntyjS9ALnlDzCT6ds3Bi71lKhq18KOfrwEDkKKZZIs
	 T+O9Wsg26Vqmw==
Content-Type: multipart/mixed; boundary="===============8855634537732790590=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <accc0cb4b44bd410326ca2a60238127519258fa64d48fc4b090311199e1848ad@mail.kernel.org>
In-Reply-To: <20261111115911.1142000-13-david.laight.linux@gmail.com>
References: <20261111115911.1142000-13-david.laight.linux@gmail.com>
Subject: Re: [PATCH v3 next 12/13] scripts/kallsyms: Reuse tokens that have no references
From: bot+bpf-ci@kernel.org
To: david.laight.linux@gmail.com,pmladek@suse.com,kees@kernel.org,david.laight.linux@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ljs@kernel.org
Cc: mcgrof@kernel.org,andrey.grodzovsky@crowdstrike.com,rostedt@goodmis.org,andrii@kernel.org,wusamuel@google.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 23:34:02 +0000 (UTC)

--===============8855634537732790590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> scripts/kallsyms: Reuse tokens that have no references

TL;DR: Nits only: sym_arr_free_all() in scripts/kallsyms.c has a misleading
name, since it only zeroes counts, and returns its argument needlessly. The
review suggests a void reset helper instead.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c

[ ... ]

> @@ -720,6 +733,19 @@ static void token_add_symbol(unsigned int token_idx, unsigned int sym_idx)
>  	sym_arr_add(arr, sym_idx);
>  }
>  
> +static unsigned int sym_arr_free_all(unsigned int ch)
> +{
> +	unsigned int i;
> +
> +	/* Just zero the counts, the entries are about to be reused. */
> +	for (i = 0; i < 256; i++) {
> +		token_syms[token_index(i, ch)].cnt = 0;
> +		token_syms[token_index(ch, i)].cnt = 0;
> +	}
> +
> +	return ch;
> +}

This isn't a bug, but would a name like token_syms_reset_char() with a void
return be clearer here?

sym_arr_free_all() sits next to sym_arr_free(), which really frees a struct
sym_arr, but this function frees nothing and only clears ->cnt for the
token_syms[] pairs containing ch.

It also returns its argument unchanged just so the caller can write:

	to_process[idx++] = sym_arr_free_all(token_first(best));

Would a plain to_process[idx++] = token_first(best) at the call site, after a
separate reset call, read more directly?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43116767394
--===============8855634537732790590==--
