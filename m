Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860E32B9B5
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598244; cv=pass; b=VxK2Fzu+0CgaMoPpf63GI76iKzvGz3BTzVQdkyhhtoYrmkLAlwjBEgI1SdFlSm44Jfs2uZuUZBgJH28jsdUgBY4ueww8lDiFAaIXyJ8fY63B32thPZ9DujJ1cwpNrA9JiAOCuh0DopghHw9tunf6qviQ1NcdgmviOmpsjKa6G/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598244; c=relaxed/simple;
	bh=LBjqMAGLBTAxMHrhJ1OcdEJD6ZoAykyUV0/I8ZXpfoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJSDJ8qe0z8n2xW44KWjdVCbK7UW3uWkZAXFVPDAvcgTFGemwdYZcQvu0mCMY1wslaQRC+DcpJ/8t25ddmdzK1m1+kdxUel3HwxlfsuE9U4CTxAvoUZeI1H8utevFHXfdLDOwKwxoiQR/UiXUOYbl9xZiYCD+Jb3tRsR7Q1APUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=pPKGU07X; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=K1sRqyJo; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="pPKGU07X";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="K1sRqyJo"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OIhLw52346807
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=FVi7muvoRWOzeDnaBMtH5otkJGKnT2zjxf4466k7NrY=; b=pPKG
	U07XSuGi8DXqGXYBBflxrle+QK/S/jyD30u78IMxSTHpjAgYByY0U+Y7DbdO/+Hi
	xFZtwetTDNs9NVzmcvNx9wnLKLAcZlZ+NwSnO9ep/I93I8127M1wDqWN9lwIYSea
	24MPd/HJi59Xm4p6OBzeP3AuxxsUHDwtDQ/1rABf+z/Ub7pOdRXrRQhghQLGE/D1
	VlYeWbND68aLiD+yV+/9qakplpheKoVpAuZjS7QE4QMJFtaGIGH9lLLVqlRJAKbD
	OQFyuciRf3CsDH4FzIM0g+3GEmaaFYRbIueRdPfPyBvtoPxCKrEYhopQQJorobfK
	GY/kV94tO3H4fdun0Q==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4g7r8bn68h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:03:55 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66c70f5abc2so10649565d50.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787598235; cv=none;
        d=google.com; s=arc-20260327;
        b=SSsDdvhS2fJp4y6Fx2NtO5lvpuNLOMagIIMcmJu0raE2kV5sIktLo6QE3cziYZSXpK
         9tFPSbCORIckwLAAiztV1n6bfzs0tfexCEt1ClJZwYbrKtajUMKXfNhNnJNYG5rg1X8g
         8wAwCk5knL9WW9AxQxqpwqSeDoAdiq4fMzM25x6heGsYehmY6ugQS8HDaH4qsGpPCZoq
         /e0h9ettwViqtoNwB/l17oETBIlndZc4fZxctvM5c+j61D80Wf0ctAgRhUMN6EazbfDT
         KR6c/HbVUR8rvsFuc4v+hxUUrRbuUghT7c5AyCABJoJzccH22V6gG5tYhuKX83qQ47/V
         5u+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVi7muvoRWOzeDnaBMtH5otkJGKnT2zjxf4466k7NrY=;
        fh=O15/nwl8HV8G6ieXo2p7UI0Ao5Ahdq1tXaJVMJ2UZS0=;
        b=blMTHzR5ClROkSMQT5jpdIKcTNTBUZofaeh0olGPj5GSiEiMhbwM3rHOLP6KWSPV3E
         OIjncch9xcFtY8vMdiIyVae67nYfVqMioVzotns++S5O12kHj8vABq7tMddxU4RnZZL7
         QJXb8bSPjXDEV+Cg5CepZbF5nkF5wvJhJkaU5TCgGpUCtQ4hUm9/sshbnU1/oPPxsFBx
         bXxANxbcbcQWOCKATQmUymhq5UVJBXmbOuoO0Ar/Uf/m4qd9kvbJTTJ+V7vRRPgTfv36
         JTRvbxcK6ThhoP7OSu/vsmZCqYg87ReFd+Vz5GiPjMprqhkL8AFOMD2UtGgntWZFGLVo
         EoRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1787598235; x=1788203035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FVi7muvoRWOzeDnaBMtH5otkJGKnT2zjxf4466k7NrY=;
        b=K1sRqyJorF3P28W08ZEp7FIhQQoQ8aQIvjlnUUanVBlxJrJgRdeF0tQm989FfVfb9Y
         YRYeCHmJsuRNXfZIDByDrO6JIz9HlcZjXFeXzum/y2+76SDSm5+NbHpisWKkxrO5qh4Y
         Lyi2zobJ/3swWPMnnQuFSzU0ORggktC2/H+yx4EKAVHAr/DHnUswIMDwESykT7r7/hLZ
         5XIWXJKqx9ulMKERof6s1zS08kakFyNLSva9ipQKRzHoFNPREBd/TLI53x5Z0MBaLq8z
         pBVI0CLY7dJ9iSotDAs2MgyihQXjgmWWqEYXP+LIYtCrr/918QpOgAF16RNYVMGgcBW1
         si5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787598235; x=1788203035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVi7muvoRWOzeDnaBMtH5otkJGKnT2zjxf4466k7NrY=;
        b=YNmMfuYK53JRk3DwXD0ply06woYVwuwRbBhEjeIZ1+2e8U8w/VFNbYXeREW7vfuHf+
         O+i1+Mb999XyhcsBwujqpowpU/bYOSg2IHgP/G+bnty2q0FUFqp08Pd3ZfkrbTo7TEzw
         1263DVIFxP2lFQVA2+v59hvbgLnDdkvm1h3TFb+8jOFEkGgRyU5NFzATNHLFFFl3eg0q
         zZNichrcgf9uzrzx3z5n2N5jLqeITz5RhSk7u/Ix3Q2ly7s7MxVXyqLAAl95ZfagjNOC
         IZrJ/7jJ4XPKIhLJbubR0Ejw0RNw8KR7niAG+pZbsHyvJe+ABpZK+5CMyKdn1wcXaOPt
         9S9Q==
