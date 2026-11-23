Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795438145;
	b=XPjyajTXUwH2wPsiKGz+9CkHFaqzo33q4YkSN2NWykD67ipGl/V89QdS2HurvFSqOZuO
	 wyTl9H8crHtBb4OhnDQMC7+7EAIaEWrN5xqSNSOlcOuOBm3LDwuwMyTeAbwP8gfb+86rP
	 ahGUBbj7bZ+aYKAeoQ9VnJHGWIvln62M7poBb5JblUoAIQxYv43E4BN9ZgO2IwGuOfjzC
	 32oLAV0xdCoNy92bVIg6dwGR9j2NXCyJvlDCCn5MkqsluQcY06Zf7jaLTBTNQzpHPO+nO
	 iolI4GpHVMaQSjaiufxLlc8Kx5kcSUnZt6Uur0NbLc/Qn1R13geXgAtubugO6SEFf8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=kFSS5Lpx23772o0jxHiqpcMGc1EZfFQoRb+B8VLiMXk=;
	b=JE4yK+zThwZMA8Y1nNboMQDW6bH4aQxW2nRupZEfpcXFQuQ6CkHG+Yv3wwaYHVbXFfwV
	 rV39NwwDvxTt+Cdbn2EfPjGa1W9MMYqpwI8mg1zLkQsZP8Kvm2PxDTSMMIpfRnb4CWbwK
	 N4wK96CyVdWXFVCjBZXQOpj46KCknjQJ6qrqIKFxDYX8ENcgizfPisN+B0PlWxdGKNrSn
	 2ngdnG6/xOn9woDpzw/5X1SUMNxX92lzR1u/o2pzhSYQ+SduZZavginZnbwjglqpnPq85
	 NsRKOtUNXeBXelytW+UllQ+KGVETDefnEVKSwq9mMz+KKkTgBJJAmSb/Sjq6KaSXvCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=IrLGZGTM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C4606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=IrLGZGTM
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b43d6c3485so341725a91.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:49:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795438145; cv=none;
        d=google.com; s=arc-20260327;
        b=Z8hgmiiXcIu4H7olPtfOx3uH9JkcwtwG20tGFG+ywg1Prqe1kdsCxUpq2X+6vT9BXx
         EMiGt5ypFqiw0w1DA/Khd0YEPIvjpt7EzFPH1Ag6/J37dUeJmScm6hq/ftTZTZwn93pl
         Y/0TQeGT8AW4/IBd8QpMojI3XcKo1uAc/ikDYfHLuYSiHafqUsMrjsGa9gcTY5emUJbH
         Jm6FncQK3UF230+kRwZ1+80ilT87+CBpywrQBoLka6R4UGBTJKq74i+ROGBj9akCLN3o
         jkG9EVTY38SeWxTbv/iFFWnqIseab3lGoMjixL1j1I3XuSwCxz8satN97dI73WWID3aa
         DJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kFSS5Lpx23772o0jxHiqpcMGc1EZfFQoRb+B8VLiMXk=;
        fh=SP9MQuLGLKwYAkAMPXZZy/g7jD0jDxqmFswXJ38n1oQ=;
        b=HNNjuQgDkszYJzrChyCBW/Zf+hEiy11NhtCVi3G1o+dXYmzn12TwLpeajXIogmIJyd
         VaFRcG5AaOl6N/73e2tPwogW+6Ji4pHkKH1lMniCxuJ2KDoq67Me3g2r2QeBrDRg3YCs
         zKmtxIAwsve3Z1VkHwsXAsRcn+rzYkUj/sLcly2LNoDXLqfKEILc52GwRnPKgl0Kk2MN
         S7EiU3Q9Qtu8CojCAoCez+og06pQTGVu4UjBEMUyL8XBO8QdtCFH63XlbfY0jFFi65Nw
         nusrVc1LvppsobYCjWW72AjpS4JiXzoDRdfHLj3JPbPncB/lWQUUhm4TBwnL7NFHC9S9
         WX4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795438145; x=1796042945; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFSS5Lpx23772o0jxHiqpcMGc1EZfFQoRb+B8VLiMXk=;
        b=IrLGZGTMUyOCRbyjw5X/ob4WE1mDOIB8tymNE6Fl18vATMykCZjkR9ZOpfSbs0dFQr
         DyDTvbD882R78Z+CNFsfT3cgEj2tf7HmIi1cUQp+JXi+dKVp+EPEPWBEVQtbs9rbR6q5
         KwVAi+pO1JsD/bNB+RLjwZ6nZEB9ZPk398zuTPP2sgxg8c63z4onxYkd8M0UXJ7iplab
         j1fLdy0neYv3JyMlkvMYoaM/WHLacvrs5edGEY+ATzeWJGtQ/eUTyWbmpQWUCsWOf37N
         J3S1IRXLnTIo2bKeEQMtL1FrA67bQg2iAO0vj8y8yq6U/ElTdWHYFKQLyaSuBqjZ9rCi
         t3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438145; x=1796042945;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kFSS5Lpx23772o0jxHiqpcMGc1EZfFQoRb+B8VLiMXk=;
        b=zzsjbzcjttwm/8YzQaGQ0MPi/7VxKE7UOZCFbNDz1nsJevtrDq4fAS9AcgzokXKHVb
         r4CTzNo0q/NQCEUw1l1fMdvso15N0NUTropfaFeoDl8qF6VglI11bhnFK6ukJhTWon0o
         O/+3J6akfzwbnLf3z8ZGVnSytU5G9kNGhOehl0LJwmOoIt6akMEPU1YIzhs8ccHdCW8e
         tipeR861OcBEDRT/CzTWlUc0kvfDEdI9pAFVTLIg3a2bNwwpt5kvLvKFAow97TG7OooM
         c1mYIjkFGaSQqhvHLBTRKzYVppvhupahu5P/0sJqvO7HA/kI9ZlLUMMlwTYp3ZCVnmeS
         Ppdg==
