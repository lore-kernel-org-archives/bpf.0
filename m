Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793919289;
	b=zjLOwT1AttKP6G5SS5WM4CKF+DmtZxb92SjoQIvIaSab11Cs1tXwCMbfS1tjv8tNbHAU
	 iMoEJTqEPKtWBnNVRV7zDYL0Ali06P9tphIapYIt82FRId3qzC6BtitZ6bxfwFFR7yFSs
	 M8fgrn1u3JgUBMmZ8xqVOaBHiVA9hTAys80IZr4rpd0SLjmlMotNyreCTNbOsqMg2jnea
	 W5VOSlBO3Ta3CwbYlwrU0IU71jsHlBKYo1yCOjVPUfXvD3tAPUNU5wNn/km4ZpWsvtwm4
	 1vwivgu4ZOtAwoGMc4YOOxFkf9DyPcw6KeHXQ1v6er4+pwlLPMKlMwxokqoiYVnCmUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=53u7WY1TsnwmHunThsglDcDwR3ZhmgG0Jw62kG2eqzQ=;
	b=UmRVfoj27M0c72qeVGVpCad1sPE3sEjTfzbN24Voof08UVv8qBhT5rsqGVpsoEEn4P9L
	 0abOoO/Ylowx8GSB4/7dby7ItgLsHcUNpJfamfhptD2F9DSjuOU00mF5akDOFRwgv68b6
	 dhz3H5eAwJQL4zDVWS8kw0OqCnCmpt8AKVl74oqeaeT1UABjbhXo55S3lw9cFW2zedoOt
	 fC98+JMoHbwNyXSQEhwi6IE48NJWUoi2SMWvccbVVYcfvaXDYczP7fMcN7B7qtZklXesJ
	 BlFQulAl+1mDuEwWzIAiOnYFJnb2LLqxFM++wp7llLz0qISYRyxQmlTKxeXIFO67xhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv5Nue57;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D342606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D342606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv5Nue57
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ed0e2015aaso64465ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 14:54:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793919288; cv=none;
        d=google.com; s=arc-20260327;
        b=klt/E7eF5UYCZ910rTCohHSNBiGjKH076FWgOGA/SJGrntL1NRU18HeID+/0Ni3bVn
         MqYPprEgYe25VRC38dMzDvf00kLf1hy2QBdPlidXKpaAd2ZCf1yW2MAmEuIkgpQ9kZLR
         YaB6fP5SUrnT1Ut1UYtly5T1Wz689Mhj3IDnkjiZmT5/yS/91BhoYbLqOtbR/926oEfM
         MBZE6KtdBRahJRQrNgQMKFdW6N0qKUHoOcSJFRMkFDzvV+lynHwTi68u3Pblr43X0HN6
         czIPZ8A0Y6cJ/v57u3+h6wnUIkdRnjcNksyE/ysMJ8Xo3oaRKQVmHdFqhywNAunVC1c4
         k6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53u7WY1TsnwmHunThsglDcDwR3ZhmgG0Jw62kG2eqzQ=;
        fh=XvKKc69WPnEA9rzlSk+f2hD6AyMRDKY6KOqNtkJxp7k=;
        b=Gaa8QcPgIMxjyEJabmgZJHzXzpTohKJjjUfQtxy2h2Nx2/z/HaPxerR3A1VzQpAI67
         tXCQ7RaM5vJFj4+7Sowy+ZW/HQ6qOfKgn+X13kiOnbA5ifIuct2lJEIp73VagSzZugCb
         gvqnWi3TTPi8SQVVUBM+1rrEL721/tlZOf//l/K+vaz7u/5MMPMGfczzCxtRXskXhNos
         Gat37cPPxCWZAWx8ItDIOYEr3hMWaXi3y98uq6NtQ1Va7i2reFoTHIjp/X4PxxGUlRNq
         2IeO4gi4nX3fJDlXhZflJGMr9WGsFrUfbC3iZ0DIrCb4I6NFTXO71m2TeHbOnIYZ391f
         AMNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793919288; x=1794524088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=53u7WY1TsnwmHunThsglDcDwR3ZhmgG0Jw62kG2eqzQ=;
        b=Jv5Nue57QjLkhMOEGuHs72frjV/ATniu1inojeuyfPkxMSjJgzY8tebX3s5VEt8P2M
         5zk79Uevpau03DtEKgmydD39Tj+kq1mm8pJ3xYPkFc3lo63wbGviTt7xGz2nkQjTWgme
         XZosPj/bHU4nk/vkXbgbH1DqTm2RdwSeIX2H3aB3tXuPraNBn0/VZGHwBP8W+HvX6wpN
         cQGsBUj+EezVKnGRxvepwdJN5B9CD+NqeIcjKdhFZgQHf6FtucQaQmKlT/r3Gt24fCRj
         uz6NppJAdxkzJP2Oo7zejufT3sR4pe3Kn6HPckZhMX9zdTnVv/XXjr20+UyoaaPwNtCV
         tJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793919288; x=1794524088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53u7WY1TsnwmHunThsglDcDwR3ZhmgG0Jw62kG2eqzQ=;
        b=Y8E5pFk4+8qdDqCt8BZQUeYMRnVP8/h2LBhPZxqLZUMANlkZpuuCZhK76zVBDaZsdj
         /Syjd2oOz+c+phFJdrieWLEacfwCbJ/lBiBIu+F9uaDQAUmWZuG2Ep5uWNvgy1aIUluy
         yhtEa/eNQzJRgPW9guBIi+SOzW+iki20cftF0Ewbvz9fSfc/6BtFeXmT2bYSbEytvo5Z
         K2eFDcThppigrw6Sfvc5TIATEhzUonCc4x52y0BQ/ylQSajMBR8GenOhYXN8r5W6Ascz
         4+CCrlBwHKNGo/fRkVaLuY/4UVL+PHDj+F1EDwewCJCYwzIhMFN8p2uQw1/sN5YWNUmt
         9k7w==
