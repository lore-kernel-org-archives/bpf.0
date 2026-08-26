Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6353DA5B3
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768478; cv=pass; b=UFWVxgLO7RT3w6d2ULYKr6Z7PRUBDpiUdqmq8N+yiRUgZn/NMIGCFOWQ/BQdfJRH2ZvAWHXXOQioNZucFvS1T5TskbDW3TWoC6HEoJWMovxVs6JjSva8m9RAmlnhaMaogsGwVaua0f+X+61BNJBym4tMP5AJUIqzpX8h0CH5sGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768478; c=relaxed/simple;
	bh=nItcYxNyC/GIY16bk8f5jPuZZ2if7+4AB27bQvCwOhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9Reh/1g5QaYjgDRVLLbIaOWNTZpWpC99e1+2M4+THzsQIWgJ9SJY5eyg+WT6RURAw+G+KUtZkMihvJDqExWCBeKkG9zFlhrHAQnikY+jPqidxNz4geq6FmAkBrmge/bRDcEfAd+csWUqU6ofkoT5AbWKTOHQgR7qHkYiIzUhAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Wxj1ZLDU; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=F+5DVUlA; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Wxj1ZLDU";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="F+5DVUlA"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QHMZHS013124
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=SonW16Ceu+sIpIzw6YaNAgkkLxM0XJEsjcEY/fc7Cbw=; b=Wxj1
	ZLDUbjh1sdh1xV8GF/ljIcL/JlKjrwQKZvwO0toiGpxiPni90NxnHV0aZHVri5q9
	5k1izsDpA7NNq2J14+jw+03lZ/sxBlah9Mg3Xe1ItrJJA2aaBf8dHaRmjAo6tPn1
	bRwgWKRVavFHLCNRzlDNMDr3WDyatPn9SgZt6L3BQzaBiTL4Y19KiX2zDkzHygh0
	SMFqSwALJoZOEIwAM3sdWAbXeii1Mlk8BAMqJ49HbxdZnFZNQX8lls9xYmMf7Ua2
	SsWxPfKYZTvBFeyLtdGpAdUco2fI6ND2FsJzB8EC7xz+ygh3VE3cxbUH5yaLSTPS
	YFC+pYZaDzNQvN9QhA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ga4g3gf8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:21:06 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-845f687dfa2so42879147b3.2
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 11:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787768465; cv=none;
        d=google.com; s=arc-20260327;
        b=Ceqba/o588hazM/BxSEhTwOy1uiSH49xDwFE7M2CroA+e8M96WitqdL6Z0QgEINf2/
         HKZB/al2ebv17b45HSqBY9Ga3wOV4HlybfZ6JXIDW8++lLobWEvdgrPOPkOEOWNBlqL5
         j8sV8h1ZxHvX1k18Udl2Ptbjdj6cLLCYjiKrl1OYKpaq1t5K000cv7ORkDmtJSMUsKBJ
         G7zpHtHgt4OU544d63CiP+Sxevc+k1MJailnuBuItxlsAnK5beXgD5SR42ovSLLQU0Ky
         aemDRs1d16tOWd4oLOwaJZI4yfUErVf4CUe1x1oSnHPWZZ5oglVe5T4eSHVN3B8q7kC9
         zVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SonW16Ceu+sIpIzw6YaNAgkkLxM0XJEsjcEY/fc7Cbw=;
        fh=O15/nwl8HV8G6ieXo2p7UI0Ao5Ahdq1tXaJVMJ2UZS0=;
        b=sx95Y/3OT5GAnuFWPYUByIHnYXaNlXujeUnL9X5CJTpP+pK1CFiNQ3TiKXGp5XzWZp
         XUShfNhdOthgvbLjbWSn5e6rawrAw3aRT1uOXDMI9RfLpa6XzVa4thsri4rvDrxkiDBy
         zG0BbPlHvO3W/oqC5gVd+Kvrz5FXom7Qq8d5nTik3VWHaobAubx1aOWvYRoNmtjdO+HC
         n9w5LnrfufyX6H/VPcC9SkR4U345aUuSq69AOfUN84Q0iQfgNL6hUtqB49rDgLzEe8Q+
         W+T2i/RnuZ0c+YR4exp7ABBde9UtulT66hVFek9QWye6/Vt6XqCNqfSLP5E6Ab5851hH
         xrQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1787768465; x=1788373265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SonW16Ceu+sIpIzw6YaNAgkkLxM0XJEsjcEY/fc7Cbw=;
        b=F+5DVUlAscgaEaVCKoSn1tZ4DL4483qDf5Ed2H0WSfzV0LYe89+7q202deL8uOS76D
         r0ggTMjOKleMo0zhNJ1VVoZFgkBq4szq/D+ENur3c0hyF0q7F2iVSe/FrsRhQOzjmAld
         F+FoFHs5wb+alkbV2ZeayoPX3USvI1Q0Cdq5KiU9LN4HxZDGpBn6irrgriU1XPpluneD
         g+lHZ2sZsZxgzRi6O/0H5kWC88RMi/w7kYhzZX5Gw9HrNg0VyhbvXv1Mf/3GsPHWRY5C
         ZITRIRRFzbzKMDpbg302+qw9krbJx2ZgOG0tIB8Pn+iqpbYrxMCveDtVFkCjLlxZau18
         5Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787768465; x=1788373265;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SonW16Ceu+sIpIzw6YaNAgkkLxM0XJEsjcEY/fc7Cbw=;
        b=NQ/9BJC4WnDaSAFE57W/0UFKFKMGwydjymp2KaUJOP29Iq3DDbdC/dwb3gy0d55QGl
         NZ4C0fu1UmywNte6FgoQgcKfOdqIzPXoeUCWRQVqVvMih6Ie7RnryZC/a8Xso0GQKEB6
         /6BLPJW//veCDUdVfAeNuuK2NhLagm4ZfXPQ0/4z8cnQeNT6y/FAWLRCq9gm1Ajgw6sX
         dHWx8tw5F3Ae1ed7z3I/QXCFhIwVZfJhpv/alKbfwjbrjXp+FkJoLbWfyJgcsSdJPkeV
         FFEs1VGGJN3Z0yl8n9YX/vJ+4YT9QeWTHRZnDK6J+dryd3U6RwtaMEfJ0u+vwHlpSweF
         nE1Q==
