Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94F3BB102
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776784; cv=none; b=jypeSdoGeJLtWptOJXstTVfeiorz91bGM9R9vDFzYbIcuyGYuiEYBYeZ7Kme8iqcBfmtDqb8kHNgIA/1IytRhLXIQuw4nhbXs3gLFfZRjMlcYEcb2mjIMXUc8rQDCeZRb2MMn9E6t1vb6QChkZum3swzrV5/4BHoO+xJGnCN/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776784; c=relaxed/simple;
	bh=Ekao+2yTBWEplpplR/FDZ/ekv8svBPwVLqXmRYiPIa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NbreJFHTeV+ta1xk38VgUVEDIMam1TVMF+WDCUJBBQ3yTSa6BG7Ja9+EMpmV866BxSFxoT1P8HRZHRiPlOe5/9ly9xBSna1gxJ/CvTy9X3EKS1eW1EHwYGtUUnWsDNBDzUNjAbozZsAHt+jDFM0f7+mtdNobCtucUVitfR8xrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITLyLenM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITLyLenM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1222B1F00A3A;
	Sat, 15 Aug 2026 06:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786776767;
	bh=5lm5vWOkc5x1aQSwGDuWMcWZkY1wBOTxdHiVCUGDUFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ITLyLenM43AtMZYaDxKOp/RSyo7O2uZMtPTeRcrRCrWXXIGFbOq295iq3pHW3YsnI
	 p+ltihB25SJcFB+1iLMYoo03+rNKX8iRFWr+EUnVIh5jPpC4cUKJD5f7/zWVZcj03e
	 lJy2PdIUapabfXqik/xMrmVVF+ECclNNo7tHGAYIvpvwnqrDUpvcQbvkP3+0y9zctJ
	 rlBucJZyPSi0gUqGLlKcIzbOwmTmBKUpAoGR+tlUoLaqd9Oi7ZdWRGBWjzm7VCRMrn
	 KvKaoMHVm1c+gur0NBhuPZa6I19fIJBLqvqsbCOQ0rRN3265dljj4bOVTN9ZLT1eCA
	 NjlRtUbQ+hTSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 01/14] bpf: Add verifier diagnostics report
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260815064612.378577-2-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
 <20260815064612.378577-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 06:52:46 +0000
Message-Id: <20260815065247.1222B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `bpf_diag_header` is declared `static` but is never ca=
lled within `diagnostics.c`, which triggers a `-Wunused-function` compiler =
warning and breaks the build under `CONFIG_WERROR`.
--

--- Patch [1]: [PATCH bpf-next v5 01/14] bpf: Add verifier diagnostics repo=
rt helpers ---
commit c8722c70a656e46b9e45b3b94e11be7487e49da9
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add verifier diagnostics report helpers

This commit adds the initial diagnostics renderer for verifier reports and
wires it into the BPF build. It introduces helpers to emit common failure
headers through the verifier log.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 0000000000000..e75753552a4dd
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> +static void bpf_diag_header(struct bpf_verifier_env *env, const char *ca=
tegory,
> +			    const char *problem)
> +{

[Severity: Low]
Is this function intended to be exported or used within this file?=20

Because bpf_diag_header() is declared static and isn't called anywhere
within diagnostics.c, compiling with CONFIG_WERROR enabled triggers a
-Wunused-function compiler warning and breaks the build.=20

Could this function be exposed in diagnostics.h so other subsystems can use
it, or was a local caller omitted in this patch?

> +	char first;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815064612.3785=
77-1-memxor@gmail.com?part=3D1
