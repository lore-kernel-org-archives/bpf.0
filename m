Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503D355F49
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731559; cv=none; b=D0sWeVPaT7lJzXMDRGFlZXs2e1qaHdmawWiN0fCGJmIuYnCAiuZ2nIXDsPQ3JDX3ADOeK1aeYAShOzCudUb7a/DoF8+L2CfCGXnjviqAatYi2CBcFB/P0IDs45UJ++x2umx9eBQDrekK+IZl82PFx9dDXhSE251Nm0gCgr1Tr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731559; c=relaxed/simple;
	bh=8mhWJyvgZlOIZEpUnwiisN5zVDq2kbO9F2H/l/0UX+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5hxHJZHaw//jqcsa0dPaQFW4LHsRVEWETuc3QB7u/CmZVYsPoqAQN4yfWiVCnL8LMZhfU4vjADlSa/LdfBSvzTjGejCMNegefgDnljaQOn4FoyzJQUB9cIYd0TNeRJ1Yh25HUbj2aByOzyVF/JUBuOBqSoisZcW9HDacmErfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZQcHjn6u; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZQcHjn6u"
Message-ID: <8217d8dd-adce-4f18-84d0-af991e171f02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784731555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKqqpIBJNxWYi9YdHpKGqhfIWYSvOKJN/T92K8Ns/5c=;
	b=ZQcHjn6uX4QmsodZ/GlSJHEKekUfUzJOsuiyhO1pDwy/ZKEADR1VsKKc2Hwp26yx4wvzsS
	xLe1KI8GkxJzjtqPRcp0LRRz+6AnuHzFf9SJ3njfv2U5kb0konDdzKs89Lw/70uY268YqW
	gk9mqlJM2a68VXRoxhkxXn+p38VBT1g=
Date: Wed, 22 Jul 2026 22:45:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify no warning when close
 fexit link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Jingguo Tan <tanjingguo@huawei.com>, Pu Lehui <pulehui@huawei.com>,
 Lin Ma <malin89@huawei.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260721133036.49265-1-leon.hwang@linux.dev>
 <20260721133036.49265-3-leon.hwang@linux.dev> <amCncpSCkLLJfCvR@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <amCncpSCkLLJfCvR@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/22 19:20, Jiri Olsa wrote:
> On Tue, Jul 21, 2026 at 09:30:35PM +0800, Leon Hwang wrote:
>> Add a test to verify that there's no WARNING when detaching fexit link by
>> following the repro steps of previous commit.
>>
>> Without the fix, the WARNING could be triggered by this test.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> 
> left 2 nits below


Ack.

Will address them in the next revision.

> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks,
Leon

> [...]

