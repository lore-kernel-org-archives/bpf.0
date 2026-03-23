Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5A3CAE80
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288968; cv=none; b=imYCDmNJlGIxPp3OFMdi/zgPz5c/BdUmNHYZ1d0Lyv4kUTMhccKHxS4MUVz0bDvrEtd+iAOME9Vh+IS8dFuVrbuz8Wftmq6nOtGFNT0rsB9qSKasx9kebGUEts+4IBjIKcbIi6Vryg86SI4W0+GXq8F8umPLSng3N+vkp8cdSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288968; c=relaxed/simple;
	bh=buz/4Z3IxsFFKAI/g14wND3Qg1tMC2EIF7ZHSwQNuqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXOev35PYvcBNLQjjy0wIWR5dri3l+/GIw26E5duYV1sY8vZmA6mOG0DPcv0UZ8/mUlr/qyO8wf7pnsxv+Mqo7aFk4yyhIliYuIfGCK/IcNj29r0P67pazXJaNU3fUD77VTGXgBkpfKLBlTmNidVD6DhA0xmMay/Zm1Lln5Tq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR3PW0/G; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR3PW0/G"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9694so7875341c88.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774288966; x=1774893766; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ODdUVNgG7bGt1GuKwcCVxsOkfc2iBduHU5qLrd85Wqw=;
        b=FR3PW0/GtsZJi4fcoIa02wsxWqrq0EMBMOSRReN9SyRSbcgZLN2JElE3rOVHCXvXBE
         zeE1xDEQUqhR0ZdLkHMniL7VDajhPOqRHittu+hUFqayj0bD0FZaM38XaeupDxFcJQIf
         A0bdX5xl7a7kmZtRntFEKFUpUFsUXmaPbTMvMpTJKIHWyAVtrNn7moND9+wBhO7AVIT1
         HWSAocHAZwGIYh3KNhHciiqzO7LaBJsie4KZ9cS+wuhJpVPLq7j2CKpigqpfb+ZmoiEi
         WBRy/zVwEFtHz/4g0VkOKSzFld3Ppxy/tWhOsgpJaUv4vSI4Pn724qyegrgIN2GUbUdt
         38VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288966; x=1774893766;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODdUVNgG7bGt1GuKwcCVxsOkfc2iBduHU5qLrd85Wqw=;
        b=baa1MySLz4ipcdVaBKmpjDCHnt5C0NcUzanaccjUXBREc6pd1bvLwJXuYWujh2GHds
         FVi7P9gWHl9o0yBBowmRI8mYjgCv3ZM6QZQ9nCuI5dsHtKyfJwtlrUmf8vbIJuaFHAPn
         dH3ZlLRbPNRn274RLIMgy9QJnk/JkXa+VE4K9hs1BjbGy4sV3b1W0iv4BMUcWP428Q+9
         5sgLzq8fIa8/43Co3wolqpDXlxu45DoRwtJCaQXn/a2vRjpYa5sMLt18CE3YVXwn1l0h
         C2+nFTYuCWstUvk2Q9S+947qtDlm+vuqfvJrsOZKJkyWDn542UZ6iHt78M3GMrrq37um
         5CZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV30wqZTY+Q2k56w3Snhp23qitjtFIuIaGF7/eRLGLl6fyczWOMxDuBDGMNC//XputaEhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyw3CuBtsH/u4Cntx48mQUyRZM6bsypPIauuLRExqQl0oCBZ7
	WVyauG6U5v+S0YKMLX6jcZ/JS6X6P/jxW7rUz91Vs6Wp/WlZenpcuBQk
X-Gm-Gg: ATEYQzzuRYdOTNBFPXIr1u2ot9q1mslXpamKtAUJc3Lu5SfGjs29NqRMX/2IeYG4mlc
	64yjSCg7zUrxO4JZjvJFyDp2G4tH/UFIkZF1/K3N0tBRbiIL6LcrounGO1seimmvgMClK0sBNYy
	SLZOvhl7sjrwPCPBhezorod61RM5d3N1DoaU0jKpOBMgLWgEllnCH/viL1Z9oa8KKUpYRsqeHw1
	/D24j4NQs6IKDxzYy9oxeBFoAb5H/mW3IcUZNeUBvgHgioUIGdjo/x0OE8Me5oUVHKOZeqyPORV
	ePtMRB3tTwSaDLl7R6oIJmASWURAfRJ9yvGrbKkvuwUD6seu0WtnRNC/iIsLAfBhTHkZegxKkPY
	TuzM1sbjk0iegWU37M6T3PbkSTerckItumcYHDRYcoYd5xwQ2bBBWxsgdastz2w1EsgRRG8JD3D
	qpbBupYIprCkp/Ut1vgR0wLkAxLVTIaWinDnVwcJm0gIsWHaP4imN8BozYu8CrExsxMBDk0EwT2
	mIUMFA=
