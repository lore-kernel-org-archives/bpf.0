Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792521551;
	b=0vYFh/lgxj8TW5XPD7RuhVuSStKlxy9+g7Pfto4e2A+fJw8QwF9UNDORyNcL93XKg4wY
	 oO8AyA8ngSeTdnZL+ft5y9tGeIYfQ9/QwqtMvDmQNmIcy5iDKQ8MPcHTsV0uxZ7yrMV5h
	 7ngX9fSaOdpzIuVqVWWGfoAUinaoDmyQWwllW2VeVlTGBBbtwTrhgjE5wGl3vCto0eiJA
	 rzzKpiVNFAVBDr8tSAbXwGEUK+YIavcXrrTW5FgWirofLfMRwvA2tv9RkauOPtusrmPR/
	 Px8Bp8RHCuJG20DwfzZWR9C8NWcI3fXZbgoxQxYzGPcNwOmqBNuThyZu7qfhwBn1ACg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+5zFGqfBVV3xW6Aki/3XgyonXgn6J8+QNfmXALF715s=;
	b=y19q6kqMSymRfWehKt3MksXHtiBiTPVZM26/rUneGePIeKrv+jWUlmETVFQ0l/A/Zc8w
	 ocAo52gQYT9pZLkuKwpG7ZbwnRSel2xGV4PfZMFnXiYvgOR3bQuB4U9birGiEqVRaIP8/
	 eOrpycxtYSg095t8BuPy98czEwTyOtYOj2Xz9LWku0tZLFrzOaA1q5nOrB7AzatWEG+dg
	 5OXzd88RWzeZWcBlnSqbo7fnfwRCACkiRqH59hZCPh99ll8B8PIxj2WoW5x8OZVKesa/r
	 lXPq865V+GMa+7B1ULl313q5gHWYwiEHNmnhl/L1FUppWMUA/fXJ++aSWw/dGCzuxUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hAAdT7AN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AD606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B6AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hAAdT7AN
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd623dfe420so2608778a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792521550; cv=none;
        d=google.com; s=arc-20260327;
        b=Gf0JepU3D15Mf31oekJzbM/Gf7RfW/DzWua+YXGexBuszCY3wODdqPyUbd5mLFHa1V
         ZDy+zV3HSTa5SYexkq8DR+i3QKvYG2MTQK8+3/T/qFRjWO3RhMT4VnyQaDA/M44q54QQ
         7oICJA7oXaMjzEEZQRvGZk05kZFnaVKzR0+OSwK8GHONOB18LSEZXj4Nmw9WsySkSwKD
         C84tZBfVCRmzP3N/sMHzRbU8BQcmi9NxPyLkX+LRcaWWhi7319lQSdxH2Uagxa47go45
         s9ilYBlDLA37zBfs2MRwON3mKvElSoi9HdOonmxEvSagL/m4AnSTLMr74UYMV2iOYz6E
         PSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+5zFGqfBVV3xW6Aki/3XgyonXgn6J8+QNfmXALF715s=;
        fh=evWe+gSJYKyh6CGUlUjBef1dPd/T7E2wMJaiGEbUlKU=;
        b=QqlLHWxk1HoFSfh3HTItRECOtD386PTjLCp5zQwP0QGI2XuQy7BeL2Zl4nU7ghSMZN
         PxE4JKIQOAFxyJ7kIDo1goJwgIfzi/tzv/rGUmJ4WfB6QhcY1JOuAeHKRgkaFIbLycOp
         kk6DjYbW5NyG1Dtz+yS/sJemir/nW+0hOG9R5Y3ySMsnV1S/WK6rx7Tb8l7c/5IXK/ll
         f6bSq0ZXY3vOH7vJTd0pVlXVlaQY01S7eS+AAtSPVQuVBrhBJP5WytwXlsdBW1q+R94b
         GNBBam7jhq5v8gF3t1Ac0V8hMeeEOWZNOo+tAKbfiAtTuz3BGCoQnARTy6NUznQO99cU
         btCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792521550; x=1793126350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+5zFGqfBVV3xW6Aki/3XgyonXgn6J8+QNfmXALF715s=;
        b=hAAdT7ANT3/aqsb+ojjWsFK+8Jf+0d+CSJ1AoEMTgHRBk0mMEduDmN6BZv+FrX+xeu
         8ZgAIDFFTjFLZh2Ko70yj7Nbr8qjvk8e6vq/U8tR1/vqxNBSK2fSrTt44tqaTrUOtNPM
         qxKFkD9K4Mwddm0XkcZig++9UobJ0+wdQAX987tlHAJ1mbs8NMdyIC4h4rmnBhBQ2kwC
         5LjHC2205P6CHFvd9Ttc4n2LdCj++CmAA1TbKLO7ntMTmJzq1Vbi2Qr2ck8ejOPMfVu5
         TFzKRax+NyQJZnNEBzr+mk9vXPVuQa1pzP7YzBH1GQ7IhFXx6mCd7v7+49u9DHgqiCbF
         g9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521550; x=1793126350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5zFGqfBVV3xW6Aki/3XgyonXgn6J8+QNfmXALF715s=;
        b=rThXIT5w0Cxv8EdyqQxUPpCqDcDC6HzUE0AKo5cAYAEjDWd8rk/cJjczT0lJgjxQI4
         +aTMhDXTmeJrcW1z0YjREdrvI3/LufL1opZxSZua3Xx9L/FgZzWy2x2/8gYtmG5+iM5+
         h/1yTOLz4Ahoh0qY3iRTRt3pWytApsxsrU2CeGtapvCUo2fYZD6bf21p2/0henYFfZN5
         kiXFsSOj5oqvKznI2H50YRlaPNCJvI7QbSYXPF2h1JLGYrSWxWBjQFFGGZjZRT8wNT6a
         H4UNqr9gcSjpOHReUmdXASKy5d+l8VpEcH4U1/54bVvZbchOe8PlLHb7cj3SoZPWqPlM
         /IQw==
