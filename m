Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD73C65FA
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834216; cv=pass; b=hxZf39my2APfXDEm9ZmiQbT2kZJYAZNRE7OTAtIUpUz+0s9cdhDVL+08qn16gnOiJY5Qy9ldT+DqOVzHeaLuT0FtfnDkrvgU3mPC1EZOKKab+uT4PIhi9kCEr9XEzO5tGAKHFcE3qas2M+cPUb/elxbF2YBt/4rrcEuih4OxpFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834216; c=relaxed/simple;
	bh=eGSKid8T3HB5+pr++L1S/29WM8A1nyo0/2pcRio9MlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbFNonkkIEYnSTcvQbVw4RIYBLPCuFp6MI5lejf3MhwEPapVcEYeMyXNaWcRoXv1cbubTX+OwijGznQl2xzl0XUKbbLp8Vo8Hbo/d/GibRfmAAgKLmVpfMap7t1Qn7hQGj9YwXR4t1qJDZQNomPa2esvlEB0+g/bzFRAcGSXfOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/VyFK+O; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/VyFK+O"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bd9f61458eso84328677b3.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779834214; cv=none;
        d=google.com; s=arc-20240605;
        b=h9zZtdPoOx5keIhUTCwAu/IL9u0H091sLjqsSnhwCcjpo3ocPy0YKd7fQeoD5Lsf65
         i40FFWHrELoy7dnLyxcc9BQ9FUmAMZgTFNBHupfZu0DvybC19lNdxhwv6Zxb3y9YviBT
         dRijH+bHtuvQMYle2kzN7EyHPIVVOJ+ELDnUKKeXoVIJAzI+++crXdU4P45zDPNpeT4S
         EEpPeWf7xI9jzxaFgajuaWwUA4EOJz2VO2uE040kAw+Mb2gCDfBB9TNitUVrG+XSB9pO
         Re2wkW32ROMyiqaLBjlSs/HWilGFlosGoduZ/LaRm1TN+rXevA8QXolXa6A8cqjC23YB
         lNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7DHzwjJ65oAB4Zi5oS+R74ouicsyriJXbMPsqN056yk=;
        fh=QkyfDpFPGx6In8jgchBEuCqYcdhE/2fkNazR1Q1TOIg=;
        b=aSNX2hUirPuXiG6mrYppqIhnuboCTyWpuj5mh0T1FiKXTa/gbu76mKo4UIpRcralzR
         EehehcviFBBQxqGn9eJpb55tHDqiE2I6VW45rbT+VTT1vb+tepofpGmFbM2PKR6kaS/P
         3u9ASviLKAGCksph1k0wTNJkVnQ+rpDV5XzJ++rqHpXEijRmq0e0OrcRQZMwrn13/Sxp
         y7xhREperx4cdDDWMAdzrLT0IlIHFbSfOoO4tYOb1NGP+Equ0d2XvGP42gUIK5s8HIRT
         uYoAGbo8GP40GDFZv2OUSq8+YOkFbyAnzFKfvtDSMDaOLikwJ9Q2orPYbt6aV/tcaxXr
         sXXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779834214; x=1780439014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DHzwjJ65oAB4Zi5oS+R74ouicsyriJXbMPsqN056yk=;
        b=L/VyFK+OGyF9vKyQeFkmV/VlpMEqG0VCx79xBn2fsOBcEF2F6mKx/lrzWnv1RSU4Ya
         Zid4vxStgP3rLhACWQW/zURfSMxOpKuvWrMK0yEpSBkmUhHbkEmC0Zs8+jcHUuS96UPG
         1ro2h0laq01AU5pr9dGQikAy+Cb2LuEguSXJVFdmpKtSfaeuIbnw/mdnq+MxXSedt+8t
         jeKmryb8kydNdZP7PPYFapklihs+V5P8tX+hq7St2tAP3pI0lkJ17uGtLVUCvekmuP3p
         Wf4htVdPVWvL13u2NWYQ/ZrpemIBCTPv55iTwIqFOS+QqESysy8TzUw99CYfeu0mm0UQ
         o51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779834214; x=1780439014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DHzwjJ65oAB4Zi5oS+R74ouicsyriJXbMPsqN056yk=;
        b=LqlkXYxhqIOMggqOEZ+qt6gP1qgaHg9mUBkIr+tBleyKt34iIqm3BGypB7OetqF3QL
         hfd/hI32kkD0x/7D8DFVFQVaT0BSMXrKpqRnsdckj1dzDDLfksuiC0Jin0OW7B/Ht4p4
         aD+TIbdE53YEtMJdlpq7zh3qacClABG1PDnDGW4m3mk/CJk87lWJOcoSWlE83ZyP1prS
         07fuafdC9ztNlwpedKEj+wQpCM6go+0CIVt72o0U/EGqvv7uCHz2vBbU0wV335fGFxoU
         PsPIMuD9kmkykxaK2WhfjtDXu/Cj0BvwnePH4ywucPwvu5wcgksUkT071bByS7hVZcYb
         SgVg==
X-Forwarded-Encrypted: i=1; AFNElJ8fgIpRCwH8rdI2g1zBOTJLv6NJOADTtATgcudECXRVeDDUnOhoyio45NfvbDYVrVu6PNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5Di5IUcfyi6mlh7LpWPu0tU68ExMXPLvA63KC3ErFLUMh1Wz
	doOoXDFJeGnqg+9lOLkRzMMUIEWaD1g3T7n4cF2TWqzm5vM2CFbrhNZvhgnoxSsBHVoS/ge/Vpe
	K8pP9wI4065IRbuRoJnK6R9lhPtHY/MBquU9u
