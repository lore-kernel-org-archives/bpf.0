Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9A30BB80
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961303; cv=none; b=RGFaQAZpHo+72s7v/acG0fCXtxfYap9I6tVDm3ZI/Pgdgu65BhBgL1LW8pt/p2EVc0YZCiAfcx5TKLOrvrypJpeeH/KfEyEwY8mZKYHWbkdFk0w39nVhjU3z09a83nV9j2E8uuGcxm5/A09aR+uq8WHQ6sYlITDywKTIe13cv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961303; c=relaxed/simple;
	bh=rllRCONuXR/41cxuzszfvBDkSYEgoLCZ/m/yVzrkiEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enVOvSRZ6FJQ2xKDbFVn/lp430MzNckRF3uhiK3ycRcYGGmaa9xhwFYxNkIZMY8rlvSmcahVDZHUbgjsJCfY9aLuifxmvRL1AVmEr04mJDOey9fOaI8PO2ha7T+kDDXLF3cJhWRft5o2eubhtq84fMftDyvXmbH28ow+ChLNfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CDaExw/Y; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CDaExw/Y"
Message-ID: <9b2196dd-443b-4632-ae11-030cdbdc59b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783961298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LT6LUEotyGC5IGoHUHi3tdJ4oqkrHoHeSXvbUIYFcPU=;
	b=CDaExw/YDor84Rmwy1Lv8I/aS2DkQ0LqTvEVBUN54Scykf+EpPyfeYNlpAL+NcNgOYAiJ0
	TDyg5EjytL8syAFoSFcdEvb93ePypnChPZ5w35SjbRD9n76EXNMJQMRx8J9doFHg9yQW8k
	MC/DSS4USmc+g2SQjUyL7GxbDKhrrGE=
Date: Mon, 13 Jul 2026 09:48:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix tracing of kfuncs with implicit args
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
 <20260710192940.3020280-2-ihor.solodrai@linux.dev>
 <a183b4d6f3e814f9ffb79c8e0efca8b5f162e127.camel@gmail.com>
 <3b272469-9563-4843-8126-5c6698a84d98@linux.dev>
 <55f4d7bba39f0fd1e85f436423a4b9a967470701.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <55f4d7bba39f0fd1e85f436423a4b9a967470701.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-07-11 4:51 p.m., Eduard Zingerman wrote:
> On Sat, 2026-07-11 at 10:57 -0700, Ihor Solodrai wrote:
>> On 2026-07-11 3:43 a.m., Eduard Zingerman wrote:
>>> On Fri, 2026-07-10 at 12:29 -0700, Ihor Solodrai wrote:
>>>
>>> [...]
>>>
>>> If I am not confused, I think that resolve_btfids() has to verify that
>>> kfunc flags are always the same across multiple sets.
>>
>> Some form of build-time enforcement will be implemented as part of
>> resolve_btfids() BTF handling, see the v1 here:
>> https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.dev/
>>
>> *If* you're right about no valid use-case for incosistent kfunc flags,
>> then long-term I agree: build-time enforcement of consistency, and
>> then the acummulation can be replaced by a search (find first) here.
>>
>> But this has to be confirmed somehow (by thoroughly inspecting all
>> current inconsistencies and flags?..)
>>
>> However if there is even one valid use-case, then we are in trouble,
>> because then depending on the flag semantics it may or may not make
>> sense for it to be consistent accross kfunc sets. And it's not even
>> clear what a good solution to that might look like: separate groups of
>> flags? consistency enforcement for some flags, but not others (this is
>> literally what Andrii suggested in resolve_btfids thread)?
>>
>> Accumulating flags across the sets is an acceptable workaround for
>> this fix IMO. We can be more specific and *only* check for the
>> KF_IMPLICIT_ARGS for the purposes of this fix though, but we still
>> have to walk all hooks and OR.
> 
> And what would that mean for the same function to have
> KF_IMPLICIT_ARGS in one set and not to have it in another?

That would mean a bug in a kfunc set declaration, yeah.

> Given that actual function address is resolved to the exact same
> function. Such accumulator would only proliferate already confusing
> behaviour.
> 
> I don't think that the analysis of existing cases would take longer
> than 1-2h.

It was silly of me to mention the analysis as an obstacle (which I'm
not excited to do, sure). We are at -rc3, so there is a couple of
weeks still if we are targeting 7.2

But resolve_btfids series is certainly a merge-window thing, so the
fix shouldn't depend on it. And even carving out build-time KF_ flag
consistentcy enforcement from there is too potentially disruptive for
a "fix" IMO.

How about the following plan.

In the fix:
   * delete btf_kfunc_accumulated_flags()
   * expose (back) btf_kfunc_id_set_contains() from btf.c
   * in btf_attach_func_proto() walk the hooks and specifically check
     for *consistent* KF_IMPLICIT_ARGS
   * -EINVAL on inconsistency

In the v2 of resolve_btfids series (targeting 7.3):
   * implement kbuild/module-time enforcement of consistency
     for *all* KF_ flags
   * fix in-tree cases where that's not true
   * if there is a valid use-case, it should show up as a blocker, but
     I'll also eyeball all the kfunc set declarations

Does this make sense?

> 
>> I don't think it's reasonable to wait for the comprehensive kfunc flags
>> analysis and resolve_btfids series landing before fixing the garbage
>> dereference bug.
>>
>>>
>>>> [...]
