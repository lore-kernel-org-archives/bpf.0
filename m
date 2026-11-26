Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707014;
	b=ijblp91jWGxKH9jhHMVFeyURBNg9azeNRrBucymYdQqrWI1wwFdQk9v9rvZtkXYvn0FC
	 n/pbzEv1768Y+LP3fhaCrquDuJJYbjIdLpdMrWJ4JJY915iugAEbVulDfblIBC9vvkvED
	 79kbcVhJA1OLuQiu5S40bcEnbfpRjvhCdDPZtyhJXqaQYfhqKEV3r5jmUwMHuuqk36LkZ
	 xkAW1fCls7338axb4XXDl29Fepn74EThzdu4rk+1oHb7p3Xjy01Su+TOUKiIvibPqKrdC
	 nxhUHR83giNKrAh1+6KS5t4GMluRjoEXBxnFTYPdODVwZxkhgPVdFKJvH24zdhWczSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707014;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RUIuNtsNjFQRnriJiAaRNZkrS0anB54nAcvR+tqu5rQ=;
	b=FZD/aHertq5//obtxeMsFLiljHpWQX8KoSVyaEs8JcmB9nn8UcXtvDqm1dhfBO62y0xB
	 TXoqki2f/oTonzRIEFhftiEImXoSepguX9TJSrfhSqqCGzDg93zk7VYohJ6ehVikcfKEF
	 FFLNyVdTkzEXsP4dmqH6C6UynIN2H8IEW1xVpdA1At9S39qUmkOPqde8EfL44T1oi1IA1
	 yrlSmrXvasHaM90xeyWWSTonoQOu9yLSs0PE46q+861cmrWAf3XBet9DUzlDNosJ6GiNN
	 yR91Kg27S8lVrK/F+AI6h2yao0haoLj2IdXWDAeu4x/FCBksUEYNOw//IPPhGCbJu5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nRKQ7WfY;
	arc=none smtp.remote-ip=91.218.175.51
Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DE606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 420DE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nRKQ7WfY
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mSefQdG9q8oprzWmA/cvxJZNWxrmJfpm9iiyYsB1lOk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795707011; v=1; x=1796311811;
 b=nRKQ7WfY2XOWMEnO65gVPYBEoBV9t4zuBTlmSm3Ev0Vig2UNU8VpsQs6kWoJEav23Yi+LWas
 m9oMXOu+mMqSrHGwQ1yoJ9aWFf1Q7P9S7UlWLmAXZWhJEgZNbWQeFgBD/rFo54bIsi4tYu3xtpB
 EPj22AseZXars+lvjASgt57A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1524a602b15b02a6;
	Thu, 26 Nov 2026 15:30:10 +0000
X-Mizu-Trace-ID: 1524a602b15b02a6
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH linux-6.12.y 0/4] bpf: Fix interpreter-unsupported insns
Date: Thu, 26 Nov 2026 15:29:58 +0000
Message-ID: <20261126153002.162337-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
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

Request from Guillaume and Vincent [1][2], backport the following commits to
linux-6.12.y with editing the commits manually.

9a6df65d5c6a ("bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()")
f1c27922576e ("bpf: Reject programs with inlined helpers if JIT is not available")
34746b5a84ec ("bpf: Disallow interpreter fallback for arena-related insns")
7a0855e73757 ("bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn")

As there was a big code refactoring in linux 7.1, the changes in the new
file kernel/bpf/fixups.c will be backported to the positions in
kernel/bpf/verifier.c.

Patch 1 introduces a new bit 'jit_required' in struct bpf_prog. The
other patches set 'jit_required' to fix the issues.

Links:
[1] https://lore.kernel.org/bpf/BESPR02MB12296D62B1B3F33BA21C4F24AF1432@BESPR02MB12296.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/bpf/MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM/

Leon Hwang (2):
  bpf: Disallow interpreter fallback for arena-related insns
  bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn

Tiezhu Yang (2):
  bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
  bpf: Reject programs with inlined helpers if JIT is not available

 include/linux/bpf.h   | 22 +++++++++++++++-------
 kernel/bpf/core.c     |  7 ++-----
 kernel/bpf/verifier.c | 21 ++++++++++++---------
 3 files changed, 29 insertions(+), 21 deletions(-)

--
2.55.0

