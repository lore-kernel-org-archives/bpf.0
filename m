Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB537378D8D
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158027; cv=none; b=WGWMcBN9PPJmuGEBbzB8jxgOwnJUgtnZfb876LKdLRLcNbAbkqhX6tBq09Sv7xiGtbEu+efdhM9GFaXCMRpICWtdFbH+JcNXsmda57sCUJ54uncoEqwarm8uTSBSx978tnpoSDX/zPpI3YKHXXP8xKAE78HbdwWmcYQ5O6e1zMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158027; c=relaxed/simple;
	bh=/Ber2a/bRTZVfIvHZqB/+gxypI/8tqNm2AiOUMW82ps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9pBbY//xZeO1QnsWjfPARDL2VbsN6UnR+LV1NDd3y5oC9HqDc3XdfIXukNBnxtJKQ9ZYcBdkoa0xbCZ36UZ2e9hgAHHB1J8524/WRrm/46AkguIV7FWDokmHs+pgSWQjgRyQ45asB4AxKvg7Ev7SD3vqQaePdjDAK2EJNyQFYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYx9pDTw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYx9pDTw"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398e9698a70so1512656a91.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789158025; x=1789762825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+jeSNh7SQgdgVvxZgQYK5oHH9o8y2bQYLv0pEhjVpkY=;
        b=GYx9pDTwW1MWOjXhqd4yiDBUXqfM9zP7ZGhsSURzV+KMWw2VpT2XtUKqg3Bqe3Yn04
         VMOVT47rgjImKZWDCou2R7poziYvjX260V18h7Adz8s8hNmoS210SznQeOWzmDS82Nu2
         q/f0ztYhLqvD/s/rHGi3VeVT0eiUqrUA1wS0Pk6L3W2+KMqZG7ZfjoyE7Y518Z5xi1It
         Z+PTefFyCRgNzs5J9gAK3K9//MHh783m1sic/DpBp3NxkQze4gs/SjW8BDaIbXUZW65X
         ZnsEoFde2glwt2xByB86ifUfZ4spU1rhZw58+jb2j8LGoCUuN+03bfW4b2Z7jlvuq2Ba
         BZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789158025; x=1789762825;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jeSNh7SQgdgVvxZgQYK5oHH9o8y2bQYLv0pEhjVpkY=;
        b=pHwcFDFSN3CQzY2/gka8vTnsBmpZ/FhjF/o0yqHF3NcpWvf+uNHiW64+CDpeQD+bgi
         uNthFBdRf+CM9e90TOmoNgpU45laeBF++rBXa/hBn2hhR905yC95SJkeWBjTWelCz32Q
         szQIMss1/fHAV7faBqYuNQp4q1oNiUAarwpS2AR13cUWmhaTkWA0w7fRbQcF3dF1fiGU
         r9uUjmWLxphRJFjQGE/yTh4bi25Lx+ErO+dSs7whMysXMts+z4COmOIj2m7HcBrz5FJT
         AxgHeJwRHzHjZF5QIjDmNWpszf97K+oYhOwsd0q7HMpYJIN5NBhm4GcN/e/LHOxZKi9p
         v63w==
X-Forwarded-Encrypted: i=1; AKwUvBxJSlWkH2cvLmt5//pSRAVbaVqKioBn8Caj/EJ/tdIIsoT11xYwQ/OurmekLUoiHT8eq3w=@vger.kernel.org
X-Gm-Message-State: AFuF++ltmpMEi+Bfxq+TGQOhDK4eLS48mz88b1b5AuBnKLiObru3xxnS
	OEu2MpAGptjQKxcGD8eZS2xMqTWl3CSriGnItlTnujXbceSEjfalR5nP
