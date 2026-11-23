Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394455;
	b=cCyn6EPknRNEFpm1PFhwVp2D51Oy7krLowlHSUwnv0FKEUVYPV8tjWn9fqfbbgPcNqmI
	 yMes/07izw2SXvaTLp26F/1UeLlB8Kt4yBaUar3BoV3jIPzBdR/Zz7CCPVHN0e2imWrVl
	 sSv3XdfMkMYZPWunYtk3aucJevWVPRhCATtCB63e2cm52Y5WX/7aJ77Wknc5+0wulb2ol
	 rXLR2G8m2e31rA3TDeSrDyoyMhQvViMqNSEXbCY36rb06+5jOeYxlQEFybR9ANeo3446m
	 Y72pbhJoGORBlvCrcF99zHIZO9tr7Y4CPBOn138y/XASgBEs/ev8lPmoBTlmobMn0Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JhBGO+Bzff2sfRtYfk09jmNW/MhpZG21e/W39Xvcbis=;
	b=LjwkCMioQjNRg5jnOjdiGFSz9V8tdLDG5Z+5kojhyzLJH6yv1jPvyPgc+j6oPvHl4iiM
	 hmGurfWUPLfJo4q8c2HWBkbxI2OWIdsaalMgWMYtQZkHXH1PyXreVci7gpOzcQFaOXdfG
	 D+vjA8Sd0kJY+OUOk4zqjqWMxX4XWGvVHV6L7aX1vxYaP32PxyNjy+yQdD1wNczb3ShM4
	 HfHV/EtMN6ZU//47dhEehYLEVwpa+dXJg4vY375fJPIy98U04jkfRhHMJ/TDtXd/S9tgg
	 X8s397MlSPtn/iXH+kMSzuP2/6U4RPL0XlyTI6aUFeExvFtpys7SToEm5d7TpISXT6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7VxvMiF;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BB606A696
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 686BB606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7VxvMiF
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso2075855b3a.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 16:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795394434; x=1795999234; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JhBGO+Bzff2sfRtYfk09jmNW/MhpZG21e/W39Xvcbis=;
        b=H7VxvMiFVH4s8ClRmHAsMycvb8VDbOKtQc1O2zfUQwjLSuXbwP35iqp8VjXYOxQqPR
         EZFiGAwwggYd5yjCZvYjKgxafzXFwYEGQCBVQovrw+xO041oD6iHc6XkhJXyVCMg7s3H
         oRW6zgEMhlMvIZHTIIKfIudIPg/e9Ojbl7lKmaZwZcIOuSdVy1uFNZTZjNUWuAAHnYij
         914nbt3VYInsCaLfSoNxUWD79rl3NtXQiOM86aghrhzomO5YY+hv2/nWPQnS2uBQWvWb
         0VrLXZ61RsylhET2ZoWL+Sox7aXKrrq2DGjfWyP64T2sNVk3Bu2pomSgzwU383pH5r7P
         L5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795394434; x=1795999234;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhBGO+Bzff2sfRtYfk09jmNW/MhpZG21e/W39Xvcbis=;
        b=GtruEM1Zq55L4+OW1aMu9AcKNe62nYps2CqmScD/koqKkpZ5TB20wyWByg3LGbzhny
         2h+MSh9mAuWeP5sjKRZe/ojIkBJQgbgxDnipNB4EVTuusMhu8DLzUsIuWkBRt4VGhUvi
         lgaRN8KIZe4gDt9YdDWhtmQ4ol6WRFz1gfacShz/NhsFcFMisTW7nftouBWBd/xAztJZ
         QfYocjjJpYowW8DsuXx5+DTVofVRFe9dRLAsLaSMzVYFHY2VrRdlj2FB0oYmfYmXh6Kt
         ecOiM4rMZvS/767y9iPKrnZSYPjphBrwwKPfAGHAoeZcCKjiKEU2bDUCLC6djkVknLsi
         ItmA==
X-Gm-Message-State: APuU4Z/CZahaOqhKHj5/LKN5KFA+6QYN9OBypNeJ0Q3uyYy/rbYj+gzp
	1UuEhMZ8sJUYWAmbD95TEYxw1YQTOLl8OMtgnYRjGuD7jGsiHxX8SYMa
