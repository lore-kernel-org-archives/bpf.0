Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3153379C57
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116181; cv=none; b=QrLdb8gVEttD97mrLF/XydKhfpJNBqT3hJRdAwuPNwXB0wYAV11Wx2/4WowwHoG/Uaimc1EgdyvLkHoCye6S4tWK5VXJR7E9XZhgwgOv0Opr6R9tTZ72fjj07/WwQjFD1ITzTTCMrwfH2rWBmn9XHMFDBKXGRzmMuSsi39in/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116181; c=relaxed/simple;
	bh=vgsa6oxD5xq3522bGLmurqTTRsBsoWRmG+b+hYxtfqA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=PP7SLZpXgsTQW4Vrg+4VjKeCAMK/1bnWv8/xPn+D/XmplGcSyEUkEzS++gImeVvQ75NKvJYHlQVMgXhGNZ4FFrEW6oJsuW4ByopLNfVaBtjXkoC7BFRFEHIDqxM1UR7T24Bb2/x5uKXU4M4c/L8TWtKhkuh6H+blXmJPyXqus3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQM7reP7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQM7reP7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab3260b2cdso2710376a91.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116180; x=1792720980; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AzOdOeU9sPLKmyZLnQBfY6vKjrmfS0zctD1rr4GZ1+A=;
        b=fQM7reP7jRPzRrAQlzk4BnS7hMnEHQw4MIXQ3xPT+M/HsODbxFISF9K+A4Mprh3iy5
         RJzxD4AiKOoaFnOODLFdjQysRKucuhF6Bnh2oKRL9rLZp9XeW0oJ5TRGZra3K/tA4pmV
         0kLZyJTg6UBJgPdxwedwQ+HjB3c0iTmSdeOmx9r6Xbz9L1z3kkzkEpCacMvEXDKFRZaO
         oHzT8odTBGUMd2JSPew67fq8E7KlXNi7vYOHrNTswIxcT7sjcIi58AD/QjpnaWFaRJJn
         QVj7NNloPnBzHOYSblQ+fY/o/NYxORt6/0FwZtFBYEJjKrcJSd/KjSdv15e61gs5iTDc
         3EBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116180; x=1792720980;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzOdOeU9sPLKmyZLnQBfY6vKjrmfS0zctD1rr4GZ1+A=;
        b=nRMqIgadCdZQXL8o1vgHi+BlUwFqJm/vBQLWYaxmhJH/Yzzya8uxrn0cTqJUQnw0dc
         vmfmIs5vuItPXEY1dHkvLpZthWCFJ9y/Ku6lDJsqedhsjRccOKudojGRdgn+Bupl8LQj
         XrRImnzdGtrCr+Zy7wZuVhohlfFtqa1cvaZQ7dkk9NGnZP0SqHu5YG7Yz/AhXcCtraNw
         oQGsk6xBiD+FdnBeZd4mAIAghsD8+/7Rgv/kCFOGsNwGmCyVFSjm34/A5poizMy9F72h
         oaWt6kINjjPWMaLnY8ADre6jMTp52/D76M30pwGkY6VvvWReunWaD6dRjxJGq9/wv0Q4
         TP3Q==
X-Forwarded-Encrypted: i=1; AKwUvBypb5yS59etg1dGLW1mKEqcvlObrzHH7q18KhtzwtYKvmCpDvqWrw2m2NB3BJ2o7aY6DRs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwo44yMFUQYiaVytapF4YifBhIATflTspbXgrMG0FoKod0xMhS
	nDtTZ/eFHvxafyv8RC2+Kpxp9vLMTudwzKIAmurz+Ef32gaQmvwj3U9N
X-Gm-Gg: AYBFou3YyAZAPaGodI2imq9JaM5EU7OUnwRYY3qFys0P4xX4WLZXPt0r0odYzQ+ASdA
	R8rTF/S8d4PzSfWzRvjBkV3WqsKDIWWacgPNxZZMkIM/F0tswYy7fQf6st9au++PAiApg1myRNV
	1gb2mFSilGDM1FY2MoF1T4imxilHpt53iVkvMF2b6KHh98c+EjT7SFcjDEj7K5Go+b+zFaa8/2l
	fYXKBaLmYdYWs+uw3SC/7cmOd8BxQXXpNEqOMJvW2DlDjuzbXPXflyvjiNZcFt/9PWb1c/74eHa
	FNvuLJ/rO5PiL8XnRge0XrNTQnd1wVjGsBxS3Oq6ttgqcPQ0xLyuBBieL2CK2KNslz9beXZudcy
	y+3kAnNlYIYTsNHCtbamtQLDuTjxJM1Ol+wuKfcHJTz9oy0qz64OjqyPpSm7g+OMFJOp3HTgN0O
	4GJZo3cRJJUnpJZ1QStx8ZfnDvzdVVgVHS+QN0Qn3LU1yamcG2J+CTtrH8c8bnPNll5jAqwruEj
	cgnqGmfoF6d9uaNWsb9igNDDB3TF85/u4g6Po3Hm+doyZjMO73WW7vTmReZYELBdwR4D5c/xlou
	4NI=
X-Received: by 2002:a17:90b:17c8:b0:39e:6c69:7777 with SMTP id 98e67ed59e1d1-3ab3ac63cc1mr18542149a91.32.1792116179878;
        Thu, 15 Oct 2026 19:02:59 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654eaf4e3sm286454a12.26.2026.10.15.19.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:02:59 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:02:58 +0000
Message-Id: <DM5W5YU16482.21ASVI86YUGIR@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 7/8] bpf: Synchronize arena page faults with
 page freeing
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261014233442.8392-8-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com> <20261014233442.8392-8-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> Prevent the arena VM fault handler from running in parallel with arena free
> operations. This is similar to the policy for file-backed mappings. Use a
> per-arena reference counter to exclude faults from synchronous and deferred
> page teardown, and vice versa. Faults and frees can each run concurrently
> with operations of the same type.

In v3 I suggested to lock the page, recheck vmalloc_to_page() and
return VM_FAULT_LOCKED. The recheck is missing and opref is there
instead of it.
The free path clears the pte under arena->spinlock and then does
lock_page(); unlock_page();
If arena_vm_fault() locked the page first the free waits for
finish_fault() and zap_pages() removes that pte.
If the free was first arena_vm_fault() sees different vmalloc_to_page()
under the page lock. Unlock, put and start over.
The fault holds a page ref, so the same page cannot come back.
The free path holds nothing when it gets to zap_pages(), so
mmap_read_lock() there is fine and patch 1 is not needed.
See
commit bb9b9eb0ae2e ("scsi: target: tcmu: Fix possible data corruption").
Same bug.

[...]
>  	if (!sleepable)
>  		goto defer;
> +	if (!arena_opref_get(arena, ARENA_OPREF_FREE))
> +		goto defer;

One user thread faulting on any page of the arena turns sleepable
bpf_arena_free_pages() of unrelated page into deferred one.
buddy_chunk_get() in libarena does
bpf_arena_free_pages(vaddr); bpf_arena_alloc_pages(vaddr);
The alloc fails and that vaddr is lost.
The other way around any free makes all faults in the arena spin in
VM_FAULT_RETRY, and the worker spins in schedule_work() while a fault
sleeps in alloc_pages_node(GFP_KERNEL).
Giving frees a priority over faults, as you replied to bpf-ci, makes it
even heavier.
