Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99D385D75
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404510; cv=none; b=oDA5vc3QjirYbO26844rzWX/L84xxrJ7+utuJE5+9EN2jMYBwY2tQ3BCTQ0c9/H48hgdpXhg7XnCgu8OYmTD9gW0k6EbkhBaYziMKoe8UcWdZp8cHCdZ5nEawuNQL6oXPfyRpU2u8YXSdSsynMHSNFjX46bs9xqmuJMv2Y35dU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404510; c=relaxed/simple;
	bh=S1aeP97yylgk0q1gm2EoL15Tj+ZSUMdIt7IJmejCISE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp+r1FAXcwbmvzTHHbo/K801D7vaZxnAsVA8OhV/zUEUg3KuOhV4wmpEXkgajfyL23PwJl5RJefoZKrnLRwld74C92yCjiUWE2hrdjGXVN2Ksd01/1jxMzDrrZ/hYWwFkjEAff0G77GRXZpxB4UwH0YAqPvCIh4Fxlswl23QLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amuusODh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amuusODh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01501F0155C
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 06:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783404508;
	bh=S1aeP97yylgk0q1gm2EoL15Tj+ZSUMdIt7IJmejCISE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=amuusODhUNcpG+aNvo/8nf2PMqoRUdfTxVAKMCJcggdvo2WzppXXp3eYeEY9PeiN4
	 RS+OMp+b994AAy1lqQby6ZeuINcBslTbiP38sVA4mrdQzfPEJ1wmd+An3EnY+fbJtD
	 3GjlabhSM4eZu/4Z1ruyCIsbFsQCWaVeJMsHb2RjqNjHxcAJPafzEmoTKBZj9w2ebO
	 xOVS+yeWYt37gsFuwvTE9Cx+k77hd1NRY8ZCRkqk1FIgupEaAQL6MMMx3OBVuAujJm
	 xexojw9+QQ6ErqjG0kmcHi1m3o+M2M443qd/vnqIGLkc1hqrCNlw+U/c7sTw1YGox5
	 4aBwW86T+6Rag==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80bb41f7f3cso35034187b3.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 23:08:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqvDfuDHO+BK22NMlaJlgZz/TSjNe0OaEcTIX1YtRbaGsvIqmIZJDDN6Zp39BVieczEfow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWi2LgxogElgi4DxEPo12mDj2fogB3QUd4ESIM8dvYOJcz85mi
	AYgnETAeEbzg/V1OrGcn8XOhsyGuQmuEQfA9sVcftWhAq8SZ0W3JsRdq1OoFAqE0qylvWg/nDhu
	ktgTKNbR26GUPtsd/v7gtjTogdgnGilc=
X-Received: by 2002:a05:690c:c452:b0:7f8:7e11:d023 with SMTP id
 00721157ae682-81be2d7a098mr27493797b3.49.1783404508016; Mon, 06 Jul 2026
 23:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
 <CAJ+HfNhn9eK+3xsd3ewEsG-duCgBeYXeLAtNan=qefas2Ya0dQ@mail.gmail.com>
 <d6647f5eb213d2ece82753285a79f28f600420d7.camel@gmail.com> <b4ca552c-58b6-49dd-bd83-dc27ca49368a@huaweicloud.com>
In-Reply-To: <b4ca552c-58b6-49dd-bd83-dc27ca49368a@huaweicloud.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Tue, 7 Jul 2026 08:08:15 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNiHMzcB6BsW3gER1-2X9EgSDnjzJ4r=ijQuPvKHx2U_FQ@mail.gmail.com>
X-Gm-Features: AVVi8CeF4tOKsvACopP39T59swPHySqB9E_OsWFganTcvFVBHkNmkbvFlwPOfA8
Message-ID: <CAJ+HfNiHMzcB6BsW3gER1-2X9EgSDnjzJ4r=ijQuPvKHx2U_FQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] Mixing bpf2bpf and tailcalls for RV64
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey!

On Tue, 7 Jul 2026 at 03:31, Pu Lehui <pulehui@huaweicloud.com> wrote:
>
>
>
> On 2026/7/7 3:29, Eduard Zingerman wrote:
> > On Mon, 2026-06-29 at 16:21 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> >
> > Hi Bj=C3=B6rn,
> >
> > I'm working through bpf patches queue and have a question regarding
> > this series. What's your stance, does it need changes or can I apply
> > it to bpf-next?
>
> Hi Eduard,
>
> I need to send out a new version to address the issue sashiko mentioned.
> It's already fixed locally, and I'll send it out after Bj=C3=B6rn's revie=
w
> feedback.

I had a look at the series. I have nothing to add, other than what
Sashiko had, Please send out the next version!

Nice work!


Bj=C3=B6rn
