Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795825130;
	b=u/3Liv0B5sCts/FRoZ0a4NNicO/bMn/ulqJAqLrsS9yPV0iGGOatxzoyBEn2p8gcK+Ge
	 MDxzzHm2UCbAqhPJDRk8+RSvhc/7NpGr6D7yXGMKp6rr2OHU9JppGsMk+f+NSWtiET3Jx
	 c7mb+6NWtqj8DYxTD6jKxi2EhPVu8nYxdajGmiHuhW7TE84Sbd8BQs/S/wbwQACF5sSp2
	 IwOviHISuj8MDP37jaNWk7fjXc5QnpQbo8y0ernkqo5hlSrohchu8bIjyeYHmZPRASAZo
	 qqsRrYaa48ieXfmI+vJOuwhP05o34Uf+vR20Zf71hsmjp8PN2JEU4Y1ukMOYHyEPNDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6OQ2jIXGCbCx2gH2ueOTZDzML7ivwO7Wf75LpMaGfjc=;
	b=dRzUV9fwRlKJA4yR7RoSSlz4oaZT1wtRUIwlZth6OyylOnR7W351RocfXiSq/1nf7BC6
	 IOPSZEpvP8BxKYBWGpDVsKc0+YNZPt5mgxSXhwvr1smole54dt4z1mH5jmSnqaz+SEC3w
	 SjZ50LOvzU9bDB/5hCbf1sTwViqQxWTX2IAH5+Qop/9FpQ85K72UFFx56Y2ta7zKbTPkR
	 pwUi0Kwc5bVVsSQUPH9PJPIwatkoIiwtBzmbXPxEZK5BDNZLdxbh+usNl2MgKKRl4hxuK
	 ABsBt2w8W/0BEo6Pg2dTlFFljK7KgfUnYchLBNafVSo+bxoVO3js+jIeWMg9nm00R5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JnUNTTAg;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FE606A31E
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 00:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D73FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JnUNTTAg
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso3013070a12.2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795825128; x=1796429928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OQ2jIXGCbCx2gH2ueOTZDzML7ivwO7Wf75LpMaGfjc=;
        b=JnUNTTAgGQMnp/NZtz9Q4EbRlnsgRUMB4k9QVABlBtWPPwV5kUIZt/coGm4oTrWT9B
         IFRyVLrNUNigaqA9qlscqhVPd590MwKx+nps6H/xZ4yiU+4DxBXWZL5wuVSKwDUSYKsl
         gJNaYSlLVnL573AUCEAT09jdiVmfFbPu/2DfbEuOklE4Tr0EjZNUS35lANqwY8Lknxto
         WsbzmyFVaZK+zmucVhzjJD+TXZN7AsdgNseURfTrcZIXSZ6ut1RvL//XSUo+EJDCSsPJ
         JOMDhIdRkkW7IPYJq0uUnPKotf1uvJeEqXs0qjCL7NAjlqtWpieswpRfKQuXn0EAexWO
         CUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795825128; x=1796429928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OQ2jIXGCbCx2gH2ueOTZDzML7ivwO7Wf75LpMaGfjc=;
        b=epcTM+1yxtr46p+1KOpq73CXoeH3rPqsUgpg2W2FVu0lJUCPslRFeBzYAYvyxkKKvP
         8NEPMBvnSYTnWAx9jJtbffMLiUX8rUKkdCQ34JaNX+pS897Vzq09rD9RPMDU++D7j6uM
         mIxTOuwEwrEdDD2KakTAcgTv24s1SuH/+HU34I7UEiZsnHEc+4v4lNdQ2tV8pqGP1d1v
         ShD9pBmBtV9auwIJ1Z1icz6ArKvdJLqtC4YRBG6CEKMCLq9c5+QnK6j+hxRNTIsuJr4M
         DYGJQeR/1svgEXnHnfF7EKX57dfIAQcm4FXyfZEXEDLyz8tvqrLNR8ZJUkK0GGreDuK+
         tJ9w==
X-Forwarded-Encrypted: i=1; AL+hErF8HK9EjRLhgceHlyUshYSSlMwFy2ySo22RCjw3zbOrCPoOcaB2XY64zHHPZtKQQ0sOJnY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vXuVCTVSeemQEVskQWt3+UyMFzfaGizJise9LIAI2fpCiAF9j
	Pkwvc3t2bNdLFdvbTDtjbLGVPufZuNWCijKDyAGDFaWrmnwKpuBVKAc/
