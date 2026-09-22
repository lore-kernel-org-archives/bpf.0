Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12748285061
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040087; cv=pass; b=e8fL//dznUUjxbsPUs18QIN35r3KQC3UwPTlB/kHm/90k09za/fsQtIT+q6mSS+87FwXRMaiT5SWOCNmjz8TfDUW93J/UCMzp4fKAWZvmuKpinfZo5shfBR8KX/swZhPHDxv0d92cHo5DgXxnvZ4JlrC+INYshMz4DG46FyosEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040087; c=relaxed/simple;
	bh=XGMLc8O9wQ2kbJfaKvLL4ZU0r7ZfUppVx0yg76psbQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKOsjL39Bnq0r07hJul6cEadDu6/QLP2QSkXxsOKmunI9E2cnJG7/d5VqfFLFy79jCAHANLqKrbxsWyVh6GRax/hBKP3mdg1Q/NR3S3DVXXF+bENgNIzaULrHuchHt6wbd0EoN5MBdZnHhhS70FnFpPaJJk75YZ1f+yHYov0LS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYaruLXm; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYaruLXm"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff15fadfso14129071fa.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790040084; cv=none;
        d=google.com; s=arc-20260327;
        b=JH9f4LIRgtsYkmMdTLSCr9OfZyz7SK/fdE2hmx1P6fNu0dCGZ+KrxtRlzA4R/vMEFh
         jUgfM4m+Uo9xAr2V/r8MWM9aOcl9mStCjcc7xzR7q0rO3Uu5KabJodP1LaXx6yTKSMGd
         9MH55uoT6BcPL4McOMpOIkF/KsTfyXX+xYq+jbFd9zPME5l4cVW9PifftelVU0ZDb/RC
         hoGS6uKS5T7ss2LjJxs0qU428pMMPnV7nRPWm+roOI73zlOb+vSyYUtASi2ZXeQ6L/4U
         t4m2lcrUHgJbxxEcfXI2jHu9MBrVrjpMdzxOBl0e/zoBxn4ppoB9V8RFh5OccRGvjIcR
         DTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=94viYqPCx5bKufuoQHb0p4ULNgGNRu66+Yp2unVMzo0=;
        fh=+FmiFiTFLynHaqDE7CnX+Ws2/GFh/fq4SoHPyZ/6ueE=;
        b=loLHfo6jTyKnCZHk3pFxReWdbYSZP1aUvbZc6p5q5p0G6zXIo9cNEGzlzbJpfSe8yN
         0Qg77tofY/XM9qhW8gVDjZ/DZwyJzjJOiS6AUCfulyqi3KEvct3uVp2x/DVv0kDVS/Iy
         KzNRZjGvf/qif1rw+zbSJLSXxPZUHq1b4ANnSonc4lf2rOMcnlTLsPhS04v/S8oJh7t1
         lwVgztIpwCvwanhZAgHi66hwlTWLDljMQagKRS8nFkl/cQMw8Oro31eQmvhAHTpo3j8L
         0K5EWJ0RgLzeIWLifovSyruCa0BwAcez2uNLbKAYbj4kvP8vrizbKLd3oEyqmpG1NEXA
         4eKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040084; x=1790644884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=94viYqPCx5bKufuoQHb0p4ULNgGNRu66+Yp2unVMzo0=;
        b=TYaruLXm32cjbK09Y8AFa9Sr+6I/mt2WCO/dXA9/SaYoUu484R0cMCC+iQinzvJBIE
         qvXs45OaG4zhJ46liBEwXLmItviQkX+BQkjcO0FYWLOFYO3tr5WL7URddb/zsWJKcJy9
         RiEY0d7A+gS5zgyvL+cggenkrH4PACg7cV2Byy39ZZjElJ6Cifh9zePC0ko9F/gyNzUf
         IOHlo9pLM3M9qjCmYJxYTJ9rE5wDfCeSKPqgCFpr/YTeZpFF/WLq9bkh6rlnK9Z266gP
         d38d9BDrBWfs/CMdEINRcz+oIb6E3hz2KV7xbQn/jiErrtdULWizbduWa24Z068B72yx
         gGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040084; x=1790644884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=94viYqPCx5bKufuoQHb0p4ULNgGNRu66+Yp2unVMzo0=;
        b=ICdJVzPGyvVXK3j1fWuheyeP+J5Xlxf4XuuACkt8plWK1wc0oqODJe1SSqCEy4NfqB
         2LEspRGHbHTtFTPPWStZ/JjpHSq9XN/tEuSVmsqlb5iwGcb0HEFME1iVicxuI1OOU5PK
         2uzbz37i5AVUjxrP4HPiZE6E7mnYRczqExT5RcKhXgYxLhiVViZ+lkKwMLuLTU6WImDw
         wjnbcJPeiNVM0UBwIR/31gzOJFQihbhV2GYPvV/a73CwltQpOVbqkPGFpxt+Q5jhkzCL
         qpsg9Xs9zeYJXGyZBwCfLZ5sH3AMiHwBpq1sgG7auzaKR/qZVUrIkklF+M0GZb2SAM/m
         eHLg==
