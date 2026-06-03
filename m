Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF11408017;
	Wed,  3 Jun 2026 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481090; cv=none; b=mFERT8YnYnORphYUwiRNtgsJm8R5Eh+kX5JocvgOomUgqadRBgXxFSH3djCDoyCn6dN98MXY70OwWV5bTab49GxI4rTVJ2uFfTxrgcjGgSQhPoTPeKa/eSUpDWp5k9+o5sXGn9ZQwd7t+8htzIc8qbPzrwzsVasCj1lSu1XTqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481090; c=relaxed/simple;
	bh=v0hw2/HKtZ0jn+W7IBWh3fjD8gxS+wtO73RQ1qyqtwQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GwP5Jwup4D4AJy/2TKbQuFgE4g3G3GmDXJCQrWxWkz7me3jU6hA5PyEvaPUuUrvYSaZ4q/GHdMD1DQALGlzHyimMXE9Txj+Jg8I5lSIN6Z7Crp8i0k/lf4sA327fqvq+KuqtHZ5k+GiubAahgD9vEAaxq7bsmUWOzYZl9C28o04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sys/8VLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sys/8VLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45C01F00893;
	Wed,  3 Jun 2026 10:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780481088;
	bh=9GcmqVO/8+e8ziDng5PlXoujz8XaRdrBzMzktUibbt4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Sys/8VLIcxEe1tu7mSK5aHb3Gfh9in0UJqDFAfsjsDwGRTJZ+KRBXDzComWpDcChC
	 NaGYMDwpuIYFo8y5FFe5WrcgEN5ZqmFukb+AsheEELbVE2nXbYgYNUnlmYQzimckgn
	 QsxKpbAuKQQXqv3fQnXrD8qkdPVEOHTwFAxn7FVFvwNrbpPozGMHjmrftmAbmOEqEf
	 L7fT+GnWu3I+WPaAzKm3vOt4uMMNXnX/Id1H+dgH7dnA2uGEIMSKzlQ6nGegwTwaqe
	 UY8StG91a2o0g/nzyirLe3Zeu5BqMdo5wJTYKTv69KKEVlX8ZJD6P16yHY5cIq32se
	 Noav5YafdndFA==
Content-Type: multipart/mixed; boundary="===============2685360771759624979=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <311933301e2bc7d8e730b94fce0b2bada789161c7aaf2fd7850843e575a61b5c@mail.kernel.org>
In-Reply-To: <20260603091910.7212-1-chensong_2000@126.com>
References: <20260603091910.7212-1-chensong_2000@126.com>
Subject: Re: [PATCH v5] btf: reject to register duplicated kfunc
From: bot+bpf-ci@kernel.org
To: chensong_2000@126.com,martin.lau@linux.dev,ast@kernel.org,alexei.starovoitov@gmail.com,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,kaitao.cheng@linux.dev,leon.hwang@linux.dev
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chensong_2000@126.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 10:04:47 +0000 (UTC)

--===============2685360771759624979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 68921d9172b5..03fca4902cbd 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8757,6 +8757,39 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
>  	return 0;
>  }
>
> +static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
> +{
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	struct btf_module *btf_mod, *tmp;
> +#endif
> +	s32 id;
> +
> +	if (!btf_is_module(btf))
> +		return 0;
> +
> +	id = btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);
> +	if (id >= 0) {
> +		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
> +		       func_name, id);
> +		return -EINVAL;
> +	}

Since btf_find_by_name_kind() matches any BTF_KIND_FUNC entry, can this
falsely reject a kfunc registration whose name happens to match an
unrelated internal or static function in vmlinux rather than a function
that was actually registered as a kfunc?

With CONFIG_DEBUG_INFO_BTF, the vmlinux BTF contains all global and
static functions, not only registered kfuncs.

> +
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	guard(mutex)(&btf_module_mutex);
> +	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
> +		if (btf_mod->btf == btf)
> +			continue;
> +		id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
> +		if (id >= 0) {
> +			pr_err("kfunc %s (id: %d) is already present in module %s.\n",
> +			       func_name, id, btf_mod->module->name);
> +			return -EINVAL;
> +		}
> +	}

The same question applies to the per-module scan, which walks btf_modules
and matches against every function in each module's BTF.

Could this introduce a load-order dependency between unrelated modules?
For example, if module A has a static function 'foo' and module B
registers a kfunc named 'foo', module B's registration would fail when A
is loaded first, but succeed if B is loaded first.

A module's BTF is also added to btf_modules at MODULE_STATE_COMING,
before module init calls register_btf_kfunc_id_set, so could concurrent
module loading expose raw BTF early enough to cause spurious failures
here?

Would it be more robust to check against the actually registered kfunc
sets rather than against all BTF_KIND_FUNC entries in vmlinux and every
module?

This was raised by an automated review on both the v4 and v5 postings
but does not appear to have been responded to:

  https://lore.kernel.org/bpf/20260603093823.B11CE1F00893@smtp.kernel.org/

> +#endif
> +	return 0;
> +}
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26876238212
--===============2685360771759624979==--
