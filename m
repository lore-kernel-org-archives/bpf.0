Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77228352C34
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484741; cv=none; b=LzKihsTqWE2fZziK8endcgylMEgj+Hr5vvPhutmSlwZgU3TdnTaFYkz+mU+assICtjDq47/Vr/JEW5+68Ga8ayTbMIsH/P5HE+YqGdYYtZqIpK39fNS2WpHhDH+B0dVOne8sPADZDr++PWNFzzD9x4rjbQaCLtGiqb7FeF9Yz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484741; c=relaxed/simple;
	bh=l2I4h2348rDh8x+jW2z2jdFqYjFPK6PNULZizwSUWV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AawiumJ2rQ0FklD+smvs41K5wh7dTr+rFMZ83BW+pZoUO/e8v/aY2dEJDc8fDeZOrkQI96oeV0UZBoyHTvqruESB+G/P/y8SgzrBK9wIE7kngnFd0KLWwZGykIj88fbnpM8wYeCqWqcb0V0ZzOg2L3tresvto0HAgbYnId+Dxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4lNfIIm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4lNfIIm"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848761b5897so71780b3a.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786484740; x=1787089540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OM6BZ9DAYVfndX+5WTuWDzY9P3dZ9W+R+GxML11hZwE=;
        b=D4lNfIImCilM60PC5usA1BfNKzfx37eg2+fGFNyDgic1bYNQyh70ZniatTVYTdccuY
         Gwk4wWCGWugbl2BXnRiWeZ8/xzdlsxAgDd/h1bvkdDIyDgHBM959csdUZVngK8MV8DLp
         dmWuDhwtYrkNKdZUNiejZqW6HHdXRaDy7cHU6x0CizWlkM25KJtsUt7Wkt1eV6TJmEus
         gVBaw/gNhcUpxxXwwF42XaUFa5ppRonZOzjZMnBnfcviKC3cvRyIs2mt4jXFtuDvyKgZ
         l9DVsb+hGgGYvnn2vz1pgyrVvfpdl3GVC74QHOlEsN0+n2Zw2Oco9HC6nAc4BKLYP0FE
         /ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484740; x=1787089540;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OM6BZ9DAYVfndX+5WTuWDzY9P3dZ9W+R+GxML11hZwE=;
        b=imfPDw7CnodnoYu+iU/E3FtF03oGPtMAOy5bSCLf8W6iS5OsaQP15rw8QEKl3eks78
         tU1ie+sBhDaYD102BA93gz6dDqBo2897q5kZV5hOu1oyATkT8z4u17Yck+98mfaEPqSo
         Mb3XFD5mSOrWQHoTj3GC2vGj+NYhk/aLES8if+NF8ab2Q1uc1JjTqM4fxm2pVAZ4f+zG
         0ffF3NoN2UdwZBcfvVq1mkfJB9c72ybjnln6g9Zb9CgWQACuEC0iAib5qVhz1lAwEqdl
         pIhliHw+cPUGqTH85/y6AeikhN0rbVJcxfTg9sVjbKBfa1xuWvOCvAJ4WcsQHWSR7dIP
         wi7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqNlUgpCn6H8OacukzfkdmKD1W3ss6dLSNceu3VyTPafeDqzt+bnFRPPB5NGp+JETL/EGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtA62ZaX6JDQzG+ayMZ9Np3xplyeCTIy0IZha9vxBmc1xNnCA
	5PV1S653Yvy4t84i8QFln010dSN/j+mXKbAvClclS9MJhvwM4qenL9+W
X-Gm-Gg: AR+sD11+BoWuxo9cCjh1PcTvqrKMCL0J5VxRYXJ9LAx3AxAuBWrA6mMLntKtIukoPBr
	DO/jf8SsMh1R4Eq6su50EKU6JKCUQ3nBHm/clvinURYrFx5dvwz/6Nf8DFYRD+yxreBU01uKwd7
	/ZxhWGmOsWMJWZB//S56L70rUStfj3RA6tnZX5FD5EyVHQ0xTR1OHHtaAPdS87aRgsBwdm97TE+
	s93/GYRqtLvt1/3xlhaZM7TYvaTRYkhWxKruaeqVsK6PLeXpVvVyr3yBIMnFMrXFTFjG0EQtNQP
	rVUUmedXoK62DYmdqUYtsEADhmpRal/mKA6cUl2KSrtXTX7eGIVR8ZBCiyWiv+5X+j7soF7THVh
	4aTXsGlNlZ61VN6+7E4rNVC9US7dEqq5j+fvQejK4+wmSDm7iYboYn1mfKci3J2lE9qYV0e7vIH
	4pWTBXjZGrFSNo7+1+/dmYRGdw+OxarFSBP0+ltg04SjbmwiqezyBzLfciCZ45Jg1bIjlNGe16K
	sOASCamLHmcK8cRiC0iWrgFKGn0EsnnQGSXjsagTEHVNZ0WVtfqGqzhEw==
X-Received: by 2002:a05:6a20:d80f:b0:3c3:a1ed:3c36 with SMTP id adf61e73a8af0-3cc37dba1camr3984039637.24.1786484739578;
        Tue, 11 Aug 2026 14:45:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124583ad0sm2618051c88.12.2026.08.11.14.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:45:39 -0700 (PDT)
Message-ID: <ab558ace2c4806c58db4b82f5d35953cce1b548f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Derive the atomic load register in
 one place
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, bpf@vger.kernel.org
Date: Tue, 11 Aug 2026 14:45:37 -0700
In-Reply-To: <20260811131600.506721-1-daniel@iogearbox.net>
References: <20260811131600.506721-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-11 at 15:15 +0200, Daniel Borkmann wrote:
> check_atomic_rmw() open codes the mapping from a BPF_ATOMIC to the regist=
er
> it reads the old value into, the BPF_STX case of insn_def_regno() open co=
des
> the very same mapping a second time, the const folding and the liveness
> transfer functions a third and a fourth time, and BPF JITs need it as wel=
l
> to know which register a faulting BPF_PROBE_ATOMIC has to clear.
>=20
> Add a small helper so that all of them can share it. No functional change=
.
> The BPF_LOAD_ACQ case is there for the JITs, which do walk all instructio=
n
> classes. const_reg_xfer() loses its explicit BPF_ATOMIC mode test since t=
he
> helper checks class and mode itself; the BPF_PROBE_ATOMIC it additionally
> accepts cannot be seen there as it is only set from bpf_do_misc_fixups(),
> that is, after const folding has run. arg_track_xfer() keeps its mode tes=
t
> since that also guards the stack clearing next to it.
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   v2 -> v3:
>    - Also use the helper for const_fold and liveness (bpf ci)
>    - Drop the return value comment in verifier since the helper
>      comment already covers it (Jakub)
>   v1 -> v2:
>    - also convert insn_def_regno (Eduard, sashiko)
>=20
>  include/linux/filter.h  | 24 ++++++++++++++++++++++++
>  kernel/bpf/const_fold.c | 11 +++--------
>  kernel/bpf/fixups.c     | 11 +----------
>  kernel/bpf/liveness.c   |  9 +++------
>  kernel/bpf/verifier.c   | 13 ++-----------
>  5 files changed, 33 insertions(+), 35 deletions(-)

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
