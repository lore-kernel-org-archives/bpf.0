Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343378;
	b=LNLM21Qai3RjeroVR01hiIYdcSF1fHZ32bbEMpJyElKYisCVTGoTxRlVx1sbbfoWpyFP
	 0RyBmoQpqie6vTxgpHeRjT5dCuNppLYFzIGSP+WO8lwBQ+mBnw2acZsFwQvb5TVXw3T2l
	 3msJ1H8VZGIMWf9cOQw/wtwRN81D+NlBnXULfLFy4/PAk2MW8+z7NE/qdVRHLOreyFkby
	 rzVh3zl34FHosILyj56dcV3eEuHWdXLfZIMQzwCTrrqCu8sJhkmm+5Ib+ox27kFxJfoDm
	 35fB430Gx6ihzAardVvAvtdWDTQ/mcM/RwVeaUByWvyunURzi8F7TJ1ehjIFKEpEQgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6JIpC5xmZmVh3gHvpm6TlSXy64wN88S92afzeHcQ6Bk=;
	b=L9b6IQSLOy2GXR17C65xstxDpfuuuu+RD0KgmFSrL8ViYt1uTduaYcWzoWZR6LujZE26
	 D5podxQhRmqnpDis23wy5qysYnHO7kIaY4fAjHBx6yl5nMt0zoLPx5Q5pJUmHsxjkyutS
	 tluDISRO3i+b3FsgyH0JZ1l61mVITKKdF8uxL1CHaLcFizyFNjaWVlE7PWc2JdFqnXCMK
	 xZVC8Qfj3/TVDUz+rOBkKLl0pUX/0JMPC55ySDmoseowkPz5aogzoLjx69h6MvaCxD9sj
	 2lMQXeIm0ZpVHZRO0HzdY0rxpAdIAe4daAgBiBHSHnDDV1z0ILduoDjMJWHijsgetUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=BzOrX5df;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7E606A325
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 20:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43A7E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=BzOrX5df
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b0b6cae44aso432955a91.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:42:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794343377; cv=none;
        d=google.com; s=arc-20260327;
        b=XWkIbU6sRhgZRCZN5hyhZrAELe7H2smbRDZHLJtr1bFCxLH7cF/Q8GThZbd9lQ845V
         LS4LssvhUPcyo1X9kNwhOssAhT7vK3vjirXGjCjb+EftKmniGTeYMwdJ+vNRHWYbZxUy
         JyaNZ5AhxqfxhtT6ze5DXCykR5hpunrWSEST5OU+v6bYS62SbHlgpiZWyjWFDQY1GkmU
         JBbVYu4iG8l+DqBZlHw3/HDsmBlp+CI/UcpSNvD4H6dzd27XRv32daJ2LbvSvFtUwiMM
         cFe4DOyNbNeXQKCLZ6POGnIfuzt+doVvHj4roSldCHjHoeT/7UYJ+RMXrMozn0C09BEc
         qLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6JIpC5xmZmVh3gHvpm6TlSXy64wN88S92afzeHcQ6Bk=;
        fh=IXo7Z6J2yqsKXWGKw6CRk3yi3MqnnW45OHgM0cqdPUo=;
        b=f52+tbvE7kuCS8EX5nXPuN4WJ1gxuBDV9U3T8I7an8pUzXhkwdzrQ6u+t5gSVw30oN
         hu/PtOqEROnsTe1wQTYf2K7my/kArtM3RzREKY6k1AUnFE0uQ+iEjIcUT8cwwXcoVU7B
         IP0m+fJQLCJcMJSRNeDjNCuZZ3Onm0Q4UiL60Wq3nsWRtCQi0wciTm44sOtHZtmvKBBT
         2WlXyi98Fnoh9HFYoMn7nwwzp7KcGn4ECtBRp/MlSD6+eEaNum3XMyKVMMliP5pU8kov
         vPXpO9oqssFdcQ4vJ1TbIYS3hucYsHUCuc/akXVvOY/3EBWtBHwYuLzsw6Ac02h+TDFg
         vpzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1794343377; x=1794948177; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JIpC5xmZmVh3gHvpm6TlSXy64wN88S92afzeHcQ6Bk=;
        b=BzOrX5dfpE+ATWGL/wdnDmqs110TVhKTlWIlwAI7dDMi72e9e0m7HPA4+FO3KKu4+D
         jjDcivdVMk6pFQQZ7tqXAm81UmXbkm0Sj0zwPWm5dNiPJIje1jHSipW0d/82pks/7gP2
         3WHAPaEwpL+zWUIS5nnUbKOHbvoNQHJIOaRvY54sQfLoC96BLA00QBwvxdr4Gtrv7GId
         Jq9lCx92m78rRmjUjEJOlaG6bdRXLRNFcS2xrkwH+t7+0yVZbQ1bkObsSQJ0Ez1IefzT
         NKBrqUOHNz1Y8Xgv4/wLJ6SmZHlCmp87DYAfN2IejsMxJKb1s3eCOwQFI/knqHBBQfrC
         25YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794343377; x=1794948177;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6JIpC5xmZmVh3gHvpm6TlSXy64wN88S92afzeHcQ6Bk=;
        b=gahWttsK+kl1SHRTIY7JzSfaQAgmAlIpi+cxdjfIVMC2VyskOARAXBOAKCI6GOlEqd
         R/nhjSd+BocI55hA+cZV/5GCuXLsE3N+jLus3aqZngU2nBnHTD/v6ezrUk2kMutC4LPB
         LWgiubBQ6OqwqWCeQR4R1lluJka3iq+fYf6rLG2G0e1uTwl3q4hHoF+Af7qli13XMLlO
         D4v7Q+wW/Xv1Wp4askI+Spm0vZh2HVYzqXFHzbjd90VbObbGkQwfE6CdPYUH/TbNSRPW
         V1CDGhImuEHTUa9UybfnQ66EoS1Tu0DQGLI7A7W8I3oJcD6BQ7A5OtiL4JWtDN39Y0cg
         eOKg==
