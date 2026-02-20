Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22B311C3D
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771630028; cv=none; b=OSf9yg5IwcggVpNz4fV068BcGOV4BmPirQycEwavveQvNDzmdopy9l8nXSeKHwnU2XRRmWB28n6n6Yc/55EYw8k/9jBmeOtQswbplUmtGCj0LsjpPzMWWbqVf1S1x7wOAGS3tLiwM5hyl5V3Hx7ZM66n8RYHKr/oeF6PyREbIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771630028; c=relaxed/simple;
	bh=aSoTNv2AhVAwf1ps0MFuTo6uZzoq8CsNQHzVz9Nu9ag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CspnkaxsI/9Gl8f1Ab+qVEEGZb/LKompuVwW16ucoe0VdFz4DcLSydaulaIr0C7QIHW7pad2u3zvtlbi5gdhYI6D3Hjaclk76XdFsI+ykMz/OoH/Ub3YUcy1baaJkQOEEH+ABwnEnw2Ee3zbjlu4r3g/yAtT1Fn354xypDFPodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIHyRsJk; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIHyRsJk"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-127423bea4bso611737c88.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771630025; x=1772234825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nSo2E5papyeCp4YuIQodtnge+pLmvg0/6Xep64bPZzE=;
        b=YIHyRsJkG6gn0EAfdqDlC4Ubg1/c5JitK7ST6h6o60H/kOe6xTjBtw7qvP0nhtL+E5
         1rL/hrCG2wOXXMqfKTWfpSspu22OU1m8RYEI4gOSh6gk89WNi8qyrlBB1j+s0/uMe3U+
         ytFAT0FSZUsuaOgocAM0UbUDMyRfEv/ePNmORBSRpddpXMmSpkEBSSdI8OFrytbxMR2n
         KmFjRqX3B4vltHfzaKsN45nBxzuOJZNwiNjnXRWkUAHPp6UYl0dXP9nbVehb9HL5pmE5
         fDA5bjk2vktbTgxQNxfdxk1ESg+UfIfuIRnw2RPuwK2TigSKmp/DrrFHToiQYeTMYMqi
         QJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771630025; x=1772234825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSo2E5papyeCp4YuIQodtnge+pLmvg0/6Xep64bPZzE=;
        b=X0HKP1BTJvf0UqY++i3507qamlHpDFDfnLgcWymzmnKNJa6tigakXT7AJ03B7z35fR
         3jI3IJj2KvjyOxIsGb1YOSnsYQlRGwphmamCfvrVk2eHnIkeas4oa9G2xTtxaRoQliOn
         YVXi3ektOgDiuGqCFXYPSwSAaxy3jJX3bfXyPsG/vMfuOrKvwq7OAt3t0rcIN9ZALBkb
         /nldwYUor2vi45co7zizDFv9bG/ohlslpjkV05RTkOOWz7M2sw46OEjUxBi1EdeMtg2e
         HzNo9bl73/gTyJXkc5xXtzDYqMQFdN1kWnYfmyqPs61zzr8B7Yx8kOoj+lB2XTK1txln
         bsEw==
X-Forwarded-Encrypted: i=1; AJvYcCUyShidh1xEAF6fY8mu8u1otj9dvnK4ZQiXN1J7MNasrbmkFIujKGy6Q6zNAoSrPlBklqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL2A+IuzjjMZrE4nTJOLWh/UleTYPVxJIgaBt5PBQRe1GZJ5kJ
	Jjw+YORniaFOuZcjAofcN8e5EBKCTMRzFWUJo3vdEL4PjM+mP6hlKfa5
X-Gm-Gg: AZuq6aJjVrCxSw9S2Wy7ixG1B9PkHvrcEk9NBPjQpB1Xin41v7Iz/fBu5mvGShZdfkN
	7XrN0RIFByknzKb7KmUu60zw+FDIxoVmftjUu2JmstHa+VZGcxifmIsIhkYr8V62hy3XGmWmHAu
	A1kB2xrycsFZHnMr4W9L+mBjyjOTxxGpmhQYRo+Of1sryCW9jkso+Jgjt2/Hh5LuKBIbXZoKICx
	lemybbpEY/MDnbO3Xf9T7YSIGIx+8bhb9QaKPHgfzSBM05zglBIVq0ftYz/BkO8nTC9wCJBanvz
	FVICQf5lALfd2PjdBbrA15ebrOTh4Nqcb2EqcXRp754hs/aNS8vyNAO3OvDhvxRHRVlvGT3hbEB
	TqMVc8+RwUOWybge8mx14AnrzPDC7ALym1SE2ol0VWD6/t2PH2LjT5Yu5bfKTu7VuQKp3WtpKXb
	KfMRX0f/Ke4RlNRsaOg60Dk44J3RmBHP1boOYymHJX80IO78xZm2yvMdlz/g2KMXuIMV7Yd4KwV
	Lkz/bjG
