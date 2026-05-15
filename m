Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A138D401
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848345; cv=none; b=QlMG/GmwtprdPVDVHJfN53eWkeB3tp40loPu7SwcfMErxY2doyPdraCpg8k4gf+3TgaaQooZaqvEEX4eLemt1sEF4eVmzUlyJ2RwuBtW6fjTCVs04xbRdxKENK8+QYE8dB9SYfNCiZEovYD8kwEFX3TVT4F32VZfTFnB+KAQgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848345; c=relaxed/simple;
	bh=Of7ZLPaq/6ravJ5G/ZeLrIyaLyCJZRNYT6/T2Q/LAFM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvRzCfl8zCncYp2E8M9V+xAGakMMHG1PMZRObO+nHJSlYPDdrUsiIauFeowG6BomPptFjxG0Rq3uKn5/OSYj9V0lFKvAekPSEs2I9RRmk5TpFvavgNvknkzx7EMycxT4Z5FCU9JAIh2SgqwWWLmOmLD3Qswi4Wj+oW9Vpa3M8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=API4J+HW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="API4J+HW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb05b1875so5412898f8f.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848342; x=1779453142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHm8mTrTqx/p4mqwv7bqPTURn4DDyo3QX4UkvLGKpYM=;
        b=API4J+HWHN0kCSmj4BVtukJ1RqNLrAOnIc7xu/c8V3nkyWglhVLph3GP+Y1xxOGYy3
         aD91Tm7Bij8LfULZvFt6ZRh9KJzgyrrlKE59K2L6/uBuyuiqRdDtBAEkwCSYCzM5PMEW
         ry8vWNdgQRbnrbG8XSTI5RK6Y6kv8YUkRHVCOIV+ig/neZiWSI77mI8wJMQx/TUcPKT0
         CaIfmvuc1F5/D7ZNXd29uWC633XRs1HtKCBUWIOdv+QOt6GF+ouYXfJlfXklbivbAWEr
         vEe7pNj5HXxMVJxB4xnH0bvEVYDNy2fGuaT6e79zi5TqetkaASaWHQbLiyPqC6y2uEkD
         ybog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848342; x=1779453142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHm8mTrTqx/p4mqwv7bqPTURn4DDyo3QX4UkvLGKpYM=;
        b=dA0s7CZgqRZosgfNN+LdEzU1ru0JpDR2FLZArPKngXotgyvOzRkkPF2rRjFurc4f31
         PwYAILP3giL+XBN/rxmMXNmmCI8uXw8PFq+2RjEt7WMClUFyqoR/z/KeVHat8OKVtPhD
         A/8CZo6tZSAkFMHULP/CPculHKIG2qMKkRoxd9hbJ8McJ42h0vwviQ+ooKbMQdMuAfzG
         4b0YA5y3oACwVZh3M2PK5KAB9Icv7XjmPQE6K673FCxqEurrQfEEGk6gHDeZJOMlghfT
         P2n9FpStk+T37y1Npb8TIsHrS1qiMFnGJvBSkvj9rXTZ9Lv8I6/+qeBcidTq02W1jkpo
         t9Og==
X-Forwarded-Encrypted: i=1; AFNElJ8UES19XReV0WIdpbHYWBDqLKqlGlihAcHao90aQHEILfalRlExfP7ocMZVFOAMUTj4J7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWaJlo1vsJa1YMP4C4cpqMpDJT7JdpajNikNSL94fPTGfxNy5
	0AAVB+NZAv/iCjKIjlYQe2Dv3aVgmXVE7ScY0WDwiBb39Smwqin/sAtLrn3jaeDB
X-Gm-Gg: Acq92OH/x3xZUUkdm34JUYBfQWQuVsc6KSCqDF8ez7Dq10swgmtBgCmtoKC6Kf1swKI
	TmKTWbavaxmU+6z5jLX6q5ptMGeDgQQ+bc4zhwGjq3Jp0LSqx3n1YUOdFmr2e7I0baYSzW1MQpL
	JXddmzF1CKXBgTn4MrI/PNdvYqLS6zEkQL6vQM/nKE50lwZ1/1mV4BLnITkQMaw8clvX4cgZdKT
	XcNh3HMTv25gGXmSpu+YHN3RmXZMhuUF7WSBVNyDDA2jgdd2KMgt3NGFWlKLUNiEv6eDIiljgJY
	z/5ILYCvbgxKnIMMk8GqaiZDMe+v3pQ1rJdqPeKPyaheIhGhzQtCUPpMFgKdnTaMCQKl6U12NPa
	r7uDMoNH811Si9uOM/oCndw+HzJYIP+6yc0buG0PydN0Q3tqTv93CNQp6EYJmaQ6nb7psRL3GWt
	KjpJnVL3kOgNI47M0=
X-Received: by 2002:a05:6000:2c0c:b0:44a:46bc:e5e2 with SMTP id ffacd0b85a97d-45e5c5b3980mr4763657f8f.9.1778848342307;
        Fri, 15 May 2026 05:32:22 -0700 (PDT)
Received: from krava ([2a00:102a:4039:3341:dfc:8dc0:b9c5:81b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm13524671f8f.26.2026.05.15.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:32:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 May 2026 14:32:18 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/7] libbpf: Change has_nop_combo to work on top of nop10
Message-ID: <agcSUowckidZEIr5@krava>
References: <20260514135342.22130-3-jolsa@kernel.org>
 <430564f1eb4e1fb284b40510811502671e4aa8ef59afadddd546e4286402f760@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430564f1eb4e1fb284b40510811502671e4aa8ef59afadddd546e4286402f760@mail.kernel.org>

On Thu, May 14, 2026 at 02:55:25PM +0000, bot+bpf-ci@kernel.org wrote:
> >     libbpf: Change has_nop_combo to work on top of nop10
> >
> >     We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> >     fixing has_nop_combo to reflect that.
> >
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> This looks like a bug fix for kernel/libbpf integration. Should this
> include:
> 
>   Fixes: 9734c3ac2f23 ("uprobes/x86: Move optimized uprobe from nop5 to nop10")

I think it should be this one:

  41a5c7df4466 libbpf: Add support to detect nop,nop5 instructions combo for usdt probe

jirka
