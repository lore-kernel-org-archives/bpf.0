Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01A41443F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419786; cv=pass; b=fyVADbrNuaDH1nd5rRGxAaz1q0eHcarI47uGfw+2z0Kc0tLxYsqGJI31RZbdNtL/2KXQLY27kKD0iSjF2QJP99KXpzKoL8+qIIM25Pn+rnjqOv2SXG/juWLfjgdB/pxZrFIGOgX1iTD3BDJKYU3tdRHCpc5C6ZO5icxiiU0GtmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419786; c=relaxed/simple;
	bh=TcMIKztAxPUEwbcBrlMBI5zKh5KEIYOF+Cd0/8pmdYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWqNJAA1Qzqb3aPxX5Bm5JuoNv3EfdOm2IGaq3JyykxD9UAFucFvqsfIIjJORD68Pt08BBqD6B3jeQfX4uIW4iV1GKw2E8b8UdxEc7meZUulo8CTSO5AMowYefIArNJowA66fksfOXdVD06rRwAn61d3ltbvs69hgzmw5QC+6Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr6foiPT; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr6foiPT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so6769595a91.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789419784; cv=none;
        d=google.com; s=arc-20260327;
        b=cC59cBw8JAxhLrb3N8HSd+4/SFZcJH0LdY4i+wUWMOu+4UfBPZx2+Cao95dM0WvBG5
         jNZAHk+QH8jZbBM5WyfIFKW20Y2WNkAIdkXJur14C9h4XkG2wVsQoqr3/r5oRZ6QmoEq
         RVd3l5rZ5e8ggQ7bxSBIrjktYlQnVcckmYnIZn1mgy6zYD7D2tVRwxVo++0TQP3FQcGL
         n8sTbuHw64F9suT31hb1xKtwmreJodmDYoMuZJbTIj6xUVrtk0g3LRLAwt6Hli0FnUMX
         mo7Lzwx/o9xnFZ84hL6UStb80DtgAVorkTjNRC5PgQPNefK0xF8ppkl2l6PIgM2l8SS0
         AmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=riaN4hZS/UPot0dC/2/kTznbgofvthWGK+p8JsaAblM=;
        fh=jX/El12euiQ1g499ziyGHKoTj/szcVkfmpUxd07P6mo=;
        b=L280SGEYsemYgIovPP69U2JtFTD1GnNoJlZFJsZAUO8PAizdBLLa9k596UEp3jnDoM
         NhA7ErQBZrEUHQEGddG+VpnwMRQFm5g6JGy4WooVJ4FoTT8q6kahDiJWEc8EyQTYQbf1
         CYCZaM+CBq0tr+kjdK7prGcs/iqloh357+iLwko+f5fXP4/98ACpFbRF1jPbd6mHWXWf
         ms68zHDVReMzwTeRsRLk7zEx6Wyoz5aUMm6TDOwo0BJ5bNA90G2b7ab+SKPEgQgWz5Iu
         bk75JPpyXFXhMNJ2f6zaaGP/4EGGboB98rnmi/67Y2WWrrQ1XWN28mEhOonS5Tlkhyjg
         3UPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789419784; x=1790024584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=riaN4hZS/UPot0dC/2/kTznbgofvthWGK+p8JsaAblM=;
        b=Mr6foiPTdx/MNimFwQP/1I/W4B1j03r6dRt5asL4CRbPeW42Dle0ukHVMvPqmGCCip
         8kZxytDwuSu/TZnHBN/pc8ID3RrUDgF9hf2uMyyl28qFzP0v0RLJxAOFOgaERuuRQfRc
         TKWniiwsQDGm7J4YwUa940zZPF9RSBrGDk8xlYJKq7z1gTgpFBkkiM4NBoHSUpz4FFiB
         OMsxLEWPS3FZj3Km8lueTtcIDyMTPlxc1kWlOnam99m6N0psdxnegNK24A7k0qjExW1v
         5x1E1Q9jkbndlArK4s0QUNl1YgEnsqiTqqMk99wUFrb9N9Rutny6TS31ys4QEdUjJ2tK
         proA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789419784; x=1790024584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riaN4hZS/UPot0dC/2/kTznbgofvthWGK+p8JsaAblM=;
        b=aAr+ougO3PQgfAlUZoA73YdGJXN/ZMTS7ZIDRukuyzRAkYBCdzJUT/py0JoNRE1fBf
         WNBu/KZBwmxXSom7h3FbA1nezh1oxXNya/96a4Y/Vkk2RmsbSmzUko42qPSWDv3gkrBM
         FiiEKkpPv8LNKAxaKHs1fy+Ti/bo353mtLcmVnfTVkl1pwnFr+iEwcQEhv6dlArd5RxW
         3l68d6YrIK34VATFReqiNAS2H1Vb/87b0T7aIt5CwcrBtXM2WvjqXx2EtB+tXOycl0bD
         cJE1njNSE/1VeZES2+w8TjnVi+GhlN1QPeW6etqkZbcI2NNgZV54VgIgF1lKJT6LHg9e
         KkZw==
X-Forwarded-Encrypted: i=1; AKwUvBwXW3cTVEaz/MDimIIgjjdSH4IJ0l22KRd9n16/czC6KFw/u9fZU1D35MgPktSLd4D+AiU=@vger.kernel.org
X-Gm-Message-State: AFuF++ku/fWKnZaKLqgRrIKJl5CS2ZX3aI3sT3TG+151ZbOsrGh4a41I
	p7IDgs23O3taECURVvLdqUpkjJdHOIKubEeBW+zRzmsjgB6FYGIodGox5gl73Dei2DCoswtvXFJ
	IFPzEipZTmNUZvL4hT3Cvk1k/0V1K2sE=
