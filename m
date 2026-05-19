Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91AB2F8E90
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218647; cv=pass; b=G2hhxcaB/bAIEuNoKsaIy/Mre1S/voZxKvnrjgfmDW91Isdszw3tcSA9WxACNAB5r8v0TCq97bovMLJAnZVzU/sVzIxmPjvXGTCoGVDsUcLLugoBSVFJC18BBhPKjzTdQv+3hm937RPkgyZGay0VFSMgRaI04SOrlPXzD38BOZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218647; c=relaxed/simple;
	bh=RlvM1M6ANjyWqgZqYLqn7hs5nlMVkBq/XuvFm7K5JZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUEmcfyGNrW+WtMefdQh5foBnfayp42ub+hP+n20W+CT+x02ProHU4i7Lrq4uQFy6HO33RMX2iPQOYPByJGpfpKGCqEUK0s9ZUm+AzcS1EkfU8wiFRbS5mjqp+Kcba2Qsv7ZdGBX6vNUgzzSTbJSkFtxaKXrWifRY7pViHYDMUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kgv6mxlm; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgv6mxlm"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67c1e0229acso6653120a12.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218644; cv=none;
        d=google.com; s=arc-20240605;
        b=jP92tX6zUnTLCuB1rMUJ2nhqdeZ5g8nzPD92CW4cVIIT39MXtXRyYwSo9zO3DPwYKx
         L0/2ZnHuxcPx941fdrmGBHIQ4Rhamakcc/oiQnWQppPdEcXJutV00fG94rmI4qm9g41b
         ZRhFE2FysN/ppwq7oAiH7ac+itSld+g4km1USLUbZLX2hXp8ReWAKLDRhG/U3s045id3
         4BbBr9jSwXR4dQ5MuwyqBGckfJMNM/fgKQAc4+KyQW3f2TGKe4D/ix6+NPCAlgMBRdGT
         C3NWkxHRXuZu6efBk+BGkYjEmy675N9iH5UTDPiLShOnCEoz+F25Cv4t1uzh2s4dtN8c
         itOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=llVLZbOPPPSzMipQ2syl4ldrO1/hT+fdvXZ/pihXu0U=;
        fh=6hiPdiTe4zHoVSFcX6DceRO15RsbA1SKMTu9jUn9QM4=;
        b=TIDbMv4V8nWbOs2Gblt4s3PFeVn1FdTskDa+y7im8BgSUihkueGMSnYI2imgC49IlY
         isdJ6YD0GqPuAr505EagbQk9nx7rbznVKzZxnMgH7bALGOXLeschbfpKRHj3vUyobCih
         ld3aysWwkzhqdT7GNHbJ3rd77q/gZn5jdnY96U8jmLhhxQQ5a3PfrLVklBj42NAotvOW
         zZa3Yuat0usgfQmSdlBUf+z1vfUUthlbAL0c5rV+9v3PPKEi4/9OmxRUU/4PQ2S9uwVI
         AhS2w/ZDxoJfFXinOGgUJ538YQ9PG3Gq8vN4DPAWXws+f/XQDF9lazLYoj9HcMm3GtcJ
         kqig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218644; x=1779823444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llVLZbOPPPSzMipQ2syl4ldrO1/hT+fdvXZ/pihXu0U=;
        b=Kgv6mxlmDc/TSode4v+KFx6cpXeqzT0MoSTKV5VIMm4QYJQk7YLOS+jwxjOKu3GgMv
         h+ZtoU//Ym0IO/KIGsGmkI97jDVd29Tjz+wUqSlcoqRG5eHlhgGIPi3qUBt4mNg/+sUw
         B4LteX2a/XaX1PxzYCVk+5R7YH6zN2QmxCiHvF3qaCDM0TtZgJgyRe+9FuIZx8g1B1st
         SU14EUPwaTLOIAzAYr/j1wyDpcKgRTE8NufoO3ur8OzXE87I6oTyhCepbezoOu49Xxt1
         KNvfbKRmqhrOi3jxXPBj03cOLOACq+DDbc9HPDa8iaP6i/eICgZECc7F/Mqfcl9F7Lvp
         VzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218644; x=1779823444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=llVLZbOPPPSzMipQ2syl4ldrO1/hT+fdvXZ/pihXu0U=;
        b=SlmqOyz02R7JXcUWQYZmtmzTbWQm7dzoO84XcgYckVQaNx8kQdJ+qeRo2ypHDJK40a
         WbGVb20w3CTFc7oVF1kGU9aPVapUI2hu3AtoCHyLMppbWIs3SCiCUUHeglw9eCQbFF5C
         DNuu0uFCqRJjJCpDZNQ09XNMGjHzy9hB/NP8pNp3xX/poVzL1DYMUgWP7TzIkOIOKKDx
         ww6brjGYBgOIQzT4M9X8L2uIc9pUU09WE21sWHxdML2W0N0ZIuS3zXHj3j/3TnDAQE+q
         Lm8JDorVu+kU/9P1dVsv6ZEIgH0bNj22V7yKuIlrCa1+t+Qeg2jQOu8vCFYeiIO3RRB7
         arVg==
