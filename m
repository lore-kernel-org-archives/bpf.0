Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE15446074;
	Mon, 31 Aug 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185904; cv=none; b=Qfh9SQBI9esbDZu6weKfKirN2qpJWIAWJIzDcSO685gT++z3TRCRgsFIU0sm0Hbc2EgDsYWx0XLsG7b5q7Ie/oH6ECj7RhaflGdZ5Q4Tr6x8ncj8BIUWjjpXu8icuyhLCAi0bM5eZYYwWG/3AxMJyvShJ3ALC3vdtjgDiXqVZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185904; c=relaxed/simple;
	bh=pnNhEZtfzy7FU5AjKwxKTGn8vSdyNwrrXOGlsVcBEuo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AiJko6n5eu9Zr4lfwajD/Ypn/zPaB+6nw//JPbeHVeoQeApZDvrH7C/OFjZLZYueY0+s6E6tc2EtsWAHFq6te3yA3yTLeHOo3Z50ssWtnEfOdkrh/sqKUJxNXjvOXO+QjI5yWCzVLdtFj00+28k6hMrOAsyPn8A5uMxC95DvL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pec58PIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pec58PIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C641F00A3D;
	Mon, 31 Aug 2026 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185902;
	bh=pnNhEZtfzy7FU5AjKwxKTGn8vSdyNwrrXOGlsVcBEuo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Pec58PIwvVrF94R0DjRChEtV9nY1tsQ0I0n4ppIiLSfrd5l+Ijk4NQjz4GLVHBYIe
	 TbKjiPjAd/xqyOHER9mX0t5YkIUkPwLyJVG/7HuXq2wUcnuu7CwBqXbcXWwHBot33n
	 Q5ASRor1jciGLLFmMumdTaEKP06S11CwR08cK+V+XyChQ0k+hSx9fs0uiW4OpqgzbA
	 IZOn31ERUhKe0EU9nfbvZUNK6ESwUgRlfDCVO47bgO1yWzaKUE9M5LEILkZMr6NJBU
	 5UYP7mfPOX512Ykr9SJ++9I28Fwvdglsnkjr/+9GoUwMkDabA4KioECE9RmdyLOC1y
	 dqksxdDf1UvuA==
Content-Type: multipart/mixed; boundary="===============4942061954748237564=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b256533a30204621a9d7963031e0033d87a88f0858ce6c6286a2fc054dd6ca11@mail.kernel.org>
In-Reply-To: <20260831132648.65843-2-toke@redhat.com>
References: <20260831132648.65843-2-toke@redhat.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: selftests: Check for flag presence in bpf_program__flags()
From: bot+bpf-ci@kernel.org
To: toke@redhat.com,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me
Cc: toke@redhat.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 14:18:21 +0000 (UTC)

--===============4942061954748237564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: selftests: Check for flag presence in bpf_program__flags()

This isn't a bug, but would it be worth using the same 'selftests/bpf:'
prefix here as in the later patch of this series, so the whole series
reads consistently?

The sibling patch in this series that also touches
tools/testing/selftests/bpf uses 'selftests/bpf:' as its prefix, and
mixing 'bpf: selftests:' and 'selftests/bpf:' for the same directory
within one series makes it harder to scan in git log --oneline.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33398158091
--===============4942061954748237564==--
