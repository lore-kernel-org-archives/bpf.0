Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CD2931D7
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056884; cv=none; b=EwLLk/sQ5InJsBQMBP+d5n6apzHaf/E7kw+vdvdwp8DQp1Atwig3jeFMJeLEYgVDx8bCkFW8releMJuio2Vb6bjfw3gZrMKf+LPuVlTw8QSOyAMxU+yjcB30R2neJzBYjUZ2VIfUIKgroUDdqk09Qi+/+ouO/xToE74bNiN+w8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056884; c=relaxed/simple;
	bh=tWniBlvSYvLc9mXjbuv76SfuUK88aGrLRBkLHUZFF10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCA28be9nBzSTsX5I1N0U8W6e7i+XedXycWP7/gtx9Fzx+kIkQoxr9piSJppynxXpZHkwC/apvn8o6RHJUmLruvcp0g+JQsLCpGRIm9up68ClFQhUtkG3XZxcoYtCUUY7tz41hy0cyk7P76gueUoSnesvSE5Km1bOBkt3Ed+kcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCt8Lfj2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCt8Lfj2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc891373e0so56233655ad.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056882; x=1784661682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mHy8t4zKOYGLPi7aUYeTB15EGxexEveRnk5KK7uTm0c=;
        b=XCt8Lfj2mZnBma3+2nbP50NeVeN67/4hD9v4Dy0VIb/Vifq1ftMBeRVCtEtJ4KJ86L
         SBDTKo3JpVRSRZOUD4x/z+7l3MGMhaxgyQjGfFIROhj5mez1rF13GFpFeFq75gZXWpF7
         qyuSt0aNparC+9MD8dpaY2EUUkX+jwRaNsLadGIzURw4F/KxGZ6+r0Ej235pjUQNsoJF
         FE2oN+C5NUD86VRKG6degaXXYFzcEs2PEoTd/2YE5I3ZUvcv32Bihsobx4+O9ovyCECF
         uhR2ezBUG/OY03Mvz37xvS0ACeLVlWU0dE95qCaZx3RBVHeqLkws/M4sxkxk6wG0vJLV
         9Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056882; x=1784661682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHy8t4zKOYGLPi7aUYeTB15EGxexEveRnk5KK7uTm0c=;
        b=JwBl3p88BU3kffY7f1DmnPIq1MGaj0EFHyKFcsXHDkvjsoAZyYtQdYO8zx4/ENR1Sj
         Coq9QvImLm9DnsRoMv/9DEmefkHTZtQ1A0JEsZ49UfwLeFHNis2jl7pqd0w8HY6oHqsX
         3oDE6rsqyCCkHlzjO0U7DEOUlBT0/VizlCaT+N4uJZxAqUSiVoa+MNmcLB4Q4UMWVk8j
         aG4v2c52tbU2LPj4SwlBldLYEASryGSetAfn/ypxKfwhc1l2TVSueLkPiGDpRyB2rKy+
         nVebyyhDVpTLyCSgrnnLAPM5+ZVjkCnrDCfWM+NWesoOZ6hgM+d0WzSf1quCt0PB3bdu
         ydjQ==
X-Gm-Message-State: AOJu0YzW2Nmbgt6+fW1e7MS2GDPvHyatvv9pogUe9EB2ocum4S1Lm8rj
	e4RqnHsnQCm7Vc/Ybc1oJD0PMlph3hgjAO91Gv2mvwa1AzXKxpp+Bwl1mfg59w==
X-Gm-Gg: AfdE7cmdkLsrB3F0rykUfYrME6loK1MdhWlZxTYuUCE+Xi+wy/ezcklAffZAOeU1LzW
	QypGHqCnlA82YohVzLSNDQ60iThAOXNTNAAQneZLHgtga9VDf2w1uER00osFEUh6MBK6t0+7qWD
	FN9MJssgHyYqyRv/hhq9eMD7BrYraNZCQDyTMiPSHdi8X/jmKSMMy8SMf6gi/G9hnGxM4QxQOoX
	IniK3bRQu2PRhfl1ZgpiWdAoOgUhQvNMIUrw8EuoCfJUl3NEwBY2P2ng9oiZmtZ8QOwFpF+wBLG
	CSIBAacCCNyoWnCzlSyrrUJVb39XGCMA5k5KjxxKO21BQWs7LxRho4r1oN+ZMNCr6KFyz3druhj
	S6QkicMXeNbhFKY+skH+Vj1nlHjhMSx/I1UUCwP991HeZG0ltGTUT6oa4BzVdMsmNMjEnRwWG8C
	PNU2vGGGgvOg==
X-Received: by 2002:a17:903:1aef:b0:2cc:f7c6:8353 with SMTP id d9443c01a7336-2ce9f1605e1mr141816505ad.41.1784056882165;
        Tue, 14 Jul 2026 12:21:22 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm120804945ad.18.2026.07.14.12.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:21:21 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:21:19 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mattia.meleleo@coralogix.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
Message-ID: <alaD1E0nOLZ59kT8@john-p8>
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
 <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>

On Wed, Jul 08, 2026 at 06:55:00PM +0200, Mattia Meleleo via B4 Relay wrote:
>From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
>tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
>counts bytes in ingress_msg. Without a stream/skb verdict program
>nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
>returns 0 even though read() returns data.
>
>Add tcp_inq() to the reported value when the psock has no verdict
>program. The two queues are disjoint, so bytes redirected into
>ingress_msg from other sockets stay correctly accounted through
>msg_tot_len.
>
>Remove unused sk_psock_msg_inq().
>
>Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
>---

This would be good to merge. The bots had some good callouts but mostly 
they should be follow ups IMO. There is some concern that the FIONREAD
may not be accurate on transitioning add/remove of progs, but mostly
this is done at connect and then removed only done on socket tear down.
At the moment this is causing real application problems.

The most relevant bot callout would be to make this work for UDP progs
correctly as well.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
