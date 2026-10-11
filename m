Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FA425888
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791716274; cv=none; b=H4CuixBtGMU/k5Fwbx+nCdtfIviGxmyu9hynK1A3EUiczfLfGzrczPyPiCbsV7tHXsEC9pMUOqNiK+I1M8vtQ0ZC+vfIpKJuugDwEUrAqcRYU5kAngewEVzN9p7secrnzIL6cEzSUv7xpw14dyKk+lQk+W0QOxBDQSBFXvKmQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791716274; c=relaxed/simple;
	bh=jurhZonTAHPcRoXR87rUYd6+VfE68pFociMCFbOfTT8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phc4gqONnigvX8igrwEt8OuGEUn3R5sBYCcJrQGsdNxgsOxOs1Ltk7zeHqUkaN4gHpkh0xeDvir3yBk1bgRgb3D0czvyykeSZnrMu9wBoBc88TEFqWZRhIYfvMbKQVi+HPysJg/PW7EntpPRUlhtchF3xADQw/3Mi6P3GxS//Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpXyppH2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpXyppH2"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so893127a12.2
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791716271; x=1792321071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKhg3P7K9JH6IPxkoS6kW4Qa3bVqrpmsAGquZuq3bmc=;
        b=hpXyppH2E88Qwzd8PdC863VMawEwEKgMgnlAnWTckV7RkHkT4kOWeqN1LUDsi/mR2h
         lmeB0rGoTe3MY1iUn+PuCDXpB8jf9i0QiGffLJE+gQctu7OQKhxenRJhvqWwCNJNIcxa
         m0sjrADk5Tkd1GMrEpbSLqe+Gx7NUgVxWWSd5yzWNrDVHAojhJh0Ob6tsEP7y7pnp2sv
         4yJiTzmCKCkmfS8cg/vISMygkMfmEKY04RO0gW+6kmi6wFVZr7LykaPtNu/V3svPdGny
         b5z/b22zz+rSZGULmHLtN+gxc6vzNcCGRuxLH1RsYzDGyZCMyQ5J6Yf6nrnjs5kzBwVH
         v0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791716271; x=1792321071;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKhg3P7K9JH6IPxkoS6kW4Qa3bVqrpmsAGquZuq3bmc=;
        b=QIzTJP0UVMORf1XH8Ze1JQm4PU5CzSdqBrhrCz40tMPDTtT+OHDh/FRtZDANKnRI3F
         7DdmjZ6ACHRnpHHANesC34nlt+iGR0cgTMwxVlYb1idNzZgs7Sjq6FET0Kzzd1nSB9lD
         YWTUqQXklx6Iq3Lh0T1852peUp5ygE33zSmv34XmpTOixiT70LxYvXhCUIAIr1u4/HC6
         I/FAfSdz9PmE813FkaNyM6mLnzPLGm9NFMIzizUOx/qIC9kwXmS49sVMBOE4XyzHGzb8
         fV8yDK0C1PzmLettA0gmRic45V1rawQIUTVD0gipQS1n/Q139xq8AH1fwZN/RD0IARuZ
         Am+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzrIBeT2ZA5mPmM7pg0ufjfnJBa6PzMsqVKqiTKWcjoIZF+xwifGkmE3xHt75zde8aHTDc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3eeotxAD3a0jGGLzwA9n7lphWehwAH1pfMJhZnH0iIDzVeSZF
	Nz2PrBDD2DlVvt2VOB44ws9AZVxIlvNenLvj2B6CNhE4xkA8cKQsK7pI
