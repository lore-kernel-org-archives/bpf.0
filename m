Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6804915A0
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045708; cv=none; b=kaWOmlExTsZVqqlGW2VLrdp6TPnZyl/OeAieHLh9H6sNtk6MbzrDBFdETFUD7ZQN2utfpTVeZhu4ggu0RUsI4ivQZ0o9NEMDeKCPYrG/h9mSfZAtKS1h1kHasRoaByNvJoPqSiQzRyJxcQN5axBOLfZsqQtzQzaaEHq9Xm5f9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045708; c=relaxed/simple;
	bh=uj+eBd/f3Zug9TrVB8ngpe/OD1Uth7IX6h+eDg4Lc9s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G2C2IH/ZAp9kxvoBmjzfRDLm7N/Q4pM0QEdMKa//pcsVv/jjfRpA79Twd1KXq9sJ/zzOtNPmnX4kEClgYvPUS9qPqZbBipcWtvZrdPUNAbHVb/tF5VbN/cpDr+PAQbSgIB6CR78CM1bcGfD5xOem+Djb79TV84WjpWXchgN0BBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjbhvHM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjbhvHM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793161F0089C;
	Sat,  3 Oct 2026 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791045706;
	bh=TcEj4URmWKNn52qouK3IsSamBiP+3ScCQhqde0lztnQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PjbhvHM7GvZ+jB6AAg3s0UI3bZFPHb0NNE3dVrrX32KgwUVb6xbql1p8nHkSZxgcy
	 J4TGEo6XLWzPDqxH0P3aEAn9X9dz2N7dBYDymMbmgHhU2CBJBuXYmrU5fjls/Y2QJU
	 sjVKGeAG3j96H4TB2sQNLojP/qjrvon2xJDdZH4LeO8klcyfRW7cUVkaiPWaPRb+/i
	 Wb2WLsxVPR+sNQRyZhug+kS9upKhRF89VIRrY+D7N6lA06zDqSgmjz+3OHrbLA0U9G
	 GrcY2oZS3GobPWb1aHaomkx8Y2fqj1Fh8fWdK7kndtZyFj0gGMh9kUbNw2pb28xUEa
	 0eUp2d+1EciQQ==
Content-Type: multipart/mixed; boundary="===============0599825430489692911=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f1002b1b19865cd8740befb32b9ac7f35438dbd438313d1bc25ee5402912f60@mail.kernel.org>
In-Reply-To: <20261003160213.2641506-3-maghasi@disroot.org>
References: <20261003160213.2641506-3-maghasi@disroot.org>
Subject: Re: [PATCH bpf v3 2/3] bpf: Fix incorrect handling of user flags by percpu hash map updates
From: bot+bpf-ci@kernel.org
To: maghasi@disroot.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,leon.hwang@linux.dev,maghasi@disroot.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 16:41:44 +0000 (UTC)

--===============0599825430489692911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix incorrect handling of user flags by percpu hash map updates

TL;DR: Commit message only: it should list the user-visible changes
(BPF_F_ALL_CPUS with EXIST/NOEXIST now accepted, EXIST|NOEXIST now -EINVAL),
not just "proper flag validations".

>     bpf: Fix incorrect handling of user flags by percpu hash map updates
>
>     For BPF_MAP_TYPE_PERCPU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH maps,
>     htab_map_check_update_flags() and check_flags() are not considering
>     the possibility of a combination of (BPF_NOEXIST, BPF_EXIST) flags
>     with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
>     This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect.
>
>     For example, when using (BPF_F_CPU | BPF_EXIST) flag combination
>     with bpf_map_update_elem() on a BPF_MAP_TYPE_PERCPU_HASH map, the
>     BPF_EXIST flag does not prevent new insertions as expected.
>
>     This patch fixes the bug by adding proper flag validations and checks.
>
>     Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
>     Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

This isn't a bug, but the changelog says the flags "lose their effect" with
BPF_F_CPU/BPF_F_ALL_CPUS and that the fix adds "proper flag validations and
checks".  That is only true of BPF_F_CPU.

Before this patch, htab_map_check_update_flags() rejected
BPF_F_ALL_CPUS | BPF_EXIST and BPF_F_ALL_CPUS | BPF_NOEXIST with -EINVAL,
because (u32)map_flags was greater than BPF_F_ALL_CPUS.  After the patch
those combinations are accepted.

The patch also starts returning -EINVAL for BPF_EXIST | BPF_NOEXIST, with or
without BPF_F_CPU, which was previously accepted after c6936161fd55.

Could the changelog briefly list these user-visible changes, rather than just
saying "adding proper flag validations and checks"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37135877031
--===============0599825430489692911==--
