Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4B30FC27
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650400; cv=none; b=jd+CHN3QHCHEQf64HV2XbaXHI2JCxbxjNbeFNDRU/J8OBHavrH8alvLNUNStN+ORse+Mxkk/ItS7UC3zVaiFNDpcjX0UduegZcuWmp3QAloPDKgkTkR9FW8DOywbkiLJP9YaEF41TigBPHkEwVMI9s1L84lnxjcKFbR4CW3KJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650400; c=relaxed/simple;
	bh=/NkO3PanqqQzXVlk+swFj1IdAFqyxC5UOGxXnTKiVyM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=han1/jhFXp58xY6CCgsB0OPDdKZds9YRMTqorB6v5KW+ggwhquS84IwSEoSL3o4BvR/3nq9x2yIuYFfOUQulMK84D7a34OzuUqECUr4mRD2Butx9hbBHlbOPjct/LjfmHTSoGM5J2RDZuhV6I+ChWklG3LxqfqlbI1zXkK8mCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDoFda9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDoFda9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E856C2BCB7;
	Wed, 13 May 2026 05:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778650399;
	bh=/NkO3PanqqQzXVlk+swFj1IdAFqyxC5UOGxXnTKiVyM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TDoFda9ewfHPlGD18KgHAfkxDufdzm5Ks9bzcduk8V+1ldNEC96cnsKn8TpeKcEYZ
	 qa3nAi/UGwomgIUPk3fZ+k468g1zJKCV9U3fDtAua9E/swrZT5dqTd7PL5k1otInDL
	 v6CwFp1RuUzAxFfULY4RCQFqpdaaRrdcYcJa13lBXjXRQsBjAQGtFTWFbZV6yhT4WW
	 rKlN3s8dGLh7k2hdFG6VjSab6FSNahAG8X80Fk3St7el7Y3XSvonh75Ovxjx3f+2iD
	 fJdr5O32J2Anarcjj+2ruE4t30hxf7I8lCwv43A34XHhYRnzDouB8XOJr6QJwdE4tt
	 NfNrHiU8McnOg==
Content-Type: multipart/mixed; boundary="===============5344446607086190472=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a662f3e63bfbe790357cddbb8d21070b9fc0e55604626e90a63a5edff821c388@mail.kernel.org>
In-Reply-To: <20260513045049.2390444-1-yonghong.song@linux.dev>
References: <20260513045049.2390444-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 11/25] bpf: Reject stack arguments in non-JITed programs
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 05:33:19 +0000 (UTC)

--===============5344446607086190472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject stack arguments in non-JITed programs
>
> The interpreter does not understand the bpf register r11
> (BPF_REG_PARAMS) used for stack arguments. So reject interpreter
> usage if stack arguments are used either in the main program or
> any subprogram.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for stack argument support. The interpreter
does not understand register r11 (BPF_REG_PARAMS) used for stack
arguments, but the original stack argument implementation did not add
checks to prevent interpreter usage.

Should this include:

  Fixes: cc06010ca1b8 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25779371388
--===============5344446607086190472==--
