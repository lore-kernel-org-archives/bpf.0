Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B03254AF
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413534; cv=pass; b=QQhZHT+gZMipk9p1Sb2OjM62bSLz3jTCgZcp0cJErojhPXE4h928hAHEglT7ihpgMLGBMa2i/xQ/Gm8+OcOFMZNA6fN19g5ADqnqapfb71Qlx6n7MFxcavo8qNP+xLlrk6b5BfQ5QmqHyuGJMtw5HM2wx/GLZoVAnlH7slq1k6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413534; c=relaxed/simple;
	bh=M40TG7c9r5snh3t+V3TfavDILSqPtNcNAuyFiLGJGqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCIf9cMjZS7W+/3qnGGm0nAJn7tPeN1MlceQ4eiHndNY6gFZuNwsSdIG+7J3Ba4K/U/N9X9wnEbWsn/x7Cw298Xw9pOOOXTk6d/dgZvoK4LEIGfCMvp5PJTm+ti2fZMpzWGBvQWIZuzitwNvAI2nqE6+1TfQBxk1u+heeAhm3EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNH26si3; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNH26si3"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664c4a04081so3316553d50.2
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 01:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783413532; cv=none;
        d=google.com; s=arc-20260327;
        b=as0nF71e9CKww+BkMCZ/dz66DYf2vfjBceKeRVXCC2DuKy679cN2OIUhSLCM09m1KI
         J7jMhC86hdduNFs5n2hZh1RY7YCg6bgCAz3Xf4i1XfldxZrhmtpT6kA79gR5EAmAp7kF
         VG03o8wI3KnEINeolJ9lj2aCJW+KKjMZX8aZvA8iagpGTc3EBUgvMTOBlwvwtmqh9aLW
         CtyACeewdEa7TV+eJwOEw19bUnfhoanQN/4PbJCJZDIB16h6yRMGVJbWEUxtfr+RzgIn
         //Qv61p4jXeBqhMfXORYtw25jAY+hS8/VLIrWyHgjErEToaySippjObhm15/MQh4jjJQ
         h2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZomEEGTGH2mnRXgq1g8Tg7V1t4BtL5TuXlvu5Cqrtjc=;
        fh=Gb2jYWfnRE9tiVrycsLqut9UaWgVu/muX8TeT6TC36A=;
        b=DOeKxN7+qq7mDuTpVd0fDqFoFzzQA1QsBZQ1fCHTE2r5c2WPDq+xXXL0DSPGE9Z5pb
         M989ggxuj2+gKN8G28unWAbXspVKSQW9fMioTbFlRg6tDVGegu+FbEqfQdj0wuE6ijho
         Qs0GqpuS95Rh/blZrH0PRyGL+xXWtL3fZLbskA7B58ckTkzKGm9/on3tQGrxQGSvs3LZ
         2SVeMo4cr1lgPeozdlx+QTmdUIffQU2Ur+YTEqCu831O6J6UfUR9xAp9ftNTBK1XpE9v
         vwRFRe4ReXqRQCywA7mj3onC/18rFuIL6ES/xaSuv+dNkBX/0qRr/PurDoZZCcXkfJm+
         ThzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783413532; x=1784018332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZomEEGTGH2mnRXgq1g8Tg7V1t4BtL5TuXlvu5Cqrtjc=;
        b=gNH26si3xv8pRCak+aiWVcJCFh8lqS5+ZsSwyxX813srdAjMVpwBdGaywHqoc8ZyXk
         ylmkGKSQn8uOXT7ewh9FpLTWcokaEni3YVFLxUYdP0FV+gGsA1Yn/d5p7MjrVXabZHyx
         OYP0rusFu/zsBnqYOK4v1pnL25gGg1R5crHgR9jMdg8o3wmK1mVchdHxLPruZ6TutUXh
         0tah74ijcNbd/BP7eB2z/nQj2IT2b15izx/kI/nq3MScvtecIllmn/Ki6MwnvGx4TvVQ
         BrX6SngToTbCTdN8YbJgofEhAXe8ayDySBn7a83ihXinsuWv8u6QOIGpH4ne5ZrIhkYy
         oIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783413532; x=1784018332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZomEEGTGH2mnRXgq1g8Tg7V1t4BtL5TuXlvu5Cqrtjc=;
        b=XAqYJomk785am0uaimfvymOpfntnguNGOyWtE24wCCfPlbxEuw4I/7s6ZdpLloTqv7
         z6hv0NyVVrWLp686UFpD6PkPbw67alu/D2onpfpEgcIMi1Df6kQv3kmoM6H4IulptPOZ
         vujeihTR3ttTm+QMXPM8uM/VfHhOaHy/unSoL2ACS8wPeBqtux5dj4mQgaoDWb/07qJi
         jXEZjCqgSacJA9j8x8KMA9ceaza1t6BPoH2P3EI32FwjjsQaY/4bvn/deKPUO4kGpm3k
         zbvqkp8VHwif+OM4SLCB6xf6NF3Qb+8QFA3OsYjOn/sXPRdAcw7UECi7Yo36CZWtj7HV
         3W3w==
