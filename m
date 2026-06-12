Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84C3B6374
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295463; cv=none; b=XhryWWNhR8+nFmFOeuFlXBa4nw30Akzd9d/3TBDl5wIRAzu6eez+Hp7W9awq9IoPZguLsPkeEXSuuOm5lYx9M7K5r91Dg/aOeXOut6c3TWJddZKQ9lZvut8iFkvcTa3KMCWmk4qy6/lGI83RLUBpRgXMtdh1fyKbsnfGbf5AvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295463; c=relaxed/simple;
	bh=DQkH0EqHo/U4CmrPE9183vaCEEACVGKox23KO3cOE84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncxn2XBrBsvCs2R+ALBnIWSHyNKMdHHawOhSSaYYHYf5cz+N5odL9/wS81RIUvrgj2x8hUM8yv1OPqyE/gpnL7dF6Z5y9iq5ikVJcPCBix3ip1UNHUM/ner0LxDx9MYJ+io61AYsGLkykzLEhNvnmYVAIzrisTzzv0/DIS6mCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=Wy+fXVLS; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="Wy+fXVLS"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3042a388168so1384223eec.1
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781295461; x=1781900261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gla2bioFzKzfVEt6gQK/GdOcOBavArs9BChjcX+MDZQ=;
        b=Wy+fXVLSVvoV7unMbS1ZOxt6TAixaic/fhUt5z7X7uhbBcgKgooitvOktdBo1h3gp3
         3tKMr7yKAZfNOmXaSZIyE0O0FN5NKrsCI5fJTJLTtv3YxgWrcqVsXF8j6KCGQgbRBoT8
         W03FLOCmajjh+2pUgtvSGWYrESj9/0dCCWed/WCpoQPwv2S3g+TneCVpvHip09Uwj5xD
         nJEBgxb512uCzPZ+AjmQgD42g/629PJTROOS/M8hvwQx8OyC5iTLXvJRQuxnur39qV27
         xfB9YBgx5qxq3o2BS4/AnBriU6ohs1/y252U0Mhxl73eiV56bgJAhgcnyhsJ51UVBFJ5
         A/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781295461; x=1781900261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gla2bioFzKzfVEt6gQK/GdOcOBavArs9BChjcX+MDZQ=;
        b=ocbhpFEV0Xg+uIOYvDkSRA+chN4lpFKIhlE23FruxM92gYAWPom4LR3mMh4WogxUv9
         fht0Hni+kyAMDHBTkRqvMeIaqbQodFWuLtPvDnjCDqI3UlO1efcv20m0Nc6QAGWZZEKd
         mItBVO0qz5EKIbd7YkmgSkyPnFZZTiYX2gyLmJWSogQzE9UvOCgw/OSJb98JUZlO1g8M
         02CURzkxEol5ndq1FGl76H2WOcJQSVIPg6vWZyKIlA1i5p/Aduy8gGhd9CpZBURmUn0b
         K1P4i/cYMo6QaNyCxcOk36UbQIIJhma/1DEreIvkOPH29XRdaBCQbKv65xnmP7qg0cSA
         YigA==
X-Forwarded-Encrypted: i=1; AFNElJ/HqlT3ndr8/Bhqe44naYJ5f0pXo7WVe5hJ1bA99WWjGwtWjiE5/v/0DFKBs3UBO3Z0on4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPISAEoCq1tuhN5e4nwc4c//S2PPE4ZgfR4QxrJLz8kIfiekxS
	Kjd1CQ4exxqzBzaIBWAMHimS/JlFTyXubwA+MSHsbvKiKBXq41hxRl2mpWJmF9suU3s=
X-Gm-Gg: Acq92OHhos3lEyeG0mLvVPcnR5ms6AHHwGFTDrt2BTo6TohvoQxq631Fi+YpWyvXvDq
	G8wS5Ja8K0tZiElkeY1c2Id/osBtXyNnFg7W4uL1Uw/ztcGALbv3YZVqy7jVSglBAozr7n0pClG
	YjLnKa2pwu5zwJ9eNJSK2tcpiVxOSm2r+ogFEKvk2hjy1YEMcwRYacf3mizWv3nDFKCt8Ux/oVZ
	NJpFNv1qYxx4W8U5K3ULO0fWmflVvXckcmO/qkHsekY4RyEPuRKARYgnQi8O/wXeQft34UFYUT+
	ZOfxg6nDIpZl156NZE2Opnp3x5Q7hkbJwJhXnEKf0vcNiY0vrySYPd1pkPCPpBAV4hDi6z4ueV2
	ESwByrtBB+lt9GqNXlPiX91AUruYJhV6nPldYjfsCW2spDJU9u2/uHMl84GD2+JatxF1moBi5Y2
	vuEqums21F0ZDebNAc+vXEChLahyA6eICpeumFisT6GNrhTYc8jZ/5gg==
