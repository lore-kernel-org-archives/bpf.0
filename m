Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4433B6DC
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819740; cv=none; b=HPqs7vcXvtNofGdUYX2W9bJECKSDJnlIenQDbNAu0b+Fkn9Ydxy3NLflD9t2NH+y/tYFufjZqAQpJ8t49RfgItKBZw4fS1qT0yavIOUJ8Y7Rr8H4tbdxH9ffprv59LzQEueKwq1Knxa+aSxpX+W8siayc8XPjXgJLup32rCjRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819740; c=relaxed/simple;
	bh=aAU4r4wcSzuJBRtvpmCVb7VW5HpUc9ZubfS/88tMtgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOL//rexKSnnzaaf78MNcFFb/r4DZowNITglDyUhZJVAsX2OG8kFl5Z2x0un5DCQMNMv69aNvAeVS/ezXamOS3nbcCqpJ0Tm7Zz4ak6/R9JBVPtLhNviEDX7I7cLW3eC03U/ljunXaYBLGFPK/HdKlBneqaU/ek2LmJMeGxH6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RcC4LpGG; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RcC4LpGG"
Message-ID: <0fb2d99b-b122-44fa-a8bc-9befe6e350bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778819735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTPHY20UAnHcyPzsegTptAYyXWembJwUrSvdT0eQ7G4=;
	b=RcC4LpGG7HyGL4mkc7i5Z69cIXry+7cKanZJTwWUMpiSgGyLcVjaxhY9AkD1e41V8rVx4/
	f/+WwZUnivWFJ2iEHe3EM7/HNym9764I1Fa6NbJCs93wLEY8VwJ+vNAtoiq7oBZlqV3UFs
	B1iFTEg05eWHCe0bF6liOeV8tv+MRvc=
Date: Fri, 15 May 2026 12:34:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and
 unlink before drop
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, ast@kernel.org, memxor@gmail.com, corbet@lwn.net,
 martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 vmalik@redhat.com, linux-kselftest@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev, bot+bpf-ci@kernel.org
References: <20260512055919.95716-3-kaitao.cheng@linux.dev>
 <da95f45b43d94d17796b19abc4c555e35daafab7d5e1cdca3714fe0f54ab8cce@mail.kernel.org>
 <e141699dab70282d811ec30bbf2aa8279706817b.camel@gmail.com>
 <DII0TT9LXYCX.2GMM6QA4Q9BPZ@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <DII0TT9LXYCX.2GMM6QA4Q9BPZ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/14 09:50, Alexei Starovoitov 写道:
> On Wed May 13, 2026 at 3:53 PM PDT, Eduard Zingerman wrote:
>> On Tue, 2026-05-12 at 06:41 +0000, bot+bpf-ci@kernel.org wrote:
>>
>> [...]
>>
>>> When a BPF program holds an owning or refcount-acquired reference to
>>> one of these nodes (node X), which is structurally supported because
>>> __bpf_obj_drop_impl() uses refcount_dec_and_test() and only frees at
>>> refcount 0, a concurrent push to a DIFFERENT bpf_list_head becomes a
>>> corruption:
>>>
>>> CPU 0 (bpf_list_head_free, lock released)  CPU 1 (BPF prog, refcount X)
>>> -----------------------------------------   ----------------------------
>>> (owner of X == NULL, X linked in drain)
>>>                                             bpf_list_push_back(other, X)
>>>                                               __bpf_list_add: spin_lock()
>>>                                               cmpxchg(X->owner, NULL,
>>>                                                       POISON) -> OK
>>>                                               list_add_tail(&X->list_head,
>>>                                                             other_head)
>>>                                                 -> overwrites X->next,
>>>                                                    X->prev, corrupts
>>>                                                    other_head's chain
>>>                                                    because X is still
>>>                                                    stitched into drain
>>> pos = drain.next;      (may be X or neighbor using X's stale next)
>>> list_del_init(pos);    reads X->next/prev now pointing into other_head,
>>>                        corrupts other_head's list and/or drain
>>
>>
>> Kaitao, this scenario seem plausible, could you please comment on it?
> 
> I think bot is correct.
> This patch looks buggy.
> It seems to me an optimization that breaks the concurrent logic.
> May be just drop this patch and reorder the other one, so that bot
> sees nonown suffix logic first.

This patch is still necessary because it addresses the problem discussed
in this thread:
https://lore.kernel.org/all/DH846C0P88QU.16YT12I1LXBZM@etsalapatis.com/

The patch does have a bug, however. To fix the issues we are seeing now,
I propose the additional changes below and would appreciate feedback.

--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2263,8 +2263,10 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
        if (!head->next || list_empty(head))
                goto unlock;
        list_for_each_safe(pos, n, head) {
-               WRITE_ONCE(container_of(pos,
-                       struct bpf_list_node_kern, list_head)->owner, NULL);
+               struct bpf_list_node_kern *node;
+
+               node = container_of(pos, struct bpf_list_node_kern, list_head);
+               WRITE_ONCE(node->owner, BPF_PTR_POISON);
                list_move_tail(pos, &drain);
        }
 unlock:
@@ -2272,8 +2274,12 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
        __bpf_spin_unlock_irqrestore(spin_lock);

        while (!list_empty(&drain)) {
+               struct bpf_list_node_kern *node;
+
                pos = drain.next;
+               node = container_of(pos, struct bpf_list_node_kern, list_head);
                list_del_init(pos);
+               WRITE_ONCE(node->owner, NULL);
                /* The contained type can also have resources, including a
                 * bpf_list_head which needs to be freed.
                 */
@@ -2481,6 +2487,14 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
        if (unlikely(!h->next))
                INIT_LIST_HEAD(h);

+       /* bpf_list_head_free() marks nodes being detached with BPF_PTR_POISON
+        * before list_del_init().  cmpxchg(NULL, POISON) below would fail with
+        * that old value and fall into the generic error path, which wrongly
+        * calls __bpf_obj_drop_impl().  Reject POISON up front instead.
+        */
+       if (READ_ONCE(node->owner) == BPF_PTR_POISON)
+               return -EINVAL;
+
        /* node->owner != NULL implies !list_empty(n), no need to separately
         * check the latter
         */

-- 
Thanks
Kaitao Cheng

