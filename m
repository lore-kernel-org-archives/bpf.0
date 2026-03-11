Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6C31DD97
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188442; cv=none; b=AyvWJ8X3odFqXz3lWINAKQ1iiv5bLrApbkFftxOnaBFMX3WlPKYZrwOBXIuQFkhgu2SznxVGfM02Dh5w88mEuHb9Ohv/ZAXax0CW9G7YcXoQZ79mP4l3+up+WGo7f6NNIAlytbKVUoGn7T7R9lcS99puVD8FkiitmUnvQtH0Sdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188442; c=relaxed/simple;
	bh=hLsDEu+zR8PucaLR8pmIos5H/Zo+JHw2jybYjyVWfUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbUgXLL6ukAxdqkyLCwS2F6mNvLE1bzmUFdu4oz5fcY7yFBIdhiDqRM971wPNivCdipFMhHAVyCV1uVTxWZhGcAeys+MBj7fhYLg2g1WcdptpYO43RZi7/E0Oif6SB7hUe5RmkPSresDeOPB6SBVafAmOGP0RCK/tdEkX+sFzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e8jAVJTE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e8jAVJTE"
Message-ID: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773188438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw1FokbwUhlf20zD8yP5NKPUpoGDVamLwdYCvzK8A84=;
	b=e8jAVJTETHw8g0MVlj5IF4O6gL6D9TYE/Y6adexCOozgwmlMeIXbWSDuyhs4QMsjCfVGK7
	gSD8FCsomyUHpc+to2yia/3lWhewU8GOxQ0V5+B/AmeqWBWdgblKgjVFaiiVbTt+FIiSzK
	Uml886jDAMoYDQBlmh1S5dG5WYkjUKU=
Date: Tue, 10 Mar 2026 17:20:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Amery Hung <ameryhung@gmail.com>
Cc: Gregory Bell <grbell@redhat.com>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <cover.1773170190.git.grbell@redhat.com>
 <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
 <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com>
 <CAMB2axPT8L60FGN5wben-pa73toOwLcD8cuGqbNUg6AB57ePYg@mail.gmail.com>
 <CAP01T76cPcToNwu_NMFU6QDO8qZB+n9WA0_qxSzrasZV-=G-Qw@mail.gmail.com>
 <CAMB2axMTkN5R3+JQL-2L0fWAqzOQOFOxp7+WKF4DLUF-FqgiPg@mail.gmail.com>
 <CAP01T75dDL5pud_NmCmEapw6p1cZss9LTfh6sBxdxYinVQTP5Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAP01T75dDL5pud_NmCmEapw6p1cZss9LTfh6sBxdxYinVQTP5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/10/26 4:35 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, 11 Mar 2026 at 00:17, Amery Hung <ameryhung@gmail.com> wrote:
>>
>> On Tue, Mar 10, 2026 at 3:48 PM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>>>
>>> On Tue, 10 Mar 2026 at 23:38, Amery Hung <ameryhung@gmail.com> wrote:
>>>>
>>>> On Tue, Mar 10, 2026 at 2:41 PM Kumar Kartikeya Dwivedi
>>>> <memxor@gmail.com> wrote:
>>>>>
>>>>> On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wrote:
>>>>>>
>>>>>> When running BPF struct_ops tests consecutively, the second test fails
>>>>>> because BTF object references take longer to be released while their
>>>>>> associated module is removed from btf_modules list immediately
>>>>>> during module unload. This creates a race condition where the second
>>>>>> test retrieves the cached BTF object but cannot find valid module
>>>>>> information, causing btf_try_get_module() to return NULL.
>>>>>>
>>>>>> Fix this by modifying MODULE_STATE_GOING handling to wait for
>>>>>> active BTF references to be released before completing module
>>>>>> cleanup. This ensures BTF objects are properly cleaned up from the
>>>>>> cache before their module metadata is removed, eliminating the timing
>>>>>> window that caused the race condition.
>>>>>>
>>>>>> Signed-off-by: Gregory Bell <grbell@redhat.com>
>>>>>> ---
>>>>>>   kernel/bpf/btf.c | 7 ++++++-
>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>>>> index 09fcbb125155..81c9f46a7bb7 100644
>>>>>> --- a/kernel/bpf/btf.c
>>>>>> +++ b/kernel/bpf/btf.c
>>>>>> @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>>>>>>                  list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>>>>>>                          if (btf_mod->module != module)
>>>>>>                                  continue;
>>>>>> -
>>>>>> +                       unsigned int timeout = 1000;
>>>>>> +                       while (refcount_read(&btf_mod->btf->refcnt) > 1
>>>>>> +                       && timeout > 0 ) {
>>>>>> +                               msleep(1);
>>>>>> +                               timeout--;
>>>>>> +                       }
>>>>>
>>>>> This isn't the right way to address such issues. Your diagnosis is
>>>>> correct but fix is just papering over real problems.
>>>>
>>>> Second that the fix is not right.

