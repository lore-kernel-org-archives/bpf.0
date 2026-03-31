Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF822ECE93
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774924717; cv=none; b=O48SqcdQvgxvH9+LbO5rCihDzLEPbwY5q2XxOcOnmTrtm5ReVGQw3siUyOxUmfkw+TWA2aoekjnqHScr2EaSCcjYCZWo7YFCpcCqfeCt/WgTOsKrIKFzgAwU76z54/EmD3L8gy7RfMXoU4mche/HcZTSo5njqlWjz+hMRz0Nm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774924717; c=relaxed/simple;
	bh=JhyRUyWEpnO/iXSYwadk1kXq8yjsGuMVz7FLXZ3wAvI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tOHHm7zPN5D9lIY5Q4ESoiXlaIgAbOBc/KUHSYtqVS57RsGmcfKsIHEPWIR4yuAXRyT60VvrenhmJB1JkD6zwnMEgWERPYMxXrO6HjhMzbW0bgemUEAqN4NJkwBBYwyqOWM+XxsAOI8GmZa12fIQHcbggTmS00XyJQeRa77QqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV0Wtss2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV0Wtss2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3111AC4CEF7;
	Tue, 31 Mar 2026 02:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774924717;
	bh=JhyRUyWEpnO/iXSYwadk1kXq8yjsGuMVz7FLXZ3wAvI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kV0Wtss2rtl4z7R2biizRCqxtBC1Oe75zJBH6aXxzS0/czOJsvDmxkHOuLo0vd9mD
	 qAqNQeRaGbCfbUgw7uG69qNLrdmYkH1LBuTUV36diXHe8+ETsXqSW2AGkadrEJ+vH0
	 BDbHR1SN4Wf9PNYuAfBicOBqzrgj5BF4apKrzki1YBECL0bIam0SHejQzVeTBrFf+N
	 W9hy2k6ezlUX5qLwJI0v7PD8HEV/W3bdvt0X2exvexy0yXABy1OfZngST15FsJGWmt
	 E3VNvFQDImzTs7RB545ciJxYbdX8BkX4zccsPAYypaLeRs29d87gSw9f0EzDTEeTzy
	 Qv3wUnaHyHg8A==
Content-Type: multipart/mixed; boundary="===============0495404066996485630=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fdf52b7b106f1747fc2e4bf11fa34b28f140b5abb1c698c6800ad167130c10b6@mail.kernel.org>
In-Reply-To: <20260330-selftests-global-tags-ordering-v2-3-c0ac61e81098@gmail.com>
References: <20260330-selftests-global-tags-ordering-v2-3-c0ac61e81098@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: impose global ordering for test decl_tags
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,cupertino.miranda@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 31 Mar 2026 02:38:37 +0000 (UTC)

--===============0495404066996485630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 50ca1b6ec8150..3f784cc76f8f5 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c

[ ... ]

> +static const char **collect_decl_tags(struct btf *btf, int id, int *cnt)
> +{
> +	const char **tmp, **tags = NULL;
> +	const struct btf_type *t;
> +	int i;
> +
> +	*cnt = 0;
> +	for (i = 1; i < btf__type_cnt(btf); i++) {
> +		t = btf__type_by_id(btf, i);
> +		if (!btf_is_decl_tag(t) || t->type != id || btf_decl_tag(t)->component_idx != -1)
> +			continue;
> +		tmp = realloc(tags, (*cnt + 1) * sizeof(*tags));
> +		if (!tmp) {
> +			free(tmp);
> +			return ERR_PTR(-ENOMEM);
> +		}

Should free(tmp) be free(tags) here? When realloc fails, tmp is NULL,
so free(tmp) is a no-op. The previously allocated tags array would be
leaked.

> +		tags = tmp;
> +		tags[(*cnt)++] = btf__str_by_offset(btf, t->name_off);
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23775718736
--===============0495404066996485630==--
