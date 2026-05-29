Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E735F5E6
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023985; cv=none; b=lwnueuRrKw6YI0PzreZJejHND6jAGYqLPsRIZpRBaAx7Aes/4XNkVIpLq5uzYIz55Ok5iETE1epnz9N0oSIkB+LLhxLKmz4rEtjZGvyIxnLjECfwDSO5v5SVjoiVvmDR0+tlfWdYjWy+ijZbzeuwxp4RFY4NILMyGps+lSaBQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023985; c=relaxed/simple;
	bh=3otPB21uOSfThybbnR8uOHzGvGyJ0GpxOFH5v+ygLvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEfUXkXEIbQHcXLDoKfP60xla5xHUcM3GikYIWBl4oThw4+f6fNYKQvhaK8VPP1IyK6SQX5/qZUSraQEuWGtg2pWvHAOrFecEt64NBu8E2/iW0TWoSrutpaUhJZnboioHVZjxBBS+5+7TzkI8YnCwniGkOEfCuU0q9NgVSFUhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRJmAp83; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRJmAp83"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so527157a91.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780023984; x=1780628784; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3otPB21uOSfThybbnR8uOHzGvGyJ0GpxOFH5v+ygLvc=;
        b=aRJmAp83vfgqoKVFxCJHXNC3/nWdTz8yoiecRvo7pxilnw3m2zRR1/7fEyMjryp2yw
         U+aTlzqfqLwaqIPhdYC8xxS2gKbIUZD0jO2ut12XCzgJ+vhc66RB0inx/091LEXySdXZ
         5qQmByFsc9MZOrtGqqd4KFSqsQaKDgiXrMA+X1qwq/HNRjoVXiSYc+puYGGd7DXTfIjs
         1Uh9Zvx/lzH012SGwCnV3wQoQ1nmMoT97rfJIxUbZaoSb8lrEOIr8dUFPgvYhAUSLzDF
         8ZTWr/1y/f8bR2ZThMO5ec/URBQwXv5aVlAcjGBMi/+C1htVO4Z8PrxvekHmQeBV+CSO
         9RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780023984; x=1780628784;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3otPB21uOSfThybbnR8uOHzGvGyJ0GpxOFH5v+ygLvc=;
        b=SnkLtxfMy5OLmaR0bO4RAyzPS7sTVDc4y99fk1Xc/ULy6LpzHFv++ISDN7qiTniVO0
         ENYNvrGphh2v6mgRUgHkA2rvhrPmUfida9lncQAH3XD3bkZ71vmzNTv5PEmau6XzkmDX
         vteweqdMvOgxvEEw6uhkh8kM+CAuoS00n6TOWbfHSbwUir7UCvf4/H5UKcwjavHbLMmq
         YkzCLp1JHNryBEeFL8AiBeG34U8nVXwVlUk0C+v/n5dveIEpQzu8QMvIimeGWZLdbRcQ
         WNfY61Zc2LtPwDvCK+yo7Jl/XPrlmovFTrTNKPI6fP8zeRIi0+CB8mprvyPwIGasTC44
         tn7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8MO5kv+At7s7pA6y7re4YvODorGjtRndeBU1ISoqlhlF8Vs0/JAsFM2AyMvQJrL5irdF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQPc5DnOiJ6HrJelEI+XAVQbVGgR6TmMqJDCMRU5AK/Gwc7bL
	FDLWmxlVEoGi7Dui3O18kbpP6OKnuj2OZii0/w3/DrxGgRSGIZ+WuVXZ
