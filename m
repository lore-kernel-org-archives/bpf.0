Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B623A48F7
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399773; cv=none; b=NzAOwEKOSDx4EjwP1FWClB1wffaSsvQtACtswKU20SXovC4zYLCj9VL49xqi/YmABxSjSGnNS3FCBTpdO6mLtrxRxrzPW7JsAkxBW1IuczkwBXTyByB5QOJsYqOSec1sO9xUTTlS1YxLVsaMWVyAzxqQL1hx6X3tkwNTdhbuYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399773; c=relaxed/simple;
	bh=YVHpfijMFvXwFYtYcEbYOzUGDrBKkxr0rE81ZuLCUDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjakH5O4iB6AQkpd+JppYRe7lIHbU/zz1k7SqPbrjfXPLbu/FPmQ9KOzPHPU+Rh7jtu+8CTZT/G7dDKHduTEJ3sLyiysBzNBj7WGiJdu8x+D64yprdF00LgkhVUa/cDCM7qYgEF34ccJRvi10Yxa1gzUxC+ijY3Ztm/Z2LqBQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=POeCWXfH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="POeCWXfH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49553515a8bso21977765e9.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785399770; x=1786004570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nv5MqGnJrlRE2FZIwkXhHOAq/BZNAwk3GFn3XVUQ1R0=;
        b=POeCWXfHaaaZr9y9ym1fLeUu3TtJgtUvEOWyvlbGcprHHOBLHJ93vI2A62bCHo4AMl
         lShZeT2r5Jd7QK/vlGfQQcMmSlDTEbO949rZUVQ3vTIl93iswjT38k/HTTL5SrEp/45B
         laWbmT4lL0Ev+hSWgVrw/e+LpQhdbOipdF+JeN1BueJTJfxLKqKojmptLycYQ8cbsI/d
         2RnCAxQqt6A+dag5nYewdq7ohD24G+P9173R4pODSFxnZfdM3IcQA0SOTtFUrJ9ne0K8
         qx60b9Qu+tL/EtEF/OHrRXve4ZvzmbkRJ2c9BtHRBWMFPKaJKCkbJoe7vrvRd76VwIv4
         USGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399770; x=1786004570;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nv5MqGnJrlRE2FZIwkXhHOAq/BZNAwk3GFn3XVUQ1R0=;
        b=JMEO1AIFZarNEIeV3tKPfDJl93fW5D4nUz2Ssa1ZciIqjioJkdNw5aOZGXTkxGfEGP
         9lPlE+W55SYedAHZjU4EqDgX17y1fVDY7VKwCEcYN6OMjP1ehMq/RXJQW02zY1KtsV9D
         Li3Q6xbG4mqs2yMd6GLeAvHeU4e6ggqRu35sxTrKG+kdQNcBModcqbja5g0jlncFlkjj
         mCVlFyyqtTXxxxWs1T22I3fZesreJoEnZu7JwYC0W4iRpOwV+FBvaZV5qU4WB3s7YV9A
         R9dwxjj3wXcYFMJYBmMTt9DTXL34q199dUBOgul3hDSTF1nuD4EW3/69JQTALUpORYOb
         /8tw==
X-Forwarded-Encrypted: i=1; AHgh+RrnO68WhG/27h9Lqj0nRADGCwDYMkq8AMmJktix6Fi9d09m5W2oZjSmVNGP5ikWj6NaY6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdHHPsreKCGK506Ef2VF2t8p5A2vBFh86nxLSC9Uzgst+hjM2
	8t6htJo1H8tRhneS3KT9xoD+vUgmb3gQZFX57cbtE2zt9HbKo1rdghb/idj4ci0Ap4s=
X-Gm-Gg: AR+sD11SV6glIDjwZ87RiW7RlFSRbak4GCd9/4cubbN2ZdHVaQ9bz5Mfqu/zYPkhiUk
	XQAuQCEMOMEBhfB4ENvarHMzkuTRQFGZt6e0Qpv3ZpOkHlQtmBFsp8+RsAsGGcFXHlPK0bDqeuv
	kvDPj4KoMEcevvkbgnzyv+cfqQWMKAWRfUX5Fo7Cb1NKmIBxeB4syTzZmuokqcyVx9Zg/1PHpTP
	xqICqL0Rii7avkd7NcA3QresUk+iajPmBCow/jWi7jYHlbkciOZbbDG9pSAHkyeiA90jdOD+Vcw
	DgS16V/yL/0LYStxgpFxWWsdxQVIH/ok4riuQjViuyPtUJVgAA+wawuuxxchOdQwydoSeO1EXmK
	dOhae0MMUZTEYDH5OYBBSqO3PmdJBTKtGmq0ZQriJw79ePSaWCVe/umeAm+y2oLWnIOB/d/S1/1
	P6KbCFzG7VK/6Hiu2t9XiHKQJMQtNdpj48BXKRCp6SsvC191elB2tNFnd1fqTs8w/8+WLZjzNlT
	gG4rtqjl+E0clg=
X-Received: by 2002:a7b:c3d3:0:b0:495:62bc:a022 with SMTP id 5b1f17b1804b1-49800e749abmr13357955e9.13.1785399770061;
        Thu, 30 Jul 2026 01:22:50 -0700 (PDT)
Received: from u94a (61-227-70-26.dynamic-ip.hinet.net. [61.227.70.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d480c5sm29881120eec.25.2026.07.30.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:22:49 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:22:41 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: chenyy23@mails.tsinghua.edu.cn
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Daniel Wade <danjwade95@gmail.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v4 1/4] bpf: simplify sanitize_err() signature
Message-ID: <amsJt7qoxbqhNKM3@u94a>
References: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
 <20260729-c3-035-public-bpf-v4-v4-1-8ee297e2346b@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-c3-035-public-bpf-v4-v4-1-8ee297e2346b@mails.tsinghua.edu.cn>

On Wed, Jul 29, 2026 at 03:18:27PM +0000, Yiyang Chen via B4 Relay wrote:
> From: Eduard Zingerman <eddyz87@gmail.com>
> 
> The sanitize_err() function is called when:
> - ptr += scalar
> - scalar += ptr
> - scalar += scalar
> ALU operations are processed.
> 
> This commit drops offset and pointer registers parameters from its
> signature to simplify the follow-up changes for 'scalar += ptr' case.
> regs[src].type is safe to access, as it is not mutated by the callers.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