X-Gm-Gg: Acq92OGHqrcMpg6jdxfVI4t4KNXjEDzO9D4uQpcrHIUYLny4TkSlKG1C65POASH7V+Q
	2yUiMTGINAIrblcfjObr3y2wKNXNHZGnn3ybTKuWDeytEmnwaZzfT+Q8t3yjd+FJX9adEnhLWvg
	TpBz4cLDjKy86yVP/YYBVI41TfLVQJ8qv/7ZJNofOb/1X78Iiu21jLIkuePMjCAp6Z8vE0YoyUf
	+8ouEnQnE/cPrBDif41d4CqvSbdSfgyZKhugtnVJNG7fDyBKdWWZRFG1iWuSXlaGZdB8OhyUIHg
	BdPpZFGOkyV8qPFK6wxlEEM=
X-Received: by 2002:a05:690c:888:b0:7b4:1ffe:f9f9 with SMTP id
 00721157ae682-7d3342da180mr223593247b3.16.1779834214393; Tue, 26 May 2026
 15:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519215841.2984970-10-martin.lau@linux.dev>
 <20260519225002.986EB1F00893@smtp.kernel.org> <2026519225454.By6y.martin.lau@linux.dev>
 <CAMB2axPDDom8sD7u+2Fgo9dZO1ereX-unai8EW1SmsiDrnzzwQ@mail.gmail.com> <2026526211020.HhEJ.martin.lau@linux.dev>
In-Reply-To: <2026526211020.HhEJ.martin.lau@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 26 May 2026 15:23:20 -0700
X-Gm-Features: AVHnY4JUSZ3t2v6IJQLuXpnvOcVkIqY0BVIvHYrgkCXkRpmnjC2Shb9O1cuvfxw
Message-ID: <CAMB2axPqfHPmxx3uCHnts+uDKiBMBWVaDXR+X_ZJW_xn=07VPw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 09/12] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 2:37=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Tue, May 26, 2026 at 10:54:00AM -0700, Amery Hung wrote:
> > > > > +static enum cgroup_bpf_attach_type find_atype_by_struct_ops_id(u=
32 type_id)
> > > >
> > > > [ ... ]
> > > >
> > > > >  static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type =
atype)
> > > > >  {
> > > > > +   if (cgroup_bpf_is_struct_ops_atype(atype))
> > > > > +           return struct_ops_cfi_stubs[atype];
> > > > >     return bpf_prog_dummy();
> > > > >  }
> > > >
> > > > [Severity: High]
> > > > Can using a loadable module's cfi_stubs as a dummy sentinel cause a
> > > > use-after-free when the module is unloaded and reloaded?
> > > >
> > > > If all maps are detached, the module providing the struct_ops can b=
e unloaded,
> > > > and its cfi_stubs memory freed. However, the cgroup's effective arr=
ay might
> > > > still retain the dangling pointer to the freed cfi_stubs if BPF_F_A=
LLOW_MULTI
> > > > was set.
> > > >
> > > > If the module is reloaded, cgroup_bpf_struct_ops_register() updates
> > > > struct_ops_cfi_stubs[atype] with a new pointer. If a user then quer=
ies the
> > > > cgroup via BPF_PROG_QUERY, the loop checks
> > > > item->prog =3D=3D bpf_cgroup_array_dummy(atype) to skip the dummy. =
Since the
> > > > array contains the old freed pointer, it won't match the new cfi_st=
ubs
> > > > pointer, and the query loop might mistakenly treat the old dummy as=
 a valid
> > > > map, causing a use-after-free when calling bpf_struct_ops_kdata_map=
_id().
> > >
> > > Agree. This will be an issue on BPF_PROG_QUERY when the module reload=
.
> > > I did think about the module reload case but I have only considered t=
he
> > > rcu-reader in bpf_cgroup_struct_ops_foreach.
> > > BPF_PROG_QUERY does not use rcu_read_lock and depends on cgroup_lock.
> > > This will need to be addressed.
> > >
> >
> > Also thinking of the potential problems of leaving dangling cfi_stubs,
> > but I don't see any other cases.
> >
> > In this instance, it seems adding a cgroup_bpf_enabled() guard in
> > __cgroup_bpf_query should be enough. The dangling cfi_stubs will not
> > be cleared until update_effective_progs(), which happens during the
> > first struct_ops map attachment. cgroup_bpf_enabled() will be false
> > until a struct_ops map is attached.
>
> In __cgroup_struct_ops_link_detach, the static_branch_dec is done without
> the cgroup_lock() for now. May be moving it before the cgroup_unlock()
> is enough?
>
> __cgroup_bpf_query() has already held cgroup_lock(). I was thinking to
> use cgroup_lock() in cgroup_bpf_struct_ops_register() also but it will
> need a cgroup_bpf_struct_ops_"un"register() when the module is in
> MODULE_STATE_GOING.
>

It makes sense. Clearing the cfi_stubs when MODULE_STATE_GOING makes
effective_progs valid all the time. I think it will be less trivial to
reason when it is okay to dereference effective_progs with the
cgroup_bpf_enabled() approach.

> Either way, this should fail early in __cgroup_bpf_query() once detected.
