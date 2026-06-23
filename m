Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC33955CF
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251829; cv=none; b=O/HNiiDWfs1G5fgaCBZlUeOjh4X98/oy0tx6LkqgBSZgeba7T+q6/5M+gHq7zCwhdeNC3VezbDK/5jnbuVpx9D0DnmAK9rI/9jhk2L8DkcTXuxslcfxR66324/pXwezWICoRbEBPgTgByMBqHJr2HMaAO6fy8JWkLM7fp0vY2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251829; c=relaxed/simple;
	bh=zxaht1ET26HBoVtBIwwAtbc05sEEPno2VMLGk/tK6k4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvExwOaWnWLHK+dlnyD7HSsDNHZkc4qNFg+Evrp3hDrCsr9DZDV61dZx/ducC8AFbcoXjeJ6UXBkWFZXYqnGiyW8B7LU+OD6dpGmVgzjBQIem30XqyNp9L0AZEhWxalReniLF0uWuscghIkAxWUQtrPlJpQyyH+CYz/4zuspDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A89Ra3T+; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A89Ra3T+"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137335bc3caso612352c88.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782251828; x=1782856628; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uWE4Wa8PVJ+yWZdtXpFN351hVNpU3NirdT/O2ctygmQ=;
        b=A89Ra3T+S7b5kMZkB4V+bx+5EUqtjLVTSKKpZkzlo/M4hsTCO4ZzDXQ5VVUzuKPVnS
         MTcK3PY9A2j/KjsdY68rbenpfat8Tni2gbn9PO1XaVLKXGPiaSO3wekFsq1KjDIt/NzW
         9s/haiKBSCDtC3sb2/CNLR7JOrdWj9HbPZUjthKFEyxbuL9NrMQpT34nL0AtSlj5n/hm
         qzkOC//xpXXAwnyygvsQJFcPw5I9/9vx9kFJSTMOrGsr3fGF/H5OrFuLN6urhOvgeLov
         0SEj21osv63lFRgNBc5pnTiY6cUao5PjV6Iunf+3MnOwUMaQw5oQCtjXi9bPzY/n5VqN
         NjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782251828; x=1782856628;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWE4Wa8PVJ+yWZdtXpFN351hVNpU3NirdT/O2ctygmQ=;
        b=TDivDhew8JU3U4AwYQSAj1lV+xzyR2dUXP/Ggsh65hKI0tDjvE3nzmST3d/rmIrTca
         iL+yKwYiV4AvdUP/Tp3K7COr/zUqK7WSdwpgBczjMdYSkbAhRgJtxmW9SaU8j0Aysn/V
         rlW4AWnTjSwn0Bw1yEE62Ie6u1S20Pfhpe5lbZSnjVyEvTjYTE0t8a8+aCzqrfUphRMy
         8eWCoa8iaojq6DglMlxhp6wnje5NTA8Qt8xtEqJTd2KtUsT83HhaKhVChRyH0HsRYK15
         Mdq1pLf6guu2hEdBL5wlVK7Xy3ttXwZ6Npzab2lEL0k0HqPaKzybB4lCpf9NwrER09qA
         FlLw==
X-Forwarded-Encrypted: i=1; AHgh+Rqa9nB2rzkjJFqEHz4OqdxI/n9M7cozT/wQQxco9gt4XaOY6eoSMbLh7/CUwiVb73sSpjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIuEiVU0NG8afKXKipLwzGHXJtwgxBl4p1zuVKE1kc+VkLJ3b
	riDJ9pmTQe/t572ysGLQXdT+UY1UCIO+S6KF4ztaMXGckT8MjxghJVns
