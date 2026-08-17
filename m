Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A383AC0DE;
	Mon, 17 Aug 2026 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003673; cv=none; b=a/JX+rP2WEv7KCI7z48964SJHThlCKSwABb/1VH9RCwezMX4o23+lE6yjpvCTSG1bZuJDc3oS2mrJ85v8EUWYY11V2qihctkWzXyC2HRZpqZddYf07iwGUtWAvt7LKsOcPHKQzZbx3o5eQi3nfu9ZEEchqSXQYYQ9L341Xl7wtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003673; c=relaxed/simple;
	bh=kj5lyGq8SalOuIZcQCzfhrwevxGOGcGP5f7B1WbRjJo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pgjJ4hWIfDj1VQkP/SIV3MJBGA8itZA2YMcaBxVJLO5Iz/eWLybfRYMBB1pE12mfzaMGlCEvQuBth9bt6iqA/0ijY1e0Kpwndylp5baET8En+QhVpTusrqDOGrNxAd9sefD8P/ubEwJ3qmjQp2eSuGBm8c51MZA8qwa/V2gT+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6HxjbX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6HxjbX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40461F000E9;
	Mon, 17 Aug 2026 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787003671;
	bh=FEND4t2b2K4tvt4gLzsrRxja62eqP6PAUgA96KM4yV4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=V6HxjbX+BQ+Pxo6tNju71E51SgzskEsqScnuYR9ywLkGbsgliXZTlb4OrUrXNEj0E
	 1ZSgdw5tAUi6JhShMb8JojoqmJyVLngUg+Cnu3wLTA1MlncDZP6Vxc2n4RIcEPdf/I
	 ylMBT2UMzTJioSmwxjOWSCAn1TTm563riiTHVgCvqxWkV/qmv7KHihXZXCVO+q9BBi
	 vFBqhyyrEgeeUj63KukU3oy/W1Dr2TzP0VMQU82nALks4aECCM0BXJxP/0tbNm3u6P
	 a39JO9miTxcQMWBGTQuhLJwWQHvtsiWphZzggaQMocZ1oEi2Fi8y9Bxdkwd/ljEzQh
	 Ie4Zjj0NnaaLw==
Content-Type: multipart/mixed; boundary="===============2606687245961102636=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <695639f2477a0070c2219414e4359e7f433423322b30d6e8d5759b3b1686ce24@mail.kernel.org>
In-Reply-To: <20260813062754.360131-2-tushar.vyavahare@intel.com>
References: <20260813062754.360131-2-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next v2 1/5] selftests/xsk: add UMEM users refcount and centralize socket teardown
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 21:54:30 +0000 (UTC)

--===============2606687245961102636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 38ce6060b8fa..d0c2d0efb97f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -1467,6 +1488,17 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
>  	return TEST_PASS;
>  }
>
> +static void xsk_delete_socket_batch(struct ifobject *ifobject, u32 count)
> +{
> +	u32 i;
> +
> +	if (!ifobject)
> +		return;
> +
> +	for (i = count; i > 0; i--)
> +		xsk_delete_socket(&ifobject->xsk_arr[i - 1]);
> +}
> +

[ ... ]

> @@ -1701,12 +1735,61 @@ void *worker_testapp_validate_rx(void *arg)
>  	pthread_exit(NULL);
>  }
>
> -static void testapp_clean_xsk_umem(struct ifobject *ifobj)
> +void xsk_delete_socket(struct xsk_socket_info *xsk)
>  {
> -	struct xsk_umem_info *umem = ifobj->xsk->umem;
> +	struct xsk_umem_info *umem;
> +
> +	if (!xsk)
> +		return;
> +
> +	umem = xsk->umem;
> +	if (!umem)
> +		return;
> +
> +	if (xsk->xsk)
> +		xsk_socket__delete(xsk->xsk);
> +	xsk->xsk = NULL;
> +
> +	/* Skip slots that never acquired a UMEM reference (pre-initialized but unconfigured). */
> +	if (!xsk->umem_ref) {
> +		xsk->umem = NULL;
> +		return;
> +	}

[ ... ]

> +
> +	xsk->umem_ref = false;
> +	xsk->umem = NULL;
> +}
> +
> +static void xsk_delete_all_ifobj_sockets(struct test_spec *test, struct ifobject *ifobj)
> +{
> +	if (!ifobj)
> +		return;
> +
> +	xsk_delete_socket_batch(ifobj, test->nb_sockets);
> +}

This isn't a bug, but could the three functions be simplified?
xsk_delete_all_ifobj_sockets() checks !ifobj, then immediately calls
xsk_delete_socket_batch() which checks !ifobject again, and
xsk_delete_socket_batch() calls xsk_delete_socket(&ifobject->xsk_arr[i - 1])
which checks !xsk a third time even though the address can never be NULL.

Also, xsk_delete_socket_batch() has exactly one caller and is only ever
passed test->nb_sockets, so it doesn't provide any abstraction benefit.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32069138770
--===============2606687245961102636==--
