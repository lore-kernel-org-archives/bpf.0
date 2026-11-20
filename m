Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158957;
	b=cdHCK0t9GtOCbFGOWTPosbZvUI9mbz77VlX5IYUh/A3rsfl1w1RWPiK/czY4o0gMskyd
	 nHaEQF4WjdMPFBpbXNNBQ+u+euS8tPs85lKlHCoG3rez2vkb0pg6hx0RetTiQABajt6Md
	 RU+fd4fpY3YK0y/IOnjI9qTuOKKatnlYcRCKWlL78kW55G6SodBAuMw0rcRHHZfjuznbU
	 FC4qD+yILCDWDIi8XVQjxPCZUwRcTdUnI1Ji/tBav3aipuK+pujD5+N4e6qr1X2V9VbKT
	 OLJYyuU2b6rpeOHJ6YJPOTTOq+lwrFB205JOx1mmj/dF+t2uho6Bf/QkGpOAoAD71YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158957;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=MpSejgr2yOWVjUY3TJB4/bXQFGqhZdUZzWXieqZDX5c=;
	b=ThT3iiLE5/ujxN3kb65Hb/yNb5ADkjrJjmUwiEAUHtdrD3+hILO4/+4yEi26Au46mKn9
	 /HSriK2LV53SOKD2QYBaOfJUoNWz4fStb6uLebwrfJNDMtAQADLnJvYHe6pDktOiZWsHJ
	 shjiF3rEDUMrGHH/7/J/BcXhcGx2cNjbpUsFRi3i9L+OqOpf/3Pb2hjf6rTp2T71jScns
	 LjUf8l+pmIIaRYt7hOsR9pUzNI2wVG8XdPVy1exnokR5Eb9MSYZ/AR+rwV1HM7/UnKV1q
	 zEHE2KJ9r5SNr094zOCjWB09w9Fac9PkfUxoqFhZL4B7meKpA89f1Tk14pIUqgqGy+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15EF606A33E;
	Fri, 20 Nov 2026 07:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D15EF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jW66S6z45z1xr2;
	Fri, 20 Nov 2026 15:14:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 948114056B;
	Fri, 20 Nov 2026 15:15:51 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgA3dfSm8_9qDM9HFA--.40246S2;
	Fri, 20 Nov 2026 15:15:51 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH 0/3] Introduce a classic BPF filter cache for seccomp
Date: Fri, 20 Nov 2026 06:48:49 +0000
Message-ID: <cover.1795139109.git.xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:gCh0CgA3dfSm8_9qDM9HFA--.40246S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW3CF4fAryUWry7Kw45Jrb_yoW5CFWUpF
	W5G343KFn5JF1xJ3sFv3yUKF1rWr4kXr15J3Z5Gr9rZr1UKryjgaySqryYkas8Ar1Uu343
	ZF1Dt3s29a1DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

Sandboxes like Firecracker use seccomp filters to restrict allowed
syscalls. Hundreds to thousands of Firecracker VM instances can run
from a single template. Each instance loads identical seccomp filters.
The kernel repeatedly translates and JIT-compiles these same cBPF
programs, wasting CPU cycles and slowing down bulk startup of
identically sandboxed workloads. cBPF lacks dynamic instruction patching
features like tail calls or tracing. Its JITed instructions remain
immutable at runtime. This makes it possible to share the same cBPF
filter between different processes.

This series introduces a classic BPF filter cache. It is implemented as
a hash table that maps user-space filter instructions to the prepared
bpf prog.

The cache lookup occurs before filter preparation:
- cache hit: Returns the shared bpf prog directly.
- cache miss: Reserves an entry. Concurrent tasks loading the same filter
  wait on a wait queue until preparation completes.

The cache is instantiated per subsystem. Currently, seccomp is the only
user.

This series ends with a benchmark test. Every producer spawns one worker
thread at a time, the worker installs a batch of filters and exits, the
benchmark reports the number of filters installed per second. The table
below benchmarks the batch size and the instruction length in one round,
running the command below with different option values. The base column
runs the same command on a kernel without this series. All data was
measured on a local test setup with 32 producers.

$ ./bench --producers 32 --duration 10 seccomp-install \
        --sync-mode yes --filter-len 128 --batch 4 --same-filter yes

batch  filter-len   base      cache hit            cache miss
                              (--same-filter yes)  (--same-filter no)
1      32           0.044M/s  0.064M/s(1.5x)       0.040M/s(0.9x)
1      128          0.043M/s  0.062M/s(1.4x)       0.039M/s(0.9x)
1      512          0.037M/s  0.052M/s(1.4x)       0.034M/s(0.9x)
1      2048         0.023M/s  0.037M/s(1.6x)       0.023M/s(1.0x)
4      32           0.065M/s  0.187M/s(2.9x)       0.059M/s(0.9x)
4      128          0.062M/s  0.190M/s(3.1x)       0.055M/s(0.9x)
4      512          0.052M/s  0.167M/s(3.2x)       0.046M/s(0.9x)
4      2048         0.030M/s  0.119M/s(4.0x)       0.028M/s(0.9x)

On cache hits, the cache delivers 1.4x to 4.0x throughput. Hits bypass
the translation and JIT compilation pipeline entirely, so gains grow with
filter length. The worker thread setup hides the win at one install per
worker, a larger batch amortizes it. On cache misses, a miss costs a hash
lookup and an entry allocation, the throughput degradation stays within
about 10%.

Xu Kuohai (3):
  bpf: Introduce classic BPF filter cache
  seccomp: Use the classic BPF filter cache
  selftests/bpf: Add benchmark for seccomp filter install

 include/linux/filter.h                        |  25 +-
 io_uring/bpf_filter.c                         |   3 +-
 kernel/seccomp.c                              |  12 +-
 net/core/filter.c                             | 318 +++++++++++++++++-
 net/packet/af_packet.c                        |   2 +-
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../bpf/benchs/bench_seccomp_install.c        | 249 ++++++++++++++
 7 files changed, 604 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_seccomp_install.c

-- 
2.43.0

