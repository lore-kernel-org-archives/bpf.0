Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111F1DDF5
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380891; cv=none; b=Sg4ueLlUrMKn2ASFZ4Dp3MsvANcKfhLUjEKbnJlx9Hp/Ddu+VBPN2us38lU1wCTJrpDZYDWTKMlMB8a8nXbb+VmAF7O92FR89MHRkq8nL3cVQw4GuN9npehTOI9WE2OioyM8OOMJ9PG/E838N8KXJFyxkPPP5P730LJoNLvz9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380891; c=relaxed/simple;
	bh=ZfgpN2Tva6+ezCPNUt2QLInW8fUcFn5nSTGE8TQ/SMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8P6lpVhKuo09amv4WLqmwsXLmPWqPySTmaavbXtwitXpfm6CVE/Ot28X2OlYqK+frR3oCiLTiLzd941mNaL044M3EWhYMqJFOiNYaby53Lx02sigyTWUDB7qeISYQA5LP5Cy9hHS8aTAlYeGYPyfWoihGPXMzgQTC269ocTX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fzk/f5Uk; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fzk/f5Uk"
Message-ID: <bbfb67d2-2674-41ed-a748-eb364fd22146@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712380887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ej8eS3ceRn7IoyCwLyM1bZdW4CvD6GCbDN/feEJ/jbU=;
	b=Fzk/f5UkCRv4VToK74UrFlBAgNsI/SZTjnReoOVxf0loewu69aR8UTqSiRr4uzwl+p9S39
	zPwyjX4K09A8ulRLLgxnOvW8e06kUXaW8RilL1Xcf3OdAPSbeAbGTgD8cVJkTq4FzMS+GV
	yp+qKQsL6JHEqIdTDR4zvfWZBxq++u0=
Date: Fri, 5 Apr 2024 22:21:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025310.2211688-1-yonghong.song@linux.dev>
 <CAEf4Bza+V-DerE=Y2cuNNYgyv0jv0b4RH2r3gXt9=uzZzA2JTQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bza+V-DerE=Y2cuNNYgyv0jv0b4RH2r3gXt9=uzZzA2JTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/5/24 1:12 PM, Andrii Nakryiko wrote:
> On Wed, Apr 3, 2024 at 7:53 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add bpf_link support for sk_msg and sk_skb programs. We have an
>> internal request to support bpf_link for sk_msg programs so user
>> space can have a uniform handling with bpf_link based libbpf
>> APIs. Using bpf_link based libbpf API also has a benefit which
>> makes system robust by decoupling prog life cycle and
>> attachment life cycle.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h            |   6 +
>>   include/linux/skmsg.h          |   4 +
>>   include/uapi/linux/bpf.h       |   5 +
>>   kernel/bpf/syscall.c           |   4 +
>>   net/core/sock_map.c            | 268 ++++++++++++++++++++++++++++++++-
>>   tools/include/uapi/linux/bpf.h |   5 +
>>   6 files changed, 284 insertions(+), 8 deletions(-)
>>
> [...]
>
>> @@ -103,7 +111,7 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
>>                  goto put_prog;
>>          }
>>
>> -       ret = sock_map_prog_update(map, NULL, prog, attr->attach_type);
>> +       ret = sock_map_prog_update(map, NULL, prog, NULL, attr->attach_type);
>>   put_prog:
>>          bpf_prog_put(prog);
>>   put_map:
>> @@ -1488,21 +1496,79 @@ static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
>>          return 0;
>>   }
>>
>> +static int sock_map_link_lookup(struct bpf_map *map, struct bpf_link ***plink,
>> +                               struct bpf_link *link, bool skip_check, u32 which)
> why not combine prog + link into a single lookup? also it seems like
> sock_map_prog_lookup has some additional EBUSY conditions, do we need
> to replicate them here?

I can combine them together.

