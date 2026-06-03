Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347738944E
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485604; cv=none; b=RhCkaobZBONCdWKID+U7YZ/NOSunjB8irLcQgmU2sHDw4b6J2pzG22pg8FSnEdB8M7soYgXRiPSXXLKAr5zUnOqWFLg5BxFModcdWXVg79A1UsAO3cnoBDfoYvrrJvlM/me4aEveMGZav5Uf3dB3xqIkbCgLb31H5piBgy8gLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485604; c=relaxed/simple;
	bh=15gLpT8vS1QO/htr/bOb8jjhFZ1hz9MyKyPEdedINkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTZT9MsFLbthKIi6HyRCsq2UPU1KZSwqq9Wra15GEAOoU8FDW1X3w9AmOdzMemUxshO0s7g+RQnRFGINkmqHKtElC1PLRmZOqusGqxtlXcnEdCdjxG5S8282iIryYqLpTYCLQqWE/ZM/o+HJd8e/byhib4LWVSuuS0hK7yuL7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qlaI+asY; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qlaI+asY"
Message-ID: <c57fe00a-5cb3-46dd-8c1e-a4f19567dfcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780485590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15gLpT8vS1QO/htr/bOb8jjhFZ1hz9MyKyPEdedINkA=;
	b=qlaI+asYNiip64z7eOjFvNnckh1QZtNuLpxSUm9zuV2TruwdWTJTy5HdKkHGnb9BNOL43K
	TT4z/rx+RhW3hEi+yf1+SQBLtKeNvtNLaOOoveB7wPfW6/gGhvJHYmesYb5QhV1WX6gT+s
	8hwWgV/Q76YEnAXo3LL9kZqwC948VaI=
Date: Wed, 3 Jun 2026 19:19:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] bpf: Restore sysctl new-value from 1 to 0
To: Dawei Feng <dawei.feng@seu.edu.cn>, martin.lau@linux.dev
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, kees@kernel.org,
 joel.granados@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
 <20260603105317.944304-4-dawei.feng@seu.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260603105317.944304-4-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/3/26 6:53 PM, Dawei Feng wrote:
> Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
> helpers") changed the success return value to 0, but failed to update the
> corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
> bpf_prog_run_array_cg() now returns 0 on success, the legacy ret == 1
> condition is never satisfied. As a result, the modified value is ignored,
> and bpf_sysctl_set_new_value() fails to replace the write buffer.
>
> Fix this by checking for a return value of 0 instead, so cgroup/sysctl
> programs can correctly replace the pending sysctl buffer.
>
> This bug was discovered during a manual code review. Tested via a
> cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
> Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
> returned 8192 and the value remained "600". Post-fix, the BPF replacement
> buffer properly propagates: the write returns 3 and the value updates to
> "foo".
>
> Fixes: f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean")
> Cc: stable@vger.kernel.org
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

