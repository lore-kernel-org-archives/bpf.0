Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3F3DB89
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160303; cv=none; b=bG0LduHvmt10dfkv+GJ9aP8vtSg8kp2554gMkRoT+bKWPQVqB0IgHNUKUBf6HATg+4O9aYpWQHpvJ/v5pMC8tzcTGNgyhWOOQ4DTauWJ8IKgXTkZIx2cZoOsXR1aBxd0nVw7vyIKcyO/nhhsj8QTlgTHr+qWtvE1Xx/KEGyZ8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160303; c=relaxed/simple;
	bh=EdM448FB9/iYoKH61bfb5XVsEpexHAoeqRr6pU6j+XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntOas9rcDEQYeKH4mx2FvWzJ2W+eV6U+DCzHSIK02VjkZT/hBcev5Cb6YqGLeSBxqxnxohaHvsGyPlgMKyvROzg7rNeIAzqQAraJTi9qNLRaxi3HWUZtnYxe0bb+Fb/+gHFp5EOmy2mMnz+CJRlZ0f8Po7PBY7Stq2O6mPBU2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA+Im0Nr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA+Im0Nr"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513173e8191so4122213e87.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710160300; x=1710765100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdM448FB9/iYoKH61bfb5XVsEpexHAoeqRr6pU6j+XQ=;
        b=eA+Im0NrgSujnBstyyUlMdarXVurag4LmTorq5OlO1QYB/06up/xEX0BYA8vrJiJRN
         2GhjLr/Sly19K0oyEFMs6eu48Tap2SD9wrPIrqA84SwfSEhvKwUepINiIzpz2PdjtCVo
         p9bJvKTfMnfFQT0xwASs0ghcj1Cyqk/QgM/s2q1XNT4kLr8szEwzvnDZKU5nmD5hucYd
         /ThdYi2JFw1Z4VoX6Sfq3syTPTSqZnUzj5QFW0uDUzmJ7sE9lSQA/WWLQ7PYb3XOaxtH
         NJknrElhPNRM4Cmx0WsjFgR3Tzxg2nWpE/N9Ua/uwNXYoRA4uhCwygva6LLFJIxcKG1A
         cn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710160300; x=1710765100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdM448FB9/iYoKH61bfb5XVsEpexHAoeqRr6pU6j+XQ=;
        b=U70mywgjkrPRJr/A3WVsJKlSW0Xjiou/BzoiRlwCAz8I3dwq/E8W9aAu9zQA0h2tW6
         98LcqzaPcd9oUod2a+0M/I6rKXAqGC7Mj4rfe+k56iVIOwIOJrZ+yQnsL2nTePURkIBZ
         Fo7de4WJFjZC8VlF9qN5boQxm7P8J6VHDd14UxMhCm/VnhgIQJgSQH5xy27pYegZkjyD
         2AufX2lTtOj0AWPckjooff8UgQDZV9OzG/vCTdebmPKEc/qigypNTb2c/JH44IQEFmMT
         SUis7IgKi3kCOj/ZycOoVcNbtoan6P1fvY7MhWtWqdDd4uNir44xIuxDvPqnFzGj6BJz
         JTjg==
X-Forwarded-Encrypted: i=1; AJvYcCWUF1H+2y4zxTbEpaLYl3Xqhu547zWhPweWaneJDmcNsLy3IKG/AyHo4CmzY9tkcxAQVg3kwcbc4fYhzTtFd4zcekas
X-Gm-Message-State: AOJu0YyH36JL56i1+wZrAY6HrR/qZUakjyMYoxS16UKubXMSKE/zvnqn
	zUXRH59CEXhXUhyU3JYaO3oySBCB2IOsbPdtOMaTFF9lJ4tKqyHfPflYo2lQDTnTXJ/5/uakJPv
	g0nD1armHQsPFZKoJqRSznAQkzQ0=
X-Google-Smtp-Source: AGHT+IGgH3xPWXYHquog9/cefkErcywJeZkFQJJaBl7g2wjM4WpGFZ4qZU1tNDeWqR2UhqFIsDhApBvfggDck69EADk=
X-Received: by 2002:ac2:4d0f:0:b0:513:a161:2c7d with SMTP id
 r15-20020ac24d0f000000b00513a1612c7dmr2859243lfi.64.1710160299639; Mon, 11
 Mar 2024 05:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403092219.dhgcuz2G-lkp@intel.com> <CAADnVQJ+6mFs56fu+KEvumQ5uqM-oLpYx0hGxLJfE9XUCtEWEA@mail.gmail.com>
 <CANk7y0gT8bvKuhJvxG1yLTxdRycMKNEBtgEv_PsCA56Nv74cDg@mail.gmail.com>
 <CAADnVQLXFWDDV8xGLVRNd9JXaqOMfCO3ZGtuQUg8CZjrwLjxrA@mail.gmail.com> <CAPhsuW4=OPS+MgbsnsJM=pJCj64vg2xEG4MUq3hufWBkNDr-1w@mail.gmail.com>
In-Reply-To: <CAPhsuW4=OPS+MgbsnsJM=pJCj64vg2xEG4MUq3hufWBkNDr-1w@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 11 Mar 2024 13:31:28 +0100
Message-ID: <CANk7y0jWEx4Ziym=6dNZ7kZFgj=MfKdaS5qYJZPnx_DHCc0GsQ@mail.gmail.com>
Subject: Re: [bpf-next:master 5/7] kernel/bpf/core.c:900:5: warning:
 '__pte_index_size' is not defined, evaluates to 0
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel test robot <lkp@intel.com>, 
	bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > I think hard coding is cleaner and less surprising.
> > I'd like to hear what Song thinks about it.
>
> Agreed. Let's just hard code it to 2MiB * num_possible_nodes().
>
> Thanks,
> Song

Here it is: https://lore.kernel.org/all/20240311122722.86232-1-puranjay12@gmail.com/

Thanks,
Puranjay
