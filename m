Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF835CB61
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101386; cv=none; b=B61hHg0CWvc/nPH+7SAfMfEpq0J835xgZ2LDW0IcIuWERpWjbMTV3JtbQ2D7dQsdMPXMTN4f44l7nhuRfO2Pa+enmGx7b/bLpPXqhoD2zo+W5syWgBoxELzu+SNGJd5eUHPTD9by4NNFU0lcwMANsvxWPapjpeEDVRMct2J5mZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101386; c=relaxed/simple;
	bh=+eFASHBUKj/vmGIDzXzaILBDEJbb+2jzsRnnlxOyuDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XckdUtA79t2T0xIypV7AyBGxgHgeSa5Y0V2YshF9B3Xckd6LZP6UqzBvynj0Tw8YL2oAXTc4axBiXlS9WDkQ3jOgtOKHro+59nh+uX4JUYXnUIvs7JkhGg65GZGDGeEdTEz86b1v2h9qAyaAE95ojykaMa/+fHBEBP2H9YcE0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcCZUuNj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcCZUuNj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso14110935e9.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101377; x=1779706177; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmztjgxnBwyFFAmNOF4gqLXbhTNy4nJS+u1BNslkG4U=;
        b=LcCZUuNjWfCCpqBOLIF5Grm/7SNxZtfJMFHbP+cT6WltvnePrVYY6ebaJ+60Y5oaQ6
         L0hsPk7aOenw4HYkhbZlVaD/O1s8YMtmvV7P8xoOd7VRtEXcsUchlqDOeIJPnDPZlqVi
         rGgtR2ia2uWV0tt8ORtoVWOFrld4vGdMefOLzyya4Eq7vv6cYrtd62O7AuRRno9l9S5B
         Sn3kxryEx1rrmShGH7WoSpLvyIX+qX6g66+n4rWky7x+pG3DnwVmPfjp50W28XiLDcQm
         KoFXJkYt5dEQo6b7a6DOphNOasrH/jGXQu8BMf3JSa8KS2QxJISmEU5PvOE+YHahNUuy
         C8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101377; x=1779706177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmztjgxnBwyFFAmNOF4gqLXbhTNy4nJS+u1BNslkG4U=;
        b=nTG5S+HxG/X/nWjruEQ3ybSmZ0p5cUlfhFcWmzRnGqwl7VRthQiE60FnvyB0/syKgc
         G08XAz8CMZhriXTPPBsILngdFLUy8Xbs7PhOLGwTObbKj42Jmg9TcAkA5pIZxrYaPn6i
         8nG/wvL0WnndhmMwjJWJ1Bz83lWZQskCeBQl7Kw6YgHymgiUqd0xSjaLYtJjhknTDPbg
         vbX4FEEO3qJMxjK/tV9sp0pj2zOUB/usFVTtKQ9WSmPQeGOrG5DPlmBe7tgWK6gP++MW
         Zsr5XFM+TXupN8SF2PYvvCjaWtojWBF1EPR9jlli8DvFYwcwu8ORbJ/mLinPvJRVJqzL
         JTEw==
X-Gm-Message-State: AOJu0YyZZc8ZCORInD0SKTCRB1dRUw2ItFng/KiK02YZTrmdAoy9jISp
	4zAprIK8JmZgexKF7CbI5Q4VYICYSuXZa9Ou4/+jEi5qzbJeU/lACG5aOK/nFb+y
X-Gm-Gg: Acq92OFI2UWzRbRVI/OybRbaHw2BwU+8aN55Ncdpzwk/3PG5arEYUmCb82LuS4JjtYS
	54F178thuLk1yveLARP/Rp7+3xHsOpfufnu9ZoLKcHpR7iA3wxADPvjXTV+M6dfjR1HwrdMIo4i
	ptZXMMPNIXk253b3z9cXpw4yHQHsVuLV8vR17dKP4xll3Qom/KnuJ0DuqPha/zHELg1ldLkZRS1
	xad9p/HLSAPW222t+iQH4cqNOFKpfZG+RLS6FOS5eyuAwUqjoJe4rTCAVSwJuAgIRQPb1+ATR7Z
	mWGIImPDBoo45+9N7np6r9FxaDX/iOLlmF74wY3gK7x86UWN2S6HjsV1XGkp9mZFMrcGaOSNd3w
	l/1MrJG1X/tFLvbSk+ORT4kGDFvMStMpoE5ucMl0QzFMH0fBz8u1q0+QhMGgEVy0sC6wgP9qbg7
	npcTChvFe3XmH/VYmhhPF1y3P33OTzpH6LGwRCI4I4v8m6FR7hY+8Q82YYj9oN
X-Received: by 2002:a05:600d:8448:b0:48f:fb0d:8d86 with SMTP id 5b1f17b1804b1-48ffb0d8ea0mr127495825e9.32.1779101376640;
        Mon, 18 May 2026 03:49:36 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm37534481f8f.29.2026.05.18.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:49:36 -0700 (PDT)
Date: Mon, 18 May 2026 12:49:34 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: add bpf_icmp_send kfunc
 IPv6 tests
Message-ID: <agruvp6BaVzUWn8q@gmail.com>
References: <20260515194746.50920-4-mahe.tardy@gmail.com>
 <20260515204444.D8204C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515204444.D8204C2BCB0@smtp.kernel.org>

On Fri, May 15, 2026 at 08:44:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Buffer truncation and type confusion when calling getsockname() for IPv6 sockets.
> --
> 
> commit 3f16e831f177058fc11380fe48e08f94594b83bf
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> selftests/bpf: add bpf_icmp_send kfunc IPv6 tests
> 
> This commit extends the existing bpf_icmp_send kfunc tests with IPv6
> support. It updates the test suite to handle IPv6 connections and
> ICMPv6 error queues.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > index b98c0312adadc..d9badfc6e620c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
> > @@ -78,14 +92,13 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
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
> > @@ -94,6 +107,8 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
> >  		return;
> >  	}
> >  	skel->bss->server_port = ntohs(addr.sin_port);
> 
> When af is AF_INET6, start_server() creates an IPv6 socket, but addr
> is hardcoded as struct sockaddr_in which is 16 bytes.
> 
> Does this cause getsockname() to silently truncate the 28-byte
> sockaddr_in6 structure because len is initialized to sizeof(addr)?
> 
> While reading addr.sin_port happens to work because sin_port and sin6_port
> share the same offset, would it be better to use struct sockaddr_storage 
> here (like in connect_to_fd_nonblock() earlier in the file) and extract
> the port conditionally based on the address family to avoid type confusion?

I don't think we really care about this since we are just reading the
sin_port.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260515194746.50920-1-mahe.tardy@gmail.com?part=3
