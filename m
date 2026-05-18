Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA03F58D1
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114445; cv=none; b=oJXfEUu6hp4mM6paFyyyZ7SER8jtgTcwFpwg5zY9TkPNhHsfIg2H4cEFZJWCFZob8hvFwcwhoaVQSAEuREGg6pSzxagKM000cczyYO5tJhf6EYBSyUI1f6fohWohnVU/uJ2pz+AM2vz/DTYPEEVxQkPAGa6eETCj2MnZpWmoWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114445; c=relaxed/simple;
	bh=7/5JbgXtZakp8qAu9fde2pP1hH3kxzyf9U26Y/nySWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEU9vt7rnexny6qfZhX1WRf8DIZZKwVN3mFjD/JoZaeOHqe1rFAlq+UCTuCAgMui8cTcfdANbedn94aEh5RGWCVM28lQAFmSAkgb4OIqX1VjWTHANbHnd93qRRRnWapNLGPaoq+ngBlwudw6yDM0wWYug6KzXCIbf4LSjs+aOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSIV/zeM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSIV/zeM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-441209fb77eso1362699f8f.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114440; x=1779719240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBsBNTtwVI2xNlfHzXc+UZ4Z+a3F93xqGI/4FrRRBuk=;
        b=YSIV/zeM5KSPwQCDxE+MQAEC5QKx33TQ6w0zX0n6zXiVCuTxHeypqKlYqo0gobK0hr
         hYY7yAt+2zbse6xZ6BiiirxaxSZwOBDVZo3KtAMjge1dMEVuHnIjWilHa7zC6WQ2XuxL
         LNzLppQEVcFR58HN2ocepMUR3oz1cWExV6CswapaL+xis2iWccF5tqbiDaZEmPX8ZDUA
         2sxcXxklmIH8ozaOGSaP4Hf60LbcoqYt65aTZLtDDrptEIzQpJMYO/JB5OgNomRgBez+
         xxYPs0MLZ355PNO2N1vPrZy3xTxPlRv4cf4aUpYw5vmVpZXA2gl+uJrbozGKpM3/IBe8
         H+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114440; x=1779719240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBsBNTtwVI2xNlfHzXc+UZ4Z+a3F93xqGI/4FrRRBuk=;
        b=JP+68Bp80r/mjMii6A1Pn2SHdjU/fgTw3sT0YUnnXRtXNzXSRLth4EtQbztXm1uXD4
         O2CVlOfnDLJwR8srh2EGuaMR6xqABtrL6SkEjxy6+qg1OjiUeoIUSwoXmCfgztXKiH1P
         3PxC7S4ye7cs6CFASh94CU67wYojC8xsty1wuoFgQiXVt21T+jKYzlaijBxHcsMfzihb
         wD5wTwhnCSrd5RyszjAcrG+2j7TP5PVEFfwW+NjvqwgIiSYLRHKo9KZVqCSlvw1SDAfn
         hjaikBWRhrwkbMXywbo3yhcY9jVVMhUpxH8/s5IbX/IlVtl8gZGQsD733oRIZZfyM0VN
         UpGg==
X-Gm-Message-State: AOJu0YyjJaC3Sme/ERb+BoHAntc7nXr+mwPJekHiMP7BTKFExOHzBh8X
	CpV7onxto+JjJtTlG0MjkoPq95CtxPpMYv1lZPl0oYJLYiqxLq9jqI0hDeYnDbvnJ40PqQ==
X-Gm-Gg: Acq92OHYhbrqs/YNAepb6cQBYVqkJVi8dvOXo9tbKCG8D7i13i7NmavQZUgdidlJufb
	GnPTzEjueipNLu0gvNvoTEP+xCH8ZJD5hjMUy/hJxDCLR/tYztxPoOj/YKN1g976ef16LbdZsJl
	yKcYoyhYtphjBuowEFPysPpl2uAlr6T9GYBoC3HrbY7uytpiiiYhwZ3B0AGlErfUPX8wvVJvdhs
	Pkb/T2nnxtwkheIj0DGQiQ6cbRv4fkUkG7241pljCP7J0mTrjQfpQu2qNCVMa9Q88XyDHOhJXjL
	4+10v9DRfdT5GvT5VV0XkhKiwo/zmYcLGLkIXR56Z1EOvU1GEmbzMlxrqWGUTXM2NYi1BEu1BlP
	gu6oZNdmwP9cAxWj+ydmdfMVLLMAf+TYEzeGTT0cj4eor2Gg2FOoAQujqHGeZmmAH3Z1WhAo/Je
	259NWzgRfJJyAtbx/+thQkXbcnAUJWAXPykyIV4aJuLQdY4isi4TZ4NUU=
X-Received: by 2002:a05:6000:2087:b0:449:31ca:5e53 with SMTP id ffacd0b85a97d-45e5b75624cmr24344453f8f.8.1779114439663;
        Mon, 18 May 2026 07:27:19 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9adc2209sm34825331f8f.0.2026.05.18.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:27:19 -0700 (PDT)
Date: Mon, 18 May 2026 16:27:17 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 5/6] selftests/bpf: add bpf_icmp_send kfunc
 IPv6 tests
Message-ID: <agshxWX7r3pDznKC@gmail.com>
References: <20260518122842.218522-6-mahe.tardy@gmail.com>
 <f1c34c53dbda338bac68cdcbb48197412e542040617d8bd04c7c94a0de052f1a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c34c53dbda338bac68cdcbb48197412e542040617d8bd04c7c94a0de052f1a@mail.kernel.org>

On Mon, May 18, 2026 at 01:21:35PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > index 4f0aed8152d3..d0ac0502f6df 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
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
> 
> When af is AF_INET6, start_server() creates an IPv6 socket, but addr is
> hardcoded as struct sockaddr_in which is 16 bytes.
> 
> Does this cause getsockname() to silently truncate the 28-byte
> sockaddr_in6 structure because len is initialized to sizeof(addr)?
> 
> While reading addr.sin_port happens to work because sin_port and
> sin6_port share the same offset, would it be better to use struct
> sockaddr_storage here (like in connect_to_fd_nonblock() earlier in the
> file) and extract the port conditionally based on the address family to
> avoid type confusion?
> 
> Note: This concern was raised in v5 review by sashiko-bot@kernel.org,
> but does not appear to have been addressed in v6. See
> https://lore.kernel.org/bpf/20260515204444.D8204C2BCB0@smtp.kernel.org/

Also I have replied in the v5: I don't think we really care about this
since we are just reading the sin_port.

> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312

