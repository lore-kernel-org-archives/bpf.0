Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F33CD8CD
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838061; cv=pass; b=A5pHURNBfK7h+4/fa/UjHHtaqZyqm0erks4Rmxt1RUh0J0H0roE+cxPsbJ0FdnwoQnIZKxId8dsPUqNAgOL/HjyHOX8k0ZuZkQWabDAbUNqsGdil2S/ezJicfsMC2yuLP0oUJt8EXLx5AVxz8io6RRL76XptoFoAPdCpxuyNiyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838061; c=relaxed/simple;
	bh=bwnH+qqXBGDNH1pSWPHYbKfMg7zHv6kdJ60OymekNZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7cQCb3LKnJk+z9wPdSFE5Y2deDntJba6+oXNJjc3UiD/OqtfoarSlw2ZuCF1MNqxDO1v0Uz2HOeQr5KbcCB9MCePX+sG0Nshmn4CVjQ49g9qNb6NXgXiXt8ecc72DInhCyfMTLKeL875158DFR39OiFDxjMJewUFiEFrVmJxHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd/kG/Ul; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd/kG/Ul"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8cb92f26aso12030449e87.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 16:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779838057; cv=none;
        d=google.com; s=arc-20240605;
        b=GIZ2EaodnrkUdvocA6vRDWuO51UyPPSB7F5dRv4luL+Y4xPf8g1yz4xvzDiPHfT+Bo
         BQMVjtV/4GpKGiB2S8Eo7JPZec5S2xzsrG2ILtjP1kOBIeDY5nswPd/cNgFrDITag7cC
         j5kBIv961cYk4dmQ1npP0mh2Y0nvEMPB871+XACcj/1uMvat6Sqt1/HrA8lpfgpQy0qz
         rEaQa8lAgxZ+ZCR6Dyr1+r7BcSgASZzWbH+si4GQ0M3nWv9SxPVILpAiKdYsc4G95LJR
         TN/IOnxUd9G8IGVmi+UoEo5Px8YoFETzmRUKulN7ABIJNlaAZ1DRR859y8ZSda+7HGTI
         fsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7VvVVF9TQ2M3AhNyLDn1boVhFbmnNPIqQWMPVPpz0o=;
        fh=D35vEYOPnrqplpoYmpWX22tpJSk7AWtwt53Wp63HFPg=;
        b=FW9NX8lldP8xqTzeROvmkBetogodJg2Pf0z6RjxHFulXhxNy+pHxqJxYDasP9/gEgu
         PbVogI7s9/dGL8UBSA3r4G0lRcxNED6czZdeAYbaUQUnVQrdKmrpyuJejdOFXL8nooa2
         wYrXBK5HcOFor0rilukIGzHIC9McQ5ITttrijhYJ+M5g9qIuQQy+c34E6Yfjb5A2qsLF
         kKxZ0OWaJtKr21iKZBtHp+6lvsOUDlYHhOk126p6RV2b2j+P5LDlZtrCISlaaXK47tUL
         IBiBWDiMzbCHvfr3CvFEpAQg9zvg+MhKEBVtbsO+nPp9A9MLmK07B/4dqyM9x6LL5fKJ
         /4eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779838057; x=1780442857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7VvVVF9TQ2M3AhNyLDn1boVhFbmnNPIqQWMPVPpz0o=;
        b=Vd/kG/UldV/BhQ4b693e9yQzMsEFsREfig7YKZdNZX5NlxhcbTNvvBiG3GvOH0QbJx
         /gQTNr/p3q3pMlprwEkaNM1mUxUsF2TdiDkNDNUWxX9tnhgArpyht5F0klzhn163qJ3Q
         MfHj4JZjZCB2NnFtH0AQ6+cjswnyFZfn25AilIdxqgDL5iuI16G2lMQ4T385djX15Vr7
         9XW75s5bzUF4NFdfnQ5XQH23+1QcwuQBTNyAXfcum4TvDGT/t/lbkKnVSDqHrNgOTQsk
         /NWzlXfwdV5MZKDqP60nfTlJxALLsEu8jLZsJB/6z0HrD+0wQpGUBmjrlzFfugH31wKE
         qH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779838057; x=1780442857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7VvVVF9TQ2M3AhNyLDn1boVhFbmnNPIqQWMPVPpz0o=;
        b=JnFnuCw4DZFErQyEZsiFXajqNx5ed6shlHJzRwlR6sYSRYaVu1+jQ8jqykn+DaAHFq
         YW4oepVThCKxulXaBIeQKSThpieKoV8NstSrFpm+LMFx4zdIpHHaIr2xUVWJNrWBc8e7
         IK01FejypsKNmYFOd3RELv1wCm1KREynzBru+Bses0SeWgiL6NUFVKuzbt7dmLfZcnCb
         HQh8jktgC1OdT0Rk8ykovIBA3rCgJ/sgUVvL+Xmu+dFW1OWDLs8ZQAKOrxsGBHoH379E
         hDv6lL+GEwmmG30jktUDwDqByI3+zdpSkfXiFbJvFjKw2GSP8/fGfaA2PDUOtOLJzUm1
         B3bg==
