Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC67342CA2
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772603916; cv=pass; b=BoxJC4NYrOldFM8HGdgNg9V3NBEVUac3JG8jVm3tGk+zLGPUTtlCA6rAJziOrlOzeNWcMPO8kuHDcymJtkrWgP62HSvJ5vX/eTc3SKwzcurqUW+S6U1f20f4GN+UY2RMRCCTznLy7i9N2G9VmmqD+PFUUdZ9nvVhzCgnITFo108=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772603916; c=relaxed/simple;
	bh=/NX7IFwd1F4m7lXUlgO+wNI5t2GEUHSg21WBVXnVvIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUoYNspm6TSCtMTZCMRMMqm6ghOE+zLVQRoyKPLP+fUA3qxaHMCr7rIaHNr/ae8PpGrwGOYgLr1yeIKZlf1qaBamC3xfofHbm+qg/ZeA23dGh08+MeaNr9d5vLcWjU+witm6c+vJNiVwmcyRFbrJs9cGGGoeQYzqzd5ZUYo/9uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epgCOWwq; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epgCOWwq"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso56875245e9.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 21:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772603913; cv=none;
        d=google.com; s=arc-20240605;
        b=LClDsjrRn3NxY7xPRIPJ5IIHoXlhVICMgvpQP2pidDzlXfiQ00VbHB2hmfGSNdmGXA
         H2Psc0sk11PqmWR731Nf82U/ySnjjit2Ots5135d6dOhbiPww7Ho1wkVR5qKepSBim5u
         qCM4DmE3EcPP1Uyfs7fmYOdHmk+3wGXth15Yo/Ki6mjKWvC3z1Y2jg61K15E6Gi2B8eZ
         sJ+OwnqwBmRGPu6hLPm2qVgQEl0MFPdbjMuOKekQ10HBLYb1YZOYFkmi0tmpdsXyqq4+
         reHrLYFXR8jDgMH8gAkCJbxEt/8wNcjcxl1M1en+2ZJIAFrIa6+ApyzPRcd0Cb7npD8X
         w1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpgMwZZuaK2KyeVm1P5Jh1Jm+p04rBkurVuB64xnmxc=;
        fh=Qwi4bkM/TcZNakyBIOP2hHL6j49r9ebjziY5QnZErxA=;
        b=AS9OZWHRtDwRFIbLGZip0n/OHPYvA5TvhiugeobcAEPLusnO5txSr5XnA3gYYnuChj
         mN5ffakVwYca66cuBJmvpwmXWO7oO7D/TyeN1TaFpcBi+rpXh1nP5JydkYKdF497xagY
         zJwktpZbl3cQ20W/xo1Eb+IbniekpIVTEfvf7PrY4QfYQYIo0FjZIdRp7Fe0NUTk21TE
         SyOIzG0oEVJIH+xiuhYCR8zKzKz4UQHD2wgIwJHfvk5a3yeKELhjo55Mu6Kbn8xl1HQT
         8ofN365T4rbpZ7GccJxnlKLUq2O8jMrq5N65uKkOmqtPS1EoqHqsqU/u5cB8cL7phiN2
         sJkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772603913; x=1773208713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpgMwZZuaK2KyeVm1P5Jh1Jm+p04rBkurVuB64xnmxc=;
        b=epgCOWwqhn2R7s4zUDMRPFuJmIe7WFu2ukL2zRAGseATTEXH3JpQJoZ/vtd2Zs87QR
         pcWFojEEIqPQknASR7pxuKlJ7+Eob5ztflW0XneqZ0aQjrNf9rwcjeB0QUXoXEv75qm4
         ixrF1wrjkz2hEFkd6Sn5XE/vw7mSZWk408/JpqSuQtK8oyyisBD7vK4Alugs+vSALmJp
         BoolpQCNsT1FQ15PPykheT1rzlWHkHdmT1kx30TpeIzfbXkIyA3irsxcg7joaxJwocjj
         x7RL9Fteb5wFr7URfFYMuxfIr4ffWYEfsBL58Ty1otch8++JeoYsZZ7R3oNpJSSeSQdc
         wC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772603913; x=1773208713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpgMwZZuaK2KyeVm1P5Jh1Jm+p04rBkurVuB64xnmxc=;
        b=K34P2YrgNASpI3RDb/D1uG+hIFbPOUqy+tvMik4epWIXODcnXgIvMGRoRaTs2C8urM
         yFHn5q3iJCTNU99YpSexJhP3AfZ7ar59fZREiaq9AV8SGhkg70FhmWP9iF67G8S0l7oa
         /L5QDl/6n3CPR6SsU/pWlrcysFTiVBGIdhI7/Are5g/vzQZcyAxkpuB4CwsMg8Mh7J4l
         gesCaz8f9Tbzb90PTpYEiRiCRuE8qBghowqLZvSrEpObJKpGkRplXfqVleJhxNxf2U6g
         mnm9XGaINdzNUz30emY8sFtIjrqIj1x9W1CZeeMrcbLHEhos4VlNzh7PralMPdbsSQub
         hlsQ==
