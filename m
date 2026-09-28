Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C5480DF0
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589880; cv=pass; b=a8Uf29o89QVDhaPE2o0gvtePo00r3VHDA6vKh6GyWYHGQN2pyVgG+YY4eA8KA5fT9F+x8w1q+zB66HUuLJdWdxw9VJ0aq9QV7xn0vKWqNUbUQL91OEmaG0t1w+gdux49DAeAX5wfcufI+VRo2DieaEdHZk9B8v5FyvWdwGx9N9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589880; c=relaxed/simple;
	bh=Vw1BM8+0IrGCKReQt1zsJ+Gdt/hrNRdgc5CzHZf4B3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jh3jvqX1cEBBbTfHGVlHrWedVGRmj5BOulw6khOs8PoLqQCPUJ2nT7uWAD1WS83ARpiXY3UIKGG09iELz9PaPKW2I4gyrwnKJJiUSdfIOaEt1+XY2lQEXoF+qlxEOPNnlV3ftRHmvPuF9aTlODo3GbuitBnCjVVVOC2OAGJT2EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cruNU7pp; arc=pass smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cruNU7pp"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81be5042c56so738681a34.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 03:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790589878; cv=none;
        d=google.com; s=arc-20260327;
        b=K19kGe90Qr1uiW+puGkIOnx8D1k2h9XyWYd4gRFG4zivcJgsh+TA/ZRsIUdN1hWIEW
         /GRav/wSt7h/SiVMWj6xxNzX2WItykF+YLNbV++FiUiHaCPgiygKhfHCibYGdEPxiWdj
         A/CpxzdfchqAkFqzm2wSsXqdiWewhsWOKv4ygZMjbokgsEX20QLk5FKL2t/+qWKmH30a
         YCk4PYAxRYnteCSAvX9awB8dAmkf50NToXlaEjaOXoJd0j/uqZB5nMk5f2wwZeNol/eX
         tGuing/AEIAXr5XIqwV+5SAmQ8QNfKv+Ht4j16P0826TPXQhRhxpLW9n+pm0By2BjRsS
         FNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BC4w9/SPD2ShdV5ojRXJqy0mNEMVxZyH56jhpnMIHqg=;
        fh=DaXwIQqIokGrPoUM8mvAgv5bFzPncIc0jICYzg/jbTA=;
        b=ixpLDjSVbW1SGCPXI2+ctAMdt7QeL6v3Hfn7Oy3z1jcGjqJ8NXZQrffPDudl/5Jw9B
         cWfh08hk6GL+lMCSnaKPFzeLM/CzlhH9ObVRQhrqqcgEHg4noQ6kRDQSnASLJMjGYvwH
         85AtFXlQhzjoIhSBtU26dNh/W69M5G1jaoJrKuRiHqJGBv/m/aijdxJuj74JZLFBopkw
         VVtaI+1Qn5TGL9uxEJVeANEjduuSnHGVc0irwoibKFozxGGh7mATndUaeJP8kYYjH/nU
         qN2ihi2baxmf9co0VoCsLVXzS0BMavLh0IIA5oU16A32O+2GMMqkaPt32+wAWmn/woUq
         mlPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790589878; x=1791194678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BC4w9/SPD2ShdV5ojRXJqy0mNEMVxZyH56jhpnMIHqg=;
        b=cruNU7ppMO6c/+UUEogGLnOg7jffYocRC1htoR+cRQbAYs57k/3rKAIj15qSUailOE
         eRIG/K6MboqfgRmHzR0kfwMaPEcualBFVj2vw+nD6GspAmWY98MXishKOEpczwdCKNun
         dXlKx44HOBh4pW5H/w5z6NCqs9xjW+Qkc3O+wbgAzciFumzAQ2UFW7rHguV3HMBTpzoI
         54P5uPsCSbhX4EgWqm4zfB1tvEF3pMD8saYF1QiXlYN+V/d/6QtmIx19aM8Fw/f1eSSP
         aX0rpiNkYIA86RJOtrKWQ5Y/UpoNLeIniF+IcND8HE47qVQs7cSNuOMhTavF2i14f68I
         O1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790589878; x=1791194678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BC4w9/SPD2ShdV5ojRXJqy0mNEMVxZyH56jhpnMIHqg=;
        b=tE0S/+4XtoehwGSSUpiAbqCIQZDMBdmc6GmOeM5cPzKe6Pf8ICPQ16a0jrLecfLrae
         GoHU6oIzyT325yoILXb/mzPHzQ3G4Q+k/KCEMesWbVdyE7/3EJAeJ6WXFNtQBHYhJUiS
         I7ZMGvsDO04mubmVQE+ayFxgFmMB29PeKW25vsTCXdznlGqBcEe6ybGnUspdKMQtZmou
         9v2Hkcx7nM+qE2mT6FM1zyUb1wtXEE+bMADCykiSBjUR3EW8vt5YORZ6n5tee8Mt8Lex
         Ag+tjsjqmOwaxDxdzFk8lGUd5l/eGA6XSPWE1WxuKEYZmcyCTBVnslWDc6hbqCBjrb+y
         ymbQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+iGCoxZ0G2KeR2h7GMQoDvwGz6WdpoLJ1sdMkRm9h2lOVePYoaljIOrpWfu5FDq6d/ag=@vger.kernel.org
