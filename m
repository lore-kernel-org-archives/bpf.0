Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935EF3815EA
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511401; cv=none; b=sLn3hZOKOj1y8Vp0HKsEEMRwGiHGVE0a4GNKyV6wRqbb5SKjo12wOJ1eNmDxFXpzIgP7s9ECQNlwcWZcyFD9v8peYpRtQe5xKKbZZje3qvdf8z0TmGIQwDw/fQkma0WtF7QFbC4IF4RY7wqnc2it0Fo6qPNpSIaCILOYqC0OSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511401; c=relaxed/simple;
	bh=nozqZkYqnKNHxP3Iu3Sop6z/onajxYXf0IYlzL4iAmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6Y6RjNNmdRoI3ed/RiRv7VCIzeRUDnfTENr5aInYtnkK6I087BGqApavXXYWnNYDHqUuOtyZg8KqpqDnjnmbN41nINf+Re+iq2f0q5v361xsueKdV4CoiTkQ+qCo5syIwIanRjR0SrVoM1UD9i2q4wn5KpCaiqhOx05i4PBh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1tLH/Bp; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1tLH/Bp"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c80291e6237so2995014a12.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511397; x=1779116197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1/2XYunZZhJOj9243Vaf4F12iOGTyYZHD3g6BpnS6cA=;
        b=F1tLH/BpqP68bSawJG2Tgwo+t1/bm+oLSP6Ns7lbYuREEBXr856W97T9rWZT12D7H2
         pa9RMqg6X5sXFO/VTo3BZEpsbXNYtrM/H5NLNnJvkGsnVO1Kg9CBYyIgtCK3bWUKgIpa
         BQHgjRNXKHF7YxaNtzM9vfa/r9zTisDU8vZKNfFgvA7k4UDJLjgaNTBlpqek3dmyBg8L
         RSOAYThEDYa+1ojHwZGfKxPKp1EpQt1PJfGZ9AFJcqX9WzV6SXOAUBFLLMRTFR8YXTly
         /ULVtA91MllQt9BFpWFhRRuufX6RaUPLHRD6g47IPnF/+kpgEX2BPuxASJ0jJeSlDRet
         N2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511397; x=1779116197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/2XYunZZhJOj9243Vaf4F12iOGTyYZHD3g6BpnS6cA=;
        b=ryc90gfkWb1AqTe3+ZUKqsrOGEd1Bc32AEkDdXB9YfDG+Xlu5K001I7X5wIhG7ROk4
         5fqGo10/SRaX4FGLl8Stf5bHjUHFjETFTZgtsr3aRtzOQMXIle1njhHW5L3SrteCVGpc
         4mWVK0XwSv0DGS8DCIrB2MKKOnqjNhBhrDuGBjcp8maxejMG3J3ek++dhAdtPM7Ot9dN
         Aj5+uFxEPB8/KRUGGZ95jAaeyFecZrN4NV3MS/xlyLxkRL9jo8jtjE6CbaHu9uzQ4KS1
         nbYe9Qa3+PHDdIYYE+5yBU2yemM+rs4w5OaHHU6D5x/N5OB5gWa4WT9q3yEiU/I0y0rC
         K9qw==
X-Forwarded-Encrypted: i=1; AFNElJ/SDBzaeFQ8nHpyn88q0d9Zy/HtnkRpj1DsPBwTqxNVtvQgyV9vhCvhBtvXCImwzTGacPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1FK3uBrPHqruSbC1i/I4lxv6tGh/CWhlQQ51RxVtfjBoSfUS
	aybkybBnwWLyxZCgqrq2h/Kk0ffljA/vtH/oN/9oS+TWz1qSrAbgaYGuOLiKZeE/
