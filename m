Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795249735;
	b=biIc8+e0WDzMtO+zQsz5oR7YwHKG+ViKaIc7e8QdRO9gr3c/EaxThi0akEQi1cAMMeeU
	 yM38Dc4l79nnf6G2LYdKDlYDsbMmiA2urkC/UJ7/f8BjwsFxew/c8w8CFaG/u96wF6d8U
	 VA2pyTvGMv8j6T7nCS2ZMAK3yUPij2yMxLjNF3HdDg+O2xFfEya1DE9gZ6SNm7B2ggYYX
	 DYqZ+zIgl/IsA9cDdVV9Hq2ToxWQaUTpaEuyeC5hIUeKuuo3zph4AKyDDRDLGW5vg7K/C
	 yWLtKzjzaFPnizAhOup+ti6DfDyAEH+hkh5xmPFRvXBmWyABUo/xU/YGzcmbpS364Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795249735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vA0VgrN/AJbvlL7DFILZtRf61HlqOG1LXfr01uh4umc=;
	b=eRXNTzclCNAq+12teNuAbvD9EasmtRa1SVMk+jxTINWmlcXazZH/BHCGG9HcyG4UO7tD
	 IYVRbA1NIw/boWIZMAjZmF/4QvzLOf6B/QenEn5Owy6sEj5T+fVpNYBZUCo/D4oAtQ0k/
	 o4BHE/w3YFb92gU0fvONSWAnuQF368V7UJ/vLOpXNP+M2MpAjWY3As1YvEyvKy4ZQp+nf
	 YbHrDpaR/f9Hs9Et9egzSRa65CStbvj2UBk3QNWRsLhAQCEInQvPLJSZfzf8fxmcPkG72
	 Hp8vEpf7fTAghY4JiJ1Aa5lXkD96IhK2yjL27Htcw+ai1i8fNzTJW8knkHHn2JvYWCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JWTvHv2M;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86963606A32C
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 08:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86963606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JWTvHv2M
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a42b34e930so1416921f8f.2
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 00:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795249733; x=1795854533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vA0VgrN/AJbvlL7DFILZtRf61HlqOG1LXfr01uh4umc=;
        b=JWTvHv2MoSyG38P2ut6CGuOo+RMs6DecQiq+J9y9TQm+XNetpG7gWzCduF+1Dq+EcA
         Y3FOLIeetVe7r6I7AkfF3FK/laIIZPksmjpIosdGBa3KNHqZUb+OZKE+yM+md43V29w2
         sovrWZbaKaw9XEZHUAgcsp3KxNw5lz/6bbZZEGeXpRPcTr8OJMWGps9G3UBVpq/fZnXf
         Els2ob3iY6686NjEuUwxO4w+d3OEy5z9s2KtJHmHa57HDi3rGQggnI0NaEjh365jLsnZ
         V1namk7Gmdj0DXYajWjOCesPRxk5t7JckHbva5Y3AzE/T0AJmDsb7dApwqBH9cY66ciZ
         rdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795249733; x=1795854533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vA0VgrN/AJbvlL7DFILZtRf61HlqOG1LXfr01uh4umc=;
        b=CetozS72zu8kN8Mn6A1cnGwSkBI+2//lUExuBHVVC7zBjaMd85JfAx0yWDgpbHP1zb
         oetY+qPr0W/EPZV8mzjhF7F2AvjlAaCa7fWBZaU+oDl74758koaiYTAObEboB9G08rza
         Ik+7iLn3Du2wYKaGgEREtU0dXCPhAbJN9ZZYounVeGoMChhjkhIPoTW7k0TpAt6bU/n+
         I8dCls9XLW9QWeSetICE/Hhz/Vyj6gHbYRIlr1ka+XrYT+Fd0QFxTOWThTbzp7NQcq9k
         Xg5PgHt73Xiv6kyUUf8AB//R+bnAbhkaTiNJ7DIdwdji2zmnvb2nfqU6V+ojDLrz40yf
         WS3w==
X-Gm-Message-State: APuU4Z/WgRm13GFYKm+XnFD4YYyB0e57eSngk3cgTwfVOGN3i3zN36GZ
	wLBMotOnqddL7SSpp09lFA2fgKFwZtK/9nIIfBe+8MiZhS8fniHEosVxOdhfsTOGDrk=
