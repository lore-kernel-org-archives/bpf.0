Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129635DD1C
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837135; cv=none; b=d85TsLdI5WqPg6jfQGgN4DCb8RfmvUJ+MEmBNwx1mk96wMcWL2rNBIU/IWAt3IDA9CJwrHCvzAEsaw+6S1+WHswj1QcJWO+OtNTsi/TxzKx3Z3PrkJwbAPkXfdvBTGi72J83m5sWfuzS4VleV4tsWDFvi1pvuXn2s9Z5JXAxLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837135; c=relaxed/simple;
	bh=i6bEd552PhBO/1Xeb3RQMWVne64NiEeYfAApdFhY0jY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajfRnKW8KHUFi+rOKd5on9T2starJmwOvUDUrGjRQ6JQtxrBpJKdXvqgUj77GwnPo1PoeRjcqma7IQwODhLKhyXzWP+Bw/IHBPC5SM28sQpzuROBnuRR4yP+gT1tYfbIg95/B6xxKDZXuUb6AWOXb4TLBq8p0YzqdkysNph2uNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT8rgPha; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT8rgPha"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfb723793so1540512f8f.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837130; x=1776441930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krK2n62Fq+Z6Io+RFNDqG7AgBW6fbH9EutpWEaO54oU=;
        b=HT8rgPhafBlNNDaqdb78lnZpSZOI6nVs6Vj7c92dQa0Cb/z3XbWalGq8DGWX0l1GKL
         9nvjX/0QcrYroy3jKbFLFMesZzNFPNbqPTOh0vCxT9YbmX9KBWsKfRXmFLnGi+EKOEE7
         90TtIbck0jdfSulDRHW+iBD+QUhe4fA9zHEPVrgcPHJGtksaIw0d4gxpbyt5tQad3wZk
         z2BS5Z6oWUEhgLfeyrGryPU+mm9rsjnpelcuw3pJNSg0fcaEdK5SLtv8fNCqLjQ7U83W
         1/qZlWf9EytAZYCBzI3BBfAEvheT2adA7om/Qks2fRzDyh2lknGhu1VSsDU3dplezjQi
         ZSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837130; x=1776441930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krK2n62Fq+Z6Io+RFNDqG7AgBW6fbH9EutpWEaO54oU=;
        b=aJ07U6ZTxzzUwnTM3mmGy1kig/dYs7gdeWAMfZHMGKiTb7atVjtSuLWWBpifK/JIE5
         HwMsdxyhs7p2ADOSCG0SXlTlSoBx8KoFqddA9YHeEpZgngwkuK3F3b9rzsc8J+dzJnjM
         +VP/6sM+PlIbGSJMCqVSvn9URQWHNIuPP3R2739ISAvT23mYra7hZKOxSvGgsuARZPP4
         zT5R6PnsptKxfEXkkNCnV2lpFZRKfb6KX4eFJsyfoaCAtsQtT3uS6QgDkhzph7BUgry3
         KPYb+b3IHkoei6sH2J4z7cWxf0OYEkgJMXdk3UDECzKXSaTGWkkY9yHJYGnhXb1BAM6B
         t04w==
X-Forwarded-Encrypted: i=1; AJvYcCW3R5yc100GIpBkumgkyXsswt3Kg02hrT4Q+n2L7+IqI4NjeT/SzyM1VNLlqLZD65yFczo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPjq7zZR/aTcbwPMs8GZ9hrkzxhIAgg8qrI+RiMA42qpOA4Ow
	ihqtjQ+7NddnvHcJYejLui6EQXS/duGlFqFM50I8BEOBxlsNPbMNb9Rq
X-Gm-Gg: AeBDievSmMzE7yHzepiZ3K1lwoqa1Y0m7xTYQiHQD9vu7VR7FhxKzkZmcLVTqQe+rt7
	JSsIdRAITzI8ZDnkmlyVSxRdPAC3o1pecnLwwEsj/gRFEBy5MOkiSBinK0TT5olO/qe5dsvPhS7
	o3Helxav4UvgG23TPC7USvfY8RXfclACHOIy1pcqiK4YLjDxnIQ/wspr2d8+3AlEaxPIpcsoy6I
	cIls6/ABk0cjADBrpcotyP4Ef6BucxW/yiUNBsCAjOOtqtGX92KD4MeNgT6KYWToBxewLKNqJfd
	uBAYSHZsrm9PvqEHrQs8oSr1a1xUYCPZrVeNAxU+EDYGv5trYzK1xWdmhgMgvxCKQVAPMqOartX
	Dj4DyVWR0lIzgxilN0qOc8+5xjVu5xiwVZszLkHfOpfYOMZ/ekGbtzjaYWZezqrUshVemXhm7W5
	qTQxz1GF7k1lIfbQQ=
X-Received: by 2002:a05:6000:2886:b0:43b:4982:fc73 with SMTP id ffacd0b85a97d-43d642c77cemr5750110f8f.25.1775837130107;
        Fri, 10 Apr 2026 09:05:30 -0700 (PDT)
Received: from krava ([2a00:102a:403b:7d88:2732:ff4a:659f:a4ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e468c5sm8877076f8f.20.2026.04.10.09.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:05:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 10 Apr 2026 18:05:27 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 0/2] selftests/bpf: Test BTF sanitization
Message-ID: <adkfx0imgJ2mjtHM@krava>
References: <20260408165735.843763-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165735.843763-1-alan.maguire@oracle.com>

On Wed, Apr 08, 2026 at 05:57:33PM +0100, Alan Maguire wrote:
> Allow simulation of missing BPF features through provision of
> a synthetic feature cache set, and use this to simulate case
> where FEAT_BTF_LAYOUT is missing.  Ensure sanitization leaves us
> with expected BTF (layout info removed, layout header fields
> zeroed, strings data adjusted).
> 
> Specifying a feature cache with selected missing features will
> allow testing of other missing feature codepaths, but for now
> add BTF layout sanitization test only.
> 
> Changes since v2 [1]:
> 
> - change zfree() to free() since we immediately assign the
>   feat_cache (Jiri, patch 1)
> - "goto out" to avoid skeleton leak (Chengkaitao, patch 2)
> - just use kfree_skb__open() since we do not need to load
>   skeleton

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Changes since v1 [2]:
> 
> - renamed to bpf_object_set_feat_cache() (Andrii, patch 1)
> - remove __packed, relocate skeleton open/load, fix formatting
>   issues (Andrii, patch 2)
> 
> [1] https://lore.kernel.org/bpf/20260408105324.663280-1-alan.maguire@oracle.com/
> [2] https://lore.kernel.org/bpf/20260401164302.3844142-1-alan.maguire@oracle.com/
> 
> Alan Maguire (2):
>   libbpf: Allow use of feature cache for non-token cases
>   selftests/bpf: Add BTF sanitize test covering BTF layout
> 
>  tools/lib/bpf/libbpf.c                        | 12 ++-
>  tools/lib/bpf/libbpf_internal.h               |  3 +-
>  .../selftests/bpf/prog_tests/btf_sanitize.c   | 97 +++++++++++++++++++
>  3 files changed, 109 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> 
> -- 
> 2.39.3
> 
