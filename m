Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653234DCD6
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935887; cv=pass; b=D6999/izyAD1QXpPkUgMuAaQ4NL04Xl/d6rqe+kDOcHjOrGKkAkN0OpNIzna8sX4mwiqLyFwd2LirV24TkLy6/EFNo/2+6KgjuIHVellmzpYwVFtzLBlSUE4/ym6HnYBnvApiEZWK0XJVqQ1nTd4++gcIsIGZmG6kuCZpgtBXJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935887; c=relaxed/simple;
	bh=i60NZHFAr/h3m8g1ycLBjS67V/ddDkK/sHBzOunEesE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu5cL6gTpOuD2yvxC4wJ+FoBqKB3kFu8zoyYnctvzR5wDBX5l7uhbvdm1dC+unfWki9+BJu6B0UTECfGcY14hAKzZ0el6MAPfjFk/5oxdTZRutHe+RWd4Tuhcnfswk+VK9zFwBjxdO03P2o1N2WzwL23JrP+IJJIuWZ/oCZcWkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZodBLrT; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZodBLrT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ca06ad2d11so9213205ad.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935885; cv=none;
        d=google.com; s=arc-20260327;
        b=ZOjqELEvxIZJeNo8A6uXhNgU4EoWkLZTjiM0kNXkVqktwGi/WjHcfyubY0a+g9pYKw
         k+OlUAButt8QqCpHnYsYFxLRrEVMpkNt5Z7I56hpnqTFLmfbxplUSmKswfLmL6fGjBkt
         ob0sd5qsqmXxAaA9Z4y1iBPWHsLU3JcsEvW5rXc0gbfz4I5gTfSr6jFgfa7c74pW10xb
         Aek+JEBtuX9lFTGdCdpiIL9edSrvjOa5Ox4tjPnzBmrzMUL015hALle6aDUJmhIz0K61
         mRCC53S4L+Cmyy4981htPZZei9eSsfJUV7v3H2tNXX7Xvch3K0NCZ1S/U1T+u9g8RC75
         7fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z/jk7CuiaTeF+7fFe7FXnvT1Gom1hwgxaJqMwyCP2ak=;
        fh=DCeT40mfOmWbTemaVd59mW3xuosOt1YA5R0rNbzb+c4=;
        b=QurgHezfKdCqJZgO6Gt7yFqmZufJo4L40GvccfFsGdSe4wujTaY7GGU007yTJ+DZzH
         aqxSRguZ0NmL9IuW/bq8soN+Aw16dYbRKo5duizFTj5PgAKcucmEPs4nBnXCRHLSrX2C
         D2Uxge9QcenpyMr+3o1yTzdwyGFwgoDMu0LaoKZIbXUItjAwbNpBzdcoVm311CSRPlyY
         Etdnw6aygXSTPSBollslhpZwsn8otsATLTmyT8m/av4ENzrKeAontU8NzLhs++Y7xtfJ
         IsIDeq1W15sRjYwW7K9c/780G5u9Qv0ocR65JxBDF5w+ywPPx3GJyL5LCe1HYvxGgD+G
         gIxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782935885; x=1783540685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/jk7CuiaTeF+7fFe7FXnvT1Gom1hwgxaJqMwyCP2ak=;
        b=XZodBLrTnLTOOKVwnMBhP+vpNxwz1pBB21LrsOnL5BiluVYIW0X+0ozcYGgTbtC016
         nxFXa0RI2G7XtKuImrG5FQIS5JpzqTbefndXnzY0+Rc0LfvmkIALUVBwlTn2QeWCADW+
         HUuGiGBbM8SbWbbanSRtF/U3lp/1i4be1aQSDsFr2fNr3UFkw9S3mmXXIuOT2W/Q1u2V
         rpr5fm8Soh4LUJXnJy4Uio7Y7Dwmq4WH9h/bOBlL/7kAl0rJwDWoTMLMbid+GyTIKkiw
         Hjn9EQZQUbivurtUxHvcnBq1TblLAOTz6hf/LeCeGsozaxM8QnxHJ1tVcbdgcczmyZ71
         Y1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935885; x=1783540685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z/jk7CuiaTeF+7fFe7FXnvT1Gom1hwgxaJqMwyCP2ak=;
        b=dLQ9R6qV/UuPG8aZv1nilsFeGmd+j72yNh5ta/TO98rjKUQtvS57oE0fld2NX9JwFV
         1cIbj1X3BZLmkVw4iTNWKKYE5KwSDBj+F3+4zgu7Q/wmQZvjOqJ6OW1sVC/99Q6DPZy7
         YPQmj4LWQ0hf7yWfO0qmFKialoMei4RhnYc4cRb76m3YO0KHBeq3vHdLCemG9365TYbT
         Qg/eOxD1+WdorbvU7oj+LTyY/7rBW5/D1AapKeEWlq00F7YxcQQ4c0B4L7JPpSfTGIBj
         COdtp7g5nu166Inbcfd3/uMbj85LE1K5tV1XV3560BUK+r0ki76ZRpaWgQmXD4wUHbej
         W8Gw==
