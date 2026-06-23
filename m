Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F83175A79
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173800; cv=none; b=iydhwBGiGCd4MLfhd2QfE91u1GVdcXCto8ob27QM07U434Puz8SxDmH9ZX0oKF2/WysqIUj/tclsRLxBuxtHn4ksjI6rBYy2yLj8AKI/Kp2Zwyt8mwQQm0S0f0jjwFMZxcgo4RrGiK6MGxb6jYmTO0GKUqRb48um/OQ61b0FDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173800; c=relaxed/simple;
	bh=A9k/De2Tfc5Y4psiflVWQIwhMTnFgBl0DSkO1O8fypQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDXyyqQ2RkaPDOb1/64LaPa9jkATvDTVNHpmqgsgMqcyyU6S+Dg5YIN10XAK+ywwijNDZx03txM2lb0lu86mWuXqWhgzXbQf9O+flcTbvXuGL3NEe6oJeu5Sa2vOK+VVgkEw+o9TWmQAeJ2IyZqVxydmQY7zL3htzIbilhcWHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ica8PoBm; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ica8PoBm"
Message-ID: <407fc549-1363-4b22-b6aa-b85283873433@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782173795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQ/tN8LPB9pbsNYKwXHKXdDuCRbHVz4A0BWR4CadjWs=;
	b=ica8PoBmlvFDqhLY70+zIqEUwaYq/9kKUcVfUDNxWB09L92DemTjVMJ0rHXgj829Y1NjsO
	5cFVokuTTuxBahVAoa3o7pjhmaPnT4HnqwxUWLOJbF0GDL2fX9WdUJVmdSaKHasrgzxUOV
	aUuEWZr3c8n4kTnCJFV10GC6YIPUNYU=
Date: Mon, 22 Jun 2026 17:16:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/bpf_memcontrol: mark BPF memcg kfuncs static
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260617202147.78347-1-jp.kobryn@linux.dev>
 <CAADnVQJ=q7hJkt=ekLD_a5KjJ_+icdwgsY61rujjLMKAKByvWw@mail.gmail.com>
 <7ia4cxxosss5.fsf@castle.c.googlers.com>
 <DJDK2NVO8903.19LWKQ3ST3U89@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: JP Kobryn <jp.kobryn@linux.dev>
In-Reply-To: <DJDK2NVO8903.19LWKQ3ST3U89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/19/26 8:27 PM, Alexei Starovoitov wrote:
> On Wed Jun 17, 2026 at 3:31 PM PDT, Roman Gushchin wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>>> On Wed, Jun 17, 2026 at 1:22 PM JP Kobryn <jp.kobryn@linux.dev> wrote:
>>>>
>>>> The kfuncs in bpf_memcontrol.c are not called by in-kernel C code. They are
>>>> only referenced by BPF programs and resolved through BTF.
>>>>
>>>> Since no external linkage is needed, mark these functions static.
>>>>
>>>> Fixes: 5904db9891f8 ("mm: introduce BPF kfuncs to deal with memcg pointers")
>>>> Fixes: 5c7db3239c9f ("mm: introduce bpf_get_root_mem_cgroup() BPF kfunc")
>>>> Fixes: 99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistics and events")
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202606150332.Xy4Egd9s-lkp@intel.com/
>>>> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
>>>> ---
>>>>  mm/bpf_memcontrol.c | 21 +++++++++++----------
>>>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>>>> index 716df49d7647..eff79bb2c758 100644
>>>> --- a/mm/bpf_memcontrol.c
>>>> +++ b/mm/bpf_memcontrol.c
>>>> @@ -20,7 +20,7 @@ __bpf_kfunc_start_defs();
>>>>   *
>>>>   * Return: A pointer to the root memory cgroup.
>>>>   */
>>>> -__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>>>> +__bpf_kfunc static struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>>>
>>> sashiko disappoints. It couldn't notice that kfuncs should not be static.
>>> We have few "__bpf_kfunc static" in net/ipv4/
>>> that work by sort-of "luck", since their addresses are taken.
>>>
>>> In general kfuncs cannot be declared static.
>>
>> It seems like it thought hard on it but failed based on the existing
>> code and a bit vague documentation in Documentation/bpf/kfuncs.rst:
>>
>>   kfunc definitions should also always be annotated with the ``__bpf_kfunc``
>>   macro. This prevents issues such as the compiler inlining the kfunc if it's a
>>   static kernel function, or the function ...
>>
>> So it reads like bpf kfuncs can be static.
>>
>> This is the reasoning from the logs (a dismissed concern, to be precise):
>> {
>>       "type": "Dead Code / Linker Error",
>>
>>       "description": "Marking kfuncs as static could cause the compiler
>>       to optimize them away, breaking BPF verifier BTF resolution.",
>>
>>       "reasoning": "The patch adds `static` to multiple `__bpf_kfunc`
>>       annotated functions that are not called anywhere in C
>>       code. Normally, a compiler would remove unused static functions or
>>       fail to expose them in object files, which could prevent the BTF
>>       ID generation logic (`resolve_btfids`) from finding them. However,
>>       the `__bpf_kfunc` macro expands to include `__used` and
>>       `__retain`, which strictly instructs the compiler and linker to
>>       preserve the functions in the object file regardless of
>>       usage. Additionally, `resolve_btfids` and `BTF_ID_FLAGS`
>>       successfully parse and resolve `STB_LOCAL` static symbols, making
>>       this change completely safe and correct.",
> 
> Almost, except it's not clear what takes priority for the compiler.
> __bpf_kfunc used to have '__used' and it was enough until clang
> got too aggressive in LTO mode. So we added '__retain' and so far
> it seems to be holding, but sashiko is missing that both of these
> attributes don't say anything about _name_ of the function.
> 'static' keyword means that compiler is free to rename it and
> compilers do take advantage of that from time to time,
> while __used and __retain don't add 'do-not-rename' restriction
> to the compiler.
> 
> Also look at it from the other angle.. why anyone would add
> 'static' when the function is clearly not static to this particular
> compilation unit. It will be used outside of it by bpf progs
> that are obviuosly not part of this .c file.
> 
> Documentation/bpf/kfuncs.rst needs to be updated.
> 
> JP,
> pls send a patch to update the docs and include few words
> to ignore sparse.
> 

Sounds good. I'll get that out this week.