X-Received: by 2002:a05:7301:d80c:b0:2df:498e:811b with SMTP id 5a478bee46e88-3081de628c8mr1733511eec.7.1781295461301;
        Fri, 12 Jun 2026 13:17:41 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f878sm4756671eec.17.2026.06.12.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:17:40 -0700 (PDT)
Date: Fri, 12 Jun 2026 13:17:39 -0700
From: Cong Wang <cwang@multikernel.io>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Hemanth Malla <hemanthmalla@gmail.com>, zijianzhang@bytedance.com
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
Message-ID: <aixpY3DHpukx6bix@pop-os.localdomain>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
 <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
 <aixMETjhANSYBZP_@pop-os.localdomain>
 <CAADnVQLzEopmoR7vdTnno25gCqT99ja3jPaMGUnW+edg9P9Sew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLzEopmoR7vdTnno25gCqT99ja3jPaMGUnW+edg9P9Sew@mail.gmail.com>

On Fri, Jun 12, 2026 at 11:34:25AM -0700, Alexei Starovoitov wrote:
> On Fri, Jun 12, 2026 at 11:12 AM Cong Wang <cwang@multikernel.io> wrote:
> >
> > On Fri, Jun 12, 2026 at 09:01:43AM -0700, Alexei Starovoitov wrote:
> > > Just saying that the code is free nowadays, so whether it's 1k lines
> > > or 10 lines is irrelevant for the discussion.
> > >
> > > As far as the idea goes, I think, it would be interesting in pre-AI era,
> > > but today splice and friends are a prime target for bugs and more bugs.
> > > skmsg and tcp_bpf are reeling from unfixed bugs too,
> > > so my take is that we should not add any new features to skmsg
> > > and instead deprecate what is already there.
> >
> > I guess maybe the name misleads you, it has nothing related to splice()
> > syscall. Its ring buffer was developed on top of include/linux/circ_buf.h
> > which again has nothing related to splice()/vmsplice()/pipe().
> >
> > In case it is not obvious, this patchset does not add any new user-space
> > interface, only a kfunc which is visible to only sockmap eBPF programs
> > which already require CAP_BPF privilege.
> 
> Not the name, but the concept. Taking from one socket and feeding
> into another already caused a ton of issues for the networking stack.
> If you can convince Kuba we can entertain it.

If you could be specific and provide examples, I could provide better
answer and take better actions.

Until that, all I can say is Copy Fail leverages page *references*,
bpf_sock_splice_pair() shares no pages, it is a private kernel allocation,
with no pipe_buffer or page-cache involvement at all. Probably the most
common thing between these 2 is the name "splice".

In fact, it has 2 copies (not 0, not 1) by design, see details here:
https://multikernel.io/2026/06/11/bpf-sock-splice-pair-two-copies/

Or if you mean skmsg or sockmap has a lot of bugs, this is true but it
is mostly due to TLS (which codebase is already a mess) and the
complication of skmsg itself, none of them is related to
bpf_sock_splice_pair().

For your reference, this is the data sheet I collected with AI:

  ┌─────────────────────┬─────────┬──────────┬
  │ Code path the fixes │  ~Fix   │ Splice   │
  │       live in       │ commits │  ring    │
  │                     │         │ uses it? │
  ├─────────────────────┼─────────┼──────────┼
  │ sk_msg / verdict /  │         │          │
  │ strparser / skb     │     ~59 │    No    │
  │ redirect            │         │          │
  ├─────────────────────┼─────────┼──────────┼
  │ TLS / ULP layering  │       8 │    No    │
  ├─────────────────────┼─────────┼──────────┼
  │ psock / sock_map    │         │          │
  │ teardown (close,    │     ~10 │   Yes    │
  │ unhash, destroy,    │         │          │
  │ replace, free)      │         │          │
  └─────────────────────┴─────────┴──────────┴

Thanks for your comments!
Cong
