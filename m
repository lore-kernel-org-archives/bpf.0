Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51009303A12
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418237; cv=none; b=rUYSltxSq3vqy6P3ZxvGJvcI33ZorLP26ZBbIYmK7u82DphoekI89Hg4VFzp+A9sV5TLeeCkdP5zIYER0GTk9sBUR93nnx8l2quPrcfpiMgD248XzRQAjlkCN1VQE31tOspx4+5lrNfkS+zSzbnjFLXR19XfpKP2lKBSLV5DPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418237; c=relaxed/simple;
	bh=dXzVdpp6u14DEpmbAtyv5zOxzpd8zQvQBYz34+VQA9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeGlx1LtFpikle+cKy1/4/YmWfeNbCZ3pdqN5dTibtaWr0o3XEDbexcYlznw/WRvigX/5xjcy4b59SwRDDc+Nb/IGIGO0AiYxh0gnoMxByAvw7mjEk5a1zL4RTlglofzrRqqdu5+ndgzw5bxGsU9xWfwPuQ413UAFdI6M0eDdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQZfMCCO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQZfMCCO"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so7159825a12.3
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 01:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769418233; x=1770023033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wbb8sEJMuc5fviCTa96wTOpP3h6jEV0XXQxJqatlP7U=;
        b=ZQZfMCCOZa4K6C5KNyaY2/OQFHmR/ckytYncb496nawXHQgutDmMnCWdfTIyawHHzd
         PHIsYLOqxpcMTBRrKphms1BV1kx4cv3ILinvkvfbJDeh9s0XrwmFY0UvgjqPdkI0dzvD
         0mlkaIZc3Jy79dMV8O4dmJW8fewMdwW0IkEWVMKKJD21ec1wxLmITg0jX1o+mDY/cO9h
         O6aP0Ex/5OAadqIXrAfmqbPrt+CFRM8eWJGrS6iGudGIQmJEEbsuYZLXsczblratJB8d
         RlKIrcCIbVesbYCM6N/0nKIJq0chDNhNLsp/AHR7OWJPGjwPkIYEuaEm/16M5XO2FGPf
         bPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769418233; x=1770023033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbb8sEJMuc5fviCTa96wTOpP3h6jEV0XXQxJqatlP7U=;
        b=mUf4OcQfw9dr9n2wzSKSu/vyE7/IcrH7xVkDo3YhmT4Xt0CQR+I8UHL7+lvxg4N4E6
         reMEULJVA76dybi3hofR1z6UaVsaxa6ztPHQyqw9vWxycnaaebdZrScADq8i0kmRYg6Y
         K6Q1U6CEaFYZjYaoQAcv4inFUMBHuD1m7gPHdStWv1WpTHiupJzvtVR6to02vO9ifJf0
         ouVy6Z6P1hlB9hDf424MXNf4zTjwLuX18x2Zl40EJY6dTGcNDtIMWMxV0tJxIdMrF4zR
         nQc7vcJ/4uQ50KBUBGaReuq7bSOZCnPTdwdtYArED5jU4yoLmJ1USme4VHfXqnqgmIr/
         BVAg==
X-Gm-Message-State: AOJu0YyfZWr+NidIWGKDFBZF4ilnv7Ww788zerswPVJKidqXccDmktDl
	CH0qrNgxBQpN3ZX0KumZunq7j6Daxo6+SF3uf6N4gY6UICtLZZsXjMNbMPUP8GtgaA==
X-Gm-Gg: AZuq6aJl/CIIVVXdH4/oWz0+PEANEUTLGpJk+eM0sojHLzGE+NxeBhpo1h7RdNJnTj8
	WK36W1stZIrEgWsp5zT9fXJoPqIsBsx2Chv2PFO7WdYQoCsw4V2ITsHDS+OoNPvrc+LtZBkIdWb
	+IsxX4t7r+A/i5YTIzf9RlvnWg3vDBr7WKZShHA0YA2toi/ldU0auGhtFHY+/7QrxKGbTS1TxwU
	wLMes32FDXHt3ppAA1E+IOuqAUfL+NO3pmSEOKgLScO6ADUsIb5LitChIwTky+6/i1fjVp8K+x/
	B5KDspvg4xjxdxTASsRWT8GUIkjZ6zSmR1gb2fMKGwWB22rlNIzta8jIF2REdV04PB9e4uSuILx
	zqEYpch+2MDbnwyT9J0RAzV9CANLVvKc/qZfBdKkVT9knk6NzFUdFd2i5vm1nTwH8VaanPaHvm5
	xkltyNBCAcNsbWicWmgxMhuTVKeftMqoxIVHlfJAVynYZjyL5iP70=
