Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137E367B85
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196672; cv=none; b=Ve4tancxELN4opQuskSy3gkoBIRnbzzcnDW2xm74ObrRVaj+SNhBcDJ0iP4SekI8ZjgosWddjN/F22FgDx9ekqS/QrGuEG4YkKqEqHkG88DhhhRbYOxYQzveFltow5VCU2qgXkHmyELuDNbhYESIM7dS4D+sbtKLyGLJfVlKd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196672; c=relaxed/simple;
	bh=1NLcJ6GRNxlB1+tUNvOCbHhcChkzSgmvbI3BEcjdHPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTH60vTBg3Bn5g2BB3tyDhBq0jag7pDY7i1+tWlXLPsEkXYV1gVFORugdmrPRD1i6IUOfZYnPWJsM6qCwH3SUDT6c0rjoBXWTqX9YOjNL1WQa1cBV+JiDtc8ClgzcX/LORHQSQwyRzaER9eYABoUm762gYgIEZzN5kOGyX2VAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9zwBuoY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9zwBuoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EC01F00A3A;
	Sat,  8 Aug 2026 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786196671;
	bh=yAV+ORZoO8mL3x/laTKIZKwhnnT0mcXS8/TmoB+e3FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9zwBuoYtxP/oIFVPER2oVFyVTwE4hYnAvGGeS6XUSmlBMhBCVkvEUxa7LNY9cIL6
	 p9Qs5mIDFYmSe68DUox1gkVvtpfytUGeEWnXWttRxxLWR39pk1gsgeL3NAXOf0HwLX
	 egWLlNcsrz1MZK8TFbq0jMpxcKZ4f9WS5ALwNn8fccuJclFwVqqizM19L8wvgNiiEn
	 XS2LcCuILsanx0fhABWnvCy3TtHAaKtBgEUHgE6m6Zt+5YcJkE7LqMEsY5sNz6sgoA
	 nbHy4dN0s4j44DBMbQb7ICpmFl10vKyidRFJK++0JCH5CaUlleCrqK6ybnSihwvR3H
	 hj+q2QPjL8ZQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/5] selftests/xsk: roll back partial socket
 setup on configure failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260807134209.3794735-3-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
 <20260807134209.3794735-3-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:44:30 +0000
Message-Id: <20260808134431.11EC01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Eager rollback in xsk_configure() causes a guaranteed NULL point=
er dereference in the parallel TX thread when the RX thread fails.
--

--- Patch [2]: [PATCH net-next 2/5] selftests/xsk: roll back partial socket=
 setup on configure failures ---
commit 80baccb88ac5eb975506a8efbd37137e2c6775b1
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>

selftests/xsk: roll back partial socket setup on configure failures

This commit introduces an eager rollback mechanism to clean up already
configured sockets if subsequent setups or busy-poll configurations fail
during xsk_configure().

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -1500,14 +1522,18 @@ static int xsk_configure(struct test_spec *test, =
struct ifobject *ifobject,
>  				break;
> =20
>  			/* Retry if it fails as xsk_socket__create() is asynchronous */
> -			if (ctr >=3D SOCK_RECONF_CTR)
> +			if (ctr >=3D SOCK_RECONF_CTR) {
> +				xsk_configure_rollback(ifobject, i);
>  				return ret;
> +			}

[Severity: Medium]
Could this new rollback cause a NULL pointer dereference in the parallel TX
thread when an RX thread setup fails?

When xsk_configure_rollback() cleans up the sockets on a failure, it calls
xsk_delete_socket_batch(), which in turn calls xsk_delete_socket(). That
function explicitly clears the umem pointer for the RX thread's sockets:

xsk_delete_socket() {
    ...
    xsk->umem =3D NULL;
}

If the RX thread fails and exits, the main test thread does not check
test->fail before spawning the TX thread. The TX thread then executes
thread_common_ops_tx(), which unconditionally dereferences the now-NULL
umem pointer:

thread_common_ops_tx() {
    ...
    if (!test->ifobj_rx || !test->ifobj_rx->xsk_arr[0].umem->umem) {
    ...
}

Does the main thread need to check for test failures before spawning the TX
thread, or should thread_common_ops_tx() verify xsk_arr[0].umem is valid
before dereferencing it?

>  			usleep(USLEEP_MAX);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807134209.3794=
735-1-tushar.vyavahare@intel.com?part=3D2
