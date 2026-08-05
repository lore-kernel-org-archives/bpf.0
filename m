Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDC382F28
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905978; cv=none; b=qOcryQ8kFBq4LoojOCN8gyy9iLhMIgVhzz4xg8mYJ0N8aBzOd0m4aQyTJ+LIMJMOi4zXIc6+xzxPtlnnosXlhRlyXcYCtjmKqVtiMpmFEe/iQnZNO7plqJtsh845eArRZnj63n0/xNph7b99ahzGy1CwHFFEg8PlP2xcIBi6opU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905978; c=relaxed/simple;
	bh=z1VkAjpulNp9pefF1Z3YqOb/eM+sYJMF2iC+JjcyPro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie/Cs9pHJNixLARQ9cFqcndWx5mJklTuYiIx5jCm4EW9NCR3ogJkXI6Y8Ef5geA06o65REJ4fxc0KQI9r2WepCDu00v505PsBS7O428fK83/gJam/7F0KE4X88WzCtBvVZesrX2fAKjte3sJ8PZCLzJgbxDtI2fNw0pJNPy3yFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lPY3E+5k; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lPY3E+5k"
Message-ID: <77241871-37a8-430f-b7a0-0c127daf5fc4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785905974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w63W4+TkWhEjvWHk9f9hwutkgui5A3I0yKe7EIHhObg=;
	b=lPY3E+5kYt5/hXQhTzDOMnDx6V1zrNtPQv+PAUlZmTjplEndGxFsE7vG0dkyC1F7MbSy65
	0a8Y3VuizuL2h721AWbgHtLJ9n/NevoaTugIdcBk1m/DNTVUKEZl3D0OxxAHuKO53GTZkM
	mlW7MuJ4R7N+dCy/djLydjAmgVRmo6g=
Date: Wed, 5 Aug 2026 12:59:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v5] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Amery Hung <ameryhung@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20260805035342.349421-1-pulehui@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260805035342.349421-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/8/26 11:53, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller reported a storage null-ptr-deref issue after replacing prog.
> This occurs in the following scenario:
> 1. prog A, an empty prog, is attached to a cgrp.
> 2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
>    bpf_get_local_storage helper.
> 3. link_update is called to replace prog A with prog B.
> 
> The reason is that __cgroup_bpf_replace fails to alloc and assign the
> required cgrp storage for the incoming replacement prog. Consequently,
> the new prog inherits an uninit storage, leading to null-ptr-deref panic
> when kick the new prog.
> 
> Fix this by rejecting link update with -EPERM if new_prog's cgroup
> storage is incompatible with link->prog.
> 
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>


Looks much simpler than the previous versions.

Other than the -EPERM in the commit msg, lgtm.

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]

