Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667B3033E6;
	Mon,  3 Aug 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777508; cv=none; b=DAsm8jad0fEKobbomML7wBqHa0UPJ1UbeAxYDY4fr9mk91cI8Pa/tLd1l1IwxcZA2wS1CqXLUODpU5+gI3808O9tzafL7GzMVxF+ltBjD05Zq1EYb85tsxKTeM5RyKPPvYMIfCwjFrnV9QZrk9fSbuU2bxOxZx95JsBzGYupD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777508; c=relaxed/simple;
	bh=Dv6Fid50KWac4NWQG6uZA5Sig5f1xEVZa0UOIPKIWSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+yu+wVcS1f3JYnRy4G0NNAzvqSaw8AUInNk7s1LHzyv1ZxAStaHgHrN7x0c11JF21bQLuXd+UdkiJgVMwaqRfWg7A0noF5uHFNzIUVbhQPJTmCZs6yfxrkwLzCvuKiUXNsPafo7wALHlBusKwOXTsMffwvJ5fy6UDiwJoduHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBresFUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBresFUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D4B1F000E9;
	Mon,  3 Aug 2026 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777506;
	bh=KDMlJ8e58+/poOlXD4ClH4FCQ9XO9ZMSS6kLO52PMNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBresFUfmOVFLxHMnrnvu7JP3JWOhzC21LYcTYOFodH5w2Zquzjfo0dPA6XoES5KA
	 70fB+/Tq5OuZiZ7UQRsaQzXm2aG2lNP7bZTYbaPkJLjQCJMh/jQ+50IZ9B6H4QvNmB
	 kRFVbhr/jRcBwBs1R/SCaOva1iH+gpAx9LDN1YE2h2kd39Lp+xUZYKQ7oie0S/6o/z
	 /4eoMokHPGRek/O7WCHNE7+GJKZnxyTu8yXiO4P9uOc09AGWC+DyQkzZsoYGrjJaCP
	 Ec4AN9CPwftDrCLAnWhCi1GmO6XjE6ggjnmkv4A2SjmWhE1bd5ku/9meYywEhi097u
	 +y1LS81KzmVCw==
Date: Mon, 3 Aug 2026 19:18:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	linux-mm@kvack.org, bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, jannh@google.com, 
	mail@johnericson.me
Subject: Re: [PATCH 1/9] binfmt_misc: let a register string create an entry
 disabled
Message-ID: <20260803-notunterkunft-wildtier-restaurant-1733e9660017@brauner>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
 <178571387898.1880415.17662890925792360904.b4-review@b4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178571387898.1880415.17662890925792360904.b4-review@b4>

On Sun, Aug 02, 2026 at 04:37:58PM -0700, Farid Zakaria wrote:
> On Thu, 30 Jul 2026 15:34:03 +0200, Christian Brauner <brauner@kernel.org> wrote:
> > diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> > index 707f8a14f8a6..ca7840b01a2b 100644
> > --- a/fs/binfmt_misc.c
> > +++ b/fs/binfmt_misc.c
> > @@ -75,6 +86,7 @@ static const struct binfmt_misc_flag misc_flags[] = {
> >  	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
> >  	{ 'T', MISC_FMT_TRANSPARENT,	MISC_FMT_OPEN_BINARY,	"transparent"			},
> >  	{ 'L', MISC_FMT_LOADER,		0,			"loader substitution"		},
> > +	{ 'D', MISC_FMT_DISABLED,	0,			"register disabled"		},
> 
> AI brought up an interesting point that this now changes the set of
> valid delimiters which you might want to call out in the commit message.
> 
> For instance 'DnameDMD0DmagicDDinterpD' was allowed before.
> It might be a very obscure feature to pick a delimiter because
> https://docs.kernel.org/admin-guide/binfmt-misc.html does not even
> mention it beyond 'where you can choose the : upon your needs'.

Yeah, I can send a separate doc addition for that. But that's kinda true
for any new thing we give meaning. So _shrug_.
