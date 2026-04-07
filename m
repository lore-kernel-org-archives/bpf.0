Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DC26F46F;
	Tue,  7 Apr 2026 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552497; cv=none; b=KTCkUuXofPjQi9sEa8OlhjcN9fSCoYg+OLQdv/Gp7FIQaqwR08WnHTUb269o+0tiQstthsBUUJBO8oE381IdJ5aOBZExk3ZB4t7QjB714cUsITRp8hcaiQu/fhkwHxi2izn37ySmkDvv04DLfqTl5Lrkk2QE6PcXxe+5nhyuZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552497; c=relaxed/simple;
	bh=OFp2tMevSg/BVftlj+6fpr7OiSxL/I91thS8tJr8PIA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DBVnO3XVoMBCgkLLKAbXGVQhGdnxJnt4GZhuo8IgsaGXIiHFYsj9vzG2YlRD5pvWXPM92T5ELB2bvV/4eeubvsESLpn0PzoN/X86c2fBLfkqzPaG8RyJAQQ3xEjKOEqSYT2tljjSx8YHljQpWrszfCX5/Py6EtAuKmh2tUFH4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAK9V6WZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAK9V6WZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14227C116C6;
	Tue,  7 Apr 2026 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775552497;
	bh=OFp2tMevSg/BVftlj+6fpr7OiSxL/I91thS8tJr8PIA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qAK9V6WZmdP8E3OBSlOvgHdVcDWSCEIeSCJvQyQK/fYjKuew9sVjwGPJC0xUt3eXY
	 eJhqYQOM01s0h+vJFgDlfS5cerjal/Xp2S0CPKaX0WMH9YqxE+bviPXxB0omDtJQ0g
	 P3ACfk5wSRJkU7WShivtSdZQ1+Gp3hSf6ez+BCvFVl51PygovX1Vcla5eBNfMflKsw
	 NvkHgrrae9XGzp4yjdLntf2x9k+s26hhg2g3D/8/JGavr2G7MrTS0I4ceJVVL6hCJV
	 jYzeZq+1hgprVNggF0MhErlfQNJAJDESPZXmN4+c3bGP4pZnmGdJw0uw0eK+J8ANIZ
	 xXdzuwHrZuOww==
Content-Type: multipart/mixed; boundary="===============2668565029444911021=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <17901aa75b11868efa03c65d338f071b6d06a0fd2f5536086be0a11d88e09e04@mail.kernel.org>
In-Reply-To: <20260407080900.551797-1-chenyuan_fl@163.com>
References: <20260407080900.551797-1-chenyuan_fl@163.com>
Subject: Re: [PATCH] bpf: fix btf_types_are_same for cross-BTF type comparison
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  7 Apr 2026 09:01:37 +0000 (UTC)

--===============2668565029444911021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..daad28ae32e5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7432,15 +7432,39 @@ int btf_struct_access(struct bpf_verifier_log *log,

[ ... ]

> +	return true;
>  }

This looks like a bug fix for btf_types_are_same() which was introduced
by commit 2ab3b3808eb1 ("bpf: Make BTF type match stricter for release
arguments"). Should this patch include a Fixes: tag?

Suggested tag:

Fixes: 2ab3b3808eb1 ("bpf: Make BTF type match stricter for release arguments")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24072076699
--===============2668565029444911021==--
