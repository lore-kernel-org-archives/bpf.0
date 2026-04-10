Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FBB382F08
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850820; cv=pass; b=AHM2jACDi5L7pkPa6y8TiXFzYF9/Li+mqivm16A1Rss5tHDOY0hCFJ0V5/1hmcCgF4zVw6uy//PM9OWYAMlrdk8AEDSAYinXSztzKLdJu6Xs0MLIAVp3nIBZUj41NcYeUR7AQ9dqURG4s7FUqfRF/OKzVn4jSapf0jRAiqIAfzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850820; c=relaxed/simple;
	bh=a3PdLqEd/A7iWc97AtITXDLzWU6Nm38RC6CCX1YAnpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzQIB/IIz6v5twXsrQgWOrwYbyEthgpr0TUib9SF5D1rx+baNNIdF9dAIV2ISXKFmEbEZ9JkKEijU+2hr+epE+4g2e3fn3hIPBeKzVMPClMT8dVMHR72n0XPXtrOBnqOWidnCgQXW80PI83Xfr9h2cz46YlSKqcppEZ4RAA4UYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBTT2Kef; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBTT2Kef"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b949bf4easo1482086f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 12:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775850815; cv=none;
        d=google.com; s=arc-20240605;
        b=gN8VZT41hSzBwhhoXRW0roNsUxKqw7hoHYHhdBniBysvzmKAEYZMJfI26w5naCAq64
         XCTn1B0diZ13aKbf4PXvDiDNmmWDYfbXjqdF3b3EfVNiS+Xlwev3du2ocYYJyf/hHS+u
         Liksw3FTjy9zrazkCfHebtitl+v8op5YcAUjH2HcGEwPOXgjwwad1XhIp6YYn2LRmERs
         DnPTzp/BZ8CQEGUq7CmipOjjpypFTfGFk5tD8i0q7gfeizZNhP/cRU0+obnJmJxFBIXw
         inWGE1fj3eFhAX9v9rDB0JFJfxoP+gWXoxz3zVinct4E1qfMoYOe+eXk0hUiYu1IbXrM
         /T6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9cvnwtnLI43EJDQ1KXQHzYGEVojP92QP7WWiPjzjRs=;
        fh=OdoTkGJ2jAdRtqXZL7E1p8n7BlU3RbNiMK2FNoH7lP4=;
        b=d21vkH9EaT5npqLSSW9JPqq3/nX7ijEpMqQpPeYQO9fnwSF3RATu2f+36869EEYUMT
         zQNoK1a2r6AwdvIJqjCW6CiKrRiTVcqHm0tUQ/toKGTRT1t5gFfJxXKaxivRW5SFYFPi
         yV6wetTcGIvj5KIZRJx2em02JDXOSiGc9rVvkwBvmku4jnBFxg3YeRwkyKQwCj36Ktes
         VHup+vq9tCIE5/YQafbx7yuURu6Nliy2S7JSvM5sCj6svFpT1lxXTEq2VC8T3P0KSH1N
         vqzRTacVGWp3bGZviP+NPxnosgY6wuNxR44vereZXsaJ2yYHBJohCe25LYCQ7AvuQ02j
         FbQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775850815; x=1776455615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9cvnwtnLI43EJDQ1KXQHzYGEVojP92QP7WWiPjzjRs=;
        b=eBTT2KeffEvwCKcYzGHmccV6L2rWbdZXByY2g/Pj5CVd1PhJh9o6Xku49JU1/Asnwu
         Z+UoM6DNVlH0TCN5N4lgai//bVCGLoReO8PLqi1lu0huqO83ukfXKw4xMYJGXtNzxKVS
         9Ka71AH+AuDb8ZoEpFgcKwDZd7q8Zt22YVnAxyOwIxb3hn6X2TndW6I9Byw6wiqd6lT/
         +O1JcuDOGBTkuZldQgXa7jYt1c6V0sc0ShtrGCAJ6a1gehiy4Mx8NaLnDuOnSRqE1qIq
         xMp3SHvgOoSxAhQ/3mkO5jVUXUdldIxbuLZVws0FgB4XJEt01+VpSauHzVjnaSqPkoTx
         sbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850815; x=1776455615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9cvnwtnLI43EJDQ1KXQHzYGEVojP92QP7WWiPjzjRs=;
        b=deJ7GWX43Xo6DG95930bV8WWhjCAZ1w4oqiJIXbGUokL2QTHUNmiP6BU1s0yvRSONJ
         5ncMRcjyOUidrz1yeGeZGpJZNV2JokJEnbpuKOnVCz8IUyqmsFrkz8ZzDF3N2crNd49T
         J/qaNyRiX3wzUbHxVznGhomxGGQHvDTurp9xHaiv8PevFnQbdKIoPRkAGE/PZuheFzJi
         dpRYtI2kyJ4lyDEGGkzGOQHGivhi+8sqpGEHXyXTZiIkwsEJlguDTJ5qK/tR4r6axJb6
         SDJEe85Ofcnk3MDtAdJJYx31Z11MpVsQCaVqkP6L/ozDRVclupCG/t+jQocAefNFaO2x
         UAlg==
