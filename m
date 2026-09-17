Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D633CEA8
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605971; cv=pass; b=OMS+6rEZqSw6v4aLrsYmmngvkmAdGX23wUsDdRmPS5X+zWAylinlAo9RzqcDXlurIlMOByhw1+wusUJ4CZmOaw1Z6YLikNmmY5L7aqdX8EzaIsGaZ+u2uRYouWVeDk6hLDYtWYlIFOxtCvJdTVMQepAAiFLEEEzjm1beQtKJ/7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605971; c=relaxed/simple;
	bh=YcN1I+53DqiUYtgA0QUZxBi/BApI1Vnu7Xc8fs0S95M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn5b7EkgZtllFKFr75hSg86kO6Yvb/GUyAyMr9j6QNYifmEaafuY8jC1rR48ECNnUvCIWrz5Ns7nvrPymNbKhU8/AWSPrYAPmEL1m+n0Wn3QFHMqbcp5gctWRHaErKANgOY18qbBmER6phNfjFxEKJoXBF+1ibWYQ4gwlTjMevw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=zkWMB0fd; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=DypTKxHz; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="zkWMB0fd";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="DypTKxHz"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GNST471204670
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=+ALA4fbhD0MHL54QSWjb+JRJML/23w8RPtCUKMmgxj0=; b=zkWM
	B0fdy2iDFAMfy5GKmKysiTZ9FRVIsyv0yN+kgxgTe6NWo633yNqVd/4JAjBr7Tg4
	BsTpc9QI6YKCTu3JDpfZf1QNdec0gKelVZ/RMqIjpeEgW+wPi30gAJqgn0Pm7jFI
	wE3szazBqq7V5/ESOaSLJ0ZCu30+hRZli5F9syICUEUX5z9uLr2LkQ1p4xKatBMo
	5FDifMYtQva8C0LtchNPKvX9LuqdEWt9acrGa4RqldkGoWAl3K9/fyfsPULHw6Vj
	27+QmtVEB+Bk3nq4M5OtM5nzTEyykIWRDGLw+bRQ+HAqwu2fC2UxElallB5ppf/b
	ok+yFzy4YNvHEtvvDg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gqyajhjqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:46:04 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-86e8abd7136so2256567b3.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789605964; cv=none;
        d=google.com; s=arc-20260327;
        b=sc3fjpngO3SvSXwrv28/B9aUjSElwMs55xtHFkFwy3oqh1Py8NS+S1FxG/NbGlz27j
         5TsXWxcdt5Cv8wWrmdrg6ZyZHjdgHwzl67bqemjmLOAOryhFnxvd7MriNMdIkDK75bpL
         vjSlcnnBwqnjIeo0EqGPd3kXnORlgOEd6NaVXmBHz9+a3ntFsumHDgqrbsX4Q14LHkli
         PRkKv2QOJotJeyb8q7aHl/U6r4FTEM+hxTGVVQHgtQ8IzlYLR7mkn9MOElEeQqGvM2Y7
         FQPV0D/uG1PdXejMOprYnt0CcyloYg7DFHfA7m7tRjLHozK6n5+PShB7RLBga/fEWl8+
         UV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ALA4fbhD0MHL54QSWjb+JRJML/23w8RPtCUKMmgxj0=;
        fh=YQPPkC7mvlH0fybsfjOSFdxPREPTtX0rge8YY97d81Q=;
        b=iP5I1l/bBgiyvtvQVmHHZbgsZYXVZtxONgVMY99SNmIcRkMczmVWUnbu3plIF5zJBZ
         8o8qIbdbSuysVPK1Gjd9LdE8TGJv5eMg5eGuK8rZvADjGV5z7Maz6cDzrMXeviXIX6v+
         mO+TClMtqeqPtFuoLmcWLfsnMkX9vxT8ezFMl0Ax7yI0UVl2tQ9lklmGwktlPzy7uhI9
         zPRHcQ6uwi8zxCb+VXjz8LH30wc6XxyMiC6s4sglHO73V/xGha63vd+YdwxVQRgTelKR
         3s9B+AC7Fn1n3RKb9Lej3Rbcgw202D+rKaBI6wsu/mE4JwJuV/0v2lMBJZnpvgEy4EXW
         HDkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1789605964; x=1790210764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ALA4fbhD0MHL54QSWjb+JRJML/23w8RPtCUKMmgxj0=;
        b=DypTKxHzMLa1P/+I36AChAwxAbQBq95xUJe1d5fHEt7+5ZcbkzUdtgJXDNY/hlItHh
         ZPLxVPwLvBCP3TzzWTGGa9i8/jTtqtRdylB68qsJsqSvFKhE87jlk2kKidAH/7SZUdWS
         2hF0WAVSjBTrq5w0eKTpgCruJxE/z64IF+qTqD3MDDbFKj6HPJPosy5hdlarKJFrrlwW
         wlAnFKmmwXNT5kB1L2UrQVWxgIRJiFulc/W7MpJy+ebGsLRFdPfPqmmPOfKXNCI2pnfq
         aE4soPwCmL23+Jh1iv4EfDFj3ezSkqQZNLrAGUT8bx577KhMuAfLVt5ZebPnHBoGscz7
         lGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605964; x=1790210764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ALA4fbhD0MHL54QSWjb+JRJML/23w8RPtCUKMmgxj0=;
        b=RC1gpBXv1ENPoIpifY/2znn3K4M2MFsyyQC1CnbkAx6kwiLERaZ98QWokIcV2KcDum
         BgulDHOnCVTNHLteW9Vn/pind98X0WKP6i8kkR9Hzw5T9c9XNxTOJaj508wU7uhNaDBR
         Y+8lH6cf/pDJvys9lXnUj2WgVJFk3qp2Vm7xhJ3lLweo64p0Tv2zct7gGiI5I+PX2tqe
         issLy++kiPAGI3ufRGkUPRFv7+GB7eSqc5NelVpnAM2CDhtdm3cjdAioCf3fk3jcemAV
         aJpyz+/vjNR8YmgZGGtjAyJvy4zpRNY551NOqxdKxRkh+z1uJVYBxvlmHxhze80EseDX
         4ZCA==
