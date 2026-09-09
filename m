Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F12BDC1C
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928477; cv=none; b=hqE3gVWUtfkb6f84H5yfH9pksKPvZ2Xn7/WiFnRjOoH7YB1RddAmxBy5ljPx6VBSm+MwDCKT/rNm2Ywhi3ZxmBvlKWCUEAmqwZYx0jcZUAblYOZIed1EZC6RSguedVT0QaPT/OZ+TcoMV1haOPRNPlz1/RhmdtSy+zBlrrWR+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928477; c=relaxed/simple;
	bh=oFYpn3xIuZjIdlVsVxaCJkOITsONh6E8DB6XpsjqiX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B80lyUwUm2OAIZoNjwkCllwUkxmvsWK1KvV62TIqllCH3BKx0TUI+DzMvrs9y7Yss67I4JhJ50k3myYz7D4i/hfqN2+hStasIvSGNej7EQMxmEje7G64FaBGcnn/SLzwi8a5m7x/SvOhqjj2/tZpkHVRNZIvQburgGwYILVuQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYDBJ30I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYDBJ30I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A117F1F00A3A;
	Wed,  9 Sep 2026 04:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928475;
	bh=2Z4DL6S5YmRhjVMPpGXC6fUfqM/HdHkP4ctNhePvvVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYDBJ30IcfMOqvR4g/BH74t3x5tw0a029Z1cQW8k4jZo8RCeyv9dbCwP7i8NqOcpZ
	 BEhJz8rRj4NVpn3G/vSmZ8WGk/jmcOtJvgYgS4pyc2mwhzyRxkot8SnkVGAEBgqV1y
	 IvzvhixaukAcyqv9Fg07yQZOqeK9GZSVF7kXO7xkaCHeEgf5ftDXlhVt6xcPR+ZEDv
	 YbONKa64e9LLOb+XKs0FHEL4a4jieBgwnHwZnPAalOO4im7UFb4c5dUsZ0PxJDQv4V
	 yuYwtCvN3deRDwsSLriusZFHm9Hav7UVJIzH6/G7ct5tYsfBeiMm6LwiGjrtcA/Eid
	 b/dTImnmQ5iFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test slices escaping a clone
 call frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909042858.1734125-3-xyx2021@mail.ustc.edu.cn>
References: <20260829040712.B1B511F000E9@smtp.kernel.org>
 <20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn>
 <20260909042858.1734125-3-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:34:35 +0000
Message-Id: <20260909043435.A117F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the strict BPF subsystem comment =
style.
--

commit 720f5969dc3c0d1bbc8d954089385b04bccca58f
Author: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

selftests/bpf: Test slices escaping a clone call frame

This commit adds a success case and a failure case to test BPF dynptr slice
behavior when a slice escapes a clone call frame. These tests verify that
subprogram return behaves correctly with respect to slice validity and
shared reference release.

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index 1cd61d72c166f..0704662cd32f3 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -1892,6 +1892,52 @@ int clone_invalidate4(void *ctx)
>  	return 0;
>  }
> =20
> +static __noinline void clone_slice_in_subprog(struct bpf_dynptr *ptr, in=
t **data)
> +{
> +	struct bpf_dynptr clone;
> +
> +	bpf_dynptr_clone(ptr, &clone);
> +	*data =3D bpf_dynptr_data(&clone, 0, sizeof(val));
> +}
> +
> +/* A slice that escapes the clone's call frame remains valid while the
> + * shared ringbuf reservation is live.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment format match the BPF
subsystem requirements? The BPF guidelines specify that multi-line comments
must have the opening /* on its own line.

> +SEC("?raw_tp")
> +__success
> +int clone_slice_returned_frame_valid(void *ctx)
> +{
> +	struct bpf_dynptr ptr;
> +	int *data =3D NULL;
> +
> +	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +	clone_slice_in_subprog(&ptr, &data);
> +	if (data)
> +		*data =3D 123;
> +	bpf_ringbuf_submit_dynptr(&ptr, 0);
> +
> +	return 0;
> +}
> +
> +/* Releasing the shared reservation must invalidate a slice that escaped
> + * from a clone's call frame.
> + */

[Severity: Low]
Similarly here, could this multi-line comment be updated so the text
starts on the next line after the opening /* marker?

> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int clone_slice_returned_frame_invalid(void *ctx)
> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909042858.1734=
125-1-xyx2021@mail.ustc.edu.cn?part=3D2
