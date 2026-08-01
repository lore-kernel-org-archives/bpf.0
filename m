Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37A3793DE
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577500; cv=pass; b=gM4qSgcuk+RjSVA/PXPJtMwcPAm7wBsnbmxxAqkXMNP+Y0ZK3xtXfW4R/vbAZPK1xAS5MaE86anCUTrCjiPmObDB/LTxW0W70RRC7u9QT9Ptsobnt1rlprQ+NubYB+8QnxMH0FxnVnePexmbxjzy/LuxvW7I0mv9IcU2DAHWN/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577500; c=relaxed/simple;
	bh=+8T3x6BTgIdAaarTuQS+9WrA0w1pBOk6DXEebwZZ/y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExW78/JzS6B9Sk4kcHsWWDk3Gk+96NSSwNgFhxWbqrhIZQamR4JeDYd0iFdbX6dVJwEo9MZdI8VE1VvQiiGr5AYwErcKcLvRqvECBMJoBVEnUzWaWMwNy+2PNki032d9e3s8e6JOD9KmgfXefaaT9QEKbDJ+IYoKH8DCDrw+LDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=ZkqxCZrC; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="ZkqxCZrC"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bfaa014978so831064e0c.3
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 02:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785577497; cv=none;
        d=google.com; s=arc-20260327;
        b=BMJ0sJtkW0VbLx0jVJw/shKI2bKBNjaf2qXoYICxt0kKQChTLfMYLrqF3ybxYKXb2t
         FkW3pf5GblEG4jyec5HjVarrHROxkazjXQEIKgnGmVLV234qgS/J1n7O6gF234mCI/X3
         nD6vLAGCXgbrRb3NiDBMU5MJmwwZ5KzoyEJoSxvG47zeLASvyusZ9QAmFCayvprfPZOT
         +dowueTEuE+Plwf+j9IO3CfjY3hSkJxhG97ipkisoEsxfImHxn16LkNDSe3BKmX309gf
         Ul1p4htUcLmvuU3x6xL1j8/7NiHU/iKwdiEyz98xcX/fwiLHD4+8+hVtTlrDdTz1v7EG
         LufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+8T3x6BTgIdAaarTuQS+9WrA0w1pBOk6DXEebwZZ/y8=;
        fh=MYsHdBGttvDePHrNP1u7cU34ccyKKdhpkJZfOHC5QqM=;
        b=GacR4J3BN3zNJ1GSKW1em2YJPFZ23mWmR4W5LwBWfxzubaNhjpkdrvLLR0GFkRPtyJ
         L6e0lHkhHhMqqi1cPwPz1CLbsdMa4nzNphJvzh3UV3IzsfeWmKzrPVMuMmWjLcGZWhFO
         rGcJ1Xue4dXy0A7Z3iAnOBrqjvCMZ/dt4/SGpGpq3D6NQDkOOayDJol2XkGQumdDE+Dz
         M70/N1dYWbi9fY0SSi/qrapNHuNIELBLDhOvHxoX5bpmWaMOLRss5B9W7KXFcX6Xwf5P
         EnDXcun4H6cycae1x05hj1LGROQ/n/da5I5wTZ3UqJobzAAv8oFJVCQyyyOfHteakgRS
         QVMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1785577497; x=1786182297; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8T3x6BTgIdAaarTuQS+9WrA0w1pBOk6DXEebwZZ/y8=;
        b=ZkqxCZrCW8CLOm1gLO9RqcOQhVJ37cU7GbI/7EgTXtPb/Zg7NB0nI3sOVEcLey3gyz
         GT+iMQwKgwsOH4Ajd8QtSSsXbHgMOqQS6D28N+ykBAWiMVNGpsGHNJXklb/VgwqXUkbM
         qWMIyiNvhs7InDxV0fcC6/UcnlyRqy1tiMNR809VQ+h716Qm036c7GrWaI53vw1JgduR
         +RpbWk7uzUiArxY49qNFwtUWcC8D+9/WLvCj9l1MGsBT/xTo8VqG61e08Bx6tzyRC2MQ
         MUBNsrXlDXw/Rai3Pb+WxOPjab/2i9wpKINySe4vW+T6UIS7NJxX1uD0WCnRiNiET147
         23Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785577497; x=1786182297;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+8T3x6BTgIdAaarTuQS+9WrA0w1pBOk6DXEebwZZ/y8=;
        b=aFcdiqAyCeC5YcowU3mzn2l499O13rAQ9XPNlEPLmry8jr5KVm/rR3yWRm1hHApI1f
         X4JB7FwcE9LfYL7MphGeEbBrecZYNIJXbCs+9LaS4NHOkwDwIJjRcgKrBig876nKsIdk
         FLirwDhWta27M0FdvkaS56W9YQg5awYdxhKLeqzgsBvDcS5G8sAenE7QX9NpqbjhuWkA
         PL+bWDIeTdmDCucqp/H+Jr5hxgpQUefpYOm2wAAeGZ2QsbqivP9rxULvbvXr7RpjmyuP
         uu/jDX8Kn78McvOW00QuGVvnFsGA40itwUSLcSlI7u/j/QGfZCRWBB9724xC80sjATkf
         B24w==
