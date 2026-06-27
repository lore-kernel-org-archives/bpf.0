Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AD70808
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521297; cv=pass; b=HCEPA5kY69NKG53ssX8Ez/3Aqis+28wcipXC+yELy63tyCGT/UM48woM5asRBnuS3S2CqVlDozVPuodYRinbBCBrQiR/ISHIUMoMXPR/tjm4H6BPkBqc2dzKNyqkAAK5wqLSx7lUR7ZW3vrDiZZr1GgNHKOoryvG6g0USk+eGXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521297; c=relaxed/simple;
	bh=Bmz1WKyaVMmyeUHYDXRZy/G2uXyM9XjanlQdBBr06KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGITXZ0X1/ggAWzGoF71wXia8NQtSfpX+KETNfdAj274R59LaDUO79hnEF26R+c0rR1ywiBnYtynjTFK7VS89U5R2g3rauZ8q4eXSMwyChQKBw0KiZDjhHCGt0Mym5mNJ8DJfE/SZURqDkXolIgLiMywf0qwisNynPBddfrCY/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNTYYib8; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNTYYib8"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aea7bd6e18so896321e87.2
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 17:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782521294; cv=none;
        d=google.com; s=arc-20260327;
        b=n5+jCVO0sIRU6eKESmbFt4/DO85c8juICPQvHwLQWU7ArKR/wg2EktYyuG39T+7BIt
         BeehTf2IvVuJYSEypC3opZmuth69AFBQH02uA7tMc1kAQ3VpTWYAYNbPWyq323MFQWLH
         O7TgUD330jmMf/UYHQUMsycTJZkIK664VKMWO9sjjjxqpZWol9cZaVQTWDyGXodnD6Uv
         2V+r//AgSGjGUsiw0oR6PM7Qo1b0jUJX9wshz1rC2kqUjDKXew2yjWNMEqunUl8XcK66
         fyvAKU8mSOi3I1zPOtjhwx0zD5TbF4PsDUsLkX4OusfYARei++MAjkOhgS7xTxNG5d6o
         TJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i8oCl3yYNOYjny6JkpEjXGEO5YMr6q41v93XlfvgW5w=;
        fh=mKgy2AaurDJQLN4zOj/GE+mtrMFHo3aNAB9/wmqSFpg=;
        b=owiZKwEt0JnDjQKUsrIg5rdXt7uVJwhs7vTQhhRZA1BY9xfyVWGkojEP9mwiQMnb5o
         kWQC0jHhSUB5RDkDCc8G3BWoWCdOFn4WDQCv+BV0ls6YEN+2FpIvXac8tIrFR35/7PeN
         CwhH+B4aNo3qj4mcUR9Rb8PyhgmYhDHxcO9Md/f2YJsoEKAcElgTOhasbAt3Boz9coyI
         hH3aG+W/Xi3PlhxSEu9gxJ9095OabZ7zG1kWsdY2aJFNjoPRr+r3i+fblPa1lJlo/unn
         fqEhqFw5zrEe/CHi5h45n2i/IUmW/6gBGKnCGqp8HSbnPfTT4g+arAmy5LBTwpeQGulT
         sYcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782521294; x=1783126094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8oCl3yYNOYjny6JkpEjXGEO5YMr6q41v93XlfvgW5w=;
        b=ZNTYYib8E7CYkRYTiMolPZwBa2y5iJ0QJ7UqPWRFoYXgQ5WAMJaNlIBFKy+O7Qp8GA
         4DEHGS5JRvSTIIA2iFkMmgNFtyNCFmTfOZ93EXAkgitJ1JmrxtojMDnxN5ILpBI3FUSc
         eb62pdUiMv8DrcK4cQBDce6lwswS1hWS4KH3n6uu66Iq5U9HEEB+LDg1MnRrJPzSdi6q
         b9nxeOCKutRCiicdMEZMyqQGAnC6FaJUNOg+F1jgJac5PoktkPdguKxtIdtwo+/h8i3Q
         lbuPyjRqTWiRNXDx6uKKlx10FhrRwCXHU3O5NBvl7T0AVZ0ttseTpBzEaiEbbSAtw9Ae
         Tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521294; x=1783126094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8oCl3yYNOYjny6JkpEjXGEO5YMr6q41v93XlfvgW5w=;
        b=UN6IPlc4WOfURt1n5JC9lxJpHWgDH6nG+bvDmWtct19IpW8DzSOj+e1xJZ0LORU1C4
         klMwey22XA0qysK3cAsrMtfXEpMmTIFgt3+NuocgEOw3vGrK3kvEl34kWyaULnKMB7Y/
         QvAnAr06oRHXResK4F+hhEznxxC+wdITvyL1z3q7OOni/yyyy/PpiVWcgsgb06jnhEOg
         vCFREX8uTtubBqcgLrDbOTB803lb0qO/hXFq69xQJVsftfAn3fag7/Tn+hPVMQfBPy+i
         l+4BSusotTFWfkwZluXGaKrR9CFTwWSItcvH3oksLITgM5bCAzZjpYYS7p+Il6bf6E1Q
         g5kw==
