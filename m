Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B332737F2
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627767; cv=none; b=oEhKOiNNNN/MsbL+ZkdsJdYcQfnugWzmESyNtGihTiWcsMgfCorNyr51pZgGGS1N0lzMwgdOG+52sGWQIHylHW0rxlyrU8WLzwkNpXcJ3sbUX+3op4ynfxEbFKwGHpx4XoIVXC/uQwDdzOzWxMwPlyxLzQarOR99crv6p1yEmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627767; c=relaxed/simple;
	bh=xuLintyR4tYmiyQmUlHF5BJe7KKXm7X2Jj8pszJ0JSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0CpRzDTkrBRfLxWzRyysoaTPPP+okmIbNPBLC/iCr5oQ4DpCX5yqvxZdZsJ1lL7vIL5/i476Dss2/W5KzYkMswd7BoEjx+ftChrYGjyF24dDceusshNx7XBlPJnrw9H/Sh7MHzHiIuMHi0urCHifNut3nPF/rv5pOIhv8trOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTyePO3e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTyePO3e"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fb439299so21773095e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774627765; x=1775232565; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuLintyR4tYmiyQmUlHF5BJe7KKXm7X2Jj8pszJ0JSE=;
        b=gTyePO3ew8rj7l0ZzIwPaa6w8RBmn+J46ahgYEJ/6eouLht8SW4/LO4srcNxt9BRY8
         3xFixG0fpPyHO9RfBZ4s2QBu4ZX1r9b2dHT4iapkh/6QaJFWbsG10t7R/PSvgpbpF/Ie
         IR/w46Fwe6he/aRlv2GG8L3KubMvirrjtVKzMseo0y6tb4dVTTBjYb3JrfdHyffPuDV+
         3seqX0V3V2qGCkp7Q/fgdBpfc2ty4haGAHBC5htzSwsYjoNn3T7vj6V3o2K47k02ifEw
         anS5DVqxW1iCnMMEcTQeZ/zmsxgDwrz7FQkA4pmETNc81Mjj+Ck927DT5JGRlPkklMAq
         qk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627765; x=1775232565;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuLintyR4tYmiyQmUlHF5BJe7KKXm7X2Jj8pszJ0JSE=;
        b=hzrWt09dEY8ZAvo+03JTRV84EaX0FWqMOw8YmrNxzidytSqZwRQAsW/m25q+p5GXBO
         TWzYb6VawaA/gOaV7LibTaZoJjFScKne0skVi/OLH8BMPBkf9bnYmgSr9qJ0xO2PMblx
         9RVoS3yhMPJv44abUQTMCP/SZJhvh3LAts4xp2m8QMN/NKvL98TMBajgbsrkHeC1oetG
         1CSvh2+DEc4bp9EUXEm5gu0dA0GjP/LIyNrPvindZlUHDCaCe29z37Dxpl0e+JR6HS0n
         OPevM5CVSAPCrC23BjEvt7d1lyXOV8nG84sXU3Md+wVkwq0pWVlrwFnCNWgzkIFW1mZ4
         pk4g==
X-Forwarded-Encrypted: i=1; AJvYcCUhJtfuYxjfaivXCXMe+TYLs5N9PlyArpRdJu10MXQz9uwdVLFDUFbjGhrONgBcKUby6CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0G6s21g7L+oKhlis/LslD6cbhzGfdE7CbEm3PEitDVtZZ6tt
	G0tghHhSXTYNfovgQ5PXGs/Hig6hhg+MJnHhj2A/eRVEIR9qjA9h6i2D
