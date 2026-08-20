Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915347DD48
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245058; cv=none; b=h4lGuvA+tWABTJuFhELEBnUBtCkBPCpcfn/lw4HLWR2nb0l+0hlJRG+MgLeLDy8dHczfxbwQ5m3Clvny0rWdNpzgAyiPQGIAdp8Xe2LWjzRU8Q8lc3LsuC+16jIyNVwIgvb4eEBuqATLjoksCOnEBj+zK2Y63lqxBEbUnE2KhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245058; c=relaxed/simple;
	bh=jC2UcUAOttMeIoy21Qt4awNQlbkaaoxMVuZfXSLuPH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpUDKrl3v+ZricCuHAivATA80cMDR+LoeJwWQUPRd0RfZM7gn3HUar4LeabAAhruiRj4xrJ1nktxkGUKuWmeR505wHKBHhxoigyK6kZqT1611xzvMEsvNyKMlyXHEMHoJgp9FPv2t9Ul34kCxvkMIsHUuZoahuQGlCLE69klBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfHlaKxt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfHlaKxt"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso770897a12.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787245056; x=1787849856; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pPNxbwFgEbIIsx0BPhP6+aVO1rxNFafty/Nx+HlVzLQ=;
        b=jfHlaKxthSadTqhcqPZPJo4I5jfkp4Jmx6oGbdYcFonN5qkH1S6Ij7AYZPsxu5WM3s
         Obv4PqsUPtf3f0seLoEg0FiiZtyZDMIrCUspy0wpcP2x+UQs1qIaQDfLgC7+i1Spyh8r
         rebSLph+SfsBdoIG9WT9xD2CYOUwl7mGgs4EbTAE90hG0JFtfABJZe8zsgO0W8Y6hHcZ
         jmgsUI2zOJqJ09N7BMIGprBvj8U6OWbUb80jhrEssvXfGaFz+9MRe7mdtIDKt+ADFiZ3
         XWiow189/qdfI6QVaqe/UYCLwFPMocezBt51i+IadkM56/mZFeHth66wW1Tfs5mbEi2D
         3M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245056; x=1787849856;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPNxbwFgEbIIsx0BPhP6+aVO1rxNFafty/Nx+HlVzLQ=;
        b=sDcZ2XglDfrJ6HWA/FKDuFyAaHxJzpi0C5iqWyGpo+5Vc9IQn68LGd5xKiMmzRmygt
         2rHlWgA14GHfOg8z5BdvkbpbkOyGuNy4aZaW6Mr+7N6unFar+hSkd45jbn11ojbrdes1
         /RwSH1Qke2L3rNy+/jTyw7oWw1ycNZ76LnlDmd/nDR5wosawerh0IPaWHmEAvROGsAwG
         lu/6SOvVvRIpguy0Y9eqjuI3b7kcTGXKHzfD+JxtNnGz2/DexENPTrVsJ5hxO4xxVt+0
         MN0B8AOHSvyQ7ZPtWcvlX94bqK3UjYl4bU38wfIxPj8XtGk1u7PAX+awxOUB7WcJgSp6
         odZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpS0LyQugYIXXheUpqO5YeO4zHpIvl0l1/Ny8gRuQkZGhRzk5H1tgfb6V6J0oQ5UP1eO/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mEblySJZfqz5Av8HRr46GNeAWXb5JB/DnJYXwpA8JyJAJt4in3
	1no12JRDiyaxxjSDCO2ITrMye+NJFJrNxrRZdNhz86KypZul+lUeeYKaY95Qiq+QIEY=
X-Gm-Gg: AR+sD11hsdJgYhMa83obtrVvObfTYHu81t8BBFShmbSssF/GabBeQ9ODB0jTPUuYU+k
	KnFO2gc2K1OckEAEbNToeAW35NAsdrrWTk+/tUTGio5rGuM2WklJt0dyyX4kk9Xfn+MPsMB1vnw
	jPTFb4fx0zSbsu0GlEc0f7mV8MdObtbuGnnKjFDmUJIeE1kHPyLwg1JV/yvkvSAnwFTagjDgI48
	VsFt81vYHVRyz0XmzT5q22aZWuv8IT9m6ORGWE4Iz9VST+EIBaduAa79XkihbzWMq0TdDipRY6z
	a2UC5HUAjqpUovjfSei2vYsW/uFtRCOxqWtRl3ZRJLdQmOvsJbf9M3EWy/aZDUnI05viBGH3irz
	wP+yify5NFv1sLJyY+ydHPKeqLvkKwNVbMIhMXuuCCvwoXCChQvacRVA5QfNVDcqeef8pGod3UT
	gok+w4iBzxnPGax5oblBSh7xS1TeHikrxYQHF/UPig32qPZlWgTXAB5sbmt3P7zxQV/y3RyWKSq
	DtqoEoeisuFPgVhE9k+PH5pe1CaDXdOJWaRAxqmDtrNdmg=
X-Received: by 2002:a17:90b:1d51:b0:38f:cfe2:fd3a with SMTP id 98e67ed59e1d1-395a06b9c5emr10418816a91.15.1787245055762;
        Thu, 20 Aug 2026 09:57:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb4ffcasm7553036a91.6.2026.08.20.09.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:57:35 -0700 (PDT)
