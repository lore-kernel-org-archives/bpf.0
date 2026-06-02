Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30D392C47
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379236; cv=none; b=bYaLY6oOa/vWST7WmPcFWCXzxafNHwukqYaZ6lY4n/Bd68ghKMjPgDekl3cdvSvucNrRAEJ11rg2JwZpYssWmz6Zq50oS7HDdT8n9oHIB5AKIk8P/Dh4nFOCEuSu+PTkA4xbXfDUYe3r9f34AMTw1Wxl+Pxa+01fsitWdTEXFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379236; c=relaxed/simple;
	bh=gt4DXyUMK+4E/fE2Ex3K88HkST93/FqQaubscf4ycQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0oGAhXCYBs7dSxx1/1eYZO8ALylDQVBfFLXsXyftNk1hmx43/bjO94sfoJ11rE2xPbQngvvi7gAwHrC/MwoK5buWhKQnIixLujTai7VhiXBuoXIrH/g61n6onSLjb3FlgtwZ0CL20sgV1wRIhLjA1kB/N33LB3foZUlllQo4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=foYU2uFe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="foYU2uFe"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so1919218a12.3
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780379233; x=1780984033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI3N+hg4XqY5ZLMNbq1e38j35o45dSTupckxs1bB1Cg=;
        b=foYU2uFepYyGOM+zT3zzXvXlMNT3T1X2BeLfQrMF/02n7fhufme1fN68hkNfVoybZ4
         jghWzsWDunEOGTfQcIS4adzC7ZJnJ+/3qFJgAaHwMkmeyvRkoxuZ11Q8xYznOvPQ3JTL
         SYcyEdaEY1hooy5zb/Ln02Xug/+Vos6KSsHPs8VAkhwGzxeyk7vehDPUSWijhZEBjZTl
         Up2ik+VXd0ymLooae/P/IvRmezQ7iw6t9Od+Vf4+W94BfSZOh30iW87Ob1URxtQemtj4
         k+H9QuiY72k5txgXU1WsPLZSBVk1/Pfr6mFhD+6jvEjBaLutG1R5xtDDXOprImu+QgNo
         Nt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780379233; x=1780984033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI3N+hg4XqY5ZLMNbq1e38j35o45dSTupckxs1bB1Cg=;
        b=HUDVUFag+LDVGwCJMcns+Bb5iB07v9veV0xIf5Ig/2DrgwCvR3B/Sktud/adlZb0GO
         FfC7ewqPdXnRqoI467kDfks+jELu3smsajs+Rh0k2ieBGKK4jLLMDStd6wy8VMMA5m0g
         wKFsikW6IAHbUAHmByWgbNgDjMy91t0kkMyWfjcSIVzswZnw0RGUoSMsS5Hno2iRWiNa
         sSWOMM3iBkUT68eilQzbSjmlemu2/irph8AfVsn/GO8B2HF5w58+NVrXSFWjTd1+FAG4
         lVuGkDIvz++/DNPT5spNJ4O4pPhlr+D1v18O9pxIm+4NB4+CAIHhgwzS/pcDZG9oc9RV
         FA+g==
X-Forwarded-Encrypted: i=1; AFNElJ+6JSqGzUzG/9BLgKwUUGThnP/AAGhqBxE/Gt7vETSABjsOwyRVCWMLvngEc5HUq7TSYoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXndWcXiy5wSocmW0/bVHt6nz6Hv+SaF197NgvUJeteapEUJL
	g1C/AiiSz7dyLywufnxVPFHy/GDOWPnTCZ5Jn8l6/3dP61Ycryafx4Yd+gX42yckg4U=
X-Gm-Gg: Acq92OHKAzTEg+zbOpBTTcuSqc2C6EsXvpilzky7T5TFK1T/18PMmRQRYQiomTxVekX
	jzJTZxfGrtIl9ivCJ+lBC92UIBCD2OVz57WYHHaft0GQOIszy6KbvZa8W3L4lh6eCtolcYOnZfG
	55JLITxw8V3X8ZCESsNa1gk9yH0E2rwWj963Korpa8TQjz4kEscK/SuBF2fNqDofwZRxApn7w+c
	nWFIuLVsP8952cTdjwZZ/Y+r/Cdav9LDOJjKI1r+4eGu9u1jt91QQZ+CdMpoB34LkNgoL6goCyY
	el734iA2Q5duqARSzQznQQcz0iNEuCqViCHpeBNlNqFoy7YwpYl4DViOUcQC1FFErF18rP3Yrp4
	0wm4xHdmbphOKDlv44DfNV9aXfn/KntkLhllRHkJNo98wiOzdy7irkrXvK3spK7O7kuxH++jVIi
	gBu5ZJ2id0DvvEW58UQZT/wYi0DdevVc6wNrkLcE6U1G2fWHTKrm9q4g==
X-Received: by 2002:a17:907:9282:b0:bd4:6da5:d5b2 with SMTP id a640c23a62f3a-beab0dd8aecmr706227266b.1.1780379233570;
        Mon, 01 Jun 2026 22:47:13 -0700 (PDT)
Received: from u94a (27-240-75-84.adsl.fetnet.net. [27.240.75.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd9877d85sm1381496a91.14.2026.06.01.22.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:47:12 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:47:01 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>, eddyz87@gmail.com
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, tamird@kernel.org
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <ah5pf25fhVH9WuU-@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601180400.1381736-1-jt26wzz@gmail.com>

Hi Zhenzhong,

Thanks for looking at the stable kernel branch!

Since this patchset is intended for stable 6.1 I'd suggest to also
include stable@vger.kernel.org even if this is an RFC (and ideally with
'PATCH stable ...' as subject prefix, but that's just minor), so that
the stable team is aware.

On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> Hi BPF maintainers,
> 
> This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
> The series is intended to fix a verifier state-pruning issue where an
> impossible scalar path can be kept while the real success path is pruned.
> 
> This is a verifier scalar range-tracking issue, not a helper-specific
> issue.
> The visible failure is that the verifier can prune the real success
> continuation, which should not be skipped, and keep only an impossible one.
...

This sounds somewhat similar to the issue fixed in "backport of iterator
and callback handling fixes" for stable 6.6[1] by @Eduard. Could you try
to test on the latest stable 6.6.y as well at see if you can reproduce
the issue there?

Also per stable policy[2] we have backport the patches in the series to
6.6 first if we want it in 6.1 anyway.

  When using option 2 or 3 you can ask for your change to be included in specific
  stable series. When doing so, ensure the fix or an equivalent is applicable,
  submitted, or already present in all newer stable trees still supported. This is
  meant to prevent regressions that users might later encounter on updating...

Cheers,
Shung-Hsi Yu

1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
