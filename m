Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FCD3033D5
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122038; cv=none; b=HoqvVT+89Q8wrfqV1qE303ekT47MZrQ3tT/zVWkuWfbMhiKd62RYP+FwD8z+h7/q/CQtorbdcHYuACLCCbXR/40FXisgN0G+4Sy1N0mRFJ5npFfRDz1b4c+8zGNK/KueVFa9LyNR96c9o8BiJY9FQ4G09CHXR64WO4wg8XQOjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122038; c=relaxed/simple;
	bh=rQdPo8e1PoW2Gs+DE/31pynpa7P1/rM6rhCAdPpnrNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PheZniHJMW0TgeoUGZ5E9hJ4M2ms0yhksims8Fhlx9AWmGqBcuh402Rq338spOrUEvt0lmlK26mo6C5EqUoHkdhsDI9i2tho2xYcbEfHqLzLo6h73gSUL078W0bQYElIEBy7BDPJBCXfgyYE/l8ss1faA2V2ZPNuBmBnDxdiqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3nVmFkU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3nVmFkU"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd830404c2so215082485a.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 22:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773122035; x=1773726835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6xDrLeY5aKyG7EdMYINUg+J1ID1PkakjrsnlqRo9TjM=;
        b=d3nVmFkUKKYvOVZMPgzjc+UyctNHOncZboEkoZrdi3X8nVnptFT6tlrtN7N6JgBmHF
         w85pMFwacnzh3K3WhScSJ3MTR/rrgXUvPmN82xJC9gEZWA6oP4fdQJlL6+a/hjE9HnHe
         P0SLxBzcJEAvwmdR0uUcq2PvysJL5o3ONDgh1861JWBZdXqhm8VJA+1C0kOokwS56UjJ
         4dO81dzkWSAkGCpkBDZcYg0utCmkd0OkqY+t34eOwcgobrAoNIilhCpP+9V2/uBuKCGT
         Em+oYeUbUdKmdH3h2rzhcHg6QnrE2KsuxxWOfFWtj8ibtynGMS0n+wCQ7Td4xpKhBBnB
         gWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773122035; x=1773726835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xDrLeY5aKyG7EdMYINUg+J1ID1PkakjrsnlqRo9TjM=;
        b=A4rUUbdNvLL9XLn8ReyssCvXwlyZh5SdljT5gOQzCg6wt7V/+bNrR4b1kCG4zixDDp
         HR1XHF+sOhZaeH77uw80EZB0XpLLvhv0Cb3ZvSRRnMZc9SAMzMR13IR5dKWjfmocqS9i
         UjKbX9j/z7/4AA71Y4b+FPYVvvZtUPcNQO5Bk5HFaftK0BsT2LNlrya5DXpmrqm0ZU5w
         mf36f+toKyRQYiLUccLg7R4EEoGGsvBYOufoMv1/puT/4AWoJoj5Jn4L1ytXqCFDztYl
         QujKKPtai4g2Cd/aV4Y9KjZONyRPCucl0OJAX9TDXqS+k26x7A8arANSJbjI16YX/fhG
         IUxg==
X-Forwarded-Encrypted: i=1; AJvYcCVasXvXF2Fpnce2Kzx0xsDTJXcQO6bgE6P0fVnDdcLjkuxqMRjHdkUudxzAFWdKwgzR5AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ca9VjupB+YsafuhShOaR4/dg+HFYnS6JgLWv26W5SyjgvOkd
	Hh8IC8u1y99BsA/HrJ9P74deWAOa3KyPomApc5SXv7EQ/2eABGS5fsdw
X-Gm-Gg: ATEYQzys+1E0OnLh5QkGoNL4sS6YwtHymn16GbfDYkz/2XgL8t4bOm+iu98ogOSLFcT
	Ortj5b517g25f7beGVCfbAz6TE0NLJOlXDvXj2hFaoVhWhmSrW1UW4YiIHBkrhDxacXrCiqtJtf
	vrAJM73Jz+TtjInEAcQ1VQwSOPGRYurR15ZGP9Ia0b4P3ESeg+rJ6b1z5LCKAUyn3T0J/6UDnbt
	C9UR15hWtc+fhe9zcIRcwTp6J1pxoRmY3sSao9m2qKy4oH7gJCqqlxsmZnkYm3FGJGEbdFfwtBt
	izRkg7o9I3TwPOP3pl0Pcw5aftJd5NPXA/g2pFwM1z7+7uqkNENXyEuuwWgy0hRL+GYuTe7Oc+V
	gzE9bWsn3xek9SBwRE7pEuT4ktLBL2DdkTmu8dSlzDETJmVmUWS2oP2mhlGOvOEHzD1VorI4xpM
	7DqYbJCrirPc+BYnZNr0F/Gs9uAiYrVTIe5RaPUJxgf/jF1qAfG3c=
X-Received: by 2002:a05:620a:1726:b0:8c6:ed3d:be60 with SMTP id af79cd13be357-8cd6d4a14ccmr1727212585a.71.1773122035530;
        Mon, 09 Mar 2026 22:53:55 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8d4cac0esm285167885a.36.2026.03.09.22.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 22:53:54 -0700 (PDT)
