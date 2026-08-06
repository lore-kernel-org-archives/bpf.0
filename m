Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077448A2C7
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035945; cv=none; b=WVToOt0gtYt75bXffVt8r4nBw2BQqchcqjLWe5pH762Af1n+GvzmBtV2Kr5+9EZXJCYEhz6oSK3YBbC42OJ2ATddTmaRkczskdfLquSHdW3ZDLiQ1BWhU6loUEr9YLar7t6IN3BwCWRY1TuTTATp6/4PryfQJ9y0ORXjEK+L5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035945; c=relaxed/simple;
	bh=mDQICqf/qjK9CxNtPCAaFX4TujTI+hbPy/U0sLlR2xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mUyLHS4jnaEoXa6rjhf175s2g984vCQ7fNkjzSj0chWcHhZQE0FaYzABTMkvJBmKJTcjZeMZdvGs/W1f1L0R65g82MymMefnRN1N7dsxM0jKbdZpoMtbinLl2LJl7JxbGVteLVSHVef/e7n82E5tmhfu8G+p9QKVpLmxkpotnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Assv4qYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Assv4qYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC13F1F00A3A;
	Thu,  6 Aug 2026 17:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035944;
	bh=mr+nqRyutdKmKZo9iA96h0d/LSohI3pHaq9hWm2AGr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Assv4qYktWVy+jMYKLpAI7oveDsIUSZy/ASn8o1Nc3SNA3J0Jpuc+WXp6H2VmaetN
	 sGh2Yej+n/mcj7dUrLYKyMRe2+z/v3jYFktt8Fq506ChWblTRpz06TIE25CPZz07WV
	 k82taLH4ORJRblTyXjZdVKDGPhAlTEWP3mXWvVWrjMVV/fhpZJnT4YU+2VD/zJMbMm
	 0KQE9/0asHx+hg0ML8B/otHZY7P4uoUryeRIvuKzBo4MVaKCmsJ6sJWrMyPkIQM+du
	 iJnjX2z2VDYRUqwsgBnj+pA73mQXVF9oMITEWjEhmwInR6LFXK7CZdVC1uwVKLYYwE
	 Ie+P8F2GYaGIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 04/10] libbpf: Probe percpu data feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806163125.11172-5-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
 <20260806163125.11172-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:05:43 +0000
Message-Id: <20260806170543.EC13F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added feature probe `FEAT_PERCPU_DATA` is never used t=
o make capability decisions.
--

--- Patch [4]: [PATCH bpf-next v11 04/10] libbpf: Probe percpu data feature=
 ---
commit 925264284b89c241360ff401bd914f9c19997613
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Probe percpu data feature

This commit adds a feature probe to detect if the kernel supports global
percpu data. It aims to allow libbpf to fail predictably when this feature
is unavailable on older kernels.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0bb..ef9581c113035 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
[ ... ]
> @@ -707,6 +739,9 @@ static struct kern_feature_desc {
>  	[FEAT_BPF_SYSCALL_COMMON_ATTRS] =3D {
>  		"BPF syscall common attributes support", probe_bpf_syscall_common_attr=
s,
>  	},
> +	[FEAT_PERCPU_DATA] =3D {
> +		"kernel supports percpu data", probe_kern_percpu_data,
> +	},
>  };

[Severity: Medium]
Are there any callers that actually query this new feature probe?

The commit message notes that libbpf can make capability decisions early
and fail predictably when global percpu data is unavailable. However,
FEAT_PERCPU_DATA appears to only be defined and registered, without being
queried in the loader code.

Is there a missing update to the loader, perhaps using kernel_supports(),
that checks this flag before attempting to load percpu global data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806163125.1117=
2-1-leon.hwang@linux.dev?part=3D4
