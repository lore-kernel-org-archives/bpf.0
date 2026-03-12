Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6B242D7B
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314563; cv=pass; b=WtvzoP4dcJYQR+tHdGQ4vYyxYIakzLbbZ5hYe04abwEplUEaErCe1bpwF8wzEUYdxedhLbkziSHuhgtGHfUqQ2IXwMXj3f88RMT91QP5VdYZ6mCNl47SjZE9anCQ4tnPz8ONGWAs5FZ6/vplf5S+q+qsRzhm/lQ8tcv24tP3lQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314563; c=relaxed/simple;
	bh=o4Ul7nKjlfGesIuUZ5jl0QYi6UxHgN6lC1yFFzonDqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApxyiCSn2Motwu4nPQmCKWw+xZr/JZVqzDFrYr9VIDM1kvK/4UaXQnolUslm0n6U2o87FpAJp+QDFa52gaz08zorZpHrkOLV3XNCqvNJ6JM3HwJ9l3UHYZ8XgXoI4W8McdqOzrRubu0irKEx7Dq1xeI23WMKeUONZ67nKDUCWac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxF7SZ7L; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxF7SZ7L"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38a45bc61e9so7500451fa.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 04:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773314560; cv=none;
        d=google.com; s=arc-20240605;
        b=P2ffENASp415PYjYjffsgb2R6Sp6GlTpd3GVbAZoIwnuKFIcjQQW382jigEcAM3GLx
         SNlznIdeqvClNJyzDLxcvEG6hzY8WCfAqGYYPDZ0tjimiab+YVxD5OVo24pc3uTLZLm5
         C0MZgR2nOYMmpEYD3ysbBjR06E9WLsznwT7tT/3oK0LsnP03/IIv+QhYdo9PmbsPT3P+
         RutsnIW9kTdCH51Ar2evkQzP9jsCaw3wY+0k/PQoe5V5CUnbdoTM9fWVkTzxCmTgnwwE
         wqUbc7tWPSEtNNVs3WGXADxQztduSfITDp4occuP+HKsc7EObVPG1NcqltMjU+yJpfNz
         5TKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3QaJgk7QAOL/LIy3ichchEWU1Xnqclfz0s2h4tb2vhk=;
        fh=l2kjjz505K+KLxRAN1lnv3/f5D31akwYmvMPQMBV3l8=;
        b=H1dYa6bXaSB5YpQABc78fLa7Jcyc0DD/DXxMr1FEW64WDymEG9ho/xXEbZ5GAR+jA8
         J69BYzRrarFWyw+e6nv/3C+dUaOCI2NXq4998+AsybGZHrg9/Eyk9hBUD9LJ95ESX+B2
         RGa2oVItIqNSY65GBzG17rG+d+euqitcwIQMtBTV5xkZ06IXRc8HtnbWZvYRufIljI+0
         RHZ0xnFNNVZL6Ulb5kSkDQzh1kM5sPduNt674tKZYJcDdeM0eIXQWrm9545zz8a18tJ2
         HHJsRCohS/W4LjylItEr5WiN3TUgqCQZaJ8MEWfx7XaHmE8G1jDAeDbeQDMteSERSBXp
         gReQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773314560; x=1773919360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3QaJgk7QAOL/LIy3ichchEWU1Xnqclfz0s2h4tb2vhk=;
        b=jxF7SZ7LkBa++80n3E/U1Exi43H4ltZXISsDx5Ep0Cl/3/5Zg+Ob0zi5P5YKYAmPMM
         Wyql2kU2mCNN1s0BQzirlpv0AWt2DtZrYYiCDsLpTIJgXiuEUUliDaourRGmVL0UcdSw
         B5OYT9U5GxlGLepU2lTCCwolkim+f81ky7wOidjYLXbV8MLJ4blPnFqAjuApp6uXxal5
         j6jynGGJVHYaCSsUBDyhMWP8chiQNC86xBKaSQHubGRInfxSQraz8oITKwKzELSPK/uu
         A+KWLAYXhKS6cR6eFrYAdGGFom988LJRzCKSiZpGP9vhJlQgWXxDNt+dDtQg2FbdASSV
         ho1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773314560; x=1773919360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QaJgk7QAOL/LIy3ichchEWU1Xnqclfz0s2h4tb2vhk=;
        b=c73u8fpAAzf6+O9QSDfpmTe2iSj60krfUSqmY3e7P1pxjK6FQlHcp0vR00+0uDjwio
         yH45uO37EUDq7DHGo+R4BBBMLgwuGm4hTLoH8Rk/UK5ROQ7Q/hFW0rQz5GKTGmSnmXq+
         aYvXvrmP7B5/QJByp7d98lUKGHN/Rshpm6z/ot1v8Buzo/bePSYNrMbrbvFDUdJ3/QT1
         9G1Kf9JXAfK4BpkDXfU/uxynOhfC0btJ04kttnGcdmJ+1ODKg/FhFJWjTK4ToJyxx3H0
         tJXxvK1v0189zdhsOFdDu764fvP4SL6qxTlpnVoPmPHeK5BEH9Ga15As538pIrYeDCS8
         L7ZQ==
