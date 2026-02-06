Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BE367F56
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385355; cv=none; b=qUj45+5XcE3DDydwj5CDNbpIMLT1sCj8fnBW7EOiYkEBWcNtZrqfAtFfcdg4RJ6x9FcDlELMZuweuDld/287jDwcvQGc1ThIkFCDNS1xX/aT8c8GnfGwpuAmQEyVsJX6s9MICurz498mqnb4rpa5YrL8zZ2hlC1mUQJyLmyXzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385355; c=relaxed/simple;
	bh=rGBbb+cAh8cXdLw7bkpja62+z4B0+I2tQhqSEHc5exE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH1wuWRj9dE+wbfHmKwns2uruxBo40Gd5bMB7GV8AFzwm3C3maE2LuAOz2bt3iRAvFYVZu1A8NkKAiZw2h5vCxNkrjUY3MQDTOJ7sWN83SZhd6uheLIYGKYadv5CGdzlSK43AH95x22y++FRa9DhgPBXHrXPWP/V1SK1pmiefOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKNPp4AS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKNPp4AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D2EC2BCB5
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770385354;
	bh=rGBbb+cAh8cXdLw7bkpja62+z4B0+I2tQhqSEHc5exE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sKNPp4ASwuDJh6J3uuLKftMnuPZhlF/r3Ulpe7aRMkshyt1ktlpyMZNYTt+T80Us0
	 WTQ+WBoBRpD1zf/IerngC9z3FBikrNW6K9zdXm/jL6VAdJXbOvbagaLuSk8+uuS4C9
	 njZ7gdfpETVFid46/Ek04EzIuen+RT5TPXsyPB1vdyEMTsgtOcuEV4xn/xlLm4XceJ
	 +ZvAFaBLKlN+p8BsPJF3FSCHynOmAgvWAj9h+QEc+O9xttgjudNnldXaWPxlkGTMWi
	 DkTCEGrWXUEn6HtKV5w9oPNaXjVfRK8QWrycsK3ISCmdqHf/qiehllMzxq34L0G0mM
	 Y+GfytlkyVQzQ==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8947e6ffd30so7793996d6.0
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 05:42:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2jv+cHNuDrxQ/27Rdx1xrJBTMDMnLNZP7023f6SliVnuBfOdsPscDbDEa+Mc8By5At1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkUC1tj/Q9HarQsMIqhNsTp0Ut5adNe3ehZY2ThQ218CtnXRB9
	DWA0T8pPt5Tm5lpqCCH8rOAXsYyZ4t+3LXXBoNTyV/0whhERYW/02Lb9Q63KHEOYOV/n4RLkGFk
	RAcrFw/7gUO8HTGNcyeiJG6mLjFspBc8=
X-Received: by 2002:ad4:596f:0:b0:88f:9670:d107 with SMTP id
 6a1803df08f44-8953cd9c4f3mr32553666d6.66.1770385353802; Fri, 06 Feb 2026
 05:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206122002.1494125-3-dongml2@chinatelecom.cn> <444267200b59241e9da104eab8af2d7189aa401005887a2cd0128cd6aeda98e2@mail.kernel.org>
In-Reply-To: <444267200b59241e9da104eab8af2d7189aa401005887a2cd0128cd6aeda98e2@mail.kernel.org>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Fri, 6 Feb 2026 14:42:22 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNj5JZJ-k5bJibSgLPD5xnTzf7kfvma4kJOBKoNTnSLLDg@mail.gmail.com>
X-Gm-Features: AZwV_Qgp30xu6TweGeMW0sgxJKdeBZnllbFPIwwNJDP6mSLbXtqNecZzsDiMGlk
Message-ID: <CAJ+HfNj5JZJ-k5bJibSgLPD5xnTzf7kfvma4kJOBKoNTnSLLDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, riscv: add fsession support for trampolines
To: menglong8.dong@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com, 
	puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	jiang.biao@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

Menglong!

On Fri, 6 Feb 2026 at 13:51, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
>
> [ ... ]
>
> > +static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
> > +                   int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
> > +                   int cookie_off, struct rv_jit_context *ctx)
> > +{
> > +     int i, cur_cookie = (cookie_off - args_off) / 8;
> > +
> > +     for (i = 0; i < tl->nr_links; i++) {
> > +             int err;
> > +
> > +             if (bpf_prog_calls_session_cookie(&tl->links[i])) {
>                                                 ^^^^^^^^^^^^^^
>
> Should this be tl->links[i] instead of &tl->links[i]?
>
> The function bpf_prog_calls_session_cookie() expects a struct bpf_tramp_link
> pointer, but tl->links is an array of pointers, so tl->links[i] is already
> a struct bpf_tramp_link pointer. The extra & passes a pointer-to-pointer.
>
> For comparison, arm64 uses:
>
>     if (bpf_prog_calls_session_cookie(fentry->links[i]))
>
> And include/linux/bpf.h uses:
>
>     if (bpf_prog_calls_session_cookie(fentries.links[i]))
>
> Both without the &.
>
> > +                     u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
> > +
> > +                     emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
> > +                     cur_cookie--;
> > +             }
> > +             err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
> > +                                   save_ret, ctx);
>
> Note that invoke_bpf_prog() correctly uses tl->links[i] without the &.

Menglong, the v3 doesn't build. Please refrain from just stressing
versions out. For v4, make sure you properly build/test. On that note;
on what hardware/simulator did you perform the tests on?
