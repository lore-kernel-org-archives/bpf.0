Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4418FC86
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558250; cv=pass; b=Fl1hGv/ubpwxCvqBcM5WiGO67eGm06WMx7vBXC+bZApa7TEsPbew7RfiW6/jlIGUxOpCDtJQ4+SeoPfWSDy7d99MKwqBNiw49gJehUMKgFuEUcF/bU8uM+jQqwknR0caSVTHwBzdHY1LYk3PiCT1U+50q0JSfrmvVdr991Om33o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558250; c=relaxed/simple;
	bh=tEnXDpEDuQUul8LMOlQka3HH8W7KL7acGpNS7NAdTUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dydmzEH3+U1eD3wg+rf3Av1cwTd7RCu6sqV5zs1ZgfZD5g1XXYZwMNSb9ajuAKZrJ9SZYofalpQ7dYWIYSNC0rvg6bJH7YJzloZFwg7rBNLXAHxdU0gjZsq51rry0T4xLaHqXobJDKgl7WA0PYlyEG8AmXgZVOpQ+Br47B/7Y6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZsr0Lq/; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZsr0Lq/"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4327790c4e9so4051569f8f.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:57:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769558247; cv=none;
        d=google.com; s=arc-20240605;
        b=iPJ1IKL6S4/fa4OGbDKA8ctAZwAhRSAEzycPBhmeHmw0zBehYhH1umYKlSIxuCql5w
         ekQOzPOrVhXjE2MTwBm1+vD3QV+Ee2Bmdj6cFFG/qMzJpKOtvAEr/n0acQksagATmTUg
         oyO8tULQ+jdosUhheJMa0nl6TOKpWfLEmdTX8++YW4wIBh7AFV74kFApJSmZpz3DthyS
         KyytU/RKSmc8a+l+4/2SLMD0IzlVqFyij7A+nYsHBFhlltIY+ypHewivAfgpo7p7Hm2a
         xhElLj3qNLRXPREVYj0MadBzTPVbcVK8lFe+FHVc6UQd0DcDD+SjIGJsgJtJApbgrpOn
         vOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Wuhs8mK4ZEi2WjVMB9DtaGZVfrakfl2lYnCKR047AnI=;
        fh=PJbsLSJX8dcQKAy2XHfUHAsKfnjgMACdo4w/+okrX4I=;
        b=Zl5n4Cg314ex3YwrY1JOp5yAd/AjjNkx+1W4SM35Rg1jCFycCkqqXnpCirWqWY8mVv
         aXp0HPHqacQrlxVMlb+yNviCeFaXyYrLq9yrIEx3RO2oD2t+iMgXeL/aZkQs17X2dgnu
         FClOrUNQU1NgPUb2ULdlx5w1UMTFxVRGU7vMv2+HuWFq87p7+RQ2q4fJ5xmFPsCUVcUD
         NZmX4bI991iiOe+p13XoyRBgxO6PdYYBbkf4k0mPk7fhpMhUXj0sidliJvQebfNr3ttH
         8nGKRGx3mVGrr9wYEjOUyxpgzMJcccYDfizbuzO970DOYv9MhV+PlBxta/ypLI3/Va0K
         7MNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769558247; x=1770163047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wuhs8mK4ZEi2WjVMB9DtaGZVfrakfl2lYnCKR047AnI=;
        b=BZsr0Lq/QILNSVSc4SLRMZlwV9RnBgiKdmklPTRooan6oFndrNMbf+NMugaN3s86sh
         9nVbXfe0MfaGugYUCKLl6qg2TInpQdVmiiQw2Lf6+3+9Hbi/LyIwmHZyOUjg/FzaJ/il
         c4JkQ0E1Xm0ON38ETW0QJX1wWe1k741w5ruzVr3G5adXKAckl+jSOMptaAh8LGv99N57
         MYtGccZbx7tKfFwUqIITR8wA8CREOY1LFhauIu+BxSQ/pkt0vJfDtKSaVRjtx+MlgFWC
         z+Dal4QNWVmLuVXvcSUGC2FRFEdwPAIf3fFRRyE0bWxBqMGM8uEnXDhGOnONBua8724n
         lVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769558247; x=1770163047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wuhs8mK4ZEi2WjVMB9DtaGZVfrakfl2lYnCKR047AnI=;
        b=RmCjQuWZKo0z+sxcEwUlDBHMgaRHwLa8FDBHSjwJFIp+jInw9mevL7ZLqp+10zRd3o
         4fBzQMSB9a8WD/N1khWTIAbdIq71F35zGffOZ+mAoYkupk3dePIUPCQ+N6PHWFqhVNic
         N6TpsRf9C6u65s0RN9ls7gAAFrJOelga1SRZdjdVDkCAi1RTSEbNH2lRB4LKA2mNhBJi
         IhjNH/bjQMZoAw0NRz5WWmxKuta2uxiIhlppK2HrnYZsK/f2KGFfWBrLXkQBMZxpuFkd
         ZSObwMGf7+mUhexfpXxQF52yYAmzotPH2DmvoZ+QjTcJlPhuJ+k5labk7VmviS1d7RCh
         tiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgCQB4/3hu8Gl+zp8pG5TjZ0w4k8b0BqAHeLsblX0T6MffVLOMtil2F1Yy6WhhE0wbsdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9a43aD9vaTssJxIB+HEZ5GQz1GRH1buv3nJAro/yzsodS2DLQ
	yzhwJpDv+iJTaGX+gQRvdZjMhXRnZnNfhDL/Sv7Z+kXLlzzxp6Bz7QBspbh2KULNQWTx2edaXcv
	93A41Ou3qKo2CcmaByV3LylXF5HOk7/w=
