Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817161;
	b=W3gUMVHf2vbFL6VZYdAvnrPdHsUiAc+Z/bK1PjmOVGFGcj0HFdR4E8XgsNfwej+uY70+
	 wVTAV42meCjxhaePRPxGBrE9fz61qV0/rLsDcgaDZCThflqgjD4ZaDvixPN1KrHTgE4k2
	 KK+MjejA64bpmBa6zZH83faxn3SWmEuzkI/y5jCY9xNd6Qi+fs1C7urfgnisZ5jdeSGHR
	 oRfFT4a9zah0EmwnApEWLxi+t+FI2he97m/ro2PRePEuWxtYhRKTff0ud2CSFmIxEFN6G
	 6OlvpAx3fKTHdux1moP/+J47PoM0DKFjFuLuP/IBEgl81pKHKcZlUSDlUL73sMrmcbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
	b=dKRK90IjlaGSbUBSux3qRopnEyrz24iZqka57IvK3DNpNrrcpsTSAdQ6phrXmf6mgoov
	 sNky4wy//V9KQm4HElfuRZnEDkGFmUASy07aM7vgbaLkbkOzHnky4HxkQnJCZtyAW7MkG
	 t1DpJVt0qGQg/gK9cAeGULqENtYtsWco6ZZ5Y848QdBSuFi3h+nlmMkyxoYRQAyAWpEeh
	 iyZpFUdEZGWj2sw6JX39sS7BuCYvufEZyQ8Zn7EKJucrAkFy+4a1sakY5fVFqsxmWUSJC
	 U6HHV9qZaSKLD87QQEYeSvxyLT/sXWW+dspjXT47wMwuftoGcaxCvbhblVk2Y85bpxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnhNglyv;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCA606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73DCA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnhNglyv
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc147d86bebso616146a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 10:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817161; x=1794421961; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
        b=WnhNglyvCBh7ZPhaI+5vGqQkRigBp6TtgG0deUYHZNLf5FfinhmiZlHNByAGYNI4SL
         iSmUomw8vSyjos/KvmTEAGXcIjs5ntqRuFyyj+SDPaP1aolY1XC5rpnAwltboXplmF+H
         npO6z20tFVzn719f2b9XBNGstbEQRzUzgPW46+Dsks0ffp36oCT9dlXJBTg/OBdPsrVi
         GNYZxZ3TbMimbcRV0fLQ8t6EMIgUb0I6KT4dp0PaW8ZUcUSIu2Wb+fcGOlDFOAa4NmGE
         /sOsDZA4Gw4LOrkEAAF/eXmFi8HbwyV59xDcNGJrES/3JiZfwhay4EOl/OoArRih0CKd
         3NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817161; x=1794421961;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
        b=zFjsVaNEuo6cOCaPAMlqQxbEFW9Gyai9D6iac9hRZNnbI4i10Dx+ziMxKzADfgx4iK
         He5LRmSl/5a8cvBVcy+kWW7ziYxMegHfzZeKZHLl4/kAnnk8Vu8ZFELNyi39j1e7U83I
         yhHo0PH6LmlTIbTe++ebyt+KWXVflAPuHZ5Mf91FrysoUi7U69ONqFGGVZux3S6800RX
         8PE53OKAaH+lfRfGq0d/3DeOFIDl7xAUgpLBz6KRycoOTIagpUXjVOwJks28DzUym+4R
         goSkJSUwpZkGQgR9oSrtQmU5Le2x1RDVxPJXRHAb43I7PLwau4zSbfKMEMqAmBQ1EM4o
         qp2w==
X-Gm-Message-State: APuU4Z9JRWYAnRaD4rK+FJi1QVks5AMOhpF2ixw6FlQ6VuYhFhloRQ+7
	c7grTMARvr6G2VrhD9GuKNbMLV55ViLRFTllIDfARqWA/ScwrHqcogtJ
