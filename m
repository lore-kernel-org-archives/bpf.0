Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA21A0BD0
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532348; cv=none; b=lJOOXhLFbamkTT1eqFLihDNZWTEXsuc2oO3lZeKYLznWCq6xeVUEIZEvH7fi2LxIMDJlPuFEPJES29VRkLDLP+RfK7EBsxhRMT1siYPtD5iJnGk/IGxMr0apaKF/detoCCDTKxMkX/hnUMsGYDoXc6+joahOl8iOxo1UkuvvVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532348; c=relaxed/simple;
	bh=5YudJIPsEbx5/mjoGIDtMlHViWSXh/8229SAGXIW6Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l6cEmnAUDpkGFkjzxDIb/72XG0255i+HH8P3Eeu/PqrD/FJQnpK89NLCmoVCgHR33zNY26v7naKLzCRvlZu+skbPnaMX6Q7yxMjN3E3yInf1jpfxuWG6YboL672z/iTkUHQTe6QPA4dIh7myPOLAlTw1enLK++naF6ViiMv6CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+eRawWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+eRawWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B4C116C6;
	Thu, 26 Mar 2026 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532347;
	bh=5YudJIPsEbx5/mjoGIDtMlHViWSXh/8229SAGXIW6Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T+eRawWU4m+SwV4Ahqa5lw5ICqZKJjp7ieA8Ej1u+R2eHmFWmAPqP8LlOVT2tOyDE
	 uWD3OU+lCXD/lqOramsCM21+GXdrKDsMy3xIQTTv/2DNKKlqgYe6uIf888NbEwYEt4
	 ZfCgMLKouie4sZCUXJOtjhsY8RU/b/Dz0w8eQTTqSuR298agyqlgxEE8mo82hCjVIb
	 xeycLJzGF8CxqFaiMeUGLWjRDAGcoUc2mcOre1JAGxjIvy5dOo2hmQfVpw6vJlq876
	 DoP9pdlQ1QKwWhMl0JD5wRQiza7uvINgBWuRV4sWYixY9NvLeDGhCmFrMAEJdSjjn8
	 NSWseYP9MmAdg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Aaron Esau <aaron1esau@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update
 path
In-Reply-To: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
Date: Thu, 26 Mar 2026 13:39:02 +0000
Message-ID: <m2se9mg16x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Aaron Esau <aaron1esau@gmail.com> writes:

> Reported-by: Aaron Esau <aaron1esau@gmail.com>
>
> htab_map_update_elem() has a use-after-free when BPF_F_LOCK is used
> for in-place updates.
>
> The BPF_F_LOCK path calls lookup_nulls_elem_raw() without holding the
> bucket lock, then dereferences the element via copy_map_value_locked().
> A concurrent htab_map_delete_elem() can delete and free the element
> between these steps.
>
> free_htab_elem() uses bpf_mem_cache_free(), which immediately returns
> the object to the per-CPU free list (not RCU-deferred). The memory may
> be reallocated before copy_map_value_locked() executes, leading to
> writes into a different element.
>
> When lookup succeeds (l_old !=3D NULL), the in-place update path returns
> early, so the =E2=80=9Cfull lookup under lock=E2=80=9D path is not taken.
>
> Race:
>
>   CPU 0: htab_map_update_elem (BPF_F_LOCK)
>          lookup_nulls_elem_raw() =E2=86=92 E (no bucket lock)
>          ...
>   CPU 1: htab_map_delete_elem()
>          htab_lock_bucket =E2=86=92 hlist_nulls_del_rcu =E2=86=92 htab_un=
lock_bucket
>          free_htab_elem =E2=86=92 bpf_mem_cache_free (immediate free)
>   CPU 1: htab_map_update_elem (new key)
>          alloc_htab_elem =E2=86=92 reuses E
>   CPU 0: copy_map_value_locked(E, ...) =E2=86=92 writes into reused object
>
> Reproduction:
>
>   1. Create BPF_MAP_TYPE_HASH with a value containing bpf_spin_lock
>      (max_entries=3D64, 7 u64 fields + lock).
>   2. Threads A: BPF_MAP_UPDATE_ELEM with BPF_F_LOCK (pattern 0xAAAA...)
>   3. Threads B: DELETE + UPDATE (pattern 0xBBBB...) on same keys
>   4. Threads C: same as A (pattern 0xCCCC...)
>   5. Verifier threads: LOOKUP loop, detect mixed-pattern values
>   6. Run 60s on >=3D4 CPUs
>
> Attached a POC. On 6.19.9 (4 vCPU QEMU, CONFIG_PREEMPT=3Dy),
> I observed ~645 torn values in 2.5M checks (~0.026%).
>
> Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")

