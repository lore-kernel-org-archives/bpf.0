Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776A3382E7
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668349; cv=none; b=leVqNKmWCfuGCF2EY57DX6Qc9y8FVtQRSrFUhNznsEJ2gDond75EFVNeBKA8lKoUxqIgmNaxemVLt12Tovn0bg0oTzpYT7lNSMcQgY1NVABnwvwngQB6GFYLYE9q5742xxd/fWdzN0rwUFPqAnJa7BJMJPOuhAJTIGOj285P4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668349; c=relaxed/simple;
	bh=oMO2lmI6jl8bfWRtrbTzUfsP4kK3JhJ9nHuZIHroJso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMscvjBmHWoVfHzqf0wim+rgTuO6c+YoS0bHaH/nNxl1BriHJC6MF2Y+Fwr7RfBhWpo1X8UbmXF/qmjiKIJ9myPJmgAXMafFSdAAJ4M7WaknwhkEDno4SVkGlwxiy5IpDZXAeAaALYBC7ljpm56TMHMfwVarMJrm8TrZE8aUlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oK3evLd9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oK3evLd9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae523d54d2so14165ad.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772668347; x=1773273147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJXWQ/ytiNmgn7oJt5ZgR0qUZMF+nTZXMyr1U431JSU=;
        b=oK3evLd9/s19oYVpWqqUGHjQ8ssniPbGyQi0Zl+AX6le9o9dHF7wNslguOvO1ZF/rS
         9kvUXr3RrZZjqSA5O3DSykB3F15zD3zxTAeFdVqZ/Bd32UbBVwjUAzGrElTfS29xhQJl
         XkceJQcY/7aqK7zScI/QwmwxxhMLUl+3iy2Wp9bjagl9yaCltwg1s3flTXliJ7FksLJJ
         oZkODv0KpmNoWn5+t2qMlr6SSnuAePfV2sFey4ueUjCoPdP/yJ9pmN5bMs3K+O+7lZ4C
         MRqanKV8TDjxwzcYOuj7nO0mj02IAx654ZPxljymcPmdlQABjZm1MxCyKUc0DMa8NQPj
         Fccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668347; x=1773273147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJXWQ/ytiNmgn7oJt5ZgR0qUZMF+nTZXMyr1U431JSU=;
        b=gh6wikBDO06V3YdG3QfY8xkziMNeZOLyZ9Kx3Gj5hvOeBjHj3Ge650B3psN5LTXbTp
         z5Nhrzt490QKpkqKyGJc5hSpCDmdk+N2fazWFYBAV+BkYp6V+GAeU41VC8Vk+hBAKH59
         yoIXUyWDd7Audxa8B9wNCfLWjxfUK84tdm14bwb/eBj+94yuerzqgtC91PiE1veJ5cNZ
         8nkURINsyrDh1OytvrXTHAdcaXkmiXxDvC5MmExoS3CSISogs+QC/5+DyO4CnNLtd3uF
         Bb9GqdLXAaXn+SGDE6l/31/DlO1iRm/S83VQG3y4RPKGZ3dn8HmaozYoVjwV7V/WPUf2
         4mhw==
X-Forwarded-Encrypted: i=1; AJvYcCVi8F+j8l3XutI0/qFSeVeZd3OHmSXnokaIAMXAaDOUIVjQbeCqLgQJq9oyKWtKZ/R1NxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAveQ/AePT8r7+dnRRQkQwxJ7Ecvq5d93GAapT1dRERO42Tkz
	hXVq25e1/KhEm3ctW+2lAv6ewkC69HelvJr1BDIHSi/iy6hkQZkvzpI8aqFzcvnPwQ==
