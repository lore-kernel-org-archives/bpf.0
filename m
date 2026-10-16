Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316458B6CE
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172691; cv=none; b=WLfSVGos/7aiOuHYQZcnv5MTZpqTFC3Lu7+v3y8dKMte6zU+KJABs3TwP8fF/HPSgppHiSMYw0MiVfl4aZvCKtfrrj1MQuMs+6HEowmfqwukO/Ek970zQDYddOhDwIvFQ4o6Ci6R/MzBdXP8EQWf8YzLs72nQYJtWagGmpvtB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172691; c=relaxed/simple;
	bh=0qQPKvoofyZm5iriRHoYfKcREeJIoy8Ti8MzgNgf/5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw0q1ES9s6TN/5PCpOVqLOA2oR7I6Fjx1pFw0pNubwln0EBYyv4TCIz3QnAHb3i3WAlAbN2uo5f8cPuVCus4vanUlTzIUuGFpI0O2yXZ7eiYym8OBGLxOiUhEJYzKRVj5iNGx9D0+z2aymNSNI+mVQVmbZ2lw+6Xz7Ud5BXX1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LrR9B0CP; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LrR9B0CP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0qQPKvoofyZm5iriRHoYfKcREeJIoy8Ti8MzgNgf/5E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792172687; v=1; x=1792777487;
 b=LrR9B0CP8USmXlAOuXUJnkpBGZl9l6znBG2TwOAJLSrOQzKdLmnq7q5hz84lVYnrQ2zIORFl
 VY0cBQOvL1Oi8ksjy18RQerEqs9f9fo83jKjlSlAzf3Td34rBlnVjm3f/N6G6BV1joTEL/N25KN
 npDQdAsAfTaNswXClC3jeGxo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4913d8876a98336d;
	Fri, 16 Oct 2026 17:44:47 +0000
X-Mizu-Trace-ID: 4913d8876a98336d
X-Migadu-Flow: FLOW_OUT
Message-ID: <a99c19a5-c5ef-4bf5-91f7-8fae78858db9@linux.dev>
Date: Fri, 16 Oct 2026 10:44:43 -0700
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
 <b0bb3596-35a9-471b-a666-d7a638d00e5d@linux.dev>
 <DM6DTIR83Q2M.1GEPF95MFWXY5@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DM6DTIR83Q2M.1GEPF95MFWXY5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-16 8:53 a.m., Alexei Starovoitov wrote:
> On Thu, Oct 15, 2026 at 10:49 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> When PSO lands, people might run into this as soon as they use new
>> bpftool to generate vmlinux.h, and the failure is very loud.
> 
> fwiw calico does
>    if (bpf_core_field_exists(skb->gso_size)) {
> on __sk_buff in skb_is_gso().
> It includes linux/bpf.h and not vmlinux.h, so it's not affected,
> but the pattern is out there.
> 
>> Yeah, the __bpf_core_<foo> might not be the best name.
>> I like btf_relocatable for PAI, should this be btf_unrelocatable?..
> 
> A struct without any attribute is not relocatable either.
> iirc Eduard used __bpf_ctx earlier.
> It's more of 'hey compiler dont mess with field offset'.
> 'bpf_static_offset'? 'bpf_fixed_offset' ?

 From these bpf_static_offset makes most sense to me, because it matches
the compiler attribute name (preserve_static_offset).
