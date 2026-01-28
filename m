Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9A26B777
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564735; cv=pass; b=RcAq36MqWxOAAmtV08Yb+qk8TMKkBXTXOWwuGE/8045QS302UL3138rW/C8In+I6PQr+q1kKgtqwHXY0Dmic7ovUlWa5BAlmLoeazzcc/HfYk3RhgV/dQNleSxhWrEmfRdSwm+5oOOvmweGqFEhUFBLGmaMH8/TZvv9p9TGaigE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564735; c=relaxed/simple;
	bh=vBZPqR6U6dxiUal2oA4lUQyxVklJl41rl6nZ65jUDXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBksRJ58shkIOiKx6bPnZaotFs9r0+ZQh6k55ufG25hS+k9gcXLmZxmtwvSsBCLbmSsUsA3+VNRTme3yI5uCm7m5oYetSLxNEE4smYHv6AlrSNVhO7yscFun8zaprJxfPmGGUIWredW79LbYyuzkKDiOj1xRObLLxPlCxHPOmGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4+/M2LQ; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4+/M2LQ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233bb90317so399028c88.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 17:45:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769564733; cv=none;
        d=google.com; s=arc-20240605;
        b=JiH8Ji0aEuYRU6/JUNfFsJeXaBGM8HFJ2kum/66OJ1uGueuILdTHC5jYrrrcF9G0kP
         FmR6Krkm+TBdyk8BE4Nb1eSBSwknBosfbOZ3xfHAIh8VZRECDIYdwoikGngc4/5mh2SL
         VkrbnLpBrMY9pshP+TFNbLz402JQ4WSF7Iyj29VXnXgdxRHPwwmKaH2Jt/AbfA8g3sqy
         7okhHXVOWdECItKJ8v/uq0bJLExsrQoOLuHaJOOBV/vtCoN6jqc97qtsaLlLtWU42bk0
         1kD4AbxfpBozxbTnZ+H+ZynuVMukdojYWO8acj5UfwDx31Iw90nsTR3jk7CWY/HrXDmI
         4xnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8YOp8+/leeiZQm/nnW7y4U4uL4Yt6PTD22rlWaSe+ng=;
        fh=MD/TwRLf5YbKrdodWANwZukmXvrbZbd/eSTpduQdEwI=;
        b=MTwwBbsIWGG0CNziJJXN7KWiCLasCFOiS1kfoLW/ukcxpKiB1CQmglhrC1QSMut81a
         SV7qzK3GXV0kY8f7IL/NsgfXoV24PIF40YSV4EG3l6T0aB4cmjgomG6NnNDPY+wgF4Vf
         jRqAmP54AhWMN1UO232XWCMU9JYFgsQFaBaQJ2rGkmn1fIpDL0N/a31r2kIWSfBLSwV3
         3rIl0Qih5SxeoZl7qZX+M/GbDfbAHdTsl/EyJ5mRt6bryuyJVlA40bp8NMyRhRFPbeCa
         8CO2MpHZOqMhNm8JDAY4WVDdJkhjJLJwSNK+C1ttjhc0hifanGcgJLFV59tLIi3XxgbE
         IwTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769564733; x=1770169533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8YOp8+/leeiZQm/nnW7y4U4uL4Yt6PTD22rlWaSe+ng=;
        b=j4+/M2LQTCK3WssmNgfIdCQlHVHnbazAdYEcQ26zEh2PZxT3IuM5qGm48iCqEAM3MZ
         FVX/VYgUJWc24aPKtkWMOBFcDdOwR1YpZ9iPeQV0mE7mqPotJyL5iT7g24pYUknetlhO
         l435ikubffb8O5ToH9+AK+OIqOWk2txQ5UaraYwGo0+kbJi2NJxtNNMdJ9mAE3RrhIps
         sYbKwkvNPrj8pfqCto83MORC1Gz1k6mK+ZcP3xe2o3LVR2+kk07KT3n/WzmXD17qsJYG
         kiO1rRv7JC0aZTJzyxuYiiT7cJ6OjjQL+H5GiCssrgeOp9n3NwKZ+Ijkkd26d49OGpnK
         ROdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769564733; x=1770169533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YOp8+/leeiZQm/nnW7y4U4uL4Yt6PTD22rlWaSe+ng=;
        b=R9Iq+qCLlwELZX/pPh0NAhNCqUlffZfcAgqN/L5/azgSJY9brBrAzeeEawbW3YaW/F
         wAnfXTvTcH9hwqgj+3/uPcsL7w4gPLijK9prZFppCG7KcmndIsBfk3F+5ZWzHDx8hDqu
         UuESLVkSbaaQe4UZZizkQFwtjk9z+pF9Qf2XWpPuvXij459iutbQytGjr+4tvzWZoIbQ
         cp/vCY5Y5xF/8xX15CRepB7Z6JXQpSgBcKc9thhJAXtV3JKmsjFt/j/aoKU9hhEy5L1X
         2BtdZM5noy02FVpknzDxKzvA9nNnqCR7DvpWZf5h9z57pTPbI0/Tpu80NvxeWAWaS+p9
         KLsA==
