Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7FE26ED59
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747259; cv=none; b=Uq1bFjJMj11cC8CNGKEPiCyreTbESPUz5jHzFZnUpEljUqbUT6VHbGW6f90OnnC4WU2SlfyGS1sYvuycXdVuTnP5SKCXpt14BroEmEuFJ+2cgpA81DhaemU4IABY3WI+I5kZflyZl3/4W/HTODWVzMd3jLq62zrKpNQ9UEDywZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747259; c=relaxed/simple;
	bh=IeCOwNfz/b0sVItIu2e7aXW9GcF38NDSB+HgI8MLBNo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TnG16g1eSW8Uhf6JQXeq8kwqgYLYDSeM2L6K93YhpmkzgfNUm5NgId3U3nEmIYvigTZ22NorT1lqg0GTYgyazbtdIngUozWeVqEAqTvYL4HidDsIzZbEsWEBnM4UVL4Ylf5rsLGs0hFQrM3wkvdHqP827FE3KCMUMVXq+Ta8R70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrYt83XY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrYt83XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CC11F000E9;
	Fri, 14 Aug 2026 22:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786747258;
	bh=uVzmKXUXQCAKX+3M7RqMNcZQ+Oz/uDvi525yZEig+pg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LrYt83XYKwzRchJPC25nyFK/ZVg97P8/uEGAFoqACdjBnhg6RX1oe5qFVRaRyzOyH
	 wRhrSYrnu0YgrHVTTkna1i6Ag3gnB8S0cran9ii8eIxQpZNgIQhW/fNZNhfc7x7qKh
	 yeETOkic/swG5WK9Cj2ZLQZfc9S9S0lgG6HW6hsr/1op9yX6KEk60jjFSedonudghD
	 BUdTKB7mHc3H+aiKU35rKZcOHICQO3doxGDbY4Z3No6EDv/xoOOLMtjqt+mm2yUjMM
	 O7kHDDc+tm1i+NOvRCqyyVYZ8IkrWoAV8rItstW9f+o4V0+0edMwb8+dLWuZZu/x0M
	 mxCbveTuCYUSQ==
Content-Type: multipart/mixed; boundary="===============7828696089515052364=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5b81c3f28a2ca32623bdc5e1e2ca55d797d37739033a0ef1338f1c93bd6911bc@mail.kernel.org>
In-Reply-To: <20260814215301.709827-3-daniel@iogearbox.net>
References: <20260814215301.709827-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Reject a store through a fault prone pointer
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,eddyz87@gmail.com
Cc: memxor@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 22:40:57 +0000 (UTC)

--===============7828696089515052364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 814096ed835d..cbbb0c82d22c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5788,7 +5788,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>
> -	if (atype != BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)) {
> +	if (atype != BPF_READ && bpf_may_fault_on_deref(reg->type)) {
>  		verbose(env, "only read is supported\n");
>  		return -EACCES;
>  	}

Does this change also reject HID-BPF writes to struct hid_device fields?

The HID struct_ops hid_bpf_ops_btf_struct_access() whitelists writes to
hid_device::name, ::uniq, and ::phys via WRITE_RANGE entries in
drivers/hid/bpf/hid_bpf_struct_ops.c. A HID program receives a
'struct hid_bpf_ctx *' argument that is PTR_TO_BTF_ID | PTR_TRUSTED, but
walking hctx->hid produces a bare PTR_TO_BTF_ID because
struct hid_bpf_ctx appears in no BTF_TYPE_SAFE_TRUSTED list in
check_ptr_to_btf_access().

Before this commit, 'hctx->hid->name[i] = c' passed the PTR_UNTRUSTED
test and reached env->ops->btf_struct_access(), where
hid_bpf_ops_btf_struct_access() returned 0 for offsets in the whitelisted
ranges and the store succeeded. After this commit,
bpf_may_fault_on_deref(PTR_TO_BTF_ID) is true and the store is rejected
with 'only read is supported' before the btf_struct_access callback runs.

The three WRITE_RANGE(hid_device, ...) entries become unreachable. The
commit message notes the bpf_qdisc Qdisc::next_sched case but does not
mention HID-BPF. If the intent is to preserve HID-BPF write capability,
hid_bpf_ctx::hid would need a trusted annotation
(BTF_TYPE_SAFE_TRUSTED(struct hid_bpf_ctx) { struct hid_device *hid; })
so the walked register stays PTR_TRUSTED. Otherwise, should the removal
be documented?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31845722500
--===============7828696089515052364==--
