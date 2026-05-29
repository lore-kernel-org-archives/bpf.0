Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA328390989
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076567; cv=none; b=u8b9sytycq05MwYB6flLd7yZXOqH4ajlNKFx3Prs6V7LH4rwiC4TrcD6p+mQyRJIhzMuFU9Xb8Bp+Kdu1Plm8NdtmuN0xpUDqROGddJhmPmJvWU1ElBtulMtyMJa7Z2wFZyWZgI/tDaOXxiTVX2YdqWOdG2Gs4jzSWcqcVX3zaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076567; c=relaxed/simple;
	bh=LNYMZSCC/cAzhF+LBgIl6sgAGyIlLiiPJxEGjkswYyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkeEaj60/Odhzeh8Frz6OXj54FHnI3FIPpOKdj1Z2Yr1d4AIez41V3S0vkcIy/65hZqhCXIevzSJa35EInwiMh798XkhmCNnuzCFxyznDYV2bTdOZDC9dLHabXJA0CGdoeRQtaiA18EObU5ucMiBB9gV7LUVyErM8IZt/swNXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwEflVMQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwEflVMQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso46940335e9.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076564; x=1780681364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HADlY/OIlF0hpDL5/ae4J9awZWb2JktfXMYyTtRGzk=;
        b=AwEflVMQ7pQsx30LNG6PgR0iFIpAY5RV+RyTI2t3AG1c9g0JG4fsUTcYdSAA2XkAN6
         f9PYchNMEQ6gr4NTdSnL4oAFXWX2GLayxWdF7U/9J/2ma+tMhHk+qISuavKfJCC0xag4
         lOYg3VKcOn7KizN+7BLsPzZ0WMrwdo+isQUgaYgZDfNdYGrQo4ZmewEYzzd1y+XnAJ7m
         TOb35uzrLRuAw8fw6EpUOOQfXOprg2+gd0TaVBP7iEqc5R4Nd9vEwBZZf2f3G7mQ3qdb
         QzqPLIx94DaWcIhngqZLWw6zwxRP1MsIoOdg2siaEkV+nfckEu+KgwbKLy5eItTwOl5O
         SRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076564; x=1780681364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HADlY/OIlF0hpDL5/ae4J9awZWb2JktfXMYyTtRGzk=;
        b=e35avXVoJ67eSiYsXO5nIAA0nEi61UFTSZEcgN+/WAugmLmMSNJTN/k5GHZuo0kfbA
         RzXjIlbjtf96/1M3o4uicFOn0fq7REpEB0+yk7dk0NEWoatj6m0VBRE9O4zBYHqxVdmh
         R6nn8V/10Faki4dBTCrpjwJnmR18JGDMNLw1JVyYnaI15wzauFmoiSAkl+FtzdliRJXA
         ezBTfadIWCluV81ILKed+TRCvS3i5iLenj7FusyBzzhMMaOZXd7AFQDKKjZpALED4lLE
         4y4+4faHo8R6jIDy6jep+VxNPppH4mmWaf5YkM/uxqHZ/aWmeJfyWWYwuZpoSgXarEI5
         FwoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9G3pksrGUqqc5ypjOdXTZmJS7gT0//Vsi2kiGpX/vOlKydMXgb1AFJm8G3B2xNFO4DocI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4XFcueEtwOS6IwxB7ErcqCU1XWTrrJrOgol352eQB1zdi35V
	cPogD/PXfJb8apmXccLLsV/zFwMw1AoPShCXg2KKK7bDB1inoyXGowNV
X-Gm-Gg: Acq92OF2M/SDFxXvb6jHn/J1FtBtUC2Ts4U3XnK6jz8Pjy+eSSKVtDtdQARdX0P0jwu
	I3JSplMH7ddyLkBIR1kt8XvmK6DOnMjeekpXDvkZETMjUE5IMYi24JwzmKyLvgsuhbRrxJnSeE9
	fPhVtIyBepGnwjYxiBd8qxFIwKQhU928tBlNSaUYUSF4BJbQRSgi9ULAG3vld14w3GQ7r6632Fo
	1JHaKamME3IY+x6holyQa5S9eNCv1+lIgJ9H4PCNun0gfBSibQZm8feiE/+4GLXhxndjxmtDkgh
	FORNknedyAbe2/TjJAWTjrYSh+rvRtAIc9367dcxrQ8oxGJ4RweHTiF1UouAs3GxUuDYIGzSsPv
	UPCjKINE9f56689e0bjzacT//R36PLV9gAlLYR4DMeaTc4yKFLbmbnMH3DI7hUmvjmGxXM6RxR5
	1wzKxOooEptuha0FccOkVch0kIBA==
X-Received: by 2002:a05:600c:a00c:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-490a2904aa4mr12256725e9.2.1780076564142;
        Fri, 29 May 2026 10:42:44 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c13d018sm25065735e9.8.2026.05.29.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:42:41 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf, lpm_trie: Allow lookups from sleepable BPF programs
Date: Fri, 29 May 2026 10:42:33 -0700
Message-ID: <20260529174233.2954240-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trie_lookup_elem() annotates its rcu_dereference_check() walks with
only rcu_read_lock_bh_held(). Because rcu_dereference_check(p, c)
resolves to "c || rcu_read_lock_held()", this passes for XDP/NAPI and
classic RCU readers but fails for sleepable BPF programs, which enter
via __bpf_prog_enter_sleepable() and hold only rcu_read_lock_trace().

A sleepable LSM hook that ends up doing bpf_map_lookup_elem() on an LPM
trie therefore triggers lockdep on debug kernels:

  =============================
  WARNING: suspicious RCU usage
  7.1.0-... Tainted: G            E
  -----------------------------
  kernel/bpf/lpm_trie.c:249 suspicious rcu_dereference_check() usage!
  1 lock held by net_tests/540:
   #0: (rcu_tasks_trace_srcu_struct){....}-{0:0},
       at: __bpf_prog_enter_sleepable+0x26/0x280
  Call Trace:
   dump_stack_lvl
   lockdep_rcu_suspicious
   trie_lookup_elem
   bpf_prog_..._enforce_security_socket_connect
   bpf_trampoline_...
   security_socket_connect
   __sys_connect
   do_syscall_64

This is lockdep-only -- no UAF, since Tasks Trace RCU does serialize
against the trie's reclaim path -- but it spams the console once per
distinct callsite on every debug kernel running a sleepable BPF LSM
that does map lookups on an LPM trie, which is increasingly common.

Other map types already use the bpf_rcu_lock_held() helper, which
accepts all three contexts (classic, BH, Tasks Trace). Use it here as
well, matching the established convention.

Fixes: 694cea395fde ("bpf: Allow RCU-protected lookups to happen from bh context")
Cc: stable@vger.kernel.org
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 kernel/bpf/lpm_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 0f57608b385d..ac36063cb7e6 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -246,7 +246,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 
 	/* Start walking the trie from the root node ... */
 
-	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
+	for (node = rcu_dereference_check(trie->root, bpf_rcu_lock_held());
 	     node;) {
 		unsigned int next_bit;
 		size_t matchlen;
@@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 		 */
 		next_bit = extract_bit(key->data, node->prefixlen);
 		node = rcu_dereference_check(node->child[next_bit],
-					     rcu_read_lock_bh_held());
+					     bpf_rcu_lock_held());
 	}
 
 	if (!found)
-- 
2.53.0-Meta

