Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFA2F7EE6
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867779; cv=none; b=nrFVt38K+dk/PgsYSd62VKCp8XwlfW36IVQjM8wZ9g6+bRlwENTAhSvV+Dwj0Ws32oegE+FUwzoRnHhm+IBs+yCYq3gJAs/GRCntu4YdN/ut0XxqLapXBcds7LH6A/hsvDqJm+8/dCQY5m+eCbWyz5LgLTg2CNcp76o0ntTCZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867779; c=relaxed/simple;
	bh=/1WSjRMqV5ilBnTjX9ICtrP4ZcS48F3/LM8wZzDfFKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vGJswg4QpT/pACC6cik5Gfhzb/1UNWXPgnrsDksaFGhjY73C0kP2kfsqN+MAQ5cM+7Kmzs98CN4DxACUNzuKog1MogiE1XaDRZX2Mnw8umNFv+EcL0Wq8V41a4cNIohKmtI1cjdrc03Hd/9tg9lj/hPkAJlcbDaNDCL9T4Fz3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/KxbwTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/KxbwTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4059C2BCB0;
	Fri, 15 May 2026 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778867779;
	bh=/1WSjRMqV5ilBnTjX9ICtrP4ZcS48F3/LM8wZzDfFKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q/KxbwTvGsm2F2/nKF+e/Xtt0/4dLwNIO68ya33/yC5efJXw39LTE9F4I1YQ6rs4Z
	 m53e+aK4l3ywwV9mbgSkPa/gBiUvkF/w+0mpoWryKzdIg0Ps25dyfuAmenluFxWCC2
	 0D8OdrLTHOe6hmBNgfDmfV2mJbjiZxaV7ITQ/Um5a2gd84jUuuizXLkaQQJ931vGeC
	 Wd77mnuqvWzlF8yskmFntcbCmdqmMAGgmdCQTBQy0RMOutU3RHPo6xOtEkzzcjM+AU
	 bGKwHipKP2fh+cXhIQrqxuhodbGtkq/3/HpybPN0N/9RI+xyvRN5S+oqRNxT/3QUMv
	 WQvNlT3P/79ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/3] bpf: Export btf_get_module_btf() and
 btf_relocate_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515-generic_tracepoint-v1-1-aa619fa94132@meta.com>
References: <20260515-generic_tracepoint-v1-1-aa619fa94132@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 17:56:18 +0000
Message-Id: <20260515175618.A4059C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] API Asymmetry and Resource Leak due to unexported btf_put()
--

commit 51050bef777abcb3d2969804b1e3693feb10a170
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Export btf_get_module_btf() and btf_relocate_id()

This commit makes btf_get_module_btf() and btf_relocate_id() available outs=
ide
kernel/bpf/btf.c by exporting them. This allows the tracing core to look up
module BTF and translate split BTF ids.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 77af44d8a3ad3..aa88d18247bda 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -8500,7 +8501,7 @@ struct module *btf_try_get_module(const struct btf =
*btf)
>  /* Returns struct btf corresponding to the struct module.
>   * This function can return NULL or ERR_PTR.
>   */
> -static struct btf *btf_get_module_btf(const struct module *module)
> +struct btf *btf_get_module_btf(const struct module *module)
>  {
[ ... ]
> @@ -8529,6 +8530,7 @@ static struct btf *btf_get_module_btf(const struct =
module *module)
> =20
>  	return btf;
>  }
> +EXPORT_SYMBOL_GPL(btf_get_module_btf);

Because btf_get_module_btf() increments the reference count on the returned
struct btf object using btf_get(), callers are required to release this
reference by calling btf_put().

Since btf_put() is not exported, won't loadable modules using this new API
fail to link or be forced to leak the struct btf reference?

Alternatively, if these functions are only meant for the tracing core, which
is always built-in, are these EXPORT_SYMBOL_GPL declarations necessary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515-generic_tr=
acepoint-v1-0-aa619fa94132@meta.com?part=3D1
