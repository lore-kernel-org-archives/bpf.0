Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7022D792
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710596; cv=pass; b=G0oY57DMeqMaurp+mtlW5YgA2Gc+n2yJR3IU211/6xOQ+l9kxu/so48dTmj7pkp15ZyM5ALWX1kW4iXQqQxxcySuV/txhAlq9OEpVYVAFHl//tsKqrN2NyckDuzaJ37LDv2HXrWpn5/41CW5oO0Yo5S0PUEgv5zphJHFOe14GQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710596; c=relaxed/simple;
	bh=+fuWPy3vD/dypXRFlkLZYzrfqQCaKjZVoHHIvzbAUs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fK7UBQ6SeIGdY7mU5zbbNDdVzuSN7kDtpILpBkN/ZEVRjdkZ7quedWAufTxOH75ipVt3iEV4DUzXkGm2coLYa//sWaDbVIQtXOhoSzuEd7nql1txhEz2AO2SO8bNmQhX2S/7/XyPSxgXE97rU47t/m7KRnHj+BD2PA0W8rKkQGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEecjnXy; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEecjnXy"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439c56e822eso5378093f8f.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 18:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773710593; cv=none;
        d=google.com; s=arc-20240605;
        b=F3uHlDstXgQVFgb2oioL25sGccyot4ym1ToSC2UzVELrUM2QL2mPBk7Dm7ICdGmSRM
         Vmq6md3REwZXQ0NBbl4PFacqsEDghXNdF5WScIIusQaaodRHzoIv7oZjR2knBcPr5idm
         UdD6aONQn9URGatx7Sf+cJKcUZ1O2U0+cPsgpsYMhtyFN1Nfj+sJINZCp6L0Gj17YLx/
         Ah12biXUHPkAbUWyk/2HcT8atJ284L5HNHQLzOwaeGMqOwQ9yjjLLF4P1O/F4LPWxliM
         /h8Zb7oaa/EdFH52SUA12sUCgpGw5nPSfTJzQJlvi8+BXMm17rmyq72yzTEF6FRohgy7
         ispg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/v1tj/nhweIdNI0/ZrMKvn4j/ujNucLSsS1v/ZSxCb8=;
        fh=wFN3T5AdikUT1rE4J/DCHHDF0hVKxgRUrz6iXuni5ZA=;
        b=lP5/JoBikFI7dcKbL6ueSOnp+CJR3qraqITc5ROdQ1IEhhzzSs2cSkO+3/3ocfm+K1
         8zfEKBpJmeBKB7/zzfjwAYlBPWwflrVWWzzA+3KJU2LSS3zhaK9KhyNqfno6uaUFTsda
         quA+mY80MXWmZON4gKBwWbUz2TigzMEJ7T/jWFTkKtk1ZhOsFODu2k/k95+CujEPdiAC
         0n6srUHKFSZz4ehepYw6LVDS9c1QeovhN7WvFZ4r/uRXafcVZDwfHV64T6NaVLyC+iL7
         8KX/Y87MH+gsh6w2RaOiSxEdHHg+AwJwCPB7+4mbvTwPBZAELaUZujIEfLb50BiVJjlL
         cmdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773710593; x=1774315393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/v1tj/nhweIdNI0/ZrMKvn4j/ujNucLSsS1v/ZSxCb8=;
        b=NEecjnXyOn6n5y4XuT9ih/pSx4eHox2lk/Fsx25gtyHvbgbu9AMHTgP66VZfpor+qw
         gWUHp3FtnpbWgz+9rxxKVRUym2DtEA9TExFu9Gi3LVOItWZmmg83jWMyAqAwQsA/De1U
         7lcMQhAuA+xHqIPmsVnOcNMwYoWHrh9SrnNF6s+dilynSC3NfBljZVgamFc8CorNckfl
         zDmdTa+OxaiLNn3S0eqeuzEycInTp8hq1erAI6O88uHQEQkip4yP1AG97GlB8WaPL0a5
         82wCNNWwVZqiHS7M2fyT+RFLN70rrHh0J7MO2PYe8sS0MoMVoRaDXeZ/0b55cNdeskrg
         2p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773710593; x=1774315393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v1tj/nhweIdNI0/ZrMKvn4j/ujNucLSsS1v/ZSxCb8=;
        b=VehRQxH3tGQMgzhVeT0tTXslo7hR7ETuI+ELBnu/nfU2iIdjXeQacTnP3w5E2W1OJa
         rTMD4jhiiuQu7IauRfRJNpxHUJA+C2ZY4aZ3Ln4Fj0dWpIg0Dyj3+IRGMpnvT3BaW5xY
         2gNi3nIjeNUw4JYcZzEc0qQ+yTBz704PeEobOHyimy3IP0aIBw4vj5JngmN4U0QYZx/S
         g1+/63TG8rqMvQzHmuVEXv78/fbsJ/uahZTs7ycx/VnXC7HQ0hhgnfn8oS1STbW54LeW
         KX3ZKlmV1Lnm6XT91ZZERYXVydmsaFB/6aBDECqlEyAQBReREAdOSzuQtSFIkKBkqFNw
         Qt8A==
