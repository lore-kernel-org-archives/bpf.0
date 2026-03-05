Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A50140E5F
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681128; cv=none; b=u7Tov4LpfkO2FYgUIhzQQY60OAEOjWckaUTZ+CZAvtaDW1VLeaiPuBp+SwWjsYuPuB9QRN/dKbjAsW83K4Dvq9TPMPekR+xslxUY6AmPEZ5jogLukbIQGcRqJ6sQg9J7aEw9q1ZVad3vNFi0OwS1njSGW1dcEwJfgM12N7BBWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681128; c=relaxed/simple;
	bh=8cdCwzcIZiM0RhwEFVpTwVIxqlCZ8nO9R/03FJa2cw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l2nvIj7IN72cSoRRPKDjx+14Au7BAjE/Ibzg1OEdoq78aUTFbuiE+KeggV9Rrs9+g6u0zl+ptc/I+C0G+E1pu7HgLSOs9us07qBRJfWpyVn4BDuXAjsyAwvMvVXkzDl6LQpDeAqkTMS4E1wh/hRBPgpNlCGbhDS4n/m1OpCzdos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A73hbU4B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A73hbU4B"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae48a21d12so29851585ad.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772681125; x=1773285925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRSnHe4WXc8o31JrOkZ13HKREi6iZmJPPXA9ncj7Loc=;
        b=A73hbU4B9LEXVeMkvcoNuPg1qVHR2mOgiAVFNzk5HQQ7UJtQSvoSAn+FdVolgGeEX/
         aqhA3dekQFNm+0w0vw4BY4AhMJnaVBG7o/wsTBY/QIEt48kEQUTbHCHsd4AYZ5hexGsM
         rvpHj9yjvWNnQ4SjSibzCdWGxuCDu5Itr6wTPMDKSLOpCgVKmZOf77PK3hCUtbIdRKfE
         zkHaHWK5iwJ9BXRKeAa+8LNbMYTJEzDIW1s58ywzAl4smCWW02DavvCXm3U3LMnFrlyT
         h7fkJ+Ykm5fcbA8Vvud3lRwcFB7YG8bt29uZzLQfCQEv3xgWYGVnYkDLOkjl9ue66hgK
         sgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772681125; x=1773285925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRSnHe4WXc8o31JrOkZ13HKREi6iZmJPPXA9ncj7Loc=;
        b=JMGcqmHtEqKddoOXApS+Ah4to6kbahNIsl1dre3HMFJUaiqbSBM8dnuP/4/wX6LH1T
         6o8pbmuB5TA2jjrlws8mUNkLgCRHRn44qnFD8kpfkhNgJH30aK3HoPZy9ov53+O0+wIZ
         g17+xNiId6WdxucDRM5mVxLUOP4s6Htymn3kAVa8vVglpOf69PB+9n8NBna3Xcq0Xv9g
         Np82x8B9FJDHna3gKwA/4cJ1jCvg5Zk2OPXW9t7LkzGlvYlzRQ8QJgusFcupYNcv7dDa
         ZnDoBNonAffD5I6/XpnKOTJwqBp8TuhKpxMQLHikG4VOXO6xijOsemv1tTmVnmwbqf7h
         DS+A==
X-Forwarded-Encrypted: i=1; AJvYcCVKDnBBDv8xUabSZFSz44g12DFIA5Ks+4VybsnqmNt5l018IjKxc1UNGSZtj5E9UcbiwVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDH/ikzgymo/r6YRRFPqjXtaUFDa4aeYf6a0apv5vYQA7Xwvxl
	hLgCrhuAVKpdUmbYVjFEfaVNFsdSzb59VGRZZ4gQ8FUdbiU0tfNVLxXYcDmm8JzH3vF5BhNIxPE
	oet7yBg==