X-Gm-Message-State: AOJu0Yz2NYh3CBAxbs2UyaPvLqB2tBnZVBbslW7y72wnvNkzQU0k08lm
	+8s79XFLNriysNVmwqTjcacOffYbv49vvitoLsvpsH114djDBU5x7DDyYru/zcaKx+zcjb4Jk4R
	uvjwQhAgSdjAIvPM3R/Dbp8iOesYUBks=
X-Gm-Gg: AeBDievdblm3MO+1+9w1S6j7oQdvmbj12ag9HxF1uShvWg5S+U+roBMpzSgRrWyLeM3
	Im0ERWsk4a2YGHdTz4Hl4GcDLctYsaTapveFvJqyg1tsDmAe30BkvywGiFlrXRv/J5n25QgTIM6
	4zE5TZg4fD8tBiPVfCsBYU34sChAS+dhJq3z80faIpLXd8537nuoKDW4WmgGzOQzvZd/6WGGU/R
	kz+RTxbI9l7TmuLNSGHDb0FbK0kjnNcNSX26be1LcMUVIaRa56CjjTsTgu+8pX5VpOsD1kqa1Ob
	YK62PJfVqmXbFw58q6u7B2hyQm2zallJMCMwY1nZBUBCeTtGR2viWm5/+i6hxHyT94DvCNTvhRX
	SHpKCreTKUwprggzk4h70O/ej3Q==
X-Received: by 2002:a5d:5f94:0:b0:439:bee4:8a93 with SMTP id
 ffacd0b85a97d-43d6497409emr6442665f8f.12.1775850815128; Fri, 10 Apr 2026
 12:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410140725.961623-1-yzjaurora@gmail.com>
In-Reply-To: <20260410140725.961623-1-yzjaurora@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 12:53:23 -0700
X-Gm-Features: AQROBzBCFa3sA4-4hePXzFf7cvxR7iUKpRzXYMt_02UU1S6ORFff99IGUFkb33Y
Message-ID: <CAADnVQ+HFJXyVY+W4Pvn49wb7gYPKAsUCfj8QK9USix3qisJog@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: reuseport: add cond_resched_rcu() in reuseport_array_free()
To: Zijing Yin <yzjaurora@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 7:07=E2=80=AFAM Zijing Yin <yzjaurora@gmail.com> wr=
ote:
>
> reuseport_array_free() iterates over all map entries inside
> rcu_read_lock() to detach sockets from the array. When max_entries is
> very large (e.g., hundreds of millions), this loop runs for an extended
> period without yielding the CPU, triggering RCU stall warnings in the
> kworker thread that executes bpf_map_free_deferred().
>
> The observed stall occurs because the loop has no scheduling point:
>
>   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   Workqueue: events_unbound bpf_map_free_deferred
>   Call Trace:
>    reuseport_array_free+0x1ec/0x470 kernel/bpf/reuseport_array.c:127
>    bpf_map_free_deferred+0x34a/0x7e0 kernel/bpf/syscall.c:893
>    process_one_work+0x952/0x1a80
>    worker_thread+0x87b/0x11f0
>
> Add cond_resched_rcu() in the loop body to allow the scheduler to run
> and RCU grace periods to complete. This is safe because each iteration
> processes a single entry independently, sk->sk_callback_lock is not held
> across the yield point, and the map is fully detached from userspace so
> no concurrent insertions can occur.
>
> This follows an established pattern for long-running kernel loops that
> must run under rcu_read_lock().  The closest precedent is in another BPF
> map free function:
>
>   kernel/bpf/hashtab.c:1600
>     htab_free_malloced_internal_structs()
>       rcu_read_lock();
>       for (i =3D 0; i < htab->n_buckets; i++) {
>           ... walk bucket ...
>           cond_resched_rcu();
>       }
>       rcu_read_unlock();
>
> Fixes: 5dc4c4b7d4e8 ("bpf: Introduce BPF_MAP_TYPE_REUSEPORT_SOCKARRAY")
> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
> ---
> Base: bpf-next.git master branch
>       (tip a0c584fc18056709c8e047a82a6045d6c209f4ce
>        "bpf: Fix use-after-free in offloaded map/prog info fill"
>        as of 2026-04-09).
>
> Tested with CONFIG_PREEMPT_RCU=3Dy, CONFIG_KASAN=3Dy (inline),
> CONFIG_SMP=3Dn (single vCPU QEMU VM), gcc 13.3.0.
>
> To reproduce: create a BPF_MAP_TYPE_REUSEPORT_SOCKARRAY with
> max_entries >=3D 100M, set rcu_cpu_stall_timeout low, pin the CPU with a
> SCHED_FIFO thread so the kworker stays in rcu_read_lock() long enough
> to trip the stall timeout, then close the fd. Without the fix the
> reuseport_array_free() kworker stalls RCU reliably; with the fix,
> cond_resched_rcu() yields periodically and no stall is observed.
> Reproducer (C source): repro_reuseport.c (https://pastebin.com/YjdwqdX1)

This is not a realistic scenario that is worth fixing.

pw-bot: cr