X-Gm-Message-State: AFuF++nBWWiovtk1IH32bsMfdtohRcZIUUPLr3wX1adkviU/QqfrzJN/
	ctTzRAz4BH541/+pifoegPt4aMJ5iaoZ38vv4aEjq+jELtIeXOJwa7jOkdy9rzhOMJSzxfm3sna
	B3CicBa8gSYyZNGb5mYN0FBTQh8HjeODohkIDeX37MTMhdKh9h/xbRtQcR/D/FxWvquUQlBjUaY
	iFe5ZY+Z1GFgWxyzzqEKThGWNG82zllbCeJYKt
X-Gm-Gg: AR+sD12Akb584wkvgzg5IhIBq9/Ev1cjjrnOIfn3ej5i/Vay1kqU/ehJnhUuaSL9Nwh
	Fm96cv0/PKKCjdGFMwYnKsvU1jB5+fJ054zvohjKXp0DjwZZp0DnOYbdJEy/kv2u4Cq6O6G/82v
	eeX6fLYkDKYbPS6uzLQG0XNMwnZ5Nn/FX6vh0TihwOxpSTfvYV32mT5vx1CQ==
X-Received: by 2002:a53:d904:0:b0:66c:e38c:599b with SMTP id 956f58d0204a3-66ce4ac3323mr8555145d50.27.1787598234415;
        Mon, 24 Aug 2026 12:03:54 -0700 (PDT)
X-Received: by 2002:a53:d904:0:b0:66c:e38c:599b with SMTP id
 956f58d0204a3-66ce4ac3323mr8555118d50.27.1787598233683; Mon, 24 Aug 2026
 12:03:53 -0700 (PDT)
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
 <CAOu3gNhc3NHdMkvvd=RvWyhBB4s4O5g2K==kcLvuUoR81zoJvw@mail.gmail.com> <CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=9RhXrnbPhOZcVbOSA@mail.gmail.com>
