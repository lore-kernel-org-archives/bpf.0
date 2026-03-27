Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326873EF65B
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621330; cv=pass; b=qQtcuQrOdqF/qJRGQ1RYU4e9UROkEVho0VnNOxquoT9gDO0GvdYvgqUP7KLOVsEVpf8OmKsFjO8Ge6Inz/Hkoj8ukaipTtYdETKlxbu009+nDViaBpygOLyh34hRPM4Q19mV2Xr4rXpExosZRqEGb0uV/edvWVc161ytxYgCsLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621330; c=relaxed/simple;
	bh=KTDK3vOxt1fIVdHhRs3HNHtD5rFi66H7oz+TrzUybAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTMBgq/lScUklGL6ex3mpQL9Ptt33CGqBXDsLIp5RXILeu7dz1W/isVSIbREPzQbbyuJXSlf4savevzTOAdZ+6rXBYTujs7HmUz20VsxEJWq1kSfSUaH06EzDRsNjMChBFLi1OYaZ7h/3fm7VXvu6UAVRZscryK7xPf5Xwd8P70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID41B3kO; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID41B3kO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso21074395e9.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 07:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621327; cv=none;
        d=google.com; s=arc-20240605;
        b=RT+rotYbZs1ufIxWApVABMsV44c+u8j9WhA37/AUMqvLo5urnmNF82J8Bv9IJypavO
         gNbifY/HSLwJ0FZqDXO7Me4RERnYWkdrmaDVJIaBtexpFpKzuB78pceqZ+H1edUwiLEq
         5kEOf1mnuT94zRZyWXaulkv8kNQZ7TmyDryg9hkmAcsfj4GuC73Fvn3v7A1RtBCf9wXg
         iHyzAgLAdTOkLvWLwjOiofs6MakO+3S3k48mmyZzk9q7aUatajqL6a2B0ygH9BFLAc+M
         qF9P5xU0rG0pRp9S1QthaFEKW6GDI38QyYvkYCOxijW+YnnjEHfQ2HhQxqdN+g127TgD
         JxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ms382mXmeMfyEZXo+JDpLmvuZwZ5tlyqI074nqlFpZI=;
        fh=FO1PeLT2VHHxhKstgzmmlpzPAy2WZbeiEB/oAvC8l8A=;
        b=clXjV+xCS3QdBeKvYj6fnjKktzNY38ZC5Sbg3PlwloBYKgBqlbf5nN1OW4mPBzMd3O
         Rpx0kGDqkpNscwetV5SmMHzmZlpFiL80rnhyOEUDZ07emHygyHd/6SxalYqmwGPlwkYC
         g1MAFHh7+PEjsemUbcx438nkfhoA+9q5NiW1bNI5gvGJubhniHBSmwDZp9XEHH+yF8vY
         Iig4OMGeSG1dGXra7yztelQ6S9ZtTYyo6eUaeoo7tGE5/emoXlfDM6C+z4WOHeHnN1An
         cV2SPyU1ZfSIOBA2h7fjw+W8Ojpx3lqkLJlwflpgPyfDM8lAY+cLW2nkLl5BgCW3Uch9
         0Z1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774621327; x=1775226127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms382mXmeMfyEZXo+JDpLmvuZwZ5tlyqI074nqlFpZI=;
        b=ID41B3kOeFeMQf6qz/FF7kGQvO9qo9l1SDlO2Hs/teWIpjaa68X4pXuzQaSFe80yGy
         dZ5ZXKzqbZyFKx/32kPuei4PrzJ/xUqRAKHlezgiEfbEhZV7sbljVBNYafTUJ6U/jD/C
         KeyZNqycrLT0xHJYsQx+XDNPW1mytftFmTasne8vb9pC2/9sKj6Hur52fAn0ugDbTIOP
         MPajGDu/f8j+9wKwCT29dVsD8t7akE56tdEIPRqcIQSzS3B0zlZElbb4BUyuNxKYDPAT
         En6wgibJHr8IL8+CBWpiEBgV1WcYYklfOliek5xF0Hd7PNSjAMwn2UVDVqXZqbJoX7NV
         jhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621327; x=1775226127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ms382mXmeMfyEZXo+JDpLmvuZwZ5tlyqI074nqlFpZI=;
        b=DnPqhhWkOHI2Zko4NbUeY836+QZlBBAIvlV0AJd8xpnc6vewZxJzthCqlW9v80/lKT
         0Rzck14MpmI0tQ2G3Mn1lpI+852FuwlkKuXKhHMLex4nsxynPEoGxTia4RFA7WyjBWna
         tcEBWDwKAO88boGPPGlqUTKgYF3WvTwRve1C8IxY1O9Pq4EVawAjRTrfKci4pxPJezGn
         2ouavhoUFG6vswgw0rbwYz3L5ytOeXk5GTUK8OdDVUJK7bJW3sd28sv36l95Kw0z0n4a
         ndoHgZSbZ0hScKWtSsjGQePsyoijj/bxl6WYuSqeODPreBRGLoz8lgF0Y1D+62Kkzv35
         lCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvbHS6SqLAX1B2WEH+ve4QGXxYptJgNem2nWOt7jNpafyvqsLZ72SsYamLcPYhr1V6uUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEsFoW9xp/gWa/9RjHVPzygsBo5POpAZVOEKJ0t5ryZLV5bhOU
	rEm/lwuS//yWROLgOgfzrusid2SGjRrH0BOPvb19TsGWPquuPgn8pyxIc1qPlQPhAI4WQjyVVmT
	vBS0w4CENxGJOW68Vv79DSNZrrdfy8aY=
