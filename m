Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB12F8BF0
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349616; cv=pass; b=EMTysWcOFGP2z5QkGnYbEJ4zyJgpeSu3SWmNmDzB/Ry+mmwoCPzAjdOb3aPa0c4ol+9bUJd0oZH+jUIDzRP3tAJEBIBhGc/hVvJOQ6zosXDnpnsHCMHqgPfhLFvafzn22ir23VGa4IOAt4fNszpui8SDjHbLdj++zhteODffSyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349616; c=relaxed/simple;
	bh=2cBhd9lQQFTMlzQz/t3sp7Bzeku6tTRVne2CHRq+dwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBu/J52VpAb37s/45i2FujCUbrCPh3j+/teMUvZXea7rqX7udQMwbE5MmFO7z11C+b/Hac5m9I3N054NtJ9BCHr4jWJ499sCmI14at9YMgAn4poDXRDZsuGjmJ3N35MKBsSQ+TzOmc8ovsqM2tyGvRp5DNzfKbEhxljf7c+/yDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azb7edeG; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azb7edeG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso16800075e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 19:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770349615; cv=none;
        d=google.com; s=arc-20240605;
        b=LRDnbI0rNLS6/WzqbZdLdOphGsd0VTxaMTlUSbqSCzb1tLeQwB4gcIteG2AUa3NfCX
         gVelLfnFbCD+F1a5/X3mIkDv4r2pcer0IXDuT4nVA7LT0taWg0MW5DUGfDH1TqHiCKCG
         EqiyEX9opLdye491oLHwV+MqVxYuzUNw415zcv5aIDDL/owoEzUB1LVUPxb9/5qN46ZV
         B8kKbk5//u7n+YErOtOsmc7w3tbHhalg6GMvQbExIq1OCYNvCbYTFJpWLpLF3POQzGB+
         FsWHgP8BN5OoxWUs8Ef/kRAvxCiCbf0wcIvj1yqzBrVJ3d1OyXaeUfsfvw0hSEm4eQbt
         VjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7NRHTFX2qkJZ2rt6gB1PRbHG5DRVceO/SYGhCSOeVsA=;
        fh=Go7kfgOO15zwSLAqKjxpjhsa40ez+ZN29yDWz26xqmU=;
        b=JxdPaPYf79qVIqZrmU4uXnWKdLt8yJziMbojPKAx2HLHNb5hvS2oKkV5ajk/r7Pwiu
         5jNZT/f0Q0Zr3BWIbpuqnwunRs7xxk4cKHLOCxK+tUjrAhsy258g3Oqx7HapHZGniklO
         ocwVkr+/7rZmRwfdrjvRT40hs4c3dt2QwWMF6XtF/WbOFc8pBy+unDzGPikGEV2tXkW8
         QU1+JP9+euZ0FOB6UaZYm9yTamPe1LRuKccWNa/OqD95nmM6RGgy/9Q9wGqJhhmbyNOR
         geimKpKuqRszk3EYruwTo/sIOfgmSqDxg5vSg6XoQF5XK7FNBSTEyI9cOi9iZfBt6SEI
         1/Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770349615; x=1770954415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NRHTFX2qkJZ2rt6gB1PRbHG5DRVceO/SYGhCSOeVsA=;
        b=azb7edeGSCKx21lMX7fAvQgNun3na6n/wzhjb3zRkvkUYK5V70KBPNEoDLiI/IsCTJ
         WlnRg0g9I5rToK1O+GjcfGJCQrURCGIvxy9w8uuLG4wyfeMDUyrf4ZAWYq2qslvTxDa6
         4TUZ47M9BNxkZ1HuSPrZh2jhsdvWxtqaAW5j7/z60J+QCPK2tryjrH7lY9VotI2NXhnS
         nOIdkWBu4kGNDhSvzsJjP1Ku/N8sPV1PlNavxO9+GkvOAZACq6JA4jPBWjVShR8qUP+3
         SjdoJ2SWHkQI16SpilCBqKb55KIiYk1/MPMxu0HfiRrZ4zS9YHOU+ow7L5n2cjsoCdaq
         EsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770349615; x=1770954415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NRHTFX2qkJZ2rt6gB1PRbHG5DRVceO/SYGhCSOeVsA=;
        b=kBWeXTcBIncq+mgi5NGpLCnFHQwUaSsU335AQkwW2l+lNx7F6THrm0zcycSf39PsvG
         gQFLeMx81aJYs01n2QA5dK9RadeBWA77aRtPJH8DGUwb9cwOdPcELkG6kW6ohgd1Gwwc
         frdGsgV3jIUP8fk/ZuvQZ4DQjjcm2fXB9rqFuu2B+Oksahl3tMWG013U4y67G3NjTaQP
         iyV5nRl0Rso92roXpnbiPuMQ6JTIIHigRG6DhqMkpDWwp1Vx47HpFD3/OJhFqUrABQvL
         1miXUIYyFaQkfz7hQOyjFM1D3L9t73HWubutgR0Gw3xlnZnt3A9TEXqemSauSU8jG3nC
         hGMA==
