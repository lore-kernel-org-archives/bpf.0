Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7589421EEE;
	Wed,  1 Jul 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907043; cv=none; b=g6VX6E+8ER93aLh40/E+AudhNcUeXBbGPuhtA/+9xTBgiZP1Qszvc+LGKrxd6aajH7Iw4ZoNe/4XtQHDXxrb4d2IGW5nyUt1wQNiT1sYXnWcuDYYFeAVvAXe2pDgovyA9NvLA9aazTgByQiYgZxL4ew24zmqJSBgGX3F7OTArOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907043; c=relaxed/simple;
	bh=IMDCiOl6lwnt0GoRPYAuKxImQcp8+PErmSoKpejZ6o0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=umMXkyK69OJn7N7Kf5vHEUNCF6yMz7YAhvQqDaKXt8/rH0CS/2y60syFj9Jghw0kWFjpSe7Ohl2DzvIHVoDRUQTgd6vM8g4Bv/w3ApKXZDhznT7Wb7Jv105RPXAHG59K9aUx3xhn5AgJxxbj59ceRwV3OcrN/Xk/1C1K/gkFjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obUyCfxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obUyCfxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A001F000E9;
	Wed,  1 Jul 2026 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907042;
	bh=o0rU2zsVbV+8X7c5T3QFlyD0RyGFqANe/iZ+055/2nU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=obUyCfxiF9Kw88EcGWVPmZxuJBF6idvnKlJgogVZuCTx92sHkKRPQkF1Kujl4/MAV
	 xFHQFz1+svPJXQ4oEJAlXimIvQzMZhQsByfKr64YN1T9gb5MtfxZRaABA5YzfC9fiC
	 dZutflbvCAnuWrQfn811E3ZvoILvUH1rgr4aZuOjASvpD7XXJN5FrL40ikNTXADtEL
	 22/a2vWo98g3GIqGmaug7cx3IyQsAEDbH0lk8ATsW5uTdJc69pnTPxkpV//kG0b7S7
	 RwEEzLxLl8f/9VDm8VU1Gpm0C7ebqK9PRDSppXsGKZdnIaWDPiHbFXSUPbyWY/0XF0
	 2hucNR4FdY3Sw==
Content-Type: multipart/mixed; boundary="===============3195589384710005851=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d0b8da347310d39950b517c8f6805cd7a0fbfff576aa21e49ca115538b0a615@mail.kernel.org>
In-Reply-To: <20260701111337.53943-14-jolsa@kernel.org>
References: <20260701111337.53943-14-jolsa@kernel.org>
Subject: Re: [PATCHv5 13/13] selftests/bpf: Add tests for forked/cloned optimized uprobes
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: jakub@cloudflare.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 11:57:22 +0000 (UTC)

--===============3195589384710005851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index ff07e5df9a65..eb067f029a9f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[ ... ]

> @@ -954,6 +957,88 @@ static void test_uprobe_error(void)
> +static void test_uprobe_fork_optimized(bool clone_vm)
> +{

[ ... ]

> +	/* Make sure it got optimied. */
> +	if (!ASSERT_OK(memcmp(uprobe_fork_test, lea_rsp, sizeof(lea_rsp)), "optimized"))

This isn't a bug, but should "optimied" in this comment read "optimized",
to match the spelling used elsewhere in the file?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28514315910
--===============3195589384710005851==--