X-Gm-Gg: ATEYQzxM2GCsjiGYiY5rsw6qWcTVS/vvfGOW3BZ8y2hXROinY7MkOhcxbkQgINwlq4o
	69Jisgh/W1+8ZBq0tBWiguprhUO63YTFPnOcdcmoodSh1wi/jfTqNVSu1ml8W1wwUkwBxZgrrGQ
	hzOi761MFvt07O5BtUo/7MXd99K90huZvNi7uPOdY0W/JP2ooBtY9rdZnbsB1tzpGOOIkXrl5yj
	S4suWHupfy5OnJC3Yy5W8/Oo5SGsCwW0m3MlagQCjYX/8lbHpdKsHJROXpptgAWj8wXie9rrV0S
	eEvkFOcIRez/79JtGmGja+r3QpN8NMZeQLzaBe6xGyPtsCMluzNOO6TWOw3oW22yS5Og9cNFV4c
	9IqbN57shwZ9pmMcRKh/MmcUrMw==
X-Received: by 2002:a05:600c:4f91:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48727eda549mr46648885e9.17.1774621327165; Fri, 27 Mar 2026
 07:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327114741.91500-1-pilgrimtao@gmail.com> <20260327114741.91500-2-pilgrimtao@gmail.com>
In-Reply-To: <20260327114741.91500-2-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 07:21:56 -0700
X-Gm-Features: AQROBzBIPfZAUsMrDB7LBzUtbbmaH79IMxVvd9bzKdqKC91ZGulsOHpJpWVa3Bc
Message-ID: <CAADnVQJizm+Y8_AE0rjJnBCrvNc+ThiWdbc-ZuUZqYTLtf=MOA@mail.gmail.com>
Subject: Re: [RFC 1/2] block: Introduce the UFQ I/O scheduler
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, pjw@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alex Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	tmgross@umich.edu, Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-block@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 4:49=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.com> =
wrote:
>
> +
> +__bpf_kfunc bool bpf_request_put(struct request *rq)
> +{
> +       if (req_ref_put_and_test(rq))
> +               return false;
> +
> +       return true;
> +}

...

> +BTF_ID_FLAGS(func, bpf_request_put)

I bet you knew this is not safe and despite that you still
decided to hack it this way.
This corner cutting is a red flag for this patchset and
your link list patches.
Since you got caught doing this you need to prove much harder
that you know what you're doing and there are no other safety issues.
