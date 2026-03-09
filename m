Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50E41B369;
	Mon,  9 Mar 2026 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085789; cv=none; b=ZAD2sJXwh5F0hzuZ8zTfQ/EMBFsvn4BDclQ0EjbcffCjdmGmr9Q6xeRiEO25CtKmvRzXUNfgwzssvEPkEZtTlo7PwetUFndFIg64yKRTthDR+0BTyYzubf3wqeLuCIAgc9+0E8nyI5gjASVhFxeW3LqXlCUH+AwJr92+asTl8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085789; c=relaxed/simple;
	bh=wz5YucaUQOKsZKoMsho+Oktx6Qh34ufnECmZFmW4peU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Y6nFRITwpyiwyUsOvbWcl8KM1nub6NG4z5QxwBHp8w7wWMcwhbqvhmcRU0VGhAeEdXtE0N3Lg3EfuksvWgzoHB/eUmXXiWhwSe091nytzO6kc2bmql9uSLja/X1NhxXEOOy1Fb6JypsaxOkakDE58qHJDykORXCZxgWlHnWmFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI3Ue6ts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI3Ue6ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60D3C4CEF7;
	Mon,  9 Mar 2026 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773085789;
	bh=wz5YucaUQOKsZKoMsho+Oktx6Qh34ufnECmZFmW4peU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qI3Ue6tsIWP76yzL5ogshne6fRwceDSV/mUSQExVnA9C8PjwZFVnYeYTPkg1yrdHW
	 Tu6Qs+IGNqvxzNaxCjcP7jzUwkLRRWNGsFJ6A6+KEOs0FSx9fBVJ63byHMf1XNkffX
	 3Wzu0kyYQZzmuQWBqygmY3PzA4fW7HDJB8KuCZo+goP+S9rkirCg2HL9uKwEvafuQY
	 VOVSCh9T2I4pnw9hIgWaOEzpNTinpCULXGAf2SQVNZ7rYKoAEmfJUeOJfhsklYdv+p
	 lbsvcy058CSfVEO1ZvERNQgzM5vV+bCaXL6q6j273Ex1Lb/A88Y/IJV6RmOIFHcVtX
	 3gctunRXaR6/Q==
Date: Mon, 09 Mar 2026 09:49:47 -1000
Message-ID: <4f2ce4157e294e29d83c97838ed34cc7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>,
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com,
 morbo@google.com,
 justinstitt@google.com,
 emil@etsalapatis.com,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2 0/2] sched_ext: cleanup and toolchain compatibility
 fixes
In-Reply-To: <20260309022847.106150-1-zhaomzhao@126.com>
References: <20260309022847.106150-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> Zhao Mengmeng (2):
>   sched_ext: remove SCX_OPS_HAS_CGROUP_WEIGHT
>   tools/sched_ext: scx_sdt: Fix BPF verifier rejection on older LLVMs

Applied 1 to sched_ext/for-7.1.

Thanks.

--
tejun
