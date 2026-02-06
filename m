Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633D2EC0AA
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348299; cv=pass; b=e/h/bw3Didk/ur1YxLg8SC9zMSXEYaD1gfYgswi0UnJ2TSZ4KIaBVc2Rv0rTnnmlXhY7OfY+nda+3blPBzMWtrbTy8ldAFKkDuyDV1GNRXyCmG7XiEBq1NPfR2i2rmcU1Sm0R6DL2kUq8OhiRGaqP6ncc1c+OhT+vjqkfuN0z/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348299; c=relaxed/simple;
	bh=lgpV9ElA2iLclZTi5fktRlCFSso5u2tx4mI9BKW5jpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/Bj+Yg8NHA8DVfH/uSXjaGge8I3/PF99+OGk5jaAaLb1+PKZeCOgTwOrO/QbAZjKfLqF6uIermsD9VXTmL5JG9XfR0vwo7gI8RElJwaigRF6eZvs/OcH/fjy3Y2rF7pEw0aaw3MAWVpTze7jc9McCwP0yO+KQbasl4OKX2fEqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BAwKgrq7; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BAwKgrq7"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64acd19e1dfso63240d50.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 19:24:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770348298; cv=none;
        d=google.com; s=arc-20240605;
        b=Gxs9NpG0E3eeBZVGgUCTBFr+xUxYPytz/DbPzeAbpAuMzqLf8NoT4edTyjYyne82M3
         EbmxbZGU3NtgcsfYrnN5d7X+X00nMdU+JQ6bH5jva7qJChxx4ibceobJDmPvHKhTcyEK
         UEqi9k600vcACqc9j18fHdkBhhoVUQnEltoMJyGn0hhzcMAXNMgAEgdaOx4jJrh8MYkV
         MchcYdxIjqvyhmH9X+yr05dEhQSasjkhRLKSrtNnQdtMOFJRLT8qk8QyyPHzaH+hMf32
         e4bOk3SW2F0N1Q4ijS9vtIyJFr4TaP/cP+WJbesQXtLfzhj/wUZyvCplkjPBS0QBgd7f
         SqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IYpfhHnCqzmTTxN+oFmlvmFlw2cTV/n/2cenyzT/W0c=;
        fh=kC99FKnv2unmkJ/I4z8dq9h3Vwuy6XnSIWKCxZMCrCY=;
        b=D+yyC9mFNvL9/FkPYIKm3UWuIy5PW4MyxxdiFwuD6D98jGGybztN7m83xgVPHSLXfm
         Ulq5VkVCWd8KauoZ3TUEVg7RxJDoXpc3RDxlkWoiy/0+ILS6eeRWXJzkWaFPdxgWO9mk
         kDtTVCbARJF8aWpd03d+XpCU+7Ue7Le3Cs6H55iPrn+dnwnrUztuC+hWQjwBjA3poiZV
         Ee/tT4NDaE99zTqPtzbJMi14GTBnMGdV6HLbdr1+VmvzZl5E7rFE98P86m49m5kQmXJ1
         l7sN3Eq3QfDTXOjGi7f0bKMLjHofRtpGBBX+FRm6BkUCs75qOYmb5gA/mSAxvlP4h1Sz
         yacg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770348298; x=1770953098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYpfhHnCqzmTTxN+oFmlvmFlw2cTV/n/2cenyzT/W0c=;
        b=BAwKgrq7I7KelXwu+vRJXIeMevvtIED4aTqIQmyi9mICFBKVYktYRgLYOJoNRj9dds
         PbwrcUULObRb5CWnVREKDSsjQwzBezweCrI+y27wFTJrUO1NsmYuLnberyjbI6wjyNG3
         DRnTk2GbpKw06Ccmq6Kc+WZexR9+exTBxALjmPJJgoyqcblGcnhzutT9hY62u6mbMrvc
         dilYHzv8AINTER9xdnsyF0XHjVjGDpf3854BYsAULyle7tfkvjEmYtDxns0iVbksJbiD
         GsOzhy6gDKQhXnretDRC8yxdvisJmNxyZZlP7+5+WAt3gfzOPzSP7UXaB2OX9SPxIkrZ
         AHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770348298; x=1770953098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IYpfhHnCqzmTTxN+oFmlvmFlw2cTV/n/2cenyzT/W0c=;
        b=npUQVXdVjtTV8OhHgrRYMGPCQkyxA2tM71uDDkv6mqMiiCBL2oJNDMaRWfGJ0YDE9A
         e2Huy6jFeUW70vLwOlrYTOO2Z/ThLGim7Xf1EdVYqAXRjJiaYDGfqRnR8DQI4jZMV0Cl
         dv1Zxynr+R/Hbs3yWW+jE+0i+jzqYD2n4EUHPqJofsI7HI6roDd1fFQIfBQq4pn0ivMb
         EY77T0VCul8n4vRAnDg1rUS9Nq5rP2L6sDuo+l7CiyWilq9CGjjfQmbW6BAuC6NSxseL
         5h2Zs/ZMElEtppkavsdf6qTmnWl7Y3WWJ/QY8CQjdNoydAOBauI7722vXmpDzCUgK+Bi
         HvnA==
