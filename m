Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377764;
	b=bf0fE/YQI/jXrk24RwGY4mFQWh9IYwQf5mRvci55hWz1fGM1BNKvupGo4/x3KAUHBJ4F
	 g98sq1nFsQTb5gNWE+LSsx8DJLJRwILfLWLtVXbNb/zsUbEkIzWlNJSwkv/NOgnyXAHNi
	 XoHRy0sP/S9q6BG4NvB43spE95vPJBe7pxlW2KBeHHrK09QEIGS1rRFMhbnWpCfa+L4LF
	 lGI2FxPvRWyw6lyixq41bR1BOie3VwJ1sq6ATIcGAPICA0cWoJAYuIWCkL5DfkC+QVewx
	 vvvdhuvlz4ce13dqkCLUCEFjH6uv/VSFvgjR9dL8XP0Z7h8x56XDx8D3D2KKRfeCAzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377764;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pMkwsGeFmNym3OzbToToZ481ja3lbFgl1IDUYm8MblA=;
	b=mHlw4tslzOFeWUgXxLHmv6KFAqdYC2Tcdtj0Per7+3tRknBdYMLyW3uo4ub87ZRNXTYu
	 hM4vYa7WB8itwqbwQXCOHd1veFJcV5Efdml5TEruoUz5wB3C40Rasr4rXcAMAhclNp9Ki
	 K+YPrupHr8vf6Z7Gxp3BQZMCnhLwFSVG5hGOBWjL2ELYIBLy/uezdFGBeNs+tcEPkYnm1
	 cUpywkOC5bS9QERWIRPhuHXGs2IAn9tFY0EmGCtC08/zy/yUvk49Sv26xyP3Ivzm2PFht
	 BKcQjuvX2Knw8sGYiFPlxMf8V+RBwAnaN/BbmdOcQG0LS7hKphClJVTV98UZNhCq2ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zun7/Dpl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C13606A31A;
	Sun, 22 Nov 2026 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zun7/Dpl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16A71F000C6;
	Sun, 22 Nov 2026 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377764;
	bh=pMkwsGeFmNym3OzbToToZ481ja3lbFgl1IDUYm8MblA=;
	h=From:To:Cc:Subject:Date;
	b=Zun7/DplCWSw5lqUOySkd3OYY0S9kspejLyppqLyiqnZjmlI9jjG3l6T6V8JUbvVZ
	 +3bhtyWFJNYmVZ8Zy6zgDzxSL1WyJ2SSdfnZCgn7RKOxPa71gVeT6ri8FsLWuCqmkt
	 80XxN/JTLOxcVzr5Mkn+gQtewEaaxIZoEaCgNP6bXYpKrhNeQAG3Y1EwnMxlq3xMBo
	 9psWdnGQ+eui9Wp9HDUaiccxXGkfrw4WkSA866CEoEAY1rTtzYlMVb30ujsgClQDG7
	 QNZE86tq782mZ1sf8slLdi7SZupZV4LLywjVJIKtxnBteJwodKQeyd8TxnnxwXYlZG
	 JLb+jgP1+9kEA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCHv2 0/2] kprobes: Reduce registration lookup costs
Date: Sun, 22 Nov 2026 21:02:37 +0100
Message-ID: <20261122200239.1481088-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.1
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

hi,
this is a smaller follow up to the v1 series [1]. This version does
only partial fixes of what v1 addressed. Instead of the rbtree and
iterators, it makes the existing per-address lookups cheaper:

  - increase the kprobe hash table from 64 to 4096 buckets, so the
    get_kprobe() calls done for every byte or decoded instruction
    around the new probe walk short chains instead of 300+ entries
    per bucket with 20000 probes

  - use ftrace_location_range() in x86 __recover_probed_insn(), so we
    skip the symbol lookup ftrace_location() does for every decoded
    instruction that is not an ftrace location

Registering kprobes with the kprobe_many_example sample module [2] from
v1 in a KVM guest goes from 4.71s to 1.30s for 20000 probes and from
29.99s to 3.64s for 50000 probes with the hash table change, and the
ftrace change brings 20587 probes from 4.02s to 3.70s. Please check the
changelogs for more details, the first patch has numbers for different
hash table sizes.

v2 changes:
  - dropped the static_call/jump_label indexes and the kprobe rbtree
    and iterators [will be addressed later]
  - added hash table size increase and the ftrace_location_range
    change for __recover_probed_insn

thanks,
jirka


[1] https://lore.kernel.org/bpf/20261109194916.1089703-1-jolsa@kernel.org/                                                       
[2] https://lore.kernel.org/bpf/20261109195827.1091410-1-jolsa@kernel.org/           
---
Jiri Olsa (2):
      kprobes: Increase the kprobe hash table size
      x86/kprobes: Use ftrace_location_range in __recover_probed_insn

 arch/x86/kernel/kprobes/core.c | 6 +++++-
 include/linux/ftrace.h         | 4 ++++
 kernel/kprobes.c               | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)
