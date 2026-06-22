Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641A228CB0;
	Mon, 22 Jun 2026 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107117; cv=none; b=s9oKV3s8JcKuGB95jbiLdXRzPkBIOlIi3mxl6tcoLuqIrntPS3UUTJEkf7SgoqyJAB8uWgo229kmdS11wPcBIhX6DnoMIYncYG9SpU4z9WcCILtwawwTnifK2GAfiVaqBuSrdLdKc430D/HwZsc2ag+u7lxqXDFReL8UfoH6ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107117; c=relaxed/simple;
	bh=nkZolzewDVt7wVgUKDXJ4Fu8fUcGEueJnMy/zKLise4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z5gFnA2tGp2FGXJRl7us7Dbya4EdUEoie8hl2v7y9y0xBAwG85unrA3qZRxHueVH1Bhh8USBKKhMdJtuqvkmheryhjTJm9L5qj101zycaEGcghXjn/84o9pbZrkghEtQqhY8jJmrETI3Bw4TV6ZNYXN9KW/U1kQtSMNWT33JrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQtUkUXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQtUkUXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A28B1F00A3D;
	Mon, 22 Jun 2026 05:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107116;
	bh=huZ5w/7Swsanuj7kuY72lXcYi/GUKNSXABklAVBl84Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WQtUkUXzGMtBXRHQbhSeC5c0rBEX7JFynvkXNTevSk0hh8NsxJq+HEmArXGKrLkIZ
	 BX6Ih/3myci3bOtuRCFC3YM3jIncCwRslr0aVaL93/lzOyK4ADTvTBFODvKQ2v5LnU
	 n5c3jrKBG1JH5lGPlpy6ZE+8M7HWwRBVYRVguLSBTK7vW1Zab53C8HevcF6q4IuDaW
	 648YMUTCiAcRvivv6/U47sqL7++Af4ElxDdPjR79FO0glmZrlRhihQt9AKkA1ikhKa
	 zC30HpqjxbyxtMChBHpex/YFPrqWPhXx/wWSweGOZbRgm/Q+KxJ8/xXtknD13w89aW
	 7HqPSznAHsvlw==
Content-Type: multipart/mixed; boundary="===============2262182024979101694=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0cef90e92e9f4a3054a75413f47254cad9d78a64f8bce5b8330b35935c8bc3f9@mail.kernel.org>
In-Reply-To: <c230ebd7f2e28e0cc3820bcb2701ec517933063e.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
References: <c230ebd7f2e28e0cc3820bcb2701ec517933063e.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject flexible-array allocation types
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: chenyy23@mails.tsinghua.edu.cn,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 05:45:16 +0000 (UTC)

--===============2262182024979101694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281..c3a574cc0d09 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12749,6 +12773,10 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
>  			verbose(env, "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct\n");
>  			return -EINVAL;
>  		}
> +		if (btf_type_has_trailing_flex_array(ret_btf, ret_t)) {
> +			verbose(env, "bpf_obj_new type must not contain a flexible array\n");
> +			return -EINVAL;
> +		}

This isn't a bug, but this branch handles both is_bpf_obj_new_kfunc and
is_bpf_percpu_obj_new_kfunc, and the message just above uses the dual form
"bpf_obj_new/bpf_percpu_obj_new".

Should this new message also say "bpf_obj_new/bpf_percpu_obj_new" so it
reads correctly when it fires for a bpf_percpu_obj_new() call?

>
>  		if (is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
>  			if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27931273498
--===============2262182024979101694==--
