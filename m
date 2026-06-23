Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0FD5464D
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173278; cv=none; b=TjbveOHCx7Ofq0o+tWqCklbEz/vHmwTTJ6E1h9KPon+pyIFgJ2Qc7bfbyy8JycPzB+PfiznPwDbMaN9RnZ5cwReivrf8xKlvEHuRc5u9G+F78WoNDTfGXUGWgL4YtyP2FO17S1AGYOvTVepNSeEPs9nunk/f+7gt0icDDz6JcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173278; c=relaxed/simple;
	bh=nRV59y3Rno5LQFnWbfsFG/AK69d4DippmWN5QexS0A8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d05HxC9QVxLP5tZEUTT4v88RVLWykSW8/VoNH5GMgUmP51Q2G2PHi3NKpxtX/Sb2IuQ5OBk8yUC49++Vu1v6adtmc04v4WdCUU/qDcvlE36/S4X1ltLnE80ldhRfiRkaThrNLXJoFTwSai8Hb0/VB7dcKtUhFa1Zh3Hf9TiH0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSzL0RE3; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSzL0RE3"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bcdf8232fso10536909eec.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 17:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782173276; x=1782778076; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nRV59y3Rno5LQFnWbfsFG/AK69d4DippmWN5QexS0A8=;
        b=PSzL0RE3kBKj8Y2pyDrwX58/IHVxeml22HnLn+snl0DCL1dUe+YZ5uYg93XBD6EFhp
         SH1pOZOJxKYJykrwXqObVnnx939UkqH7tzTB/siLcBqmVFmvEjmFEQW17cnI6iNvlahH
         tJvIUNAYave4XRp5JwaycMjyRJFdns4oSgaSIqlOiIkYOyS5fpwrmJckWbr7x7cUogdu
         YAKP2O5w//LGm0MHkzS6SxKXp2zpaYyJih7wnd6jEoMKLOHS0bK19jHVXYU0jPnGvP06
         2Iw1KW2LdqEzHQbd88zEHfDQDPfLqIZ8Jo+N55OcFLeB+3r0y4zZa13otYgUmL4kczVV
         0HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782173276; x=1782778076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRV59y3Rno5LQFnWbfsFG/AK69d4DippmWN5QexS0A8=;
        b=Dycx+e59CyRkHHO72jux2+oPfcc4iRISk/JoHsFyWIOzFBcmpswYsOj2euH1Ha73NG
         y3t1vCow8aU177+E0zpIdqeUVHKwmllmosmMfnLjDlZHObMq5t6GX8C6Qfro8m7qmd6S
         67B7B/mGDnAJ7uSdpyGnjKeDbv9u+jkNXyhRywCgfPBjO70odA8YqLsQ1KQ5AP4xIa8b
         z9TOxJhnt+wfnCmU4q/Ox483EMkCGb3zkpY7GrcLgfWT77iiOlypmkjqVm8DhUn0tEru
         pkesVeaxua+HN2J97tSPwkd/6KjHiyu8i64opZylJOq6zyt3I5PQp8gr8pL0F4WLexv9
         MuJw==
X-Forwarded-Encrypted: i=1; AHgh+Rr4e3BOsxQ5uiNW2Blw5CKrTnbEDu0jYcG6JcorT7/cbB7ZVOPDbkeAz+KKzAqtF29640w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKbtDOWtq1GYgGoyiFttcfF4jt6MM84WNv9hzPZFyZCbb+tHA
	kMNnvmAr1OM4N0avYftARbCY5guJETWi938q97vlDaMzTch2suuChdMz
X-Gm-Gg: AfdE7ck2N75/Gxq1ICNtBc3zcCkjrXCLlLjcn5oFatccVIjE/PU7vW2/dRmSsO/NBXF
	HNeT7dg7tkThtgEuP7gSoCYcCtgEVdV7/FEO/IEimqBWuGIr7pAxffhZelILhMDPGAle4mBZbEN
	2UKk0Rwb8PLsbGKLOjZ6ThZJXsNaI+jDdpTpm3ppaRi18Mg7XoFLM8yuD3aJQt9b14n6ZWzNa3w
	zknzSJxOoF2+0YyO/hU8zS4SBIUEIXdVHAYsstJZdWqgZrUCPsdWdjUpIWDhEZpFhXWIg6Cfszf
	eKrkPnxoVFSB4o54BHOWM2aMpDyIYxQWOoHnb4372G3BwZeHOh1TRwDe5PW1aS5iPR/cR1dn8fn
	kogZ2ZK1U4nCPq9CfJtmLz5p9H4aVAUF2jcCpHvPOef9mNqnN/XsjLhNwZp/GTEpegePFTc3JUG
	SkCRnkHYpYBLBRXojeE0kZISRduxXqyv/FaS2+8pwREQOGU6FdkdP5OlnJuqqoRM+eHhaBeA==
X-Received: by 2002:a05:7301:38a4:b0:2d9:ad46:4a92 with SMTP id 5a478bee46e88-30c06e4f9edmr11670192eec.13.1782173276518;
        Mon, 22 Jun 2026 17:07:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c4f4:7a34:78e2:a600? ([2620:10d:c090:500::2:e8d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f8b2sm12488864eec.4.2026.06.22.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:07:56 -0700 (PDT)
Message-ID: <ee4804545dc421010b5ec8b2d8b30be168faf6de.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Reset register bounds before narrowing
 retval range in check_mem_access()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tristan Madani <tristmd@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Xu Kuohai <xukuohai@huawei.com>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org, 	stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Mon, 22 Jun 2026 17:07:53 -0700
In-Reply-To: <20260622230123.3695446-2-tristmd@gmail.com>
References: <20260622230123.3695446-1-tristmd@gmail.com>
	 <20260622230123.3695446-2-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 23:01 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> When the BPF verifier processes a context load of an LSM hook return
> value, it calls __mark_reg_s32_range() to narrow the register to the
> hook's valid range. However, __mark_reg_s32_range() intersects the new
> range with the register's existing bounds using max_t()/min_t() rather
> than replacing them.
>=20
> If the destination register carries stale bounds from a prior instruction
> (e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
> reality. The verifier then believes it knows the register's exact value,
> while at runtime the actual hook return value is loaded, creating a
> verifier/runtime mismatch that can be used to bypass BPF memory safety
> checks.
>=20
> The else branch already calls mark_reg_unknown() to reset register state
> before any narrowing. Apply the same reset in the is_retval path so
> stale bounds are cleared before __mark_reg_s32_range() intersects.
>=20
> Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
