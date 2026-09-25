Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD371501F41;
	Fri, 25 Sep 2026 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377159; cv=none; b=LOUexnRLVystlI2od9GViCJw1NFbAq9yd42rMzdlqIHIwYnxn9wS1ORJnQ2dh+Wbtb5jyHwmFRnItY/cPl5q0oI+jdg7j53qaMDxuAn822mbdoBknPKdBERCHitdoxFJiYwtyedKUKpyYrGDM3PxqGuYLoxlhpYLosaEJxIf3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377159; c=relaxed/simple;
	bh=xmssPx5AHJgk2ro4YQzWuoezNhdArtrHLBK1GqJuXjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fsa/91ySukRy6MOY2o0tXwdIUcGfw6u8ahceqjouCkXdN8viztuXp4YntWhkZzAXgZEnQB12gJ71e/Qfgs3tbBGESqFuInVbbiMdwkTRbLnE3WrhMia26gyOvmY+ARzQzuX4XitesUIxNtGMQstuTP2nP0Nycadu5LcbVF5Jq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0zI4WTn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0zI4WTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BCC1F000FF;
	Fri, 25 Sep 2026 22:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377155;
	bh=L2SQTEzxANunYWA8gTr2sfK/s/6XskpJ04PeS3cLIxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C0zI4WTn615nAmI21GE1oyHMNfxYzR31quvi4lTRNuBmPtRCpn9z/Ii6G7/dx0GJE
	 Q9fbOKjwRlObLB7ahlYR55g4o3bOLjE5H1WjMWRQKPjwTW09Qx5u7obTc7do3T/oV6
	 O3LUR09sK/h9AAjvkvornWFGutJXPwSviRX6HpmKb+e6st444M5vJd7HpjhVkIK336
	 Te/gMUcZLQ88M358WBDfnSItH4KUTRrnEZys9UT5peRelVFEKE+N7iVzhqC1xIFkbN
	 WlLGb57wsybaSHkvlQ5Ss56HJPOTfCrUaH8GWUFqCPS+DqjjwSul2DPqDUzPm2+THL
	 BRXUgrO6LrqRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 6/9] bpf: keep module BTF until the vmlinux
 BTF is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: ojeda@kernel.org, linux-modules@vger.kernel.org, gary@garyguo.net, bpf@vger.kernel.org
In-Reply-To: <20260925224229.1850-7-wanjay@amazon.com>
References: <20260925224229.1850-1-wanjay@amazon.com>
 <20260925224229.1850-7-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 22:59:15 +0000
Message-Id: <20260925225915.76BCC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: memory leak of module BTF data on parse failure for .BTF.base =
modules
--

commit 10719f6f8154699a27d9151dc131b89e1ea34139
Author: Jay Wang <wanjay@amazon.com>

    bpf: keep module BTF until the vmlinux BTF is available
   =20
    Module BTF is split BTF against the vmlinux BTF and is parsed in the
    module notifier.  With CONFIG_DEBUG_INFO_BTF=3Dm the vmlinux BTF may no=
t be
    loaded yet when a module loads, and the notifier cannot load btf_vmlinux
    (that would nest a module load in a module load).

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 207954b5754a7..1dae1c9b53fed 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -9309,6 +9414,101 @@ static int __init btf_module_init(void)
>  }
> =20
>  fs_initcall(btf_module_init);
> +
> +#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
> +/*
> + * A kept module whose BTF cannot be used after all.  The module is load=
ed
> + * and stays, so there is no way to reject it: the entry stays on the li=
st,
> + * dead, until the module goes.  A sysfs file it has keeps serving the r=
aw
> + * data, which is kept for that.
> + */
> +static void btf_module_dead(struct btf_module *btf_mod, const char *what=
, int err)
> +{
> +	pr_warn("failed to %s module [%s] BTF: %d\n", what, btf_mod->module->na=
me, err);
> +	kvfree(btf_mod->base_data);
> +	btf_mod->base_data =3D NULL;
> +	btf_free_deferred_regs(&btf_mod->deferred_regs);
> +	btf_mod->gone =3D true;
> +}

[Severity: Low]
Does this code leak btf_mod->data when parsing fails for modules with a
.BTF.base section?

If a module with a .BTF.base section is loaded before the vmlinux BTF, and =
its
deferred BTF parsing subsequently fails when the vmlinux BTF is loaded, the
memory btf_mod->data is retained because btf_module_dead() assumes the sysfs
file will continue to serve the raw data.

However, for .BTF.base modules, the sysfs file uses
btf_module_sysfs_read_deferred(), which returns -ENODEV when the module is
marked as gone. As a result, the memory is inaccessible and uselessly retai=
ned
until the module is unloaded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925224229.1850=
-1-wanjay@amazon.com?part=3D6
