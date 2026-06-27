Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842B3B3BE6;
	Sat, 27 Jun 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573767; cv=none; b=Cyv7vcDe103SuLzYWfFofpGCjOQgHZKA7N7TAZoVwBnTbkbyTOMncGZStfzP+IlDein7LdplRiuGisDwGThP36dvnWGb7RzhIG2zqIZLRfiJN73uGTHI0HXv70qf478fYoStWWW5YLU/gdmCLU6wjGw5ICNR2Xrcgp48APWug70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573767; c=relaxed/simple;
	bh=DdBqRVpUFc6T3qX+WtSuzv+5r9eRC4yUM237TTVE5UY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Em/qJ/fDuknBFwuceAsMYW+8qBIIEg9pM8ZEkocIvk+SiL7A212U84YLTAOJHWtpIK8siDFvDG28dXvUCg8+EgY4hBS6D1uaTV1tKyqZsWYWQKLjCiizETjYDF9Scw4mmbdiCgosdXBWjTZ9sVQlXkeNO0tUs4opqE8xPJiS5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm2LXOPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm2LXOPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3631F000E9;
	Sat, 27 Jun 2026 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573766;
	bh=s2RbOD+3PVSh+ezctvNFtXyG5RIGpYGUgra++DBFVPs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cm2LXOPXdyFg0oEIw86/YctVWB2O03EgiJ0v1Z7trpVoLtlttuN83Qwp86kXQGJ47
	 9aesjKsEnilVNG3/NNVeMgPJAdwhZ2/IVuDZlnZWMnKZsxo6ekNdCAZkeyWtBgs0D3
	 BCUlS7pfEB4uCbwvZZ1vZSlYQcMVt+J+8yqmmZSRyQ6PIJY0swcbskihh7GOtXTDHg
	 3PQwZ8u4yEm7whTaQm7E64DXTB1oGaXbhJXiuZXv4Oh3Bmd1cekuj/ZB2aWOuYO7wM
	 EDuvjnvr3RPftWO5InCllcFdWg797p45g+k+z+VbWX9bvHkBAnVca+Ok6/PNgzs/vI
	 jddNWIA5EmZ1A==
Content-Type: multipart/mixed; boundary="===============0914083358267488336=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <13795f227ac0dcb75bde245ffd80da37bb0f4d9f8eaf5184b05e5c41fbf29d18@mail.kernel.org>
In-Reply-To: <d20d2be69ab6bfa5f81c249bf54c2d47558d239e.1782571533.git.xukuohai@huawei.com>
References: <d20d2be69ab6bfa5f81c249bf54c2d47558d239e.1782571533.git.xukuohai@huawei.com>
Subject: Re: [RFC PATCH bpf-next 06/12] bpf: Add type check for SDT probe site
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,a.s.protopopov@gmail.com,ameryhung@gmail.com,eyal.birger@gmail.com,rongtao@cestc.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 27 Jun 2026 15:22:45 +0000 (UTC)

--===============0914083358267488336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Add type check for SDT probe site
>
>     The NOP instruction at SDT probe site will be patched to a call
>     instruction to observer programs. To ensure the arguments passed
>     to observers are as expected, add type check for bpf SDT probe site.
>
>     The check for probes with no arguments always succeeds.
>
>     For probes with arguments, argument registers are checked against
>     the types declared by FUNC_PROTO for the probe site.
>
>     Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

This looks like a bug fix for SDT probe support. The commit adds type
checking and protection for SDT probe sites to prevent them from being
incorrectly optimized away by bpf_opt_remove_nops() and to ensure their
argument registers remain live during liveness analysis. These issues
were introduced when SDT probe support was added. Should this include:

  Fixes: b96ff657266c ("bpf: Create insn_array map for bpf SDT probe")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28292842584
--===============0914083358267488336==--
