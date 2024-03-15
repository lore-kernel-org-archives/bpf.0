Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB13D572
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518608; cv=none; b=XeC7yRnPogO5r1C1ez9SU7/mMdOL4d9MtD1hxTKfqhIyVudjR0jqCsDEXyzxz97MQuvZR+ik8KUS7PHJssY8Uv0C6YbpvSWfwAAnWlGquk0anYl404mK12dlqCXmaiWIH+UR9oViRg4GFY6VRYFc6fR/gUgeiHZneMSyiMmgilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518608; c=relaxed/simple;
	bh=dwHj5gzY0Sp5uP1aRWo2ZZ6F6iBYRcCWAEjfTTNquhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBRdG5tco+KLXY6UYwFFBDFZd67kkzLauVwU63AsbHtVTLl7+RQJSS7XPbYKpdBv+GHawDrmpxh/tccfhbxoA8vdPS3n380+vlroSRouchQdJGMb3A6nyt7NsTms6pPVOoV80j44cDY4bHZwBxTKqjQ8vx70hsBHgtupZsYIxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3P6riVz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3P6riVz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ecbe78c3fso955700f8f.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710518604; x=1711123404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Blzgypz37b2JG7X9PSwzmVpCFhKRcmcGo5Twd0NTOWg=;
        b=f3P6riVzbZTOFExlOYZOJ8YvDCw0vVRxxAf/fw0RenputHKR+0izc1pb7rZl/qDAfo
         a3SVBhtLzAeAZs8zlLf9y1In8cpEecoKyniG1qngw4w3alRIA/49I28NZUDPha/tUc+k
         EsiVm8FyBv1r8kvQEmKDB+JNarFPUoCnoPPpDv6o5dV/Vcqx9LJqAgVRt8uKqKkdRBJs
         z7Z63BuzXxgyXml/CJInv+oDz6dxtaD3paxdeYheQD+cyb9pWXgvutV00vZfBq19WMJG
         9rMQW/dzQybuUbmSJgW4W/gyaaDWPlxZ/xFXgLJlyr9a/iPMMEuNLRvLBtZsrBZ75xhA
         hq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710518604; x=1711123404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blzgypz37b2JG7X9PSwzmVpCFhKRcmcGo5Twd0NTOWg=;
        b=DVtMKcg8zW+VmgQwTrhaAC5X454VR71YI8TiqhADqpGqPnNIr9QTyEGp0xP81vbrlk
         8mxSvxawB8m7XPSk9I7qbEbYy6N2nS81h0NQmKZMpaFCy1qN16wD9ut3MBrFlq8WzL/Z
         WZx/TwGcVqh7LcrVRYaSd6Za02zQxy1tz6pVej98v9jAGD2sGyYDA59JY5e43XQhiUaN
         lVmqRhdGB1uZOI0hD+lUpfsKaArn6RGdEtk03q602pf6wP9/mnu2rzgJ61yEWnQ7xemq
         lxHuFqdV+xezo2ktUwmr8TzUcqJSZNvNPvYaNDrxaLRxIJX+LAS+jaN2qON7vPlCvSm9
         BU9g==
X-Gm-Message-State: AOJu0Yy300tYLRsEhY60P/mpWIwDFgz+6f9VT5JsNoy17p1CggsgGjjG
	dScT8Pm9PK6df+XIyO+CT/8sMNqQlNFv2z1oUKPqs7CPe9UMD61n+ImovYFGZhkSC0N0w4bi0J6
	ZeLv5m+CD0jx44jLifG46snuFiXlxToIjve8=
X-Google-Smtp-Source: AGHT+IGlasP9uUFNx7lz9t4yVokdzDnJihxJPumFOJXdBXnP75qXzsKSEHpxQWtlAHD056RUR89j5AEbzBK0/v8JUQw=
X-Received: by 2002:a5d:6a49:0:b0:33e:7cc8:bd68 with SMTP id
 t9-20020a5d6a49000000b0033e7cc8bd68mr3244583wrw.31.1710518603642; Fri, 15 Mar
 2024 09:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315051813.1320559-1-andrii@kernel.org> <20240315051813.1320559-2-andrii@kernel.org>
