Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879603E5EF4
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407264; cv=none; b=UXUQP342p+UHssIoulCcUemhpoL3gZo7PW79/A5EioX0ez+x46oo4U6vBufXCFZ/DFKndKkve/ESWYcixxP9cufqcHnupk6DeX2EeQnUKZV41+Unc/x9EG7WFHG0STfxNtYUy4dwMptAdDpy1n5qvj2bbWpd00spUR+S/fjW5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407264; c=relaxed/simple;
	bh=kBnX/+0c7ITyMO0P3knR00sfYCRT+0BHh1YQn7jrn64=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=DgK2HFmBNe/KOqC37ahtjEfUWA7eg+1qNDszDgFlQttUWRsagPa2zD/EVylY+JE8sfdwRb3Xol/LxvYBJ/PekBykxiqmVjZHE0UGu7+fXcXJEjiUfYmsQIxp86S/jlxSp+caqudvajrdcAdTGIyJVIRefkIa1TyUzTRrn2au1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fY0WgkbR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fY0WgkbR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49068493267so65810445e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780407262; x=1781012062; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM9eMUk/jCkJgL/kA3ALW8afdDw3W85juVsOkTKRsaM=;
        b=fY0WgkbR6mkHahbU5G1lBdwUcnuXXa+x22HRpQwKdZJ47LbSVw0FFARCi9F5PXuwQp
         OEKdC/FvlXzcVjluIaaBlIJ2VW7jNjvMVdOCRHTy+vN4QWxQsLIeliUlV8xoq8ll1gqy
         u0rGP1QzcPwUe+zsVHL6zfiz0WZ9vYUkh2pfzDMz/G4yg5tfO2yIy5A0QJfLnWs8GUre
         FePhuo0S/yoFlLXtuhWLKd+E4u4FwpXvvjD/8xnYRO0ZY461EJZ+rf98RBE9K5Fq3NUU
         zs7G5hQTzLe0RXBULuk9WXy7RNXQvXJIjSwHo5NPIGqDXDvEEOt4N3/iTI2tsnfhIBFQ
         Scvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407262; x=1781012062;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lM9eMUk/jCkJgL/kA3ALW8afdDw3W85juVsOkTKRsaM=;
        b=A327OsxGbj1IUAQWK66ELDzzXL65GxhrZq9FXoZyUZ1AJgt3YiWke0yWK8HjB8tsh7
         U29X67Qs5Fx+o8ZcCnzs7mHOHC7XgI57vFf6SyQjunnBOdsa5wCyRtUHSs0EszbNl8ZB
         As+iRnklHGbgwYfsOECb+k9KF2PoEG9abTXVv/Lfwy/scp4rzEheAYWwIA9JcA/UG0yj
         8ewhGdSUvxxkBUCJNnDh+zhEugZQLS0tZ+pBQC8K6icFaa6XBAFehSEm8YBLgd/IHC3l
         tHV6vz5RJxrDSvnATXkf9xHnqELuD3X/iO0Xyn+0hpsIsXBwV+4GxVa6YJY/VZAfJjox
         xaIQ==
X-Gm-Message-State: AOJu0YwDVSum0mfrNQRpyRNqVIbmvMqdTJjK1VymTHf5dBDLZWAK4wDh
	nW2WfjkhYrrHcMKO1f6kNmVCLfAxKkIqMe80Dv4p/x6GU8oYfO4pyr718quLBWvxGfs=
X-Gm-Gg: Acq92OFUPXZ6c18I6UG3j9dG6GVm0VkXnkfHk+LpHTKwsXzrgLVP/lBzjVvXSHOxYqT
	HkqBeMoWX9AcnjBrmip2M+UpkEaV2f9cDrqkL3lhrpvMlxFWQKiJuwm6dvgeOQJ4bFGLCZdpys8
	OqA2IBpIKpIbHMpKRaxRIL5UGZAztVmidAX5u4HF5EGkRVe/4rtU04WwPXUe3FkbHPrz68+qXw0
	UvqPBa88c2KcveeNlYhbej7uycruDA1eA5iKMdj8D8iniKKp4+o2MFbFzdBWHX0jkLG8eTfODkE
	SVWH6iie0DLhFf9Xq5PnvVC5s5IzlIFYNL6vUAgD9tT1fzXoSM/YADnsQMTFg1x1/J7G2H3m9EW
	keRBf6Ibuh9Tj7nCVSaoFf7vjf23lXhgQTbZDxZK184K+J3Uar4rtBsStsAZAZSOZxgZKl2TwVN
	VzZThaNX3/GJHD2Y7byeGv
X-Received: by 2002:a05:600d:640f:10b0:48f:f7cc:f6f5 with SMTP id 5b1f17b1804b1-490a2945b99mr208508155e9.31.1780407262005;
        Tue, 02 Jun 2026 06:34:22 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a9d27sm11444232eec.25.2026.06.02.06.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 10:34:18 -0300
Message-Id: <DIYLP74JLI7O.11GW15J2LC01Q@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH bpf-next RESEND v12 00/11] selftests/bpf: Tolerate
 partial builds across kernel configs
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, "Alan Maguire"
 <alan.maguire@oracle.com>
X-Mailer: aerc 0.21.0-146-g87073a0460e3
References: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>

On Tue Jun 2, 2026 at 10:02 AM -03, Ricardo B. Marli=C3=A8re wrote:
> Changes in v12:
> - Rebase from 11 to 8 commits: split the test_kmods KDIR patch into a
>   pure KDIR fix (no PERMISSIVE) and a separate tolerance patch; squash
>   the BPF_STRICT_BUILD toggle with its first PERMISSIVE user; squash
>   the four test_progs partial-build patches into one; move the install
>   fix to immediately follow the first PERMISSIVE user

And of course just as I sent I realized this was left behind by mistake.
This was scrapped and the series is still v11 :(

