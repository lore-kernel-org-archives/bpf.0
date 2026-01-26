Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3503321D7
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426471; cv=none; b=Ny2bxRxzCkQvxAmfr1dQx3JhkZVnd1cikW6/UbiRMrNR0TRBmWxvtYRsQfEL8udpfdH5pxXk3KAEFKfbTb9IoIoSlS2EEch8C/TO5Z0fdklnns+ADdiEJYmWi/VMp2MOx003w53uGSO4rlW2Mp3QS7EI5WKhzgPe1yrDr/LhfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426471; c=relaxed/simple;
	bh=6SCDj3DaVwHwu86UUix2ZGksopNHxoXEG2KMCvUYO7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7fUKCaJoZkI5/qIB3tTSPk6OL2T6q9NjWzQGvhn01teys5ikYsUCBpz3+4zRZhVmfdkXw3xQFVITGrRIbDzvRJm+5crbY6bbRWiZqZ5BZLNOIZW5oA21XVHXaYL2jrAKxDC8WNjPjnGN/yHftA81nfLL3jAxhGYTIQ6m9HUg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQtUB3iK; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQtUB3iK"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-65813e3bdaaso7561546a12.1
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 03:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769426469; x=1770031269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uIBk01gM6FKw1rvD1ikNVpurCi/qm6pCy58lapMHrBw=;
        b=aQtUB3iKI6rAz8NMcQw3UJzlb8XHaxfbG0pdqjgE+q3Lf+7MGVu1jlS6OaBtH+CC0y
         XOft/92Pg+moj/cd/xrDygIe+1pCkq413hHdT0anSIP5vujQk9ah1rPYDjM4ykBrC4lg
         vqrv+0nXXB48Ztd8YGadlGQNov/6uzgy1SaidGQypwgpMenRgbGcDdODQ1TUqVxfwC/T
         Et0WlDlOTtN6uNRUndCf0yGYUKUKQxsCUA4wuYmq7VX55TuvHbat0dT1LELRLLfr822X
         twVxoyJw9F7JLB12cI4/BUtNaPbn3nBVw5x/hqHU1nUCqGOKMftuTTaAIkuM7oKbrbew
         3ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769426469; x=1770031269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIBk01gM6FKw1rvD1ikNVpurCi/qm6pCy58lapMHrBw=;
        b=NAUA6BCZHjoRT6kOnVGlvcqp4GXhN2+f4qhR2yT7K+9FUs9tqPwyN5P+eqzA8pRGxw
         FCkSi6yhH9PMA52D18XF2wZgkWYs0m3XBtrHI8OcFxTS80W8anTfMXYnxItUCijeIxdQ
         35JpHJdSZNo67i84ze6zthmt8e4JLw2ep89be+UB3Su0vcxUGUh+WV89HIR9gd3krSTX
         AU6vYl3ITVtDj0ARkCKqoFyp1UwTQfP8nfW+9iJOcQ//iKPG4meKG8UOQONTJLJ+QXi/
         cscjVCu3gaPZaPI9cwWbcfvMwVkFhJyzsegkJhejNph7/jTJaLZ/bi2petdbH6YtWRyC
         MRBA==
X-Forwarded-Encrypted: i=1; AJvYcCWpE9HTbUHqh+X8nJnpnND04xFufgdqTI5ocXCnjzvw3pZHBGg5wWQuTCmAZoSBTLHRJok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4drfXuRGsWDlsA7CWtNSpkFtJtbqtV9tBoQD5xhjszE3Saty
	coeKm7U4vCh0iuL4UEfqsfQQcdo90tW3jIWb4bCBJj8vgU3tKM/WLLvirCuKebRosQ==
X-Gm-Gg: AZuq6aLRTA4nVX+2j1r0yPkDiX/rhrIQwIHbmbTotI6zwNh3HDbNSZ8jukZGTIYOfun
	AKOqrv5FNOcN6r3YG73i66UnaI1fCjmd7rCCCAvr1hXz+QrBOfiyO+h456k0qfAfrzNOTJaJdhp
	WzeUlkeMIG0Vhsam3wIBfSHPVqOopKE5F7LtGBOJcCwmpcQ7k1Geu8FQVEldxI3OpUzi807Cc+d
	gMClBQHbrbOndgxEGXJ+I+M2OCoOwdJXy5f/xM6nZax+kSXQcQStg3/1DIYim7g+uZ1edMt9nhp
	vnUSpn4t+IgiFKP702ronLOBu8biICjNImFCWnGLBeuQVFviLWuPisenAsiKLkaqfqgvLVYoaMz
	SBGLddNBv6OYqVyEkwGUYcAm7DXSNq1XnQ6LhOpD062N33AJtRB6UvjypmdT53S7CLjogEkTVYF
	gEDrnVETpG7uHgs7e2yk839wnT/YKtuw9mi7NKFuKO3+xmmhVN9/U=
X-Received: by 2002:a05:6402:4445:b0:64b:a3ea:5086 with SMTP id 4fb4d7f45d1cf-658709fcd0emr1915941a12.12.1769426468436;
        Mon, 26 Jan 2026 03:21:08 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b92b66dsm5234876a12.20.2026.01.26.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:21:07 -0800 (PST)
Date: Mon, 26 Jan 2026 11:21:04 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
	jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
	david.faust@oracle.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 4/5] man-pages: document true_signature
 btf_feature
Message-ID: <aXdOIBvo9rZLGn-f@google.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-5-alan.maguire@oracle.com>
 <aXc7uFtOhE7bSZnw@google.com>
 <e7345200-ce29-4077-9d2f-7d7e4b47ca79@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7345200-ce29-4077-9d2f-7d7e4b47ca79@oracle.com>

On Mon, Jan 26, 2026 at 10:51:31AM +0000, Alan Maguire wrote:
> On 26/01/2026 10:02, Matt Bobrowski wrote:
> > On Fri, Jan 23, 2026 at 05:26:49PM +0000, Alan Maguire wrote:
> >> Ensure non-default "true_signature" feature is documented in
> >> the manual page.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > 
> > Acked-by: Matt Bobrowski <mattbobrowski@google.com>
> > 
> >> ---
> >>  man-pages/pahole.1 | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> >> index 3125de3..90a8f45 100644
> >> --- a/man-pages/pahole.1
> >> +++ b/man-pages/pahole.1
> >> @@ -337,6 +337,11 @@ Supported non-standard features (not enabled for 'default')
> >>  	                   of split BTF with a possibly changed base, storing
> >>  	                   it in a .BTF.base ELF section.
> >>  	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
> >> +	true_signature     Encode functions ensuring that binary-level
> >> +	                   (rather than source-level) signatures are used;
> > 									 ^
> > 									 within the generated BTF.
> > 									 
> >> +                           for gcc these are ".isra.0" and ".costprop.0"
> >> +                           optimized functions
> > 
> > For BTF generation, would there ever be a situation whereby we
> > wouldn't want true signature support? I'm just trying to understand
> > why this isn't defaulted to true.
> 
> The key reason is the "." in the name for gcc-optimized functions
> "function.isra.0" ; older kernels will reject BTF function names with 
> a "." in them, so we have to guard against new pahole with the feature
> enabled by default being run on older kernels. So by having the newer
> kernels request the feature only we avoid this.

Oh, yes, that makes sense. Once a new pahole version is released with
true_signature support available, will you also be looking to update
scripts/Makefile.btf and conditionally enable it based on
availability?
