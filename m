Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEE34B437
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667526; cv=none; b=YzcTZj3F2wOiYdX08D0QWBNvd9btrV8Myu2VkLlzNTXnucDg68PzPzmXRKY7SXxhOyZndII7dMZWkQ2F7ffSYvKil/BSKks0iSglp6lImPAw1azoC+eckS0QCvq8c2c3TmDCersCYQufJD48yzjZa3FO8a9GRmIAwYQaIj0CwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667526; c=relaxed/simple;
	bh=cFGv1sL9pqbx153vxBCwRyGdMfivYi5rRpVeeKWxw90=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lAhC/zLxrBsl81vD8dkBJ1/8Pz71XCzAf1QTsszr85+c+EPTfBrLFbVdAaBbo/dxmPVK0iVNfueW+eCO7KDEBfTdogA+qOOUDTowQDlWf8ypEpa0F2iKi67z7wVIHBB5nvlbvi3Yn/EhGKu/5ApSVOHWyMR/8TikKtt8f6fISaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF6oBn6p; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF6oBn6p"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ca423ad53so6632161d50.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 15:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772667523; x=1773272323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwEg//kb8UGbW1G0PCmmnpwtxLnHg+DSaYUVRtKA4rU=;
        b=JF6oBn6pDxkd/WmNriovCLV9t9gYk9qFKYX3NAL5bL9rpHqTtgZj9jA7k7EaGbOjdV
         zGA/ziOLqro2qlFhasPRaIkcNnddpba6wtAqGIfzVeV/Q3DjE/jSxKkpW6SIr4mcOLcD
         20yb3ZZMUZTOXvFw2Aka+vD91aRPl3dfLEbgm6wJTc9kc4tN12q8DlXCvW55Jrp80jTM
         lTOFVvpGJb6Vzz+DGrMolWfxgYuDlfva4fzbsfSIUztk6C1n0kZ5Tv8Z1XSdPcodRHUc
         MOkiHoM5pAVZ0J0k06Fk//P9V48sHaCGRdfzuWP3xIBI985SaPI6j5LODZ+tLO5Vnr+q
         cHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772667523; x=1773272323;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwEg//kb8UGbW1G0PCmmnpwtxLnHg+DSaYUVRtKA4rU=;
        b=ZgcS0LV0tFU4XBfwC6ImllCCq55WDYPcZvpuTapGjWDZiklAKsDf4gOIWMycTjTQfI
         jl5D0h5ooAXlyTLnGfCK6k9oUp1gi5W6HRPvCo/cvvamCpfoT8HLLKGHxbRwL7dbm3er
         cqc3MAijBQYwQ9w5NQtQ++fPcga+VZQldbJHqmW0vgQ5S430eZ55CRr7SMC5WyGNK17O
         6D0ofpGOfJCim3HpVM12CF3O7mFNdrV9oLCnkSHYfo3+h0qTJh+BrNCEXYn3PmnsRgcP
         YgPDz0WX1nXU7G+1HjQ5oT2+OV/uuBe4Xr2jPRCl+BlxG0COW6TyuBNJGN3aLYx9zZeJ
         t7lw==
X-Forwarded-Encrypted: i=1; AJvYcCWo2zegYuMJ4LIqe1UI1VScIJuDpRj9NEZnuN8rAcu2ZCsryYwWpPPhGAw1Uxi8TWRWGTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UkCBcbD/I3BOfZQe5JNegOM5h5YEAuYN7gVGej9dmrBolYYX
	MTYJWe1ZeZ0lu7DJyCIDvOslj7NDi5fwZUEs9EkySXW9f9LYVQKT3ho1
