Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794393172;
	b=Je1J4n5vzDxdOPl8NpWMRSOSy0SlepFq2MQIP80KHjiW2mFyGaI+Wz4SLM9jTPkQp8ax
	 cjpkxiZLTnPsHCMFldGa3eNdoEhPwWiU+U0Z7RRMQFDOxxLZhXmpzdLWpwt66Gv2kwhrg
	 GsaSvJJ0BrRVVXavB0QvOEbHl9PZx3J8X2fI7oQz4db5+rWMm3+eUhxsR3Rdto6sa5Lii
	 bKgmRVfzveYmyfZErTRk+H4j0y/DSO8+K3FfC8QTgtG3DvAaASOJh4pnQxVMtZviVj1Wi
	 b6U0bqotIoZNvSZ+txTMehQwFuf7o9zZKmRnOPRbAAY4aGz14R44pgeOy3s7ZG/ykoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=02bBnMozli8MiWSGFFGAt1jIgOdeJZMOgr35PuI0WZ8=;
	b=i03Ptcf5jX4teUvW/I9ZvyUXC0It7dPiNf15CaQRFcEi/9vDc/g4TSw+I+86UZXpGFaa
	 73KqAhZGHVVoj5WSFathtrWiB/htrYBJIcLtQQAYc/Iuq+dW3BAuog80zqvTqZB2avtCo
	 4gePndRcpH47LZDhFrdN/20jVWx1OpvjHjBZsJv/lrjJfR3WKR0dFy2zKJUJJkJAjKa75
	 D8w2v4RT08dx15P7vBMD5iP5VCwGzdpViwUudcubsWcWq5NSqUJxXidbYIGKJMgOF7fBs
	 Rht7QbrSzc3qT6J4dtsaIOt/pTv3uyRj/KvDfpbjcgNtKE/QdywCk2BLR4Rc6a4a7XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kOKn4s7s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E6606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 684E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kOKn4s7s
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67be1e468a8so2284811d50.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:32:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794393171; cv=none;
        d=google.com; s=arc-20260327;
        b=fE/QfJbnShxNLY8uY6I8LVuIBtJdcaudbLzl01JbnFaSJnMjOMmQVTi7OldLGLN7T1
         dhzvF5D/1k5Q8dS0FHYcPfbpMx63zuIcPy+GZsuNKooqlZYFZ0thv58+KUHwwCIK7tvT
         y9IWhggf3E4RWetIjOI3ZUDr9o2Yr2fwZqiHXs3goQGBKDhGylEWAf2fa8z9GSieWpA4
         rTkgEeAdf55cc+hXYUuSiUgvfaUVRH5kxYd2wpxocuH9U6qbq6f6hkXW40Bj1loHkFES
         /o++0F9RypRpa6FJbIqf6q7dDmK8dRgWlACaITP+EW5Nq6YJdlxxZMwEYSRCm/Vqg9iH
         nTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02bBnMozli8MiWSGFFGAt1jIgOdeJZMOgr35PuI0WZ8=;
        fh=kGwa9FnHMXRuQISYUMDCO057x2Hh8EtdT7WW9AwFV8I=;
        b=FwvCT7Wrlr7f4LWSdzKI4BSd73pqb3Na1yuPeoKzmGsO/4+qaC083y/aiNsFoP5pVe
         dymO8s/yMzFEaFXjw2msWUgwhZPR+bCk5kz3Mk6FHJLZCxFqDudUyvpdnKjDN/fONfV4
         cOzUgmMNjGhn7xsLUfbJspKNZYxBPq3chmF7779D2MPu/kU0odwAg+wskTpKJKDScUst
         fpcUZPRZXYiQbksYel628VoePs3A9YpCFsC+eP0eFp7sEDGPqUYcVI/8iTUwHNWKSeT/
         R4RJlFuULDRpQhfdUxY2cTVeLJZ/DAG9t2q0LTRmu9cp+TEX5kX3FwK9/wZrFPzpvY46
         jqhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794393171; x=1794997971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02bBnMozli8MiWSGFFGAt1jIgOdeJZMOgr35PuI0WZ8=;
        b=kOKn4s7st+0UrDWuAYbFD3mtTNdrCVTRR8+85TqjA8fiP4ltJ7AHQigaHvo8xxhwUO
         nPYpl1wTPtgTKILmEFdpmVyEesy2bAQR2kiEXQNhEGX4UVwhDpNkzPYFQckb74omhcA2
         X1XNPUzOXuNY9DIuoBxr2mK3379AeWdWkrB3rwjJai5L+BTR7bNMMmYKJlgyXL50pOVg
         VcbHXMrQrXuiMTtSQdaQiy3Y8VYMfDvwYKyN8CfyttDu0YIPbAoTE5Ly/q+8vZc3chU6
         pSmsg6om2foGmEAapoyuEf0j8YZfLsxS8KjemDsyhn9rM/BkHNG0PQ5l3ogKQFE8TdNt
         9KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794393171; x=1794997971;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02bBnMozli8MiWSGFFGAt1jIgOdeJZMOgr35PuI0WZ8=;
        b=YlsrnAC87ypjW3ko3uPNnG1ztQRFD0sOI+d+QcuQGNlHYoCrR56y73JZERGqNUaMZc
         rf65LMUCL4/eh8bXmkAb5pNky5S6EFdS9miZRuNdgtP/qt/+KORFIak7K46VVJ0C0MB2
         JjJ9Et4z0F3DYYevzcEPDuozKigCUgS38L4vUpllXatMBEVJfgx7eBL0I4PUzi0IIf0f
         J7lB27dqPd5cJBjIT1LLZWshwAIy5N63VZyg/TZOFd/Nx9sY9vzLd7KZj+PqU2Tj/FvU
         Mf74lh8z7+DJmFF+Bf7tYMm7Zrewgdz82aSxqVmQpAtmFg0xkmREjWZ5onKSis1ZIoaZ
         Tifw==
