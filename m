Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD1256C70
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769209056; cv=pass; b=CjJ4Ok8h03SX3csnOMMv60KBlp7jVXza01BRiGmB8e7fBPgAteaSYTA1rbffvH3BQisjiXE4IQNUdjonyz71PV/cax4WvmfXnUMOHunQQYwwXuV1rPkqq6QCLQsHF9X4epeFycgMaM2VzqrPO/OR7TutXw0pOpAC9NbhWMxI2qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769209056; c=relaxed/simple;
	bh=6v4rZ9oJpz8LUKiLodEbEuxsY/ZrUiOquPogvNms0iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww5yHxF7j57DmegEPJ5YehSFGAP0cm2C8VhTybkRa/9om6MSlYPM9VkXsM0uCA97vtJJaMbj3NoZv0fd3BDAiFqIpUGs67EtZNFCuMhl45s77lHe2VZYJfyvC1UpmFVaKThzLeuZrNaLuZpW3XUWVkv0Rv3Tg+r97qnfGPOhgYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW7fHD/w; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW7fHD/w"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso1719076a12.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 14:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769209054; cv=none;
        d=google.com; s=arc-20240605;
        b=lDhjkcf92Ji/xUYzs3jJuOVa2O52dX+RtVDmxsY8HJi//s0V/xaIZWV9a+NrXV27sF
         L7HylgOFhGtCU6TO8iSvgBSP+0CJ3Yq9ShQZWN4kMUhCBAuOrRSIes36VDCEnYoublXd
         gLgJsscHVBmWa5Rw0UeNShUp7vL2DH7hKYFoQGA6/h8HU9JiNWjivfdQB3hTPMpRmXYj
         TgNDLzehqO/pMgbhXDKEFfza/w9cKfYbxh40c5fMfaZ6cRNCbEsPk7M6LzgQ3u94ELnA
         rUxIsorvmfs5v+m1bz3jQUmYNRU2U+66Y1i7HuhDg2qhjuqvwHMBDLmKZWesjqnw4AXl
         kSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4j31uslQqJ9kDCp8Ht1kV/SN1veEZSVwfHGiVKs76y8=;
        fh=H01VLxbrqcy8mprO7lU4+jp9vUzqwQgRL4MzmsWHtDA=;
        b=dDTZru7yHNjJUiaoslreIue8cRCEEjVENf6n4ajfpCt3jywiNxeteF6WUwz5zzj/1M
         dMA6QLvBO/Oh9oCjqOUDVw14e6ZY0UI49ViaXGSNHtGCnSJfmU+ZtIBuVBEK8gX3qwCD
         KXj8YSXPHh6yv9YAuLKbDjfmhS4vHECxqij20S5usO399W6z/6AQeQxkQgblgcnXNrDO
         UfkVPwHYs6W5zkCUs6iGeo60eOmpvT1x10HN7biuwVenXkeBWMdLPvVZj4poF7800kDK
         4hzQJePUEjPqw4N4uZRVmu+gk4a5H9R0K1OdAgg2btzBANwd/tnqTqZRCWnuFyXLu9pY
         pESA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769209054; x=1769813854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j31uslQqJ9kDCp8Ht1kV/SN1veEZSVwfHGiVKs76y8=;
        b=XW7fHD/wk8H98YWft98bmxnvQdkfV3uYiQVlHQaL+kL9Kn+SAlKGgLMCZY+vOqncT2
         c7sEQ/ZFPXH8G3eyIRTkxWjXQdxQNgfpXVaqXvj56B3hoTl9i9WMjJD0CL+Eocmx7Wl0
         SYWQXhLSj7WwsuBwbGGEWeJZcXJgMJVCVeaEBPl9A22KoDX+ynkHX2vE/0WqDEV8HN69
         7wJvt4SwMxcJa0ZOjnLfWIaLDCSaK5kzVlv4WzXmY2vsT34ezyNQsXu6spI0K5MO9YnZ
         u9JklG2P9TTavpHWaPUHA4Licl63Kf6QKi0igUo22fIEmoyCSn2NKZWGyoX2QuaCGow2
         zVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769209054; x=1769813854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4j31uslQqJ9kDCp8Ht1kV/SN1veEZSVwfHGiVKs76y8=;
        b=CX164GHUCM1lmEiArtcmsXdhKQ9OkSbCnRnz8aBALrIMBY32jSVKbILHZYrvt5wxcg
         PrvX/dyqIvgO3H5P1YM0+2TDIxAznZeFsZvq5c6PuSvSUqXgXje7IM620DM2aGx0rTXb
         vnSgrYFLRQc3nEVkQC4jq1AQB0jEL1pxy1xoTy2V6fML5scoh7tHc0Cj4ORm/XFUVRXA
         //wWpTCBYvRaL3ySuri+FMjU/We81zuYkCqz/Y9S1gIBkCiK0t4G+ML2Auw11F+dTQcS
         IMfSAxEuAsecCoa/vBuqeS4HBPaJiv8GBL7I9RKL/ZagJJ/sP5ki/hEWe0hubtKXTmql
         xI3A==
X-Forwarded-Encrypted: i=1; AJvYcCU8rE7/1gcyqBrAj+lqt2xJF1pv9DVJca9hYjq6VDc1K8GNRcsM7LqDodCYBzlEWmjgAuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7T3qQI+brbcDixiXtp1fmgtSSipFBEmlkhzVqiSy9fH+KMI7
	756dF9yzks1FubpGy+GzGQIKm6Ou6aOcgzAmSRyOA0UwXRam8ZvjjI5c0D2ScI6Zp4NCVegWmL0
	cXFkzIMvQpyRYCOzAZnlRvUMqM69ood4=
