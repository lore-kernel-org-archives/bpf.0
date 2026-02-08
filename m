Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEDF30C353
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551801; cv=pass; b=eKFlDaPKEjHqFI3NZzEbT0dftqoUNgwZ1kxPeKL10QUSxmO4cAFwfb5YYXy9HcHRPN7We0AQs9MPulFHDx1F4AJI6a4eXd4KW9Q8pewe6B3VxxYj8c89zNwtg7mQPkDc7uwKI4At8hHIgFFTn9HeWPV8aGYSGGEpFp3hjcmRF2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551801; c=relaxed/simple;
	bh=O/bCq9oY7MiChqCYIWRrDBo5upEC/4yNbaqzbHenGs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+wGkF2ZadiL4sa7l4H2xJMcf9VSEK2f5/1FMQASgHSkncqPI3MdT2H3T76AKNs/xef3chEsltV++4pB0WdBUV3knnAmS/EBWEnWaUclSn3e6Ax2SPq9fCnm3Ni0DufTcD5NNqACH4vlMwWsObfMcSvfPF1bxpcVjTDAEewVyXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9Cnrgrs; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Cnrgrs"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79640a34aecso1872377b3.3
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 03:56:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770551800; cv=none;
        d=google.com; s=arc-20240605;
        b=euq1kTr903VeYQVaR5Gy5PwFYxNkgZs4BoJCJUxxzgrfp4tFAVpZyU6SxzIfbq9ht2
         IkK9KwTHTWL7R+HPZ+gOKhADOoWetvGiETZPOFSO/wlC6aj2Kj5VCwD2cdYKHwVfrGe1
         YefdPpGd1g4om0LV0leDOQl4lz50YwQS2dRnc+hV26tqOEDBu2a1KBK4sSapvFcp5e+j
         t479fG96lZpMl/QtiWrsG/9w+yMPkyfvyJ9QD6k4zONyedMxxvZ8+kGE5qiZW+OD9o3u
         cmfxqtadgAewhzEPYQqF9/jxJjKbpRz0+ngWD7R/vh8k6+HLwELoYJfLp/0FyAWz5yqo
         QhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lQ74fT1LHGLF1+MzpFCcRRM+LpRRKH/G9qpCR6T7NSU=;
        fh=TTxhMyfhAVqQ1IR3OCB5mJ3e88w9wh2QYu6naN1/Q5Y=;
        b=ERyBXFotT//jj7fRUGwmMWQYV6nEUHOhV7iGXHwOH6nwWxYOqnvrntFvZA9V3ONlfL
         LpBxrURRkcyyvh9CVMifYoA9HbWqpQFnPpJsl6JGJaYzSkrL+h4zC+Ajz6GuKlAuUX1t
         28CgtZIQz3PONyyXGdi1tzf60BKS7K7JgWSmPzGmVE1NdKxAxwhLIK04Jgq57ELV1BPb
         rOFcWeFeWx7hWGhnfH61FIpogDSRwxP3uHU0nHId3MF9vPO7R3QvqHxHQFnMDNp2nSds
         3EMrNSSql63PRyxBtrcaHW/jh6pxi+Er/U5cxUwe8OSj1KrE3EVp28Edmsmktk/1vSge
         syaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770551800; x=1771156600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ74fT1LHGLF1+MzpFCcRRM+LpRRKH/G9qpCR6T7NSU=;
        b=X9CnrgrsGM7vylzrBelsKfGXIFvPlpnJdvYUiWEMq5EosmTgO5fJtFvAxylTqGYE0+
         dp2drBUdwtXGgFubH9L0qVDcGnQ+F8JpKducOZR1xriSZ4uORQ/ygMNhuVyFe1Q6o+S1
         D2LEF0v1zrQQur063g6b/cg6mT7sgFErZlnKbLgm4Vq9jIWlm4rrTBpWl2ddfUlerogt
         wBWUd6ilAOAQqXvpnluSY+e6KGTNbO4IC0seZy1rMfJOnZ7NjxOAYDvCuH44EnF8G4B3
         qq3u0Dz+WUJNEz1gl2G+8K7BOvR1Po3ZWiPokR9ZEpbFsx0TILgVkd/QU6JGBKLSsk/j
         RgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770551800; x=1771156600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQ74fT1LHGLF1+MzpFCcRRM+LpRRKH/G9qpCR6T7NSU=;
        b=l1bce9cRqOQHJ0dFyB9kIdZoVsW0BQ7w4HcsDDqubx4DQzA62rHHrcdTNbnjieM+it
         oCEoajP0ffrTyUwboT+7PZ3H7JGuJx1mcNFQ3FjecvM4P6eGbSdeATA7TnsBhq6K/VaG
         u0uvZfnj4zeT7SRc+7q+ySYDiGOkQOGRQk1vKgR5+p8WALKtV+Hct9bHkiQm5zkHGAO1
         WRp6FscEkFMMSJrVSfJOnnpU73QBb5b6XTHNseL9VjfAyZCC3HQ2DrcALiOS6cNOuf02
         CdnoloQ18QEFfLOzZdcEQlCkRUK/L/DdL3gV8+oUTLTBI12X5DJcJffDmWmGlGPb3KRR
         pNmw==