X-Gm-Gg: AYBFou0PBTmk5rY8UcKJmNc30rY3+0ngsd6jjHKR4MRLn4MkMmWVXja4dhxxoR+q7G3
	zOVBXbNs3kd2KelE+rPnb2GQ52yv+CjPU7cbg4/ikbElarHK/USU+or1MSK/ZLu7P+7y+WdRSxU
	f/c3iGwtu8olXvfT4YUMfqCG2FqhRPCFHVByrKJ5TtzFDXZNWdV1/rRyFBTnDG7wNzBuiLw4SAs
	HuE+5OuF45/nP8VMwE0ogia1KiF/bRhbmovv9ML7mNcWnaZ4xcqXtx4jh+lPdO7O3hyzKcLOCBp
	rBOnezQhsv1zsRNa+xDuyZ2P5sDOwrxO15pHK3RlM3JnjoTI8NMDsPA42nLeJ73sd2gsBLREu5b
	hgjN23hX8yUkJCTb3QtxqpU213mYmcCiGGfGUmrzhs6FpvjlA7rIQOJ9S8gVaRQtJk2wRjJQNp9
	MMD5MjkhaYJMgw9aQHb/a9zcIb/Tui/9dyk9tkAobLhyQyO1WT0IOmI9G7/XHDiPD545aBJBjLe
	o9f3+U3YUOKK7i2f5Cs4Fr73RW847z/7UR6acwzDoq452W4KZYfBQwCzA==
X-Received: by 2002:a17:90b:3a0c:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-39d9bc10065mr9687179a91.1.1789158025081;
        Fri, 11 Sep 2026 13:20:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c52f:3686:673c:704a? ([2620:10d:c090:500::4:b9a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4efc398sm9705357eec.19.2026.09.11.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:20:24 -0700 (PDT)
Message-ID: <ed7fb81ef39f8e21bce6fb79698f5fbb6998159e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test global subprog
 callback contexts
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Fri, 11 Sep 2026 13:20:22 -0700
In-Reply-To: <20260905051224.2325381-3-memxor@gmail.com>
References: <20260905051224.2325381-1-memxor@gmail.com>
	 <20260905051224.2325381-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-05 at 07:12 +0200, Kumar Kartikeya Dwivedi wrote:
> Exercise global subprogram verification from workqueue and task-work
> callbacks. Both callback types can run in a sleepable context even when t=
he
> containing program is not sleepable, so an unprotected callback must not =
let
> the global subprogram use implicit RCU protection inherited from the prog=
ram.
>=20
> Add negative cases which load an RCU-protected task kptr in a global
> subprogram reached from each callback type. The tests fail on an unfixed
> kernel because the programs are incorrectly accepted.
>=20
> Also cover a workqueue callback protected by an explicit RCU read-side
> critical section. Finally, call the same harmless global subprogram direc=
tly
> from the main program and from an unprotected callback. This requires bot=
h
> non-sleepable and sleepable verification roots and proves that global cal=
ls
> from callbacks are not rejected wholesale.
>=20
> Keep the harmless global opaque to LLVM with barrier() so both call sites

__weak is another useful trick for such things.

> remain in the generated BPF object and the positive case cannot pass
> vacuously. Have workqueue callbacks return zero explicitly after calling =
a
> global subprogram, as required by their callback contract, instead of rel=
ying
> on interprocedural return-value optimization.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> @@ -179,3 +285,29 @@ int task_work_sleepable_prog(void *ctx)
>  	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work=
_cb);
>  	return 0;
>  }
> +
> +static int task_work_global_rcu_cb(struct bpf_map *map, void *key, void =
*value)
> +{
> +	return wq_global_acquire();
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +__failure __msg("R1 must be a rcu pointer")
> +int task_work_global_rcu_prog(void *ctx)
> +{
> +	struct task_work_elem *val;
> +	struct task_struct *task;
> +	int key =3D 0;
> +
> +	val =3D bpf_map_lookup_elem(&task_work_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	task =3D bpf_get_current_task_btf();
> +	if (!task)
> +		return 0;
> +
> +	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map,
> +				      task_work_global_rcu_cb);
> +	return 0;
> +}

I think this test is redundant.
