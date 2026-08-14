Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968763624CC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738550; cv=none; b=lLYYytohInEc6o0lmC0qLfy/AvLelkhLiSqTTlIlgukR9m/Hf5gUeShKu8Fd8xUu7D9ZM5NdHHkdSxQNTKgHh0iV4O++CJRkuKXB4BWp3CY8dJdwh/nsnLER+6KRIu+7nJ4fWFTWZbZ114iDppFj3pwIKcCR1uyOZA/4+vDXPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738550; c=relaxed/simple;
	bh=grJ4AkWgooLwdgkYjpKaTW9ERskIEcV1kMKXUkMxeiQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZLrkv5UD64cTtVdMnDN0FUyKuXec42BbogipyGa2l+lOjnKbHd5zyjfdaQQnvOn7aZ4CQ15JXdYczzLlviCYA5TsTSbSBPoWhv1M1r4+b5d7KdjvNTL2K3+wailWOnVt78sNWwSD90HleoSHRZFj0TMDqr0YgJDfNsVcDhjprX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QVCXCLwl; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QVCXCLwl"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=grJ4AkWgooLwdgkYjpKaTW9ERskIEcV1kMKXUkMxeiQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786738546; v=1; x=1787343346;
 b=QVCXCLwlQg9yqyxVmrnbn1GOSlP+mlJzU+M+ZZNmkXz/Ba6dMPhS7OrHX5+Q7WPObECxbkW6
 ndLNcXTq0eCHfl8Y8naIqWjdRNAFngMFQDQKy6EMjXKPNliv5gJ65WQeHw3zG8br0yQYiQrSHIY
 +ZFKqU6shBnYjyaZfTnCUqSM=
X-Envelope-To: bpf@vger.kernel.org
Received: from smtpclient.apple (37.66.176.2)
	by mta10.migadu.com with ESMTPS id 4056120256c2435d;
	Fri, 14 Aug 2026 20:15:36 +0000
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs for resizable hashtab
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <CAEf4BzYLLOoiujaFO5GSra37i-DR-T4CGgU_zL-HGp2HEK2N2g@mail.gmail.com>
Date: Fri, 14 Aug 2026 22:15:21 +0200
Cc: sashiko-reviews@lists.linux.dev,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Message-Id: <DFF6A1C5-51F5-4CAD-9627-3A59CA5853B3@linux.dev>
References: <CAEf4BzYLLOoiujaFO5GSra37i-DR-T4CGgU_zL-HGp2HEK2N2g@mail.gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: iPad Mail (23G71)


> On Aug 14, 2026, at 9:49=E2=80=AFPM, Andrii Nakryiko <andrii.nakryiko@gmai=
l.com> wrote:
>=20
> =EF=BB=BFIs it really a good use of tokens for sashiko to review old patch=
es
> that have either landed or were significantly changed since (and
> probably got a bunch of new revisions sent), or just plain forgotten
> by now?
>=20
> Did something regress recently? I'm not sure this has happened before
> until recently...

Ooops, it=E2=80=99s probably a recent regression I had which blocked sashiko=
 reviews for few hours,
so I had to restart some patch(set) semi-manually. Likely this one accidenta=
lly got into this group.
Should be a one time off though.

Thanks for reporting!


>=20
> -- Andrii
>=20
>> On Thu, Aug 13, 2026 at 4:59=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>>=20
>> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>> - [High] Uninitialized memory read in `last_key` when `seq_show` overflow=
s.
>> - [High] `rhashtable_walk_enter_from` resets iterator on deleted cursor k=
ey, causing O(N^2) complexity and infinite loops.
>> - [Medium] Missing __GFP_NOWARN flag in user-controlled kmalloc for map->=
key_size can lead to OOM splats.
>> --
>>=20
>> --- Patch [8]: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs=
 for resizable hashtab ---
