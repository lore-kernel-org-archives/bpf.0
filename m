Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A77FBDB
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143250; cv=none; b=Aaw5nCgQBUdjGOqzGn7RqHZgOQGdxeZdqEpCJq4Lsk24DjBjcW5s7YLwKXYfHpexQ4qswERXC8U7wqd6mBRj+bvBr0KkEon6xKNVSa+aRnHDCxnC4PJI0UXegvQTIDEPgmOTeeyH7HXTJ9uQkfl4+lNawb7H6R4xoRG5BG5ubK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143250; c=relaxed/simple;
	bh=VZog1M/bRVc9/OHhQazIssijoFD/emHmAQb7koIRP74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDdNZZw8GL+k+2sbEYIJj2fTb3gfvV9tjKhgOcwACQvMh4R6Nf8RfwcBFCBbNk+fadT7Bw0eHFHv99gRVe5Gi1OOYfRSP7HPnwX+9TYLjTjiEfKauvAcYWMTvFJuMqfB8lXyo4pxZX8A9esxOzr+wtj4heDxaWkODw99Dms/fjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQyoI26l; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQyoI26l"
Message-ID: <b89a5d59-b4bb-4ffa-b366-3b8a9fadf10c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711143244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icONPZ5oDx03RQSNsvlwjK6qJHrYr8j7OmEaRnBqnMQ=;
	b=qQyoI26l+6+tFOcV9lwPNFJnbe3gGT1GMqdGzXOKBBT+lzyh/tblsQSi1486nUtQJ5rAVJ
	RNh7iaeh+bMhw2MQIltJenP26c6+fBbTOmThvUZy6ymsJlGLQBZtI0vRC2nEzijrMqYp8B
	K/oVKs0WIfFojNBipzzww5M9e5Bz4jk=
Date: Fri, 22 Mar 2024 14:33:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240319175401.2940148-1-yonghong.song@linux.dev>
 <20240319175406.2940628-1-yonghong.song@linux.dev>
 <CAEf4BzZxD3xQ_3x_576OuvM2pueki=h19b1eyX5i1cqZtWNA4g@mail.gmail.com>
 <7d6eba04-d70d-4467-9c65-065774b29012@linux.dev>
 <CAEf4BzbEAKFiuxrMj2qRgQvyUQBeOWLMOqgibO7s9s9Bc3FVqw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbEAKFiuxrMj2qRgQvyUQBeOWLMOqgibO7s9s9Bc3FVqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 1:16 PM, Andrii Nakryiko wrote:
> On Fri, Mar 22, 2024 at 12:18 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 3/22/24 11:45 AM, Andrii Nakryiko wrote:
>>> On Tue, Mar 19, 2024 at 10:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> Add bpf_link support for sk_msg and sk_skb programs. We have an
>>>> internal request to support bpf_link for sk_msg programs so user
>>>> space can have a uniform handling with bpf_link based libbpf
>>>> APIs. Using bpf_link based libbpf API also has a benefit which
>>>> makes system robust by decoupling prog life cycle and
>>>> attachment life cycle.
>>>>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    include/linux/bpf.h            |  13 +++
>>>>    include/uapi/linux/bpf.h       |  10 ++
>>>>    kernel/bpf/syscall.c           |   4 +
>>>>    net/core/skmsg.c               | 164 +++++++++++++++++++++++++++++++++
>>>>    net/core/sock_map.c            |   6 +-
>>>>    tools/include/uapi/linux/bpf.h |  10 ++
>>>>    6 files changed, 203 insertions(+), 4 deletions(-)
>>>>
>>> [...]
>>>
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 3c42b9f1bada..c5506cfca4f8 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -1135,6 +1135,8 @@ enum bpf_link_type {
>>>>           BPF_LINK_TYPE_TCX = 11,
>>>>           BPF_LINK_TYPE_UPROBE_MULTI = 12,
>>>>           BPF_LINK_TYPE_NETKIT = 13,
>>>> +       BPF_LINK_TYPE_SK_MSG = 14,
>>>> +       BPF_LINK_TYPE_SK_SKB = 15,
>>> they are both "sockmap attachments", so maybe we should just have
>>> something like BPF_LINK_TYPE_SOCKMAP ?
>> Yes, we could do this. Basically it represents all programs
>> which can be attached to sockmap.
>>
>>>>           __MAX_BPF_LINK_TYPE,
>>>>    };
>>>>
>>>> @@ -6718,6 +6720,14 @@ struct bpf_link_info {
>>>>                           __u32 ifindex;
>>>>                           __u32 attach_type;
>>>>                   } netkit;
>>>> +               struct {
>>>> +                       __u32 map_id;
>>>> +                       __u32 attach_type;
>>>> +               } skmsg;
>>>> +               struct {
>>>> +                       __u32 map_id;
>>>> +                       __u32 attach_type;
>>>> +               } skskb;
>>> and then this would be also just one struct, instead of two identical
>>> ones duplicated
>> Right, we could do one with name 'sockmap'.
>>
>>>>           };
>>>>    } __attribute__((aligned(8)));
>>>>
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index ae2ff73bde7e..3d13eec5a30d 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>>>>           case BPF_PROG_TYPE_SK_LOOKUP:
>>>>                   ret = netns_bpf_link_create(attr, prog);
>>>>                   break;
>>>> +       case BPF_PROG_TYPE_SK_MSG:
>>>> +       case BPF_PROG_TYPE_SK_SKB:
>>>> +               ret = bpf_sk_msg_skb_link_create(attr, prog);
>>>> +               break;
>>>>    #ifdef CONFIG_NET
>>>>           case BPF_PROG_TYPE_XDP:
>>>>                   ret = bpf_xdp_link_attach(attr, prog);
>>>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>>>> index 4d75ef9d24bf..1aa900ad54d7 100644
>>>> --- a/net/core/skmsg.c
>>>> +++ b/net/core/skmsg.c
>>>> @@ -1256,3 +1256,167 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
>>>>           sk->sk_data_ready = psock->saved_data_ready;
>>>>           psock->saved_data_ready = NULL;
>>>>    }
>>>> +
>>>> +struct bpf_sk_msg_skb_link {
>>>> +       struct bpf_link link;
>>>> +       struct bpf_map *map;
>>>> +       enum bpf_attach_type attach_type;
>>>> +};
>>>> +
>>>> +static DEFINE_MUTEX(link_mutex);
>>> maybe more specific name, sockmap_link_mutex? link_mutex sounds very generic
>> Good idea.
>>
>>>> +
>>>> +static struct bpf_sk_msg_skb_link *bpf_sk_msg_skb_link(const struct bpf_link *link)
>>>> +{
>>>> +       return container_of(link, struct bpf_sk_msg_skb_link, link);
>>>> +}
>>>> +
>>> [...]
>>>
>>>> +       attach_type = attr->link_create.attach_type;
>>>> +       bpf_link_init(&sk_link->link, link_type, &bpf_sk_msg_skb_link_ops, prog);
>>>> +       sk_link->map = map;
>>>> +       sk_link->attach_type = attach_type;
>>>> +
>>>> +       ret = bpf_link_prime(&sk_link->link, &link_primer);
>>>> +       if (ret) {
>>>> +               kfree(sk_link);
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       ret = sock_map_prog_update(map, prog, NULL, attach_type);
>>> Does anything prevent someone else do to remove this program from
>>> user-space, bypassing the link? It's a guarantee of a link that
>>> attachment won't be tampered with (except for SYS_ADMIN-only
>>> force-detachment, which is a completely separate thing).
>>>
>>> It feels like there should be some sort of protection for programs
>>> attached through sockmap link here. Just like we have this for XDP,
>>> for example, or any of cgroup BPF programs attached through BPF link.
>> Good point. I have a 'bpf_prog_inc(prog)' below, I could do a refcount increase
>> before sock_map_prog_update(), we then should be okay.
>>
> My point was that once you attach a program to sockmap with
> LINK_CREATE, someone else just doing bpf_prog_attac() shouldn't
> replace this program anymore. BPF link preserves *attachment
> lifetime*, not just the program lifetime.

I see. I briefly looked at xdp and cgroup where both support
link-based attachment and program base attachment.
For xdp, indeed if link attachment is already done,
prog attach is not allowed.
cgroup seems more complicated and need further study to
confirm whether BPF link preserves attachment in all
cases or not.
But any way, since bpf_link is a new feature for
sockmap. It makes sense to follow the xdp-link
style to disallow bpf_prog_attach once link is
created.

>
>>>> +       if (ret) {
>>>> +               bpf_link_cleanup(&link_primer);
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       bpf_prog_inc(prog);
>>>> +
>>>> +       return bpf_link_settle(&link_primer);
>>>> +
>>>> +out:
>>>> +       bpf_map_put_with_uref(map);
>>>> +       return ret;
>>>> +}
>>> [...]