In-Reply-To: <20240315051813.1320559-2-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Mar 2024 09:03:12 -0700
Message-ID: <CAADnVQLFCVCdb4Uu+6QJMDybUc5RqLCF-5yS2eQVoQ==qq3vvQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel
 BPF triggering benchmarks
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:18=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping between
> one syscall execution and BPF program run. While we use a fast
> get_pgid() syscall, syscall overhead can still be non-trivial.
>
> This patch adds kprobe/fentry set of benchmarks significantly amortizing
> the cost of syscall vs actual BPF triggering overhead. We do this by
> employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp program
> which does a tight parameterized loop calling cheap BPF helper
> (bpf_get_smp_processor_id()), to which kprobe/fentry programs are
> attached for benchmarking.
>
> This way 1 bpf() syscall causes N executions of BPF program being
> benchmarked. N defaults to 100, but can be adjusted with
> --trig-batch-iters CLI argument.
>
> Results speak for themselves:
>
> $ ./run_bench_trigger.sh
> uprobe-base         :  138.054 =C2=B1 0.556M/s
> base                :   16.650 =C2=B1 0.123M/s

What's going on here? Why two bases are so different?
I thought the "base" is what all other benchmarks
should be compared against.
The "base" is the theoretical maximum for all benchs.
Or uprobe* benches should be compared with uprobe-base
while all other benchs compared with 'base' ?
Probably not anymore due to this new approach.
The 'base' is kinda lost its value then.

> tp                  :   11.068 =C2=B1 0.100M/s
> rawtp               :   14.087 =C2=B1 0.511M/s
> kprobe              :    9.641 =C2=B1 0.027M/s
> kprobe-multi        :   10.263 =C2=B1 0.061M/s
> kretprobe           :    5.475 =C2=B1 0.028M/s
> kretprobe-multi     :    5.703 =C2=B1 0.036M/s
> fentry              :   14.544 =C2=B1 0.112M/s
> fexit               :   10.637 =C2=B1 0.073M/s
> fmodret             :   11.357 =C2=B1 0.061M/s
> kprobe-fast         :   14.286 =C2=B1 0.377M/s
> kprobe-multi-fast   :   14.999 =C2=B1 0.204M/s
> kretprobe-fast      :    7.646 =C2=B1 0.084M/s
> kretprobe-multi-fast:    4.354 =C2=B1 0.066M/s
> fentry-fast         :   31.475 =C2=B1 0.254M/s
> fexit-fast          :   17.379 =C2=B1 0.195M/s

I think the "-fast" suffix doesn't really fit here.
It's a different way to benchmark fexit vs kprobe overhead.

I think the old approach should be replaced with the new one.
There is no value in keeping the old stuff around when
now it's clear that it's measuring much more than it should.

> One huge and not yet explained deviation is a slowdown of
> kretprobe-multi, we should look into that separately.
>
> kretprobe           :    5.475 =C2=B1 0.028M/s
> kretprobe-multi     :    5.703 =C2=B1 0.036M/s
> kretprobe-fast      :    7.646 =C2=B1 0.084M/s
> kretprobe-multi-fast:    4.354 =C2=B1 0.066M/s

That is weird indeed. Since it's a single cpu run
it cannot be due to contention.
My gut feel is that something odd is here:
#ifdef CONFIG_X86_KERNEL_IBT
static unsigned long get_entry_ip(unsigned long fentry_ip)

Did you have it in your config?

> +SEC("raw_tp")
> +int trigger_driver(void *ctx)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < batch_iters; i++)
> +               (void)bpf_get_smp_processor_id(); /* attach here to bench=
mark */

bpf_get_numa_node_id() is probably even faster and
not subject to DEBUG configs.