X-Gm-Gg: AZFdTZf/RSGKKob+sqH6p5cxuwZmZlS6Oukfn1OuALpcD9KhIbp64ig3zLIwvUpD8GN
	ZRgL6w+sLRR+NZtaKdBHovf5XT1XvXo8O1+rfoBpBJ0FThy2uqx4yMZJIm/A+KeZedrOqdlcGKx
	Nm2VuYPpaIiyz6VnUaenu8GZ6tceU/fHGxuWm66lxyfxqoGM3DPNGOaNDUqqZ0ru0k8bQTKyz+h
	bh1ndaCaG8Gmlaz63/1AT+eGus7OsssfkOukEETe6oO2x43FfRVEQnXBnuERw3WstzW/V12dJRr
	GtigwH0bqAaZkWfHZqWC/JRiO8kV8bOPfMfSV4MSWS/c+71Dl2iAEd6Wl8B0kKWoWPl23KdO7zN
	fB0YwwzbakO4KuAbValWF/TSUwCVGZ2SwiWck8HBVrSWoaa1Aofv/9yg6wtQDkXtoKOkMoAcI3F
	+i5aDYbd5CAPmEO0lPJ505lpVTYRW4Dwh87ECFDf6mk3POGzoHFt2OLJByLFPN0Ouxo8SCdpFHw
	AchGza/l2PQ6hX/w/YLRN72m5j7lNwdF3/DUuRbl3FX+hKBD+bT1Y4k0PsdYDMpprGVEJL9gNpO
	/NLaUB/ZF4qJ+xZYVeWRmVfDUIfBg4II1XMX4FtMsiHS8Cl0XL+IwhXyIVCq/XpNTsEGfN3S
X-Received: by 2002:a05:6402:c47:b0:6b5:4baf:ad96 with SMTP id 4fb4d7f45d1cf-6ba37e6ee57mr18746128a12.17.1795825127925;
        Fri, 27 Nov 2026 16:18:47 -0800 (PST)
