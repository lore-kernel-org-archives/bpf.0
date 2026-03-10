Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D43D3484
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163466; cv=pass; b=Icd8vZl/yS/z0ly89jnZ+wFROi38anm/IWuuzKynfSNUihZTvKdCCLvJm6mFVI8D7GFMoF5s7NSEp2PbYHZqkKk/wJh52K3y0u18qkmX8pr8BWDeP9TQDCfzL0ZJLlAIPpYBtCMWv3KIwkAVEQrJPNtB7Nc/dLlajjSCh9FgbiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163466; c=relaxed/simple;
	bh=qe6UOPyH09fVG+sn9JIknvgtuqP2tPFx+HmroRjB1BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfF3bTORDc8XrnnL+GWIZLxAuXFsld1XeQXO32xS1p6+eVO/L1foihm83aF4aLNghMKG8GI3tp/ZMZI+5Fq+yqfpaxAt99vqLMdzA2ZxX7eFy//Zl9/ZkMpZYsxoYq3NSHU3lkDKAtmyjb71I4VsG+zsjLrxvRk6hKQsgqhFHY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld7NVVPT; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld7NVVPT"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48538c5956bso1166285e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 10:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773163463; cv=none;
        d=google.com; s=arc-20240605;
        b=h3e/6KsY4z434rsq0ZkqdQKDGjXVjSu1hBt6vQhqx45KISIUEw+g49qF6sh3im4ZXV
         6WTBd8lYTtLkapTiePanYhDtt022wCO7VMLjq+tFka3zXnS8i62+G2jLQz6hfnmEmQWc
         6rHHhgT8v5qBb8gXP8DPTjTdVRirlTYmKr3SGoC52QxGWbJkeY1z4RP83Q8HGaW5YUdv
         7GGYeKv0oP7EbN/oJo9HNt6tc97n4BLLg0RDdSlEXg/6UQo8j72a/rpqSsjkeqFLyjtg
         EU3MrhsQWDjaUCHcDgnlNRvSZVxYQ5tcBUnAhNJpC57Mfn0fMNhrfi0h/i5xjiqFLyml
         lvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m34P9qg5/9p0up6Ob522geMpxbEkYzYijmYKyt2ZJUw=;
        fh=boGSsBpOF6oibtuaPOYPS+0wXa/Cjegx5avEAz9GAhQ=;
        b=eQnnVJbFoEkBRyDczJ0KlSlRGYwrdzsxixCfD2z3JPJ+/34bMWSMJkesgtmP76Li0f
         yrgUcQfTqlspK+gBSOPq0epMvKcwEup2lGmwf4UenKcSDS/1EM8LxzAJheu/DlUXAJ56
         9zV2aUv+4QFgCmn6JhQkL2L1jFSEF6/jAFawjYxEAs2Vl0RxDV41A5HT8QMwSBIroId0
         MFFISCIEttdJJmoATD7WoZwIK1jSZ73hxY4uert7nU9OeHqpNYmpu58+XUQaN5zVZFhK
         wSg8RYBm1TP0jP3v3INFr0u9LjSNwszcskPhFi0b/WqR2Y91TGsIXEX5uwuixsoGOjEY
         7l/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773163463; x=1773768263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m34P9qg5/9p0up6Ob522geMpxbEkYzYijmYKyt2ZJUw=;
        b=ld7NVVPTHQ3qZjn108yq6rGOKQ8aSqMn0E4BqLLp0jATneuZIHFsKKjd3Hkgy4PJhh
         p5qxLlQtfImvbXRtM7Z3mwTgwM0vNT6QQ7S5/f7MP/J8rOQBEwtdlZKo29DVJwdhJ1o3
         kwdyuBQeDLES+itEZawxZB+FG8FXwWLjg8jw+4ldHM2vXohqKUB52OG6X4Jcv3UVrzZO
         Qjk6Ut/JFpJmFTvPPRrACxL0y7f3m7v7b/9RcruEL7t7st/yQnvSE0bGKPFfX2w7tP6x
         Zk+8aqtmiPkrRDDUZqt3SJjUrjjOBdWWDJLW8d+2Fq7G22hEaZtm4SWaNgfwYlJbIL5G
         iu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773163463; x=1773768263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m34P9qg5/9p0up6Ob522geMpxbEkYzYijmYKyt2ZJUw=;
        b=jMW/omRWQy3v2puCg3HFpQvrADkiL/OShnp2cbMPo7O49ygXpvHkkH16bGroe4g2jo
         ZxSpR+y5zruFyzoRll7E3FR0b6pCVrQROb4kidr+4NlVe5c3Z7yAYdKgItQ+oBnNrlkH
         YdIziiVRL2haLRduDTcV7ab26fbo6XZMOM05jPToOoc/VD+8FJVgVaEH+ixCBxyMgsau
         S2KOuu1s6dEqmEvhAXqkzuBVZG67xQ1iOKHS+1tG82YZ8+avSW8uUGt18RZOYEb5MqgI
         xbkuXYejocAft98OMvo7olphyyzN42YPCDCaaleugEl9HktOUtPefi6CwAIFQObJbfoX
         FP4g==
