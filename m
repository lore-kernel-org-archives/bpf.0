Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7B3290B8
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279655; cv=none; b=RHYHGkZweGCZ22bJ7DyXnkR8BrUlEIynBB2W1nvzxAulWkD0n2bX3Nq29rGFxJqBqp7fz/Sq1VUC0B6ey+8wP15O0qBpIOHwOjrEz8oPvdqEyF3nlU1bshQMk2++w9Z84gDGvhbTgW1h8jlDrFyBIN5deCby/v4qhHnGzq+jNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279655; c=relaxed/simple;
	bh=ptUVIe7hs8B31TMpNhjyRGapNvnwonQQpN2oLunngDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WksX/NxnjtDpy7+rPy8UJ7sczWaTPrptpJl5D+HWjKIunKglIPapK/kdVqQcWKQAoiMhsFgdk+FWqg1m1XJ73AFSS84rSkV4ElOimw5XhhRcFG5otAShCNrL5pti5eDVNeV0RhO365lken10l3DQ5hO0jhDGoDzH9nwe3KaE4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0LSiDKw; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0LSiDKw"
Message-ID: <ac5b73c3-f886-404a-a608-29aca3782274@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781279651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoG+5Ny4Y44KKv74fhjS/uC+SDLiwcMyDAehLJSIfLo=;
	b=K0LSiDKwDUMPqJwjlhKzsbFEv2DMQMj522vZbsDrJmDWb10IJDxEbsLcJ3WxUQy6x25JjF
	7CpWAjB6kgCtGqNmwT7El+rdCoabB2cGR8gUsPKTWlJEJFnBkU11lOWkaC280fKCfg9G+U
	YHeJRTxesz4+5WuAmeet0TQlRRAQDbA=
Date: Fri, 12 Jun 2026 08:53:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: support shift operations with
 non-const src operand
Content-Language: en-GB
To: Tianci Cao <ziye@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com
References: <20260612121041.25254-1-ziye@zju.edu.cn>
 <20260612121041.25254-2-ziye@zju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260612121041.25254-2-ziye@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/12/26 5:10 AM, Tianci Cao wrote:
> Currently, the BPF verifier only allows shift operations when the shift
> amount is a known constant. This is overly restrictive for cases where
> the shift amount is bounded but not fully determined at verification time.
> For example, the following code is rejected by the verifier even though
> the shift amount is bounded to [1, 4]:
>      u32 shift = bpf_get_prandom_u32();
>      shift &= 3;    // shift is in range [0, 3]
>      shift += 1;    // shift is in range [1, 4]
>      r1 <<= shift;  // non-const but bounded shift amount

Do you actually have real use cases for this non-const shift?
Commit 44fdd581d273 ("bpf: Add range tracking for BPF_DIV and BPF_MOD")
supports range tracking for div/mod but the divisor and modulus
needs to be constant.

>
> Modify the shift helper functions (scalar_min_max_lsh,
> scalar32_min_max_lsh, scalar_min_max_rsh, scalar32_min_max_rsh,
> scalar_min_max_arsh, scalar32_min_max_arsh) to handle non-const
> but bounded shift amounts.
>
> Update is_safe_to_compute_dst_reg_range() to remove the src_is_const
> check for shift operations. This approach ensures the verifier
> remains sound while allowing more programs to pass verification.
>
> Also modify the comment on is_safe_to_compute_dst_reg_range.
> Shifts by more than insn bitness are legal in the BPF ISA; they are
> implementation-defined behaviour [of the underlying architecture],
> rather than UB, and have been made legal for performance reasons.
> Reference:
> https://lore.kernel.org/bpf/20210706112502.2064236-47-sashal@kernel.org
>
> Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> ---
>   kernel/bpf/verifier.c | 100 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 76 insertions(+), 24 deletions(-)
>
[...]

