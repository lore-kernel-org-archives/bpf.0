Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D7381AF3;
	Mon, 16 Mar 2026 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650112; cv=none; b=Tqv0bTGaUZ9LIOXrclX5O9InqsHzDaURvT3FZii3N2E4ToLncnZnVFhUbkWY8pjy4XsRkcEz60YhPJsmVu/Y2zUnkmCjfKdS+fKSj0tkzlGawsENx0OLxXF10ZAVhoiyb1jAJEYkglt1L0I5P9qmzbq34UZV6JJy5f7pdSivdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650112; c=relaxed/simple;
	bh=aOaXbifCJ+bskh0vNmbeZi9ldWKBKwd3fIY2ftp62d4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZnFhykD4U1IN4Ae47ZFxGBLc7qBnyyjImzmZo6gBxNmX19BCtbwMCWSVODaprPDh8wvLYLEc/ulpXX3iKCF3fCW+81zEzHZXygNwnIruotOCm3C9nzdqbM/ULSrnjCZm+0YxJBY8FKZpaLIfD4spv9qeKuvoTCiSV+qeX08NJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roBT3Mx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roBT3Mx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68528C19421;
	Mon, 16 Mar 2026 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773650112;
	bh=aOaXbifCJ+bskh0vNmbeZi9ldWKBKwd3fIY2ftp62d4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=roBT3Mx/bgydCSTgQy6AxoDEMGt4z4K3jFNmD23AXIyok0xc08s5yftCssZWwMB/r
	 2aRxIidbJLtS9Ru5sLFyBM+n00Vyxzh3eedUHVu7NbL10yafpqOqPR7PRVJgheQvzp
	 +coprmtps57foCch0lC5VcEjuooir+wJB+60kCGKa25N/l3yTi5eIJaKSzMsK+J5F5
	 YmYIlqMv2nQGJ3/QywQpg9LIzQzC+8rayY35+wB8eyBGmjStGYLhm40ug4u2HSEc3a
	 ydrxo7LQ7kSYdiJ2Fy3mhWe6TAQmFv4aJjavcw1nw2jP8vE9cPrG9zQR7MfcsobhDn
	 NesOj8VddaU6A==
Content-Type: multipart/mixed; boundary="===============4498239069233042298=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <46d7ff451871969354eeff0215fec41d41f1587deb6b0944f8f38184b715e2f3@mail.kernel.org>
In-Reply-To: <20260316075138.465430-17-jolsa@kernel.org>
References: <20260316075138.465430-17-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 16/24] libbpf: Add support to create tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 08:35:12 +0000 (UTC)

--===============4498239069233042298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The provided <pattern> is used as 'pattern' argument in
> bpf_program__attach_kprobe_multi_opts function.

Should this say bpf_program__attach_tracing_multi instead of
bpf_program__attach_kprobe_multi_opts?  The auto-attach path in
attach_tracing_multi() calls bpf_program__attach_tracing_multi(),
not the kprobe variant.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558
--===============4498239069233042298==--