X-Forwarded-Encrypted: i=1; AJvYcCXNxMNxPO1cz3BHrh43ElPJVSPXJBzLrH/+0vPd5FaAbID2RWcgiblgFqZlJbbLcvAj87c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV64iVh3lbDxcqTFTPmVhuAzqGzub3kMG5w6qubnQeTmm8o/k+
	hod94LX+fAtZYwcOHX7uLp+rrjR+AN3bKCfHy1An+UyEiB49wymsoawmF0smVYUOGKEA26fS4om
	OIoTGcT2V6B2iNiEm6FH9wzW81URtuK0=
X-Gm-Gg: AZuq6aJeZjeboQi5RNMTSaFRv6MpgZBTy+IoYmJ2uT0OlKHtrVUe+f33RR6BkK/idXf
	2rfGeIg5gMv0RsqZMapr34diWEe5N8OVTk4VtJoMJL6mIsoLO6GRtVJgCfPCslpGUcbYutBjcXe
	MTmagkD6MsThpX/zcbI7H4nnY4xiGWW5sCEQMII47iGwZYuN2JD+Dl/U+ceW8bFEyDWrExCpAa+
	zZzPI4TAno6ugi1cT1GVe831bQNGvtP67jheCHuHgpWEOrFI1LTCjm99BtnTKFMqFybJVbpX5Ht
	geqTtUmQIg8pFSSIZUT6LukotW+zCLO/zH906E6ehTs9QhdyZLaKfYG8
X-Received: by 2002:a05:600c:8b61:b0:47d:3ffb:16c9 with SMTP id
 5b1f17b1804b1-48320966711mr11809005e9.23.1770349614725; Thu, 05 Feb 2026
 19:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-ivan-bpf-ksym-cache-v1-1-ca503070dcc0@cloudflare.com>
 <CAADnVQLaGNF=QypjnM1pJV_-49D3AXaRLpvCb31ozpg_39GO=Q@mail.gmail.com> <CABWYdi2TxJb+GUqiEpgQORnf8-ErYaPJHzE13oMKsL7bL4_4nQ@mail.gmail.com>
In-Reply-To: <CABWYdi2TxJb+GUqiEpgQORnf8-ErYaPJHzE13oMKsL7bL4_4nQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 19:46:43 -0800
X-Gm-Features: AZwV_QhqOIXC0XJIF2bqWPEHo1NfeZcJAPVZZ1LOIbGBVjS6WDzeBshqi1q_ygM
Message-ID: <CAADnVQ+NJSjQQ7VJ83NohEvfkKpPhkAPKerKHgi3m4tOQqK6yg@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: cache bpf symbols to avoid quadratic iteration
To: Ivan Babrou <ivan@cloudflare.com>
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

On Thu, Feb 5, 2026 at 7:24=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> wr=
ote:
>
> On Thu, Feb 5, 2026 at 3:11=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 29, 2026 at 8:50=E2=80=AFPM Ivan Babrou via B4 Relay
> > <devnull+ivan.cloudflare.com@kernel.org> wrote:
> > >
> > > From: Ivan Babrou <ivan@cloudflare.com>
> > >
> > > The existing code iterates the whole list of bpf ksyms until the righ=
t
> > > one is found, which means quadratic complexity on top of linked list
> > > pointer chasing under rcu. This is't noticeable for most installation=
s,
> > > but when one has 10000 bpf programs loaded, things start to add up an=
d
> > > reading from `/proc/kallsyms` slows down a lot.
> >
> > How real is this? 10k bpf programs?
>
> Very much real.

I'm sure you know that each bpf prog is at least one page.
So you're burning 40 Mbyte minimum.
You need to redesign it. There is no reason to replicate
the more or less the same prog 10k times.

>
> > >  static int get_ksymbol_bpf(struct kallsym_iter *iter)
> > >  {
> > > +       unsigned int index =3D iter->pos - iter->pos_ftrace_mod_end;
> > >         int ret;
> > >
> > > +       if (iter->bpf_cache) {
> > > +               if (index >=3D iter->bpf_cache_count) {
> > > +                       iter->pos_bpf_end =3D iter->pos;
> > > +                       return 0;
> > > +               }
> > > +
> > > +               strscpy(iter->module_name, "bpf", MODULE_NAME_LEN);
> > > +               iter->exported =3D 0;
> > > +               strscpy(iter->name, iter->bpf_cache[index].name, KSYM=
_NAME_LEN);
> > > +               iter->value =3D iter->bpf_cache[index].value;
> > > +               iter->type =3D BPF_SYM_ELF_TYPE;
> > > +
> > > +               return 1;
> > > +       }
> >
> > I'm sure there are other ways to speed up get_ksymbol_bpf().
> > bpf_kallsyms is a list, but the same symbols are also in
> > struct latch_tree_root bpf_tree
> > Integrate it into get_ksymbol_bpf().
> > latch_tree_find() will be surely faster than linear search in the list.
> > Or go the extra mile and implement an iterator for latch_tree.
>
> How do you feel about Florian's (cc'd) patch here?
>
> * https://gist.github.com/florianl/41e2bce29ffde797536eef9b2e47ba92
>
> I can take a stab at using bpf_tree like you suggested, but if you
> like his patch, we can just go with that.

Sigh. Did you think of RCU life times with that patch?

*iter =3D ksym;
rcu_read_unlock();

What happens with that value after unlock?

struct bpf_ksym *ksym =3D *iter;

what is being read here?
