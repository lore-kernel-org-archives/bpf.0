Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660297;
	b=TClWPU0t/OihcGBoZYF+Fc/E0GDVII3+GcVWqPktd9ZGvBWvy8ChHMMk7ql5nZz3g4bL
	 PEQ2MsUWHb2KS+fviSFi0dWaTT14Ytd/yi7PhfwmS4db9VoQDPXbgawuI30HSoGeHMowW
	 uTbX0fzorLN8pJ4Yip9Ef52Ir4sWmNtBSbpxm8SLQfFnfbkBDgsWqKbMkfi8o4rZG24VV
	 wWk+2HnLMwZjWBYdY+xyzVEFpSolES2ge/lIBnl6G0lqyGDCSkrqQnrbRT4OVvGl3V4ec
	 /TKD7C+X0Pf5nNU4ifNAYoueV2Ju98hcvrliyy2xj5hiOckd0Ju1pIdZNe1P4ozNVqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=Ylf3JoV8T76a8xqmKU88In/jWWlRhpVeAfOZXRk2qmU=;
	b=Te2LShILzzmE/uIBm24Kkp7+QV2VrARmG0HpKlF7YFViHrrjmfkQEz+8CG3Hkq+zaBof
	 Y5SGusgo48PvBqB3TL2yoyuz7uOOMBvS0+0dh0wm+i5tJHyTxn3x46jAbihzVrzsSkjsr
	 T6CfThs4/U3HYX//pGy07LlToam0X3gUbLN/Q1pSf1hT92I1dTqISPOG6lk9IBWxbVDVx
	 7pyOtjbyi4P9BBMYgT5f6orcfYbMgNnlC3+IqcaRWNCcR7HDFsoOvUbb9NWZmDuXLYM5X
	 AZdmqtKIxymWNrKCcgjCSBkT4tvnJIH4ZcvmqUHwG+GsJfL7r9Vyg4kk0KBEXtw0RSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QO4kjAiw;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF7606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EF7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QO4kjAiw
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso1205969b3a.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793660296; x=1794265096; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ylf3JoV8T76a8xqmKU88In/jWWlRhpVeAfOZXRk2qmU=;
        b=QO4kjAiwiyYFFo3REuVTUATrPcjk+plLwu07XmvgWYbV99Jhy6hLVdV1Q6Af7jP1bE
         buEd9TyjHGNQSPjKhqHdr9sge6URxzmZKTJF0XNNnc6bn07eNEB/ET6NTOHsioSfrL1k
         404+nqkdWox22FEPySNn+F1veOIDCeAvXNrEcQT19KKA/caZita8LiiSNwAkAYPRRoy0
         +udhlzPkrmkEeMj8oGKdhOdpevTZKponrxojf1zNyOYh25KVd5aJmiR6Gr0VVs3DObv7
         g7Vc9PKCF0umjDyJPQKCfwjw66d4Ln/OgZe1VfXQJVZT2S+HfOTmoUsFxyB49w+vkmZi
         Akyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660296; x=1794265096;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ylf3JoV8T76a8xqmKU88In/jWWlRhpVeAfOZXRk2qmU=;
        b=DHdB3YQW8crmDsBKHoL8ixvHSilI8cLl6rI+WTcEtGG6O0ArWxZLwMaXmoXaVgswIF
         IIxqo4z5K/B5iklfXmfCO3Trvt0/5x9dhUmvCQjR1yylJzqTf7L6/uQ1hOCk4DeKa3RB
         B4BXr4GROD4hmRApUXvPC1ffIaEUehld6Kd5CQoGRLd49wWEN+aRU4FErpjny0Hfe9a1
         TF4wUZF0UvrmxKNI3WRN2xhxOJI3sicYyTNxXDjwXfpMCQiuL6XvU1zSFMF8aRjGOdp2
         +xnR8oTNr5RoyWMIJa+z80zYzvsk8sMYLUCnjFaaQZlpnOM6aiMr71otS9njxyfQjSyW
         FLTA==
