Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91D340407;
	Fri,  3 Jul 2026 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081936; cv=none; b=pggNFKYUzJ75B9zzvAc8YU7Wp1dR2agvnHmYi1+xpjN9/JGvatTjzDrjv/VwGAchh7Gzvk85kABQjzigVi1GPjCu2dJCPZNhszCcqeRGBx9U3gnJpllOFa3TyAT+PQew2Q8dh6E3L4NIV7QsX9N9pIaGF0OexbelSSQkcnkn6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081936; c=relaxed/simple;
	bh=PoNOme6RAV8DA+0buWUum3XfBPwAD5v03iZX/WA7qro=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uGK+jyqAjuXSixcUVTFEerLY1Su9eXQrgGVVgKQ0MX5PPwLnL7vJHgCdhEHz095Jdm+DHR1tdt1oCmanfSDCPZCXfStS/C4ZLiKLTaB5pSA1zeHIpijydIPFS8kzGkbmWcB0oP5E859MmGofJQXLMmLpiRUwcC+REC63mzvz704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUSIYvPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUSIYvPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4E41F000E9;
	Fri,  3 Jul 2026 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783081932;
	bh=PoNOme6RAV8DA+0buWUum3XfBPwAD5v03iZX/WA7qro=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cUSIYvPNn5kqAwluBnmEamj5wC8IEaC0L9mo8YKHezCtHxbqH8XligmPRg+j0RcP7
	 7o/LSOEcDINbvGC/6ryMHvANy2Q5WeXOxnyEag+TLGsQ3mmi4rsn9nuwxqM2KqUx9h
	 m3YsY8u95DQLL/BP0/DCsccwSPvXn4vqBbGuabuUhcV+B0wTNvwj7Yac4asECimbKN
	 BCrll8zCR8nHgCYkJGvbdx0B7bAubzdlYjoKWD1NTWkrofaEpo0Edk/hqniKWTdMmh
	 /mII7aPb2pgwaxn2+2cgt2vqperCjUti+u5EJxDAhusx72pM7wu/3Jvn3/IJGD3yAc
	 OCPi6FaH2HezA==
Content-Type: multipart/mixed; boundary="===============7859000914753863281=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1a9bbc8d6eb6987a94069feefd70b50f2a614bc915743b1369f5bd4861dd2363@mail.kernel.org>
In-Reply-To: <20260703114917.238144-4-jolsa@kernel.org>
References: <20260703114917.238144-4-jolsa@kernel.org>
Subject: Re: [PATCHv6 03/13] uprobes/x86: Do not leak trampoline vma mapping on optimization failure
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Jul 2026 12:32:12 +0000 (UTC)

--===============7859000914753863281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> uprobes/x86: Do not leak trampoline vma mapping on optimization failure
>
> In case the optimization fails, we leak new-ly created trampoline
> vma mapping (in case we just created it), let's unmap it.
>
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")

Should the Fixes: tag point to f4216a203c5d ("uprobes/x86: Remove struct
uprobe_trampoline object") instead?

The commit message of f4216a203c5d explicitly states: "Note the original
code called destroy_uprobe_trampoline if the optimiation failed, but it
only freed the struct uprobe_trampoline object, not the vma. The new vma
leak is fixed in following change."

This commit (ba6320f8c716) appears to be that following change fixing the
new vma leak introduced by f4216a203c5d.

> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28659696456
--===============7859000914753863281==--
