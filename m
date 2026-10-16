Received: from mta1.migadu.com (out-220.mta1.migadu.com [95.215.58.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087183148B4
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160450; cv=none; b=HOUjPcB027ukfz+DU7MmKHn0FjCqFohej+Tmn05Y51xfTPeusREG2u/AVltYdKCHE9ezu/59TzV0tta1zlPSBYNCPjMnAdEbCAKS/xr3mkBYXkxzgxvkKoLmbtZx64gpIPVhYyKihPK4HZLxaX5fOfPo673SZ/dez0jytQBnP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160450; c=relaxed/simple;
	bh=GGu42Tc205kOaDPPavt6aY7Pz6wZPQ9/zQLUQB4dO3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mybP2X5xAbNw4QLjEhedFHEbNKBiD3/03sOocpeVYp+kw9NRzjO5h+9UYnNhOwp8OsBTmUiy8RVO3ECDrruiBU2waDdgJpcSBFSsRBJYygxnugUUjMEafkptVjIDUa6mKsFbah93xER3IJSk+bmPchGvBwmYTkLnlt1tBOMNQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vw3VocTC; arc=none smtp.client-ip=95.215.58.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vw3VocTC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GGu42Tc205kOaDPPavt6aY7Pz6wZPQ9/zQLUQB4dO3I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792160444; v=1; x=1792765244;
 b=Vw3VocTCIYF9j+3vVsyd3PuLY6dMdx/NtilUo+uM0bK2m0v+Ajs64NA2bry8UKHpa5voFlaQ
 PLyXmBUbInul5SPh0kGL0k0kEuaVBXJuvabqaCr1meFoQCRQ8U33aJGS4Hv2QKACRFgPh1CbRFP
 VKUcGmzn7a8eBsdBW/RQwHio=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dc5ee27f9bbf3835;
	Fri, 16 Oct 2026 14:20:22 +0000
X-Mizu-Trace-ID: dc5ee27f9bbf3835
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 0/2] bpf: Two trampoline cleanups
Date: Fri, 16 Oct 2026 22:20:12 +0800
Message-ID: <20261016142014.12420-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split these two cleanups for trampoline from the series
"[PATCH bpf-next v2 00/21] bpf: Add tracing_multi link support for bpf progs" [1].

Since the tr->ip is ftrace_location()-ed in bpf_trampoline_lookup(), no
need to call ftrace_location(tr->ip) again in
register/unregister/modify_fentry_multi(). Also no need to call
ftrace_location() for the target addr in register_fentry(), when
initialize ftrace_managed in bpf_trampoline_get().

Links:
[1] https://lore.kernel.org/bpf/20261012154024.29423-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Initialize ftrace_managed in bpf_trampoline_get()
  bpf: Drop unnecessary ftrace_location() in
    register/unregister/modify_fentry_multi()

 kernel/bpf/trampoline.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

-- 
2.55.0

