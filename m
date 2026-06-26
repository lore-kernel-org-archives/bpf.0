Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25AA381AF
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433507; cv=pass; b=ToF8sjPZJzeBOMAp4WTJ6d2PSd/q3ww1Jh2+u9Mi6fZ1BNvqDn528j6bre0tL5j8+HC8GYDoY7tbmuMa0ZibFmzuasSCIDkZyugcMM5kqsyxYYdREpWsgv+dVIpS2OLE9RRIy6BgI1NP/wJ2QXWTTWRfjB8FybQZGmhwuuTlbz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433507; c=relaxed/simple;
	bh=tm/9ng6QXFy/yxdcAYME2k/dGepHGP2ultLBruVBzUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1az1Vg0o+Hnu0uOgvVJ/SOtH0pIdEHVGtc32QDpfcJOeO9QMXN6haBZDseOiYVZviL4wledHoDGvw7B180MOoyRV0mXeuHRZ3m7k7EbEzDd044MdD3CGdQEib4Ynwuh5aa9CUHUwqEjyEH7RA/bqmfSNzt7DBv8ppVfAmr6GSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WappjDp/; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WappjDp/"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aea5e2a361so204695e87.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782433504; cv=none;
        d=google.com; s=arc-20260327;
        b=fNuoCptHQKbnklgUmmDTlL55/5dcgZuBco99q8+cQwrGuuMcMVDsPPuJXfOviINVgv
         vApo1y2bcubNxAMPN8sp9aseMBKmOsjImFU4D85ypq+T8HmsmpqzTmBaRKQsOvc2EYBa
         BUySKEmGmsVDDQTy3BbJtS9kIILUoztrCg5QBPaqzq7jTREA9kacaezeBxlpvRnN7Z0H
         hjb7buOSQg2FgdAAb16R3TatVzV55NOYT6CDXQq5OB0qeIVeUa/t4gjYnIy5KQZ67qRn
         Gd71oqiXBOcXJiK1vu2CMzF70HtZ2C9SYE+L1ldrp2xEuBJe+iO0N2eIwOzLjXQYUZXc
         ur6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jWB/65iCNGVpgG5qvQh/EqdccH9lpCvvVXNz6Hio+Y0=;
        fh=amXqui17mxccnrtYRQwmpaK0DuhUJWlwM5FNvQkMcQs=;
        b=qFRsMazPwxqUt6t9jIEjqT/FgPhgHsALq4zX9Qrd1qpSV4Z+JpWArejfkb60WSKB6c
         6T/pdIIcgk8S2X02sz1cE1lVUXafkwCKfvAcAG33pQJ2vHlQLAIlDpDo/oYHl+ZInMHV
         NR0emDUEAZJ6PGIm1dBHtX2Rk1Qlw8eKHcXJF/oUIUOKzU3IFfP0oK7+vZkRqpoOcjYn
         2xlQYDjrhKnB1M7F1L4929sSaDluWyJzFkHgR7UEOzSe61VsbdmV5p2+sE7WJhdaath0
         ZMJxeBCeR5tuRSsRZdk4X3Kn5Ft+wCQLfE88ZFgT4mgQ6Lxh+DCT6Ifrc3YTTE/+lV7A
         lzsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782433504; x=1783038304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWB/65iCNGVpgG5qvQh/EqdccH9lpCvvVXNz6Hio+Y0=;
        b=WappjDp/3a8DXz73rBdAYr2m+md6mqy8AvIAtJ/ONV3PzIRbiYEfSjxKohCBC8OCH7
         brp5yy+T4kCkr2dPqZLkuqZ/81UFQMC0CLSaRc1z+dWvECbdCki7W5iJ05FXldUXnvIB
         6B8NBPPqbHuKRwxgEdYZHYoqjgUq5bEL8x7HoYAGReQu0njY2KN3gh8pzPPz5Xha9sd2
         Hbnd5a9daRTp72wzd3mHpYQDEVfkevnAF62l1B24cEwo//nf+nRS810ZYMFWlN7dZ+5x
         eQxjFbux4RnTGuyd9EqDey3dm5vnK42sk9aEUzNX+wdtfs83r95edL6pQ0H6O0tmU7P9
         DogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782433504; x=1783038304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWB/65iCNGVpgG5qvQh/EqdccH9lpCvvVXNz6Hio+Y0=;
        b=GldEBVtABEK8IJQlwia5HUin/AkT7RI50byb2O03/dCnATuy/rPhHLz2y0fj4DDwgl
         Hs+KdTxPrqi6p6ik/5dtbdVBwoh9UTfMVeRyKBQ/DgP5SdVujSztvcZgvwXxVGN4Kb91
         9QqL8rXNj+9oqZDoDjRBXSI2b6U6B3h7qE5sW4nwzV5VASfCWwGr3KCb14BozKdH8hwe
         Oy01Fi7hGcBUOLAvv2W7uSboSibpFgxGP2yiKdoN8C8d4M2352YmIkLUs6bN8kjyzXPT
         ojjNNFjANMHvYDhXl8G+jBMctEyy/Yy9cqA/RuX5GpaWCB9444HPBwa3RJCqnq9nxtWI
         F1Hg==
