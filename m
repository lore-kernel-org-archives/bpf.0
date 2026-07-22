Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA5318BA8
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698482; cv=none; b=nqjGQOBZWByZqE6rqLoqO81XO4o0oFZ064B+XwAoLwUsSnrOpLSs6G/v2YNp+2cW/tiTydF5NPIi0I9NBL8qbupqZBIX3mBmbwiH+94hyuKH4DY2qDaWXs0zsE+j9g4wST9q9qBcufh5sj+QfkUJDWDcYa6EGIgbfxqo/WFdpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698482; c=relaxed/simple;
	bh=eLclA0SZOSkB5OEe0dyJaBaEuOKY8HB5P+t15WLH3PM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ajWeThtZgNm3RqJJFd+XTxn+0sIKJwFI8cCZ1ZBN+muWbZA9YvAnuglTQGixIJ7gHmLAZjQdP/JH+UWvUx7Fhv8vvZpVRW2F3Qwip7wwiV+fDbGh+NCNOhzH0z8O+9oBQUA9UfHvUHUHPfofmAvGnL3LnHN6oBVy4LLMypmuNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2jqfNF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2jqfNF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FAB1F00A3A;
	Wed, 22 Jul 2026 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784698480;
	bh=mFf9aCHpLWTWPcEgso6hUY7vO55NgTBwaQxoLjmT7Sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2jqfNF9cXIZFp638+4FlT0X8PGoqPM2Krh2IO9yV9CcG4/OFDcGmBnhZB5D96TsR
	 4YDSu7WYoEsI4xWb+CQh5ZqoF/3mZrRyXItZNA7/6GV9n8detlV6ZgclE+L3L082Np
	 Y+4Ynl8CfejVm3gorWZDAVzszabWlOzy0otg3jvUcUspnk4/dakB8ADs6UqNQ1lH8B
	 3esvbJhZ0fZHADSPWJ0KPjP5XPUx2hXrFMWyEzAJ0lyq4etkZoHQSv5IR4T+GvLr6K
	 kIp11/oEgnPn34kONnfa6yL9+Iu7FX6H9yf3YPfKx76YdHT/CXav1iFYFeES64FUtg
	 95g23//g4GyZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Cover commuted pointer
 state propagation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <c1023bb6c9e24d98cbe69f63e1df487f4d490108.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
 <c1023bb6c9e24d98cbe69f63e1df487f4d490108.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 05:34:40 +0000
Message-Id: <20260722053440.93FAB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment uses the deprecated style where the text starts =
on the same line as the opening `/*`.
--

--- Patch [3]: [PATCH bpf-next v3 3/3] selftests/bpf: Cover commuted pointe=
r state propagation ---
commit 39ba76cb345769c48c9359e58e1fcdae124fef19
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

selftests/bpf: Cover commuted pointer state propagation

This commit adds verifier coverage for three cases affected by preserving
the full pointer state across scalar +=3D pointer operations. These cases
include stack frame number inheritance, readonly-untrusted memory access,
and dynptr data-slice invalidation.

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index 94489ac64da8e..7da4266bae09b 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -1635,6 +1635,37 @@ static int callback(__u32 index, void *data)
>          return 0;
>  }
> =20
> +/* A commuted add should preserve the parent id of a dynptr data slice.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style? It looks like the text starts on the same line as the
opening /*, whereas the modern kernel style guidelines typically prefer the
opening /* to be on its own line for multi-line comments.

> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int dynptr_slice_commuted_invalidate(void *ctx)
> +{
> +	struct bpf_dynptr ptr;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784696371.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D3
