Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9812D9484;
	Sun, 28 Jun 2026 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782669612; cv=none; b=k0WMDcUYRS9KgqQFO5Pi/aA7TAeN56v5YrIFTGgrPYwUmPoI/zgzZ1C7llUv5TGD2JQf5h4/BxVWfa4MZqYwTZSDyeZJPJ7fijYOEkTBCsdgQTXhvlmDCZlLjw49SCq45k9FiI6Uc0C9yr8EbBXnAjyeQZ/slVlWWaNVokw1RTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782669612; c=relaxed/simple;
	bh=6fYTUS5K2aiqi9gethG95Bw4Ab0tPoP0XerX2NFOF5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWQUj47OiXVqWg0wDF/bMMTgVfVUXXs1PVXVssgthYhrXMgzvUDlOee1HlGJeyBq/hVyIyZPV9gRsXOvkwFRO0bYvWxz482AOqt3AZPk2IcpTDXMjODRuBxR9nAGrFRhJAiQbDq1YICDB8pZjCSmC3JML2WJWQrQXe1blfHbBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWwU0FSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWwU0FSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDB91F000E9;
	Sun, 28 Jun 2026 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782669611;
	bh=m4w2zYR4pkagcbFIWL/+If5a2G2VCWitoOLDB2Gmh/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PWwU0FSJCwADrUnl65r7aAB8aO+AHlVhiUTDhA4AjNIFZzLKYFZyHjFl5A9THhBHq
	 jT+T6RxfNu1zxBa2mqatTEUgTYHl1YsU24Xvh5llzdCK7nbU6FTywcMfPLAaq8O9Wi
	 jU4HQZ7WT30xvzqUyK23nXwABnwdzuGF4UM2aRc9Wks1q75/8lpxfGAa2o9I3tAaYD
	 bEWtY51EvttcdtZEvNdz9EoV5NlnjtzvnM9lEpPxs8eFKDToSJm1z3qPe0LmUultfH
	 m4a0uENHG+OvE/l49mJdqBiZXB9SXhBhT2ZUMmIMUYuwpYHv7lmC/5H6Hd/P6BlA5Z
	 zaxzk6H7yxdew==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Varun R Mallya <varunrmallya@gmail.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, pulehui@huawei.com
Cc: alex@ghiti.fr, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 puranjay@kernel.org, shuah@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, varunrmallya@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] riscv, bpf: Remove BPF exceptions from
 BPF CI denylist
In-Reply-To: <20260628081710.113333-4-varunrmallya@gmail.com>
References: <20260628081710.113333-1-varunrmallya@gmail.com>
 <20260628081710.113333-4-varunrmallya@gmail.com>
Date: Sun, 28 Jun 2026 11:00:07 -0700
Message-ID: <878q7yy28o.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Varun R Mallya <varunrmallya@gmail.com> writes:

> This patch removes BPF exceptions from riscv64 denylist on
> BPF selftests since support for exceptions has been added now.
>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.riscv64 | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing=
/selftests/bpf/DENYLIST.riscv64
> index 4fc4dfdde293..9268351ce4c1 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.riscv64
> +++ b/tools/testing/selftests/bpf/DENYLIST.riscv64
> @@ -1,3 +1,2 @@
>  # riscv64 deny list for BPF CI and local vmtest
> -exceptions					# JIT does not support exceptions

Hmm, reading your cover the kselftest run still says "#113
exceptions:FAIL", so from a CI perspective this is not much help. ;-)
Can we restructure/split so that we're not bitten by the lack of
BPF-to-BPF calls and tail calls?


Thanks,
Bj=C3=B6rn
