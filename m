Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795172379;
	b=YAJTX6L3s9E57rywyw2TciFys3/Yt52flMLj/swZBecWRt0enVtM51mm4CUBpiTIYhYQ
	 s2jp6stL7Np1iGyjBNQx2W3qXR++4DADSgWHs/fhsa7VorpG+PVOoujoXRknYmjbYI4kj
	 uCfeC/YHpB5H8e/g2tit4b1y5t5732BdEFu/FqPvBulEI+68J0sxdNkfJaQ4sAeX97CsR
	 +fd6VxSm0pw10WTrf/HNYTSKQy6bN2ZsFXRaSfRh7fC+o+QCs87GUAWSFVApMvACG4byt
	 DpnGZIT2soq0oO+j6Y3zaCJkLW9raDiagJSHpksIKW0ANmYT5FKabbka9LsslfUq+5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172379;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=N9GJoWP9KWGANWBclMN/x/7grGRAitsXcFOYvWp45p8=;
	b=VCbxb8mxLZnMFbtFstLNgrubfAKP9HsqOPI/MDKvv/oYo6YzevkQKEmhBmf6eAsB+Uum
	 LFMG2jhV5Rb16TeCE3aSrrEm/vTifoisY3PekB6hn2+pHM34AkMVmM10fIXvS2OjsqLIm
	 QCVAvGofuYbuGn/1ThXyKBPz9sPzADcZO31Vw6vvDba2B1bTgioYJ0hWiTjRGaA7LS/cN
	 cIrCdHNNOdqQdKzCgrAP9O5ADUtm+d9D2k2rhbWdsnsV10UPGhbC6i7/uRZKYpmuRN2b0
	 hVvQBIwgBcTapp4K8N+TFtSJ4KWrk+2zPXxr9zBtl0zYqwdf5JRTEb1HvWioHRUkcHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg+wGCAW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5A60A2600;
	Fri, 20 Nov 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg+wGCAW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795172379;
	b=3OXDbaMMpzQ4cLykjXsDEaHhqVAD0Kn+RYbqeqGB/jfKQLI63YcVJr2BWS59EaTYqbtH
	 iimis6ItokhyyDWlMgWEvd7nFcj3Bi7HZfvtczn7Ipj0MuF3pveRjmS7AzkrGZeQ96UdP
	 rX7PSbdIPBT8wh3/X8pOmlfKyjINTpdK90t0jtFCg30fGDnsQyaMcdixEvfi2R1dWA/Zt
	 B0r67+aK7t3iMNMwtyaR2Ts6E7xUTCdmXKBpnej+mszjw45tP+iBl9KpnH92bz73H/OPO
	 bLY31VrevDhFWNOqTa5QA5YlwBLmugNxSRY9LQziOzm6L+STbOSc2bfVWpMZ1uYMBUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795172379;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=N9GJoWP9KWGANWBclMN/x/7grGRAitsXcFOYvWp45p8=;
	b=PmJdtqexSORjpkVpBvOBNqgwVcqvqsSW3zjnjMwLj6zYEKm3teCefcNBbj7bz0BjXoek
	 W2oZWrveASshqIEccEra2ZDEqIid3aNOhwndJE0KYHb6tUgT7TepKlq+4kpgfz5jdZuD1
	 62cncmb0MWENEpB0v97OslgbvgTBKJaRRfwyUZLY1sS9WVWEJs8s23XF496iHZYQp2Kqa
	 EVsEZJLwMCYXHP0JQ+dKfrjy6wRbpHabIFUAvpbKLD/AflippwIehUTkZhg1CbCrzcUuH
	 ayUYeU7empDo8tfBB2JQHyxWZG6+0Puk7dD083DxssKxGF0rcyFWADLfRuj6N9WzIFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5F05C1F000D0;
	Fri, 20 Nov 2026 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795172379;
	bh=N9GJoWP9KWGANWBclMN/x/7grGRAitsXcFOYvWp45p8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Tg+wGCAW4zpukb+x1lwkG7mWcbdnZSiVTg4hGAhEYkgJqSBYWW0hfmFcyfnUeRmP4
	 Lz1VqpEMQyQGdCeB/qIcEgQYQeEqF2Dcv61p4ZWh8K+rthJLDiyrhg6dqnwslZAzS1
	 RtIm1tdinEPPY/Bu9jS2G2nhTlHT64/wtwRePx/0ENhKU8QCyEYg9hBU9qWXSMdJxD
	 RPBxHpVZGdPFKOoarLizZiLQnLAyZ9qMoSgXmIcU0qBvsfjJ2klLq7VzbA0AOilxJQ
	 HogP1V17DOS6S/TdeZgpWOB0jaB/pFhZdX5JPNpvpjcAvtDLDG54Lvx9Nu9VdlTXQF
	 rxydHzl3JlErw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D186B49822;
	Fri, 20 Nov 2026 10:59:24 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mike.bazov.gmail.com@kernel.org>
Subject: [PATCH bpf-next v3 0/3] bpf: Use an on-stack pt_regs in the raw
 tracepoint helpers
Date: Fri, 20 Nov 2026 12:59:10 +0200
Message-Id: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8nAGsC/4XNQQ6CMBAF0KuQWTuGKRGoK+9hXBQ6QBOBpm0qh
 nB3Kys2xuWfn/9mBc/OsIdrtoLjaLyZpxSKUwbtoKae0eiUQeSiJKISG9uhUy8MFh33Hq1jHm1
 A6qqcpKylaiSkdbp3ZtnlO3xHEy8BHqkZjA+ze+8vI+39Xz0SEuqcmlLr+lIV7a0flXme23ncz
 SiOjvztiOQwMTUyT44uj862bR/iVWwyEAEAAA==
