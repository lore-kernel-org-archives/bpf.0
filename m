Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBD2E8DEA
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068840; cv=none; b=Kk+L00cVAe0O1IJVRPiyA5U1YUwdTWRIVC1NhkhTLdnN4k5xVu9tO3AX86Gv8ziGm1mth/xbkh2dD8OQ76MUBENsofZF+Pw4Ynlp/xiix3vHgAhTzjdSS5co0jZagZx9aqqdbqHOr+tREfgaohNVfalS3K/UZhroTbIqlg2Ly8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068840; c=relaxed/simple;
	bh=AOqZH4TjexRNiL3Xr2hdH7fsuIFfv0iYOpL745/voUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jv6j3uHRYuLoSMiTRXgp92iflsYFydk1GxDHmXUEuxtGZHohYF2OtU3PMfKuRgh800luGpyWKPeM7zNXx4LM8ypzgSwwVTbnbYmY4Vila+vgIh9Np2/5VRJESzobs/Tnml4s+PTGcWAAhQ01xEhFCgQbU1IyhsoVh56tlSFm9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3DBKf8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3DBKf8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BAB1F000E9;
	Fri,  7 Aug 2026 02:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786068839;
	bh=Z1hzzh8q6iPdierpc51vHY1mEHcsIMAYH2TuqUuGHys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R3DBKf8VBW+4nwM0CtvqmlePMA3Un6T/qbUEXyGCyrBMAI8j8Hli0IbhLqpuPD2up
	 QmKu6ZVcGpQfHhAvSrI5OjvhTl54uQ+32yGMAwoancy4tw4JqxfJ1SsQnRIBgyg+sv
	 3CYCroa9Fn74aQp99HDoBW0hdCtivQihoZt0nY4WO+7IcwyFwmEeVwTGMxEgF/8XOm
	 2S1zyDd8jI8c9D/m3Y2a3tOfsRbtGZyRGCov51yEVyi+pPZXylBkxkUsSW8kQxv/QU
	 LnB/wwEAeYvFkOGSpOPUbcIdpZFQ096HSDxg6hTZvBiOWKe5ABp6TGI9Iw2XztbmZV
	 20MIKv9DPYFCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/bpf: Add regression test for queue/stack
 map size limit
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260807020548.1376979-3-chenyuan_fl@163.com>
References: <20260807020548.1376979-1-chenyuan_fl@163.com>
 <20260807020548.1376979-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 02:13:58 +0000
Message-Id: <20260807021358.D4BAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment opening `/*` is not on its own line.
--

--- Patch [2]: [PATCH 2/2] selftests/bpf: Add regression test for queue/sta=
ck map size limit ---
commit e79d16bed784907a39f11792c9c1497efb8fd26f
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Add regression test for queue/stack map size limit

This commit adds a regression test to verify that queue and stack maps reje=
ct
creation if their element storage size exceeds U32_MAX bytes. It tests both
queue and stack maps with an oversized configuration, ensuring they fail wi=
th
-E2BIG, and also verifies that a normal-sized map is successfully created.

> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/t=
ools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e1794..6f8ac285e7196 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
[ ... ]
> @@ -101,8 +101,42 @@ static void test_queue_stack_map_by_type(int type)
>  	bpf_object__close(obj);
>  }
> =20
> +static void test_queue_stack_map_alloc_check(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	const __u32 big_value =3D 1 << 20; /* 1MB */
> +	int fd, saved_errno;
> +
> +	/* Regression test for the u32 index overflow in queue/stack maps:

[Severity: Low]
This isn't a bug, but should this multi-line comment follow the BPF subsyst=
em
comment style by placing the opening /* on its own line?

> +	 * a map whose element storage (max_entries * value_size) exceeds
> +	 * U32_MAX bytes must be rejected at creation time, otherwise the
> +	 * u32 head/tail index multiplication wraps and push/peek/pop
> +	 * address the wrong element. 8192 * 1MB =3D 8GB > U32_MAX.
> +	 */
> +	fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, big_value, 8192, &op=
ts);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807020548.1376=
979-1-chenyuan_fl@163.com?part=3D2
