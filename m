Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860843DA4C
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588038; cv=none; b=UlIPxvRYgS35kRKJTMR8GCu7b2/qnCkqa2MQTabFaefPAOeeB7kWHBaI9rUxxQ9s9zrGm1FaCt+F6wnsCtiKfMem5mng6eSKhUE09CXrvq+iGICHTppbhKBYJdLX6fqoChcxA1/NtYfltjgGXTH/113FLGQM3l+Ot0J8IeEcuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588038; c=relaxed/simple;
	bh=moWMKDFo1ejO1Y+SvTSn1ZBtiqsMttxF5PTsWQBALgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxpOKLctuayMcsIPHxAIhmF+vnB6a38btJNOiZjGRCFv+ukYEA9JmyB6OXluGxMnHy+Uiaki1zM/WglSvqQDbJCBfbuYW2JR4Jvw299lxpzZ+SJCDo3vSF+rWBX65HwIMkc1Xh+VP5/v+03BtxnHO/fsGYKaiG52z2vDzSEM730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=abSqDNyw; arc=none smtp.client-ip=95.215.58.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="abSqDNyw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=moWMKDFo1ejO1Y+SvTSn1ZBtiqsMttxF5PTsWQBALgw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787588033; v=1; x=1788192833;
 b=abSqDNyw/yKFT4k9pLTjpemjs+ZnH5r8henQ2NmyzQknZ14BHwMXRUfqVQMmcLNGLFEE7/uY
 pTcnnG5iAw+jRUjqYzg+K/ucUb7aDuxNY9j27CPnV6GrV9Dy10m2Kd1Os6trGrY3qiTzqCcDjon
 N2wOgPrDYlkyv60NIzhbaSdg=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.50.204] (146.199.86.12)
	by smtp.migadu.com with ESMTPS id eea20e0d7aa22208;
	Mon, 24 Aug 2026 16:13:52 +0000
X-Mizu-Trace-ID: eea20e0d7aa22208
X-Migadu-Flow: FLOW_OUT
Message-ID: <f81160ac-0c7c-43f2-985f-43ab54a52358@linux.dev>
Date: Mon, 24 Aug 2026 17:13:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/57] mm/collapse: freeze the sources behind
 migration entries
To: Johannes Weiner <hannes@cmpxchg.org>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, nico.pache@linux.dev,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
 hughd@google.com, liam@infradead.org, mhocko@suse.com, rppt@kernel.org,
 ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com,
 agordeev@linux.ibm.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, jannh@google.com, willy@infradead.org,
 pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260816224609.308019-17-kirill@shutemov.name>
 <20260824131224.73344-1-lance.yang@linux.dev> <aoxQnuEacGpzp2I7@thinkstation>
 <20260824154921.GA863036@cmpxchg.org>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260824154921.GA863036@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/08/2026 16:49, Johannes Weiner wrote:
