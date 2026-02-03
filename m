Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7628CF76
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160639; cv=pass; b=tN56XQl3Vj/hicRrlJmWEp8YiNWF1ebUHTranQdNjtSSUcrtzNR6M/ksX5+JzrzwYoUUpdTpaXx9hLdBQTcqiyNMYVnvJeNtSgibuRjqv7k4RidZzEQUglA0hfYGeOorT2sGHtJCbRX5jLWBIRC3Xm/j5ZHowYa6TogrxKCkG4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160639; c=relaxed/simple;
	bh=oGLAAx0oDXJySJ6SACiBMMlBs8l/0/aMYhTmfuLrNXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmpLB1pbSqlantpVBI/eZD1+9cCcIgJNib6xcVLIpmgCW+TfpwKIbLYJc9S+aem0kDTs/uJBG//shNz2c5sTLv2xwp9iY3MPoLdikUoF2cKhaj3rqHoxbQuZv43ouF0EwBF2yUg6bs/7NYS2A5Otadk1mV+ETI7DyWjHKGVQN5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIWkkqDy; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIWkkqDy"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4807068eacbso51236645e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 15:17:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770160636; cv=none;
        d=google.com; s=arc-20240605;
        b=G3bM4i0KbSBex1D7ym9LEZwWxN4juGCa6MABeHof6tIUBJBczvjwI7blce+4MBEWf/
         KQFpIVGABBgrGCyeD4RnIoTLRIzG7e+xmjy6LV+Psf7rz7dkl/278RgLv7AdChpyY9gZ
         AzwNNx+ebWJU6eEIRLOmmBEluwfXGzzkE11LmVJr5D5GaiAotsvS/RvwHkCm+/xVAB/G
         pXe7EGQCcQEkeJK7LviRHIq3xCxuNy6zOoaucAUOZsI8Fy//heEDIN8Pa8dUbXkKutxf
         s05qIhSlp2fP80kNUyZedoBeWxkPR9JOmeg+R6MTyskcNqDJ6B1uHNdNE51AWDl1dbKI
         BQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qCzknF2XLFkMn/b7FrJtBsuU+TTC6yCt38+P4qpWFOk=;
        fh=PMVhGt80QeKX4Kk621fCewXJClSlTOsokTxPTqNnDOU=;
        b=Xo0cJA3xmj2CLPSoDPPE3UZgmUM6hbqh5FnxvEv1SAMVGtLQ2aBR4TChaywx73rOUC
         t3vBihpW4/gTbWMKLWfGUqWl7nMQm4ZAom0iNpJ9PuyomMRL9hthLo/Tfq0obv2kXhi5
         j5Ve92O4HJ64QLDgxBMxfflaLRNEKzzgoGCsY/KZ2qvczUsp8+tWWNYZbZG2Nql2zEWe
         mjMbR+BjbPEMx7pWvyvqSgrU0j2VfmJt7JSnX/kw4AM+cO6qzv+F2Jbg8ga0M/Dr5szj
         RjyR6IF7uup+EB02FnyK2kP3YfQKmIrUcSVAAANFnIs8vJ9wVX0rwpq5bX6DClDqE6hT
         NC3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770160636; x=1770765436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCzknF2XLFkMn/b7FrJtBsuU+TTC6yCt38+P4qpWFOk=;
        b=PIWkkqDyCA1HVf849aOk6fpfssZMWbI6aRfHCT2+4Zg7Xv6XNZqzNEo0vWT+pXG8iE
         rwKzeQldc65jH1utn2dGiRszSNUi0pMy+EUz7jFhau+1KAZjxwb8RumKvZa2MxTcw0eC
         I7TB+z6m/d63cNzAUPzQIEb32iAaM9gQSVKD9L0rKOBM0B9hhQiuogwF4GlasQGa7186
         MrNQU2t9s+gCZtDMUPjOzbosbQZgwtmFhcYwdbKBhAMUzoSpYpXHby1gOu89B8JgOlpi
         +yfa7g3/ZbL8Mx/IlhVJh3/0N01LtAYvUisGM7gk2hiVDh34JfVmbh0t0kadW5pbnncS
         EExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160636; x=1770765436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCzknF2XLFkMn/b7FrJtBsuU+TTC6yCt38+P4qpWFOk=;
        b=fHS4HXixEbBUZfYdXWlHe13pjuGFrBSi/aI1+OEtZUKHoVcnW74BR/srF7A5ZHPJ2D
         sNhza4LgRROPXNeT/jJZ5n42/vMfLs3XA4qHzJKYkgLP896EMTmd0gvjI4nB+c6Ax3rM
         uuslR+ztdIA7fiKIXNEzrs6J/znMsBGIBaboqywbDvARZ4NKqR4ii9xMnpPKdnu5/zfb
         P6GyxkzysJsxXbquXYVTa02P4O/L8XBv+klDsYrvhXvxVq0QhtPdcBC3ztJWT4s3DzNW
         ds2GmLQsAROC16gW1T5OMmCPg4Ivioy/7l7AOE9swibeMmdfrWfxOO306RTSOFGNtg3t
         9fAA==