X-Forwarded-Encrypted: i=1; AKwUvBzRXVVe55n69xYfDrFtOS2hnSzFH/g+BN+yJ0TYs5KJfqlEaLGHAFxmCEPctuS2xsHXn9U=@vger.kernel.org
X-Gm-Message-State: AFuF++kweeKDv30v4YBFq7gY5bKpMlJ8yqRa/02CZrfn0rL6Q1rLYP3E
	/oiD/QX/ydeQ4Vz0sfsqJq9SyXfgNQO4k+x/9d74dH2G479Y9s4VgpnKOCj3ndtqDYj2H3Nqlbr
	U9algz8c1lHh3OstTjgtIKOZToJcB6aIML16oCrXAimA88mJLN5AgsoHIu5ZKSYwZzvHg9f/kFv
	3Qoncwlgch27xuC2iSYRPk0Z6kYrqM
X-Gm-Gg: AYBFou2yAvI2ptQ3QQkc0waFFcdy4yooOinOIhHnb89taYOMx0QRZ3pxmhE9eri/ZQJ
	oxmaSsfC+Cgrbhsx0y2X8E9CK1LmFdCoWxaH4534B1NEeAxhRA14wvdVggUJteSigFifMd3ajC5
	BflbOObfrwX25sIeY/aXYBwvRH3SP3nsXIU5f+tZucENUCpTqhvDcni+2v/w==
X-Received: by 2002:a05:690c:e215:10b0:871:62a7:9e00 with SMTP id 00721157ae682-892219daa1fmr11384627b3.24.1789605964160;
        Wed, 16 Sep 2026 17:46:04 -0700 (PDT)
X-Received: by 2002:a05:690c:e215:10b0:871:62a7:9e00 with SMTP id
 00721157ae682-892219daa1fmr11384577b3.24.1789605963570; Wed, 16 Sep 2026
 17:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com> <CAEf4Bzaf9AMBUWQeUj1Uor8F7A-tOPpVMa-CjRB0MNH4zRHEeQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzaf9AMBUWQeUj1Uor8F7A-tOPpVMa-CjRB0MNH4zRHEeQ@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 16 Sep 2026 20:45:51 -0400
