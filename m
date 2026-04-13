Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBCC347BA5
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112380; cv=none; b=MyZiAJu+7WIxeUJLU8IdbX9iyu7xPjlP/25pFr7Jzka8ppjPdWc6va+9LbuuaAo1E0kbdtJxpHQRyZrgD2B/yRyPd/lVtWo8CnrjyylQl47snxRs3BZ/FUIg38YmmPvVIMFKWFj2Y5CYQtu4ngoVoGN8CH4mmbpXF477auC5LS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112380; c=relaxed/simple;
	bh=mGFvpLb6Fs/TJ2Gb97N7ZuHtZhJ+uzFxzps6sgL/qeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxAisXvO1j1gekLh+lNGWhbkMocLmcv2eNVDE8FnXIquoIzv6ygbOe670cKnHLREqWtySSAkeDQHu/8LAR3gvvnSEaKLxlvId7YTzZKka00ddhIsdxulctuUMN0VxTtXTSk8nWsab4YkwWV2zCcMamYZlNZGgVgC40dmKOIMjk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eQKHe0ot; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eQKHe0ot"
Message-ID: <8c205cc8-4c59-4c1d-a845-c647b2574d4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776112375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYyVqPvxLhWSx5muCDuFHpTkRRXIoJbgXKmIVEDGIC8=;
	b=eQKHe0otxQnCii8KHgvGfn/CTRRipeumwTfcuiFgk5KpvNWe3U7XFG/7cUvUHybhi8MfMX
	kay4rH3eP2KzYfcPutUxIj4ZIbvl69mRiabsSRrDK+rslc9ek0vulQOQSkLlCfvHQslXA2
	/mn0UlMTVgqmV9k4nULzNEFgOEkhT0k=
Date: Mon, 13 Apr 2026 13:32:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412050033.267815-1-yonghong.song@linux.dev>
 <CAADnVQL462NnYNquWqJL8=CFZr6vJOxVzCPCpijV2MLAx0y67A@mail.gmail.com>
 <281485db-073e-45b6-8929-dad36fea5f87@linux.dev>
 <CAADnVQ+Xem-VErMn9f2MC52ugofFkA+XcUz4OqgvxJ9wTVz0JQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+Xem-VErMn9f2MC52ugofFkA+XcUz4OqgvxJ9wTVz0JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/13/26 12:59 PM, Alexei Starovoitov wrote:
> On Mon, Apr 13, 2026 at 10:26 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> Yes, we can do something like below:
>>
>>                   case BPF_ST | BPF_MEM | BPF_DW:
>> -                       if (adjust_stack_arg_off && insn->off == -outgoing_stack_arg_depth) {
>> +                       if (dst_reg == BPF_REG_STACK_ARG_BASE && insn->off == -outgoing_stack_arg_depth) {
> Something like that, but use BPF_REG_ARG_PTR name ?
> here and in the verifier?

We have a bunch of ARG_PTR_* (e.g. ARG_PTR_TO_MAP_VALUE, ...).
So maybe BPF_REG_STACK_ARG_PTR to distinguish ARG_PTR_*?
BPF_REG_STACK_ARG_BASE_PTR seems a better name as it does represents
the base pointer for stack arguments of a particular function.
But BPF_REG_STACK_ARG_BASE_PTR seems too long so BPF_REG_STACK_ARG_PTR?

