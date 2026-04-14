Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DFD3E8C5E
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176994; cv=pass; b=i1hRavO0XBpOoUxgSeJONeenn8EXwlFe332WR4ETmGVB7u8bSbiKT6+T8GSpzOMpgljbd4GXRdFfBrIK9UqMibt7YgC8GhUnO/e7DI+TCe5qSSHPdcATRfAveyRS2d/rGz0fdAgUll9PC5+hzehprcs8Vx2MxNzUHjzm8iK5oSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176994; c=relaxed/simple;
	bh=DYwEuGP6607kKSiEAJ/bJtWXPBAVsuNfRAS7za1yxH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSGKuko18bWhFT0T/Ymsx4JIPug6moebanGA61OK9FrD41H7G4sOpaWjar8dAb1AeGIuAyyhLP7ddFSlrFxFYVl+1o74tRJ+gqWgjcmqdGSPKTCOgQvFLp0rkFIoEmewmavNFe5LM4DD4RA3JPmi5oTVnDb0Hf63y+16U6DOXec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qo7phO1E; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo7phO1E"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so56419165e9.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776176991; cv=none;
        d=google.com; s=arc-20240605;
        b=MqWEiS7LMAY2fjfg28BgwtYX8QOVtd0mWh5uGkco0cqvxYdJ5nFl7bVzWdGJproW9o
         hIWvoDGo/cTsVEpYWa1/2AwUHvj7VKDI8JFgWZWLyE19UdWuvuIJKcKs2gkfejnPir2V
         aZFZRgd1MCEXZOWQcxbzfeKaCnMObhBHak5d5HesW6CnVz7wUl2btBDcOVrxmTa7P/bg
         a7cRqDLdXsG9eMGgNu72eE+ok0gyG2L2Gb/v/8fz/gdGiBE9wAPwuF10wfESMymkomBA
         At/Z5P1DQoWA3C4b+WE2Z8Zj340PXHKpKc31l1YIZoHiIfZ4s1IPjxNvQzlrIes7YDA/
         4Ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DYwEuGP6607kKSiEAJ/bJtWXPBAVsuNfRAS7za1yxH0=;
        fh=R7U1+2Hv9a+u3AMR4aV7olFLYFbGkCEcQ3uEpLxIK50=;
        b=NCOPRiWNRLzQZHQ71Hum1wu0gqJkXBluSgdu0rOrEVqBjxR8v57/+chaO4M6FtUgP1
         GlzNTGu8CvbwFGVjcsi/bi/2GvTI1xc/pGGHvGRQixwwlgiyq0MDQMkYhravSXedEZzj
         yanWZcMaX0zbqoTuU8MLiL4/xlGy+hsNzbhiw3iBrNqA/BLhCPZFE0S9/tv3jXieRWU1
         X//CG+xGfFEApmIlfM34I4/xSIKm55OZwu1ENgVBzCfZz5eoC3V3CWz/QCG72BZGJbhk
         kCpS092UXN6V9ueeqMzMCBCha2hn8Sn6Ok+onAO3r9Lw5pkMixVKeyBb4cE2IQrQ43eA
         bKPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176991; x=1776781791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYwEuGP6607kKSiEAJ/bJtWXPBAVsuNfRAS7za1yxH0=;
        b=qo7phO1EViiyoOTdAEOLoYrV6BC8F9Q8ZlTRIxqAc9fpW+QTE7SYdnHN4Be/6VFLVe
         QLiIa0otYAUAZMBFoDOjj5PBwWvuqrjYJnTqhiBG5Cn9Xh2/Jz4rhQO5s0pHCtBZQ40k
         wHA/tak4bhPbtnF5mnY/TYQM9hd/KTo/lOg4MWYxI731w25sGJ7z7lxvEZl8GdwmqgT4
         jnzTDofjwmVUucbkZdhmZSAnSslN5/snDsjb9MhXvOUhixwpfaT09D5wKQgYta4i6wIo
         rnf3yDQVBp3hfzErpYz9KZLMF6kzsktfwM3Bqw7jya8iQXgMWmphl1S9m8pGHjQVXb1N
         a1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176991; x=1776781791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYwEuGP6607kKSiEAJ/bJtWXPBAVsuNfRAS7za1yxH0=;
        b=rXm2IYA+XFlwmk9LZfYvgjgBHRkJ1Xd8QCLmZNmNbuVYKsX4H988m0euWV1JM1E+dt
         QkvRFUZ7zWmI7A9dCjBCaf9wT6vBWpUkDz8LjEKhV4ojEEOLw+5DKjbngyq1q7UIX5Vo
         M3levnu3RZBv8VY+Y6ABz+45Pue/cJkMK8BaQboEV/tSxkporWfYMbJyEbAT71GFwhHa
         OSbqmlecCk2oOFBjkSTkIyBOw+ytKH93rHYHs5rDs0+6xMfT5xJb0fY2Sq3egKMWIBNR
         Dhz+K15PIRvDp38x3t7fnxyvrl3+4/WPtyrlThCbYbuBvcEQEiEUptx5LPfxJ8Az+tvI
         oZsQ==
