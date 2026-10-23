Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775435;
	b=E431RuTBq2+c9Eg6KpVtATjwQcLxChbkXxuR4iABmh190WDYCcnzrGXUA9qgNoSYqnAt
	 i+90hfQm3OWPvlostPFtUMK6Celj3vloV2zYAr9MzgwR8ZtT+HEmRKKgh+zb53pn5fN24
	 rNXGgoUCdQafp21oCl2Z+jYTr6APkzoQIbfTJ1n3cHLx9V/7kLfHmURKGgJvTZrnL5RIk
	 oCdLvv9HRBWHHWU2L1kx/M7OdVIfErsc4EC5Yx8nNDtsteq6Zp9LNhcpF+dvPxEm74hlw
	 dU1knrmmhWDt6eO/Btc8Jbzc5v+0z5rlTxMQamUQUPcECUREGXxZhtrXbROWgGV71pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Btr7hr0LuMAaYdMP/tMMJLFSICUnfP+fAjhqSakVwX4=;
	b=LJuho/D0n1WE+/T9hTb6zjavbRCSFh/phWbCE2F125nm+oeGCaU41YRrlyBzTMX+Ktzy
	 v7ujMFK7mBTmVXD2bG7u1G5V35TxU+x0RP8c3aeFTpGqSxYW7/4jp2tGomU7gxmtOLI9M
	 Kv4wihpKuqBg/Uttnsl4J2csYkCg0F3w4eMO+TZXUKkXztL/yauWSTWpVPz0g2ePJ8fm7
	 OUJ+HzzB1x6bhowCpMfdIqpqgjh9ybpf2rMkiSXNKx3NA4bCFd2LDPWA+bPnw/4U1LDNA
	 2m1A4Nt1jSpjyp0eBozReIKXbwgPG48iqSofPYLVQ4VT7tAXfotVaBnHZNGNfxVthMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AgxEKTUH;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC91606A327
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC91606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AgxEKTUH
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so824026a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792775434; x=1793380234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Btr7hr0LuMAaYdMP/tMMJLFSICUnfP+fAjhqSakVwX4=;
        b=AgxEKTUHy8ctoDubMdjyFor88pmJ1RUyuatzX0e1CxVswHag9pSZt/fX79EjQFEGNU
         UeU4P9O/uPbnk7q2aER+bvaCtX2F4ZXJ2BoPAL8LIUZmukK6ssFsHs8iApGCIRb9OBix
         RcZn56fnq9qRI1pqtDeAf+LiZrK5ClPHVu8o7KvZXU4GVrxpMYMjq4u+UQszTMoXvlaN
         7NaDsCWT7jwkU0bVC5uBrYfFAvM9qoBViOgJ510w99hI+Y6HDdNk2eO4KGKlPhDmvB9C
         C41eXmKdNvYwOPy3XERwh+Ns+0VoJU7ggY2oHXg2tWndpPaAyd8pbgSr0iP0O2nquuQ3
         GbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792775434; x=1793380234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Btr7hr0LuMAaYdMP/tMMJLFSICUnfP+fAjhqSakVwX4=;
        b=pwCBM8FW6SKJ1LN8z+DJKuyX4AHrDHzjHtdJui8am/trHKJNmUEzYku5Pu6Hsgqm4V
         xfeX9sOiEnvZG7KbB8B6r6hjJahk1s/5SofrF//xYloQMcSYU7yyqMW82ESrRCGFBatG
         gXFyHjSnnZG7/RtJAKGFhzOqU7fC5rpdcbEQhc1jfopS0QQdYW3+Rk2t2YAKpQvGsYbR
         Nar1gD9LFIccZIqsP1D2s5OyLKwhd8KGz0zoEeH8j1rox/indGkpq4qtWvujst0/zjfi
         uIXpo2UJ9uicKkpm7XR9f0UeLowzgZHNiJ3LU7tbrZHtj6zKeVMdkeTUADu91Yla7b71
         WiKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAYjUNi7C1/PTkNqIR+ShBbIYXAe7CB3OkR8cUe5x1R+NA78opEQCUWNowbZr/kBNAG58=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbtm1FKACHwHzFlu1ft99w+IunNJzdPInjthuD/QGVJKadHcAS
	ydwCPUXodGRtqpkkWcJ6d+NZkLd0MUW8fk3KrSiPgoSmd4Nrpn0MlbdJ