X-Gm-Features: AcwNN1UAcO-9BZ4jVR5deoJXjAXsnQL1GNJmS_p3MwPiKSTwfdQHJq2FQi7Ey5I
Message-ID: <CAOu3gNhjPamqZgcxBj7Sgmr+B76qPC+O1hdWg7dY3uNuat+UMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] libbpf: BPF program dynamic loading
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAwNiBTYWx0ZWRfX7vIiI07ZdBxS
 q/ai7fzXodEQhh1t+pTX+0aFXBuT5acwP0TwIirHiMXyHbA5dw5EZDkXr6xN9MhONr6EbUBPF8K
 y/SdtiTW6zeof/teSxVRvPqDRPhHPgzSLJCT/pVeLzyP8Od8tbXu
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6aab384c cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=Pgacwa0oAAAA:8 a=PY4t9M6HWZK_zjpFqZcA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=xnLNWz09G3ZUmE6K9NTY:22
X-Proofpoint-ORIG-GUID: lym1KKxwL-1kYwbWqiRIlNv7pJong88b
X-Proofpoint-GUID: lym1KKxwL-1kYwbWqiRIlNv7pJong88b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAwNiBTYWx0ZWRfX46wKHz7DWZAB
 /HVK8daI3bDV+b696cbYmAnc6dK3IUcTW2yz8++s/+oyI1mQkG42TK+uqV90EC1NG40BJafKx8m
 aXqM+gHt4clkEAuX5gbXbVLBiXNfhva39/VW/TrGdOGkd8cfJuNqrTWB0zl92IHE0MPmml7fl3V
 I8KVSgptK872fFU3lnMD7MIcrbFHvJ51kG6R2GRZUV8vfbG757ANDpZDP7Hsu9KCcwGrJW2WNEg
 uzgECHCVnAnDIWgrVsIWN2hYD3L/4aw5c4Et8sTVf/c1QYpdponon/VNBseSOc7K3rYpDR/CxO1
 vxpHVoUTb56IoruHztIlKmO86UTX8YAi3GXXXCJtXmCcAF07dkuKKIGt39YvCV4RNb2HJO3/doD
 jbx7PdOLig54lyooREm2nGkuK1tffq6uyyuCkdxTpWHw/VOTgsCZ6rJTeM4UuycWhQEdQZPZ87g
 vh2FuZef9Vxry3YG1lg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11907
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170006

