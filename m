Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294143C73F6
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179273; cv=none; b=Iq8k1UarqVml6jg/zgwnoHCDi+nujuZO8WHAYD5e6syVO7iIph9YnR+atueDS60tAtnLkxDgasDl+0Llp36fmZVSllte7CPmzsdJlRwyBZJnV4ZkTmdF2zWlVicsytH2NsJgHN2iWx2seINbmFqI+o8wnH90AJj25zpdShHJ46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179273; c=relaxed/simple;
	bh=OaY7FcEUo4cP/Mb6LSNCYDsl6Pp/iSGtB/KaF62pbMs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mDtMRJ5GcZkfZDVNkFKUeD1ZkQpnc/G6Gsb4rasP77KaxWNMQbvKuZCcF1G0yC1/wtdSpIhsctyjtJVsuhNKJHX3R6oyWBIlQguqZfWRhStejGd03jlVqoNNcjNVPI26SGhLzFWPlx/P0TS5v0xuLaPNyKi1upmSULR/3jfU64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=lkLHfjCZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="lkLHfjCZ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9995ce866so1494915ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792179269; x=1792784069; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hDImHyjN07xmEBQoMW3gOEA6iX6zD1BhOQAEngTln10=;
        b=lkLHfjCZXKbDbRNt9DI3QSrkl1FTMnb+K+HwrkD3HJKU57fcHel3TRmMOtelWGIrOw
         2lOgb6zF9doym4V3GJw59v/DrMQIohlsTTgToAWYk9QBzu+hbALsCRmDwgQnF/vHhKT+
         YbkbTuzq3P6aFNDAT6nhn1MLiJ8RxXw8YSkdjW9BNU1IB40mcplMENl8rzdvTAxGzbb5
         PEG8sju1vc9UBPcm8iTbJDauYmyjxiHq9ItieqG3vvX3sEuTqN8gr613JmbOXLofXi1b
         RdQsQkZs/R37W4dh0UAGCyfcKQrGQDV16UwJ/J2QdwqQGigS0Us1n6muoKffvUpzPcHM
         XKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179269; x=1792784069;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDImHyjN07xmEBQoMW3gOEA6iX6zD1BhOQAEngTln10=;
        b=lc4k0R3iRj7aVxiAkn8n0nwOm6tL7U1DAfPTzK7VcorFZFTxfQjFjoUAr7BpcfRXFa
         VSDBs+nsvt3DtOqWj6EXGitTPX7HLIQ5ByThHMXIaimo60IxfWLFZuyUIcSRGiYI5UwZ
         okUIeAOlchZkLDO/kEtnUXzd9+xPNkCOgfzkZJvh+zFcwxM6Eh5Znn86Uvxl7S0W3AxB
         OJLy6DzWnKjccxB1ZlzfjP/xqcOolaTD3SU34IkcLFGXEWIiWdJbgu4ppuoL70emktiT
         lJByQYilRuDYOTeOF+zzlUhpAC8m74eWUS359pP27r4APU66xQbcxGjskRYCLcVJ5hc0
         VWww==
X-Forwarded-Encrypted: i=1; AKwUvBwzoUKiW7wziIYh02brFa6qehW8mQI0RiCQ79aVD44ObH2cLek7GB5AJorApyIfzejHKbo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuTD3lc5bf8SVRA+AZTL5xZGlrJmbs5/dpm7Y3g6Z70u6uLrrB
	kRE0RlQ8Lm1Mp0nn2QqB0Skp+c4qhlWhQ8PAizpTFEJarCcTuVwNr9QvIFIzXwUgc9LlLOqbm5Z
	H1QT/VAWmvQ==
X-Gm-Gg: AYBFou0bstvYL/FB/u1oM+6ReZHBKuuM59jgf+Fez8a3kT7O5laSgOBOfW0fkaRkiF/
	bgRxikmys1KK3Nf/qU26LC5JaWDMRJlCYZflHsyELmx9fP1uaE2HB8JAKtLu+EnDbxw56apmrFQ
	r6jb730GeVh8aVCd6hvmqIJvBBYg/vcEb1SVBo29eVex9CuzMhqGHd1Zx6D4t9WfRyplRKBl+jf
	Qar0i23dtXmT1G8AgeZ8v/b9qUl1lJdm9vNWXbxLsyJjFIX25jDbjqTAFXNlaXlC1KVrn+Ziwge
	FzgMv3JNlFUwoS8yeD+Pw60fvHQ/GqfM20XxSujcN5NM5JCIeXunjn18tmgRBU5N90fBiIHjkDs
	gMo7yQYeH/dfiCrYx/XlVj+JFE7sBEqiyK6egNpDj1eiCL6BAlTTQ04ZvlxbCaEVC/YLmU0sUKk
	WU6eo9EJHE1OIEheqCjlWRCcoqkuxBxqSexIs+hjPe8ebJWCBTMdrCJUN41u9AuW4yiCdo+kpn1
	mle+688YPSOBqyKQpWxmq24U/E=
X-Received: by 2002:a17:903:244b:b0:2e9:322e:1f94 with SMTP id d9443c01a7336-2e9a68e6c56mr8270715ad.20.1792179269023;
        Fri, 16 Oct 2026 12:34:29 -0700 (PDT)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e83498csm15122285ad.35.2026.10.16.12.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 12:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 19:34:27 +0000
