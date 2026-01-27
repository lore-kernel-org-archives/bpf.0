Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21D22256F
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769555329; cv=pass; b=hxMK1kSmtB1wbR1FLQbnSKX1D5upZ0uH+HdBjuewOAruIa5kY7vlC4aWdSDRzGGaXuV2AMahe0+Px61NEy5TKQA1cz0xyMk8T2BZk/PKGOXiPBjWAlAPne/sNkywwmOREvR0ZZtLFmwRwq1DYWEu/pgvDAsNe8MDM2Bf27tYFHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769555329; c=relaxed/simple;
	bh=m02DGZ7syi+38suiIi0OqYhAPASvnJjxwkmdJTFTL50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eygHIouMneWP/xnXtMjSTgWAMWBJj04TdI+iwkwxybdgsBDVdoId4O5xFvz8KBAkDYq4xhKUr/p5BP1lc1UULn4x6T2WLOr40wZnBLLqHGj9V3jBZlgGWS6wNEn/AP7HdLXut2uHdgWF3fQwENhlpIdEcJl2rkATVuz5ct9jhAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vexYWdN5; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vexYWdN5"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12336c0a8b6so1500692c88.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769555327; cv=none;
        d=google.com; s=arc-20240605;
        b=OhnWjkVt6r+Fvm0ioROmwDqR1oX6kCQ8gHXzziGraXiZUheukdlacXLTFD3a+EPKyT
         Fp9SLyPCZn46cJh5JqvF8wVv2AYBNzVANCjlVGAZ0Dx0YzdSDTQPkmy+ynP4PV4k7xnz
         Iqz9J1KjQqBabNEnnS6S8ULtB/sZ0Kq+4P7Rn3g0xL6WarHmWzL8hUrb4A3EOhubkd69
         D4SW2zFDxdY9NKunNx7VhUkX8rgXb3UixtAc9Vw+UmQL0tI28Srisu5BM+FAbplfgRCI
         MwXgv/ahet18h/sG4d5gDMxIx1zAFdVLaGm78uDG/IOi7jVHD64b8ZT7Nu1ndIuIsIDJ
         cCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m02DGZ7syi+38suiIi0OqYhAPASvnJjxwkmdJTFTL50=;
        fh=06pmUUT8gZ0rNvrquz08lYLVxpXrP5aZ+10WAhGEihY=;
        b=Yq2wWua3mLRP+2Y7YOf4Kh4KcsiRCqeSuEUvwG+skD40+2Ca7xwVSvnbUDbsBfuTu6
         FlY5sgeiJNG6TTS7GsYOjrIB8Rc3xNTV2rP04dfI1/9J+465x9uoagg/KsRJpTER/zSh
         FqAKHtYqv6l1xsff09rUp4ny+DtgJZ/HoSV7Gvx0aL6KzoLGWPubC+qe4/S9TZVDlxYE
         rBf/kNvtChFwdvG4ntav2qZHeTAKU/jlO9NV+9fuLJcBQwRZUACipnrJMkf49zkOOoMa
         qzuQkcmFP3EIfqlO+5hLm1VUaPMO4Z2EhDU0YPN901IVqmTwJu8AOBeqX+uf5s2xas9V
         g4cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769555327; x=1770160127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m02DGZ7syi+38suiIi0OqYhAPASvnJjxwkmdJTFTL50=;
        b=vexYWdN5HsNJ4GIAaTLYck2wnC0w4JqumiYcvt1n1Jp2ObAiDYr2TylQfNmpGgszir
         QzFho32pvGiKMvfzKao/afx0lykTQDnBxI4H2jsYK5+J2Ejo70rpDq0acF50YJQDyaTQ
         0wTkHzl43acuXyXqOHG5ZZ1wgBCJJWurBdPCEPdlHM+A7AcabPTjujtKC2mbxc8n7fx9
         Bj/uUw0Hvx1DjCkD6a5mDu7cYbROwleOjK/9+LI8O3yE9UiCsCe9qdnGNh4UqgDKhNK0
         nOuz2eo4zYSi68IxWFCQhd2scdfo2VClp6Ib3B5eltnyLI9z5Mxy/XByDpX+EEAdR7xi
         FSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769555327; x=1770160127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m02DGZ7syi+38suiIi0OqYhAPASvnJjxwkmdJTFTL50=;
        b=jhhhrJg8rLGyr5DkuWW3jTXiXkHwaLOLKlmuOetcMRi2rkZS9McNf9nbgkdBg3Ucyg
         Z0W6r6oQ4TXE9xINr7FcAYDc9SMfVYVVyE6S/Jl8mviWV4fr3SSsStnZzHBvtoV6r2bq
         v7RP2Ls8ENuhHBjAuppIkcy7ge+5tzpePmA6ErrG5Pv5onwJZ0oD2DluVOqxYwytT9dA
         0vxY/mGhe2L3vhMo52UYskryfyLU6tijUy0S1uLstuwdWNvFiW7T6fYlCl8FDoeLNoVV
         F0xnO5+pa/8a2F0r1r7yiiRtM9/0XICwVW6VqLsHU3quTlLHVu5iPgGHWsCYXeQI12ol
         YQzw==