X-Forwarded-Encrypted: i=1; AKwUvBw2rp8RYEdPBy1fFwbWJ4DbrzTaNTZswbRliAaeIVNpmhIiN06+pJywEs6a+QYeKh3NvIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKB8isECOFuA4ffw4GlShdHPGZAe2c212O8HkbpPw9WYaiIjlMG
	gXw6hG/fWsta8B+bLoMo4ZucrpHc9+OVnaF/Kd3mReZloQboyIhLY57gaCgxsMOZlFixX3AJ9Fm
	JZhLZqgFpIgYbkomYb0w0XDTwGNnKfMI=
X-Gm-Gg: AYBFou2zbzsfmnLHCplVW0ob9sHoG/uDD4EpOdyR5eBgaCB9nuUSAI77yciDN6F2Tb/
	dydgghHsPi5k3R/U8glKx4vUwL2sYmlqDysxjGmNsFXIdwvp1Sg5ikX0Ww3+0gL+nis+ypB8MaK
	Ac3a1uoZn+erZW2lmJG2ZoHofyluW+M0HnI8ybwfKWfQqicIOLp3T0o47qzCngghO/KN1EqntqH
	Ld52zw/Ifd7U3COTiAOUfWldi3p7XoG3PjZ143aoGUggLA9D9vB5K7aDNp1ipHDtXfux56qeiUg
	vKi7WA4oUQGobv6xQ/Jsk4ijL9IV0l/DbypEn4ey92MLHSvsmi4egQxid+C12nLv5X4zuUeZKKW
	+qEtrB9XQZ+mrIjA4gAMRdspbFAR9XjCRaF9ABqUP1ajXv8Pnm8dzsn+IqWUWiL2u
X-Received: by 2002:a17:90b:5487:b0:3ac:9c37:9426 with SMTP id
 98e67ed59e1d1-3acef0c8743mr11052165a91.31.1792521550227; Tue, 20 Oct 2026
 11:39:10 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
 <20261010143156.379864-8-andrey.grodzovsky@crowdstrike.com>
 <sashiko-outbox-166685@kernel.org> <CAOu3gNj7fYONFo2-UqcBVv5Uk2=d4Cw=0fvQvLPCwiDA6zc3Wg@mail.gmail.com>
In-Reply-To: <CAOu3gNj7fYONFo2-UqcBVv5Uk2=d4Cw=0fvQvLPCwiDA6zc3Wg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Oct 2026 11:38:57 -0700
X-Gm-Features: AclHuK-AWau34ltWS04pDenENv5-tDO6-u2ioZdJ_Z5yaVRsHA3AkdRi4OAJDTQ
Message-ID: <CAEf4BzbxEBC7CGDTZF_3nvupgB4QGcV_k0e1mo5Zjm-g2nBWsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/7] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 7:53=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Sat, Oct 10, 2026 at 11:08=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [Medium] bpf: veristat uninitialized memory read of log buffer on ear=
ly load failure
> > - [Low] bpf: veristat skips cleanup and info retrieval when BPF program=
 fd is 0