X-Forwarded-Encrypted: i=1; AJvYcCW5Ho5JU0k5i1JpsOPqjEcfZ7xZUDn8oJ6MQ7k8GZBDcRy1pv/pgDwagLEyPYwtI8WDFXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsRlot9ipy9MYircrd9YnO9E58PuR4DUCYWiAm+PqRfAEI4t1
	xCzHE7vPk81p48oY6ou1k6hwibLd2/0xLmv9hrPdLBmuXgLk401Tg5nP+lvd+ptW9Ty0joc+yr2
	Zew+hl3KgHimDnDNp5G5Eu4LYxHnWFkM=
X-Gm-Gg: ATEYQzzYSDI4VqkTqiZ2hICuz9BjRzPCyRFgrDL10gdECMvsA9AU8soOXvWWVIyLomq
	Acc7LcWbE4ynx2g8yrAmiPncBuOe6bhAlczLCBLb66tlV5chZTtCzl7BNA9Lc0G1VRxjycR2B+4
	9OXfph403fGFPvT7di5hY0vM1/xKcKs1w6F6Ms0RZoORD6shZPhG1gwHqt+mQOXHwN5vygWSJBC
	DdpzvF8oj4o3H2ZzDbxuWobV+kmlvDSiJUcm/H5na9egdt8Q3l6JljOuGXEkZg9yBhCKTWVTbUA
	8I7fov57R5BORKl+nwtFp13XyY0OoBbjRww1jmREiBCaWt+ZE3Ig9Go3ot0=
X-Received: by 2002:a05:6000:2903:b0:439:bd70:610f with SMTP id
 ffacd0b85a97d-43a04dc0893mr27674110f8f.44.1773710592796; Mon, 16 Mar 2026
 18:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317001325.318004-1-ihor.solodrai@linux.dev> <cbc753d17a4e0037aa7e0711ef6cd3a34e7e82dca5a3ef445b7d78af51e5a1cb@mail.kernel.org>
In-Reply-To: <cbc753d17a4e0037aa7e0711ef6cd3a34e7e82dca5a3ef445b7d78af51e5a1cb@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 02:22:36 +0100
X-Gm-Features: AaiRm52CHIpF6SuiHN_g6mlO71LqJVlGwsbmmXjpVnE_FwgIxPajrTHAV72rQUI
Message-ID: <CAP01T77-BHTSLrknnqRgpJ89snWKFBGLOmgxuXQhzqUSj731fQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix exception exit lock checking for subprogs
To: bot+bpf-ci@kernel.org
Cc: ihor.solodrai@linux.dev, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 02:02, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20911,7 +20911,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
> >        * state when it exits.
> >        */
> >       int err = check_resource_leak(env, exception_exit,
> > -                                   !env->cur_state->curframe,
> > +                                   exception_exit || !env->cur_state->curframe,
> > +                                   exception_exit ? "bpf_throw" :
> >                                     "BPF_EXIT instruction in main prog");

Fix LGTM. Thanks.

> >       if (err)
> >               return err;
>
> This looks like a bug fix but appears to be missing a Fixes: tag.
> The buggy check_lock = !curframe logic was introduced when the
> inline code in do_check() was refactored into process_bpf_exit_full()
> and check_resource_leak() in commit 2d419c44658f ("bpf: add fsession
> support"). Should this have:
>
> Fixes: 2d419c44658f ("bpf: add fsession support")
>

The fixes tag is wrong. It goes all the way back to f18b03fabaa9b.
I was scratching my head for a while, since we already have one test
to prevent this, but it turns out it's broken.
If we look at test reject_subprog_with_rcu_read_lock, it made the
mistake of returning directly.
Since the throw validation wasn't correct, the error instead comes
because of not closing the RCU section and exiting the program.
If we do the unlock without returning directly it starts failing
(i.e., unexpectedly succeeding).

I would rather change that test to fix it here in this commit, then
add more cases for IRQ, preempt lock etc. around it in the next one to
increase coverage.
With that the commit log could be made more clearer.

pw-bot: cr

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23172639489
