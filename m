Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559964;
	b=BvLjqPStjAT1gJOrp8jgCGXNbzJQcVzpmhY/ByzgSxMFm0UpZIph/U+jBmJcUy6hX66K
	 cge+w603dnKOw/g/38Q+b0Vi2HSdjxGDrwTWQZgGA320XF/i9l3dsatWjNEajwyfCMWJF
	 Am6WtWiKPM0HWx+Vv7t5L/EIZu6voplDPLphQ9VeryAZI5fo/r90FdVkCD8hefGshDL4g
	 ks/Ovgy5XzWNuCPI+O5WaMvtfw9TkO5Nbbjb4FwuZ4rzUUaUqmotN6dPy/Wyx4qD4Hhxb
	 OvRg/zpN9TZ5jayODGWXKl5IIX4Od+AMcgz5+0EIF7fWaWOF1vohYpOHq/BYmfCzfhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GIOCiVSkD3l77kCSmpSfV2QUFKpiHxl/71iiH+OiWms=;
	b=AL3R1DCOVPnRXNXHViUL4nq9gX1WkQgXjCZWBt2MLaIukh5/t6S0X63ecwboC5ChHyGT
	 MG8S0tlzBKnR2dHT01nlxxo14VdQFIoRKTmxw9BQOfd9tRWVRXAF6yRP4shQFHxhCANhu
	 EsAd0O6Ej6tuHDUpra/+bkxrBm/iG4pu/DBHdmj04rTkXOA4+qLvJ7V/CbG4aIdfU+fjI
	 ucKvGvUWKai8vEUYfUkkn6k23XzHhS/jjc5RjRTgmwxSulvtEJ1FBzKl+qld2s8EQH2N8
	 /vMqWshr6jYGJsK3NbBgntG0d/wUEKbhnfOSEXzQbgrWxVceneocILEY4bcuHR6V4qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niKItIjC;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B50606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2B50606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niKItIjC
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a9f9473029so1564035b3a.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559963; x=1794164763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIOCiVSkD3l77kCSmpSfV2QUFKpiHxl/71iiH+OiWms=;
        b=niKItIjCeig05VwUP9Mhg0zri08ENYlL1mMdmaTrJ4mWMrna3yfXLhMhgqWyP1miau
         sZWHGFAnZ9jM7UNkIMak5PEBePwzHwwvVEOGnAHuDAl+Yw5sTUGKs1vHcNWjssXTew+z
         UqZRryp4FsOGthxBiOj3yQmOy9tdQs8DFfovJpW09QpqUHmN/GxP0Mc/WAdDaxy98sZk
         p2iFJT4chx7icf4jOw4DeXvkx8cJYV/zdsKZJkyo9sh+GvLtPrL1BZRxViBymUI4CnOJ
         gw1KsAzzQhQo7f9pvCEhK2Qt6Pwqvsb1VOvqbLGi08GKZck8udFeGZqZC3yVfRe8058W
         bkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559963; x=1794164763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIOCiVSkD3l77kCSmpSfV2QUFKpiHxl/71iiH+OiWms=;
        b=dCnLuLPsFuES9nYBDvfwTG3SRl/r5RiiO/o0Sf3SdvmS/aSi9GsClAPRviWjD5Lhmy
         0oI2RBtyJUdgMX4GajqMYnCQ87/m/YOdPc2c9gGLoiLAfhoupTncq9fP5HXPQHSNbH1t
         MuSsu1CNQhse0H6NX/pGcIU7oIW6ehECW6i+b9d2KVvp3Znsdk9tHZmJ1o1ahd/uyCdJ
         4uGImJK1CkUayumWLWjBJpOhyvk5bJpuRGEgC1HWOmeVbwBBfCzeA7zs+yL7aIZ/4m0D
         EJYUZz9MmDNn3te87gkCS86t2cNESoImntW2oUZLuVZHlN/qIcwPX/XvsPviE86NaGiP
         MZoQ==
X-Gm-Message-State: AFq9FYKXX5vZ2vRrg+a3L101eTH7Ex26jnmuts5kzAKHeFmF/xCkIobN
	+pPpDptMyh5ach/mnJuH9HVfzzjtz60I46PY9kex9VbPGnv+FWl0FE6U558pew==
