Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374A199FAB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775191285; cv=none; b=DsVt8NBulfnHeGF/jT39lkSsMXnI94TAiTOqJvMYkfeEzeSWdXv9ZpvdA3Yj3IYkSnWzQbd2c2dz2l/SJUq4mmDQ3A1fmNUgml1DlWXOmHjDHZzdxBfDjXeVjDc0b9Xn/ZgDAnso3+lMVIolAEbfQClxA6vihNY4M9cEtA3QFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775191285; c=relaxed/simple;
	bh=Qy5fQsC3lqK5d3jdFwGq4cNJ1oBBNIluh3isZXPx5rA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YNVg6MwvZqLg0k1TBv4UmRNEDHWTSWCb7MQUxZSCZMjUGwzc6DKnsPguOAILW7r9zZ7/ajnlayPFhgpSTqYUB26/NfVsJS0qQ3YZsXGs5x1+5zh1kYf6pAYGSmG4LWdL4Mo9vK2ClfQJ6QBRtm5scb3avT1iTEFSNGRbN6HD+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrXKOaID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrXKOaID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0649C4CEF7;
	Fri,  3 Apr 2026 04:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775191285;
	bh=Qy5fQsC3lqK5d3jdFwGq4cNJ1oBBNIluh3isZXPx5rA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RrXKOaIDMcLYJxB7SpIJKXc0ith7kpGv5T4JyPVEn0gbFdZ5TDWiqovHa+wl2iLjO
	 T2sJzadCRRzSm0fYu2qJ7eBXfr+maZpcLpFaYJm1Mp1n+vnOqMltNhxb2ocaQjnQRr
	 Tfel2USkk+vtEBr9sfoKmqk/U11vOZlH52n4/cxf3etPJ3hYeQCaB32IcpoZd59w4k
	 0w9Bz8Q9DAI/6p6/pmtD93o8vLYNW4WuKr67yKzd4DLcnIVWjnsl+GYdTnpQCqJZCl
	 nnFCfAjazfT4RxUTsd/BufIYAzovrS2UYU21DI5q/9Ro7OlCsVyA1c6r6t5gH6azNZ
	 p2ezV411lY81w==
Content-Type: multipart/mixed; boundary="===============6721060086328178875=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c9783bba89cc5b4c61a077be8c0b32517455ad02fc98ab42770f5b1d3bd51b63@mail.kernel.org>
In-Reply-To: <20260403035111.4031084-2-bestswngs@gmail.com>
References: <20260403035111.4031084-2-bestswngs@gmail.com>
Subject: Re: [PATCH bpf] bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
From: bot+bpf-ci@kernel.org
To: bestswngs@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,bpf@vger.kernel.org,xmei5@asu.edu,bestswngs@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 04:41:24 +0000 (UTC)

--===============6721060086328178875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> igned-off-by: Weiming Shi <bestswngs@gmail.com>

Is the Signed-off-by tag here missing the leading "S"?  It currently
reads "igned-off-by" instead of "Signed-off-by".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23933352248
--===============6721060086328178875==--
