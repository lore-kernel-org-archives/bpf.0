Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9E3A3E72
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562408; cv=none; b=FFoyVjBL+SpNST85arzvoQiP4KTzoOVN0aOlrpSi9Q/mp0sbOqeFDgOKiure7xq9MQWTfV67QpfroaQJhCyWKUaT29Cu1Kjy9+aZK7UG46CQlgsf14LwbLoSe5dDlXi7l9TDTyq60CuAw9Kki4ZY8SgKZB1nmgN5NPOxe5ofMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562408; c=relaxed/simple;
	bh=Ewwx2pzAuTYWn5a+CUylyHtUhb4MPMt3XVeiLqZ3JzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S08gx1kM4lChe3I55zyA81Hc8z7WPUy8rdcQ0YJx2S3nlTbYImv+el3//6SV6MjRLp9O5e/NcguMYCNWk/c12EKK6f2KvNP1cuTsy5fowcB6piTlp5uhB+7TpKLhgBJHEf+KtWg5AmpRqit6VBfnKLEa0qUs4DizvQ7oq51qoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=taAZe0fP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="taAZe0fP"
Message-ID: <8f50e350-6788-45a6-8004-c5ac285700bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775562403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkrAA/oEhvlGvssoZIcqmwroYOw69QiH6A+eYcA32R0=;
	b=taAZe0fPADfoONx7d9qvlhTQJ+uD9EbdG7mdHPP7M8kFtSBGb2jh7JuUsp0Awm8+9Wtf2e
	k7I+w+bTQiMvTH6s8buPpMiGwh2nPSxPIcV3/vfWWH1TvFyjrcOa2V19zHq5FSke+tE8TI
	C0fVfxXW5BYSjAWRcYwHSfdVNP7Qp6k=
Date: Tue, 7 Apr 2026 19:46:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix same-register dst/src OOB read and
 pointer leak in sock_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
References: <20260407022720.162151-1-jiayuan.chen@linux.dev>
 <20260407022720.162151-2-jiayuan.chen@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260407022720.162151-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/7/26 10:26 AM, Jiayuan Chen wrote:
> When a BPF sock_ops program accesses ctx fields with dst_reg == src_reg,
> the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
> destination register in the !fullsock / !locked_tcp_sock path.
>
> Both macros borrow a temporary register to check is_fullsock /
> is_locked_tcp_sock when dst_reg == src_reg, because dst_reg holds the
> ctx pointer. When the check is false (e.g., TCP_NEW_SYN_RECV state with
> a request_sock), dst_reg should be zeroed but is not, leaving the stale
> ctx pointer:
>
>   - SOCK_OPS_GET_SK: dst_reg retains the ctx pointer, passes NULL checks
>     as PTR_TO_SOCKET_OR_NULL, and can be used as a bogus socket pointer,
>     leading to stack-out-of-bounds access in helpers like
>     bpf_skc_to_tcp6_sock().
>
>   - SOCK_OPS_GET_FIELD: dst_reg retains the ctx pointer which the
>     verifier believes is a SCALAR_VALUE, leaking a kernel pointer.
>
> Fix both macros by:
>   - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
>     added instruction.
>   - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
>     restore in the !fullsock path, placed after the restore because
>     dst_reg == src_reg means we need src_reg intact to read ctx->temp.
>
> Fixes: fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")
> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when dst_reg = src_reg")
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn/T/#u
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   net/core/filter.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb05..53ce06ed4a88e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10581,10 +10581,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>   				      si->dst_reg, si->dst_reg,		      \
>   				      offsetof(OBJ, OBJ_FIELD));	      \
>   		if (si->dst_reg == si->src_reg)	{			      \
> -			*insn++ = BPF_JMP_A(1);				      \
> +			*insn++ = BPF_JMP_A(2);				      \
>   			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>   				      offsetof(struct bpf_sock_ops_kern,      \
>   				      temp));				      \
> +			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \
>   		}							      \
>   	} while (0)
>   
> @@ -10618,10 +10619,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>   				      si->dst_reg, si->src_reg,		      \
>   				      offsetof(struct bpf_sock_ops_kern, sk));\
>   		if (si->dst_reg == si->src_reg)	{			      \
> -			*insn++ = BPF_JMP_A(1);				      \
> +			*insn++ = BPF_JMP_A(2);				      \
>   			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>   				      offsetof(struct bpf_sock_ops_kern,      \
>   				      temp));				      \
> +			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \
>   		}							      \
>   	} while (0)
>   



Sorry Martin, I forgot to include your Acked-by tag. You can add it when 
applying,
or I'll bring it in v4 if revisions are needed.



