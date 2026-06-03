Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286D377EB8
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483249; cv=none; b=GBb2WF2IJ5W6fQGlDrwIYT8ZWeglgqfsvzLBsejFztEo4ZG3nWhicwWNVJ5WiC0wT5eTmcK45poJOodPwhYRXQ3pQMlueznki4lrcI08s/SuM0OQjNJh/rhNY3G9xYM3ojprvZtYVPhtNWVQP+o2ahYTM2UuCxb5CJtH6+RP6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483249; c=relaxed/simple;
	bh=BstLxWuGG+6g4CjFilhYfdIVRH2JbDHeXfNS0jfFcJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AdefhEpoz0V4239SJpRdwKP20pnmGsfcTbMN7QqLVo/+HHXJyooJgwKMFtNCyrEA2f3RJZoDqLBPhgP1n7fDULmQuIdK5ffIa/NutzbzA2YCmmI/EPesfLFPBLGzYU59yyuJCI/vh8liFzBXBi78iRNF58h0eg1GjYD6c3bmjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN+JQJ4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN+JQJ4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809111F00893;
	Wed,  3 Jun 2026 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483248;
	bh=kIQKGp14/AiqPLR6UryCxKub8IDUgfGjeEcdO9rWOYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WN+JQJ4GL3ETGxdKOmEy9+Ty2/r/fI4pLBONra9gjzkJI2+ZtYagCSfAId9bEiKcq
	 2v0pBNMj72Ha9qQxzFad2Cdxoo2wWEvEWX2LH3I31njQ9s26aEReduLyFzOoBGABHv
	 dSDEZyiJV7wcrL5pTrWXtZy6+OgEgRobuhCJHwQObNDyr2RRaKYDBPYp60NAwcotLJ
	 EK32wmKbmni481dmCwQwc25qfhW3rSjRzRNuNQgibcaVsTZmyi04S0y1t/FEH9uVyW
	 xKJVo0r5ixpP5zVzeerdaW6r4PwR7YNFJoqMze/dZHi7C1WhnYnWYsN1oY90xtiLhN
	 A7US7ya4MwQHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] selftests/bpf: Add kptr-xchg benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <zhaochenguang@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603100438.2177817-5-zhaochenguang@kylinos.cn>
References: <20260603100438.2177817-5-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:40:47 +0000
Message-Id: <20260603104047.809111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The multi-line comment in `kptr_xchg_bench.c` violates the mandator=
y BPF subsystem comment style.
--

commit 65ef658c1862e0b10ff0a6614c9d69939e4240fa
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>

selftests/bpf: Add kptr-xchg benchmark

Add a bpf selftest benchmark that exercises bpf_kptr_xchg() in a tight loop
so helper vs inlined JIT paths can be compared on supported architectures.

> diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c b/tools/=
testing/selftests/bpf/progs/kptr_xchg_bench.c
> new file mode 100644
> index 0000000000000..ff146e4dcde7a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
[ ... ]
> +	__sync_add_and_fetch(&hits, i);
> +	return 0;
> +}
> +
> +/* BTF FUNC records are not generated for kfuncs referenced only through
> + * optimized paths. Keep bpf_obj_drop() visible to libbpf's kfunc linker.
> + */

[Severity: Low]
This isn't a bug, but the multi-line comment here violates the BPF subsystem
comment style, which strictly requires the opening /* to be on its own line.

Could you move the opening /* to its own empty line?

> +void __btf_root(void)
> +{
> +	bpf_obj_drop(NULL);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603100438.2177=
817-1-zhaochenguang@kylinos.cn?part=3D4
