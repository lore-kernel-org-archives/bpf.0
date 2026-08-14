Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF63AEF2D
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739918; cv=none; b=c3q9DtNOjosVQdW3rJKMWClFc8OCwV9aDTkh31qAsIEvn//9B+i2ayGogHu9RpOy8KgdoZFda+qoVjy05EXPNPgLAscqEfNzIcl+DByxxcgeQY3+iMwYjRZr9knvWRULPcsM4ZjTCG06nL8y9dn3AEyvoxpSx50luIMsk6Abf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739918; c=relaxed/simple;
	bh=SZeUFJKb4xC8GxKAIGOv5DJZFMYNIGZjz5aW7/UJl1Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eevLIhBkjVw1NVxQIhzbATYft96N+c1G+qQFn7GAd8EQQQRXiZRZN0MwJ2BeP2kl6irtHp7ePGJCgYQiXNQjCgWfVWFVgixgX6pbg/OrpYG3YZj5uI+kPMsZDogOQAscU9VMvhHoxxc1Y+7Fjdie6sxlxTbIQVgOYjtYg7bHCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v5cnXove; arc=none smtp.client-ip=91.218.175.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v5cnXove"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SZeUFJKb4xC8GxKAIGOv5DJZFMYNIGZjz5aW7/UJl1Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786739914; v=1; x=1787344714;
 b=v5cnXoveDfUjfsfpw98pK1e0+svKSKQRThuPFtrSE7zKSdyLsz5lakuMJJlP6jPax3HsnqgO
 t4x1X46iOeKYAB76cxNENvpsz5z6aUhnV3NefQvwXcDA3+JQYAh3Sgo3SOaJ2HYCPZe4YVrdznO
 cyWUToE020xQCrzX8qcFl8Nk=
X-Envelope-To: bpf@vger.kernel.org
Received: from smtpclient.apple (37.66.176.2)
	by mta10.migadu.com with ESMTPS id 46bab47cf99e8b25;
	Fri, 14 Aug 2026 20:38:34 +0000
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
In-Reply-To: <CAEf4Bzb-BifnOHQKeFNf2TX2WaF+-6yajVsWCNnn4Zgn545EOw@mail.gmail.com>
Date: Fri, 14 Aug 2026 22:38:23 +0200
Cc: sashiko-reviews@lists.linux.dev,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Message-Id: <AEACA6E0-6D4F-4E74-9188-00EA32703A47@linux.dev>
References: <CAEf4Bzb-BifnOHQKeFNf2TX2WaF+-6yajVsWCNnn4Zgn545EOw@mail.gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: iPad Mail (23G71)



> On Aug 14, 2026, at 10:19=E2=80=AFPM, Andrii Nakryiko <andrii.nakryiko@gma=
il.com> wrote:
>=20
> =EF=BB=BFOn Fri, Aug 14, 2026 at 1:15=E2=80=AFPM Roman Gushchin <roman.gus=
hchin@linux.dev> wrote:
>>=20
>>=20
>>>> On Aug 14, 2026, at 9:49=E2=80=AFPM, Andrii Nakryiko <andrii.nakryiko@g=
mail.com> wrote:
>>>=20
>>> =EF=BB=BFIs it really a good use of tokens for sashiko to review old pat=
ches
>>> that have either landed or were significantly changed since (and
>>> probably got a bunch of new revisions sent), or just plain forgotten
>>> by now?
>>>=20
>>> Did something regress recently? I'm not sure this has happened before
>>> until recently...
>>=20
>> Ooops, it=E2=80=99s probably a recent regression I had which blocked sash=
iko reviews for few hours,
>> so I had to restart some patch(set) semi-manually. Likely this one accide=
ntally got into this group.
>> Should be a one time off though.
>=20
> It's not just this patch, we've had quite a bunch of sashiko reviews
> for months-old patches in the last few days. Just wanted to raise
> awareness as this doesn't seem to be intentional.
>=20
> But ok, let's hope this is a one-time glitch :)

It should not happen anymore, they all should have been sent yesterday, what=
ever the number was.
If you see any new coming, please, let me know.

Thanks=20




>=20
>>=20
>> Thanks for reporting!
>>=20
>>=20
>>>=20
>>> -- Andrii
>>>=20
>>>> On Thu, Aug 13, 2026 at 4:59=E2=80=AFPM <sashiko-bot@kernel.org> wrote:=

>>>>=20
>>>> Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
>>>> - [High] Uninitialized memory read in `last_key` when `seq_show` overfl=
ows.
>>>> - [High] `rhashtable_walk_enter_from` resets iterator on deleted cursor=
 key, causing O(N^2) complexity and infinite loops.