X-Forwarded-Encrypted: i=1; AJvYcCX43WEjixY3jYqOFmMSpMDniVZNUzLDh5pOIIqrKBkp2gdlB2GNVlocmCHcF9iXAwMmMd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTOxzF6WBnnKDu0yCUIY7E2P3BSIZcC8qsfvuWRywsGFGL9H5
	WZPOwqWrOAlcHS0bM5ruzmu3j2htS2ntIJ62cx8esWAH81xuoqjT7sgjLQPC/nWgwj7qBW8e9Ce
	cNWayiAZGTNn4Dk8js4bCMpgyLxYHijOEnwX6fJDY
X-Gm-Gg: AZuq6aIjrueMc6O3JIALMyE2sRFOvM4iY+Sld651G+wb3tCkFW2KFrhzSv5VQjfflqU
	uRy8+xJHEKV4bufxTm9r5BTbNxazm0BmY+5eyasYn/r6YeGaOLAL1/6eiiNSb6f1GV0IlSa7eHE
	EvumwZtTVmH7nIZ3Exe94IMnYD6Ha0tuq+XIBIYU+nkiXeOQO/aYBqykKqP2CfNncPovtjieAH/
	eCSGjssbv+BF7G5hpKlBo/l+QHCCEiLkkG/5z0TVX19rUKUpnrZFMZSevFJBd+lYsrqN5AG2PaN
	tuIrMZ3DLbHGThHCHICFE9DObA==
X-Received: by 2002:a05:7022:b90:b0:123:2f12:60b4 with SMTP id
 a92af1059eb24-124a0e788c8mr1994359c88.20.1769564733142; Tue, 27 Jan 2026
 17:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116091730.324322-1-alan.maguire@oracle.com>
 <CANpmjNM=w46BDuLsvAW6oM7JbPvrhN1ddaEUNSvsfZVU-514cQ@mail.gmail.com>
 <CANpmjNNoDHQOfH+bUqjpHdzYDxLwG7wA9qEywfWFNamt66Ziyg@mail.gmail.com> <20260127153129.2ca728a4550375a4172e1351@linux-foundation.org>
In-Reply-To: <20260127153129.2ca728a4550375a4172e1351@linux-foundation.org>
From: Marco Elver <elver@google.com>
Date: Wed, 28 Jan 2026 02:44:57 +0100
X-Gm-Features: AZwV_QhSjmzLIzBUhRwfGgKEWVU6weg0Ck7C_TGjNVwXp4aiaROpypITOJHgZWo
Message-ID: <CANpmjNNnMiUd4eb05fXCndJTd_WB9TRB_O0AB9+C4BCgrF3ZDw@mail.gmail.com>
Subject: Re: [PATCH] kcsan, compiler_types: avoid duplicate type issues in BPF
 Type Format
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, kees@kernel.org, nathan@kernel.org, 
	peterz@infradead.org, ojeda@kernel.org, ubizjak@gmail.com, Jason@zx2c4.com, 
	Marc.Herbert@linux.intel.com, hca@linux.ibm.com, hpa@zytor.com, 
	namjain@linux.microsoft.com, paulmck@kernel.org, linux-kernel@vger.kernel.org, 
	andrii.nakryiko@gmail.com, yonghong.song@linux.dev, ast@kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org, 
	nilay@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 00:31, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 28 Jan 2026 00:08:10 +0100 Marco Elver <elver@google.com> wrote:
>
> > > "KCSAN and KCSAN_SANITIZE objects" doesn't make sense.
> > > "KCSAN_SANITIZE.. := n" objects?
> > > Or just "instrumented and uninstrumented source files".
> > > Anyway, I know what you mean, but others might not. :-)
> > >
> > > > Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
> > > > Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> > > > Suggested-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > >
> > > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Which tree do compiler_types.h changes go through these days?
>
> Thanks for poking.
>
> compiler_types.h appears to be a free-for-all.  It's best to view such
> a thing as a KCSAN patch rather than a compiler_types.h patch - that
> the patch affects compiler_types.h is incidental.

I wasn't quite sure, given the conflict potential for this file - but
next time I'd take it through the kcsan tree then. This time around,
please continue to carry it.

> 31f605a308e6 came in via paulmck so convention (which perhaps only I
> maintain) says "Paul", but whatever - getting the fix merged is the
> important part.
>
> So I'll grab Alan's patch, shall drop if it pops up in -next via a
> different route.   Aiming for upstreaming in the next merge window.

Thanks!

> It's unclear whether a -stable backport is required.  Thoughts on this
> are sought.

I think it'd be appropriate!
