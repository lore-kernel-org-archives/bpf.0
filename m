Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAC17B50A
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016619; cv=none; b=lPQO2LNdma8lwguVBJ93kxzvamWohIxhHUKAHbeKJSjDbQzFz3pytuiL9+avtq+OIDiGW7plRbnEyJqmiuvGf88sXgOnfSBP+3Aumx4OjF/AQXVQyOVvNPQFxpzqDfV1s7zRjllNJZGO92RbB9cJzNyerRfgBXumtIT/zUw8+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016619; c=relaxed/simple;
	bh=/KkzOjBdfKQy2PKOpjoFKv4ZMutKIw6NJW/W8FCK7cU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hJPzU/94Fi+WqZ/RFKxudZ7QtnkQac+vzSBs2WhMFzfYC/HzPR/ESAv1okL94OeNHLgxlMSSI+KSMQcSZF9bWQrZ5rAxpOJz3pZyK/fKnEQoWwDx4qUfcyBP8aGesL9s7KnKmBm8ALedMhLdhdCGl9MTkdsC76hit/sdhpVVwoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsOJLqQ4; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsOJLqQ4"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479d593a0c3so10964476b6e.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780016617; x=1780621417; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylWRg4bGcwe7ZEke+FfWeW8Bfa4iTQbilHYuBByUGKs=;
        b=HsOJLqQ45GjDHlhXoEXmst8zrRZeU2ZTqniHc3c2ngQNcJ7661n3+wjEkVw6K90y7a
         zct/b1ZiQwOjdG1MwI/K672tn+EQdS9kD8ej/DSgfdictJ7GToSIF7P9HTKb5sYsSdDK
         +5UqDMblJj2b6IIDEaD61ILs/lgzRuDLJ7UlC+m+qdg4LtpzdsEAWz2+3BOcQHfEE1R7
         RyFphW0QZWL+/lAkgd/VLJk8LFo0oMU7wMuze8fwpVdXp+lFabvCjcrfblNDH/YVA/1x
         yFMKRGmvgozifFOfvH+A7EavKVFyWqGmtOdP6Y7mmzvlyis7H6qQqdKnpkke+lP2vjQN
         aNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780016617; x=1780621417;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylWRg4bGcwe7ZEke+FfWeW8Bfa4iTQbilHYuBByUGKs=;
        b=JW50zaH59ajZuDaLHjJipg/n+r76uFGp3YcWTXZdm4olHQBybnKNTVRUL7d8+UAjF2
         XsfaYBBjN5hstxsF8V7HrkOfCNBCKGGWu0A61XDAzfXuEWK69sztaBuaF1is/M32DY39
         Rpq7JX5fGOU4FQONXA70q3tQ5EaiFo7zagwNzUawszBEyipFJsX+QQLEzadTeGhKbyuk
         50MzJR+Dq+qV4mQpST45mczXNhAJmvTKhxe7P94JXt3Ju3vLfiFmu5dIrc3r3QPYw0M7
         QoIm9RxePI/nRjBIJO8peJRPUibjHn7q5+/ZTzSUrETW5sgJfIdZPnhy9vRKUr/fd2SK
         dTEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kKExbr3HegApNHdl3E4zKLEyMhPntdqO09RM8BhOB6r8xnWl0SNDRFfJqGxJDBPrIcSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmQKlK3CN/P/o1780McZkH8DrmwAeTmfIyHldgMvX4vEJGb4Y
	OBmF6tcYxzNMM4U41xNyI5jNzLnrigxrpVjr4M8j9N5Vn9mnsrX7PEA9
X-Gm-Gg: Acq92OG/zYvK/XtVTfLiWqa9rgBHc+jgdHhqewzPmA9gkNHBoPZj2mRVktROAXefXze
	W2vnJICJ7aaHR6boxYRqtY9tPukgACiHzGLUHtLXixdaXbdmopPU1VXbElpmjMN8OMxHpMgoyMc
	JA+/hbVwqIfNxBizIlDxhhrifBue5PQ7lc0rQjzlxp292U4X98rY9PS5iGxxa63WgdsVTtJ0rwr
	0SYn3119p2JhswNhVNd2B8u+B1Ihg4lMbKHr9tE1/6v2S5jllmxXj3afJhVwBlf7V0aV4RCP72G
	Vn3sW8XEcy/hXW54vdJvLf2mqWCsOxrEWoTBInJTueb5q/w+aVDq8UIXSMIEDy04q9wxYgQEuwX
	PUvX54gbNhcvTJdxqlTD8+W8Fn/wgGscuWknTyoC7dDAyD3SWxW82sWaALxt3u0TUPexF1a/w14
	f+uvZgSDBHqwrJZnfZ1bHqOIJYs764O/qsVQORrRta5AP1W+QAqjvYgFcxSXnFgBxACW4COqx8U
	XvJjILB3fmxBVGd2fSHGf7Cf7yZ