X-Gm-Gg: ATEYQzwlox2wX56TwRkyR512yaQAaBbJBeEJzhMi1m4O5rg9cltpA3DIDopg/aUIUDA
	JPnzXxxZoW3JhUD2OPkuQ1Jq6Zj6RGp6d6BtOwZKCQBq5z5c36+ncddCezQk3tUU2IjK76fnSx9
	aeA0vfX8pMNIUAHrnPxmVDYoFlpubnWw1Ec+aDGNtZUSzCo2/RICrAm1mDq1NhHHQzexwDWTxrC
	IftVsBoNqiME9sD3bhTCFyrgTBgHWhNtsqBSzoQ/q1BkbsLE/wJEj/LmCVZMp5cT39p+rhzzpLj
	bVAVczpxi9lbQU7rjBNc6b+YkSGAvR75IuRJRgVzMtZXLgrsWoaIqmTdCWQBwan4qf/ZxkPTHuz
	WbIdfxFDcG6mbOn6l6NBa3IzV91NXCcvCxvN8aDpmhnJQUtHWLI/CwL00S+ae1QxaDCbGZ7HjTp
	D8ZBPrSrLPvq8Z+nQ582uOOl4KR+RxbyuGXA==
X-Received: by 2002:a05:600c:6091:b0:487:13d:4e77 with SMTP id 5b1f17b1804b1-487280a9d07mr50802605e9.27.1774627764722;
        Fri, 27 Mar 2026 09:09:24 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722cb0d83sm94131245e9.13.2026.03.27.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:09:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Aaron Esau
 <aaron1esau@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update
 path
In-Reply-To: <CAP01T7712ZmLy2YaViHtZ=2RqtF4i_F49Vyb_UC8NgQcYX8j5g@mail.gmail.com>
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org> <87qzp6ipc7.fsf@gmail.com>
 <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
 <87o6kaioju.fsf@gmail.com> <87ldfeiodk.fsf@gmail.com>
 <CANk7y0iXJ1sTn5eMrUosvbwnLrSwGtxyirgTpFwdDVWN0tHb5Q@mail.gmail.com>
 <CADucPGTNHas6gJu=ybWyZ5X2s6bOO_ar2eg9PFv6TRv-=NA-Zw@mail.gmail.com>
 <CAP01T7712ZmLy2YaViHtZ=2RqtF4i_F49Vyb_UC8NgQcYX8j5g@mail.gmail.com>
Date: Fri, 27 Mar 2026 16:09:23 +0000
Message-ID: <87a4vti79o.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Fri, 27 Mar 2026 at 03:54, Aaron Esau <aaron1esau@gmail.com> wrote:
>>
>> Puranjay Mohan <puranjay12@gmail.com> writes:
>>
>> > Yes, if all the users have BPF_F_LOCK then it will work because the
>> > re-used element will have the same lock and everything is serialized.
>> > But this reproducer is trying to show that the elements are being
>> > re-used, which they are.
>>
>> Updated reproducer attached. All operations now use BPF_F_LOCK (updates,
>> re-add after delete, and lookups), so value access is serialized via the
>> element's embedded spin_lock. The value size is ~4000 bytes. Torn writes
>> are still observed (3 in 2.7M).
>>
>> With full spin_lock coverage, the only remaining unlocked write path is
>> alloc_htab_elem() -> copy_map_value(), which copies into a newly
>> allocated element prior to insertion. For this to race with a locked
>> reader or writer, the reader must be dereferencing a stale pointer to
>> memory that has been freed and reallocated -- a use-after-free.
>>
>> The root cause is bpf_mem_cache_free() in htab_elem_free(), which
>> immediately returns memory to the per-CPU freelist rather than deferring
>> via RCU. This allows reuse while the syscall path is still within an RCU
>> read-side critical section. Preallocated maps do not have this problem
>> because freed elements remain within a pool of valid htab_elems.
>>
>> Switching to bpf_mem_cache_free_rcu(), as Puranjay showed earlier in this
>> thread, eliminates the corruption.
>
> As I said, the reuse is intended behavior. We won't be switching to
> bpf_mem_cache_free_rcu().
> This is mostly for performance reasons, in case you're perplexed as to why.
> That said, we could do copy_map_value_locked() if map_flags &
> BPF_F_LOCK to fix this particular case.
> Such that if the value is being reused we will still have serialization.
I think we should do copy_map_value_locked() on the reuse path.
