Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79F38F934
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251418; cv=none; b=c7l8wFAIZlrgqbzR52Oy2U1F0d1DNyXSbeAYcQM43zY4bmzPOYCmA4FIbSB29EM22ZmmvEVjsvq8wzatfMQAMRaIrJydRqPTiI2xjTK+FznDpinKbV9sb4XZGZzRHFxbuimqHacEgziqvP70/1cvai1/BowpmED1y+dmk9cQbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251418; c=relaxed/simple;
	bh=b4ENfaBsVJRLUTwdTPub2K6QaU6LFLOw5bkkndWjqb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iSOkh2i3qSV/XyHSjbCKGkbkwOWNDdw65czpmH/o0G5ENwAb3z22mzpTYTbsKUJ7ji0cZOLArY7qSlAegN0V032E+gQURG8d+0Msu6dvohwC+BkLiR6MysJybNfLEsDz5fSwPRhfqvjVAbGzP3zUKi6/4oa0Ut0vtC7bxEDhz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDdHOFWx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDdHOFWx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso148719a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787251417; x=1787856217; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=b4ENfaBsVJRLUTwdTPub2K6QaU6LFLOw5bkkndWjqb8=;
        b=hDdHOFWxg/p9nn0JhnjDYA+azFCQLc2r211BGAUmiUd6Edk0Y+iAca8hdRam+Hzw3f
         2gfRIZ38wQP3IVeseoUeR3p+ArUz/Hu1q3eXYNVX29IoCq3T/49Vpg08+afnd6AYKD27
         RAHm28o0xmxCkolHzgw/+ulTAczqcklkpP/uwCUW2Rr4IoGym6bCheUbqaaPVUsO5Ka9
         bkLKESnsVbIrBeUVJ6WgQSfj+lizIwzlznQ1q/IRNW3lrbrSVrIuM4TxCf7uZ6rBixfE
         SQUGKZqhXh4fIQdgXIcYJl8bOPxBBO+Tmw/HG1S485AsNwNoxp/wVqFAAQZlNJbSoV/m
         /KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251417; x=1787856217;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4ENfaBsVJRLUTwdTPub2K6QaU6LFLOw5bkkndWjqb8=;
        b=DoslYSz5fAEPNbbiJZQlAwUNOIXIsfq1pXq8HwOFxDYqzZihBAAenKn4FK4IP1UXB3
         EtOlGXKvRnOhZsfLouLYBwk0sh9/UBcoUdK34U8+NqkKw1MBnfvCbryGKdTjjCdVhQiq
         /3UNUO2F9/fOwCK+a7OyEk1fLAfObWIMtvyWVgo2zu7uNFkCmsZG4TPU+dwEuBzkwJUg
         Z+dNMI6N24Oxvdxhpy4ySKD0pTUCn8inUuL2obyn/GNNHhRN9pjAYkVaqSiq+rALmN+p
         3ugR3OKzqgHlDHjC+eXVvOGTyKj24OlRsiO0CsUyGFR+aVeFqYLcPbAt6Y6yF4sl70DK
         VYjg==
X-Gm-Message-State: AFuF++mQcps71frYzKF+QgGWUQNFfyYrB/nDgLUhBGJ3Pv0O03BZazJL
	sgQlmWLKNUmUYIVOrv8bGmr3bW6wDgq+++xipHBhLJ2tlaO7D3a5Zlav
X-Gm-Gg: AR+sD122nk7JSEHiTm1Mhb6R3pwQxLdaKRFPyuGuRwswywHxmVQTMNWmTHKy79wPc4y
	l04Bggxu+VrcL6bYYKBb8w1A14RPWetWQI80rejMg3hJhUfxSm4yZOJcNyQ7y3+/QYZD184Kkj9
	kDEthKJah84a5q0egUGViXBgY08LiBv2MhyhE1g1EMM0zf+pAPKpAzkHV30v4DWrdWEOk8LzQO4
	Js/OmFZVTzIeSKCVlE1ECShaMJnnYxZaZxzCP+i4iUMXLFMf+h1BAmvmXACgIIT43jTkOgu7ScU
	udxyzEE8oxSKNeCyupnCCQx+wI51cBsmszE0mnYEuRbLIQM4cIyYK0f0pX+Fzze8Ve6/uWWtes7
	hs7bG2JSpNoongV2OV3hCGQLz8v0Av7TM29fbDyCY6lcnfgx1A01Xbi/Uw/7D0fJA7V6Lk0W4Fy
	SBfXc7zl8TlV0LbFzaTUJBlY1ft/w9ZQKzTA791g3vz1T+XVyg96A/XXTT66DOjeB1ii+xqabUq
	8n7VUw5rfQDNAkKPNaOKm/FqX6UrABYHDEj6JdEor1zG7VdKCM=
X-Received: by 2002:a17:90b:2712:b0:395:543a:cf3b with SMTP id 98e67ed59e1d1-395c3518185mr1142363a91.2.1787251416707;
        Thu, 20 Aug 2026 11:43:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad3d708sm16233330c88.1.2026.08.20.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:43:36 -0700 (PDT)
Message-ID: <fefe5b3af230f51a30f3f77c313452eca81aef9f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] selftests/bpf: NUL-terminate bpftool
 command output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Date: Thu, 20 Aug 2026 11:43:34 -0700
In-Reply-To: <20260820000627.3826188-2-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
	 <20260820000627.3826188-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 17:06 -0700, Ihor Solodrai wrote:
> run_command() writes a bpftool command's output into a caller-supplied
> buffer, and every caller treats that buffer as a C string.
>=20
> However fread() reports a byte count and doesn't terminate the
> string. The helper does not terminate either, so callers have to zero
> the buffer first. prog_tests/bpftool_metadata.c does not, for example.
>=20
> Read one byte less and terminate in the helper.
>=20
> Fixes: f21fae577446 ("selftests/bpf: Add a few helpers for bpftool testin=
g")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