X-Gm-Gg: AZuq6aLkGQ2b6x73uNbGa5V7Vds6qZU9JzwE+xwCJOzB/NGMvPp6qZYKpvpVFU+d0LZ
	WARvt5nlNJmHZolvgui8+93LaBaKQTHPV6QKRFM++aUpiRwX6MFIs8jbX9r76a1uW9tq+MMxBVD
	gO2i7OghArih/M3+3Csy8+RrmITDXxwG/OrGk+5iEPcOz02Th6+ws0yFTHmCkoAPXCNMOPjzdif
	PWnHljEEodAu66gRc6t1MqO212AxtpY+wQCM8mQl+cMjzI9ZZok3caDK/oEvBJzY3MNCBVEc5IY
	19zc6g9XxtguqoOZnQaEK5fWUHb9
X-Received: by 2002:a05:6000:1843:b0:432:a9db:f99b with SMTP id
 ffacd0b85a97d-435dcf6bb08mr4233980f8f.0.1769558246862; Tue, 27 Jan 2026
 15:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-5-emil@etsalapatis.com>
 <92fcc97e-1313-424e-b67d-d86effda3481@gmail.com> <DFZRP6TI6K6B.12EQ0UD7QO4N3@etsalapatis.com>
In-Reply-To: <DFZRP6TI6K6B.12EQ0UD7QO4N3@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Jan 2026 00:56:50 +0100
X-Gm-Features: AZwV_Qiy21yCwAmoN-Ji1BlpEwvl-oOFrY9XJzEDIeh7Zq7Mg2opISL0D2P86a4
Message-ID: <CAP01T754eOs2DCjMmkK=CppEwfk5EX84tc70ZqS0_OxTfgxE=w@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] selftests: bpf: Make WRITE_ONCE macro in
 bpf_atomic.h conditional
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, etsal@meta.com, 
	ihor.solodrai@linux.dev, martin.lau@kernel.org, puranjay@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 00:41, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Tue Jan 27, 2026 at 2:26 PM EST, Mykyta Yatsenko wrote:
> > On 1/27/26 18:16, Emil Tsalapatis wrote:
> >> From: Emil Tsalapatis <etsal@meta.com>
> >>
> >> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
> >> and in bpf_arena_common.h. The bpf_arena_common.h definition is
> >> guarded with an ifndef to allow for inclusion after bpf_atomic.h,
> >> but the opposite does not hold. Add an extra guard to avoid requiring
> >> a specific order for the headers.
> >>
> >> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> >> ---
> >>   tools/testing/selftests/bpf/bpf_atomic.h | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
> >> index c550e5711967..d89a22d63c1c 100644
> >> --- a/tools/testing/selftests/bpf/bpf_atomic.h
> >> +++ b/tools/testing/selftests/bpf/bpf_atomic.h
> >> @@ -42,7 +42,9 @@ extern bool CONFIG_X86_64 __kconfig __weak;
> >>
> >>   #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> >>
> >> +#ifndef WRITE_ONCE
> >>   #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
> >> +#endif
> > I wonder if we can avoid duplicating this macros, for example by
> > including bpf_atomic.h in the bpf_arena_common.h.
>
> I kept both definitions because the headers correspond to unrelated
> features (atomics and arenas). Including bpf_atomic.h in
> bpf_arena_common.h would work, and we'd need to update just a single
> test that includes bpf_atomic.h directly (lpm_trie_bench). However,
> any program that wanted to include atomics would also have to include
> arena-related definitions. If that sounds reasonable I'll update the
> diff on the next version.

+1 to reusing bpf_atomic.h, it's supposed to work fine regardless of
arena or normal memory.

>
> >>
> >>   #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
> >>
>
