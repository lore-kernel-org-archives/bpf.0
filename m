Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7681465B4
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058876; cv=none; b=E+ENC8oYJs1t9TO1b3ur5BljjFZXr4HTmj/9qAbOM7RDEzQgkplcjNLHYchpP+CHTwALhASHr98wsUUCRC8OF2PA55IlCQsy4wDjdW8eIpwrlLYi5OiOfibNzJBHaegi+ggFR9rJXEPFDFmv5Kg66UHXVFQ1UTEBkaCbftW+yGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058876; c=relaxed/simple;
	bh=k0Ux9tJ/CJmzpRawTFB7jjdxHa6GhgOHMEVMEuMUY0Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cphIrPQwY+AFd1X1IwSLU4geZuufELZdz3lQK+t5PGDrWnfl7cjaKVHRemFyzmlxvYIxnwXLVXPzw4LQzjLGgeaK1pXDwg2AKRxNWJkS6bh2YqrFETavHNXV9yvNeoqowTVCLxBz8a7/51iCf9o3BMYOtT8ikjUlMaBYcwu7b/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcX87M+J; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcX87M+J"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6cfdc92bfso2306782a34.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781058875; x=1781663675; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a1EyuZX0UgpOqWTMwxkb3RUUDojRXF8E/bEe1SSxmQ=;
        b=HcX87M+JWA94fYpZS0kmGMLYmB8irBJ6W3UONRPxQWJcyMUQY3aD7cDUQnkuIAjGIr
         QjyJ3k1LrhCTHGY7FjcmrVTN1QSmhlawpAzyPhW54VzeeKsQY7hqWrluibE6/FnIFmry
         Uy6meFmj3GSJDmdNWM7EnlDO0tsszQJt6l00sbkmm9XGhp3siVA4sUnWuQkt1XzXyAtd
         tejc+ZjYE/xqwGmV9RQp8JZdVD/VcPoc2cUW/T3+4675hx3GkylZOHdPXDsP3S1DTwsn
         S4pZej2nADaDjS8rH3pISFbLurnx7s7ZUeW/Ew0Y6hiQEJvaspG/hAh4EKm14GEMBdLp
         2VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781058875; x=1781663675;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5a1EyuZX0UgpOqWTMwxkb3RUUDojRXF8E/bEe1SSxmQ=;
        b=JBSVml/dZ+GyCcGnvoe1ZeUX3wMo0OuHbISubjfcHbn/czKrSLxsJRW0IMlVQFYmQS
         1ZGvkyOfL0EBdBa8YPnpzQd1SMIaczvAH0+t6AISkZ6WaDrSk20+EBB8KzXNlaDcV9cS
         Q4v5Mkmil8FwffZT/iKZr86TNNDTCxIIIS4uiSqnVQdx6TE0vef6wKDypJpib3L6pCBd
         V0qwECK8mOsOr9ncJcCIeHspkNz7l0knAHdxoA5dbxz5SEZ6a/CSGRgkpPmNeMIv0H1a
         j30F6RE6JfjbuCPVoTaOIu3uGW1elMWhCAOCub8I2h+7/bRm/iAJ+k1ssSlT8KjvhwIg
         nvqA==
X-Forwarded-Encrypted: i=1; AFNElJ8UtyoHiLbr46vkr4z5N6bpn8cmMTYQh6UzgYKpT4zi3RPKYCcRgfONofkKrGujm3a5zrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1W0X597eWRZhnHwQMJo3JN2+i6skGrzJwRKIm4nres+03GBq
	xfKvipN2fhHkaBEdy9wuQzRb3a77anRI+jHkL6rgSmzvT3aI0m3fyhk7
