Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244B36CDEF
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274617; cv=pass; b=nR92Pk8+9j0gsQVXEtJN5tP94X9g56qQc6ipRRaFrCZy4Pa+nemFKZWaBgO0Hc1OX9nYxBMPEuxGXCWMSCE08xiU755r78/VNpbNAJ9lDGcXsPFSYu2RQc1QN6ge2KG3uY3DUZcaPUucz1cZk3OJm9TL2Wo84pP6mJRRym2EWuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274617; c=relaxed/simple;
	bh=5XQnqmNznRuJTw4ebb8qVPcUCzwx91ppiIHuwm68ZQY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=h3ChIcZfkJ8lYZ4ykTViB4CHAkVWSJzc2KnCXj6ejCGB8pOesS0zAb1NeLzPDbLraChrlSLDaS8yNhRPs12KXqfgq9UeHKPWW45xwquTbGPVtpEoNsAhyIsRKIJ7UMKB6Hmj2IIs2wL9qDhf0/u1+x9nkOgxaxbM5svHGnHjJDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlifvote; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlifvote"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-439acb393f7so5441252fac.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 03:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779274615; cv=none;
        d=google.com; s=arc-20240605;
        b=KKDgErSN5MGHhauzUSEqtZaj0EQhGPiEZLSqeyI2AjCp4RxfhcwSek3v5Da+rJs+ix
         KQY9RAOCngM8Oops+cuBTkG1loemJfurk3U4W6LcoSyKP7qE3RtsXCb1+Z/Qn4wUxakj
         j0yIy9hqY1yKeGopKrvQn+3BE+H/1betYgWW9zUVWq8q6clE3SXVxBI2FjxKTVeAK4Dm
         dg8VhvwHMnAh5cOCxmjuh6lwKAidCevn2TBGh/zkeVp2eOybYY6lxj4LatlhkUnNENfk
         /+occJaPeezeL9wbnWK11s+99FtnntIL/wJP4YOZ/WlMVaY4iK1SJVdClBkb5auhrVcg
         jktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=r/NK7+VqvmwkFP9pNkZ80sKNM6xb3H1qdFY05QwDPeA=;
        fh=CEEuT8ekTYgUhIC1V2EQ0qIqTEZl+6Pyn6zUOley+bI=;
        b=EfPmdLOMwTODS4ui1AKF3juVSjDBYTy2dy/dBuW25PWmOM+PsnGYF+Wjjx+InspY6S
         ejCEhNDXM8UuReSmh564WDt4oGp1kAtdyOIo2V5W7jvusFeO0hXZI1vrgvlWn0PGtuXa
         qY+OMAA53muQfrSkJtt4oE9n8U4OVVMXRrcXiLj2tZ2Q7/AT6BWJXEygiwmq4kWz2eAD
         NahH298qQkmEDLiBFeROxSMkVctiDhAQUa/1V5OjtwetRRahYO6KoeVltPPEMhWVt6Ru
         CGBSd3LJv31+HqG6EXvHtD8DjHWmIyLmPmcJZnthr5Z2PoyGuPYsOxvhPwGjiwJ0bbtF
         SlrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779274615; x=1779879415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r/NK7+VqvmwkFP9pNkZ80sKNM6xb3H1qdFY05QwDPeA=;
        b=Mlifvote3lzqy9GrZ31/IGwUQV2bPFmLNZbFHMveOnVD9e6UvOdeMtObnQglF/lUB1
         28LhYypZOqV9AajfDliKGClJWWfrd5vV+PENh3OCpKZsg2xCvXU4dHcKvAyW11qBZV87
         2kVou0iegLkLZUoyz0K52U6q/8MC7MLBrEhErvRa4YON//aZvzenkZMvX0w2FrEofKUY
         EbsDYzn9MCUeaEcoucbpO7cCEh7lw4tMBSRZNLhFWzCqjQJCxWV9e3PD+2XnX695BsiV
         wK11VYsDDyVfTp1cj2XxGVoLMazQdgIGj/Ps7JOrJdtahzSpf67yL6ipR9IX1P/hmTAM
         wkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274615; x=1779879415;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/NK7+VqvmwkFP9pNkZ80sKNM6xb3H1qdFY05QwDPeA=;
        b=k6z7gwCEWKUEV8xgK7jm/oR5Uk0btV5BMyHqd3RatDNm5TkG4dNswHvf+MPHIKnAW7
         TB39lLderyaQIqiMZrM45bpgwg4kxgQ5J6arYwKKz1TpxVxfFiIe/FuQenkOunQ6WmN5
         J9M8tAgjfnc5OeL3bJ5NzWKUdp6S4//G57B+3sYA8HMoz7NFO5D1BJqsjKfAaGZXzPVH
         Ufkh/43NcLZAmYYciUU12P5BSRMC9YDEKaUmP3+jw8CjPtWq+r2SMP8ikxyhSsxAD/Jf
         11Uk5ekK8RFlzHmEGJXUl7z1tLkFY8zxBIGSHAJgdbJ6g3/f8Xi2Rof/6MQJc3++/CYI
         Sk9g==
