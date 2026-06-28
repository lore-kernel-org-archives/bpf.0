Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1E23F417
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782628675; cv=none; b=uwc2PNXhxiAf6Fu5wRM75XzFR8ym34qWflwXX0wZl349AirLbvKD4gKNiMaGXod2k3gFHV87sR2eFJdFa1TSdY0rFOxQG7WpK01pr50ie0CmCsTSFnGKNslL7HR8Z7ufkYfIqYxVN9VQFm425F/G392iW6JZpOpaLs+2TcHE1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782628675; c=relaxed/simple;
	bh=qjynzZ6KOMkia6Kld8oKK1e11+mTHpxJS5f6P9dewpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG+M5urpaFCuMV46eGx7g0I2/DKb75e7V6AOPkhZoA5hpzOIVLMFE6sd8ZrfRf8JfKxa3B+31RiIGqvGlGtT8IcEL1fezSTTwEC5EqURrDkja27w8rCnCDf8hkzx6+RcJgxiLhi0Vrs18uQ8cD1Tbp6JB/QXvcwq4ThwyiPhhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS6i/OQ/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS6i/OQ/"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so1873948a91.1
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 23:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782628673; x=1783233473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XxbfFY4tow/cxVk3DBC5MbGr8rGt7hcXtDQR3cXybbg=;
        b=bS6i/OQ/FvNy4d3CNwFb2hAxCp1BFqnOLXSpKvJIOsAxLGWBbXZW4TsUqbhQy8lYbB
         U9QS6YpaU6UOLCzKPPyf5SHxWx8c+9QOvWMIu5P8zBcIvWLVgG3tcS0NXT9ZCdFOWrsO
         9GnLejjaoHVnya3nMMSwLiXI7BPd7hSDbCkcXYSLQU0QSozq5FWOEjt7kL8qv6xNsVNP
         4rSLXlbu9WWYrUnR6I5jWagE+bPGwNHOytg8fL9mAbVgJt9ssWcqzYOeZ84M8kXcQ6wk
         ot7O8PNFVoLp50crVLef6Jx/vUBzvVXd4F9KeyOfEZl+j9NsxFQyJCiNueX21XEGbOYn
         BIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782628673; x=1783233473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxbfFY4tow/cxVk3DBC5MbGr8rGt7hcXtDQR3cXybbg=;
        b=GDblMzVMi4LdP/DRJID3eBB2OYF533UyPMDSHRNw3QPblW7E0p8Ly+TjNqQHqLGJNv
         6iAzDLhGWc8VBLjc9WJjYf+ygMxOeZ+IJqoLLd9n5iW6rZLYQPILjpRuCc99gPGEsaoq
         DjVrc1tyAPADkmgDqVgn7+L8Bh0kU+etpizb7CMfDXre+X6EFhqGlDGHYbw9jUsQADvR
         rOFXKpmjv5sMUQB5jG42TwmUSOxjCNWAvcEJwP5coisWm82XCF2moGakQWOhxtr4wfea
         K90r+DkJzZ+knvFZG92ahi/E+L4PvbBLL5R8myEr5DqVjbsFSWFkj3sn+UNxp66XXFxA
         WXFg==
X-Forwarded-Encrypted: i=1; AHgh+Rr71aTXP7dBHSFVUsnDOzBVsM65JKmgkHZR6X8nYOnUTAA91lc5FY/ZcTgrX236wW4/Ewc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQId00CdnVW+M0nyry+8UUXLz6dJviwmpnswCRbCldSkZUiQI
	OUlQRonXPrec3EmfahkJ+Ib4bBg94lfD1sGgL3wfPcW5907WCsojF+JQ
X-Gm-Gg: AfdE7cnJIYlogdoK1769bYX+aVRTJJ16jr1kyzgfs5Jihzu2ML45bFk77vx4BunUsJQ
	Xd2oml8Iow1dPoecAr8OMM1EUM/bm5b8QiQfxW26Ps7buTTtGuMPGDWyZgsK7yldmw8wI/1EsBp
	b8AW0EidN41HSP2AMooOPUC9oxP8K1GOYaSNW7dhUVpw2fOUqI1Zz1rBk1FbA/NnI6zh8jOrICy
	5vDfpoAHis06Yo/6ZV7YCWSeLFLFSUAVTRlp7PcoMPf6my1r+wP/TfYOUkC7SFX3ZzvdyiVQ8j7
	ohBfit+51YxPaGgtkx5ORB7dFU0wmmgnE0iaH/qCr0Io8mxwgQOMK1oNooStfD/VlosLT8SWkm/
	hCuThTSQ+IyA/fuv0Siib1shCZS1OvG3AiHzUyXa0ZahWf7FY054SWecJpFwJPop+gJZnP24Qqf
	jvTzo9IISGFCZKFDTdhfuPDqtcSulMxT/P5WAZ9sA=
X-Received: by 2002:a17:902:e5c9:b0:2c9:97a7:327b with SMTP id d9443c01a7336-2c997a7337dmr51790045ad.44.1782628673499;
        Sat, 27 Jun 2026 23:37:53 -0700 (PDT)
Received: from computer ([2a09:bac5:3b4a:8aa::dd:15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f64cfdcbsm68156965ad.62.2026.06.27.23.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 23:37:53 -0700 (PDT)
Date: Sun, 28 Jun 2026 12:07:39 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, bjorn@kernel.org,
	alex@ghiti.fr, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	pulehui@huawei.com, puranjay@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/3] riscv, bpf: Add support for BPF exceptions
Message-ID: <akDBMx45h20In6EP@computer>
References: <20260621144259.288135-3-varunrmallya@gmail.com>
 <950216803ac2380e0537b27c94ff87dd2ae0dc689fe320c51d96b9095cefc614@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <950216803ac2380e0537b27c94ff87dd2ae0dc689fe320c51d96b9095cefc614@mail.kernel.org>

On Sun, Jun 21, 2026 at 03:32:32PM +0000, bot+bpf-ci@kernel.org wrote:
> 
> This isn't a bug, but could the kcfi preamble, fentry-nops loop, and
> TCC-init instruction be emitted once before the exception_boundary /
> exception_cb branch instead of being duplicated? The same three-part
> sequence appears again below in the non-exception path, and the two copies
> must stay byte-for-byte identical since the tail-call epilogue skip offset
> depends on this fixed layout.

Making this part common in the next version. Sensible change I missed.
- Varun
