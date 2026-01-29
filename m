Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1129125A9;
	Thu, 29 Jan 2026 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666843; cv=none; b=Qbezje8XQPYYYZWHyJ85mnvFAd5Etp0Z05d0FstTYP9CpuSL27S9d0w0p7BI3c6fdNbFkDs97ZUQN1GNMXRLcNculYD90G0g4GuVWXtKPvHAGnj5kX69tZRkZAtK5/WaPfwISPicYAUBuhh33omGEQtwq3lmUS8d/fMzGLxL4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666843; c=relaxed/simple;
	bh=o1kr4MDge4qRt1w2EPnVZQ24pNn5eXA9+YNtbyjpTI0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oeHcQLnRLOuiu0VbYZtYn7F3gHZnKtcYzagRXXVD1iNAux2gr/2x/8on0tTW2oVET2bRUwbd/iamKlOY4M4a/u0H9sbU46uShsfq0li5HhJxEHYvUNjFkMXRVHxDvYsrr5WEisYD2Od2iLCDinZmUrOEPd/bNTf/f3tRUHBx+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUaiYGpX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUaiYGpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D916C116D0;
	Thu, 29 Jan 2026 06:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769666842;
	bh=o1kr4MDge4qRt1w2EPnVZQ24pNn5eXA9+YNtbyjpTI0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iUaiYGpXxfcCx1eEb8ug76lUmIHTmS6TjnjJD/VDm6kzPipx7oKSGZatc5qq1GrXF
	 ZINNbS6YtSUguHnnXpF/hLMQLluf4QahDr1FNZGM6cwGb6GRDPkSpMUH6yj4KHSL69
	 87HuorROAHT20QZIdbt0UJzH0zpCc2nnI0iJX0OEOwsdcxQJ5+2/xo1I5IU+Pt5Ina
	 Ka+nBpZjdsxY5aKFkp4H4nOroEXKCRLrnH/bCofUzzLLVk11qNZR6WX3udAO9pWybc
	 Ec0E2fs60VqtwbggnE97NcMTWKMENYyWv3bD0e6I4t12MrK2b9OieJ9GHiwAnIjq+q
	 38QV7n7i2Ev6Q==
Content-Type: multipart/mixed; boundary="===============2621773127213540498=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec269f64770e0c87c198d34bef01d818108015e8952d441d8708e5cf0e9c70b9@mail.kernel.org>
In-Reply-To: <20260129054035.168078-1-skb99@linux.ibm.com>
References: <20260129054035.168078-1-skb99@linux.ibm.com>
Subject: Re: [PATCH] selftests/bpf: Add powerpc support for get_preempt_count() in selftest
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,maddy@linux.ibm.com,mpe@ellerman.id.au,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 29 Jan 2026 06:07:22 +0000 (UTC)

--===============2621773127213540498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index a39576c8ba..147bbf6cd3 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -627,6 +627,8 @@ static inline int get_preempt_count(void)
>  	return *(int *) bpf_this_cpu_ptr(&__preempt_count);
>  #elif defined(bpf_target_arm64)
>  	return bpf_get_current_task_btf()->thread_info.preempt.count;
> +#elif defined(bpf_target_powerpc)
> +	return bpf_get_current_task_btf()->thread_info.preempt_count;
>  #endif
>  	return 0;
>  }

Now that get_preempt_count() supports PowerPC, should the documentation
comments for bpf_in_interrupt(), bpf_in_nmi(), bpf_in_hardirq(),
bpf_in_serving_softirq(), and bpf_in_task() be updated to include
PowerPC in their supported architecture lists? Currently these comments
still say "Only works on the following archs: x86, arm64" but they now
also work on PowerPC via this change to get_preempt_count().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21467281843

AI-authorship-score: low
AI-authorship-explanation: Straightforward kernel patch with natural technical writing style and minimal code changes consistent with human-authored commits.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Documentation comments not updated to reflect PowerPC support in helper functions; minor documentation mismatch in test code.

--===============2621773127213540498==--
