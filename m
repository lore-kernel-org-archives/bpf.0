Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF7409612
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688170; cv=none; b=ThdQlqbQ+fxSSd8EN3lXDghufOWDGzh+GXwf4fMzN1KvZaQZQMIRc3cxz8DjYNBRvjIGbYnqiHkgkrQtteYDctJwNklcXDcR3Xmmpu2Oc2WugLhIRS9NkIg/iX5HQQqRteCCWd7K0ncxW+colSdCnLIvhwS7i07nJVvaKcGDeCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688170; c=relaxed/simple;
	bh=9CFunCJTMW2VaginoE/cEl2FkAT/k/PaNhncoUuX2Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6YpplC/9io1ZBLMjXPqupAvyEpLg79xKuKVrpmKE9VMqAzA684XBDJuLnwmoHSheWtV3cto1+TQoXRIAO01mrcGm9puq3uGTfsD2RWFin2qlqxW0E1Fyfx7ft7YWDhU2T6CmPGVsBl5OhszwLeSIYbG0Pyo4dSOJTu4xONi/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EnA7NeDv; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EnA7NeDv"
Message-ID: <7fc583a4-b664-4578-9068-7cb9d9be19bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780688166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4O3p/JRcYpnU/4bZ9FlMTkdSjuJpgq/045zkY8Mk9UE=;
	b=EnA7NeDvwg7dFzcM1oWCelsylTfWCkjK3DkOswzB4an85Y0+5xklXl0g3R9gfQ6uDzMgiw
	nW/SzTeqEF/DVHYb9rLjSnpWr/DP38N//RG8Y5RfVcTb0kMN5lLHYGfnYG1qLc7yC3Ga1n
	o4sx43NjVfkuuolVxEjLITt+8z0QxNA=
Date: Fri, 5 Jun 2026 12:35:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix flaky file_reader test
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20260603-file_reader_flake-v1-1-7f3f52d1e388@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260603-file_reader_flake-v1-1-7f3f52d1e388@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 7:39 AM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> file_reader/on_open_expect_fault test expects page fault
> when reading pages from the test harness executable.
> It is not guaranteed that those are paged out, even
> after madvise(MADV_PAGEOUT).
> Relax the condition in the test to succeed with both
> 0 and -EFAULT returned.
> 
> Fixes: 784cdf931543 ("selftests/bpf: add file dynptr tests")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Closes: https://lore.kernel.org/all/ah6g7JSYOWGp2oAG@u94a/
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Hi Mykyta,

I tried the patch on libbpf/libbpf CI, the test was consistently
failing there. It works [1], thanks!

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

[1] https://github.com/libbpf/libbpf/actions/runs/27032965962

> ---
>  tools/testing/selftests/bpf/progs/file_reader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
> index 462712ff3b8a..aa2c05cce2b3 100644
> --- a/tools/testing/selftests/bpf/progs/file_reader.c
> +++ b/tools/testing/selftests/bpf/progs/file_reader.c
> @@ -50,7 +50,7 @@ int on_open_expect_fault(void *c)
>  		goto out;
>  
>  	local_err = bpf_dynptr_read(tmp_buf, user_buf_sz, &dynptr, user_buf_sz, 0);
> -	if (local_err == -EFAULT) { /* Expect page fault */
> +	if (local_err == -EFAULT || local_err == 0) { /* Expect page fault or success */
>  		local_err = 0;
>  		run_success = 1;
>  	}
> 
> ---
> base-commit: 245da8192c073820390f7fa1cc1e834b32119bce
> change-id: 20260603-file_reader_flake-bf0753be6b2e
> 
> Best regards,
> --  
> Mykyta Yatsenko <yatsenko@meta.com>
> 

