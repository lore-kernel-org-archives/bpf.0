Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB06384256
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521012; cv=none; b=Q5HgmJx/PGTf/iBDH+CcyWCPBLWDwZjsIhVWlNFrEbEA3ppX4NHPf7y8q5ZOhTFwcyaQGjnGmaLy+bX4ZyGnUok7uqGQpOmY1mEJnT0JqkBzG514BlpRQp00uQAGG5lEAF1lFhKemKZqc5fGXg/SfdYLwQbESzKI00E/ULaBaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521012; c=relaxed/simple;
	bh=qPvNEikHjzqmXy0O9aiIhkNQbZMiv4YfBZUz90mtGHk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nGNgmns7eX64iBf0fpdsgnuq6YP6VWBRGnuOr0HUbYslmJ4BPjQj5F/NBP+YPvO14S+IOLbtQZnrea5mDFAFJPCzFnPoQnBp7+3PKPeQJH7f2aBRHKLyFx/3o76ZdHuCmgHHZn2VxKA0iOmVp+DxpscGB0nnUc0+R0hbS4fwoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V72jV84w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V72jV84w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE28C2BCB4;
	Sat, 18 Apr 2026 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776521012;
	bh=qPvNEikHjzqmXy0O9aiIhkNQbZMiv4YfBZUz90mtGHk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=V72jV84wFzUXFCvcD6jSeOfaKbPOiCRHAXkffm/HioRq9rJPerWMVFENybsiZGOR7
	 W+lHQouj83FaPJfEkwTFa1wW1hqjojTlHmDZsRz3+U4WkGtMzQu56ltqK+OE7Hvn+/
	 254eUot3zVx8piVHUu7/Y6OMky3TIgVJwxsXqOPYunSB3ntsy9zKv8+iIgPRG4VQbq
	 1577bS1yS5WQlaV191JEeyVOxGndFNw/3sCtpi8IwEPcAmmT8Rc37nrka0NzA33sSd
	 Qv4BzrSKN8HTnP/AIGy1afgmFPcMZ8zMDV9G/Ec9l2BwRIyavITlr8FGez48RlKs55
	 A9gj86ZthxkNw==
Content-Type: multipart/mixed; boundary="===============0546296290627441763=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bc06bc710ed78082e1d8017a6a638bb27a7b3f6f9b21f76d62233351c5001aa1@mail.kernel.org>
In-Reply-To: <20260418131614.1501848-4-puranjay@kernel.org>
References: <20260418131614.1501848-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v13 3/6] bpf: add bpf_cpu_time_counter_to_ns kfunc
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,xukuohai@huaweicloud.com,vadim.fedorenko@linux.dev,catalin.marinas@arm.com,will@kernel.org,kernel-team@meta.com,vadfed@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 14:03:31 +0000 (UTC)

--===============0546296290627441763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7cda5589107b..a8956eb867ef 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -10,6 +10,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/bitfield.h>
>  #include <linux/bpf.h>
> +#include <linux/clocksource.h>
>  #include <linux/memory.h>
>  #include <linux/sort.h>
>  #include <asm/extable.h>

[ ... ]

> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index ca208378c979..da61bc5585aa 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -12,6 +12,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/filter.h>
>  #include <linux/if_vlan.h>
> +#include <linux/clocksource.h>
>  #include <asm/cacheflush.h>
>  #include <asm/set_memory.h>
>  #include <asm/nospec-branch.h>

This isn't a bug, but the include appears to be unused in
bpf_jit_comp32.c. During review of v11 on the mailing list, Alexei
Starovoitov noted that the 32-bit JIT implementation was questionable and
should be dropped entirely:

https://lore.kernel.org/bpf/CAADnVQLYT5SV+tS2ycLteBMYOc12C=X7iHZ=RjhyVzuY=6=8Uw@mail.gmail.com/

The 32-bit JIT implementation was indeed removed, but this header include
remained. Would it make sense to remove the unused include from
bpf_jit_comp32.c?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24605755621
--===============0546296290627441763==--
