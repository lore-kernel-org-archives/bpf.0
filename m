Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46933D6FD
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325429; cv=none; b=R9ATLy4hgSA1fWnPZb8angG5c0dIe6yeoQc+SSX7zPNOai/jtnyosxUT/aVMnE0IMQZ1g6QS9QcFiPo3BYGTFEN7S6Jp0f97oDVcp/3Jqvrfnjj7LHuHZoh2xAJ/VbG7+asHKfwDuCyu6ea4vtNH9RITubW4+ntp3BxDaj9V/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325429; c=relaxed/simple;
	bh=LURWwFmN6Lhm3n+L2kmQVrHIUNNBhmNaLACiuEKH+p0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1BFGolWvq92deTTtFgjFHhnjdAP4umfP+M5p2b5P/Ff5O+NLqThuDF4jRYfGvOR1HcgTbyvRw6nlFViiR2axSACWZRQ/ABxzlWJym6VEJKURsM1yQCEr/i+WfQoeJxaaZDaK+Yuv7UtbZ+guf9ABtemI8IDCWPlMjdrvzuf3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn8fPwRy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn8fPwRy"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f4c3619b0so1744145b3a.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776325427; x=1776930227; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LURWwFmN6Lhm3n+L2kmQVrHIUNNBhmNaLACiuEKH+p0=;
        b=bn8fPwRyteXquyoe2czMzelpphv20JKmOVwZFLTuQjA3eeXNWhUWbKC+o0jGCfNSX1
         SwDzwyuZU5Px5N56RD2fZJA7X8n+njERrks/UuGUxmn/Ns6cjbft+96N0uoT2xXCUlil
         VoByaAf3cJNvuLiEjYUVZ9hVBKhuR/8Uf/POIgNIXr4Q4P4QceFBRkd7g5zQWMKFNbqF
         KD26+82auGP8kORuKPwexoHznD6GXwAU1ShnTUZ15NqDSSyE4yUQ8U7JblSBSPud933L
         6LhfYmENYQV+eEOsqbxS2sssO/bvVd061jug/pUArd1AxmTges2olkpCtBTTgSgh8PtL
         LJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776325427; x=1776930227;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LURWwFmN6Lhm3n+L2kmQVrHIUNNBhmNaLACiuEKH+p0=;
        b=j9go2hITb/sCpDmhEiCJhbFPSNyUcEUn2TwvpTQUu14bjtOai/VV36A1vDn1fYelq2
         OFL8SmA2qcn4w7SdZpf7XxAHIrxeTukRUk8HuNI3o2TkWTz9v7KN8nY+f0FkuD9iq5el
         GsToBvN5lBQ2FIEVeO8okZH015WJOKCm3H7JVdUHuO9vgaPn2rar5S0I91NXHs2UGWfo
         j3dymbOCkV+QlvK+gYfYgV84GTuv53QKRf87tZZhEdADdJ0fu5Pojq1+SbLp6z20Urrz
         UHkZF8SnzTrgBSdO4SSPZShpaf72y5JMcBTSOTCY5GA7ugQDyt3I4UnoYuyqHO3D9aAw
         9Drg==
X-Forwarded-Encrypted: i=1; AFNElJ8Eaf81hMbbHI98x+M7dgUe4/fhw+Qo//pDZr9sJj7N9SS5pjWILNNByTm/5wvhRcwNPLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0InvtCtslr9GZHZK+UE3hHyZdi2xUD06tJiwdmOTgs9WmGRGH
	NWxZRUyzX1B1zhoihZscEDOhD2x7AV8vFKsterV5UrDRZrVf4hbHsKrk
X-Gm-Gg: AeBDieviUE/hJ/4dy1x+jGLeBZqDxKqN46RRtFU8pkdb700VEB8NGO+jmtEV1AGqHt4
	wU+4ymWP+5P3ZQ1ErmQszcrVTFIo+OGM/NK5MlN/AON0WuAWDq0viRf5i+GuY52i9OHcVvGXgHG
	tm0QXcY8uzScAbkoguhT3wdVH+oCZSSVv9i7iQf9oH9N2aBuPWcQf2/cKJP9WWMH+piuckScJnX
	nnU+nCTKO9KKu3bcQGh8TjqDGeR/9Vt0szjianSBla5yDeOx9EmoUOz0QRIKAU7sKy1nA1D/LRD
	C5q3gV+SrVLhpf63aHNwuC7aJ0BvUMopG41bWe9CiPEXx9px+meqVZKMMBxvjW9A8K8sqBgr8Xi
	1dUTfbbxJRaVtrfDFJdVDRG9zHoTGMa88jsfvAAiDPWf/WbVnCeJ58GrjuvKgTkrzVC/Y9qWJrT
	oQhchXMnQHbYs5In2/3PxiXVoFd/JWQELigkqdLaWzzGG2bzjtR50=
X-Received: by 2002:a05:6a00:4b04:b0:82f:6bd2:eac5 with SMTP id d2e1a72fcca58-82f6bd35957mr5136022b3a.2.1776325427368;
        Thu, 16 Apr 2026 00:43:47 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f673e38ccsm4366170b3a.33.2026.04.16.00.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:43:46 -0700 (PDT)
Message-ID: <ffb759d53577d1fe05b31373cd0a5bdd6661f547.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Helen Koike <koike@igalia.com>, harishankar.vishwanathan@gmail.com, 
	paul.chaignon@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, 
	ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Date: Thu, 16 Apr 2026 00:43:44 -0700
In-Reply-To: <7tgaeg4mpuoage626jaxu6sl6yht2ace4saog7yyx33pope7xk@kixri3atcb5q>
References: <20260410124035.297632-1-koike@igalia.com>
	 <16990d86263fb24079e6f0b476a8854ec2366932.camel@gmail.com>
	 <7tgaeg4mpuoage626jaxu6sl6yht2ace4saog7yyx33pope7xk@kixri3atcb5q>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-16 at 11:52 +0800, Shung-Hsi Yu wrote:
> On Wed, Apr 15, 2026 at 12:12:45AM -0700, Eduard Zingerman wrote:
> > On Fri, 2026-04-10 at 09:40 -0300, Helen Koike wrote:
> > > Unify handling of signed and unsigned using circular range logic.
> [...]
> > Hi Helen, Harishankar, Shung-Hsi, Paul,
> >=20
> > I think this algorithm is correct and covers all cases discussed earlie=
r.
> > I also prepared simple correctness check using cbmc in [1].
>=20
> Given the "Fix invariant violations and improve branch detection" is
> merged and the original Syzkaller reproducer no longer triggers an issue,
> teaching the verfier how to do better bound deduction (i.e., precision
> improvement) seems less appealing than before, unless:

There is only so much information that can be gained from 32->64
tightening. I think this patch-set makes such tightening as precise as
it can be. Which is a nice property, hence I'd like to proceed merging
it.

> 1. LLVM produced program show similar pattern and was rejected by the
> =C2=A0=C2=A0 verifier, which will be fixed by this patchset
> 2. We're proceeding with cnum RFC as a whole, and this marks the first
> =C2=A0=C2=A0 step (I am assuming this is the case?)

This is likely, I'm about to share the RFC.

> My understanding is that we just need the verifier to be smart enough
> to accept safe LLVM-generated program, where as Syzkaller-generated one
> is not as much of a concern if it does not causes any issue. cnum
> improvement make sense because it simplifies the code, and could
> potentially be the last time we have to touch 32->64 deduction (famous
> last word).
>=20
> Shung-Hsi
>=20
> [...]