pw-bot: cr

>>>>
>>>>>
>>>>> The better way would be to block the discovery of such BTFs once the
>>>>> module is unloaded.
>>>>> I.e. once we return to userspace after module unload, subsequent calls
>>>>> to obtain an fd for such BTFs should not succeed.
>>>>> If someone is racing to look it up while the unload happens, so be it,
>>>>> they will fail anyway.
>>>>>
>>>>> I would use a bool flag in struct btf, set it inside the critical
>>>>> section at this point with WRITE_ONCE, then test it early in
>>>>> bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
>>>>> condition.
>>>>> Using READ_ONCE of course.
>>>>> Also, we need to add it to btf_get_fd_by_id, so that once conversions
>>>>> from stale IDs to FDs don't succeed.
>>>>> Looking at load_module_btfs(), it already handles the ENOENT case when
>>>>> id lookup succeeds, but fd lookup fails.
>>>>> So for stale ids it should just skip over their errors if we return
>>>>> the same ENOENT as the refcount_inc_not_zero case.
>>>>> We will still report stale ids, but not allow their conversion.
>>>>> We could filter id lookup too but it will penalize the common code and
>>>>> we need extra radix tree lookup just for BTF case.
>>>>>
>>>>> For me locally, these changes seem to address the problem. I could
>>>>> send the fix, but if you would like to take a stab at the above
>>>>> change, please go ahead.
>>>>>
>>>>
>>>> I guess this is worth a fix because it makes btf_get_fd_by_id() less
>>>> likely to return to stale id. However, there is still a small window
>>>> between btf_get_fd_by_id() and btf_try_get_module() so struct_ops map
>>>> creation can still fail.
>>>
>>> That's fine, it means that module unload is happening in parallel, so
>>> it's racy and non-deterministic anyway.
>>> When the user controls the module unload though, they should not be
>>> getting stale BTF fds once module unload has returned to user space.
>>> At that point all associated artifacts shouldn't be discoverable.
>>>
>>>>
>>>> As for the solution, there already is btf_mod->flags. So maybe instead
>>>> of adding a bool, just test the flag?
>>>
>>> You mean struct btf instead of btf_mod? I don't see the flags field there.
>>> The btf_mod->flags won't work, it's already deleted and freed by this
>>> time, and requires us to go first from the BTF to the btf_mod.
>>> So it has to be in struct btf.
>>>
>>
>> I was thinking about updating btf_module->flags when handling
>> MODULE_STATE_GOING. Then btf_get_fd_by_id() can call
>> btf_try_get_module() to check flags if it's module BTF. If the module
>> is already freed then it returns -ENOENT.
> 
> Hmm, interesting thought.
> I guess the only downside is that it's O(n) lookup under mutex, which
> can be costly with lots of modules, and always penalizes
> get_fd_by_id() for handling race.
> We also need to repeat it in bpf_core_find_cands and bpf_find_btf_id,
> where we may repeat it multiple times in the loop, so the cost is
> amplified.
> 

Is btf->id still needed somewhere after MODULE_STATE_GOING? Otherwise, 
directly removing btf->id from btf_idr in btf_module_notify() should 
stop the discovery.
