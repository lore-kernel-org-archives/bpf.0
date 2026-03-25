Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD43DBD4E
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446890; cv=none; b=A/UslVUtKy9hwscK03jyNFreTHMOYKWkEJ0M/PRP6brODhwXep1xRbCuaObFrgAc0c4aCBmclekeLkxYgDdfCW4S/3qop/RBN6KkRAw/hasqarVFZ1ft+evAp/VRy4SkdGy/+edUJJiP/iQqIbv1w9OAWTmI/sZsF1ZnLAIum8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446890; c=relaxed/simple;
	bh=q+pMp5JVqAvlUlZ++vIPWfFNi3wud0iVLrZfD7M2nR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5R4AX4uOyzfk0STJrKEhYbD1RmQKTLH9TAQqjguK2lBawobBlMPcKpPUhb/pCvR0ihKOOo2p2qh55UkBVG9T08mMKUfsdSmT4LMOUftXZejK0MM0JMnIdDL+dkfvrQ/nhYkgRcZr9zagcnors/lzOpNsLdhaOjyalIntsHMXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m0Hgn8yd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m0Hgn8yd"
Message-ID: <5e960b3f-bc29-4d92-8af0-ec207e3946f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774446875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxQsf2q1ci5YPhXSa4LVGW35p81aNPC6dkLRQOM/qOs=;
	b=m0Hgn8yd2lA+M1l0fBoYvP9D17kDemrGYGXcJYrOFSRmYnjvWysNwrt1vpwkRn0Rg+K9as
	SzLq4wyTslbyXJ2rssrnv2NtZfsfjF0fH6yZqy5kY/Orv8GtIK42qRtJoKCv75rpBT1j04
	4KLOYm5gie+PIWtLQYp8sSuoupKQaYI=
Date: Wed, 25 Mar 2026 21:54:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Disallow freplace on kprobe with
 mismatched kprobe_write_ctx values
To: Jiri Olsa <olsajiri@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-3-leon.hwang@linux.dev> <acPaTdLd70YI_uNW@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <acPaTdLd70YI_uNW@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/3/25 20:51, Jiri Olsa wrote:
> On Tue, Mar 24, 2026 at 11:04:43PM +0800, Leon Hwang wrote:
>> uprobe programs are allowed to modify struct pt_regs.
>>
>> Since the actual program type of uprobe is KPROBE, it can be abused to
>> modify struct pt_regs via kprobe+freplace when the kprobe attaches to
>> kernel functions.
>>
>> For example,
>>
>> SEC("?kprobe")
>> int kprobe(struct pt_regs *regs)
>> {
>> 	return 0;
>> }
>>
>> SEC("?freplace")
>> int freplace_kprobe(struct pt_regs *regs)
>> {
>> 	regs->di = 0;
>> 	return 0;
>> }
>>
>> freplace_kprobe prog will attach to kprobe prog.
>> kprobe prog will attach to a kernel function.
>>
>> Without this patch, when the kernel function runs, its first arg will
>> always be set as 0 via the freplace_kprobe prog.
>>
>> To avoid the abuse of kprobe_write_ctx=true via kprobe+freplace, disallow
>> freplace on kprobe programs with mismatched kprobe_write_ctx values.
>>
>> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> 
> hi,
> so it's another issue in addition to that on with tail-calls [1]
> do you plan to resend this fix as well?
> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/20260303150639.85007-4-leon.hwang@linux.dev/
> 
Kumar will re-post it soon.

Thanks,
Leon