X-Gm-Gg: AYBFou0JGgXi+B+HgyQDlAbbtF8rR5ycp+Ebt79nl476pSqVLEB3DYOYBQVZMAxXHWG
	qOdR8r0R6cUTaqEyYwUeWKYs4pTy+64zBK40a1HD3RT5pBBo76V7jKgdJKjFwVt3/NAiLdvv3HC
	iNPoG8DTQlKUfvRkmGec40uswauL72gsvSZvLFoxkalDbSGDNvVm5s4aHCZ6x2rMAwJNhAAx4b7
	KGhYbDTxiYjRvM5mR3Y3+w0XM+rcPYog1NNaEMJIqkDZNEWpG49cFHO905RFGbv1qhHSX+/hRG6
	3n4W1cYFwAe19x0+EANyXf7Kul9/MjvWz/9lO288DeZI1fR53M+0iYLTbJi8LtjSvrpfQS8O9ld
	4a1IRKcHtrC8Icg72GFhBfImlDc6ig8U7nN+5hGloY4c45xEHteS9
X-Received: by 2002:a17:90b:4c88:b0:399:ecd:d68d with SMTP id
 98e67ed59e1d1-39dec0e0267mr8150189a91.22.1789419783499; Mon, 14 Sep 2026
 14:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914131701.2529725-1-memxor@gmail.com> <20260914131701.2529725-5-memxor@gmail.com>
 <CAEf4BzZjrWzQxaZ1kXyvXHXuUFDsgZe6NwQHH6seqfoMLpJLZw@mail.gmail.com>
 <CAADnVQ+SOswCXzZbCbjtjXQDd++Zkrxpg4k3gHMsMPsN9BRQEA@mail.gmail.com> <DLFBY0XAL5NW.33SRTMMYCWJHZ@gmail.com>
In-Reply-To: <DLFBY0XAL5NW.33SRTMMYCWJHZ@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Sep 2026 14:02:48 -0700
X-Gm-Features: AcwNN1UHdHP5f_aHlpDLP9t4celHa3xijbL4B1U1BkXyn76YSo68UkLZrWj5pO4
Message-ID: <CAEf4BzZ9S+xCAXrzOeYCRJK-j5irjfuRqxWWTPAK3VDvaoSTPw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable instructions
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:42=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon Sep 14, 2026 at 10:21 PM CEST, Alexei Starovoitov wrote:
> > On Mon, Sep 14, 2026 at 12:54=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, Sep 14, 2026 at 6:17=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> <memxor@gmail.com> wrote:
> >> >
> >> > check_subprogs() verifies that each subprogram ends in an exit or an
> >> > unconditional jump before in-kernel CO-RE relocations are applied.
> >> > An unresolved relocation can then replace that terminal instruction =
with
> >> > an invalid helper call. The resulting fall-through into another subp=
rogram
> >> > breaks the CFG invariant used by postorder and stack liveness analys=
is,
> >> > which can write past their per-subprogram arrays.
> >> >
> >> > Handle instruction poisoning after the instruction has passed the sa=
me
> >> > class and operand-form checks used for a resolved relocation. This r=
ejects
> >> > relocations targeting jumps, calls, exits, register-source arithmeti=
c, or
> >> > non-immediate loads before they can alter the control flow. Keep poi=
soning
> >> > supported instructions, including both halves of a plain ldimm64, so=
 an
> >> > unresolved relocation in dead code remains valid.
> >> >
> >> > The shared relocation code applies this restriction to both libbpf a=
nd
> >> > in-kernel CO-RE.
> >> >
> >> > Fixes: efcda22aa541 ("bpf: compute instructions postorder per subpro=
gram")
> >> > Reported-by: Nicholas Carlini <npc@anthropic.com>
> >> > Suggested-by: Nicholas Carlini <npc@anthropic.com>
> >> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> > ---
> >> >  tools/lib/bpf/relo_core.c | 28 +++++++++++++++++-----------
> >> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >> >
> >>
> >> Kumar, can you please see if we can move check_core_relo() to right
> >> after bpf_prepare_btf_info() instead of trying to guard against
> >> malicious CO-RE relocation? I think what CO-RE logic is doing here
> >> with poisoning is correct, it marks instruction as invalid because
> >> CO-RE relocation couldn't be resolved/applied/whatever. That's sane
> >> generic behavior, IMO.
> >>
> >> The fact that this breaks subprog validation is more of a sign that we
> >> do this CO-RE application too late, perhaps?
> >>
> >> Also looking at current bpf_check_btf_info() logic, seems like we'll
> >> skip CO-RE relocations altogether if we don't have
> >> func_info/line_info, which is... fine, I guess, in modern world. But
> >> it certainly is a bit orthogonal. So check_core_relo() seems like a
> >> stand-alone step to me, which hopefully can be done very-very early,
> >> so that no matter what patching we did will be properly validated by
> >> verifier.
> >
> > Let's do both:
> > - move bpf_check_btf_info() right after bpf_prepare_btf_info()
>
> This won't be a copy paste, since it depends on various checks on subprog=
s we
> would end up skipping, but let me see how we can split some of the steps =
and
> whether that ends up looking too bad.
>
> > - check that relo applies to relocatable insns only
> >   and hard error if it's not.
>
> Ok.

let's also extract poisoning logic into separate function, so we have
less goto-ing unnecessarily

if (res->poison)
    return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);


and bpf_core_poison_insn() will be free to return error, if necessary