X-Gm-Message-State: AOJu0YwRxnJ++J/bVa8pIrc5n3aDa5HLiBAwmv3SONsQc3Mtb+iLM+pu
	Jci8t7DhQauaxEGTzo5FevuzcX0uasueLCkaos+B94DGUhk1yN9TJKzw2Rpj+2qM2M1eupaKyQg
	UApxBSzyooFZ8pSymSnwibV/hnLVtp2k=
X-Gm-Gg: ATEYQzy2J1mBM+zo/ISKriO49EivFUmQJVT/f30GsurUG10GvwcoaETvvIpVX4Hs6Se
	nZqGBy8JqX21X3CVTA6LImc6qyvk/w2clHtSuN+l7MwO0C2ykWnceliafhSQZ5rHauWn/TDeXN8
	Hp2E5jpsvQNT38bMenkF6kUkwYY6r7F1qsxlBsw48nAMtkwkXgaZ8FvJgKY6x8svtw2kPk3mXMM
	dl+RbFINDdWSU9c0UxfPme+pOPQlKv0VVyavLVQQ/j1WG5kXFdV5zWukndqjToxggO9hC4ktw4Y
	H29BhoT9DBj2huXy6caEvbY7WGVyqrMiBNW6ybcVDrlOqd/e00L5IhRKHO0Z0JL3JdWqHQKZnhP
	50TYVIoXEbruYT/1y+GQflaOfrHm4yRlU4EHR
X-Received: by 2002:a05:600c:529b:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-485198840ddmr11665155e9.17.1772603913306; Tue, 03 Mar 2026
 21:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211151115.78013-1-leon.hwang@linux.dev> <20260211151115.78013-4-leon.hwang@linux.dev>
 <CAADnVQKc5H=k-++CHxs+Y1ggptRSLRcACLgVaMgOmt=QBT=dkA@mail.gmail.com> <c9cd645f-810b-4dd4-a1ed-27569dca5055@linux.dev>
In-Reply-To: <c9cd645f-810b-4dd4-a1ed-27569dca5055@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 21:58:21 -0800
X-Gm-Features: AaiRm51xhuPvPiRd8hQXDi2A83VK1MO7x6pFIqJ0aN5XHu0ii-a61Eu49k78XMo
Message-ID: <CAADnVQJ4E5L8rL-K=yJJZpCeRBvEJZcSKOEQP0kg2ztowhGmvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 3/8] bpf: Refactor reporting log_true_size
 for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 9:47=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> On 4/3/26 00:32, Alexei Starovoitov wrote:
> > On Wed, Feb 11, 2026 at 7:13=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
>
> [...]
>
> >> @@ -6241,7 +6244,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t=
 uattr, unsigned int size,
> >>                 err =3D map_freeze(&attr);
> >>                 break;
> >>         case BPF_PROG_LOAD:
> >> -               err =3D bpf_prog_load(&attr, uattr, size);
> >> +               if (from_user && size >=3D offsetofend(union bpf_attr,=
 log_true_size))
> >> +                       log_true_size =3D uattr.user + offsetof(union =
bpf_attr, log_true_size);
> >
> > So you added 'from_user' gating because
> > you replaced copy_to_bpfptr_offset() with copy_to_user()?
> > This is a drastic change in behavior and you don't even talk about
> > it in the commit log.
> > You said "refactor". This is not a refactoring!
> >
> > This is v10. The common_attr feature is useful, but
> > you really need to think harder about what your patches
> > are doing.
> >
>
> Refactoring should not introduce any functional changes. If a functional
> change is involved, it should be factored out of the refactoring commit
> into a separate commit with an explanation in the commit log.
>
> I'll add this to my self-review checklist.
>
> The intention of 'from_user' was to replace copy_to_bpfptr_offset() with
> copy_to_user(), since the log is always copied to the user-space buffer
> when the log level is not BPF_LOG_KERNEL in
> kernel/bpf/log.c::bpf_verifier_vlog().
>
> The 'from_user' gating will be dropped in v12 to keep this patch as pure
> refactoring.

You were told multiple times to avoid copy pasting AI into your emails.
Sorry, but this crosses the line for me.
Your patches will be ignored for 2 weeks.
