Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F21E9B37
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187066; cv=none; b=QoxyIY5K3s7kSN01jF7V8fW01Rf2yRTWzFzF7CeOlGRfa0tACQIldn+jVnNP1pZRd/Ufps1cm4OaBM2wdcER3f78Q24C2Ts29BGs/nasKHMS06dXT9flcn1ZJjs2HjmjntC2ZGn4S7AGfa0YJjtG2U9bIdoz6pZnw5EJkLXup2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187066; c=relaxed/simple;
	bh=88/90EY7WT121tc5qi+8CBVLTmvCbhgRigPnwaq9YWg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cGZrxueyBP6dQKcDH/MB4nrz+u3byWsalrM3GKUvi01W+e3HVuCs/Mb47VYifuNm41y9yU6xbaU77NCSgVdsiewgM5XoyFGk6KB00tQJN5/KO8aQxINRISIYzMZ7osdNXxNfbjzzF2KTx7MQihzp1RdaOESjPrP10kBIPeDtZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQDE/qRI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQDE/qRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC221F000E9;
	Thu, 20 Aug 2026 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787187065;
	bh=p67vyU6Em2WNYjhkkgzDWpIBLnEzae7Bf3b447IEKcg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dQDE/qRI+xfmWqYAfnDyIQm3eeVJdGMdUS1+ojHI/ouh/fGj2aXMAAz3GZl+m7Npp
	 xvQzud/nQk7QXUziMYpZ8a8MvH7G08IY2UISaf1+ZD6ABK0un42F6nGo3hIBXoehK6
	 Gc01U7PuzENXgmheFp4XxQz+26wBEeYX7P1KkBkn1hdzjdJ3DesgbyGvPAxRd3bGbQ
	 HORjAUw66SEoLr3kYMaGyrkJRDiHc8OjLhnZqS3CpO7qAcXOzdZFGAvJFFHf4w8j0I
	 lAtOcGm13yZC9UetZgAIu90HluOBUpaR38eNIaiwfqQan8BBfwskj0051eTeLHJzSm
	 sh5LlKsUfNu3A==
Content-Type: multipart/mixed; boundary="===============2787318148574499149=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a6349e7b7969b72d2067db4c8b2e15adf54e96663bbe3eec8abddf56b5679f8f@mail.kernel.org>
In-Reply-To: <20260820000627.3826188-3-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 2/4] selftests/bpf: Add tests for bpftool btf dump format c
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 00:51:04 +0000 (UTC)

--===============2787318148574499149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> new file mode 100644
> index 000000000000..53bb7065b3ca
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> @@ -0,0 +1,151 @@

[ ... ]

> +static struct btf *mk_btf(void)
> +{
> +	struct btf *btf;
> +	int id, err;
> +
> +	btf = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "new_empty"))
> +		return NULL;
> +
> +	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	if (!ASSERT_EQ(id, 1, "int"))
> +		goto err_out;
> +
> +	id = btf__add_int(btf, "long int", 4, BTF_INT_SIGNED);
> +	if (!ASSERT_GT(id, 0, "long"))
> +		goto err_out;
> +
> +	id = btf__add_struct(btf, "holey", 16);
> +	if (!ASSERT_GT(id, 0, "struct_holey"))
> +		goto err_out;
> +
> +	err = btf__add_field(btf, "c", 1, 0, 0);
> +	if (!ASSERT_OK(err, "holey_c"))
> +		goto err_out;
> +
> +	err = btf__add_field(btf, "tail", 1, 96, 0);
> +	if (!ASSERT_OK(err, "holey_tail"))
> +		goto err_out;
> +
> +	btf__set_pointer_size(btf, 4);

This isn't a bug, but since the pointer size isn't part of the serialized
BTF and bpftool re-derives it from the 4-byte "long int" type, does the
btf__set_pointer_size() call still do anything here, or could it go?

The BTF wire format has no pointer-size field, so btf__raw_data() doesn't
carry it into the temp file. When bpftool re-parses the file it recomputes
the value with determine_ptr_size().

> +
> +	return btf;
> +err_out:
> +	btf__free(btf);
> +	return NULL;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32317197542
--===============2787318148574499149==--
