Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604889;
	b=jR5YaZaPDWXdB/VJI3soIxZb6VxGYyw6pX675lUff0Ek0qkRLo+23wwGKaLC9HEU+Xo1
	 eBB6h2pEc5u8bTbiwyOKclOBchpZ/bnKMbQJl1OnicS6ku2gnj5NesZ6ype/ZFqGwCcwC
	 qmXfXOkIxJbdoeKnGEIn6OyNubAVgrxLPPu6hf6zFIPiTbqmedq541r5OCnxLT+eMSxIF
	 dEzBMFKQsPg8vXy3oRaBjqYi+d8348vcoFviEsPAWLLM+AsCq3KX+x5Svcy+23rBHY8wK
	 RFRyetqsALXbnsdPjYfX0wlaAa+cJ5wZA/SZSwbhWLeeT9Ad1s7geJo1H4RlflA1LPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oa9L9/wib9xMUobSu6/SlahSuVEkIu0Pgujj8s0hYtA=;
	b=qbTBculWS+KT4UhYaWew6BLjVrKeaY8YQD6kAEHQtYYI38+7l8unLJye4zP1L+it6Ggb
	 GZ9ygfplufUazcciBLV/nPtwnYjG0icRv8Uy6YfSW3RiRcSKuSKBYwyClJsNxShZ/FD29
	 CZGatUlN1xy/tRHkCa4qr0Xn7Y2GdLRz4NWUkCoG+kDdyp7nxERkRoZ99XL0aXYpwAk4I
	 NRJUjjCL4lTSMUYyJvhpn1yDwgv7sQ2kvCX+Hvv4F1EeyRbQVlz6RRqFZPSDoMBruEiPE
	 G6NzszoFcs+Ua85Iu0WLdI5od1z8z5jZVf2Xx6VsKB7rB7GPn1lLPGv9/3sD+e07l8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="TnX5L/dB";
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97F606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E97F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=TnX5L/dB
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso1429236a12.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793604888; x=1794209688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oa9L9/wib9xMUobSu6/SlahSuVEkIu0Pgujj8s0hYtA=;
        b=TnX5L/dBwg2JgHu7GhyBkXNKiXPHRlfThSQMlo7ItFkx7tnXuxnutvLMeq5MfDQawp
         zH/+EZ7s3CDsdfB1mSzgt67jTnlhZ9Wuz1HF3BQWkji+xycPHfw7cp7bAeE4fzJmn1r7
         w7PzPFGG5Xqtaj543PD1i3EkkIrX5lOB32aDYYS9Of6mD6896emGFCpAutFQvHR6VQhf
         LetZeswQcjZR9mGsCfOs1ZHdTqBi5KRaswn1W0/AtsT3Kqlxax80hcJ2GwzQC1IBIZz9
         60p+gjyHclDSUx8KKZreLnmVBimf+d7+dBkMNV/UCW6VjufTzIXvA51zX95tdW4WYg/B
         KP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604888; x=1794209688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oa9L9/wib9xMUobSu6/SlahSuVEkIu0Pgujj8s0hYtA=;
        b=pmz4HGDVz3PViati8qfdI844afDQKnDajLYhev9DFNhMeTx1zDCHlsOuxD6NOnxCFh
         1D37HzEAHc8Et03euW4lPGLWTj/5bbtSk1l1UzRwvyeIOGjwmtGBHZNshQty/V9fUfpQ
         zgV1q3nY0js0fs/rFYPKAd5hXGtFTkooIa6+EyLeubAkWDyo8vWcgKASBsCwp4mzWuqj
         SGp1+PMl4MuH/8BGKPDSrPtjsB6hMQ0yjaKxHOjWkxoQYqRVi30DcusnxyLwurr5kdVu
         a5yIWCiTFevDXbtr2u51XKmi6PbiJOY02Ja5XxI79tvuaK8q6i9YTyWLVVkmkrqmT3i8
         sw6g==
X-Gm-Message-State: APuU4Z8W8pALwoE+Kuh1PuZRhNPMphpVio/a+5faEJRIb2CaN536uqzM
	QRyH9Bkxx8igBRJ2QHXMawbU1zppFvSdUqgUh1ZyLgKwRGVp1E56zWSje7ypj5dsE9nXNRSPySy
	n9zwDHsM=
