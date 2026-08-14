Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557D377A8E
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739856; cv=pass; b=bkDeBzbhsq3F5zZkwHG7jTyrBCnVim37rAh6Fiuw+9MkEshka0nQrA2sJN9QTFYDFNPu3rakG4miVyEetFXGfF1ppxX4oQ4cf34qzp5UUcfgd1hP629f5+M9k1/Ox89DVDJNEUe7zpgSlnsBYCNNCdc8nEoQvuqigL5u5v+OSYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739856; c=relaxed/simple;
	bh=z9JNilwsmgDiP85ztxzf9GGPteMVUxvleIIDOUywAzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4OtgiCrrFyUC0P+dChmxBMreZMR4o/PccWEw9zJl7hAGRlbfpdiKy7p3Rl777SV5HpwxistVNyZ7PC4VrotFciU3XOOFrf0BeIbprbPgJQX1G87A+lsl87rgQ+eTLWdjYeL5SQ16mkQsOhkZoyWGhpsgTumkAe0yheDG7TxofY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geNLKTqq; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geNLKTqq"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1180640b3a.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786739855; cv=none;
        d=google.com; s=arc-20260327;
        b=SJpIWyTfZxawkdigMpC1MtS8n9j7MWGJgjpwTTDeTQgbfdw6h+S8xLeLQcYOa7IY7+
         6+0zNaFTRp4Z0QblBfNVSd5B0tBEUZVq/p3CGL6NF7YUWtXjtcXSpbggfdky0SA5yiw7
         BxUY0nXkdXvSrF6bLKV3JFDO9QkihCoVvVKsJl1j919U+EbQMcTu+PAu2kRVn1S9Kn7Y
         ddXgU8jJh2y0jqPk88+rGaXN1YnE+FRLAxqZF3Du1KTOHOF/K4NX1RBqMLNYv+Q1msB6
         qPo42osQWIKx/wAnNhIA8cBskVzeAV4Cva1GE6KfNmiHmr0H08IW2KR0Bm6kSmY0rusG
         eyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZaBi3+qW7LdKraIcgGbIr7kPFRKjPyDOF9NpBaNJJGs=;
        fh=Jhc8qUS82ewjnmR5J6GoQBwkTnL2S38bZDTss0mnObU=;
        b=YWp2dCQFLvLlbgcQdj54yrUnhWq9nL74KMS2h2R8MQffrZ+gowx9N2eG4dOjc18yM7
         ejQdDjyTec/UoCQP4PEwlAmQ//Jeh9b/Ds8bV3EXEdoyq7y0i2glEsF1xUiId4dn73wU
         3rMrfoTdCbBhtw8IhToQf74RMHUHNL9wk7fprNg2ZGT+CCtfaR+4+iiCGXiFIQQCHojL
         Jm+UXc7qY3/G7/zpb5xX6FbUNvcCHy+xgyQ0jh17+1FiI8eyMJUYCRqsZNd9HVO+0aYi
         w5rvf/SjyQ10nfa0Yks/H2zNy0Y7bIzqAuv0JhHcRx4w1JlFXm57ANpwRddxXOJ5WvRO
         ePoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786739855; x=1787344655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZaBi3+qW7LdKraIcgGbIr7kPFRKjPyDOF9NpBaNJJGs=;
        b=geNLKTqqK655c99Y3ZfwCLr92P3L0p0/Uw23QB4IwfXO/0ADlZgLfafCha+sSjkZGv
         auJkaSPmjf3LVCCO6TGW/HvE1kGEsf84DraNwTyKqCExpmIc8QS5HfML9bp7n1pl8J89
         SOFCJelGOMjPlm2bdKLdw+5DEoINZ0SUJ3hHC/faINrWiLfVWJqg5e5y7OXtjLPZSNfN
         MWEjyG0w4chMXVcTCaHLf85+gc9Zqe6RdpmRm1/g/NZNh5U7g/cXdp7mbFmjL1NpLxaI
         6vt2hZUfp3Geyc+CoL7EPAHV5QZCNa/6u0wwtqMh9wCAMgMBFCijGceRtnfFgTtwoXyP
         1pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786739855; x=1787344655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZaBi3+qW7LdKraIcgGbIr7kPFRKjPyDOF9NpBaNJJGs=;
        b=qXPLKmS+WlJ+3HLRHs/72TQuCOpqtSrdO8gd1TMxQWqu8ubjZwi4UN5G6zxz6BGgi5
         /zOUHVTCbJwzWItp7w+ohhzsltbjlthiFguQZKtILK5JTVOtJPPs5FWRbuJxXFYB4YyI
         8Hh2Tk53fzV6toofa2I+x1rmnpeaKC8y9DOM8F0a7KuXvL4H3APULlXze/LfcftQfPWz
         qFrsQZQ3ysurpUssPm8s1jPHTFDV5CZk2x4TY6zgzS5PMPsxgBR3xr25WcejJUnTpluh
         d/m3PNgbnqG3rbbq3pVlLJRlCwcE/0p7Xw+sXmUSXFBfGaWpKEzEZl1tl+Q16r7CgiXu
         +1tQ==
