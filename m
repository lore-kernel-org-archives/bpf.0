Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5F3E3D90
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733796; cv=none; b=l7LDmHq/n/Gv0ZZUMqE07sHgeColvwMjNpHDLMizz3aMhHFyewDIt1k6wbk2IYodhKKVjvO1lrpqGuxdsI8y/ygTBvPtiISoth4V8nomtBD299nrQE++XWCgFquA9dSmOP7heMcHctWg5zfuPYxurndjFVGjgjR2nF2p7DOUbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733796; c=relaxed/simple;
	bh=omlXUwv1FnudEc8jOPj5xurO8/qWUq1d/WxN3fj4l44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+TklNOJybiuV+N6xM5WYniXtpD7oPOmEOT5DexXMA8CBqtssSY6ZyFOfSwLY9qEj1wzsA8OWgCrZJ8SXt/qMCTjWpCZSC0nrwFWkJPkezvY23BLwnBzJ4pigzyjfExqSawGMSGo9oSk3GlhGUuep9qLISYpGXQL7aKJOGEPhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjJuxMSI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjJuxMSI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae523d54d2so2495ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 10:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772733794; x=1773338594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy+g39Jz5B1czi+R9NnoGqSaJNTKdfTEfLcJ6RKB5fo=;
        b=mjJuxMSIWTo0BXD+43tAPuQZFSxvwiM7/w0xyZ8axS+W/aJBH+qVqvU3o8X6zMGpx/
         uUxSBVCggVZ2c9coUB4orLEq0Y46+vjyLCVqKEoC1udjiBTk3LK/PxZaM9SNYIcX1ap7
         WptCnP6/GB9cJRbTYuSUJ/ygY9hyAJ4UeXsuw5ktm2d54Xugm7rrGO/ZfnT3S67oHXcJ
         zJNfuykUtfvcl1yLKf3f40CUkJB9PzqDiqleTTyOGJ73armz/Kil7uKzyps1xj+aaZd4
         W3ciGO4MUmaSLQlCylXCg6rxRLHxYyJUckfsACk23gjSOK95hqQ/a5VyxTe5Lb2eY5wg
         95Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772733794; x=1773338594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy+g39Jz5B1czi+R9NnoGqSaJNTKdfTEfLcJ6RKB5fo=;
        b=MyYL4Ao2rF5sZmJXRYhmJEG7wHclrLaUGeFldxbvJU2DIj+GgZi1lJvjgzq89pfbPO
         nVnC4Pq0klRB0c88NeGfwuUHfsuHWGvD5sIcjQ2eCtlVyZnmOBrgMSZ+UNhV+GlkSKPG
         7tgAhAeOe72R6rw7vwAUEDw4H13MWqvG2Tp3XMevwYuomEt1vEo4ao7lGVGVwW/omGoG
         OBJ7Y33TVLL1pczv1RjjED8CI6GofCc9TJowEnNmQ2BWBl4UZ9XAP34qqH0ckv8B0nJJ
         musQjeFo7lZxdz4kzpzGeT0eamb2qv7tSnpaCDjkstNsqTqLBnTqkBmUDpgN3bSkyM1d
         aMvg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ogNHkF1ob5l7dhwX4ZrNLd7yDB7Yso/LWK+kKTuM6ubMZ5cEoaDfipDSt+UCxT8savE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKTL0xKmL6WtaDbnPvmiUSY2b9Ruu5bKVUFKjcABaPY0yMEQq
	HcDqlygutb/4bIltcPvcHDyw4zRA7NcRdjnUhXSmqUDZ6RI2U4w2yXySZKlAxHWzvw==
