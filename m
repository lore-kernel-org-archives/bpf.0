Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391E3BB680
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222986; cv=none; b=FVKvQw0Z+fP4Xh4v6Gb7AJEdnoa6xk3wPSpj7ZjYOLYFZhqN/egQOgIw1kahLvn/tbHn6dOqm+KF0lVhDQT5vkgtNWJM1vz9vyoVyU48+rhnTOL2G4MRkJUbvuxgCLzTWY6x5202nwUkxyxkAnYV6iGBR73Ar7Fk7ENsfeGxEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222986; c=relaxed/simple;
	bh=bTJhmnPHVQfDLE6i7BAsrj3KavRtwvPpOCW3cro9GuM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpOqX5GFL6r+78aZZ6VXaJaXOj7X7T1otflQWlY1VE7YxnudFBLaAv3KQ0fqplPbsna9d6A7UIIUAoCSVHfpgAAbmqQGAy/5S+qz6tGxM/N0oUSExAPwFktNXmukL+hjb/Qe9zjZsFwvYLjQbgvymzQVXomziLyhthFSYX6kLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no5bmojd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no5bmojd"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48896199cbaso32817085e9.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779222983; x=1779827783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCuUQocKta2y9pjLLvcUgr8BdZJVTFxHLIXm4C7A1E4=;
        b=no5bmojdHMrciCSk48aeL5n5vE+XszXsjK9TmZCz355X+V3T6YVTA9oOe8oJxNjIVW
         5hcXLbLN08cISvK38R7AJqTtz5hYZ1leJ7socoaKcnkVmxB9QQqDqPNt0KgagDlbfzMD
         Sn2GLgdy89IA/PNaXJ2cFsfu0HTbROZ4/QXEgk0tV4IgP/83uqVhxNLlzwGSeKXW5ONO
         wYvPnlySBAxdpQi8Q8gIg8tQX97A+vek6J6KavRrEn1fJVqnq4AEK3zQ99bhzimoCeO+
         gA9Yu6KlYuCAzar9spUOUkCgzVsb3IWuwAolEB1TEsVTV9CWiqvCumVH4pKx0EGatyz6
         dDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222983; x=1779827783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCuUQocKta2y9pjLLvcUgr8BdZJVTFxHLIXm4C7A1E4=;
        b=AstsUrHkZlfaBv0GDpZeuMiFaAFtvpNpnIfN11FMyGSdDTPVp1XtBv1pfrNZW2qg/E
         f4dBHO72Z/R+vtNMitnIpz3Vv9wrAQO4vjYz5hKy77QVIPviVYANSRgU3k2fsMNgfTuT
         yJbQhepDCWp7YqzX+3UJPu1m3ibSy0XVUdTb5PIudfVcQBliPHRQmdl/tgQEavDnbOko
         vbZHdybtCIrX5f9BLqjvpDx98Au5qpDuc2nPm9RH30E97gugzKn4n68PFvBxOFtRfxX3
         yBqx+++NSJEPQJj860PevUQqk+EYqEF9YV6XuoNT7zdipv/lGR1ePyN1TyPFdS8jZDxl
         XMNw==
X-Forwarded-Encrypted: i=1; AFNElJ9VatPo1nIMiv362InQEPVO6ZM5FO7x54q642eCryZFVuVM/cs/gsCsKxuclBn+SGxMO7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywftd5lrHZT/uvEfv5ASfBh53cPLvPhzLS/jUeW32BY+Xnk8NUo
	2bSiXr6Z53IqrJmPOdFdD6Z4POe8Sjipkb+DvZvPRKsAU7/LTuUuxXM0
X-Gm-Gg: Acq92OFmwrzz1YaZdQ53oNQsoAGDT0aCqPyn8L+p7MO6rD5F1ZEbowskMFimHRWnmoM
	wzMJt5y+WqvAkPExyJQOTIzOJMSB7j1cprp20G8golUa9uUpwvS9Evb/B6heja+hrOQzKDlJ3tK
	UowDGmq5ZbBFRxSyV6lgKUMePw9AW3uEOBkHuOcA21vftl+LaqSRt88rbswHC3DDjUwLZAolTCv
	uv4Xdb3gkvCl8ty7mHVpQtZGtX47HcynV1iert5KF0brbLTg7njNV/v58/BPu+vQ8Gm938Bxg0L
	LyZcyS9JxMY2CR9Cs9FC6DDdlvI/RiSdmHEmCG8+39zQQ+qOa+wMOMsE09bmUupCZMHWLkszNjh
	zJ6dJhayGKGGIpU05w31hs5DFsJWBfgovuowNzQJIyWDMh+ijP3qKL8+OYdWGdRfITVY0dLXZCH
	A5+pXnLnPs6fQ=
X-Received: by 2002:a05:600c:4a1a:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48fe6325f25mr198421795e9.17.1779222983139;
        Tue, 19 May 2026 13:36:23 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab671sm357371335e9.1.2026.05.19.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:36:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 May 2026 22:36:20 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, jakub@cloudflare.com,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 04/11] libbpf: Change has_nop_combo to work on top of
 nop10
Message-ID: <agzJxADwIdwta9nJ@krava>
References: <20260518105957.123445-5-jolsa@kernel.org>
 <a5a57eb9690a537c2d8d7ec619fb1d200c9fc804436ae085b9344b691c2470df@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a57eb9690a537c2d8d7ec619fb1d200c9fc804436ae085b9344b691c2470df@mail.kernel.org>

On Mon, May 18, 2026 at 11:37:58AM +0000, bot+bpf-ci@kernel.org wrote:
> > libbpf: Change has_nop_combo to work on top of nop10
> >
> > We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> > fixing has_nop_combo to reflect that.
> >
> > Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
> 
> Should the Fixes tag reference commit 5c3c59c7952a ("uprobes/x86: Move
> optimized uprobe from nop5 to nop10") instead? Commit 41a5c7df4466 originally
> introduced has_nop_combo() with the correct nop5 check. Commit 5c3c59c7952a
> later changed the kernel to use nop10 instead of nop5 for uprobe optimization
> but failed to update the libbpf has_nop_combo() function accordingly, creating
> a mismatch between kernel and userspace.

keeping things separated now for easier review

> 
> > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index e3710933fd52..7e62e4d5bedd 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> 
> [ ... ]
> 
> > @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
> >  #if defined(__x86_64__)
> >  static bool has_nop_combo(int fd, long off)
> >  {
> > -	unsigned char nop_combo[6] = {
> > -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> > +	unsigned char nop_combo[11] = {
> > +		0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
> >  	};
> > -	unsigned char buf[6];
> > +	unsigned char buf[11];
> >
> > -	if (pread(fd, buf, 6, off) != 6)
> > +	if (pread(fd, buf, 11, off) != 11)
> >  		return false;
> > -	return memcmp(buf, nop_combo, 6) == 0;
> > +	return memcmp(buf, nop_combo, 11) == 0;
> >  }
> 
> This isn't a bug, but Jakub Sitnicki suggested in v1 review to use
> ARRAY_SIZE(buf) instead of repeating the scalar value 11 in multiple places.
> The suggestion was included alongside the Reviewed-by tag but was not
> addressed.

I think it's easy enough to keep the number

jirka
