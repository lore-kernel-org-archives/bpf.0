Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DDC1E49F
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719363; cv=none; b=ukgmlz2fEvv+prvr6X5zasgEDYGRoxB88yiaaTrQN0JoWP0rO7vkoixDmDfFu4GTavGeQutsKeVQPcmL7mOWwhYmcwAxOYdlqdXkPvA3Y6Fuwu77AbXa/JmRTbQywSJ5GflqC+gUmNVDJdzKVUi/UDgnREh79HGLioKc8NVlTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719363; c=relaxed/simple;
	bh=bgz9O3COzJWKZFYXwI62/DT5ZlfVX6Tgi6hBu0rXcrw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuKbv1b2eAKz79op/PywR4IHJtNPxw3l+WgEq1V8hHFHMzRONQGnusM/ZVuF1IrtGh59cFrzKBzCVuRMKXmY9EDvzmag5wanqGxwDdZvBz10ne2GT5YNfTVyQw4yRppgPXyVVi8ELP3Yy23oWIQDcncNGTN8rCC5mpAhf4q+4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsE3v7bz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsE3v7bz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b935a74b7c2so1098651966b.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719360; x=1773324160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5F2Z+dABDZHtAocG8UHmP/srpFxbX53GysJp892PCRw=;
        b=YsE3v7bzsnqC10TfBbG8Q0tFIIv3TqE1IZ1+yMT/zNN+5jZyxKD9yPYQZDkIwNikZP
         k17k9lR0oOL+Yj1Nxm2WJRqR74wS0Nf7r+xa7K99HRq87odiuIAZsG/97gUJzhUacmr1
         jGIujweIaqVKcD7tTxNL3j/wNU65dmVsDfE3F4nZX4t63hrB8sY8XUasItuetT3aRK81
         2ztD3CLoFDY+5hPY+yhIF8x+9OVZ8QsQEVAkjOYbwLLijycNpYGphhg885CgXeEQigsl
         TH3pr4O8umqBXCqYLtg5r+Aq5hx1xEgzu+pGB8g+tbP1pQvD9UL+oNba/rxwmlrAg4kn
         9KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719360; x=1773324160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F2Z+dABDZHtAocG8UHmP/srpFxbX53GysJp892PCRw=;
        b=C/RpXDnRFkFEzLQ/e0fvA6bJML7C7DnpFuq+pyLoYFj9+YTCXV7/gpE7PRwKtMECRR
         ns/iBAHtpxkZiZ3w2q0tWbl8Rd/DPYZu7TkoJ6hQPmvkwe0PFkSYT/s6iilsXALUPa4L
         kCs8poRmrIBG+4aBXRdeJd8i0yQy+/31BYYFRdl3JRN79rlrAx0qn1Vj4YcE/yERW/hE
         dbEVXl+47bEPXL2d9gyapOdbeAFFZ5BtS5malFRnqBgEHl3X6J9R1knoA4wMpLNXZLOo
         pQhCnqNHE7P9skvvBBnh7oBSkp2EtqrzYsb5Pc+JTD0PJQm/jxObVvZI5o4Nhtert6mu
         anSg==
X-Forwarded-Encrypted: i=1; AJvYcCXgOBo5LYFMlEEP+NiZyJ2I7o5v0h8xoZbxWxECjEbMWmbBd8uTvGcIDJfyK2bulHo28Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSr0SaEbwVt8lmDKgGwNwzr/t6oD+9/2e4O6MDXnJXSHFniSy
	fEFdzfDXwoM3WX1ZYlLfMMeuKPmI3CrcJRO5DMxr9xryQAV+f9OkPYxMnEdjpUjO
X-Gm-Gg: ATEYQzzAi2TmGhJJ/O29zuvpXZQZ5mPRQ6p9SSVJOZzgxUYXqPet04icxBtqQPKhg0N
	n5ST5tzWiuRA/jO+wgv0qlvlexVKmnFqe7+31IEWWUHGspQp7MCz/SQBHCbaelZZcu2TyebGKFm
	/4ljtFb3PQZ+uzdJsxISgY4lrV1uOcwa0AStdkAangEO95h9DJ//8BXMQ2hS/bDJ93hQgdI3fQX
	z0n+XQ9cAzaZ+uAH8bYsaOcFWugUw/ma/QXDe9XSAvMsPllUraG+BOxgiFfVbUB1S7YGR/FEsX5
	Z5Ec7f0zAUfHpt8Etf+UiF2d52l661/7Zm8L/2TEVK5h2GS1HUIe76qo7sOdD/UleQVOX3p28cm
	TM/NRNpnB0wlmLTipthVDQ4oEIY/El//nEVcGRmjUVkrTpfLvtbSyN1/VXwLxLCb+bAAVGH+H
X-Received: by 2002:a17:907:e895:b0:b84:40e1:c1c8 with SMTP id a640c23a62f3a-b93f14dba47mr407420566b.33.1772719353405;
        Thu, 05 Mar 2026 06:02:33 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503424fsm35859009f8f.22.2026.03.05.06.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:02:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:02:31 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 06/23] bpf: Add multi tracing attach types
Message-ID: <aamM95ydg4RFY-MP@krava>
References: <20260304222141.497203-7-jolsa@kernel.org>
 <90246a2d7a691e7374b18d699e0778f10b750b85fd0739d485c96960925a822b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90246a2d7a691e7374b18d699e0778f10b750b85fd0739d485c96960925a822b@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:33PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d92cf2821657..832a87da5a86 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -25173,6 +25181,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  	case BPF_TRACE_FENTRY:
> >  	case BPF_TRACE_FEXIT:
> >  	case BPF_TRACE_FSESSION:
> > +	case BPF_TRACE_FENTRY_MULTI:
> > +	case BPF_TRACE_FEXIT_MULTI:
> 
> The new multi types are added to this switch, but earlier in the same
> function bpf_check_attach_target() there is a check that prevents
> BPF_PROG_TYPE_EXT from targeting fentry/fexit/fsession programs:
> 
> kernel/bpf/verifier.c:bpf_check_attach_target() {
>     ...
>     if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
>         prog_extension &&
>         (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
>          tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
>          tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
>             bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
>             return -EINVAL;
>     }
>     ...
> }
> 
> Should BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI be included
> in that check as well? The comment above it explains that extending
> fentry/fexit programs is blocked to prevent
> fentry->extension->fentry->extension call chains. Multi programs map
> to BPF_TRAMP_FENTRY/BPF_TRAMP_FEXIT in bpf_attach_type_to_tramp(),
> so the same concern would apply.

but multi programs would never have tgt_prog/prog->aux->dst_prog set,
and that check above is under 'if (tgt_prog) {' check, so I think we
are ok, but I will double check, thnx

jirka


> 
> > @@ -25202,7 +25212,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038