X-Gm-Message-State: AOJu0YxyH1OWMfmtR0mvM41kQqcfg8bkTj1Us66xYzIk8VoZGliDfMMI
	KDgHZKAK/j8LGKBvUqjLL7R66G9D7815EgKYGZYOCCf4GsFflTvozA5LToVaqm+BROwTSdXYxpz
	2GHSDDTrHy7KcpJvovcfvqk27HJ9t4Iw=
X-Gm-Gg: AeBDietQ4CsaSe3tPd9VDvWA4dWNXfsaaf8dvnOM1DQDrbdB2g8emucK4Xajm1NxQJM
	0axjIDPNFmyxVyMdwjqBCo2eMmlVzyFDtYJpwLuzr2wj4xWpieOEzgh+o727B8qpoG/DbmDTMBw
	Gprji8AhmFuxrPsCMCFjkQkpMTgjY5k34ESeJ40XhDJWbK7FQsa0ND32n6kQeIsXk4ePcPhFsuh
	4PJypqXh5lYKLFQtao/+xp9YklkaUNUr5GFJV4vvBh7HjqMcMvUXnvEDSk8YbF/C3uG+0pbRGwa
	n/XCUGarTzKUE6UnMim1FxF7YEcMdTL+sRpX8TpECrbQT3buJIZUsKDwo8izwawA/XtaV0Cvoa1
	jKWINK+miAhbMCONkbWucKXEDrg==
X-Received: by 2002:a05:6000:2c02:b0:43d:75a2:44a1 with SMTP id
 ffacd0b85a97d-43d75a2463emr14084957f8f.47.1776176991506; Tue, 14 Apr 2026
 07:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414071507.29804-1-yangtiezhu@loongson.cn> <20260414071507.29804-2-yangtiezhu@loongson.cn>
In-Reply-To: <20260414071507.29804-2-yangtiezhu@loongson.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:29:39 -0700
X-Gm-Features: AQROBzBAOST6EG1FhjwDMHKuc_5-NsRFYzA_M5anxwVzBX7qIYhfu6GIOUUTcKc
Message-ID: <CAADnVQ+9tr5wh+Lx86mo5NZ9OZ=6KAyrwL3jAHhC=0jfZ5SQeg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] selftests/bpf: Only define
 ENABLE_ATOMICS_TESTS for cpuv4 runner
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Yonghong Song <yonghong.song@linux.dev>, 
	Eduard <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:23=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> Currently, ENABLE_ATOMICS_TESTS is added to the global TRUNNER_BPF_CFLAGS=
.
> This causes build failures when the default test_progs runner (typically
> uses -mcpu=3Dv3) attempts to compile atomic operations on 8-bit and 16-bi=
t
> variables. The BPF backend for Clang only supports BPF_B and BPF_H atomic
> instructions when -mcpu=3Dv4 is explicitly specified.

Sounds like llvm bug.
I don't see why -mcpu=3Dv3 wouldn't emit them.
