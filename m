Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793385183;
	b=tEW5gZUp+IbHqMpk+GS66rZpUptBl2w7Tlo8nBdVEAWzwsY7eX40DqU4FkW7ytQCsL5i
	 878gNsRQarjlVjv8xoAZ1bmcqQOgJfs8qLPta7fUnjD+w7w2VFTT4E16ojPYn6rtRbxaB
	 F3oLHdDnFdcG9koDbXrVwbJBNEa7hPxWgVS+jKTn/UEP+z828h0ZvV8KMAQIPhmZaA6PU
	 oNVY4MUVV1V8bisv176YUzMNOCNMQORcoZoBWTSHuvSKHQBWMohWL8+JDAbLAOpGXplgo
	 XyPQ3KrNbLLr5bhOIdZ4wmWLj5yjMbUlfc6uJIFXtd0T9JsRCqMsBzJGjdIEejesRKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6diPpuSI7ZQakc5U3rnHtMFr6ZbHOPgPX5V4mX9Aiqk=;
	b=fFzFBIQN8uxDswSJ6QISzx+SORhXprpucLIW7t4phgm4yFB9wtfW8hBlO+qAk+qcsLyD
	 jPcl0RC1e76TgLRBFZJRJ5E+otYkiER7ZoiYJgaPqHjXWl9WHyxgMohLZEyfDREZjg5+p
	 BOhcgp44OOaAXMX1YJ1TAESfOXUVS4LgWUluKxoA7NfGvgaT9WnT6nW4OvrCtaDwy9ND8
	 oAqbsEiq3/RMfdsRCif+n2y4J9i/FDLtmqyPqYIGVesAnihzQeQ7MTCDF0rS6BkuleAYq
	 NBWg0ovn1BzBVtNaMcd6hkM8JzoNSmyIxxooHnAPTEh/nLSQ3kjipPOAHW6mRE5FVIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NlktPH42;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189F606A32C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0189F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NlktPH42
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab98332238so642076a91.3
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793385182; cv=none;
        d=google.com; s=arc-20260327;
        b=G6Tzi9Onr2v/jyXrkkwD6BsR43Nm+ZN3Znd2Od17PeD03+H8eK4a0/+bQ/dc8ivcFS
         gZra3grhndYTk6Ttr7dsbYny5+nX7VFRaWqp9GCIMiDJ1X3WeUdq57r/ek6u4hLKGtIA
         UYotXCW6euLn2ozZpBrhdXukZBEnqNKWi8+n8CdC8u2a3SDLHWIN0Jmslc71nU3EM/wn
         TbQBMEHAr/QV83Hv9SvD68dEWh625D3QJeep8nPF3X17/P2Dv68bLTQtTov+89RwXccW
         Pyef/lACtTWsQvQ7jA1z6IXhcHIJySdJ1lZVaY6Lf5DwcCKIUz3PjHk/n41Ck7+owXAq
         TPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6diPpuSI7ZQakc5U3rnHtMFr6ZbHOPgPX5V4mX9Aiqk=;
        fh=hxRZ/yxzH0mnIMeGpQd7Zzze8yONgMQRyPM05yvEJ80=;
        b=PjVloQ4S42C2JPpmCwJu9d69aTlZcKXhyqD93KxIdDdTalvUjNvFEJf2FoiTz9AFeb
         oGNezlP08wnNntohBQjQHDwaDEmwzT7YT4gK5/DSCns2hfR20+DCj0T1UKT4TQfffxrl
         xBC78y7eShvJ2Q0rxD58cZcpYbQk3abKZlnarSxSqTIMhRWDEo1skOTJMuVeMB9oAQbS
         gh6gt336y9eQwWxF/9Y9EwyXloC+mIAryDy2w0S6ScZ8z1hW63u4ElkYBEIiU0jJsk8B
         kuTnahz+F3SI4okyTagJcM/sgPXuxJXgu1vLQH85L50h2Ie2Y3F7oKD2blK9rX40j7n5
         pLaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385182; x=1793989982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6diPpuSI7ZQakc5U3rnHtMFr6ZbHOPgPX5V4mX9Aiqk=;
        b=NlktPH42Pj3UDBtIZQdJct8Vg0WhcUJG1f6/zFRjnGSaeg1jER6ad8dQbgBR5ExngT
         3EsFDZ1Wnph09jogEYZKXPRruyY5zdYo2wExoZmV+pAZfrTz7mvvUlg+b0z+ALNvTfi7
         q4ZNImjXS++UfjzW9KOCouuUNeVGqTuCuCMWR2UW+iyg+ee/V8rOKvmMArCWqk/dP6zk
         821QEEGl8AVtmzlJHPATxEledcebDrfk6blFeAUVsW0ecc5m/6KvCuU59JdVMrioQgxf
         8opUwaWdmSjBaYeoYpkKGl5gUXVIvM/X8bVzlBVs4RXfYhy3cNndzBtgz13/nLicXn3F
         4xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385182; x=1793989982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6diPpuSI7ZQakc5U3rnHtMFr6ZbHOPgPX5V4mX9Aiqk=;
        b=oAhUKCZEZY/AflVR684YioK2kopwoNWqnW6d7QilicdltPpmkA5FqMdsj7xa4cL3na
         JhH4rgVMn0r5v81DNn3Md4Nu9X2ydyQQUzFJ1S2kd7qkM3dalYzBfP0rvKd8BCKx6SBf
         dL013ugxyL58+z1ecsVSeXAdVXLfS81vFAUyH4ewO43Ie9VJwE4vTfBP7ZNbzAGR1oQI
         HYBnY+kpkbfOVbpIyLCBR7bWRomVrbOuSsN3U9HfYcpBIdKe01olu22npoRvm+47Kx2V
         UW4dEPXvF6g/PEiDxScMJNHUrXu8I/dv20dKrrvNAu5zKNV6TA9i06nml/RUnRcYxV3M
         M1pg==
