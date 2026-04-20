Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9533262B
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700197; cv=none; b=F6DjkpyjtNgmAGa611yVEuvAMV5jC1u4Dl1V1DR5yVWzw1a6KZpJTiZqyrT/MWekO42SiiXgQPp4pJ4fuTn5S9O6LwyXw2wbMG6Hr/uqq8HfK3UpxZm361aLA2uesSQgUEwOoZYr4BMaJDuvDJ1UmXE6MQCfXZb45YFLv4ZqLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700197; c=relaxed/simple;
	bh=N5e+O7600IiCxXeHMVqB+507A/2Oser6vrTYiRYSnT8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZdzsdGZ8qoVcMC/8oEpu8VkrZAnafPfTv5/M2sR09PPYgQteu3KgsHcr9Qi6O7FipPpxWi8knIgYsjBfQfd2ubZ0NUN9PTY/meQNQgT6pSSiTsjW5+4eY8q54lPXSm3OHN8WcLd58g+zD1bDK5x0hIUCqbbRwqzlBlbm2Y+rNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI2QV0gx; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI2QV0gx"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so1596478a34.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776700195; x=1777304995; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UJiob3GxfT5FNIDJCcLo/pjhEnWnGQgX7Sa/bHklps=;
        b=OI2QV0gxzD/BWcUYQ3Fpm0r0Sy2BOOVwY62fKS5ciaVD9GdUN57YFB7qasAyhNlX/o
         r8RJTCx8q3lenhDoRYfytOthw2cr2gi8y+RtWppgL7l/zd63WUtXzjBGHlNTB7d7lnt9
         DDwyh8n7UYre9G6KXfqliyXrrpraBNrJ4uWKgteC6CjhXwFYzGWbQ3ULu9kKNO0Ho8OU
         sUEn31TAi3g933xoRcdjYkPrcE5k5wq+h/EyoVB355yDSLbKtH3gIiPGYCnLJAgci7S8
         vIFeQgpaJ4M/BUD1Pc9HTVu+V1EF+hFflqdGdzhkd+5G8UN2C8AoYSoNq9lnuzNsSi9K
         dqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776700195; x=1777304995;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UJiob3GxfT5FNIDJCcLo/pjhEnWnGQgX7Sa/bHklps=;
        b=Wvquk50rJYzWQ6hARyOQC7x+fucyt24SL+Cu8vXG9dIxbbNrEGKKMHMtXAP6llCAQa
         JvlRvjccRDT67Ai1m5qKzPo1LG3nYK0ZQ/S3By97qa2o3Un6cwuCT/pwHJvjow7nbr9G
         69DH+6buBGbzo/gPW2/Y/HGfqWzhxSj/aypwgMxsY2MUc6+RU5ApFVlc+yvpcOW5nxtK
         2p71BxG1xRNtAdAnJVog0WFBG+8lMcPLSpiGGnO4P2Zq9byK3FoDW+NE6BnE1OzR+PTG
         H69wIeS+SbSZQ45Whz4RsoYRQm8KtTL0l7HcSl7llw/eG4JgT2t9kvqIt8Gixrx+ck7N
         DYMw==
X-Gm-Message-State: AOJu0YxkLg6XVhkZMGo+xE/6gbXDp14JyahfepyWU+RefUM3bXzQvMDu
	QNcz4HbTDST0SJwmMnZYquN9YvRMCuwvbSgM3lcOAsdrS7KnusZdMRKn