X-Gm-Gg: AZFdTZdU6NpLBpEjJ0fndLgYypX3u0brsJTuLrGFpjCZaKnDrDlRnvbJYSlnG/VEQNA
	X6AZOM5xAa2t4M8isJGFlQxsErGxPrSqfVYGHyba6i69lc7aP+1iY/ijDmK1Bp7DLFss/+19oe0
	o+nAB9PiBBixjwETnhLw2RMxvfo1hez/k1wiwBBvsiopvUR+vjekw2yPh3T0c25VjBaXDPuGAFh
	v6NrQ8JNuX0mJ4hPra/8zlKHzislJY2X627rMaSRs75DeG3t1RgVTTr5jKxgvbQxBfD4PuDTrgm
	uyr36x0Y2rb1/4rgv1hBcgmyxT/Lg9+M1o0iVjafvn05Cp/yfydR4Vz+yzyGC2jqrTs3W7m/G+r
	1AxGoW/yftGdXw7QBheeYjlWu1O1iWS4P4axYNL++EuHpjiz9tLckSiwVWq54/l+L9TneVwO8Qf
	Yfkk+nIXPOh74sXZw/EiYOJpGpg7u2OlcITU+aWMUCkQONvgL0WTDYHd/9rYDsOEb+USf7iEvZD
	gaosDKOaupUBTRKOkhr+LIXIlwGsMDueEW4cWoDFuOd+z5ZqxXQ2Gaz2cbW6jiB7s98i4zpybAK
	2vVnvM2A2ZHqA209c9LyXrRAy7ACCqEL7srGQX+b6shY+2E40gzXTHwza5gGIt/uZSJ3vqZFWVe
	q8266qJIe2z7GHCupigwySVopOcXnPuWc+pKoZFylUmt+yYj+vkhhaJE8Y0c5gnO3YirX2w5QSi
	v7HzzNqIEmJZWYv2h+zvnnq7tEGso6yJpE
X-Received: by 2002:a5d:59c9:0:b0:4ab:f5b0:a7fa with SMTP id ffacd0b85a97d-4abf5b0a975mr10806542f8f.33.1795249732684;
        Sat, 21 Nov 2026 00:28:52 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-aeb0-6801-ad74-bca0-dc5f-7242.310.pool.telefonica.de. [2a02:3100:aeb0:6801:ad74:bca0:dc5f:7242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm10892378f8f.4.2026.11.21.00.28.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 00:28:52 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: bpf@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next] selftests/bpf: Disable preemption around css_rstat_updated()
Date: Sat, 21 Nov 2026 09:28:43 +0100
Message-Id: <20261121082843.44614-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

cgroup_hierarchical_stats triggers a lockdep warning in
__css_rstat_updated() on PREEMPT_RT. The counter runs at the
cgroup_attach_task tracepoint under spin_lock_irqsave() on
trace_cgroup_path_lock. On PREEMPT_RT this leaves preemption and
interrupts enabled. On non-RT it masks interrupts, satisfying the
assertion.

Disable preemption around css_rstat_updated() so the updater can queue
the update without being preempted.

Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
Reported-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Closes: https://lore.kernel.org/r/20251119111402.153727-1-jiayuan.chen@linux.dev/
Link: https://lore.kernel.org/r/fmey2ektwdk7l5aktjz3xb24x3pk3lxy3gfld7reazal6xa6u2@tmryedehqhql/
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Assisted by an LLM.

Ran test_progs -t cgroup_hierarchical_stats on bpf-next 9867c61abbd4 in
x86-64 KVM guests with lockdep. The test passed on all eight boots.

  Boots with an rstat warning   Before   After
  PREEMPT_RT                       2/2     0/2
  PREEMPT (!RT)                    0/2     0/2

 tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
index 8fc38592a..d4babda81 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -76,7 +77,9 @@ int BPF_PROG(counter, struct cgroup *dst_cgrp, const char *path,
 	else if (create_percpu_attach_counter(cg_id, 1))
 		return 0;
 
+	bpf_preempt_disable();
 	css_rstat_updated(&dst_cgrp->self, bpf_get_smp_processor_id());
+	bpf_preempt_enable();
 	return 0;
 }
 

base-commit: 9867c61abbd44f7053a871566b3d982f62c6d8dc
-- 
2.43.0

