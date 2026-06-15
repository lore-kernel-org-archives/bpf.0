Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D814071D6
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538508; cv=none; b=n2P3i5UZwhL/0QVCf1NHq+qb8QKcJTw9QQU8AGuWcx5cC05QcFLUFnPzyjtgyZe0hHGHw2SvSiV3o85fP29l66u2okzt8LvVMail27L7eshKPQ2G5Rub+JbSC4c4GomqcBLT6SlAY/fdxF2osKYr8lF2GFP/Yc7tbOxTixcmIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538508; c=relaxed/simple;
	bh=edS4wwWza3l3hBch2iES+eWpDKEJqliItDw+Mo2XuCw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JK/pxCXscQjtdKN+G9QOHbrSgnS2rtIl8FcnYNRUSs7JSLT1arKijLybRGpX1QxDhChulSGoX/W2KLPi9lX5f8TgI3UDSYR1sJgrmPc4A5MgnsH415FQidg9LuVMmXH5YV5UK5+AkLagAb8nD8QsNzRqQsLPPH8/g1UCBbjMwmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aD6TOtbx; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD6TOtbx"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e46524711so2355305eaf.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781538503; x=1782143303; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edS4wwWza3l3hBch2iES+eWpDKEJqliItDw+Mo2XuCw=;
        b=aD6TOtbxlyLcEuW2VSUUBjbs4fzAzxHeRfAtJhRX491BQuq/nxjlfqUaxonQsYee/f
         oaspwpKWytsIjDZ4zpqkXLRRVAGRTixIsuH1pyjNsUkgFAOQc5jyO7Hj4bcZVmV+Uobw
         AH4lgE9dSC4NVq6pndV4LQMEAnpniViEV0rOFdCGH4OttUgj2z/w5UBDF8PRO1eF7zAy
         fN3VroM78nfGi9wdhkvHZ98DxLTeV0Az956BwCz/Wx3PxR2MIyxKOIT5DmFajOYrZGH4
         Sahwx4QUFry4GyZbBBZM7Hjf1FQU5JoZsJoemnuRHdj1VhQ9MvfDFV68qW5YV4CDCgj7
         MeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538503; x=1782143303;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edS4wwWza3l3hBch2iES+eWpDKEJqliItDw+Mo2XuCw=;
        b=hi5v++i26A6OT2TkwPOkrAZfDIgg84CmLiGV9IZ816rUm5pNmNAcUe4vJhW3rRIs7/
         TztfJ/RrxFSu7nmouXQInknox+Fo7c3ptCKPL5AwffMuGTk/9OfTaoVdy/bf3XG+KBnd
         dRBcAywKG7FPwxkc1gOs0O9uA1AAjiTHjTQQNOsQmVQzzBM5Pn6IlA19uJze/5tcG/G/
         6LKMEnkb3ClG2Gx8KdOINVjTJcusIOR1g4gXy+xWJRRrcklOGLgZ9NZib4O1nmUyy+tq
         8DqkM0AMhpWGAcrJdTgKMllEM2RuE7oS+0qy6FMwnXK0EAGsinvnFP4HDvCLM04lDojQ
         f3iQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9N8yNIByTKJ72DtVnOhbC3yNELvkcMZvV94015umGmKMxJdymUKhbbqnVvYetTqBFf/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2PT2rWRz/o36K5THtwl9AxAXLHrMNrBlMyhcbc/zf4yTAilx
	qlNNB7my9y02IxbcKdf+1qrnmoVTbbGS2r8QotBksxf3/u6yN9eNndzp
X-Gm-Gg: Acq92OFSXyXAdpRSwLNxxntI89YDSvEhzpFAqA/QFyJ6NYBrcA+XItuB0WlkBCocPZ8
	Z4Wz3qr4NQeYICHlPqNXudkwgjSIiUmhUi8FH4hfxgcrJrJ0J5PkBna9pXvw6Ev05iijfHRN1CO
	e+69jKsnpJF075vrdDKfx1AErTu7QRkIG0FqaQ4s/7d8vpMPAngCrU7PGnUZTB5CxyaP+hd7mWQ
	k7AMCqhJJYqkCJodrb+bh1Tggp08Griu1VuuI81766uwW7rr2jG0M0iTqR2aZ/YqI38GPRum3VV
	9OHinEXR813gZ7RZkm8T5RFEdTz/aglTQPFlw4VfrvK+7m9nMgeEVzCXbnu/LP9Y/zI3hMDsaqI
	tpIAhbvVX2pwa6ND86K4arOO+xl06ZgOs0VyAEXPvBacb3l7tTRrMJETTpT7CC9h9MDXxU6lB1i
	UAWFUgdSzXazzfZTjZ6MA6BlpPnIU2pdPas2t2qr0pe53zSZYSnd4m/Gv75hbzIEAUH7UADwkUy
	nUiKAZ/Sgstlp3KZQJOjRVbKrQ=
X-Received: by 2002:a05:6820:c2c9:10b0:69e:df26:ad45 with SMTP id 006d021491bc7-69edf26ba9bmr5778694eaf.43.1781538502837;
        Mon, 15 Jun 2026 08:48:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00d5e926sm3286569eaf.8.2026.06.15.08.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 08:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 08:48:21 -0700
Message-Id: <DJ9QOWVIXFHR.1S8UL5H0USVCB@gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf: Gate dynptr probe-read kfuncs like helpers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Mykyta Yatsenko"
 <yatsenko@meta.com>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc
References: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn>

On Mon Jun 15, 2026 at 1:31 AM PDT, Nuoqi Gui wrote:
> The dynptr probe-read kfuncs are registered as common kfuncs. That lets a
> program with the generic kfunc privilege gate call
> bpf_probe_read_kernel_dynptr(), while the legacy bpf_probe_read_kernel()
> helper is exposed only with CAP_PERFMON and is blocked by kernel-read
> lockdown.

It's fine as-is. Won't fix.

pw-bot: cr
