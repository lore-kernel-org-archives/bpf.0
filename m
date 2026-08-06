Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB144329E5D
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044034; cv=none; b=d36Me8pJ7Gv6OJhwB/1T3eJQ1cZjlHz2Tw6+yJEcXS5uf1nHdxO4pr/a4ny8woZ/fh4UX5GaDfj+A5Tzd0C3FR98GJtpy1fO0XeMK+iSD4hjc99lq6bDN0yjGKSz3JrE6PQfO/Uujv0XBL/OfUKEARCFJ9Qq+GfjJePQNn0YCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044034; c=relaxed/simple;
	bh=4rwlssvdyxclDVyU4O9eod759u1ZWu47LbXTY8c2lyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pJZDyDMhxGdJvaPVALFiWDztj2UH5i2zFO9uKpv5S0asKthLj712fytBXkKLHbITLkKG42RQdkBDdTON3tF9QHxHU4mmVU/6tCxmTB9wrcmbnjop91dobRbQ/LTwY6C3ZTzo0wcyeIbVr0Pav4Lsqp+C5nat1PzyOOGckN3mhng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=prKY/7Z/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prKY/7Z/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a2dcede83so3683156b3a.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786044033; x=1786648833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4rwlssvdyxclDVyU4O9eod759u1ZWu47LbXTY8c2lyE=;
        b=prKY/7Z/sSWWPthG4LEoWCz0xqz0BG8LPG/diMw8Qs88ybqEDyTkHU01ML0XJa2b0o
         niMoA26Ll+auo0EIfz0E3sTUCxVeLCVUDTsS5+2kAonw5ozIrpdH3X8rhHD/D9DJHTzn
         u0sF7Q6NIS0/kcdDngiIX5bq7n4R0+IRW5J8nid8oVxr5qGZmwVrw6V1L3dFTiNSMoF0
         mAxSD7W1uAxa/QdJQDQKhGS/Pl/NmFYMU7/FODeClWOvvJokzvnNU+8vXgVMBRoQojRD
         sVmYjrl2HG5K+8lL3Ccyg46EjVEzPbdzJFktaHYyadnxc46ZL7dSRMXUtwLaUSKA7pke
         S1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786044033; x=1786648833;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rwlssvdyxclDVyU4O9eod759u1ZWu47LbXTY8c2lyE=;
        b=qbR9cnj2oviOpnus9RkNWZFlm5zx1KsIU8rcKUv/wJ7EEJiHsCKuTTcHQf8e1sCqD9
         VdoSWk0FUGV/O7Dr6tJp/kYH2EPXUzQQrHOB73l3Lwr7ai8Z/q5IakPvmI6dgVUpLds4
         u0YLAJu4YNHJlyERy4OOJFTWIiZmgD+IBhgMYVBEKMPwceGNoasNpELq37t+jyXUf6f6
         0DszQeZVio4ZEw7i8wb9FuayDQY4FwrvMX+2TMfSE2PRmiwiMjU8R24HTmECy8E09sRd
         yr1cB2ZpvJTIFCUuRK55IZKjfgEujoluig/1B21DbzalEaTzrqP0glG9jo+zwOhLivbX
         pHAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGrk72Atc9RwAs25ajzY40JydEJzSJ9H9xDLPKRKzYnHCYxVOmZIYXoDPvLhTHE4hDHBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtYx0nWUQeCHm+nldEsD7w75qwUR1nEltMrJsDOvuZAhhAuD5
	MzSZsDahTBG7HdsOW9E1X7DfkDfboX7DJ5tttIQDGJELLstuM2OIzbnM
X-Gm-Gg: AR+sD13CcyEoxISMTmeAHRxPw1xAeaWnCEmSxDVBXzj+aQWeFlsaAsjNbc6Xfzgka3m
	V+9cgACeXYQHbsQ2FuMpl6cEGEVTtv1++1kw4RZax1WMeCRKx/SIRdwZxxhSNCB8gANst5HjwVm
	nBmWeB4GMvCk6NCa+7JZobe3nNAAYy8kGbkskNN4gNWBbdQ7RgYRuHM2Km/0q1GoCOlkfOmA8Ch
	vMklBETnFpgoRMb7AK9jx5EGp1+sFzKwXbum6YJJi0KmKt6iKsbG7eBnsg5lpOEKdvxIiX73SDP
	YhYMKIReEOu9ssApAEQ+BdLek5fA6+IVz1OKkSpST21qhkDA8W+iZOEi7GHa/cBrwnQF0JwJP5a
	roQQp8JnI7pgS5dQ1+iH69LjJy4cU+6UpN4BhfkCVllEHNoPqVDxVI3/tkaUTgk6UxaBOGnq6Mh
	hs+jQ5mXAnCjgBy+tHZAG3jI1t085RDpocSfT+X2RUR/vj3uATScnqSR/1PndlLVtD3DlC2kGsB
	vPsF9O55Vclf+L0
X-Received: by 2002:a05:6a00:430b:b0:847:893f:2d0c with SMTP id d2e1a72fcca58-84f2dfb5113mr21619405b3a.5.1786044032903;
        Thu, 06 Aug 2026 12:20:32 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708e32casm2991877a12.23.2026.08.06.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:20:32 -0700 (PDT)
Message-ID: <6976811166d665aab176fd40ec56c24c76f64bd9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] selftests/bpf: Verify decl tags
 emission in resolve_btfids test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 12:20:29 -0700
In-Reply-To: <20260805230648.2354989-6-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:
> Extend test_resolve_btfids() to assert that resolve_btfids emits a
> BTF_KIND_DECL_TAG named "bpf_kfunc" for every kfunc, and
> "bpf_fastcall" for kfuncs marked KF_FASTCALL.
>=20
> Add a btf_has_decl_tag() helper that scans the output BTF for a decl
> tag matching name and target.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