X-Forwarded-Encrypted: i=1; AHgh+RoWVzjKSnADj0t7Kp4dfPzLRJiKFnxRVT88bBG/9qvA6Ih71Fhc+KvyYbrQ5ORcbXHCBT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Bct2Tnzu8yMCV6QHM6qaUxiUWUldBaBU+MM46aDwsXOIMda1
	asbcJRuj3rihf/tp2qQ3lpa9qtZsdvuPcX/DCGB5DcVi2ntHIVFbgDfZsC+Dz7Zfmjd91kNbzXq
	0inDoSONImeei4kULOd+vgZFikYeS3CQ=
X-Gm-Gg: AfdE7clG2t+ut9aA+IcTFozZKJKJQSpRQVisGI5ABf/MaadD9FgSGFCCHY1szl8oKa6
	G8RO1q23jiMH87ITKQ9mYd0kf3tr+ykfnWgJTPR+asvEVtaMpiairMOBqcQLpGRpI3Dh1e/O8Q0
	l/r0Nmth29BSKh0Y9MxT8HgMq5IRsi64z4WGggYiILwrddhOu9WMErQnGAq9ue6NvW3vkkWNRnO
	buv3ZYl9IY9DA8mbqsbbxhx9SWiT5EKYQj9eVn4dOqGeKSz0CgqTJYK3egveWPvU2UuY6XnQPc9
	4zdbcYcWm7N+BcgjQVxV1RClL5SNVoB3F3JOL1mBHTk7fs+OoDCiMx9MvhYAugLbl8gQ3POF259
	sUsXkexVAZA==
X-Received: by 2002:a05:6512:2514:b0:5aa:6c05:f0e with SMTP id
 2adb3069b0e04-5aea1f3a44dmr1939611e87.7.1782433503822; Thu, 25 Jun 2026
 17:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com> <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com> <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