X-Forwarded-Encrypted: i=1; AKwUvBxqI2fnIM66j7WxmNxcIotIgmcnyzF8+Dmr+kxkUMBzt6dp9mXXtbHd1a1YVrSl705SRQc=@vger.kernel.org
X-Gm-Message-State: APuU4Z96fBcnMsoCi8ZQOzjFLAqNfnFylNqlOSEwxg1FYj+Keo4q3fAP
	rvM9qEXyDuCGpZNZPOejMJz93EO4BvG4KvDYiEfy9xYEsytoEqSVMLeH
X-Gm-Gg: AYBFou2N3tgnusLx5tPPPkUcDBJvGZR8D6sWYp+TK/qQydWdEI4ed+42Eezzy+d99EZ
	aFiea/TFquU5RhPbqNcbwZJev9DQx/+TzFJjWf9b2qG2HJuuxzD5Xh3NKLKTWCo2JH5nxrHFxVW
	pbOV0I+aUHsCX/HBTFFKOLaX1voyyjh1nXPZqVKZChevJa+U8hox0DbtqEYZnXrgd51uKrbQnzo
	LjISYiuRCYxyg3zg1C70TxDdSSwk8v/ACDEm6RkR9QnYoA4FHBNST1mLb3jmjt0/+yP9xqCOU3c
	RmDfBbAzVNg4EHP4neenFx9usKcBEiDkaUPjWdzsj7M8REfOzzaFR/1bbNb8+rmIp/SB/6pNAMo
	UX26ituzcb4HB3R6vGNvK0TrNc2+NIP8qbWSOlJQlxacDcDG7y/ekELiYxZvgsJnj9dKXSNST6G
	VPjsDtlRTLKfquNvIs4tJ/e/qt8PjPxeqJ6VNTJCk7sotg45qSemDp+1v3Db2yhq1e1EF6hrpI0
	bLbo9pTykX5BTnevt7CNTkT94pI9ULDrerbgM9VfYlAbHAEWBFe9wWrQYgg5hwagIO/iS7W333g
	Zku+7tMclhXw8sPz2yzsNHFgtRXCbJLtCqt9ybfwUYjFIIruwhxnt3zBJzIAYPvIj7q0u7boWsd
	UAyJgePB16EsZwfObvdW4/won5vN+Z6Eg1w==
X-Received: by 2002:a05:6a00:a91:b0:87c:f67f:f7d3 with SMTP id d2e1a72fcca58-8a9b791770dmr8265563b3a.0.1793660296313;
        Mon, 02 Nov 2026 14:58:16 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aeb075f41dsm747574b3a.21.2026.11.02.14.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:58:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:58:15 +0000
Message-Id: <DML3ICCA0NOI.3NTJHPQB0ZF29@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: recover page faults across all arenas
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261028015141.10710-1-emil@etsalapatis.com>
 <20261028015141.10710-2-emil@etsalapatis.com>
In-Reply-To: <20261028015141.10710-2-emil@etsalapatis.com>

