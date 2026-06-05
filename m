Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C0413610
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660582; cv=none; b=ZFgxeOIe2cvnLc4aMJkxthNCrUpp46AyguNbqsPypta534f8bauI2qshmt1wrB/EWI+aFHCrmJrtMDPu5k4n00ofJkiReNFlGLt73KigfKnln8kxfng72AtLuUywOVX19aS515nI4PWcEUxZBLMNLohR8y3CQGtZ+hM63Pn5uGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660582; c=relaxed/simple;
	bh=Z/aWrLMM0CzqUOOpo0vWpBVTox8n3KMnxrv56RQe/Ak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2hylajoZf6Itud4fWQWyyOvSDIHPkKlXc/bk/2LHznpzUBTXRSpsOGMEU0auge8hXSL85Wdg3QC/VgnO5EPqFQqMff/JV9/62GP8fR6tTIvNoIBvgGHoFM4rTHYVR6eWgRx6EBHq6rv2oxIltihR9TVN9nli1tuCz9KdbIowHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADcSm5lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADcSm5lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B7C1F00893;
	Fri,  5 Jun 2026 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780660581;
	bh=EL9imOroRCxeSvd8i7ukDwpWHp1kUstZarvKVdu2+qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ADcSm5lcmwljVtht6e0iXYDF7dQil5TpklCQoUavPlbJ1Tmr3P1sK/z3ZYYHskalu
	 xIn6aroqBzw6AbBbn7iyjfSj3+1W3uRZXfPjICBOQRNtkDf/LpM4MEJ/sz83eJRaUH
	 +W0J2kKQZ6uI/X2FyW6RLHBgjS/7sj/uDIoUIWmAcqzK6EJYMTdtNJCqRAwkreAcEy
	 y4FvS1ApojIWT4vZL7OMnQZZmVJVor9WdfbBhy2+6CiyQL1yZRfOLALN9kJcr9lyQ+
	 33mDUKSlDcC2+V3mMARndUhfRowq5d2tB72A8rFtp+nKfRun2siOXZeF2S++EsVJ4E
	 mmCFa2JMyL7jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 10/12] selftests/bpf: Add BPF iterator tests
 for resizable hash map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605-rhash-v7-10-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-10-5b8e05f8630d@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 11:56:20 +0000
Message-Id: <20260605115620.F1B7C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BPF iterator test `rhash_iter_test` does not verify that `re=
ad()` completed without an error.
--

commit 80a3099ee25442fbc4f994c884097e00ff4bfc97
Author: Mykyta Yatsenko <yatsenko@meta.com>

selftests/bpf: Add BPF iterator tests for resizable hash map

This commit tests basic BPF iterator functionality for BPF_MAP_TYPE_RHASH,
verifying all elements are visited.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testi=
ng/selftests/bpf/prog_tests/rhash.c
> index 69686bf69ba57..98bb66907b7f7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/rhash.c
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c

[ ... ]

> @@ -89,6 +90,65 @@ static void rhash_map_extra_too_big(void)
>  		close(fd);
>  }
> =20
> +static void rhash_iter_test(void)
> +{

[ ... ]

> +	iter_fd =3D bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
> +		goto free_link;
> +
> +	do {
> +		len =3D read(iter_fd, buf, sizeof(buf));
> +	} while (len > 0);

[Severity: Medium]
Could this loop silently swallow errors if read() returns a negative value?

If read() returns an error, the loop will exit silently. If an error occurs
after all map elements have already been processed by the BPF program, the
subsequent assertions on key_sum and elem_count might still pass, which wou=
ld
completely mask the failure.=20

Would it make sense to add an explicit ASSERT_GE(len, 0, "read") after the
loop to ensure read() completes without error?

> +
> +	ASSERT_EQ(skel->bss->key_sum, expected_key_sum, "key_sum");
> +	ASSERT_EQ(skel->bss->elem_count, 64, "elem_count");
> +
> +	close(iter_fd);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-rhash-v7-0=
-5b8e05f8630d@meta.com?part=3D10
