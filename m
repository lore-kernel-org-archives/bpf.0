Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94832B9A5
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731460; cv=none; b=Y7jCLkSMBDQJMx9hAJ/eR7kn1PfRf1VNwgH2VA3HkMBkbIOBQUu5EqFeISIiyzU3BHWggwdSGFSmuJtiOI+Ye2ninbp3/zlEibogSY6T/bwGDV/wDJ0UQHWfIBZz6DBpHjka/pV5pu23HRFS/PrzYiWlvSVD0SGDKzYfIT4OzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731460; c=relaxed/simple;
	bh=Apk6b4Ser9pZEBm3Ipc5FPIOTneTH/e76yIbKMT40nU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5/dD9e2iRU1RbVYLZkSkw38/s4eiO9tPHaoLSmEnOArFgOf8xgcR/ZyL0a1xG8ZOSfRr5lTB9/6vqvIL/FMrU/3tMPW6XLfJQzvZQ6azeVDR14WXMELsDxUuzmtZQjN21NdblYFaHRR03pJGoMpTtcdHzCVwZD/D1v14SSQAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNvV7qTW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNvV7qTW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48327b8350dso35002735e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770731458; x=1771336258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZSyHzsKlLj3SzVp+5gj2MbG7e5iF5jGchS1II3M/kE=;
        b=SNvV7qTWqYPJBprbiLU12DKjIMNzN0DW1PRLwcuOYzFHMxy8rpBRAwp2R75otQ+8JH
         WgYPN/Kg7vyIkutMLMOW3BoaroLcciyUgVGE5W1taB4Gm+L1NFXZeofTRKnmplsK71xt
         fwoabtGhxQeusVjpIOCQzS1+7l46rqzSgQD/Y5xg1xQL7wOV1tvvcXGNM4tnxQtCjWMY
         QE1kkj+A/MIMjX9cC9bYNqNRmNJy6dQvYkjfODYWUWh6W+D+klWbFaPjkO3brH1fUMeD
         Saa6UlZF+hAyngSad0KbzSts/6baRScrO5AFkzHyic1F7TjevxrAh9UrjjSaP811etYi
         oXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770731458; x=1771336258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZSyHzsKlLj3SzVp+5gj2MbG7e5iF5jGchS1II3M/kE=;
        b=wPH5E5Ib9roa3o46dPIXvwQsnXz8QPittDRjRKcgxxkeiuzzgj2PZENcX6RiDZiQoG
         cRlmaoBHeQyO8b1qfcB2wN+XBj+7PJt1v9T+htmgMf4+hfe1Zo2rt6Bg23N4yGH03ffp
         RQ4CuuxepFMu9oH0b6aUwwL4WigfkcRgtGGRr98mzYczdD5OBFMBTqaB7l3ltVOgmvQQ
         qibnEAHgDsW0+PVOJxX3pGg7+0QIQiTaE0ZVRS9xaUjTp7DsTdij/j/y98lDElY/8w76
         qQRo3t3ufUrJ5ofR4liFKw4T9rDXsuOSDhnSrPB71LmwnIRVJm3CtBxpO8OqL3I9MYOP
         A5aw==
X-Gm-Message-State: AOJu0Yzws0CeV4h7YnU6nIE8MlTjGQFQMVqGtswNVvrQDejfDblVmOaW
	Q+gZ2AK+JTBVlM0AoWj9AlV86/zO8FYiCKpNb3eGYroNGj7jQ6dRbpnIpba2IVbb
X-Gm-Gg: AZuq6aIJTjUjWryTDwG4VhoGy4k1guuhHTrPs4zYGbECJGRAofdc2ctraPME26uCPF+
	amShqAJah+hGtW13TOv2auJ6w9czcs40zi105meFrEEyF6npow8PV6fUPxtF7i+gJeIE8RqeKHc
	eXvOHlglIuhFhL4PxAKtsOkpPu+pAZWotkBy1fWCwjmOvi3ZqCcNqChg61dV2piBySb3vUvN4Dz
	Gfq4KdheJUzWakl3FIDbMnTcZYjcJZbuHhbxo1wNRRhd+WsJ69egWbt8iKGTshJ1ijOg2E992UP
	s6IAbyzvyfRKVzgMwvWrnnQ3TA0dPHRZu71M5juUKfwrtCW6wUWv5rEB65ieF+Y3eyeXMQdVQ+V
	Zs84GRXdBxHueiW+aCNTcrpZNSwaUzAvRY8g7zoJOZ1rB3d0/D2vjfkl/mqSJA3S7sFMMh+hC
X-Received: by 2002:a05:600c:3e16:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-483201d9fc5mr202082045e9.6.1770731457294;
        Tue, 10 Feb 2026 05:50:57 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d482480sm70897135e9.0.2026.02.10.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 05:50:56 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Feb 2026 14:50:55 +0100
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf v1 1/1] libbpf: Fix out-of-bound read in
 bpf_linker__add_buf()
Message-ID: <aYs3v2OMxm1HIcmw@krava>
References: <20260209230134.3530521-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209230134.3530521-1-ameryhung@gmail.com>

On Mon, Feb 09, 2026 at 03:01:34PM -0800, Amery Hung wrote:
> Fix a potential out-of-bound read in bpf_linker__add_buf() by advancing
> the buffer pointer and reducing the remaining buffer size passed to
> write() in each iteration. The bug is reported in [0].
> 
> [0]: https://github.com/libbpf/libbpf/issues/945
> 
> Fixes: 6d5e5e5d7ce1 ("libbpf: Extend linker API to support in-memory ELF files")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  tools/lib/bpf/linker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index f4403e3cf994..78f92c39290a 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -581,7 +581,7 @@ int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf_sz,
>  
>  	written = 0;
>  	while (written < buf_sz) {
> -		ret = write(fd, buf, buf_sz);
> +		ret = write(fd, buf + written, buf_sz - written);
>  		if (ret < 0) {
>  			ret = -errno;
>  			pr_warn("failed to write '%s': %s\n", filename, errstr(ret));
> -- 
> 2.47.3
> 
> 