X-Gm-Message-State: AOJu0YwFLvikOsiLKo0SUBnqzHDsYzGQ2EvaKB5BiHpVHClCbnWQS31j
	uTtTgbDR0fjxhSHUEU8U99MXFlefaSTNYxg+6ENWiXJoId2qW2U5Szt4u8iN13KSHTHFfkoGDGV
	6nc1x9R89cVIFafNsar6geHx7t1LKRX92e5NSSXzImg==
X-Gm-Gg: AfdE7cnPVhm4z/OmBUxl/pchhrtMgrANPilbogNWgLEjBv2OlbvRCx8xRCoKKC1UqO2
	MiTtdCRtrMFRKpuPY8OYgF5pffBbTedrOn9kD93aopfxue9oYd9+yt32jHpBmqZU40RRqou2Imv
	eZcgGBnTVyop1OHUOTFJFAlZ073bc51Fg9SZs1Q3S0IVghwESG23idUiDt9nzY1pmHwLq19SULM
	sNsaSgo1mqOpf7+2SRbP7yakQPM/usNo3dnaNpYALq5wXm4Bi3FKk7bmjnCNUu+sle9o7mKPtZQ
	rUOBKkckd8iAl6LG57G1gFtNZI5efgW9jeNwSpR8
X-Received: by 2002:a05:690e:12cb:b0:664:dbfc:e454 with SMTP id
 956f58d0204a3-6677fa53cd3mr3038526d50.3.1783413531695; Tue, 07 Jul 2026
 01:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707060804.93561-1-sun.jian.kdev@gmail.com>
 <20260707060804.93561-2-sun.jian.kdev@gmail.com> <akynPc5YJKD12963@u94a>
In-Reply-To: <akynPc5YJKD12963@u94a>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 7 Jul 2026 16:38:40 +0800
X-Gm-Features: AVVi8Ccml7vKiUy3CRrWyBg3h2LKdgMnGaOrJjZ3WaoHakhkVoHtqOvoDbMJT8Y
Message-ID: <CABFUUZH44FfBqFdKhs8JdJrrB9_XqOzm-rTAsShbNLn0ZXOhcw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Reject negative const offsets for buffer pointers
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 3:17=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> Sorry I missed that there was a v2 already. Reposting the comments I
> sent to v1 below.
>
> On Mon, Jul 06, 2026 at 11:08:03PM -0700, Sun Jian wrote:
> [...]
> > @@ -5344,6 +5348,29 @@ static int __check_buffer_access(struct bpf_veri=
fier_env *env,
> >               return -EACCES;
> >       }
> >
> > +     var_off =3D (s64)reg->var_off.value;
> > +     if (check_add_overflow(var_off, (s64)off, &start)) {
> > +             verbose(env,
> > +                     "%s invalid %s buffer access: off=3D%d, var_off=
=3D%lld\n",
> > +                     reg_arg_name(env, argno), buf_info, off, var_off)=
;
> > +             return -EACCES;
> > +     }
>
> Other pointer offset checks (check_mem_region_access and
> adjust_ptr_min_max_vals) seem to check var_off against BPF_MAX_VAR_OFF,
> and that `off` being >=3D 0. It would be great if the convention can be
> kept for consistency, albeit being more conservative.
>
> From a blind guess I would guess that compiler does not product a
> pattern where `off` encoded in the instruction is negative but the net
> overall offset is positive for PTR_TO_TP_BUFFER/PTR_TO_BUF, and
> rejecting such pattern is fine.
>
>   r6 =3D *(u64 *)(r1 + 0);
>   r6 +=3D 16;
>   r0 =3D *(u64 *)(r6 - 8);
>
> One more comment below.
>
> > +
> > +     if (start < 0) {
> > +             verbose(env,
> > +                     "%s invalid negative %s buffer offset: off=3D%d, =
var_off=3D%lld\n",
> > +                     reg_arg_name(env, argno), buf_info, off, var_off)=
;
> > +             return -EACCES;
> > +     }
> > +
> > +     if (start > U32_MAX || size < 0 ||
> > +         check_add_overflow((u32)start, (u32)size, access_end)) {
> > +             verbose(env,
> > +                     "%s invalid %s buffer access: off=3D%lld, size=3D=
%d\n",
> > +                     reg_arg_name(env, argno), buf_info, start, size);
> > +             return -EACCES;
> > +     }
>
> If we check that var_off is within BPF_MAX_VAR_OFF and that `off` is not
> negative, then `var_off + off + size` should be guaranteed to not
> overflow max_tp_access, since the maximum of `off` is S16_MAX and the
> maximum of `size` is 8.
>
> > +
> >       return 0;
> >  }
> >
> [...]

Thanks a lot for taking a look!

This makes sense. I=E2=80=99ll rework this to align the buffer access check=
 with
the existing verifier offset convention, including the BPF_MAX_VAR_OFF
bounds, and send a v3.

Thanks again,
Sun Jian