X-Gm-Gg: AYBFou2eWafeswRW7t/aqkES9g92Va4SEWW4nTuIRxbZKGRXAS1TMa0ZVnuXdTrWw0W
	WzsTkvQc/yBNFrTvYQASzS65CYesqAalr/nQFH35LW/OWSB4Vb6DrG/UjC7B/FM0lHFlKhxQCQz
	pH0+mRTyu/qGBK7svYCXuBhz3XdCc0/E05Dxs83KlvBHw6SkasQs3wRWtxV2NaCqYqx2Wk0NaxI
	Y/i0QcwN4ArWvtG/x6bOjQue/Jy1DoB4obU2JJIJd+dyaLcFnDUXT2C9ImmEhvxEpGtUD4zmuO4
	SfEiS9kYymw4GwJpbC8AuAC59ELfoiGrtAi3beL5ho3UK2nRDYcsLrZxfzMUH2OHbWXKPkaSKts
	pCENszn9s+V3pEsgsPacss7XkDmhz2AoZGEJC6XECSEazl2iJgyqXpU/kLzg/nCSEf4OvM8S6Ho
	CsUH3aLERZfG8r4O0jMD3X9GU7cG5Vkw1aqUyCxKZIIWoz298sn7BvYp1tiSMLYwLIssVSOpqdb
	A6LujnzRatZ13WOWEsaXrAHtTzEo6hpdFuytmVrlpSfNvPDFYHqt82InSPIGRiyxpdLP+SoPGA5
	qGa/n8qnmXQkxOlQ
X-Received: by 2002:a17:90b:1344:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3adce0cff80mr2343177a91.42.1792775434342;
        Fri, 23 Oct 2026 10:10:34 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3addd78d4a5sm919619a91.0.2026.10.23.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:10:33 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:10:16 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Alan Maguire <almagui@kernel.org>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	willemb@google.com, eddyz87@gmail.com, edumazet@google.com,
	john.fastabend@gmail.com, kuba@kernel.org, horms@kernel.org,
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
	song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
	yonghong.song@linux.dev, jolsa@kernel.org, kuniyu@google.com,
	memxor@gmail.com, emil@etsalapatis.com, martin.lau@kernel.org,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_ksock_bind() kfunc
Message-ID: <atuU-BE4wssJaH4_@gmail.com>
References: <20261022181620.247201-1-mahe.tardy@gmail.com>
 <e31194dd72efd3c182707e870b7e7a6d67b78be23cea06aded0275678373c64c@mail.kernel.org>
 <atseCFvfx9FbTXP3@gmail.com>
 <b28db1fb-ea02-4f83-be99-c8d4b180dc6b@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28db1fb-ea02-4f83-be99-c8d4b180dc6b@kernel.org>

On Fri, Oct 23, 2026 at 05:05:10PM +0100, Alan Maguire wrote:
> On 10/23/26 9:42 AM, Mahe Tardy wrote:
> > On Thu, Oct 22, 2026 at 06:45:34PM +0000, bot+bpf-ci@kernel.org wrote:
> >>> bpf: Add bpf_ksock_bind() kfunc
> >>
> >> TL;DR: bpf_ksock_bind() called from a bpf_wq callback runs with kworker's full
> >> capabilities, so a CAP_BPF-only SYSCALL program may bypass the privileged-port
> >> (CAP_NET_BIND_SERVICE) check; the review asks whether to block it.
> > 
> > Honestly don't know if it makes sense to prevent it given you are
> > creating this kernel socket from a BPF context, if anyone with more
> > experience on this can help?
> > 
> > If the answer is yes, I imagine preventing bind() to run from a
> > workqueue is the easy answer so that all creds are respected as usual
> > and it's not a huge limitation (we mostly care about being able to
> > send()/sendto() from a wq).
> > 
> 
> I suppose one way out of this would be to forbid bind()ing to the privileged
> port range; that would sidestep the issue I think. Hard to know how restrictive
> that would be in terms of real use cases, what do you think?

Yeah this is another way around it but I wonder if keeping the ability
to bind from a wq is more important than beeing able to bind on a
privileged port.

Otherwise we can probably guard bind with:

	if (current->flags & PF_KTHREAD)
		no

If the assumption is correct i.e. you can load and run any SYSCALL bpf
program with just CAP_BPF, then indeed having this would allow you to
circumvent a CAP_NET_BIND_SERVICE check which is kinda unexpected even
if we could maybe discuss that those are BPF sockets, which are pretty
limited for now, etc. The reason why I'm thinking like this:
- I already tried to import existing network resources limitation when
  writing the initial patch set, like limit the number of BPF sockets,
  and I was told it was unecessary.
- I did this whole annoying dance with LSM hooks so that ksock goes
  through them and I was kinda told that it was maybe also unecessary.
But the more I think about this the more I think the concern is valid.

> >>
> >>> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> >>> index 37168f43c16c..c7b487d90cd0 100644
> >>> --- a/net/core/bpf_ksock.c
> >>> +++ b/net/core/bpf_ksock.c
> >>

[...]
