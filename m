Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B036D9EE;
	Sun, 26 Apr 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777219900; cv=none; b=kcNSaec55yYrvH/aJ5rD459NodXJczyMDZjA6I4LapoXozwDhrQXCF/eVyys0ujXMzmd3CeHCQ839I5C9lqBXea2/C+J9LYjx4sv/f2An12u/A95GfSsuMcoy1Btr0UmtDssw6LxIqWAqRXMhgv7mEdS2EWt0n6D9PK1rSO+0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777219900; c=relaxed/simple;
	bh=b9JLA/2q6TtRrMDMO0AudCSw4T6WWbvj8Rb6vG0+HRg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nYa7cGaoIGZaW1OL5D19D3yEw37NwXX/qdP8kyOO9syaSSSkW3tdnYOp3hTZ5puGhIuqVhSmX7M19QmXBexkzfmWqlkWl0FlsQIbrcWzHryhe0/lF5cDdux0WgPk3+dXTbSEHxrLTF99YpwTkR7gLg0fr+D77JybYXoSPFCgkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHSVJp7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHSVJp7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8CAC2BCAF;
	Sun, 26 Apr 2026 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777219899;
	bh=b9JLA/2q6TtRrMDMO0AudCSw4T6WWbvj8Rb6vG0+HRg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rHSVJp7SLAVhCQDVMSoj3GxWnaZ3FE4dnjfp8FN/ZPHFLhI7JXb9x3ly/oUpPIh2k
	 IzEsuz0rVu5CoPvUS5i8CAc7QD71hKrndxkuOisOd05h72ncmWrTYLnYH4blZqYoj5
	 CfGd4QBpkbZX2vrxQqnB+rzbL4I3H4OZ7dtjSTTrvLKTk81JbWJ89BCShinmvNd8uj
	 Yyq8BGufGIDppKXZp0rzczAoaDYkN27XwGwVcrn4OP+pAWlPn8BAVV/lLT9HT/yBnP
	 zFie0w7vEExI8zNUaiDfB83BpN8A6CEvd6Y+ve/DADbQiwAT8MQKBebJIgAGxvqDah
	 z+F/b2CJ8qXzA==
Content-Type: multipart/mixed; boundary="===============3422819452575301484=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f5f6a09960ca2e06e4c118e77fec34ce824fc68fe47788012e7cba4cc355b5b@mail.kernel.org>
In-Reply-To: <20260426152759.1932675-1-graypanda.inzag@gmail.com>
References: <20260426152759.1932675-1-graypanda.inzag@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix off-by-one boundary validation in arena direct-value access
From: bot+bpf-ci@kernel.org
To: graypanda.inzag@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,greg@kroah.com,security@kernel.org,graypanda.inzag@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 26 Apr 2026 16:11:39 +0000 (UTC)

--===============3422819452575301484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>= to correctly reject offsets outside the valid arena user_vm range.

This commit fixes a bug but lacks a Fixes: tag. The commit being fixed
appears to be:

Fixes: 5a2f726fe6d0 ("adding ci files")

Should this tag be added to help with backporting and tracking the
original issue?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24960599139
--===============3422819452575301484==--
