Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBD1B808
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849148; cv=none; b=HvxDPSRsGmtZ0oT6HlEyC6SuyxSPr9BJUYPvQHHYhcaxDOQDcKNwL3Bam4aBorlhsK60qNAK4JIyEDyWgn20Pz9Rb+I8ZnCOsvsDFKlrodJprXaLEDM2XUqowfm9RpQYmG389GSdtZK58XNXdxO9tFkT8vodGo8oO8tMHyWQfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849148; c=relaxed/simple;
	bh=YSUrIPWVeOQxTLripfAdxalqDdoMDXRfR1gS80yHMbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNuaZPNHGaCxAJNpJ0pZ9hzggl7ZwcD1+w0N4oltXyqpYG3wuUmor86Y0MXl23MLBBFWy08X8d1qjqb8AlVypEY8dmlY0OM6hwyBiNScnWlUp+1BrgU1MEFcBSZQr1kEzSexeAKPD34HLEAb5U1WV8XbxHWvN4hZnC7ktRDrPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su1IgyrT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su1IgyrT"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-835386ff122so11336431b3a.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779849146; x=1780453946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YSUrIPWVeOQxTLripfAdxalqDdoMDXRfR1gS80yHMbA=;
        b=Su1IgyrTIdcUHSBB8HKVVLJnAr66ZQE8xMGIbax1cVRHirEUzaOLRLibR3j2iB8wbW
         jXr9CNzB5ygeocUxaXdDX/+fFeGB0r/xPqIReZoigz5mZSTjaSHbCPdqAmAPt26ddc9d
         oeAvv7uJr9evfgh4OJkPYLwCekRSNAvd4ixbdKYUCi+lvcWSTFND20/PKHf6wgBSMJA1
         RnTbio+2FFQCpcBUZmxde3Uj927og8BN3h1lenhlMCoiMlY7x4CTefftpMr+ixUBvNQH
         MUi8cBgFL2rMR+t6Al/+6va08zkIWQbI4orJLnnGokhpiajkPPFVgw+5Wm9y3hN93z/O
         sTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779849146; x=1780453946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSUrIPWVeOQxTLripfAdxalqDdoMDXRfR1gS80yHMbA=;
        b=LSrVXSkgB4FxKkGADVBvxJ4wVQptxEQ6Bc9v7JXlfOfF+GYZ/LjmtElZCHyCtu48rg
         6srZbWT3/Y5kAf0MR9Y887SbkOIoDVkFTlji0AmYwWwLnF29A902EV/Ar2pP0tHkUnpZ
         jLYy3OvnDeXt4nEtPpf5CZiI7OZJGlf+ECTICWJtLFSC49dGz5kbtspehxMeT3U+Te3E
         zfZvtlsdrckWKK8YRAh56Elz0yQLl3DCZqlvhgdiKFUUT5VMmXAoXXQ//IAi7wyU09J2
         YAdowYcanlmS7Vf3C7XKdf14yk8bENGB3Aov+MBigoJ4C7HQMKnevMNcr9bp99nd84H0
         T55g==
X-Forwarded-Encrypted: i=1; AFNElJ8x256hv7xdkuiJs/8Lsmy5c4erNdLLynbAbZgnvOAW1Fh2DMxu4rZDVY2dNEbvzABTdg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzybI8lZUEIR7zAVBi4w04aJuyCulLaxWtiio1nDCzNVJTFdvGa
	C6IuXsd9S8pHetw5k4lx37s23Xxc7zCX9/JCOX+HVhKVIDjs1JstfCir
X-Gm-Gg: Acq92OEd6m85BA/Ko2lFOTpMFG+wNbyWeT9z2EA/HzBsiV7K3b55Xj1ygjKTrN0rbFX
	hyK7sONuAHqKZlq9RVb3BzSqzdo0syJEY8A2pHvMOyThIhdpwNF1jV+oUUQiE/5vwH2apATqSpH
	GhWNXGAFUIv+DUoEUW1ygedlPQZK1k4nqBzd6Q5wKQKuK5ByZi+QXW7zeXPeqSe1LJo1B04br8D
	nYY4MWmUv46il+vxfR04U1S0+b8oblDiJtnpCmErp1Ib4O/nJtUScrhhyubuEjfoVgDsJC4JnAR
	sGYCmie7Yks3o/2OBaP9BQ7+/Xh7I0MvA9X9MMwzsBFjEAvjUzcEvR8mEbrq7MVCNRZjHd1ldcs
	7h6lQeFJ+rrHtxDqRH/JuQ0tQGDDq+9BLfbbMutrchAd/u79j9+Zz3yAsxh+MYHEJPzmHvPN+aO
	CWGVKewGr8Ap3DpiVr23hbYt+eYSMhhgsChBLFGAh+GPtkuB1tH2r+RPGE8D4aUA==
