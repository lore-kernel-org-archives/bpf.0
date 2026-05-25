Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA843F54DF
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723933; cv=pass; b=R7zyafNeNouVwnwtqj2PRSrFHV38SrRmxVvy4J1b4AP2a92occfSsU0KKGRnT02qwQiS+AsqUAdekgJSLXrCr2/o4RptkqK0bPxzzAWXfYUnS9Q2jqAg8lgIKUX734Zp2zirnus/5nZWo66LZTj3PN6BiwGHF0RzC+hLjGL/dbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723933; c=relaxed/simple;
	bh=K1bIRSu1qsTH0QLG5z+7HNXdx36VKK8jxuEIgQjNPag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcJ3e//7vIYqImWidfdt/ET035HfMcbaaL7pwdXPuf+Ne9bQYXluJwm8K6ySix0zXDp4YLlSLBI2VVLNtDSinY6ORSoU6z97PrdDxA71it7h/eMrEiZGjSpFqhvduhc4RA43jIAZFKkXzj6c+MxU0cNnWwgcc9nBmPGFkdm3AnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6pgB3Wt; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6pgB3Wt"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so7031102f8f.0
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 08:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723931; cv=none;
        d=google.com; s=arc-20240605;
        b=OqxFxJLHpMjKOliLo510NH3NEYsHhOEVIaqT57rWOpdFIsserGHXjtGaXddkaoD8eM
         4HBlYUG+2dKNJJD7kYSGUQVHQpn8l6aJksFz4UliFHcjgMr0cT79hK1Rc8gxAmPPrIH2
         sf+iGmvqjWVND28ZUzrE6xNI7ubQ/YI5BPH5uMoOi10TcZxZRW0QXbKAWdX9H31/Vmc8
         QKylTzmNyNE1p46bbLs7/P8cGjxjfuxpTTR4EpREpfsZRDz8dPNT4O0+jOD/RSgAfctL
         K4Pk5IG/aD74YzWoryIbk5bhNXaJoFpv0Bbz3RW9KGisFLhGMhDapc150JbDiUtkAl8J
         xaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/KJeVQcoYJeZ7NEMluoiY5LeaLQ6MRIkXZPWciIjMs=;
        fh=Jf/U4DUc6ciPl6SikLFsyhnRzyx7oUjddyDlQPw4ZS4=;
        b=P587LPZRMebt//neAcy7RYZ/525arvAcPUyfyI5oyEQeK2Dmba1vtzCtHKIYZ9fDui
         ym6PXbF5Lf0j6Mm1OAYSy3jRFCqoZuOpbsY8dq2FgUSVV3Tnjh0EaQGtzAqwNvC8pcEz
         xgP+SftQC3J25PSOg6fiJfZbIKDoPjSUcdT+wiWjT9YP1Mz9Ukjdyi5AxecrTv12HbA3
         hGK8IY1LxLvswb0jQ7Bu35YNz6w+xM9YrgZw4BhJdA5kf4/DPkLzQ7tnOQpOiIEf4Rjk
         XBGpS++kCbl39E0bdZi7MPtGCnAapDYbYNVtqyTg8bKiHyLLwiwqixT37rvVju/XFBUH
         54aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723931; x=1780328731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/KJeVQcoYJeZ7NEMluoiY5LeaLQ6MRIkXZPWciIjMs=;
        b=M6pgB3WtvGwGn8rQoRvcnuXC2ILRMa2oPTiRP7pwyH2+k5pDnttK1tey8WtVL6KGok
         R3O577yYDyvA0GlLBr6F8ptAUTk0E0rXtRu2xw5GS/c+Z+Fau6z1gXJuwFXVEq9OGxov
         iBpayiKL+SdnU9KdyUNJsXMu0wEai/Rp6OxTd5Asy4dAZWnClKPncksgTYBfZl/UQchb
         37OWwFOPInEXlEx+Qtc2N48tMly0eA/U0M1Bo43Mt0O4cMVUx8DNIDnIz+cuRMzfiyt3
         +y9gzTsbJBKlwG+OZvQl6UZwi7ZL+Stev0yaIdho6BZpf74SdDWSObUr3ORXUln0r98H
         EBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723931; x=1780328731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/KJeVQcoYJeZ7NEMluoiY5LeaLQ6MRIkXZPWciIjMs=;
        b=GGNMEquCCf3iBQtW6Ar/+c7NM9Dlg5PQGVjBS3HmoWb7GBvjKr7bb06meVM/8QyF5u
         fFD4E1KlAyHL0iz2Ji/hGHlsrkr7Xdgptan1y5yACs6qHqG/MOWacJIi/6pjJAkSPNYo
         df6Y+j2U0MGPjQ3xEWCwuhmiwJ9zJY5k0nqbcwCOBVXRY2wfErMV7mw7mXYk/wMxjfKH
         qfzdDjvEUkFP31db7FK+C8+DkrmLP6P4yNNU5StQEdgEArNusk+MNAFmt6MWxfJ3+DcX
         m0NLx8XYYPoUocsbdGmXnKVxPrpy24qSMB1GAJ0r3Ron0shqi6loDvLh0E9TSxyYvXAx
         SO0w==