X-Gm-Gg: ATEYQzyJr43VdLmBNwTfYSOd0Tma7c3lOauSjF0g98pwfxdCq2KSuL/9NBSLEcVBxdq
	7elSJKnrXChkOqNY660zDbmw7CQhtpPN2LSiNLoTpjMEjB1mpF++ZTxe4XPlCKMOitkZ3CP21NM
	3o1CjJq7bOoZFlFONKM4nmxLa6jo7PSEOveh227uPrcLYwYW9H+IEgaFtmhU240j8EvTkwbGfOf
	GOw4rHUK3PCoJtDq4vtR/16E4wJftfWIyGIeKIBGBEa8vnDaZsviLIfK6ATalse4c7l4c0oUBgq
	ZW6e3UzmQztYLYQ04KBgeGqB9d9YDepUay6LRFHu0TiYfpTIVUGthUb5bEAy2+Gu5r2IVIDvmJg
	tH1VelQ4d5FNRpQzDjPcuH5A0nc0Y8R+Mzqjq93K9leqtX46V1i91P30o3Q0+BE11gLnIJ8hF6i
	irbxeATP6ND/LYxp8zRvwggTlhQ6x97qT4+yLa84bQcF1dUEV2cKPc13HWZA==
X-Received: by 2002:a17:902:cf4c:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2ae7649469emr2428835ad.3.1772733793881;
        Thu, 05 Mar 2026 10:03:13 -0800 (PST)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b36e1sm231068925ad.9.2026.03.05.10.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:03:13 -0800 (PST)
Date: Thu, 5 Mar 2026 18:03:09 +0000
From: Jordan Rife <jrife@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	edumazet@google.com, kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, willemdebruijn.kernel@gmail.com, yusuke.suzuki@isovalent.com
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on
 abort
Message-ID: <md5mulclwk56nxxdqn4zwgiouwfdi7ydfn3g5hka434ov3ygax@qrw2b3h7ho4f>
References: <skxd6uimyxzi4x5nfmz24ez3d45qiubdnwkqawtbomjfzy5qrs@yb724ykvvkec>
 <20260305032524.2176479-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305032524.2176479-1-kuniyu@google.com>

On Thu, Mar 05, 2026 at 03:25:21AM +0000, Kuniyuki Iwashima wrote:
> From: Jordan Rife <jrife@google.com>
> Date: Wed, 4 Mar 2026 23:52:22 +0000
> > On Wed, Mar 04, 2026 at 09:21:03PM +0000, Kuniyuki Iwashima wrote:
> > > From: Jordan Rife <jrife@google.com>
> > > Date: Tue,  3 Mar 2026 17:01:02 +0000
> > > > Currently, udp_abort() invokes __udp_disconnect() which clears out
> > > > socket fields like inet_daddr and inet_dport. This makes fields like
> > > > dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
> > > > hooks following an abort on a connected UDP socket, since they'll always
> > > > equal zero. This differs from the behavior for TCP sockets where a
> > > > cgroup/sock_release hook will see the address and port that the socket
> > > > was connected to at the time it was aborted. This causes issues in
> > > > Cilium where a sock_release hook is used to perform map maintenance when
> > > > sockets are released, since Cilium actively destroys connected UDP
> > > > sockets in some cases.
> > > 
> > > Just curious why Cilium does not unregister the socket just
> > > after aborting it ?
> > > 
> > > At least Cilium should know the key at that moment.
> > 
> > Originally, socket aborts in Cilium were handled with sock_diag (and
> > still are on older kernels), so you'd need to do some map maintenance in
> > userspace directly before or after aborting the socket. I suppose it was
> > just cleaner to put common cleanup code in a sock_release hook.
> > 
> > > > 
> > > > Make the behavior consistent between TCP and UDP sockets by not clearing
> > > 
> > > This patch makes another inconsistency with TCP.
> > > 
> > > As you mentioned in the cover letter, before the patch, even if
> > > aborted, a bound socket still reserves a port, but it does not now.
> > > 
> > > This might be surprising for non-reuseaddr/port sockets.
> > 
> > Yeah, true. I'm curious if this behavior is something that is useful at
> > all or simply an accident of the current implementation? If I'm
> > aborting/destroying a socket, why should it hold onto bound ports until
> > the socket is closed? I wasn't quite sure about this.
> 
> Digging into the first (long) thread of SOCK_DESTROY (TCP),
> the motivation was to kill sockets bound to an IP address
> that Android/laptop removes when it switches networks.
> https://lore.kernel.org/netdev/1447811024-8553-1-git-send-email-lorenzo@google.com/
> 
> In that sense, holding a port seems unnecessary.
> 
> But there are a few concerns like
> 
>   * someone could use the feature for server and reuse port
>     too quickly.
>     https://lore.kernel.org/netdev/1447879416.562854.443622857.62708268@webmail.messagingengine.com/
> 
>   * it's a bit worrisome if this feature is viewed as a way for
>     resouce management.
>     https://lore.kernel.org/netdev/CALx6S35Q_pc-vBNpA0hipn5K-vSmPDsV-V=D13sODESNO7Htdw@mail.gmail.com/
> 
> Considering these, it seems fair to only notify an error
> via epoll or blocked syscall and let the application to
> close() sockets.
> 
> In a thread, the author mentioned this :
> 
> ---8<---
> Its purpose is to interrupt
> blocked userspace socket calls, not to release resources.
> ---8<---
> https://lore.kernel.org/netdev/CAKD1Yr0Gpr6Ex2i1TXEWyETn48P4g5vBvFZ9=_g+Lz_7-PqBDQ@mail.gmail.com/
> 
> Also, there was an assumption that a sane application will
> close() sockets after receiving errors.
> https://lore.kernel.org/netdev/1447972381.22599.278.camel@edumazet-glaptop2.roam.corp.google.com/
> 
> And yes, this does not apply to UDP, and sadly UDP patch's
> thread has no such context nor discussion.
> https://lore.kernel.org/netdev/?q=udp_abort&o=-1
> 

