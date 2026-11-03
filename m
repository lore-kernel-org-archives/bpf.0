Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716155;
	b=tUjzn4eparwwPDtObQ+CDaXj8rTFkM8jkMeZHldlIPmw/eBEFtB+V+NMY5pE7g10wgdU
	 MbDwY8RCBeDA2bV2bYyBRKR/Achy9E+bi71V/1RzY3KelGmSc7gR0/ZIQ00Q5Mhxrtubk
	 PZkJJEHIBfxlOoqe5ATYKqijvCXkoR4ylG+PCV/4gOfVZpuqj04zZ27Q7kF4VCJofsde4
	 lYzbCiMXFOIR6F0w6IcYoyvMf/1Rw++Jj5wE9Jr9+FP1oG4ZXzSRRP3Fx1Me3AVyl6EM3
	 uRcM8thqwtWV5YVxhPQDzDkX3UkPVoWoj8ExkXZEI70/Cntqsne+c4Q79zCO1GCH8ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716155;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oZHUWqTFzAYc6EeZQBOGUKwe0sk6p3GJrYnYURhZBY8=;
	b=Zd1rqeWxNRJ6GzD5GIcFolBlRQyBg7I7x1terC8BQ2yY4Nhs6NWdPo8iLn2TmBhwBSRJ
	 ElN5uJQXn8WhiyNTiVrag70JXTqR+iD1t/cVROQigYlfaGz11Kue+zs5oevnjMIzesNaR
	 c/MCukHvDGrhBSBN7Fvi6J8S3L9zQOcoJhyKLxdwynNa5TldPqF+HlvfkO+XwIrfoSSf9
	 RsG5HJVCC/UsjHpoad/S7w/AlnFTxa02U39RzuGddL1XWC/BENW07LwA4316dKdI1s5vF
	 ssUNKNFePn4zTuBuK49FV8v6F0WT5KeFo3RIL5v9qgdNtLaoBDZvxgrRTBaMs63fiRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMvoDbwN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE0606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMvoDbwN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6BD1F000C1;
	Tue,  3 Nov 2026 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716154;
	bh=oZHUWqTFzAYc6EeZQBOGUKwe0sk6p3GJrYnYURhZBY8=;
	h=From:To:Cc:Subject:Date;
	b=nMvoDbwNiEtRcji2f2h6NDn4nLBheUcVp6L02LSboe2BMJtZo3Q8IC3ADdSrsxyuI
	 ehx9jGurS3vBpELPRduBvafVPyBkJ8H822JCFQ4KfbflluE2s8LMkTlMG12oal68js
	 nmvx+SVTQHS0X/99lKSXAl2R7jeYhBiaSGGSWblIuRYbN0zVb//3yw18EtiLa6kIxJ
	 02A/Ex3v0KJa/IHwYQ62dEHMf6gP0iR58Kw2h9GUiTi168+irQVL5qh2ePeFVpe+lE
	 68UuUz6I5sD2TB7Khiuv9bO1AnH2kimWLWHcq5BnJXmx6hY4vOR1DHw1oEdXVqYeby
	 HGo75BA/zdFQA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf 0/2] bpf: Shorten pack_mutex critical sections
Date: Tue,  3 Nov 2026 06:28:52 -0800
Message-ID: <20261103142856.463063-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Patch 2 moves bpf_arch_text_invalidate() out of pack_mutex, as
suggested on v1 [1].

That makes the frees fast enough to hit a deadlock that was already
there: the pack_mutex owner frees an empty pack and waits in
flush_work() for vmalloc purge work, which cannot run while
bpf_prog_free_deferred() items waiting for pack_mutex fill the
system_percpu_wq pool. Patch 1 allocates and frees pack memory without
pack_mutex. Seen on arm64; x86 and powerpc take the same path.

Changes since v1:
- Invalidate before taking pack_mutex on all archs, instead of dropping
  and retaking it on arm64
- New patch 1 for the deadlock

[1] https://lore.kernel.org/bpf/20261024031046.625578-1-alexei.starovoitov@gmail.com/

Puranjay Mohan (2):
  bpf: Don't allocate and free prog pack memory with pack_mutex held
  bpf: Invalidate freed prog pack memory without holding pack_mutex

 kernel/bpf/core.c | 58 +++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 19 deletions(-)


base-commit: 9abe2c42ecab6c86b54838d2d645ca2e10204606
-- 
2.53.0-Meta