In-Reply-To: <CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=9RhXrnbPhOZcVbOSA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 24 Aug 2026 15:03:42 -0400
X-Gm-Features: AcwNN1X_fiN6MEqHz0TnUeRHDQO0xUZDHGP8lVdogi2-GyltQjKcXMM8yRuUXWg
Message-ID: <CAOu3gNgcqTUHzeiO0njgk3Rm6wPFGyag+=n+Y+p5wvfAkWX8fQ@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: LfFrhS7RXbu_e0TAlsRVp2dzeXVNcUSW
X-Authority-Analysis: v=2.4 cv=FI4rAeos c=1 sm=1 tr=0 ts=6a8c959b cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=_q8vvxln9xwO6xG7d1kA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2MSBTYWx0ZWRfX+PRK+MiLdo/L
 B/p9kZm3twOGom7rSRTvwm9ftSNewsHMhFg4+RoTf24kdx05Mf7mhW9mxxvWQk7H3ruwUBuPyO9
 sYkUeqj6lquQzsAi6iC2H3fxFNgnDIPcsjK2OXewQ0B28Ea7J1oBrz/Low7jiEhjxYj3xbZFlpm
 aQd9PMzGnIHeyiuFH9u22ShRRuYdJhy8nf0RMyxuxgCCoh44OE0zF/NNDP8k2skTFHRZeXDksBv
 tFy/5w4P6qrC52SVvasVrd+fcq5e2/lGZHis5+d3MEtKtBoqUXIkcVvypewApgISDtdgHuB1AIM
 RGALUXnhQ+wWdv4pVxXdfDTOG8FjIy6/N77q3OnYsY52tR+mESlOj7cccOVHZlj19/rFp028BIK
 WpXr56V2r13OYUF1VLQJVqPsLAeGT4sHtKQ7wVqeogxBnY5/W28+Ka9O/EPf+IIPO2z/cfTD/pO
 GXqjO68kPwzTGHgCqqQ==
X-Proofpoint-ORIG-GUID: LfFrhS7RXbu_e0TAlsRVp2dzeXVNcUSW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2MSBTYWx0ZWRfXz6HFfJ4hVxj4
 vwm6EIKlZq8bHj1rxLOyiZnEeFBud+1Atl3Op/V0q3hOZXuXg3ToG5XgeR3Tdmj3oBBMvB4lZd0
 ge9ATtbc+FJq0RUIvbcC34Vlt3k2kkDGPkuD9tiRLhEJDMxhETMf
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11885
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240161

On Fri, Aug 21, 2026 at 1:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 17, 2026 at 8:32=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > > > > Hey Andrii, getting back to this important topic -
> > > > >
> > > > > I reviewed the proposed solution and the code . An object-wide
> > > > > bpf_object_open_opts flag that means "all programs must be
> > > > > considered loadable, but maybe later" collapses two things that n=
eed
> > > > > to stay separate: a program that is not currently loaded but may =
load
> > > > > later (feature gated, config-driven), and a program that is
> > > > > permanently not going to load on this object instance (e.g. it
> > > > > targets a kernel symbol/struct field that doesn't exist on the ru=
nning
> > > > > kernel, or it lost out to an equivalent alternative implementatio=
n and
> > > > > will never be used). Today those are distinguished by the autoloa=
d
> > > > > bool: false + never load =3D the second case. If the semantics of=
 "not