X-Gm-Message-State: AFuF++k4/n/3Xh7Mn4ePeSy1AuebM9XJo+JpL9qnPPhLhSFkfzvGXtOt
	b5AmR5R4dtlkX/LCu2E2RA7Ie/YR3eXv10jNEMGC7vIBomeSKofG+eYQLLa/Qu+hqUvG5WSPS1m
	xokwKmSe3QyisJaTQYtEUzmHS2Wc8/gJmOxNtMyk8e9Y03h3kfZOXMAGv9HKiuSTMWjUFUaaTAi
	KPk9j+f0rMKkq1rokeRpogKiToNPPe
X-Gm-Gg: AR+sD11c8S/WYcqsaokMoiIvALfHyfIl3T8esgHwM63NdMcqYggCKc1ZnL3tfNmbWq9
	SxmBI7KslSe+nX4BirEv7gEtkEf82xhAlu0N23bu+sfs2IKDVMZ6tniLntUcQ7z9Yb3eGbYjH8p
	MMRnhuTlvP5JWMxPUv1dii4Cfproo3c/JhhI/rjdulHD1Xv2f1Y6m0yTFs
X-Received: by 2002:a05:690c:5681:b0:855:2c61:4f67 with SMTP id 00721157ae682-85741156ae0mr32481987b3.33.1787768465347;
        Wed, 26 Aug 2026 11:21:05 -0700 (PDT)
