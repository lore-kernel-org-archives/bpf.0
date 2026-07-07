Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0493D6690
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417728; cv=none; b=BHdXXnAQiEU9mUF07jcppClq77583e2VoQzwt8eXK8b21NMld+ROx6AF7OCc90dr6jwc11zdK3g3XZTOfaHLbv/KP7QjZ89CIiAf5Xlbq9JS36jciwGKTIGNbAxTjP7ruEQffnCz3ELS4lF/JSfJEWCG5MZ6IuW7sqXcjlPyr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417728; c=relaxed/simple;
	bh=KbABl74tqG5GNUvT0QDb0Q47cc8vCeHZWLO1bl26ED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0DuCRKURwJRNMgFsQadwx7nNOYgxIv6Bob4Rp6q2Rz6xCFumUKOfs5JTsh65GCBs3Ae5HvX3TMYlGW16zyM/5ZyByDFVcxGUZFJjrb+DawqCOkqH8BaNQEAItgHg8/8NsDYrKEVOjJvAjfs6EGV3G03qEvKhKQDgLmQcj2sMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnWFmxsH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnWFmxsH"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47d6c634f45so1752173f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783417725; x=1784022525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J0oaZRt2VWFRfQvi/SNR337ENDlCcdDtqHlqF7h8Mhg=;
        b=pnWFmxsHcHi+IV2mcxnLNG4LFXms2f7dhMM+nWQLPtcQ57Neym52Ukr4q27SxgzeVG
         pmrC3MgTAXh63FQRJcULNSAqWvWFxoKxugJ2Jy4Y/lONeqrnBwyq7TubQwnUlfFoJETD
         5nYkBxhj2hTv99wVXtvknQpWmijsQRRUqx90Nbw0dJvxcBK2+v5nWm/sYmUuD7N8ITNR
         yCbjakWkZ/hnWEtji15qTeTtm6yOTOwo5hdm/ovltTzUSL0VEFMZCOz3Q5tE8o6j9hk/
         avbVOMfUePO/QR/gxiVL8z/BLnydad2ejq8LnFDyo/KqW7Oba+AxJYDowbtsWqP4qj4F
         c53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417725; x=1784022525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0oaZRt2VWFRfQvi/SNR337ENDlCcdDtqHlqF7h8Mhg=;
        b=JGe5nDl/aePG8N7JafKZ2Kb9yOMi6zMH9usDC9M4Q7ONTYyJ8yWPo+3OQIMxA3YIfW
         UDF0Bn1e0l1WwYm3GMvCl2plt1jhlLI3Ce0dVouF2He19nimoXZQV1FvSUtdU145wch+
         lcYkGohq5lKBhGgNAq11w+hQx6mhcofCw+7cA32jExt+nbih//MgdzJ5SukZvFPcfrio
         Wnh+Zm3L0qgyw5E0mQORSHbtL27TMj5FgcjjSwoqnacW4Iq+AR/pgZOONLLcXpN+vnZZ
         ZGM4S1Q+Sgz3Rf7XlkWoxsn4QSi2yh9lAesLsJ41+g5R/55mwCoNJYYigjGA4wmwvTr0
         xnrg==
X-Gm-Message-State: AOJu0YzDLi4TWJtxz1qf+a/EZ91Mhjkzn2A9mClYl/I90ULQOYUb6Ilo
	xKc7qI0q6KvQn5HIsUR/3qjFIknnHaWCu5vEq4eXLVVdK+JrmSCyHDOy