X-Gm-Message-State: AOJu0YyubvFAPwgLsn79HVwzlIbRZOog77oK2Gz7JUBwwZbDBMEYwoDA
	i/bQYs2Rol9kPLjHVtfHl/jdozjRL46LakP5M8xSiHthLyiE+i6XyzNvkCWxU6XUc+3u9Up3V+e
	NzPO0GxSo37wgYEVfmk72xHapmBvWvrTZiJBxVP29eg==
X-Gm-Gg: Acq92OF+UHtFSK0baBtI4gg5WxFL1pmCor8Ovjgq7wj2cqQd79Sq1jMWIhh2k5rDdWM
	IIwF6TWUtRepZ776YloQtMg+cVik1M89aHLtUBn/oPMClCY5TmIxpafdk/BQIDujDy8jheCOzUH
	GOcritPewJUMW+yHR+nh8rZ9rFAzxo4VSgGXPX3oATNjWzStMB9W+jY6AWwNXSZf/nFQ2P9NUHi
	9rUuq3LUJd2IVqQkWVDCxHFxSh0enDxDCgq7erbfWx+wKh0sxWNx5kfGtcn6HnblDr6gvRYXstG
	yV0KXGmG9TAYFbFMSjZWuM6856+qV6regMhOxO4xKw==
X-Received: by 2002:a05:6870:418c:b0:439:c546:e9e7 with SMTP id
 586e51a60fabf-43a2dfe2c0fmr15618389fac.27.1779274614658; Wed, 20 May 2026
 03:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lara Hisham <larahishamahmadby@gmail.com>
Date: Wed, 20 May 2026 13:56:43 +0300
X-Gm-Features: AVHnY4JctuSOjnfK2wdQVisqeXlks1B-hpaWlQ-2qbn3zdn_7SLmCBrbZ0OVusE
Message-ID: <CAKCqX5oNwWaY7OMsdN-wJWf6YZMBdbxaDmyonj+bf-Bs-+0Ytw@mail.gmail.com>
Subject: [RFC] eBPF-based production deadlock-risk detector:
 kprobe/uprobe/tracepoint pipeline with userspace wait-for graph and Rust
 runtime awareness
To: bpf@vger.kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi BPF maintainers and community,

My name is Lara Hisham, a Computer Engineering student at Jordan
University of Science and Technology. I'd like to share an eBPF-based
deadlock-risk detection tool I've built and get feedback on the
approach before considering whether any part of it is worth
upstreaming.

Repository:
https://github.com/larahisham/Production-Deadlock-Detection




What it does:

The tool detects deadlock risk in live production systems before
impact occurs. It traces lock acquisition and wait behavior across
three lock sources, builds a wait-for graph in userspace, detects
blocking cycles, and emits actionable alerts with severity scoring and
remediation hints.




Probe strategy (deadlock.bpf.c)

Kernel mutex path:
  - kprobe/mutex_lock: records acquire attempt, detects existing owner
via lock_owners_map, emits OP_BLOCK if contended
  - kretprobe/mutex_lock: on ret==0, records OP_ACQUIRE, updates
