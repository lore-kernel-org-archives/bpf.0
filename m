Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D913AEF59
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501097; cv=pass; b=Madx+rzTVAlHLV6J6vjxz0NSzucoz3kTkzMYXkZy634dnXFyBGZkYUWmT6VbyHai5fOtlg6fJrYpngFPXI48Ck96+gLOSn/kW5PGTwFiAFbQThb9oBau3RwR1eI9w8bS0NmGBpzAzpNkDFSZij0ofbMwJkBiKccUtCfrwx0Lpx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501097; c=relaxed/simple;
	bh=tYF5ImeKfH0MhfqFqALg1UhDM4+qKe5D6LzI6Qrw3sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8Y5/lWLfTOJBWLuKB9Z0Q+f3x1P5fo2veCWrxOXo3vFqj+Ou5UmhjcoD43TfAm9WDNg5nm8VipL+oCCceBHopoJ2KSxzVbcZdfA67fugP2r9UqaywlQaMWgh2S0WiBrLLiy7A9ZqTYeUaAe/JNxu4wCImDkm14lZVjnLxxXp5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmYXcBVD; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmYXcBVD"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-444826c16ffso238167f8f.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 15:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777501079; cv=none;
        d=google.com; s=arc-20240605;
        b=LsQmV1oZ5GpDublXql3wjRO5UZI5wG3carZTY5469h5VL1jLWxAPWC9VJeG62oepll
         rlvDYJT3xw/YUND40HluhS/lG2KMe89H79pvzhBjaVF2X4fKc36Kd/fxzIRMlbyrTTwP
         OJ1hHYlRghcWlr+JL0ZdzWeYHidM6D3qXfa+sFCyAYTQOWBShXP3f+GnOjP7j3pPqlGL
         fMA3akJsGHrIYaYaNKJCXqdP7Ulhh2DckZ93Ua2opo1HgqwNEqwYOQUDF73PKwAqbbfk
         bBx6EtTYxWL/JAxNuS0/b6dCyxUsBZ/WYbrq7Suh0/rbFLpKK6117lRK9s7bi8bPcNFr
         qJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U2h3VezLsp5DKwP85IUlxsYIWmkmTvnb6c5O+N8gFCw=;
        fh=qHkpieUBBBxp61uLS/AlrxLy3s/Z9jUZBF8kVClLLGE=;
        b=H9L/GESTOT32nooekO/H1MIUEODZp8h3Pk3SdmO8tKX9VAKRUJwYgv3cYa7sBREDc0
         4z4fJ9upjVfPqaqmkokbckqP8XlnidnD3CRPVPQfiW2KWQl3p8JLcJo5KzzUWK8O66PK
         jAJp83ilI+8S/06TSu7XRCJm/+gZzR0jtgWwD1ZhXm3iUYYWVhzMROGmsuCg8GjOQE1O
         G3eoltt4ZDJAiatjAI4ZcaEQAq10vndd/ZTuQX/Ett3p4jaZ8BSGoWfohCku6CfoQOrY
         YEMGZK7eiqa0+HqHf9+GcWgC14f2g4FdzA9+YDwIe4OxLW5p/IMlOcTy8xnZHQ2/odgf
         /dCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777501079; x=1778105879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2h3VezLsp5DKwP85IUlxsYIWmkmTvnb6c5O+N8gFCw=;
        b=SmYXcBVDM0QMXxkSOyPf7Y1vJuCdP4uvOkj3GRxRwTxjlWnvTjzAXEVyio7tW6M0dJ
         JsDE5dl19hUUyblK12AyY89+tBYhw/ev9Ret49JaZ/3m2bZyB2zFga14zEX5OADa2YUx
         cCjZQYGAoN136UuKxGZOcoTHCAZ/8eX9Z3B0mZ9jecc+FLz6J8PrpjVEbDvhbyzb/LkK
         rieD56lM25dD2ms00iYTfyiL3qLPgvlOF5M75VsDTxps1aO2nntktCe5NZfYxXHLfpIM
         j1dqRtpFwPSDkSvjwHi9Zlbnafp7c9ZqwFi8MK9lHZXHwetBrK9HEXX9jmpMTPY1YKqr
         2hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777501079; x=1778105879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2h3VezLsp5DKwP85IUlxsYIWmkmTvnb6c5O+N8gFCw=;
        b=YRvPC4s3ZzeJQ0ykDjRhiTSaCw5QSgMW6o0JGAVp3GhTayYx0H8osgnR/5i2v3UNJt
         wUTT500d/lZD4L4MZFKMpncOOgQXPW17xSyF2+J8GGhb69IaxhapW9irLaL0QsyJxgo/
         MZgPh/ILXGDxU6RFS/LQdi/HAHpjEP32eWAyHPGJVCykgI3D214OTEZCvD3tww8oQMal
         IA7gbkw3nfgs7F8lSnvCNxixv5B44fNueUwdO4bRMv4LN8h6JVASdz17IYSCPUWp6qeP
         1Un6af5BaBQQB0r/a/fSYe399R+pX/gATOPS4pTWIU6npEewhEjcY2snqar1fNlLRFZj
         wISw==
