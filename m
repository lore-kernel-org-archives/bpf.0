Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173942BEB2
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875177; cv=none; b=jewCudrg1YofYYDLfLYO6ZbYE3D4Bf7CYPSk1wxiWYos/kwfU3MyxtvZU054DOBKi4dZX+Vk2WNCWb++x9hxPVcD6NphS1QWNz9xA20CeaXiAm37bgrNAqc2OlI8xZI+ytkjRqBRwhimKS4+VpDWZ4g+H4MA0xKC5T52LvBUe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875177; c=relaxed/simple;
	bh=R82EmcXHhs23cvmwSup/qIsLmDPUlMW2Hdk+ax5bwFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgt1phxtEpO2p1+5R4w0xV7o1ahBd/plyIErWNatax5Ez2r7xjIFd8W1s7x0YwheDl+r+vQsXclm2896+XBMo2sdh5zzJ9dFsuU5Cj1ZEoVCK2ci9b16nhQR4BxplrcJG0MyeLrhL3NFKK0hBw5RwBj1F4fR4gdfTvx0XcZ8THE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Itwnyta8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Itwnyta8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so3902395ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875170; x=1786479970; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=R82EmcXHhs23cvmwSup/qIsLmDPUlMW2Hdk+ax5bwFk=;
        b=Itwnyta8NdReH24jZAKUB2IoOQJV/tXTxbe9lBEpM3BMiC7LGu6c3ium51ay1/1URO
         pSneNt8j15LY3KH+VkwWHKZLPvcVWzFhXQ81+DNPrtvPYABXFeFC9muH7KLEuI+Jru2m
         XAIrHU/DMpxdOvXJCpU8Br3oK4yHq0Nwr5vZqQJESKQFsyKRq1SXymVnSNCrx1ZfAhaa
         txXZSpQGYjgERlxtREqDi/Mu15K92qQkOMp1esb/mh28BEbTeBDoZo+7vLr+qpYKDD2N
         k4RxG6B6ZKqgE6XRDaCMgwFLmddfhewpvzwY5uc/SBMuKdnhjoy41QPAoStAgk91zQFp
         IoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875170; x=1786479970;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R82EmcXHhs23cvmwSup/qIsLmDPUlMW2Hdk+ax5bwFk=;
        b=EEsCeFilTKGE6rXuAiSw0ms73kkb1PeRBXRNYIR8uYIJQ2JLDU0e/uHvJIg8KQckxf
         xwARzObE2TdHuWZuU3FDXJuyifXUE+T84wE7S+uPmunz+KvLxzLx4gPCY7nlDXTvKamT
         JtSFLcLnkvgKzrizCGG/xM4wJJnVoiS/pbjcfUHk4PK0hZGxmz2BbRs6LoVAj8S1DqW/
         YLoztxAsZ0zZZer6X8b+e0AeWq2i0ZwZKA93z/hf/C0Z7ryWUeIvHlgEIzbJQMh3Uzdz
         eX2fSWIcEpvj0wLjnY9qzgX+cdCeXQDV1fTRwdX0zHueOjqq43el32Vjd/Oh8y7g2qGh
         iQ+A==
X-Forwarded-Encrypted: i=1; AHgh+RpGS2rkP+inu/uaYAIR7KKtx6u+2SWViwSze2PAaGtvmbHDsMTmskneyVIHBe6qXyqOZiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwnGPdSgiIl56aDXCYk3u3vgdVL1wI3lbHEM7On/IAC5GYpvN
	TeuXsw5m8i086N7X/Nos8Q7SxJ6doOalE6r5CJyQ7t2/K2fVG72LfRG2
X-Gm-Gg: AR+sD10YSpECcgCnBDuCLAkOmO9zTBWP11hxaCUWFsDoPTEYBfV4rDWpROuJKkK3cHb
	M4aDbw4v4l+JYHzwEasZIcQWyvUtwSdahTvVz3YHvJ+XRsu5qyShOM06x97wSrIBOs4hRRJaH8v
	3nAnLvkY8zqFvGgOmHAy0Y8RUaSqFfWiGgIt9xKDYKc1BH4Thh8m1QIiHGqQPdrsft/iEQRXIgy
	S5pRc42bwoFCd5HZ1t115mAjrnvEuKfm9vh7h+EupL9VlMwf5CfoU5lsipqWrHnV5KZNkI9cDMM
	/twijb3Jc8K/0ffuvH6mdUeIGwC7X6yQYcnQhI6TlhZzrHBGLThHTIW4OBvq+M8aXERW9TV9G+J
	owDyUXneQOZN6LKB9m6/Fgx44ic0GTan1B9JBsvaSQcfJcT0xvBb7CvwKvuyoZJpjECBhSqS4h1
	74K4NKOBb5oL1uD5j4uw2TWkh7cYvDUCpN1lHWH7Fo0FIJWrUfWV7CKfdOl/lMrCrmCaXHFl0hq
	KQ08xQPo0qfo2ii
X-Received: by 2002:a17:902:d486:b0:2c8:1c05:16aa with SMTP id d9443c01a7336-2d0ca984bffmr12437485ad.19.1785875169872;
        Tue, 04 Aug 2026 13:26:09 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4f0afdsm13428755ad.81.2026.08.04.13.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:26:09 -0700 (PDT)
Message-ID: <9552fc68c2d06c5dd88bb7494b4934e779bc45c6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 13:26:07 -0700
In-Reply-To: <4d3b9137362fd9151ecdaf29d863a6cc0b0799d1.camel@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
		 <20260803125115.2264733-6-memxor@gmail.com>
		 <7f0d996cbfb2703450b9974d18c9f60ac2a3a959.camel@gmail.com>
		 <DKGFO6NR1WR4.JUGJA7Q941BU@gmail.com>
	 <4d3b9137362fd9151ecdaf29d863a6cc0b0799d1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 13:24 -0700, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 22:14 +0200, Kumar Kartikeya Dwivedi wrote:
>=20
> ...
>=20
> > > Which leads to several conclusions:
> > > - We should reach a consensus regarding KF_ARENA* usage, as these
> > > =C2=A0 kfuncs would clearly benefit from having __arena annotations o=
n
> > > =C2=A0 parameters (on the BPF side, on the host side these should be
> > > =C2=A0 declared as plain pointers).
> >=20
> > Yes, but even if we do, for the time begin, we won't have support for
> > automatically emitting it until resolve_btfids changes are done. That s=
aid, I
> > can manually add the annotation for now.
>=20
> We can fast-track resolve_btfids.
>=20
> > > - In patch #1, it appears that there is no need to allow PTR_TO_ARENA
> > > =C2=A0 for parameters passed to such a function. At-least I don't see=
 a C
> > > =C2=A0 code not involving manual casts that would require such suppor=
t.
> >=20
> > This one I don't understand. Why wouldn't we get PTR_TO_ARENA typed par=
amters as
> > arguments?
>=20
> `(u64 *)val` is translated as an address space cast instruction.
> This instruction yields PTR_TO_ARENA. Except for explicit casts,
> how else can you pass PTR_TO_ARENA to such a function?

For example, `foo->ptr` yields a scalar from the verifier point of view.

>=20
> ...