>>>> - [Medium] Missing __GFP_NOWARN flag in user-controlled kmalloc for map=
->key_size can lead to OOM splats.
>>>> --
>>>>=20
>>>> --- Patch [8]: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator AP=
Is for resizable hashtab ---
>>>> commit 226ce1988038cf4876ff0a72b5ae8e5ebc263151
>>>> Author: Mykyta Yatsenko <yatsenko@meta.com>
>>>>=20
>>>> bpf: Implement iterator APIs for resizable hashtab
>>>>=20
>>>> Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
>>>> bpf_iter and bpftool map dump work with resizable hash maps.
>>>>=20
>>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>>> index 4611671bf8e74..5ca4d26e70178 100644
>>>>> --- a/kernel/bpf/hashtab.c
>>>>> +++ b/kernel/bpf/hashtab.c
>>>>=20
>>>> [ ... ]
>>>>=20
>>>>> @@ -3205,36 +3218,113 @@ struct bpf_iter_seq_rhash_map_info {
>>>>>     struct bpf_map *map;
>>>>>     struct bpf_rhtab *rhtab;
>>>>>     struct rhashtable_iter iter;
>>>>> -     u32 skip_elems;
>>>>> +     void *last_key;
>>>>>     bool iter_active;
>>>>> };
>>>>>=20
>>>>> static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos=
)
>>>>> {
>>>>> -     return NULL;
>>>>> +     struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
>>>>> +     struct rhtab_elem *elem;
>>>>> +     void *key =3D *pos > 0 ? info->last_key : NULL;
>>>>> +
>>>>> +     scoped_guard(rcu) {
>>>>> +             rhashtable_walk_enter_from(&info->rhtab->ht, &info->iter=
,
>>>>> +                                        key, info->rhtab->params);
>>>>=20
>>>> [Severity: High]
>>>> Will this silently restart iteration from bucket 0 if the cursor key is=
 deleted?
>>>>=20
>>>> rhashtable_walk_enter_from() looks up the provided cursor key to resume=

>>>> iteration. If the key is missing, it returns early and leaves the itera=
tor at
>>>> bucket 0 (iter->slot =3D 0).
>>>>=20
>>>> In __rhtab_map_lookup_and_delete_batch(), the batch operation deletes e=
lements
>>>> and returns the last deleted key to userspace. On the next batch syscal=
l, the
>>>> user passes this deleted key back as the cursor. Since the key no longe=
r
>>>> exists, rhashtable_walk_enter_from() resets the iterator to 0.
>>>>=20
>>>> The inner loop then executes while (total < max_count) holding rcu_read=
_lock(),
>>>> rescanning all previously emptied buckets from the beginning of the tab=
le.
>>>>=20
>>>> For lookup_batch and seq_file iterators, does this yield massive duplic=
ate
>>>> outputs to userspace and enormous RCU stall times?
>>>>=20
>>>>> +             rhashtable_walk_start(&info->iter);
>>>>> +     }
>>>>> +     info->iter_active =3D true;
>>>>> +
>>>>> +     elem =3D rhtab_iter_next(&info->iter);
>>>>> +     if (!elem)
>>>>> +             return NULL;
>>>>> +     /*
>>>>> +      * if *pos is not 0, previously iteration failed on this elem,
>>>>> +      * so we are restarting it. That's why no need to increment *pos=
.
>>>>> +      */
>>>>> +     if (*pos =3D=3D 0)
>>>>> +             ++*pos;
>>>>=20
>>>> [Severity: High]
>>>> Does this pass uninitialized memory as a hash key if seq_show() output
>>>> overflows?
>>>>=20
>>>> When reading a BPF iterator, seq_read_iter() calls bpf_rhash_map_seq_st=
art(),
>>>> which increments *pos from 0 to 1 and returns the first element.
>>>>=20
>>>> If the output of seq_show() for this element exceeds the initial seq_fi=
le
>>>> buffer, the buffer overflows. The sequence machinery reallocates a larg=
er
>>>> buffer and calls seq_start() again.
>>>>=20
>>>> Since *pos is now 1, the code executes key =3D info->last_key. However,=
 last_key
>>>> is only populated in seq_next(), which hasn't been called yet. Thus, la=
st_key
>>>> remains uninitialized from its kmalloc(..., GFP_USER) allocation.
>>>>=20
>>>>> +     return elem;
>>>>> }
>>>>=20
>>>> [ ... ]
>>>>=20
>>>>> static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_au=
x_info *aux)
>>>>> {
>>>>> +     struct bpf_iter_seq_rhash_map_info *info =3D priv_data;
>>>>> +     struct bpf_map *map =3D aux->map;
>>>>> +
>>>>> +     info->last_key =3D kmalloc(map->key_size, GFP_USER);
>>>>=20
>>>> [Severity: Medium]
>>>> Does this need __GFP_NOWARN?
>>>>=20
>>>> Since BPF hash map key sizes can be extremely large, requesting large
>>>> contiguous memory blocks without __GFP_NOWARN can fail loudly under mem=
ory
>>>> fragmentation and trigger high-order page allocation warnings.
>>>>=20
>>>>> +     if (!info->last_key)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     bpf_map_inc_with_uref(map);
>>>>> +     info->map =3D map;
>>>>> +     info->rhtab =3D container_of(map, struct bpf_rhtab, map);
>>>>> +     info->iter_active =3D false;
>>>>>     return 0;
>>>>> }
>>>>=20
>>>> --
>>>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408-rhash-=
v2-0-3b3675da1f6e@meta.com?part=3D8
>>>>=20
