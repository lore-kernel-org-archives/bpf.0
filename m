Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A118EB0;
	Mon, 15 Jun 2026 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565371; cv=none; b=rWgIB10Ts2bH4ouqugOKelHw2ih1wjAd0tXu0wKGJHCUeeKz+uwDDIZ0mp0tbrqGXgj+ziHE9tdHT/d/4SEekDwHBPjI3Vkd3T92vGq1bXP0+vjpwpfz12mGePCxI2HI1599S5WCVKULiyALOo7VzkQAxxLSYGi5pgSwV2pFgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565371; c=relaxed/simple;
	bh=eMn8aDsbUSTDVO7DTdxWIMDLPPYN75Q0md1zRQ0MLwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiNBGADUqsFk1PPWyKbuoB7J4IgzdEKQuPo2TWMhZ/SqZN4XYB6wKOZiH/6eQkGrgnsumanaZQHmb+23n6aNNd9sAb7NbdUM8ntA3LAR6KqTcFwLxZ5Moi+dysRT9l9eXrz5/S7Mq5PNGofki3bkOP6+JSqjUEMibsqpsbFX3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNYgJf29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNYgJf29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE8F1F000E9;
	Mon, 15 Jun 2026 23:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781565370;
	bh=GRH8yIzqLR3v4Izgh6VsTtJPcd4MPPnKk7ieqqGaUK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iNYgJf29bbMZEekZSSvPc5l/sTl+ZO3JIv18asgC9/wk/nCrsaLdKBQp/cQj3TQYt
	 Ngo0isBlQCE0jMRBZrM4I16C/GYCBfkREkaDJg/VTgXTQJFxpxVMSzppNO5Y55lz3R
	 dhznE1qgtL7918jG2E1Ca/ksWNB0frkw3fI9B6gP3TLHaLVxiyHTyclCWD9an0RQsL
	 OtZevU4AUVlBbFWKOqd1zfL/wEEVD1OUELtF44Hn3fuqCcRlvvdj+1tb4scga7WSyL
	 sZnlPs1FHUU87yyg+L++sbzCXApzYimKPKGXVigJSxhThq9HxdhDCbjeSraUKlfiOC
	 0wKdaIH6XQzlA==
Date: Mon, 15 Jun 2026 16:16:10 -0700
From: Kees Cook <kees@kernel.org>
To: Jamie Hill-Daniel <clubby789@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Subject: Re: [PATCH RESEND 0/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
Message-ID: <202606151615.312A45613@keescook>
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
 <202606122110.28245E2D@keescook>
 <CAO1UbGcbueeqLPOFA+=cJKjQxgXr1pW1vGFR-zNOT7rqsUqs+w@mail.gmail.com>
 <202606151535.F32ACD538@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202606151535.F32ACD538@keescook>

On Mon, Jun 15, 2026 at 03:38:35PM -0700, Kees Cook wrote:
> On Mon, Jun 15, 2026 at 05:23:53PM +0100, Jamie Hill-Daniel wrote:
> > On Sat, Jun 13, 2026 at 5:14 AM Kees Cook <kees@kernel.org> wrote:
> > > On Tue, May 26, 2026 at 04:32:14PM +0100, Jamie Hill-Daniel wrote:
> > > > Link: https://github.com/moby/moby/issues/42082
> > >
> > > This doesn't show any particular application, just a demo program.
> > >
> > > I'd *really* prefer to only add complexity to seccomp if it is
> > > absolutely needed.
> > 
> > When I filed the original issue it was attempting a minimised
> > reproduction; I was trying to run some legacy binary in a container
> > that I unfortunately don't have the context for any more.
> > I've submitted another series that should hopefully address some of
> > the concerns raised here, including complexity.
> 
> Right, I think I'd prefer the legacy binary be adjusted instead. And not
> adding complexity to seccomp given the issue isn't actually a problem
> any more. :)

And here's a wrapper, if there's no source for the binary:
https://github.com/kees/kernel-tools/blob/trunk/seccomp/strict_launcher.c

(This could probably be improved...)

-Kees

-- 
Kees Cook
