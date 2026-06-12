Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC23D0C00
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305152; cv=pass; b=EM7jbCfa8ZQBTcTS8w4NUCGl8C4Fh9+84IafYlZSRuq+K/xM4xqpVSUbuMGFCpKHmdbJdEgVefZ81bWAnWZYFYpIXd3ODbP5XrnU9vqIAGLGOajrlMA/xJTwfkWtSaDgbAJuP0G9NqCbnxI0G6oc5nu0/iFB235gfuG1Z5fMBAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305152; c=relaxed/simple;
	bh=+ST1k0pyym2NatbWfqX8fttcjv/E/nGS7iP8gVgJvTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM3bekDj8KlokyryDpY/lAMKhT9cKiSS7ehEMl3iCRw7S9px0NnLaID6skDKFbG8k/n31dexFExKk/KV/MCIYIlri1wgIMWkUZSPNi0e01sboqlaBG0jt14zrS90Hw2JcwxTHYO0lZzo1d2j6vXl3ANA1qI7WzQski6H1a49fFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNTfwaTZ; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNTfwaTZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51776b4de37so12613831cf.1
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 15:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781305150; cv=none;
        d=google.com; s=arc-20240605;
        b=jBbN27aXqhznmiVKGJbRKJZ0skmKlwNXYkwChd22IVrRx0djOLqnOhSDBS7y6GfGXH
         VyS/TuH+XaBX1CDH5IyxBGE1GZr6v9ThqxtGRwZqq6a3I+IHwQ95Gs4RijqnKZV+qb4L
         +N2bcmEaPz8rYds5pm2Kc774zRyUXaKQi2ZXi6OMFEpMrakiOmv7re93Uq1lIcqI2bb7
         tuG0IDHOF+H7RL5Hz4GPj5Zr0+LYE6MFOOc4UfFdXRhF0hNSdEPmy+UAtbsWrkXuPIdr
         tNy+QFMnYlQ52MlERGCPVnaQhKqIcNFQS5NiBTVewhiTzxPqfK1h7E2F8wmT0siUPS89
         D5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+NFLecPAKu38rb3b3Li0gGWxRi2IeB04bipAEb4Brqc=;
        fh=9MDHcPm9NFMtP/q7kRLGuyPc+G+FOmF69VI/imIgD5w=;
        b=dNvXaGkjaMJg8lmJb/Mc7kJKVkxkudZ7O6NVebC0cvbl2dlu/F+gIxo83cTnpF/kkr
         KyTmv7+a7xyl3uIeTITVS4QsPh0Ro4gP5TAXXc4U/mT7BSbwUpLrKvU+YHvNebF4BVdo
         hqHvUlov9LxP32Be3e31v9YmFRnj6+x3+Dh2gPt6uCbUOGGi15mEp48t/0FzU/DsZBhk
         C4smVeVBjOXuyLLZAaiSCe+yB+QpqzZVsE7CwBSYU4VetgxtC1dSLe8V35ksbryDgCGD
         kr9f3RywiVhuf1bxLK2EZCjNG+TSeqK0+uEqhcomr8RbGeZUhWAbrDrDXTtyNk51ckSd
         7+6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781305150; x=1781909950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NFLecPAKu38rb3b3Li0gGWxRi2IeB04bipAEb4Brqc=;
        b=CNTfwaTZ6hPOVHTZoGZwsd2VJ2RKlPWAsgsARXorcHBVr0e3zh7DLnkOnB780G1Z8G
         jxdfX5L4JqDg/GqlaRma4mvTVidqAwQ5TDXoH0HAXTsQAAUQ921i9QfkvJGDjgfs32Pc
         bmODk5ZEC4B0sJYhZdCiUDrwjNhdQUEgTqu9fKBT4Ag5t+qlHYt/wuzmZtKUpDIXwpPm
         uNr/A+OqLwdfTCJO4UQGl/itvyyXkozhFquWukz9A00MidRp9DQ6ZCznsQjUfjB4vZ22
         2hiB4mqifi5jkJw2YxICl67RnuRNvhV2hS4rOU5sOwkwuuzsjcLCzBK7vkHkdn4IjZh/
         dXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305150; x=1781909950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NFLecPAKu38rb3b3Li0gGWxRi2IeB04bipAEb4Brqc=;
        b=lupqu2wu1+H0hYeA9Vu48taAvXnNeHmQCS0PgFIQHzGuGUHOmNuFOauXaj6U+plZm4
         5PGfkjV5x1zeJft00cu4NlWAW70z5hcKF4RojLchq2hKl7J+xqp8QTwuewm+g8ORZo6P
         Ap2eEy+TyS+6XU7VHrnULBkObTAaSEBwLXCReIO33IBitUoDI7ljHWvADu/B62MyMWHk
         8M3LiAnjQ5F0HAFZyBj8Xl77xYZb24OWsUvzOi4bZXn2tM90Yg8B3cmtPYgoqZwffBIy
         evY8ZXXLHHQLPZ7LGTGCTzXbHBnHMvjtpBpZ58yMPinuTtk4uGXOyJ1Uz7m85fJHaWWg
         3zdw==