To: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
 Matt Bobrowski <matt@bobrowski.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Mike Bazov <mike.bazov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172363; l=4481;
 i=mike.bazov@gmail.com; s=gmail-20261116; h=from:subject:message-id;
 bh=4aGQ30fVGQcDktz+c2aNUCUwsz1tlkmURfv5+dT5M+Q=;
 b=Br8yFWWxoQSuqlWMGIXaNofyvpYJBZw/pOHE4k/eXeU9vSibz9Je439VzXK+bUFun4kq4wd3B
 uwmLjp4+fnAAwiorDfpWyDqkMjypn0a3NRNE4spCWtXCt3+lzo0sbyU
X-Developer-Key: i=mike.bazov@gmail.com; a=ed25519;
 pk=Rr9fagn0pNA+bs8tgc6DXZpRAhl/maU6BeqkttIR7DA=
X-Endpoint-Received: by B4 Relay for mike.bazov@gmail.com/gmail-20261116
 with auth_id=1544
X-Original-From: Mike Bazov <mike.bazov@gmail.com>
Reply-To: mike.bazov@gmail.com

bpf_perf_event_output(), bpf_get_stackid() and bpf_get_stack() of raw
tracepoint and tracing programs share three per-CPU pt_regs slots,
picked by a nest counter. These programs can be preempted, and tasks
then leave the slots out of order, so a sample or stack trace of one
task gets the registers of another. Patch 3 fills in a pt_regs on the
stack of each helper instead and removes the slots.

The slots also limited how deep these helpers nest. Two things need a
limit of their own without them, and both can already be hit today
without raw tracepoint programs:

- bpf_perf_event_output() WARNs when entered a fourth time on a CPU.

- Build ID collection in bpf_get_stack()/bpf_get_stackid() and
  bpf_find_vma() take mmap_read_trylock(), which fires the mmap_lock
  tracepoints. Programs on them that call these helpers nest into each
  other as deep as there are programs. Patch 2 limits it to three
  levels.

Results on bpf-next 0fb18ce8a2e9, x86-64, debug config, CONFIG_PREEMPT=y,
preempt=full. "base" is that tree, "v2" adds only patch 3, "v3" all
three.

The slot race, 5 runs of 10s each. Two raw tracepoint programs on
sys_enter call the helper, two threads make syscalls on CPU 0 and a
SCHED_FIFO thread preempts them every 20us. For bpf_perf_event_output()
the reproducer reads the return address of each program's helper call
from its JIT image and checks the IP of every sample; bpf_get_stack()
and bpf_get_stackid() get an empty kernel stack instead, because the
unwinder looks for the other task's sp on the current stack:

                                     base        v3
  bpf_perf_event_output, wrong IP    7-18        0      per program
  bpf_get_stack, empty stacks        362-535     0
  bpf_get_stackid, empty stacks      168-364     0

The bpf_get_stackid() case with bpftrace, whose kstack calls it; @a[]
and @b[] count the empty stacks:

  bpftrace -e '
  rawtracepoint:sys_enter /comm == "dd"/ { @a[kstack(1)] = count(); }
  rawtracepoint:sys_enter /comm == "dd"/ { @b[kstack(1)] = count(); }' &
  taskset -c 0 dd if=/dev/zero of=/dev/null bs=1 &
  taskset -c 0 dd if=/dev/zero of=/dev/null bs=1 &
  taskset -c 0 chrt -f 1 perl -e 'select(undef, undef, undef, 2e-5) while 1' &

Nesting. For the WARN, a raw tracepoint or kprobe program calls
bpf_perf_event_output(), and three fentry programs on
perf_event_output() call it too. For mmap_read_trylock(), six programs
on mmap_lock_acquire_returned call bpf_get_stack() with build IDs, or
bpf_find_vma(), while the process does 1000 mmap()/munmap():

                                         base     v2       v3
  WARN, started from raw tracepoint      no       yes      no
  WARN, started from kprobe              yes      -        no
  bpf_get_stack, build IDs: depth        4        6        4
                            calls        1.5M     5.9M     1.5M
  bpf_find_vma: depth                    6        6        4
                calls                    5.9M     5.9M     1.5M

Depth counts the programs on the stack; at 4, the last one gets -EBUSY
or the fallback to IPs. The kprobe case wasn't run on v2, which doesn't
change that path.

---
Changes in v3:
- New patch 1: don't WARN when bpf_perf_event_output() nests too deep
  (reported by the BPF CI bot).
- New patch 2: limit nesting of mmap_read_trylock() in BPF helpers
  (per Alexei's suggestion).
- Patch 3: correct the commit message, bpf_perf_event_output() keeps
  its own nesting limit.
- Link to v2: https://lore.kernel.org/r/20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com

Changes in v2:
- Use a pt_regs on the stack of each helper and remove the per-CPU
  slots, instead of disabling preemption while a slot is in use
  (per Andrii's suggestion).
- Link to v1: https://lore.kernel.org/r/20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com

---
Mike Bazov (3):
      bpf: Don't WARN when bpf_perf_event_output() nests too deep
      bpf: Limit nesting of mmap_read_trylock() in BPF helpers
      bpf: Use an on-stack pt_regs in the raw tracepoint helpers

 kernel/bpf/mmap_unlock_work.h | 16 +++++++--
 kernel/trace/bpf_trace.c      | 80 +++++++------------------------------------
 2 files changed, 26 insertions(+), 70 deletions(-)
---
base-commit: 8835113107b2cf75df33a71e265cdeec5d5d13e0
change-id: 20261116-bpf-raw-tp-regs-preempt-1f7019989ab9

Best regards,
-- 
Mike Bazov <mike.bazov@gmail.com>