X-Forwarded-Encrypted: i=1; AFNElJ9b3F/2AVG1vDntZ/OTjOlRAKYxMSHCudLViGwq4RWckzYsCW7YPsjbEIPGR4SSqvtLKGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VuRoS8OTvRi22UyihVvROrdQpQDI2J0OpwhJ2QdBFpHzcQ78
	XiJRrWirzOioXS9QNdowcY6HZFR3Heal1jvdQZFDrbU26BZ2JmLKh4wAWjvKk90oVmWVAZ1GsBu
	jhvgP6mQ15SJSbUIYbG+CARvHuJWyFR4=
X-Gm-Gg: Acq92OEQjpo/70ZFppC637jzxETd+ueQkT/Q2i4RdedeAG/ZheI7oewZYJsREj91Lp7
	iD6v+ZvYdWEuT3FgFp5b1uhtss/LJaZDzwNaeSe06PR54aWyjlN06ihWrCwnTC+fF+dPC/jJY09
	VvFSJm3QBetE8v2h5LMF//LSEqTVfhOszpjWfbOJwT2mhoMb9S6ru+P54IhpvzldZGHTgnDTD0E
	sAhTockhFR8aM7u1BC9JVA/66PjWwYe5ghAdo06wUWg9P2mW6B9EjBKRo2wbvqSXzKzp8JHN8Zo
	NqvZ6MSvA4vktCflgqeR0wAisdOe3S2UAgOtACA=
X-Received: by 2002:a05:6512:3d24:b0:5a8:9b19:8ff8 with SMTP id
 2adb3069b0e04-5aa323cbbcamr6743621e87.32.1779838056809; Tue, 26 May 2026
 16:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer> <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer> <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
 <ag8VgX2TxYIMJZB/@boxer> <CAL+tcoBy5bb2iqOfYw1Ayr85WBRRDmsPqxmquSojNgM1U21UXg@mail.gmail.com>
 <CAL+tcoDbUkj1nJcE0HUt4Fy7FEr6oqVbpmj6utDc44KqVW+68A@mail.gmail.com>
 <ahChjcRmM+wEx2uq@boxer> <CAL+tcoBud6+nZ=Zeq-Ja+nnOcfwt71Z_QBofOS3qyrNt3Tkkvw@mail.gmail.com>
 <ahX3zCRWTD2v7kwn@boxer>
In-Reply-To: <ahX3zCRWTD2v7kwn@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 27 May 2026 07:26:58 +0800
X-Gm-Features: AVHnY4Ki4miX94TDW1Znm1UKdhBucSygFFqlEh1pGvikZPAPr6IU5qCaAcKosK8
Message-ID: <CAL+tcoBC8CUzu9S8UDN7tW3H6L9F3TMzt_pF=-dXTJ6_Mz2F4w@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 3:43=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, May 23, 2026 at 07:49:00AM +0800, Jason Xing wrote:
> > On Sat, May 23, 2026 at 2:34=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Fri, May 22, 2026 at 09:48:39PM +0800, Jason Xing wrote:
> > > > On Fri, May 22, 2026 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > On Thu, May 21, 2026 at 10:24=E2=80=AFPM Maciej Fijalkowski
> > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > >
> > > > > > On Thu, May 21, 2026 at 09:07:30PM +0800, Jason Xing wrote:
> > > > > > > On Thu, May 21, 2026 at 9:00=E2=80=AFPM Maciej Fijalkowski
> > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > > > > > > > > On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowsk=
i
> > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wr=
ote:
> > > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > >
> > > > > > > > > > > The series is the product of previous review from sas=
hiko[1].
> > > > > > > > > > >
> > > > > > > > > > > 1) META
> > > > > > > > > > > patch 1: address TOCTOU around metadata.
> > > > > > > > > > >
> > > > > > > > > > > 2) PUBLISH of CQ
> > > > > > > > > > > patch 2: make sure xsk_addr->addrs[] can be published=
 to cq when
