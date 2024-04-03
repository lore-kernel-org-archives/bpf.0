Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837528FC
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106535; cv=none; b=f23U7K3ceH9Vl30VfCo8p9U+x8VKERudtOruXo8nhH9Eq/46ojIjaufvwyICufHQNv7+WXGtED6wsHDJ+uhOBVL6qQHhveszmBXjPeuEP0Z46u4A0LQwv0I/LiRa6CgsgfohKDtnGL4ZoNbOjtDOnScLuZXan8blKyPQDwd3b4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106535; c=relaxed/simple;
	bh=KLH0XneWkr+RLzvTDmUu4LTPkJYyrFcR9FohrHZ6FO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFMY/6LXl7G3PB+FI2tsyCNG86TKl+1ohxp/60sLyqmE7rh+B5EL5YREC4VCiG/L9uahULMu1Kz1qvLG2m0JBWrA4bgW3Gc7dWLWcFWSV8S2ONDMPU4XojGvYojcT+Ymokwj81d+yNZ6iQx60jE9bk26gBGHZG8UFU0kIywSQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJt50UJX; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJt50UJX"
Message-ID: <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712106530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSz42FaigdmwaCr4OZPBFKdPw0megH5VcZ1U1fRuBh4=;
	b=lJt50UJXKlqwzArU2sB3KYuepMDW0/uEwYP3erstVavFH3kvQJZpvC6Bvz4v4FlfaiIewA
	tAB1GEv7DPkxEBYXPtJuG9WJ5TEsfWV+i+AE9lsxe9nCYUgQMgnQCkpljt704ILmtoj/x8
	fGqiynPPawIHiIDlFdi/4lXKlXJ3p6c=