X-Received: by 2002:a05:6808:1a1d:b0:485:4c7f:8f51 with SMTP id 5614622812f47-485e73f86bemr368030b6e.25.1780016617320;
        Thu, 28 May 2026 18:03:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d17b1asm338219a34.17.2026.05.28.18.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 18:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 18:03:34 -0700
Message-Id: <DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com>
To: "Yuyang Huang" <yuyanghuang@google.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, <bot+bpf-ci@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard"
 <eddyz87@gmail.com>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski"
 <kuba@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Nikolay Aleksandrov"
 <razor@blackwall.org>, "Paolo Abeni" <pabeni@redhat.com>, "Shuah Khan"
 <shuah@kernel.org>, "Simon Horman" <horms@kernel.org>, "Song Liu"
 <song@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Yonghong Song"
 <yonghong.song@linux.dev>, "bpf" <bpf@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, "Network Development"
 <netdev@vger.kernel.org>, =?utf-8?q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, "Lorenzo Colitti" <lorenzo@google.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Chris Mason" <clm@meta.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org> <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com> <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com> <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
In-Reply-To: <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>

On Mon May 25, 2026 at 12:21 AM PDT, Yuyang Huang wrote:
>
> For this example, the regression lies in legacy CGROUP queries:
> 1. BPF_PROG_QUERY for cgroups is not a new feature; it has been in the
> kernel since 2017.
> 2. There are existing legacy userspace applications and language
> wrappers (like our android net-tests) written years ago with older
> structure layouts (passing size =3D 40, ending at
> query.prog_attach_flags) that query cgroups.
> 3. In June 2025, Commit 120933984460 backported "revision" support to
> cgroup queries, introducing an unconditional writeback in
> `__cgroup_bpf_query()` at offset 56:
> ```c
> // In __cgroup_bpf_query() (kernel/bpf/cgroup.c) - Introduced in 12093398=
4460:
> if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
>         return -EFAULT;
> ```

Ok. This is fair. 120933984460 is indeed problematic.

> Now lets talk about BPF_TCX_EGRESS:
>
>> bpf_mprog_query() and tcx_prog_query() were only introduced there.
>> How come your userspace passes shorter uatter to query newer
>> BPF_TCX_EGRESS attachment?
>
> I understand your point, but two common cases exist where userspace
> will legitimately query BPF_TCX_EGRESS with a 40-byte structure:
>
> First, a generic BPF querying tool (assume it called `./bpf-query`)
> compiled in 2020 (when the query buffer size was 40 bytes) might
> accept the attach type dynamically from the command line:
>   ./bpf-query --type 47 --fd 3  # 47 is BPF_TCX_EGRESS

Don't buy this at all. This one is clearly a user space bug.

> Add gating to the TCX path, will not be able to fix the legacy cgroup
> query path. As shown above, the cgroup query path has the exact same
> OOB writeback regression affecting legacy userspace. Since we must
> plumb uattr_size to cgroup.c to resolve the cgroup regression safely,
> applying the same consistent size-gating in bpf_mprog_query() seemed
> like the most consistent and robust architectural path.

Not really. Your patch adds checks to what looks like "random" copy_to_user=
()
places. This thread is clear indication that it's not a "robust architectur=
al path".

True robust path would be to wrap every copy_to_user() into another helper
that takes uattr start pointer and size, does extra check, and
returns something like ENOSPC (and not EFAULT),
but that would be a significant churn.

So I prefer a minimal patch that add single check in bpf_prog_query()
that checks that user space supplied buffer is large enough for attr->query=
.
If not -> EFAULT. That would be better than overwritting.
One can argue that partial copy_to_user() in __cgroup_bpf_query()
should still be allowed, but I'm against partial and
inconsistent queries.
query.revision might seem benign, but if we do it for all copy_to_user()
we better return ENOSPC to differentiate vs EFAULT to tell user space
to fix itself.

