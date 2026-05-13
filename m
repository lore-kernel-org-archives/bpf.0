Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D03783CB
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635900; cv=none; b=Vl7QsEXXb87RJqD2flZWKw+NjWOyjs7thmGwPp2vGPYTs5YXkyW+qKsSu90Ftvojb4HlvJlYd/upRXnVgd/9jOCNGm6Q+4jBLKv87ykhMjCGocwb9FulzyxmTVOkKBLCl5O2UPVylKJIFaTSZeMzRoD06rq9RrjeqA1oriiSMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635900; c=relaxed/simple;
	bh=uTgZo2rbYIIiMbYn9F8Ie/XS5usfTV8rdiJBhJRL7YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVfh8xv5sjfJ8h34iYuI9dbSrUQbtvEg0xyrl77Y9XRVbddWeHEVW/+fd1lm/raxtwfkwlcE7eXFW+ualoFNdo1BFSuDkcvQh2J59U0ASkRzu3ysh+B7YLK7ygEUS0ylpsm2MKNN2EELxr9Adn0bp0m+KgyQuf8aUwfdZLrKZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfesjAD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfesjAD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04105C2BCFF
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 01:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778635900;
	bh=uTgZo2rbYIIiMbYn9F8Ie/XS5usfTV8rdiJBhJRL7YQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DfesjAD+Keq2p1qtCro3hfSZNNhwYbOmoApL/5ceKQVqdk2AoqZOTDJUl0iBdxJE3
	 iuaw+5EIVLR74L0tc+cWQ2LuGeHNm5xsCevbfJnQkRq8wYHjVu8UTG488voOgaIsa3
	 VOw/BHu4kgoJTiP3CjWMH5AhVcytx7hW/yFC/rl8SyhaxNQnXbE7vOGfJ2r2C1nvuh
	 ZWqJcRpwYulWCMeJQ51Q/oRuH/y3AJCQdAlmlY3ktmfkPoGRRKBNolAkBohg+2bCEh
	 QD0E1UWCYUYc0BH+8K9QKwQv2KXiqleiDMhT+pSCWa+24Rj1JzVENW9lszh6c1Pp1U
	 sanF00vT/8+YQ==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d87c138e1so60356461cf.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 18:31:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8tKM7mMJhIimW/gcGAUYb/021brSA2o9KyT2rwoT4iPrbRkv2v5YxTMoiswU3/J6N4EhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++njgtl8rp64Lx0ZN7ASAO0vE+t6COtcjgcNcQYj7fWt0fgbj
	YZhdAaAi+vtdhZKU49Vdy4jPBMUQ/n4tjqfHfTWrpXZFtW9e8da9439jlQC+MEUEIahaZZQx0xn
	0SLwjuV4OTr+iMc9oC+zfkkiJcFk5Re4=
X-Received: by 2002:ac8:5750:0:b0:50f:b4c0:630f with SMTP id
 d75a77b69052e-5162f6603d5mr17430591cf.54.1778635899150; Tue, 12 May 2026
 18:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511085344.3302-1-mahe.tardy@gmail.com> <20260511085344.3302-2-mahe.tardy@gmail.com>
 <20260511182019.69ebc7c6@kernel.org> <DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
 <20260511193603.3ef00cee@kernel.org> <DIGD21MXE0XM.3CLUL6BVK74PK@gmail.com>
 <20260512065335.50647ee9@kernel.org> <DIGZA9DICBXO.2QQ1V7T186JW2@gmail.com>
 <20260512163255.34162f1a@kernel.org> <DIH5HQ54TYJF.2LNWVZJ50B5L0@gmail.com>
In-Reply-To: <DIH5HQ54TYJF.2LNWVZJ50B5L0@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 12 May 2026 18:31:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW71P58XqsXrLbqsShgnozg66TA=T_c=fYrqSSzvL1tTWA@mail.gmail.com>
X-Gm-Features: AVHnY4JCL81buvEeAfsCsYLCYSVQ96D_XFiVK9VZZgUIjXOAHxyK71jlM_PVSUE
Message-ID: <CAPhsuW71P58XqsXrLbqsShgnozg66TA=T_c=fYrqSSzvL1tTWA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, martin.lau@linux.dev, 
	pabeni@redhat.com, liamwisehart@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub and Alexei,

On Tue, May 12, 2026 at 6:17=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue May 12, 2026 at 4:32 PM PDT, Jakub Kicinski wrote:
> >
> > I think you may be overly optimistic on the dependability of netpoll.
> > Rik has added support for serial scraping at Meta because netconsole
> > misses a lot of crucial alerts. And I can confirm there's a bunch of
> > errors that appear in that dataset that are missed by netcons.
> >
> > Then there are little nuggets like some generations of bnxt NICs
> > having to discard all Rx frames when netcons is trying to send
> > and Tx is full (bnxt_force_rx_discard()).
>
> horrors. since bnxt is doing that then indeed it's not something
> to rely on. I thought that over the years major vendors cleaned up
> the driver side well. Looks like it's still not the case.
> Sigh. Moving to sock_create_kern() and friends then.

Thanks for sharing these thoughts and background with netpoll.
We will look into sock_create_kern() based solutions.

Song
