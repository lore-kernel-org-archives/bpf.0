Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41810366820
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730552; cv=none; b=tVHpp9EvxFEGqbRVx6hYWsH6kqhPbbo7oXvwKciWDqXyv3KUsRkBjuZd8uMzlytQSt+bbmpPCALA3dWRlFud1sIL3FifidxK+zro5ydIWUXX3ZxKlqB0qb99pSUMaRgULhw6sJsSQSbd1aO4mB8Uzn4OiOyp7STJ/Orjd8ZHwZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730552; c=relaxed/simple;
	bh=imTjA+0O2e6HQVFcIonBts3XhcrtKnuS8mtXFp20zik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SK8cPvuyNn64Dw4f73WHFbru5SMrqMaKSMw4DzQ4K4ODaeqC6jNBuhwBBlb1Pv7m2V5yf8mqy+etszb4mLaVb7GkMYxmIh0384O4PinCRizM9Yax84hDZJvjl55CSJ/QCDI+Wbetdo1adhF9X9VOk/RuRRWWetVm6dmwYCKy7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hog9A6Yw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hog9A6Yw"
Message-ID: <4f30012f-778b-4c7d-b610-2e18cf01abdd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782730539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKHjzvlntcGT6k+3BIWnKFMiFZceKFoemKxv/3R/xQY=;
	b=Hog9A6Ywk551pSQKQZ3mlgkE6vuPXrJMM2Bpjvo5zIIqMGVRmf+xZYSYvREkuftUw4ytUq
	VLQMNiw4yUYeKlXvSXEDDIK996aWh9XCnghDZJLE3+DwAw7KrWJSXCbcC3W0CIbixgd6f9
	NPuXC77d+JvihbARenpAZ3+eTvKERBs=
Date: Mon, 29 Jun 2026 18:55:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <855e44f3-d22c-47e5-8bd1-c5d9f7014a75@linux.dev>
 <ec28f0f9-0693-4c9b-88fa-bffca446a63c@huaweicloud.com>
 <b8d8ab5e-bef1-4c95-8e5b-ea9768041b2e@linux.dev>
 <55499fcf-d552-4366-9016-21ede7f687ac@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <55499fcf-d552-4366-9016-21ede7f687ac@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/6/26 15:51, Xu Kuohai wrote:
>>
>> With the elimination, the callsite of 'subprog' has been eliminated.
>>
>> However, as you mentioned above, the argument preparation insns are kept.
>>
> 
> I see, the CALL insntruction is removed, not patched to NOP.
> 
> So the call site is either a call to subprog, or totally removed. The
> fentry
> tracing only works when the CALL instruction and the subprog are not
> eliminated.
> This is exactly what SDT tries to solve.
> 
So, why not add a macro for the stub following the subprog+fentry idea?

#define DEFINE_TRACING_STUB(__stub, ...) 	\
static __noinline void __stub(...)		\
{						\
	...					\
}

DEFINE_TRACING_STUB(my_trace, int, len, int, ret);

SEC("xdp")
int xdp_prog(struct xdp_md *ctx)
{
	...
	my_trace(len, ret);
	...
}

Then, add a libbpf API bpf_program__remove_stub(prog, my_stub) to drop
the stub by the way like my demo.

Thanks,
Leon

