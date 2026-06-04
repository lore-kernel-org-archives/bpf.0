Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680C3ABD99
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588819; cv=pass; b=ZfTeLrk319dAm42Pu7MtdYmCROM7gRgvPyFS07araPHZEJYs68+PWR0V3e1x+Z/lOFsdY72JMjQw9GXLBqNv6Pb9/HxLwHU+WWZS8hH9OzanI8OzMU4u6Kuy8iQFaHarx7sFJ/5NbuAofKFtVoJWoHyJvp9nVEdXHXV7mlK1n8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588819; c=relaxed/simple;
	bh=bLe1Y9Of8HNmICgPAiQwdq9YGoPx+pI+2J6qjn08Evs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU56knB+4BS9Ln4pm/gKI9EuQrIcE458KjI4wiIJhP98u+Ux6gZslXCwpqz7yJctP+N07dBLQzaDCILhmGWIhPpP0thyu8Ods2AiwcscAiQvvVCFZHG65PB322ClCdJ68KNYTI8vh8YwXBCo7O/18+6kmdUbQXgbvpyUduTk4Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUdrVTEs; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUdrVTEs"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8cceaacd07bso8589956d6.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 09:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780588817; cv=none;
        d=google.com; s=arc-20240605;
        b=Egb/2WJQ78onGycKu1OUkJh+2Uch/ZQ6HQCG7KY+MWjEsBcRGZy2UrNQPgsLaSxFMX
         ki5drrRUuMphXSkTI0NvXEvjeeQwa5YTJ1WvSECYT9kKtmiHkslJoL3Bjb3GT3uRDoce
         QV/JGVJR2iNhCSJCiWAvCEukB5i6QGtzv3cbMJ77eVw7t3Lcy7h2sZOx8yHoETrx8ADF
         WmgBepewdaDALYlErBgF0q1oLf4KWT4iDrjOISYkKVrqw1wdcZx8jTqydOFTkc1Y6OZg
         Yl5pIGiReXroNNu7fRycOxucD3kcBXeIpoV0ntkNATq0ndUgas3SSeqW1HWct2Flsd6m
         /Sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        fh=75f2A28W9VcM7NHPBVVYIk+5JD7pHrzYxxfTKKi+ct0=;
        b=a7qtnpr9t2Ed0LltmAnW3wdWChWbcQOqrRWq0Z6Z+mTPiEW7/mbPeWqLmyZjFbgVlx
         8k47EDu4jW1jSPMzTp7xQR6PGf7Lv7F9G5J8xSEepHDb27dJ3nfJTLN0NPpI8n2gQFs9
         FI5kCFD+F+tXNY+Q+Z98Ee5Db7AOWrJKMRghw/hfZlLIpPUe9B6Ve2sQSrpFG1Mtu/CK
         qibYt0cOO4xKX6CmqABRITX+J6uQI4oxWrz/wX8uthKc0+Lbtp8nNAvHYEW+sQMLxkb/
         07n7CQwzWzXn9ulU16VhS+d6rmuNki4QwkfeuCNHTnfci54tfZ7K788QPav/6KTPbFYo
         RQIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780588817; x=1781193617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        b=ZUdrVTEsopIF2xCG1HzWlcWIBKbS9DCFIlYws9LCWlK4utQH5+8hfNN9s3QYItnklm
         Cm7wy9BXaf/vdf27lWf9fstb8GRELagqwzQD97fnqfzIR4hrlQq1r3AB90yomVXQ7Uvr
         xoNisG+j7buROc40OA/nlGaKpTWRe+WvkmDyL4OtsI2woLWYZ6fHiZyZjznBHRSbYRFM
         p9VqFb3h5o5GQtIiCKPmtnST4Xkze+oSPzSXc1e7EdkdPqY3sY/0InxJkLHRHw3KMk6r
         tC3XDXWRE4w2fEFAihknzjFqRlReVXF9TjU087p5WnvYzpfFweYKP0B0xMilxGSu3Jjd
         uqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588817; x=1781193617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        b=sMEthUkd5sA36ArHfBt30KsNGWa6cLnL9cMAX8k4DkIoC/ScgQI1KQSdHmnLcnTauD
         dIHaHbTDELpI9sKerIeLVWcRz38vG6lWs8B08564bCfl1fIQbSGBiStXhrO0rX68+hgT
         2whzLZjMl2e2dsXeutpmHa6obxyexkpxxRKvmCa31I5RFoInsyfiHJab2kAidUx7ehh+
         +BEyOYUdHygi/aMI+mJ1xLXIXwY6KLJG7OBnt2PDsxNkyh74VokNqENcX5skcTAPvQqr
         Myhy9oLUNrdU51JbnoD4pShcjPcbRFPik8346QpUWaM+en1JoERGZ/cgFJ06oAARSDsO
         FK+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+J39LmHkhR2wfAwAJhZw/5eyN5FInqktuGYI22d2wAThoP9j4JEPHsLtezQ4/50O8c558=@vger.kernel.org
