Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715B41DDE0
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050854; cv=pass; b=NBak5LG1v6Sr7on3lWV+VwIVajBpV9x+7A2nYsf0k+zwQVCOD6DwQg4d2wSWhNFcoU72Ul0zKso5kHvDJdFAUEmEW4/q+ZIMX66dyWGq7cAmMDqf0cyI5ai+S++wCZth9++3kZDL8di3kLK2tsebGEk7QE+aZLge7AIJaVaKRSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050854; c=relaxed/simple;
	bh=2Ul71xOb4CR3H33B4d0sA2boSbkG+i5cMyJ/5cZrvtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhPo93Gt8vC/VhRuBZ+FiWRvhh3fGm81WGKUQnseg0RijJq3f6ifJpJGx0mK352kg2sjbu+DdqHtHQTkxSDGDFLT7TQkmH5DHjTkzclRXz8o4EzcAKJve2CpNb+hQMra+1OroFg1vEHgbX/HNuQdUw0mWCUViTfFALS9TUjGyHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKfWDKYH; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKfWDKYH"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c7fd21b63so22277931fa.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050851; cv=none;
        d=google.com; s=arc-20260327;
        b=l/3hbNauS4kNIbKKSetEZ9lWlDRwtvdOJRW3oNfl5o57VhF6dQERfvf/Iz5Urpmno6
         Gk/TTsAaBA/iM7UvFtpEEbHtG8O//Mngv6ePd3OPHErEmD5Rlf5es2Tj6HIFUWtm1hQ7
         EBD3DPioJ7DFE5FBswqGqqYyf+PkzoNcLHkGn20SJFHy8JxXG8QwuxzfuxIzagvYFesW
         JjPby/fSRmyqWWIOAwE3v3TSEHwHfnVB3zK1UUcKebC/5q7ggvLW1YqfMMbgCiEo41Qw
         5c2MH0jQ+1x6+SlLjMemWD2gEC0VtwmoMqx3CrhLtpL2Wm957AX5JAGM6TblN0ju0ENk
         QUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2Ul71xOb4CR3H33B4d0sA2boSbkG+i5cMyJ/5cZrvtk=;
        fh=5b5dLJ9kTJfvQoWGFwThFDZmVhP7lAb2WX2IX41yKn4=;
        b=T0kZfrUx7pm2BcmMvys/KMsEl3rMCmM2jWZg36mGRZr61sirbhkdUeft08mgIsDVCm
         2zG6SF4irOL1x43qFt46ClChmseBV39aOkYAsoGsV0+y3W6uDW6iP8phDCbV6q75//FB
         nkRCSoG3oqi+zoMKi36e0CKRtZiPKhxHAxW2OzXifbazoXEZxWvUu6udykTumO656vpE
         aGcidEiQ3FsqrBY8wJ6CZ43THa2NPkeDloIrp5QJo/AW6snIHwIHwnjZce4mrY3S1lBr
         VL3dX2Uv60spJim8KjdcJBnoFIOg5zW7CkcWEJnDeSUabYFexAV5p1vn4rLXP3JpyPYE
         X6Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786050851; x=1786655651; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Ul71xOb4CR3H33B4d0sA2boSbkG+i5cMyJ/5cZrvtk=;
        b=YKfWDKYHMBI3EM0/BQnf5xm7YpN8/VaCh8cjMLOGrb1d19h1cdaEpUhFG9ypWZfsN1
         BtAQiqcL+ZPFLqUTBypE1Wx8CsuqEwVA6bSCwWrfhjgwm1ZE71PRtZL4nHXCn7xexcdV
         lgmj9YXFcFUI1Y9H3YQweO+hj45yjrJAmxDUgZ+tYivF7KgcCSjpw5y/tGoBrZQzrBhw
         EacrHiZpY/H3SLi8V94LxDD8RtVzXo2uBw4MOXhmxig1FFY/F8ci64WS1yrx+qiDcetY
         fzOoqUlezVM+sVJx4f4FNG3RXCwTHkTbq0IXUqvditV63cpjKbKJ4li1gbByrjV7LRE2
         WX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050851; x=1786655651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2Ul71xOb4CR3H33B4d0sA2boSbkG+i5cMyJ/5cZrvtk=;
        b=ieerNyXkp4NaBaT7weDH6i55UuLnFvUhVQuYBjqRNBXYUzZT0BYgm787TjxxvT8+D3
         kB5e/woHcRmuA8sVnIJiRYo7TnuEktKwRSqbJQSZQulRVzUNWYduUW5D4VEoJYJDFrfx
         SwoL4l8lbhmrMRZ+f5MX6N5f4rVHLs0fg7++59cb6XJAajWViTAg8oC9OEo8NvB5V4RO
         dmK25v8WQv6u3EpWjLNikT4qqKIAxnS7zsJK4ZzClSakK82nJtjzicUPo4pIGRBGf2sV
         HxXUiVVrG7036f11DFvykh+97bF9t9gefGTP/ZX1eMow6v8++Cu9kNVdODVWtkPDyBXJ
         SaWg==
X-Gm-Message-State: AOJu0YxOIMoAoeYetBerCL7KpETT7tLTGX2Bhsug/lh3geqGGfKE9/0B
	KQGoN6V6TgSiL/yXyE5xChPveOI4/wHrTp1yk7FoxNYD2uNXaxVc4ZnEm6yEYzyF2TK/DIFpVeU
	rZpTabRaPwAfow+7coBk7+kzW2nqtp3o=
X-Gm-Gg: AR+sD12uF/SvGYGgbmT0RAxD+9Nt6i0Fdc7Kk4MUbnIC3teyGJdAWFwqAsuOyChlaHG
	7ktd2e1GEOaY4n3sn4n6lQBDlstTwUKsjQkPYKSVEjI110wwIHXwhPn11Rvs7Hghvr78QO3REZW
	PiJNluqwnmcc2AAbVNtWihFpdG1EO3AamHHvurk8wu0S674xrY4ifQQAeyTAMBJSG4S9r+6sf4g
	frfI5fjP+5gd50FVlkt3cDZ3+4QqWq+/w3U9HCOLB4FztZskP/uQsThDjjtNuNs9Fl6fbVyQsiL
	AzUSpmeVMfaho3lJXNgGg34mGsMr7zZgl2ov0+JUIgCeCWodD+xwTasqAQ==
X-Received: by 2002:a05:651c:1993:b0:39b:2757:c1d3 with SMTP id
 38308e7fff4ca-39fbae29cffmr20604271fa.9.1786050850676; Thu, 06 Aug 2026
 14:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805233940.3966981-1-dingning04@gmail.com>
 <DKHQUVB5TV0R.1OLK7GG1APAOR@gmail.com> <DKHR95T6P1ZC.G09YF6M1QEL2@gmail.com> <DKHY982BEJN7.2ZUBJJEXR8X7B@gmail.com>
In-Reply-To: <DKHY982BEJN7.2ZUBJJEXR8X7B@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Thu, 6 Aug 2026 14:13:59 -0700
X-Gm-Features: AUfX_mx1ga46zrbsPio-BaoBvBGYjHe9_71Kt_FkjtOcL0VD5rCVzb5iPff8W3w
Message-ID: <CAJP4iuvBhxjmxKjVKK2YFWyx=5qJc3ANLOxFdYfXeg-S5QXegQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Track overlapping RCU protection
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, puranjay@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

> I fixed this up since it was minor and applied the series. Thanks.
Sounds good, thanks!