X-Forwarded-Encrypted: i=1; AJvYcCW2M3/NprLBNVfuYrYd6Sg/F3PO2LnPjhWUPoXf7OTo/2FmTqmTNlzacejaSRmj6xW+OU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhZ1RIeZjU0e0lHeuLoN7/2cfVgtXH5iNOY5Zan+xv8wcvhdW
	2ZGTKB2RvHrHhYOc9LU7/pQsF9HNgeh0W1OGukS6HG53/mnNUfqgpBdiVZ7VyTENXnyrZCGuCZx
	ia/riIuYwCQOUMcLRuF9Ksd61ZcBI2yIzg8WVRULR
X-Gm-Gg: AZuq6aI5sNr+fZ0oDF+9O2PWlVl/XmQGuzNjDIkAULs9H1U3iY9P5sRd+EEK/Zg0Wfj
	wkdlaHp43f23Qdq5BC/d2vJGiMZ+l/XorjqXFe24mn/GXQM+EJ61x/enLHSouVkIji64u4nsU72
	z2lrXhUkjaWBfz/WApt4Dvv+Cp8Dw2O4iDTTEuq2qAmdjeHXeWinBByWJz7utZrIu0RO9q4B+Td
	LcV/1pe3wEhuDNHAAVroIP1EJ6N9tyJuNADiNpSKmEyaY7zam/DEAGoZWgeJGvniZapdQfyYY68
	TTKBIg/ZFm/AVaPOe+09gnQjhTheUCYnb9yZLg==
X-Received: by 2002:a05:7022:1102:b0:124:9acd:3b15 with SMTP id
 a92af1059eb24-124a00cf226mr1708949c88.39.1769555327045; Tue, 27 Jan 2026
 15:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116091730.324322-1-alan.maguire@oracle.com> <CANpmjNM=w46BDuLsvAW6oM7JbPvrhN1ddaEUNSvsfZVU-514cQ@mail.gmail.com>
In-Reply-To: <CANpmjNM=w46BDuLsvAW6oM7JbPvrhN1ddaEUNSvsfZVU-514cQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 28 Jan 2026 00:08:10 +0100
X-Gm-Features: AZwV_QgUhI83Y18ayBUFiF9OU9usfkL7z0KYVQcFTyq8s-VGQxNt-ue84vTb0DA
Message-ID: <CANpmjNNoDHQOfH+bUqjpHdzYDxLwG7wA9qEywfWFNamt66Ziyg@mail.gmail.com>
Subject: Re: [PATCH] kcsan, compiler_types: avoid duplicate type issues in BPF
 Type Format
To: Alan Maguire <alan.maguire@oracle.com>
Cc: kees@kernel.org, nathan@kernel.org, peterz@infradead.org, ojeda@kernel.org, 
	akpm@linux-foundation.org, ubizjak@gmail.com, Jason@zx2c4.com, 
	Marc.Herbert@linux.intel.com, hca@linux.ibm.com, hpa@zytor.com, 
	namjain@linux.microsoft.com, paulmck@kernel.org, linux-kernel@vger.kernel.org, 
	andrii.nakryiko@gmail.com, yonghong.song@linux.dev, ast@kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org, 
	nilay@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 at 11:13, Marco Elver <elver@google.com> wrote:
> On Fri, 16 Jan 2026 at 10:17, Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > Enabling KCSAN is causing a large number of duplicate types
> > in BTF for core kernel structs like task_struct [1].
> > This is due to the definition in include/linux/compiler_types.h
> >
> > `#ifdef __SANITIZE_THREAD__
> > ...
> > `#define __data_racy volatile
> > ..
> > `#else
> > ...
> > `#define __data_racy
> > ...
> > `#endif
> >
> > Because some objects in the kernel are compiled without
> > KCSAN flags (KCSAN_SANITIZE) we sometimes get the empty
> > __data_racy annotation for objects; as a result we get multiple
> > conflicting representations of the associated structs in DWARF,
> > and these lead to multiple instances of core kernel types in
> > BTF since they cannot be deduplicated due to the additional
> > modifier in some instances.
> >
> > Moving the __data_racy definition under CONFIG_KCSAN
> > avoids this problem, since the volatile modifier will
> > be present for both KCSAN and KCSAN_SANITIZE objects
> > in a CONFIG_KCSAN=y kernel.
>
> "KCSAN and KCSAN_SANITIZE objects" doesn't make sense.
> "KCSAN_SANITIZE.. := n" objects?
> Or just "instrumented and uninstrumented source files".
> Anyway, I know what you mean, but others might not. :-)
>
> > Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
> > Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> Reviewed-by: Marco Elver <elver@google.com>

Which tree do compiler_types.h changes go through these days?