X-Gm-Message-State: AFq9FYLnHPxxw46FLKbXfT6I3sC5ZaIEbBVxxNI1TOC4vvHZaLyZFehm
	5pi1D69LxH2NvVJV7NHE+jRfDI6//nmNJPLS5L72ZBYgbi5/8Abe9eu4e+tj+UAjUXk6/QEoJFM
	ywLwJ9VlhSlPq9ky/cTm6Gugm0FkbHbQ=
X-Gm-Gg: AYBFou0lOl+1OaBy4096QvflPcuFNhfB2/ZzPf5YeSCOrlrcaHUj0tW6Yo13eCsV6wZ
	mSwEpIMgx65K4iDBKClkeBnmcr3iPypwVXkeDi5QkcMT7uFf0PaJa38TsIIw+ggKJec7MsMr6g6
	Hr5rxkmpGZASuOnRPhB9xU7sbywPba772jt2UM5ki/uv4MVhwj0nZAW4WoJpknDltVNKxULXTFS
	6lWNJmnbgDOEDEPbxg1nROsDL1ZMQZEABLoMpGrjSDM2TfU0MaF5PpNcdbL+cX9g0g7QkBswbij
	8sukntIQtLmUaafLmgAtpNCM19UMyWVwl/vGFzt/vMONiJL7v6/lvThvlzBxix8hbZgFPGyzpvw
	E51X8bDaa6upfCO2sEAPPxRRZzmn+Q1TlpZzBixmivh1hjo7q3dsOBahy7Q/+uGYm3HVib8jCw/
	sLDGjNKhf6cTy6MFp6aoHH2nwK6/CeK2uij22hSJfsXj2L2hQ73sh2F2M=
X-Received: by 2002:a17:90b:17c1:b0:3ac:a7ee:6760 with SMTP id
 98e67ed59e1d1-3ae896f7f94mr2731780a91.23.1793385182251; Fri, 30 Oct 2026
 11:33:02 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com> <20261029223348.3730738-8-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20261029223348.3730738-8-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 11:32:49 -0700
X-Gm-Features: AclHuK87zHNq5nxU6nrnLe6A1tQzWhCKeqUUjPPJrWfpsnkeIVEdLv14FJFXDC4
Message-ID: <CAEf4BzbcY1+CJY02-bwJrg8Wr9Mc9E8qowG0iRF50any2p1D-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 7/7] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:34=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> veristat used bpf_program__clone() to verify each program in
> isolation. Replace it with BPF_PROG_LOAD_STRATEGY_MANUAL plus
> bpf_program__load()/bpf_program__unload().
> Unlike clone(), which skips binding RODATA maps to avoid mutating
> shared object state, bpf_program__load() does bind them - but each
> program is unloaded right after verification, dropping the binding
> along with it.
>
> Also, add relevant test case to struct_ops_arena tests.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  .../bpf/prog_tests/test_struct_ops_arena.c    | 48 +++++++++++++++++--
>  tools/testing/selftests/bpf/veristat.c        | 20 ++++----
>  2 files changed, 53 insertions(+), 15 deletions(-)
>

I'm dropping this patch for now, please split it into selftest
addition and veristat change (those go separately just like libbpf and
bpftool is separate from kernel and selftest).

[...]
