Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567342F531F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833274; cv=none; b=A5V5JbFJIGAZkCi23MbBicnYZID+MBD6HXeoIhgpgHHzAst1tkNPHN/Mlli9f2X1hEs3S6UeIh1fvlfTsvU/eIWTsSRrlQ9MO7RepB4IQd8HHZWPSBudUxWllTN4BbMfICDEyRzUfdopbM9M8uBar3t9Fg1CTQufZ3eVgMgwFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833274; c=relaxed/simple;
	bh=glugTUUtq2vW+OhlBhdujo7uqVawoDJuwjsODXI/Cd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIZOFph17vpNdU+BVrbk+BqYNuPOtRaOQae/0s4bmMiLXOJA32jRLUdBlD+0n1FUsYsG31W+hutkdrgOnQoPg+03hL3clehYQKvdTMYjxgDCxsiXgO7NHSdi2WKKdqUrIBRgl4HLAM4LX6d4EwDNjlLpSOSSioP9aTAzaQThvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiiztjQj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiiztjQj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso57599235e9.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779833271; x=1780438071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BauVnyNJJhLg6EtseSLWNHqErI/TT2/1wQejCvlza8A=;
        b=KiiztjQjYxZpT0qgNl1EsxWNyOu4UzyeRCaqIpeBoarDEajvpw1EIOVU69dtWTHMVq
         aN3luRmf9civkoPHtj8hUHqMEw6AKGbx9YvbQ075iuM/gJTBfBh7WHER91yjJntKaAhv
         NlyVeGmDQEqe96WagsIZKB0UnxFVK6F5wjMuSHQJmeGXDEdMNzD4VegqE7HpqszTuAyP
         ZMRjnvELs9XzXhxvhOvpUr/5NMnRUF5IUSc5xzmWX8P5o5h+WWSqn6SUbdXzlNXjObxY
         UXt3zoGyR1sND3TpU+XX9rmC3FtEA/vrVUm9FWRtDT8K1bqoderPyxr+A4RWXtHVMBhE
         FbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833271; x=1780438071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BauVnyNJJhLg6EtseSLWNHqErI/TT2/1wQejCvlza8A=;
        b=H87oHiwT+jnqbV8l15lZuteNTq+0hnjsY+v6ZWqUgbDhEFlsvpetTj3fTCM4vHSGwq
         FeEFJTmqTHZowcgxbHNbrTvA7nQq+4lvq0NRCoItZOFtE1ZF3dpR/HISyrqBTgVzW0EF
         Ka+VPQorPL10dngXmYmNnyP2NyYsl8YC/X/h9HuRWiDbBC9t64ZG1OTTX0Ojlg2MAW45
         tkcqNSAJJivaw9IgdvBowMK4ViwqocypM0efaCH+esF2ipn+KJK2nH8Wjn1n5HgVdsTN
         p+Z1Ip4bwrtDQyTczp2o3oIRe6OZmfA99UgxO3LoO0ZPfKK80oJ8eN2fZnmBmmu2z43J
         SiYA==
X-Gm-Message-State: AOJu0YzduVQy6A/L9FW4kj81++KA+kW4JVzGQy5xo4WHKlAFG8IBRm/D
	sg/ebHnFByOVz3mjssjvILhjhugYA5ZCs0FMadbhGAcrlTplF25JJatLJcnwJIw2DLE+DQ==
X-Gm-Gg: Acq92OHQeXN41V1N9+AA8ZZ0hnf1Uz+Ryzcma21DgiFsrCuytHVhuiWeMWd6gL5oIxE
	ySwmh9KKGAd1yEjC5YGPL8qC3VypGW2Xmb+wmxqDQLUMXNxjDCaHLm+B7xGvRTxL+oIex0UKqdo
	vcy6FLVsUwEwABiu4JlViqPUd6fiSOykMHxey2pqeqDYqB4QDTYNn0rV8qSmGIHa9xKwngCm980
	D6moQsE+MvGaYoo12iniH99PbTWpX1UZobe0yR2tGrK0B4rQP2cm9Cd8bjzooM1qeW6GNNaZmUg
	jn1EM9Y90s9zv9881ipDsCHuUI4sOmppXmxfYe3yBitiVltjbCznsH3vIt+wJxiUm/zlUUNpH8u
	IHYskV8b5IHVpUZbTexMxkjeGpQvJFAutUIdV3GejfZi1jhTgYI0HLxLwGPUuTR965BkHUhg3kp
	aZEH/QWMBsI+RHdVBaSJWuh6YiJ7M8V8lUoNnnRrc=
X-Received: by 2002:a05:600c:8484:b0:490:3b87:be0e with SMTP id 5b1f17b1804b1-490428e3362mr349669215e9.29.1779833270597;
        Tue, 26 May 2026 15:07:50 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:488:3510:15a1:dbd2:86bb:c4e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561f2dfsm336341015e9.12.2026.05.26.15.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:07:49 -0700 (PDT)
Date: Wed, 27 May 2026 00:07:47 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 5/7] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb IPv6 tests
Message-ID: <ahYZs1DJfnWHtiG6@gmail.com>
References: <20260526153708.279717-6-mahe.tardy@gmail.com>
 <20260526193248.B92CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526193248.B92CC1F000E9@smtp.kernel.org>

On Tue, May 26, 2026 at 07:32:48PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Type confusion and address truncation in getsockname() due to using struct sockaddr_in for IPv6 addresses.
> --
> 
> commit 0cc9d08ecac1ed3d21b7e5cbf50d68e27cb610de
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
> 
> This test extends the existing cgroup_skb tests for the bpf_icmp_send
> kfunc by adding IPv6 support.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > index 0dc6b6ceafb4a..1d6900d6a8f8c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
> > @@ -79,14 +94,15 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
> >  	ASSERT_FAIL("no IP_RECVERR/IPV6_RECVERR control message found");
> >  }
> >  
> > -static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
> > +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code,
> > +					    int af, const char *ip)
> >  {
> >  	int srv_fd = -1, client_fd = -1;
> >  	struct sockaddr_in addr;
> >  	socklen_t len = sizeof(addr);
> >  
> > -	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_MS);
> > -	if (!ASSERT_GE(srv_fd, 0, "start_server"))
> > +	srv_fd = start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
> > +	if (!ASSERT_OK_FD(srv_fd, "start_server"))
> >  		return;
> >  
> >  	if (getsockname(srv_fd, (struct sockaddr *)&addr, &len)) {
> > @@ -94,6 +110,8 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
> >  		return;
> >  	}
> >  	skel->bss->server_port = ntohs(addr.sin_port);
> 
> [Severity: Medium]
> When af is AF_INET6, does this cause an address truncation in getsockname()
> since addr is defined as struct sockaddr_in?
> 
> For an IPv6 socket, getsockname() requires struct sockaddr_in6 which is
> larger than struct sockaddr_in. While reading addr.sin_port happens to map
> to the same memory offset as sin6_port, could this lead to type confusion
> if the address fields are ever used?
> 
> Would it be safer to use struct sockaddr_storage here to ensure enough space
> for either address family, similar to what is used in connect_to_fd_nonblock()?

I already replied many times to this point, I don't think that's a
problem here.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260526153708.279717-1-mahe.tardy@gmail.com?part=5