X-Received: by 2002:a05:7022:4594:b0:128:ca6f:adf0 with SMTP id a92af1059eb24-12a72676781mr6485897c88.17.1774288966472;
        Mon, 23 Mar 2026 11:02:46 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:45ca:895c:22d:457a? ([2620:10d:c090:500::2:8b17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29b447sm13241535eec.16.2026.03.23.11.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:02:45 -0700 (PDT)
Message-ID: <4e6dd64a162b3cab3635706ae6abfdd0be4db5db.camel@gmail.com>
Subject: Re: [PATCH v3 bpf 0/4] Fix invariant violation for single-value
 tnums
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Mon, 23 Mar 2026 11:02:43 -0700
In-Reply-To: <cover.1772225741.git.paul.chaignon@gmail.com>
References: <cover.1772225741.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-27 at 22:30 +0100, Paul Chaignon wrote:
> We're hitting an invariant violation in Cilium that sometimes leads to
> BPF programs being rejected and Cilium failing to start [1]. As far as
> I know this is the first case of invariant violation found in a real
> program (i.e., not by a fuzzer). The following extract from verifier
> logs shows what's happening:
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
> More details are given in the second patch, but in short, the verifier
> should be able to detect that the false branch of instruction 237 is
> never true. After instruction 236, the u64 range and the tnum overlap
> in a single value, 0xf00.
>=20
> The long-term solution to invariant violation is likely to rely on the
> refinement + invariant violation check to detect dead branches, as
> started by Eduard. To fix the current issue, we need something with
> less refactoring that we can backport to affected kernels.
>=20
> The solution implemented in the second patch is to improve the bounds
> refinement to avoid this case. It relies on a new tnum helper,
> tnum_step, first sent as an RFC in [2]. The last two patches extend and
> update the selftests.

[...]

Hi Paul, Harishankar,

Apologies for resurrecting an old thread.
While reviewing the recent series "Fix invariant violations and
improve branch detection". I notice that we have a single test case
broken, with bisect pointing to merge of this branch.
Details are below.

There is a slow mode for reg_bounds* tests,
it can be triggered like this:

  env SLOW_TESTS=3D1 ./test_progs -t reg_bounds

In this mods reg_bounds* enumerates some cases not processed during
the regular CI run. One of these cases fails with the following log:

  ...
  19: (bc) w0 =3D w6                      ; R0=3Dscalar(smin=3D0,smax=3Duma=
x=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
                                          R6=3Dscalar(smin=3D0xfffffffe0000=
0001,smax=3D0xffffffff00000000,
					            umin=3D0xfffffffe00000001,umax=3D0xffffffff00000000,
						    var_off=3D(0xfffffffe00000000; 0x1ffffffff))
  20: (bc) w0 =3D w7                      ; R0=3D0 R7=3D0x8000000000000000
  21: (1e) if w6 =3D=3D w7 goto pc+3        ; ...
  ...

  from 21 to 25: ...
  25: (bc) w0 =3D w6                      ; R0=3D0 R6=3D0xffffffff00000000 =
<---- unexpected value here
  26: (bc) w0 =3D w7                      ; R0=3D0 R7=3D0x8000000000000000
  27: (95) exit
  ...

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  ...
  ACTUAL   TRUE1:  scalar(u64=3D0xffffffff00000000,u32=3D0,s64=3D0xffffffff=
00000000,s32=3D0)
  EXPECTED TRUE1:  scalar(u64=3D[0xfffffffe00000001; 0xffffffff00000000],u3=
2=3D0,s64=3D[0xfffffffe00000001; 0xffffffff00000000],s32=3D0)
  ...
  #319/1007 reg_bounds_gen_consts_s64_s32/(s64)[0xfffffffe00000001; 0xfffff=
fff00000000] (s32)<op> S64_MIN:FAIL

The test case can be triggered manually as follows:

  env SLOW_TESTS=3D1 ./test_progs -a 'reg_bounds_gen_consts_s64_s32/(s64)[0=
xfffffffe00000001; 0xffffffff00000000] (s32)<op> S64_MIN'

The verifier produces a more precise result here because of additional
information inferred by tnum_step: lower 32-bits can be equal to zero
only for r7 value of 0xffffffff00000000.

Which implies that reg_bounds* test logic needs further adjustment.
Could you please take a look? Please let me know if you see any viable
routes to amend this test.

Thanks,
Eduard