X-Gm-Gg: ATEYQzyYRoxG1BsJvDN7qtifXhYkArbS30tZHzUAooQMwZpyBaQAdcRQ/HpJfSxEVkx
	1q2a0zpJFlE5FLMYpm243pCg/hv4+ehOCOMPzdXvcz4M6Z8Yv4D/Vn/RD3L1dQJXzz5QbEg8Yqh
	Jr3u8ivVK1xMDdYNs7M22oSx1+81gWmsgv0eq3adhZ5oOV1SY8twr5uBYVhGgJvON3d1tgC+MvF
	k0+PpNI0SKHAM05WJuxspXgRnGaJb37fz/zIL4tGLQ1VFOTRnw1Izz41KyaVEhBGiIPKAltvuVR
	MbuIJ/50VCZkFfelXTDEote8wldOd+8AVOHgq6cpf0FuEbl0Om5AU0Hqa51kandnD0I1QO6Y3zk
	uyKii+ene6gQrmWcpF9WcpB6nRmjhEfr8y8EjVUWnNUjpP1c6/DWLduQrRLSvnQ16QUhZGhaPA+
	uACiqXDsTjq5KaTSyQv4O3Uf48Brkj/0RSyORY9+XwFIdTPcM12RtJIeVVyaswGMA/cF4RCLQ=
X-Received: by 2002:a05:690e:1248:b0:64a:f1a6:6b0d with SMTP id 956f58d0204a3-64cf9b3425cmr3179552d50.14.1772667522539;
        Wed, 04 Mar 2026 15:38:42 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb75ba104sm8430163d50.10.2026.03.04.15.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:38:41 -0800 (PST)
Date: Wed, 04 Mar 2026 18:38:41 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 jrife@google.com
Cc: andrii@kernel.org, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 martin.lau@linux.dev, 
 netdev@vger.kernel.org, 
 sdf@fomichev.me, 
 willemdebruijn.kernel@gmail.com, 
 yusuke.suzuki@isovalent.com
Message-ID: <willemdebruijn.kernel.1f16f5ebde0ed@gmail.com>
In-Reply-To: <20260304212128.1943568-1-kuniyu@google.com>
References: <20260303170106.129698-2-jrife@google.com>
 <20260304212128.1943568-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on
 abort
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Jordan Rife <jrife@google.com>
> Date: Tue,  3 Mar 2026 17:01:02 +0000
> > Currently, udp_abort() invokes __udp_disconnect() which clears out
> > socket fields like inet_daddr and inet_dport. This makes fields like
> > dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
> > hooks following an abort on a connected UDP socket, since they'll always
> > equal zero. This differs from the behavior for TCP sockets where a
> > cgroup/sock_release hook will see the address and port that the socket
> > was connected to at the time it was aborted. This causes issues in
> > Cilium where a sock_release hook is used to perform map maintenance when
> > sockets are released, since Cilium actively destroys connected UDP
> > sockets in some cases.
> 
> Just curious why Cilium does not unregister the socket just
> after aborting it ?
> 
> At least Cilium should know the key at that moment.
> 
> 
> > 
> > Make the behavior consistent between TCP and UDP sockets by not clearing
> 
> This patch makes another inconsistency with TCP.
> 
> As you mentioned in the cover letter, before the patch, even if
> aborted, a bound socket still reserves a port, but it does not now.
> 
> This might be surprising for non-reuseaddr/port sockets.
> 
> 
> > out these fields in udp_abort(). Instead, just unhash the socket, mark
> > its state as TCP_CLOSE, and preserve the state of the other fields.
> > 
> > Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
> > Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >  net/ipv4/udp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index b96e47f1c8a2..01a0a0fbcd56 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
> >  
> >  	sk->sk_err = err;
> >  	sk_error_report(sk);
> > -	__udp_disconnect(sk, 0);
> 
> How about passing another flag and avoid unwanted init only for
> bpf iterator ?  This will need another layer of __udp_disconnect()
> like ____udp_disconnect() (I'm not good at naming), or must make
> sure the flag is never used in uAPI.

If the only goal is to not clear inet_daddr and inet_dport in
__udp_disconnect, then another variant of that that takes an extra
bool might indeed be the more obviously correct approach.

> 
> > +	sk->sk_state = TCP_CLOSE;
> > +	sk->sk_prot->unhash(sk);
> > +	sk_dst_reset(sk);
