Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9AE149E17
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480830; cv=pass; b=EC+VzQuto5QEoBFa+nY/xqtrHYDYDZefjJNtwOsAvl6yNPbIVkRKunYN7596xFYTOWgmANErYpfAVkoQvbAIX9SezUe1C+CYJbNsu/2PdjyxkdAFv/rDMRazQlaWT1bCECoQ8/zJRjOjQI646GGCC7JJMnnEUgCUopQRMiw5M8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480830; c=relaxed/simple;
	bh=DHhWwA9WXZv5VCDDG8Ki1OXw02p+ulk0/1MfMhwP/eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLv74CzTtrvQhT0+f4VdRXrIZFguqY18I9leDjVqL1ISJyerH+Go7cVcP2bFlsJOcyYz2fwkTJer4WSM0HvqmGWmieXFK38J7uIjvS8bfg5A00gnvA/q3E7LGR9N1t6nWIbGwWTQ8TNkD2/USbBJC+gR8drmJ8qypdzpY2uQH9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqG+MJ7y; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqG+MJ7y"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d2670932so4721036f8f.2
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 18:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769480827; cv=none;
        d=google.com; s=arc-20240605;
        b=jTCKl0ziCJiNOUcwhHlwsvyX9tu7GwNGyhS6YRyU2/8UeFt0I/39/VCgSHXmTx6olR
         RzuMW2L+Au8fc7fAWRl4SABuD3FuyvNQ9WhvORDscOELRr1N0tk3l0q14Ezo4X+mF9n/
         WSAnJQe1tXtg6CVtb32joYv663W2WwpWBdEnIft8NBdwlIpXRUHpw1N4dAzB2pn/EbmX
         K3rHFFh3MXiPsk/NCGAOLn33W75RDS2sKwn32aB1wia+1IqXiwzc2AaDsjhu9ZDruXPU
         cJ3zRK7Su9uFIZdBFrZo+VvJ2WovfPq2lXIbaFJ5h6M20k0DyhIyTJgnIVCbdFSrvMyO
         98Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rAP7UibDzwrBBbLv0zTVdstEX/VNmCNyFjVLWLRqkAs=;
        fh=fgKuWAwrPA93AAgmAid+ntX61zo5emBWKaUHorOCgYM=;
        b=bN8p2gK69dFKiGAxYwg2h3gnboVUvmfWqFy6afuVQUJ3Sv9/prbiCD/atb4rLVM21s
         APSETN2Dx5CXISNBMM2fHWokQzr4Sr8gwppOQ6Oy3lnZVmI8Vfz0XTfY3qA2BdZP6pCi
         +3Ce8jbzjuPHIc771Obe4fiS7RVjTuYkL1JEBCpLx9qZfXGsf3M1oguNtoEgrdouLlJz
         Fi2PZsGSpOwuhMW5AuiJcx24qk7MS1cNLvNXIcDmAfCL6i+xKdr3Th1jvLn740nup5p0
         DIQgnojZBXGi2Uxzqp3wgVtgK9VAFRO2HzDnTvA9E+6fFO/jOa8pzDczMAyuV776i94q
         VsZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769480827; x=1770085627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAP7UibDzwrBBbLv0zTVdstEX/VNmCNyFjVLWLRqkAs=;
        b=MqG+MJ7yqauIwJUgbVmk5eGEgudgQFfoU0cAD1IXV/yU+vvpNJZAdQHUoQymbeGH5q
         E+r30h2yXxHlLcLe9ROd1GRxp9LrtO7xk7UZzt9BlM7nGuJfUooBcybblBvsvyktzLBI
         CbUAwRkptcMhwWeS572J4ShXHTOD8+uLDcSNjfwJuSdcz4ICoBW3ydHVkfwpCl0flGCA
         A1dveOLW2eUiBPM5P8WaI8vcLgkTEIe75jZEeuM/jtVLBqOvkG9tlM/iM5MpLvK69B1C
         gM5ewnq3LBfGsRKr+MtI6YtMEoEMipc+nXGN86qaeqNvZlWNhyexxVr9TENgLmqG9Vaq
         6ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769480827; x=1770085627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rAP7UibDzwrBBbLv0zTVdstEX/VNmCNyFjVLWLRqkAs=;
        b=p4ZPpNjqX3YlfKmpnGT1ilD53BTlHGvO5FvMNTCkdeJjrJbIvfGXI2y5navO2TXoMg
         JLa+5LMPABDIulgbcCIzyUDsWUiYSodYKtVRJcjvsjI5Q/LXuHLN6ELPAvNQ3fdfBxAW
         ZrWCCKtwxpGlMSHKabK3YwYOKkz/zSNB3I79TPzp1yMREJnF2vSJnpsT0rDmchh86RcL
         Zcmif8cPnbtY+ZoeC/3N9a9scHj0SRRFOcFvukV+odlbBp/mtyFVgCh3apKI8xthGnlw
         Dcr9UKPROFgecDVovUoAyoUlRylQv0yrq/qqh/shoTe6dsCEMBK8GBbgcTKY6KQVBMHx
         LY3w==
X-Gm-Message-State: AOJu0YxxcBhrZW5Op2uSXBNgioETUMlonN6QUOBIVlOLvU5+bk01eFdL
	GwxO8UHoyzomlNxGvMDgmMGgcNQDmRvrjfF+lh0ksPUzOI1DW4aE348LBnZ+CZiCPYbsd3DMjq8
	NKbiSL5j+INlGar+fhEFCC0NdCyTl/gs=
