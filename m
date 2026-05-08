Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498D2E7BD9
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276883; cv=none; b=doMldOKdijh7plBVxknh1b01a+8L2NzARSihYK9D0WSnnUM4rSJdp9MfQXaczDcYQmeztfm3sccnoURdUejDXwVZISomqj12KNDEwFtdzdwlMqHIMaIKpjG6vNys+ZFGQ3TBmKQy9fNCWwlssHGA1RZ5kj9g2O0AWG6OhXnHOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276883; c=relaxed/simple;
	bh=b4xSfSEBba07dS73A1Cb20OypxaXWo+/j+rABWOKtO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycce8Iq88YX+sQwnDDHoq2MQIE/SPOuEDV39WQ2VNAHhp2I623B2PsEJiV9Qw6ypa1baCRdO79hhRz6qT61tE05GXTlpZbjfNm8nYJRpfknujR0TQxlXAEEyRjshv0BhG9XPkClGEE1jmIkPbceS4i2YO3I1ty1D8RbPE0tOVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc4IQrBf; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc4IQrBf"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c82471904fcso1102270a12.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778276881; x=1778881681; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G0o1Aye+qO6lkwtaNafHPbGoI4Pmy+TMkFbSow6+WyI=;
        b=Vc4IQrBfsk5HXcj2h17fUZr352Throppee8uOb0Sk2OYHlD2+EwFXRUJsSmT7RGrK4
         c2G7RiS1VvQ2n2JPd9q7qYLXNBhALvuH1CDyWs9Xv85HnkP+vJNvFuq0wlNFjSeYjV0k
         S/VVv+JDNFpyMO2A0LzhHbrMloolXReDLPyBVEfF/1q9cAAmc6fNOwWRb+6FQx0LrBmn
         x1w02y9qPTQxXlvW+ZBIp5+e8zHplklfpTTVEbRl68mnp7FKQXtejNXgvd/7cgDKYGbd
         kxXPV7yjGW9ZVL21xJhKF6V/Ih1HEyCShDndEG9d69dDwynkOAKwWagDSjHqC0kutHQ1
         C5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778276881; x=1778881681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0o1Aye+qO6lkwtaNafHPbGoI4Pmy+TMkFbSow6+WyI=;
        b=Cxix/aI/DXYnvzN5WImYsFd7MT19aTv81alZ5PlohVtsBuB+7PRBo5DqqAeGvYNRaj
         hRPehasy4/dz43RJs4Oq7HefpsWqlE2obXwZA57YVi28Bij8zklXI/Yk7ctdCR0i2tb+
         yxlddq8SnYeUxYLTcT5EZRlF9yay0fv0CnUCxnMqoehJUoM25FkcAuLmh2CHjnIiMCdy
         YXAS2Am7+dVxkOFggBRTiAUiZHrutHiAB7XQuIl6DPvKkRQW/l/XIl8PZ/yOduhlxY6A
         wBb99hp7dQcG8szT4Utr7DRzsvy6Z6VZYKq2FUIeZqV1TwyyPOyFqcmeEMcK7NoJjcN2
         kxnA==
X-Forwarded-Encrypted: i=1; AFNElJ+L5N542hwXy23K9VMRotyxS6LmAkP/SnoRwUxJpqXl7I6K4lk72j/SBOQeR96iO1aYW6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYQ16MocTlMNAvfzdZKhDHupjI8hOuV/1zd+24cJ6wezycKPq
	Y5ByGRcFN/srHaOC2gR1lZ+IEo04q1STZtBiIC8Kh1ohGLRa/11VfFJM