Although this is a real issue, your reproducer is not accurate, it will
see torn writes even without the UAF issue, because the verifier thread
is not taking the lock:

So the torn write pattern CCCAAAA can mean:
  1. Thread A finished writing AAAAAAA (while holding the lock)
  2. Thread C acquired the lock and started writing: field[0]=3DC, field[1]=
=3DC, field[2]=3DC...
  3. The verifier thread reads (no lock): sees field[0]=3DC, field[1]=3DC, =
field[2]=3DC, field[3]=3DA, field[4]=3DA, field[5]=3DA, field[6]=3DA
  4. Thread C finishes: field[3]=3DC, field[4]=3DC, field[5]=3DC, field[6]=
=3DC, releases lock

This race happens regardless of whether the element is freed/reused.  It
would happen even without thread B (the delete+readd thread). The
corruption source is the non-atomic read, not the UAF.

If you change the preproducer like:

-- >8 --

--- repro.c     2026-03-26 05:22:49.012503218 -0700
+++ repro2.c    2026-03-26 06:24:40.951044279 -0700
@@ -227,6 +227,7 @@
        attr.map_fd =3D fd;
        attr.key =3D (uint64_t)(unsigned long)key;
        attr.value =3D (uint64_t)(unsigned long)val;
+       attr.flags =3D BPF_F_LOCK;
        return bpf_sys(BPF_MAP_LOOKUP_ELEM_CMD, &attr, sizeof(attr));
 }

-- 8< --

Now it will detect the correct UAF problem.

I verified that this updated reproducer shows the problem, the following
kernel diff fixes it:

-- >8 --

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bc6bc8bb871d..af33f62069f0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -953,7 +953,7 @@ static void htab_elem_free(struct bpf_htab *htab, struc=
t htab_elem *l)

        if (htab->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH)
                bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
-       bpf_mem_cache_free(&htab->ma, l);
+       bpf_mem_cache_free_rcu(&htab->ma, l);
 }

 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)

-- 8< --

Before:

[root@alarm host0]# ./repro2
Running 10 threads for 60 seconds...

Total checks:    49228421
Torn writes:     5470
Max torn fields: 3 / 7
Corruption rate: 0.011111%

Cross-pattern breakdown:
  A in B: 8595
  C in B: 7826
  Unknown: 1

First 20 events:
  [0] check #42061 seq=3D39070 CCCBBBB
  [1] check #65714 seq=3D60575 CCCBBBB
  [2] check #65287 seq=3D60575 CCCBBBB
  [3] check #70474 seq=3D65793 AAABBBB
  [4] check #70907 seq=3D65793 AAABBBB
  [5] check #103389 seq=3D95745 AAABBBB
  [6] check #107208 seq=3D98672 CCCBBBB
  [7] check #108218 seq=3D100387 CCCBBBB
  [8] check #111490 seq=3D103388 CCCBBBB
  [9] check #140942 seq=3D128894 CCCBBBB
  [10] check #164845 seq=3D151828 CCCBBBB
  [11] check #163993 seq=3D151828 CCCBBBB
  [12] check #169184 seq=3D155453 CCCBBBB
  [13] check #171383 seq=3D158572 AAABBBB
  [14] check #179943 seq=3D165425 CCCBBBB
  [15] check #189218 seq=3D173926 CCCBBBB
  [16] check #192119 seq=3D177892 CCCBBBB
  [17] check #194253 seq=3D180562 AAABBBB
  [18] check #202169 seq=3D187253 CCCBBBB
  [19] check #205452 seq=3D189021 CCCBBBB

CORRUPTION DETECTED

After:

[root@alarm host0]# ./repro2
Running 10 threads for 60 seconds...

Total checks:    108666576
Torn writes:     0
Max torn fields: 0 / 7

No corruption detected (try more CPUs or longer run)
[root@alarm host0]# nproc
16

I will send a patch to fix this soon after validating the above kernel
diff and figuring out how we got to this state in htab_elem_free() by
analyzing the git history.

Thanks for the report.
Puranjay