Message-ID: <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>
Date: Mon, 09 Mar 2026 22:53:50 -0700
In-Reply-To: <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
References: 
	<5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
		 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
	 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-09 at 18:30 -0700, Eduard Zingerman wrote:
> On Mon, 2026-03-09 at 18:07 -0700, Eduard Zingerman wrote:
>=20
> [...]
>=20
> > Of-course, I might have some bugs in the test definition, but in case
> > the definition is correct, I think I'm inclined to agree with Ihor
> > here. If we can't mathematically prove that the sequence converges in
> > a fixed number of steps, putting a loop on top of it seem to be a
> > reasonable thing to do.
> >=20
> > [1] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle
> > [2] https://github.com/eddyz87/deduce-bounds-verif
> >=20
> > [...]
>=20
> Pushed an update to the test to check if new bounds are tighter than
> old bounds (instead of equivalent). Still get a failure log:
>=20
> $ ./parse-log.sh out2.log
> Values extracted from log:
> =C2=A0 s32: [-1686110209,=C2=A0 1907957760]=C2=A0 v_s32=3D-1411416065
> =C2=A0 u32: [ 1746894847,=C2=A0 4030210048]=C2=A0 v_u32=3D2883551231
> =C2=A0 s64: [ -4350478693995380738,=C2=A0=C2=A0 2172132303447261182]=C2=
=A0 v_s64=3D-4350478693150261249
> =C2=A0 u64: [=C2=A0 2172132302103053322,=C2=A0 14096265381705949184]=C2=
=A0 v_u64=3D14096265380559290367
>=20
> Running C code directly:
> input:
> =C2=A0 s32: [0x9b7fffff, 0x71b92000] [-1686110209, 1907957760]
> =C2=A0 u32: [0x681f7fff, 0xf0382000] [1746894847, 4030210048]
> =C2=A0 s64: [0xc39ffead797ffffe, 0x1e24f6d2501ffffe] [-435047869399538073=
8, 2172132303447261182]
> =C2=A0 u64: [0x1e24f6d20001040a, 0xc39ffeadf0382000] [2172132302103053322=
, 14096265381705949184]
>=20
> old:
> =C2=A0 s32: [0x9b7fffff, 0xf0382000] [-1686110209, -264757248]
> =C2=A0 u32: [0x9b7fffff, 0xf0382000] [2608857087, 4030210048]
> =C2=A0 s64: [0xc39ffead9b7fffff, 0xc39ffeadf0382000] [-435047869342495539=
3, -4350478692003602432]
> =C2=A0 u64: [0xc39ffead9b7fffff, 0xc39ffeadf0382000] [1409626538028459622=
3, 14096265381705949184]
>=20
> new:
> =C2=A0 s32: [0x9b7fffff, 0x71b92000] [-1686110209, 1907957760]
> =C2=A0 u32: [0x797ffffe, 0xf0382000] [2038431742, 4030210048]
> =C2=A0 s64: [0xc39ffead797ffffe, 0xc39ffeadf0382000] [-435047869399538073=
8, -4350478692003602432]
> =C2=A0 u64: [0xc39ffead797ffffe, 0xc39ffeadf0382000] [1409626537971417087=
8, 14096265381705949184]

I added back third round of __reg_deduce_bounds():

  diff --git a/deduce_bounds_new.c b/deduce_bounds_new.c
  index b0bd8c8..dc498b2 100644
  --- a/deduce_bounds_new.c
  +++ b/deduce_bounds_new.c
  @@ -326,4 +326,5 @@ void reg_bounds_sync_new(struct bpf_reg_state *reg)
   {
          __reg_deduce_bounds(reg);
          __reg_deduce_bounds(reg);
  +       __reg_deduce_bounds(reg);
   }

And run cbmc with the following assertions (see [1]):

	assert(a.smin_value =3D=3D b.smin_value);
	assert(a.smax_value =3D=3D b.smax_value);
	assert(a.umin_value =3D=3D b.umin_value);
	assert(a.umax_value =3D=3D b.umax_value);
=09
	assert(a.s32_min_value =3D=3D b.s32_min_value);
	assert(a.s32_max_value =3D=3D b.s32_max_value);
	assert(a.u32_min_value =3D=3D b.u32_min_value);
	assert(a.u32_max_value =3D=3D b.u32_max_value);

This failed quickly with an example, showing different results for old
and new orderings, new being tighter.

And then with the following assertion:

	bool old_better =3D a.smin_value < b.smin_value ||
			  a.smax_value > b.smax_value ||
			  a.umin_value < b.umin_value ||
			  a.umax_value > b.umax_value ||
			  a.s32_min_value < b.s32_min_value ||
			  a.s32_max_value > b.s32_max_value ||
			  a.u32_min_value < b.u32_min_value ||
			  a.u32_max_value > b.u32_max_value;
	assert(!old_better);

This finished in 20 minutes claiming successful verification.
Hence, I conclude that new ordering is strictly better than the old
ordering if there are three rounds of deductions.

I suggest we should keep three rounds of deductions and adopt the new
ordering (or play with orderings some more to choose which one is
better under 3 rounds).

[1] https://github.com/eddyz87/deduce-bounds-verif/tree/experiment