X-Received: by 2002:a05:690c:5681:b0:855:2c61:4f67 with SMTP id
 00721157ae682-85741156ae0mr32481597b3.33.1787768464542; Wed, 26 Aug 2026
 11:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com> <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
 <CAEf4BzYbUhpwP3nq=M4Ph12LwRYO+mYSQB8SJjsw0AzZAFqyVQ@mail.gmail.com>
 <CAOu3gNgv_nJ6tjZOZ-FnJNYntbnpKn+nRnO4G6j0fkBmeeu=GQ@mail.gmail.com>
 <CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com>
 <CAEf4BzY2ucQUsNbbaKcOyLhXNbMBS4ouoJknAqNJ6CN8rPG92Q@mail.gmail.com>
 <CAOu3gNggJbiDO+_2tq8W9mAY=BtP+wnpn314sJaq2e-y=vcpbg@mail.gmail.com>
 <CAOu3gNhc3NHdMkvvd=RvWyhBB4s4O5g2K==kcLvuUoR81zoJvw@mail.gmail.com>
 <CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=9RhXrnbPhOZcVbOSA@mail.gmail.com>
 <CAOu3gNj25-wRO0fSK2FRPyBFo767ksqso2TkBy6yRbbiwhEAzg@mail.gmail.com> <CAEf4BzZ+Y7ZOzv82py0xvtuVE=GeTkHQGzwy8kfnoyuEzxQfDw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+Y7ZOzv82py0xvtuVE=GeTkHQGzwy8kfnoyuEzxQfDw@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 26 Aug 2026 14:20:53 -0400
X-Gm-Features: AcwNN1UccucFroqk593TVz5tY8AobAOP_IENtpLuL-U2XuvWSlSQ1U4uddy789w
Message-ID: <CAOu3gNiDHio-ZyWH_u_x=hDkCoADqTL=vRq-mzYfcWiQRyEzrA@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iNYAYQCUJkR8iN3YmhUexK7BO5OBRnMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX7seMXgluAGle
 QsUguWCurZ4uIfT7/6iDQJ5sxBKOEJt5BCq4mj5rvWfPWTvfyNAbWtSRoiDc/BCY65uzULY01mF
 arOrN1+bAyi9aJKca54dxaakewXHJ22737iw3fKBhEr/f0xZDnuNIvPC8GbxuULBKmymAQUpPyi
 z08WG5ydR0d09870n1n9smAXfrmhn+X0sPXW0BT+Egi+ds8TRAzbpF4pQYFa9cT+HDRyol50szP
 XyrVlXuX0uPXfTqpZ/0bFW71i+oJxfgzTFxWGhP9fSnl3AgfojyZZQIzQQ4V2dKBrXJ21KLb2LQ
 U+J5jLbjMhuLnOKkvFShI5I6oMMA6wnBNkNZupvRsiYKGUlA5ZY02JaO89HAq0cXUn4fJqkhs6c
 7DzLTqjZ/ypPNKgTMdmL6NylJSegTObMNsNVHSkhZhUGy/UsCxTy97UV6FaRlc4NrPwcHPXhk8I
 y1jE2QMC8WZmJqBrPDg==
X-Authority-Analysis: v=2.4 cv=V4xNF+ni c=1 sm=1 tr=0 ts=6a8f2e92 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=w2_cvhK74s_Cg0y5AxwA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfXyFuQEhJ6M3Qi
 woeZN/9zLyTAMwkec0l9V0GoHDWsKkkHXu8kItXAElt0mZ1C9tJGg7Qv+c5+75FoFm94QL0XORB
 tmO0fWOVe6t6FJpLEbBnfLbgs7PnZ8ngusVP5GzZJ12S80N5UfvY
X-Proofpoint-GUID: iNYAYQCUJkR8iN3YmhUexK7BO5OBRnMp
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11887
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260153

