Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612483;
	b=uK+KzxgCn2HRCUPNr2e18aQFn57tLsWWby/612JZjDV4D360BS0DYAwRH3TRhQY3dvkz
	 IIU5VeIVyc0Rp2ae8DpGITC/xSycMO6iCki6DR39JJKNJK81gKQL/Rnms25Rt8UtvYhrQ
	 0BB4scr6O7QzJSTdvb7U5Ejzvdgufl9FhJPkuBayKew8XOi/+qlau8ThGjt/r+0S6HjWP
	 4HHv0z2gYJyjQAgS5Q9D0sVbT1S+ToU2KKjF2+OUDCg3I6CFbzyRx4uoimxPseDKJEp41
	 ttPteu57Vh1luk2LyOKkxPP1wyMgaLLXo/9HI/BvbyQzp4NN9tySNlbtd9+KznpaYew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8+UpSrIIh8oYZoaR+fE3t/cM+ncQILEW2maZ4p6UL2U=;
	b=YU6wlnSzZRqbQbVbutlXF6uAehh+wNUfA+N+Gb0Fo9rE0suYibJVAEZew+TlsHTbea7w
	 HFVQpBok5xIlgsKh8laMy+8F1cY3HWRkMLJ0/H23othN2zobJtOjbafswdLTP5LmLubys
	 H3Yho/pZxbzvwokxbR+sZm7JKfg47kPmZP9Gv/CBEQ05wzxL5AUbgFkeWNN9HdYSgrlzO
	 NH4UcvjfM9dKKiDY3x91AjoTHdvXlquEVVA+AaJLxPq0LCBMc57127D1xX99DqqMpJHJL
	 whvkOLooNgJD8x4E2YcETv9BWgm+I3NKONikIVmCoenerIfkaz8dCN7k9iMuq0Jwi4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xe6TBrCd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6B606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD6B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xe6TBrCd
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67db3a48dc6so6787184d50.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795612482; cv=none;
        d=google.com; s=arc-20260327;
        b=p53aIqkJ/o6ur7sqac2skEfFoKvJNrR2snPCkHHNCEhDbdY/06i1ZrEpCk2/oLYuYx
         laLH7rBJRaFwq86amgqhFFKh78PvR7GDfTjZqI2QUN1MFpPAM4Jq3ryULaFvTk7lIIxV
         OL5fIe2Xw8n/ZY/JogM7sZB9gcKeLm+/dM+FnAPcQmbPCYkcP/E3GAIXZc4Dy9laPKgk
         N6gGxL+Tj1qelX3YBmdAhup/V3zMfPpWj2d0sCy9J4oJO8Rb4RKtevgX0Or6UE4vsdl0
         GQ3mrg3qlXH8RB5yVr9rLSKTsQYXJBlSKM5ik0wyqXEaf/kl2hnheaCx81liwL4dp49S
         WF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8+UpSrIIh8oYZoaR+fE3t/cM+ncQILEW2maZ4p6UL2U=;
        fh=CUUZZQZp7HtZ+zx8K7DwZ8N3t8eKuelmuh7pjlKd1UU=;
        b=HdwQXRKIL/Cy0Ynf0PjFYDZ//T8trwP+eQ65Be0nPNuor9dtQu5QTk7Lh/KbqxyDa3
         H49qf9jn0VhQ31actQ8hYa7YRPpOCnS6m3iTvMI5IXnNG0makIOGz3i1NJ7CJ/4/yaHB
         SoUktqukdJIUctox7XcXuRGjcCVRKAEKwAmlR92TehE6MomT0Q6UmrlSOS+rvR6Bbvo0
         uoEe0FL68zNCu7dF6jVE6QfIKSVqK3u3yrD7RLn/IjhfxAqdQvcc7XKC7qqv8R8red21
         sT5oMlN9euv4IVm3QdaXsO+u3EPnKoqJrb/yD1NFPwhm9Av8mk4JH2lctOErBqbuMCG4
         FBsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612482; x=1796217282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8+UpSrIIh8oYZoaR+fE3t/cM+ncQILEW2maZ4p6UL2U=;
        b=xe6TBrCdnueQe1Bxi3UxN84SJa9EjbiTLY5EbP2pkinwdL6F4wePexAfI/MB8Q9Fqt
         7K7gN7m6+lwjPdcNknY/ulAUWHTsMLTBuxMX7AT3I+owNQRqbI9byMsTDn/RZfZP7Q+Q
         Uj1gTkQxIvAfR7vD3ramYWPcCJwK4jHNXoTp1umXw1R1USdBtZ8jWixV7OL0OFgez3jl
         t/NKxGO7EhJYUagiUMTlhHiY2ULuLT6AqXYldWT70LV82TeCz134BTUkuqf7uZZttCnz
         SwWlGJQ4w9wM+Ld+Glhl5Mny8cgGyuutqRlI+MUNFDJBFUSsI97GfBtFcd5ilq1MDxWL
         Sd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612482; x=1796217282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+UpSrIIh8oYZoaR+fE3t/cM+ncQILEW2maZ4p6UL2U=;
        b=uRESgBMJzzZNwB8fIWeuPh0b1MEHoHqZoEm1kT/oCcM9mlavhjuFSrCchKsoWHrIZm
         qO3So8c6dLQol1gtpGA8daEfm9KlhHccraCnBt6TnPkQKRSv4DLRzqKw8yhWnqKeS+w0
         Jokprq/uteahZXVnbooNtK6YkhVfM9eeXlHYL1BZvtR/bkVbfWf9OlfSio1XLUzsPTVu
         jL9rcNR9nRzWATjJijtNLILuNkmVI+vxzfM9RLqEzyO7dCTm62SvXTYJqp2bXNoYlJmX
         jnR9B1Q65mMeywqSmQgzwi94BoIs8bqdlMC4SakcHzUkDWbDpKjjB0EK3oqFVkzVgzqd
         FGuA==