X-Gm-Message-State: APuU4Z9ifVOfL15K7JVTd77PDsjpBIjM8IaKFRJu87MQrIIrfplL3Ak6
	lucE0rt0/VIlkFUauLUdnZJNpNEEyiYb27gGUBSIFTOCDXoZ6WgNSA9G2lc9ze/3h1cCo2lzuRa
	HJShRXJGSZflgXsVGtm1274c3rArMvEi2MKQSOpEIWOkoJxnLEXtFziQ1IjB1
X-Gm-Gg: AZFdTZcODM2bJEim5yMc5ZHUvVuUHBJWQMd1TpTq6hatgPbpi+MGRg1nQXt4K0671iV
	/NOuGLidh+mRGlNcZUP1GD8tVQzu9ep+W/s1RoN3qjFUH24Y3rcGjkdprRqSFSC5FvxB5MO0xG6
	NNezDxbH6Br1dfL7ugVFoNOtCdidE1IuN7o1Ct80PTwLHzLLzVVHyvZuFSKH2UKPfoQVdoIBcra
	rVS49ZYl6rfISx8ADBNvk0qxNKeMXVEexmqtJjlHjbCC8XwueaZ01qPsBfad6KNmL4kI8/HNbU8
	TrBGezhajERJyLTjUiZPVrpfSxkb2fdGW/QStBpxSzmX+4Dm7tPoVn66qFyiQoidpstaG1MyG/x
	iCeonUDrhsZj4OlBpYmnF3EQHsoxFfqe2+SQ=
X-Received: by 2002:a17:90a:c10e:b0:3b3:c92e:f523 with SMTP id
 98e67ed59e1d1-3b41c917320mr17695252a91.3.1795438144716; Mon, 23 Nov 2026
 04:49:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com> <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
In-Reply-To: <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Mon, 23 Nov 2026 14:49:07 +0200
X-Gm-Features: Aa3M54oTl11TCFGAigV7UhZBuv7UvpVpxQ6riby4wl4QTdBGKnWaIn2NNnXrHOQ
Message-ID: <CAPnbwjqUgxYmiviUVRP0PzPPcYdOHkESrhBepkQuPqA-tdyyMQ@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 3/4] bpf: Check program
 recursion per task via bpf_ctx
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, tyler.wilson@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

Done. The array is not faster than walking the chain

bench -w2 -d12, M/s, median of 10 runs [min-max], lazy preemption,
x86-64 VM with 4 vCPUs, bpf-next 32b66b94c86f, in boot order.

The existing benchmarks:

               trig-fentry          trig-rawtp
  bpf-next     39.36 [33.73-39.72]  40.02 [37.00-40.78]
  series       40.10 [39.43-41.41]  39.63 [38.99-40.06]
  array        38.97 [38.19-39.17]  39.19 [38.58-39.90]
  bpf-next #2  39.74 [39.17-40.12]  41.12 [40.14-41.68]
  series #2    40.68 [39.68-41.58]  39.81 [39.33-40.49]
  array #2     39.89 [39.48-40.29]  39.49 [38.85-40.34]

I added two benchmarks to bench, with three programs nested: the
measured program starts inside the third one.

  driver (raw_tp)          calls bpf_ktime_get_boot_ns()
    fentry on that helper  calls bpf_ktime_get_tai_ns()
      fentry on that one   runs the loop that fires the measured program

               trig-fentry-nest3    trig-rawtp-nest3
  bpf-next     39.88 [39.42-40.52]  41.44 [40.93-42.68]
  series       41.25 [39.95-41.95]  39.62 [38.62-40.50]
  array        39.59 [38.15-41.53]  38.22 [36.37-39.02]
  bpf-next #2  40.62 [39.79-41.13]  42.84 [41.96-43.50]
  series #2    41.48 [40.09-41.94]  41.10 [39.70-41.63]
  array #2     41.06 [39.73-41.80]  39.67 [39.07-40.08]

The array is patches 1 and 2 plus this in place of patch 3, with two
fields in task_struct

const struct bpf_prog *bpf_recur_progs[4];
unsigned int bpf_recur_depth;

 static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
 {
+ struct task_struct *tsk = current;
+ unsigned int depth, i;
+ bool ok;
+
+ if (prog->recur_per_cpu)
+ return bpf_prog_get_recursion_percpu(prog); /* the old body */
+
+ depth = READ_ONCE(tsk->bpf_recur_depth);
+ ok = depth < ARRAY_SIZE(tsk->bpf_recur_progs);
+ for (i = 0; ok && i < depth; i++)
+ ok = READ_ONCE(tsk->bpf_recur_progs[i]) != prog;
+ WRITE_ONCE(tsk->bpf_recur_depth, depth + 1);
+ if (ok)
+ WRITE_ONCE(tsk->bpf_recur_progs[depth], prog);
+ return ok;
 }

 static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
 {
+ if (prog->recur_per_cpu) {
+ bpf_prog_put_recursion_percpu(prog); /* the old body */
+ return;
+ }
+ WRITE_ONCE(current->bpf_recur_depth,
+   READ_ONCE(current->bpf_recur_depth) - 1);
 }
