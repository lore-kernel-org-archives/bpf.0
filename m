Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028DC3D7D8F
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399392; cv=none; b=qgldzwNrVJOtiJeYf2Dd1dm6PsvaC4zvbhjJ78KlI4KV92FAiWr7Wrtl9iKy/mcmVIDJNt8rvSyXfya2EfvgnWVw3zGLSGmGG+oWSxPgXMpPq/DRGQqmuzazFdy6qEBwg/hhLLq4Ql3Uppjw1qfZpk9TTpfzgPCM8IXTb1hqdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399392; c=relaxed/simple;
	bh=oAZVn3QAINRtvywLnVja6KEpsrjhmlgvCnSS+qwS2eQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D8Z8ct5EFEJhAkf4rGNJhWg1yAJ1St5K9AhMKu1k9FwK0PwS/Ahta8YdkqJTBl0OrQHMvVivRv/tJQgwNPa9sRbHDVCFAq/PZHate6e1ck1S3QGSS1kos1fH8DHvChaCasvkM9TOyYI82dRxY3nC8u3shDeo1rgRZtHGVZudg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN02+xQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN02+xQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578341F00898;
	Tue,  2 Jun 2026 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780399389;
	bh=u7Wd8U4/amercpeH+3/QxRFQ7GLgkKJHJDp9Ff3b4BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UN02+xQhJ2l8hZjR90tv8J53glrdRumOTMBoyCazLD4So+gJakC86l9QkWLEGSIaf
	 JSwQ9NH6HzMCaIqHY0YlwfR4X3yMlWphxCChRMwzDOwRnvrCA7XKxY0Foquduwp0NJ
	 +orUEeOexG/4b/aWjHKLxRCf2SNKJKhPo0+H72O0gT3NanjEJvAInJyjwcBNTDxCdb
	 BzdbSxxK7ibc3b42twn0RlglfgV1T70IHSLJKrfFuWt5+hoX7DWIqFT/XWBE7+yLkN
	 Lt1SR0WCVPfbUpeZQvijSj4/kVJYv4tba3F+OGzN45bUXu022FY3dIHaJ4TV82WW6M
	 5mAT5YG/Kk7Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] btf: reject to register duplicated kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Chen" <chensong_2000@126.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602110710.19642-1-chensong_2000@126.com>
References: <20260602110710.19642-1-chensong_2000@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:23:08 +0000
Message-Id: <20260602112309.578341F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Kfunc registration incorrectly fails if the kfunc name matches ANY=
 internal or static function in vmlinux or loaded modules, introducing load=
-order dependencies.
--

commit 8a8189baf0633350e5ca2b793c2340e48f4787df
Author: Song Chen <chensong_2000@126.com>

btf: reject to register duplicated kfunc

This commit attempts to prevent duplicate BPF kfunc registrations by search=
ing
for existing kfunc names in vmlinux and other modules' BTF data during kfunc
registration.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d785812076..ad6b925125dee 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8684,6 +8684,41 @@ static int btf_check_iter_kfuncs(struct btf *btf, =
const char *func_name,
>  	return 0;
>  }
> =20
> +static int btf_check_kfunc_name(struct btf *btf, const char *func_name, =
u32 kind)
> +{
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	struct btf_module *btf_mod, *tmp;
> +#endif
> +	s32 id;
> +
> +	if (!btf_is_module(btf))
> +		return 0;

[Severity: High]
Does this bypass collision checks for built-in vmlinux kfuncs? It looks like
this might fail to catch intra-kernel name collisions.

> +
> +	id =3D btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);

[Severity: High]
Since modern kernels generate BTF for all global and static functions, does
btf_find_by_name_kind() with BTF_KIND_FUNC search the entire BTF data rather
than just registered kfuncs?

Will this incorrectly reject a valid kfunc registration if its name happens
to match any unrelated static or internal function anywhere in vmlinux?

> +	if (id >=3D 0) {
> +		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
> +				func_name, id);
> +		return -EINVAL;
> +	}
> +
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	mutex_lock(&btf_module_mutex);
> +	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
> +		if (btf_mod->btf =3D=3D btf)
> +			continue;

[Severity: High]
Are we skipping collision detection within the module's own BTF here?

> +		id =3D btf_find_by_name_kind(btf_mod->btf, func_name, kind);

[Severity: High]
Can this create unpredictable load-order dependencies between unrelated
modules?

If module A has a static function named "foo", and module B registers a
kfunc named "foo", it appears B will fail to load if A is already loaded,
but will succeed if B is loaded first. Should this code check against actua=
lly
registered kfunc sets rather than all functions in every module's BTF?

> +		if (id >=3D 0) {
> +			pr_err("kfunc %s (id: %d) is already present in module %s.\n",
> +					func_name, id, btf_mod->module->name);
> +			mutex_unlock(&btf_module_mutex);
> +			return -EINVAL;
> +		}
> +	}
> +	mutex_unlock(&btf_module_mutex);
> +#endif
> +	return 0;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602110710.1964=
2-1-chensong_2000@126.com?part=3D1
