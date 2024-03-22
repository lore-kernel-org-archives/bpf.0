Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810078693
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135085; cv=none; b=YYtik7fnPZK9jJeCSKSBpqdpVerxbKW6zWliy3FcoXnEX6ktKRYO/zu847sde3WkrBTNy9coT4gaDbzBXjlnYJ2pT+K9yHDbtonPc1uvCF6ZzHYnVgvQVsSTisUBUO2ZgiiYxkS8yCv3JsF7hAwsO8ppwcvWP6+GVVJbUueG0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135085; c=relaxed/simple;
	bh=En/ZeBFL4ahU+rctEP6VVD6dPTcKPma3GNYKgXXdwTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQP2lAu0al8RaKKCCe7CLmS2R7/wx36ox/MnQfEXJ4IqpajAy6oWUzu224PXppgjEmuWfN/5jx4bs0vPntWCNHfDJrwjkPBjHQGexxkTsyKnDA8AFZC1F5v0SYl1DVpYDQrTkDMc0dnqvAaXkh6Muj/ACfffS4BxeTQYeXjTiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EleZzSvz; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EleZzSvz"
Message-ID: <7d6eba04-d70d-4467-9c65-065774b29012@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711135081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOc0l9wx+KtdXo/SEUKer9k7YhVovGFlU71Rdn3HzXU=;
	b=EleZzSvz2QaarXKhcHk7MZlG7GiM6bS486EMGWNrhVh7YtXHBqss2p3Edw68933SCyGwj6
	M/oH8iYrfvDun6MA6KVH9RIJdC8qQPnIbd6/xwZxFyIuYo5P2Y35CVfSVMgzeb7zQPbAQH
	u9ZjX1J/kPFb7jZwRzV8PxR7uaGq1sM=
Date: Fri, 22 Mar 2024 12:17:52 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZxD3xQ_3x_576OuvM2pueki=h19b1eyX5i1cqZtWNA4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 11:45 AM, Andrii Nakryiko wrote:
> On Tue, Mar 19, 2024 at 10:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add bpf_link support for sk_msg and sk_skb programs. We have an
>> internal request to support bpf_link for sk_msg programs so user
>> space can have a uniform handling with bpf_link based libbpf
>> APIs. Using bpf_link based libbpf API also has a benefit which
>> makes system robust by decoupling prog life cycle and
>> attachment life cycle.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h            |  13 +++
>>   include/uapi/linux/bpf.h       |  10 ++
>>   kernel/bpf/syscall.c           |   4 +
>>   net/core/skmsg.c               | 164 +++++++++++++++++++++++++++++++++
>>   net/core/sock_map.c            |   6 +-
>>   tools/include/uapi/linux/bpf.h |  10 ++
>>   6 files changed, 203 insertions(+), 4 deletions(-)
>>
> [...]
>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 3c42b9f1bada..c5506cfca4f8 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1135,6 +1135,8 @@ enum bpf_link_type {
>>          BPF_LINK_TYPE_TCX = 11,
>>          BPF_LINK_TYPE_UPROBE_MULTI = 12,
>>          BPF_LINK_TYPE_NETKIT = 13,
>> +       BPF_LINK_TYPE_SK_MSG = 14,
>> +       BPF_LINK_TYPE_SK_SKB = 15,
> they are both "sockmap attachments", so maybe we should just have
> something like BPF_LINK_TYPE_SOCKMAP ?

Yes, we could do this. Basically it represents all programs
which can be attached to sockmap.

>
>>          __MAX_BPF_LINK_TYPE,
>>   };
>>
>> @@ -6718,6 +6720,14 @@ struct bpf_link_info {
>>                          __u32 ifindex;
>>                          __u32 attach_type;
>>                  } netkit;
>> +               struct {
>> +                       __u32 map_id;
>> +                       __u32 attach_type;
>> +               } skmsg;
>> +               struct {
>> +                       __u32 map_id;
>> +                       __u32 attach_type;
>> +               } skskb;
> and then this would be also just one struct, instead of two identical
> ones duplicated

Right, we could do one with name 'sockmap'.

>
>>          };
>>   } __attribute__((aligned(8)));
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index ae2ff73bde7e..3d13eec5a30d 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>>          case BPF_PROG_TYPE_SK_LOOKUP:
>>                  ret = netns_bpf_link_create(attr, prog);
>>                  break;
>> +       case BPF_PROG_TYPE_SK_MSG:
>> +       case BPF_PROG_TYPE_SK_SKB:
>> +               ret = bpf_sk_msg_skb_link_create(attr, prog);
>> +               break;
>>   #ifdef CONFIG_NET
>>          case BPF_PROG_TYPE_XDP:
>>                  ret = bpf_xdp_link_attach(attr, prog);
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index 4d75ef9d24bf..1aa900ad54d7 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -1256,3 +1256,167 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
>>          sk->sk_data_ready = psock->saved_data_ready;
>>          psock->saved_data_ready = NULL;
>>   }
>> +
>> +struct bpf_sk_msg_skb_link {
>> +       struct bpf_link link;
>> +       struct bpf_map *map;
>> +       enum bpf_attach_type attach_type;
>> +};
>> +
>> +static DEFINE_MUTEX(link_mutex);
> maybe more specific name, sockmap_link_mutex? link_mutex sounds very generic

Good idea.

>
>> +
>> +static struct bpf_sk_msg_skb_link *bpf_sk_msg_skb_link(const struct bpf_link *link)
>> +{
>> +       return container_of(link, struct bpf_sk_msg_skb_link, link);
>> +}
>> +
> [...]
>
>> +       attach_type = attr->link_create.attach_type;
>> +       bpf_link_init(&sk_link->link, link_type, &bpf_sk_msg_skb_link_ops, prog);
>> +       sk_link->map = map;
>> +       sk_link->attach_type = attach_type;
>> +
>> +       ret = bpf_link_prime(&sk_link->link, &link_primer);
>> +       if (ret) {
>> +               kfree(sk_link);
>> +               goto out;
>> +       }
>> +
>> +       ret = sock_map_prog_update(map, prog, NULL, attach_type);
> Does anything prevent someone else do to remove this program from
> user-space, bypassing the link? It's a guarantee of a link that
> attachment won't be tampered with (except for SYS_ADMIN-only
> force-detachment, which is a completely separate thing).
>
> It feels like there should be some sort of protection for programs
> attached through sockmap link here. Just like we have this for XDP,
> for example, or any of cgroup BPF programs attached through BPF link.

Good point. I have a 'bpf_prog_inc(prog)' below, I could do a refcount increase
before sock_map_prog_update(), we then should be okay.

>
>> +       if (ret) {
>> +               bpf_link_cleanup(&link_primer);
>> +               goto out;
>> +       }
>> +
>> +       bpf_prog_inc(prog);
>> +
>> +       return bpf_link_settle(&link_primer);
>> +
>> +out:
>> +       bpf_map_put_with_uref(map);
>> +       return ret;
>> +}
> [...]