Message-ID: <88b2bba531714814df5a2c4fe9d10aadfd4cce47.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Track linked scalars across a "rX <<= 32;
 rX >>= 32" zero extension
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 20 Aug 2026 09:57:33 -0700
In-Reply-To: <20260820013925.2515018-1-yonghong.song@linux.dev>
References: <20260820013925.2515018-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 18:39 -0700, Yonghong Song wrote:
> For the following test in
> tools/testing/selftests/bpf/progs/verifier_linked_scalars.c:
>=20
> 	void alu32_negative_offset(void)
> 	{
> 		volatile char path[5];
> 		volatile int offset =3D bpf_get_prandom_u32();
> 		int off =3D offset;
>=20
> 		if (off >=3D 5 && off < 10)
> 			path[off - 5] =3D '.';
>=20
> 		/* So compiler doesn't say: error: variable 'path' set but not used */
> 		__sink(path[0]);
> 	}
>=20
> Without alu32 (-mcpu=3Dv2), the test
> verifier_linked_scalars/alu32_negative_offset will fail with llvm22 and
> llvm23 like below.
>=20
>   3: (bf) r2 =3D r1               ; R1=3Dscalar(id=3D1,...) R2=3Dscalar(i=
d=3D1,...)
>   4: (07) r2 +=3D -5              ; R2=3Dscalar(id=3D1-5,smin=3D-5,smax=
=3D0xfffffffa)
>   5: (67) r2 <<=3D 32             ; R2=3Dscalar(smax=3D0x7fffffff00000000=
,...)
>   6: (77) r2 >>=3D 32             ; R2=3Dscalar(smin=3D0,umax=3D0xfffffff=
f,...)
>   7: (25) if r2 > 0x4 goto pc+5 ; R2=3Dscalar(smin=3D0,smax=3Dumax=3D4,..=
.)
>   8: (bf) r2 =3D r10
>   9: (07) r2 +=3D -5
>  10: (0f) r2 +=3D r1              ; R1=3Dscalar(id=3D1,smin=3D0,umax=3D0x=
ffffffff)
>                                 ; R2=3Dfp(smin=3D-5,smax=3D0xfffffffa)
>  11: (b7) r1 =3D 46               ; R1=3D46
>  12: (73) *(u8 *)(r2 -5) =3D r1
>  invalid unbounded variable-offset write to stack R2
>=20
> R1 is never narrowed down, so the address stays unbounded and the store
> is rejected.
>=20
> The test is okay for llvm21 with -mcpu=3Dv2, see below:
>=20
>   3: (07) r1 +=3D -5              ; R1=3Dscalar(smin=3D-5,smax=3D0xffffff=
fa)
>   4: (67) r1 <<=3D 32             ; R1=3Dscalar(smax=3D0x7fffffff00000000=
,...)
>   5: (77) r1 >>=3D 32             ; R1=3Dscalar(smin=3D0,umax=3D0xfffffff=
f,...)
>   6: (25) if r1 > 0x4 goto pc+5 ; R1=3Dscalar(smin=3D0,smax=3Dumax=3D4,..=
.)
>   7: (bf) r2 =3D r10
>   8: (07) r2 +=3D -5
>   9: (0f) r2 +=3D r1              ; R2=3Dfp(smin=3D-5,smax=3D-1)
>  10: (b7) r1 =3D 46               ; R1=3D46
>  11: (73) *(u8 *)(r2 +0) =3D r1   ; fp-8=3Dppppm???
>=20
> To fix the test issue with llvm22 and llvm23, note that the shift pair
> computes zext32(base + delta), which is exactly the relation
> BPF_ADD_CONST32 describes. So keep the link alive across the first
> shift and turn it from a 64-bit into a 32-bit one at the second, which
> makes the -mcpu=3Dv2 sequence track like an alu32 one.
>=20
> Two conditions guard this. First, a 32-bit link requires the linked
> value to fit into u32, because sync_linked_regs() zero extends the
> bounds it propagates through such a link. linked_base_fits_u32() checks
> that on the register state before the shift, mirroring the dst_umax
> check the alu32 add path already does. Second, in between the two
> shifts the register does not hold the value its id and delta describe,
> so the second shift must have a single incoming edge, otherwise the
> intermediate state could be checkpointed and another path pruned
> against it.
>=20
> With this, the llvm22 and llvm23 code verifies, R2 keeps its id through
> both shifts and the jump narrows down R1:
>=20
>   3: (bf) r2 =3D r1               ; R1=3Dscalar(id=3D1,...) R2=3Dscalar(i=
d=3D1,...)
>   4: (07) r2 +=3D -5              ; R2=3Dscalar(id=3D1-5,smin=3D-5,smax=
=3D0xfffffffa)
>   5: (67) r2 <<=3D 32             ; R2=3Dscalar(id=3D1-5,smax=3D0x7ffffff=
f00000000)
>   6: (77) r2 >>=3D 32             ; R2=3Dscalar(id=3D1-5,smin=3D0,umax=3D=
0xffffffff)
>   7: (25) if r2 > 0x4 goto pc+5 ; R1=3Dscalar(id=3D1,smin=3D5,smax=3D9,..=
.)
>                                 ; R2=3Dscalar(id=3D1-5,smin=3D0,smax=3D4,=
...)
>   8: (bf) r2 =3D r10
>   9: (07) r2 +=3D -5
>  10: (0f) r2 +=3D r1              ; R2=3Dfp(smin=3D0,smax=3D4)
>  11: (b7) r1 =3D 46               ; R1=3D46
>  12: (73) *(u8 *)(r2 -5) =3D r1   ; fp-8=3Dppppm???
>=20
> The llvm21 log is unchanged, R1 carries no id there so the new code
> does not apply to it.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

I think this is too tricky. A simpler thing is to rewrite the incoming
program as `w2 =3D w1; nop;` in place of two shifts. The CFG check would
still be necessary, though.

...
