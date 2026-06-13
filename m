Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D9387369
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781385941; cv=none; b=tdesZa5qFtILUavrwpMqtGebrtDPbDHaIsyCzNMcmeulD03Ap4/hdJq9SUoyKmMBtpi+3qyAzElGKuQIDWRNBoV77Jb3YEWW2Mjv16xC57A1wJBn9Q+AWXm/TpDKsPmS7mZo/tunyG5sAdpIiwamn5OTmRAfScJREmcCjGBqXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781385941; c=relaxed/simple;
	bh=sUW26/GjdOj1Qq716n0nbWsrEvJOhcLVVVNk0Yh/U80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT4BMJ3I2HHZ+XycRZm0fXt+1nTxOEm6V3Xj8JBr8DVzU/q9v7eD3vxr/ei3gYVUXMLpPSCbBuM59xi0pmJ3qRjm2xn/1Hk52GuL4QKHE63WOlXT8toYwcCBP3ob0dFUeME/tLTm1JD4qo1QCC4zj0wP289Gc6nD6U3PaYlF1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=BHISyfx5; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="BHISyfx5"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1384ebe7a10so1749778c88.1
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781385939; x=1781990739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8RVh2EafPzCmCimjzyybRSe3Diu63saSE546mxfPho=;
        b=BHISyfx5VmPeS35iXRH8apZp8aWFKTyb4hmP0wNq0Yz5O11xLjkBWFQFh2HZ/MJCbS
         3MHqjkkLv38ysjPFW1o3rBq8yunJPekHcqerVqoJWcg2elCA8cy/ecvF3Zl/3NmyqwIQ
         Syx+1LkOoTUJe4kkYJKGx7iIAx9FpC9dyAx++E60TidPLtIqEPM3qWfy0i2r195ZnIae
         3zJbVoYWubx0v63WuImZhorq7w2FdF2Rcu7l7Iil3WILrNT/dYtquF9SRiK+yKX0+Gm5
         ux54pbIBivA3iFViikm9gON67J6mp8E/yPrngmnxhvLeDlglgz+NyrSTksrHGYMpQc4+
         nU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781385939; x=1781990739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8RVh2EafPzCmCimjzyybRSe3Diu63saSE546mxfPho=;
        b=ZAE8xl4TBIckYJfm21T/K7pqYiGPMVciV3TIWTanwq/j2FjvXM9VZxyCWXz8dh7zOb
         JkV3FA69lKY7hWndWkA4WArxGExP6R4WigKIcyRlexQY9BQSiOP/UEYr+TXNSCTE3wp1
         R6n8SjykGMSn/GxO9fG879EIvmfVsCWdDmEyuGJw7qfiM5Rw9GXHm/cWzEsmlu6pD9SC
         mlgGr3Rn+cZJ3u2D2kLAu+iXNN4/YyMrbWI3OuqRowMq5U7DnJzbmPFErxXgZzqoKFnK
         9DLamx3zEoOgjBqidr1JdW5GJz94t3HFvjpCn7GeEGj5zvgSRXUrDVMtVnfkWrsy8t9e
         HaRw==
X-Forwarded-Encrypted: i=1; AFNElJ/Me0KzN9XF0+ZWhOVyAkWBfcA9t2NUHSH6uPbR/orCjakcxdOC02/hqgNVedqTI8+3FAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Mh5IH6iDtGjsl+2NQ7PYRaTEOZBEAMRCseVnDRxgw/9HF5vY
	EsHj3CkPJAwAypFbxR2ztJsYRPwBtnd7GpfqX0Ls7Bo1sVxqZcmjc3JdXyoisHzwGis=
X-Gm-Gg: Acq92OEyOmeS8Cy+W8us1jmm5xQPBfVJfgn3vKT1SQkcIV2SnhU1V+UM02KmuHbed7l
	BoJvbQAooLOCcp+bjjjK1bVJtUHMqKQ6UHAWYOgTJBuahTlRb+BDjbHPu0ZuGGzkDv2sUa5w1vd
	8Hgc5SbeYIoAXew+1arS9wQ3DnbfsVAPzU5AINh8iCBhzG3nVxoLZhWK+ZdK0ILiVmLo4U4BZGH
	G+OMKCMc7XOnd4AhklqbYwDsV8nuW9kd2ToN539fAvscLfvMoW1zJZZMbJjfoYefJ+ioRJtX1GL
	cfwMa7Ikh5stgqdw6P5YKdNWQiTFpP4RTpwrJdfCxXhpjIpRpfE/YKqj4ikYi0Z0lFXqZzF8VZs
	T8LZ40TQ5QVCCMBZ/HPypRuyLafYXWuGXubVN9jbTSxCuoTGuy+c6w4YWr9DXAJLzw4cRzscknH
	aQShbD1LrNr4XB4xeawAg0xjNEc1zm9QvH+equ0KZmSRdBxxSuy24D1v/5
X-Received: by 2002:a05:7022:6183:b0:136:ac69:b0e8 with SMTP id a92af1059eb24-1384bb37863mr4425156c88.15.1781385939038;
        Sat, 13 Jun 2026 14:25:39 -0700 (PDT)
Received: from localhost ([2601:647:6802:dbc0:56d6:c5c3:3b81:a8d0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b964853sm6012730c88.11.2026.06.13.14.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 14:25:38 -0700 (PDT)
Date: Sat, 13 Jun 2026 14:25:37 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Hemanth Malla <hemanthmalla@gmail.com>, zijianzhang@bytedance.com
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
Message-ID: <ai3K0dBQaPqDGl6X@pop-os.localdomain>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
 <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
 <20260613105730.0ca1ca07@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613105730.0ca1ca07@kernel.org>

On Sat, Jun 13, 2026 at 10:57:30AM -0700, Jakub Kicinski wrote:
> On Fri, 12 Jun 2026 09:01:43 -0700 Alexei Starovoitov wrote:
> > Just saying that the code is free nowadays, so whether it's 1k lines
> > or 10 lines is irrelevant for the discussion.
> > 
> > As far as the idea goes, I think, it would be interesting in pre-AI era,
> > but today splice and friends are a prime target for bugs and more bugs.
> > skmsg and tcp_bpf are reeling from unfixed bugs too,
> > so my take is that we should not add any new features to skmsg
> > and instead deprecate what is already there.
> 
> 100% agreed. There are so many unfixed skmsg bugs it's hard to know
> were to start :( Kernel "intelligence" to help unoptimized applications
> is particularly unappealing right now.

You are absolutely right. :)

Thanks for offering opportunity for me to make profit out of it.
