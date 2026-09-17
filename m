Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE149D584;
	Thu, 17 Sep 2026 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688986; cv=none; b=UMzaa+X0vbpnvpM1nWNtaizprgMmIz+r1P3tpfZax7o7sr2VdtZaj83bCqRWlcdjbeNphJBCSmbJI0EP0LciaAiKJX+N0n1uwkzJ3/7b1ZFLzQK3JUZWirTzdWYuhi4P2b4WoIl5oZ2sZI7625TMvGB/DOeGshN7Yg1PvAy0jgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688986; c=relaxed/simple;
	bh=r+s0LiPHCI9anNwog1q1wCmxZuy74xNwMr5QmaPk9ZM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jwrgxoKkkE9z2VSV62YDe4Szfq8bIQA9E0iNtPth0Kr/R25l40UZ047j51YbUuML3KX5OHFKfOToW3CN3qrDsdvKGwDSZkC9iWQ3+0BFdawli+22UuZVMr+jZSzsqC+tX7ilob6pj0m8fgzCkmPVsn2GJLxyB7sf8xUhFtcQb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfsMhic9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfsMhic9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0781F000FF;
	Thu, 17 Sep 2026 23:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789688984;
	bh=r+s0LiPHCI9anNwog1q1wCmxZuy74xNwMr5QmaPk9ZM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TfsMhic9doUbsB42YOZng4qb/OEY8ycWIK+/HxMLPdrnnK/XcZvCH8XBTVwHMHnwD
	 b1K/ES113ArKc6RJFl/7qc0khZYsrIW/DmKux9tzrAGYnH2UzxT4CiKelFtWLhb6gR
	 1ZGKtQjyoyghPjecZA3S7ZuQshkjtU3PAFTGoIJodlHw1xFt+aHcMZ7OsOC0SZgWcH
	 G4IhDihfBsiMYy+28qqVoFDCM/TzrbRrQVKwqCJYowbQTsdzlIyGXEBkLKFgl1o3Qa
	 +KPbQTAeaIqGx/8LkctLSd9Vh4P62c3EC3IE+sFOOiaK0ab73ANUAn7G66MF+Y7eQq
	 EHQDF4f4UsXBA==
Content-Type: multipart/mixed; boundary="===============0095006719181285834=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc85d83ac07c116cd243a2bbfff0a994abcea9e9588048e80f9a1234d772b757@mail.kernel.org>
In-Reply-To: <20260916195203.1099646-4-ihor.solodrai@linux.dev>
References: <20260916195203.1099646-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH v3 3/5] x86/cpu: Inline generic_identify() into identify_cpu()
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,mingo@redhat.com,tglx@kernel.org
Cc: ast@kernel.org,andrii@kernel.org,ryabinin.a.a@gmail.com,akpm@linux-foundation.org,hpa@zytor.com,andreyknvl@gmail.com,linux-kernel@vger.kernel.org,x86@kernel.org,bpf@vger.kernel.org,kasan-dev@googlegroups.com,linux-mm@kvack.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 23:49:43 +0000 (UTC)

--===============0095006719181285834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> generic_identify() has exactly one call site: at the top of
> identify_cpu(). Fold it into identify_cpu() so that a single function
> does the job for both the boot CPU and the secondary CPUs.
>
> While at it, fix up both copies of the Cyrix comment.
>
> No functional changes.

This isn't a bug, but since identify_cpu() already covered both the
boot and secondary CPUs before this patch, could the changelog instead
say what the fold enables for the following patches (e.g. making the
init_cpu_info() placement explicit)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35285131592
--===============0095006719181285834==--
