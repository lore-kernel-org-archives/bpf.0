Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA02D77F7
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409836; cv=none; b=XM9GyPUsbQcqyG/1oKCpXemZhbJva+xia9RrU8j7qqu2+r3cjYfO0RmTlKM774TGs94vKB78+XftLzwlWnbrE6N53ENMc/IUToLdV4MgOGjVYAWpEf6MjTz5f6xqMFhGrMs6b7rPs1yJrt8XHjSy52CHGYJqeYYu4tLBv4pow4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409836; c=relaxed/simple;
	bh=Z6tnLZmfbZY9KJukSWtadBsrV3bxYzT97i5mms5gBBU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u5IfdMx0J9mBDrVORBVs6NuZbHrOhktrD/kdaMIENidHr+lASACOJZqrt+gntGB7g682pRb2i36BDA3L3FxsFsSDU9Cmy7ML+RBEvcu9/bN4T4+c5E7I4wFzNWRltB8VYN3Dz8wNahYunNr4xT3Mq/B4xqEKBtMVSA7efCb8GDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljEN20HE; arc=none smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljEN20HE"
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-6a144c8f038so2237571a12.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789409831; x=1790014631; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MhwZKQH3naP48pBWrsTvWrJs+Fp5fgGMTIobqvnavu8=;
        b=ljEN20HElxd9H8T1EKn4LuHkQus18lX3szBzvlm9slxRPtKIOPJ6rNRFfKffuaxnyU
         ybyDiR/1RIl6QqA1UbElBeVpnOLpYOwuH9yrBPJW6XbA/VUw8sa3ewplFAAqkZ0hLOpj
         eQpJPwQk2mikEFr5Oczfyd+l0sRywPHnFKqnN+4RjTiE48ARLt5oGtr/gkMdsfMVRfAg
         Q3FWQ0M9uSBaYcNUIV0xzMfJzECrpVQNz3ZrTtzDCcQnuWD63zeiXmrGAycM+9+QFVrv
         iPyXrlURabFvZxNgzVxQLMKF623pvmIaAsMZxbaobJlqKYikJfdKbiKTr0hfMSXBAa+m
         UlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409831; x=1790014631;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhwZKQH3naP48pBWrsTvWrJs+Fp5fgGMTIobqvnavu8=;
        b=AzRNFcL2MvI1W5m5fFPvN82TZDIeGr7F2+u66jEbYN6EtFdihlD8BqDNAo594FhFAg
         G04hANpYCDzIX+ONUCphd0gtYGmVQynSxl9Wzp9DfiZYvv9hjtHt8tpkSs1zeRHqq57u
         y3C7p1MOWo8iybmnnWSaZV7ZdR9LcUwyM7hhmwyq67b8i+zHxh3fXxlPG/Ph4bGEgh8d
         aG0GuBySAD9QEryHTFW/pPhROAQTvcUgr3SCVHa27WXMDYUoZd7Jy1ANSlubW7fzDTjl
         8NhSJgVx9KpAzw5crM+A1dEoYdzX1aiUaGETnC6q+wjxtcXsZA9Qjh63C+4g4OcH4A6+
         uYWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjpVz7N2dJuadCQy0iuL85Z1dPMgEcXDEv1VuUkS6RAXjfbhwKWeLXIjK9N1i/+pVZvns=@vger.kernel.org
X-Gm-Message-State: AFuF++k8TZBQQLxDQeImHINVwkI0q6qQWIlGr+mJTjxKPR/MBTMo53JT
	zOEYDw9a6Ea1dnB+1r2DkKvjRwFgv28YxWoAZVeEBm5z3HGtL33PFa8R
X-Gm-Gg: AYBFou1VKE7UMxthbgBiCxRaEfTbvfnFYjVFPXEYPqRb349FuM52ZPhyB3RLKa+zwTa
	t+/8EMpfleXMt++FI0dnKjyR7CW3mClvjXQhkm2borOPzAnubz4GgmR1tZaz53haygHJjoQsdWN
	OKdqH3nCKbtz3HjnFpoCqToDfjX52oCng/8/7ePhqRqJdqGCNIIdDk85GjSYMSqP86LuD6/QLPt
	QhIGgX7yh1qWda3YIUEluNb+2s9r2YJStGXB1EdXWTjJUUeNgAfBj3ctPbKbAXi5jrRCtIaOkwF
	yHpCo55zbBoqHU0a6cfL0ZxGr5KjU7XQnPi6GmxNJWZ7W5+wWZhUftRLfyIn/qyAOVY7QIeaDXC
	K5KzyMxrsLnRB8e4xDxqRHpAtnXiWtzrheN90W8mqzokqjseguZ0v2q/VpNiN6Qfv3pqtYYgLds
	Lig3qnQCCo2szIT4hfUEwMRe4fa27sH5TO1+Uibf+fKraKNFYliwY35b9RLIUP7/ykNaXwxa6VW
	GW4GXW7AXGMEvs+irW1iBhyOespUL7Ic/SEIlBUXRQ2IGs/6LB71Ci62EiHdnKt7V6BfUEE7f0k
	dqQEuFhpVMz5xFcoSForsSLg5U6ZLcqcml3sJA==
