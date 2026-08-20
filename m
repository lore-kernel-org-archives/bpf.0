Received: from mta1.migadu.com (out-148.mta1.migadu.com [95.215.58.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868E3EDE40
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218002; cv=none; b=XQsgSrizBcgKrc1ShlkynmfItqpc3E8Q2NVde8EHlwazJQ7KFDnyA2E9rx3E23OdU80omaV6VofNnExUShIeYcn7zgWguEpocPe5Hfu3+8kxhEkf33fwvzZq0ARmraR6MgGJ9q10fzMKjg3f6RI//7Ddx/esKtVxIMDA0JxkMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218002; c=relaxed/simple;
	bh=Gek/TUnjnbgVkkRz4P0hFtvgEDARD/U6vioE9VPA7iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thapKOAuPQu1yJWhjfjFsH0niCMrG0HL2WQSfd4R59dbQr6OPR5wUaQchadZMCP0pvVSsm4bk+y4IjObAiu2mkrWD7O0ixBthdrCzUUClIwu56koQgHsAMwg+Owg+CezugETJfAZq4N76HKK5WSg17GZNHCPSxxdd+8SG2MR0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jAoetNUm; arc=none smtp.client-ip=95.215.58.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jAoetNUm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gek/TUnjnbgVkkRz4P0hFtvgEDARD/U6vioE9VPA7iQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787217983; v=1; x=1787822783;
 b=jAoetNUmjcJN4+mt/G5DmSVDpoSW30qbUI1NhmbZWAVa+JSba4d8e5iPzVTJHMw3dTBuL115
 rH5xAWJH/iMuifJW2M4j8SBdsU6fmAN4rSvsIT9OXpi8w0CnL63xwW3uCjNmKfwikkn6fptziRP
 8LGtXP7quzULWrNo4DNHGAVE=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (118.201.124.118)
	by smtp.migadu.com with ESMTPS id f4bcea8e9c0a67ac;
	Thu, 20 Aug 2026 09:26:23 +0000
X-Mizu-Trace-ID: f4bcea8e9c0a67ac
X-Migadu-Flow: FLOW_OUT
Message-ID: <14c836d6-8919-40f8-8559-bd6048c14316@linux.dev>
Date: Thu, 20 Aug 2026 17:26:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: keep trampoline progs alive until image
 release
To: Junseo Lim <zirajs7@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 Sechang Lim <rhkrqnwk98@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20260820022831.18601-1-zirajs7@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260820022831.18601-1-zirajs7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Junseo,

On 20/8/26 10:28, Junseo Lim wrote:
> arch_prepare_bpf_trampoline() embeds program pointers in the generated
> image and passes them to __bpf_prog_enter_recur(). After
> bpf_trampoline_update() replaces the image, bpf_tramp_image_put() can keep
> the old image executable past a normal RCU grace period.
> 
> A detached non-sleepable prog can therefore be freed before a preempted
> task reaches rcu_read_lock_dont_migrate() in __bpf_prog_enter_recur(),
> leading to a use-after-free.
> 
> Keep image-local prog refs and drop them from bpf_tramp_image_free().
> 
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")

There was an existing fix [1]. Could you take a look at that fix?

[1]
https://lore.kernel.org/bpf/20260819122252.1782790-1-florent.revest@linux.dev/

Thanks,
Leon

> Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
> Signed-off-by: Junseo Lim <zirajs7@gmail.com>
> --- [...]
