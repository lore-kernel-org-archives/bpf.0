Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE5315D49
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043715; cv=none; b=PvTZXYE2OmWUwBWpf69nNPeVxrE1b09Zgg6pOL76CN4lWc9YqELTDY4e6w5cVpRmVBH0dEB9siTfW8tuOydS28ZiOqYGRWd6qOQe0eScQhwrfDGpok4xOhteJ0TFTyyjvKTYTfixBySqjOiy7uDr+cqexW2bIlQ6Bg877bBaZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043715; c=relaxed/simple;
	bh=yEKGtu2e4uK4Bod46cbDRvfekf1NB7CrPwMqfAf7MNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlcUbjCtTYuWayTVB7i8noBIegOmtgj9q7BIJevmr5qSFIEwmXgZJQM/9sIupk5STzKzl5pGfF71IqKfCV3rJWEL9K22FLMAYo+r4c/zf+V3by2an3wCaVCei1mNOOkcWcztKmDxLcrFvj4ptdF86zxbsRuTA563sq/gm6UVwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=snCpx6Qe; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="snCpx6Qe"
Message-ID: <2bd48c7e-e1b4-4498-99ba-18df16e7b358@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781043711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0yOQP8J31/xGy/19GRiGfVQjZatw67nUmbWHOWT3uA=;
	b=snCpx6Qev+fRiFzf4D4PcqKqRmWmW2rx4+Djs2TmcfBIQ9RtuEW/HAiNUoXNi6aODXYy8j
	cB4xcC4v4AqfUDU+/IcpRQZA4XL6rjorj2Fh07UPLD5Nr8RwNHJEAWnstYBG67BXmPYtiW
	qQdbF4KjeSN/l7gJMn/WhSukAQqjOQY=
Date: Tue, 9 Jun 2026 15:21:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Keep int return type for
 tailcall subprogs with maps
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260609163947.1717694-1-yonghong.song@linux.dev>
 <20260609163952.1718472-1-yonghong.song@linux.dev>
 <DJ4PQYTQDWQT.1ENYNRIC3C7IH@gmail.com>
 <145c7132-ec43-4238-801d-55d518fb0da8@linux.dev>
 <DJ4ULU6H2NYA.24B49ESUI6RNP@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DJ4ULU6H2NYA.24B49ESUI6RNP@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/9/26 2:49 PM, Alexei Starovoitov wrote:
> On Tue Jun 9, 2026 at 2:30 PM PDT, Yonghong Song wrote:
>> const struct bpf_func_proto bpf_tail_call_proto = {         /* func is
>> unused for tail_call, we set it to pass the          * get_helper_proto
>> check          */         .func           = BPF_PTR_POISON,
>> .gpl_only       = false,         .ret_type       = RET_VOID,
>> .arg1_type      = ARG_PTR_TO_CTX,         .arg2_type      =
>> ARG_CONST_MAP_PTR,         .arg3_type      = ARG_ANYTHING, }; and for
>> RET_VOID, we have below in verifier.c:         switch
>> (base_type(ret_type)) {         case RET_INTEGER:                 /*
>> sets type to SCALAR_VALUE */                 mark_reg_unknown(env, regs,
>> BPF_REG_0);                 break;         case RET_VOID:
>>     regs[BPF_REG_0].type = NOT_INIT;                 break; so we cannot
>> return 'r0'.
> Ahh, so bpf_tail_call() is a void return.
> Then, I'll take it back. bpf_tail_call_static() is correct with void return.
> I guess we have to teach the verifier to accept void subprogs asap.
>
> In the meantime let's do shortest possible hack for tailcall_bpf2bpf_hierarchy1.c
> to pass with llvm 23.

Sounds good. Will do.

