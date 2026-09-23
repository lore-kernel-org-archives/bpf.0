Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF473939D2
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138236; cv=pass; b=Sruap3/L3bAl+IwjFhb8AR0dO8K3n4JSFbYVg9n8DCrb7s33Do7M1oByOcW2n8UpRtd9Uud+OIXW1kATK0cCfOYDphMm+WP1fopVzxbfawh5BTuOG5ZiPzeFxc6BsLdf4vF0MkdOXuwSsE3uF8WivxYHAUC1J7e8DPDY1IQH5JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138236; c=relaxed/simple;
	bh=uii4uZSwuRp1E2i/9mczGA2c4h65XX04B5SOMwY0GVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugDOKV/DOwAuuAvbOspRUBfUrU2y+e4he2s9q25rbML7nBWhRvO5ulyOR2HPFIoVXOwteuDeTPR96SgYHUehdzE/WHzain0LqUGrPBJAVQTbxnIu8aA7CMyvP4CL2KJHMks8HudOFbzcTZtS4Qj7BiVkvNA5V1nNxcPNRnt7XvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3BVske5; arc=pass smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3BVske5"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso269627f8f.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790138233; cv=none;
        d=google.com; s=arc-20260327;
        b=ZvOhMzJcfaBGWkZYIgo0CkQoX6eDX493Nc0CojMmfc/gnhYMEU72/u9ZZZVKew1vnz
         AP6piAONVPFYiU/wtEfdfu2ugoF3aZdWd6Wt8qApkyPcpbLI7zYSluDneHG8i7+bclOQ
         29DljovLRqMZiNEt8hD/Ei4zcWVywgBHLEYQ38Aa1WMheN10miAUKj6fJ4py0pz7tvMT
         fZP4OfNaTGHozhuN3kCET8HmMR24lX4Fk2JXz2FQppyOUICkckUkPBHvnZpwYYFGJHSS
         ZqhGd3YnKZUdIIrjm16/ljpR3Yeo5UhI6DD6UVWNUmRn5XMHVObkx5c3aN7G+oAMkr17
         zebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uii4uZSwuRp1E2i/9mczGA2c4h65XX04B5SOMwY0GVg=;
        fh=AMoCKYy0bhTSxkMuE4WId0GrUptcjGnZy2I2Mber3Do=;
        b=hPYLURpcSFIkn8Lqj+jFpD8YkhaLV/XLFw6ZyXvsHmVtOkYmHzAjKsLpWuJN7lj9jO
         t6KPfWHEvJc3Rub/YyNqqwZ6ib418+RO01x8+qgXVvFDRDN7jnH+OG9wpDsH+2AW4ggH
         bN4yPdX7quuvqWnmOKoltD71uAuZDZ5cO6v76MMXhu2TrdXvtKUqdCvdNtT7iZ5o92vZ
         knzXUERHkpZdKJZ0aEN3RFZthbLdZP/TmuvlCat3rsu+mJuwViNJHQGXzPqipjAGzXVt
         v0Yc/e5oR2uFha8W1brWa6/r/x8flLCKePHNZL4iTrUHf51qDEx0gsfHcdpqLbq1RSEq
         iXAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790138233; x=1790743033; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uii4uZSwuRp1E2i/9mczGA2c4h65XX04B5SOMwY0GVg=;
        b=V3BVske5Qa+MCOp8sodg/eGavJcHj5UgqLYGP70vuq1tzseQQLWuBa9XWOTaqdhI3v
         0TREPgTCi//Zl/EfO/H58OQAr0I0o4J67P1v9VT37Cik3B+rD9aWPNYP/gWWrY8OXE6J
         pA1c98k/Vwytr0l29fRDYWKQXIVb0bC/y32L4kPx3B85qrF2xMnR5BppHHSJ6bK0My3Q
         VnsBST4yOum/rb9CO2pAQCx+1/zXbmEYpRGJc+Ec2DYlcI/0n/+IegVs2EwV5880VDs1
         0oRosdsMZ8oSVu7vQ8/sxE2lLm/G2EN+jfY1p1y72/SGK0Gm/JkFuunjFOAQgPbrrCVN
         V06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790138233; x=1790743033;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uii4uZSwuRp1E2i/9mczGA2c4h65XX04B5SOMwY0GVg=;
        b=L++9+u1QxPVHI+KwjGznyp0eDTECxMItHvOp3ykAK1SWLvSneD22o2G8l80Y3FE2SF
         fgFMiH4WfJ9MWi80gkMveggo+RV8lG3DftVdzwe+LzwcsbCpgpdYz7jY0UjisAahx27/
         EsN+RKnZcN2sEPGttZRN7AJpnJBC0uq+f7lM4SJLKzGncdTD5q9MB0IjilbLAAbUy85n
         6NeUmrGZnaUoPnLlXx83WB6iYLiHtz4T68sIZqKlbLCXZSHvqpsXAd4Vfpf4E7XmdcIZ
         yqkGr1tG8UP++ny3AiicFhy+OggZ8pRjznbcbvxm4VWBmUoJTHN6NlpOFxQigU24JTEJ
         C33Q==
