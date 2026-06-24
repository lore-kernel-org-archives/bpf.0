Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C13BB4A
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264758; cv=none; b=qIM0Y9AiboWwYHL3FDlzEhePHiJ3t3wsh8IUbpxrgfLXpbKyvgz6dTvfsqk5mijYEi/aukTC3mubrH7QwBhnktFRTnG7ZL6r73Q4lPBB5Qz7fUGdUPWEdRnLb9s7sGqka+goSfhckA4SCNR+0F6QYSgCpPHZpMK8Wigj+Pu4jR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264758; c=relaxed/simple;
	bh=RJsGpGQRVwr+JtNwlB8ZsFkHFjOC72SBkJgXJW5OVMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXBUC+9oHYR1dJxg1FehSMklrymD5PlmfB/mYvkHkWvhLyyHWn6fzmMdt0cnBNuXbyb9VAjdxt0AawkWzEv0QetQ4nyBovufyweDFRHomr7rbYN3H4n4leMUf94kgP6KoiZXVZCXsqmtSRXT1spZiB+xSEejbk5jRL6m/roKi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iOQ1dmnr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iOQ1dmnr"
Message-ID: <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782264754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzBFoRi1EjW63O+lDY8B7JDNKdt4cYcrugVV0eKFoqw=;
	b=iOQ1dmnrNcKk5R+/Bwqb99gm9pehbaVHV0XivtkX0NsExbboFt6U8FnQQNlT0iuuCqE9kS
	ZDfE1IbSw7TFIQkMBJHHqCYKUpW3K+gyPWMMEUHDWA3/Q92HgofX6WF0MjCu8bAPGal2pg
	ROKpprz62nAV+pj97AGs2NUHTRnRmC4=
Date: Wed, 24 Jun 2026 09:32:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Amery Hung <ameryhung@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 kernel-team <kernel-team@cloudflare.com>
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com>
 <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
 <87mrwlyqg4.fsf@cloudflare.com>
 <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
 <878q85yoy5.fsf@cloudflare.com>
 <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/24/26 5:26 AM, Alexei Starovoitov wrote:
> On Tue, Jun 23, 2026 at 1:36 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Tue, Jun 23, 2026 at 01:22 PM -07, Amery Hung wrote:
>>> On Tue, Jun 23, 2026 at 1:04 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>>> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
>>>>> On Tue, Jun 23, 2026 at 12:31 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>>>> On Tue, Jun 23, 2026 at 12:21 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>>>>>> On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
>>>>>>>> On Tue, Jun 23, 2026 at 4:20 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>>>>>>>> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
>>>>>>>>> completed all code paths related to sockmap-based redirects should be
>>>>>>>>> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
>>>>>>>>> disabling NET_SOCK_MSG. The implementation of sockmap as a container for
>>>>>>>>> socket references would remain under BPF_SYSCALL.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>>>>>>>>> ---
>>>>>>>>> Changes in v2:
>>>>>>>>> - Handle prot->recvmsg being NULL (Sashiko)
>>>>>>>>> - Elaborate on the end goal in description
>>>>>>>>> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com
>>>>>>>>> ---
>>>>>>>>>   net/unix/af_unix.c  | 4 ++--
>>>>>>>>>   net/unix/unix_bpf.c | 6 ++++++
>>>>>>>>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>>>>>>>> index f7a9d55eee8a..84c11c60c75f 100644
>>>>>>>>> --- a/net/unix/af_unix.c
>>>>>>>>> +++ b/net/unix/af_unix.c
>>>>>>>>> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg, size_t si
>>>>>>>>>   #ifdef CONFIG_BPF_SYSCALL
>>>>>>>>>          const struct proto *prot = READ_ONCE(sk->sk_prot);
>>>>>>>>>
>>>>>>>>> -       if (prot != &unix_dgram_proto)
>>>>>>>>> +       if (prot->recvmsg)
>>>>>>>> There is no reason to have this dead branch when
>>>>>>>> CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
>>>>>>>>
>>>>>>>> Let's compile out all sockmap code when both configs
>>>>>>>> are not enabled.
>>>>>>>>
>>>>>>>> Since AF_UNIX differs from TCP/UDP, it can take the
>>>>>>>> simpler approach.
>>>>>>> Okay, will put the whole file behind hidden config option like so:
>>>>>>>
>>>>>>> --- a/net/unix/Kconfig
>>>>>>> +++ b/net/unix/Kconfig
>>>>>>> @@ -30,3 +30,8 @@ config UNIX_DIAG
>>>>>>>          help
>>>>>>>            Support for UNIX socket monitoring interface used by the ss tool.
>>>>>>>            If unsure, say Y.
>>>>>>> +
>>>>>>> +config UNIX_BPF
>>>>>> Maybe UNIX_BPF_SOCKMAP or something.
>>>>>> bpf_iter is supported without this config.
>>>>> I don't like where it's going.
>>>>> I strongly dislike new config knobs.
>>>>> I'd rather remove existing knobs.
>>>>> What is the motivation?
>>>> The goal is to compile out sockmap bits that use sk_msg.
>>>> NET_SOCK_MSG is natural, exisiting candidate.
>>>> New knob wasn't my idea.
>>> I'm also missing the big picture here.
>>>
>>> sockmap already holds socket references today. You can store and look
>>> up sockets without attaching any verdict/parser program, and no
>>> redirect happens. So if the goal is to use sockmap purely as a socket
>>> container without the sk_msg fast-path overhead, what does a
>>> compile-time NET_SOCK_MSG knob add over the runtime checks?
>> Sure, let me clarify. It's about the maintenance overhead.
>>
>> sockmap-based redirects are a rather niche feature with few users, for
>> which we've been getting quite a few bug reports since AI came along.
>>
>> We're not using it internally at Cloudflare, so I don't really have a
>> good reason to justify time spent on these bug reports.
>>
>> Hence the move to put sockmap-based redirect behind a config option,
>> which you can enable at your own risk. Or which we can deprecate, but
>> that's not really my call.


Hi Alexei and Jakub,

skmsg is actually still pretty useful for gateways.
I started with bpf by integrating skmsg into nginx as a module and envoy 
has something similar.
The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for 
L7, redirecting
between local apps by looking at the payload. So there are real users.


> This is wishful thinking that a config knob will stop
> the bug reports.
> Just disable it for real instead.


About the AI bug reports - yeah, I've seen them too. I think it just 
comes from the complexity
of networking plus how programmable bpf is. Reviewing AI-written patches 
is often painful,
the commit message is frequently wrong, once it took me a whole day just 
to reproduce and
confirm the issue. But I do believe these reports will converge eventually.


>>> I am also not sure if NET_SOCK_MSG is right. It is broader than
>>> "sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
>>> Because those select it, it can't be toggled independently.
>> Once the sockmap redirect bits are behind _some_ config option, it will
>> be easy to replace it with a more granular one that depends on
>> NET_SOCK_MSG. But we're not there yet. One step at a time.
> No. That's not workable.
>
>>> Could you share the concrete use case you have in mind, and whether
>>> this came out of an earlier discussion or thread upstream?
>> This is a follow up from discussions at BPF summit with Alexei & John.
> Not quite. The discussion was to disable pieces of sockmap
> that are causing trouble.
> Not to move them under config knobs, but disable them.

Agree, just like we remove skmsg from KTLS which is rarely used.


I think the motivation of this patch - making the boundary between skmsg 
and sockmap clear - is worthwhile.

Hope not have skmsg disabled by default.
I don't work on that upper-layer software anymore, but I really don't 
want my ex-colleagues to
upgrade their kernel some day, find the feature I wrote broken, and come 
curse me :) (selfish)