Message-Id: <DM6IJ1O60GH7.2JQCLY20XU62Q@etsalapatis.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 7/8] bpf: Synchronize arena page faults with
 page freeing
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261014233442.8392-1-emil@etsalapatis.com>
 <20261014233442.8392-8-emil@etsalapatis.com>
 <DM5W5YU16482.21ASVI86YUGIR@gmail.com>
In-Reply-To: <DM5W5YU16482.21ASVI86YUGIR@gmail.com>

On Fri Oct 16, 2026 at 2:02 AM UTC, Alexei Starovoitov wrote:
> On Wed, Oct 14, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> Prevent the arena VM fault handler from running in parallel with arena f=
ree
>> operations. This is similar to the policy for file-backed mappings. Use =
a
>> per-arena reference counter to exclude faults from synchronous and defer=
red
>> page teardown, and vice versa. Faults and frees can each run concurrentl=
y
>> with operations of the same type.
>
> In v3 I suggested to lock the page, recheck vmalloc_to_page() and
> return VM_FAULT_LOCKED. The recheck is missing and opref is there
> instead of it.
> The free path clears the pte under arena->spinlock and then does
> lock_page(); unlock_page();
> If arena_vm_fault() locked the page first the free waits for
> finish_fault() and zap_pages() removes that pte.
> If the free was first arena_vm_fault() sees different vmalloc_to_page()
> under the page lock. Unlock, put and start over.
> The fault holds a page ref, so the same page cannot come back.
> The free path holds nothing when it gets to zap_pages(), so
> mmap_read_lock() there is fine and patch 1 is not needed.

Makes sense to remove the opref (and a lot of the rest of the machinery)
since it's causing problems. There's caveats with the recommended locking,
while I think it'll be easier to just discuss it in the next version
more concretely but it's still worth pointing out some the caveats here.
If any of the below is wrong we can continue discussing on v5 that is
likely to be closer to where we want this patchset to look like.

1) The free path holds nothing, but the program calling it can. A
sleepable iter/task_vma program runs with the iterated task's mmap_lock
held for read, and so does a bpf_find_vma() callback in a sleepable
program. If either frees pages that this mm maps, zap_pages() takes the
same mmap_lock again. A writer that queues in between waits for the
first read lock, and the second one ends up waiting for the writer.
zap_pages() has to use a trylock.

With a trylock, a free can fail after it has cleared the ptes. It then
has to defer the zap, and the range stays allocated without ptes until
the worker is done. In your 0/8 reply you suggested returning the
scratch_page error for a page that is being freed, so every user fault
on the range gets SIGBUS for that whole time. If allocating the deferred
span fails, the pages cannot be freed, because user ptes may still map
them, and the page table walk in arena_map_free() no longer finds them.

The SIGBUS itself is a problem too. A fault on a page that is being
freed has never raised a signal. User space cannot tell that a free is
in progress, and freeing and reallocating is normal arena use.

I have a next version that takes the trylocks before it touches the
range, and defers before clearing any pte if one fails.

2) As you mentioned the range tree already shows when a page is reserved
or being freed, but does not distinguish between the two. Only a reserved
page should fail. A fault could find out by waiting for arena->lock,
which a free holds while retiring, and checking again. But it would have
to decide with the fault lock held, so every fault on a reserved page would
sleep through any free in progress with mmap_lock held.

The next version avoids this by recording the range it tears down as a page
offset + count. It sets the record under arena->spinlock in the same
section where it calls range_tree_clear() and clears the ptes, and drops
it when it calls range_tree_set(). Frees are serialized on arena->lock,
so there is at most one such range, and recording it allocates nothing.

A fault inside that range waits for the free to finish, and can drop the
fault lock first. Any other fault on an allocated range without a page
is on a reserved range and gets the scratch_page error right away, as
you suggested.

A range without kernel ptes is released right away under
arena->spinlock, without arena->lock or mmap_lock. buddy_chunk_get()
frees a reserved range before reallocating it, so its free is never
deferred in sleepable context. A fault on the range being freed does not
take arena->lock either, so it cannot make another free fail its
trylock. It sleeps until the free bumps a counter as it releases the
range and wakes it with wake_up_var().=20

A fault that cannot retry sleeps with mmap_lock held, which is safe
because a free only trylocks mmap_lock and never waits fault. Other
faults are not affected. A sleepable free of a populated range is
deferred only when one of its trylocks fails: while another free, an
mmap() or munmap() of the arena, or the worker holds arena->lock, or
while a writer holds or waits for one of the mms' mmap_lock.
Non-sleepable frees are always deferred, as before.

> See
> commit bb9b9eb0ae2e ("scsi: target: tcmu: Fix possible data corruption").
> Same bug.
>
> [...]
>>  	if (!sleepable)
>>  		goto defer;
>> +	if (!arena_opref_get(arena, ARENA_OPREF_FREE))
>> +		goto defer;
>
> One user thread faulting on any page of the arena turns sleepable
> bpf_arena_free_pages() of unrelated page into deferred one.
> buddy_chunk_get() in libarena does
> bpf_arena_free_pages(vaddr); bpf_arena_alloc_pages(vaddr);
> The alloc fails and that vaddr is lost.
> The other way around any free makes all faults in the arena spin in
> VM_FAULT_RETRY, and the worker spins in schedule_work() while a fault
> sleeps in alloc_pages_node(GFP_KERNEL).
> Giving frees a priority over faults, as you replied to bpf-ci, makes it
> even heavier.

