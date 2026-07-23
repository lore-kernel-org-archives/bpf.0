Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755C379C32
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787885; cv=none; b=XqrfwEGBNDv5VOrm9rSj9lL8odFI9dACnELyqGOmKzaL9WieBhoao0sJ/ABDDNBCvH0cLV0OVGfs8d6x0IkVOICJ936XNi55DEAznpXZYpAv+veiC+xTpLCBHbY4Z7+gAbKdgbrZidxWDbrXvDrBpYU14gaQowf+1R1n5b13m/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787885; c=relaxed/simple;
	bh=HGDv0KovPBUwjRvzrg5QQiUWolpU3TUYfPfWB8s7egQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T3sGSoQCjR1MQFolV0kFFc8YN6TDxR2YN3WDeZB4c5o45IucRo7SX3Wb4Bh5ai8AwY9OWNulWQ57VRsTjx2RoaizRgmKyg5yd8e5NpqPyT1KcGqJn592Jepc5MaYHj0rCze7+pUFOO9NgfknYdNQbUcO8QwAwhozGULAR0+FkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7wEVHnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7wEVHnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D491B1F000E9;
	Thu, 23 Jul 2026 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787884;
	bh=ZgZQckaooPUYKO7FXKov0FIfCwCFn+DFOi1HIOWvQr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P7wEVHnnEbr4Vsx105y2efNorXKUPgKl7zqLZxZA07CmLZX0oLhrB0Rjjs3wpPYJC
	 695AzHl/N33vFAZpzgezOaq1lZEBo5HWAlWBifbx4wmEaDqfIU5lAgbGIsuhv88rDV
	 1hPRQuexXVBt+UeIaomN+p9yeZHICpbt8FZZ8eQ3sITW6tF9IhuDy3lxtJpqRxFsO5
	 vH+2xNWDQkreXVLZPBA97QmUmOSyh3McGfT8yS8DVlLWsUu+zCpGqRDsFtvWuDqRa3
	 6Lg3W4JMH6qecCxxZFTaNXGkwWZZJLCfQhG6fN+Os8xE2faqkEP7GOvSdgnt+JKt68
	 G+chng5MvrzFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Report the real error from
 libarena parallel workers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723061347.398591-1-jiayuan.chen@linux.dev>
References: <20260723061347.398591-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:24:43 +0000
Message-Id: <20260723062443.D491B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Skipping `-EINTR` completely causes interrupted tests to falsely=
 pass.
--

--- Patch [1]: [PATCH bpf-next v2] selftests/bpf: Report the real error fro=
m libarena parallel workers ---
commit a35a4526e56449664def8e15919986cc43126b84
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Report the real error from libarena parallel workers

This commit updates the error collection logic in the libarena parallel
tests to skip -EINTR. The goal is to ensure the real failure is reported
rather than losing it when another worker thread bails out early.

Link: https://github.com/kernel-patches/bpf/actions/runs/29867905253/job/88=
764463566
Link: https://github.com/kernel-patches/bpf/actions/runs/29878191901/job/88=
794845824

> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/te=
sting/selftests/bpf/prog_tests/libarena.c
> index df7e4b8dc3945..daade4150af66 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c

[ ... ]

> @@ -118,7 +119,22 @@ static int run_libarena_parallel_test_workers(struct=
 libarena *skel,
>  			continue;
>  		}
> =20
> -		err =3D err ?: (long)thread_ret;
> +		worker_err =3D (long)thread_ret;
> +
> +		/*
> +		 * A worker that bails out because another one already gave up
> +		 * reports -EINTR. It is collateral damage that carries no
> +		 * information, so skip it entirely: never let it become the
> +		 * reported error, and don't log it either.
> +		 */
> +		if (!worker_err || worker_err =3D=3D -EINTR)
> +			continue;
> +
> +		if (!err)
> +			err =3D worker_err;

[Severity: Medium]
If all worker threads return -EINTR due to a process-wide signal, such as a
global CI timeout or user SIGINT, does this loop leave err initialized to 0
and falsely report the test as passed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723061347.3985=
91-1-jiayuan.chen@linux.dev?part=3D1