X-Gm-Gg: AfdE7cmFSmdf5L+kYNMSgw8SU3b/hgJth5ZB/1lwUfLjYbleZ6aAQlqZ33etCsgyB/h
	dGYg4fScCWp0i5c5WWmmxm247Q6LnnPZhaYq68iqP0tjKr/SutVCRPWY95zt166qNQfTKgRfVEa
	Vq9/TbsI0/1Biw2h84D6YaXJHJIpfji5OWeXaNnGdkUd85uBrTYxwUO+tUItS4DeJBXedHn9YuU
	Ug3fd2FZBZThzI+CwzLlQ0xKFTI9lVKFLBJwexJN7AJ1ZFU6fSxYL6j2gylvS4JtqcDisDbSgtm
	hcQSOkSXFpC7Pe/+N+XWH1U+ebsarOqOWDAQhSAWqNUK6b8J5Du+EtNKKRPcbbSTX9e4MBz84p9
	OoR5VeoaDKfZXTnJOZ34k0mqy3ockrbnno3wxyibjkQ3hss2JG94Eqp6z7DO5+bc4HcoEnSdSE3
	+0jNuaD0ch8IxUN5CACgBh9A/kQaTlrJRcLheUWBS+KFtvg8khySV/6VeFgKgcS79j+aH+SOGbm
	R6n
X-Received: by 2002:a05:7300:434e:b0:30a:e530:ebc6 with SMTP id 5a478bee46e88-30c691cac71mr1041968eec.12.1782251827517;
        Tue, 23 Jun 2026 14:57:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:20e3:c15b:de5e:66e6? ([2620:10d:c090:500::e22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1b4f7d81sm18411106eec.0.2026.06.23.14.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 14:57:07 -0700 (PDT)
Message-ID: <2e01e2580cee612d458f99253b3e9c91d4a75e98.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/17] bpf: Prune verifier diagnostics on
 backtracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 23 Jun 2026 14:57:05 -0700
In-Reply-To: <20260619205934.1312876-5-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Save the diagnostic event-log position with each verifier stack entry and
> reset the environment-owned stream together with the normal verifier log
> when a queued state is popped. Also reset the diagnostic stream after
> successful subprogram verification even when level-2 logging preserves th=
e
> normal verifier log.
>=20
> Record branch outcomes as true or false. Later reports use those
> events to show the path that reached a verifier error. For queued branche=
s,
> append the queued outcome before push_stack() so the saved diagnostic
> position includes it, then reset back to the active path before continuin=
g.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Nit: Let's not use the word "backtracking" as a subject for this
     patch, as in verifier it is easy to confuse with precision
     tracking backtracking.

>  kernel/bpf/verifier.c | 44 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e81fdb0e22ae..ca4bba163418 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -192,6 +192,9 @@ struct bpf_verifier_stack_elem {
>  	struct bpf_verifier_stack_elem *next;
>  	/* length of verifier log at the time this state was pushed on stack */
>  	u32 log_pos;
> +	u64 diag_log_pos;

log_pos is u32, can we use u32 for diag_log_pos as well?

> +	bool diag_branch_valid;
> +	bool diag_branch_cond_true;

There is a 1 byte hole after 'st' and before 'insn_idx',
these two flags can fit there as bitfields.

Together this will remove the 6-byte padding and a 4-bytes hole from
this structure.

[...]

> @@ -1786,6 +1794,21 @@ static struct bpf_verifier_state *push_stack(struc=
t bpf_verifier_env *env,
>  	return &elem->st;
>  }
> =20
> +static struct bpf_verifier_state *
> +push_stack_with_branch_diag(struct bpf_verifier_env *env, int insn_idx,
> +			    int prev_insn_idx, bool speculative,
> +			    bool cond_true)
> +{
> +	struct bpf_verifier_state *st;
> +
> +	st =3D push_stack(env, insn_idx, prev_insn_idx, speculative);
> +	if (!IS_ERR(st)) {
> +		env->head->diag_branch_valid =3D true;
> +		env->head->diag_branch_cond_true =3D cond_true;

Tbh, I'd infer these flags instead of storing them.
If the state's prev_insn_idx is a conditional jump one can check if
this state's insn_idx is a target or a falltrhough. Would break for
'if ... goto +0' but I'd argue that it does not matter.
This would allow to move the

  bpf_diag_record_branch(env, head->prev_insn_idx, head->diag_branch_cond_t=
rue);

call from pop_stack to do_check(), near the:

  if (env->log.level & BPF_LOG_LEVEL2 && do_print_state) {
     verbose(env, "\nfrom %d to %d%s:", ...);
     ...
  }

and to make do with the activate_diag_branch flag in the pop_stack().

> +	}
> +	return st;
> +}
> +
>  static const char *reg_arg_name(struct bpf_verifier_env *env, argno_t ar=
gno)
>  {
>  	char *buf =3D env->tmp_arg_name;

[...]