X-Forwarded-Encrypted: i=1; AL+hErH2ma9rhI/69RWBkHtOs6EHgn+Lvkf2WFNNtMmeO40FtD/cf76sf6SdtlBdL7nDLavqx9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/0quSbW4SN74gSLPsFCcxGzQ7R90VIAymh9XVMV2/PHCxk4XB
	2DKy00zWcLU9kIGS+f6QBhmkxEzR3z+gJ0SFp2fQPduNba2rivHO/mu9En475fP0GLsarr0Z8kZ
	7Jj/2MK4u6ojZyWP+d4/R5uG4Rxy2PJLFD7lDG5cXKA==
X-Gm-Gg: AYBFou2aUFj4WYmGiA7MElbwo6LBhyfQ/O2U8Dz+6jqvWWlUPifcb/6ICFmU6LpnTaN
	OuI5FqmjCa0exrAgsgm51hNuAFRaQMGcm6IhNeFCxM1v5cktErXhE5+sbu/x4a4Ta+jwAMY3tRF
	kNtUWjM+S492UQSUlv7uzVdYtI1XU32TST3Ln388HNsm/35ezhSuIUpoaebreyQr6HyEClyBflT
	yUTsuCLsuLTAztlWhgFdv3QZ3ItYzAMHhDcea00pRQtMic80h5XxYApycfXN/V2sysWubhwhZIm
	TGpRZ/V50BJ3R5uiV7KycQHpYqzLpIYTa8Xo0CZo/RsqXyT424cW975185h1TZXUxMV0E1RhVAw
	ziTZHPnPGwn+1/Fd1z1H6X89HcwZUMVB2Bns+Li8BEOo/0lwtxTOvdfka
X-Received: by 2002:a17:90b:540b:b0:3b0:975b:2256 with SMTP id
 98e67ed59e1d1-3b182f9b9d4mr203359a91.4.1794343377444; Tue, 10 Nov 2026
 12:42:57 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>
 <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com> <CAPnbwjpQBR-KHwOMG2bo1uhdp22ZW_O5sUj3=vjazVu=Rdnb7A@mail.gmail.com>
 <DMN0RC27TJRM.3KUSPS9QTBV4G@gmail.com> <CAPnbwjrX-ywbcgNQSZKE2jiggEOSVCRVw9OLfaksihiVSCoqvw@mail.gmail.com>
 <CAEf4Bza0XDMTxxZeukwRXjvoOOruY49q66xBXnYnuncbeo_Oiw@mail.gmail.com> <95e07cae-85ee-4f14-b5f3-070803ee567e@linux.dev>
In-Reply-To: <95e07cae-85ee-4f14-b5f3-070803ee567e@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Tue, 10 Nov 2026 22:43:02 +0200
X-Gm-Features: AclHuK-KEMNOlfWD0UWl6ryn4dajINfOogjLWWr7jApapLp0YR3rK8ycXvkFphk
Message-ID: <CAPnbwjqw=uxd8UyhEgNjSrpK1DhbB+dex0mGVW=dwuoygqgRHA@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martin.kelly@crowdstrike.com, andrey.grodzovsky@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 9, 2026 at 4:12 PM JP Kobryn wrote:
> Before moving away from an in-kernel solution, can we consider the
> direction this patch below takes?

I haven't proposed moving away from an in-kernel solution. Your patch
is the same design I proposed earlier in this thread ("This is what I
have in mind for v2") with Andrii's bpf_ctx suggestion folded in, and
it's what I've been putting together for v2 (unless someone comes up
with a better direction), which is nearly ready to
post, so let's avoid duplicating the work.

beyond trampoline progs, v2 also covers raw_tp, tp_btf, syscall
tracepoints, and BPF_PROG_TEST_RUN, and disables the per-CPU private
stack for preemptible tracing progs since two tasks can now run the
same prog concurrently on one CPU.

a couple of notes on your patch:

- Passing prog to bpf_set_run_ctx() churns all callers that don't do
  recursion checks, and doesn't fit bpf_prog_run_array_sleepable(),
  which reuses one bpf_run_ctx across all progs in the array. In v2,
  bpf_set_run_ctx() keeps its signature and initializes prog to NULL,
  and bpf_prog_enter_recur_ctx() sets it after the walk succeeds.
- bpf_io_uring_submit_sqes() calls bpf_set_run_ctx(NULL), so
  dereferencing new_ctx unconditionally will NULL-deref there.
- Cross-task synchronization isn't needed: a task only ever walks its
  own current->bpf_ctx chain (and any IRQ/NMI on top of it runs on the
  same CPU and walks the same chain), so compiler barriers around
  linking and unlinking the frame are sufficient.

I'll Cc you on v2 once I post it (probably by tomorrow evening UTC).
testing and review there would be appreciated.

Mike
