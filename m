Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6C43CED1
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140389; cv=none; b=A337ezUPjaQOwMeeRoKF0psqCFyG7X9WbWfOgnnZBPS+aOSFkE5s103xS8zQy1Hf0vqXX++8fzy9UyknesDsZkn+ZzCGWL22YtFcJESlkYA2eOmaO7MaVFn8p0NnDMp18qk0tSw7X6023pCXBB97WN/f8lLeETmo+c+5jtHNUPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140389; c=relaxed/simple;
	bh=Z7IEfLEm2NSKQ/Hm6w2MDipmn27AkA+2R/Dtftjgb/8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fvv3eYxb5MQLguZQM7yy5o8uCKKPdeL0pEu2Y2bly2JSXzWCW0nR0hXCVJ0odCMj0xVN0zu/HR0qicWfmkLZkiMq8kROBzIep2lz3T4iEasouqV/Y/bdGmvn+CSn5+NLZGfa2HaKLrkG3O5v2l9b6IGvLrS2MZh2H3O/twPBloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dhJ386y5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dhJ386y5"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-386fb2c31e2so12122681fa.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140384; x=1772745184; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V56aujRPERyoCLJD1JZX+RLV6JuIYVjtI+SIgQdcX4s=;
        b=dhJ386y5JwUgbX3pj6qc7nCFh6Asb+nqK6FV5icBYmilQmghPVTskhk1XgotIsvfkI
         jjEjWssIhwQXjtcS13TwFe2ix65OU8PZoZAk8/04Kzqjsryo2xMeieZhzlwN2ivqtf+B
         hs6caTR22ldSt0NPg598MSKUXFQnXqmIowFtN4Wl7jVRaxcXe3FjnIU3WpmMWiBTI6O8
         b6N1voEkqqgRfCDiiwZ6Zn09MEsem8OU/2eAoUxi1XnN8MGycQG0JHfGiSvcrvqyhNRb
         Yum4cB9kykNsy4e/QppvgDmnkLnTa965CwbqlncB4zceWU3Fcqsm1IzEfRmxVI+7h7gR
         eNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140384; x=1772745184;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V56aujRPERyoCLJD1JZX+RLV6JuIYVjtI+SIgQdcX4s=;
        b=OsaZ8O60WqFlATuYAdpxlaYLKp6yg+oHFmxoyf4NYbbS3kqZKU3I71HbULlXN7ZjDX
         +udI8cquvEt3LG5105+1I0hKHO1lJEAelcK+OMnthh/0pxT7j9h3arvnXcWAnGMk5px6
         sZOCiM6evYl9rrgv4RtPEBtU6yFnLFB1kwS3hykf3ykAVIuH3db6jl5SnpUctx+J0as1
         xvYz9kXfZ38iYERqkOPfc2PMiPDw7+3HBaK0TY7jujyYRetP0nfStRlUlWx/R9Umf6gw
         5Gx4yvZtCcPNq+O58ZL2Rpfejmoi2oVs2QgsSHMcRpmcUsX4QOfCJ1xU8un4KAc+LN6e
         YoQA==
X-Gm-Message-State: AOJu0Yza1+pX9iowxDYGrOZKdoWh4cD8JpmYJgZPdLtPbRq6//IHDk/d
	IciKMst1QqyaMzXdfSkV6A0ev3ZjVMDohurmbLK0UiBrlJqD2jCNrDaWReolSPrDeQ4=
X-Gm-Gg: ATEYQzxK8KN0wL74wHol3wTdC3Z+4ro5OpY9bAIyL5eBQLf3+JzQ6cVzTMQJTG+ZVnw
	TC4YWX7zlmjrkTi6H3n+LzinuxlHdYNPClGzuLWWyQ7nq7KfcnXuHvHS0FSQqJZkT+yEfLaB6G3
	8sSnwWIWYelRguN1VxyPPbjxeygMoLECIZ98sXaN9YLbtZMwqYcDFpjmFi5XO0RnNakSufSo8x5
	mtlnVdCMlljEzf2aXcRpwsjzTfw9WcjiiRqJLvBnC+XXB0kV29moRMakNV1Ri1ceGcX2qKx9hsg
	+R49WX8QJJicEvfLasjDeYvPsczNwZSSofDUSADgOlYku90tVmhVcLf4UcG0IG/9IB5uY1R7Qhd
	f162TgKmuG16IQierbbTwODk/abnDVFbRfSBx0CnZIb7Z4lom6F8tg/eWx2BmSPp4Kp0cSzSR8+
	VSGHQH9HwWOr7lF6ZxsIYodubtipHqLjE2AZGP9V6vS1LSz0eTvFoLeZMvHVTG/q/ak4fr
X-Received: by 2002:a2e:990d:0:b0:385:c314:2ebc with SMTP id 38308e7fff4ca-389ff137201mr1288151fa.11.1772140384035;
        Thu, 26 Feb 2026 13:13:04 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2f62d25sm10158451fa.17.2026.02.26.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:02 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