X-Forwarded-Encrypted: i=1; AKwUvBw41REJNMskYatR31pKdMNSO1R/svvwiF8LuwByO2MWQsq+er2QueRtv4ATpp2TI3QtzhA=@vger.kernel.org
X-Gm-Message-State: AFuF++ldRPqwGDxdQ/6CXpTAi+aq4dhigIrSdplanXR3/+7xUwM14nRW
	dKzJ+lg0zHMqdp7KC3Flyofvv5U+k5NnRMKrUc5nS+ygbpa0xBlkNSAza++3AFk3E0VGsRxmT1Y
	GFlJUhgDAg6dwdSuv+XHp18Vkdot22Eo=
X-Gm-Gg: AYBFou34h65laGbZba/Cz7xeOd2BuXu6VXvXQbaW+JOzTI5SfnZXoOqwxTlXfcd46D0
	g3ovwDbzdGr7d2YtSczrV8dDOy+5LNh2UE7t/ziZWqxp7UmjX8NfvrggPX36dzRnyiAgq/fMR5H
	msAt9oK9Enq6lR6Da3p6ZDO2oSd4heq7swbZln+KRPYySFJzml1o7d4hwkUAuaCUBYGfi9fzmAM
	hV70NSfzByiHNWV3fXvuXacIhUkvkAhWmpEuFl91aVafqfxK2DbDb/oF8X4cDpyGe1O7Yjtjd5m
	LK4gFBIhqsyAAC9PbDbeLSLicW3gvcmHvuNKg2hRGVEq9A4u+jGwvDjRE3umz7/GGgN5VOIb8PV
	NmC4Tx+JwEx3swpmoOHafs1jqIsfqXUCJp9Yfz68T8wswH8DzK+QJ4W74Ip5RqTMXCSqy3qCQRT
	l97XIhpr2QQ5qvDDgR6ug7en/f4G2F3s3gwtRsv0U=
X-Received: by 2002:a2e:be95:0:b0:3a5:a4bd:bff6 with SMTP id
 38308e7fff4ca-3a624b2c4f1mr2510321fa.0.1790040083589; Mon, 21 Sep 2026
 18:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919143732.11772-1-kerneljasonxing@gmail.com> <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com>