X-Gm-Message-State: AOJu0Yxt6FCpKutduCzTQgn6RBI7d0aJnv1Q786ary+YHlAt6/yS7Fcp
	OBIQCyjmSFdHxKIXOJ1vlPJ4xHECHpWsCbMsbPXUj/wIyHAcmOea1d22l5F/9LZmfQfFZB1h3qr
	OahYt9tBnrVjgFZ5nxov5JUU4KlrwpVk=
X-Gm-Gg: Acq92OHh8021YVCA6Wdyhw/DO0CgVG0jVLk8vsFWwrDSETbEdKPEp5hkJmHeqmDyP/Y
	y/DT44VOQVYVQwTq49ilN2hQDaCDm8NUUhKtuHqwned75GmyVPD36ZEo5vPFvlnWdil87EZzQyA
	LE0LokaFTzgHDjPeoyi5wIG28qk0Ob9owyuDT3KEw9y/zKDoFVfBvpIQEg8TmURCJxfjRV5grZh
	ChvszR80zD+NnANFGOv/XB7ymiENw+H2Ir4IAIpRE4NpZh7+XKFtOLqIgZHTPPMHvztZ1819HsD
	bHEi1oTMA1t/jir5ACiXHePCLqx72ZhCp7otku/E7Q==
X-Received: by 2002:aa7:c14a:0:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-683bd68303bmr8038389a12.19.1779218643829; Tue, 19 May 2026
 12:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519163632.2220753-1-puranjay@kernel.org> <20260519163632.2220753-4-puranjay@kernel.org>
 <CAADnVQKhkKPS_7v-4dGWEsjR7rBRB_XG4jHq3JpLYwzKmCn4Bg@mail.gmail.com>
In-Reply-To: <CAADnVQKhkKPS_7v-4dGWEsjR7rBRB_XG4jHq3JpLYwzKmCn4Bg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 19 May 2026 21:23:52 +0200
X-Gm-Features: AVHnY4LucGI1rbU4TXVGDWXG5eVGsToCd8XmhyzBF3DZiYEMpkb0mkD5Vd-ULaw
Message-ID: <CANk7y0h2T3d7u2O5g8PFTNAwQgHedi9r7BiNv_pVVmFP4JOGXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Cap batch-timing calibration
 at BPF may_goto loop limit
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Fei Chen <feichen@meta.com>, Taruna Agrawal <taragrawal@meta.com>, 
	Nikhil Dixit Limaye <ndixit@meta.com>, "Nikita V. Shirokov" <tehnerd@tehnerd.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:11=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 19, 2026 at 9:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > BENCH_BPF_LOOP uses the may_goto instruction (via can_loop) to bound
> > its iteration loop.  The kernel enforces a maximum of BPF_MAX_LOOPS
> > (8,388,608) iterations per may_goto instruction.
>
> claude is incorrect.
> may_goto is timer based. It aborts at 1/4 of a second.
> Old BPF_MAX_LOOPS limit applies for bpf_loop and bpf_for() iters only.
> Is this a theoretical issue?

Yes, this is theoretical, the benchmark will never cross this limit
because it runs the loop for 20ms at max.
So, I will drop this patch in the next version.