X-Received: by 2002:a17:907:745:b0:b88:4e52:bfb6 with SMTP id a640c23a62f3a-b8d2e816decmr275399066b.56.1769418233187;
        Mon, 26 Jan 2026 01:03:53 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7b1a7fsm587710066b.58.2026.01.26.01.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:03:52 -0800 (PST)
Date: Mon, 26 Jan 2026 09:03:49 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
Message-ID: <aXct9XxD43eBZs-H@google.com>
References: <20260121135444.187001-1-mattbobrowski@google.com>
 <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com>
 <aXNWLU7ay1HHmg6S@google.com>
 <CAADnVQKHuj1snSOBh+VEJrcW82OW2zNOEd1=Dqe-m+kuOV7MWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKHuj1snSOBh+VEJrcW82OW2zNOEd1=Dqe-m+kuOV7MWw@mail.gmail.com>

On Fri, Jan 23, 2026 at 09:17:03AM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 23, 2026 at 3:06 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Thu, Jan 22, 2026 at 08:26:49PM -0800, Alexei Starovoitov wrote:
> > > On Wed, Jan 21, 2026 at 5:54 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > >
> > > >                 break;
> > > > +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> > > > +               kit->pos = css_next_child(kit->pos, kit->start);
> > > > +               break;
> > >
> > > There are no users of css_next_child() outside of cgroup
> > > internals. It's a red flag for me.
> >
> > Hm, I can see the slight hesitation here. However, until somewhat
> > recently, the same argument could have been applied to functions like
> > css_next_descendant_post(), right?
> >
> > css_next_descendant_post() has rather recently started seeing usage in
> > other subsystems (block/, kernel/sched/, kernel/bpf), despite
> > remaining internal-only since its inception over a decade ago. Given
> > that css_next_descendant_post() continues to remain unexported, in all
> > fairness, I don't see css_next_child() being all that different in
> > this context.
> >
> > Would your stance change if Tejun agreed to mark css_next_child() as
> > exportable, or simply agreed to it being used from BPF cgroup
> > iterators?
> >
> > Both css_next_child() and css_for_each_child() have remained virtually
> > unchanged - and therefore inherently stable - since their
> > introduction. I should also mention that functions like
> > css_next_child() and css_next_descendant_post() were originally marked
> > as exported, and only later unmarked. This presumably was done as part
> > of a symbol cleanup, not because the functions were unstable
> > primitives.
> >
> > > I feel there is something wrong with the use case. It should have
> > > been handled by the primitives we have.
> >
> > Right, arguably it could be handled with the current set of
> > primitives, but it isn't nice and certainly not as efficient as I'd
> > like.
> 
> Why is it? Just descdant_pre and break out of the loop if not immediate.

If I use a break when I hit a grandchild in pre-order traversal, I
will still terminate the loop early and miss all the subsequent
immediate children?

I do understand that using css_next_descendant_post() (without a
break) could allow me to logically filter for children in the
loop. However, my concern is purely about algorithmic complexity and
scalability.

css_next_descendant_post() performs a full subtree walk
(O(Descendants)). If I have a top-level cgroup with only a few
children but a massive hierarchy underneath (hundreds/thousands of
grandchildren), using the descendant based iterator requires me to
literally visit every single node in that subtree.

In contrast, iterating immediate children is just a linked-list walk
(O(Children)). For deep hierarchies, the performance difference is not
constant - it's orders of magnitude.

For example, if I have 5 children under a given root/parent with each
of those 5 children having 500 nested descedants each:
- A pre-order traversal would lead me to visiting 2505 nodes.
- A linear traversal would lead me to visting 5 nodes.

> The thought process should be to use what's available as much as possible.

Well, I get that and it was my initial idea. But, I quickly realized
that we have a gap in the current iterators capabilities, and this
patch is meant to address this gap.

> Adding UAPI for specific use cases isn't great.
> If it was a new kfunc that's one thing, but here you're touching uapi/bpf.h
> So acceptance bar is much much higher.

OK, but now that Tejun confirmed [0] that he's fine with exposing
css_next_child(), how does this weigh up?

[0] https://lore.kernel.org/bpf/aXPC_KMX_rvO14lR@slm.duckdns.org/