> > > > > > > > > > >          overflow occurs.
> > > > > > > > > > > patch 3: keep cleaning up the continuation descs (mor=
e than 17) and
> > > > > > > > > > >          publish its address when overflow occurs.
> > > > > > > > > > > patch 4: like patch 3, but only handles the invalid d=
escs cases.
> > > > > > > > > > >
> > > > > > > > > > > [1]: https://lore.kernel.org/all/20260502200722.53960=
-1-kerneljasonxing@gmail.com/
> > > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > > V4
> > > > > > > > > > > Link: https://lore.kernel.org/all/20260517063311.2892=
1-1-kerneljasonxing@gmail.com/
> > > > > > > > > > > 1. correct the description of xmit path in patch 3 (s=
ashiko)
> > > > > > > > > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > > > > > > > > >
> > > > > > > > > > > V3
> > > > > > > > > > > Link: https://lore.kernel.org/all/20260515123018.8014=
7-1-kerneljasonxing@gmail.com/
> > > > > > > > > > > 1. avoid breaking previous usage of sendto, and silie=
ntly handle
> > > > > > > > > > > overflow case (Stan, sashiko)
> > > > > > > > > > > 2. add one particular exception process in patch 4 (s=
ashiko)
> > > > > > > > > > > 3. adjust the selftest to make sure it passes in eith=
er virutal or
> > > > > > > > > > > physical machines, which includes add usleep to suppo=
rt physical machine.
> > > > > > > > > > >
> > > > > > > > > > > V2
> > > > > > > > > > > Link: https://lore.kernel.org/all/20260510012310.8857=
0-1-kerneljasonxing@gmail.com/
> > > > > > > > > > > 1. adjust selftests (Jakub)
> > > > > > > > > > > 2. add READ_ONCE in patch 1 (Stan)
> > > > > > > > > >
> > > > > > > > > > FWIW I still get test failures (yes with patch 5 applie=
d). PTAL.
> > > > > > > > >
> > > > > > > > > Thanks for the test. But I've tried with ixgbe driver...
> > > > > > > > >
> > > > > > > > > I noticed there are some flaky tests which have nothing t=
o do with the
> > > > > > > > > series. Can you confirm that it's not caused because of t=
he series?
> > > > > > > >
> > > > > > > > That explains the different results as i am using i40e/ice =
which have
> > > > > > > > multi-buffer support whereas ixgbe does not even support mb=
uf at XDP.
> > > > > > > > Broken tests are from mbuf cases.
> > > > > > >
> > > > > > > That's weird. I never expected the failed tests to be about m=
ulti-buffer.
> > > > > > >
> > > > > > > Are they the same as the output you attached last time? Or so=
mething
> > > > > > > new? Could you please share it so that I can investigate the =
root
> > > > > > > cause?
>
> [...]
>
> > > > >
> > > > > Sorry, Maciej. I managed to get one server with i40e nic but stil=
l
> > > > > couldn't reproduce it. Can you try the attachment (that is the
> > > > > replacement for v4-0005) instead? I removed those nasty CONT test
> > > > > cases...
> > > >
> > > > Ah, I think I eventually figured out a solution. Maciej, could you
> > > > please test the 2nd patch instead?
> > > >
> > > > This patch reworks the CONTD test cases. Cross finger.
> > >
> > > Please don't rush things here, I believe we need to think a bit more =
here.
> > > I have second thoughts about overall approach.
> > >
> > > My understanding wrt CQ was that it is a container that holds descrip=
tors
> > > which have been successfully transmitted. Now we want to add also lef=
tover
> > > descriptors from broken packets, which might confuse user space sides=
 in
> > > case they were relying on behavior described above.
> > >
> > > The intent is right of course as we don't want to lose UMEM descs, bu=
t I
> > > feel like we need a separate mechanism for that rather than putting
> > > invalid descs to CQ.
> >
> > I don't sense anything strange here if we stick to put those
> > invalid/overflowed descriptors into cq. AF_XDP is only a tunnel that
> > transfers the data. That's it. A bit like how the physical link works,
> > which means it possibly drops data because of congestion.
> >
> > Upper protocol is used to guarantee when to (re)transmit a packet -
> > the mechanism is the ACK driven in terms of TCP. TCP is absolutely
> > capable of finding such an abnormal thing happening by checking the
> > seq of incoming ack. My takeaway from this is we don't need to
> > deliberately design new stuff to fulfill direct and immediate
> > communication.
>
> AF_XDP is often used for L2/L3 forwarding, UDP, custom transports, so I
> was afraid some existing solutions might be relying on CQ entries implyin=
g
> successful Tx.
>
> Generally this issue is highly unlikely yet a thing we need to address so
> let's follow your approach, but for that we need to update documentation
> and align ZC side so that we would not have to deviate test cases.

Sorry, I don't see the point why we need to align the ZC side rather
than skipping them in ZC mode simply?

