Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C73D301F
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270992; cv=none; b=r+/hCnpKph3SXTp0V/MPRQVLMn+s/H3gri5qjNya68RuWAESfODH3JHixSiqgboedUkUNPYhhW6GanYdQaFpRkS91RYtiPkvKW/HcRriJNenqpVKotrRKiVxItY84wTLh2M/5+MRm4PHQ8X0hACzxMqX1yV4S1mKd6zT967YkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270992; c=relaxed/simple;
	bh=lPVKnxeYZcOQBIW6ypz3E7ZufIXvKyUkwx8YZr2smpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/Q3uggmPdRvXwzGlqA7ua12SvUXcOUzSnCaMnnqEXMyWiyLpnXq/33tV/R7cuGN9EkrWC9IcJxEmRXved8swW7TiyPgljJis0FkAg32UIz0MenUmm9+kUbCvonEjWdMnJ5HDK8F+8y42QyCymYXceGMioYKKWM6BSheHa5xcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eKUfxmBE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eKUfxmBE"
Message-ID: <47b928ac-25d9-481c-8764-8f840c2dcafa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779270978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk2SEnfE8DoCb6Y73J9sMWTvnR47QajM1Ro5oBOMNpQ=;
	b=eKUfxmBERs0yEGH1Boa4hUveRBD4XIziHjY6VFVb5ACA/mS4KFqQSVUGedsOBpYCXeL7zN
	XlPrnFrsEBu5XUD702HkvgpMVIlOF4t7v6dwJBXfm2Rq48EIsLYcr2qxayCF9iAb2YS2RO
	E3l0cqQOctyOT5kDrmXZqETJFvxwA60=
Date: Wed, 20 May 2026 17:55:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and
 unlink before drop
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
 memxor@gmail.com, corbet@lwn.net, martin.lau@linux.dev,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, skhan@linuxfoundation.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev, bot+bpf-ci@kernel.org
References: <20260512055919.95716-3-kaitao.cheng@linux.dev>
 <da95f45b43d94d17796b19abc4c555e35daafab7d5e1cdca3714fe0f54ab8cce@mail.kernel.org>
 <e141699dab70282d811ec30bbf2aa8279706817b.camel@gmail.com>
 <DII0TT9LXYCX.2GMM6QA4Q9BPZ@gmail.com>
 <0fb2d99b-b122-44fa-a8bc-9befe6e350bc@linux.dev>
 <7fa6794161a8bd4fdbc21dad68e86e9770c873cc.camel@gmail.com>
 <0171629c-bdd3-4661-a4e6-2698dd623c3a@linux.dev>
 <d5961282-d41c-4e54-8ba2-cd08823a8c77@linux.dev>
 <782833db5da77e4aa9761fc410827e7abe8583c8.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <782833db5da77e4aa9761fc410827e7abe8583c8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/5/20 06:56, Eduard Zingerman 写道:
> On Mon, 2026-05-18 at 11:02 +0800, Kaitao Cheng wrote:
> 
> [...]
> 
>>>>> The patch does have a bug, however. To fix the issues we are seeing now,
>>>>> I propose the additional changes below and would appreciate feedback.
>>>>>
>>>>> --- a/kernel/bpf/helpers.c
>>>>> +++ b/kernel/bpf/helpers.c
>>>>> @@ -2263,8 +2263,10 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>>>>>         if (!head->next || list_empty(head))
>>>>>                 goto unlock;
>>>>>         list_for_each_safe(pos, n, head) {
>>>>> -               WRITE_ONCE(container_of(pos,
>>>>> -                       struct bpf_list_node_kern, list_head)->owner, NULL);
>>>>> +               struct bpf_list_node_kern *node;
>>>>> +
>>>>> +               node = container_of(pos, struct bpf_list_node_kern, list_head);
>>>>> +               WRITE_ONCE(node->owner, BPF_PTR_POISON);
>>>>>                 list_move_tail(pos, &drain);
>>>>>         }
>>>>>  unlock:
>>>>> @@ -2272,8 +2274,12 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>>>>>         __bpf_spin_unlock_irqrestore(spin_lock);
>>>>>
>>>>>         while (!list_empty(&drain)) {
>>>>> +               struct bpf_list_node_kern *node;
>>>>> +
>>>>>                 pos = drain.next;
>>>>> +               node = container_of(pos, struct bpf_list_node_kern, list_head);
>>>>>                 list_del_init(pos);
>>>>> +               WRITE_ONCE(node->owner, NULL);
> 
> Is CPU allowed to reorder the stores in list_del_init() and WRITE_ONCE()?
> If it is, I think there is a race here.

Thanks for taking a close look at this. You are right that there is an
ordering issue here, but I don't think the specific sequence illustrated
by the example below is problematic.

> Thread #1:
>   enter bpf_list_head_free()
>   acquire H1 lock
>   list_move_tail(pos, &drain);             // reordered
>   <-- ip here -->
>   WRITE_ONCE(node->owner, BPF_PTR_POISON); // reordered
> 
> Thread #2:
> 
>   acquire H1 lock
>   n = bpf_refcount_acquire()
>   release H1 lock
>   acquire H2 lock
>   enter __bpf_list_add()
>   <-- ip here -->
>   cmpxchg(&node->owner, NULL, BPF_PTR_POISON)

Even if the stores from list_move_tail(pos, &drain) become visible before
WRITE_ONCE(node->owner, BPF_PTR_POISON), node->owner is not NULL in that
window. Before the WRITE_ONCE(), it still points to H1. After the WRITE_ONCE(),
it is BPF_PTR_POISON. In both cases, __bpf_list_add() will fail:

	cmpxchg(&node->owner, NULL, BPF_PTR_POISON)

because the old value is neither NULL nor expected to become NULL from this
part of bpf_list_head_free().


However, I agree that your original concern about the ordering between
list_del_init() and WRITE_ONCE(node->owner, NULL) is valid for the later
drain loop:

	list_del_init(pos);
	WRITE_ONCE(node->owner, NULL);

Here owner == NULL is the signal that the node can be inserted into another
list. Since WRITE_ONCE() does not provide release ordering, another CPU may
observe owner == NULL and successfully acquire the node in __bpf_list_add()
before the list_del_init() stores are visible. In that case __bpf_list_add()
can link the node into H2, and the delayed stores from list_del_init() may
then overwrite the node's list pointers and corrupt the H2 list.

So the fix should be to publish owner == NULL with release ordering after the
node has been fully unlinked, for example:

```
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2279,7 +2279,8 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
                pos = drain.next;
                node = container_of(pos, struct bpf_list_node_kern, list_head);
                list_del_init(pos);
-               WRITE_ONCE(node->owner, NULL);
+               /* Ensure __bpf_list_add() sees the node as unlinked. */
+               smp_store_release(&node->owner, NULL);
                /* The contained type can also have resources, including a
                 * bpf_list_head which needs to be freed.
                 */
@@ -2607,7 +2608,8 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
                return NULL;

        list_del_init(n);
-       WRITE_ONCE(node->owner, NULL);
+       /* Ensure __bpf_list_add() sees the node as unlinked. */
+       smp_store_release(&node->owner, NULL);
        return (struct bpf_list_node *)n;
 }
```

The existing cmpxchg() in __bpf_list_add() is a successful RMW with return
value, so it is fully ordered and is sufficient on the acquire side.

-- 
Thanks
Kaitao Cheng