X-Gm-Gg: ATEYQzw2yrfznAJbNGAxo8RSOBEkCxdJa6bXZkadu+UILBpMA6zMdY7AzFybmEqYNkx
	LUW0ZllJK+WMyUTHCpfXOc5CHCYPyIMbqqXhRE7ys/GWZdiMboXUBWj9nO1y/qLId99IqfPcxwS
	TorUeR8ZS4QMUHrbVhHN+Ws+CTXexAkIw9io5Dyk5iMqzqzl4eH3+ithvbr3kf2wigqiKioT6+9
	8a5ArcdrzrHcvLkMF8KteawUXZ3BDd8p1wUlXjvPf/WWVSEyIY8DVc/WIJjAT+mCLvNt7iN5SQv
	03OKA42sHsU8X1vESr0aNb7kUAHmsLs3vedm6BMCp6FUHera/WWsfaltJ2qehtxxWeInc9m9src
	Xetvo0UmZM0Ze3e84c+uh4riaawewYhj5mkBSagOw/s2zJhCCn7MforiCb9JDaMD4kHWwHLfDMV
	JW+ZP4/xtN8jUvOwBWrUK9U1eIrkVsCJ9899tP5u8gbf1hy8tb2bjpGmmPCA==
X-Received: by 2002:a17:902:e5ce:b0:2ae:5a44:ea91 with SMTP id d9443c01a7336-2ae750e2726mr647625ad.22.1772668346686;
        Wed, 04 Mar 2026 15:52:26 -0800 (PST)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8059bcsm17879218a12.18.2026.03.04.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:52:26 -0800 (PST)
Date: Wed, 4 Mar 2026 23:52:22 +0000
From: Jordan Rife <jrife@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	edumazet@google.com, kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, willemdebruijn.kernel@gmail.com, yusuke.suzuki@isovalent.com
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on
 abort
Message-ID: <skxd6uimyxzi4x5nfmz24ez3d45qiubdnwkqawtbomjfzy5qrs@yb724ykvvkec>
References: <20260303170106.129698-2-jrife@google.com>
 <20260304212128.1943568-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304212128.1943568-1-kuniyu@google.com>

On Wed, Mar 04, 2026 at 09:21:03PM +0000, Kuniyuki Iwashima wrote:
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

Originally, socket aborts in Cilium were handled with sock_diag (and
still are on older kernels), so you'd need to do some map maintenance in
userspace directly before or after aborting the socket. I suppose it was
just cleaner to put common cleanup code in a sock_release hook.

> > 
> > Make the behavior consistent between TCP and UDP sockets by not clearing
> 
> This patch makes another inconsistency with TCP.
> 
> As you mentioned in the cover letter, before the patch, even if
> aborted, a bound socket still reserves a port, but it does not now.
> 
> This might be surprising for non-reuseaddr/port sockets.

Yeah, true. I'm curious if this behavior is something that is useful at
all or simply an accident of the current implementation? If I'm
aborting/destroying a socket, why should it hold onto bound ports until
the socket is closed? I wasn't quite sure about this.

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

To make sure we're on the same page about what you're describing, I'm
imagining:

static int ___udp_disconnect(struct sock *sk, int flags, bool reinit)
{                                                 
	same as before, but if reinit == false then avoid reinitializing
	fields like daddr/dport while holding onto reserved ports
}

int __udp_disconnect(struct sock *sk, int flags)
{
	___udp_disconnect(sk, flags, true);
}

...

int udp_abort(struct sock *sk, int err)
{
	...
	___udp_disconnect(sk, flags, false); <--- set reinit arg to false
	...
}

This would have the same behavior with regards to reserved ports
following udp_abort() while preserving fields like daddr. I was
considering something like this initially, but it wasn't clear to me why
you'd want to hold onto reserved ports if the socket was destroyed as I
mentioned above. If it's important to maintain that aspect of the
behavior, then I'm OK with this approach.

> 
> 
> 
> > +	sk->sk_state = TCP_CLOSE;
> > +	sk->sk_prot->unhash(sk);
> > +	sk_dst_reset(sk);
> >  
> >  out:
> >  	if (!has_current_bpf_ctx())
> > -- 
> > 2.53.0.473.g4a7958ca14-goog
> > 

Thanks!

Jordan
