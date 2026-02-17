Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F06313276
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366010; cv=none; b=bksLeue9PqxmVW1aT9dmJw9ZC7MrFMvqYOIWuTjdcTMOX0RamGFPLy1N/pECgCwPZyI7HD0Ce1onKiVoTOLRmGyi8qHNKjkAdQDXmYCCDfIih/lGb6IUw4uF3JFU8PDt4ZF4a6wR2sk6xazDbiINf2ybPr4AKbUNdYLNtyUPTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366010; c=relaxed/simple;
	bh=GM3vbopTlK82YTDhjQ6dx/5d8/FZmxV1xH8VtYP250g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4fPy1ReBMq3EaJnUfiuVadRRlfmKi6HMFr66vPPsya6DZaREPBqATbox3GS2lmiMDUfSYw4ZJInvnYwQnbFjnFj40Wy+nb5r0hzK00fnpIzFmOiBk0KgU8/8TxQm/6KqMmtvJ74gORTRFH3+c0Gq3axVbVPKn+Ytz1FNVFiw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cwjdrql/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwjdrql/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48375f10628so27848385e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771366008; x=1771970808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95TVX6sRJ3klPmBqzqAdvLFABEaQa3ayeFUm17/kMe8=;
        b=Cwjdrql/PGqiITfjQ6yxvoWS9MrKFj+/FjF4KNMCitpSqW/2upIq8B8NfXiRPgntZn
         6rlYPfU6OR0dbi6/ORIgLJWgFjo1n5RPLon55mD9Ak7/+9+VBt9ON4uk/ftD+EU0ZA6u
         VhDRVBN3g8UQ6hGC/5dbuc607AN1EkVt2hJA1KB+Gc1GhHa81ZbtvxXxPCg8yaD72Xo9
         DIYY+hS1r04LR8l+cKobll0rtsKfwPIHPuaaeqK2Ds+QUmHvI1hRXPd3sJ9hFLbq2aNz
         juFIkux7KuXonuFjv1+FMOzu9U3Iz8iMujATkkk3caDuMSk17GygNCI6mWIApvTIbEqd
         fj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771366008; x=1771970808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95TVX6sRJ3klPmBqzqAdvLFABEaQa3ayeFUm17/kMe8=;
        b=pWWpSZQWz+0NA6Xg1k2cX7Tgt0ZSUm8rBnthEf4ZwlnhTfC8AZFqSHSsxJWJyW032/
         7DXgAt9UsQ+6Q5WkIuQ6Tfz4/KtDxS1U2ZokulOOG1icODjqBUWebkXwSEorb4NXpqW7
         F9y+nfHdiJkNVNG1c/2oSudA9kvjM3KEy7XqY9XxZWGXqf1ds1njYx4QkEKcYgP46AkQ
         8SRHRM9nv+n1ZSW/EPnRqvUYHGgNTlox5wh/D3bv1vy24T3BhtQuzTubk1H9ayECwgY0
         KpEkj9ObVkGWdZh7riaRw1N8KGyAmRqD7sF87pBKvYgLjWNcWnCXbG6tTWObCiPnZINz
         dcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9EOk9ML3QymO+7AP9Ik4Vw5QK2CEjcwXieVVsvyZ/08VIdVsrPVAyZ611P1+Pww2d19g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZMJ0+HpZ6HI2TM+ygHGa6/wdd7PTwQLZadz0H7tH25VYj23L
	h6dFtA4ypkn7ApmmE8LuoJmP6ICBhS9gqYp4fXuAbGMvwpvp+A1Yn3n1xwgUyn5h
X-Gm-Gg: AZuq6aJbEs1rpjVbSCx3uFYERR4S14WvZ2QJ1STlFxLC+SXLmNSLI8gUOnQ0g1uEwsu
	8FW4oPLVHMOtLzWJgbB5UAxi4y+87LeTHSpFr3m/r4WVcq73X0o39AXmHbkYteGnxKw2lhYagll
	qe+v2W6oVSWynxKCN+OA8llx7yxpNCCnWk2WQ5QbDCK0TaDDdIEOsoy+S4wwLEKLBMmCXAv2E1w
	VydUjrxtJxAgMhBAyuIjZdhPnuW80Fy3O/FrBv7js09CbiAuDPbMWEMeWJRQZ2Vm5PiVN/b7SCB
	41r0TqTsHKk+5kG2bUwoh7FB/dMMo32pcyLWAchDfAc9Ijvtvn1B18WzdcG9y/zw+nJZJjjNWFo
	kO0OUp8KeYbFNljpKNCh00QyhWB6oSF8+3z47Fr8m5Cua0OyXZYJiuBD1Kmsod/NivAGu5eW2q9
	9YEEpHprGFr0hwhRdQS0o8qGGpmziyS4rs
X-Received: by 2002:a05:600c:1549:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-48398adc614mr119005e9.24.1771366007937;
        Tue, 17 Feb 2026 14:06:47 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm596556105e9.3.2026.02.17.14.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:06:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:06:37 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 12/12] selftests/bpf: Add tracing multi benchmark
 test
Message-ID: <aZTmbRPKvjqyeI7M@krava>
References: <20260203093819.2105105-13-jolsa@kernel.org>
 <9de646e4e4d2fda0d4f0543b422439f7c1fcc121d4db2e38a28bf3a454b96d98@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de646e4e4d2fda0d4f0543b422439f7c1fcc121d4db2e38a28bf3a454b96d98@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:13:57AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > index 3ccf0d4ed..575454e31 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > @@ -6,6 +6,9 @@
> >  #include <bpf/btf.h>
> >  #include <linux/btf.h>
> >  #include <search.h>
> > +#include <bpf/btf.h>
> > +#include <linux/btf.h>
> > +#include <search.h>
> 
> These three includes are duplicates of the lines immediately above them.
> Were they added by mistake?
> 
> [ ... ]
> 
> > +	t = btf__type_by_id(btf, proto->type);
> > +        while (t && btf_type_is_modifier(t))
> > +		t = btf__type_by_id(btf, t->type);
> 
> The while line uses spaces for indentation instead of a tab.

yes, will fix, thnx

jirka