X-Forwarded-Encrypted: i=1; AFNElJ8JowHg1oGSk79i9uEZy26f4H50mKxApVGd31I/Lo7ToeimOgx1ShM0f/yUKsiz2NKEin0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpawGhXBqeuWfUovq/xmxzTEnkj/cOrHv9tS90KEk+FebzS32B
	V+ZxXSrY5Tei9LbJzyTrQjGx99NuBvpGedbcJsOhmyKMuFOCqy6BgK2t2Nh+M1u3JpAZiQy6kcn
	6zFkNBnaJhMkNvLXlrGAjZUmOSpccYbs=
X-Gm-Gg: Acq92OEozoJmziF3hVqhuktw1OKtQJRW+yZsg+d6F2MOqSkSJjXITH7TjsegonQ3QGT
	gTsO427FJernK+wuPyHm5LHJ8gkVqDAa66WAB0MCc7KDkWNc560vdZVBp69D/T+qPh33piCYKCT
	NYcVbjbEiTQv7xo2rYwsSsqCV24Y3jmKEytsw/6exI6Ywcf5B7+LOxihdYlOT7mtII2bky6B3m5
	OEFQ/DCqOqsLYN0iJynGYe6hhmU0SSgSxxh8fXp/uBIsxgxLhrfXxY3ReiykmApn9Wkld2Xk0kk
	S/hzmsuexrltK45+a86ZrTQMRUA5p3Qz7CTAyd2IL3WUrOlW8ycfopBM3u2f6YLCJGvNMJ2s0Er
	ckZzTk2s+s7cH0RdQhdfrYLhFO6D68ohB+De3
X-Received: by 2002:a5d:59ae:0:b0:45e:8526:7dcb with SMTP id
 ffacd0b85a97d-45eb30deecdmr22155169f8f.7.1779723930477; Mon, 25 May 2026
 08:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522172219.1423324-1-tj@kernel.org>
In-Reply-To: <20260522172219.1423324-1-tj@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 May 2026 08:45:19 -0700
X-Gm-Features: AVHnY4IIG790PDlY0_eU6bDIBpmGdEOYyU8PJIW44rY53Ae4UthkEJDV1ZzBOrU
Message-ID: <CAADnVQJ2r6qYRw-kRe-55Pwg9zAhj7SQkOd_eH=JSAyBFKKymg@mail.gmail.com>
Subject: Re: [PATCHSET v4 sched_ext/for-7.2] bpf/arena: Direct kernel-side access
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 10:22=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Patches 1-2 (atomic PTE install + arena scratch-page recovery)
> --------------------------------------------------------------
>
>   mm: Add ptep_try_set() for lockless empty-slot installs
>   bpf: Recover arena kernel faults with scratch page
>
> Patches 3-5 (helpers used by struct_ops registration)
> -----------------------------------------------------
>
>   bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers
>   bpf: Add bpf_struct_ops_for_each_prog()
>   bpf/arena: Add bpf_arena_map_kern_vm_start() and bpf_prog_arena()
>
> Patches 6-8 (sched_ext: arena auto-discovery, allocator, set_cmask)
> -------------------------------------------------------------------
>
>   sched_ext: Require an arena for cid-form schedulers
>   sched_ext: Sub-allocator over kernel-claimed BPF arena pages
>   sched_ext: Convert ops.set_cmask() to arena-resident cmask
>
> Patch 6 reads each member prog's prog->aux->arena via bpf_prog_arena() an=
d
> requires the cid-form struct_ops to reference exactly one arena. Patch 7
> builds a gen_pool sub-allocator inside that arena. Patch 8 converts
> set_cmask() to write into arena memory. BPF dereferences via __arena like
> any other arena struct, no probe-reads.
>
> Base
> ----
>
> sched_ext/for-7.2 (f31e89a8f583)
>
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git =
arena-direct-v4

I created a stable branch bpf-next/arena_direct_access
with the first 5 patches and merged it into bpf-next/master.

Tejun,
please pull it into sched-ext tree as well.

Let's do any follow ups on top.

Thanks everyone!