X-Forwarded-Encrypted: i=1; AFNElJ/ofPLj3FWmXkN/JqP/CHWdPZkCiLTsCsOD03YMZBGh33zS4pgjjeofybvYD8pQetRJB4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZMTm9y6KJSzi8kIeSjDZg+todT4Sxitn/4sey7/b0torc6sd
	UTz6/Qa9FA0HH6+xP/SHjt78Waqr9G2qyVFeZTgHnO2sMzsPpMzA4/wuSiadrt7eRhEfjsHBSCP
	El9v+X97kV+PxTX6LtGN4oiLKpztb99M=
X-Gm-Gg: Acq92OEQL9Ce7qyA9HQ+hdeAvZxUzx5JWeY9dxktNpqTnU/rqAzTrpEX/+od5wuG9Ye
	eeVZfN/Hrb0NUFInp6nP06ZwTUSGBn2fCzGMdLzY+3Sd3tXs3IcVtLbjvZjSKLtPZHHDJiXHCZP
	MfrKPD+FTGrtvF5ZZcwqtzVd08b0jnZEg47w8qsCO0tDnGb+LEpcmcs1tX1PADfUZ8fpAwibboh
	KvMWyKyFJePnEhEH4ldXZ3Kd/SBvDwOeLukK5hn48S/DiBltbwM+Fvoa7t/15R+IoCY/pQ3eKpl
	tL9XXNN9xnuB14lRCAZO1G3fhbs2BTwgCQGrxlAM4S3Q/oD0rV5QK/rvrQu+N6W8u62ClvO5nCs
	YUGVxgvrs
X-Received: by 2002:ac8:5750:0:b0:517:9e57:c681 with SMTP id
 d75a77b69052e-5195358292emr27403981cf.53.1781305150238; Fri, 12 Jun 2026
 15:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
 <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
 <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com>
 <CALCETrUArQBzUS2mAhYxDS-unze_gnQ7efv1qeBke-ux=2KdkQ@mail.gmail.com>
 <CAO1UbGcJEhwtHcxy5zcc8cH=YjfSDiDa2o-o8o+LMbkmL7WFcQ@mail.gmail.com> <CALCETrXrAs5R_u-Y=1qCg2PvW=xx=hMZovBBv9UmKPkVCedv9Q@mail.gmail.com>
In-Reply-To: <CALCETrXrAs5R_u-Y=1qCg2PvW=xx=hMZovBBv9UmKPkVCedv9Q@mail.gmail.com>
From: clubby789 <clubby789@gmail.com>
Date: Fri, 12 Jun 2026 23:58:57 +0100
X-Gm-Features: AVVi8CdJPu5BwJxrQwePbiiuyEBsOn_03DZWSuhQlpjvZo8ZrOMDgD5d495Itt4
Message-ID: <CAO1UbGcO_mNvLO8gMzGMWsKaW2qytnVit1DSFFnO7d35CpWQCw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
To: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 11:37=E2=80=AFPM Andy Lutomirski <luto@amacapital.n=
et> wrote:
> > The filter
> > itself is also rather complex (mostly due to needing to account for
> > BPF jump sizes, which differ
> > as different configs (uprobe, uretprobe, SECCOMP_ARCH_COMPAT) have
> > different logic., and I'd worry about
> > keeping logic synced.
>
> Perhaps you and your AI could elaborate?  What are these jump sizes?
>
> In any case, I think the actual issue is that the STRICT filter's
> failure case doesn't quite correspond to any of the FILTER actions.
> So maybe it's too complex to be worthwhile.
>
> --Andy

The filter as implemented looks approximately like

load arch
#ifdef SECCOMP_ARCH_COMPAT
    if arch =3D=3D compat: goto check_compat
#endif
if arch !=3D native arch: goto kill
load syscall nr
if syscall =3D=3D {read/write/exit/sigreturn}: goto allow
#ifdef URETPROBE
    if syscall =3D=3D uretprobe: goto allow
#endif
#ifdef UPROBE
    if syscall =3D=3D uprobe: goto allow
#endif
ret kill
#ifdef SECCOMP_ARCH_COMPAT
    check_compat:
    if syscall =3D=3D {read/write/exit/sigreturn}: goto allow
    ret kill
#endif
allow:
ret allow

The offsets from each instruction to 'allow' will differ based on the
presence of various options.
I came up with an approach using an enum for numbering each step like so:
> enum {
>   SF_LD_ARCH =3D 0,
> #ifdef SECCOMP_ARCH_COMPAT
>   SF_JEQ_COMPAT_ARCH,
> #endif
>   SF_JEQ_NATIVE_ARCH,
>  /* ... */
> }
> #define SF_REL(from, to) ((__u8)((to) - (from) - 1))
> static const struct sock_filter seccomp_strict_filter[] =3D {
>     [SF_LD_ARCH] =3D BPF_STMT(...),
> #ifdef SECCOMP_ARCH_COMPAT
>     [SF_JEQ_COMPAT_ARCH] =3D BPF_JUMP(..., SF_REL(SF_JEQ_COMPAT_ARCH, SF_=
LD_NR_COMPAT))
> #endif
>     /* ... */
> };

But I'm not convinced it's entirely readable/maintainable.

And just to be clear, I'm not using an AI personally; I was referring
to the Sashiko review bot, which I've now realised does not reply-all
with its reviews.
