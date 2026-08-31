Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650A3E0C47
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178248; cv=none; b=XSjkk+BAvvWlT++LjDBQnvfn6KX/VH31N/tm2XSLeZs+w7il5RjY6jXZDryq9PwDHV8BOCfrDIm1BKTlUd9wA7UXZAyaDsyIb5r15NhHjDkTbDchP+KsnAlix1ktJcYD+67VgeRH44EH67p3yU/USqiWmMd7ohAN40W4LW/siZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178248; c=relaxed/simple;
	bh=p2Uu1nMgVMYKLDH4fRq1B7AXh5w3WUSQ7LF0tE+17PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWvD0qaPjTpi5oOc1zBJ4B0jjU3nSqli85SvHTKk0wkjGXXGQByTYA2O0jkLbvLmzrdvtH3XwVlAxjLRwSLYhnjjq/ZW5qtnshXvlOuHkSvuC02DPfDDXjRcvjzvTLrmqrNv8eaK/UJGeFIqjdb7PbGmaFqiKwqU6PLBUYvTVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozKGpdpz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozKGpdpz"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso4320260a12.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788178244; x=1788783044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AjfRvBDgN8YljIPenyb3yj/VMKwNxmnnBipoaD0U950=;
        b=ozKGpdpzIiZofXMtdoZkqoFqyHsHB9fIInAytIIJuLx9qiiRq+Ak/J+18mZHldqK/a
         KmMtW14CzEAMCz4adnIj06XUVo7zDF9DzJhTymoaB7qUxoE8EBDbkqUFebry5AH15I5E
         sbOqU13xCDZAIj8CxSDEtxoz5WQu9bfCrdavBGW2vrDvGn7oeX7gp1TviSgd4IDORw7+
         K/3DuzkcyAUH6BalJG0g1UXoZ1iVtcsL4p4MQYZVtZiDiAz49iGtGUYkQQ3zOrn7N28p
         y25FCnGj18/2X9NAclGQ7DKO7+Xd3XntWnAlfnifJeWJuCb0Tnl3lGd5+aOd68/rNo6B
         hNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788178244; x=1788783044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AjfRvBDgN8YljIPenyb3yj/VMKwNxmnnBipoaD0U950=;
        b=Ws8oQWsXzQ+ligWVeLOkNL91PfbZQVeozPH//ClvIzZ4AQzS2ukixk95PzT65/yC3Z
         TElWMdpr8cwUsm+/+vKXfNiFb9OJ+U8IjFl8GuI+UCCglZagrKRTtbC7kox7mvOh2KcR
         oRdGSEF1FWuW+IlnkZ3MmBzwIXjlv1ZxezP3rr9JD36p/1ZHCLc9gxQtG8EEXwdArbG7
         VpP2GGN7+dA8z+aHcyMNX5ER1P0a8Sia5m684EgHGjxOTlZocAOZvNkb/R3CMMTG0PN6
         eoUFNLY+XCfTiHI3oikeMlz/odrmY1tepFMQIIRL1PLmDsNLzgluoS0x6VnqZCYOxa1o
         tDFg==
X-Gm-Message-State: AFuF++nVcBHXGWcuVu8neqGsuLrIZ/xTDaERHAL9EQV0xY5CkXVrFHUa
	bJkNZvrT1P7rUAE3mq4fwaH4D+CQSwSXmACca1WY3Rgcgfv3gkSjFfow
X-Gm-Gg: AYBFou3u+0WWJoK28k/tA4qvmCRzAhkkbQkxnnBoS2uph3b60H9gCzkaWvZhUGYtLRY
	PgosEoDDgSKXwUMp+/WLPI0nmvoZJVdrrlz7FRpQ+XNfy7rYu2t/KV9tpoMMrpPnKEWUCG6VGUl
	/2Qke8sA83YT011ct9FlbqKx2kaB14/l3xDCMRqUrLrMhJ2H2WIhANBkJZqoRRdRLU9u0Df6848
	rgBJaD61cOAf5VOi3hOGEpCeRfHNSgkQ2NzDjibjAYbN4UdUzbrT7jFO7jwzlVRr0kpPWoR9zYU
	sbCIqRBEM4nAd531TPHP1i2iWKOktqMeKWf5fKgubfHY9MzBDOakZtVIHfRlk+NPSonai6jSxdX
	a5VMV406/fEJtyMKNZ/Gwdn3ykTr1dp7lgW0eXsTpRGoVi/OMplnU90CKnsKqWhmGVDgPLHKdS9
	+1WbVLwXen1IVazEg+exZuHzWzftnJvs8KyDZiPDVQcE6W1Roaa1qwh2DaDn0XLexArSqN
X-Received: by 2002:a05:6402:378b:b0:6a6:32fa:1e9e with SMTP id 4fb4d7f45d1cf-6a632fa1f4emr7274569a12.22.1788178244220;
        Mon, 31 Aug 2026 05:10:44 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611c64f9fsm3557069a12.27.2026.08.31.05.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:10:43 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:21:24 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>, rachelmenge@gmail.com,
	hargar@microsoft.com, apais@microsoft.com
Subject: Re: [PATCH bpf-next v1 1/2] bpf: allow terminal gotox instructions
Message-ID: <apVxxDcvCSzlw2FG@mail.gmail.com>
References: <20260830073125.360934-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830073125.360934-1-sidchintamaneni@gmail.com>

On 26/08/30 07:31AM, Siddharth Chintamaneni wrote:
> check_subprogs() treats gotox as a direct jump and validates its reserved
> zero offset. When gotox is the final instruction, this produces a
> synthetic successor one instruction past the end of the subprogram and
> rejects an otherwise valid program.
> 
> Skip direct-offset validation for gotox and accept it as a
> non-fallthrough terminal instruction. Its actual targets remain validated
> from the instruction-array jump table during CFG construction.

Thanks, the fix looks correct.

I have comments to the selftest, so expecting v2. When you resend it,
please capitalize "allow" in this commit's title.

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e036ae20bf6b..44195ec1445d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3087,6 +3087,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  			subprog[cur_subprog].exit_idx = i;
>  			goto next;
>  		}
> +		if (insn_is_gotox(&insn[i]))
> +			goto next;
>  		off = i + bpf_jmp_offset(&insn[i]) + 1;
>  		if (off < subprog_start || off >= subprog_end) {
>  			verbose(env, "jump out of range from insn %d to %d\n", i, off);
> @@ -3106,7 +3108,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  			 */
>  			if (code != (BPF_JMP | BPF_EXIT) &&
>  			    code != (BPF_JMP32 | BPF_JA) &&
> -			    code != (BPF_JMP | BPF_JA)) {
> +			    code != (BPF_JMP | BPF_JA) &&
> +			    !insn_is_gotox(&insn[i])) {
>  				verbose(env, "last insn is not an exit or jmp\n");
>  				bpf_diag_program_structure(
>  					env, i, "subprogram can fall through",
> 
> base-commit: cd35e1b10182c42b4ae31ee49119463b17d8ba7f
> -- 
> 2.43.0
> 
