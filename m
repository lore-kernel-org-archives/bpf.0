Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626990;
	b=mgcaXigPg0r83lqr3P3QYz2Jfk1g23j4jbAtpaKqCLL9NIXO3v5DiRgwoGAZoXo4qtIV
	 4crB0pRqf30UURgwQp+0+1A/wEcFLalG5oZmt+AfDNckjlOaqXNcQeMfNEwydiFWGKKE6
	 jjAe68MHTwTIdEYN8ZMcYB9fjEXmXzVObKur6ybL0tGB0F7rVrZxeNfR4HdwkPXFJbq3n
	 XjhYJyQxh/tWrYXvd3vspXSkDAlUYfDR11seW71Am0ZQHeEfU+NIvacO8j/B/GsLo54nW
	 Gt0eVZTk4m+VRRQOXmO7ZkPHzlOn7+/W6x2X3r/d6riB1br5IsrXdOllVDa+DqMWaSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626990;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IZRnxm3T2lBlIWWQ6Nc4qn6VvbG+TU4FXDFG3luI9a4=;
	b=UJdJP3dABmeg2tad7KpJVW1MCWgucBkj3VbxdIu1h34Mgf/LclbI8oEj+4PCdu0XsFts
	 MfYJBul/WixhtjI7zd4Zjoi7t9utCIwr/foHaSAOYc0K1I7+Z2K4hFmCFejzUj7zOxSD0
	 BhSOkDae0taJ6iJoTC601e13VlGmtiONearHbUjDRH31TtQDGCle8K10HpVRlXgLXUUpS
	 pVrzoi3uTYGDs/fsjL7aaj5tEwVlqALN4IKOXhd+wpVMqzKOCGATOp4YGBj04nr4d5o4P
	 EBhoj0156FlxBjgmsaUw9lzkF1LK/JBKkxhxndyPxHyu3Wr6jIMZuDTATm+zGBh7tJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=wD1nXRr8;
	arc=none smtp.remote-ip=131.188.11.21
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69958606A329;
	Wed, 25 Nov 2026 17:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69958606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=wD1nXRr8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1795626981; bh=IZRnxm3T2lBlIWWQ6Nc4qn6VvbG+TU4FXDFG3luI9a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=wD1nXRr8NS8eQkznKgULqLRQ5KX7k3CbQeD+HtsbGurT9KX0c4JvsyUm5jEKDvFuF
	 AwcBAWHf+MEHaQO9TDpPKMiWG2n7Pix9J2HSxLv1xGq2XW/L78Y+4guddTWHDW4+Ml
	 aCQfdgVtQkuqNyzJ9XAKNDTrZdrzZTlIaxX+3Ai44l5V53JbVdZa96v5ZHARUhZY3j
	 oOeWhKK/oazDOnL3eKKp+1MrPoSfKN+Uf7kR7HYZUWBKc2ya1tQwlBNM/VpVRfxeNC
	 tQKInFGlyS/+vwYEiO+58ts5E1N+ohbhuzyXE7kTxjdhizkBGXv+RhrxTF7YtUmR2C
	 vFHUIaJIP7dQA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jZRD55v2qzPjw1;
	Wed, 25 Nov 2026 18:16:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:59e
Received: from luis-tp.epfl.ch (unknown [IPv6:2001:620:618:5b8:2:80b3:0:59e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+50KPzeeuxrztJo64+ljyXz0WqhT2StxE=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jZRD23bg3zPkSN;
	Wed, 25 Nov 2026 18:16:18 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Henriette Herzog <henriette.herzog@rub.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/4] bpf: Emit nospec after every insn that stores to the stack
Date: Wed, 25 Nov 2026 18:12:48 +0100
Message-ID: <cover.1795625597.git.luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de>
References: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de>
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

This is an alternative to patches 4 and 5 of [1]. It applies on top of
patches 1-3 of that series.

check_stack_write_fixed_off() sets nospec_result for every insn that
stores to the stack and must not be bypassed speculatively: a BPF_MEM
store, a BPF_ATOMIC insn, or a call of a helper or kfunc that
initializes a dynptr, an iterator or the flags of bpf_local_irq_save()
there. bpf_convert_ctx_accesses() emits the nospec only after BPF_MEM
stores.

[1] handles the other two cases per insn: patch 4 also emits the nospec
after BPF_ATOMIC insns, patch 5 makes do_check() continue a speculative
path behind a call because no nospec follows it. This series emits the
nospec after every insn with nospec_result instead, whatever the insn
is. do_check() is not changed: it can end a speculative path at each of
these insns, and the store of a call is covered for Spectre v4 like
every other store to the stack.

The nospec behind a call has to be inserted without taking the aux data
from the call, because the passes that follow still rewrite the call.
bpf_patch_insn_data() can not do that: it moves the aux data to the last
insn of the patch.

  patch  content
  -----  ------------------------------------------------------------------
  1      bpf_insert_insns(), which inserts insns in front of or behind an
         insn that keeps its aux data, and its use where a patch only
         inserts. No functional change.
  2      tests for the converted callers that no test reached
  3      the fix: a pass that emits the nospec in front of an insn with
         nospec, and behind an insn with nospec_result
  4      tests for the nospec behind calls and atomics

The main downside is that bpf_insert_insns() needs a buffer of its own
to build the patch, because the callers pass env->insn_buf. This adds
insert_buf with INSN_BUF_SIZE insns (256 bytes) to bpf_verifier_env.

[1] https://lore.kernel.org/bpf/20261125040820.947816-1-alexei.starovoitov@gmail.com/

Luis Gerhorst (4):
  bpf: Add bpf_insert_insns() to insert insns next to an insn
  selftests/bpf: Test the insns that bpf_insert_insns() inserts
  bpf: Emit nospec after every insn with nospec_result
  selftests/bpf: Test nospec after stack writes of calls and atomics

 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/fixups.c                           | 351 +++++++++---------
 kernel/bpf/verifier.c                         |   3 +
 .../bpf/progs/verifier_percpu_addr.c          |  31 ++
 .../selftests/bpf/progs/verifier_unpriv.c     | 201 ++++++++++
 .../selftests/bpf/progs/verifier_zext.c       |  57 +++
 6 files changed, 477 insertions(+), 168 deletions(-)


base-commit: 81c6c8c608b6075846d3bd5b6f57958300a56eda
prerequisite-patch-id: 6079fc600b6711222dba245601eab9d1b76f0ecc
prerequisite-patch-id: 1f8ba1a2f5b8b7bf73dea4349ccd7b2679f4ffaf
prerequisite-patch-id: 2a97f28aef89f4281e7205a16f2210d3a95581b2
-- 
2.56.1

