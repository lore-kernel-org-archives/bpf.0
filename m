Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3E34405C
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475343; cv=none; b=O/LomRJ5J+M+zYjcqrxznRb9TRhwevkuTqPU65mMOXIJWm9up+UD+RhVQPWtCUTJwT+OsDMQQMED1nmCKLm0dE3NSdlE/xh7o58I6Js/50AYE83w4PIbNpikm6LgalVnOxLAizBtHlZYqd02+1OSfEW1sqy0GDBnCUyMUaVvHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475343; c=relaxed/simple;
	bh=MsH+PcXT30u+lJy802VpEE2WroiFoM+7z3TtQBxk4pE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCLH5msSJBlUo4P3onW0CrhDi2y1yOGSnv+NTxvZpKQMAizGn0KvwEzfuXDXRgF5DK2SbDHOBHJFTgBZOrc5qBc9GRqYlEbETU0DUwzjRkmPRZInX06Eoy/y2f5Xisob3t0U/uWPo0Mj/KmYWzku3SkOTizOFj9PM7z5/NnvyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NisCVJG2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NisCVJG2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fb14227cso3697545e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774475340; x=1775080140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMoNBjl/XwK2i9fbEYYiMgexUSM7RdwiRIGsr2oDlWQ=;
        b=NisCVJG2JgflV5gIbEfjBJSJcy6Jc09c07pZy6ak9QbhMJ3bKTVDMVeqMKDYs/X3Ca
         S4PGyx/c0wVQupe1nbY1jxsOSieKWLxAW9ARVYubBqVQ/G1vwwdSZ4bHJnYiuFNnfkNj
         yJBlwAsfdnOhDhqIl2JSoWKGktIFCVz+9kO+p8B64x+SavBtWpAO/f77zikJXGaP/xty
         rLcHOtZqz1EDmOZMUc6dE+nyVZXEFQUmwu6PKV9tqYuofbNFDzte3xY7XBz30URqR2HM
         fiBvDyYB8R7RbWq2IgTLlsr3u27QPYb6FEyqbURIZqsdC5WiGM3D+jFEMRAryOsop//H
         eEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774475340; x=1775080140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMoNBjl/XwK2i9fbEYYiMgexUSM7RdwiRIGsr2oDlWQ=;
        b=QZrauVMkyO2XOncyJvZjSX31UY/OEY7NTXHzM/d1iSBu08EGfKY6GcZjcm08e12uG1
         TIt6nefyl2CaBLycwzkgdHfd/ZoN8H+AGtrVXAVXtLF161WvBaEDekd1Hi1RuyrKU6NS
         pj1e56Kp/ky3EXjFeh2fxPyy8dEea16SgrBP8M8IzGIa6rLas77/JQCgkbG6IjUU8xoi
         RrkQ5IFJQKsI5yJG/n+srxs4wghrpETWVBywfn+MeYoGvLSjurYEQXPU8I1S9pd/KNt9
         Rrdg2GSPF/xy7egS22Ezbt0uz9u7XZW/6nP17Ngu+vUWTLzvvbH56YE3RjXrvPHFSGoH
         +PKg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/yS1KPhybFTqdB1Y4A60I2UMtCKoBz4js4jwIXxJPb2XvmjGUMdJ0ZYnk/IS1tiluHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNkS1gxNOcOwMMHR8ytCOYyJRTD6zWfcZNlstu28Js47KveQd
	ZZAm5OUeHW7VwanEyh8qNBs91sdsjfxWogjh9v+KK6CyBFaXOIevwsBa
X-Gm-Gg: ATEYQzxyYQKFvhciV3mJz32zPuCPXGlVd9QzQsjqye4JT9oyAnc625KOeQ5ii3mobiI
	oBLmk0OAwieHKzBUdTRPr4xmNW4y5NBSAzSpym6mkuhEglCkrtCNRDTalGlOx69SdvDJAYdwrvh
	1kbejdJVc2MxL177gO1AZNT0TFlJecjzQsff+qonvvBX9Q6Uil7QmAioj213h7++vGGKMkeG6/Y
	i7hW1xWqfFJzgYHwYFY96vFH1GGeubEge7bqGsopp7akHuq8Bd2cZiENtqZyPrVI/dj3rdxgti7
	hPCDSNh7w8W8zoIZDnHZQPylfOl9O0QBPz/Hr3GLpihC6ixUGRQZ++yTsS16quQixbKxW5Ew5BF
	gAENFQrOpLCLjF0pgwpq4GYM6ZXUW0zCGO7qsRUL/etja00VXKTyooWWeLUDD8zorAJUz0XuB2m
	0E2DyF3RU5vsYQAV35fv0d707Jj4pu7axlilMbJOcOJQ==
X-Received: by 2002:a05:600c:a4f:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-4871606c9e8mr64820085e9.23.1774475340059;
        Wed, 25 Mar 2026 14:49:00 -0700 (PDT)
Received: from krava (h082218179122.host.wavenet.at. [82.218.179.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm3094304f8f.5.2026.03.25.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:48:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Mar 2026 22:48:57 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv4 bpf-next 24/25] selftests/bpf: Add tracing multi attach
 benchmark test
Message-ID: <acRYSeQm58rVpWzk@krava>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <20260324081846.2334094-25-jolsa@kernel.org>
 <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>

On Wed, Mar 25, 2026 at 02:45:31PM +0800, Leon Hwang wrote:

SNIP

> > +
> > +	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
> > +	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
> > +
> > +	printf("%s: found %lu functions\n", __func__, cnt);
> > +	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> > +	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> > +
> > +cleanup:
> > +	tracing_multi_bench__destroy(skel);
> > +	tdestroy(root, tdestroy_free_nop);
> > +	free_kallsyms_local(ksyms);
> > +	free(ids);
> 
> Is btf__free(btf) missing here? Since 'btf' was calloc inner
> btf__load_vmlinux_btf().

ah yea, will add, thanks

jirka