> > --
> >
> > commit 9ac34aec88e7eee9b39c53e8055bc5989345ce5b
> > Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > Subject: selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANU=
AL
> >
> > This commit updates the veristat utility to verify programs using
> > BPF_PROG_LOAD_STRATEGY_MANUAL alongside bpf_program__load() and
> > bpf_program__unload(). It replaces the previous use of bpf_program__clo=
ne(),
> > ensuring RODATA maps are properly bound during verification and subsequ=
ently
> > dropped upon unload.
> >
> > > diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/s=
elftests/bpf/veristat.c
> > > index 9cfc9b4b41c12..0cd19b59037f6 100644
> > > --- a/tools/testing/selftests/bpf/veristat.c
> > > +++ b/tools/testing/selftests/bpf/veristat.c
> > [ ... ]
> > > @@ -1726,18 +1725,15 @@ static int process_prog(const char *filename,=
 struct bpf_object *obj, struct bpf
> > >       if (env.force_reg_invariants)
> > >               bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANTS)=
;
> > >
> > > -     opts.log_buf =3D buf;
> > > -     opts.log_size =3D buf_sz;
> > > -     opts.log_level =3D log_level;
> > > +     bpf_program__set_log_buf(prog, buf, buf_sz);
> > > +     bpf_program__set_log_level(prog, log_level);
> > >
> > >       cgroup_err =3D reset_stat_cgroup();
> > >       mem_peak_a =3D cgroup_memory_peak();
> > > -     fd =3D bpf_program__clone(prog, &opts);
> > > -     if (fd < 0) {
> > > -             err =3D fd;
> > > -             if (env.verbose)
> > > -                     fprintf(stderr, "Failed to load program %s %d\n=
", prog_name, err);
> > > -     }
> > > +     err =3D bpf_program__load(prog);
> >
> > [Severity: Medium]
> > If bpf_program__load() returns an early error (e.g. from libbpf without
> > calling the kernel), could the dynamically allocated buf remain
> > uninitialized?
> >
> > When env.verbose or env.top_src_lines > 0 is set, buf is allocated
> > via malloc() but the fallback initialization only null-terminates the
> > static array:
> >
> >         if (env.verbose || env.top_src_lines > 0) {
> >                 buf =3D malloc(buf_sz);
> >         ...
> >         verif_log_buf[0] =3D '\0';
> >
> > If bpf_program__load() returns early without modifying the buffer,
> > parse_verif_log(buf, ...) will read this uninitialized memory. Could
> > buf[0] =3D '\0' be set directly on buf before loading?
> >
>
> While this is a true observation, it seems to me this exact scenario
> would also happen in the `clone` case, so it looks like a pre-existing
> issue.
>
> > > +     fd =3D err =3D=3D 0 ? bpf_program__fd(prog) : -1;
> >
> > [Severity: Low]
> > If standard input is closed, can bpf_program__load() assign file descri=
ptor
> > 0 to the loaded program?
> >
> > If fd 0 is assigned, later checks will explicitly skip handling it:
> >
> >         if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
> >
> > This causes the program's JIT statistics to be skipped. Should this che=
ck
> > test for fd >=3D 0 instead of fd > 0?
>
> Same as above , I thiink the issue was pre-existing.
>
> >
> > > +     if (err && env.verbose)
> > > +             fprintf(stderr, "Failed to load program %s %d\n", prog_=
name, err);
> > >       mem_peak_b =3D cgroup_memory_peak();
> > >       if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
> > >               mem_peak =3D mem_peak_b - mem_peak_a;
> > [ ... ]
> > > @@ -1774,7 +1770,7 @@ static int process_prog(const char *filename, s=
truct bpf_object *obj, struct bpf
> > >       if (verif_log_buf !=3D buf)
> > >               free(buf);
> > >       if (fd > 0)
> > > -             close(fd);
> > > +             bpf_program__unload(prog);
> >
> > [Severity: Low]
> > Similar to the issue above, if fd is 0, will this prevent the program f=
rom
> > being immediately unloaded and leave it in the kernel until the entire
> > BPF object is closed?
> >
> > Should this check also use if (fd >=3D 0) to ensure cleanup occurs?
> >
> > >       return 0;
> > >  }
>
> To summarize, I agree all the 3 issues definitely need to be addressed
> and I am happy to fix it. I just don't know if it should be as a part
> of this patch-set or a standalone fix?
>

let's just land what you have, don't add fixes for preexisting issue
to your patch set


>
> Andrey
>
> >
> > --
> > Sashiko AI review =C2=B7 https://urldefense.com/v3/__https://sashiko.de=
v/*/patchset/20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com?part=
=3D7__;Iw!!BmdzS3_lV9HdKG8!3il3wicS8Eiw2ogONUagDMIrsqcvvmLZ1xXNrquJMEVXEJr8=
5kqsNp4CNFasNUc417QJ6t73GShkLS7-x-efgKPJp1HzLOdaJg$
>