X-Forwarded-Encrypted: i=1; AJvYcCXPGbd+g+ruI6jIpoGNsWr/kkmiVpvVWGOCtPw693X+nwU6ZMBq7mtLpHDrru5lAnwKBhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3AkjDBPwYWi3KmEXkRvv4UZwAqhH8hx+oVh5hwcgrBtpCJhyI
	NzAGA8CI3fkGxn23MRVr/CtpoSiBUiD/qz95wBQmb3TNK+VZ0Ru+P52oSTuoBUdNHf8giAWUl3H
	uM4QlFHpvHA/MUOO7oWVY5vgXgGA23jE=
X-Gm-Gg: AZuq6aIDfkdtom14HPydQ4mt1gpiZxz2ct4uUCdbkOY9DDi388JpJAwkUn/IIzeSF2F
	Hk93MigV2cdxyX1pqpXgNLoIP/jnyhTgdzWIq8GS944jME0YvImCaphp82amYISSEcov0G1cu76
	DPJgsiOiinZliBYd1e+3AlrmjldfHQmE4FoHvPMn0XX3TzSElt0eJrLk1L7K4pKClQ+7ZSSADvC
	PRdTbzleOx9tDpAwb4ZZHU/iep0XHHqNz5OV1fIo6n/1bkymhdjTi0RO9sNNN3fKxpznV+OvuqH
	59o5W3tEilF1vY4koMQjm5XKwR8yrFl2Tno+OTw94dsqq4jBQiSXsLiqcgfHdg/z973gHUc+D8l
	KehKxM4fOVsueQQ==
X-Received: by 2002:a05:600c:468b:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4830e99c72emr15368615e9.36.1770160636123; Tue, 03 Feb 2026
 15:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org>
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 15:17:05 -0800
X-Gm-Features: AZwV_QiKtrXKdO5AhQ0I4_nizbg2ietswcwGbOy_bfzFE5Gd80HiFm4U4YWqCsw
Message-ID: <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> as an option to Meglong's change [1] I'm sending proposal for tracing_mul=
ti
> link that does not add static trampoline but attaches program to all need=
ed
> trampolines.
>
> This approach keeps the same performance but has some drawbacks:
>
>  - when attaching 20k functions we allocate and attach 20k trampolines
>  - during attachment we hold each trampoline mutex, so for above
>    20k functions we will hold 20k mutexes during the attachment,
>    should be very prone to deadlock, but haven't hit it yet

If you check that it's sorted and always take them in the same order
then there will be no deadlock.
Or just grab one global mutex first and then grab trampolines mutexes
next in any order. The global one will serialize this attach operation.

> It looks the trampoline allocations/generation might not be big a problem
> and I'll try to find a solution for holding that many mutexes. If there's
> no better solution I think having one read/write mutex for tracing multi
> link attach/detach should work.

If you mean to have one global mutex as I proposed above then I don't see
a downside. It only serializes multiple libbpf calls.

overall makes sense to me.
