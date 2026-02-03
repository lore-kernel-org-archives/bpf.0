Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE060241665;
	Tue,  3 Feb 2026 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113640; cv=none; b=eNKA68CTr3XV1C5q821JWzq26JsStZ0jdr0wPEoaJEoZTxCazPTgsz0bdxVJtLANNMq1ztTVj6dJmtRfPGk06xTgwnssU0EcCNHmZT/M23W8v44fswKAGOWZf2nGvU3CNOPTSVIINxUV+7LB2wrdRECIGQ/68r4iRqwE3kC004s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113640; c=relaxed/simple;
	bh=m2LLv3JeVUedBXO+zu8Cntoh21Jan0uxR3E9cw5Riig=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mUNDRZM9OcA7Qqes6kHWfB7Hvj9adHV16NA0BMQbLFtpKwVDe8RbW0bs3ywdb0lQoUzMfzUUXyhimsfzl5itENIXwmDgBIP4bSpYzN19uqpE24t/yX4p1oDQGXVnnhsL5kM1JW3fMk532Isd97Q8pHuVUWfR2UWOMmz6YC4Wecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT6Se7FL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT6Se7FL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4F5C116D0;
	Tue,  3 Feb 2026 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113640;
	bh=m2LLv3JeVUedBXO+zu8Cntoh21Jan0uxR3E9cw5Riig=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jT6Se7FLrjgF3UTns28Jifa/d7HSWjgt8OuvdI8iHVj+ViilUjB4DlUNzVA3XEKve
	 59aLFlmbkCFY3Y6C5WGDBMdNxhbBJHO/noh5q3jwIyNvu5QT/C0hQkwsjI7t7JyVEY
	 wZe6edugNnGbKK0/COe5cMZgIxURqN7XjnBQkqMdVLunxMSy6R2/TDHYmxAjCLknvE
	 pguwYWSMd+1i/HkPBfg/pIWT10kZxsDaIZNmidJI4N7LPrrtuU0Xvnogzru0ITuWU6
	 JeoNPiPtbTTpq3/r2nUWCFMMeDa6A7Jd2hIkvlnT8hBleEuekYlTVIcEK/7Cz75asp
	 1QKnARfYdplLg==
Content-Type: multipart/mixed; boundary="===============9203936643770176435=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <92cab2cedc2a94005b3383f2fa05ce07602cb37ceba65ae30dcdfe70a7f7677b@mail.kernel.org>
In-Reply-To: <20260203093819.2105105-9-jolsa@kernel.org>
References: <20260203093819.2105105-9-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 10:14:00 +0000 (UTC)

--===============9203936643770176435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffc..64502b3ef 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> +			   const char *allow_pattern, const char *deny_pattern,
> +			   __u32 **__ids)
> +{
> +	__u32 i, nr_types = btf__type_cnt(btf);
> +	int cnt = 0, alloc = 0;
> +	__u32 *ids = NULL;
> +
> +	for (i = 1; i < nr_types; i++) {
> +		const struct btf_type *t = btf__type_by_id(btf, i);
> +		const char *name;
> +		__u32 *p;
> +
> +		if (btf_kind(t) != kind)
> +			continue;
> +		name = btf__name_by_offset(btf, t->name_off);
> +		if (!name)
> +			continue;
> +
> +		if (deny_pattern && glob_match(name, deny_pattern))
> +			continue;
> +		if (allow_pattern && !glob_match(name, allow_pattern))
> +			continue;
> +
> +		if (cnt == alloc) {
> +			alloc = max(16, alloc * 3 / 2);
> +			p = libbpf_reallocarray(ids, alloc, sizeof(__u32));
> +			if (!p) {
> +				free(ids);
> +				return -ENOMEM;

Should this use libbpf_err(-ENOMEM) to set errno for userspace callers?
Other similar functions in btf.c like btf_find_by_name_kind() use
libbpf_err() for their error returns:

    return libbpf_err(-ENOENT);

> +			}
> +			ids = p;
> +		}
> +		ids[cnt] = i;
> +		cnt++;
> +	}
> +
> +	*__ids = ids;
> +	return cnt;
> +}

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index b30008c26..d7b47bb0b 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h

[ ... ]

> +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> +			   const char *allow_pattern, const char *deny_pattern,
> +			   __u32 **__ids);

Is this intended to be a public API? The btf__ prefix and placement in btf.h
suggest it should be public, but it is missing:

1) The LIBBPF_API macro that all other btf__* functions in this header have,
   for example:

    LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
                                            const char *type_name, __u32 kind);

2) An entry in libbpf.map to export the symbol from the shared library.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628

AI-authorship-score: low
AI-authorship-explanation: The code and commit message follow established kernel and libbpf conventions without telltale signs of AI generation, and Jiri Olsa is a well-known BPF kernel maintainer.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Missing libbpf_err wrapper and incomplete public API declaration are API consistency issues that do not cause crashes or security problems.

--===============9203936643770176435==--