X-Gm-Gg: AeBDiet8m9/2ScAOuQTE1gsu7lnS7FYGPEKeGda6TSmh3B3KQSmAaMNLq6VgpBYKwxx
	5FHdpEAa7VuKwqYmp5qrjxFGBgH189/OH1lQhKx8ON8DRG3N6L2APeG1V/PbgX4TrpE5CB8JS66
	yDiR1k4zsmYRKIe0GNF3fvLB5wZlScKYtNVRBHCm5gH2oNxKU4QPt2KmSmbJKNFP0+R97SP43TD
	zyqnLNqy4HLeqpjXodxsQIJA8EezNqtHVveI0ALKJb8pmX/ZaYVY6cHZ2DTPt7yjC5ibA/wGHu7
	siWFin8HSnDvrWBnMaob2s4mNxK+Qp1UpVmg37s6j2cXtyIw8ngrcoHqUOw75k1puxKZAF97qTm
	DATFsorIR2V3uqumfBKRhfr6jcLzb8Eg6C3uRwROTIn8AjFIj86WYhT8fuXngh3WWRSEWnKWpao
	zuutq0MmajVF+SEYrafJM5/rc8yAJn3KqjhrvLmEEI9vivLJkT+ADapepwWpucrBZ56+uct7TYd
	pQOf1tHZtJgBP2leb0ZF0RmqL4R
X-Received: by 2002:a05:6830:81ce:b0:7dc:c7aa:22c7 with SMTP id 46e09a7af769-7dcc7aa28ffmr1737892a34.0.1776700195132;
        Mon, 20 Apr 2026 08:49:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b0591sm8776278a34.19.2026.04.20.08.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 08:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 08:49:53 -0700
Message-Id: <DHY3NL1SEU8M.3D81XSXXQRRWK@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Request verifier warnings for
 object loads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>
X-Mailer: aerc
References: <20260418171701.610025-1-memxor@gmail.com>
 <20260418171701.610025-4-memxor@gmail.com>
 <d3e3a02f-8948-4952-b0e9-6e289fe09a41@gmail.com>
 <CAP01T74ne=kN2+C8Yxqov-2an=mMo8+OSAKXxe9Vqim1qu1WYg@mail.gmail.com>
In-Reply-To: <CAP01T74ne=kN2+C8Yxqov-2an=mMo8+OSAKXxe9Vqim1qu1WYg@mail.gmail.com>

On Mon Apr 20, 2026 at 8:23 AM PDT, Kumar Kartikeya Dwivedi wrote:
> On Mon, 20 Apr 2026 at 15:57, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> On 4/18/26 6:16 PM, Kumar Kartikeya Dwivedi wrote:
>> > On kernels supporting BPF_LOG_LEVEL_WARN, have libbpf request verifier
>> > warnings for BPF object program loads by ORing in the warning bit.  Th=
is
>> > keeps the existing log_level=3D0 retry semantics for verbose logs, whi=
le
>> > still surfacing verifier warnings for successful loads.
>> >
>> > When libbpf owns the log buffer, use a small buffer for warning-only
>> > loads and flush captured warnings through the print callback. Detect
>> > support by probing for BPF_FEAT_VERIFIER_WARNINGS in enum bpf_features=
,
>> > and document the updated kernel_log_level behavior.
>> >
>> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> > ---
>> [...]
>> > @@ -7954,7 +7960,10 @@ static int bpf_object_load_prog(struct bpf_obje=
ct *obj, struct bpf_program *prog
>> >
>> >       ret =3D bpf_prog_load(prog->type, prog_name, license, insns, ins=
ns_cnt, &load_attr);
>> >       if (ret >=3D 0) {
>> > -             if (log_level && own_log_buf) {
>> > +             if (log_level =3D=3D 16 && load_attr.log_true_size && ow=
n_log_buf) {
>> > +                     pr_warn("prog '%s': -- BEGIN PROG LOAD WARNINGS =
--\n%s-- END PROG LOAD WARNINGS --\n",
>> > +                             prog->name, log_buf);
>>
>> I'm not sure if this block makes sense to me: we only print warnings
>> banner is warnings is the only requested log type, but we print no
>> banner if warnings are requested with other log level, also different
>> log_levels: pr_warn() vs pr_debug().
>>
>
> With other log levels, it becomes part of regular verifier output, if
> requested. By default, we want to print them on success at a higher
> log level upon success so they appear, even if the user didn't request
> verbose logs in the log buffer.
> Since the default case only generates warnings, we change the banner,
> but keep it as-is for other scenarios. Does that make sense?

I'm not a fan of banner either.
Screaming BEGIN and END is imo too verbose. I would skip it altogether.
And probably would have removed it from existing 2 places in libbpf.