Date: Tue, 2 Apr 2024 18:08:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/2/24 10:45 AM, Andrii Nakryiko wrote:
> On Mon, Mar 25, 2024 at 7:22 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>>   net/core/sock_map.c            | 263 ++++++++++++++++++++++++++++++++-
>>   tools/include/uapi/linux/bpf.h |   5 +
>>   6 files changed, 279 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 62762390c93d..5034c1b4ded7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2996,6 +2996,7 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
>>   int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
>>   int sock_map_bpf_prog_query(const union bpf_attr *attr,
>>                              union bpf_attr __user *uattr);
>> +int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog);
>>
>>   void sock_map_unhash(struct sock *sk);
>>   void sock_map_destroy(struct sock *sk);
>> @@ -3094,6 +3095,11 @@ static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
>>   {
>>          return -EINVAL;
>>   }
>> +
>> +static inline int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>>   #endif /* CONFIG_BPF_SYSCALL */
>>   #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index e65ec3fd2799..9c8dd4c01412 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -58,6 +58,10 @@ struct sk_psock_progs {
>>          struct bpf_prog                 *stream_parser;
>>          struct bpf_prog                 *stream_verdict;
>>          struct bpf_prog                 *skb_verdict;
>> +       struct bpf_link                 *msg_parser_link;
>> +       struct bpf_link                 *stream_parser_link;
>> +       struct bpf_link                 *stream_verdict_link;
>> +       struct bpf_link                 *skb_verdict_link;
>>   };
>>
>>   enum sk_psock_state_bits {
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 9585f5345353..31660c3ffc01 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1135,6 +1135,7 @@ enum bpf_link_type {
>>          BPF_LINK_TYPE_TCX = 11,
>>          BPF_LINK_TYPE_UPROBE_MULTI = 12,
>>          BPF_LINK_TYPE_NETKIT = 13,
>> +       BPF_LINK_TYPE_SOCKMAP = 14,
>>          __MAX_BPF_LINK_TYPE,
>>   };
>>
>> @@ -6720,6 +6721,10 @@ struct bpf_link_info {
>>                          __u32 ifindex;
>>                          __u32 attach_type;
>>                  } netkit;
>> +               struct {
>> +                       __u32 map_id;
>> +                       __u32 attach_type;
>> +               } sockmap;
>>          };
>>   } __attribute__((aligned(8)));
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index e44c276e8617..7d392ec83655 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>>          case BPF_PROG_TYPE_SK_LOOKUP:
>>                  ret = netns_bpf_link_create(attr, prog);
>>                  break;
>> +       case BPF_PROG_TYPE_SK_MSG:
>> +       case BPF_PROG_TYPE_SK_SKB:
>> +               ret = sock_map_link_create(attr, prog);
>> +               break;
>>   #ifdef CONFIG_NET
>>          case BPF_PROG_TYPE_XDP:
>>                  ret = bpf_xdp_link_attach(attr, prog);
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 27d733c0f65e..dafc9aa6e192 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -24,8 +24,12 @@ struct bpf_stab {
>>   #define SOCK_CREATE_FLAG_MASK                          \
>>          (BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
>>
>> +static DEFINE_MUTEX(sockmap_prog_update_mutex);
>> +static DEFINE_MUTEX(sockmap_link_mutex);
>> +
>>   static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>> -                               struct bpf_prog *old, u32 which);
>> +                               struct bpf_prog *old, struct bpf_link *link,
>> +                               u32 which);
>>   static struct sk_psock_progs *sock_map_progs(struct bpf_map *map);
>>
>>   static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
>> @@ -71,7 +75,7 @@ int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog)
>>          map = __bpf_map_get(f);
>>          if (IS_ERR(map))
>>                  return PTR_ERR(map);
>> -       ret = sock_map_prog_update(map, prog, NULL, attr->attach_type);
>> +       ret = sock_map_prog_update(map, prog, NULL, NULL, attr->attach_type);
>>          fdput(f);
>>          return ret;
>>   }
>> @@ -103,7 +107,7 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
>>                  goto put_prog;
>>          }
>>
>> -       ret = sock_map_prog_update(map, NULL, prog, attr->attach_type);
>> +       ret = sock_map_prog_update(map, NULL, prog, NULL, attr->attach_type);
>>   put_prog:
>>          bpf_prog_put(prog);
>>   put_map:
>> @@ -1488,21 +1492,90 @@ static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
>>          return 0;
>>   }
>>
>> +static int sock_map_link_lookup(struct bpf_map *map, struct bpf_link ***plink,
>> +                               struct bpf_link *link, bool skip_check, u32 which)
>> +{
>> +       struct sk_psock_progs *progs = sock_map_progs(map);
>> +
>> +       switch (which) {
>> +       case BPF_SK_MSG_VERDICT:
>> +               if (!skip_check &&
>> +                   ((!link && progs->msg_parser_link) ||
>> +                    (link && link != progs->msg_parser_link)))
>> +                       return -EBUSY;
>> +               *plink = &progs->msg_parser_link;
>> +               break;
>> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> +       case BPF_SK_SKB_STREAM_PARSER:
>> +               if (!skip_check &&
>> +                   ((!link && progs->stream_parser_link) ||
>> +                    (link && link != progs->stream_parser_link)))
>> +                       return -EBUSY;
>> +               *plink = &progs->stream_parser_link;
>> +               break;
>> +#endif
>> +       case BPF_SK_SKB_STREAM_VERDICT:
>> +               if (!skip_check &&
>> +                   ((!link && progs->stream_verdict_link) ||
>> +                    (link && link != progs->stream_verdict_link)))
>> +                       return -EBUSY;
>> +               *plink = &progs->stream_verdict_link;
>> +               break;
>> +       case BPF_SK_SKB_VERDICT:
>> +               if (!skip_check &&
>> +                   ((!link && progs->skb_verdict_link) ||
>> +                    (link && link != progs->skb_verdict_link)))
>> +                       return -EBUSY;
>> +               *plink = &progs->skb_verdict_link;
>> +               break;
>> +       default:
>> +               return -EOPNOTSUPP;
>> +       }
>> +
> you can simplify this by
>
> struct bpf_link *cur_link;
>
> switch (which) {
> case BPF_SK_MSG_VERDICT:
>      cur_link = progs->msg_parser_link;
>      break;
> case ...
>
> }
>
> and then perform that condition validating link and cur_link just once.

Indeed, this sounds simpler.

>
>
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
>> +       mutex_lock(&sockmap_prog_update_mutex);
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
> it feels like it would be cleaner if sock_map_link_lookup() would just
> return already set link (based on which), and then you'd check update
> logic with prog vs link right here
>
> e.g., it's quite obfuscated that we validate that there is no link set
> currently (this code doesn't do anything with plink).
>
> anyways, I find it a bit hard to follow as it's written, but I'll
> defer to John to make a final call on logic
>
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
>> +
>> +out:
>> +       mutex_unlock(&sockmap_prog_update_mutex);
> why this mutex is not per-sockmap?

My thinking is the system probably won't have lots of sockmaps and
sockmap attach/detach/update_prog should not be that frequent. But
I could be wrong.

>
>> +       return ret;
>>   }
>>
>>   int sock_map_bpf_prog_query(const union bpf_attr *attr,
>> @@ -1657,6 +1730,180 @@ void sock_map_close(struct sock *sk, long timeout)
>>   }
>>   EXPORT_SYMBOL_GPL(sock_map_close);
>>
>> +struct sockmap_link {
>> +       struct bpf_link link;
>> +       struct bpf_map *map;
>> +       enum bpf_attach_type attach_type;
>> +};
>> +
>> +static struct sockmap_link *get_sockmap_link(const struct bpf_link *link)
>> +{
>> +       return container_of(link, struct sockmap_link, link);
>> +}
> nit: do you really need this helper? container_of() is a pretty
> straightforward by itself, imo

I can do this.

>
>> +
>> +static void sock_map_link_release(struct bpf_link *link)
>> +{
>> +       struct sockmap_link *sockmap_link = get_sockmap_link(link);
>> +
>> +       mutex_lock(&sockmap_link_mutex);
> similar to the above, why is this mutex not sockmap-specific? And I'd
> just combine sockmap_link_mutex and sockmap_prog_update_mutex in this
> case to keep it simple.

This is to protect sockmap_link->map. They could share the same lock.
Let me double check...

>
>> +       if (sockmap_link->map) {
>> +               (void)sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
>> +                                          sockmap_link->attach_type);
> WARN() if it's not meant to ever fail?

Yes, this is in link_release function and should not fail.
I can add a WARN here.

>
>> +               bpf_map_put_with_uref(sockmap_link->map);
>> +               sockmap_link->map = NULL;
>> +       }
>> +       mutex_unlock(&sockmap_link_mutex);
>> +}
>> +
>> +static int sock_map_link_detach(struct bpf_link *link)
>> +{
>> +       sock_map_link_release(link);
>> +       return 0;
>> +}
>> +
>> +static void sock_map_link_dealloc(struct bpf_link *link)
>> +{
>> +       kfree(get_sockmap_link(link));
>> +}
>> +
>> +/* Handle the following two cases:
>> + * case 1: link != NULL, prog != NULL, old != NULL
>> + * case 2: link != NULL, prog != NULL, old == NULL
>> + */
>> +static int sock_map_link_update_prog(struct bpf_link *link,
>> +                                    struct bpf_prog *prog,
>> +                                    struct bpf_prog *old)
>> +{
>> +       const struct sockmap_link *sockmap_link = get_sockmap_link(link);
>> +       struct bpf_prog **pprog;
>> +       struct bpf_link **plink;
>> +       int ret = 0;
>> +
>> +       mutex_lock(&sockmap_prog_update_mutex);
>> +
>> +       /* If old prog not NULL, ensure old prog the same as link->prog. */
> typo: "is not NULL", "is the same"
>
>> +       if (old && link->prog != old) {
> hm.. even if old matches link->prog, we should unset old and set new
> link (link overrides prog attachment, basically), it shouldn't matter
> if old == link->prog, unless I'm missing something?

In xdp link (net/core/dev.c), we have

         cur_prog = dev_xdp_prog(dev, mode);
         /* can't replace attached prog with link */
         if (link && cur_prog) {
                 NL_SET_ERR_MSG(extack, "Can't replace active XDP 
program with BPF link");
                 return -EBUSY;
         }
         if ((flags & XDP_FLAGS_REPLACE) && cur_prog != old_prog) {
                 NL_SET_ERR_MSG(extack, "Active program does not match 
expected");
                 return -EEXIST;
         }

if flags has XDP_FLAGS_REPLACE, link saved prog must be equal to old_prog
in order to do prog update.
for sockmap prog update, in link_update (syscall.c), the only way
we can get a non-NULL old_prog is with the following:

         if (flags & BPF_F_REPLACE) {
                 old_prog = bpf_prog_get(attr->link_update.old_prog_fd);
                 if (IS_ERR(old_prog)) {
                         ret = PTR_ERR(old_prog);
                         old_prog = NULL;
                         goto out_put_progs;
                 }
         } else if (attr->link_update.old_prog_fd) {
                 ret = -EINVAL;
                 goto out_put_progs;
         }
Basically, we have BPF_F_REPLACE here.
So similar to xdp link, I think we should check old_prog to
be equal to link->prog in order to do link update_prog.

>
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +       /* Ensure link->prog has the same type/attach_type as the new prog. */
>> +       if (link->prog->type != prog->type ||
>> +           link->prog->expected_attach_type != prog->expected_attach_type) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       ret = sock_map_prog_lookup(sockmap_link->map, &pprog,
>> +                                  sockmap_link->attach_type);
>> +       if (ret)
>> +               goto out;
>> +
>> +       /* Ensure the same link between the one in map and the passed-in. */
>> +       ret = sock_map_link_lookup(sockmap_link->map, &plink, link, false,
>> +                                  sockmap_link->attach_type);
>> +       if (ret)
>> +               goto out;
>> +
>> +       if (old)
>> +               return psock_replace_prog(pprog, prog, old);
>> +
>> +       psock_set_prog(pprog, prog);
>> +
>> +out:
>> +       if (!ret)
>> +               bpf_prog_inc(prog);
>> +       mutex_unlock(&sockmap_prog_update_mutex);
>> +       return ret;
>> +}
>> +
>> +static u32 sock_map_link_get_map_id(const struct sockmap_link *sockmap_link)
>> +{
>> +       u32 map_id = 0;
>> +
>> +       mutex_lock(&sockmap_link_mutex);
>> +       if (sockmap_link->map)
>> +               map_id = sockmap_link->map->id;
>> +       mutex_unlock(&sockmap_link_mutex);
>> +       return map_id;
>> +}
>> +
>> +static int sock_map_link_fill_info(const struct bpf_link *link,
>> +                                  struct bpf_link_info *info)
>> +{
>> +       const struct sockmap_link *sockmap_link = get_sockmap_link(link);
>> +       u32 map_id = sock_map_link_get_map_id(sockmap_link);
>> +
>> +       info->sockmap.map_id = map_id;
>> +       info->sockmap.attach_type = sockmap_link->attach_type;
>> +       return 0;
>> +}
>> +
>> +static void sock_map_link_show_fdinfo(const struct bpf_link *link,
>> +                                     struct seq_file *seq)
>> +{
>> +       const struct sockmap_link *sockmap_link = get_sockmap_link(link);
>> +       u32 map_id = sock_map_link_get_map_id(sockmap_link);
>> +
>> +       seq_printf(seq, "map_id:\t%u\n", map_id);
>> +       seq_printf(seq, "attach_type:\t%u\n", sockmap_link->attach_type);
>> +}
>> +
>> +static const struct bpf_link_ops sock_map_link_ops = {
>> +       .release = sock_map_link_release,
>> +       .dealloc = sock_map_link_dealloc,
>> +       .detach = sock_map_link_detach,
>> +       .update_prog = sock_map_link_update_prog,
>> +       .fill_link_info = sock_map_link_fill_info,
>> +       .show_fdinfo = sock_map_link_show_fdinfo,
>> +};
>> +
>> +int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
>> +{
>> +       struct bpf_link_primer link_primer;
>> +       struct sockmap_link *sockmap_link;
>> +       enum bpf_attach_type attach_type;
>> +       struct bpf_map *map;
>> +       int ret;
>> +
>> +       if (attr->link_create.flags)
>> +               return -EINVAL;
>> +
>> +       map = bpf_map_get_with_uref(attr->link_create.target_fd);
>> +       if (IS_ERR(map))
>> +               return PTR_ERR(map);
> check that map is SOCKMAP?
Good point. Will do.
>
>> +
>> +       sockmap_link = kzalloc(sizeof(*sockmap_link), GFP_USER);
>> +       if (!sockmap_link) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       attach_type = attr->link_create.attach_type;
>> +       bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_map_link_ops, prog);
>> +       sockmap_link->map = map;
>> +       sockmap_link->attach_type = attach_type;
>> +
>> +       ret = bpf_link_prime(&sockmap_link->link, &link_primer);
>> +       if (ret) {
>> +               kfree(sockmap_link);
>> +               goto out;
>> +       }
>> +
>> +       ret = sock_map_prog_update(map, prog, NULL, &sockmap_link->link, attach_type);
>> +       if (ret) {
>> +               bpf_link_cleanup(&link_primer);
>> +               goto out;
>> +       }
>> +
>> +       bpf_prog_inc(prog);
> if link was created successfully, it "inherits" prog's refcnt, so you
> shouldn't do another bpf_prog_inc()? generic link_create() logic puts
> prog only if this function returns error

The reason I did this is due to

static inline void psock_set_prog(struct bpf_prog **pprog,
                                   struct bpf_prog *prog)
{
         prog = xchg(pprog, prog);
         if (prog)
                 bpf_prog_put(prog);
}

You can see when the prog is swapped due to link_update or prog_attach,
its reference count is decremented by 1. This is necessary for prog_attach,
but as you mentioned, indeed, it is not necessary for link-based approach.
Let me see whether I can refactor code to make it easy not to increase
reference count of prog here.


>
>> +
>> +       return bpf_link_settle(&link_primer);
>> +
>> +out:
>> +       bpf_map_put_with_uref(map);
>> +       return ret;
>> +}
>> +
>>   static int sock_map_iter_attach_target(struct bpf_prog *prog,
>>                                         union bpf_iter_link_info *linfo,
>>                                         struct bpf_iter_aux_info *aux)
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 9585f5345353..31660c3ffc01 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1135,6 +1135,7 @@ enum bpf_link_type {
>>          BPF_LINK_TYPE_TCX = 11,
>>          BPF_LINK_TYPE_UPROBE_MULTI = 12,
>>          BPF_LINK_TYPE_NETKIT = 13,
>> +       BPF_LINK_TYPE_SOCKMAP = 14,
>>          __MAX_BPF_LINK_TYPE,
>>   };
>>
>> @@ -6720,6 +6721,10 @@ struct bpf_link_info {
>>                          __u32 ifindex;
>>                          __u32 attach_type;
>>                  } netkit;
>> +               struct {
>> +                       __u32 map_id;
>> +                       __u32 attach_type;
>> +               } sockmap;
>>          };
>>   } __attribute__((aligned(8)));
>>
>> --
>> 2.43.0
>>
