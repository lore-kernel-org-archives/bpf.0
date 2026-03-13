Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470E31E830
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438088; cv=none; b=j9lzcHDMILoma7ON6MeHfj0plWT27qg2H4FYaGslYnCm0RwncOu8D1FqEFciTTMBEcpWqDl9A3W54KIS3xwdsma/gH6st0EKj6gR2lBMfzWTErnkRRiy9kgjdzTMwyl6NH2HoyGYBd/8CxrQ5aEye953OXIIUuR2PieGUehpBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438088; c=relaxed/simple;
	bh=oAB60OQwBs0in4aCcqtzuPGTNVp/3lAL0yLYeleIF64=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MZA9/wvR2Ze/AHuUwlpsG06W+PJ4C0AA92NEkiZcvuG9i7sj2mZYmzOszp6LhA9iyqpwQEGfsLPkPHjMNIiQDbWn/ozrPH7mXLfnNiGIymzJikI5c/ZqG5UZ4qFuiwscLEbnli9ad+fa2kOVkyMsbeB3JLurS6wUOuh0OKEenxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3m8CUNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3m8CUNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E1FC19421;
	Fri, 13 Mar 2026 21:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773438088;
	bh=oAB60OQwBs0in4aCcqtzuPGTNVp/3lAL0yLYeleIF64=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=D3m8CUNvT7u470ucNmqhDs+pdhLk0N9B1mPKUTO1qD+LIm4FDdtm6S/98g2TZrPXv
	 s42gohRNysPawAyocTjdznVikd9KrXuzvdn21Wlc4Jm5OCFLgN/D3NjuymNJZ+3sk+
	 k5h09OHZvrh99MCNsOrcMXpAVEYXUz5+08K28cvLCh7GmNgjiP942vVfKbyg+fA/sO
	 IimtbL1mMc2wxNK2uxXTGGgjQkBd23IR8z4u1uqCK7PrGAUWMZ4fCPHn8aB0fAS5fm
	 z08QDaxsvhXkrENh8HUIHGuoZNp/fve94p4C3exkKHnhO/pS1arVRwpuVkIHSC5AEG
	 i++hZUYIucGEQ==
Content-Type: multipart/mixed; boundary="===============1203741757263406352=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <64dd24e307698caa34f414e98f51909a3ec3824facb60ceb6ef7594ee3407b8e@mail.kernel.org>
In-Reply-To: <20260313-sleepable_tracepoints-v4-4-debc688a66b3@meta.com>
References: <20260313-sleepable_tracepoints-v4-4-debc688a66b3@meta.com>
Subject: Re: [PATCH bpf-next v4 4/5] libbpf: Add section handlers for sleepable tracepoints
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Mar 2026 21:41:27 +0000 (UTC)

--===============1203741757263406352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0662d72bad20..ef79a980c0bb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -12997,11 +13009,19 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
>  	if (!sec_name)
>  		return -ENOMEM;
>
> -	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
> -	if (str_has_pfx(prog->sec_name, "tp/"))
> -		tp_cat = sec_name + sizeof("tp/") - 1;
> -	else
> -		tp_cat = sec_name + sizeof("tracepoint/") - 1;
> +	/* extract "<prefix><category>/<name>" */
> +	tp_cat = NULL;
> +	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
> +		if (str_has_pfx(prog->sec_name, prefixes[i])) {
> +			tp_cat = sec_name + strlen(prefixes[i]);
> +			break;
> +		}
> +	}
> +	if (!tp_cat) {
> +		free(sec_name);
> +		return -EINVAL;
> +	}

Should attach_tp() handle bare SEC("tp.s") and SEC("tracepoint.s")
the same way it handles bare SEC("tp") and SEC("tracepoint")?

sec_def_matches() allows bare section names for "+" suffixed
SEC_DEF entries -- when sec_name[len] == '\0' it returns true.
So SEC("tp.s") matches SEC_DEF("tp.s+") and reaches attach_tp().

The existing bare-name guard only checks for "tp" and "tracepoint":

    if (strcmp(prog->sec_name, "tp") == 0 ||
        strcmp(prog->sec_name, "tracepoint") == 0)
        return 0;

Since none of the prefixes ("tp.s/", "tp/", "tracepoint.s/",
"tracepoint/") match the bare string "tp.s", tp_cat stays NULL
and the function returns -EINVAL. In bpf_object__attach_skeleton()
this becomes a fatal error that stops the entire skeleton attach.

attach_raw_tp() in the same patch handles the equivalent bare case
correctly -- when sec_name[pfx_len] == '\0' it returns 0:

    for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
        ...
        if (prog->sec_name[pfx_len] == '\0')
            return 0;
        ...
    }

The convention across libbpf attach handlers (attach_kprobe,
attach_raw_tp) is to return 0 with *link = NULL for bare section
names, signaling "no auto-attach" without error.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23070834076
--===============1203741757263406352==--
