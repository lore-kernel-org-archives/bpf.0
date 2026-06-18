Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E335F619
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754746; cv=none; b=SL+cc7vlQzO4lXEDn8Cz3NcTgktDlLQR0T0e3rtMgVb3Np9K9LNdAf2ZOOUBMNdyrcEuTE8p435qXxKMKo3bnVa2t0WZfHhWt5/yHWVaGUyW/eYB0bReUk3CJp9p34UD4zKhrIFHArygmociSDvCcUz15SgXAPh8BwR7nWaG1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754746; c=relaxed/simple;
	bh=BQNh/DtST9OOQ17vCHJtWdOK4qHrl47TeiU0NnVlpNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uxmzrBsJcJ5lgKj2sG9BeMIQGA+RUsaIknq/fXniJu1xxkas4Z80FUQ1zlVCKUHZv2q/ucJEDVV8bagNKfXe4b7VDnDL4wwCJggzue3kPhovjoxknw7dfiR/WjfQUao0Xw5zel6Tmn7v7vjtKrtBww/UzMaJD+nJJOyrrPMR814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d35U6D3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d35U6D3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8801F000E9;
	Thu, 18 Jun 2026 03:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781754739;
	bh=MFJLvpKB4/Ig+sCCyU/JLQPvsh3B6oxZwEqZBbdyzOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d35U6D3z4XwRUdMj4h8upiR4Kr2EnAGUKLi6zuABMx6/srbIOqyuWvtqLMny7HG13
	 cCFEHutj2HVeuXIeqBpdXRs2JZ3Tod0co0kbnBJG00383fTSqc4+L9HjNHhdQcZV0u
	 YJ97NisGVc2z/ij6jzvlH/rAjyiYcDb40pYxa2mlyMDZ5x/eXgCEmw66siLGOI//E1
	 dobiWqecjJLRwPn0Ti8g58i5xoMvwloESABsme6Z5aZnLwbYlzSDYk5nwrzH2jmzAi
	 apRVlMojXVPNFKLVmZidIjNBrvCiwcWZgSTom5UYmjrlKyAlFKlUY5Du53ueDE53Pi
	 Gw+nfAZRz4S0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] selftests/bpf: Add LoongArch deny list
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618033809.98253-5-dongtai.guo@linux.dev>
References: <20260618033809.98253-1-dongtai.guo@linux.dev>
 <20260618033809.98253-5-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 03:52:19 +0000
Message-Id: <20260618035219.7A8801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `arena_spin_lock` test program relies on BPF atomic operatio=
ns on arena pointers and will fail on LoongArch, but it was omitted from th=
e newly created `DENYLIST.loongarch`.
--

commit 4b438bd9b260c0e4fb1672644286e66f7e59d089
Author: George Guo <guodongtai@kylinos.cn>

selftests/bpf: Add LoongArch deny list

This commit adds a new test denylist for LoongArch in the BPF selftests. It
disables the arena_atomics test because the LoongArch JIT does not currently
support BPF atomic operations on arena pointers, which causes the verifier
to reject the programs.

> diff --git a/tools/testing/selftests/bpf/DENYLIST.loongarch b/tools/testi=
ng/selftests/bpf/DENYLIST.loongarch
> new file mode 100644
> index 0000000000000..925005e4298fa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/DENYLIST.loongarch
> @@ -0,0 +1,2 @@
> +# loongarch64 deny list for BPF CI and local vmtest
> +arena_atomics					# JIT does not support atomics in arena (verifier reje=
cts BPF_ATOMIC on arena pointers)

[Severity: Medium]
Should the arena_spin_lock test be added to this list as well?

The arena_spin_lock test also relies on BPF atomic operations on arena
pointers through atomic_try_cmpxchg_acquire(). Since the verifier rejects
BPF_ATOMIC on arena pointers for LoongArch, will arena_spin_lock also fail
to load and cause CI runs to break?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618033809.9825=
3-1-dongtai.guo@linux.dev?part=3D4
