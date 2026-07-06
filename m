Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507D36EAAC;
	Mon,  6 Jul 2026 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361539; cv=none; b=aVU/afnkQy9L8G4ibfhMhT5P+Jt/o+Pp2D3/popVA5sWlf4Q9ml2OEw0pI8TkxJOTdNZNv6OekN/tU40gl9rCxkNzInnTqV066OmPF399JN2rCMLlZywdb3lk3dAJ3D7cW5HAsZWLiOluqBgojC1OxX8CRMfxUsMDFASqdhEHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361539; c=relaxed/simple;
	bh=BN+dhNfm3/oR+pQ1Y8KYi3lTJwRVpnmyQ4O0HniJ6lE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F5XRDr9upLn6ngU6ygqV6F2E2yhJO4tUCMl5K7tyavw+Hz5+bJmQNq+wNY8jjhlSYkladZOlS7yL04QD5+VWFNeFcl8NocovdOcQBkKjl6cjEoUpNyxGZ2BLkPvwxvzIXpAFDbhD1ea2QL4+6rdUGU5LLX1zZAvIfDkZtTRnBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCaLd0u+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCaLd0u+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129241F000E9;
	Mon,  6 Jul 2026 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361538;
	bh=KIXRI3TQ7ZvV3sUTmq1nadKHBwAO/5S7/EIqCa9F57s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aCaLd0u+EOs/tO2pQi7ZruB6gQimi7ASCf43Tipsd6FGD6F2o8GnCp6VVyQBcZ9kp
	 CCN7z2++GCT1HoOj+YxvpyHlepTCd+PoLdMj4aOjhYuxmyAs1a6ajUrcYQNttXy8sY
	 PnkqrkXIY0gGdHG7+LNY1KmiGQ+cycYuFMHZPZ6mjmT38w6MjZtYgBUofJ4mAH+BRH
	 uQYxEC1cTSmPRkRTXpAe2BUdEPWRR0DRSnJ3oHY/VL0sYS7HJJkag5P+11J2VuuwfO
	 s0ZfVxu8GZ96xLGq1Neo/JGJry3k8uh7+xhzUNJTNgYpODWJJjc5nwx+vYICEaFxHH
	 qJI0Eyhx5s4DA==
Content-Type: multipart/mixed; boundary="===============5985291679337553647=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ed385399f170538acc571665dca8036ccaa85dd1b9dfe987d8c7d566f59e8e5@mail.kernel.org>
In-Reply-To: <20260706172846.3876436-2-visitorckw@gmail.com>
References: <20260706172846.3876436-2-visitorckw@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,luke.r.nels@gmail.com,xi.wang@gmail.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,pulehui@huawei.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,alex@ghiti.fr,jserv@ccns.ncku.edu.tw,eleanor15x@gmail.com,marscheng@google.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 18:12:18 +0000 (UTC)

--===============5985291679337553647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit c5a973b7fc82eeb9b84aaf80fc2673a94ab795b2
> Author: Kuan-Wei Chiu <visitorckw@gmail.com>
>
>     riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
>
>     The current rv32 bpf jit compiler incorrectly treats BPF_SDIV and
>     BPF_SMOD as unsigned operations. The BPF instruction set allows
>     signed division and modulo by reusing the BPF_DIV and BPF_MOD opcodes
>     with the instruction offset set to 1.
>
>     Update the emit_alu_r32() function to accept an 'is_sdiv' variable and
>     emit the correct div and rem instructions when the offset is 1.
>
>     Before this patch:
>     [   44.161771] test_bpf: #165 ALU_SDIV_X: -6 / 2 = -3 jited:1 ret 2147483645 != -3 (0x7ffffffd != 0xfffffffd)FAIL (1 times)
>     [   44.167385] test_bpf: #166 ALU_SDIV_K: -6 / 2 = -3 jited:1 ret 2147483645 != -3 (0x7ffffffd != 0xfffffffd)FAIL (1 times)
>     [   44.171053] test_bpf: #169 ALU_SMOD_X: -7 % 2 = -1 jited:1 ret 1 != -1 (0x1 != 0xffffffff)FAIL (1 times)
>     [   44.172081] test_bpf: #170 ALU_SMOD_K: -7 % 2 = -1 jited:1 ret 1 != -1 (0x1 != 0xffffffff)FAIL (1 times)
>
>     After this patch:
>     [   16.002192] test_bpf: #165 ALU_SDIV_X: -6 / 2 = -3 jited:1 95 PASS
>     [   16.002983] test_bpf: #166 ALU_SDIV_K: -6 / 2 = -3 jited:1 1059 PASS
>     [   16.017167] test_bpf: #169 ALU_SMOD_X: -7 % 2 = -1 jited:1 136 PASS
>     [   16.023002] test_bpf: #170 ALU_SMOD_K: -7 % 2 = -1 jited:1 109 PASS
>
>     Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

This looks like a bug fix for the original RV32 BPF JIT implementation.
Should this include:

  Fixes: 5f316b65e99f ("riscv, bpf: Add RV32G eBPF JIT")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28811594040
--===============5985291679337553647==--