X-Gm-Gg: AeBDiesPDZo2iuOYY31rNBfx/nQ9CeqJyb45Koli4PP+rV4ZF0RxaLHjRnTL2pxw5Bt
	d3YWWruqWtHO4wFjbHR4TDbS3oZdTN0TIp5lK4pklUbrxxXM38vYwae0tmb1I88Y0ypj41o/xek
	ok61u2Xozlr+b0hILx8vjKT5n2QngU25O0wVUgUsaZTUjuSbNJrqTMa598VLMgC7hLu30VEtjN6
	AZY1pLeNIiI2y5v56Fal5eVmxvJ0MX3NVGgxOmEXC4ix9yVHuhP5qBmeS1u2Le0eH/vvs86M+T4
	O66yOGSuzx6TuSDYPBJyQ2VXAOVDN7AdGM8bfGxMzl6wtNbj0Gzux79Okk4f0sGIjiZAkb/YA2i
	feWpEEO3mkg4W9BnwfWK6AK//N4MGEzChnTEAbnGRmH1FeLrGX/crgYnlh4KOKrgs57cOvCNz1t
	Folna5n2A3xUv1tPU=
X-Received: by 2002:a05:6a20:958f:b0:3a2:dabf:feed with SMTP id adf61e73a8af0-3aa5a72c4d7mr16428652637.3.1778276881331;
        Fri, 08 May 2026 14:48:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767bdffsm2732043a12.5.2026.05.08.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 14:48:00 -0700 (PDT)
Date: Fri, 8 May 2026 14:47:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVLOWAT_CB.
Message-ID: <af5ZVL3EmKIfTcFQ@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-9-kuniyu@google.com>
 <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com>
 <CAAVpQUD01-UJorFM=4sT1b4XbiVF0TPorpzpU+b8DYXzn0FH0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUD01-UJorFM=4sT1b4XbiVF0TPorpzpU+b8DYXzn0FH0g@mail.gmail.com>

On 05/08, Kuniyuki Iwashima wrote:
> On Fri, May 8, 2026 at 8:35 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 05/08, Kuniyuki Iwashima wrote:
> > > The test is roughly divided into two stages, and the sequence
> > > is as follows:
> > >
> > >   I) Setup
> > >
> > >     1. Attach two BPF programs to a cgroup
> > >     2. Establish a TCP connection (@client <-> @child) within the cgroup
> > >     3. Enable BPF_SOCK_OPS_RCVLOWAT_CB on @child
> > >
> > >  II) RPC frame exchange in various patterns
> > >
> > >     4. Send a partial RPC descriptor from @client to @child
> > >     5. Verify that epoll does NOT wake up @child
> > >     6. Send the remaining data of the RPC frame
> > >     7. Verify that epoll finally wakes up @child
> > >
> > > During setup, two BPF programs are attached to simulate
> > > a real-world scenario; one is SOCK_OPS and the other is
> > > CGROUP_SOCKOPT.
> > >
> > > While the SOCK_OPS prog handles the dynamic adjustment of
> > > sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> > > BPF_SOCK_OPS_RCVLOWAT_CB via userspace setsockopt() using
> > > pseudo options:
> > >
> > >   #define SOL_BPF               0xdeadbeef
> > >   #define BPF_TCP_AUTOLOWAT     0x8badf00d
> > >
> > >   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));
> >
> > Hmm, so you do want to have this enable-on-a-per-socket use case.. Then what
> > happens to the skbs already sitting in the rx queue by the time
> > we enable BPF_SOCK_OPS_RCVLOWAT_CB? Isn't there a race? Or am I missing
> > something?
> 
> If the upper protocol is designed that way, it could be racy.
> 
> For example, HTTP2 could have multiple streams within the
> same TCP connection while only one stream can be upgraded.
> But this use case simply does not work with a single
> sk->sk_rcvlowat in the first place.
> 
> This feature implicitly assumes a single stream per connection.
> 
> In our original implementation, it traversed all (technically
> up to 100) skbs in the queue and parse them like psock.
> 
> But this will be unnecessary if the server drains the queue
> properly before enabling the feature.
> 
> If needed, we could return -EBUSY when the queue is not
> empty.  It's always under lock_sock() or bh_lock_sock().

But even for a single stream it's racy, no? Suppose I do recvmsg()
and then setsockopt(BPF_TCP_AUTOLOWAT, 1). There is a window of time
between recvmsg() and setsockopt() where we can receive a packet?
Or you're saying that if it is an-RPC type protocol, the receiver
explicitly signals to the sender that it's ready to receive (by sending
it an RPC request). If that's the case, let's explicitly explain this
somewhere?
