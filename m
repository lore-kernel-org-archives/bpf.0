Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276F39DBC0
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029390; cv=none; b=STceJfNXn1aIhKIQueuCOtPx+pcP6FLLBZm+ZAvhaLbmK+H0lvPeFzJFPJT6dvTKkKpXfpVwN5eYEBAvF3UivkH0S6IskcRElDQ8ddKlA8lh8uj0SwlJFgUnGVv7ZV5nm2Do7b+diPwGw2swYrxejwaqqmbnHj43rCyrt9bweZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029390; c=relaxed/simple;
	bh=knTFUy0OLTlm4ckeIx17ey9rRaKGTIdN0CcfLgbRoGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyPQbL3g4dSUMhwwDqQTtsXbtelMunKYWeL+vvTFML4Jyuxx5g3F2w4jvNO2lLmSfnW3HIQkVaM7tES0HbDxpLZhld83Y6u5D5yJZfm3u09ei7fXoBCrrn4hgLtDgrjPC+gVX6oO62EKsCJFyBRqHkhkQFRqnKjqK27UVRMkfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpigTYTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpigTYTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA67EC19425;
	Fri, 24 Apr 2026 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777029389;
	bh=knTFUy0OLTlm4ckeIx17ey9rRaKGTIdN0CcfLgbRoGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VpigTYTTR7oY37WJRKyx7fUiiOEHprkmYDGvvN3JNzlw7aJoUVfb/wvRl/N/BXCuc
	 rfZXvXbTEFgnn5NLYEdaOsjVkA1ZRfdRtPkOrBm2BzeD3jFWlag/7As5pkVVChhomZ
	 ENk0khn+mtMTvqOwgVCpUH6RgG3oKZTHjNBiK2th/Wo/ZTJFgp3Ao4VkNLQlShvMsd
	 o4TZEHXtmu8NXJt3r00fbhqPAXmQNPcBrYq6WKPIsyBwpB/dnySJmYB2l8h5w3LNRt
	 FrgVRPWxJvBHta9EwDJJBe0E2XjY0cP9kgEToS3EPxUypQ0A4NXFyMo52RHPRPMAx/
	 TNyCreni71EXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: bpf: Sync KF_SLEEPABLE flags in
 hid_bpf_syscall_kfuncs set
Reply-To: sashiko@lists.linux.dev
To: "Zhao Mengmeng" <zhaomzhao@126.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn>
References: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 11:16:28 +0000
Message-Id: <20260424111629.AA67EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] ZERO_SIZE_PTR dereference in hid_bpf_hw_request() causes a ker=
nel panic.
- [High] Integer promotion bug in hid_bpf_hw_request() silently masks hardw=
are failures.
--

commit 5998989ac7e53dfd091520e5a1a9f8e928c8cf45
Author: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
   =20
    HID: bpf: Sync KF_SLEEPABLE flags in hid_bpf_syscall_kfuncs set
   =20
    This commit synchronizes the KF_SLEEPABLE flag for syscall HID-BPF func=
tions
    in the hid_bpf_syscall_kfuncs set. This prevents the flag from being
    inadvertently dropped globally when pahole intersects flags across BTF =
IDs.
   =20
    Link: https://lore.kernel.org/sched-ext/177693500312.275653.17323765149=
266875001.b4-reply@b4/

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 50c7b45c59e3fb..62db80ead86e51 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -585,11 +585,11 @@ static const struct btf_kfunc_id_set hid_bpf_kfunc_=
set =3D {
> =20
>  /* for syscall HID-BPF */
>  BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
> -BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
> -BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
> -BTF_ID_FLAGS(func, hid_bpf_hw_request)

This isn't a bug in this commit, but since the BTF flags are being updated
for hid_bpf_hw_request(), I noticed a potential issue in that function.

Can a ZERO_SIZE_PTR dereference occur if a HID device has an empty report?

When a BPF program invokes hid_bpf_hw_request() with buf__sz >=3D 1, and the
device has no fields and no report ID, hid_report_len() can return 0:

drivers/hid/bpf/hid_bpf_dispatch.c:__hid_bpf_hw_check_params() {
	...
	report_len =3D hid_report_len(report);

	if (*buf__sz > report_len)
		*buf__sz =3D report_len;
	...
}

This clamps the size to 0. Back in hid_bpf_hw_request(), this 0 size
is passed to kmemdup():

drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_hw_request() {
	...
	dma_data =3D kmemdup(buf, size, GFP_KERNEL);
	if (!dma_data)
		return -ENOMEM;

	ret =3D hid_ops->hid_hw_raw_request(ctx->hid,
					  dma_data[0],
	...
}

For 0-byte allocations, the slab allocator returns ZERO_SIZE_PTR (0x10),
not NULL. The !dma_data check will pass, and the function will dereference
dma_data[0], potentially causing a panic.

Additionally, can negative error codes from hid_hw_raw_request() be
permanently masked?

The variable ret is an int, while size is a size_t. When hid_hw_raw_request=
()
fails, it returns a negative error code (e.g., -EIO).

drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_hw_request() {
	...
	int ret;
	size_t size =3D buf__sz;
	...
	ret =3D hid_ops->hid_hw_raw_request(...);
=09
	if (ret > size)
		ret =3D size;
	...
}

Due to C integer promotion rules, the signed int ret is cast to an unsigned
size_t before comparison. Any negative error code is converted to a large
positive integer, causing ret > size to evaluate to true. The function then
executes the ret =3D size assignment, masking the hardware failure.

> -BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
> -BTF_ID_FLAGS(func, hid_bpf_input_report)
> +BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | =
KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
>  BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424-btf-define=
-v1-1-0f52dffad5aa@kylinos.cn?part=3D1
