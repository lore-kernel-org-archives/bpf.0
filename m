Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920463A8CC
	for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710099825; cv=none; b=HFajEKIl0HnRlatr37+9mGDoBGOsXdEeazdrnxf9E2SHRbKhWrexvzvSu8IemkZsBTKBYgMVz8K09TwD0chLVRLcR3zjYSjLCvYeAALEXaU5RVLKuyp1bYkQi7rfkP7VwBTHOxxGcrSIhxw3out2KL5Bm+klk6JSQ9Jr8nfrOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710099825; c=relaxed/simple;
	bh=Po+LUBeVn1OO/Jp/EJAb5LbLfXvJwOhspjQU7oYwS14=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Fz+C8TTSjvov5Av/5JCDhClCPrfHWWf7urq761MJV5LcogSWrxHLXexs8Fe7UPXl9bYaS42FHEptMn5DlXbukAlrTaeu7aXpqmcuxga0Xd2AkduqXmLGLpgdGDWljbngWd+qsfsLYYG/LvzJDqeQGKxTFEpcEJ6unxk0uisQhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=C7s4WDVT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C7s4WDVT"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d382a78c38so43500991fa.1
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710099821; x=1710704621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po+LUBeVn1OO/Jp/EJAb5LbLfXvJwOhspjQU7oYwS14=;
        b=C7s4WDVT8pqC0RmXyiUSpFhGlVJ9YBqHmPBFp1AuItISY0Cx2xkSl7T5KGALiCe6An
         YxphfR1cTxgBQ0WGQlwuI36NatzzOvQZHKW6WFuj1XHKa12JAqAPoJWTEsBF/isD4dKN
         dP8ft5aH1M6BHphK3E9hB/2fcgggadltV3spJB6Mfdr1np2mexBZMN6UVx4Sgwx5XVSk
         XdeZzqVZsEJ5g747DtSseVEVqxUuCEdQT/5PN1AzYTtcD+6pKbe3JroQYNc0ZkRde8RQ
         f6+lSAUK1kRQUPNHevZw8T6EzATTlAtqIs+AY1fVo9SAUCGOppc3ygH2/uV9gzbmirw0
         kv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710099821; x=1710704621;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Po+LUBeVn1OO/Jp/EJAb5LbLfXvJwOhspjQU7oYwS14=;
        b=lhVeYQxA4q7/9urWOoCel2+TeyvnWz3B9YTl4g1H9FAmz0dcQxGnEcB+gcK3m6uHK8
         qfAZiItmaXUzcCO73Gp4d8CE/cd3tsIZSKAzMNTbfbGbuLMjQMdTaZl1b62zzLOZubWX
         xmoH5z2UsWIm7Q7ffob8q0cvFTPRhZ9e9TJmlOxpCPjKB8ZYAAdk6T7hPE4dEJ8RGMWy
         pG9cAvF3z7Z+ZTxCtaybh70LL23J1fgkPcy/QLt81FVOWubp/OPhEYHSFOQChh/OvS3L
         y/MqxoKFSX5KgeQwip2q674uVi6TP++aaDdL6s8iD0xsLWBDVznzCoYSNPbkoeO0QPq5
         wGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX59BBK7nMqEjJaXCmX+ZvBp4bOcvXJctHZFxtH+XIpG6rX9lGA06BlmUc3GUWceS2dbZK/XNVk2vihdswdwdtPPvjm
X-Gm-Message-State: AOJu0YyWIjgXMX2Ad5sSMu9/c9jxQLvOj6aCevdD0myMi9+4O6NWjIlc
	d5k3aEVDyqCwE1gaHK5n54CjeVPyQr6IYwXw2dhza03h8WzfrDMpOb5nKrYpaTv1rUd3Ci0Ge4K
	U
X-Google-Smtp-Source: AGHT+IGFyVvdAFE0NAFVZngCgJ7i6p78aGW7lh2Aqqniv1VQZs5PG5HRneBcFRQvS0ThP1rmraJmnA==
X-Received: by 2002:a2e:3212:0:b0:2d3:3b37:db78 with SMTP id y18-20020a2e3212000000b002d33b37db78mr2552879ljy.16.1710099820655;
        Sun, 10 Mar 2024 12:43:40 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:8f])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7c902000000b00564e489ce9asm2222322edt.12.2024.03.10.12.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:43:38 -0700 (PDT)
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202201.3891042-1-yonghong.song@linux.dev>
 <CAEf4BzYXwKsmbj2D38DNsoi_gb-VLN1+2xXR9SqyPB6wN=S81A@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, kernel-team@fb.com, Martin KaFai Lau
 <martin.lau@kernel.org>
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: Add link support for sk_msg prog
Date: Sun, 10 Mar 2024 20:23:49 +0100
In-reply-to: <CAEf4BzYXwKsmbj2D38DNsoi_gb-VLN1+2xXR9SqyPB6wN=S81A@mail.gmail.com>
Message-ID: <878r2pswie.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 04:59 PM -08, Andrii Nakryiko wrote:
> On Tue, Mar 5, 2024 at 12:22=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
>>
>> Add link support for sk_msg program. This will make user space
>> easy to manage as most common used programs have alrady have
>> link support.
>
> So we have:
>
> SEC("sk_skb/stream_parser") mapping to SK_SKB/BPF_SK_SKB_STREAM_PARSER.
> SEC("sk_skb/stream_verdict") mapping to SK_SKB/BPF_SK_SKB_STREAM_VERDICT.
> SEC("sk_msg") mapping to SK_MSG/BPF_SK_MSG_VERDICT.
>
> Are those all kind of in the same category and should we support link
> for both SK_MSG and SK_SKB? I'm not too familiar, maybe John or
> someone else can clarify.

We also have the most recent SK_SKB/BPF_SK_SKB_VERDICT [1], which is
what one would use instead of SK_SKB/BPF_SK_SKB_STREAM_* prog pair when
chopping the stream of bytes into frames is not needed. For instance,
because we're redirecting from a UDP socket.

I have a cheatsheet that clarifies in which redirect-with-sockmap
configuration what program type + attach type is used [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Da7ba4558e69a3c2ae4ca521f015832ef44799538
[2] https://github.com/jsitnicki/srecon-2023-sockmap/blob/main/sockmap-chea=
tsheet.png
