Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793296756;
	b=IZwr9OvF0XSE0p0/yGtVxTKek8cldQWlroLZWdOnDAUOTHoV9k/OooAOaaR/KQL2zFdu
	 o8r7RohgShhDd7AwGKJJixFNsCxxpJowEgboj6tCh7wqWx8lo/D5XGVr50//R4/5k63E/
	 8iclkAbzbao0EWqo2gQY63iNm7qHkSRb9sCDUR0Gy2gYHU7Rk5aRqMe/NBMflxHeAAfnZ
	 yBVkEStsh3pRGCGSTcA52uQESK9UUJWotEKjeaoDtrZoRIn85JGkkLkp+3PKOClixATlm
	 wVUELOcHbDhSWB/8mxxdLVqL2G9fi7U+x49YhxtrGczzPb28ALu38X9yWSbzIWhEoaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lHG7McDXGibw7mJw278mz5xCK+QZhb4zygLxkQkSnyo=;
	b=hDobCyQZQSSqdWGBirAOKYefBVWOAaAydTes/WX0NSZhlgYglI2FIknl+6JyoubDcRZ+
	 JYmdPcxFkR4CulfKgL4fqH6w2cvKW5iBuzc35Lk5L9s/oG3UGLCmPZy4FMz0/oxOfEEA3
	 3KKNcntSxvEM3Y/ZIyQA9/E8BF/bVXTQbdYIi3jfpVApBQdjKKhQvp7/IoawHCeWd4Hgc
	 hBsBQfT0XfT4Dfr8q01QT1YPcNIZveyFdIhrYjZvOn/4TfaLCID/KoqRs0XIGIT3OhQRF
	 wyFEgpuJTzgY6GriDXNgRqssEp8VL/84BvEDzd15jSQWqQJn/nzib4zQUw65HMBBeOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQ1ORx9t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E6606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQ1ORx9t
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1100145a91.3
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793296755; cv=none;
        d=google.com; s=arc-20260327;
        b=SBX5gKtI9RV/v4B5Yi4VO6olikfNPocGkKyLcO5PigxgBFTkvbpUFmf2E/BBbU4EYr
         uMDM5P85zM3zfWODo+7MtnaFZLGCrAbWoyoOTufz7i0oomHyI4LFNNAM5By3T0hSYRjJ
         veIwpjZ0AB0oCC/JinDfMzqYXVkw4L1mIvYQ1UJymISozd0GtnzolYsyOEvBDsMN8znV
         7cE3iLu5mlL4FkssLTWAEutyja55Dpj9pkhgU6r/vhN1JaPOzD/2oHDAxsEXhKG7s+MR
         9nhAimLXVOTCmOpXRZSSqI0OARTElFjhS+HH2jEdys3AIBMDCbJrSMHQlWQKHuX03kGO
         C6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lHG7McDXGibw7mJw278mz5xCK+QZhb4zygLxkQkSnyo=;
        fh=U1AyNOOuD3FDIMQpMwbaUnFIGdCIPVD6XguW1ABdQZI=;
        b=g8Vgo8NzWTAsmWuls0g+hvtf+xMCj7DLWvQWynBrMPXcn3iUo+V+qssBnXKA7sOeAO
         wdkPaj5c8UKCaGoTOl9MPp1nzvn1bHM24sfGCMQ7O38y3eJoAYG5E1oNjtZllVKA03C/
         V0eEXeEIUoNGYEoHRXgGuCE+k8vHgsAymy8FI8y8D+WSz3t4tIKWK2MY4M+ConJ5MD/t
         BVGkc/vEOMmdA+w4qh9rplw4B8+uqMxiarpLcPH9ku2Bj5OFxd+nQrYh1h5bs6PMimrL
         kZ2DIQOUHQTF1tj7fBI/TkZYoUgO/bqUKIJhSsB+wUKt65ftnfpOhH3paIB3Cp1PHjD5
         snNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793296755; x=1793901555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lHG7McDXGibw7mJw278mz5xCK+QZhb4zygLxkQkSnyo=;
        b=jQ1ORx9tW0INF6KzW4uWEy3xjdkDc86f6YpKWRngvItxPuAaFROXiJUPdjsCw2wVY/
         vpCY7sgiVmeeEgiJkUEizyf8VuZM0K5xsEG2kg5LdDV181+LBcAd/ot9AqkL9OO4wKq6
         4RQ1wCC2zkCAuy238MEUhoQDTI/Zqr4P0YR2GlQcfnTQFWok0t1Jh2kcwoMNw4MBSXh7
         yvhgiZ6BUmdqLOvajknRIdX0TECkfsXOSbs3p1J3/FoSUh+wz9ZqLjD9g0nNJU5NMDSA
         oNUBehSRT70N0QfiCIitZ8yTDsEr+atkk+E3x8QnGIHnOg1WqcPWiPJNmVVN70tRhE4I
         j1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296755; x=1793901555;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lHG7McDXGibw7mJw278mz5xCK+QZhb4zygLxkQkSnyo=;
        b=LGBAoPU2ceX9rGkQwUHrEfJfq+pOQ/oS5ckvSYqoSKKQ/cfXsuLoXRnQ70D0BdTi48
         jRC2o0KvlNYVLFJXxdiAcQ/OGY7GXXxGi5Hy9DNFRKefAt/0B5QNP9BR/v1ekDOMS+35
         DqS8omT49N7rJstebcXe84KL9dckXq/j/JQOMFbCfQ/iSGWIbiJPoHI5aw7eyHyKrVPU
         21h1WKKzzgE3PCrhHW3TRU0kS2kxVR6HFxTwNNwybdupKJ3Ue5eaNWQ11Wl8Tt6x6R9J
         +Ez0ewVbnNSSb1az3j7ZOHtFrpxQ9B7xopXdWAl9yHFr+eUstkA3w6AyJUxnmjsh5KFP
         hekg==
