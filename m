Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A250242D9D
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 05:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773034038; cv=none; b=YGhFoeRmxiGA1CIJQuGP2upkKeofiabmUqH/2nmi4iDWmKKfVdn76CSQC/dXZPfDsUyZTbPP5R7CRrzO1ByK55wrLX2E+lit1FRLVxqEDj6VNlxfACQVKT55iWpcKpRxOIN7e64aBhyWpy0kvqMs9ugtw77kEJ6fZyr0RDbek54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773034038; c=relaxed/simple;
	bh=SaOrBLT4l851fCcHgY5KsHO57MmiotmaAt68kcfMsJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn9gGTa3kfhtyL4TOT9iIZYFDph8QEnBxkKOsmN/LUeKV86ft2NIz2AmVdE71xoTj6FFK0CzUFepWqNF1zeIV+NCOwVz/QIUEkz4aMjyPYHrefsdj78OuUJSebt6lNg88GNgUC+VrCW3QJIYWVJrZ+tgvMwpu9iOKV1FDzgY7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A6e6j/rG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A6e6j/rG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso18785565e9.3
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 22:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773034035; x=1773638835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHU9NtN20V2yt5D8h9eTlDEMfyJSkwZKQCpCvZ2HLZE=;
        b=A6e6j/rG1+kKXnsTrqMvUHmF7gG7SgYnRbk5CXA0Nwp1yQprIo4mJiCY30P6lQoVZe
         nQcVfbAg/wY4zoOYjiWRRbYmIqOXg76eexIX+51z/XTGLBoSXnx3c3DMlpt8esHjc0mL
         /HxCdjLf42ISYJBCkAFBg+ukBZRSjrU0EAwwKqw9/tsTj/tp1FYiPDT1VencxGtqgiei
         DzrPOSGfud2LuudvgQWzD8ZYN7tWIBjGmbPZIy3LXhb6rE6I5Udp+MfeHvqT1YdoinXW
         NTpBIx6zrfGw1O5BIUzBuesRbiexdZSKoivQYeBZQj+pVVlZ2oRzZeVIda960ZBRDPDi
         oeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773034035; x=1773638835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHU9NtN20V2yt5D8h9eTlDEMfyJSkwZKQCpCvZ2HLZE=;
        b=cFHgVA3ROXN4PSNXM8K/M7Nx12CDsDIZ2Cfk8pTzCWByTCpzUrTtaowz7txtCxTuuE
         47jMKm/5zO3FM3aQjI64oU/gEskiizsAZwWbOHjPrc6WHXlyvKbrpFXdxnpyt/ZfJbuJ
         HD946KR4T7OwIOGPPTEMaGfC21/cnGSVhZqlYuEl8ogZEy7W9uF8hAoCtIssW0DMwoAy
         VNeEwQwGSsY+MAicAGmjckJeEzsXvUdqzYwudkVot8POgJR6nPJy+Etg9maj7JcpPrKU
         HL07lcQxInGgLu5Xk3unQOO2B2b7imr/1CoYGhMEOoXdWhwV92r+BObtgtFC5yGE8Emw
         P2Mg==
X-Gm-Message-State: AOJu0YxsIL0KYZ2pF7df7FqJ2kJk1OyXIhLoRT6IeC7Un8OOuXxZ08Wa
	XHiZLVl/bJonHlpUdehrPWUePqLovP481RK2yaoDQTnIoh+a/6tRJxhLShWfFM1bQX4=
X-Gm-Gg: ATEYQzwaiVmRQn6cFs1gVbKRgq4azse4BnQxSkc/Ucktmxoxp1fH+7DMf0mOEM5Squ9
	HXtXGYhJHog3RgqfMQnAJaY98xBsdOp4N7sig87ma+KVwN5PCDeU4o5CfCphaE0wHkRDZtRDk+T
	NLRFiHOZtITyM5YhVKK7TbE0qt0VPpF0beykrl1c9y3yIFsumT+SnrZpR3Y8JI3nrJcC8PwPvSJ
	r8UzGkzXhVfV0Yx/X5h+rv7b4A/xeXa2sLTfoBQUZYXtlapWug0Oa0tfmbWERBqSdkWZcnUmcBH
	dqg00oFWUJrab4KZcT+cvZfZ15TdAfplTCfc58HEOGfA3wC6QoXZk8siZl2DhCVainyTeGqLjPV
	3Pr7rc5dWsWg+c6PEsC5mM70XZkFlW2Pxi77URVbYGgZtfJs+w5nP1i9XFCGYwxFhKf4+ZlUjbW
	pjMfJhXVf3XrgGf+G2cN2WFUSQvhEq
X-Received: by 2002:a05:600c:4591:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-48526978664mr160069705e9.34.1773034035362;
        Sun, 08 Mar 2026 22:27:15 -0700 (PDT)
Received: from u94a ([2401:e180:8d01:1fb3:e42c:360:78fd:1fec])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128d83495d2sm1770572c88.16.2026.03.08.22.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:27:14 -0700 (PDT)
Date: Mon, 9 Mar 2026 13:27:07 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <cn6sgomjvq4gxhnhuvbijg5clv3wa6qg63wki3crte5swqlegt@akrmjonuz7zu>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
 <nuuegl23fabz3whjszvzwd67m4l2dzu62w6onl45rjdauweyif@6gqzd2kzne7u>
 <aatoFpl2eJpS3MoF@Tunnel>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aatoFpl2eJpS3MoF@Tunnel>

On Sat, Mar 07, 2026 at 12:49:42AM +0100, Paul Chaignon wrote:
> On Fri, Mar 06, 2026 at 12:14:01PM +0800, Shung-Hsi Yu wrote:
> > On Tue, Mar 03, 2026 at 08:27:20PM +0100, Paul Chaignon wrote:
[...]
> Thanks a lot for the review and the detailed analysis! I also initially
> doubted that it could be reproduced in a program, but gave it a try
> anyway. The v2 includes a selftest that reproduces this (with a
> slightly different value on smin). I added you as a co-author; please
> give me a shout if I shouldn't have.

Glad to be added!

> The tnum does look suspicious but my intuition was that it doesn't
> actually matter to the reproduction. So it's just a matter of reaching
> those *32 and *64 values. The v2 selftest details how to get to that,
> but the difficulty was mostly to find the right sequence of bounds
> checks to not trigger refinement too early.
> 
> So this demonstrates that the patch not only avoids one round of bounds
> deduction, but does so while improving precision in some cases! I wasn't
> expecting that. Thanks!

:D

> [...]
> 
> > Haven't check whether Eduard's latest u32/s32 bounds refinement patch
> > makes any difference. Likely not.
> 
> Eduard's patch shouldn't make any difference as the u32 and s32 ranges
> are equal and therefore one can't be used to improve the other.

Oh indeed. That was a surprisingly good counter example I got.
