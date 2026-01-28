Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB61A9F83;
	Wed, 28 Jan 2026 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769562243; cv=none; b=IGiI0za6hAhhisdw63tBDLMW6JGnJnRGnvw9vuME0jF5n3H1hIwaZjxNizFjCIENYbcadsLTOKKFngp3fCPuzWJMZe2OcyEWGPSxQBQD9sgyz3UcVG64fvsJJYWyuJwiUQmuaI8FW4qYdCqr1eEwQ9bIKdcYtaS6Iwjpgfy+L9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769562243; c=relaxed/simple;
	bh=mdDcknH5BtgmjDkUBQIyPJuMNm0p9krUQ1ntzkx6jpM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GLQl0g+qgrrrSzkzntY8TacNuYskx0V85QGblSBfyStiuJjlqA+PMRxoQgXWfIetsS4uX3j6hPHUQi8tXu4YQpLHbB/+ZSKOA8XB9yp+3oHXRuPjHWPL2pLtd/BZkYlNvKv9Lav4oq5FkXhoNayssSEIeGMZUnKAwmflebt3CAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2PmDnPhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2PmDnPhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1839C116C6;
	Wed, 28 Jan 2026 01:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769562242;
	bh=mdDcknH5BtgmjDkUBQIyPJuMNm0p9krUQ1ntzkx6jpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2PmDnPhW5nIUXESwN/n58zbMjcZiLsvT71e98eQxn680UGs57nsTLxrqE53kOydm7
	 AQmYyHgh0PuKRCOHp3gr3f+JBtBMh+Dc/OhcXHaFx5141nlJqyhoGlJ+81ACdLk35L
	 Z7Edi48mjDIFmwdT2E94I2wOzi4UjVGj6/pBtyBs=
Date: Tue, 27 Jan 2026 17:04:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Marco Elver <elver@google.com>, Alan Maguire <alan.maguire@oracle.com>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Uros
 Bizjak <ubizjak@gmail.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Marc.Herbert@linux.intel.com, Heiko Carstens <hca@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, namjain@linux.microsoft.com,
 "Paul E. McKenney" <paulmck@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, bvanassche
 <bvanassche@acm.org>, nilay@linux.ibm.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] kcsan, compiler_types: avoid duplicate type issues in
 BPF Type Format
Message-Id: <20260127170401.43b972fa4f7b0b4419c7023c@linux-foundation.org>
In-Reply-To: <CAADnVQ+7ZxXE8O254rkYt+U9PO3Rxt681LaOT7W5UMj1PobHHA@mail.gmail.com>
References: <20260116091730.324322-1-alan.maguire@oracle.com>
	<CANpmjNM=w46BDuLsvAW6oM7JbPvrhN1ddaEUNSvsfZVU-514cQ@mail.gmail.com>
	<CANpmjNNoDHQOfH+bUqjpHdzYDxLwG7wA9qEywfWFNamt66Ziyg@mail.gmail.com>
	<20260127153129.2ca728a4550375a4172e1351@linux-foundation.org>
	<CAADnVQ+7ZxXE8O254rkYt+U9PO3Rxt681LaOT7W5UMj1PobHHA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 16:02:32 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > compiler_types.h appears to be a free-for-all.  It's best to view such
> > a thing as a KCSAN patch rather than a compiler_types.h patch - that
> > the patch affects compiler_types.h is incidental.
> >
> > 31f605a308e6 came in via paulmck so convention (which perhaps only I
> > maintain) says "Paul", but whatever - getting the fix merged is the
> > important part.
> >
> > So I'll grab Alan's patch, shall drop if it pops up in -next via a
> > different route.   Aiming for upstreaming in the next merge window.
> 
> You mean in the upcoming merge window, right?

Yes.

It could be added to 6.19-rcX/-stable if there's a need?

> The severity of the bug is significant. Better to land it sooner
> rather than later.

OK, that wasn't clear to me from the changelog.

> > It's unclear whether a -stable backport is required.  Thoughts on this
> > are sought.
> 
> Yes, since without it kcsan and bpf are mutually exclusive.

OK, cc:stable added.
