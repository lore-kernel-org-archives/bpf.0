Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F226ED41
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177946; cv=none; b=aJM46+TZIdcCn69PeH9+Xwr8ybS2PTlXfD22f0U+BqVaOLs3c6uwT/Fh9u30aI0EQUCnRutR/bZcwW/S6+Cqw/OzZ4Dy+E9rai6deOYecmCW6fw5/a59TH7W4g9iL6rsH8nFzFuifqBco1+6B0nKykuiZyRXG5PyzHz/AdiWa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177946; c=relaxed/simple;
	bh=Q+OtUgkTLjMviwdPjO6dyXit9l1yGqWak2Q+ZgX/A2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YldTsgFShTUuReCrVeMRoav+75G1MjVD7oGMGPSh0ZzNgLMmy0YheZU7khv/TZ/HMC83pawCUs7cwWXJVuG5dxqyfC7PyzpMQWow4IpA2qWbq3gj4r4X2kWwSILsTtREQa8m/GXNU3Dlby8ydCoTw6ZESGXBwdYGON2hGW33VUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=luh4BpEt; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="luh4BpEt"
Message-ID: <20a444b2-aeed-4af8-ba76-e994e2c14087@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784177940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvCD2v4AruZcFU070q9xEZedJW9EMLvMy6qcn3WXYx0=;
	b=luh4BpEt1Vw63yLxuktf95I3AsZECoA/3XL1SK8XHWRUNP1/s75dQxFU65jkP25Ml5WQGm
	kZLGW9kereDgs6y9UTClpfQKSlz8AYCYSFOpJj6TRW4Mh6P60GIxUe0J0Ipo+MP1BM2MEu
	V4Bz5j4yq4bkv5IBJBk6AsywIkRiBVE=
Date: Thu, 16 Jul 2026 12:58:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf:syscall: Log error code on trampoline unlink
 failure
To: xu.xin16@zte.com.cn, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: xu.xin@linux.dev
References: <20260716113419588y6Ycmo7pzva8buwne9yWZ@zte.com.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260716113419588y6Ycmo7pzva8buwne9yWZ@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

In subject, 'bpf:' is enough, 'syscall:' can be dropped.

On 16/7/26 11:34, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
> code from bpf_trampoline_unlink_prog(). This aids debugging of race
> conditions during link teardown, while keeping the warning rate limited
> to avoid log flooding.


Have you tried to trace bpf_trampoline_unlink_prog() with fexit?

bpftrace -lv 'fexit:bpf_trampoline_unlink_prog'
kretfunc:vmlinux:bpf_trampoline_unlink_prog
    struct bpf_tramp_node * node
    struct bpf_trampoline * tr
    struct bpf_prog * tgt_prog
    int retval

Since bpf_trampoline_unlink_prog() can be traced with fexit, it seems
unnecessary for this change?

Thanks,
Leon

> [...]
