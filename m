Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7482D90
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251549; cv=none; b=kRq+6WQzkNJsURwmjGIs/oOM+IvvbOfVCjA/qN3y/Y4r3A+J+hOtc9GaKBQi7pgyEVQte1GNkrjmh+OF/qOSdTQag6JZqFbTnX/GoQqqtvpBkz2gfBeH37Sh7RYUasLBSYgI4JWDlcQ0DpTk7hs3VJCh/TfRrjKOHo6EXGFCPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251549; c=relaxed/simple;
	bh=jgKeLawvvBF2acZpw4qcy7oAsMVjWn+sNPlwrXv58Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMq37d50OR7Ni99+2s5KE95cHtbCvTg96/YsrL+PgLc4b1YOkW8Qpl9/dAqaNYTR1uyqyjv55/DKBuAvNZ91xQTRGKlJSTSVNnSYYsLLVz0T+gVm1N+F6qUrhCmHaPVc5HgWuXrxgDHP+j1CaukdhVpTtvCsOKQWcZATNPKUXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NFJRR3ry; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NFJRR3ry"
Message-ID: <4ac94d18-082d-4725-9600-0e0a7ccd39cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712251545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHC7VpwPJFRk45txxpHLGqruMV8WCKWWdJ3v8ad1/i8=;
	b=NFJRR3ryl2aktnGHywBGNwpa7jgSZBoVZZkuUc9wEyeoojT1ltweamtkSv1uo0IxFRDuxB
	IjfxKWODG+azfkijLyp3NQFme5LprLrW9UGh0jMI5/t09G3dO37EOdejb2BehYVFLsA2w1
	KYGlOnI0QEZ9Rk/sC8Jpp4SUQF3l2MY=
Date: Thu, 4 Apr 2024 10:25:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: make bpf_get_branch_snapshot()
 architecture-agnostic
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240404002640.1774210-1-andrii@kernel.org>
 <20240404002640.1774210-2-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240404002640.1774210-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/3/24 5:26 PM, Andrii Nakryiko wrote:
> perf_snapshot_branch_stack is set up in an architecture-agnostic way, so
> there is no reason for BPF subsystem to keep track of which
> architectures do support LBR or not. E.g., it looks like ARM64 might soon
> get support for BRBE ([0]), which (with proper integration) should be
> possible to utilize using this BPF helper.
>
> perf_snapshot_branch_stack static call will point to
> __static_call_return0() by default, which just returns zero, which will
> lead to -ENOENT, as expected. So no need to guard anything here.
>
>    [0] https://lore.kernel.org/linux-arm-kernel/20240125094119.2542332-1-anshuman.khandual@arm.com/
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

