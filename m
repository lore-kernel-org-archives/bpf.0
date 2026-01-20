Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0893A89DE
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946552; cv=pass; b=Kf+2pDnldRE0nbW8JuR2EMdrRCj3f1VbyHmlrVJ8sAI3nsFbc/W8SjWRoQdsDCEOERvbmQpkJ/DNWcCF1tXrf1zmRoEK12RiutyGEUlWpdx54EiFjoI87EVDH9m/DH1+PLnu33pgFBQRitxFe/f9qBRuiVQuiccR8FHAAUZPBt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946552; c=relaxed/simple;
	bh=anXykZX3wEyvvnPQM8K0cjVftNbQa8ubBY46QzAm/wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMe/7sRwllWBp7b8U4CAzsHSyyO428/Iuj8ak7N2kv+e7kFXyyq2/NaXVW1dzL3Dr+qts7xlNdkizacSOYfyHZkAswDXKaybIOZcXwoLlyCsPbnZJRRVovy8DSWv9rtgeFCYtOHnbFaluVqjTjecVnKZcQwtPRrb+wP9BCJXf2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDSaoS42; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDSaoS42"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432755545fcso3395745f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 14:02:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768946547; cv=none;
        d=google.com; s=arc-20240605;
        b=js7S8ZXf2IUrdBcz2BpCQbkabGZVjXylQ2wfWFuiyrjoTws7gTcvxUkib0D+zLfadH
         dj6x6fSkQ3wVLmcqDoUaKqPZwEnsUn7cCK6peU0iLpbif6fXuB1BnUZV9tixpYwcAyxS
         dANFO1A0BkmbCdsBid+hqE1zu7HHORFjfc79U+bkr2BbtRJxew7lqflcI8gmWldRHCsU
         OmfdraJV8zNv8rxwyvH+rVDLs9PNFfnV9UcxOlc/29HjsNtuA7/9qt+eAzSPTGbFhgH5
         oU2GgscjyCQ4woPVTLxrq3RlKsvT8GrncDcyaJWf9D2YRaWm9VcJKPrPzV8RuZlaAk1X
         z9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cKVtlrqGvoMQumP0pE/JC8zj8C6KdtJIB2DJqGOlxFg=;
        fh=a74pCiTbpS/awYcMIpdGkefUEb6j7+cQ7adaIJaAOP4=;
        b=JX+uZ/vFTSCfFSbUKa5/Rbo2T6YEWlPqhnZKWKbAlP3UyqfowUdNBDSZdx8dKID3t0
         u2x7rpbtXOIhn2rbLgircsvYzzYXTm7DDS4+P94lbrbaXUk6FJiJCTsVagn/tcxQ0ftA
         2kCBusabFE1KPaMNvMO9gl9npqAQZh6tE9xkHxd9GKtuRZUh7BmhbX39Fp8JmGnR653T
         uGGI7d9InXntretNqQXj/GoxdAddZH4it9hAvoFArxK+a/+L+StVzRvbGF2bZ+ArgNvt
         60kZNpj2dDrxjh30eLJKjbBY5xHMXaqNUQRFUujdTG2WeQhIXP0d/pAHZBB2qeQb+XQS
         TGAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768946547; x=1769551347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKVtlrqGvoMQumP0pE/JC8zj8C6KdtJIB2DJqGOlxFg=;
        b=gDSaoS42J6drUTtdXXXuA0I1DhJmVaqqpIQeI87cCzxHDMHHGK3+Ohpm73zOnS3Cc+
         cDfBXArESe8Sn4DnQBp909u8w89/38UIL08ZYtxtznW1e8r9Plzl4/q/He6nR7QQp0cq
         OuU1wTXdVGaQt0RWiBWWhCNsf9MX/J1rTIvG0ctqjESjhRRReLOv3/MQcsLbk9YwwL3k
         vLNfJMW+htDD8uOCpGDzc9a2zIy7pgbLHVdqBnHID1OMDsNA9Ize/dcOTVvwyzCWQ89r
         sCzQ8hoJFlBjPXyeljA8J0iuYxxBVlGkQjo0/Fj2waz62e22np/t07VTkCGQXngxszC5
         PwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768946547; x=1769551347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cKVtlrqGvoMQumP0pE/JC8zj8C6KdtJIB2DJqGOlxFg=;
        b=rCKqJwoghj6vDO2ICQCEBZg4lnAM7NPbVOIpDr8WsVfZ0y790U5uGw2cZMpZjfJlN+
         DFSQRKXeT0DD6NRQhcsB3w95YNCQ5qNZsIvObvcGsGmrJTn/n081TDUYTPEMNLQu0MU3
         UcA7zSxjbt16ZxcCFW0OYlP0LkC7pcOz92LgBphneNkljdf0hiPkAsOtGQxkxXtVVEJG
         WFrvwCg7EnCBDyD2uv4pLNdLJ9YjUjEgvNHDa8VnzWSFY9zjMsueisX6XO+NjMcstgzO
         n7WQXSgc/1AybN2s1qY/2CmC7cFYGVw6NLhX7aseACy+Z0ItRcNy3+TRvd8TZUIUYdmR
         K4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCULROvsEmu6lumhhSDmDUgVZx5iL9TygFvXwg+KuSN9QOasORLxQykIXvx+4DKs8pJZbWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDR6Sk+8TebNk+j8w/WW5TMVqKCvVNCn7z5cHUSO3mTFkLQIW
	+WroDmFMfqBNtnqZYKzQez8Ts7m+yb7jEEjyVbopn/+M1CjZ0RGTVT/+3JMwyYaiIurErGjulgt
	MBetl+S6A5fc7+XFecdm6FEiAN+7Hep9qeQ==
