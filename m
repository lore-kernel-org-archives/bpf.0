Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9B2836A6
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778327427; cv=none; b=YuyI9y6Ri+sNVx6L7BBKa+d/tVknptf3666adrrj5sFrgobJB/cVTvIcPutj2Xqsoc6tNNcMtmhr4+C4j7c6cgFT2dzsYrbqVGtcBllOHbyxXkxGlGWrfOkCHUDdqLwUsU9XR/0bgULDMHZjz72Uv4N80nplJqIJ6OxorVPuyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778327427; c=relaxed/simple;
	bh=J/EL3Y2oCRAog8cN3VJvIbSDvWtrO4uPWJuHm1ccVnw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJU7+GmYJltmF0CrSnoSvEqtIF2j8BLuiFyXnh9GQXHeG0jIpoK42qxSSX1BR8AeVhU4yA5vwAGFxj4Gs0DRoGHe9wNobVt9T2af6RcYMDee7SI0/tO44np9aPzAp9Rnp1/1YpGrw2L3T6Z9xB2yugRIlvVRX0Mz0yAIkotCghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu4Mb/Mw; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu4Mb/Mw"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c827313dac0so162341a12.1
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 04:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778327425; x=1778932225; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/EL3Y2oCRAog8cN3VJvIbSDvWtrO4uPWJuHm1ccVnw=;
        b=Vu4Mb/MwaXNYPxTUDE8R8vj0H3iZHrF1JU0F1Wl/JidhUyu5gWMHXV3cuoEnowEOQV
         mQqLS9I+uPL76UWnfP2V6gSc2HVuwZBx3dqJpqiH9qfR1Jvz1FBcNX/zyKVBmJn1HLhH
         L/xsuvkKQl8fvqlY8vAw7pRZ9EKNZxbOjBBRDPrWKJz6r1psyHcwK+gQ1lzvxnXMiq4k
         8z5LRvjaE7gjfHbBmsF23pEomg/z1f98TegNTal+iQe+Su2ylG+ZNM/+uOgI7ChIjo1F
         ad5c3S+Yn9m35id73GAwN9a+CfAso6Y31uz5l9LKxPQjYlrBishgZCrDzsRMkYn4U91U
         PaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778327425; x=1778932225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/EL3Y2oCRAog8cN3VJvIbSDvWtrO4uPWJuHm1ccVnw=;
        b=QT88pCWUj56B0ocQ2U/q8PcF0PYfYBpJbJWBX/Yad7Dkb6IkXzukfwQ0AEPh9fmqU4
         VdiBvnN7jaHPUIn/TkFcKzEVO2QuP15G0lHNINgBNcdlkcOwC86YNkS/WifLDwVh5tRZ
         xzWpTU7wzP123CBptNZkylzMuk1RaKRn6MUkMUATay+X0MePsD1xd0KN30ojLf7bxhGW
         +aB1HJKEyAFZmqqfNIkdSYlCDaSEDcaH2zCLhifBnXD+1f2UZmnxgu8D/lIkIMdLWKQE
         Qqs3czODXbraDVA5V2ZkInOeG2tgXcJcvJE6PYt8i07MwHbmwn6xHsGGswgH5LRHPWk+
         ZEfg==
X-Gm-Message-State: AOJu0YxVzpk0AO8nKElWEfJhdORIdFrG3y6v0xYgtMX69CN3xq2dYuvO
	baBxoj/Cv/SPXtiei0mrNq1DyKEc9a2+tdgM9QhuiM64AY+2UkZY8q6efOULkg==
X-Gm-Gg: Acq92OEVqKAP4s2jt5AGHbrpu/dreBV4obcNoS2MWi3ISuGckwRmGrvZ+GAWqJiYdSc
	PvL6s759bjvj/9IeO3acyw+I2tRMvj8GO8CfpZGumPlTYbeApB7DqhLHJT/6etp2NwzL2moSdmV
	6wKSAdZyn3BpyK6Avp0j2UHBBEU8cLLVW/G6lkwNrdKh12yI7orFh5vbtjLHwSo6qIFykdoM1O3
	xYQXX0KtdtgZ7NgeFgfQYWCTlX4qmo7S0AE67HDrPtEfSD/BwgRfg+w8z24xbC599wk5MHZ+0wl
	fbUYEDerJUe62lWHmIHVWwfIrKIAOU3vAXrarUkeAv+NeCn9woLSexjvFg/weLf5gAJhBPEKDMg
	t7nDNEM21CyRQ5iksF4nalLl1p2Bpm6jo2kOid+ON5osQOFKLcIA35p+vL/A6pwtcJOX2Iri+EL
	AgtVx1ykR3kxYk03UDU79soOvySEYwzclvHxhJhYc4QkHE6wcAIfbOI+Tfc+HRsA==