> On Mon, Aug 24, 2026 at 03:13:10PM +0100, Kiryl Shutsemau wrote:
>> On Mon, Aug 24, 2026 at 09:12:24PM +0800, Lance Yang wrote:
>>>
>>> On Sun, Aug 16, 2026 at 11:45:28PM +0100, Kiryl Shutsemau wrote:
>>>> +		if (!folio_ref_freeze(folio,
>>>> +				      folio_expected_ref_count(folio) + 1)) {
>>>> +			result = SCAN_PAGE_COUNT;
>>>> +			goto unfreeze;
>>>> +		}
>>>> +		nr_frozen = nr_saved;
>>>
>>> Just one thing I was wondering about ... can deferred_split_isolate()
>>> remove a source folio from deferred_split_lru while its refcount is
>>> frozen by collapse_freeze_candidate()?
>>>
>>> Assume an earlier span belongs to an anonymous large folio on the
>>> deferred split queue, then a later span fails folio_trylock().
>>> collapse_freeze_candidate() continues after freezing each source folio
>>> and calls collapse_unfreeze_candidate() on a later failure:
>>>
>>> static noinline enum scan_result collapse_freeze_candidate(struct mm_struct *mm,
>>> 		struct collapse_candidate *cand, pte_t *pte)
>>> {
>>> ...
>>> 	for (i = 0, addr = cand->addr; i < nr_pages;) {
>>> ...
>>> 		if (!folio_trylock(folio)) {
>>> 			folio_put(folio);
>>> 			result = SCAN_PAGE_LOCK;
>>> 			goto unfreeze;
>>> 		}
>>> ...
>>> 		nr_saved = i + nr;
>>>
>>> 		if (!folio_ref_freeze(folio,
>>> 				      folio_expected_ref_count(folio) + 1)) {
>>> 			result = SCAN_PAGE_COUNT;
>>> 			goto unfreeze;
>>> 		}
>>> 		nr_frozen = nr_saved;
>>>
>>> 		i += nr;
>>> 		addr += nr * PAGE_SIZE;
>>> 	}
>>>
>>> ...
>>> unfreeze:
>>> 	collapse_unfreeze_candidate(mm, cand, pte, nr_saved, nr_frozen);
>>> 	return result;
>>> }
>>>
>>> folio_ref_freeze() takes the source folio's refcount to zero:
>>>
>>> static inline int folio_ref_freeze(struct folio *folio, int count)
>>> {
>>> 	return page_ref_freeze(&folio->page, count);
>>> }
>>>
>>> static inline int page_ref_freeze(struct page *page, int count)
>>> {
>>> 	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
>>>
>>> ...
>>> 	return ret;
>>> }
>>>
>>> While collapse_freeze_candidate() still holds the source folio lock,
>>> deferred_split_scan() can call deferred_split_isolate():
>>>
>>> static unsigned long deferred_split_scan(struct shrinker *shrink,
>>> 		struct shrink_control *sc)
>>> {
>>> 	LIST_HEAD(dispose);
>>> 	struct folio *folio, *next;
>>> 	int split = 0;
>>> 	unsigned long isolated;
>>>
>>> 	isolated = list_lru_shrink_walk_irq(&deferred_split_lru, sc,
>>> 					    deferred_split_isolate, &dispose);
>>> }
>>>
>>> static enum lru_status deferred_split_isolate(struct list_head *item,
>>> 					      struct list_lru_one *lru,
>>> 					      void *cb_arg)
>>> {
>>> 	struct folio *folio = container_of(item, struct folio, _deferred_list);
>>> 	struct list_head *freeable = cb_arg;
>>>
>>> 	if (folio_try_get(folio)) {
>>> 		list_lru_isolate_move(lru, item, freeable);
>>> 		return LRU_REMOVED;
>>> 	}
>>>
>>> 	/*
>>> 	 * We lost race with folio_put(). Read folio state before the
>>> 	 * isolate: folio_unqueue_deferred_split() checks list_empty()
>>> 	 * locklessly, so once removed the folio can be freed any time.
>>> 	 */
>>> 	if (folio_test_partially_mapped(folio)) {
>>> 		folio_clear_partially_mapped(folio);
>>> 		mod_mthp_stat(folio_order(folio),
>>> 			      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>> 	}
>>> 	list_lru_isolate(lru, item);
>>> 	return LRU_REMOVED;
>>> }
>>>
>>> And folio_try_get() fails because the source folio has a frozen refcount.
>>> deferred_split_isolate() treats the failure as a race with folio_put(),
>>> clears PG_partially_mapped and its MTHP_STAT_NR_ANON_PARTIALLY_MAPPED
>>> accounting when set, then removes the folio from deferred_split_lru ...
>>
>> Hm. So, the premise in deferred_split_isolate() is false:
>> !folio_try_get() doesn't mean lost race with folio_put().
> 
> I suppose you mean, not exclusively. But it can also mean that. And
> then the question is, who cleans up the partially_mapped state.
> 
>> I think deferred_split_isolate() should do something like:
>>
>>       if (!folio_try_get(folio))
>>               return LRU_SKIP;
>>
>>       list_lru_isolate_move(lru, item, freeable);
>>       return LRU_REMOVED;
>>
>> Johannes, do I miss something?
> 
> Ah. The idea being: leave the item on the LRU when there is a race
> with the refcount going zero; and then it's up to that other side to
> deal with/clean up the partially_mapped state as appropriate. Thus:
> 
> folio_put()
>   __folio_put()
>     folio_unqueue_deferred_split()
>       if __list_lru_del():
>         // clear partially_mapped state & stats
> 
> will always succeed, even if it races with the shrinker. And you are
> also guaranteed on the collapse side that the state won't vanish from
> underneath you.
> 
> I think that should work. Usama?


Kiryl's suggestion makes sense. I think there is a bug here. If we dont
get the reference, whoever owns the reference should decide how partially_mapped
is treated for that folio:

- If its the last folio_put(), it will clear partially_mapped and cleanup
after itself.
- If its folio_ref_freeze(), clearing partially_mapped is wrong (which we
are currently doing in deferred_split_isolate)

