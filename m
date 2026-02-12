Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADA35BDA0
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905416; cv=none; b=tmXUWk8ijQOuCRo8VV5egnzMKZY1WVpulen9EcY1583Wq81F9Kl8BRLJB/S8VwM9ctT7BkqYiEN7YtkvIOKPiM4x55MjfsdkcUH3q5Nl4pLN6bf/t6kUriZHGhyjiDLcGfFW+B/+WaN6g6qJ3ovCWM1EDucJspwadq2oi9xYEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905416; c=relaxed/simple;
	bh=x6XW7TicCM0/vitdGw1lx5ML1SM+zN6bujZiDZlBzTI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSBn0REDNCVL/Aq7dxtKTfVqzxx5N4b9ZRAWhnwLEu/78JX1eKu/cBw5duC5KY1Ol6ovlSTQjOfr5UZAEkAf80xdAP2EJ6bEBFhubpFYIjIjpiF4efiamzistpmds3m0HiGHvBy/bnaORD9BML1abQOMAGS52vw2m2C7zMpVf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtKOjErr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtKOjErr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4807068eacbso29006245e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770905414; x=1771510214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dq3ACEcbwiGgOeHNcJWkbCiaFjnyRa3H9wdpjQ+otAU=;
        b=YtKOjErr75G7WFm3yIi0NIJ2K3HEw86/DJnZOGBnJIF2VxO/tGyP50m8jL5grvyems
         XzU0VpQVKdGDep05788gTfrbLL2MnhjKEWqjfft1PrdpzCMvyNHN92qe9qUaA3YErxqD
         7LJAVUzZyLWpIAUUZyRPvQITxX3gZEeSs3NI2w0+tuvigU9vZ7Wn4hmfpF73q/otVV3T
         7zly3RnKfQl4wDA9pEzrk8zpnWIJMPHCl7glp3BeELKWOSNHAjJlyQBtLzQItXG9BWR2
         G/ZaVswEWWICFkYN5gf1Es/4nsVA7mEyEm1SA/HsJm714ucD2rkS05r7uk7f7QiLND2k
         +aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905414; x=1771510214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dq3ACEcbwiGgOeHNcJWkbCiaFjnyRa3H9wdpjQ+otAU=;
        b=IIH1lHwv9hxKiHo73ZEslW/17g9PoWz9ubQaoE9UahVG6jgCP0hT7tTklmTJHyw6rE
         iRjdekUcJ8I+F9EWheV7AXjRnZFvvIBYuva7PTx0a9sj/xtD/WnZ2ac/EbHphopnIfZ9
         BfBIkWBrUpMctY9ihXMqYePkRP+gd28tfXTdHnqgDW/EKvLCjgmIUQdIgZsADXg2aFvj
         gSfgb75Y2djgzhogwTt1JC+3CMZI9LZSzFN3EZ+nTwlrPlwPSqVH/U3NVlT4E+LGyAUU
         DlPtRPoxb1m2MZOUz4/BqCx95W99+TUAimdCcGQ5KTWfFXmsFVwtG5YZVze6F0LcIpQ7
         N5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn7aLNeHsH4YL9vL9c2IMfP4k6PLUr41cNulHBnHGK8zJQPIj62qArUZ9yzWg4nlPuWqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjZL42m8oDuOGvfwUyVQFS8vpHt2DVuvhZG/FFwx4RMbapMYb
	WiKrTnut/1FARXLBRgZ+jwEh0dGzQJirzoUEsZTeNbbKxfNdTzW5fWSp
X-Gm-Gg: AZuq6aIwD2LaVnAD4AQ3GHcQpJZhjfQ6U3QDFwgYBSdTpEHlJDPum01RrAu2Fz0Ap4d
	1lanY3bUqjY2OjiPxluHD24Whj8h91J6AhIW80us3bxRx+jIckRXTZKQYiuNMsuxBVLJ8JfkAE/
	//EW4HzO+JVdr6suo1ieCUaY/IRiq1lwu0UFKIUNlF1K3Q/GC1OB2wbMzurLOcwlVXoeYBhJcoQ
	5y8zbLwK8tPbCZEgcVrgeUfUSZumWd/B8al+nju3E3D5Ezm0aDKD31DEuqbzMJsSeZngm9ZM+7p
	Q6PR3Xcjb4eo5lAyzgt9rTLbl9LtIjwpgVlLqO0JX5/cPPBRgAQw2WZFl78N/u7xMDXIIh4HAKD
	5Pw4Qkq4YpLOul7l5pBDoCPcuOd59WCMb0GWCS+4VS+xwGV5DOA8W3VjyzOTtnvJA0ckbU567
X-Received: by 2002:a05:600c:458c:b0:471:700:f281 with SMTP id 5b1f17b1804b1-48367173348mr38358755e9.25.1770905413699;
        Thu, 12 Feb 2026 06:10:13 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dfb4bd4sm130062795e9.7.2026.02.12.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:10:13 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Feb 2026 15:10:11 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCHv3 bpf-next 4/5] selftests/bpf: Add test for checking
 correct nop of optimized usdt
Message-ID: <aY3fQ-3KICVGLAKP@krava>
References: <20260211084858.750950-1-jolsa@kernel.org>
 <20260211084858.750950-5-jolsa@kernel.org>
 <CAEf4BzYVhVabvXRNGycSzA57HbF7ECZeYCQ1chq7HxXTi6gogQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYVhVabvXRNGycSzA57HbF7ECZeYCQ1chq7HxXTi6gogQ@mail.gmail.com>

On Wed, Feb 11, 2026 at 01:45:24PM -0800, Andrii Nakryiko wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> > index a78c87537b07..6911868cdf67 100644
> > --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> > +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> > @@ -138,4 +138,13 @@ int usdt_sib(struct pt_regs *ctx)
> >         return 0;
> >  }
> >
> > +int executed;
> > +
> > +SEC("usdt")
> > +int usdt_executed(struct pt_regs *ctx)
> > +{
> > +       executed++;
> 
> did you try capturing pt_reg's ip value and validating it?

ok, it's easy to add that check

jirka