X-Received: by 2002:a17:903:3890:b0:2ae:4ad5:b76c with SMTP id d9443c01a7336-2babcbac030mr97476995ad.10.1778327425106;
        Sat, 09 May 2026 04:50:25 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm47776865ad.44.2026.05.09.04.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 04:50:24 -0700 (PDT)
Message-ID: <3e3a145bfb6c17535c5c921c60f405d56d32bf7d.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't run arg-tracking analysis twice on main
 subprog
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Paul Chaignon
	 <paul.chaignon@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>
Date: Sat, 09 May 2026 04:50:21 -0700
In-Reply-To: <CAADnVQ+kM=Zg_pcY30QHFPu_16L8wa+DbgQqnidqo-QZphihFQ@mail.gmail.com>
References: 
	<e4d7b53d4963ef520541a782f5fc8108a168877c.1778176504.git.paul.chaignon@gmail.com>
	 <CAADnVQ+kM=Zg_pcY30QHFPu_16L8wa+DbgQqnidqo-QZphihFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-08 at 16:24 -0700, Alexei Starovoitov wrote:
> On Thu, May 7, 2026 at 11:22=E2=80=AFAM Paul Chaignon <paul.chaignon@gmai=
l.com> wrote:
> >=20
> > Because subprog 0, the main subprog, is considered a global function,
> > we end up running the arg-tracking dataflow analysis twice on it. That
> > results in slightly longer verification but mostly in more verbose
> > verifier logs. This patch fixes it by keeping only the iteration over
> > global subprogs.
> >=20
> > When running over all of Cilium's programs with BPF_LOG_LEVEL2, this
> > reduces verbosity by ~20% on average.
> >=20
> > Fixes: bf0c571f7feb6 ("bpf: introduce forward arg-tracking dataflow ana=
lysis")
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> > =C2=A0kernel/bpf/liveness.c | 11 ++---------
> > =C2=A01 file changed, 2 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index 332e6e003f27..505250998f36 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
> > @@ -1914,15 +1914,6 @@ int bpf_compute_subprog_arg_access(struct bpf_ve=
rifier_env *env)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 instance =3D call_instance(env, N=
ULL, 0, 0);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(instance)) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 err =3D PTR_ERR(instance);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D analyze_subprog(env, NULL=
, info, instance, callsites);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out;
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Subprogs and callbac=
ks that don't receive FP-derived arguments
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cannot access ancest=
or stack frames, so they were skipped during
> > @@ -1934,6 +1925,8 @@ int bpf_compute_subprog_arg_access(struct bpf_ver=
ifier_env *env)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * each subprog is anal=
yzed before its callees, allowing the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * recursive walk insid=
e analyze_subprog() to naturally
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reach nested callees=
 that also lack FP-derived args.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note the main subprog is =
also analyzed as part of this loop.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>=20
> Thanks for the report.
> I guess the fix is correct.
> This part of the comment needs to be adjusted:
> "they were skipped during
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the recursive walk abo=
ve."
>=20
> I wonder whether something like this is cleaner?
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (info[sub].at_in && !bpf_subprog_is_global(env, sub))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (info[sub].at_in && (!bpf_subprog_is_global(env,
> sub) || sub =3D=3D 0))
>=20
> This part of the comment:
> "Async callbacks (timer, workqueue) are
> * also not reachable from the main program's call graph."
>=20
> is also not quite correct.
> In here:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else if (bpf_calls_callback(env, idx)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 callee =
=3D find_callback_subprog(env, insn, idx,
> &caller_reg, &cb_callee_reg);
>=20
> they could have been reached, but find_callback_subprog()
> will ignore timers because FP-derived args won't be passed
> into them.
>=20
> Eduard,
> wdyt?

This is a nice catch. Idk if 'sub =3D=3D 0' part is necessary, tbh.
Paul, please add my acked-by when you respin with fixed comments.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