X-Forwarded-Encrypted: i=1; AFNElJ9xXSNtuPVz0Rxw0yTSkCZWRSpJMx5U89MGZNNivmtuYgj7+3wFvcwJoGhItNa8Rt7dJrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Qqp7y0fu0G4fXKhlauaZ+LmSOWmm0+czInVbKePAyBe614dr
	sdU4gXuL2Nz1K9mqDjWwSp++g8oVI4ib2qyL2txW++QQo+KDb85Viv8sPJ9Y0uD4Ur258Spa21M
	ZggTr4tJL+0V5gpfK68GqRS0Fld3tBQo=
X-Gm-Gg: AeBDiest6In9JxuyLqGABoota8ZJx6ZMyn9BFa2YAnmDas5ppIrHlFm74a2LUMZDAar
	AMfqyOdeKE1rRtkY2AHnM27OxHY6TGgbbGhEY9vwawkd8o5rt30bwcuN7lihxFNvVEiNK9AFEH7
	7aiK3cuTOdtXLFW4O3KadnZrkuf0lH7g09HrsLvvbLk3PcbKYBOtmf4ONcXTm3h/Yt738AjeJIv
	kzRB6avNldJe7PvKT2uvbalgzM7n3IZqe79KfX328fC6F8vrZqw54KJj6G+EIxwCGajJYsHuKPp
	SCByMvUwp4cKiIp0UvqI5UGpsqqL3wmhUDrVx6oOAGTJ7NV6Un0ExLjqQQl+5UccaY7YvNK4ThM
	yfOvYMjABq4ytU0xRUpSLGhHpPCuDf5fz3cFofDoOj3LFoAXz195ZFB/HP2NXzX2+d7Fo
X-Received: by 2002:a05:6000:1869:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-4493d7fa267mr276743f8f.9.1777501079154; Wed, 29 Apr 2026
 15:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>
 <20260428230844.EFA64C2BCAF@smtp.kernel.org> <DI56ZVH6HKDK.1L8J5HPA37J09@gmail.com>
 <DI578ZDDKR6K.QH52KXPV1CLN@gmail.com> <afIPMllq5VI-bJLY@mail.gmail.com> <afIphKy2138OC5GR@mail.gmail.com>