X-Gm-Gg: Acq92OGhEwDoUb/3XL7D/HAf1xfkhvar9h1LtxLKBzKg8k1RpSL00UOI4e3Tt1Q7M6t
	2j2R0hBQlotS5COP5SxRJlSrYSgs0czfU2tNJmu6o7Zai5vknS2jv4jkwk7TVw3WeYRlLTLxjYH
	Z7NvBUIjHpxnHKvnsNYnhFixQTGAHx4PZkwo6KUDnJZOGPVUdiSzE23zPhXldBuxjLkVoZnhr0F
	HdmCCXdZB/w8SPd1RghKpadOXI9Fa/n3a3fK7WZEOoKTbibyONfcldrRSj+XBlEuJ8OQa6PMrXs
	MufhSDbBZ/mev2a+AjskY0wcfEYG/xTsS/Dmyaf2uzimYGJQG9By8rV7X6gitJyh0N1KOv2+Qk1
	dDCbh5sfQagPM9x2m9zn8AdHvKuQmLTBVyBdKkN/TRn/QdsON70kyxc3zjeIFXZbU5PmtP1DMOa
	MCt1iYU5yI+kRGzZE8bYx2PwqktvVOLrNyh2rLWFdNHB5xRcZnKOYfsYeVFFCdXPks+lvcKIuHG
	kavpX4qUf5y3gZZMyQxXhBB183O
X-Received: by 2002:a05:6820:180b:b0:69e:2cb4:2ed8 with SMTP id 006d021491bc7-69e68b95539mr11104567eaf.26.1781058874493;
        Tue, 09 Jun 2026 19:34:34 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm12197566eaf.9.2026.06.09.19.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 19:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 19:34:30 -0700
Message-Id: <DJ50ODKTFMP4.767A4DLXUS4O@gmail.com>
To: "Hou Tao" <houtao@huaweicloud.com>, "Vlad Poenaru"
 <vlad.wing@gmail.com>, <bpf@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf, lpm_trie: Allow sleepable programs to
 use LPM trie maps directly
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260609135558.193287-1-vlad.wing@gmail.com>
 <20260609135558.193287-3-vlad.wing@gmail.com>
 <ca38cbe4-dbc0-dc28-d7c5-07c0566348fc@huaweicloud.com>
In-Reply-To: <ca38cbe4-dbc0-dc28-d7c5-07c0566348fc@huaweicloud.com>

On Tue Jun 9, 2026 at 6:53 PM PDT, Hou Tao wrote:
> Hi,
>
> On 6/9/2026 9:55 PM, Vlad Poenaru wrote:
>> The previous change relaxed the rcu_dereference annotations in
>> lpm_trie.c so the trie walks no longer trip lockdep when reached from a
>> sleepable BPF program holding only rcu_read_lock_trace().  By itself
>> that only helps tries reached as the inner map of a map-of-maps, or
>> from the classic-RCU syscall path: a sleepable program that references
>> an LPM trie directly is still rejected at load time by
>> check_map_prog_compatibility(), whose sleepable whitelist omits
>> BPF_MAP_TYPE_LPM_TRIE:
>>
>>   Sleepable programs can only use array, hash, ringbuf and local storage=
 maps
>>
>> LPM trie nodes are allocated from a bpf_mem_alloc (trie->ma) and freed
>> with bpf_mem_cache_free_rcu(), which chains a regular RCU grace period
>> into a Tasks Trace grace period before the node -- and the value
>> embedded in it that trie_lookup_elem() returns to the program -- is
>> released.  That is the same reclaim discipline BPF_MAP_TYPE_HASH relies
>> on for sleepable access, so a value handed to a sleepable reader cannot
>> be freed while the program is still running under rcu_read_lock_trace().
>> The writer paths take trie->lock across the walk and never relied on the
>> RCU read-side lock to keep nodes alive.
>
> For trie_lookup_elem(), I think it is not safe to enable the usage in
> the sleep-able program as the patch does and it may return unexpected
> value. The main reason is that rcu_read_lock_trace() can not guarantee
> the current node which is being lookup-ed up will not reused by other
> update procedure concurrently. However rcu_read_lock() has such
> guarantee, because bpf_mem_cache_free_rcu() makes it be reusable only
> after one RCU grace. For the hash-table case, I think it has the similar
> problem through it has already used some trickle (hlist_nulls_node
> variants) to mitigate it.

You're correct. I remember that discussion.
Yet people already use lpm via map-in-map bug/workaround.
So I applied this set to make lpm-in-sleepable usage official
and force us to do a proper fix.

Also both AI bots didn't spot an issue, so the bug won't be
discovered immediately and we won't see a flurry of
"security" reports with slop "fixes". AI isn't that smart yet.