On Fri, Sep 11, 2026 at 7:47=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > This series was originally posted in January 2025 [1] as
> > a two-patch RFC introducing a per-program tri-state load type
> > (disabled/auto/dynamic) to let large BPF applications load a subset of
> > their programs lazily, after the initial bpf_object load.
> >
> > We looked at the object-wide opt-in flag Andrii suggested as a
> > lighter-weight alternative to a per-program enum ("all programs may loa=
d
> > later, opt in via bpf_object_open_opts"). Problem was that it collapses=
 two
> > states that need to stay distinguishable at the level of a single progr=
am:[2]
> >
> >   - a program that is not currently loaded but is *expected* to load
> >     later, gated on runtime configuration; and
> >   - a program that is *permanently* not going to load on this kernel
> >     (e.g. it targets a symbol or struct field that doesn't exist on the
> >     running kernel, or it lost out to an alternative implementation and
> >     will never be used on this object instance).
> >
> > A per-program enum keeps that distinction where it belongs: disabled
> > stays fully excluded from relocation/map-creation with isolated failure
> > handling, auto is unchanged, and the new dynamic state is the only one
> > that opts a given program into later loading -- without implicitly
> > promoting every other disabled program in the object along with it.
> >
> > This v2 keeps the same programs and tests we originally proposed, and
> > addresses two additional requests from Andrii [3]:
> >
> > 1. bpf_program__set_autoload() is converted from bool to the new
> >    enum bpf_prog_load_type, so it remains source- and ABI-compatible
> >    with the ~200 existing bool callers (false->0, true->1 already match
> >    the enum's DISABLED/AUTO numbering), while becoming a thin forwarder
> >    to bpf_program__set_load_type(). It intentionally continues to rejec=
t
> >    BPF_PROG_LOAD_TYPE_DYNAMIC, to preserve its original on/off meaning =
--
> >    dynamic load is only reachable through set_load_type().
> >
> > 2. A declarative way to mark a program dynamic-load-eligible from its
> >    source, as an alternative to an imperative set_load_type() call, usi=
ng
> >    a new BTF decl_tag.
> >
> > Motivation:
> >
> > Security tools built on top of libbpf commonly ship as a single large
> > BPF object containing many programs, only a subset of which are needed
> > on any given system -- the rest are gated on optional features or on
> > kernel/runtime capabilities that vary across deployments. For this clas=
s
> > of application, per-program dynamic loading helps in two ways:
> >
> >   - it shortens the initial load, since only the programs actually
> >     needed for the running configuration are loaded and attached up
> >     front instead of the whole object; and
> >   - it lets a single failing program be unloaded and possibly
> >     reloaded (or a feature toggled at runtime) without tearing down
> >     and reloading the entire bpf_object.
> >
> > Both reduce the time window during which the tool is partially loaded o=
r
> > inactive -- for a security tool specifically, that is also the time
> > window during which the system it protects is unprotected.
> >
> > We have been running this with our internal fork of libbpf in productio=
n
> > for about a year. Depending on kernel and configuration support, around
> > 250 of our programs are potentially loadable on any given system; with
> > dynamic loading, only around 90 of those are actually loaded by default=
,
> > growing to the full 250 only when every optional feature is enabled.
> > Cutting the default set of loaded programs from 250 down to 90 measurab=
ly
> > reduces load time (we observed ~60% reduction in our own measurements),
> > and since unload time scales with the number of loaded programs, it
> > correspondingly shortens unload time as well -- which matters, since
> > slow unload can delay system shutdown. We believe this functionality
> > would benefit other libbpf consumers with similarly large, modular BPF
> > applications.
> >
>
> we should try to use this functionality in veristat, see if it can
> more cleanly replace clone-based solution we have currently.

I will look into this, in my next patchset iteration, I moved (by your
suggestion)  the gating for manual loading from OBJ_LOADED ->
OBJ_PREPARED, this at least according to code review should allow
this. I will dig deeper into it.

Andrey

>
> >
> > [1] https://urldefense.com/v3/__https://lore.kernel.org/bpf/20250122215=
206.59859-1-slava.imameev@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!1zjO5-1CVICh=
pj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDyjBPDLExnfctIUG_V2ATbp4=
Ecz6a8j3WfggToQ$
> > [2] https://urldefense.com/v3/__https://lore.kernel.org/bpf/CAOu3gNjg5v=
Q=3Dt0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia*rdNw@mail.gmail.com/__;Kw!!BmdzS3_lV9=
HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDyjBPD=
LExnfctIUG_V2ATbp4Ecz6a8j29k6Njrg$
> > [3] https://urldefense.com/v3/__https://lore.kernel.org/bpf/CAEf4BzZKy5=
Wv_TxtEqsbzW*v-tO28kgY=3D9RhXrnbPhOZcVbOSA@mail.gmail.com/__;Kw!!BmdzS3_lV9=
HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDyjBPD=
LExnfctIUG_V2ATbp4Ecz6a8j2Xo62azw$
> >
> > Andrey Grodzovsky (2):
> >   libbpf: Convert bpf_program__set_autoload() to load-type enum
> >   libbpf: Support declarative dynamic load via BTF decl_tag
> >
> > Slava Imameev (3):
> >   libbpf: BPF program load type enum
> >   libbpf: BPF programs dynamic loading and attaching
> >   selftests/bpf: Cover BPF program dynamic loading
> >
> >  tools/lib/bpf/bpf_helpers.h                   |   5 +
> >  tools/lib/bpf/libbpf.c                        | 273 ++++++++++++++++--
> >  tools/lib/bpf/libbpf.h                        |  32 +-
> >  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3=
_lV9HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDy=
jBPDLExnfctIUG_V2ATbp4Ecz6a8j2Lf3q1jA$                       |   4 +
> >  .../selftests/bpf/prog_tests/dynamicload.c    | 222 ++++++++++++++
> >  .../selftests/bpf/prog_tests/load_type.c      | 167 +++++++++++
> >  .../selftests/bpf/progs/test_dynamicload.c    |  40 +++
> >  .../selftests/bpf/progs/test_load_type.c      |  31 ++
> >  8 files changed, 741 insertions(+), 33 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.=
c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.=
c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c
> >
> > --
> > 2.34.1
> >
>