X-Gm-Message-State: AOJu0YziDGwvMaTHGCjZLWcPxm+a70IdB/1cDAmP0XzQwX6oq9OMgkcy
	HCQ4YTSwF967Y+hoBPmv26hS5HStj09orcRh0DfImCFRStGcOyQl5QIw3GTy/+wyty3DapYgLXv
	b91HlZoROyfQUunoifoJP2DsAwdMESR+KKn3vEzmu
X-Gm-Gg: Acq92OGn06fQX3XjsfebXmmn2zpgFDyl2uN4da893as/TgbN8/vjRnqqMum7UvUTd4W
	/3zqZObYxa9pSv3YG/t//JPuVcKvF73hHJDWSpxFWBt4N7gfJH7aAZGymtpGx1TzK5EHFG9w5Z8
	NBgUTybPDv3Y6NLYDh+eWvdMjS/SDlIhL6S8zjIHcCrgLWV+l/Gy9b8FuD2G7ClYtUC2Z6TwLN/
	VCHdiCyWYT0GMsFTelGPMBCrFJD/LKWbAZ3DLTEr/vMG4Ir6jEeElqiY67gwcnorC4c7eEIOh3Y
	+8Cp+q78oaQyVPsdvcE2mqyD7frlKCdu3reJwg+9HgNStrv9ZDAbLChzCRTFRI++clBUHkVrBKw
	iaD0/vGEOCvqM4eH23ZfcOoo2DFWy3g==
X-Received: by 2002:a05:6214:3c9f:b0:8ce:a005:3e93 with SMTP id
 6a1803df08f44-8cece02dadamr121809056d6.35.1780588815554; Thu, 04 Jun 2026
 09:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603162737.697215-1-rhkrqnwk98@gmail.com> <b5d4d726-c32f-45e4-9ea7-28f7b6a1f8d7@linux.dev>
In-Reply-To: <b5d4d726-c32f-45e4-9ea7-28f7b6a1f8d7@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jun 2026 09:00:04 -0700
X-Gm-Features: AVHnY4KFeB_7dmL9P1vPP7kjQ_Xqs-Cnp4utG2D6VMV7WmTclo4knkrnYzYYWMU
Message-ID: <CANn89iLhibjsgf-nk5U9be5kRpg3k4FXchKszmerkMbaaK6z6w@mail.gmail.com>
Subject: Re: [PATCH net v2] udp: clear skb->dev before running a sockmap verdict
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Sechang Lim <rhkrqnwk98@gmail.com>, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jakub@cloudflare.com, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 6:49=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 6/4/26 12:27 AM, Sechang Lim wrote:
> > On the UDP receive path skb->dev is repurposed as dev_scratch (the
> > truesize/state cache set by udp_set_dev_scratch()), through the
> > union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff=
.
> >
> > When a UDP socket is in a sockmap, sk_data_ready is
> > sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor=
()
> > (sk_psock_verdict_recv) to run the attached SK_SKB verdict program in s=
oftirq.
> > If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
> > bpf_skc_lookup_tcp), bpf_skc_lookup() does:
> >
> >       if (skb->dev)
> >               caller_net =3D dev_net(skb->dev);
> >
> > skb->dev still holds the dev_scratch value (a non-NULL integer), so dev=
_net()
> > dereferences it as a struct net_device * and the kernel takes a general
> > protection fault on a non-canonical address in softirq:
> >
> >    Oops: general protection fault, probably for non-canonical address 0=
x1010000800004a0
> >    CPU: 1 UID: 0 PID: 1406 Comm: syz.2.19 Not tainted 7.1.0-rc6 #1 PREE=
MPT(full)
> >    RIP: 0010:bpf_skc_lookup net/core/filter.c:7033 [inline]
> >    RIP: 0010:bpf_sk_lookup+0x45/0x160 net/core/filter.c:7047
> >    Call Trace:
> >     <IRQ>
> >     bpf_prog_4675cb904b7071f8+0x12e/0x14e
> >     bpf_prog_run_pin_on_cpu+0xc6/0x1f0
> >     sk_psock_verdict_recv+0x1ba/0x350
> >     udp_read_skb+0x31a/0x370
> >     sk_psock_verdict_data_ready+0x2e3/0x600
> >     __udp_enqueue_schedule_skb+0x4c8/0x650
> >     udpv6_queue_rcv_one_skb+0x3ec/0x740
> >     udp6_unicast_rcv_skb+0x11d/0x140
> >     ip6_protocol_deliver_rcu+0x61e/0x950
> >     ip6_input_finish+0xa9/0x150
> >     NF_HOOK+0x286/0x2f0
> >     ip6_input+0x117/0x220
> >     NF_HOOK+0x286/0x2f0
> >     __netif_receive_skb+0x85/0x200
> >     process_backlog+0x374/0x9a0
> >     __napi_poll+0x4f/0x1c0
> >     net_rx_action+0x3b0/0x770
> >     handle_softirqs+0x15a/0x460
> >     do_softirq+0x57/0x80
> >     </IRQ>
> >
> > The rmem charge that dev_scratch accounted for is released by skb_recv_=
udp() on
> > dequeue, just above, so the scratch is dead by the time recv_actor() ru=
ns. Clear
> > skb->dev so bpf_skc_lookup() falls back to sock_net(skb->sk), which
> > skb_set_owner_sk_safe() set just above.
> >
> > Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>