X-Forwarded-Encrypted: i=1; AL+hErH7XD10moSgdL9dAukwgJ6PcQ/DKtLRTdF+dr9aCYaBPTUwOf2vZHiWTV2ihaMb+be9hi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z8Ebm1g20pGW2/jU8rucWOKX52+bx8KwjZ8htc5iJ47dICwkP
	Fg7kXuQ/8ZixgZcXiztTI52smbcu6N1jrDC/C0KgmxzsoTU/KFsiGLP3+7FqOdDS+WFAiudeYJp
	jafOuN873tpYEWoQvIiZixNCTIvj1RX263QGoaBo=
X-Gm-Gg: AZFdTZcX8j0KE91n8AzJzUvyZUJ+zSjy34Bs5gr0FOSl39Ov2i6JGO5ebB4XCcMPypH
	EyPTJmHi8Wid5uhU2fMHKKGRUBGXZEPwQGWrgNgDIcHe6YqA1V6ALC8kCGFsNj4QG2FVuCoTdE1
	Hv+rgUi/C5+8QK8NWZRZmdfkuBawl8ZUB6V63k9+581NRgBj0eLDqH9syTQE/G/KM3A1DHDMHcg
	gzEOzaeTXgQJtzwMR2F5YgPZsoiWxr7fkR8J3yTSqQVrU6IHkhe1cAgqqq5HyieKkV7dvux6/4N
	7U34/uPvvu5qVmo2VJGXJwzFwtU43rWG2E10Szqt4Zd9qw+Eaagxbc845XvAN5EvFQPIdXHetBS
	cZ8bTBrHbYJbXkv69K9+kgeb7YTejbpZs6uxqMgQ+swAn66ze447FtQcwr0giz3KTq3I=
X-Received: by 2002:a05:690e:d4a:b0:67d:b0df:9095 with SMTP id
 956f58d0204a3-67df449010cmr5025992d50.126.1795612482300; Wed, 25 Nov 2026
 05:14:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125102810.699464-4-a.s.protopopov@gmail.com> <9c0a23fb1309d4e2843bcbc1bca80b4c553880ac4e73f19dc63e461829d611fa@mail.kernel.org>
In-Reply-To: <9c0a23fb1309d4e2843bcbc1bca80b4c553880ac4e73f19dc63e461829d611fa@mail.kernel.org>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 25 Nov 2026 14:14:30 +0100
X-Gm-Features: Aa3M54p844JgvYCwGHcvbhCUF729MxwT887kzSwfO7nKl79_NEeYmUxoQR4gxcw
Message-ID: <CAGn_itz052DgCmMvf1ckDniJvcHtQ3cMg-XF-dxx62scYBh1Vw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/7] bpf: Allow only NULL or ERR_PTR() from
 fmod_ret on pointer functions
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, almagui@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev, 
	mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 11:47=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Allow only NULL or ERR_PTR() from fmod_ret on pointer functions