X-Forwarded-Encrypted: i=1; AKwUvBxZEMLxzU6scFUhs7bLGDXlrE3NzpqPCaa41RPhD83LCuOnP246Fs8wLXcULA6NhMMiH+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kjoBq6fwC7adZJbtelRS06MxqVz+6sq5YJyn0tHa+ZsD+ccHzv
	pgMoS0zNieDrqVxdzALJkdUz9xo5DL7Oq58oBhuj5WjaCgbVWSt8Tpgb8JjdsaxfJrUwUc/R5LK
	jP/7i2Ki8Km1fE1O32pKcs6XRXoMWvPc=
X-Gm-Gg: AYBFou16vPrdGVpWQwe+MGQJdqCH0nbZwO8jmbS1w6r8TvV+OPbei+xu6krQY8KbhGx
	Y1ElKFF7qGHPJyBCZIz27xn3NNMNfJL0l2uw56tbO+YOd5cs7l4IFWjZKcoZ8hwsEptz+U0qg3o
	HCVlfgijnhtgOg8IDfKRlAeLg9v3I9W5Y8xC46VQtiQJEs6gCzOhn4by6+SzcaG4wz794uc5k+Z
	trOrmb31faLAAOERFWIgI2SWCocEyLKLgF1LmRFm9RTy5vmZruStYwJKmo0cNXb+8iTvkFM7GGC
	o2XJiKYbJtBJX1BO4Rudg+5oaxGEG0MOwryoUprcNA3zpwlx+j0sa3s/n4HdT5jxu9H0+H8visj
	sxXK9GiX/ccmhxqJjada7UemC9CpIHTzOzyRFAx22XZURExoo/rIsPdcPX1zxrCwlNMss+vHomk
	vptUO/nCRQ1WvoJ0ctco+8RlK7xmDccHq4txzkU3xeaw==
X-Received: by 2002:a05:6000:2608:b0:487:2347:817 with SMTP id
 ffacd0b85a97d-48867090ed6mr2115579f8f.33.1790138232477; Tue, 22 Sep 2026
 21:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com> <DLLHQDZBGDUO.2TT8UBHIMZEFK@gmail.com> <DLM696EA5JAQ.3DBNX7Z6DB7N3@gmail.com>
In-Reply-To: <DLM696EA5JAQ.3DBNX7Z6DB7N3@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 23 Sep 2026 06:36:35 +0200
X-Gm-Features: AclHuK97qrdHWoo3XeIrAoR5n17PHP3sC4jtIlLimYkZ5xh1HgsLbUPAvCGVb7Q
Message-ID: <CAP01T76JZUzzyr50dk0NzGv73p12v8E17Lbgy1_yZVqg3Qju0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing pads
 when bpf_throw() unwinds
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 23:44, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue Sep 22, 2026 at 2:31 AM UTC, Kumar Kartikeya Dwivedi wrote:
> >
> > I think you misunderstood his question.
> >
> > What Eduard meant or is asking, was that (per his understanding), the verifier,
> > in the future, would attempt to defer to runtime checks where it cannot prove
> > certain patterns in the program safe, regardless of how they came to be (in C,
> > or Rust). Instead of rejecting the program from loading, in such a case, we
> > would emit some form of a runtime assertion that, for the remainder of the
> > program, guarantees a given value to be in the range the verifier accepts, as a
> > very simple example.
> >
> > In such a case, the assertion and associated panic is being injected after
> > compilation, hence it is likely there is no associated landing pad to fall back
> > to and clean up program resources. Yet to safety inject such a runtime assertion
> > clean up would be necessary.
>
> In this case presence of landing pads from rust is especially important.
> The verifier would need to rely on them to insert additional run-time checks:
> if something bad between [ip_start, ip_end] goto landing_pad.
> It's not possible to insert control flow edge at random points,
> since the verifier cannot see original rust code and its meaning.
>

I think you're conflating several aspects again.

You can obviously insert aborts at any point in the program, provided
such a primitive works, even when the compiler doesn't see it. It is
just a way to halt program execution along a given path, and has
plenty of precedents (assert(false), std::terminate(), panic!() =
abort). That property can be used for several purposes, including
proving a condition true on the other path that does not abort, and
retaining that path condition throughout the rest of the program. That
is basically the gist of Eduard's suggestion.

Injecting random gotos and jumps to some other part of the program is
problematic, of course, and for that, your explanation above is valid.
However, we weren't discussing those.

Anyhow, let's keep focus on the current patch set and continue with
it. We need the ability to invoke user-provided landing pads in any
case.