X-Forwarded-Encrypted: i=1; AHgh+RoCNIOVgemhplLjnG9S7A5PTp5faZUX51Tpwc86RGUqO6kQPxqBE0pVHDNCf6C69HRJ9/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kiRyv7I35Y7CBfwscy+swf2lMqDvx/3ww+uuL1ZFboiMCtMZ
	m83etJDr4JO3xw9zXwa+HKSa9rE1vQogJz4B5DgmC3ISUmNgC1u4biVjudmWiT/j4fBbtEBpde6
	sQZQAE/R11Q9i+QJSptD8Nv37Mj2GT+/VLLqwHh6xKg==
X-Gm-Gg: AR+sD13s9iO+bki2mQVmr/jXuXEHtd/3LB6gMe3TT+zPy39DJt18FCMSOknDu0ShMH8
	eUp3/8p8NtTEkz57soaULipeEQWjYzgHvKUtWVKiL7hELpVTE5Vfrd0WpIVBh0qAnmQdFmYFi8o
	oEBgGmcke1kf2uQ39Wo7rccSB3eiWGoE+Aey5QYfG9RDdJsXe7SCrDJeGKWDCFMxwVMM/JOHegp
	94D9Dd1QCPDCj+5y2N43cTOInN0blk0N2B6jhimSBcsLpyJ6yYJJnsxcfRHif+Zr5jr5HDfe6IH
	/PXNfPqJavIWRl/L/xucz+L90S3mQd3GUcoun8ObVTU=
X-Received: by 2002:a05:6102:e0f:b0:74a:b1ee:e034 with SMTP id
 ada2fe7eead31-75b223602a6mr2689929137.8.1785577497619; Sat, 01 Aug 2026
 02:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729162931.2369353-1-main.kalliope@gmail.com>
 <20260729162931.2369353-3-main.kalliope@gmail.com> <CAM1=_QS79dDBfaaNQXnWd61AqHd1M4o9aDMMiftnoJveNr=FZg@mail.gmail.com>
 <CAJZwKkgXoHhaej_hkBfytY_6N0PdpwfGMt+GUcHJGyaH0+e7RA@mail.gmail.com>
In-Reply-To: <CAJZwKkgXoHhaej_hkBfytY_6N0PdpwfGMt+GUcHJGyaH0+e7RA@mail.gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Sat, 1 Aug 2026 11:44:45 +0200
X-Gm-Features: AUfX_mzaM7ZKuNLIM5NDcwTn1wPXRR6WpbSUQa-TuJLiyYJnFzRMKLFC3IL_-jc
Message-ID: <CAM1=_QQ7XiJEozaetLt_+kVn91YAXWpJK_pyfT9=paXseW=wwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, mips: Add support for BPF_SDIV and BPF_SMOD
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, paulburton@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	philmd@oss.qualcomm.com, visitorckw@gmail.com, bpf@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicholas,

Thanks for putting in the work on this.

> I'm working on separate MOVSX and MEMSX patches. Would you be willing to
> take BSWAP and JMP32_JA?

Yes. I think BSWAP and JMP32_JA will be independent of the SDIV/SMOD
and MOVSX/MEMSX handling, so we can work in parallel on this.

> I'll pass the raw s16 off value through immediate validation and
> register emission, and interpret off == 1 only in DIV/MOD-specific paths.
> That leaves MOVSX free to interpret off as its source width.

Great.

> I will validate each series boundary on MIPS32r2, MIPS64r2, MIPS32r6, and
> MIPS64r6, and build the complete v3 together with the MOVSX and MEMSX
> candidates before posting it.

Good. I also have a QEMU test setup that I will use for verification:
mips32, mips32r2, mips32r6 and mips64 (pre-R6), both big and little
endian.

> Does that sound ok?

Yes, sounds like a good plan.

Thanks,
Johan