X-Received: by 2002:a05:6a00:8c04:b0:838:af72:fb2f with SMTP id d2e1a72fcca58-8415f3af2d2mr22538871b3a.6.1779849146261;
        Tue, 26 May 2026 19:32:26 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eae727sm703135b3a.19.2026.05.26.19.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 19:32:25 -0700 (PDT)
Message-ID: <5bd0c7b135559943f3abccda6390705da5e493d5.camel@gmail.com>
Subject: Re: bpf-next verifier regression on unsigned bound checking
From: eddyz87 <eddyz87@gmail.com>
To: YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov
 <ast@kernel.org>
Date: Tue, 26 May 2026 19:32:23 -0700
In-Reply-To: <CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
References: 
	<CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 17:51 -0700, YiFei Zhu wrote:
> I was looking at Kuniyuki's selftest for BPF autolowat [1], in
> particular why the verifier fails if these two conditions are swapped:
>=20
> =C2=A0 if (copy_len > RPC_DESC_SIZE)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disable; /* always false,=
 only for verifier. */
> =C2=A0 if (copy_len =3D=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disable; /* FIN. */
>=20
> This is the register trace of the reversed version (which fails verifier)=
:
>=20
> =C2=A0 33: (71) r1 =3D *(u8 *)(r9 +16)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ;
> R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=
=3D(0x0;
> 0xff)) R9=3Dmap_value(map=3Dtcp_autolowat_m,ks=3D4,vs=3D20)
>=20
> =C2=A0 107: (b7) r7 =3D 8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ; R7=3D8
> =C2=A0 108: (1f) r7 -=3D r1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=
=3D(0x0;
> 0xff)) R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
>=20
> =C2=A0 117: (15) if r7 =3D=3D 0x0 goto pc+48=C2=A0=C2=A0=C2=A0=C2=A0 ;
> R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
> =C2=A0 118: (25) if r7 > 0x8 goto pc+47=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> R7=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=
=3D(0x0; 0xf))
>=20
> =C2=A0 126: (bf) r4 =3D r7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ;
> R4=3Dscalar(id=3D888,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,=
var_off=3D(0x0;
> 0xf)) R7=3Dscalar(id=3D888,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax3=
2=3D8,var_off=3D(0x0;
> 0xf))
> =C2=A0 127: (85) call bpf_skb_load_bytes#26
> =C2=A0 R4 invalid zero-sized read: u64=3D[0,8]
>=20
> The oddity happens at this instruction:
>=20
> =C2=A0 117: (15) if r7 =3D=3D 0x0 goto pc+48=C2=A0=C2=A0=C2=A0=C2=A0 ;
> R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
>=20
> The C logic constrains that the unsigned copy_len !=3D 0, and <=3D
> RPC_DESC_SIZE, i.e. the end state should be umin=3D1, umax=3D8. However
> instruction 117 does not record the umin constraint. If the checks are
> reversed to match the patch order, the verifier is sane; the
> possibility of overflow is eliminated, so the range becomes [0,8]
> after the first comparison, and then [1,8] after the second.
>=20
> I looked at the verifier changes and found this commit:
>=20
> =C2=A0 commit bbc631085503a7fde9617be18b0657cc9a83910a
> =C2=A0 Author: Eduard Zingerman <eddyz87@gmail.com>
> =C2=A0 Date:=C2=A0=C2=A0 Fri Apr 24 22:52:44 2026
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: replace min/max fields with struct cn=
um{32,64}
>=20
> This change means that the signed and unsigned ranges are no longer
> tracked separately, but rather in the same circular number.
> Unfortunately 0 falls within the circular range [-247, 8], and the
> cnum intersection returns the over-approximation result of the
> original R7 range (because the intersection happens on two disjoint
> arcs), thereby ignoring the introduced umin constraint.
>=20
> I'm not sure how this could be fixed without reverting the patch of
> using cnum to track ranges (which would re-introduce a lot of maths :/
> ), but I'm also not sure whether this is an acceptable regression.
> Some helpers, such as bpf_skb_load_bytes in the test, uses
> ARG_CONST_SIZE, which really does not like a zero lower bound.
> Therefore, if that argument results from a subtraction, the verifier
> now enforces checking the upper bound before the lower bound to
> eliminate underflows, even if the variable is unsigned and thus
> invokes no undefined behavior...
>=20
> YiFei Zhu

That's unfortunate. Thank you for the detailed report.
One option is to allow intersect operation to return two intervals,
then use both intervals and fork the verifier state to explore second half.
Veristat impact to be measured.