X-Gm-Gg: Acq92OFbsQYsSxYe3N6mwrWwDXqC29hFEdlGzsxSW2KnjKoQOmCooMADNHhEeA2iBmP
	KxgqFLOu2WzTMaIF6NMQZhHMypCWMFUmTm0224Ptq0cuAFP/cAdOrzQ2LjaKR3dQc9Mp4cuvKaH
	lwQ/wQPGSriP063Fa+einnctSoHXV/Em8hzfA5vY7cQqNrhJa2Pz/PmtMBrr8xtsGNnUdfeJQkc
	R2dXdSei4P5ZLyVsim9Vu/e2HNSRGu+JEDRFpedjRmeMCDIlTmuOAQ+WLozhwobwudF+dxd1NEg
	Hl2AsNCHrcBdDISufOM5q1zV0jJeAVC2TUOg5nLqMHhcanBSaZwV1zo8vQgspELP9xkw90dTtOO
	QzXHXYL9MDs0JEJkhKrwcizIYHeqMncDZeTOcMDfBp+7sh3LE5EHQWun/QVWLcil6wTV5OOBETr
	WBFYnYawE71FecCI7zJ6fE6qbkp87l8TLuGLXiGZWBrMXTG4K4n0SKht+3ssHIsA==
X-Received: by 2002:a17:90b:5487:b0:368:6998:b49d with SMTP id 98e67ed59e1d1-36bbcc14a37mr1378776a91.10.1780023983741;
        Thu, 28 May 2026 20:06:23 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdb6978fsm276066a91.1.2026.05.28.20.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:06:23 -0700 (PDT)
Message-ID: <96c4a1aa4333d10b882a9b5093d2d982f9f106e3.camel@gmail.com>
Subject: Re: bpf-next verifier regression on unsigned bound checking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>
Date: Thu, 28 May 2026 20:06:21 -0700
In-Reply-To: <CAADnVQKyj_QHfsp7COv5-RUFE03FDYOE4VTNhY-_YgvTiDCKPw@mail.gmail.com>
References: 
	<CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
	 <5bd0c7b135559943f3abccda6390705da5e493d5.camel@gmail.com>
	 <9d1dc36948ea9cfdf48f643f9b34ccaf51411847.camel@gmail.com>
	 <CAADnVQKfjaro6PMyd=2qaU9UeecLmTbzfj-f5ULUpfobhsbUgQ@mail.gmail.com>
	 <43d76deec1c5aa8a2029f907ad9c119d83b9966e.camel@gmail.com>
	 <CAADnVQKyj_QHfsp7COv5-RUFE03FDYOE4VTNhY-_YgvTiDCKPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-28 at 20:04 -0700, Alexei Starovoitov wrote:
> On Thu, May 28, 2026 at 8:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Thu, 2026-05-28 at 18:05 -0700, Alexei Starovoitov wrote:
> > > On Thu, May 28, 2026 at 4:34=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >=20
> > > > [2] https://github.com/eddyz87/bpf/tree/cnum-split-at-zero
> > > >=20
> > > > Approach [2] fixes the issue at hand and has almost no impact on
> > > > verification performance when tested on a set of
> > > > selftest/scx/meta/cilium programs.
> > >=20
> > > pls quantify "almost not impact" and send that patch.
> > > Looks small enough.
> >=20
> > Here are the stats comparing current master to this patch.
> > Results are filtered by programs taking >=3D 10K instructions to verify=
.
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D selftests: master vs experiment2 =3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >=20
> > -rw-r--r-- 1 ezingerman users 504K May 28 03:21 selftests.master.verist=
at.csv
> > -rw-r--r-- 1 ezingerman users 504K May 28 03:07 selftests.experiment2.v=
eristat.csv
> > File=C2=A0 Program=C2=A0 Insns (A)=C2=A0 Insns (B)=C2=A0 Insns (DIFF)
> > ----=C2=A0 -------=C2=A0 ---------=C2=A0 ---------=C2=A0 ------------
> >=20
> > Total progs: 4707
> > Old success: 2952
> > New success: 2955
> > total_insns diff min:=C2=A0=C2=A0=C2=A0 0.00%
> > total_insns diff max:=C2=A0=C2=A0 32.41%
> > 0 -> value: 0
> > value -> 0: 0
> > total_insns abs max old: 837,487
> > total_insns abs max new: 837,487
> > =C2=A0=C2=A0 0 .. 5=C2=A0=C2=A0=C2=A0 %: 4702
> > =C2=A0 20 .. 30=C2=A0=C2=A0 %: 3
> > =C2=A0 30 .. 35=C2=A0=C2=A0 %: 2
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D scx: master vs experiment2 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >=20
> > -rw-r--r-- 1 ezingerman users 38K May 28 03:22 scx.master.veristat.csv
> > -rw-r--r-- 1 ezingerman users 38K May 28 03:07 scx.experiment2.veristat=
.csv
> > File=C2=A0 Program=C2=A0 Insns (A)=C2=A0 Insns (B)=C2=A0 Insns (DIFF)
> > ----=C2=A0 -------=C2=A0 ---------=C2=A0 ---------=C2=A0 ------------
> >=20
> > Total progs: 376
> > Old success: 351
> > New success: 351
> > total_insns diff min:=C2=A0=C2=A0=C2=A0 0.00%
> > total_insns diff max:=C2=A0=C2=A0=C2=A0 0.00%
> > 0 -> value: 0
> > value -> 0: 0
> > total_insns abs max old: 233,696
> > total_insns abs max new: 233,696
> > =C2=A0=C2=A0 0 .. 5=C2=A0=C2=A0=C2=A0 %: 376
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D meta: master vs experiment2 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >=20
> > -rw-r--r-- 1 ezingerman users 234K May 28 03:28 meta.master.veristat.cs=
v
> > -rw-r--r-- 1 ezingerman users 234K May 28 03:14 meta.experiment2.verist=
at.csv
> > File=C2=A0 Program=C2=A0 Insns (A)=C2=A0 Insns (B)=C2=A0 Insns (DIFF)
> > ----=C2=A0 -------=C2=A0 ---------=C2=A0 ---------=C2=A0 ------------
> >=20
> > Total progs: 1540
> > Old success: 1448
> > New success: 1448
> > total_insns diff min:=C2=A0=C2=A0=C2=A0 0.00%
> > total_insns diff max:=C2=A0=C2=A0=C2=A0 2.08%
> > 0 -> value: 0
> > value -> 0: 0
> > total_insns abs max old: 666,036
> > total_insns abs max new: 666,036
> > =C2=A0=C2=A0 0 .. 5=C2=A0=C2=A0=C2=A0 %: 1540
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D cilium: master vs experiment2 =3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >=20
> > -rw-r--r-- 1 ezingerman users 16K May 28 03:28 cilium.master.veristat.c=
sv
> > -rw-r--r-- 1 ezingerman users 16K May 28 03:14 cilium.experiment2.veris=
tat.csv
> > File=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Program=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Insns (A)=C2=A0 Insns (B)=C2=A0 Insns=C2=A0 (DI=
FF)
> > ---------------=C2=A0 ---------------------------------=C2=A0 ---------=
=C2=A0 ---------=C2=A0 -------------
> > bpf_host.o=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tail_nodeport_nat_ingres=
s_ipv4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19858=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 20170=C2=A0 +312 (+1.57%)
> > bpf_lxc.o=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tail_nodeport_nat_i=
ngress_ipv4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10510=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 11457=C2=A0 +947 (+9.01%)
> > bpf_overlay.o=C2=A0=C2=A0=C2=A0 tail_handle_inter_cluster_revsnat=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 10857=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11437=C2=A0 +5=
80 (+5.34%)
> > bpf_overlay.o=C2=A0=C2=A0=C2=A0 tail_nodeport_nat_ingress_ipv4=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11768=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 12729=C2=A0 +961 (+8.17%)
> > bpf_wireguard.o=C2=A0 tail_nodeport_nat_ingress_ipv4=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11811=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12769=C2=
=A0 +958 (+8.11%)
>=20
> ship it.

Ack, will send later today (closer or after midnight Pacific).
