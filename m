Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074384;
	b=l+M/SU6bZBGELqhYlYRUyxi7AqvbfILaRyzc2I5FuR13xNtkB7V2uJA4UO+2cHLHQcGC
	 LHa7mtUMozDu7E23qg1GCjECESKQPo19XI1TcolWad6PYJcWT+W8MvNs2x5mf/TYLfXxB
	 5ieiw6X8I+Cn2TG1mpre5bE8Xkg/Se9YfDmYVv9LayvmWBzg+F7FUUf6Bb+8g21rb/SJd
	 3cFxMo/PjKILHe/f48Xbr/3ye5sdEFgSE17bs2faM8DNVVc2fuut2kqBK3hWW5+/q2wJ5
	 vnK61dhCjxF67Ahd3e4yVz5KmL2flpxbg6LCY3eP+CwmF14vv0HF+jSMOpR1NhdF2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074384;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=bGepyAYVEqnlKtLsoUC51vfuL8x0qiUkny6Ci/G6J3U=;
	b=wNbwXl9nIBIlY+cx1VIkD3QpD8JpW36Kp8zLOV+IqBUb5w8AIodSzP/XjBnWtkVdizWP
	 la22iKVr6rcdROTd9AdTw/7E7leMvMVu7H4eKoWywlEO60E3cuDRSLzACAh3/xDfDaFWq
	 SegAYSrmznFwmBRSCsEV6o4ndrlPbrKeuqMAVhGt2FcunSrMwpSy9wkPQzsvclli5rO5o
	 Vxj+1oOZgC+zG+T828Tj+Kf/DePfbyBz/F/Ixu2zkUnuzC25og+oOB1nOQzDbUe2j4hJc
	 3lmx+J/KT7unqfTLE1X9s5xtkYkRcyOlYGlbDzyXfoDsTU9jvA3DSJ1JSekDqbX412A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b="Mt/7ZFwO";
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52A606D811;
	Sat,  7 Nov 2026 17:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F52A606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=Mt/7ZFwO
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhN-007oUJ-R6; Sat, 07 Nov 2026 18:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=bGepyAYVEqnlKtLsoUC51vfuL8x0qiUkny6Ci/G6J3U=; b=Mt/7ZFwOmJ2rkTAeItS9T8hfdD
	qirpYNVLVnMJzAu614dofN5MYpV3oc0QhQazqdilxE4FURcqyh6paUP/2gzv2CKkiIf0Fb/rYjGC6
	CvLGL8nww71LkGOObn2QsPpqvl+qz/rV2zAGlADiCx8rRtK/IfqnRENN1IdLSgfeXiyTHN7972Qhl
	6LpDmxdjjlK/HpFZvoBIf30MZIRQkGD9bvmq4PtNMGS9X8BMI9fTEJ5sB7KuCIgpxWmltejuRk59Z
	ltA2MWWSmTX87aGQj7Iyljh4Ek/fBNn7FPdjpoSsbbcnRbvzPU3ahHbtEFWZ9BNVREE9IUlz2g5Ai
	2kgrpyZw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhD-0006IL-Fw; Sat, 07 Nov 2026 18:59:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkh4-007LnK-Uj;
	Sat, 07 Nov 2026 18:59:11 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:26 +0100
Subject: [PATCH bpf-next v3 4/8] bpf, docs: Document BPF_ITER_NOSLEEP
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
Message-Id: <20261107-sockmap-update-limit-iter-v3-4-7c0bad1ad036@rbox.co>
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

Commit dfcd17659112 ("bpf: Reject sleepable programs for task_vma
iterator") introduced BPF_ITER_NOSLEEP, but did not update the docs.
Mention the flag in bpf_iterators.rst.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 Documentation/bpf/bpf_iterators.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 72435e32ffa1..c534215f05de 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -351,9 +351,15 @@ The following is the breakdown for each field in struct ``bpf_iter_reg``.
        the bpf iterator.
    * - feature
      - Specifies certain action requests in the kernel BPF iterator
-       infrastructure. Currently, only BPF_ITER_RESCHED is supported. This means
-       that the kernel function cond_resched() is called to avoid other kernel
-       subsystem (e.g., rcu) misbehaving.
+       infrastructure.
+
+       BPF_ITER_RESCHED
+           the kernel function cond_resched() is called to avoid other kernel
+           subsystem (e.g., rcu) misbehaving
+
+       BPF_ITER_NOSLEEP
+           ``seq_operations::show()`` cannot run sleepable programs
+
    * - seq_info
      - Specifies the set of seq operations for the BPF iterator and helpers to
        initialize/free the private data for the corresponding ``seq_file``.

-- 
2.56.0