>
>> +{
>> +       struct sk_psock_progs *progs = sock_map_progs(map);
>> +       struct bpf_link **cur_plink;
>> +
>> +       switch (which) {
>> +       case BPF_SK_MSG_VERDICT:
>> +               cur_plink = &progs->msg_parser_link;
>> +               break;
>> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> +       case BPF_SK_SKB_STREAM_PARSER:
>> +               cur_plink = &progs->stream_parser_link;
>> +               break;
>> +#endif
>> +       case BPF_SK_SKB_STREAM_VERDICT:
>> +               cur_plink = &progs->stream_verdict_link;
>> +               break;
>> +       case BPF_SK_SKB_VERDICT:
>> +               cur_plink = &progs->skb_verdict_link;
>> +               break;
>> +       default:
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>> +       if (!skip_check && ((!link && *cur_plink) || (link && link != *cur_plink)))
>> +               return -EBUSY;
>> +
>> +       *plink = cur_plink;
>> +       return 0;
>> +}
>> +
>> +/* Handle the following four cases:
>> + * prog_attach: prog != NULL, old == NULL, link == NULL
>> + * prog_detach: prog == NULL, old != NULL, link == NULL
>> + * link_attach: prog != NULL, old == NULL, link != NULL
>> + * link_detach: prog == NULL, old != NULL, link != NULL
>> + */
>>   static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>> -                               struct bpf_prog *old, u32 which)
>> +                               struct bpf_prog *old, struct bpf_link *link,
>> +                               u32 which)
>>   {
>>          struct bpf_prog **pprog;
>> +       struct bpf_link **plink;
>>          int ret;
>>
>> +       mutex_lock(&sockmap_mutex);
>> +
>>          ret = sock_map_prog_lookup(map, &pprog, which);
>>          if (ret)
>> -               return ret;
>> +               goto out;
>>
>> -       if (old)
>> -               return psock_replace_prog(pprog, prog, old);
>> +       if (!link || prog)
>> +               ret = sock_map_link_lookup(map, &plink, NULL, false, which);
>> +       else
>> +               ret = sock_map_link_lookup(map, &plink, NULL, true, which);
>> +       if (ret)
>> +               goto out;
>> +
>> +       if (old) {
>> +               ret = psock_replace_prog(pprog, prog, old);
>> +               if (!ret)
>> +                       *plink = NULL;
>> +               goto out;
>> +       }
>>
>>          psock_set_prog(pprog, prog);
>> -       return 0;
>> +       if (link)
>> +               *plink = link;
> nit: feels more natural to do
>
> if (old) {
>      psock_replace_prog(...)
> } else {
>      psock_set_prog(...)
> }
>
> it's two alternatives, not one unlikely vs one main use case (but it's minor)

Ack indeed better.

>
>> +
>> +out:
>> +       mutex_unlock(&sockmap_mutex);
>> +       return ret;
>>   }
>>
>>   int sock_map_bpf_prog_query(const union bpf_attr *attr,
>> @@ -1657,6 +1723,192 @@ void sock_map_close(struct sock *sk, long timeout)
>>   }
>>   EXPORT_SYMBOL_GPL(sock_map_close);
>>
>> +struct sockmap_link {
>> +       struct bpf_link link;
>> +       struct bpf_map *map;
>> +       enum bpf_attach_type attach_type;
>> +};
>> +
>> +static void sock_map_link_release(struct bpf_link *link)
>> +{
>> +       struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
>> +
>> +       if (sockmap_link->map) {
> nit: if (!sockmap_link->map) return;
>
> and reduce nesting of everything else
>
>> +               WARN_ON_ONCE(sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
>> +                                                 sockmap_link->attach_type));
> I think sockmap_link->map access in general has to be always protected
> my sockmap_mutex (I'd do that even for the if above), because it can
> race with force-detach logic at least

Ack. will fix this.

>
>> +
>> +               mutex_lock(&sockmap_mutex);
>> +               bpf_map_put_with_uref(sockmap_link->map);
>> +               sockmap_link->map = NULL;
>> +               mutex_unlock(&sockmap_mutex);
>> +       }
>> +}
>> +
> [...]
>
>> +       if (old) {
>> +               ret = psock_replace_prog(pprog, prog, old);
>> +               goto out;
>> +       }
>> +
>> +       psock_set_prog(pprog, prog);
>> +
>> +out:
> same nit, feels like
>
> if (old) /* replace */ else /* set */ is more natural, and then you
> can move xchg logic before out: knowing that it's the only success
> case

Ack. will do.

>
>> +       if (!ret) {
>> +               bpf_prog_inc(prog);
>> +               old = xchg(&link->prog, prog);
>> +               bpf_prog_put(old);
>> +       }
>> +       mutex_unlock(&sockmap_mutex);
>> +       return ret;
>> +}
>> +
> [...]
