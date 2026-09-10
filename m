Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A52F6931
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080199; cv=none; b=Onv1jwMDa6RW//IqIHGYbYuN44+o4s9lffETW3ejnnbvLti5ud9/tVGKfZ5QTtG0sIiv4K1eOr0VDbsu2AapeTPZc8Ufq21yb50YZmpm1nCEMPIOJgn+XWioBiL0JK1MfcXZks7KZzr2etdMEkKdzrIVlt7RxDtd/BYkl8ngUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080199; c=relaxed/simple;
	bh=7PIpecPJpoZvOhrKSUYeeB1ES+6HUYRNIU6T+EOhjRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZPUI3rx8+BkZbT2ksfr+eVkChxxHdbNmdiEn8XNqVmFAuinWRUgTiIKb+10COLfw1SXAxUci3TqAqo9h1tXi2h/kpP2JoFnGPIZFAW6vK8xyzaG5DUvuinyj8RIdzf9WI9cFPVWfjkZWOOm9Kbe0ACcJL+sLEaipwMao7HQhrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxsXGw+i; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxsXGw+i"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8557c3f270eso238829b3a.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789080197; x=1789684997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7PIpecPJpoZvOhrKSUYeeB1ES+6HUYRNIU6T+EOhjRc=;
        b=lxsXGw+iFlotqJmOIzVIPsXak+C3B/Q2oNS0F/EptOK7ApORnjrzjAi5GkpMvNXGog
         HWWXtcB9Vh6n8IgBOtvk7yKKDbfWCTQGsc6z4LRy9Q/sb7Ee6RBBY2v5mUCsC8JZGeyr
         aCx8Z5diA1bCwKgEiFORQgWzJ5l84uoszbon5G9kYflsJKs/cu6/3YM+rgPg/nYR1rh+
         Ml94r14mcLA2xnZ568YE489JChJEJ5YDV/vIo0H7p0gdcoKsGW62+8opE/JTMSmzOwaI
         sjs5vaZ5fd2LL6Y5eMTWmXGb+7m61yE9kEIuCBD7rMJyVA1hYh9w+lDi+myxOrANHs39
         lmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789080197; x=1789684997;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PIpecPJpoZvOhrKSUYeeB1ES+6HUYRNIU6T+EOhjRc=;
        b=To+4s6emMAxkXT4T1fsTdSozKQqJcedG9vlWDYOx5jkwrWmkM4FKLZPy7ir1frJr6r
         hXqOM5hVJkymirxi10Q3B1Q28b4KkEFn7Mt6ocdzbEgfWtx9VCgcDefcQL6jQ+zNjDWB
         eEfFY1eblkRgUqesArJRwjz2rasL7pWbchNnWlLnbj9DH1vA5u7KxFobxKegYHwimQda
         5QjYZueKE7h8ZXdWPqFDRq7QryLjula5QpJq2cwv5qEsmEKGqXcSM9rfy7xqemDfc9Ix
         susgZs+AONJB2HDSpbQQ5W9jM+oAt+aNhoPtTBNbAgTgLrEWZi6fC7OwF6lyJArJvGVE
         G4dw==
X-Forwarded-Encrypted: i=1; AKwUvBzUd8xbathLMFfR98hoVEsXvyTKaeaDWBBGFQs9jFM0juOrLcZOfEfebq9ilVdJiXernlc=@vger.kernel.org
X-Gm-Message-State: AFuF++liQKwf2QfYdhKXmhlwSS+ofUsIs121femhFJ+6S2pRTyvY8Uvs
	9SD2R4YodNAj9meLbnFr/lRsEcZ2I+F8rsJIjFOtp7l5Hv7SIEozzXkc
X-Gm-Gg: AYBFou1pxrBJkhF36MKKQlcawwgslPKvqgQECrW+PvmcF3EBfdPmsTIp5gppUqzUvQR
	irgVr0L2Cg++4UEAz/MZt+rS6FSHgbOIpZX7bFwLmDIxpO0361RPGsGiD/qepZi8rBUMJ78Fvpb
	itR6XlK8+/lqM80w4D8IMePsRwc7gjkROke+B9wVvHZqNDn+HR6cd5ovtHO+FuQ1/XDl70f1xQj
	AV+nz2d5ANU6LwxXo6pTj8d60B0pKRrcOfVArR0QvrpUdTAyFikfSXcg/vAjdilhmW03YvGMIgf
	c0EZH/XWsXb4Gp1WsKQvh80GmOQe3f8FETmRMJPoUMviXZdYa+81JPQqLwzvMpvD/MUWFfc3ReF
	S5Eq5JR+rfSrb7Fmn6IrwgD0pftTRdiyrudOzFNBAu5Am8GbKcSzSTHE2xUclO2n9rIlBGRUDLe
	DnbK+LdmLqb0HvvLnnAB2zD2KJG6S6tOD2fXoT4FPy8LR8F8W0EuJ6dknEKWL04f/AQEKt86on7
	fHzlRGrlpIU1p/tB/aZBCo59gtV3HBVBxkRQ6sywg3d/YFU9ltl01YWBw==
X-Received: by 2002:a05:6a21:8cc1:b0:3d1:af47:5f80 with SMTP id adf61e73a8af0-3daed18c27emr2348554637.11.1789080197109;
        Thu, 10 Sep 2026 15:43:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a3ce:533a:7492:3ff3? ([2620:10d:c090:500::4:d279])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fa50efsm1216425eec.28.2026.09.10.15.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:43:15 -0700 (PDT)
Message-ID: <9f28bead21b014edf092ca07c03de7380bfe5390.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: Add bpf_program__add_flags()
 and bpf_program__clear_flags()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Andrii
 Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Date: Thu, 10 Sep 2026 15:43:13 -0700
In-Reply-To: <20260910183222.307208-1-toke@redhat.com>
References: <20260910183222.307208-1-toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 20:32 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> When changing BPF program flags, applications often need to just add or
> remove a single flag, without touching the existing ones. When using the
> bpf_program__set_flags() function, this requires reading the existing
> flags and doing bitwise manipulations before resetting the result, which
> is slightly awkward to do, and easy to forget.
>=20
> Add two new convenience helpers, bpf_program__add_flags() and
> bpf_program__clear_flags(), which wraps bpf_program__set_flags() in the
> bitwise operations required to modify flags without clobbering the
> existing ones.
>=20
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