X-Forwarded-Encrypted: i=1; AJvYcCXLuH44ST6SwPYn6jhWclTompz4alRL1WmkYkgAg61hxJnmEjg4wRQ10fsrkrDaI5D50PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydD77QWMQcHYyM0BtzyqhTEjYvSoxBg8V/5cwZl9Kdu065ikxA
	TQFYc3obL0G7qrgxkInvgLqLnSs/rIQAKu3E6zcR18xR07y+D/PYZmMwKTKxEJqG8Mmfd74IHZ4
	5JpGVZrP3SDlam0NXWAILxebR0aMjuxk=
X-Gm-Gg: ATEYQzyOhOyamRAP5TakAo7/Um/FDqZdx3gJ6BY0kSG3btnEiVERYXpCW5RDz576kub
	nS95VwbqK6HXgF35Ajr17RnWIdifx46bOGQkPP1TIZacyTRfed+dP4GIR/vnX/JpN2KZGvDlJ5/
	XK2guwDyVUBz3N1JeE9Vvg559KvPeWc/N7bW9lQblbBFcapsF1HR2X+9SwMun/FHhBfoiLuPX+X
	cFfVP+TP5tXso/Qd3UhOuH/FD73AU2QValDxrbVQZ8o9TNoOyBKSErvTEwXshbyeESSuf1iNvX+
	sOX80imiwYiv3oKdTYKCUdcZAI/wF50oJeOGqJwmj/RBlbov9FiL9EYCmbnq
X-Received: by 2002:a05:600d:6450:20b0:483:a2b0:d210 with SMTP id
 5b1f17b1804b1-485419e0654mr57793155e9.7.1773163462372; Tue, 10 Mar 2026
 10:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303150639.85007-4-leon.hwang@linux.dev> <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
In-Reply-To: <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Mar 2026 18:23:45 +0100
X-Gm-Features: AaiRm513_5D97dMh5zZ6mTaj8z2tHS7OLQWsE8CcolmJzu3CwwWzrNbuIqXtyes
Message-ID: <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: bot+bpf-ci@kernel.org
Cc: leon.hwang@linux.dev, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, yangfeng@kylinos.cn, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, 
	pulehui@huawei.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Mar 2026 at 17:04, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
>
> [ ... ]
>
> > +     switch (match) {
> > +     case BPF_MAP_OWNER_MATCH_FOR_INIT:
> > +             if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
> > +                     return false;
> > +             break;
> > +
> > +     case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> > +             if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
> > +                     return false;
> > +             break;
> > +     }
>
> In the v1 review, Alexei Starovoitov asked for strict conformance
> both ways rather than one-directional validation:
>
>     "Don't be fancy. Require strict conformance both ways
>     in *all* patches."
>
> https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com/
>
> The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
> matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_write_ctx
> but allowing the reverse.  Was this an intentional design choice, and
> if so, should the changelog note the disagreement?
>

Let's follow the approach Alexei outlined, while the changes look ok
to me, let's remove the one way check and just do
owner->kprobe_write_ctx != aux->kprobe_write_ctx, same for the other
two checks. With this we can also get rid of this INIT vs UPDATE
distinction.

Other than that I think patches are good, please also test both
directions in the selftest in next respin.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22630000544