On Mon, Aug 24, 2026 at 3:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 24, 2026 at 12:14=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > On Fri, Aug 21, 2026 at 1:54=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Aug 17, 2026 at 8:32=E2=80=AFAM Andrey Grodzovsky
> > > <andrey.grodzovsky@crowdstrike.com> wrote:
> > > >
> > > > > > > Hey Andrii, getting back to this important topic -
> > > > > > >
> > > > > > > I reviewed the proposed solution and the code . An object-wid=
e
> > > > > > > bpf_object_open_opts flag that means "all programs must be
> > > > > > > considered loadable, but maybe later" collapses two things th=
at need
> > > > > > > to stay separate: a program that is not currently loaded but =
may load
> > > > > > > later (feature gated, config-driven), and a program that is
> > > > > > > permanently not going to load on this object instance (e.g. i=
t
> > > > > > > targets a kernel symbol/struct field that doesn't exist on th=
e running
> > > > > > > kernel, or it lost out to an equivalent alternative implement=
ation and
> > > > > > > will never be used). Today those are distinguished by the aut=
oload
> > > > > > > bool: false + never load =3D the second case. If the semantic=
s of "not
> > > > > > > autoloaded" change object-wide to "loadable later," we lose t=
he
> > > > > > > ability to express the second case at all -- every non-autolo=
aded
> > > > > > > program in the object now implicitly carries the cost and ris=
k of
> > > > > > > being treated as eventually loadable, even the ones that neve=
r will
> > > > > > > be. So, every non-autoloaded program is implicitly pulled int=
o
> > > > > > > relocation resolution and map creation, since nothing can rul=
e out
> > > > > > > that it might load. For a program that  never will, that's
> > > > > > > wasted preprocessing, and if its relocations fail against thi=
s
> > > > > > > kernel's BTF, that failure is no longer isolated to just that=
 program.
> > > > > > >
> > > > > > > Given this I wonder if it's reasonable to re-evaluate the app=
roach of
> > > > > > > per-program enum from the original patch series we prosposed =
, rather than a
> > > > > > > boolean plus an object-wide opt-in flag. Keeping disabled as =
its own
> > > > > > > per-program state (excluded from relocation and map-creation,=
 failures
> > > > > > > isolated) alongside auto and the new dynamic case state gets =
us
> > > > > > > the capabilities we want without forcing every already-
> > > > > > > disabled program in an object to be reclassified as "maybe lo=
adable.
> > > > > > >
> > > > > >
> > > > > > Goodness, 4 month since that discussion... I don't remember all=
 the