X-Received: from pgc6.prod.google.com ([2002:a05:6a02:2f86:b0:c73:7d8e:b5d6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf07:b0:2ae:6192:8da4
 with SMTP id d9443c01a7336-2ae6aa0fd9bmr46707585ad.2.1772681125409; Wed, 04
 Mar 2026 19:25:25 -0800 (PST)
Date: Thu,  5 Mar 2026 03:25:21 +0000
In-Reply-To: <skxd6uimyxzi4x5nfmz24ez3d45qiubdnwkqawtbomjfzy5qrs@yb724ykvvkec>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <skxd6uimyxzi4x5nfmz24ez3d45qiubdnwkqawtbomjfzy5qrs@yb724ykvvkec>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305032524.2176479-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on abort
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jrife@google.com
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	edumazet@google.com, kuba@kernel.org, kuniyu@google.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, willemdebruijn.kernel@gmail.com, 
	yusuke.suzuki@isovalent.com
Content-Type: text/plain; charset="UTF-8"

From: Jordan Rife <jrife@google.com>
Date: Wed, 4 Mar 2026 23:52:22 +0000
> On Wed, Mar 04, 2026 at 09:21:03PM +0000, Kuniyuki Iwashima wrote:
> > From: Jordan Rife <jrife@google.com>
> > Date: Tue,  3 Mar 2026 17:01:02 +0000
> > > Currently, udp_abort() invokes __udp_disconnect() which clears out
> > > socket fields like inet_daddr and inet_dport. This makes fields like
> > > dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
> > > hooks following an abort on a connected UDP socket, since they'll always
> > > equal zero. This differs from the behavior for TCP sockets where a
> > > cgroup/sock_release hook will see the address and port that the socket
> > > was connected to at the time it was aborted. This causes issues in
> > > Cilium where a sock_release hook is used to perform map maintenance when
> > > sockets are released, since Cilium actively destroys connected UDP
> > > sockets in some cases.
> > 
> > Just curious why Cilium does not unregister the socket just
> > after aborting it ?
> > 
> > At least Cilium should know the key at that moment.
> 
> Originally, socket aborts in Cilium were handled with sock_diag (and
> still are on older kernels), so you'd need to do some map maintenance in
> userspace directly before or after aborting the socket. I suppose it was
> just cleaner to put common cleanup code in a sock_release hook.
> 
> > > 
> > > Make the behavior consistent between TCP and UDP sockets by not clearing
> > 
> > This patch makes another inconsistency with TCP.
> > 
> > As you mentioned in the cover letter, before the patch, even if
> > aborted, a bound socket still reserves a port, but it does not now.
> > 
> > This might be surprising for non-reuseaddr/port sockets.
> 
> Yeah, true. I'm curious if this behavior is something that is useful at
> all or simply an accident of the current implementation? If I'm
> aborting/destroying a socket, why should it hold onto bound ports until
> the socket is closed? I wasn't quite sure about this.

Digging into the first (long) thread of SOCK_DESTROY (TCP),
the motivation was to kill sockets bound to an IP address
that Android/laptop removes when it switches networks.
https://lore.kernel.org/netdev/1447811024-8553-1-git-send-email-lorenzo@google.com/

In that sense, holding a port seems unnecessary.

But there are a few concerns like

  * someone could use the feature for server and reuse port
    too quickly.
    https://lore.kernel.org/netdev/1447879416.562854.443622857.62708268@webmail.messagingengine.com/

  * it's a bit worrisome if this feature is viewed as a way for
    resouce management.
    https://lore.kernel.org/netdev/CALx6S35Q_pc-vBNpA0hipn5K-vSmPDsV-V=D13sODESNO7Htdw@mail.gmail.com/

Considering these, it seems fair to only notify an error
via epoll or blocked syscall and let the application to
close() sockets.

In a thread, the author mentioned this :

---8<---
Its purpose is to interrupt
blocked userspace socket calls, not to release resources.
---8<---
https://lore.kernel.org/netdev/CAKD1Yr0Gpr6Ex2i1TXEWyETn48P4g5vBvFZ9=_g+Lz_7-PqBDQ@mail.gmail.com/

Also, there was an assumption that a sane application will
close() sockets after receiving errors.
https://lore.kernel.org/netdev/1447972381.22599.278.camel@edumazet-glaptop2.roam.corp.google.com/

And yes, this does not apply to UDP, and sadly UDP patch's
thread has no such context nor discussion.
https://lore.kernel.org/netdev/?q=udp_abort&o=-1

But anyway, now I think we can solve your problem more
easily, see below.


> 
> > > out these fields in udp_abort(). Instead, just unhash the socket, mark
> > > its state as TCP_CLOSE, and preserve the state of the other fields.
> > > 
> > > Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
> > > Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> > > Signed-off-by: Jordan Rife <jrife@google.com>
> > > ---
> > >  net/ipv4/udp.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index b96e47f1c8a2..01a0a0fbcd56 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
> > >  
> > >  	sk->sk_err = err;
> > >  	sk_error_report(sk);
> > > -	__udp_disconnect(sk, 0);
> > 
> > How about passing another flag and avoid unwanted init only for
> > bpf iterator ?  This will need another layer of __udp_disconnect()
> > like ____udp_disconnect() (I'm not good at naming), or must make
> > sure the flag is never used in uAPI.
> 
> To make sure we're on the same page about what you're describing, I'm
> imagining:
> 
> static int ___udp_disconnect(struct sock *sk, int flags, bool reinit)
> {                                                 
> 	same as before, but if reinit == false then avoid reinitializing
> 	fields like daddr/dport while holding onto reserved ports
> }
> 
> int __udp_disconnect(struct sock *sk, int flags)
> {
> 	___udp_disconnect(sk, flags, true);
> }
> 
> ...
> 
> int udp_abort(struct sock *sk, int err)
> {
> 	...
> 	___udp_disconnect(sk, flags, false); <--- set reinit arg to false
> 	...
> }
> 
> This would have the same behavior with regards to reserved ports
> following udp_abort() while preserving fields like daddr. I was
> considering something like this initially, but it wasn't clear to me why
> you'd want to hold onto reserved ports if the socket was destroyed as I
> mentioned above. If it's important to maintain that aspect of the
> behavior, then I'm OK with this approach.

This was what's in my mind, but probably we could just avoid
the initialisation:

---8<---
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ce49ed2bd36f..d44be0020446 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2213,21 +2213,21 @@ int __udp_disconnect(struct sock *sk, int flags)
 	 */
 
 	sk->sk_state = TCP_CLOSE;
-	inet->inet_daddr = 0;
-	inet->inet_dport = 0;
 	sock_rps_reset_rxhash(sk);
 	sk->sk_bound_dev_if = 0;
-	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
-		inet_reset_saddr(sk);
-		if (sk->sk_prot->rehash &&
-		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK))
-			sk->sk_prot->rehash(sk);
-	}
 
 	if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
 		sk->sk_prot->unhash(sk);
-		inet->inet_sport = 0;
+	} else if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
+		if (sk->sk_prot->rehash &&
+		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
+			inet_reset_saddr(sk);
+			inet->inet_daddr = 0;
+			inet->inet_dport = 0;
+			sk->sk_prot->rehash(sk);
+		}
 	}
+
 	sk_dst_reset(sk);
 	return 0;
 }
---8<---

When we need to rehash(), of course we have to clear
saddr/daddr/dport, but otherwise, we don't, even sport.

When ->unhash()ed, only thing we need to do is to clear
inet_sk(sk)->inet_num.

Then, even if bind() and connect() are called later, it
works because each syscall does not care about the old
saddr/sport/daddr/dport and just assign a new value if
inet->inet_num == 0.

This seems a bit fragile, but TCP already relies on it and
it's unlikely that we change the behaviour in __inet_bind(),
inet_autobind(), and inet_dgram_connect().

And all the other users of __udp_disconnect() are also
AF_INET or AF_INET6, l2tp, ping, raw.


> 
> > 
> > 
> > 
> > > +	sk->sk_state = TCP_CLOSE;
> > > +	sk->sk_prot->unhash(sk);
> > > +	sk_dst_reset(sk);
> > >  
> > >  out:
> > >  	if (!has_current_bpf_ctx())
> > > -- 
> > > 2.53.0.473.g4a7958ca14-goog
> > > 
> 
> Thanks!
> 
> Jordan