>
> TL;DR: The new fmod_ret pointer-return check may be bypassed by an frepla=
ce
> extension of the fmod_ret program's main function, so a non-error pointer=
 like
> 1 could reach the caller and be dereferenced. Not covered by the selftest=
.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -19762,8 +19764,19 @@ static bool return_retval_range(struct bpf_ver=
ifier_env *env, struct bpf_retval_
> >                       *range =3D retval_range(0, 0);
> >                       break;
> >               case BPF_TRACE_RAW_TP:
> > -             case BPF_MODIFY_RETURN:
> >                       return false;
> > +             case BPF_MODIFY_RETURN:
> > +                     /* An extension replaces a global function of the=
 program */
> > +                     if (!aux->attach_btf)
> > +                             return false;
> > +
> > +                     /* Allow only NULL or an error pointer for functi=
ons returning pointers */
> > +                     t =3D btf_type_skip_modifiers(aux->attach_btf,
> > +                                                 aux->attach_func_prot=
o->type, NULL);
> > +                     if (!btf_type_is_ptr(t))
> > +                             return false;
> > +                     *range =3D retval_range(-MAX_ERRNO, 0);
> > +                     break;
>
> Can this restriction be bypassed by an freplace program that replaces the
> main function of an fmod_ret program?
>
> An extension verified against an fmod_ret program P gets
> resolve_prog_type() =3D=3D BPF_PROG_TYPE_TRACING and, in
> check_attach_btf_id(), expected_attach_type =3D=3D BPF_MODIFY_RETURN.  It=
s
> aux->attach_btf is NULL because bpf_prog_load() sets dst_prog instead, so
> it takes this branch:
>
>     if (!aux->attach_btf)
>         return false;
>
> and check_return_code() accepts any R0.  env->fmodret_retvals is also NUL=
L
> for an extension, so check_fmodret_retval() does not run either.
>
> The comment assumes the extension replaces a global function whose result
> goes back to P, and P's own exit is then checked.  But
> bpf_check_attach_target() also lets an extension replace subprog 0 of a
> tracing program.  That needs linkage BTF_FUNC_GLOBAL and reliable BTF, fo=
r
> example:
>
>     long p(unsigned long long *ctx __arg_ctx)
>
> which btf_validate_prog_ctx_type() accepts for BPF_MODIFY_RETURN.  Only
> fentry/fexit/fsession targets are refused ("Cannot extend
> fentry/fexit/fsession"); BPF_MODIFY_RETURN is not on that list.  At the
> end of bpf_check() the extension's expected_attach_type is reset to 0:
>
>     if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT)
>         env->prog->expected_attach_type =3D 0;
>
> so bpf_tracing_prog_attach() accepts it, and __bpf_trampoline_link_prog()
> then pokes a jump at P's bpf_func entry.
>
> For example, P is:
>
>     SEC("fmod_ret/xe_device_create")
>     long p(unsigned long long *ctx __arg_ctx) { return 0; }
>
> which passes the new [-4095, 0] check.  E is an freplace of p that does
> "return 1;".  With both attached, the xe_device_create() trampoline calls
> P's entry, which jumps to E.  E's 1 is non-zero, so the trampoline skips
> the function and returns (struct xe_device *)1 to xe_pci_probe().
> IS_ERR() does not catch that, and the caller dereferences it.  That is th=
e
> case the commit message says it prevents ("The caller of such a function
> dereferences what an fmod_ret program returns").
>
> The selftest added later in the series (c210c64e053c "selftests/bpf: Test
> fmod_ret on a declared function that returns a pointer") only loads an
> extension of the non-main global_func(), so this path is not covered, and
> no later commit in the series changes this branch.
>
> Could the range from the target program's attach_btf/attach_func_proto be
> applied when an extension replaces subprog 0 of a BPF_MODIFY_RETURN
> target, or could replacing the main function of an fmod_ret program be
> refused?  The existing fmodret_retvals check has the same extension gap
> for int-returning targets.

In a parallel series a patch forbids to freplace fmodret (and LSM)
progs, so this doesn't apply anymore.

(And, in fact, this also failed to load for different reasons (BTF
mismatch on load).)

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/455951=
81490
