Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AAB3B2FFC
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421647; cv=none; b=uR6vg7Pn6hKbI55ZzQf1Y51FR3M66WkPryqxdjTKox+w+cNA1A+YC87YPXmf7U05d5jyvyg1PKhpI3dGZVHS0Z6LbEIzUOByDGimeoyWdl9DWbQJ51MMH6UlFyeXoLtov1yGbGpCzKoagTBp/n1zYA4cqzUGZQs1mX2UL6xFDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421647; c=relaxed/simple;
	bh=IaXeKln7M9N7HcvTCKtwJ4tn/m+fj0Km4rcVmVH7hD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pK1uIU7mAHwoJMSetX30N6hVhG4InrK6lYWYQzMywZ98R8Zd7QZSFPXxkcko0inezzsAjFv3fy0NjgTQ6wuNV4WFb7G48+GLBSR7ANMko3siJ7sMhXEDE0dYPmyJbY5bWbGGO/PUs3xzhQd8OPK2bmPV+yn4dUfOQyBVnnuiO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oa6qtvm6; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oa6qtvm6"
Message-ID: <0d25b0b7-5560-482c-a626-fc43abb045b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776421631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8L1TXwxJHEz1sfg1EUcrGf2kt7J7QaV9bX1WaMgGMU=;
	b=Oa6qtvm642n96GU5TT04Z7xtWs1T0GAdrjl61vbOlvZmKZHrwCGxsdOfZSRdpn+/yn+hu2
	L4E5GSx89h9FmPwpy15PDmLRne3CoyX/PtEIMAgfyxkPE1Ge2yeZmEwSdSWfCdZijQma2o
	Mo0sHyoi3R5jlGGtVXd/mJOKoIMVE/k=
Date: Fri, 17 Apr 2026 18:26:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
To: KaFai Wan <kafai.wan@linux.dev>, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 jiayuan.chen@linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>
References: <20260417092035.2299913-1-kafai.wan@linux.dev>
 <20260417092035.2299913-2-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260417092035.2299913-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/17/26 5:20 PM, KaFai Wan wrote:
> A BPF_SOCK_OPS program can enable
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG and then call
> bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB or
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB.
>
> In these callbacks, bpf_setsockopt(TCP_NODELAY) can reach
> __tcp_sock_set_nodelay(), which can call tcp_push_pending_frames().
>
>  From BPF_SOCK_OPS_HDR_OPT_LEN_CB, tcp_push_pending_frames() can call
> tcp_current_mss(), which calls tcp_established_options() and re-enters
> bpf_skops_hdr_opt_len().
>
> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>    -> bpf_setsockopt(TCP_NODELAY)
>      -> tcp_push_pending_frames()
>        -> tcp_current_mss()
>          -> tcp_established_options()
>            -> bpf_skops_hdr_opt_len()
>              -> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>
>  From BPF_SOCK_OPS_WRITE_HDR_OPT_CB, tcp_push_pending_frames() can call
> tcp_write_xmit(), which calls tcp_transmit_skb().  That path recomputes
> header option length through tcp_established_options() and
> bpf_skops_hdr_opt_len() before re-entering bpf_skops_write_hdr_opt().
>
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB
>    -> bpf_setsockopt(TCP_NODELAY)
>      -> tcp_push_pending_frames()
>        -> tcp_write_xmit()
>          -> tcp_transmit_skb()
>            -> tcp_established_options()
>              -> bpf_skops_hdr_opt_len()
>            -> bpf_skops_write_hdr_opt()
>              -> BPF_SOCK_OPS_WRITE_HDR_OPT_CB
>
> This leads to unbounded recursion and can overflow the kernel stack.
>
> Reject TCP_NODELAY with -EOPNOTSUPP in bpf_sock_ops_setsockopt()
> when bpf_setsockopt() is called from
> BPF_SOCK_OPS_HDR_OPT_LEN_CB or BPF_SOCK_OPS_WRITE_HDR_OPT_CB.
>
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn/
> Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

I think the result of AI review is false-positve.