X-Gm-Gg: AZuq6aK9WUr/GX1DzjPjE4iKbCeNwwgm9djrjUR7khN8/yHr0nP61v1cWCoy2ITJGwl
	rcecZKfmUayQfoXMmiN3sDDTdD+UKeBuwL55gPQwyIti7pFGbdNqjSnu596xzLEPM9cT/7CzOxz
	EB1Y9sBPO4qRyfitJ40h6jPavaK2DfcIsHY/BRy0e3EA3limWf0YwJUq+kBlGZeH+rk/cU2jipJ
	C8Yxlb2s8kft4kp7PrVLojPb/IBoCG/k9i6RsY3K8jhO8ewtEZs1fxeAddS/KASCuROiuUyYwhM
	QImK/U9wUkDcrKIGOo9B63feanO5qjrBpkA7w5m7Xd9KUjmn5jmrmMONIxhBvWp0QmIZT1WJCLg
	yGVgdNqmzb3wU/w==
X-Received: by 2002:a05:6000:2c0b:b0:42b:3806:2ba0 with SMTP id
 ffacd0b85a97d-43569972d92mr19973514f8f.2.1768946546638; Tue, 20 Jan 2026
 14:02:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
 <20260119085458.182221-2-tangyazhou@zju.edu.cn> <57dbe0b62e2cf0370f90825f9508c466cd673704.camel@gmail.com>
 <CAADnVQ+xyTTweTV3Kud5zPdRtcQkXEv9iYMQXyc_rc8_Jzunbg@mail.gmail.com> <acada74ba15f0aaeede2440ff68916f3fbfa7da9.camel@gmail.com>
In-Reply-To: <acada74ba15f0aaeede2440ff68916f3fbfa7da9.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 14:02:15 -0800
X-Gm-Features: AZwV_QioTfpVzFys3zied5fnWu43jTn1g6sRq6MmFP5F7LA1Kn1mqowfEWvmMe0
Message-ID: <CAADnVQJtjEKM8peZThULpzEoP=8z-hhhCCZ9bL3n-_FFVfA5rA@mail.gmail.com>
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

On Tue, Jan 20, 2026 at 1:54=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-01-20 at 13:03 -0800, Alexei Starovoitov wrote:
> > On Tue, Jan 20, 2026 at 10:51=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Mon, 2026-01-19 at 16:54 +0800, Yazhou Tang wrote:
> > >
> > > [...]
> > >
> > > Hi Yazhou, Alexei,
> > >
> > > Sorry for chiming in late in the series.
> > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illeg=
al_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> > > > index 2129e4353fd9..4d8273c258d5 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.=
c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.=
c
> > > > @@ -173,14 +173,15 @@ __naked void flow_keys_illegal_variable_offse=
t_alu(void)
> > > >       asm volatile("                                  \
> > > >       r6 =3D r1;                                        \
> > > >       r7 =3D *(u64*)(r6 + %[flow_keys_off]);            \
> > > > -     r8 =3D 8;                                         \
> > > > -     r8 /=3D 1;                                        \
> > > > +     call %[bpf_get_prandom_u32];                    \
> > > > +     r8 =3D r0;                                        \
> > >
> > > I suggest we special case `rX /=3D 1`.
> > > Maybe in the is_safe_to_compute_dst_reg_range().
> > > This is an old trick that might be used in the wild.
> > > And optimizer should remove any such instructions when compiling from=
 C.
> > > So I don't think adding special case here would hinder verifier versa=
tility.
> >
> > and to standardize now and forever that /=3D1 makes it unbounded?
> > I'd rather not. JITs don't special case the divisor 1 and in runtime
> > the /=3D1 trick is quite costly. Integer division is the slowest instru=
ction
> > on any CPU architecture.
> > We have few selftests that adopted that trick, but let's not continue
> > and not encourage it going forward.
> > Let's figure out a different way to tell the verifier that the scalar
> > is unbounded.
>
> Fair enough.
>
> > I suspect ^=3D0; ^=3D0; will destroy the bounds just as well
> > and will be fast to execute.
>
> scalar_min_max_xor() tries to compute min and max,
> does not nuke register state.
> Andrii suggested adding a kfunc or instruction for this purpose some
> time ago. Anyway, that's unrelated if we don't want to keep /=3D 1.

var +=3D zero; in C will destroy the range.
fastcall kfunc that inlines into a nop is an option too.
