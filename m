Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B083C414F
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787114136; cv=none; b=ToEHhUK5Pd3WR53+ob14/ezauFvLP+qhkCiamw/mvJq4VQkk2/2RAH1GWvtob+fiCmzaaM1QC2nxEI4atfIR2pgm3iel3AK5Jf29dJ8MVUcmoAy3lyTDANxi2Wuv+AGwWdo6pZFh64K8n0cxiDGT0rPeQ5AR8u6HRfviNhyU/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787114136; c=relaxed/simple;
	bh=04uek7pA566woZc3ndF2+9uLrmc3+K0tLZuLhD7XrNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=det11MUksZtNXor20v6wfd+I3+0Ttlr3b/Nlwt+BDYMrCPvtFaKYGYHhCKfMNZWjreD3bxsbbwWWFrLrllMuLVkjAkfU7FLjKPj9jIp+tC7SnS3/gOua6dZ27fkVFaQSHydx1XT/F2ijQR1tCJBdm6VgA6YYBDwSCOhtqy1gibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sG/WGphT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG/WGphT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e347638adso777690a91.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 21:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787114133; x=1787718933; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=04uek7pA566woZc3ndF2+9uLrmc3+K0tLZuLhD7XrNw=;
        b=sG/WGphT8JR+/LYojZALykulUbPuGCZZ4DdBJKUNDS0RxNzXKTwnECE/3ygdKvmdgI
         Kmh4gmlpASapn9T9OCXJequiCXXZwdE8Wg434cSLFp2KgvuT3nFqfC7BcQ7h+tQfvDqy
         3x0M3lm1LnsS9UAruIM6tB0GE5yv7iDT+gv1VlIepGfWTd1tDXFjVs9Fy2fqywN3p7fa
         R+omESNQYPsdyv30cxfuCv4AC6IeWe62/rJFLMuaPUOcH7+XVhqOUe9s1haK8c4yBdNY
         lpXlNXPafb4t976rAVeAcv0OXDVowFfFMdY0LV9RHJFSQbX6K/+muBs6MMCa07Faoqge
         DHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787114133; x=1787718933;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=04uek7pA566woZc3ndF2+9uLrmc3+K0tLZuLhD7XrNw=;
        b=cHUJ77TZ4xVcGHRTOFCkxK1+iRyUxeiGuvFTQ5at5eaxwpRTY0p51nNrjxqWJYfaEm
         NVGdeN6ql1UJXuFe0LL9/Ilvnx/IrT5vt0cZPbwb76hxe0wrDzmVeM3S9s/EPNQ9FUrL
         AmAnSpnnrpnWR+Du1+PEStWVT/SRNROaFFtZt2t7ncFOKtkLZUTm4fecY4mMc+JsqsvB
         vWenHUXtZ25Bq+d2oLNqDk2QZA1NxVR7PgOjHwhCBoVCcm6sZMgK3mz1hOIYUn6+yOfN
         GKgd8nlToXStR12WJFvrraY3i6PtdbFyLEFL+fSOEap8kcR+gjNqFJVhU0h4DG4akQ1c
         tyQA==
X-Forwarded-Encrypted: i=1; AHgh+RoyVyasifcjNX4PVurr48kJHdYE83oCFdv1+vZ85IRoazadbaqTknth2IJJjD0cnWrIWik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIRFB7Usd1oxhPX16u7bb0pZJMy3xBzIBp7WRWH5sGYJZyAu0
	DGYy8uGS/OZ4l7PuNHh1xFi4t6k6TaNxA9q9zAQaGyChw9ckdlf7GOx4
X-Gm-Gg: AR+sD10oxaem8pk6iSAPYIZG31zWKYQ+N8ZCAqEx+S4UtiN+ZUrn2bRKhTbJZKAnWH5
	FQfxVhbrCATMPiTIvEWntWbFB4uaC+M/g3ywuQ0ZdJsoC/8wm7iAk1x3sZ/Vuw9NfG9KOulDy6l
	iNkXP+znQSFNnc6TtdJXbUJ4p3JhoNRt5heIDzeY88isj4zfNuWM9XkzSyTOdYz/2HLSOm+zSE1
	e+3XsZzI1kOM3oEUHw0gQ57RmKGTCSIMFWr24ejFXjrgy+0/EfmaUGOzFxssAhwogeeoPhGUMAR
	JDbDh99y7YiAzfA0uNMR84YqzXAZYOuToLqAzMBlQ2PRg+bgwxUuvNZpyAFTkS+62u2k1uIV6z7
	qUnL5GiwY3oxNdhtWtdu0ZmQw7zOlNOFOcmNSHVWXUgwca77pCqta0SIvTttYBPjm7pWcBE+NWC
	TKD5ufx09Sk8YloDhoaCgv9jalGpcGyGafLaVcq7NHA+LnW00OT4TvtTuQpBFrPfQu1B9vRMkGM
	SPvH/I8KW4A1EPO
X-Received: by 2002:a17:90b:5250:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-395810b57d1mr3689625a91.11.1787114133239;
        Tue, 18 Aug 2026 21:35:33 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fc0d1besm369972a91.3.2026.08.18.21.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 21:35:32 -0700 (PDT)
Message-ID: <5f1b726cd88f2261f70a5aa99f94ea1434c078c1.camel@gmail.com>
Subject: Re: [RFC bpf-next 0/6] bpf: track scalar equality across the low 32
 bits
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 18 Aug 2026 21:35:30 -0700
In-Reply-To: <20260814231945.3884596-1-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:
> The verifier's linked-scalar machinery tracks register equality only for =
the
> full 64 bits (optionally with a constant delta). There is no way to recor=
d
> "these two registers share just their low 32 bits", so a 32-bit mov from =
a
> source with unknown high bits has to drop the relationship entirely, and =
a
> later narrowing of the source never reaches the destination:
>=20
> > =C2=A0r6 =3D ...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* full 64-bit=
 unknown */
> > =C2=A0w7 =3D w6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 32-bi=
t zero-extending mov=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
*/
> > =C2=A0if w6 !=3D 0 goto .Lxx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* not taken: r6's low 32 bits are 0=C2=A0 */
> > =C2=A0if w7 =3D=3D 0 goto .Lok=C2=A0=C2=A0 <-- not deduced today
>=20
> The same gap exists for the 32-bit sign extension and was the
> motivation for this patchset.
>=20
> > =C2=A00: (61) r2 =3D *(u32 *)(r1 +24)
> > =C2=A01: (bf) r0 =3D (s32)r2
> > =C2=A02: (56) if w2 !=3D 0x0 goto pc+10=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ; R2=3D0 (branch taken)
> > =C2=A0=C2=A0=C2=A0 ...
> > 12: (95) exit

Note that ldx instructions have similar structure: one can either zero
or sign extend on 32-bit load. I think this series should be expanded
to cover these cases.

Also, please drop RFC tag when submitting v2.
