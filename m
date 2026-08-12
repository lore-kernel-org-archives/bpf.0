Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DF331222
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567352; cv=none; b=YIgJWXln6oPqPSSonr9IwqNgDSh9XEQgs0opoOaYOcnBgMkhZXDNatZTanlLVTd3uNZd/7NiYmlBVbSMhcVwsQ3AvyMAHu2Vb/vWy1vSy1RkyOJ82/7cjrIr9yBonLMESRTE6hshCJru6Yk89rfPG9B7onKJwO5sIYgOU4oaYQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567352; c=relaxed/simple;
	bh=ftXElRX3LzDiLzYxm7lLQAzdM52VPs9g2azlusow1dQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WeKo6kJga/sSTbqLu8wr+2HOHpqTddPMFY3f+bJIeAD+8oFGSlurvnmX3cJ6YV9n9Lm5I9wtO6nzmzECyRyeqEJyrmLq7Cp4zuUu2X+0+aiClG10HdpM4MfOAKqt9akZz8RgYkGqqikJi0A+r7kmu1gVdfrLszwPaGzQwU+Czok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC1lwoSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC1lwoSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC24D1F000E9;
	Wed, 12 Aug 2026 20:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786567350;
	bh=ftXElRX3LzDiLzYxm7lLQAzdM52VPs9g2azlusow1dQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MC1lwoSpxe6zBjT73EN1SIRWL+NXPlP1b8aFmiGwNUI7deqTi58SNf2l3asIRi7Qo
	 tLCcsYmadXdTo8EYMDNuHC18ActJO2xk6aT/jQRPT3DmqljcSSKiymsSXAKL6R84eD
	 tHSzcHxQinES4X+d0YBudUiN5vHtCAppKL8RKbKMCAFxnilXIMcvs6os9cecQJhp+w
	 6KTn1TWHcEgqUJjsRRAr+xx78S5V2/14nAUTzsyQwerZZ5JMaEvKUNAhLrxmqAiBpR
	 paOZVbP8WWuqrgjWAciqlGZ341C7h1Kbu34D2soqTxVD6NViQxhjg1nFvLFVB+Rg7v
	 IyoxCI6jOrUwg==
Content-Type: multipart/mixed; boundary="===============8653521287435386236=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aaac1d4309af7156ec7bd359800ddc8874c1b1aa73751c45f5a068765742cd7a@mail.kernel.org>
In-Reply-To: <20260812193842.2879226-3-memxor@gmail.com>
References: <20260812193842.2879226-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test resolve_btfids arena argument suffixes
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 20:42:29 +0000 (UTC)

--===============8653521287435386236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test resolve_btfids arena argument suffixes
>
> Add a suffix-only kfunc declaration with arena annotations on all five
> arguments. Verify that resolve_btfids emits address_space(1) type tags
> for every position without KF_ARENA_ARG flags in the BTF ID sets.
>
> Represent expected arena arguments as a per-parameter bitmap so the
> test covers suffixes beyond the two positions expressible by flags.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This isn't a bug, but would it be worth mentioning kfunc_f and kfunc_g in
the changelog?

The description talks about "a suffix-only kfunc declaration with arena
annotations on all five arguments" (which is kfunc_e), but the patch also
adds kfunc_f (a mixed prototype where only the second of three parameters
is suffixed and the third is a non-pointer) and kfunc_g (suffixes combined
with KF_ARENA_RET).

kfunc_f and kfunc_g arguably cover more interesting cases since they pin
down that unsuffixed and non-pointer parameters stay untagged and that
suffixes and flags compose.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31635245405
--===============8653521287435386236==--