X-Forwarded-Encrypted: i=1; AKwUvBzjYXu9eptTe/m+95wlaZS147EcWA2q8nmclJaWDJkyu2Mb0ABEWETNidwA9Wk7DEjDEBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMOfKWaPjvuxllc2H9xGcC4kj306QZfEJXpdTveD7cWmZnBOmq
	EwPd3ESLtyy246o1ACNS8BcNmhnSLDcEUHyo2BCHLPxIo7+FBfDN10JYww6laWhj6SP4pCyp7UM
	kGGKXiA+cqguMVBR5ApvWQS1AryA3TjU=
X-Gm-Gg: AYBFou0AgKBw3D2RjKUVE1oB2vbnzDOzdmtt07HgoiFnxXLvtMSjLmh4fpFLglfA+/S
	QirXO2smfOOIftoRh8PKcGyV1fS67NUC2+qwvSLd/IjLGJFJIMZasgy0CvtLi1uMpTHJkJyz4+o
	Ru5dBasPYYsLFLeQ4MZcnM+XzgNTQow6us3SFaCmD1rrr5a/vOyzwTLwhn5iUQwHWhA0MZA2TbS
	IwN//IdIc3pNPOCJGxzG3++CbIuaKdTW5tmmoscXlPBW33kYglt44FwslVblbbKp7D3M8ms3c4M
	NIrIvoYtULDaveG4NVEKNLUtn5YNWPZF/fK8Kq3VaaEhoiVR8G1WasaJyADkhANbpGC50GlQ+Df
	RrmdJKQFVRCIeIA1RaWKWwCqovVz1m8FHmNrM4dKNPNXHDralkOYGZS0LmQbpr+8NIDkxdvMDHN
	m8XjZg8LLtyzkJ72XSXCM3iEXMjJk1gPZvxw==
X-Received: by 2002:a17:90b:46:b0:3aa:548f:eb77 with SMTP id
 98e67ed59e1d1-3ae5823c672mr5168113a91.56.1793296755353; Thu, 29 Oct 2026
 10:59:15 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
 <20261024014514.2959514-4-andrey.grodzovsky@crowdstrike.com>
 <DMCRBHQKJP8Y.1KLS4ZA48PV06@gmail.com> <CAOu3gNgnhXnN_tDPnXVmnHAD5MNXwZ5iOc4kO15vy5cu1TpEgQ@mail.gmail.com>