X-Gm-Gg: AYBFou3LmDiKPToR/pfAPfaKbFiWil0dxa33sNicIAqP0zyJjHPZGICbqZbeeu5GdjU
	NRGUDP/Y1oCdpJ9OLsWjlBf+tOfu0w/qBrgOEdnmiBeySI36rAIIkGnF3NJenK4ELVQFbIDrhOm
	gK7bgOiTxt28arrs9okM0eH/ZVJz5ucOaBJF9ehe6fCqQXWNz95lrH/CPGj+Vej/annv3ocYBDU
	MbxaAL/EVFvGOV3kO5m8fMsXhWUO/jJDayNRK8PqgjTNHwgpCEqMD4LGEh5tGZ3/IDQUOP6ifui
	87CGC6FF9DlukubyILpHM2ByJ2mWNGIzeWfHwompeFgCHFTSIZuHJqGhK3qyVDzSVT1ZXkU869i
	BY+6z62wXEMQC0KYp4UvEvCFkeRIRECXDSTLhBfbMoYduTtqvHjXe7vziJhpqmnQNZFBo3NumiH
	fr2yV99ZlnZw3ikPbjIK18FuGfvPlwsVnyI2E1t+HVW2fkSmgSTT69XQs0ogcWH5kkEa0IPm+mz
	Gti7JcpGvoUzQpFYIwS2juwMw1pRjBrbH/+u7S4QCfaXbH3UUb3OZDHZ7h7plVlW6I4FONLurHU
	5sHHNMM5JZPIb/zF3elwbRNcAEEpRnn+qqsyO0UDD+wyl8OFo+yw1G9XXqmhJYYv4Q/GZkZ/Q5y
	3U2gIKzhS54VotJg44mHhmQXcV6Q72SS7EPVRDqYOFmlLEyF74GccyNvUXGvRFmu1PeScnwFZdA
	==
X-Received: by 2002:a05:6a00:b45:b0:892:a8f1:c53d with SMTP id d2e1a72fcca58-8a9bdad9e9fmr6444509b3a.22.1793559962893;
        Sun, 01 Nov 2026 11:06:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad7801a53sm1277435b3a.2.2026.11.01.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 04/27] bpf: Don't let bpf_arena_free_pages() see a half-set user range
Date: Sun,  1 Nov 2026 19:05:12 +0000
Message-ID: <20261101190535.1454146-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

If map_extra is 0, the first arena_map_mmap() sets user_vm_start and
user_vm_end. It holds arena->lock, but bpf_arena_free_pages() reads both
fields without this mutex. The kfunc relies on the verifier, which rejects
a prog if user_vm_start of its arena is 0. But this check covers only the
maps in used_maps. The kfunc accepts any trusted pointer to struct bpf_map.

Thus the kfunc can run during arena_map_mmap() and read user_vm_start as 0
and user_vm_end as vma->vm_end. Then min() does not limit page_cnt to the
arena. arena_free_range() unmaps and frees pages of other vmalloc areas.

Read user_vm_start one time and return if it is 0. This value means that no
range is set, because arena_get_unmapped_area() rejects address 0. If only
user_vm_end is still 0, uaddr_end is 0 and the kfunc returns, as today.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index ad8aab551093..e331130662be 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -991,6 +991,8 @@ static int arena_free_range(struct bpf_arena *arena, long uaddr, long page_cnt)
 
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
 {
+	/* The first mmap() may be setting the user range right now */
+	u64 user_vm_start = READ_ONCE(arena->user_vm_start);
 	struct mem_cgroup *new_memcg, *old_memcg;
 	u64 full_uaddr, uaddr_end;
 	struct arena_free_span *s;
@@ -998,8 +1000,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	/* only aligned lower 32-bit are relevant */
 	uaddr = (u32)uaddr;
 	uaddr &= PAGE_MASK;
-	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
-	if (full_uaddr < arena->user_vm_start)
+	full_uaddr = clear_lo32(user_vm_start) + uaddr;
+	if (!user_vm_start || full_uaddr < user_vm_start)
 		return;
 	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
 	if (full_uaddr >= uaddr_end)
-- 
2.55.0

