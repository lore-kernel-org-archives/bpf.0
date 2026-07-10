Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6FE573
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642015; cv=none; b=qgmeXoOtEDWQMWxU1jrtQbk4Lp13lNnzYFTvOAtUx7S9fqaFrholj34y+begYFRgzhKjOkFDhGtyJMoPvQS5wIHodONENRt3Ef0E8ppQzzkGz1aIfcxV1ZYTHVSIvYYYXCmTyWmmHfnMT0kTTTRkw6uvIgEVq1g3+LNgwAcCJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642015; c=relaxed/simple;
	bh=3EwLJBlDU0ygG45bGd9nPXY29tb2GvuOlJ+p/oegbuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bF27T3yeQuZZbv1+o7t7ngTAIHAP9eVG4bgx6fLCFfioe+cnIMDj8n+ApD7UX8bdCJ7HiVx6ukw6CI/Sja4zTYmwA1QvtmMTllCjfW0wfpEGjIbvXhqVMMRk3fq0VKDg5+YEEUjoGgRGmID5NGse+U/D1KHfI4nU+dcyLQ6+Kr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccS14Kyn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccS14Kyn"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso230952a12.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642014; x=1784246814; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3EwLJBlDU0ygG45bGd9nPXY29tb2GvuOlJ+p/oegbuI=;
        b=ccS14Kyn45bEO3mvRzkJGD+AB9x8xmcH5ZF95d5W+/qW1RVdEJj0yPfyijQpFw08t5
         BgqFD5pqE26ofR/DEZ6ElUmMNLAh2+8kVDZ6alCVxwMqWzyxv+9xefJgC7CJxQ6I5Vpg
         IehJYN+5b0M6mwNWYyI0nzzQFp6lwxT4TPJrNCKb5JtKYkVH642X3DeitQWr/I3MSxYB
         67duZNLPPYg06bIB3PS9sGNuguagAHgjzjKLt1VGEeXKaAufnTw00kCuoHiXkaSWwyCg
         PRTMrQ5yfhPq+1dwWMomiFrvxfqw+ngHJqL/mGDwlbofgSn+BklOGFBPW7014XKRtBlQ
         J8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642014; x=1784246814;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EwLJBlDU0ygG45bGd9nPXY29tb2GvuOlJ+p/oegbuI=;
        b=Q39OoJS0mnXq/BD2XCMN8z6+Kog1tbzne+8Ov8naCZkGvKaukWOatIozLdYB3NbOdg
         q5ne7US3UBQTLJ+Lr1j7FelsSzciyEbSsOPan1oFWHRF924QQPDjh8crn2WgG9NFdJRd
         Ofkk7vTBZZUY7X5LpdXbzmSM5jcNEn5QgbZdTH4DpqTg79EFLRjpGYY0O7Pz4OVIpyEP
         2ebuzWE/6lL3h4LlVjEcC2SOJmPKnHNyXHYtCr/plym9cL2+wQCVo5nNzYxXM3LSCbOS
         mjdl41TtNppaFqC3UqikxbqcYVUCbJqdW1a37etT5IsNybiU1eOl9CSKmrh2bup7Tfxz
         jS4A==
X-Forwarded-Encrypted: i=1; AHgh+Rrw8Riw+W5WeR0W6+Ps7OT4UKD/Lolbx6zTeeoJlVFwnv3kOLUYZj5/dxmjMeaj9Cv4MAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2jxraPxG+9eeZxIf5pf0+yezqHcgtebIu8REntlcbU/7dOM9
	A3ITjBcC5V1txHueAnFGJ3TyYh1yxgdThoBf1rEVlQTKtIE2A/DoeeD5
X-Gm-Gg: AfdE7cnn0uVwJizsVXj8ziYHGaSfPNvDhFcMo1R/1MT9h2NlUc+5CjGOP9yV60hRLhH
	IGerBK3b0NKmekM4dT0OjDijGFNeOhvPD5UGtHVIODAn87OIAH55CdNlkdC6kCr5/k2kZRCYJz4
	gC0HB4mR0JKNX9rAPAIH1TOtRTS4uJWLROAP9ou2iogO//1f/zg2bZtLACH8KgX6eFl0Qf0qH70
	rEIE4F5wejSn/6GE9IzX6SGTNbJ+zeYKxoxKheNVIxM9vrKutDUI4jw1Rs0KZtzStXEyyFatQyW
	463NCmI3CJBkmrI09EpnbQst81vk/fGJtb1K/jHHiywKYbSWwQe5Rcnd7uQh61zDNQCmPzkyoze
	5xQbQv+lzE9Ge3dYn4cWvsPJPxmzVgL7Y2ElkzHjKbGKVxTw+PsENduQjIIZW77EfSaZzWlYhsT
	UPfYIREMGC+++Uwm84sraJpK8Sgmu0xPK5jXVmMwqN
X-Received: by 2002:a05:6a20:a106:b0:3bf:80c9:6b3e with SMTP id adf61e73a8af0-3c0bc9a6799mr10452182637.30.1783642013647;
        Thu, 09 Jul 2026 17:06:53 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162d56sm4333330a12.20.2026.07.09.17.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:06:53 -0700 (PDT)
Message-ID: <924164ae0869fd1463694a48286bbd7e9f1ced65.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/12] bpf: Wire up JIT support for 16-byte
 kfunc returns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 17:06:50 -0700
In-Reply-To: <20260708200955.2156484-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708200955.2156484-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:09 -0700, Yonghong Song wrote:
> Continue preparing <=3D16 byte aggregate return support by wiring up the =
JIT
> side of the R0:R2 return convention for kfuncs.
>=20
> A kfunc returning more than 8 bytes (a small aggregate or an __int128)
> hands the second half of the result back in RDX, the native x86-64 ABI's
> second return register. BPF instead expects a 16-byte return in the
> R0:R2 register pair. BPF R0 maps to RAX so it needs no move, but BPF R2
> maps to RSI, so emit a RDX->RSI move after a BPF_PSEUDO_KFUNC_CALL whose
> function model reports ret_size > 8.
>=20
> Placing the second return half into R2 is possible on any JIT, but it
> needs architecture-specific JIT work. Rather than requiring every JIT to
> implement it at once, add a bpf_jit_supports_kfunc_ret_reg_pair()
> capability, defaulting to false in the generic core; an architecture opts
> in once its JIT handles the R0:R2 pair, and the remaining ones are left
> for future work. The verifier enforces it in bpf_add_kfunc_call(),
> rejecting a kfunc whose return is larger than 8 bytes with -EOPNOTSUPP
> when the JIT lacks the capability. Only x86, arm64 and riscv are
> supported so far.
>=20
> On arm64 and riscv the native second return register is already BPF R2
> (x1 in bpf2a64[] and a1 in regmap[] respectively), so the value is in the
> R0:R2 register pair on return with no extra move, unlike x86 (RDX->RSI).
> This has been tested on x86 and arm64. The riscv path is expected to work
> by the same register-mapping reasoning as arm64 but has not been tested.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
