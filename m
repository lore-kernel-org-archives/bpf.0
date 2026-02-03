Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD930DD16
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086016; cv=pass; b=QU8PS+vJmOYM/1f5PBS0Hq2uBs1nmD9Xw0l8+zHlw7eJXdkEPVBg6DpuanSqqGCmTQkinDWBbnc+xOwThtdEQOI0cWOeo5qlMpEKZGWg/xvWrUHU5aHWc1SSICkJCkS6ExznoRSW7azvx6M5j2QZZBaS92EKGV3024uNprieUFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086016; c=relaxed/simple;
	bh=Y5putze5WsPoLu/wt0IAm04YSyS6/swIY+8nnvHxMRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8Uymst6EeEUZxDLf4kt8F5vJlLhViIlv80Egi9eOB+gyzNFPzdicJ3G0IbGXqkiQxweZpKdswqQdhgNxE77K+7X2IJ7nY/03DoZWqHCLjfQEFOECfXXKxK4LRBoII01EWmNV3OPenhLnjiY8wPclsURGmvVfwcCEDw1uokZlfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqIZmnj6; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqIZmnj6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359a302794so3482046f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 18:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770086011; cv=none;
        d=google.com; s=arc-20240605;
        b=FD1lB3AK9FZYPB6tofv7geO3243450aPFmQf8okNPDvOaVkXggj15ikxpUaCvBUanw
         65AmrEkmJfoG/+5JqRey0runFgArP5KTxPQXURMUmXd1iKJf9VZSYH0Ph6nPr6R7ybd9
         1gSt/hz1hLqdIO/haYO1N6wx9qDNKLTxa4aKyfqCJbsQYOQNHFZA3wlfYyKHQTN9QWCg
         +o9sB12vPuBDO3MdWBXeknu9cnOV7sRyjwhrN4OfDI1h9sg+PyiweHGWRzz0RNxFJ/Fl
         7MIn2ek2W9uOwBi7JxG3ClnjK4yHOWzMPyTJ3nF3UcIIoJ0MGHnE3owLn9I/wq0OzYEQ
         WAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=phboMRuJZmp7Nx+aTFWME2yhj7Pm0eyhEHX0d7JcEiY=;
        fh=koU7yOq49eAPadSsm1ahXF3Nv9JkDgLFbAXS6+bx5Qk=;
        b=L6idpW6DvI9YsOHIxocM6Y4NtC15iRdG0kWY2l1HFjZe+8LnFzoV4cclPMKh24LT/a
         ISNE6dqs1iUTQrcgF7zuwhUdD4EPJNUGpdEgEpnuZ+cBE4ghpb/Qbv/HGwNM7pe/Yfpe
         azWNv/vM6kJzb51WyijNMj2K7w5ggPBk2+WLeVQRLmkt0HOTBEahB5lIIXRF2W4hXlYV
         VNLossvU2ZQDntgOxaef64lKjxhW5h0BJ33MpBoSC6B3knZC1+XM9rd4y3ER3XgIfygk
         gk6kTOJlWlvSqVCdjc6r9GJR0d1D1K7toxlUXLrVSTZPwImsA2nztskOi1Ms7AGTGf7B
         0RLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770086011; x=1770690811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phboMRuJZmp7Nx+aTFWME2yhj7Pm0eyhEHX0d7JcEiY=;
        b=RqIZmnj6+i1No2fty8B3FCHh0YKM6cLW8veAAWwr8xxswxdU8h80UBfEradX0rEYjT
         mto/L4o1udE0dEz37AXzg2X05bKFXP7LRxIKnf4dwLlNP9aZRVy/EBeRJSMvBEbnIAzN
         gzrzoU94qnDw0EWvJ29qXR4weIbRHdWGOWxVeUWjYCbiZAkFyeHPj1jXEUNiwuCFey+i
         ShE11Jq1ooIwxYUwFcXeSWi5u8npaelIl3AFgr2kWMZTeu1m8p45I/S6sWOQbxeSZ7EW
         qejUYaYENG27HDKv0rQfo8mh9abFmPkauALRU+MRZuykDfAU3c5kgB583ZGvbcONab+A
         T7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770086011; x=1770690811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=phboMRuJZmp7Nx+aTFWME2yhj7Pm0eyhEHX0d7JcEiY=;
        b=HBTKl6fPZdhhnlngqSzsOedmVvM8rm+zigjRKMXncBD80I1Jcux5kJTghhUZAk+1tZ
         Rf8hJjP3tAVd8VuU3ChgjCw5g+4VBXQxtc+hRWXMiPvDmziNhl+QwqsPNYs0K7uAp3OC
         aUzHSp3Z4Zw+GsYcnJn2KGDFT6HWhfLesh0xep/OSyB3vDC4RESyxdJYLCn2xi18R/1W
         rGe8dgHHJZxjWxlrk5Wma3+MdCac0e8IFdVy6SgWzBsaCEAuKK6pdtuNbMjwQ0ZGP+c8
         2oUFHIq2gZG/i+ta0EPWF6u+j486aORuGNXV2HbsWE3bkIg7kUxLqHbbfIY/Jfq+ifej
         Qmtg==