X-Gm-Gg: AYBFou3o3qXq31IFNBUnP4GylF3PLOmfsc4yWGeEM5ebNys+JilGlIguZsDMyQqDmvC
	RpLCz1h+yX+Kn6nvXzszhekqhVZFIaBxlPSdRtDlvQ+qn+dM0ei4y4km+tIyfLBGWKsvQVE3cuS
	DAX+5TKhVh2EzQAEiu/xkfhjrnN+GLlFdMEd/9pMhlQ3PPYf3a7BQUT9qiTbKesr6POqD0x98eK
	Dc/ZtqOZeyswJUoeersv0Ad08kJDaXis9qLRfaBuJvrprakuO4CuruYIRL4EkpYrmkR9J4QYVRd
	8XVJpxrVEYSG+vvNsI50OWZfqM0rTFGTtZbcDo6VeXm+WdcoN4SpNsrayYdf6xCBLsJXh8kzGBV
	vTcMcU1QzLpiBf8ochfPmPs9lVpwKbQUFYuHrW33zesfUlxgk8J4En2TpRuDt5c1ZFDcaxbAzXp
	X+eynPxnIOHd4Om/KxrUCamfNCN8oGl82cnm13QSxloFb30t+U8GjjzA+bHhrkWVMO2gb3Ox3YE
	RAGkUgwyJT3PlWjKr4Z6BXP2de5r89a6iSEm4HZnY28+EedZl7TW+6GK78xgIcctcGI+ywGNlkB
	8pm7vhZdzw2PNZOvrPM731r9AT8o0Q3g9GK4RnyQ4PlC1MGZX6b35d2P7pj/EYlAPhI=
X-Received: by 2002:a17:90b:4f87:b0:3a7:b260:9ccc with SMTP id 98e67ed59e1d1-3ae8985d7cbmr7490605a91.65.1793604887595;
        Sun, 01 Nov 2026 23:34:47 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9db612sm17551965a91.17.2026.11.01.23.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:34:47 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 0/2] bpf: Avoid workqueue deadlock when freeing programs
Date: Mon,  2 Nov 2026 07:34:37 +0000
Message-ID: <20261102073439.6822-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
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

BPF program freeing currently runs from the system workqueue. With BPF
program pack allocations, freeing the last program in a pack can take
pack_mutex and call into execmem/vmalloc code to change page permissions.
That path may queue a vmalloc purge helper to the same CPU and wait for it
to finish.

If enough other BPF program free workers are already active on that CPU,
they can all block on pack_mutex and consume the system workqueue active
slots. The worker holding pack_mutex then waits for the vmalloc purge work,
but that purge work cannot run because the queue is full of pack_mutex
waiters:

[   24.646667] INFO: task kworker/0:4:1291 blocked for more than 10 seconds.
[   24.646669]       Not tainted 7.3.0-00001-gdeaa120a9b25-dirty #11
[   24.646670] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   24.646671] task:kworker/0:4     state:D stack:0     pid:1291  tgid:1291  ppid:2      task_flags:0x4208060 flags:0x00080000
[   24.646675] Workqueue: events bpf_prog_free_deferred
[   24.646678] Call Trace:
[   24.646680]  <TASK>
[   24.646686]  __schedule+0x5bc/0x1430
[   24.646702]  schedule+0x3f/0x100
[   24.646706]  schedule_timeout+0x106/0x110
[   24.646711]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646713]  ? mark_held_locks+0x49/0x80
[   24.646720]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646723]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
[   24.646726]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646732]  __wait_for_common+0xc1/0x1d0
[   24.646735]  ? __pfx_schedule_timeout+0x10/0x10
[   24.646748]  ? __flush_work+0x1f8/0x550
[   24.646751]  __flush_work+0x309/0x550
[   24.646759]  ? __pfx_wq_barrier_func+0x10/0x10
[   24.646783]  __purge_vmap_area_lazy+0x3e4/0x440
[   24.646796]  _vm_unmap_aliases+0x2d5/0x330
[   24.646810]  change_page_attr_set_clr+0xb9/0x580
[   24.646817]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646833]  set_memory_nx+0x3b/0x50
[   24.646838]  __execmem_cache_free+0x35/0xb0
[   24.646848]  execmem_free+0x98/0x160
[   24.646864]  bpf_prog_pack_free+0x152/0x190
[   24.646871]  bpf_jit_binary_pack_free+0x17/0x90
[   24.646876]  bpf_jit_free+0x5e/0x130
[   24.646882]  process_one_work+0x289/0x790
[   24.646886]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646888]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646902]  worker_thread+0x1b3/0x370
[   24.646908]  ? __pfx_worker_thread+0x10/0x10
[   24.646911]  kthread+0xf7/0x130
[   24.646914]  ? __pfx_kthread+0x10/0x10
[   24.646920]  ret_from_fork+0x293/0x300
[   24.646923]  ? __pfx_kthread+0x10/0x10
[   24.646927]  ret_from_fork_asm+0x1a/0x30
[   24.646947]  </TASK>

Move deferred BPF program freeing to a dedicated workqueue to avoid
this.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: Use dedicated workqueue for freeing BPF programs
  selftests/bpf: Add a selftest for program allocation/freeing

 kernel/bpf/core.c                             |  19 +-
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/bpf_prog_free_stress.c      | 184 ++++++++++++++++++
 4 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_prog_free_stress.c

-- 
2.52.0

