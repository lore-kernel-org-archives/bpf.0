Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793319844;
	b=ywfG+NQVNZSF2xNCcM3A2/ln4uYlMI/cu6xcw74sjOopDlv0WEebzSmOdRwr4vHpKvrf
	 SXOAZgRQcKM1r1IsH3qgKiiNRmxDiW7P7bABq0KCQvy8gVrJfYNE974EncQYh0NpAnbfE
	 nRZ+5f4n6iMH3RRBoMI1ZP9xNLVJi5tXYHQPfyIS3DYuhJ1xVErKsLtV5rJnR8slQ8Vrj
	 IyHRpAvyu44GoeOnumt+TOXdQ6Ry9Tr+VyRiZiOkNEtyc045KQr63RJps0iHvrJJ2oY31
	 slFm7fUEIu3hDS8V0Ozg3HbBjlpl8xbcYI6DtW1WzBwKlxpuWrkzeK+pHffIuTvud8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VMmqUl9uJsPT0M2OBCk5mwHznWO8pexQECw7k6bATJE=;
	b=ovNaz2MbpXE+fcLO8li3f6qI/RkwkwN2ocm7/WNKKioeg7RdPEn4XG7QJQ+IsnjyfpZt
	 6NPmyaiLE3uAWu/2JPwhm5wJuY2ood2iwP7qsToX38aPIxCag6tg6UN20LOLZJDliDzdl
	 52cDrC6hQ480rMhYoURWamls11ce3eA7iin2/7QPduv9AYlOkba7pMIWCPYL1Vm2TWHwm
	 hSMZsCIq3TjacJVhj2ZUVJstHL80i4v1lbOp1Bdi1JMfb9vWMrWpoiK2laGjQuDQAzsDD
	 ikWY1vjWXEtAiWyePlbVq2X2EdCjpi1AEjcfFZkfpcsWMBEd1drAKiXs7u8ugCjrdpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpGlNmog;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56934606A327
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 00:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56934606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpGlNmog
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c247f6687dcso15113866b.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793319843; cv=none;
        d=google.com; s=arc-20260327;
        b=FoIG9QwxWMvzRM0DWwt4YYqW//WiUlWH0BSn0CAzhv8IDd5+Bzd9K30Ib4fCmKshRl
         05M5BYhBY2YeM2iuQEgxWylpuTphIXf0quoC5h/Pt2Cw1upTlJjKnHKInPMC2JgD1iE5
         cBCN3iQ26g1e+rp1H1zjQOmqXZT39qw3vUq4WKpZHpSIGLqnYReAigAXyAHJVBg4fAJB
         xiLnC49WyqS6RO/YjYn76y85hnVfGYMY8LZweG5W9OajfcAT1L9Rl2zRWpIwfbZIC9Fg
         3kUyMj3jm/0NQqP11CFKXnvScw+b87NZ0Fqs4SVsT807360Xy5W/A3JGjEp5BOBowzn7
         KW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMmqUl9uJsPT0M2OBCk5mwHznWO8pexQECw7k6bATJE=;
        fh=wZuQ+GVJUWGJIONTlx/EL9NPDN+9N6NdoU6RJ9ROwoM=;
        b=I1gYVIJce5gP36dZYbcNYgOsbno1kl4Hz9cBQ5jQ3HnVK/+lsQxh4Aadj7yfGEoZ/6
         48CFNmBe8sXL+V5WuieeTEq0W+LgXf8gSXBPmpspMgvd7Jdqj4l9Yk4Tg2q+KEPgcPTX
         nOfk/awz2PXTKJmPVgMSnlFHFiuMqznIr5NcWA4IvmYHjZVyvl3ger1eVRQNVZWuKn2R
         FziEc57ZIjd54pEETrpDv9kTH4JnViOpRvguyhIUF9GEim2DLBhn4Ya10Wd4uIui8PjI
         E4CzpSmhcnnfY/d+LLNX7VSNEeO8fHUt4mutc5DvzuKmsWSmUf2zHhDUsxlPMnxb0CE9
         zUZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793319843; x=1793924643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VMmqUl9uJsPT0M2OBCk5mwHznWO8pexQECw7k6bATJE=;
        b=LpGlNmogTRImOIcoGkVK6kX1FwvGGuvBqIqbOQmm5KJ3xSt2iFKkzmTKCxMImHdVaB
         aDfTjwZqyoMW2Iv2ufgeHFBdYwUo31Cysp7oHlTZ5mddkgutsSip90Yu0xuL4dwsjPlG
         H2d2o1NYWkpAmpZotlXfjCTbgYadKtl2mltD866hVzSHDvqBS7/xSgXNB9gCvo5NaMp6
         UR5LppzANcnsvAThS9ZzZ+t3lqd2cQjUINGMXJlzmHMLf95KKq7TGISjrOlO8RGNlmd6
         PEsSvEAPMgc2Des3Z6s7C7VBy/qcyKQWcN9VLLn5h9MLqOJtFhjlOBczCmc7Ss729Ap1
         cjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319843; x=1793924643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMmqUl9uJsPT0M2OBCk5mwHznWO8pexQECw7k6bATJE=;
        b=BK7qbul97Ia31hxPWbVPm/U8V/djMJEMqIJDaqW815C+buRpP4U5uISXnMOPG175yD
         iTMX3O/mV8dvXWAQvCJ06IBSu0+y+akXOAmVJhA4SuflEZMcAAj19nAYsNx+dFUmjgq0
         6e7D18Pc7e4FOESuzIwzrFD1g3EvVk73btiR9Pv1jNaT/qtU5c3QaXdIV+epyrwCVqLB
         oI3lYF08bAdkJq9wA22EiDQyUQpkpYXRSbRvhI3u477FAaCaS4XvJf3DfbwebP4YsthR
         HEp9VuAZMXOKANVZs6Mpuf4m7nqUCrZA56OoEKg94h7vgv33TCjl9hT8ZIY5MqYB10Ni
         NSVw==
