Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D141DEC8;
	Fri, 25 Sep 2026 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371780; cv=none; b=dqRn0n3BXITpPYuO6UgZvDabG95GZj7hPRNBa88uw7yliQqwJEEtbNXDbjsR/L0vly6WOG1JhBkBkMcIWT8+IdpBRlyF5k6k4cWBrfKZaoGq4LgBCWFwW68QWsd7XB3oBxN3x5gAlFWqL/4ciWGqPwFLrKdqWCdQx4EFRAZVr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371780; c=relaxed/simple;
	bh=59sroyxnsliLW0il/Bkx4zNOdG3m2WWbL52O08QxRtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E8WP3yJI2awwWm2aMAWDMnTc24AUSF1S/WLt6Gtbsmwg6oLZ6nnDWh57BSVfSOU/DG5jbIs35+CYgI11sDIeTgMUI65GHUi7SO8VdJbeUuwmzOQGyguSQQ+4SG75qLxA6T9fiWoRVRukSfSzdT8rffuoPrTiqto4v2dhx/IRe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adEIBx+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adEIBx+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D91F000FF;
	Fri, 25 Sep 2026 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790371778;
	bh=nqI0lBL6x3TuA07orPlYk7Qxi9YKMugSpKZAc7UHWF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adEIBx+REkzKOh+FpxgDznDUXkf5CVKjG969qZ5nQqQPn2oXBtbA5q8oUagmibFmX
	 6jU4vIaBT0TP/VYNNo39P6xyLQkjqhJOI4RAnyViPI/Hq1nxog118AqD+6jifpBYSG
	 wUXA0htjN9whOEV9qEzIsdEbYQqW+cgcCA02HNxbh9hjk0/e1Bp+zwKTHUmT1lH3eh
	 7A3lxKKiDwiO17oI7LxwKSURAr7mdAtgqLS2w5HG63+c5U/GxQbXOwBcEX/j+s+54Y
	 31nTSDLfRhCcyHXm3tOQWcY8RzQ+2ELDvO1e7RtjY1NtqafxKCi3cTvfECDWtqlQLr
	 PkPdWbiq1CEmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/9] bpf: keep module BTF until the vmlinux
 BTF is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260925211314.5118-7-wanjay@amazon.com>
References: <20260925211314.5118-1-wanjay@amazon.com>
 <20260925211314.5118-7-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:29:37 +0000
Message-Id: <20260925212938.3B4D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: Use-After-Free in MODULE_STATE_LIVE notifier due to lockless =
module memory access
--

commit 93f5bd60bb80b8878d6319aa725f17dde3127d2c
Author: Jay Wang <wanjay@amazon.com>

bpf: keep module BTF until the vmlinux BTF is available

This commit delays the parsing and registration of module BTF until the
vmlinux BTF is available when the kernel is built with
CONFIG_DEBUG_INFO_BTF=3Dm. It keeps a copy of the module's BTF data and
processes deferred kfunc, dtor, and struct_ops registrations once the
vmlinux BTF arrives.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index aa3fdc98034bd..39d75e8890601 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -8918,6 +9002,26 @@ static int btf_module_notify(struct notifier_block=
 *nb, unsigned long op,
>  				continue;
> =20
>  			btf_mod->flags |=3D BTF_MODULE_F_LIVE;
> +			if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && btf_mod->btf &&
> +			    !list_empty(&btf_mod->deferred_regs)) {
> +				/*
> +				 * The vmlinux BTF arrived while this module was
> +				 * initializing: btf_parse_deferred_modules()
> +				 * parsed its BTF but left the registrations its
> +				 * init queued to us, now that init is done and
> +				 * the module is not going anywhere.  Applying
> +				 * them walks btf_modules, so drop the mutex.
> +				 */
> +				LIST_HEAD(regs);
> +
> +				btf =3D btf_mod->btf;
> +				btf_get(btf);
> +				list_splice_init(&btf_mod->deferred_regs, &regs);
> +				mutex_unlock(&btf_module_mutex);
> +				btf_apply_deferred_regs(btf, &regs);
> +				btf_put(btf);
> +				goto out;

[Severity: High]
Is it possible for a concurrent module unload to free the module memory
while btf_apply_deferred_regs() is still running here?

The MODULE_STATE_LIVE notifier drops btf_module_mutex to call
btf_apply_deferred_regs(), which processes deferred_regs that point to the
module's memory (such as reg->kfunc.kset). However, it doesn't appear to
acquire a module reference via try_module_get() before dropping the lock.

Because the initial module reference count is dropped to 0 by
do_init_module() before calling the MODULE_STATE_LIVE notifiers, could a
concurrent sys_delete_module() successfully unmap the module memory,
leading to a use-after-free when btf_apply_deferred_regs() dereferences
those pointers?

> +			}
>  			break;
>  		}
>  		mutex_unlock(&btf_module_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925211314.5118=
-1-wanjay@amazon.com?part=3D6
