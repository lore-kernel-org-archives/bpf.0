Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F1416D04
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010614; cv=none; b=afez08pmknPnOYPPJHPlrNIxeKcjWuCT4W/BNCEWlaP94n5+6EYbku/BvCzea3w6BGfJ4B6TPuYBQlV2KF2nF0aod0SlZRM9k+RST9p78cXOcNWasRg7h1XGyt95zEw/Jg5CfUGSX+eKwYYQiylOGmEoWGH0CIMPMc2+ZGeRhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010614; c=relaxed/simple;
	bh=6z03W7Morm7yWrmKypG3Vnw+d4q2fK9rQhoU8AF66fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ajHHeYx23xKAQFtWgJLpPiqPRBbN1fYpt6iMlF0RHvslBSwWDk05djDyWmt7Mwn3KjWOkyqXFpdwAVAduikZIQqq3fn2dJBXCe6XG62Hw6kcTt5U/oPAF8ZqO9qHqTeTuEE2xjwee2bEo8lz7EAv2frYffkeGJr/6t077cuOisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieRh3JEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieRh3JEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299691F00893;
	Tue,  9 Jun 2026 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781010613;
	bh=ZcwlnJ9t48qgCfyHqiEqK44CPvWScQG1kyGGhVVgHC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieRh3JEMME2fl+vV37NlTJyw8MUnoGkmMZs22Mtjbke7GYb0G7oKM+qXYduV7DCPk
	 LEf0kPFxmbLYDVqIruFJugI9Hv2E0iyj6On6J/2ZZHePqRCHWjxNCHdx3Azt4AgySW
	 WuS3riiZWZgJ/4BrizB7Rq8QH8E61O5TY0gy/aNm1zSqAaHl+hKYYKmboAtwYj5+NS
	 I/S1VnVmBBlsaAzzt1vf3YYduMn2nBLGSKsJU7bmncBn167f/nplF/bT4YwBp+cb6L
	 IZ4yuP426JJZapyOdEXymz2U/jItIqlKQQjV0FkuYUMJE1xy4YGOBKJdik3j1BSaQB
	 u2+dhz9G7mHnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 4/4] selftests/xsk: Introduce mmap_size in
 umem struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608130938.958793-5-tushar.vyavahare@intel.com>
References: <20260608130938.958793-5-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 13:10:12 +0000
Message-Id: <20260609131013.299691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional `pthread_join` in the single-thread path can cause=
 the test suite to hang indefinitely due to a deadlock with an unsafe signa=
l handler.
--

commit 2b44f1770c5b4b9bb0b75f25f4cfb408f2d008dd
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>
Subject: selftests/xsk: Introduce mmap_size in umem struct

This commit stores the final mapping length in xsk_umem_info as mmap_size w=
hen
the UMEM mapping is created, and uses that value during teardown. It also
joins the RX worker thread before cleanup in the single-thread path.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 17a467a7dd7f6..72875071d4f12 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -1857,8 +1856,7 @@ static int __testapp_validate_traffic(struct test_s=
pec *test, struct ifobject *i
> =20
>  	if (!ifobj2)
>  		pthread_kill(t0, SIGUSR1);
> -	else
> -		pthread_join(t0, NULL);
> +	pthread_join(t0, NULL);

[Severity: Medium]
Will this unconditional pthread_join() cause the test suite to hang
indefinitely if the worker thread self-deadlocks?

The worker thread t0 is terminated by sending SIGUSR1 asynchronously, which=
 is
caught by handler():

tools/testing/selftests/bpf/prog_tests/test_xsk.c:handler() {
	pthread_exit(NULL);
}

Since pthread_exit() is not async-signal-safe, if the signal interrupts the
worker thread while it holds an internal libc lock (such as during memory
allocation or mutex acquisition), pthread_exit() can self-deadlock when
attempting to acquire the same lock during thread-local teardown.

Before this patch, the deadlocked thread was leaked but did not block the m=
ain
test thread. By adding an unconditional pthread_join(t0, NULL) here, won't =
the
main thread now block forever waiting for the deadlocked thread, causing the
entire test suite to hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608130938.9587=
93-1-tushar.vyavahare@intel.com?part=3D4
