Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EA2F5A34
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537331; cv=none; b=eYUZY1d1S6uTYp8LWAhzuhwEnyVCMXKRoBYYfm8xm8OF/ZA7ij1uH+iS9KZB3IDpTVoDJS0EIIJ8+o6Egay07QnwfAPOr7CsmuXgRBy+tjsmm2h24TvvtibNmEaEfG6T4OiRwzZOkwTtxrKewiSMiz/t+H69zRAQQlonE6KBfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537331; c=relaxed/simple;
	bh=7lS8Kh6zO/ven3XcFBSKJfmKy7d07oCYclXp9gnVptg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FK5XbbaeYieA4pP0i51DwXKTsHcmNAoOA2FDkREhtserXdMOFC/5GPGw2rxcYl1vQ7Iih4Tergnap8zpgHBx8n49sYH7xwrPlsZkyaSnLLOPPHWK4K3lxVIzySUDT7MwziNVI8xeSalWhR4LbwcB3pVv31wp9N5Bx3S+uiXkNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd0wB2o5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd0wB2o5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B598AC116C6;
	Thu, 26 Mar 2026 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774537331;
	bh=7lS8Kh6zO/ven3XcFBSKJfmKy7d07oCYclXp9gnVptg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Gd0wB2o57F+iaVRkauRoKw8dZ1MWxwSYhB/++T237vpGCQGtLLmdDgOB7B2bLtvsk
	 IyxejxRKWm5kjxbRO5ryl872JGVoysHJh51xASDsxXW9J5m/pSTAg8vitA/6McksDc
	 KzNtZ/3f71soAP6v+TWC1dUDIEzUbYOVcIzoEScN6lIk7ObdL5/0YA9IGFmomKJMs5
	 oxtd607P3p1MX/xPyZ1f6VJy3EhTbV5q4p8C7PHBNAMgImjt7VOnsTTWAlSo+INdSz
	 HnbHv0ckmBTp5nUaaHNQ+dwudiT7hl86dorC42ym7kt0J9caZu5TfWPdam6YplGThy
	 tD5qtPzpXUj5Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Aaron Esau <aaron1esau@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update
 path
In-Reply-To: <m2se9mg16x.fsf@kernel.org>
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org>
Date: Thu, 26 Mar 2026 15:02:06 +0000
Message-ID: <m2o6ka7hxt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> Aaron Esau <aaron1esau@gmail.com> writes:
>
>> Reported-by: Aaron Esau <aaron1esau@gmail.com>
>>
>> htab_map_update_elem() has a use-after-free when BPF_F_LOCK is used
>> for in-place updates.
>>
>> The BPF_F_LOCK path calls lookup_nulls_elem_raw() without holding the
>> bucket lock, then dereferences the element via copy_map_value_locked().
>> A concurrent htab_map_delete_elem() can delete and free the element
>> between these steps.
>>
>> free_htab_elem() uses bpf_mem_cache_free(), which immediately returns
>> the object to the per-CPU free list (not RCU-deferred). The memory may
>> be reallocated before copy_map_value_locked() executes, leading to
>> writes into a different element.
>>
>> When lookup succeeds (l_old !=3D NULL), the in-place update path returns
>> early, so the =E2=80=9Cfull lookup under lock=E2=80=9D path is not taken.
>>
>> Race:
>>
>>   CPU 0: htab_map_update_elem (BPF_F_LOCK)
>>          lookup_nulls_elem_raw() =E2=86=92 E (no bucket lock)
>>          ...
>>   CPU 1: htab_map_delete_elem()
>>          htab_lock_bucket =E2=86=92 hlist_nulls_del_rcu =E2=86=92 htab_u=
nlock_bucket
>>          free_htab_elem =E2=86=92 bpf_mem_cache_free (immediate free)
>>   CPU 1: htab_map_update_elem (new key)
>>          alloc_htab_elem =E2=86=92 reuses E
>>   CPU 0: copy_map_value_locked(E, ...) =E2=86=92 writes into reused obje=
ct
>>
>> Reproduction:
>>
>>   1. Create BPF_MAP_TYPE_HASH with a value containing bpf_spin_lock
>>      (max_entries=3D64, 7 u64 fields + lock).
>>   2. Threads A: BPF_MAP_UPDATE_ELEM with BPF_F_LOCK (pattern 0xAAAA...)
>>   3. Threads B: DELETE + UPDATE (pattern 0xBBBB...) on same keys
>>   4. Threads C: same as A (pattern 0xCCCC...)
>>   5. Verifier threads: LOOKUP loop, detect mixed-pattern values
>>   6. Run 60s on >=3D4 CPUs
>>
>> Attached a POC. On 6.19.9 (4 vCPU QEMU, CONFIG_PREEMPT=3Dy),
>> I observed ~645 torn values in 2.5M checks (~0.026%).
>>
>> Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")
>
> Although this is a real issue, your reproducer is not accurate, it will
> see torn writes even without the UAF issue, because the verifier thread

After reading the code and discussing with Kumar, this is expected
behaviour. BPF_F_LOCK performs a lockless lookup and takes only the
element's embedded spin_lock for in-place value updates. It does not
synchronize against concurrent deletes, preallocated hash maps have had
the same semantics since BPF_F_LOCK was introduced. Programs that need
both parallel deletes and updates must handle that coordination
themselves.

Thanks,
Puranjay
