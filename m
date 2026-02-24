Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF433890B
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967680; cv=none; b=ssMBouhjuWLIJuSlPbOgvr24JoAnqPRI7nRcgQulQsvWSiccs+Vw7cN7HHljFvlCn7huG2aSo5M93x/ntrBPJ0SGyhzd3r8nTx6gVnvMtaJyAQmVkf/lnOfqnwt45MkC/9HddigE3rbFi43Ee8B7wLLOjekJvqi1ZZkaQLoISwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967680; c=relaxed/simple;
	bh=EXhvgjk4xEFKTK69P1B1IgrdQAeAt1tuYgejvjcjOE4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OZHEusVpCSyNZREtNPSg/3AkWlmrk/vH3DM1Ry2ohYqiqfuA78pN0nd2tl0Y8Oaaai6QnGIrO4L4YQhMY9dbFtKNUs8mK4TgFZAyNSZXlig3rcMnFwrv64sSHt/pthaE37YyRPQR8N+N9AcGhqy8ranonXnJAMEqW0lB+ePnHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=yHRE98Hb; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="yHRE98Hb"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8954c9daaeaso75500116d6.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771967677; x=1772572477; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReWqXBkr0wcQ5bXYL7lZRX/FkOW7kepJ3tJ7RY4EvGQ=;
        b=yHRE98Hbhn9ccrn7cR3kR71mdqbR20ioVnNqVrfN7PxIuTDw97Bnahau6yXpTn7mLi
         QCYzTJVJ88zRLchSpI2rXLkdhhnKUbPm+ragv4QG3R43ngXPxgMSvBjnzML6qU2I1wrq
         I3vlDza/Dj9QHKBCRMF48/JHIRaemsuKCRCC0tYWpVVGGejBhLZA36JdjAc57bqnKBPd
         a7xhwQf9mTIltKZCwFT/h5cRcuqIWKvw9dz5tJh1cdzqUATuGkCqJmFR4sYvd3btSydM
         NAOQEaLACbTDAPHf8+7XelRLicfenMnluq0O9xcOb9znfCV/M0JUoVnWGVhyy8L0t1yg
         C/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771967677; x=1772572477;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReWqXBkr0wcQ5bXYL7lZRX/FkOW7kepJ3tJ7RY4EvGQ=;
        b=fQ8jcsGYIxs3XYb5Tc8SC/hFinFIzPJPGdX0n76PWEEJjaxiZM9t2rwb52fxggJQip
         dFkGmmgjoKfb/xpfAbJymvBiFBebWJFku+CZFHreKtSC8y/sy0MI0R+SL2yAmRZOW2Fy
         K2JxaGRP9AWOuQpuQlc6zTSizHKnc2F3L34UhdUBqxypADPQxOMIWi/OE3fDVjzFcXOz
         tgNtZweBhGO5vxe4jaEOBjrZq5hkG2rDyj1ndLv9w5f7IF4P0YvsSO6KlFTsF1H1mKhw
         n9AoTbTG3F/g9u2Pq1O0t/FqTxj4e3CqShRQMaK9aO/2jf3K4fd2g/u2s0lLNm3viGd+
         JkQw==
X-Forwarded-Encrypted: i=1; AJvYcCVhcfGK1UIYW4WRHWCiVt5iQz1k8fJ7q1N9g7PFkvlSorw5GMwqOERf17yxRhrdlXYiKxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4HJGhuwuYqdLfqcvRt9+hx5e2tCKhCJR7H4nOvLqHsH2rBC+
	xf/tFpwC2mwr8owU5BOuEVwJl5+L1lJyuCErWcNfVCHrDAhO3KkUX9cLxEgrJqK4VxX3Fp0Dby1
	ZLZ595SA=
X-Gm-Gg: ATEYQzwndZG7FXUXYzudmfLmFdnO3jjVRsd8S/IpQ3iU9tal3NUhPwRserrrYCYRpE+
	ZNI3j2BjytL8UC74/+1pPKYhzbvoOjObewhAp9oJEoTq6J4imbqu9WBG8xMMFYLmcaeDhtgWysV
	+sLRuem4MWs169lmScCUVTln6ZlFKztuJZh5vL8PjFMfu4zzYg5WBEl7k+ESECN1A18l7QLQXDr
	Qa4LilsXu4905zEuBSp6oZdvG+UO4KjByzG8nPjpUAG6bN9IPhG/F9/ZTPtGG5D1t6DeGaB5iES
	/GTyeFjstIn78fo9ut42Xfy7VaI+GFVbwGz4GIkWb2N7pTeM7zSmajZSJjgs87Z7pqAzqd16DAr
	ZWrB+XIAT9ftAujx5ETYk6Ve5ZIrFw4ksC5k8oX8czPi+OYVDGO8aD3IzONr8xJdo476omS2s9c
	1io5Ah0CRH8Hu8JC7d9By+BjU=
X-Received: by 2002:a05:6214:da1:b0:888:89fd:a720 with SMTP id 6a1803df08f44-89979e31e5fmr192964436d6.11.1771967676867;
        Tue, 24 Feb 2026 13:14:36 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb04csm1224468785a.25.2026.02.24.13.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 13:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 16:14:35 -0500
Message-Id: <DGNI488GTNDF.10SWXYT5VSWVV@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Amery
 Hung" <ameryhung@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>, <bpf@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix flakiness of
 task_local_storage/sys_enter_exit
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260224211202.214325-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260224211202.214325-1-ihor.solodrai@linux.dev>

On Tue Feb 24, 2026 at 4:12 PM EST, Ihor Solodrai wrote:
> The test_sys_enter_exit test was setting target_pid before attaching
> the BPF programs, which causes syscalls made during the attach phase
> to be counted. This is flaky because, apparently, there is no
> guarantee that both on_enter and on_exit will trigger during the
> attachment.
>
> Move the target_pid assignment to after task_local_storage__attach()
> so that only explicit sys_gettid() calls are counted.
>
> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
> Closes: https://github.com/kernel-patches/vmtest/issues/448
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>
> v1->v2: reset skel->bss->target_pid to 0 before asserts (Amery)
> v1: https://lore.kernel.org/bpf/20260224015855.1481707-1-ihor.solodrai@li=
nux.dev/
>
> ---
>  .../bpf/prog_tests/task_local_storage.c          | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 7bee33797c71..1b26c12f255a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -25,24 +25,30 @@
>  static void test_sys_enter_exit(void)
>  {
>  	struct task_local_storage *skel;
> +	pid_t pid =3D sys_gettid();
>  	int err;
> =20
>  	skel =3D task_local_storage__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>  		return;
> =20
> -	skel->bss->target_pid =3D sys_gettid();
> -
>  	err =3D task_local_storage__attach(skel);
>  	if (!ASSERT_OK(err, "skel_attach"))
>  		goto out;
> =20
> +	/* Set target_pid after attach so that syscalls made during
> +	 * attach are not counted.
> +	 */
> +	skel->bss->target_pid =3D pid;
> +
>  	sys_gettid();
>  	sys_gettid();
> =20
> -	/* 3x syscalls: 1x attach and 2x gettid */
> -	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
> -	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
> +	skel->bss->target_pid =3D 0;
> +
> +	/* 2x gettid syscalls */
> +	ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
> +	ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
>  	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
>  out:
>  	task_local_storage__destroy(skel);

