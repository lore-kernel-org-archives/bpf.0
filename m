Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AB2DE6FC;
	Thu, 29 Jan 2026 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665121; cv=none; b=uiQkhQWiZAYqcZgQvrImrw+cVHaUopAy6hcsSQbbDZnvhClPkGRY7Q+RXlR7eLSC1wC56gmt06LgbRHV269fucAoytq+V2YNBp7Zbs/NkRSqthwz8feq6CozwVqtMHfepfgSCqyoj/xE3powJzvElLcx1LOrF/3KeRR5M9JdgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665121; c=relaxed/simple;
	bh=q4drvNjDlEwZOsIPnU+Qr6321KEqlvlkfs6jnkf5saI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ONS+T+c8ZscFO408+tbRz4pYwv3yK0697W582iEtEnGQ1FKweKcLRu6fdUN1aKuT2YwI9pgoU8vHyw+3HqO/fbdt1ARtXEK95l3nG4wjNUoW1KQKIoNWNfBpqCoTy+aVDxg33EZwBY2FEQf1Vq3bql6f7WSSugMngWvNc31Ighs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDLRP77c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDLRP77c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3191BC116D0;
	Thu, 29 Jan 2026 05:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769665120;
	bh=q4drvNjDlEwZOsIPnU+Qr6321KEqlvlkfs6jnkf5saI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aDLRP77cy3As4a50hrokFnM0Ps/DIiIh9mQ7yXXsvKu3xphNWcrpKLBNhwvdp82LW
	 gbhsANCXpaVBYS4Hl5CKSXFcE/PSfH5UOV+fZH0fIjafnmUvqSN9BWL92v6/Uc8xyN
	 xFXdW51EFP3oJP7/4pwTbKC4uL4QTnA9mYy2fvJjLuGXkYpemhxsFj8Ddvn3drXpra
	 ImT9dvhRv/RTxdJ2H9MbxiSNGkYz5hZ4I4fN7PHEuRe6GN27F3hXWCUM4BtZD2URqK
	 XIcJridQuGQTevvo8zoIoToJO7QCl4JR1JDcpeL3o++qV9X5SCUdF5B05zsseFBb2e
	 yLoCQfamYe9dw==
Content-Type: multipart/mixed; boundary="===============0294624793989093549=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3141d10de14ab669ef0927bdb175b0fd1e1e0d1b0c6b6092385e3bcb1898ee4d@mail.kernel.org>
In-Reply-To: <20260129050949.157410-1-skb99@linux.ibm.com>
References: <20260129050949.157410-1-skb99@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Return -1 from get_preempt_count() for unsupported architecture
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 29 Jan 2026 05:38:40 +0000 (UTC)

--===============0294624793989093549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index a39576c8ba..87706a213a 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -628,7 +628,7 @@ static inline int get_preempt_count(void)
>  #elif defined(bpf_target_arm64)
>  	return bpf_get_current_task_btf()->thread_info.preempt.count;
>  #endif
> -	return 0;
> +	return -1;
>  }

Returning -1 here causes incorrect behavior in all the bpf_in_* helper
functions that call get_preempt_count(). Since -1 is 0xFFFFFFFF in
twos complement, the bitmask operations in the callers produce non-zero
results:

    bpf_in_nmi():     -1 & NMI_MASK     = 0x00F00000 (non-zero)
    bpf_in_hardirq(): -1 & HARDIRQ_MASK = 0x000F0000 (non-zero)
    bpf_in_interrupt(): returns non-zero (falsely indicates interrupt ctx)
    bpf_in_serving_softirq(): returns non-zero
    bpf_in_task(): returns 0 (falsely indicates NOT in task context)

Previously with return 0, these functions would return 0 on unsupported
architectures. Now they return false positives indicating the system is
in NMI/hardirq/softirq context when it may not be.

Should the callers be updated to check for -1 before performing the
bitmask operations? For example:

    static inline int bpf_in_nmi(void)
    {
        int pcnt = get_preempt_count();
        if (pcnt < 0)
            return -1;  /* or 0? */
        return pcnt & NMI_MASK;
    }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21466700415

AI-authorship-score: low
AI-authorship-explanation: Simple one-line change with clear human-authored commit message following standard kernel conventions.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Incomplete API change causes bpf_in_* functions to return false positives on unsupported architectures, but this only affects selftest code on non-x86/arm64 systems.

--===============0294624793989093549==--