X-Received: by 2002:a05:7022:e1e:b0:124:8d7d:2d63 with SMTP id a92af1059eb24-1276ad37c89mr611083c88.35.1771630024901;
        Fri, 20 Feb 2026 15:27:04 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dc10:521c:4103:cf1e? ([2620:10d:c090:500::1:a80e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc1618fsm385639eec.23.2026.02.20.15.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 15:27:04 -0800 (PST)
Message-ID: <d3efae584c828032fb36711f3afc6933fbc160ba.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Fri, 20 Feb 2026 15:27:03 -0800
In-Reply-To: <ff1f2d06609189ce93bbf8702031069b986ddd99.1771594636.git.paul.chaignon@gmail.com>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
	 <ff1f2d06609189ce93bbf8702031069b986ddd99.1771594636.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 14:57 +0100, Paul Chaignon wrote:
> We're hitting an invariant violation in Cilium that sometimes leads to
> BPF programs being rejected and Cilium failing to start [1]. The
> following extract from verifier logs shows what's happening:
>=20
>   from 201 to 236: R1=3D0 R6=3Dctx() R7=3D1 R9=3Dscalar(smin=3Dumin=3Dsmi=
n32=3Dumin32=3D3584,smax=3Dumax=3Dsmax32=3Dumax32=3D3840,var_off=3D(0xe00; =
0x100)) R10=3Dfp0
>   236: R1=3D0 R6=3Dctx() R7=3D1 R9=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=
=3D3584,smax=3Dumax=3Dsmax32=3Dumax32=3D3840,var_off=3D(0xe00; 0x100)) R10=
=3Dfp0
>   ; if (magic =3D=3D MARK_MAGIC_HOST || magic =3D=3D MARK_MAGIC_OVERLAY |=
| magic =3D=3D MARK_MAGIC_ENCRYPT) @ bpf_host.c:1337
>   236: (16) if w9 =3D=3D 0xe00 goto pc+45   ; R9=3Dscalar(smin=3Dumin=3Ds=
min32=3Dumin32=3D3585,smax=3Dumax=3Dsmax32=3Dumax32=3D3840,var_off=3D(0xe00=
; 0x100))
>   237: (16) if w9 =3D=3D 0xf00 goto pc+1
>   verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds viola=
tion u64=3D[0xe01, 0xe00] s64=3D[0xe01, 0xe00] u32=3D[0xe01, 0xe00] s32=3D[=
0xe01, 0xe00] var_off=3D(0xe00, 0x0)
>=20
> We reach instruction 236 with two possible values for R9, 0xe00 and
> 0xf00. This is perfectly reflected in the tnum, but of course the ranges
> are less accurate and cover [0xe00; 0xf00]. Taking the fallthrough path
> at instruction 236 allows the verifier to reduce the range to
> [0xe01; 0xf00]. The tnum is however not updated.
>=20
> With these ranges, at instruction 237, the verifier is not able to
> deduce that R9 is always equal to 0xf00. Hence the fallthrough pass is
> explored first, the verifier refines the bounds using the assumption
> that R9 !=3D 0xf00, and ends up with an invariant violation.
>=20
> This pattern of impossible branch + bounds refinement is common to all
> invariant violations seen so far. The long-term solution is likely to
> rely on the refinement + invariant violation check to detect dead
> branches, as started by Eduard. To fix the current issue, we need
> something with less refactoring that we can backport.
>=20
> This patch uses the tnum_step helper introduced in the previous patch to
> detect the above situation. In particular, three cases are now detected
> in the bounds refinement:
>=20
> 1. The u64 range and the tnum only overlap in umin.
>    u64:  ---[xxxxxx]-----
>    tnum: --xx----------x-
>=20
> 2. The u64 range and the tnum only overlap in the maximum value
>    represented by the tnum, called tmax.
>    u64:  ---[xxxxxx]-----
>    tnum: xx-----x--------
>=20
> 3. The u64 range and the tnum only overlap in between umin (excluded)
>    and umax.
>    u64:  ---[xxxxxx]-----
>    tnum: xx----x-------x-
>=20
> To detect these three cases, we call tnum_step(tnum, umin), which
> returns the largest member of the tnum greater than umin, called
> tnum_next here. We're in case (1) if umin is part of the tnum and
> tnum_next is greater than umax. We're in case (2) if umin is not part of
> the tnum and tnum_next is equal to tmax. Finally, we're in case (3) if
> umin is not part of the tnum, tnum_next is inferior or equal to umax,
> and calling tnum_step a second time gives us a value past umax.
>=20
> This change implements these three cases. With it, the above bytecode
> looks as follows:
>=20
>   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
>   1: (47) r0 |=3D 3584                    ; R0=3Dscalar(smin=3D0x80000000=
00000e00,umin=3Dumin32=3D3584,smin32=3D0x80000e00,var_off=3D(0xe00; 0xfffff=
ffffffff1ff))
>   2: (57) r0 &=3D 3840                    ; R0=3Dscalar(smin=3Dumin=3Dsmi=
n32=3Dumin32=3D3584,smax=3Dumax=3Dsmax32=3Dumax32=3D3840,var_off=3D(0xe00; =
0x100))
>   3: (15) if r0 =3D=3D 0xe00 goto pc+2      ; R0=3D3840
>   4: (15) if r0 =3D=3D 0xf00 goto pc+1
>   4: R0=3D3840
>   6: (95) exit
>=20
> In addition to the new selftests, this change was also verified with
> Agni [3]. For the record, the raw SMT is available at [4]. The property
> it verifies is that: If a concrete value x is contained in all input
> abstract values, after __update_reg_bounds, it will continue to be
> contained in all output abstract values.
>=20
> Link: https://github.com/cilium/cilium/issues/44216 [1]
> Link: https://pchaigno.github.io/test-verifier-complexity.html [2]
> Link: https://github.com/bpfverif/agni [3]
> Link: https://pastebin.com/raw/naCfaqNx [4]
> Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail=
.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