X-Forwarded-Encrypted: i=1; AJvYcCWt+7sNkaDHMQ2dGpFW4qZsssJ54nfoMoGcxdvDVLTnTeBQ8oduGtV3ZmvlU1XiE9sErR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KDnU8+HdY4S2BVodus8tfDdBHgYiiaunHGpTR4cEZD6StfzP
	L6TdCAWWAAQbuhhHL7sHfjza+s0gqnFPHTmeON8xYCNyZVb5/RYnVUr/ismMtlnWBjiL5LhJUhK
	TqmOLSdwrFqBVk/qqIdwW2XweLIRjSuNK4jRk
X-Gm-Gg: AZuq6aKRmmERyOh+B0EobNJQ9h0Q8e9avupYBG0Hd2a4xo2EJgrd2+3WmzTnabPOocR
	xXYhMaCYIs3lw+zraTDKvO0SfpuOfSHvJKAJOyecHI0hBP7c2dESMwfwzC5HtW8DFZVegSN+M4Q
	PpudfOIhf7mJGIKinFLSp724vHBTVDEm4q3C0KCRODtl9L3E8c9Ydy2BqDbmYkZur+j9UKWW16I
	HU8Q0HbFYYQLeanPoZDwirAyUL5Z4Ukqt/Rvdc8WUaAnB0vr0mdD36hk3rJduSNc+SjQdFKLg3H
	dJh6eTU1dBs9a+EUz57pKTet+Ei3OdUjquFhkp6Zyp7Kn3Ai5/mMQ+m7PWnXXM3RhPGkVcweDFQ
	AkGPTjCPRxBLGWA==
X-Received: by 2002:a05:6000:1ac8:b0:431:104:6db7 with SMTP id
 ffacd0b85a97d-435f3a86891mr21075320f8f.26.1770086011201; Mon, 02 Feb 2026
 18:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202233716.835638-1-emil@etsalapatis.com> <e3472b618ca3f4c00a78556992af9c819c3a6c93215358ab2e8d8264a7901e7f@mail.kernel.org>
 <DG4YI75AFYJQ.FMENV4LELNM4@etsalapatis.com>