Received: from localhost.localdomain (17-33-201-31.ftth.glasoperator.nl. [31.201.33.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1ca4ff7bsm4753610a12.8.2026.11.27.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 16:18:47 -0800 (PST)
From: Tom Roozen <rzn.tom@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] bpf: hard lockup with ringbuf used from NMI and sched_switch on hpet clocksource
Date: Sat, 28 Nov 2026 01:17:20 +0100
Message-ID: <20261128001825.38905-1-rzn.tom@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Hi,

A BPF ring buffer written from a perf_event program (NMI context) and
from a tp_btf/sched_switch program hard-locks my machine within about
a second when the clocksource is hpet. On acpi_pm it doesn't hard-lock.


Environment
-----------

- AMD Ryzen 7 7735HS, Lenovo ThinkBook 14 G7 ARP,
  BIOS P6CN22WW
- Kernel 7.3.3-1-default (openSUSE Tumbleweed), x86_64,
  PREEMPT_DYNAMIC (full), HZ=1000
- The TSC is marked unstable at every boot, so the kernel selects
  hpet:

    TSC synchronization [CPU#0 -> CPU#2]:
    Measured 5354294254 cycles TSC warp between CPUs, turning off TSC clock.
    tsc: Marking TSC unstable due to check_tsc_sync_source failed

Reproducer
----------

Source at the end of this mail. One BPF_MAP_TYPE_RINGBUF (16 MiB)
and two programs:

- on_sample: SEC("perf_event"), attached to a
  PERF_COUNT_HW_CPU_CYCLES event on every CPU with freq=1,
  sample_freq=8000
- on_switch: SEC("tp_btf/sched_switch")

Each reserves 64 bytes with bpf_ringbuf_reserve() and submits them.
It reads bpf_ktime_get_ns() before and after the reserve and keeps
the longest reserve time in a global variable. User space consumes
the ring buffer, runs 4 pairs of threads passing a byte over pipes,
and prints the number of events and the longest reserve times once
per second.

  ./hpet_rb 8000 60


Results
-------

Clocksource switched at runtime through
/sys/devices/system/clocksource/clocksource0/current_clocksource:

1. acpi_pm: ran the full 60 s, ~148500 events/s. Longest reserve
   at the end of the run:

     148638 events/s, longest reserve: NMI 0.112 ms, sched_switch 0.159 ms

2. hpet: produced a single log, then hung the machine:

     693 events/s, longest reserve: NMI 500.810 ms, sched_switch 1001.174 ms


Additional test: read_hpet() replaced
-------------------------------------

To check whether the HPET read path is involved, I also used a
livepatch that replaces read_hpet() with a plain readl() of the HPET
main counter.

With the livepatch enabled, the reproducer ran the full 60 s:

  537229 events/s, longest reserve: NMI 0.034 ms, sched_switch 0.036 ms

After disabling and unloading the livepatch, running the reproducer hung
the machine instantly.

My reading of the code: a CPU can be inside read_hpet() holding
hpet.lock when a perf NMI arrives. The NMI program then queues on
rb->spinlock behind a CPU that is in on_switch. If that
CPU is the queue head or pending waiter, its check_timeout() calls
read_hpet(), which waits for hpet.lock. hpet.lock is held by the
interrupted CPU, whose NMI is waiting in the queue without a timeout
of its own.

Thanks,
Tom Roozen


---- hpet_rb.bpf.c ----

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

struct {
	__uint(type, BPF_MAP_TYPE_RINGBUF);
	__uint(max_entries, 16 << 20);
} rb SEC(".maps");

__u64 max_ns[2]; /* longest bpf_ringbuf_reserve(): [0] NMI, [1] sched_switch */

static __always_inline void emit(int i)
{
	__u64 t = bpf_ktime_get_ns();
	__u64 *e = bpf_ringbuf_reserve(&rb, 64, 0);
	__u64 d = bpf_ktime_get_ns() - t;

	if (d > max_ns[i])
		max_ns[i] = d;
	if (e) {
		*e = t;
		bpf_ringbuf_submit(e, 0);
	}
}

SEC("perf_event")
int on_sample(void *ctx)
{
	emit(0);
	return 0;
}

SEC("tp_btf/sched_switch")
int on_switch(void *ctx)
{
	emit(1);
	return 0;
}

char LICENSE[] SEC("license") = "GPL";

---- hpet_rb.c ----

/* Usage ./hpet_rb [sample_hz=8000] [seconds=60] */
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/perf_event.h>
#include <sys/syscall.h>
#include <bpf/libbpf.h>
#include "hpet_rb.skel.h"

static long events;

static int count(void *ctx, void *data, size_t len)
{
	events++;
	return 0;
}

static void *consume(void *rb)
{
	while (ring_buffer__poll(rb, 100) >= 0)
		;
	return NULL;
}

/* Two threads passing a byte back and forth to cause many context switches. */
static void *pingpong(void *arg)
{
	int *fd = arg;
	char c = 0;

	while (write(fd[1], &c, 1) == 1 && read(fd[0], &c, 1) == 1)
		;
	return NULL;
}

int main(int argc, char **argv)
{
	int freq = argc > 1 ? atoi(argv[1]) : 8000;
	int secs = argc > 2 ? atoi(argv[2]) : 60;
	static int fds[4][2][2];
	struct hpet_rb_bpf *skel;
	struct ring_buffer *rb;
	pthread_t t;

	skel = hpet_rb_bpf__open_and_load();
	if (!skel || hpet_rb_bpf__attach(skel))
		return 1;

	for (int cpu = 0; cpu < sysconf(_SC_NPROCESSORS_ONLN); cpu++) {
		struct perf_event_attr attr = {
			.type = PERF_TYPE_HARDWARE,
			.config = PERF_COUNT_HW_CPU_CYCLES,
			.size = sizeof(attr),
			.freq = 1,
			.sample_freq = freq,
		};
		int fd = syscall(__NR_perf_event_open, &attr, -1, cpu, -1, 0);

		if (fd < 0 || !bpf_program__attach_perf_event(skel->progs.on_sample, fd)) {
			perror("perf_event");
			return 1;
		}
	}

	rb = ring_buffer__new(bpf_map__fd(skel->maps.rb), count, NULL, NULL);
	pthread_create(&t, NULL, consume, rb);

	for (int i = 0; i < 4; i++) {
		int a[2], b[2];

		if (pipe(a) || pipe(b))
			return 1;
		fds[i][0][0] = a[0], fds[i][0][1] = b[1];
		fds[i][1][0] = b[0], fds[i][1][1] = a[1];
		pthread_create(&t, NULL, pingpong, fds[i][0]);
		pthread_create(&t, NULL, pingpong, fds[i][1]);
	}

	for (int s = 0; s < secs; s++) {
		sleep(1);
		printf("%ld events/s, longest reserve: NMI %.3f ms, sched_switch %.3f ms\n",
		       events, skel->bss->max_ns[0] / 1e6, skel->bss->max_ns[1] / 1e6);
		fflush(stdout);
		fsync(STDOUT_FILENO);
		events = 0;
	}
	return 0;
}

---- building the reproducer ----

clang -O2 -g -target bpf -c hpet_rb.bpf.c -o hpet_rb.bpf.o
bpftool gen skeleton hpet_rb.bpf.o > hpet_rb.skel.h
cc -O2 -Wall -o hpet_rb hpet_rb.c -lbpf
