Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A28E376483
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642414; cv=none; b=Q0SnPO5a4Z8UrGmfvO4kD7naEBgmOuYuSnvK/DqNzHkTuV9qKhJlamgkuLDOGSHzWHDG2qbnNg20upoa7VegA6Xly5z7NooRyN87vKNbvdasDEp4c1FDEVjDqZ+oBCjVdzRAnUr8Xyibv0JCnQh0PQlyZqnON+cUnqL8DEgJXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642414; c=relaxed/simple;
	bh=Q1CV8onnYNmEHm7yCi6F3Q/ktJKItj/Ym4Y9XLRU/vs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QAbfTmsYUT7XC/TYROGcf/TlPZZQtVNPk5GfuAZlkmMAnxDzGYvFaF7gZ3k5Nw8nMtkvKq31MNXvEiVER/b5aAoCYvRNnRTZ9bxHk8dmcokbDy0W7nu5IxJM/LctmQwD/HEfKjUdnVZNjphuIsyjHwrfZP9I+brnRNS0FgcrEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsTx9KfQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsTx9KfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C33C16AAE;
	Mon,  9 Feb 2026 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770642414;
	bh=Q1CV8onnYNmEHm7yCi6F3Q/ktJKItj/Ym4Y9XLRU/vs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nsTx9KfQCVtXFw3kruv9KfnYZjfpfhacj3WPMcSv0m82J1XSxv2Fho7l9e3dlmZjn
	 69bz14riGrlOhWXDMVCNlGik1d9tsWv9OkMFCctyJTpgDp4K4Fg0ThaJkAvI5SVJx8
	 hxvCyGIUZzmedVuMBJHqhLMom3rhP8uNETdSDFnpCmNJshSrgktgY+JXgirEt1VvsC
	 EBgVSKEp0o5LZN0ND8MnWuq+TZ6jfbcIXhXCeuSTN+kmfl+QxPKzErYROHY9XlAeuz
	 U4S7d8ciHAP4KU2cBt7yeRoJirIVZapF1aOCiq8KjVjCPg88ol8JedB/qqdRAZ9LwC
	 h85+551kXROAA==
Content-Type: multipart/mixed; boundary="===============8763090411818044184=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <896dfc751c8e3c2b98b9b36b05bf75956640d3b9dca70d24d18eed82c4f662c7@mail.kernel.org>
In-Reply-To: <20260209124653.56103-1-a.s.protopopov@gmail.com>
References: <20260209124653.56103-1-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix a potential use-after-free
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: a.s.protopopov@gmail.com,aspsk@isovalent.com,syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  9 Feb 2026 13:06:54 +0000 (UTC)

--===============8763090411818044184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edf5342b982f..24de90357450 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21333,29 +21333,28 @@ static int find_btf_percpu_datasec(struct btf *btf)
>  }
>
>  /*
> - * Add btf to the used_btfs array and return the index. (If the btf was
> - * already added, then just return the index.) Upon successful insertion
> - * increase btf refcnt, and, if present, also refcount the corresponding
> - * kernel module.
> + * Add btf to the used_btfs array and return the index. If needed, refcount the
> + * corresponding kernel module. To simplify caller's error checking in case of
> + * error or if btf was added before, decrease the btf refcount.
>   */

The updated comment says "return the index" but the function now returns 0
on success rather than the actual index. The old code returned
env->used_btf_cnt++ (the index), but the new code returns 0:

    env->used_btf_cnt++;
    return 0;

Should the comment say "return 0 on success" instead of "return the index"?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21825693233

AI-authorship-score: low
AI-authorship-explanation: The commit has standard kernel formatting, addresses a real syzbot-reported bug with proper attribution, and shows iterative development through review feedback, all consistent with human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor documentation issue where a comment says 'return the index' but the function returns 0 on success; no runtime impact as no callers use the return value as an index.

--===============8763090411818044184==--