In-Reply-To: <afIphKy2138OC5GR@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 30 Apr 2026 00:17:22 +0200
X-Gm-Features: AVHnY4KrtM4V07tNGQMH1e-9IWZnb87S9yAPWfWBWf463BF_kxL9uAQjccpYRzs
Message-ID: <CAP01T74Vk3+udUbt5scHNuudje9ArOatSARQdkbhtFw7E7nJLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Print breakdown of insns processed by subprogs
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 17:53, Paul Chaignon <paul.chaignon@gmail.com> wrote:
>
> On Wed, Apr 29, 2026 at 04:01:25PM +0200, Paul Chaignon wrote:
> > On Wed, Apr 29, 2026 at 02:07:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Wed Apr 29, 2026 at 1:55 AM CEST, Kumar Kartikeya Dwivedi wrote:
> > > > On Wed Apr 29, 2026 at 1:08 AM CEST, sashiko-bot wrote:
> > > >> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > >> - [High] Out-of-bounds read in `bpf_subprog_is_global()` when printing verification stats for programs with hidden subprograms.
> > > >> --
> > > >>
> > > >> commit 08128f883e58301e0f97b1d4a94656be63b8f790
> > > >> Author: Paul Chaignon <paul.chaignon@gmail.com>
> > > >>
> > > >> bpf: Print breakdown of insns processed by subprogs
> > > >>
> > > >> This patch tracks the number of instructions processed by each global
> > > >> function (subprog) during BPF verification. It then reports this
> > > >> breakdown in the verifier logs under BPF_LOG_STATS.
> > > >>
> > > >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > >>> index 03f9e16c2abe..b48389b48eb6 100644
> > > >>> --- a/kernel/bpf/verifier.c
> > > >>> +++ b/kernel/bpf/verifier.c
> > > >>
> > > >> [ ... ]
> > > >>
> > > >>> @@ -18288,6 +18295,13 @@ static void print_verification_stats(struct bpf_verifier_env *env)
> > > >>>                                 verbose(env, "+");
> > > >>>                 }
> > > >>>                 verbose(env, "\n");
> > > >>> +               verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
> > > >>> +               for (i = 1; i < env->subprog_cnt; i++) {
> > > >>> +                       if (!bpf_subprog_is_global(env, i))
> > > >>
> > > >> Could this introduce a regression due to an out-of-bounds read on the
> > > >> func_info_aux array if there are hidden subprograms?
> > > >>
> > > >> At load time, if BTF is present, env->prog->aux->func_info_aux is allocated
> > > >> with exactly func_info_cnt elements, and env->subprog_cnt initially matches
> > > >> func_info_cnt.
> > > >>
> > > >> During verification, if a feature like bpf_throw is used without an explicit
> > > >> callback, add_hidden_subprog() is called which increments env->subprog_cnt
> > > >> but does not resize the func_info_aux array.
> > > >>
> > > >> Since this loop iterates up to the updated env->subprog_cnt, when i reaches
> > > >> the index of a hidden subprogram, bpf_subprog_is_global() will access
> > > >> aux[i].linkage where i >= func_info_cnt:
> > > >>
> > > >> kernel/bpf/verifier.c:bpf_subprog_is_global() {
> > > >>  struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
> > > >>
> > > >>  return aux && aux[subprog].linkage == BTF_FUNC_GLOBAL;
> > > >> }
> > > >>
> > > >> Is it possible to skip hidden subprograms here, or limit the check to
> > > >> func_info_cnt?
> > > >
> > > > Don't see it happening, since hidden subprogs never get verified, so we won't
> > > > invoke bpf_subprog_is_global() with such a subprog index.
> > >
> > > Ah, no, stupid me. We get here after fixing up and adding the hidden subprog. So
> > > we can still do OOB since subprog_cnt includes the hidden_subprog_cnt. How about
> > > the following as a fix? I checked over other places where we iterate over all of
> > > the subprogs and those look fine, so instead of changing bpf_subprog_is_global()
> > > we can adjust this function to only consider real subprogs. Didn't compile test.
> >
> > That's a nice find! I also doubted it initially as we have that pattern
> > everywhere.
> >
> > It looks like this would be a fix for commit 335d1c5b5452 ("bpf:
> > Implement support for adding hidden subprogs") (or technically, the next
> > commit as 335d1c5b5452 didn't have any user). So maybe I can resend as a
> > first patch (with you as a co-author) and the following diff (took the
> > opportunity to simplify the logic on the assumption that we always have
> > the main "subprog").
>
> Just saw that subprog_info is statically allocated (contrary to
> func_info_aux) so we wouldn't get an OOB on the existing code, just
> some garbage "+0" on the stack depths.

Yeah, I don't think it was buggy before this, e.g. adjust_btf_func()
explicitly avoids touching func_info for this reason.
Just feel free to fold the diff into your commit and resend, no need
to send a separate change or make me co author.

>
> >
> > Not sure if it would need to be sent to bpf instead of bpf-next. Maybe
> > keep the patchset on bpf-next, but add "Cc: stable@vger.kernel.org"?
>
> [...]
>