X-Forwarded-Encrypted: i=1; AKwUvByEoqqYFY/Nkzz16gH+AjnlMPf2NjCVsiPvMrnTGZAwtEiZQlLJkGsMt6SU3sMFHBIBlFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e5JBreYPCIag8Rcyh6AHelNFvvEFP3TAaE3FdXfBzGS9p61RG
	NzlhV9bwcVLw4vNlobhbUmtkuCS0L/ejCu2qqfMcMMfrfltyHj0HHIavtxmp49BY+YQHEdgfFA7
	T14+ceLVjKN9yFuSwxE4VXpoZEKLVUQQ=
X-Gm-Gg: AYBFou36Rr+iPssG3vM2DvT2EHM0nZQ37TG/BKwU1ZmYCHNSt9eJ7lxIFLsv5aPKqXB
	G2hhBPz10wvCt3RQSyVfRh7HWbHMjZ/C6ykcBrBEe4y4bBux/5CMxUN2T6NxEkQpl3w2HcsNZAo
	ajRTh2HFoxf1aLciIv9mhnM8SILcT8LYMJTso2rj5ggpMGjiV1sfF/N/9/y8y6EnRFFmTFmaW+9
	8zGYvYIyTQ8aiWajnsa1tk/RTXS6qqSqvwRtH7eF4C7ERxP/jEar802l/gIT/imGj5TDihyU6xT
	ZGIR05r/vr5uAFONXicz7nuC+tAz1bcDdDaDcyWW5Y73DZ92yYYBNRj9ZbStqQi7ep+xFMTAvmL
	FOEzkFtwaf/qDxkqOLI/qpMYUlPUkukp3Act3sDUTofH/BQDD72DMSufTPW0YF5YUeOQdyqQwRZ
	s4XHbEdZ/lneMryqCVVbv7AH+KaJOfTpxldw==
X-Received: by 2002:a17:903:f8b:b0:2dd:ad73:5b6d with SMTP id
 d9443c01a7336-2ed40ad432cmr11270975ad.29.1793919287795; Thu, 05 Nov 2026
 14:54:47 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105093212.826479-1-yangfeng59949@163.com> <20261105093212.826479-2-yangfeng59949@163.com>
In-Reply-To: <20261105093212.826479-2-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 14:54:35 -0800
X-Gm-Features: AclHuK-DzSYkqcsqv4sSPpyPME2cg_aHhMiCicQL_nOHKzRgCizS-_dThi2hBRo
Message-ID: <CAEf4Bzaq7y9q-M94X-z7sBquXuB8yUOjFC+TAZ0C1+VxriLd8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test faulting build IDs
 from a sleepable raw tracepoint
To: Feng Yang <yangfeng59949@163.com>
Cc: song@kernel.org, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	kpsingh@kernel.org, matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:33=E2=80=AFAM Feng Yang <yangfeng59949@163.com> wr=
ote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Extend the build_id test with a sleepable raw tracepoint on sys_enter.
> A helper process pages out the build ID page and issues a getpid()
> syscall; the BPF program filters on the target tgid and syscall id,
> records only the first hit, and captures the user stack with
> BPF_F_USER_BUILD_ID.  The test asserts that one of the frames carries
> uprobe_multi's build ID.
>
> Frame 0 is libc's syscall wrapper, so reaching uprobe_multi needs user
> stack unwinding; build uprobe_multi with -mbackchain on s390, where the
> unwinder follows backchains.  The non-sleepable control requires at least
> one BPF_STACK_BUILD_ID_IP frame, so it cannot pass just because the walk
> never reached uprobe_multi.
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/Makefile          |   4 +-
>  .../selftests/bpf/prog_tests/build_id.c       | 134 ++++++++++++++++++
>  .../selftests/bpf/progs/test_build_id.c       |  46 ++++++
>  tools/testing/selftests/bpf/uprobe_multi.c    |  37 ++++-
>  4 files changed, 216 insertions(+), 5 deletions(-)

this looks like an overkill, existing uprobe-based tests seem more
straightforward, is there a problem following the same pattern?

for instance, why did we not need run_uprobe_multi_syscall() before?

pw-bot: cr

>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 77682bf28c6e..367166383246 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -650,7 +650,9 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
>

[...]
