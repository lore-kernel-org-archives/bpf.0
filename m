Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD5239085
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129752; cv=none; b=O8hUlL7//KIzs05A8/FaGVnB1Q/YUUEtDKTUXktj0lUsmvNSrY6nnWtP7/qRLCdRcXYZThgCLWij+QjkcJ0kEmp3J/DdLOjgk0XdWtF/a0cQQE918+r7d9i4AAcOC8NBJw3dXcKMllJ5tWOh8UI1l8fKs+MnPBzpCGg3SbUsHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129752; c=relaxed/simple;
	bh=n1U6JUPQS/QlQvnJNmSAj8kcYKjN2e1Oop2QgAyo+sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBPluE+GiD77h8zkijwEb80jatuBJQ9WUYNd8G/nEwUGb8PQwAlvWEismXzuOihWUlO+M9jUlihgD9DNNpQzemvFeD6zDeuBtWGcSLvYFGn9/5W+EWIguzhm4FD0ybjnteXtMQoBIxyMRGjf8Ks59t1X6H8axehXyvkWA6cxTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5WqFkRk; arc=none smtp.client-ip=95.215.58.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X5WqFkRk"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n1U6JUPQS/QlQvnJNmSAj8kcYKjN2e1Oop2QgAyo+sM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792129747; v=1; x=1792734547;
 b=X5WqFkRk2kd2V24OVsVFlZuDinrzkfixOvgPcM1eeiNMUIy3/GAzlorrOT5EOXi8vNcBHJGy
 bqwo5I0duXuAeTBFXXzGFag6dNAib7tFMgbsWGeg/8DNLSX5cxzQrNmoh39b9rvjovXSUjRt+uc
 RAOTOL0gFudHUMbO5wNRH9MY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7476dcd9d282368f;
	Fri, 16 Oct 2026 05:49:06 +0000
X-Mizu-Trace-ID: 7476dcd9d282368f
X-Migadu-Flow: FLOW_OUT
Message-ID: <b0bb3596-35a9-471b-a666-d7a638d00e5d@linux.dev>
Date: Thu, 15 Oct 2026 22:49:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 5/8] bpftool: Emit __bpf_core_pso on
 verifier-rewritten context types
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Vineet Gupta <vineet.gupta@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
 <20261016000012.2232059-6-ihor.solodrai@linux.dev>
 <DM5VEJ802JZJ.2Y2NI0GZNVXMD@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DM5VEJ802JZJ.2Y2NI0GZNVXMD@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-15 6:27 p.m., Alexei Starovoitov wrote:
> On Thu, Oct 15, 2026 at 05:00 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> Clang 18 through 23 crash on __builtin_preserve_field_info over a PSO
>> record, including bpf_core_field_*() and the CO-RE bitfield helpers.
>> -D__bpf_core_pso= can disable PSO for affected programs.
> 
> ouch. anyone working on fixing llvm ?

I have a vibe coded fix, planned to review it and send a PR.

> hopefully people don't do
> bpf_core_field_exists(skb->tstamp_type)
> when skb is __sk_buff.
> 
> since nobody will know about -D__bpf_core_pso= workaround.

When PSO lands, people might run into this as soon as they use new
bpftool to generate vmlinux.h, and the failure is very loud.

Since the bug is quite old, I am not sure it's feasible to fix it 
everywhere. Probably best we can do is advertise the workaround.

> 
> Name is also not great.
> "bpf_context" ?

Yeah, the __bpf_core_<foo> might not be the best name.
I like btf_relocatable for PAI, should this be btf_unrelocatable?..

In any case this is bikeshedding, the macro is local to vmlinux.h,
not a big deal.