lock_owners_map and hold_state_map, builds lock-order edges into
lock_order_graph_map, emits OP_UNBLOCK if previously blocked
  - kprobe/mutex_unlock: computes hold_ns from hold_state_map, emits OP_RELEASE

Userspace pthread path:
  - uprobe/uretprobe on pthread_mutex_lock and pthread_mutex_unlock,
resolved at attach time by probing candidate library paths
(libpthread.so.0, libc.so.6 on x86_64)
  - Mirrors the kernel mutex logic with SRC_PTHREAD tagging

Futex path:
  - tracepoint/syscalls/sys_enter_futex: filters on FUTEX_WAIT (cmd 0)
and FUTEX_WAIT_BITSET (cmd 9) via FUTEX_CMD_MASK, emits OP_BLOCK
  - tracepoint/syscalls/sys_exit_futex: emits OP_UNBLOCK with measured wait_ns

All probes share a BPF_MAP_TYPE_RINGBUF (256KB) carrying a normalized
lock_event struct: pid, tid, owner_tid, op, source, comm[16],
cgroup_id, lock_addr, timestamp_ns, wait_ns, hold_ns.

Kernel-side scope is enforced via target_pids_map and
target_cgroups_map (BPF_MAP_TYPE_HASH), both with a sentinel key=0 to
enable/disable scoping without reloading.




Userspace analysis engine (loader.c, ~1680 lines)

The loader consumes ring buffer events and maintains:
  - A wait-for graph (wait_edges[]) with bounded cycle detection
  - Per-lock statistics: total/max wait_ns and hold_ns, event counts
  - Alert state tracking with cooldown (15s), repeat thresholds
(MIN_ALERT_REPEATS=2, MIN_ALERT_REPEATS_ASYNC=4), and active-block
scanning at 30ms
  - State aging/GC for both wait edges (5min TTL) and alert states (10min TTL)

Runtime-aware filtering: the loader reads /proc/<pid>/maps and
/proc/<pid>/exe to detect Rust async runtimes (Tokio, Actix,
async-std, parking_lot, smol) and applies a higher wait threshold
(MIN_WAIT_NS_RUST=20ms vs MIN_WAIT_NS_DEFAULT=5ms) to account for
expected contention patterns in async executors.

Noise suppression layers:
  - PID, cgroup_id, and comm-based scope filters (TARGET_PIDS,
TARGET_CGROUP_IDS, TARGET_COMM env vars, mirrored into BPF maps for
kernel-side early drop)
  - Profiler suppression: drops events from perf, bpftrace, py-spy,
async-profiler, etc.
  - Static findings correlation: loads a CSV of known comm/lock
patterns with per-rule severity boosts and custom wait thresholds
  - Lock metadata enrichment from DWARF-derived map (lock address ->
type_name, source location)
  - Dedup, cooldown, and repeat gating before alert emission

Additional: a Unix domain socket (SOCK_DGRAM,
/tmp/deadlock-detector.sock) accepts external lock events from a
preload library path, tagged SRC_PRELOAD, feeding the same analysis
pipeline.





Questions for the community:

1. Lock-order graph in BPF: I'm building lock_order_graph_map
(BPF_MAP_TYPE_HASH keyed on struct lock_edge {from_lock, to_lock}) in
the BPF program itself. Is there a better approach for capturing
lock-order inversion signals kernel-side without pushing cycle
detection into BPF?

2. Futex owner resolution: On sys_enter_futex I look up
lock_owners_map by futex uaddr, but ownership is often not recorded
there for pure futex users. Is there a reliable kernel-side way to
resolve futex owner_tid beyond what FUTEX_WAIT exposes?

3. Uprobe attach strategy: I resolve pthread symbols by probing a
static list of candidate library paths. The libbpf uprobe attach by
func_name API handles offset resolution. Is there a more portable
approach the community prefers for multi-distro uprobe targeting?

4. Upstreaming fit: Tools like klockstat in bcc cover lock stats; this
goes further into cycle detection and runtime-aware filtering. Is
there appetite in libbpf-tools for something in this direction, or is
this better positioned as a standalone tool?

Happy to share more detail on any part of the implementation.


Best regards,
Lara Hisham
larahishamahmadby@gmail.com
https://github.com/larahisham