In-Reply-To: <CAOu3gNgnhXnN_tDPnXVmnHAD5MNXwZ5iOc4kO15vy5cu1TpEgQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 10:59:02 -0700
X-Gm-Features: AclHuK_nuGxt9jQRjla6Np6o74VCdwusmQu1YtSAeiTxork4w4S_I4N-FAQDeMM
Message-ID: <CAEf4BzY0PSQc8ugHFk-BSZT=0GSYnL7B4bMLbVV6vHujLwVLTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/7] libbpf: BPF programs manual loading and attaching
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, andrii@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:06=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Fri, Oct 23, 2026 at 11:45=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Oct 23, 2026 at 06:45 PM Andrey Grodzovsky <andrey.grodzovsky@c=
rowdstrike.com> wrote:
> > > -void bpf_program__unload(struct bpf_program *prog)
> > > +static void bpf_program_unload_full(struct bpf_program *prog)
> >
> > [...]
> >
> > > +     if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL) {
> > > +             zclose(prog->fd);
> > > +             return;
> > > +     }
> > > +
> > > +     bpf_program_unload_full(prog);
> >
> > No need for two kinds of unload.
> > func_info, line_info and subprogs are filled by bpf_object__relocate().
> > Nothing depends on them being freed in bpf_program__unload().
> > Let it close the fd of any prog and free the rest in
> > bpf_program__exit(). Then bpf_program_unload_full(), the strategy check
> > and the second paragraph of the new doc in libbpf.h go away.
> > Do it as a prep patch.
> > Something like this:
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 8fcb8cf..dd15842 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -876,10 +876,6 @@ void bpf_program__unload(struct bpf_program *prog)
> >                 return;
> >
> >         zclose(prog->fd);
> > -
> > -       zfree(&prog->func_info);
> > -       zfree(&prog->line_info);
> > -       zfree(&prog->subprogs);
> >  }
> >
> >  static void bpf_program__exit(struct bpf_program *prog)
> > @@ -888,6 +884,9 @@ static void bpf_program__exit(struct bpf_program *p=
rog)
> >                 return;
> >
> >         bpf_program__unload(prog);
> > +       zfree(&prog->func_info);
> > +       zfree(&prog->line_info);
> > +       zfree(&prog->subprogs);
> >         zfree(&prog->name);
> >         zfree(&prog->sec_name);
> >         zfree(&prog->insns);
> >
> >
> > > -     bpf_object_post_load_cleanup(obj);
> > > +     bpf_object_post_load_cleanup(obj, true);
> >
> > I really dislike bools.
> > bpf_object__close() is the only caller that passes true.
> > Clear obj->has_manual_progs there before the call.
>
> IMO obj->has_manual_progs naming becomes now somewhat misleading as we
> still can have manul progs at that point we clear the flag. I am
> thinking to rename the flag to skip_post_load_cleanup to reflect more
> precisely what the flag's role.
>

instead of manipulating the flag just move fd_array freeing to after
bpf_object_post_load_cleanup()? But bool with comment, e.g., `true /*
force */` at the call site is fine for me for such a simple use case.


btw, when do you plan to post a new version, it's been a while that we
are iterating on this, I think we are close, so let's try to land the
next revision

> Andrey
>
> >
> > > +     err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->insn=
s_cnt,
> > > +                                obj->license, obj->kern_version, &pr=
og->fd);
> >
> > After bpf_object__load() this loses the fixup of the verifier log.
> > bpf_object__load_progs() ends with bpf_object__free_relocs(), which
> > frees reloc_desc of every prog, MANUAL ones too.
> > When a MANUAL prog has a CO-RE relocation that didn't resolve on this
> > kernel, fixup_verifier_log() -> find_relo_core() finds nothing
> > and the user sees
> >   invalid func unknown#195896080
> > instead of
> >   failed to resolve CO-RE relocation <byte_off> [..] struct
> > The same prog loaded between bpf_object__prepare() and
> > bpf_object__load() gets the proper message.
> > Progs that depend on what the kernel supports is the use case
> > from the cover letter.
> > Keep reloc_desc of MANUAL progs. bpf_program__exit() frees it.
> >
> > pw-bot: cr
>