Interesting, thanks for taking the time to dig into this.

> But anyway, now I think we can solve your problem more
> easily, see below.
> 
> 
> > 
> > > > out these fields in udp_abort(). Instead, just unhash the socket, mark
> > > > its state as TCP_CLOSE, and preserve the state of the other fields.
> > > > 
> > > > Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
> > > > Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> > > > Signed-off-by: Jordan Rife <jrife@google.com>
> > > > ---
> > > >  net/ipv4/udp.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > index b96e47f1c8a2..01a0a0fbcd56 100644
> > > > --- a/net/ipv4/udp.c
> > > > +++ b/net/ipv4/udp.c
> > > > @@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
> > > >  
> > > >  	sk->sk_err = err;
> > > >  	sk_error_report(sk);
> > > > -	__udp_disconnect(sk, 0);
> > > 
> > > How about passing another flag and avoid unwanted init only for
> > > bpf iterator ?  This will need another layer of __udp_disconnect()
> > > like ____udp_disconnect() (I'm not good at naming), or must make
> > > sure the flag is never used in uAPI.
> > 
> > To make sure we're on the same page about what you're describing, I'm
> > imagining:
> > 
> > static int ___udp_disconnect(struct sock *sk, int flags, bool reinit)
> > {                                                 
> > 	same as before, but if reinit == false then avoid reinitializing
> > 	fields like daddr/dport while holding onto reserved ports
> > }
> > 
> > int __udp_disconnect(struct sock *sk, int flags)
> > {
> > 	___udp_disconnect(sk, flags, true);
> > }
> > 
> > ...
> > 
> > int udp_abort(struct sock *sk, int err)
> > {
> > 	...
> > 	___udp_disconnect(sk, flags, false); <--- set reinit arg to false
> > 	...
> > }
> > 
> > This would have the same behavior with regards to reserved ports
> > following udp_abort() while preserving fields like daddr. I was
> > considering something like this initially, but it wasn't clear to me why
> > you'd want to hold onto reserved ports if the socket was destroyed as I
> > mentioned above. If it's important to maintain that aspect of the
> > behavior, then I'm OK with this approach.
> 
> This was what's in my mind, but probably we could just avoid
> the initialisation:
> 
> ---8<---
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index ce49ed2bd36f..d44be0020446 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2213,21 +2213,21 @@ int __udp_disconnect(struct sock *sk, int flags)
>  	 */
>  
>  	sk->sk_state = TCP_CLOSE;
> -	inet->inet_daddr = 0;
> -	inet->inet_dport = 0;
>  	sock_rps_reset_rxhash(sk);
>  	sk->sk_bound_dev_if = 0;
> -	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
> -		inet_reset_saddr(sk);
> -		if (sk->sk_prot->rehash &&
> -		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK))
> -			sk->sk_prot->rehash(sk);
> -	}
>  
>  	if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
>  		sk->sk_prot->unhash(sk);
> -		inet->inet_sport = 0;
> +	} else if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
> +		if (sk->sk_prot->rehash &&
> +		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
> +			inet_reset_saddr(sk);
> +			inet->inet_daddr = 0;
> +			inet->inet_dport = 0;
> +			sk->sk_prot->rehash(sk);
> +		}
>  	}
> +
>  	sk_dst_reset(sk);
>  	return 0;
>  }
> ---8<---
> 
> When we need to rehash(), of course we have to clear
> saddr/daddr/dport, but otherwise, we don't, even sport.