In-Reply-To: <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Sep 2026 09:20:45 +0800
X-Gm-Features: AcwNN1VMDqn6pXKiQJd98KeFM-hSrB1bZg4TJGtFZHqIc4Kp7X9yqfd5UwiOtQ8
Message-ID: <CAL+tcoDossUOJCVwZ-6U519L_bNMYngnd82e1_oQB-czA6rL3A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 2:45=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 09/19, Jason Xing wrote:
> > From: Jason Xing <kernelxing@gmail.com>
> >
> > Greeting,
> >
> > It's BPF Timestamping 2.0 that aims to observe the packet latency
> > more efficiently and simply for different protocols. The current
> > series is only focused on TCP protocol.
> >
> > At Netdev 0x1a/Netconf 2026, the history, background, motivation and
> > rough implementation of the feature were exhaustively introduced[1].
> >
> > History
> > =3D=3D=3D=3D=3D=3D=3D
> > - In 2009, Patrick Ohly implemented the basic infrastructure
> > - In 2014, Willem de Bruijn enhanced the TCP latency observation
> > - In 2024, Jason Xing proposed its lightweight BPF version
> > Detailed slides from 28 to 32 [1].
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Even though BPF Timetamping 1.0 is comparatively low-overhead,
> > transparent, it's still complicated due to a few points inherited
> > from the design:
> > - Inflexible/fixed reporting phases (qdisc/driver/ack)
> >   When we confirm the issue arises from the kernel by using attribution
> >   ability of timestamping feature, we need to further minimize the scop=
e
> >   until the issue is fixed. That means, we then have to resort to write
> >   a few complex BPF progs with the similar functionalities (like skb
> >   level tag) which should not happen.
> > - Not enough low-overhead
> >   Serving the sensitive applications, an always-on latency observation
> >   platform should mitigate the self-impact as much as possible. As we
> >   can conclude from BPF Timestamping selftests, there are some blocking
> >   and time-consuming points like where reading/writing BPF maps happen
> >   in the extremely hot paths.
> > - Minor flaws
> >   There are a few minor flaws inherited from the initial design, like
> >   missing tagging the last packet[2][3][4].
> > Detailed slides from 33 to 39 [1].
> >
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > During the process of the large scale deployment over the last few year=
s,
> > we eventually realized timestamping feature doesn't support container
> > scenario and we need a finer-grained and flexible tracing tool (packet
> > basis) after a few rounds of attribution of issues.
> >
> > Design
> > =3D=3D=3D=3D=3D=3D
> > - Start time
> >   For the specific protocol, we need to accurately set the start time o=
f
> >   each packet first. For TCP, we chose the entry of tcp_sendmsg_locked
> >   and the driver time as the start point, so that any BPF program is
> >   capable of computing the delta between start time and current time.
> > - Simplicity
> >   Previous BPF program (like selftests) is too complex to implement. Th=
e
> >   core idea is to make everything as simple as possible. And it should =
be
> >   decoupled from BPF area and previous timestamping feature as much as
> >   possible.
> > - Flexibility
> >   BPF program hooking any function with skb parameter can get the laten=
cy
> >   value, which means it's no longer bound to the pre-embeded reporting
> >   phases (see __skb_tstamp_tx)
> > - Efficiency
> >   Avoid the previous BPF operations as much as possible. Make sure the
> >   feature achieves the lowest performance impact, which means only time
> >   operations remain.
> > Detailed slides from 40 to 62 [1].
> >
> > Implementations
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > in-kernel
> > - Find a suitable place to timestamp for each packet
> > - Pick the right start time for TCP
> > - Handle the split skb due to various reasons
> > BPF prog
> > - Hook any functions that carry skb parameter
> > - Read out the start time from the skb
> > - Generate the current time and then compute the latency
> >
> > Discussion?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Do we need a kfunc to allow users to reset the start time of each skb=
?
> >   What I had in mind is if someone tries to observe the latency between
> >   two specific functions (rather than tcp_sendmsg_locked).
> > - Current implementation is real hardware timestamp always wins, which
> >   means BPF prog possibly gets the hardware time that is not aligned
> >   with bpf_ktime_get_real_ns.
> > - After the series, do we need to implement the same logic for
> >   SYN/FIN/PROBE... As far as I know according to numerous user reports,
> >   a small handful of issues came from 3-way handshake.
> > - Reusing the slot of hwtstamp might bring potential problems or make t=
he
> >   code hard to maintain. Can we add a timestamping specific field in
> >   skb to deal with the latency observation?
> > - netdev_data conflict in IGC driver. It seems unavoidable to pollute
> >   start time when it's enabled. Should V2 feature coexist with hardware
> >   timestamping?
> > - Should V2 coexist with net timestamping and BPF timestamping? If not,
> >   the maintenance should be easier.
>
> After netconf discussion, I was under the impressions that no kernel
> changes are needed, so what changed? Is it hard to track start_time

Ah, you refered to the internal version, right? We wrote a kernel
module implementing similar logic which differently finds/borrows an
unused field of socket to store the start time. It's quite similar to
the series actually.

After deploying it at a small scale in production, I think it's
meaningful to upstream it. But as you noticed, there are remaining
discussion points on which I hope we can share opinions, especially
the future shape.

> from tcp_sendmsg_locked on the bpf side that we need kernel support?

Sure, we need kernel support that why I'm trying to introduce the
sk_start_time to help.
https://lore.kernel.org/all/20260919143732.11772-4-kerneljasonxing@gmail.co=
m/

Thanks,
Jason