X-Gm-Message-State: AFuF++lvKYZhMEAt6TzSAWPr1h9s7gjvZa/uH8p0jxdDtaCyBUzkYYIR
	pT78p7XfueeP/yjxOee74KoXknIfPoVO4J35JA9F/wT4pP0C22q4Wq+dvmhwSAZ+z3IZ4POW4VY
	YvN5mgBv2fJDgKXlkXVJYET2PQ7c9z/I=
X-Gm-Gg: AYBFou2LWIqHDIc2UhbXAydlB1kC0fBTGT8DRFBU3cMH5SqVCiRS2XfF0OgyVlEaz77
	vlMx9a3+di/dUMjoM5KDXbAJAWuwdCdaHdztsGNl0evlbcgCZToFqXH+1rpv0L7AN53OdaBt9dF
	I2T2I40B0R3ROQnymYeeJyeLD0FqnMbbKSbkwS7CoR1THPiutB16A6xpwXTGMc9RZN45u8IBr4j
	toAsIFlwsaDhrpOMCykE0RlvOQyvvej2q1nYAMsoAzGN+HGNKvY5C5BOBhCwTVOcB4G1PLVSuRr
	g/VAx8dQ/XPQCdLu2h8TzFDJJWnexPvs8Wsw2eHxOtpU8oXh4U5otCkQwxwkkCn6D3XHvhyMcr2
	kB5S7bepIpswhMMI6Cd9R1lY=
X-Received: by 2002:a05:6820:8582:20b0:6d7:cb64:86ee with SMTP id
 006d021491bc7-6d7cb648c4dmr2630575eaf.88.1790589878067; Mon, 28 Sep 2026
 03:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927194205.125086-1-suchitkarunakaran@gmail.com> <DLQS3VWUPXK9.NWD6AU4CU898@gmail.com>
In-Reply-To: <DLQS3VWUPXK9.NWD6AU4CU898@gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Mon, 28 Sep 2026 15:34:25 +0530
X-Gm-Features: AclHuK8gz6mKKCCQPMloKdhVsNaS00d0KwNOldjCSfSti-Fcl_7gmhuMy_xUctk
Message-ID: <CAO9wTFhVR-ZPdmJ-iheaVvpK3huO4CmBjXaeaYUUyP3mpqOzaA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: add diagnostics for rejected memory and map accesses
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei. Sorry for the inconvenience, I didn't mean to ignore your
feedback. Please let me know if the following suggestions align with
your expectations. Of course, these are loose ideas, just to help me
understand how to frame the suggestions as I'm a bit clueless.

On Mon, 28 Sept 2026 at 13:12, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 28, 2026 at 01:12 AM Suchit Karunakaran <suchitkarunakaran@gm=
ail.com> wrote:
> > @@ -4472,12 +4472,22 @@ static int check_map_access_type(struct bpf_ver=
ifier_env *env, struct bpf_reg_st
> >       if (type =3D=3D BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
> >               verbose(env, "write into map forbidden, value_size=3D%d o=
ff=3D%lld size=3D%d\n",
> >                       map->value_size, reg_smin(reg) + off, size);
> > +             bpf_diag_policy(env, env->insn_idx,
> > +                             bpf_diag_fmt(env, "write to map '%s'",
> > +                                     map->name[0] ? map->name : "unnam=
ed"),
> > +                             "this map was created with BPF_F_RDONLY_P=
ROG, which allows BPF programs to only read it",
> > +                             "Remove the write, or create the map with=
out BPF_F_RDONLY_PROG if BPF programs need to write to it.");
>
> That's not true.
> dev_map_init_map() and insn_array_alloc() set BPF_F_RDONLY_PROG
> in the kernel for every devmap and insn_array.
> libbpf sets it for .rodata when the prog has a const global.
> The user didn't create the map with that flag and
> cannot create it without.
> Same in record_func_map().
>

I'm sorry I wasn't aware of this. I wrote the suggestion based on the
fact that BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG cannot coexist.
How about something like below?
"Move the map updates and deletions to userspace using
bpf_map_update_elem() and bpf_map_delete_elem() if the map and program
types support it". Or maybe I'll try to write suggestions based on the
map type.

> [...]
>
> > @@ -6944,6 +6954,10 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, struct b
> > +                                     "Use a writable destination, or c=
opy the data into a writable buffer before modifying it.");
>
> [...]
>
> > @@ -7032,6 +7046,10 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, struct b
> > +                                     "Remove the direct write, or perf=
orm the modification in a program type and hook that support packet writes.=
");
>
> These two are the same as in v1 and don't tell the user anything.
>
> Pls focus your tokens elsewhere. I don't feel we will converge here.
>

For direct packet writes: "Move packet modification to a TC classifier
(BPF_PROG_TYPE_SCHED_CLS) attached at ingress or egress or an XDP
program attached at ingress. For lightweight tunnels, use the transmit
hook '(BPF_PROG_TYPE_LWT_XMIT)'"
For read-only memory access: "Copy the data into a local stack
variable and perform modifications on the new variable."
Does this direction feel right, or would you like the suggestions to
be even more specific?

I=E2=80=99ll think harder before sending the next revision. I=E2=80=99ll al=
so split
the patch so that each commit adds diagnostics for related issues and
I missed some places, as the AI suggested.
