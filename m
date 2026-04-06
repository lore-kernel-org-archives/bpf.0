Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38A1427A
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775451270; cv=none; b=VieNq9nYEW9i6Km22O6ruEQz8AU1pBPix8S7/gohUQcVgneoncS0cutoQI82BtO5Ol/bUbuVNx3yXYVFZqMvtmYW+r+4blMyHQSBcRtE4G/5UXGg0D1MMqMkabmHo/9d2LGmftmeXTjRN3D3b4tbY1rMP6LzpAoukks7H9QljGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775451270; c=relaxed/simple;
	bh=i/M/U1Rs0FJn+opFy02cwva2q+VoShzETD0zYZFGZcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHRTaREzSFeC+ZE6r3FDxYLhQG1Lu7/ua53Cf/7I48bxUiARXNY/lL4A5RUiRSwh4J7IWaXFnB+KU86JlExiNm95nTsdqfr56xhHBf67Gfv5c69ua5plBWDy6hy41VdqrzhJU2kI6tlPatI2FUp/gqAVvfEAhQiK4Qug11R/GUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eH6SWGcH; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eH6SWGcH"
Message-ID: <739cdd1f-1838-457d-9b71-f47c3eadb0fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775451266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNbb8FX4JBbRHJzrlKceD/p+eg1E4vsexHkNHXJOTVg=;
	b=eH6SWGcHg/XM9mk09g5me7tLM3qVV1qLzSSCdcCvmV3nCl4LqFDVfcMLm4clqMs6K7WZNk
	d/qcdLWiTG+Hr41tmwrrx8Ta2SLTtwU4vpGQ3wRe7Wb8dNmiH7nkXeuhL2Q2r5KhIRNVil
	7vKND561a5c5lVMyHwL7UGkhePEg/fM=
Date: Mon, 6 Apr 2026 12:54:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and
 pointer leak in sock_ops
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: 2022090917019@std.uestc.edu.cn, dddddd@hust.edu.cn,
 M202472210@hust.edu.cn, dzm91@hust.edu.cn, emil@etsalapatis.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
 <913274772cd62d8d93e6cfb2c251c2388b73f24f90d05be3c9994207ac7048bf@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <913274772cd62d8d93e6cfb2c251c2388b73f24f90d05be3c9994207ac7048bf@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/6/26 11:47 AM, bot+bpf-ci@kernel.org wrote:
> This Fixes: tag covers the SOCK_OPS_GET_SK() portion of the fix,
> since 84f44df664e9 introduced that macro. However, the identical
> bug in SOCK_OPS_GET_FIELD() was introduced by an earlier commit:
>
>    fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")
>
> That commit added the dst_reg == src_reg handling to
> SOCK_OPS_GET_FIELD() with the same missing zeroing in the
> !fullsock path. Should this also carry:
>
>    Fixes: fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")
>
> Without it, kernels that have fd09af010788 but not 84f44df664e9
> would not receive the SOCK_OPS_GET_FIELD() fix via stable backport.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary:https://github.com/kernel-patches/bpf/actions/runs/24017481706
Well, it's true. However, fd09af010788 and 84f44df664e9 are from the
same patchset (same author, same minute), so any stable branch carrying
one will have both. That's why I only included a single Fixes tag.

But if you prefer carrying both explicitly, I'm happy to add it in next 
version.