X-Gm-Gg: AYBFou1L5SZJUq5HOupIeA+Bo914vMlxOqS3aWuvN7srVBaU4Ynxhv8tKo9ht9z1sVY
	fpQtzZ2OegIpF0yYh9VcdvUzG6MCllxsuY4jv8jql6q4RE2dC1T8UUpAgmsnxGe0die+75WPyHU
	G3blncvS2xanrVEUVg/YNLFzUvZC9qfSIWIcea0MyrhFkiopqv5pGyRrBZg7pAKlAxKIlFYJhru
	uPvTBSZCrv3RPUvYizNlYeEj0bUD/GafUwQobeN7BdbxWjyFeRJ1E2qbrOkzj2ma0AHpKqg2ef9
	+b0sYzFUHkbLHzZssrwhY1vUo4hCx295bbEDhRmE5+GmqZ9krBLv9UEqh5wrrGlrcyX0Mi07kAu
	Df4xxut3kyq+14zW+xOIqj/1rm3oeGxEOyelNN37qBOedovFTmpjIxYdU28Z+LFDMDOmKQ2MyfT
	UGESnMMn6WTAkcSurCpmKWShiBZYEufKDhDcBE+m1H0og5JE3YHHp8bWWyWMo=
X-Received: by 2002:a17:907:d89:b0:c2e:42e:4da0 with SMTP id a640c23a62f3a-c31a9d0df2bmr756672366b.19.1791716270775;
        Sun, 11 Oct 2026 03:57:50 -0700 (PDT)
Received: from krava ([173.38.220.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9767227sm344722966b.11.2026.10.11.03.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 03:57:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 11 Oct 2026 12:57:48 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org, ast@kernel.org,
	andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
	dwarves@vger.kernel.org, daniel@iogearbox.net,
	ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v5 dwarves 05/10] pahole: Support inline BTF location
 encoding
Message-ID: <astrrAe245p3pBMf@krava>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
 <20261002174043.3823987-6-alan.maguire@oracle.com>
 <asjoNE3H9ZqL4rsR@krava>
 <0980d4bf-a1f9-4984-ac7c-51141d498e6c@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0980d4bf-a1f9-4984-ac7c-51141d498e6c@oracle.com>

On Fri, Oct 09, 2026 at 06:32:43PM +0100, Alan Maguire wrote:
> On 09/10/2026 14:12, Jiri Olsa wrote:
> > 
> > On Fri, Oct 02, 2026 at 06:40:33PM +0100, Alan Maguire wrote:
> > 
> > SNIP
> > 
> >> +static int btf_encoder__add_inline_expansion(struct btf_encoder *encoder,
> >> +					     struct inline_expansion *ie)
> >> +{
> >> +	struct ftype *ftype;
> >> +	struct loc *loc;
> >> +	struct parameter *param;
> >> +	uint32_t section_idx, section_offset;
> >> +	int err;
> >> +
> >> +	if (!ie->function || !ie->name ||
> >> +	    !btf_encoder__inline_addr_to_section(encoder, ie->ip.addr,
> >> +						 &section_idx, &section_offset))
> >> +		return 0;
> > 
> > hi,
> > we get inline locations also from .init.text, which then fail kprobe
> > address validation.. is there some usecase for keeping .init.text
> > locations?
> > 
> > I currently disable them in kprobe_multi change I have on top of this,
> > but I wonder we could just drop them completely in here with something
> > like:
> > 
> > 	if (strstarts(encoder->secinfo[section_idx].name, ".init"))
> > 		return 0;
> > 
> > thanks,
> > jirka
> >
> 
> hi Jiri,
> 
> Yeah, it's a great point, and certainly doable. I guess the question is 
> if they would ever be useful? Are there any cases like early boot-time
> tracing that might find them useful at some point say? Or even informationally -
> i.e. function foo() is inlined 700 times in the kernel, 20 in .init.text
> and 680 in .text. Not sure..

actualy looks like ftrace might be able to trwce early after boot, so it
might be handy if we manage to use this via ftrace

> 
> On my kernel the inline.init.text sites are ~2% of the overall number of 
> sites, so it's not nothing in terms of storage, but a lot less than the 
> .text section. So I'm happy to filter them out if we think it makes sense;
> maybe we should add a section option to the inline feature or something?

so it's like around 200kB? I this it's ok to keep it, nevermind ;-)

thanks,
jirka