X-Gm-Gg: AZuq6aLzfSmGZuJ7hOkRyJUwJsbyEMv6z4JBf+W9f8jj71hNjiq0u9lnT6o2nI06kMu
	KNI9oz/y2ZOXMvA5BnbujO5FU6sqxRWsgNClw3PkBgzDrO5cNKMC4QyjwZfxml+9xIWsmr08rTq
	Q5apDT5Qx8uf1fvo5pEvfdKGQARBIAQfhp+FjHtZeHYxCgE70tikHnqfDEEukIpSU7gKeGGbcAR
	Hq8SpiTHx97cAbryeOQaLgCXkkRnFwKY86FzhOQuyUF25HFIZS+PLFwB3fGNpzA2uGijhcChg6w
	0iikfCSUWCQ=
X-Received: by 2002:a17:90b:57e6:b0:349:9d63:8511 with SMTP id
 98e67ed59e1d1-35368c42f49mr3571701a91.25.1769209054201; Fri, 23 Jan 2026
 14:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123073532.238985-3-dongml2@chinatelecom.cn>
 <d91544bd4b513290bf468386c0261f913b59b761c34405839c424f8eaf8b1d04@mail.kernel.org>
 <2250332.irdbgypaU6@7940hx> <8632406.T7Z3S40VBb@7940hx>
In-Reply-To: <8632406.T7Z3S40VBb@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jan 2026 14:57:21 -0800
X-Gm-Features: AZwV_QgjtKbg3xcVVs0fXgYTWRVrke_V4VqsUfD77JrusnPTgbwxconkivavg84
Message-ID: <CAEf4BzabUj0APqROb7ibkEovoXVmxbiHq0kNAPWExpEfRmQwiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 02/12] bpf: use the least significant byte
 for the nr_args in trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 1:21=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/1/23 16:29 Menglong Dong <menglong.dong@linux.dev> write:
> > On 2026/1/23 16:07 bot+bpf-ci@kernel.org write:
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 41bbed6418b5..b3f912ad18ba 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > >
> > > [ ... ]
> > >
> > > > @@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_veri=
fier_env *env)
> > > >                       eatype =3D=3D BPF_MODIFY_RETURN) {
> > > >                           /* Load nr_args from ctx - 8 */
> > > >                           insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> > > > -                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_LSH, BP=
F_REG_0, 3);
> > > > +                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, BP=
F_REG_0, 0xFF);
> > > > +                         insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BP=
F_REG_0, 3);
> > >
> > > [ ... ]
> > >
> > > > -                         cnt =3D 6;
> > > > +                         cnt =3D 7;
> > > >                   } else {
> > > >                           insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
-EOPNOTSUPP);
> > > >                           cnt =3D 1;
> > > >                   }
> > > >
> > > >                   new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> > >
> > > [ ... ]
> > >
> > > >                   delta    +=3D cnt - 1;
> > >
> > > Note that the bpf_get_func_ret block above correctly updates delta af=
ter
> > > patching.
> > >
> > > > @@ -23808,12 +23811,15 @@ static int do_misc_fixups(struct bpf_veri=
fier_env *env)
> > > >
> > > >                           /* skip 'void *__data' in btf_trace_##nam=
e() and save to reg0 */
> > > >                           insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
nr_args - 1);
> > > > +                         cnt =3D 1;
> > > >                   } else {
> > > >                           /* Load nr_args from ctx - 8 */
> > > >                           insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> > > > +                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, BP=
F_REG_0, 0xFF);
> > > > +                         cnt =3D 2;
> > > >                   }
> > > >
> > > > -                 new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, 1);
> > > > +                 new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> > > >                   if (!new_prog)
> > > >                           return -ENOMEM;
> > > >
> > > >                   env->prog =3D prog =3D new_prog;
> > > >                   insn      =3D new_prog->insnsi + i + delta;
> > > >                   goto next_insn;
> > > >           }
> > >
> > > Should there be a "delta +=3D cnt - 1;" before assigning env->prog in=
 this
> > > bpf_get_func_arg_cnt block? When cnt is 2 (non-RAW_TP path), the prog=
ram
> > > grows by one instruction, but delta is not updated. This could cause
> > > subsequent bpf_patch_insn_data() calls to use incorrect offsets.
> > >
> > > The bpf_get_func_arg block at the beginning of this patch has:
> > >
> > >     delta    +=3D cnt - 1;
> > >     env->prog =3D prog =3D new_prog;
> > >
> > > And the bpf_get_func_ret block similarly has delta updated. But this
> > > bpf_get_func_arg_cnt block goes directly to env->prog assignment with=
out
> > > updating delta.
> >
> > Ah, good point, I think this is a valid problem. The selftests didn't c=
over
> > this case, and I think I'd better to use bpf_get_func_arg() and bpf_get=
_func_ret()
> > in the exit path of fsession to cover it.
>
> Oh, the problem doesn't have much impact. The only impact
> is that the verifier will check the "r0 &=3D 0xFF" instruction redundantl=
y.
>
> I'll see if there is more comment before I send next version.
>

Let's still fix the problem. Just go ahead and resubmit (with the fix
and improved test).

pw-bot: cr


> Thanks!
> Menglong Dong
>
> >
> > Will fix it in the next version.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > >
> > > ---
> > > AI reviewed your patch. Please fix the bug or email reply why it's no=
t a bug.
> > > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/R=
EADME.md
> > >
> > > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21=
278745581
> > >
> >
> >
> >
> >
> >
> >
>
>
>
>