In-Reply-To: <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 26 Jun 2026 08:24:25 +0800
X-Gm-Features: AVVi8CdGlH37vkcvNTjP4W11sfJkcnM8sH0E8DVFLnXKaCset2j3vqBKKK-QGP8
Message-ID: <CAL+tcoDOFtTKavz8TWpU6BPrHCcL6TjY8xrmFA5y3P9Wn0T4ZA@mail.gmail.com>
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 12:05=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 06/25, Jason Xing wrote:
> > On Thu, Jun 25, 2026 at 12:37=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > > > On 06/23, Maciej Fijalkowski wrote:
> > > > > Hi,
> > > > >
> > > > > This series fixes several AF_XDP multi-buffer Tx paths where desc=
riptors
> > > > > consumed from the Tx ring are not consistently returned to usersp=
ace
> > > > > through the completion ring when the packet is later dropped as i=
nvalid.
> > > > >
> > > > > The affected cases are invalid or oversized multi-buffer Tx packe=
ts in
> > > > > both the generic and zero-copy paths. In these cases, the kernel =
can
> > > > > consume one or more Tx descriptors while building or validating a
> > > > > multi-buffer packet, then drop the packet before it reaches the d=
evice.
> > > > > Userspace still owns the UMEM buffers only after the correspondin=
g
> > > > > addresses are returned through the CQ. Missing completions theref=
ore
> > > > > make userspace lose track of those buffers.
> > > > >
> > > > > The generic path fixes cover three related cases:
> > > > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > > > >   continuation descriptors left in the Tx ring after xsk_build_sk=
b()
> > > > >   reports overflow;
> > > > > * invalid descriptors encountered in the middle of a multi-buffer
> > > > >   packet, including the offending invalid descriptor itself.
> > > > >
> > > > > The zero-copy path is handled separately. The batched Tx parser n=
ow
> > > > > distinguishes descriptors that can be passed to the driver from
> > > > > descriptors that are consumed only because they belong to an inva=
lid
> > > > > multi-buffer packet. Reclaim-only descriptors are written to the =
CQ
> > > > > address area and published in completion order, after any earlier
> > > > > driver-visible Tx descriptors.
> > > > >
> > > > > The ZC batching path can also retain drain state when userspace h=
as not
> > > > > yet provided the end of an invalid multi-buffer packet. To keep t=
his
> > > > > state local to the singular batched path, the series prevents a s=
econd
> > > > > Tx socket from joining the same pool while such drain state exist=
s.
> > > > > During the singular-to-shared transition, Tx batching is gated,
> > > > > pre-existing readers are waited out, and bind fails with -EAGAIN =
if the
> > > > > existing socket still has pending drain state. This avoids adding
> > > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > > >
> > > > > The last two patches update xskxceiver so the tests account inval=
id
> > > > > multi-buffer Tx packets as descriptors that must be reclaimed, wh=
ile
> > > > > still not expecting those invalid packets on the Rx side.
> > > > >
> > > > > This is a follow-up to Jason's changes [0] which were addressing =
generic
> > > > > xmit only and this set allows me to pass full xskxceiver test sui=
te run
> > > > > against ice driver.
> > > >
> > > > There is a fair amount of feedback from sashiko already :-( So the =
meta
> > > > question from me is: is it time to scrap our current approach where
> > > > we parse descriptor by descriptor? (and maintain half-baked skb and
> > > > half-consumed descriptor queues)
> > > >
> > > > Should we:
> > > >
> > > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to user=
space
> > > > and do a full stop here)
> > > > 2. now that we really know the number of valid descriptors -> reser=
ve
> > > > the cq space (if not -> EAGAIN)
> > > > 3. pre-allocate everything here (if at any point we have ENOMEM -> =
cleanup
> > > > locally, don't ever create semi-initialized skb)
> > > > 4. construct the skb
> > > > 5. xmit
> > >
> > > Yeah generic xmit became utterly horrible, haven't gone through sashi=
ko
> > > reviews yet, but bare in mind this set also aligns zc side to what wa=
s
> > > previously being addressed by Jason.
> > >
> > > I believe planned logistics were to get these fixes onto net and then
> > > Jason had an implementation of batching on generic xmit, directed tow=
ards
> > > -next and that's where we could address current flow.
> >
> > Agreed. That's what I'm hoping for. There would be much more
> > discussion on how to do batch xmit in an elegant way, I believe.
>
> This doesn't have to depend on the batch rewrite, we should be able to re=
write
> this non-zc in net, this is still technically fixes, not feature work..
>
> There was already a couple of revisions with this drain_cont approach
> and every time I look at it feels like the cure is worse than the
> decease :-( Obviously not gonna stop you from going with the current appr=
oach,
> but these fixes feel a bit of a wasted effort to me (since the bugs keep
> coming and we are piling more complexity).

I see your point, but rewriting is something that cannot be easily
applied to the stable branches? Until now, we fix issues one by one
which have an explicit target branch (because of the fixes tag). Cross
fingers :(

Sashiko has the magic to find out the hidden bugs more than ever and
AF_XDP is not the only place where a pile of reports are coming in.

My take is that batch xmit has been appending too long and at least so
far less and less bugs are found by sashiko. I believe if the mode is
changed to batch xmit, there are likely to be new and challenging
problems to discuss. I prefer to solve questions of the batch xmit
series.

BTW, would you both come to Netdev 0x1a next month? I believe we could
sit around the table and discuss some future plans there (in xdp
workshop?).
https://netdevconf.info/0x1A/sessions/workshop/xdp-workshop.html

Thanks,
Jason
