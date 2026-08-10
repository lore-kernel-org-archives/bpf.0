Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3F4334D6
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388189; cv=none; b=O3RLh0yLD2Wz9W6iCry3p2Iqrkts4E7D2aVwEoLcKRNeoRjoG7Q6kc6Pl+/uvOifNQSyxenL7kPvLVE2xDBr1UejxBuM+gZ/+3MGUUrjxDVvqjUQXDoZ9PCi2kqOJXbfKsfoEvEMHuroBbLVOdbssHPb5TNSMqNJV/4lpzAGiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388189; c=relaxed/simple;
	bh=0gDLuOaMS08VC+E9jAEALEzI1OohQL3X+dH4d8r2m20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A13Bhwi8T0mnMklyN/jFTANLQdZ72pIEuUlDMjjqOA3GeOPsn8qa43bOrsZlg8gmbhv2V2dtydufTWDGZuDGK/4THEqIIGij8pIt+ENqfi4nG3aGp/fFR6n6u3FHFOZ3h4mQTQBCvWPDyXMGtoQF9+qIXYHgNxHCwAT68CtV6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA7r61Xj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA7r61Xj"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so76665a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786388187; x=1786992987; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vj27TkZ20qlFYOECm6SCAcAdJIzt+j+Cwrca1Ku2d7A=;
        b=YA7r61XjK7fzxOrANiHaArxFJrvSRGhhtyIS6dUG6S3T/l3PBmktlACWKbCGUxgAtV
         c4AmNV28GF6o2wSfePceiA+ff63PeOLLhYwexblHUc3QvM2zrYozB6lMDPuIzDLedbO3
         WO9svPbwY//m95WK/lc6SW250f+dt/ntssOjcrx7Zkkexn39fWe+I6KKEWGJGWT9fzZm
         WzJeTRMtx0flSgYZAfC7wA+SBhk+xdbmgsc4qPZhd/nc9bvfl9ZL+Rn/KZ3oc6nPpJvw
         XOWPMOBRzDrLN7ip4xJgoLXrMEzgfAzkBzEpUEpI4oInwuCFl4x6WstMuPJ5lIwWM0O8
         lxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786388187; x=1786992987;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vj27TkZ20qlFYOECm6SCAcAdJIzt+j+Cwrca1Ku2d7A=;
        b=st9ucWwZwhvnhL4KD29yG861w7GJZkvFTFF9euMPDzLzYgtesP51P5V9bio0KhJTcd
         X7Z/HUSUXOPQ5GO9G8y5O20D8KccS175mUBt9vbVhg5X0giouMMJVo/d4usXEdyeaJLu
         RMdrfftRKcB/wIBs8AemFwc5nmGFBJCjwnNYwlr/JbP4Yz6+LvRBmD9S0nTph4Mlo1Zy
         lxxWWdQumxLTcuTF6jZb58jxO1t2RLBUznzn2w5ughn2kkQanOd1Y0rkwbSCH81t86Mg
         Aqqx07NqWFJKXYgfYGIXHVaHWZzJ+DBmfXiVIJ7uMNDQlGG9MNkcdRw5h1NiNpht0mXU
         Scbg==
X-Forwarded-Encrypted: i=1; AHgh+Rpl20kSK24+u0Q0wIc/0fkSLHePfRZJHF0KuxRY4+o1b/AJzrzU3Aof7op4DIxiRF3Lsxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDcLZjRfWLlJmi1MO4XgDv2bzdYk0sZNbyZOEwvmqaWXz2gSF
	13Uklllz8oH0KRp7hbd57gB9+T2wAQtQ6O2vO/dKMNFOSI1gsJVCEOFV/L8oTw==
X-Gm-Gg: AR+sD12yexbCFX4zzVWG1DUseJxhOReaxkLPvKlgjOa7te8dpIblEyaxYjGJoisAaWq
	HIYo7QvpWDfk8piDTmJKHUUy3hq1tD1CgqQ+Q9W4gCNWbDs4xwFKfHRfYpz/+1CGACTH0WmYwy/
	JM4QaoDPE89wpbGYlVtaiCDozoowfiMNxx+cAEOQLx6jkxt4P9zVBRCDzLJRXho1sAhGV+uyCz0
	dvIRLRWIFbPCtC2rl2A15IlGpISx/hl+2A4YLe8FvwMbz6pbLpeuqLbt+D4rplFPS8TAygLNtya
	Y3Ivy5iM5InDIZHrED1j+fs6CiYJExS1WCua+XEDiwx9wjLHBMBxRSnoGAnwqulfxv/Oj3pku28
	VqElQwT/Y+Ou/Bz0UP1MSFQSinJw02rOumNQJMgDMX3+35FYBIlDi+a6YNcg9lCvQM5UwqN11th
	9fyXgxkYhOwr3TgKwNWln7Ks/U78TF7LimQWnO149eGVZzijbvwypMKTSZzCSaqag7pJFls1dp/
	iPFf+l3zCVILTu7w20sh+2sHJ8=