X-Forwarded-Encrypted: i=1; AJvYcCX0ejTEyXx9hmoNxJHbPkj0BmuFNqMcPe7BpnB3WJCG6FFtSb1AzmH+QqqJX7aBd2rKrrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVNEFD9CX2QmJ0ghnZBm2LmAKb3K71/uemxDd4RAlNWI5kp5Y
	zqSNwY/RTQmMV0B518AjVgM6tBTGeimaIXTGwejB9RhJKzGHWLH2+y7X5NZNBE/NOjSgLMMCAJz
	BLfgzU428KD+mrJPR/Q267cKIeeL9MdJsFDEaGGRHpQ==
X-Gm-Gg: AZuq6aJo7wwkOegMfL1aSh5NX2GWL1TJSY7TANORgoXjD28f9s6IvGr4ANtyAbGYdws
	9YsNxHeIIRmp6tNVer0PbA6tt5+HENuKKvom6JkVDOuh2oP5fTIfYUrL9jlL0CV2mLrpFNrmNfP
	O4o9E5lvxS+acySlt0eTis9QAyI1854msj1GZxtEODsoctZ61un6gqAmLk0zbRzKUEMBnUhfOeU
	zg7xmGMQcZO5ez7jPR9qRbhrXSTitNfUQ2/v5bu3J/mr+lb5k++hGxec1LTWQIUQ0NJtKqU4JnT
	94x+/nG4cmE+1WhVJpAl
X-Received: by 2002:a05:690e:1516:b0:644:46c8:b990 with SMTP id
 956f58d0204a3-64a0b8f91e9mr865976d50.32.1770348297727; Thu, 05 Feb 2026
 19:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-ivan-bpf-ksym-cache-v1-1-ca503070dcc0@cloudflare.com> <CAADnVQLaGNF=QypjnM1pJV_-49D3AXaRLpvCb31ozpg_39GO=Q@mail.gmail.com>
In-Reply-To: <CAADnVQLaGNF=QypjnM1pJV_-49D3AXaRLpvCb31ozpg_39GO=Q@mail.gmail.com>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Thu, 5 Feb 2026 19:24:46 -0800
X-Gm-Features: AZwV_QjaOJR4Zyg8C3HSr9JY7EkYTtzBzqgIx7-1WlPs6fnm80e2BOE48S9fMcY
Message-ID: <CABWYdi2TxJb+GUqiEpgQORnf8-ErYaPJHzE13oMKsL7bL4_4nQ@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: cache bpf symbols to avoid quadratic iteration
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Florian Lehner <dev@der-flo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 3:11=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 29, 2026 at 8:50=E2=80=AFPM Ivan Babrou via B4 Relay
> <devnull+ivan.cloudflare.com@kernel.org> wrote:
> >
> > From: Ivan Babrou <ivan@cloudflare.com>
> >
> > The existing code iterates the whole list of bpf ksyms until the right
> > one is found, which means quadratic complexity on top of linked list
> > pointer chasing under rcu. This is't noticeable for most installations,
> > but when one has 10000 bpf programs loaded, things start to add up and
> > reading from `/proc/kallsyms` slows down a lot.
>
> How real is this? 10k bpf programs?

Very much real.

> >  static int get_ksymbol_bpf(struct kallsym_iter *iter)
> >  {
> > +       unsigned int index =3D iter->pos - iter->pos_ftrace_mod_end;
> >         int ret;
> >
> > +       if (iter->bpf_cache) {
> > +               if (index >=3D iter->bpf_cache_count) {
> > +                       iter->pos_bpf_end =3D iter->pos;
> > +                       return 0;
> > +               }
> > +
> > +               strscpy(iter->module_name, "bpf", MODULE_NAME_LEN);
> > +               iter->exported =3D 0;
> > +               strscpy(iter->name, iter->bpf_cache[index].name, KSYM_N=
AME_LEN);
> > +               iter->value =3D iter->bpf_cache[index].value;
> > +               iter->type =3D BPF_SYM_ELF_TYPE;
> > +
> > +               return 1;
> > +       }
>
> I'm sure there are other ways to speed up get_ksymbol_bpf().
> bpf_kallsyms is a list, but the same symbols are also in
> struct latch_tree_root bpf_tree
> Integrate it into get_ksymbol_bpf().
> latch_tree_find() will be surely faster than linear search in the list.
> Or go the extra mile and implement an iterator for latch_tree.

How do you feel about Florian's (cc'd) patch here?

* https://gist.github.com/florianl/41e2bce29ffde797536eef9b2e47ba92

I can take a stab at using bpf_tree like you suggested, but if you
like his patch, we can just go with that.

>
> pw-bot: cr