What about the case where you bind to a port and use connect?

1. socket bind() to 0.0.0.0:10000
2. socket connect() to 1.2.3.4:20000
3. diag_destroy -> udp_abort()
4. socket close()
5. sock_release hook runs and daddr/dport have been cleared

compared to just connect:

1. socket connect() to 1.2.3.4:20000
2. diag_destroy -> udp_abort()
3. socket close()
4. sock_release hook runs and daddr/dport remain intact

It seems confusing that these two sequences would behave differently.
 
> When ->unhash()ed, only thing we need to do is to clear
> inet_sk(sk)->inet_num.
> 
> Then, even if bind() and connect() are called later, it
> works because each syscall does not care about the old
> saddr/sport/daddr/dport and just assign a new value if
> inet->inet_num == 0.
> 
> This seems a bit fragile, but TCP already relies on it and
> it's unlikely that we change the behaviour in __inet_bind(),
> inet_autobind(), and inet_dgram_connect().
> 
> And all the other users of __udp_disconnect() are also
> AF_INET or AF_INET6, l2tp, ping, raw.

Taking another look at tcp_abort() to compare how it behaves, I saw the
following:

tcp_abort(sk, err)
  maybe send active rst
  tcp_done_with_error(sk, err)
    tcp_done(sk)
      tcp_set_state(sk, TCP_CLOSE)
        sk->sk_prot->unhash(sk) if state == TCP_CLOSE
	  inet_unhash(sk)
	    removes sk from lhash/ehash

I don't see a scenario where diag_destroy (tcp_abort) doesn't lead to
the socket getting immediately unhashed, even if bound to a specific
port (SOCK_BINDPORT_LOCK). This seems consistent with my observations
in [1] where I used diag_destroy to immediately remove TCP sockets from
the ehash while testing socket iterators. In contrast, I remember in [2]
encountering this rehash behavior with UDP sockets leading to seeing the
same socket twice during iteration if you bpf_sock_destroy()ed the
socket. This wasn't inherently a problem at the time, but it was a bit
surprising.

> This patch makes another inconsistency with TCP.

All this is to say, I'm still not sure why preserving how rehash works
in the case of udp_abort() is necessary, and doing so can result in some
unexpected behavior both in the case of socket iteration and
sock_release as in the example above. To keep things consistent with
TCP, doesn't it make more sense to just unhash instead of sometimes
keeping the socket in the UDP hash under certain conditions? Am I just
not seeing the place where a TCP socket would hold onto a port after you
destroy it?

[1]: https://lore.kernel.org/netdev/20250714180919.127192-13-jordan@jrife.io/
[2]: https://lore.kernel.org/bpf/CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com/

> 
> 
> > 
> > > 
> > > 
> > > 
> > > > +	sk->sk_state = TCP_CLOSE;
> > > > +	sk->sk_prot->unhash(sk);
> > > > +	sk_dst_reset(sk);
> > > >  
> > > >  out:
> > > >  	if (!has_current_bpf_ctx())
> > > > -- 
> > > > 2.53.0.473.g4a7958ca14-goog
> > > > 
> > 
> > Thanks!
> > 
> > Jordan

Thanks,
Jordan
