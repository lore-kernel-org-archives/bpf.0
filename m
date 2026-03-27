Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B237E2EB
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649074; cv=none; b=Y7xk9rcPmDOEiyT1IMmDpXK/1afQ2t++R8Bzpx4YD3fmhSzw9k5FnXa7GzRFVMRwjX1/quf2EyIsSuBuUmVyK36fmcV3296cNNu+VfPmIW3XlX+ZDAYPzxqoXbPAIPwiL3QtOOL52tnsFlpDICHsUAopJ2iATYOP9xraKhOJScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649074; c=relaxed/simple;
	bh=pvi0CPbsuhv5zp2v4yL/p7j7QhpOiY/TiqHjEbxndOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTg/jTNkTST+EK9FbQh5Bqc8AfnnTXs9LXNkQQVNC0oaBD/K0OiOfnF4JZR/BL++GcI6GrSc7LO4N73Uxw89CMfMLSAp20ypk3tmG7pPwWSrMeoVm/xpVnq1YWwHLHJGOlz+Zd1Y4MoLXIeNyLruVyQ5Jhrce1ySqvMYTsbh5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hg2JOogO; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hg2JOogO"
Message-ID: <b6e99fa1-ffaf-4a9f-90aa-7e5424f1a7bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774649070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP9fkJOZ06UoL3UxqA2oSjuWDLkLScEcq9A5WfKzw3M=;
	b=Hg2JOogO1w+EJoChWXmU4wEmapuO+vomuPQghYpAp6n4hQXN0RL9mKd9RsRo8NV9DvB4wU
	r7pu0t04JVnOR/+U003serd6Z1+Am7qo1z8y2b7GarZMx4xpfE6uVW7siM1So6cpBdZ0oV
	OWPgRJ6nFXklJux3eGdDvwwvbh/umKg=
Date: Fri, 27 Mar 2026 15:04:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] selftests/bpf: inline TEST_TAG constants in
 test_loader.c
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, cupertino.miranda@oracle.com
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
 <20260326-selftests-global-tags-ordering-v1-4-5dd2ced5d9ad@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-4-5dd2ced5d9ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/26/26 10:39 AM, Eduard Zingerman wrote:
> After str_has_pfx() refactoring each TEST_TAG_* / TEST_BTF_PATH
> constant is used exactly once. Since constant definitions are not
> shared between BPF-side bpf_misc.h and userspace side test_loader.c,
> there is no need in the additional redirection layer.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> ---
>  tools/testing/selftests/bpf/test_loader.c | 84 +++++++++++--------------------
>  1 file changed, 28 insertions(+), 56 deletions(-)
> 
> [...]
> 