X-Forwarded-Encrypted: i=1; AKwUvBxKKRL5a8hcJBNasRbDG589Y4J6kEt0x02TC3X8lt+AbSOcOlUZT7cUQ45uz3OJ63oTDLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKC0TGXMRrVi8ak7fvnuK2e7Q5tV/9s7Nzha110p4TdxMp8uHpf
	cAbwbcbIokqUf7K6Qkq/eONReiptRJzT1He/1BvlsST+LZobg8JSVTJnLt1mV47dycg7uVZox48
	5+0DfFJohNT3hAX5OyIX822oK89yzfh+IY1skD20T
X-Gm-Gg: AYBFou1CXdZy9UCZDqm9SCl03o659FQxl4SjNkOqpzOFoF4KpyFl15r27C5Bti/1vdL
	FYBthBHfDii4R7Xaa0/q1xSaGyt3zYG5ukRa+Pkx35DuzzVQS2reoL6mZs03IUtgGlIk6o9erC5
	hmD/wtEcr8yfmAzsGg1nWHoFm8Efc/3IACw5eL6wnEVr8o6mvY6ZTLmzvYOcc1jD9iF6bixz0hF
	Y2Ybal2ZoFdF9IyEibRgW/WKtoHo5ECg1spJbBiQ6tcm7wNIPuuC+CgKtzYzS1/yLIbpoL/FADO
	62INU0JABKfp/v2qoVeEMsaDa+XeSBwK1IuK4M3nN8lABVti4M/Aq0JnIWuMkTkWNopRH1ejYPh
	cLWH7934uG/0Vj4YQi+GkO56xT/5fc1gRk99QOQnU5OuFDST3vReTSnD/6nPHg8j7FyJMuUKzcb
	/JWfqbA/GREzFhkvWl
X-Received: by 2002:a17:907:6d20:b0:c46:7643:ae91 with SMTP id
 a640c23a62f3a-c4ca7a08673mr59997166b.8.1793319842360; Thu, 29 Oct 2026
 17:24:02 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <CAEf4Bzb--Jzz696u057G9_CgQN7zf6ksvoL80KJacKO2CorsnQ@mail.gmail.com>
 <CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
 <CAEf4Bzbs8F1DPBz=WXVTExrrNjzvaFsi4L+HEj+zbUTpPSTX5g@mail.gmail.com>
 <CAG2KctpSTCyWQHgJ8GyFEhHPdFawUa6zy0g7rkfCcujJRN6f6w@mail.gmail.com> <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
In-Reply-To: <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 29 Oct 2026 17:23:50 -0700
X-Gm-Features: AclHuK_8kDb2R9N0iMUoVO0Y5pzDVtS-1XOT4NszWcH8axoYKkVXrpd6hnWmpKQ
Message-ID: <CAG2KctrkKOTdsjWVRBEHuH45-9xpYsxDTk8PpZ4Gu6Ygq1Azew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 3:36=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:

[...]

> > I envision ALL_MATCHES to do some form of lower_bound() +
> > upper_bound() on vmlinux since it's sorted, and then linear scan of
> > all modules. Of course, just one of the two or both aforementioned
> > things depending on the module filter (any, vmlinux, module).
>
> no point in upper_bound() if it's sorted, you just start at
> lower_bound and go linearly from there. I don't think it's realistic
> to assume large number of duplicates, so I wouldn't optize for that,
> one log(N) lower bound + linear scan will be faster in most cases,
> probably

Ack, lower_bound() + linear almost certainly will be faster in practice.

[...]

> > My understanding is that the size is encoded in the ioctl command
> > itself: _IOWR() puts sizeof(struct) into the command number when
> > userspace is compiled, so _IOC_SIZE(cmd) is the struct size of the
> > header the caller was built against.
> >
>
> oh, interesting, I didn't realize we embed struct size into ioctl cmd
> and match it exactly. I see that pm_scan_arg has the same __u64 size
> in the struct approach, I'd stick to that, and when we extend any of
> them we'd need to make sure to either ignore or hard-code the size
> part, hm..

Ack, will include the size in the struct for v3.

[...]