Date: Thu, 26 Feb 2026 22:12:51 +0100
Message-Id: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFO3oGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NL3eLsJN2c/OTEHN3ikvyiRKCCpBQLIxNjU7NUk7RUJaC+gqLUtMw
 KsJnRSkFuzgpJBWm6eakVJUqxtbUAgFA3MnEAAAA=
X-Change-ID: 20260119-skb-local-storage-bd824356e4fe
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Previously we have attempted to allow BPF users to attach tens of bytes of
arbitrary data to packets by making XDP/skb metadata area persist across
netstack layers [1].

This approach turned out to be unsuccessful. It would require us to
restrict the layout of skb headroom and patch call sites which modify the
headroom by pushing/pulling the skb->data.

As per Jakub's feedback [2] we're turning our attention to skb extensions
as the new vehicle for passing BPF metadata. skb extensions avoid these
problems by being a separate, opt-in side allocation that doesn't interfere
with skb headroom layout.

With the switch to skb extensions, we are no longer restricted by the
features of XDP metadata, and hence we propose to extend the concept of BPF
local storage to socket buffers - skb local storage.

BPF local storage is an established pattern of attaching arbitrary data
from BPF context to various common kernel entities (sk, task, cgroup,
inode). It avoids some of the limitations of XDP metadata, namely:

1. Multiple users can allocate space for their data without the need to
coordinate. BPF local storage solves this by allocating space for each
user's BPF map and its elements separately. This matters when independent
BPF programs owned by different parties (e.g. a traffic policy and an
observability tooling) both need to annotate the same packets.

2. Lifetime of metadata is well-defined and can be precisely scoped. By
default, skb local storage is scrubbed on clone, tunnel encap/decap, and
netns crossing - matching the skb extension defaults. In later iterations
we plan to let users relax these defaults through BPF map flags for packet
tracking use cases (see Future Work below).

However, with flexibility also come downsides:

BPF local storage is not allocation-free like skb->data_meta area. Creating
the storage imposes additional overhead, which translates to skb processing
latency. This is especially painful considering the relatively short
lifetime of sk_buff objects compared to other entities like socks.

The overhead tolerance for this naive skb local storage implementation
depends on the pps rate and whether skb local storage gets created for
every packet or just some of them, for example, when sampling or tagging
first packet in an L4 connection.

Our initial rough benchmarks on a VM with kernel.bpf_stats_enabled=1 [3]
show that running a tc/ingress prog that creates skb local storage and
writes to it amounts to ~330 nsec of per-packet overhead.  Retrieving skb
local storage and reading from it in a cgroup_skb/ingress hook contributes
an additional ~115 nsec.

Rounding up to ~500 nsec per packet:
- at 100k pps, that's 5% of the 10 usec per-packet budget, but
- at 1 Mpps, that's already 50% of the budget, which is not acceptable.

While definitely not suitable for high-pps flows, the naive skb local
storage implementation is arguably acceptable at low rates, for example
when you need to attach metadata only to the first packet of a TCP/QUIC
connection or sample packets at very low rates for tracing.

From this initial implementation, fit for the low-pps use cases, we would
like to work towards lowering the overhead to enable use at higher packet
rates as proposed in the LSF/MM/BPF topic [4].

Future work - in the next iterations on the RFC I'm planning to address:

1. skb local storage copying/uncloning when user opts in with BPF_F_CLONE,
2. opt out from scrubbing BPF local storage on tunnel decap/encap,
3. opt out from scrubbing BPF local storage on crossing netns boundary.

The (2) and (3) as needed to support packet tracking use cases.

With this early posting I'm looking for feedback - is this going in the
direction that aligns with the maintainers' and reviewers' expectations for
the intended use of skb extensions and BPF local storage?

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com/
[2] https://lore.kernel.org/all/20260108174903.59323f72@kernel.org/
[3] https://github.com/jsitnicki/skb-metadata-tests/tree/main/skb-storage-bench
[4] https://msgid.link/87ecmffopy.fsf@cloudflare.com

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (5):
      bpf: Introduce local storage for sk_buff
      bpf: Allow passing kernel context pointer to kfuncs
      bpf: Allow access to bpf_sock_ops_kern->skb
      selftests/bpf: Add verifier tests for skb local storage
      selftests/bpf: Add functional tests for skb local storage

 include/linux/bpf_types.h                          |   3 +
 include/linux/skbuff.h                             |   3 +
 include/net/bpf_skb_storage.h                      |  21 ++
 include/uapi/linux/bpf.h                           |   1 +
 kernel/bpf/syscall.c                               |   1 +
 kernel/bpf/verifier.c                              |  67 +++-
 net/Kconfig                                        |  10 +
 net/core/Makefile                                  |   1 +
 net/core/bpf_skb_storage.c                         | 264 ++++++++++++++
 net/core/skbuff.c                                  |  15 +
 .../testing/selftests/bpf/prog_tests/skb_storage.c | 405 +++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/skb_storage.c    | 312 ++++++++++++++++
 .../selftests/bpf/progs/verifier_skb_storage.c     | 209 +++++++++++
 14 files changed, 1313 insertions(+), 1 deletion(-)