X-Forwarded-Encrypted: i=1; AHgh+RqpNxL9RL8dZrZn62QbjediLfqew3I0Sn3JwZehLE9EEMluuIi97D/CpYwZm43WZSa++LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFeXGzykHzD8KJU20lBZsVBqH3zafhoxFH6DMLCYDSZiZJklq
	UHnmzj/nwcTEyMyZIDDn+aJZt3eFWJ1iuZPw7ZMUItMIMgsZqsEfVgqdVF48hUMrVoVFM7nSa9T
	/A3MJwkLHdFfxs6Oj2MQXlnn2iUqxp9U=
X-Gm-Gg: AfdE7cmIHOHCTAG19wUL5PnI8YGxZq/tq1BITXIf5xcRChhZzZyz4uSHHTYSSCJ9/jR
	xC+av0NY3fJ7AxYHWZztBXzG8y9jvS4zH8/MA0AB3uTpEbpxobdh/RbZoIOh3hWrR9NyA6nZJie
	oleOK37CCIjgQlA2Bi8Po3j2wvcq8lEZkte0t4nBJpjKaB+cAjVaMg0KyfAZNZFaGYnRnSmB5yr
	yEYb7B6u7dW6Qu+CJu4XjG4iNpZnasq9OVtNUqrkqprzPgM3OoZw/RDuIjG/+Dl4CpxqLr6hOp9
	lo4INHu2ffFmF+7L0ydG4ktattCUvULBZ7TiwzfqoymQcJ/zIEDAzA==
X-Received: by 2002:a17:902:e5c1:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2ca7e90cea8mr33779245ad.38.1782935885043; Wed, 01 Jul 2026
 12:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630132226.C44601F000E9@smtp.kernel.org> <tencent_70F825FB8D959232DDCB5DDC991ACFB40D07@qq.com>
In-Reply-To: <tencent_70F825FB8D959232DDCB5DDC991ACFB40D07@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 12:57:52 -0700
X-Gm-Features: AVVi8CcmJQesiAwvYWGQKOoBWRdGLDKvlSi6L3ILgPYvpbdBIlalI7TmabXmhhc
Message-ID: <CAEf4Bzb+OOrdGyxbzjh=7MUEbA5FC05E6_iwCjDXcnSO-HZ=ig@mail.gmail.com>
Subject: Re: [PATCH v5] bpf: Fix smp_processor_id() call trace for preemptible kernels
To: Edward Adam Davis <eadavis@qq.com>
Cc: sashiko-bot@kernel.org, jiayuan.chen@linux.dev, 
	sashiko-reviews@lists.linux.dev, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	emil@etsalapatis.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:27=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> bpf_mem_cache_free_rcu() maybe called in preemptible context, this
> will trigger the below warning message:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/58=
20
> caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> Call Trace:
>  check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
>  bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
>  rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
>  __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:334=
9
>  bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
>  __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1
>
> this_cpu_ptr() requires the caller to prevent task migration.
> These helpers currently do not enforce that requirement and may
> be invoked from preemptible contexts, leading to accesses to another
> CPU's per-CPU cache after migration. Use get_cpu_ptr()/put_cpu_ptr()
> to pin the task while accessing the per-CPU allocator state.
>
> Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_=
rcu().")
> Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allo=
cator.")
> Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfd7e415d891073b83e1f
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---

from what I can see, bpf_mem_free() is called through bpf kfuncs only,
and all BPF programs run with migration disabled. So this seems like a
false positive. For per-cpu checking, it should probably check that
either preemption is disabled or migration is disabled. tl;dr, there
doesn't seem to be any

pw-bot: cr

> v1 -> v2: using guard against preemption
> v2 -> v3: replace get/put_cpu() to bpf_disable/enable_instrumentation()
> v3 -> v4: disable preempt to make this_cpu_ptr() work
> v4 -> v5: in mem free disable preemption
>

maybe throttle your patch resubmission spree a bit?..