>> commit 226ce1988038cf4876ff0a72b5ae8e5ebc263151
>> Author: Mykyta Yatsenko <yatsenko@meta.com>
>>=20
>> bpf: Implement iterator APIs for resizable hashtab
>>=20
>> Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
>> bpf_iter and bpftool map dump work with resizable hash maps.
>>=20
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index 4611671bf8e74..5ca4d26e70178 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>=20
>> [ ... ]
>>=20
>>> @@ -3205,36 +3218,113 @@ struct bpf_iter_seq_rhash_map_info {
>>>      struct bpf_map *map;
>>>      struct bpf_rhtab *rhtab;
>>>      struct rhashtable_iter iter;
>>> -     u32 skip_elems;
>>> +     void *last_key;
>>>      bool iter_active;
>>> };
>>>=20
>>> static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
>>> {
>>> -     return NULL;
>>> +     struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
>>> +     struct rhtab_elem *elem;
>>> +     void *key =3D *pos > 0 ? info->last_key : NULL;
>>> +
>>> +     scoped_guard(rcu) {
>>> +             rhashtable_walk_enter_from(&info->rhtab->ht, &info->iter,
>>> +                                        key, info->rhtab->params);
>>=20
>> [Severity: High]
>> Will this silently restart iteration from bucket 0 if the cursor key is d=
eleted?
>>=20
>> rhashtable_walk_enter_from() looks up the provided cursor key to resume
>> iteration. If the key is missing, it returns early and leaves the iterato=
r at
>> bucket 0 (iter->slot =3D 0).
>>=20
>> In __rhtab_map_lookup_and_delete_batch(), the batch operation deletes ele=
ments
>> and returns the last deleted key to userspace. On the next batch syscall,=
 the
>> user passes this deleted key back as the cursor. Since the key no longer
>> exists, rhashtable_walk_enter_from() resets the iterator to 0.
>>=20
>> The inner loop then executes while (total < max_count) holding rcu_read_l=
ock(),
>> rescanning all previously emptied buckets from the beginning of the table=
.
>>=20
>> For lookup_batch and seq_file iterators, does this yield massive duplicat=
e
>> outputs to userspace and enormous RCU stall times?
>>=20
>>> +             rhashtable_walk_start(&info->iter);
>>> +     }
>>> +     info->iter_active =3D true;
>>> +
>>> +     elem =3D rhtab_iter_next(&info->iter);
>>> +     if (!elem)
>>> +             return NULL;
>>> +     /*
>>> +      * if *pos is not 0, previously iteration failed on this elem,
>>> +      * so we are restarting it. That's why no need to increment *pos.
>>> +      */
>>> +     if (*pos =3D=3D 0)
>>> +             ++*pos;
>>=20
>> [Severity: High]
>> Does this pass uninitialized memory as a hash key if seq_show() output
>> overflows?
>>=20
>> When reading a BPF iterator, seq_read_iter() calls bpf_rhash_map_seq_star=
t(),
>> which increments *pos from 0 to 1 and returns the first element.
>>=20
>> If the output of seq_show() for this element exceeds the initial seq_file=

>> buffer, the buffer overflows. The sequence machinery reallocates a larger=

>> buffer and calls seq_start() again.
>>=20
>> Since *pos is now 1, the code executes key =3D info->last_key. However, l=
ast_key
>> is only populated in seq_next(), which hasn't been called yet. Thus, last=
_key
>> remains uninitialized from its kmalloc(..., GFP_USER) allocation.
>>=20
>>> +     return elem;
>>> }
>>=20
>> [ ... ]
>>=20
>>> static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_=
info *aux)
>>> {
>>> +     struct bpf_iter_seq_rhash_map_info *info =3D priv_data;
>>> +     struct bpf_map *map =3D aux->map;
>>> +
>>> +     info->last_key =3D kmalloc(map->key_size, GFP_USER);
>>=20
>> [Severity: Medium]
>> Does this need __GFP_NOWARN?
>>=20
>> Since BPF hash map key sizes can be extremely large, requesting large
>> contiguous memory blocks without __GFP_NOWARN can fail loudly under memor=
y
>> fragmentation and trigger high-order page allocation warnings.
>>=20
>>> +     if (!info->last_key)
>>> +             return -ENOMEM;
>>> +
>>> +     bpf_map_inc_with_uref(map);
>>> +     info->map =3D map;
>>> +     info->rhtab =3D container_of(map, struct bpf_rhtab, map);
>>> +     info->iter_active =3D false;
>>>      return 0;
>>> }
>>=20
>> --
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408-rhash-v2=
-0-3b3675da1f6e@meta.com?part=3D8
>>=20
