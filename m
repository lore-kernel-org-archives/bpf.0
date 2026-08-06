Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26F377AAF
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039366; cv=none; b=Xw4H1HRjOyp71uS4v9Ys51jt27AmunbVXwq6GHdD7LEbfpBwkefL24ZgTii/sgMCh6hd2WUecZzJqUFUsAFpWpcDEhtp0x7sd66qo8h9Y512XQmvlMC4kx2l4i8bb1O8Ru/ACzdu6LmjGef8WmS7E1gshmdPN910/KpQOfBkeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039366; c=relaxed/simple;
	bh=9POLQT+zTFRki/+eCNOnpk8JB3mOiOI14Nq9BmTY+sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vp8Quxn9VNbqhYh5SM3aoSiPMFeCriqK/j48dBYw2q3gSD4cxuLPWXBJsy6Nu4XKFNEg9x6vaUFuM7TO6frh2F3340ZH3zoNL300soiWZptG/mz6FU4DtpfeCTyyRkvqtKSf/6FWEiu65cSnQ8BrKBNhyAFtw1KBVMfVR0xVvdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DyVJx+F2; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DyVJx+F2"
Message-ID: <c59f8a61-6774-411a-bdfc-557f3488a7a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786039363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmwM2eAGJQFWYAODi4Ju6lTqdTYZIJHEDBHI855cTYo=;
	b=DyVJx+F29iVyYoRMF8ahVAe4SPDowZh7UlBe/VRrgIcaV0ivAufgIWcLNBjRxifIqp40Ri
	k/dyrEbfEFC61ctiGu0hwatazzgGzjhmi6VROCwbFlbrQuqYRjac3Vuf3lUGYjcL8FKx+D
	8uVN+4Ukhq1GhqD3h0tEyy/+9mnQn5w=
Date: Thu, 6 Aug 2026 11:02:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next 0/4] selftest related fixes
Content-Language: en-GB
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org,
 ast@kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org
References: <20260803170251.1898102-1-vineet.gupta@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260803170251.1898102-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/3/26 10:02 AM, Vineet Gupta wrote:
> Hi,
>
> This is a set of fixes accumulated during BPF_GCC testing and an in-works
> verifier enhacement series for 32-bit tracking.

Similar to other patch sets, let us have the proper format for the subject
for example:
     [PATCH bpf-next 0/4] selftests/bpf: Fix a few selftest issues

For each individual patch, do
     [PATCH bpf-next 1/4] selftests/bpf: ...
     ...

>
> Thx,
> -Vineet
>
> Vineet Gupta (4):
>    selftests/bpf: map_kptr: force BPF_STX for the scalar store to kptr
>    selftests/bpf: add --no-error-summary to skip end-of-run error log
>      dump
>    selftests/bpf: report failed subtest count in test_progs summary
>    selftests/bpf: vmtest.sh: preserve command quoting when running in the
>      VM
>
>   .../selftests/bpf/progs/map_kptr_fail.c       | 11 +++-
>   tools/testing/selftests/bpf/test_progs.c      | 62 ++++++++++++-------
>   tools/testing/selftests/bpf/test_progs.h      |  3 +-
>   tools/testing/selftests/bpf/vmtest.sh         | 13 +++-
>   4 files changed, 64 insertions(+), 25 deletions(-)
>