X-Forwarded-Encrypted: i=1; AHgh+RoXLv9lVM/c8irEzl7pcVRHOmdbjPFVmLXeZDmdCeTqcR6/A05FCHzi3Xcv4CU+23m3bg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPVFwmRooQ2u6xlircLHW1AjUauRUickppM6+j7JeTtO9Kzah
	qhIYc3KRn7YHURO1e4iwHFaJ2nzaR1c3VuDfl2vc7okouz9ac2jVM4g4WkBGflnODrUzQcQtd7B
	9aF3IA/HhMHmYL+8Ak7TXvj74H8CdwSk=
X-Gm-Gg: AfdE7cke7k1+sgmHcjPtmN7bxrof7r3VEQrGv5g0kqZA8tZN9R0xZ7vt8sVzR03GgUG
	aEgh74KK2oH4su/NCu7maborudIZH+umCcGOie9uhY7kfTGAoRDSroEBh+gs/AmfDNrqRTdOH7e
	l0VGHzgVVXU0I9fOuC18QItbUQucyWj6/D8i4KC+C+A2V2aS1X+4q2krURfylns+vBBQehI1bdR
	1Cskebq/he1OlPy2Tloo4fxechnpFefCIiQXTjlfJAnz6dzq4N3+NVA9E6i8sUJwv7cvefdg5ua
	NXhoRfUVLKFCuhmByQfHEuaNlRjjfEKFweqZf8ATxSqfye6l1vAONcLi9ranZkOdd0en1QEiPWT
	gKnzq/rXwIQ==
X-Received: by 2002:a05:6512:450c:b0:5ad:4cbc:ce9e with SMTP id
 2adb3069b0e04-5aea1f3d59emr2353400e87.5.1782521294123; Fri, 26 Jun 2026
 17:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com> <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
 <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com> <CAL+tcoDOFtTKavz8TWpU6BPrHCcL6TjY8xrmFA5y3P9Wn0T4ZA@mail.gmail.com>
 <aj6mr-cIcF2Tg73r@devvm7509.cco0.facebook.com>
In-Reply-To: <aj6mr-cIcF2Tg73r@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 27 Jun 2026 08:47:36 +0800
X-Gm-Features: AVVi8CdyDIBQUVaqwVW16SE-8u2NgWuTXDypc7adtnCyKWlnX6IZ-ykD_71LcYo
Message-ID: <CAL+tcoAdBRUSFTJfaNKSh9hLK=pgvWTwp0T8u9aYps1dFENwvA@mail.gmail.com>
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 12:30=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 06/26, Jason Xing wrote:
> > On Fri, Jun 26, 2026 at 12:05=E2=80=AFAM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > On 06/25, Jason Xing wrote:
> > > > On Thu, Jun 25, 2026 at 12:37=E2=80=AFAM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrot=
e:
> > > > > > On 06/23, Maciej Fijalkowski wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > This series fixes several AF_XDP multi-buffer Tx paths where =
descriptors
> > > > > > > consumed from the Tx ring are not consistently returned to us=
erspace
> > > > > > > through the completion ring when the packet is later dropped =
as invalid.
> > > > > > >
> > > > > > > The affected cases are invalid or oversized multi-buffer Tx p=
ackets in
> > > > > > > both the generic and zero-copy paths. In these cases, the ker=
nel can
> > > > > > > consume one or more Tx descriptors while building or validati=
ng a
> > > > > > > multi-buffer packet, then drop the packet before it reaches t=
he device.
> > > > > > > Userspace still owns the UMEM buffers only after the correspo=
nding
> > > > > > > addresses are returned through the CQ. Missing completions th=
erefore
> > > > > > > make userspace lose track of those buffers.
> > > > > > >
> > > > > > > The generic path fixes cover three related cases:
> > > > > > > * partially built multi-buffer skbs dropped by xsk_drop_skb()=
;
> > > > > > >   continuation descriptors left in the Tx ring after xsk_buil=
d_skb()
> > > > > > >   reports overflow;
> > > > > > > * invalid descriptors encountered in the middle of a multi-bu=
ffer
> > > > > > >   packet, including the offending invalid descriptor itself.
> > > > > > >
> > > > > > > The zero-copy path is handled separately. The batched Tx pars=
er now
> > > > > > > distinguishes descriptors that can be passed to the driver fr=
om
> > > > > > > descriptors that are consumed only because they belong to an =
invalid
> > > > > > > multi-buffer packet. Reclaim-only descriptors are written to =
the CQ
> > > > > > > address area and published in completion order, after any ear=
lier
> > > > > > > driver-visible Tx descriptors.
> > > > > > >
> > > > > > > The ZC batching path can also retain drain state when userspa=
ce has not
> > > > > > > yet provided the end of an invalid multi-buffer packet. To ke=
ep this
> > > > > > > state local to the singular batched path, the series prevents=
 a second