X-Gm-Message-State: AOJu0Yx4ZShEuX/mVhi5897g4FNlCUB1d5Zl2FtFLjKEsj3H+TXVMo85
	Qva/eJXOtaNlMgXGjfOM2rmQWrBD1VP5u5M5zNP2GjTg+Ht3aoeRXR0Z9v6xTeBe+WBGFq17+bt
	EI4sIdW66xl7njCDNWi6XfoaOaWKSP8Jv1UKfIwc=
X-Gm-Gg: ATEYQzzykWpzie1RvGZplRmDvi6jlA+8JoHLEshrooWfqIqlDIFHH6sTjREjJH0GkU2
	GFyH8+fDEviZlcQNaQM2/m3n/PZnOOWQKZqLVbrjrNn6sqfSKeIj7yl0ViqPc6MLLIUoF79N5Rl
	zDtNUmtd5AlCB03gvHabcTtS/20PvjIL2YEI3/UNLbignZm++yT3zJcJWORv4etSB3q0nW7GmbM
	j1tB2rE/6BhOK9HH6xt29fN/f92Pk1vDiTLEdafWZ50qJqSH2jPh18khSF+QtAp8PK5ZgVSQ9RU
	gnXeqqMQ2hxU6LJxQqtrJCUpDjQfeloGKEj/pPrxrA==
X-Received: by 2002:a05:651c:2211:b0:38a:4234:f717 with SMTP id
 38308e7fff4ca-38a67d797c6mr21310041fa.7.1773314560053; Thu, 12 Mar 2026
 04:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310133504.94871-1-danjwade95@gmail.com> <20260310133504.94871-2-danjwade95@gmail.com>
 <186af6aa5189782f9975d6572751f0099bd167db.camel@gmail.com>
In-Reply-To: <186af6aa5189782f9975d6572751f0099bd167db.camel@gmail.com>
From: Daniel Wade <danjwade95@gmail.com>
Date: Thu, 12 Mar 2026 21:52:28 +1030
X-Gm-Features: AaiRm52UtffWV7jHlTEa8J7fKvTT_AH0y2p1UtMTCAick6HSSv5HeE4NXrtJTRU
Message-ID: <CAMn7ay8WREi-gvNKX6iLc7EszAVPFCJxR7gLSouWg72McJwR2Q@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix unsound scalar forking in
 maybe_fork_scalars() for BPF_OR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"

Agreed, much cleaner. Will send v2.

Daniel

On Wed, 11 Mar 2026 at 11:27, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2026-03-11 at 00:35 +1100, Daniel Wade wrote:
> > maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
> > source operand is a constant.  When dst has signed range [-1, 0], it
> > forks the verifier state, setting the pushed path dst to 0 and the
> > current path dst to -1.
> >
> > For BPF_AND this is correct: 0 & K == 0.
> > For BPF_OR this is wrong:    0 | K == K, not 0.
> >
> > The pushed path therefore tracks dst as 0 when the runtime value is K,
> > producing an exploitable verifier/runtime divergence that allows
> > out-of-bounds map access.
> >
> > Fix this by passing the opcode into maybe_fork_scalars() so it can set
> > the correct value for the pushed state:
> >   - BPF_AND: pushed dst = 0         (unchanged)
> >   - BPF_OR:  pushed dst = insn->imm (the constant K)
> >
> > The bug was introduced by commit bffacdb80b93 ("bpf: Recognize special
> > arithmetic shift in the verifier").
> >
> > Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the verifier")
> > Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> > ---
>
> Uh-oh, what a bug... Thank you for spotting this.
> Let's, maybe, go for a smaller fix:
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15999,7 +15999,7 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
>         else
>                 return 0;
>
> -       branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +       branch = push_stack(env, env->insn_idx, env->insn_idx, false);
>         if (IS_ERR(branch))
>                 return PTR_ERR(branch);
>
> Just to keep maybe_fork_scalars() more generic for potential future uses?
>
> [...]
