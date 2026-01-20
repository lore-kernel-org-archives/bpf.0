Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B3345CA5
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943055; cv=pass; b=BB+/thnqCkwpUvemQQKnqVqYpO8+YguViPhVMiFQa+Wcoe4Ic7j5LWeEslOZENUOFR0U3z/gM2BKYEez5kqU/pP6UnQYUBmD8FVAgGTVuu9gA71fMh5YIDzB2JMyKHk87cfZ6YdB96v1viKfFBMbwOhLqhjG6oobiJCuQAVqGgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943055; c=relaxed/simple;
	bh=Ts1jxwUKhSUgqpDTCGEAc2n5xXWvl8SdC5x8YUX0Tz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyWJ7LNmysLrG8GSPwsMTF5m5/nT97/+mKMvLsly72XU7Nwmw2HU6u66tumvPBLdRSx5Pny+8C4hK6I39vjfk/9Qb8B+M2lfCEA730dmiPp7APKBdEMJRMyzRto0ghXffr3tWG62WShTWn/uTTgMIleijs3lKPvVtZUmjdGknJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAzMG+ga; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAzMG+ga"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4359228b7c6so654063f8f.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 13:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768943052; cv=none;
        d=google.com; s=arc-20240605;
        b=F4F1kRtEqhOTq0r7Sw7w3M79iB61ASeI5a0RI8W4uvE8mG2V2QIBg/1B/azCRXdXvV
         mCzY50ZaRqYmSe4Xv106GHmeLEjOa4tnqkibkztcyX0+/dKSQAYBZNbmeQAMBPxtriJF
         hkFNT6Yn9IAt1MiI4BdAGLwGuivhPnzRNEoARpuIcg64tYpSMuoR1uQwlaa1uBqbAQ1V
         WccT/GMwA9aJPSJdiOaaJLrp/Oh7cWge06sMypr+mZlOLTFwIkigmXX8PHhJs6SpSQuP
         J7555Aml0pu0vo0lY+dqbLZGxXwSxh0BXkPwo1Ms2jlZMKgY0AWy6gSAcDe9qDWr2CgS
         dvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pzzZDPd4jb3WfjctUiFBbJuKkbeF/iPpCm3WW/SQRp8=;
        fh=Hn1KVsLV/tblPOKRgacAYI4Cl9KT5a5T5FeT6fAkmjA=;
        b=ljnXKe2HgTSNCVuqsnKRVfDxGKTUVg65p9/2eX34ItanfrHV0iMCuClr9B3BSnuQQC
         RE49CN/zXvW9IVw23gouug4ymW8qJeXW32FiYtPszqISqjgXwQBdIouzWb4o5Fbx7TKu
         H30Qo6uCFmOryTiRXqV2murN8VroVjTlLgARNfRfaqbbprswWahsUdbYCnL131mb0nUq
         4tQ4ryYaWIJrFxlWgCbc24qhXuCHlBCkv35//lU0pBlFKbBG6G1oj0fLT/le9inFDKPQ
         pI9rFSZsJKt9YVPQlwhckZqaFf53gNQmSnZmlnL2+aJ6ikl6B0OpJGix+nAtoFodpUwL
         QtQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768943051; x=1769547851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzzZDPd4jb3WfjctUiFBbJuKkbeF/iPpCm3WW/SQRp8=;
        b=ZAzMG+gaMM4cf2RqlCF5/1cSxBBkzCtMIA3xVV5bzPHDgvJ3xGw1G+S7S2HTfFf2+G
         tGY0lXZKMwItABpyWOnFgOy/EX5o+lK01qWN9c4DTmXV4t3qcDlVK6vS/O8/Iaqe4P2f
         xEyHV0HjfKZpEKksYCylIgoaFCxLFPcJ7PnMCIhxsVvfbcAO/ImW4nthIsoR6HYO1EFA
         yopj7pp8Q0yK31zifeytKQ7VkjW598errr0TZ6YRyYHMowCXKi4GpRSNetYeSXBAMJ9m
         EHhvcK6FmTXsr7l588EMpf32HHOp+OHYoZIkHm4bKkJD1ix6jQuOyMggnUscLwBSxLcb
         A3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943051; x=1769547851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzzZDPd4jb3WfjctUiFBbJuKkbeF/iPpCm3WW/SQRp8=;
        b=blMtpvNvtlTlbFn/J2CNZtE5iRvcasJI9JRv609CNyr9olcSIWOaCsVN3NdOu4CtV7
         yVBQIWZmxM6uKyKPgngeNGP479jlj9YgyE1vl3kCpmYbzjmRcV11FJRlDy0RSflgmY9D
         qDFWUNAJlbu4J+Nemw/Sg2myqb3aMzNPlrLUU/elQVlyw0i4VmygJrbdabzDhT4I3Dd0
         7QBDJdlhH1e3q9DUVewcHQ5g6lS2k1y8qxfGcL7F30t3RLn6bJHw30VOMb0/eyMRbdu3
         FIcab/Q5hweZI3bwEcbRiYSjoR6Rk6PJr4HvW2Aw1gckkvN6W7/75na73lhtc1ZUjj5U
         ViIw==