X-Gm-Gg: AfdE7cnrxVEBcKlnSVHrvsB4XOIuOxIh6uNb/U7l1nXEvQ9iuq7zDK+Qy4D0shhoyUa
	7eeUGBu8aW3rkBhfoApl61EhU4SxFNSqJixW0qyXNQRYcOT8kBaLDBujETbRHxvz38ZqBm5u8Lt
	nKPTO4pjtYGmleNjvhNArvfCu2m7M60vaZyjOSpSeNBGMI6pRaWyKzvIaI48Pvl6WKPAfyDLucU
	bKOaWuINr7G7pBhxWQwJIQhsOUvsvlK+YrzSpUKcQ+2vV8qEzW7uyPb+WvtK2qpzp/balc8B40K
	lwVIsh4ohNTSGvEDez87l83Vw1K9ZTRgZlz/joXaE3MbluDVi+uO+DZKbrMEhMJpHzxgZZkhPY2
	RNfpLm6nn26AqnpQuY7ZX6UBWiwv2EnTj1ipbDngu/O0TMl4JlfiKoetplbJL5P3iTRRnacVnQj
	sPu/LMn8IDigQOh6RGq2RfzOPAMBsurGdmeMwFiqGZAEEY
X-Received: by 2002:a5d:4644:0:b0:474:9dd3:981 with SMTP id ffacd0b85a97d-47de66b1354mr3643129f8f.26.1783417725020;
        Tue, 07 Jul 2026 02:48:45 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d7801sm32987273f8f.16.2026.07.07.02.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:48:44 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:48:42 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akzLeuHT1gQqFBM0@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
 <CAMB2axO2cHcKRZzrQyY8Zd2aO56MZd8=bf5po+59qnGj=bXrkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axO2cHcKRZzrQyY8Zd2aO56MZd8=bf5po+59qnGj=bXrkw@mail.gmail.com>

On Mon, Jul 06, 2026 at 02:33:43PM -0700, Amery Hung wrote:
> On Mon, Jul 6, 2026 at 3:26 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > sending data. This provides a mechanism for BPF programs to emit
> > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > socket types with IPPROTO_UDP protocol but could be easily extended to
> > SOCK_STREAM and IPPROTO_TCP in the future.
> >
> > The API consists of six kfuncs:
> >
> >   bpf_ksock_create()   - Create a socket (sleepable)
> >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> >   bpf_ksock_send()     - Send data through the socket (sleepable)
> >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> >   bpf_ksock_release()  - Release a reference (cleanup via
> >                          queue_rcu_work since sock_release sleeps)
> >
> > The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> > can be called from SYSCALL programs only. While bpf_ksock_acquire,
> > bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> > programs.
> >
> > The implementation follows the established kfunc lifecycle pattern
> > (create/acquire/release with refcounting, kptr map storage, dtor
> > registration). The kernel socket is wrapped in a refcounted bpf_ksock
> > struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> > may sleep.
> >
> > The kfuncs are only compiled when CONFIG_INET is enabled, as they
> > specifically support AF_INET and AF_INET6 sockets.
> >
> > The socket operations go through the expected LSM hooks instead of
> > by-passing them like many kernel sockets since those are created by BPF
> > programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> > exposed to LSM progs, has a re-entering protection to avoid recursion.
> > Also, because of the LSM checks, we prevent the use of the kfuncs from
> > asynchronous workqueue as the current value would then be invalid.
> 
> Are these the first BPF kfuncs that invoke (attachable) security
> hooks? Some fs kfuncs seem to deliberately skip them. Can we avoid the
> limiting recursion check by skipping the security hook in
> bpf_ksock_send()? There is still security_socket_connect() in
> bpf_ksock_connect() to prevent undesired send.

FYI I found some piece of documentation around kfuncs and LSM hooks[^1],
people tried to avoid the recursion to happen in the first place.

Initially I wrote this with kernel sockets, which are not subject to LSM
hooks on the send path iirc. I migrated away from this thinking that
those "bpf sockets" should still be subject to the LSMs and not bypass
them, but we can change that or also have it partially as you mentioned
with connect but not send? Note that this would maybe change if we go
the sendto route as suggested on the other thread.

[^1]: https://docs.kernel.org/bpf/fs_kfuncs.html

> 
> >
> > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > kernel sockets that may exist in each network namespace. Out of
> > simplicity for now, the settings is host wide but the counters are per
> > network namespace.
> >
[...]

