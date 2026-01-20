Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C73A0B3F
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946059; cv=none; b=MnJ1JZJ96iUrDZ9b/ObER/pXAMNFYFZ+5iNF76LPS1lma3hthFwh0DQrYKLJB9VwojExbaKkWHDdIH9fN+5FuJvoD/tZ1JuzNkCFXI8188BqC1IBcCGhoecsPbCIJrL+eATvXMbyAv6r0vUFsm7xx8JsoJSOkyoPv7AnRvHNw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946059; c=relaxed/simple;
	bh=9d53jm34GSkgS994xvMdTstlDJIh/vpxoaBJ/AGCsyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcOvLQJcMiZDNe19rOv73w/15UbkwGhf50mJ4KJ4gXcyA+Sa2cOCsLDpmiq4fzZl51Nu6wb7hmpzbpZMIq2UyAXDwOf/VEtaUP0WpmZZW1uwu90oZAM7eO2S1xL4XQV7zWOLd/iU8eJwAO6kvSQJZM9zD0AmfFNgW6RqtMl+CpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiveW+a2; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiveW+a2"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233bb90317so277340c88.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768946057; x=1769550857; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YBWwpE5S/GwpjdaYQMyUayEfLLhx8fmsH84EIn3zr7c=;
        b=CiveW+a2DPNaicjjFpvrr6JYYllsK3XtXaucE6ns0+8Duq2wCPyQhPeJEabdC4UesK
         du49DOHB/y4jX67M5GF27ZLXPNjy3UAZBdKmm3hS0nBJSUq4wlSS5G3B8mv9EmDwoa7s
         d7CrI0fZxrNGMNrdVxwKLJYQhPp45F0Ot3rKGnDMsnO7D4y3HkvWjTK18FAc1gcMgJpH
         pdmHHUNkFA0ieNElLlDYuYi2wSXBUCeOUf/tprh2gkwv74l3d9QcTfogL34qNCRwGTue
         MNq4F4LBuu1pcnw4HeKps3DbG3FmGbqOJg/9XZL8zrEzxxPKFNRPBA/UxMAfkd3n+Rze
         Jn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768946057; x=1769550857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBWwpE5S/GwpjdaYQMyUayEfLLhx8fmsH84EIn3zr7c=;
        b=a2kXy2aAYp3FEywz8wYG8sGgsLoIrEnZOBwWtSgyebOXEJld+UsPC3DPFbd5YKoj7Z
         PlVRAPF1FH1j+jfnygDQok+4+J4JgIlato+WZ8ZqGtMw6xePjTRgdDIvn7R7+M9MKimn
         3K/SVt1yvxHe37fcdJqg/OK4NejTFZfw9jq00gmCm8jsVrcegCQCP6TKjL0QbJnuehs8
         4BfliIZX0n2iSjoskEh2KgHGHMYfRCLkGrFNHA4dMhEFjCFP2v8HE7FRiWBSyN4KQZgK
         l2pJ9JBG8lOU+33I33BpMBmoi35vbPP7aQytCjx1F5wSleJ58r+oGFPk99PkrScehQIz
         0DAw==
X-Forwarded-Encrypted: i=1; AJvYcCXVJyMZ+y+vl8Yw9H6pbzAzNclmaPEHrIzHNWNhr3xFj1ODQop0p3zRAVsI9oOit05RNiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqdkUljTcG+Tp4XK2T30P9AsNLta2vpo2VWThWB37sKmF/Kxq
	w9VUJg8nml42Ci2zDnLkW1/EJ0xuxFfre6puHKtdbmZn8JcmJV+SDlQN
