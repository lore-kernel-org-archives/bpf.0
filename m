Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F5248893
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117952; cv=none; b=E7SJmqpYxPdoSBcBf9g+Ovaa8gQNKHN07mxQqJPKBeDgir2gxaqQa1pO7MD7ukcnBblQM7wJoQpY86jsPOk2wgyzRuRYtxeZprjTg40CiHNYDDUobnlxHw3ycr+LcnrV35qzO2T8BB7MOQkoAi+MyooJVrMeVzxe+1nHjsQD1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117952; c=relaxed/simple;
	bh=Jwbt4sna4q8SKqLdUWxKiDuVxC9GU3p1BMahIzU/F2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRFQt2f305vKf6FWhe5+NMY/F4nmZN0IevAZrZ2VQ7IYajmJs441q7WiVqekIx2mRNT9GSzApVpIXAjTU47YBUhPPHzp1KKwfR7+JfHhi7B/j91XHfGt4UkXpaTmZ2qbaV6N+WN9Gqlt6blrXRJcfJjoBIgRKyztmagugGEV63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ihfPfg1D; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ihfPfg1D"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-17bc533fda3so2911563c88.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117950; x=1792722750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9xTWWD9mfzJtMcAru9lP6tSUbC9S1bscJnItCWs39w=;
        b=ihfPfg1DOeIlqGcgUwVDOXhrTBDxBBdUFyXNgVcKv0evpDlm0VwnnPBM3v9CkDpfDb
         b0VFEVLcuo8frMM2nZBGRUu5vr1UQ/kqVZeyrNqND2cSy5Gpt4kxYbeDSmub2frUQTFk
         21SHyDQ72+CZEMbzC/LLvmXKyBZe6vyXQK9Sq3sT69TiMa5VsA5hpLice1AmsvNzldAW
         end3lw5NHaVorHfSVxIiltN1FKZi3nK4y8o8xuy30llVPjrpYJDwd+p0DRDH1+M3Th3/
         JM5csGr4LgYDFNvMtt0lJFLpoWFTGLuUahfnje5Itq/8T8PVNHHt7sgirhb4BCMr2m71
         Swpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117950; x=1792722750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9xTWWD9mfzJtMcAru9lP6tSUbC9S1bscJnItCWs39w=;
        b=yNxzm5b9KThAxOy6EbrwwMT7b8YP2qHM6UJi7I77FqTpINuP/v5PfJly1w8P0jq4cH
         gIQFaCsJrLbMblO2ZbOUKI6B+ZCWpKym/UW6vUrI5VOOYEWoHIy+ica7zq4f/VWJF6+4
         J1tbGEsq2WAmruDB25/ZfAoFEhzV2LVrY7emUZ9Zxmwsw+gIa99yElxhAKjOcLPL/AEK
         thNKK6SXF7RlFasgiofu5qK/G0eQZRO3W6XjruU/sHnbs1SGk8jdwJVhIJUXyhhRjgj2
         8pMJjCih+G4JITE8Xm69DfRs6PTm6AeKJnKKUoQ3z8OL5sm1d9hL5YdVtgVF61oKc8xf
         oRKg==
X-Forwarded-Encrypted: i=1; AKwUvBw5AK7ZH9Mg1u0AQEWpg3ZL8LtR7rGPsADR6PM0xJn3mHcca739d9pirZJGh9p4ncGnyB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYICRK7oPk7QEm+8lHOYcyPoHSLFlh0oyUHlpKFW5wPR/qQVkEPO
	mimHSyW59o0aST9+9jz+5OkCeXslZpIby1HchDfLsryPv1hjX8JVFNd6bHI/sQuz8PQ=
X-Gm-Gg: AYBFou1J+8hIlqA2bJDukpW4PCohcDSvJcfm/rdy2f8FkYsnHwdyMZcPioC9dAwYthN
	w7fRfsFs+pCY3OY4U8xjd6xIU6Y/db6+e/X4lkVTUFC6Y6PFXjZfgGp3Wkje+f+oFAQVdKvR+Nq
	Q7uXduBHJ2d44O2Kspf1hdi8ES48kHcUtqgamGBzzNjR+Soyasq0QbQBcQObBdccfHcjQf5whQL
	kKXjINjhYA0dVPKasYtphbpRlpg+6ExfR+iKMBg+NVihldt7s+g7CElV2pL3z27J8NjkrBybH60
	e59G3l1EdE260hLFcqVEsDAnqzd1cXeM5RkBVT1j0KhZo6hrW8Xpm52t1/9ezrQIWrOqqQdcwv5
	YljHzSITw2HzhGzYhtzSM8s7sy79U5rr3h69tO/xR6sxqZe0CMo4TXrA0PbeyTL9ZHm4zeuFxmf
	zQbxFmBLDReJGtEAevbvYp4+IyxgNX4RnZ5sn10pA+w0CR5O27RIZrzoZdqPk2r77y3XfLjK6Bh
	tvO6MoLqxCdk+vtkxdrnrelFgEXDO31AC8Bk5DRqbEVdxywIHoIhFgpBxzSpSIMPylZOA==
X-Received: by 2002:a05:7022:171c:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-16a6090d024mr26389777c88.33.1792117949507;
        Thu, 15 Oct 2026 19:32:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm2233692eec.6.2026.10.15.19.32.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:32:28 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	contact@arnaud-lcm.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf: Fix stackmap overflow check in __bpf_get_stackid()
Date: Thu, 15 Oct 2026 22:32:25 -0400
Message-ID: <20261016023225.19034-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaud Lecomte <contact@arnaud-lcm.com>

[ Upstream commit 23f852daa4bab4d579110e034e4d513f7d490846 ]

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.

Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/bpf/20251025192941.1500-1-contact@arnaud-lcm.com

Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Assisted-by: LLM
[ Backport to 6.6.y: stack_map_calculate_max_depth() was introduced by
  e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into
  helper function"), which is not in 6.6.y; open-code the same
  computation in __bpf_get_stackid(). ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-68378 to 6.6.y.

The only difference from upstream is that the
stack_map_calculate_max_depth() helper, which 6.6.y lacks, is
open-coded in __bpf_get_stackid().

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/stackmap.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -216,7 +216,8 @@
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len;
+	u32 hash, id, trace_nr, trace_len, max_depth;
+	u32 curr_sysctl_max_stack;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -225,7 +226,12 @@
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
-	trace_nr = trace->nr - skip;
+	curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
+	max_depth = map->value_size / stack_map_data_size(map);
+	max_depth += skip;
+	if (max_depth > curr_sysctl_max_stack)
+		max_depth = curr_sysctl_max_stack;
+	trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);
 	trace_len = trace_nr * sizeof(u64);
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
@@ -354,15 +360,11 @@
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	__u64 nr = trace->nr; /* save original */
 
 	if (kernel) {
-		__u64 nr = trace->nr;
-
 		trace->nr = nr_kernel;
 		ret = __bpf_get_stackid(map, trace, flags);
-
-		/* restore nr */
-		trace->nr = nr;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -373,6 +375,10 @@
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
 		ret = __bpf_get_stackid(map, trace, flags);
 	}
+
+	/* restore nr */
+	trace->nr = nr;
+
 	return ret;
 }
 