X-Gm-Gg: AZFdTZfSCrneO6K3wUbXtRyznvLqmX6CHTEmOKxceA+gcJI5afeAfxC+P9WG9m4Xo7n
	rvoADekiRncg8UkrL2K0NteHtb65iva5IGy+eh0Grg3frpeg480G1niPSHJm4tLR6dPVbOokP0e
	+Ad2xmg8J55NhAMfh7wEpZN+CdC2jOWVD5iCDDnqWlb2/f5hFHYa7g+6POxYsFr27C1P/lRGv8s
	mhKbqD6I4CWj8EjV5KiTl/ZSp+gxpKPhcAGAtVezo2Vyk7y1WxLzrhFatxvdeQOR9hYttt27ZKx
	j37anRlwmsxypEVLo/337EatDdvhJo2qFJHzUxkBfKCEgYoL9mXk9l3RDjZHXOCUjIK/Wz19Iz6
	gv4TZW01DswjYD0rpfqmR7gUiNLwwiKmabmmPiQbwx3Szh6zh8fXB85fu8U5G4ldNrbz5nTbrU7
	Y55cf5XeKv9JBOhdeO9evlbiGvKWj3yps/efUc8gis8VO2oxSm2aBmcaHTAfhPWDZidjN7HcYE7
	uo4SonAalcXo1JErWytqWIY6viv7kraVnTk6qDa1piY5BFyfgG7hpfY6MkNhD9hS3o2ExUEV+nr
	s1SkWThsOFjO6ls+UP2tG5bl6uhCVEmudoPLK/S6r7KllHEPeZzaM6Wj65SgH/Kqd7rH2p0u8Nj
	c14xu/VNMp6YjHY1k7MOEGfyDngS7Fdh7ECM=
X-Received: by 2002:a05:6300:492:b0:3e0:df21:9df2 with SMTP id adf61e73a8af0-4014ca45234mr5333075637.10.1795394433438;
        Sun, 22 Nov 2026 16:40:33 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f726sm4738195b3a.36.2026.11.22.16.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:40:32 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:40:32 +0000
Message-Id: <DN267JUKDRNS.2VMV07CQ58R4X@gmail.com>
Cc: <bpf@vger.kernel.org>, "Puranjay Mohan" <puranjay12@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Mykyta
 Yatsenko" <mykyta.yatsenko5@gmail.com>, <kernel-team@meta.com>, "Liam R.
 Howlett" <liam@infradead.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>, "David
 Hildenbrand" <david@kernel.org>, "Jann Horn" <jannh@google.com>,
 <linux-mm@kvack.org>, "Chris Mason" <mason@kernel.org>
Subject: Re: [PATCH bpf v6 2/3] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>
In-Reply-To: <awGZWsCp6v63H_py@gremlin>
References: <20260408154539.3832150-1-puranjay@kernel.org> <20260408154539.3832150-3-puranjay@kernel.org> <awGZWsCp6v63H_py@gremlin>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Nov 21, 2026 at 05:40 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> This is buggy and can result in deadlock. You need to revert it or restrict
> which contexts it can be called in.

Yeah. It's a bug though very much theoretical.
A revert would bring back an actual deadlock that people hit in production.
So here is that.

> I'm a little surprised you didn't cc- or even ping mm or the VMA team here, we
> are always willing to help and it's clearly sub-optimal to write duplicative,
> open-coded VMA traversal in BPF.

Fair point. Will cc mm next time.

> It's not really sensible to alter core mm to accommodate this at this stage, so
> probably the best course is to disallow this code path for softirq context, or
> you could look into patching the x86 code.

A softirq check is not enough. A tracing prog can run in task context
with pgd_lock held and irqs on:

  pgd_alloc()
    spin_lock(&pgd_lock)
      queued_spin_lock_slowpath()
        trace_contention_end()          <- pgd_lock is held
          tp_btf/contention_end prog
            bpf_iter_task_vma_next()
              lock_vma_under_rcu()
                vma_start_read()
                  mmdrop(other_mm)      <- last put takes pgd_lock again

Equally theoretical deadlock, but since we're discussing hypothetical bugs...

can vma_start_read() use mmdrop_async() like free_signal_struct() ?
It changes only the last put of other_mm in err_unstable.
_destroy() already calls mmput_async() from the same contexts,
so the fix costs nothing to mm afaict.
We can fix it on bpf side, but below fix is much cleaner.

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d7c6a94..a3333ed 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -43,6 +43,7 @@ static inline void smp_mb__after_mmgrab(void)
 }
 
 extern void __mmdrop(struct mm_struct *mm);
+void mmdrop_async(struct mm_struct *mm);
 
 static inline void mmdrop(struct mm_struct *mm)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8..177d5c0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -752,7 +752,7 @@ static void mmdrop_async_fn(struct work_struct *work)
 	__mmdrop(mm);
 }
 
-static void mmdrop_async(struct mm_struct *mm)
+void mmdrop_async(struct mm_struct *mm)
 {
 	if (unlikely(atomic_dec_and_test(&mm->mm_count))) {
 		INIT_WORK(&mm->async_put_work, mmdrop_async_fn);
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 834bbf8..6b9a1bb 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -306,11 +306,11 @@ err_unstable:
 	 */
 	other_mm = vma->vm_mm; /* use a copy as vma can be freed after we drop vm_refcnt */
 
	/* __mmdrop() is a heavy operation, do it after dropping RCU lock. */
 	rcu_read_unlock();
 	mmgrab(other_mm);
 	vma_refcount_put(vma);
-	mmdrop(other_mm);
+	mmdrop_async(other_mm);
 
 	return NULL;
 }
