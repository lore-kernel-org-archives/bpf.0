Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634249;
	b=vOYcQo/R0fXbYdld8EtU+RflyEtNcWI4u0l/3eJ3qTJL/79qFJUO2gYKG/fswKulvUDJ
	 GrsGbdaONJEFS1C55tT47vRRWFRJl64ZzyyREGMlwfOmfyjk4mVHzxNBlcx57pSRLPdq/
	 +huCT6Xc4R5qVm6Z0YZctXMnL6VqvqmBxpuWmzUEISljPKK7U2GoVLmR0NOEEj2u8r8aq
	 NuHI9Oy+MX/DbDyvfPftsr+j52VXzsMbOQaEA3gSbjKkXLHnsesPQFVpOiTHlqXqgN57G
	 i/ojWSLKikWEXWdTRY6mS9zKr9d9GdJq0SrQC5SrP2TqXx2RcY5xGLHGHOSiCeOnH3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
	b=nAfYCOjfw1xcT0Vubxr6kl8XNEMM++U3834o01W+YMLD2XyE+/4urC+jgc0BAgVAcy6i
	 JhB2MfNTCbyMkt70Zjr4WQ71cGHB6+pjCyDIEy1V7d0diAu8iXyTKcBJa5QTqsgisd8D6
	 rl2DyH0rYBL8bO04iI4WR3kWSOF6nyMj9yc74nqPJAkqO6van/MHhPkZ/uUsKMjEtDJ7b
	 rOECbhzMQIMakyS0ZMu1eACYXtuCK2TSYcRw2tTSkB43seqXa6SjrmVs7MojsibBFs2Ki
	 dJxeB8FDSBjJOHsUq7wYZzeW1/6EV4C0bUofkhhbZlLj72sZhnZCMXZBE6Iss5SK+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hz7IhKS8;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A0606A326
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 155A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hz7IhKS8
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8246b13cbso10212725ad.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634248; x=1793239048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
        b=hz7IhKS8JnGZgEIexGY3I/4re8TbOOzx4dsaeiqtAUO3Mlg2//pA7KdBy10wHrc/WE
         oQkv3BwN0H+jxhBBiDVnqP7ZwfcFe/Dxi8cDyAm0+6qK3rEA+Rcl2yt2on5K7RkFfAd1
         JjfV/kqtvP3+GekJ86lvyfLCOfqfl6iFx3ByUKBSkZqqEkHrve8O51W3bDBcuvkErXuh
         /WNVdOyxsOBwIwnKzPKYLibS8H+/yd9dtsUyWlLO/PUUQdtPF++7YKthKoC6GJwUm/GS
         Qwb9Ec4xTK+9kEgeBXfzU4KRlJJ0yqpphEfA5EmlI19T+diFkzHeCGq7ZMN2TI0CTJry
         Z0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634248; x=1793239048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
        b=vHcXIGO0tDqe/uno1ZiGEDjhDEDNq8WpMlMnS+b6HVqtjSqiuhgnSr/kCdAqGJEEhc
         8x+oIs1yMu/vrkw0S79M2rhbgTOEmkxBs3RDJxcLIfzIK6Dfrsw5J7EufM48T31FWr2U
         iSHzTdfDCH5u6bbQxPDKYN1SwZebzi8PMpY+8iFAmVuHE3j58WUsYwL7W0v3t0yABSx5
         t7rQn62DoMDsX+ueGQ4aQlMDuoR2c+GUnZw4+wdsZdU24ieP+dN4bEjMI+ELBZVgXlY6
         MCeLEpkEUFrFYowJT5Jtr1pT3xCy8K4h/lZM9nJ3fl8X0LYojR9Zkg1+ZuXEoR23G1Jd
         TPzA==
X-Gm-Message-State: AFq9FYKdwI/JM0XETz+vrsV7vQj9IQYxg4YwZH17GNYOEanU9IQdf5jf
	UjkchXHAdcn++FOu1nlq/wNVi6sjeU5I7kyC4M/KiiAsbNljX4nbJYApS3RQfA==
X-Gm-Gg: AYBFou2cxlpjuB2KXl3HF7O4RzrBxjDzG1vBeRh2DaF/CfFAgal3z269/O6sEMAedVD
	XfeKikHHWtk29FGoY9E+elqOzR2/6wJoQaBsaYkfM0oHsz8hcRcXSNP+tArJ5O44Jt/MjPKgnoY
	q7Tz9+db9+YCz61tUoRyq+XuFuZuXJ6DCHQ1jnwD1km8fbbv+Wvn39cQ3oqL6E4VWlxxqYtNebr
	SSOiJM58YwVLXxK6/HES2gkxSLdKbHbKSA631rByTrELX7t26Ko5BF7oW3GBuyOe/Cn2Q/Krh9E
	8ylJlUDl6mjz/uMB/SPvnB6vGA9X3EIWo9FrqN3TlFxKVoC3e5H8rWsBN5PmEBA4Ci5k7ZD8qUw
	pSPHsNUJiC6MRaWIRj/QpvHhKohQBdPcjfV79ekVSs5kDh4+0IeujZigPxqeYGPYUUMyAvghCi7
	USX1FP/LpoHCh8nZdR4c7JA/0jq0B8v5Q2/yr6r2JiFhlRoozsQjwvlrmLUfr81IGgwwxICBA+m
	7QnHqO+lK6GT2JamYL/IM+//pYo28vppv3JT3jSRKhdIcb3VRq34p/mg/VYxeQYGzT13HDoXHCR
	0u4dvoT3hIGQzmEHQDEq+fD6kxfgIGcJgtDuesMqexalYSC6/cQBAX3Amuqde35igLOUAdo1bSJ
	SLnI8leLrMBw5cw2rhyMGuDJf
X-Received: by 2002:a17:902:da8e:b0:2e9:5829:9b41 with SMTP id d9443c01a7336-2ea43e20647mr33495795ad.37.1792634248345;
        Wed, 21 Oct 2026 18:57:28 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4addfbsm16725685ad.74.2026.10.21.18.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/9] uprobes: Don't run exit_mmap() under dup_mmap_sem
Date: Thu, 22 Oct 2026 01:57:05 +0000
Message-ID: <20261022015712.1297331-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
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

build_map_info() takes mm_users of every mm that maps the file and
register_for_each_vma() drops it after the visit. When the process has
exited meanwhile it's the last mmput(), and exit_mmap() of a large mm runs
with dup_mmap_sem held for writing. Every fork() in the system waits for
it. Use mmput_async().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/events/uprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7709ea882477..6792004be6fa 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1250,7 +1250,7 @@ build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
 
 	prev = curr;
 	while (curr) {
-		mmput(curr->mm);
+		mmput_async(curr->mm);
 		curr = curr->next;
 	}
 
@@ -1324,7 +1324,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
  unlock:
 		mmap_write_unlock(mm);
  free:
-		mmput(mm);
+		/* exit_mmap() of the last user must not run under dup_mmap_sem */
+		mmput_async(mm);
 		info = free_map_info(info);
 	}
  out:
-- 
2.55.0

