Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9144366577;
	Mon, 18 May 2026 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104277; cv=none; b=YUiEoJV4rwYGzG/FR0tudyk3DeHs3/h50gQstvn3E3OUoh0nu9bezhwY7M9XTPrpizx5e8ccjVwj2jXPW2eLHqrz7QjG1IGEfKUoWyASJPFBx84nkysDg070W59Lh54AKJYC7clkcgvUxsQ3sfIlT0ezE5KUb4V1/pqdxf6j5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104277; c=relaxed/simple;
	bh=h/gWCTfNbsYJ23bAT6BkmDZhMkk2QkGhDdpbYyAEDwY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oSMcWKKZpLcUFSC5x7vbX73nGwyolykzt0weSVEKvNQojQSjoP1rBh1OsxG5TsHZSdwQuTMHtq0m+JKdMH9E2Ire1A5sjeCMm4X92IAcnahf3Rl5S2g2NpviUowUa9zb7nWExjKoWXk5TWetszAOg3h57XJyY75xOprw1gw5C+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMKYdKNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMKYdKNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B60BC2BCB7;
	Mon, 18 May 2026 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104276;
	bh=h/gWCTfNbsYJ23bAT6BkmDZhMkk2QkGhDdpbYyAEDwY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dMKYdKNy48aMAlkUG1fUAN7Y5saa697Ij+fyWNhFeHISapKNweS6uW8jy0EyP6Cvp
	 2bylPpdez7oIw8ISu6Akph3vlzaGqikfK7myvoYGryWX+eUz+cHw2OoILm1nXWxmzq
	 8Ma04nqQklgdnIUgEMjrmsj6UH9/Szkfrs4vVfrjdGRdw0ce/KMFuHcz+8HDlfPVfh
	 Ayg49jPuEVkqowu3KRgMsSrritS3I/wtJnm39uAaA/IJVfzZNpU09QsaRGiIyJ9JFe
	 B+KqP/tNfdEbTFpnH0KCFyPHcohAbCnERTlU7GKBkL5QS17azm1S6KPQCjxlxtrZF3
	 Y7Xvo1Ze3xiaQ==
Content-Type: multipart/mixed; boundary="===============1980439990770604517=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70f506d03335c3cbd12dce21577fb1af98fbd432d8c1bb3464c1080a5d502331@mail.kernel.org>
In-Reply-To: <20260518105957.123445-9-jolsa@kernel.org>
References: <20260518105957.123445-9-jolsa@kernel.org>
Subject: Re: [PATCHv2 08/11] selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 18 May 2026 11:37:56 +0000 (UTC)

--===============1980439990770604517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
>
> Changing uprobe/usdt trigger bench code to use nop10 instead
> of nop5. Also changing un_bench_uprobes.sh to use nop10 triggers.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This isn't a bug, but there's a typo in the commit message: the filename
is written as "un_bench_uprobes.sh" but should be "run_bench_uprobes.sh"
(starting with 'r').


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26030080109
--===============1980439990770604517==--