In-Reply-To: <DG4YI75AFYJQ.FMENV4LELNM4@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Feb 2026 18:33:19 -0800
X-Gm-Features: AZwV_QiAw03_Y9x4DnWvmQQG2-4jWQctlA4GtejGePIBj1JE7S4ktuhGlVnCEUg
Message-ID: <CAADnVQKTrozPJ5tAadjQuFjgdOYCaHOrt6vwt5CzNEN1om605g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Bump maximum call stack depth to 16
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 6:04=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> On Mon Feb 2, 2026 at 7:19 PM EST, bot+bpf-ci wrote:
> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
> >> index 8355b585cd..9f7fc990f3 100644
> >> --- a/include/linux/bpf_verifier.h
> >> +++ b/include/linux/bpf_verifier.h
> >> @@ -317,25 +317,25 @@ struct bpf_func_state {
> >>      int allocated_stack;
> >>  };
> >>
> >> -#define MAX_CALL_FRAMES 8
> >> +#define MAX_CALL_FRAMES 16
> >
> > [ ... ]
> >
> >> @@ -346,7 +346,7 @@ struct bpf_jmp_history_entry {
> >>      /* insn idx can't be bigger than 1 million */
> >>      u32 prev_idx : 20;
> >>      /* special INSN_F_xxx flags */
> >> -    u32 flags : 12;
> >> +    u32 flags : 13;
> >>      /* additional registers that need precision tracking when this
> >>       * jump is backtracked, vector of six 10-bit records
> >>       */
> >
> > Was LR_FRAMENO_BITS in kernel/bpf/verifier.c intended to remain at 3 bi=
ts?
> >
> > The linked_regs packing uses LR_FRAMENO_BITS to encode frame numbers:
> >
> >     #define LR_FRAMENO_BITS    3
> >     #define LR_FRAMENO_MASK    ((1ull << LR_FRAMENO_BITS) - 1)
> >
> > With MAX_CALL_FRAMES now at 16, frame numbers can be 0-15, but the 3-bi=
t
> > mask (0x7) will truncate frames 8-15:
> >
> >     collect_linked_regs():
> >         for (i =3D vstate->curframe; i >=3D 0; i--)
> >             __collect_linked_regs(linked_regs, reg, id, i, j, true);
> >                                                        ^
> >                                                 frameno can be 0-15
> >
> >     linked_regs_unpack():
> >         e->frameno =3D val & LR_FRAMENO_MASK;
> >                           ^^^^^^^^^^^^^^^^^
> >                           mask is 0x7, truncates 8-15
> >
> > This means frame 8 becomes 0, frame 9 becomes 1, etc., causing
> > sync_linked_regs() to update registers in the wrong stack frame during
> > precision backtracking.
> >
> > The comment at linked_regs_pack() still documents "3-bits frameno" whic=
h
> > now conflicts with the 16-frame limit.
> >
> >
>
> The AI is right, we must also adjust the packed linked register masks.
>
> This complicates things, we now need 66 bits instead of 60 for the linked
> registers and cannot typecast the struct linked_reg into a u64 anymore.
> We need one more byte for this for the linked registers.
>
> An option is making a new struct to replace the u64 for linked registers
> with a buffer of 7 bytes, like so:
>
> /* A buffer of 72 bytes to store linked registers in a packed representat=
ion. */
> struct linked_regs_packed {
>         u8 data[9];
> }
>
> struct bpf_jmp_history_entry {
>         u32 idx;
>         /* insn idx can't be bigger than 1 million */
>         u32 prev_idx : 20;
>         /* special INSN_F_xxx flags */
>         u32 flags : 13;
>         /* additional registers that need precision tracking when this
>          * jump is backtracked, vector of six 11-bit records (66 bits).
>          */
>         struct linked_regs_packed linked_regs;
> };
>
> This actually brings down the struct's total size down from 24 to 20 byte=
s
> (tested with gcc 14.2) as the struct does not need to be aligned to an 8-=
byte
> boundary. It would complicate packing and unpacking the linked registers
> though, and we'd need to see how the new code affects verification speed.

That may be ok, but before digging into it further please collect
performance numbers for the verifier time and memory consumption
across all selftest/scx/meta progs.
struct callchain will double its size and it's hot in liveness analysis.

Instead of bumping the main limit could you introduce
and bump a new limit for global functions in the call chain.
I think we can keep 8 for static functions and no data structures
need to change.

pw-bot: cr