X-Gm-Message-State: AOJu0YwMtzqnRT/UDA7lB+ciwC1uh/0/b6TjFrpcnhTjFjXi8Z8rvVko
	bItDXXsMKQmtws4ixKVRvAIXEfhN2+JVzDy0X3pZoIY03827/+CebqkvK6uxMhEMIhbZp65bG3H
	OKK3bcvKpt7PqOZHyOwp32yiSWTezkS8=
X-Gm-Gg: AR+sD11hMiNf9J+o1AwcJypsaCitq+Pyg6TYpxY9nnbY1aHLXos95rzzFp8y8vEYjDw
	ysnohIPtTV52NTT0zGTYw2PUF+Gx2uYL5X7L1YEU474POPqSDp5DS6O4z5UDpBjCj1JIUkyBf2J
	4+ID/erAdn3/5wSVVPURYAt3tAKe6phqOUKzPy1dnJ6EKG+Z/xVnNsrrBsjXob6mInfD8bbaEhN
	iW+5+VnQKu50l6yqNGmKMEc9R/EizrVzO4MNjQdJX/4t/T6ZmrO1ISfbOs9RIX2H6F11DV1eFF5
	sE/jLaNvI3UF7F3bGdjXH+il+9qGGGCNLtMHXjsNt87/EGv3F7JU5XtPi1139yN+4HK8B/tW5s1
	2tAtIinYmQ+fge8d8r+batPQfVEsUn5F0Ohsz
X-Received: by 2002:a05:6a00:4c0b:b0:848:42d0:bc91 with SMTP id
 d2e1a72fcca58-84fddfc1d44mr10226355b3a.12.1786739854568; Fri, 14 Aug 2026
 13:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814173206.93082-1-leon.hwang@linux.dev>
In-Reply-To: <20260814173206.93082-1-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 13:37:20 -0700
X-Gm-Features: AUfX_mwRDT2_se5uEyo-BZZXwxrC1ld0XB7XkABGEpse_4coMQOr2Ywwd005h84
Message-ID: <CAEf4BzZ0ZU_g6eHnkoBFXfD24rDOBSX7QQFVd60DyNS2S+2m0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Followups for global percpu data series
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 10:32=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> Address some LLM reviews in
> "[PATCH bpf-next v12 00/10] bpf: Introduce global percpu data" [1].
>
> [1] https://lore.kernel.org/bpf/20260813152324.97937-1-leon.hwang@linux.d=
ev/
>
> Leon Hwang (5):
>   bpf: Drop duplicate blank line in verifier
>   libbpf: Avoid unnecessary mmap resize for percpu data maps
>   bpftool: Update comments about skel data maps
>   selftests/bpf: Avoid flaky resize value test for percpu data
>   selftests/bpf: Improve readability in iter test for percpu data
>

applied patches 2 and 5, check AI feedback for 4, don't bother with 1 and 3=
.

>  kernel/bpf/verifier.c                         |  1 -
>  tools/bpf/bpftool/gen.c                       |  4 +-
>  tools/lib/bpf/libbpf.c                        | 17 ++++----
>  .../bpf/prog_tests/global_data_init.c         | 43 ++++++++++---------
>  .../bpf/progs/test_global_percpu_data.c       | 14 +++---
>  5 files changed, 41 insertions(+), 38 deletions(-)
>
> --
> 2.55.0
>
