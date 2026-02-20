Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27F30AAB3;
	Fri, 20 Feb 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586686; cv=none; b=ex/TYlhR6TLhIm5E4qS8PWdNT7bYGkKTQLgERrZb9+eXC9OmzS7Wtwly5KNrusv/dPc/CNzm1021lkDQRCXjmKhMDdJYwuG7/nqjgybAgTctYweH4NBRhM08RgnH1c+tzqOzf99qsi4ds1k1fEfNPYPykm6HhOzOKr01AGJ/qGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586686; c=relaxed/simple;
	bh=OXkTL93WModJU3+hk+gCyP6KaBofCe3tCh3x9Dblwy0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VFTKyVXXxkex2qMioQgxvW7Jw5lJiY/umweCpQed1zdnlgWWcCwAp5S3ZRCf4s6KYenXY/o0tos3sz78hLJYgSObsPGnk9lDqfTxkULVQOiGIECdI+ftIzc7PX0UWhq8X4SXYZUXHeH1r2W2WadAPU59/3K5KWF9r0qq6YSF3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjDIKXT4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjDIKXT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6FDC116C6;
	Fri, 20 Feb 2026 11:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771586685;
	bh=OXkTL93WModJU3+hk+gCyP6KaBofCe3tCh3x9Dblwy0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cjDIKXT4MMxKR/ldjE5GuawfcXF+5wrMCBxLJKM6vH/g5Eg09icOrCFFZlJdNLDdb
	 43m8BI/DPio4VYCyWfkiCA89445bwlncBf374vdr8FZBIOhdfIErUpWoFT36X6g9RE
	 B9Ul0Do+RGNilKIovbOQIXZyWG2auEC2F4cTdWCNIaHuoh9uf6BvM+1F5UPI+/QWtM
	 unnjtcSpel+tNeNhEp4zvp6LbNp/SYaFTVBv3KEzwXpyVX/B4yzi9eHrjOPQP7yeMR
	 gFoFS3QwFO6jGuxwNdgH9A8YEbOjUytZM2Gsv/BsLhkk41OyRP/z68E8yIioSkRPWV
	 vLpq1xX8GMbNg==
Content-Type: multipart/mixed; boundary="===============6439054443298596662=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e46ea28bf48fb9ff5ba205036a6baf0427f7646870cafc98b387940f99a848d8@mail.kernel.org>
In-Reply-To: <20260220104220.634154-3-jolsa@kernel.org>
References: <20260220104220.634154-3-jolsa@kernel.org>
Subject: Re: [PATCHv4 bpf-next 2/5] libbpf: Add support to detect nop,nop5 instructions combo for usdt probe
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,songliubraving@fb.com,yhs@fb.com,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 11:24:45 +0000 (UTC)

--===============6439054443298596662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index d1524f6f54ae..c81e0a58caf5 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c

[ ... ]

> +#if defined(__x86_64__)
> +static bool has_nop_combo(int fd, long off)
> +{
> +	static unsigned char nop_combo[6] = {
           ^^^^^^^^^^^^^^^^^^^^^^

Should nop_combo be declared const? It is a read-only lookup table
used only in the memcmp() below.

> +		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +	};
> +	unsigned char buf[6] = {};
> +
> +	if (pread(fd, buf, 6, off) != 6)
> +		return false;
> +	return memcmp(buf, nop_combo, 6) == 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22221513473

AI-authorship-score: low
AI-authorship-explanation: Domain-specific optimization from established BPF/tracing maintainer with iterative lore review history and deep x86_64 uprobe internals knowledge.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing const qualifier on a static read-only byte array is a minor C best practice deviation with no runtime impact.

--===============6439054443298596662==--
