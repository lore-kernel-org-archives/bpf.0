Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BC2745E
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762586; cv=pass; b=mF5TR0OeLox/5BaYwzwYphKjHgx/sF1uXS7I1mPAc/cbRvb9nr28Zn0wX44l9W0HLJmMF61gsqXe8jBw2P6YTMRMb9Ue7pcA2njiLAhnDJ5lAfdiG0cyzqAm1AMHi9eGhEXUCmW+KkzPeeetTXOJzyCYzmruNiUVZcJ9ED4Houg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762586; c=relaxed/simple;
	bh=wZifllDLqrzfTTky/Ks9i0PPWTRoBdFc736qrpVFBCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8Ll2u3/cfxVdFQGnxHx0224ARAQ5PC7g7ksTzhlpnjrJk7ysQIu2OoS+QPU5q1Y+9vj+tHpRC3iIgaSjRT8M88WGq8xa+c86eWYRiaEXyYlyAn5vwOEq1Zk2QaYRZdszl4ShqVs7vAbOLYHyQ9Z1JOmZAMwYu0Va+KswYZeFQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfdhhaWN; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfdhhaWN"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso2423057f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772762583; cv=none;
        d=google.com; s=arc-20240605;
        b=HxxFy4f0NAYVhMTWdTUqDwdBJdXNBG1CxhvkgF+X2oorFKCejWABDXyr/FG7MPpFwW
         KBS7MPmFWSdKgnG+h1K+mXmxVpwi5DhSzMfRg32mC6qFoWQqkNKXWEtwI77K7L24UQ2a
         m5iIlPpw07PdObdF04Kx7T+gZ3u/B3HH82y6Y/I3Xw1T3cWPRQ5zd2jVWxIrPLHIaSa6
         Da0mZvfQye7alS+5wFsL8aaLf4UCHm2V5tNtmXlplF+6uD5m4JlarRbTh5o0mR5ah8Yx
         D3aphy09upudsCWeine0xpIWGdMLbkIp1JbySL3pdjFTQMe6buW0tP0h027lxZGTP1eN
         AQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sVeF+T24pcQH3MSIrDhsq3rsjFnKz5WU+t219wmw/rU=;
        fh=Z/1ZJMiITAkvWHV3GcEclQLh4LC1L//80QSuNHwyrY4=;
        b=NBAzoETGn/PeHKdYzTa7WpB/RU9OZQScIjmM3O3RKqu5Fiqe0z9rkUIImtjP4DHs8P
         N7cTRte+TVYWARXZ578Gld+EADzs9K6AzRMnckFlZ5Hv7hiLwqzlIh1Y/cPq6r53/J8q
         n0liT9qimZ+YiU4G4VBdAi+TLvIpk6vBWpO62hXDMvtl6JWKaReT5/3cheaohC4Y9Q3n
         TURxeHV67gVYAuv49MzoUmKmxdBXSzRfmGeqm7PRxtMFn0vrQiEhSyP/6LGi9FvdCcgB
         ogGw+VjgVgibT5Htqxmku35sEuUhtYNxnype58Kf/5fgkEUKn2DkuZmar//ZfdPqm3vj
         PJdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772762583; x=1773367383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sVeF+T24pcQH3MSIrDhsq3rsjFnKz5WU+t219wmw/rU=;
        b=nfdhhaWNOG6nNFH5Z2YU55qHzKMqLwg1wMS4Y/RN9gJPN6sMUgGiGEDkq9kvLMKmaH
         5S22kreER3BROE8HmvZJrN1NfqG1claDqArwXRFZtXQ2weaUP8kLrgy0h6YIpFE3GW1m
         OV75epJLZjdYRqrBfdI/UGypcqgStaNKf1qdT+engS3TlzseiiWoR/+HMo+eVFljIIYA
         SQI2aBzabRq7Z6S2DnJXZLWFNElll+0nhhh0KgPnvgJgcZSkPxaceH5tEaVXvllDdh8R
         mxq9eCYeNEatwQELNDpHJxif04lDqKi49pQ+48ggIQIUxy3h3QTAUTtkasSwCFN+IW0q
         kpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772762583; x=1773367383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVeF+T24pcQH3MSIrDhsq3rsjFnKz5WU+t219wmw/rU=;
        b=UhX1EebjqsK6hbAlm8Gxhcowpg1VXKOlsNZboAG4HwBVOjrc9yIsqPF0+WwHdiOhLh
         lKAaKs1DPDqkARY0kBldvNR4Krw404gNjp0TBPDiwP/setH5XcYabrpwxc5ImU480Vaf
         2/GGnfUIkzQI0QoUvphVm9+7vUIjeyx0YpT9Z8jVtZSIitLKQRHqt4CN6rVORDAkji1P
         9xKaQcntefP/45KGZWckcjFr+lvrjZDkR+SOdr28N0OOGLe5KGy1HpGgXZdxk2pwyt7L
         7hwULltfSwW8vFfV/GHdb/b8TkLGRTD/MCJodBf7+SG/2Gm9EkxRD9lLAxcyXKKikoOd
         oK/g==
