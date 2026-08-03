Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119422A1CF
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785716513; cv=none; b=bh26mQkrXDnwJZsAEupLDK3nIGfk4joD1GWsSkkA0LvNn4wo+lO2fKr3iZY3jzl2nrbiXkwFJIi3IZWIoy7vQngjSSv0O2VkplhkTONMTStsDt3tNvrDkSY0SQVEBZDOfpZURfU1d8kTU7ep1UBQqLvE5/aHnwsjvHRD7IViTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785716513; c=relaxed/simple;
	bh=1Olnm7quu3g/Ie6wUsRNxzayVdXa8Voo51+FzzYxc+I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SAnKxrWCY7sfq7H14+0C6id5j3bt1Xp9xyd6R5hiuodDrrgKCifZGyDB2yAWZxrQSaRSZluJ2PYoszEYktL5qtYgIiDKxQtklVWEmfeFklVVrA5tEoNyebusebbmn7FRHZYckhEwURw29K15CD1ecD5rHvkD3qE5ZvDHyXhY8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l12S2bZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l12S2bZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CC71F000E9;
	Mon,  3 Aug 2026 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785716511;
	bh=g8+kz5yUIQ9tM9nYXu4oV/IHY3Z5LLoBgh5e+nmZndE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l12S2bZufJZSZM88ieX8rCVhoi3CPCcQ9gfep/LaWRRx5ZFO34CuGDo6LnfsEBLny
	 md/JyQKiaVYC8xBychU+z9ItVk+We4Omb+oJvDP6enqzZrzUQziFrRX1ET6CbSN8Tk
	 XnnR9yQU9avdrBqwPieJUlQLSpdx95zdLMXyyrwnvZJiCzzVqyDVQqMAbb+PDrDpof
	 A5u7aFdxdJ0dq5nens8n0WecUH+ACH6/egZ2a7FZqUDcpCiKgQmFAlhiECnyTkJXfy
	 GD2K98IeQ2/3WcyhSKjISs7E+uCy1zXvYMK1vE5wEcu7qfeyFzSLk+3apKtgX6DOel
	 SH4rWLv2drOeA==
Content-Type: multipart/mixed; boundary="===============7710041750179240564=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02a0523b31767a3994eb6a379dfdc83217749f99f89ebc71a4aaa0d6940f45c5@mail.kernel.org>
In-Reply-To: <20260802225209.2511758-2-memxor@gmail.com>
References: <20260802225209.2511758-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Show more useful info in stack depth stats
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 00:21:50 +0000 (UTC)

--===============7710041750179240564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b274004fccfd9..3b61897ed0d2a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18777,10 +18777,15 @@ static void print_verification_stats(struct bpf_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i = 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);
> +		for (i = 0; i < subprog_cnt; i++) {
> +			const char *name = env->subprog_info[i].name;
> +
> +			if (!name || !name[0])
> +				name = "<unknown>";
> +			verbose(env, "stack depth subprog %d %s %d\n", i, name,
> +				env->subprog_info[i].stack_depth);
> +		}

This isn't a bug, but could the name lookup here reuse subprog_name()?
It is already in this file and several other verbose() sites use it,
for example in do_check_common()'s caller:

kernel/bpf/verifier.c
	...
		} else if (env->log.level & BPF_LOG_LEVEL) {
			verbose(env, "Func#%d ('%s') is safe for any args that match its prototype\n",
				i, subprog_name(env, i));
		}
	...

subprog_name() returns "" when there is no func_info, so the
!name[0] fallback would still catch it:

kernel/bpf/verifier.c:subprog_name() {
	if (!env->prog->aux->func_info)
		return "";

	info = &env->prog->aux->func_info[subprog];
	return btf_type_name(env->prog->aux->btf, info->type_id);
}

There is also fmt_subprog() in kernel/bpf/liveness.c doing the same
name-or-fallback formatting, so this is a third variant of the same
lookup.

>  		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
>  		for (i = 1; i < subprog_cnt; i++)
>  			if (bpf_subprog_is_global(env, i))

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30771845943
--===============7710041750179240564==--