X-Forwarded-Encrypted: i=1; AL+hErHm5nW9yUNEpfMjW4b/G4IBytZKLOr25iVwdMIeuwA6JfFIkIGMbnRULi5Phvhd+J2iyY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZUvWQDPVZN5dyOtR/TPXvBH6zZrM61Gp3ks+VupI0MTgMyZYH
	iR7wY24VKLPL4HLJDQLBLR1GZ4kWXghm4/dsAcowWfzh2Ma9YD8SE5U10Kq3IfRKiJGK84qSvRE
	boJAdBOwhksFMVcZ/f/SPMc2GrCVrIvk=
X-Gm-Gg: AYBFou1hh69hYKsbz1tbbSfhyU0kVs1w8ECL/bdGVZsYkaTc7D5eGR4R2yM3mygfV3F
	MSJKgeCPo3iggbRa+TVG25cZaG0n5SFE2oOhBEWw8IEIo9iY65pjPgmhIWYXKatR6S2rPbqfg4P
	NYgynVWxX3oQ4TGN5iwvgriT8/4ivbgK+5BTuPs23T9ZZDOcRfRtEqIuHqELMWkHbouygpDvVD6
	JTGNt6Bu8UB9CAM3JIqGLIqwIB98isDrfr/Uk8yumtfszsKF8gklQbIggzPSvs1EJNBcM+PWWOX
	o6WnwMeL70MOwiVmv9gukj6r4qS6VWzEaPf4sqCm9JSCNxYCnqy+zA9gzLytdRH8nDw3BSPf4i6
	ltyO5KKUBggbsqf8iZF7Km3gI9oJZ31vsNBLf0M6FwqfV8FzZJQNSpxQyk4g=
X-Received: by 2002:a05:690e:d4b:b0:67c:1c64:45e9 with SMTP id
 956f58d0204a3-67c680625cdmr1508099d50.101.1794393171367; Wed, 11 Nov 2026
 02:32:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110164046.454431-2-a.s.protopopov@gmail.com> <08e4851ff6c0fec6c90ae269b9edafedafdc5ed0462802fe1c1dae6aef465696@mail.kernel.org>
In-Reply-To: <08e4851ff6c0fec6c90ae269b9edafedafdc5ed0462802fe1c1dae6aef465696@mail.kernel.org>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 11 Nov 2026 11:32:40 +0100
X-Gm-Features: AclHuK_GbxvTdlzc2_hr4epNElrWdws4BUJQsklCjuLESJeU9114xBRiJsDQXd4
Message-ID: <CAGn_ityGqppNp6AeCH8m38o7k0=+syWpoMQb3s3iQBi+cL0wxg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/18] bpf: Add BTF ID sets for fmod_ret targets
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, almagui@kernel.org, john.fastabend@gmail.com, 
	qmo@kernel.org, brauner@kernel.org, kpsingh@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, sashal@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 9:01=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Add BTF ID sets for fmod_ret targets
>
> TL;DR: Comment nit only: the BTF_SET8_FMODRET comment (also in tools/incl=
ude)
> says the set governs fentry/fexit attachment, but non-sleepable fentry/fe=
xit
> never consult it. It could mislead readers.
>
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
>
> [ ... ]
>
> > @@ -13,6 +13,12 @@ struct btf_id_set {
> >  /* This flag implies BTF_SET8 holds kfunc(s) */
> >  #define BTF_SET8_KFUNCS              (1 << 0)
> >
> > +/*
> > + * This flag implies BTF_SET8 holds functions which BPF fmod_ret, fent=
ry and
> > + * fexit programs may attach to. Per-function flags: KF_SLEEPABLE only=
.
> > + */
> > +#define BTF_SET8_FMODRET     (1 << 1)
> > +
>
> This isn't a bug, but does this comment describe the set accurately?  It
> says the set holds functions that fmod_ret, fentry and fexit programs may
> attach to, which reads as if the set controls fentry/fexit attachment.
>
> The set is only read through btf_kfunc_is_modify_return(), which has two
> callers.  bpf_check_attach_target() uses it for non-sleepable
> BPF_MODIFY_RETURN only:
>
>     } else if (prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN) {
>         ...
>         if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
>             !check_attach_modify_return(addr, tname))
>             ret =3D 0;
>
> and btf_id_allow_sleepable() uses it for sleepable programs only, and
> requires KF_SLEEPABLE:
>
>     u32 *flags =3D btf_kfunc_is_modify_return(btf, btf_id, prog);
>     if (flags && (*flags & KF_SLEEPABLE))
>         return 0;
>
> Non-sleepable fentry and fexit programs never look at the set.  This
> remains true through the end of the series (6dc8474f6891 has the same two
> callers).
>
> The commit message ("the functions BPF fmod_ret programs may attach to ..=
.
> KF_SLEEPABLE marks targets sleepable programs may attach to") and the
> resolve_btfids header comment ("the targets of BPF fmod_ret programs")
> describe it differently.  Someone could read this comment and add a
> function to a BTF_FMODRET set to make fentry/fexit attach work, which wou=
ld
> also allow fmod_ret programs to override its return value.
>
> Could the wording be along the lines of "the set holds fmod_ret targets,
> and KF_SLEEPABLE additionally lets sleepable fentry, fexit and fmod_ret
> programs attach"?  The identical comment in tools/include/linux/btf_ids.h
> has the same problem.

Yes, I will fix it, and send on the next occasion.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/429818=
85558