> > > > > autoloaded" change object-wide to "loadable later," we lose the
> > > > > ability to express the second case at all -- every non-autoloaded
> > > > > program in the object now implicitly carries the cost and risk of
> > > > > being treated as eventually loadable, even the ones that never wi=
ll
> > > > > be. So, every non-autoloaded program is implicitly pulled into
> > > > > relocation resolution and map creation, since nothing can rule ou=
t
> > > > > that it might load. For a program that  never will, that's
> > > > > wasted preprocessing, and if its relocations fail against this
> > > > > kernel's BTF, that failure is no longer isolated to just that pro=
gram.
> > > > >
> > > > > Given this I wonder if it's reasonable to re-evaluate the approac=
h of
> > > > > per-program enum from the original patch series we prosposed , ra=
ther than a
> > > > > boolean plus an object-wide opt-in flag. Keeping disabled as its =
own
> > > > > per-program state (excluded from relocation and map-creation, fai=
lures
> > > > > isolated) alongside auto and the new dynamic case state gets us
> > > > > the capabilities we want without forcing every already-
> > > > > disabled program in an object to be reclassified as "maybe loadab=
le.
> > > > >
> > > >
> > > > Goodness, 4 month since that discussion... I don't remember all the
> > > > details, we can start a new conversation and go over details, but I=
'm
> > > > just about to leave for vacation and Mykyta is still out on vacatio=
n,
> > > > so I'd suggest to restart this conversation with all the details an=
ew
> > > > in about a month of so, if that's ok?
> > >
> > > Defenetly! So just to clarify, per your advice from earlier in this t=
hread,
> > > we don't plan to rely on the cloned sessions concept anymore and sugg=
est
> > > instead to review again the approach we proposed initially [1].
> > >
> > > >
> > > > Explicit tri-state per program vs implicit tri-state (if not
> > > > explicitly disabled -> maybe enabled, if per-object setting is set)=
 is
> > > > probably not the most blocking part of this. But again, let's come
> > > > back to this with fresh heads :)
> > >
> > > We will gladly review it again and adapt it so that it is acceptable
> > > to the community and can be
> > > beneficial to all users of libbpf.
> > >
> > > I will reach out again in the second half of August.
> > >
> > > Thans,
> > > Andrey
> > >
> > > [1] -https://urldefense.com/v3/__https://lore.kernel.org/all/20250122=
215206.59859-1-slava.imameev@crowdstrike.com/t/*m93ec917b3dfe3115be2a4b6439=
e2c649c791686d__;Iw!!BmdzS3_lV9HdKG8!zLLCzrdLf22D2nAvCY9zolVFNQrG3_TnvtoRIv=
m-HpwGPt9OIpIoC7q0ZWjijb396RLVMFi29c1j_DDBPPtC79aACUXBshO-eDCGtA$
> >
> > Hi Andrii,
> >
> > Following up as promised from our discussion last month regarding
> > dynamic program loading.
> >
> > I reviewed our initial patchset and the subsequent mailing list
> > thread. It seems the conversation previously veered into unrelated
> > topics, such as concurrent programs loading and dynamic map loading,
> > which are beyond the scope of the dynamic program loading capability
> > we are trying to introduce.
> >
> > To recap our main point from July, using a global object-wide flag
> > collapses two distinct states: programs that are genuinely disabled
> > (e.g., due to missing kernel symbols, where we want failure isolation)
> > and programs intended for late, dynamic loading. If we use a
> > per-object setting, every non-autoloaded program is forced into
> > relocation resolution, potentially causing load failure and wasting
> > preprocessing time.
> >
> > If that is ok with you, I would like to resend the original two-patch
> > series as an RFC with a cover letter, rebased and retested against the
> > latest bpf-next branch. This way we can review and discuss the
> > approach from a clean slate.
> >
>
> yes, let's start with resending patches (you can drop RFC, otherwise
> CI testing story is worse) and let's go from there.
>
> I'm actually wondering, if we are going to introduce a their auto-load
> state from current true/false, whether we should also have a new SEC()
> naming convention for such programs so that one can declaratively
> specify that this program *might* be loaded after object load, and as
> such should go through a proper relocation and other manipulations.
> I.e., we have SEC("raw_tp/...") for eager load, SEC("?raw_tp/...") for
> default no-load, perhaps we have to add SEC("!raw_tp/...") (or some
> other appropriate prefix) for lazy-load programs?
>
> And actually (I won't erase the above, but it just occurred to me)
> nowadays perhaps decl_tag is the better way to go. Can you experiment
> with this? We can bikeshed on naming later ;)


>
> For bpf_program__set_autoload() API, I *think* we can manage backwards
> compatibility by converting bool argument to enum with zero matching
> to "don't load", 1 matching to "eagerly load" and 2 will be "lazy load
> maybe later if user ask for it".
>
> > Thanks,
> > Andrey
> > >
> > >
> > >
> > > >
> > > >
> > > > > Thanks!
> > > > > Andrey
> > > > > >
> > > > > >
> > > >
> > > > [...]