X-Gm-Gg: Acq92OGQoO57fqX0q1g00NAuGLlCDOSz6lcggp7Ydi92SRiEKsbfIbfwkUnTwd7ff8M
	WImDxmp5+M0llDQwFeOlv7L8sdsIjOxrlClUoDAoA9eot5Rp0Km6O5I8vJNMWWDsaAA3Q8vYgj9
	n2IawI99MhDVYma40LdNklhGJLqZbpRMC96qlCa5U+FgFzrQxI+AR8gP09bt9Ga4aHM2kzl8B/S
	Podz9gYXjZOpACwjeSg5wDkWkStSQQ6cFniQ0LQWDxVBIIG5KfeK68hlZd8rXoQwiU5isuxkrew
	d29RrsdC5nPm9exwhI9O7IkPDt2bR37StXsJmYAkdaTGfCjAP+AY7npPAg5j/szV5lpuEoNawzr
	rPEAQ5RaGeTW0LOewQl1KNwddtlUDDTBVkySWPyndyh/8QAhxyIGtH4ZOwTtykyYp8OImAhp3bE
	FAhK7l7E5mptilK/F+
X-Received: by 2002:a17:903:22c4:b0:2ba:e66b:ce34 with SMTP id d9443c01a7336-2bae66bd563mr171723165ad.21.1778511396945;
        Mon, 11 May 2026 07:56:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4057fsm103030355ad.21.2026.05.11.07.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:56:36 -0700 (PDT)
Date: Mon, 11 May 2026 07:56:35 -0700
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
Subject: Re: [PATCH v1 bpf-next 3/8] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVLOWAT_CB.
Message-ID: <agHuDeKLLUDdWXuS@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-4-kuniyu@google.com>
 <af390TgIj5sDABvi@devvm7509.cco0.facebook.com>
 <CAAVpQUA_HHEbcRxEVbuxtnyz_5ibvOSxO2wVx16ZQ0kKHQM7NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUA_HHEbcRxEVbuxtnyz_5ibvOSxO2wVx16ZQ0kKHQM7NQ@mail.gmail.com>

On 05/08, Kuniyuki Iwashima wrote:
> On Fri, May 8, 2026 at 8:15 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 05/08, Kuniyuki Iwashima wrote:
> > > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > > prog can be called with BPF_SOCK_OPS_RCVLOWAT_CB.
> > >
> > > In this hook, we want to parse the RPC descriptor in the skb
> > > and adjust sk->sk_rcvlowat based on the RPC frame size.
> > >
> > > However, we cannot access payload via bpf_sock_ops.data on
> > > modern NICs with TCP header/data split on as the payload is
> > > not placed in the linear area.
> > >
> > > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
> > >
> > > Two notes:
> > >
> > >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> > >       invoked from recvmsg().
> > >
> > >   2) Access to bpf_sock_ops.data will be disabled by passing
> > >       0 end_offset to bpf_skops_init_skb().
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 5fa9189eb772..94d07a15b2ab 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -7718,6 +7718,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
> > >       .arg3_type      = ARG_ANYTHING,
> > >  };
> > >
> > > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
> > > +        u32, offset, void *, to, u32, len)
> > > +{
> > > +     int err;
> > > +
> > > +     if (bpf_sock->op != BPF_SOCK_OPS_RCVLOWAT_CB) {
> > > +             err = -EOPNOTSUPP;
> > > +             goto err_clear;
> > > +     }
> > > +
> > > +     if (!bpf_sock->skb) {
> > > +             err = -EPERM;
> > > +             goto err_clear;
> > > +     }
> > > +
> > > +     return ____bpf_skb_load_bytes(bpf_sock->skb, offset, to, len);
> >
> > nit: wondering whether it's better to use __bpf_skb_load_bytes (which
> > wraps BPF_CALL_4's ____bpf_skb_load_bytes) here? Seems a bit less
> > magic and used already by dynptr?
> 
> I guess dynptr used it because dynptr is in a different file under kernel/.
> 
> Users in the same file (sk_reuseport_load_bytes() and
> sk_reuseport_load_bytes_relative()) call ____bpf_skb_load_bytes()
> directly and clang inlined it there (including __bpf_skb_load_bytes())
> while dynptr tail-called __bpf_skb_load_bytes().
> 
> I see the point (I had to read BPF_CALL_4() macro for ____), but
> ____bpf_skb_load_bytes() looks better.

SG!