X-Gm-Gg: AZuq6aIhP50JHBPiox2H1B40VZCHhicf57+8RpuyxVz4LJI1n4gDvKFWoYsCdBLmks+
	4QlO4Ux/ARg0pumOyRcu9/PNXxVt30LR3E0LJhWz2WnwTLKifwJDE7vYkUnGTxMvvgvddfHKOMM
	xFU4OTBzCsqQhC2n4znq8ESDyUnvyNg18hBZ9Nw1k+Fkq1l8ana9RwaDBRD0VvFHzwYw9J9q59+
	NgGHYPW+PLrt2GX2RH+2drUet8KA7kLc/MrvzuiiuPd7sBnm8FofpLK1WtYmjFqPtp2JxZCOef8
	ZU80p4IwPlZwVoqNV1/MPf64+0ccoPrZ7Gd9fynCHJeYGFJQ/o0j4ID7ewEGmcHWFObUZZ/9q4e
	z66fs5Uthq+UWfQ==
X-Received: by 2002:a05:6000:22c9:b0:435:bd00:3978 with SMTP id
 ffacd0b85a97d-435dd1d3268mr125604f8f.60.1769480826720; Mon, 26 Jan 2026
 18:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121135444.187001-1-mattbobrowski@google.com>
 <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com>
 <aXNWLU7ay1HHmg6S@google.com> <CAADnVQKHuj1snSOBh+VEJrcW82OW2zNOEd1=Dqe-m+kuOV7MWw@mail.gmail.com>
 <aXct9XxD43eBZs-H@google.com>
In-Reply-To: <aXct9XxD43eBZs-H@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 26 Jan 2026 18:26:55 -0800
X-Gm-Features: AZwV_Qj-w5tgoF1KlXBHZVM11wgviD6JZPe2r_9dhWIHKkb6GE4A_sOu0Vu_a8c
Message-ID: <CAADnVQJXs1NinaahP-uKOrqKUHEZ4PgwOAAVpWkHDWkapBZ2YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 1:03=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> On Fri, Jan 23, 2026 at 09:17:03AM -0800, Alexei Starovoitov wrote:
> > On Fri, Jan 23, 2026 at 3:06=E2=80=AFAM Matt Bobrowski <mattbobrowski@g=
oogle.com> wrote:
> > >
> > > On Thu, Jan 22, 2026 at 08:26:49PM -0800, Alexei Starovoitov wrote:
> > > > On Wed, Jan 21, 2026 at 5:54=E2=80=AFAM Matt Bobrowski <mattbobrows=
ki@google.com> wrote:
> > > > >
> > > > >                 break;
> > > > > +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> > > > > +               kit->pos =3D css_next_child(kit->pos, kit->start)=
;
> > > > > +               break;
> > > >
> > > > There are no users of css_next_child() outside of cgroup
> > > > internals. It's a red flag for me.
> > >
> > > Hm, I can see the slight hesitation here. However, until somewhat
> > > recently, the same argument could have been applied to functions like
> > > css_next_descendant_post(), right?
> > >
> > > css_next_descendant_post() has rather recently started seeing usage i=
n
> > > other subsystems (block/, kernel/sched/, kernel/bpf), despite
> > > remaining internal-only since its inception over a decade ago. Given
> > > that css_next_descendant_post() continues to remain unexported, in al=
l
> > > fairness, I don't see css_next_child() being all that different in
> > > this context.
> > >
> > > Would your stance change if Tejun agreed to mark css_next_child() as
> > > exportable, or simply agreed to it being used from BPF cgroup
> > > iterators?
> > >
> > > Both css_next_child() and css_for_each_child() have remained virtuall=
y
> > > unchanged - and therefore inherently stable - since their
> > > introduction. I should also mention that functions like
> > > css_next_child() and css_next_descendant_post() were originally marke=
d
> > > as exported, and only later unmarked. This presumably was done as par=
t
> > > of a symbol cleanup, not because the functions were unstable
> > > primitives.
> > >
> > > > I feel there is something wrong with the use case. It should have
> > > > been handled by the primitives we have.
> > >
> > > Right, arguably it could be handled with the current set of
> > > primitives, but it isn't nice and certainly not as efficient as I'd
> > > like.
> >
> > Why is it? Just descdant_pre and break out of the loop if not immediate=
.
>
> If I use a break when I hit a grandchild in pre-order traversal, I
> will still terminate the loop early and miss all the subsequent
> immediate children?
>
> I do understand that using css_next_descendant_post() (without a
> break) could allow me to logically filter for children in the
> loop. However, my concern is purely about algorithmic complexity and
> scalability.
>
> css_next_descendant_post() performs a full subtree walk
> (O(Descendants)). If I have a top-level cgroup with only a few
> children but a massive hierarchy underneath (hundreds/thousands of
> grandchildren), using the descendant based iterator requires me to
> literally visit every single node in that subtree.
>
> In contrast, iterating immediate children is just a linked-list walk
> (O(Children)). For deep hierarchies, the performance difference is not
> constant - it's orders of magnitude.
>
> For example, if I have 5 children under a given root/parent with each
> of those 5 children having 500 nested descedants each:
> - A pre-order traversal would lead me to visiting 2505 nodes.
> - A linear traversal would lead me to visting 5 nodes.
>
> > The thought process should be to use what's available as much as possib=
le.
>
> Well, I get that and it was my initial idea. But, I quickly realized
> that we have a gap in the current iterators capabilities, and this
> patch is meant to address this gap.
>
> > Adding UAPI for specific use cases isn't great.
> > If it was a new kfunc that's one thing, but here you're touching uapi/b=
pf.h
> > So acceptance bar is much much higher.
>
> OK, but now that Tejun confirmed [0] that he's fine with exposing
> css_next_child(), how does this weigh up?

ok. let's add it.
Maybe shorten the name to
BPF_CGROUP_ITER_CHILDREN
"_ONLY" looks unnecessary.