X-Forwarded-Encrypted: i=1; AJvYcCVo/KTwAeG9UYe8+/N2BhNolHv/SiVOxZuQkRNGvSXFMpxst4nJDjtmHfzpe2R6YSnO0SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOjU+YgHZoSZnXcFO02uaXvzfslNeMWzg/nSFvg89L6zyde5S
	0gpiJVK9V/VVdBR2kyHibrNTMGOMCHfjBB+0wgXUYoAm+RTK8n3Z2wdJayOdQD/w2Jz9o+gtCxM
	aZY7CA7OSZNlrqfb2nKoJP7WNT0WaXBQ=
X-Gm-Gg: AZuq6aINiPetHVtY1WJNU5OADrBgWRZpytuXktxF+xxg5Obz3DoRVTRSwucKe4R88AF
	nHupMrgB4oCGI/1nWBqrgTRsfpXOM/YPadhbtKJ2zxvl8djNLodp2JZuefBGFJHmOkmDTvwpLdO
	cotVlrvYq1l4Ul49bggMT/01kkMj0wjCIL8frdTEi9Wfh5+3iPrP3Dlf6GsgB6p4cCO776eK+tC
	TG+7UUkdj2uIzDVFq/g9yZUzL2MyPCP1YOHWDSXUiLrIVi9PZCanWQwANVk4I9NyI+O1GHSinEu
	8pr4XQRsM2UkyK1uSXStqCMJS51RazDDctiVidvj/IeQvypI0VVHwqMEnu9ItNmO7BJBqM8R8CM
	rxIrmCNciOJS3Vw==
X-Received: by 2002:a05:6000:18b:b0:435:94c4:649c with SMTP id
 ffacd0b85a97d-43594c4658bmr2717394f8f.30.1768943051414; Tue, 20 Jan 2026
 13:04:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
 <20260119085458.182221-2-tangyazhou@zju.edu.cn> <57dbe0b62e2cf0370f90825f9508c466cd673704.camel@gmail.com>
In-Reply-To: <57dbe0b62e2cf0370f90825f9508c466cd673704.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 13:03:59 -0800
X-Gm-Features: AZwV_Qjd6CnSpX5iS38uP-qpLemsIwuVpgInUr2ejwO3zZeWv6wEaCA6cbAGQoU
Message-ID: <CAADnVQ+xyTTweTV3Kud5zPdRtcQkXEv9iYMQXyc_rc8_Jzunbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>, 
	Tianci Cao <ziye@zju.edu.cn>, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 10:51=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2026-01-19 at 16:54 +0800, Yazhou Tang wrote:
>
> [...]
>
> Hi Yazhou, Alexei,
>
> Sorry for chiming in late in the series.
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_a=
lu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> > index 2129e4353fd9..4d8273c258d5 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> > @@ -173,14 +173,15 @@ __naked void flow_keys_illegal_variable_offset_al=
u(void)
> >       asm volatile("                                  \
> >       r6 =3D r1;                                        \
> >       r7 =3D *(u64*)(r6 + %[flow_keys_off]);            \
> > -     r8 =3D 8;                                         \
> > -     r8 /=3D 1;                                        \
> > +     call %[bpf_get_prandom_u32];                    \
> > +     r8 =3D r0;                                        \
>
> I suggest we special case `rX /=3D 1`.
> Maybe in the is_safe_to_compute_dst_reg_range().
> This is an old trick that might be used in the wild.
> And optimizer should remove any such instructions when compiling from C.
> So I don't think adding special case here would hinder verifier versatili=
ty.

and to standardize now and forever that /=3D1 makes it unbounded?
I'd rather not. JITs don't special case the divisor 1 and in runtime
the /=3D1 trick is quite costly. Integer division is the slowest instructio=
n
on any CPU architecture.
We have few selftests that adopted that trick, but let's not continue
and not encourage it going forward.
Let's figure out a different way to tell the verifier that the scalar
is unbounded.
I suspect ^=3D0; ^=3D0; will destroy the bounds just as well
and will be fast to execute.