X-Gm-Message-State: AOJu0YwbmILQTapqRkQEDQKTEi0V7P9sEUyicaDXZaKz59Y6cEjjNZW8
	YWipPbKZoqu/obSHQgd86tHuzXwfUKW24dNn+qi9gEACDU1YpQsYkja06X2r+1YgrA3A+d0nhiq
	6Y0z7xaEcbU288MjnH7MWQIzoiBe8FNU=
X-Gm-Gg: AZuq6aIfSjb51Me1cFuQpOyty8YD8k48FVh9Rv+ywRPWA1if4krw2RL0QhYaM3ZPfyn
	4oVjf0AdRjWmu00D2XzBGlhNROo1f0yavgfxRjmi2T2TnT8nLyJ6XSEpp5HWg/Pv1Qi02jNG38X
	mHo+ciIkwGNIp0MFnO04QmKY1X2c1Y3fpxmhxwdfQkf/pHD2s013Z3oJCjJg6xJEs1dZzJXSybG
	HWSW7iTzPiKox5h817Ajq3zG+7+4i4tgD1YmrDzTQ/1u5HpkqminRhv2Tqkdx1Q9hDdoVeVLdxV
	nJkc3BJzHBsIHrD6rtHqrGnpqWP6
X-Received: by 2002:a05:690c:f14:b0:796:39c2:bccb with SMTP id
 00721157ae682-79639c2d1d2mr27442187b3.63.1770551800165; Sun, 08 Feb 2026
 03:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208103240.6268-1-a.s.protopopov@gmail.com> <620b07ccda2db959a07fd2fc81c6cb3127dddfd17c64ef6dce63113c8eb30f37@mail.kernel.org>
In-Reply-To: <620b07ccda2db959a07fd2fc81c6cb3127dddfd17c64ef6dce63113c8eb30f37@mail.kernel.org>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Sun, 8 Feb 2026 12:56:28 +0100
X-Gm-Features: AZwV_QgBmWdgbJJ7xId5iRXubbrF9o_jEWM5gI3zCMHPlcNdXRDUTH8MkQzUIr4
Message-ID: <CAGn_itx-OugbN_Hy9RctDfE6cMCjMJ+u8+wPpWkh1w8R3-50kA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Fix a potential use-after-free
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, aspsk@isovalent.com, 
	syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 11:52=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -21466,9 +21461,7 @@ static int check_pseudo_btf_id(struct bpf_verif=
ier_env *env,
> >
> >       btf_fd =3D insn[1].imm;
> >       if (btf_fd) {
> > -             CLASS(fd, f)(btf_fd);
> > -
> > -             btf =3D __btf_get_by_fd(f);
> > +             btf =3D btf_get_by_fd(btf_fd);
> >               if (IS_ERR(btf)) {
> >                       verbose(env, "invalid module BTF object FD specif=
ied.\n");
> >                       return -EINVAL;
> > @@ -21478,17 +21471,23 @@ static int check_pseudo_btf_id(struct bpf_ver=
ifier_env *env,
> >                       verbose(env, "kernel is missing BTF, make sure CO=
NFIG_DEBUG_INFO_BTF=3Dy is specified in Kconfig.\n");
> >                       return -EINVAL;
> >               }
> > +             btf_get(btf_vmlinux);
> >               btf =3D btf_vmlinux;
> >       }
> >
> >       err =3D __check_pseudo_btf_id(env, insn, aux, btf);
> >       if (err)
> > -             return err;
> > +             goto err_put;
> >
> >       err =3D __add_used_btf(env, btf);
> >       if (err < 0)
> > -             return err;
> > +             goto err_put;
> > +
> >       return 0;
>
> Can btf leak a reference here when __add_used_btf() returns a non-negativ=
e
> value for an already-recorded btf?
>
> Looking at __add_used_btf():
>
>     for (i =3D 0; i < env->used_btf_cnt; i++)
>         if (env->used_btfs[i].btf =3D=3D btf)
>             return i;
>
> If the btf was already added to used_btfs (e.g., two BPF_PSEUDO_BTF_ID
> instructions reference the same btf), __add_used_btf() returns the existi=
ng
> index without consuming the reference.
>
> In that case, check_pseudo_btf_id() took a reference via btf_get_by_fd() =
or
> btf_get(btf_vmlinux), but the "return 0" path does not release it.
>
> The original code before commit 76145f725532 handled this case:
>
>     for (i =3D 0; i < env->used_btf_cnt; i++) {
>         if (env->used_btfs[i].btf =3D=3D btf) {
>             btf_put(btf);
>             return 0;
>         }
>     }
>
> Should something like this be restored, perhaps by adding btf_put(btf) wh=
en
> __add_used_btf() returns a non-negative value indicating the btf was alre=
ady
> recorded?

Yes, thanks robot, something like this. (I prefer to put it back in
__add_used_btf().)

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/217967=
44040
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit has standard kernel formatting, add=
resses a real syzbot-reported bug, and the code changes follow conventional=
 kernel patterns without any AI-typical verbosity or over-explanation.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: BTF reference count leak when the same btf is=
 referenced multiple times can cause memory to never be freed, but does not=
 cause crashes or security issues.