> > > > > > details, we can start a new conversation and go over details, b=
ut I'm
> > > > > > just about to leave for vacation and Mykyta is still out on vac=
ation,
> > > > > > so I'd suggest to restart this conversation with all the detail=
s anew
> > > > > > in about a month of so, if that's ok?
> > > > >
> > > > > Defenetly! So just to clarify, per your advice from earlier in th=
is thread,
> > > > > we don't plan to rely on the cloned sessions concept anymore and =
suggest
> > > > > instead to review again the approach we proposed initially [1].
> > > > >
> > > > > >
> > > > > > Explicit tri-state per program vs implicit tri-state (if not
> > > > > > explicitly disabled -> maybe enabled, if per-object setting is =
set) is
> > > > > > probably not the most blocking part of this. But again, let's c=
ome
> > > > > > back to this with fresh heads :)
> > > > >
> > > > > We will gladly review it again and adapt it so that it is accepta=
ble
> > > > > to the community and can be
> > > > > beneficial to all users of libbpf.
> > > > >
> > > > > I will reach out again in the second half of August.
> > > > >
> > > > > Thans,
> > > > > Andrey
> > > > >
> > > > > [1] -https://urldefense.com/v3/__https://lore.kernel.org/all/2025=
0122215206.59859-1-slava.imameev@crowdstrike.com/t/*m93ec917b3dfe3115be2a4b=
6439e2c649c791686d__;Iw!!BmdzS3_lV9HdKG8!zLLCzrdLf22D2nAvCY9zolVFNQrG3_Tnvt=
oRIvm-HpwGPt9OIpIoC7q0ZWjijb396RLVMFi29c1j_DDBPPtC79aACUXBshO-eDCGtA$
> > > >
> > > > Hi Andrii,
> > > >
> > > > Following up as promised from our discussion last month regarding
> > > > dynamic program loading.
> > > >
> > > > I reviewed our initial patchset and the subsequent mailing list
> > > > thread. It seems the conversation previously veered into unrelated
> > > > topics, such as concurrent programs loading and dynamic map loading=
,
> > > > which are beyond the scope of the dynamic program loading capabilit=
y
> > > > we are trying to introduce.
> > > >
> > > > To recap our main point from July, using a global object-wide flag
> > > > collapses two distinct states: programs that are genuinely disabled
> > > > (e.g., due to missing kernel symbols, where we want failure isolati=
on)
> > > > and programs intended for late, dynamic loading. If we use a
> > > > per-object setting, every non-autoloaded program is forced into
> > > > relocation resolution, potentially causing load failure and wasting
> > > > preprocessing time.
> > > >
> > > > If that is ok with you, I would like to resend the original two-pat=
ch
> > > > series as an RFC with a cover letter, rebased and retested against =
the
> > > > latest bpf-next branch. This way we can review and discuss the
> > > > approach from a clean slate.
> > > >
> > >
> > > yes, let's start with resending patches (you can drop RFC, otherwise
> > > CI testing story is worse) and let's go from there.
> > >
> > > I'm actually wondering, if we are going to introduce a their auto-loa=
d
> > > state from current true/false, whether we should also have a new SEC(=
)
> > > naming convention for such programs so that one can declaratively
> > > specify that this program *might* be loaded after object load, and as
> > > such should go through a proper relocation and other manipulations.
> > > I.e., we have SEC("raw_tp/...") for eager load, SEC("?raw_tp/...") fo=
r
> > > default no-load, perhaps we have to add SEC("!raw_tp/...") (or some
> > > other appropriate prefix) for lazy-load programs?
> > >
> > > And actually (I won't erase the above, but it just occurred to me)
> > > nowadays perhaps decl_tag is the better way to go. Can you experiment
> > > with this? We can bikeshed on naming later ;)
> >
> > Hi,
> >
> > Please disregard my previous empty email; I accidentally pressed send
> > before finishing.
> > Regarding the tags, I realized while working on the implementation
> > that processing all of them and matching a tag to a program would be
> > extra O(BTF types) itration per program. This looks like it could
> > cause a performance hit during load.
> > If we go with the SEC() prefix approach you initially mentioned, we
> > could piggyback off the bpf_object_init_progs iteration for each
> > program and avoid the extra O(BTF types) iteration for each, which
> > seems  more efficient.
> >
> > Let me know what you think.
>
> we already process tags for some global program args, so if that's
> slow, we'll need to optimize it
>
> The reason I'm suggesting tags is because tags are more obvious in
> source code and are more documentable. If we had tags when BPF was
> just getting started, I presume we'd never use the SEC() approach and
> instead have tags for entry-program.
>
> So let's see how it looks with these lazily loaded programs.

Hey, patchset was sent to the mailing list, please take a look when
you have some time.

P.S I will be away on PTO next week so there might be some delay in
response time.

Thanks,
Andrey

>
> >
> > Thanks,
> > Andrey
> >
> > >
> > > For bpf_program__set_autoload() API, I *think* we can manage backward=
s
> > > compatibility by converting bool argument to enum with zero matching
> > > to "don't load", 1 matching to "eagerly load" and 2 will be "lazy loa=
d
> > > maybe later if user ask for it".
> > >
> > > > Thanks,
> > > > Andrey
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > Thanks!
> > > > > > > Andrey
> > > > > > > >
> > > > > > > >
> > > > > >
> > > > > > [...]
