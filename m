Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141417D6
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453729; cv=none; b=BmZDF6aCxS6IyGcSeXNYrWqoivogJkollM3rHdtBrvFe9wKPvZOkhpXHO8Gkt5zI1YusUiy+1fEVOJrtrr40s6oWbKB84uOHBg+jN1haK3di5HWvmpYhESXVWGPcF908Q9Di9HBAm/LP/gntTfDzsOwxriO4uhSOQvNfs3FhGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453729; c=relaxed/simple;
	bh=KMEr6G6Jhg0yV1D501uXoprIpSNEPlUgZU2xfb5qyno=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oAtiuByBd86vbXkvj0/2USkIzYzHwugwz5aY6iDIz9xUx8Q8W5trLWEz3PIbWHlzlrUw/kMr0OVJupZTTTwb+0pMblgyEwvh2KOZm68eRqpBZJykMjvygIHjdEfXvHo03HS6wahVM0VQGz8atNipL9FdVwRVu/PhCwYqgG9/KOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpNhJrke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpNhJrke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD81F000E9;
	Tue,  7 Jul 2026 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783453728;
	bh=0r9il7/fOvS9cwlNJM2AuJDMAmTIYJH8f9kWHrZrwe0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IpNhJrkeVIGpj1TcxFsql8xZdOi56ys5v38nBCpJspLnj42er9UObtemjIhYE/HxA
	 X9d9NCyAQXc4AF+sLpuaLRN8nlfYDVYu+ETnprrpW+K5MiFAOJb1e2koPn7SD03wIW
	 SA9MUpjZ0deZr8Wi9FAwuedNpgATehxtEGyA9emciOqSlC489vamh6h95edOdlnKVh
	 wEbh+8DpocN+03DpfxyqkFCaEVDbqLEEznoHU5lRVicaV/Hg1+8H1iZMtVgmgkmxTp
	 neYdmmwOvl3+2qlQKKU4twKoUSY5GCkcmsMxrPtU4sKuPt03qE6P3yt5ZI58E8TN8w
	 1g7pkXGpbmCyw==
Content-Type: multipart/mixed; boundary="===============5747701339641280040=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <922250504401f5ef6fc3998f372e522c5d1d6791fbb778f8d9d0534d371e4ac7@mail.kernel.org>
In-Reply-To: <20260707190214.1997705-2-memxor@gmail.com>
References: <20260707190214.1997705-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Reject writes through untrusted BTF pointers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: main.kalliope@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  7 Jul 2026 19:48:47 +0000 (UTC)

--===============5747701339641280040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> check_ptr_to_btf_access() lets program-type btf_struct_access callbacks
> validate writes before the default BTF access path rejects non-read
> accesses. That bypasses the read-only policy for untrusted BTF pointers
> created by helpers such as bpf_rdonly_cast().
>
> Reject non-read accesses through PTR_UNTRUSTED BTF pointers at the
> common entry point, before the callback branch to handle all cases.
>
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This fixes a write path that bypassed the read-only policy for untrusted
BTF pointers, but there is no Fixes: tag.

The write-dispatch branch that took precedence over the untrusted
read-only check in check_ptr_to_btf_access(), along with the "but not for
untrusted PTR_TO_BTF_ID | MEM_ALLOC" comment that this patch removes, was
added when program allocated objects support was introduced.

Should this include:

  Fixes: 282de143ead9 ("bpf: Introduce allocated objects support")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28892378159
--===============5747701339641280040==--