>
> >
> > CQ works somehow as a notification that tells user space whether the
> > kernel receives the data from the app and handles them. Without
> > putting them in the CQ, the only thing for userspace to do is simply
> > wait.
>
> I don't follow the last part of the sentence but let's disregard it.
> Userspace gets errno/retcode in generic xmit so it is aware of underlying
> issues and then it's app job to act upon it.

Right.

>
> >
> > With that said, IMHO, I cannot figure out why we need a separate queue
> > or something like that. Of course, a new notification that handles all
> > the possible/potential exceptions and contributes to the performance
> > of the upper layer is worth a try :) The latter is crucial.
>
> We discussed with Magnus it would be good to have a dedicated xsk_queue
> stat for that case, such as 'oversized_descs' which would be bumped by th=
e
> amount of descs produced to CQ.

That is surely necessary, which was actually put into my todo list as
well as skb drop reason in the xmit path. But it's a net-next/bpf-next
material.

>
> >
> > >
> > > Does it make sense?
> > >
> > > Besides, even though we would stay with proposed changes, behavior be=
tween
> > > modes should be aligned. Right now ZC seems to be broken in touched
> > > regions here - when we hit the limit of frags via pool->xdp_zc_max_se=
gs,
> > > we break the loop and discard the packet, never post it to CQ and the=
se
> > > descs are lost from user space POV. Then we would continue on next ca=
ll
> > > and interpret the rest of too big packet as a separate one (clamped) =
and
> > > therefore submit corrupted packet to HW.
> >
> > Right, this is how the previous selftests changes pollute the
> > subsequent tests after that. I think the new version of the attachment
> > should pass all the tests since I put all the CONTD tests separately
> > into another two functions? It's pointless to test those in the zc
> > mode.
>
> We need analogous fix on ZC, then no such quirks in tests should exist.

I don't regard it as a quirk honestly. I'm curious what is the
advantage of unifying it just for this case? ZC mode doesn't need to
test the overflowed skb that appears in the __xsk_generic_xmit path,
right?

> Test is doing the same thing regardless of underlying mode. Only the rang=
e
> differ (MAX_SKB_FRAGS vs pool->xdp_zc_max_segs).
>
> To wrap up, I see it like this, moving forward:
> 1. fix docs
> 2. add ss stat
> 3. wait for me with ZC fixes (I'm slow!)
> 4. inspect if tests will fly
>
> Let me know your thoughts! Maybe Stan wants to chime in?

Roughly I agree with the points if you insist on working on ZC fixes.
I can wait for you :)

My plan is as follows:
1. only submit the 0001 patch only in v5
2. wait for your selftests fixes and then submit that series
3. move on with batch xmit since I don't expect this series to be a
blocking point

Thanks,
Jason

> Maciej
>
> >
> > As to the series, if no objections or any suggestions jump into the
> > thread, I'll post the series within a week.
> >
> > Thanks,
> > Jason
> >
> > >
> > > I'll be looking at ZC API but i do think we need a common approach,
> > > mode-agnostic.
> > >
> > > Thanks,
> > > Maciej
> > >
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > > >
> > > > > Really I don't think I have much time to spend on these tests whi=
ch
> > > > > makes me feel extremely annoyed... It's not easy to analyze the c=
ode
> > > > > without a reproducer. The good news is that now I highly suspect =
that
> > > > > this kind of CONT test cases pollute the whole cq which affects o=
ther
> > > > > tests. Before I give up on the 0003/0004 patches, I'd like to hea=
r
> > > > > some advice from you. Thank you.
> > > > >
> > > > > My original intention was to push batch xmit forward but at that =
time
> > > > > sashiko pointed out some unrelated bugs accidentally.
> > > > >
> > > > > Thanks,
> > > > > Jason
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Jason
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Jason
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Jason Xing (5):
> > > > > > > > > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in =
xsk_skb_metadata()
> > > > > > > > > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP m=
ulti-buffer Tx
> > > > > > > > > > >   xsk: drain continuation descs after overflow in xsk=
_build_skb()
> > > > > > > > > > >   xsk: drain continuation descs on invalid descriptor=
 in
> > > > > > > > > > >     __xsk_generic_xmit()
> > > > > > > > > > >   selftests/xsk: drain CQ to wait for TX completion
> > > > > > > > > > >
> > > > > > > > > > >  include/net/xdp_sock.h                        |  1 +
> > > > > > > > > > >  net/xdp/xsk.c                                 | 44 +=
++++++++++++----
> > > > > > > > > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +=
++++++++++--------
> > > > > > > > > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > 2.43.7
> > > > > > > > > > >
> > >
> > >
