Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377774;
	b=eGs8OmoIo44jxf0vo3pHkH/pOFc4OPe3B7ydRXIjoi83Qm9+2NTFnABR7DAN7XJu6Lqt
	 HeTZ7X3Yz56hmm24zNzIfaaricju44NVPYoFBr4nxDm3HPqkk7kSMwuTrjWgGp/yxA7ip
	 2Wx2Wsa77awWVKig4V5OHmaOYzyNoW/Y1g9CdacbHBdUIoeyva0AcRaDRLbaAsawcxigF
	 R6+9c+K9LulWfrfhvADYHNLbw3BKq+p+2wziM2J03wE+shjPh7qNHsZVGxO487uSEymK3
	 HpVUtTJjwmEKR6Ltx4Sqw+ayCy8WDXowx4+PCDquys/pYSqEybkQOG3UdCSH1vQuEog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TB65jF6hw4RUhMI0oPmDv3OgO9hqAG9YZvDlgjcfX2s=;
	b=vdhtD+kKz1ljlZtPhgjacvNv/dV4121AxvUTKVHR20c2za2gK6Rg8+EXdhSTO8LMV0rm
	 B+ew0aPUtamrOZ2gzkwHEG08kfGbjEX4ewNVopCFk/s3N6BMWEEcfA7+htl610XYg5r5R
	 68QTKSj6QqT3brpHg3URUJ4OfmWU5U+VLy9wfhE8q6niVrbXyVkmAqp7dA4bKTewOyyby
	 pHPMJJ8Niq2OD/Neucsnqu142PwE0MnssCiZi/7BcNbo4UxFeBBVOaa+gCeQSwKxnE9tx
	 GAZVe/Z9099lamG9Uu1E3l/vi/fT+dB+LZzLsVETqzssDNxm+4U+xV4je4xXSOi+e8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPMlWs93;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C16606A31A;
	Sun, 22 Nov 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPMlWs93
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AE01F000CA;
	Sun, 22 Nov 2026 20:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377773;
	bh=TB65jF6hw4RUhMI0oPmDv3OgO9hqAG9YZvDlgjcfX2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EPMlWs93prKb6gB3fOKf9Xhfe2DQS8LfJZBA6bCubisAuKnYnKvpgLoP/DCzqgyU7
	 b7P8BVRiJp+gluSHMdTIxnrShOmHIpuDoYEVQSUD1TtpG+j0Zlc1mM/5HnHQbBfZpm
	 GOhuWi8XvAbC+QwpwDoaCm9q9KkhxHt1lBpkRrkmnKlkdQEufPzliP7k+tKMdn1xo9
	 16wX2jRNoP6V6GVDv7NB+MND810L3HcIXmxk6L3w88qLtbCVAOTFONMU7qqNTk+ZGv
	 sZP1aDh4NhMWEuihBqXIFx9k9/OpswWfxkDxpw83e9py1sIwHwOMGDjYOyvukkLLQM
	 I5ayjpx4yhK6g==
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
Subject: [PATCHv2 1/2] kprobes: Increase the kprobe hash table size
Date: Sun, 22 Nov 2026 21:02:38 +0100
Message-ID: <20261122200239.1481088-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122200239.1481088-1-jolsa@kernel.org>
References: <20261122200239.1481088-1-jolsa@kernel.org>
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

The kprobe hash table has 64 buckets, so with many probes registered
each get_kprobe() call walks a long chain. With 20000 probes that is
more than 300 entries per bucket on average, and every entry is a
separate struct kprobe, so the walk is mostly cache misses.

get_kprobe() is not called just once per registered probe. On x86 the
registration path calls it for each address it has to check around
the new probe: get_optimized_kprobe(), __recover_probed_insn(),
__recover_optprobed_insn() and arch_check_optimized_kprobe() all do
one lookup per byte or per decoded instruction, and most of these
lookups miss, which means walking the whole chain. It is also called
from the breakpoint and ftrace handlers on every probe hit.

Increase KPROBE_HASH_BITS from 6 to 12, which gives 4096 buckets and
cuts the chains to about 5 entries for 20000 probes and about 12
entries for 50000 probes.

Time to register the probes with the kprobe_many_example sample
module [1] (insmod with nr_functions=20000 and nr_functions=50000)
in a KVM guest, mean of 5 runs, for different KPROBE_HASH_BITS
values. The table memory is the size of the static kprobe_table on
64-bit:

  bits   buckets   table memory   20000 probes   50000 probes
     6        64          512 B         4.71 s        29.99 s
     8       256           2 KB         2.05 s         9.90 s
    10      1024           8 KB         1.39 s         4.63 s
    12      4096          32 KB         1.30 s         3.64 s
    14     16384         128 KB         1.28 s         3.41 s
    16     65536         512 KB         1.28 s         3.38 s

With 12 bits the registration of 20000 probes is 3.6 times faster
and the registration of 50000 probes is 8.2 times faster than with
the current 6 bits. 12 bits is where the curve flattens: compared
to 10 bits it is still 21% faster for 50000 probes (6% for 20000),
while going further to 16 bits gains only 1.5% for 20000 probes and
7% for 50000 probes, for a table 16 times bigger (512KB vs 32KB).

The cost is the size of the static table, which grows from 64 to
4096 hlist heads, that is from 512 bytes to 32KB on 64-bit. The
functions that walk the whole table (module notifier, arming or
optimizing all probes, the debugfs list) are slow paths that take
kprobe_mutex and now scan 4096 buckets.

The sample module was posted as the last patch of the kprobes
lookup cost series [1] only to demonstrate the testing, it is not
merged and is not going to be.

[1] https://lore.kernel.org/bpf/20261109195827.1091410-1-jolsa@kernel.org/

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f14f7ff45961..47ce0bfb7298 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -50,7 +50,7 @@
 #include <asm/errno.h>
 #include <linux/uaccess.h>
 
-#define KPROBE_HASH_BITS 6
+#define KPROBE_HASH_BITS 12
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
 #if !defined(CONFIG_OPTPROBES) || !defined(CONFIG_SYSCTL)
-- 
2.56.1

