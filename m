Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D73A1D2
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774721929; cv=none; b=Sg53GA7s4cyN72mW7Ufa+ZyrwwOxFEabwKQhp8sxKm1IdUu8gC4HlU3VFeUxiRX0+Km6eHjl45aaWgcAoonZx9ijZbFkmYxp9fetCnUw3x5/wbDQdUTxXAPhcME3bgKt8r350QpKknVwZMh1yRB8/l61dNGzl7AyE1epi/7tleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774721929; c=relaxed/simple;
	bh=NpWqHP7K3Jdj87gX04eiE9WOu1WIHcokuiXeJsjPkKU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VmFqCTf9ozsoNMRzK+hvi04P7s4RRJoSTPN/I5MuZM6IjPde6IxEuN3+Y51m8sHbwj7WYCNuUU2AkDUFYa26vH1n9co3nDacbtm/u0Xv0lbkrgjwBv1ciah5PsIEfFEAPDuMrzoSaQpf5cGtD+CUSS/5c4gOKhBSbAvq2T0+NXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eyz16UJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eyz16UJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CD9C4CEF7;
	Sat, 28 Mar 2026 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774721929;
	bh=NpWqHP7K3Jdj87gX04eiE9WOu1WIHcokuiXeJsjPkKU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Eyz16UJFT7g0OWcS6JZ76aQvYajCjnyaiBT1AXrjZ0Yll7Qv+YWv/nNZp1YO1Vl0B
	 G2CGMD5yh9WAABSV1gYDkZPjLTdYWmCufP+aYthPj8FMZ6QZ5QNLOt9OXnAv3RUeq2
	 fnZqWF6Y8l6nzct1c+Xr/z9Bd4NI64VtclDjvMlcUWPDIqtqC3C1j8s8fpkt0TEEn4
	 GJsXYbDgCmSNvqqP0+1cdf/90aOr27W7ohwKC0e1kwhB435WWNe6bCzh8KNShOhIqD
	 zV7scDnRamS7b0Pc0DEiKEqyYICOUXtYaQXHVGNWoRKHFxuNUXt+6sykUFoHFYpvqz
	 Yfju4jxlEhXRg==
Content-Type: multipart/mixed; boundary="===============1761448248855811369=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <620b67d9ebf7d2bee1a7de223ce6e1f19e044a7b75b7e6b83aea1427600b9e07@mail.kernel.org>
In-Reply-To: <20260328174428.3554328-1-rhkrqnwk98@gmail.com>
References: <20260328174428.3554328-1-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix RCU stall in bpf_fd_array_map_clear()
From: bot+bpf-ci@kernel.org
To: rhkrqnwk98@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.next,andrii@kernel.org,martin.lau@linux.dev,rhkrqnwk98@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 28 Mar 2026 18:18:49 +0000 (UTC)

--===============1761448248855811369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

This patch fixes a bug introduced by commit da765a2f5993 ("bpf: Add
poke dependency tracking for prog array maps"), which added the
map_poke_run() call into __fd_array_map_delete_elem() without adding
a cond_resched() to the bpf_fd_array_map_clear() loop that calls it
repeatedly.

Should this include a Fixes: tag?

Fixes: da765a2f5993 ("bpf: Add poke dependency tracking for prog array maps")

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23690982157
--===============1761448248855811369==--
