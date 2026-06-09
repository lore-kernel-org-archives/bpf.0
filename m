Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90E42983F
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013366; cv=none; b=c3c5K1pyUsW/soMfsQg5/UUjPGteyQJZ5i4TjaErV0D9Qh3Ep2EfT6bef0XGoobRMYdNaxpsG78AR6aaY3aNLn0Ug5LeaswGMcNxIaOeXF2W5ZL+REsa7HChY6eIJrVryy458AKPOjSzVa0T7gPPJiEEUUrlHFBg0P6la9skXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013366; c=relaxed/simple;
	bh=RfNWACLgqPh7mn6BW2OHVluMXiuuJTWj+ppahGvAWho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoSN4LE09MucWeTMPvoAKhWBugqFd4cEyvY6qSdGUN5WNqOokHwkNN/5JEK85GZKf0TqoLTTNMcG0SLveZM5VC5B6kFmENzNBVfr5ZHr3FX4uxo8lblaMn/Przi1csDgxa8X9q+pDK0qfF2W3UC5LG7pjwe2aulQaB1G7EtOchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/jSc41/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/jSc41/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-46013161068so2792922f8f.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781013362; x=1781618162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mArFZON/573TsUWZ5APnKTWJ9fGsLln8Kw8VObW6p8=;
        b=i/jSc41/vi+/+uf5ui8TqopdoL6cNNeFIaqEPhyOMiG/SpXXOhiEstM+/CL5V06l1D
         I//OZeWT8/iuJL1TW5J9TskXHPSrL7NHOYDUGji1nXg5Wjodv2lG13Osc6grxZDMKTLc
         gOxGtOH3gVq0QzJhjgLZozAlRaFpTTufNyEP15UG30/jfa5Rnm7mRBsLWuSGQ4xzPc43
         eCu1Q0qAdXvmTSfvAsnKhZCRT2/1ULOofpZIejNqHoG/PGwUhKrY5p7/NCBY3mRaGZk2
         4CBd27/IBrpgyoS1gZbNyHzpeKkN5rAWZdc7lEHzrRGE0vrgnF8ItJHmL04F+D1XGVKY
         gX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013362; x=1781618162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mArFZON/573TsUWZ5APnKTWJ9fGsLln8Kw8VObW6p8=;
        b=eiZtQfgffAhc/8whK+9Oh6PJZIkeizwEWW3kOnrBrVSiZ+MRp+oW5YznZdDU+ODdoo
         igRtSDrlde/nAFTeYYVmgg6k9Jvz1BhCz8i1bzfpfblcSefr1uQfOanQy5z/oUbIJrv5
         AA8uxctkOoCPtfvIxzGujSiv7O3hWuslWmWfJ8zLou7wvMA/8T3/VMiD3HrvtkCwnFUf
         8b3nYNhInmeTGiLF+JKAzgMOt8ohkqCihNR2Dk6g9tOeelhMZY9Jo/B2lwul4cKDtwWZ
         FgKs92gOpaEvzX/IuMRIFDnuXnByijvh9sytMyv58FR4GX6/ikMzUL5r0cPDqDnmbNrc
         B+2g==
X-Gm-Message-State: AOJu0YwkKMXUmftJREthEoBOcaR53pS0gdD/FwcMIG+BDbZBACuYDrog
	LksabMiA5JsocgdYEanNZEXPv/L6LPW97fiv58DF7KD04uhI7XBFmaCrNXjdi+4TAgM=
X-Gm-Gg: Acq92OFgEUTYWrve4Qd3F7kowZNQzLzWs5J2QG7J4Eenzo0jy52jzPIHzzphS5FUUtf
	uaxvhSsETzrGb8h77rUzGiPFFa5SQg8noeLFFgoPKQCObzK3gImH8UL4AzYK3Xci0TBYtITKwkp
	zyvbjfs3POJ+xv8ND954cVRE0I6h7IbViY9R35A7RdDxqFEyznOEcNWq0x6K2JUkKVcvTbHVdyR
	Ff2DTsT+337hfRcOT02Aw/6pKYH1fpj/s/WF8j8rI/kBKP6OliO2ICrY6PMhC04HiuTQdXmT28h
	BasWQD68Y2Hdv0IrFhlQwP5u4+63VPUlbddXC5dC1A7Mn/RvuEnQ+C48MV6APhBZbzDwRiX8AFX
	W/ZHoniG/35lsBliQd6oUC/CH21gWbqDxiQ1Gv/SQyK1QfICP+WeWQvrr9q0iE8UniDuKlXvs4l
	pRBq41M/uA1fbYhaZgk9prYWJDWWU=
X-Received: by 2002:a05:6000:4696:b0:45d:4a00:b927 with SMTP id ffacd0b85a97d-4603075bb9bmr22100636f8f.31.1781013361632;
        Tue, 09 Jun 2026 06:56:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm64140898f8f.28.2026.06.09.06.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:56:01 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf, lpm_trie: Allow sleepable BPF programs to use LPM tries
Date: Tue,  9 Jun 2026 06:55:56 -0700
Message-ID: <20260609135558.193287-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529174233.2954240-1-vlad.wing@gmail.com>
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trie_lookup_elem() annotates its rcu_dereference_check() walks with only
rcu_read_lock_bh_held(), so a sleepable BPF program that touches an LPM
trie (e.g. a sleepable LSM hook calling bpf_map_lookup_elem()) trips a
"suspicious RCU usage" lockdep splat on debug kernels: it holds only
rcu_read_lock_trace(), which that annotation does not accept.

Patch 1 relaxes the rcu_dereference annotations in the trie walks so they
no longer trip lockdep from the Tasks Trace context, including the
trie_update_elem()/trie_delete_elem() writer walks (protected by
trie->lock). Patch 2 adds BPF_MAP_TYPE_LPM_TRIE to the verifier's
sleepable map whitelist so sleepable programs can reference an LPM trie
directly, not just as the inner map of a map-of-maps. LPM trie nodes are
reclaimed via bpf_mem_cache_free_rcu(), which chains a regular RCU grace
period into a Tasks Trace grace period before freeing -- the same
discipline BPF_MAP_TYPE_HASH relies on for sleepable access.

Changes since v1:
- Split into a 2-patch series.
- Patch 1 now also converts the trie_update_elem()/trie_delete_elem()
  walks from rcu_dereference() to rcu_dereference_protected(*p, 1),
  addressing review feedback that v1 only fixed the lookup path and left
  the same splat on the writer paths.
- New patch 2 adds the verifier whitelist entry so the fix is actually
  reachable for directly-referenced LPM tries.
- Retitled v1 ("Allow lookups from sleepable BPF programs").

v1: https://lore.kernel.org/all/20260529174233.2954240-1-vlad.wing@gmail.com/

Vlad Poenaru (2):
  bpf, lpm_trie: Allow access from sleepable BPF programs
  bpf, lpm_trie: Allow sleepable programs to use LPM trie maps directly

 kernel/bpf/lpm_trie.c | 8 ++++----
 kernel/bpf/verifier.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

--
2.53.0-Meta