X-Forwarded-Encrypted: i=1; AJvYcCXJsd+HUdyUoDXcvYi12LP38bt53KZHrG8Nd58aNDMHbiKZzi6ypamw7G3ctJXQ7tZcBCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPC/qYSIIrYZukRiPLxWxDQv9Vu4zsR0vJpLnJbE/ATELxPRlD
	9V0z9vKWdnz30gOyLvx0qBaNdPhWf8i392YuZHIPqdBFkptDoMdGi+X+FPXs+MLy4BIVSvOwAaw
	FdZtW74UZtaWAHYKCXQK1gjNfelfIwJw=
X-Gm-Gg: ATEYQzyUfrMwbnh8UeoVktFlfHmjkoWRr0N+koFMjYUZk7F53sbr28c4FTA5oThhOP6
	i5yTqg+DjFtSPm4fdT8x39lx/qFuIH9D0HkAXYHCAgq7VqC0LeqzVww4oneECKwGeEJ+8rj2wF0
	15eQBP7CcY6AIiSV3zA+VjttdJQ8jTKz5pZ09i33r8s3bHPtwecgRWrhptt/lHy6r8KUw7vMDQN
	/O86hbipApoYcNwNLwssAjmZ/NEyTFb4FGxjpMPgsU+gQPvy99XWFtolaAIHqXkEhxw+YhEAA5A
	UYJzkYLC4wKcOTfFwAm5OK1KBTv+J+VZuC6fzOAgcSeUCmRhqOlbJlvwrKM=
X-Received: by 2002:a05:6000:1a8b:b0:439:b8b2:fabc with SMTP id
 ffacd0b85a97d-439da35fcf4mr679857f8f.21.1772762583151; Thu, 05 Mar 2026
 18:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
 <e21c875dcc2ec41524707acee1fd07bcd9dd3868cd6cdd63a9d7625c764271f3@mail.kernel.org>
In-Reply-To: <e21c875dcc2ec41524707acee1fd07bcd9dd3868cd6cdd63a9d7625c764271f3@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 03:02:27 +0100
X-Gm-Features: AaiRm53Bv5EbVLkQjDsYgH4AKo5mdT2vlPqyUXYXiQnn0OjCrZLAqd3KB2JmrTw
Message-ID: <CAP01T77_E7rJPEykxbZ2dx0aFBk+N+pFae3r37wrzoFcUBa_OQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Always allow sleepable programs on syscalls
To: bot+bpf-ci@kernel.org
Cc: vmalik@redhat.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, shuah@kernel.org, leon.hwang@linux.dev, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 17:08, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d92cf2821657..cb80a3ddb7a4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > +#else
> > +
> > +static bool has_arch_syscall_prefix(const char *func_name)
> > +{
> > +#if defined(__x86_64__)
> > +     return !strncmp(func_name, "__x64_", 6);
> > +#elif defined(__i386__)
> > +     return !strncmp(func_name, "__ia32_", 7);
> > +#elif defined(__s390x__)
> > +     return !strncmp(func_name, "__s390x_", 8);
> > +#elif defined(__aarch64__)
> > +     return !strncmp(func_name, "__arm64_", 8);
> > +#elif defined(__riscv)
> > +     return !strncmp(func_name, "__riscv_", 8);
> > +#elif defined(__powerpc__) || defined(__powerpc64__)
> > +     return !strncmp(func_name, "sys", 3);
>                                     ^^^^^
>
> The other architectures use prefixes that uniquely identify syscall
> wrappers (__x64_sys_*, __arm64_sys_*, etc.), but "sys" with length 3
> would also match sysfs_*, sysctl_*, sysrq_*, and other non-syscall
> kernel functions.
>
> Looking at arch/powerpc/include/asm/syscall_wrapper.h, __SYSCALL_DEFINEx
> generates names like sys_read and SYSCALL_DEFINE0 generates sys_fork, so
> the actual common prefix for powerpc syscalls is "sys_" (4 characters
> with the underscore).
>
> Should this be "sys_" with length 4 instead?

I think the bot is right, we should match sys_, that is less likely to
include other non-syscall kernel functions.
It only affects powerpc with error injection disabled.

Other than that, the set looks good to me. I tested it by disabling
error injection and things fail before your fix is applied.

>
> > +#else
> > +     return false;
> > +#endif
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22725431483