> > > > > > > Tx socket from joining the same pool while such drain state e=
xists.
> > > > > > > During the singular-to-shared transition, Tx batching is gate=
d,
> > > > > > > pre-existing readers are waited out, and bind fails with -EAG=
AIN if the
> > > > > > > existing socket still has pending drain state. This avoids ad=
ding
> > > > > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > > > > >
> > > > > > > The last two patches update xskxceiver so the tests account i=
nvalid
> > > > > > > multi-buffer Tx packets as descriptors that must be reclaimed=
, while
> > > > > > > still not expecting those invalid packets on the Rx side.
> > > > > > >
> > > > > > > This is a follow-up to Jason's changes [0] which were address=
ing generic
> > > > > > > xmit only and this set allows me to pass full xskxceiver test=
 suite run
> > > > > > > against ice driver.
> > > > > >
> > > > > > There is a fair amount of feedback from sashiko already :-( So =
the meta
> > > > > > question from me is: is it time to scrap our current approach w=
here
> > > > > > we parse descriptor by descriptor? (and maintain half-baked skb=
 and
> > > > > > half-consumed descriptor queues)
> > > > > >
> > > > > > Should we:
> > > > > >
> > > > > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exha=
ust
> > > > > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to =
userspace
> > > > > > and do a full stop here)
> > > > > > 2. now that we really know the number of valid descriptors -> r=
eserve
> > > > > > the cq space (if not -> EAGAIN)
> > > > > > 3. pre-allocate everything here (if at any point we have ENOMEM=
 -> cleanup
> > > > > > locally, don't ever create semi-initialized skb)
> > > > > > 4. construct the skb
> > > > > > 5. xmit
> > > > >
> > > > > Yeah generic xmit became utterly horrible, haven't gone through s=
ashiko
> > > > > reviews yet, but bare in mind this set also aligns zc side to wha=
t was
> > > > > previously being addressed by Jason.
> > > > >
> > > > > I believe planned logistics were to get these fixes onto net and =
then
> > > > > Jason had an implementation of batching on generic xmit, directed=
 towards
> > > > > -next and that's where we could address current flow.
> > > >
> > > > Agreed. That's what I'm hoping for. There would be much more
> > > > discussion on how to do batch xmit in an elegant way, I believe.
> > >
> > > This doesn't have to depend on the batch rewrite, we should be able t=
o rewrite
> > > this non-zc in net, this is still technically fixes, not feature work=
..
> > >
> > > There was already a couple of revisions with this drain_cont approach
> > > and every time I look at it feels like the cure is worse than the
> > > decease :-( Obviously not gonna stop you from going with the current =
approach,
> > > but these fixes feel a bit of a wasted effort to me (since the bugs k=
eep
> > > coming and we are piling more complexity).
> >
> > I see your point, but rewriting is something that cannot be easily
> > applied to the stable branches? Until now, we fix issues one by one
> > which have an explicit target branch (because of the fixes tag). Cross
> > fingers :(
> >
> > Sashiko has the magic to find out the hidden bugs more than ever and
> > AF_XDP is not the only place where a pile of reports are coming in.
>
> net vs net-next is fixes vs feature work. If we can't fix the current
> code, I think we can justify a rewrite using a better approach and
> route it via net. This series is 7 patches anyway, it's not like
> it is a quick short fix :-) But I'm ok with pushing it as it, I'm just
> trying to see if someone on your side is fed up with that part as well
> and wants to fix it "properly" :-p
>
> > My take is that batch xmit has been appending too long and at least so
> > far less and less bugs are found by sashiko. I believe if the mode is
> > changed to batch xmit, there are likely to be new and challenging
> > problems to discuss. I prefer to solve questions of the batch xmit
> > series.
>
> We can redo this part separately, without batching. Move from "read
> one chunk at a time" to "pre-read all chunks". Batching vs current issue
> are separate.

If the implementation of 'pre-read' is clear and simple, yes, it's a
better way. (I really want to engage myself in this right now, but
sorry, I can't since I'm writing many slides for Netdev.)

Probably Maciej will give it one last try; we'll see then.

>
> > BTW, would you both come to Netdev 0x1a next month? I believe we could
> > sit around the table and discuss some future plans there (in xdp
> > workshop?).
> > https://netdevconf.info/0x1A/sessions/workshop/xdp-workshop.html
>
> Yes, I plan to be there in person.

Great.

Thanks,
Jason
