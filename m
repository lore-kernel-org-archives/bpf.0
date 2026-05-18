Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D8381AE3
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128011; cv=none; b=Cov9ORSnZV0SNiPoWQS8928QzGEI2yFgwYvUItIYyySxpiAg1BjfqOrmO1I//B+1v91t+MN9tHaQkerM4pZQ9/Mo6LMqfFjWQD4CAiX63RCkVttA/bh+z2GoX35UslbSlCW7h35I3XJQQm2po4hpb6R9KChzeatVZsH3aRiWKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128011; c=relaxed/simple;
	bh=LvaFAT8Tk8IvuNbiwwUuWT3PICxar58xbElnDqoyo+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd8VbAuTLaazKnJWcPlGAUWddPQlMTSWXVqX+zOTggLvaYxQMfEwIZC/It4g43wQJuSREMxpgFhYbD8EVlwuoT2bZIPpan96MB1qL3HBSIzj5lg0QzNd/DHRJtGA7RiiyL9IgmBXN7hsb3qAxZVPxAP1ytTw8g1ROz/T5drAFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRElvCDd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRElvCDd"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe608cb92so1620593f8f.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128007; x=1779732807; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2SkNQZ1eRpX72UK8FcYhuc5kIn0Q9OYKn5Iz6nc7pug=;
        b=kRElvCDd8poP9SQjSCh1ijS1LTA5IeQYtIjWht1ich50MKSbL5Cc5Hm7KYwq8L59Eo
         PSuX7nzWubvOfKIkZ+xsjJVTqkjT3MocEKCvlmT3e6EzVtar4d2akWrO1FfhNlxns4sk
         RmRlNB7lRKaMyPuUz3MnmZkiEvayhJDNCVoxhWTEb68QDGlROk6ej9kP7gHSpbMiM/rb
         A5WgzfliratOQHZGUReFYzsbw7Y9mt6OMSaUCwJ1dnfVwHSRwHi52LVysRbPrS+mCuSu
         2duarqUBA3b6xruN1+2Q6TZQ1czW4/mzdK4zt6uuJ5CTEiIhLCZpkrhcnh1Xo5TyF+9c
         KkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128007; x=1779732807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SkNQZ1eRpX72UK8FcYhuc5kIn0Q9OYKn5Iz6nc7pug=;
        b=RleKgLWzKF+NbEOyat4QPcPj824sHVg5/FBr+BY1FnPx/W9x6ewUj0bwtkJq2prIdj
         nncNDVEWfDu4JbTQby3jbuTjgsP3eMJdDOknBzr4awIEEvTpvqUP8+HowqNxjL4KhK0B
         /MKxu8tsKcnrdW3ojdi9UVv6LWzmgLpyVXuSNTHk0vwcgBRkpmbtv0+kGCTmxy7YmVO+
         4J6ICOndHDKZ2lW8ucarvHKpXvTH/Rb9inhCXqgJpu3VmkUvI8boatXVxweFK5oEB0nN
         D88ksmWNuC03URYcOR2QNNWnAbu6Vu3HaUWGPOZ7hycpaeg7eqmR2tlZ57c1qbYjvX9n
         d1oA==
X-Gm-Message-State: AOJu0YyLTVo6z+iy5X5FDbM5cj1bR0cl2iDLtlRo+3TbYapOKwcySDe4
	mUsDA9nX6q/9ddjCWZRy96XT80bAxDwN1k0cKADWEfgUJo6zlFy5qFZwQfBpPu9OmXPAOKVZ
X-Gm-Gg: Acq92OEsV0Nf0s+wrOg9ErwzWFCW01ALYRmGUdi338uisQRDcz1KD1sHBjYXoJXIbJY
	MY6lmsnEsPn2GiXTPgVYtIkuIChOFOKNIuhA6ML6ZlffU4uiT/BWweGz1VIOYFiJ4E1uqrqwF8y
	Rk7sJ9HNKM8u+0kwys3vGGoBKj7hT88oaIHa8Ovtt2c3KK7JCAtoVoL/82KdZzTj9bwfKKs1uok
	aknnZev1EDoaYm9nwM4Ma9akl5LSBfgaNi5S4YRKsrdZkoUJxApaK++hxaqrxxvBgEjFUneHvOj
	99g7+jzUFgSyCHXTSiT9NdVJ5YAilui8Miu2U6Ayp0Jdo6gRDcIh/cwuEi7QmuB7QmE8xGzwDQX
	d2odFvXs2w5ttwG+hVQvvTF532pXtOmsVINau48Mdid719ci4ZF0M4nQqoV0pS1TuhbK9v5xCMP
	/psMtft5J6YM4+n0xxI0lITipnOizG9x7kUf9kx8W+tSneB010AsgSKjdwkqgGw9yS6A==
X-Received: by 2002:a05:600c:1e24:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48fe63182a2mr254168315e9.26.1779128007125;
        Mon, 18 May 2026 11:13:27 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fcasm250953405e9.5.2026.05.18.11.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:13:26 -0700 (PDT)
Date: Mon, 18 May 2026 20:13:25 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 5/6] selftests/bpf: add bpf_icmp_send kfunc
 IPv6 tests
Message-ID: <agtWxQedLwq1X-Rq@gmail.com>
References: <20260518122842.218522-6-mahe.tardy@gmail.com>
 <20260518164538.21D3BC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518164538.21D3BC2BCB7@smtp.kernel.org>

On Mon, May 18, 2026 at 04:45:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Buffer truncation and type mismatch when calling getsockname() for IPv6 sockets.
> --
> 
> commit 324aeb5b326896da717647e51a1e69a4c3e6f647
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> selftests/bpf: add bpf_icmp_send kfunc IPv6 tests
> 
> This commit extends the existing ICMP send tests with IPv6 support.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > @@ -81,14 +95,13 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
> >  }
> >  
> >  static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
> > -					    int code)
> > +					    int code, int af, const char *ip)
> >  {
> >  	int srv_fd = -1, client_fd = -1;
> >  	struct sockaddr_in addr;
> >  	socklen_t len = sizeof(addr);
> >  
> > -	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,
> > -			      TIMEOUT_MS);
> > +	srv_fd = start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
> >  	if (!ASSERT_GE(srv_fd, 0, "start_server"))
> >  		return;
> >  
> >  	if (getsockname(srv_fd, (struct sockaddr *)&addr, &len)) {
> >  		close(srv_fd);
> >  		return;
> >  	}
> >  	skel->bss->server_port = ntohs(addr.sin_port);
> 
> Since start_server() can now return an IPv6 socket, does getsockname() truncate
> the 28-byte IPv6 address data into the 16-byte sockaddr_in structure here?
> 
> Should addr be updated to a struct sockaddr_storage to safely handle both
> address families, along with a cast to read the port properly?

Duplicate bot review, do we care for reading the port? I don't think

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260518122842.218522-1-mahe.tardy@gmail.com?part=5
