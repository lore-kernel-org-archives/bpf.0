Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122767;
	b=FAj/Po98CvXU+f76l7Vgv3USkc/8vdUQFULvYTVyqGwmMFZSyJO+pV1O5NxO2Lg2UksL
	 i5DSoq9iWImr1dTengBe1FHj7daYkRF3bMi5iycPsYvTDMiu1jQDQvNYfIRhyetMQpDmS
	 mb3A6dmmE9sRi/jyXRnqFufRDhRKfj5JI+IVTklY2VZh1VgHufc+aXnxc64fT8zjDsm1L
	 El9kAYF9qZTgFeB48mzxIztLEqpHSrQ5TN4lKg6WE53jayvc4b4qdkbmVKWEWDLfSwohE
	 i8vSOWMMa3r2sMyITT2Gp5l7mkp9p08x0eqPW/G9kinDeFQoRV+LdoHXhjkLauTvsmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122767;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eFBb6ww+Wb+6PdEHxVs1dSR/RKz7OHK6jA6P8dpfeI8=;
	b=xksFmvbQPbzyqBrmM9OJhfBpWzPQeqd4Fmm28de9pNhGC23vfiG3ksPndcxWFkuhXyWA
	 xVUQ8mLoyh0aOarmVfWBYLLHPHVl6m2khRqB1AlL1keEIvbRojJBgpVepvbGm3YzjvDmJ
	 NTHAM+YqvUp8Jq2PUOzs1o5kp7MgeXS4Kv5h+Qx8VBpcPcHxK6ZirbQWba4w8cVjVBTdX
	 89BcNRUxZPAZxUoImFWZpAnt4XhoK5wvWOjLDg1b1/AL0h73xgpB7raCdYuHtKzG2rzOv
	 iyh4iy3GjXkK1u/ATCMatvdhzD2vioOTsM14dFh2iYQxyohCZqTt6lKo91zSFeSm5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uuZE5VTf;
	arc=none smtp.remote-ip=95.215.58.111
Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA73606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 21:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA73606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uuZE5VTf
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bX3h7nqhm6aGMMG6byO0ihikKXGFd1peo37c3lSGR8s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795122764; v=1; x=1795727564;
 b=uuZE5VTfQGjRZ1L5SBsNVwEBKtSZZ/861ylL/ZXRi7xAVdzBJkI8sAz7LfbbeBlKihBb7K7i
 f4bHdR1gd9D9c/4hiBU0KUdfhqZcWLE5vWSubbPvtAzb1QJzYcnMBtzj5Evr3zUcMvea4YYL7Bu
 gLIhN/i5HHKSK6c3XZt86PrU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1079ed9eecef3a2c;
	Thu, 19 Nov 2026 21:12:44 +0000
X-Mizu-Trace-ID: 1079ed9eecef3a2c
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rkeilty@meta.com,
	atish.patra@linux.dev,
	dgreid@meta.com,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 0/3] perf/core: Fix software event sample data, then stop zeroing it
Date: Thu, 19 Nov 2026 13:10:43 -0800
Message-ID: <20261119211235.99805-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
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

do_perf_sw_event() builds samples for software events (context switches,
page faults, ...) in an on-stack struct perf_sample_data. This series
fixes two bugs around that struct and then stops zero-initializing it,
a 256-byte memset that every context switch pays once a context-switch
counter is open anywhere.

Patch 1 initializes the struct for each matching event. Today a sampling
event inherits the sample ID, timestamp, pid/tid and callchain prepared
for the event before it, and sometimes a record size smaller than what
is then written, overrunning the records that follow in its ring buffer.
Two concurrent "perf record -e page-faults,context-switches -c 1 -a"
sessions make the older one fail. An unprivileged user's page-fault
event can do this to root's CPU-wide session. Broken since v6.3.

Patch 2 stops BPF programs from reading an unset data->addr through
bpf_perf_event_data::addr. On INIT_STACK_NONE kernels this returned
leftover stack, mostly kernel pointers, on almost all context-switch
and cpu-clock samples in my tests. INIT_STACK_ALL_ZERO mostly hides it.
It affects all event types, needs CAP_BPF and CAP_PERFMON, and has been
there since v6.1.

Patch 3 marks the struct __uninitialized. On every path from do_perf_sw_event(),
each field is written before it is read, counting events never read the
struct, and it is never copied as a whole, so its padding never leaves
the kernel. A privileged BPF program using bpf_cast_to_kern_ctx() can
still read unprepared fields, and would see stack contents instead of 0,
as it already does on INIT_STACK_NONE kernels.

Patches 1-2 are for perf/urgent and stable, patch 3 for perf/core.

Performance: with sched_yield() ping-pong on one CPU, software counters
add on average 54 ns to a ~627 ns context switch, and patch 3 brings that
to 44 ns (10 rounds, spec_rstack_overflow=off).
 
Usama Arif (3):
  perf/core: Fix perf_sample_data reuse across software events
  perf/core: Don't let BPF programs read an uninitialized sample address
  perf/core: Don't zero perf_sample_data in do_perf_sw_event()

 kernel/events/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.53.1-Meta