X-Gm-Gg: AYBFou1nFY8l8y8cjfBThJVBcrtN6Z+RuwBPeqQ0A5ENNAXFPWUpiZmrQ7EpZq+Dbmu
	I7wzuGW6A0YDfMRXTDJgAzOjypDG/wRZkT/JoQEpWRI4qTH3tQoSSuz3eXPGfeH2cONTtkFkAyR
	uo01JCN7MTCqQQQ3l3Y4YiI/SCPeqvhYqfYKrUX8VID+marLs3RnZnFMlgDh6egLZU4p5uTarPq
	BbVz3Uy4tQxRz38xGNk303CPFcMNJIiSe/krTvDq6pt67NYCdEgMwPrj+4DmL0gGDLmMq/wpjpN
	wLfXIpUCtIgtjgFHzauX2/y4ko09eWEuYqnbEoDFKfaz2Mf6JwV47iSD2YId6s70meaL/NKpUh6
	xjjU28sMNIAu2KUTzHtAFn2uA9IvtIwie7YktBkeTq3epCn9dhxC+3rEh/IWvkKbYxVrzZe63oB
	nZ7t44LyJOnFDX1hJc1QECvpvDnwB0U/l5OmQC89GVoapIalhpiT6+vX4ToqYlSjFZrbiufcMLG
	sr7rykTe0WHe03tE1OmVSgzpPwafTQu6+vygsw2gsPuZbPFLHJzXR7fisvJO+e9GejKe8a5ZUi5
	+RcIrBh9MfS6nHFXQQoLrQmtgY/lLEWt+OWgewry5vx/4lFzZs0U0BPJ9MJl/M2f4imxOUm/fkV
	6BC0K5FApTrkrytySP0CM+PNaCgJMGGeJtQ==
X-Received: by 2002:a17:90b:554c:b0:3b0:a1c6:95ae with SMTP id 98e67ed59e1d1-3b0afc77a41mr178745a91.31.1793817160656;
        Wed, 04 Nov 2026 10:32:40 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c143sm154357a91.2.2026.11.04.10.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:32:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:32:39 +0000
Message-Id: <DMMN42GPUESV.YUIKSBF4E297@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
 <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once
 the socket is dead
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Dumazet" <edumazet@kernel.org>
In-Reply-To: <CAL4Wiiq+QX8quVBjEZK5qipki6Yt7vx4=tt2L4o+FwO9zD-5=g@mail.gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-9-alexei.starovoitov@gmail.com> <CAL4Wiiq+QX8quVBjEZK5qipki6Yt7vx4=tt2L4o+FwO9zD-5=g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 09:23 PM Eric Dumazet <edumazet@kernel.org> wrote:
> "A signal or SO_SNDTIMEO of the target ends it" does not look enough to
> me. tcp_sendmsg_locked() takes the timeout from sock_sndtimeo() of the
> target, a socket the sender does not own and cannot configure. With the
> default MAX_SCHEDULE_TIMEOUT, a blocking sendmsg() on the sender's own
> socket never returns, and the sender's sock_hold() pins the dead target
> until then.

Right. It's not enough.

> Since this patch makes SOCK_DEAD a reason to leave, one wakeup before
> sock_orphan(), while the socket is still owned by the closer, should be
> enough. The sender can only get the socket lock back after
> sock_orphan(), so it sees SOCK_DEAD. Nothing walks the wait queue after
> sock_orphan(), so skipping remove_wait_queue() stays safe.
>
> Something like this (untested). sk_wq can be NULL here for MPTCP
> subflows, hence skwq_has_sleeper():
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ void __tcp_close(struct sock *sk, long timeout)
>  adjudge_to_death:
>   state = sk->sk_state;
>   sock_hold(sk);
> + /* A sockmap egress redirect can sleep in sk_stream_wait_memory()
> + * without a reference on our file. Let it see SOCK_DEAD.
> + */
> + rcu_read_lock();
> + wq = rcu_dereference(sk->sk_wq);
> + if (skwq_has_sleeper(wq))
> + wake_up_interruptible_all(&wq->wait);
> + rcu_read_unlock();
>   sock_orphan(sk);
>
> This can be a follow-up and does not need to block the series.

Makes sense to me. Thx
It depends on the SOCK_DEAD test, so it goes on top of this series.
Will send it as a follow-up.