X-Gm-Gg: AZuq6aIGnCChamwnnTdsRkzzXXoATeJYyCVPBqqybgbbxE/jSZaYFineHU/gkHGzM9L
	1rVaKkHAeHnVa2ydpVI1VHeC3r25vGhZyQgQGtATmBp9yq3ydxGhh8DnG9807np+3fNX0IrQBzd
	t3LyBcijj3QMVFNbqyvx4mmeo5iOUUy3WJptaxmDbilyPuwcq9bb8kioa8upwEmvBqtqDOuaS0R
	I1DCS+fLBCupkWxBsxoFi5Lq0Ptj9Qw2Hj7h7gRUzR+7gKRipgPQvJ0sFWmxqmH3tshjjzd82JT
	zKVGTVXerYLGI2vcG4S3gzqbSeI3AgzZddjEKVmHl2SaDKoAWj6i9/vtp78yyjRWBfrL4bLUHf1
	zB5FTMBWcGC7Uuhdv3mlUyWdCYccjwVcg0ljsbVUHJ2ljDJ7bBX1BFsjl3wPKcL8MYMyBmwZFIS
	i44tbUEj4oFBJmhLjjz9LzXMNXWya7YW4jgOenN8PtMOBja6hyWAgfCEaw9j6GlearvPci
X-Received: by 2002:a05:7300:a507:b0:2a4:3593:ccbb with SMTP id 5a478bee46e88-2b6b3468fecmr12408923eec.2.1768946056600;
        Tue, 20 Jan 2026 13:54:16 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6a7d:961b:9e54:4392? ([2620:10d:c090:500::2:634c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7102fd2efsm757052eec.12.2026.01.20.13.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 13:54:16 -0800 (PST)
Message-ID: <acada74ba15f0aaeede2440ff68916f3fbfa7da9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add range tracking for BPF_DIV and
 BPF_MOD
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,  Jiri
 Olsa <jolsa@kernel.org>, Yazhou Tang <tangyazhou518@outlook.com>, Shenghao
 Yuan	 <shenghaoyuan0928@163.com>, Tianci Cao <ziye@zju.edu.cn>, 
	syzbot@syzkaller.appspotmail.com
Date: Tue, 20 Jan 2026 13:54:13 -0800
In-Reply-To: <CAADnVQ+xyTTweTV3Kud5zPdRtcQkXEv9iYMQXyc_rc8_Jzunbg@mail.gmail.com>
References: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
	 <20260119085458.182221-2-tangyazhou@zju.edu.cn>
	 <57dbe0b62e2cf0370f90825f9508c466cd673704.camel@gmail.com>
	 <CAADnVQ+xyTTweTV3Kud5zPdRtcQkXEv9iYMQXyc_rc8_Jzunbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 13:03 -0800, Alexei Starovoitov wrote:
> On Tue, Jan 20, 2026 at 10:51=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Mon, 2026-01-19 at 16:54 +0800, Yazhou Tang wrote:
> >=20
> > [...]
> >=20
> > Hi Yazhou, Alexei,
> >=20
> > Sorry for chiming in late in the series.
> >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal=
_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> > > index 2129e4353fd9..4d8273c258d5 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> > > @@ -173,14 +173,15 @@ __naked void flow_keys_illegal_variable_offset_=
alu(void)
> > >       asm volatile("                                  \
> > >       r6 =3D r1;                                        \
> > >       r7 =3D *(u64*)(r6 + %[flow_keys_off]);            \
> > > -     r8 =3D 8;                                         \
> > > -     r8 /=3D 1;                                        \
> > > +     call %[bpf_get_prandom_u32];                    \
> > > +     r8 =3D r0;                                        \
> >=20
> > I suggest we special case `rX /=3D 1`.
> > Maybe in the is_safe_to_compute_dst_reg_range().
> > This is an old trick that might be used in the wild.
> > And optimizer should remove any such instructions when compiling from C=
.
> > So I don't think adding special case here would hinder verifier versati=
lity.
>=20
> and to standardize now and forever that /=3D1 makes it unbounded?
> I'd rather not. JITs don't special case the divisor 1 and in runtime
> the /=3D1 trick is quite costly. Integer division is the slowest instruct=
ion
> on any CPU architecture.
> We have few selftests that adopted that trick, but let's not continue
> and not encourage it going forward.
> Let's figure out a different way to tell the verifier that the scalar
> is unbounded.

Fair enough.

> I suspect ^=3D0; ^=3D0; will destroy the bounds just as well
> and will be fast to execute.

scalar_min_max_xor() tries to compute min and max,
does not nuke register state.
Andrii suggested adding a kfunc or instruction for this purpose some
time ago. Anyway, that's unrelated if we don't want to keep /=3D 1.