On Wed Oct 28, 2026 at 1:51 AM UTC, Emil Tsalapatis wrote:
> The current arena fault handling code accounts for
> misbehaving BPF programs that free arena memory
> while it is being accessed by a kfunc as part of
> another BPF program's execution. This scenario
> triggers a kernel page fault that is intercepted
> by BPF arena-specific code. The code confirms
> that the fault is within the BPF program's arena,
> installs a scratch page, and marks the fault as
> handled. This is necessary to prevent BPF programs
> from being able to trigger an oops.
>
> However, the protection against misbehaving BPF programs
> is currently incomplete: Arena memory is accessed by
> kernel code not just as part of a kfunc, but also from
> non-BPF paths. This is the case with sched-ext that
> includes non-BPF code paths that access arena pointers.
> These paths do not have an arena associated with them,
> and a fault there causes an oops. Such a fault can be
> triggered by a misbehaving BPF program by unmapping the
> pages nominally owned by the genpool allocator used for
> cid management.
>
> Extend the kernel arena fault handling to consider all
> arenas in the system. The handler now scans a global
> arena list till it finds an arena that includes the address,
> and fixes up the address. Retain the stream-based reporting
> code for when the faulting call stack includes the BPF
> program that owns the arena.
>
> Fixes: 9eca087deb0b ("sched_ext: Sub-allocator over kernel-claimed BPF ar=
ena pages")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/arena.c | 54 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 868589f07330..992a0b123449 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -10,6 +10,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/vmalloc.h>
>  #include <linux/pagemap.h>
> +#include <linux/rculist.h>
>  #include <asm/tlbflush.h>
>  #include "range_tree.h"
> =20
> @@ -46,10 +47,14 @@
>  #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8=
, PAGE_SIZE << 1)
>  #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
> =20
> +static LIST_HEAD(arena_list);
> +static DEFINE_SPINLOCK(arena_list_lock);
> +
>  static void arena_free_pages(struct bpf_arena *arena, long uaddr, long p=
age_cnt, bool sleepable);
> =20
>  struct bpf_arena {
>  	struct bpf_map map;
> +	struct list_head list;
>  	u64 user_vm_start;
>  	u64 user_vm_end;
>  	struct vm_struct *kern_vm;
> @@ -332,6 +337,10 @@ static struct bpf_map *arena_map_alloc(union bpf_att=
r *attr)
>  	if (err)
>  		goto err_destroy_rt;
> =20
> +	spin_lock(&arena_list_lock);
> +	list_add_tail_rcu(&arena->list, &arena_list);
> +	spin_unlock(&arena_list_lock);
> +
>  	return &arena->map;
> =20
>  err_destroy_rt:
> @@ -385,6 +394,12 @@ static void arena_map_free(struct bpf_map *map)
>  	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
>  		return;
> =20
> +	spin_lock(&arena_list_lock);
> +	list_del_rcu(&arena->list);
> +	spin_unlock(&arena_list_lock);
> +
> +	synchronize_rcu();

we tried to avoid sync_rcu() as much as possible.
Find a way to do it differently.

> +
>  	/* Ensure no pending deferred frees */
>  	irq_work_sync(&arena->free_irq);
>  	flush_work(&arena->free_work);
> @@ -1207,31 +1222,32 @@ bool bpf_arena_handle_page_fault(unsigned long ad=
dr, bool is_write, unsigned lon
>  	struct bpf_prog *prog;
>  	unsigned long kbase;
>  	unsigned long page_addr =3D addr & PAGE_MASK;
> -
> -	prog =3D bpf_prog_find_from_stack();

This has to stay. If there are thousands arena. Above should still be a fas=
t path.
Only for sched-ext arena access it should search link link.

> -	if (!prog)
> -		return false;
> -
> -	arena =3D prog->aux->arena;
> -	/* a prog not using arena may be on stack, so arena can be NULL */
> -	if (!arena)
> -		return false;
> -
> -	kbase =3D bpf_arena_get_kern_vm_start(arena);
> +	bool handled =3D false;
> =20
>  	/*
>  	 * Recovery covers the 4 GiB mappable band plus the upper half-guard.
>  	 * Lower guard is unreachable from kfuncs; an address there indicates
>  	 * a different bug class - leave it to the regular kernel oops path.
>  	 */
> -	if (page_addr < kbase || page_addr >=3D kbase + SZ_4G + GUARD_SZ / 2)
> -		return false;
> -
> -	apply_to_page_range(&init_mm, page_addr, PAGE_SIZE,
> -			    apply_range_set_scratch_cb, arena->scratch_page);
> -	flush_vmap_cache(page_addr, PAGE_SIZE);
> -	__bpf_prog_report_arena_violation(prog, is_write, page_addr - kbase, fa=
ult_ip);
> -	return true;
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(arena, &arena_list, list) {
> +		kbase =3D bpf_arena_get_kern_vm_start(arena);
> +		if (page_addr < kbase || page_addr >=3D kbase + SZ_4G + GUARD_SZ / 2)
> +			continue;
> +
> +		apply_to_page_range(&init_mm, page_addr, PAGE_SIZE,
> +				    apply_range_set_scratch_cb, arena->scratch_page);
> +		flush_vmap_cache(page_addr, PAGE_SIZE);
> +
> +		prog =3D bpf_prog_find_from_stack();
> +		if (prog && prog->aux->arena =3D=3D arena)
> +			__bpf_prog_report_arena_violation(prog, is_write,
> +							  page_addr - kbase, fault_ip);

There has to be reporting mechanism for sched-ext faults too.
Just silence is not an option.

pw-bot: cr