X-Received: by 2002:a05:6402:4149:b0:6a6:c4b:c92f with SMTP id 4fb4d7f45d1cf-6a9f6227feamr2295917a12.9.1789409830894;
        Mon, 14 Sep 2026 11:17:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9ba8f3ab9sm4370429a12.15.2026.09.14.11.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 11:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 20:17:09 +0200
Message-Id: <DLF8UFBL6NEL.MAD9F5418DIG@gmail.com>
Cc: "Hui Zhu" <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v10 1/2] mm/bpf: Add bpf_proactive_reclaim
 kfunc
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Hui Zhu" <hui.zhu@linux.dev>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "JP Kobryn" <inwardvessel@gmail.com>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah
 Khan" <shuah@kernel.org>, "Barry Song" <baohua@kernel.org>, "Geliang Tang"
 <geliang@kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <cover.1789091855.git.zhuhui@kylinos.cn>
 <e00910f328c129fea716e9fd031dada328e60313.1789091855.git.zhuhui@kylinos.cn>
In-Reply-To: <e00910f328c129fea716e9fd031dada328e60313.1789091855.git.zhuhui@kylinos.cn>

On Fri Sep 11, 2026 at 4:20 AM CEST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> BPF programs can observe memory pressure on a cgroup (e.g. refault
> stats via bpf_mem_cgroup_page_state()), but cannot act on it:
> triggering reclaim on a chosen cgroup requires writing to
> memory.reclaim, which BPF cannot do. Add bpf_proactive_reclaim(),
> a sleepable kfunc which performs one proactive reclaim pass on a
> given memory cgroup, similar to a write to memory.reclaim but
> without retrying until the target is reached, so that when and how
> hard to reclaim is BPF policy rather than hard-coded thresholds.
>
> Since some bpf program types may be invoked while holding fs locks,
> limit the kfunc to BPF_PROG_TYPE_SYSCALL only, to avoid deadlocking
> in filesystem shrinkers on the reclaim path. A SYSCALL program can
> invoke the kfunc directly, or asynchronously from its bpf_wq or
> task_work callbacks, which run in process context and keep the
> SYSCALL program type.
>
> The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> following the precedent of high_work_func(), the memory.high
> workqueue fallback. Note that only the reclaim target is capped: the
> actual scanning work and its duration are not bounded. Reclaiming more
> than one batch is left to the BPF program rather than enforced by the
> kfunc: with one call per bpf_wq callback and the same work item
> requeued for the next batch, the program can also stop submitting
> batches in between, e.g. once the target cgroup is dying.
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>  mm/bpf_memcontrol.c | 88 ++++++++++++++++++++++++++++++++++++++++++++-
>  mm/internal.h       | 10 +++---
>  2 files changed, 93 insertions(+), 5 deletions(-)
>
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..d8827bc388ef 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -8,6 +8,8 @@
>  #include <linux/memcontrol.h>
>  #include <linux/bpf.h>
>
> +#include "internal.h"
> +
>  __bpf_kfunc_start_defs();
>
>  /**
> @@ -159,6 +161,74 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct m=
em_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }
>
> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes, clamped to
> + *         MEMCG_CHARGE_BATCH (64 pages)
> + * @swappiness: the reclaim swappiness, in the range
> + *         [MIN_SWAPPINESS, SWAPPINESS_ANON_ONLY], where
> + *         SWAPPINESS_ANON_ONLY means anon-only reclaim, or -1 to use
> + *         the memcg's own swappiness
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * memory.reclaim, but without retrying until @size is reached.
> + *
> + * Only the reclaim target is capped: @size is clamped to
> + * MEMCG_CHARGE_BATCH, following the precedent of high_work_func(),
> + * the memory.high workqueue fallback, which bounds each reclaim
> + * request the same way. The actual scanning work and its duration
> + * are not bounded. To reclaim more, call this kfunc repeatedly
> + * instead of passing a larger @size.
> + *
> + * The kfunc can be called directly from a BPF_PROG_TYPE_SYSCALL
> + * program, synchronously in the context of the thread running the
> + * program, or from the bpf_wq and task_work callbacks of a SYSCALL
> + * program, which run in process context and keep the SYSCALL program
> + * type. It is registered for BPF_PROG_TYPE_SYSCALL only, because
> + * generic sleepable programs may run with filesystem locks held or
> + * in NOFS/NOIO contexts, where the reclaim path could deadlock on
> + * those locks via filesystem shrinkers.
> + *
> + * For asynchronous reclaim of more than one batch, driving the
> + * reclaim from a bpf_wq callback is recommended: call this kfunc
> + * once per callback and requeue the same work item for the next
> + * batch, instead of looping inside the callback and monopolizing a
> + * workqueue worker, and give each target memcg its own work item,
> + * as high_work_func() does with one work item per memcg. Whether
> + * to submit the next batch is up to the BPF program, which can stop
> + * at any point, e.g. once the target cgroup is dying.
> + *
> + * Return: The amount of memory reclaimed, in bytes, or 0 if @size is
> + * smaller than a page, or (unsigned long)-1 if @swappiness is out of
> + * range.
> + */
> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg=
,
> +						unsigned long size,
> +						int swappiness)

I'm going to have to request one final change, sorry.

I think long is more meaningful as return value than unsigned long. It's al=
ready
restricted to MEMCG_CHARGE_BATCH. We return error for various arguments, we
should probably change to -EINVAL.

Apart from that it looks ok to me, but please, also wait for Shakeel to rev=
iew
the set before you respin v11.

> [...]
