Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847F2571B8
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584245; cv=none; b=gitqP//Wmj6nX0Lz3Hp//VJ3vobGflDJjfTmy84C1PrwliC7zBtxV9JQGibuYc8DaiKKQM5lZ/ykjiPaLjJT6/IMe4bt1N7ch6QQKLF9F1RqcFQ2W3vTQ9mqRN1viC0Yryl6yVMgtGtZdd85DkOv+zPYcZZcuGglPoXpCSGG39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584245; c=relaxed/simple;
	bh=RKyl6aCUxQpVsXl5v1PjhpVMTuhFBBUDm9f2ucBBhdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZLa13k2sJ4OlvRFgy0rsz8waYjHh3wIpaV9U50TGZnJ2AGfge+QjqO9w0BhoT585pqRA1n23AGi0hZkoqI4BFY9TmaLND3lsDMpGO2og6/3VmKG25cnSsL+wWpDxlHSj5MsmTuqS5rJSO5+oFTyZTCnPANbq5qWSMnodmRSIRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3ymI8BY; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3ymI8BY"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8692a8568e9so767b3a.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789584236; x=1790189036; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RKyl6aCUxQpVsXl5v1PjhpVMTuhFBBUDm9f2ucBBhdw=;
        b=g3ymI8BY6P9FYPFtIN+Q6DobmGihuLI8iHqAvkzRAgH9KZkBveZRwUdtrioPh76pWp
         NiGGNtn9U8J8UJvmQ3v/OWpfsu91RIrbuuMV+3vimcRxBZ9n+XMl1NDaLYkV8dt0whtg
         Ct9HQ3IH6SV0sdKKi3IFG6e19v+01n4lBOcL5q3ekWowMu7Y81f7VSDYQb39OBOg8QKJ
         WJzSfY4+CMY4ambrcgzhUhC58NtOM1Dl4X8Gj9ccKxBJJjlf0YL8X8H5rDEVsKFjMWGS
         7HIu1lWkDM9vRVQllO2xV6cN7R8hJj/llazzAbbdsDDREKQSROieOJFh64ug6gNZsKjE
         oPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789584236; x=1790189036;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKyl6aCUxQpVsXl5v1PjhpVMTuhFBBUDm9f2ucBBhdw=;
        b=z3H0ClxJZE3WyMnSw6VIOal1ABqyifh4b+SSQ9vvnH+PUGDgHoS3/6yk4eU4yz1Pbe
         3gJZE2/iFpabFFK+URvrqavinf0/M4K+2USIMRTS4lVLFEDOurPVZmx2d5AIOJ626oq0
         1JZ90jhSa3ogrZOopFVSDLdxATMAfvrwPSzHo7LM3lQcV7l+nTe4FUSrC67yxMMx93Iw
         287Nptq2Z1p3nd4YFT2T/+sHIH3aJXPaUSnocdyklyOyIAjk0tUwhELqskQF9Tzu8e5U
         g845DlAYx3sBsQvr5tX4RK91muF1P3wT7XJHE/wHMR7IyC2YjKVg8UvbxCylbGWyjJ9r
         ly8g==
X-Forwarded-Encrypted: i=1; AKwUvBxWS6f5yomaYOt8MJMOzCESsRORbB2eDVm3O6dh7NhfkXyM//TIJ/ZihMubpt+vbsqGQcw=@vger.kernel.org
X-Gm-Message-State: AFuF++kR9nADUN/XyXcu1DiOFxggAcNTYDMcvGG7FFd+lOYvfbh71UU/
	ojApB3ohknZkGZ3nxVh/st0GVPtUkcvFUx45wsscAdqXpeh5WRVnw+HR
X-Gm-Gg: AYBFou3nQAQwXThGIc/Vb1wCgirTRsnwGQLv8NO+TuCBboFfLwI8SGWj3TQ4b3ckdb7
	7NGMqh2OPQ8oIl/NK+AkWU0SH2ZvwT3aRg8wLo4h3CAQXNT5ejXSOhR82szh+Ni2iExbVb5Af/p
	mgYEVCIKIEeV5TGORKyggrtJsHSYpnWzg270MM9fmzipO2g1/sab8pCa7FMAk3B65RwDX5TW8kb
	t4UMUzI48w/mKAdJCTHixLStEZ04cdzKI5Pe3oHqIzC5EHNgEB5UhoboIJLHxHOuacVKQ65SaHe
	vBGh1/i8qQv7D3fxFp52wT17l5wtN1ADOHb2FpHUyLzLZbB78whxVoamdg+9GroKivrlgprJ+XB
	ZM3Z/aFR+c9ESucib24MqbnX8Y9WySEe6xcWBFWqGCiGOlDnbkXYQUKEtibEQgPbOXrwCtHSezC
	bNjtCxbI8TlBZ9z2xd6N+t2mqvD7we3PfTFddvCiRjU3Ey1qo7g8JrhOIkskkseA6RN3wrQtn+6
	Rs+q61PoiADWY5SzaQillW0VgE=
X-Received: by 2002:a05:6a00:2e98:b0:871:b941:10f9 with SMTP id d2e1a72fcca58-8723abadb8fmr7337887b3a.19.1789584236096;
        Wed, 16 Sep 2026 11:43:56 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720172b126sm1740756b3a.38.2026.09.16.11.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 11:43:55 -0700 (PDT)
Message-ID: <b8b26cfa2ce3b93e364b3b1d5544c07062d8aeb7.camel@gmail.com>
Subject: Re: [PATCH bpf v4 11/11] selftests/bpf: Add truncated CO-RE ldimm64
 test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Wed, 16 Sep 2026 11:43:53 -0700
In-Reply-To: <20260914222514.1635018-12-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
	 <20260914222514.1635018-12-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 00:25 +0200, Kumar Kartikeya Dwivedi wrote:
> Exercise CO-RE relocation of an ldimm64 instruction whose second slot is
> missing. Build a valid BPF object with a compiler-emitted relocation, the=
n
> truncate the program symbol to retain only the first instruction slot.
>=20
> Without bounds validation, libbpf reads or writes beyond the exact-sized
> instruction allocation, depending on whether the relocation resolves.
> Exercise both paths and require bpf_object__prepare() to reject the
> malformed object with a precise diagnostic.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Tbh, assuming we are going for simple ldimm64 check at the start of
the program verification sequence, I'd just add one bogus test case for
test_verifier runner under tools/testing/selftests/bpf/verifier/*.c.
That would be something like 5 lines of code.

...