X-Received: by 2002:a17:90b:3f43:b0:37c:6130:7a5b with SMTP id 98e67ed59e1d1-3903c54302bmr47501947a91.8.1786388187458;
        Mon, 10 Aug 2026 11:56:27 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51b5e02sm654396a91.5.2026.08.10.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:56:27 -0700 (PDT)
Message-ID: <3cc323f3c287b428d6b6451c707edaabfe5c865c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: Add arena fault tests for
 atomics with fetch
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, bpf@vger.kernel.org
Date: Mon, 10 Aug 2026 11:56:24 -0700
In-Reply-To: <20260810134346.466004-6-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
	 <20260810134346.466004-6-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 15:43 +0200, Daniel Borkmann wrote:
> Add stream_arena_xchg_fault and stream_arena_cmpxchg_fault next to the
> existing read, write and load-acquire fault tests, covering the two
> places a read-modify-write can deposit the old value: src_reg for a
> BPF_XCHG and r0 for a BPF_CMPXCHG. Both cover both halves of the JIT
> bug that left the fetch destination alone when a RMW on an arena pointer
> faulted:
>=20
> =C2=A0 - the fault has to be reported as a WRITE, and at the address held=
 by
> =C2=A0=C2=A0=C2=A0 the destination register, which __stderr() and test_ad=
dress() check
> =C2=A0 - the register receiving the fetched value has to be cleared by th=
e
> =C2=A0=C2=A0=C2=A0 fault handler, which the programs check by poisoning i=
t before the
> =C2=A0=C2=A0=C2=A0 atomic and returning it, so __retval(0) fails if it is=
 left untouched
>=20
> Note, the atomics are open coded since linux/filter.h cannot be included
> alongside vmlinux.h.
>=20
> =C2=A0 # LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' ./vmtest.sh =
-- ./test_progs -t stream
> =C2=A0 [...]
> =C2=A0 #464/1=C2=A0=C2=A0 stream_arena_fault_address/read_fault:OK
> =C2=A0 #464/2=C2=A0=C2=A0 stream_arena_fault_address/write_fault:OK
> =C2=A0 #464/3=C2=A0=C2=A0 stream_arena_fault_address/load_acquire_fault:O=
K
> =C2=A0 #464/4=C2=A0=C2=A0 stream_arena_fault_address/xchg_fault:OK
> =C2=A0 #464/5=C2=A0=C2=A0 stream_arena_fault_address/cmpxchg_fault:OK
> =C2=A0 #464=C2=A0=C2=A0=C2=A0=C2=A0 stream_arena_fault_address:OK
> =C2=A0 [...]
> =C2=A0 #466/5=C2=A0=C2=A0 stream_success/stream_arena_write_fault:OK
> =C2=A0 #466/6=C2=A0=C2=A0 stream_success/stream_arena_read_fault:OK
> =C2=A0 #466/7=C2=A0=C2=A0 stream_success/stream_arena_load_acquire_fault:=
OK
> =C2=A0 #466/8=C2=A0=C2=A0 stream_success/stream_arena_xchg_fault:OK
> =C2=A0 #466/9=C2=A0=C2=A0 stream_success/stream_arena_cmpxchg_fault:OK
> =C2=A0 [...]
> =C2=A0 Summary: 4/22 PASSED, 0 SKIPPED, 0 FAILED
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/test=
ing/selftests/bpf/prog_tests/stream.c
> index 15dd3ae2a84b..e4e9374309e2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -105,6 +105,10 @@ void test_stream_arena_fault_address(void)
> =C2=A0		test_address(skel->progs.stream_arena_write_fault, &skel->bss->fa=
ult_addr);
> =C2=A0	if (test__start_subtest("load_acquire_fault"))
> =C2=A0		test_address(skel->progs.stream_arena_load_acquire_fault, &skel->=
bss->fault_addr);
> +	if (test__start_subtest("xchg_fault"))
> +		test_address(skel->progs.stream_arena_xchg_fault, &skel->bss->fault_ad=
dr);
> +	if (test__start_subtest("cmpxchg_fault"))
> +		test_address(skel->progs.stream_arena_cmpxchg_fault, &skel->bss->fault=
_addr);

Tbh, this seem to be an overkill. The point of these stream tests is
to check the stream output format details etc. Here the __stderr
annotation in the test already captures that the fault had happened
and also checks retval.

...
