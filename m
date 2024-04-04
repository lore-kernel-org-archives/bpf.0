Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC808C06
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712200730; cv=none; b=S5x8o09zf9AFTaHccKduthh7gw6WzKSSsZkfujms7ZhdZo/wwew02y4mnzcL3sfeJFCVJvuu6WKgIiAL7r5LHgAKp19YtHFxUtaCSsbB0DpOo91F6DavGs3hI9+oQlbcCjcCbSHXhi3usP7Nya2ejVFaFVuCTL/iaQ3n5cFQ1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712200730; c=relaxed/simple;
	bh=CuyIMFph6j0WiPlzUG2ZLcYMey1QAAV+fGxFkJX9bxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpSusMDKU4sBEnUUm/BEGhmuRckeWTiEEXWuT9fvP9p3KAUebPnQQKOP3skMmxAGAz+leAhNVzbrJ0CfRWGhiwXvlh3bOHPiBO9oiqpsLJ+TGqsuJf2GCmn5YTqxu03Bm4PEzKLXbYnSQUzP66obRAr0C3mgOUQe5BddWKnbWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5PofZCf; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X5PofZCf"
Message-ID: <55359f46-087e-4685-944b-80fe6d61eb87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712200726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C48d62kUfKMGhF5y4m05nIy/5ZjEIQbLTX/TXn77j90=;
	b=X5PofZCfwcbLLYMnCVTIBnuo1QQoASa+JpUI88xSwQunfgYIyquXegbgYJSwprePMW+22r
	T8D7qtMRzhtlzxWxSYc1LXEG85OSGuPmNTwfXgDrDEVskB9Abxfu0IC7NguifA8/ADdQcH
	b6WyY4qBlyPADw8FCNoqr2FEV2fXXjE=
Date: Wed, 3 Apr 2024 20:18:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
 <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
 <660d964a1444b_1cf6b20885@john.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <660d964a1444b_1cf6b20885@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/3/24 10:47 AM, John Fastabend wrote:
> Andrii Nakryiko wrote:
>> On Tue, Apr 2, 2024 at 6:08 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>
>>> On 4/2/24 10:45 AM, Andrii Nakryiko wrote:
>>>> On Mon, Mar 25, 2024 at 7:22 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>> Add bpf_link support for sk_msg and sk_skb programs. We have an
>>>>> internal request to support bpf_link for sk_msg programs so user
>>>>> space can have a uniform handling with bpf_link based libbpf
>>>>> APIs. Using bpf_link based libbpf API also has a benefit which
>>>>> makes system robust by decoupling prog life cycle and
>>>>> attachment life cycle.
>>>>>
> Thanks again for working on it.
>
>>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>>> ---
>>>>>    include/linux/bpf.h            |   6 +
>>>>>    include/linux/skmsg.h          |   4 +
>>>>>    include/uapi/linux/bpf.h       |   5 +
>>>>>    kernel/bpf/syscall.c           |   4 +
>>>>>    net/core/sock_map.c            | 263 ++++++++++++++++++++++++++++++++-
>>>>>    tools/include/uapi/linux/bpf.h |   5 +
>>>>>    6 files changed, 279 insertions(+), 8 deletions(-)
>>>>>
>> [...]
>>
>>>>>           psock_set_prog(pprog, prog);
>>>>> -       return 0;
>>>>> +       if (link)
>>>>> +               *plink = link;
>>>>> +
>>>>> +out:
>>>>> +       mutex_unlock(&sockmap_prog_update_mutex);
>>>> why this mutex is not per-sockmap?
>>> My thinking is the system probably won't have lots of sockmaps and
>>> sockmap attach/detach/update_prog should not be that frequent. But
>>> I could be wrong.
>>>
> For my use case at least we have a map per protocol we want to inspect.
> So its rather small set <10 I would say. Also they are created once
> when the agent starts and when config changes from operator (user decides
> to remove/add a parser). Config changing is rather rare. I don't think
> this would be paticularly painful in practice now to have a global
> lock.
>
>> That seems like an even more of an argument to keep mutex per sockmap.
>> It won't add a lot of memory, but it is conceptually cleaner, as each
>> sockmap instance (and corresponding links) are completely independent,
>> even from a locking perspective.
>>
>> But I can't say I feel very strongly about this.
>>
>>>>> +       return ret;
>>>>>    }
>>>>>
>> [...]
>>
>>>>> +
>>>>> +static void sock_map_link_release(struct bpf_link *link)
>>>>> +{
>>>>> +       struct sockmap_link *sockmap_link = get_sockmap_link(link);
>>>>> +
>>>>> +       mutex_lock(&sockmap_link_mutex);
>>>> similar to the above, why is this mutex not sockmap-specific? And I'd
>>>> just combine sockmap_link_mutex and sockmap_prog_update_mutex in this
>>>> case to keep it simple.
>>> This is to protect sockmap_link->map. They could share the same lock.
>>> Let me double check...
>> If you keep that global sockmap_prog_update_mutex then I'd probably
>> reuse that one here for simplicity (and named it a bit more
>> generically, "sockmap_mutex" or something like that, just like we have
>> global "cgroup_mutex").
> I was leaning to a per map lock, but because a global lock simplifies this
> part a bunch I would agree just use a single sockmap_mutex throughout.
>
> If someone has a use case where they want to add/remove maps dynamically
> maybe they can let us know what that is. For us, on my todo list, I want
> to just remove the map notion and bind progs to socks directly. The
> original map idea was for a L7 load balancer, but other than quick hacks
> I've never built such a thing nor ran it in production. Maybe someday
> I'll find the time.

I am using a single global lock.
   https://lore.kernel.org/bpf/20240404025305.2210999-1-yonghong.song@linux.dev/
Let us whether it makes sense or not with code.

John, it would be great if you can review the patch set. I am afraid
that I could miss something...

>
>> [...]
>>
>>>>> +       if (old && link->prog != old) {
>>>> hm.. even if old matches link->prog, we should unset old and set new
>>>> link (link overrides prog attachment, basically), it shouldn't matter
>>>> if old == link->prog, unless I'm missing something?
>>>
[...]
