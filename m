Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC13261B9B
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698677; cv=pass; b=CdZ15dQxp4jEy/BhP4TXQf81F7Zxz2IXeQKoogAdf2yvWv/SFr6A5lN9zHroLij0PuV8x7gvhb1zbWMJSuQA5UY0Ds0iO+VDfxmv+C/6zaHazBw5bj5b442VJHDg1cjeMqRxIIC/LHFjGLQL9eP/CVbBamBy5ETy84nMsI+dVHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698677; c=relaxed/simple;
	bh=gyaiu7hYhOBT8d783cyQ8+P/bVZOEr5gWCnH/uQn1FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAxaWjAgeYfkO8Y9eAnT/6DwuP/WFO7Okl44IHdQZyJU3xZyFCm0WSBk2H8oNjOhSbsZYKNx7UwIYurRbwTP6C1F53QS6jKAkzzlz9LyYhZ8ms/p0nqdHkwnhULVzAfsXe6ANyNGSgubnZvb64grzQXQv2PEEdH50edi5VtyXHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCoSVW7O; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCoSVW7O"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d43e09de5so1757191f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776698675; cv=none;
        d=google.com; s=arc-20240605;
        b=WqWkG5eUo2Bq8jhcUgYA68Plm5txK1YIUgrhKECDzlJyHHPU5eSOhoEKi/Y2lpH5hO
         /cKgA+48HdY0qdSqTSm3h08mQngl26bFfAnGE6zfHiyznSHntEdpTamlAYbvituz3Bcb
         MmjyaJQhTUmXkr7Y0bKPKrzYhkvw1vsLw1RgiBfVThwoceLEQt+5B86Lb6/qwTkwRwc2
         YvjndI7baI9if8vH57LnpBlFBepk317T0k7QQElKD2AaxXQpdhfIPknoVgit6Ymp7+6b
         Tu9neBEBXCJf9Vxp79KoN0KbvgLd9Ye3zVqQOH+721wexXCOUIahFsP2jpTZ8cMu1+AK
         i8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kAb3AmD/SYisVB7m3EkPUkLQkRT1BrLOJ/VU7lgvkfk=;
        fh=zaCmUXYsN4Lkv7omNhKOgHzW3+IM9MSi9QcW9nCtmqY=;
        b=lNh6fsQDbi/L/iT6uYTBq808RN3JgDiH08pkUuLI+q7HoRhLwlVI/fxnTe3Jbv5ACl
         DDuSS0fF3pB66VvyZSBiZ9Vyt0IcCkeEubuNsxiwgT17miCMTKufwFBZdRterTR33Z8o
         LXo/S3Qfjslp4mUKxMwGGURMxW493U+Wu/bbLuI+hArqX23kYrqQ+W421cGy6xEhxSDA
         I732JYAos9Eq86JpLLfsy9+59dDbrhO1LAW9Tj0dRHJV6LhobpbdHacwK5g5xlOBbb2r
         fi2iMw6jaeQHBJxWJTn+zMHbNe66ZJGB5pTEOzulE47Mqk5nAz7R9XOd4lN4aVsXn6T0
         Tk/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776698675; x=1777303475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kAb3AmD/SYisVB7m3EkPUkLQkRT1BrLOJ/VU7lgvkfk=;
        b=TCoSVW7OdiFjG++5WvFce/NlIoR2o9jD2dgWkXzvuhI65hT5N0F4+YkWY/vdOi3Dk1
         aeT9wsSC9Uqn77DVFv48aeV4fzckvIXPwt+st1YoJ/ODPHdMqICdnVT0EMBAYEuLnkFM
         NB/wl8GEdoLaeFMk9SvV2SH8RHddaIzpYc7InXl/ityQ5V8VBCgtw+gfjAFQTdTsiV3I
         lkydT1mvY7gpt5n9R4LbhPU1/l4KZGsyF87WVYdlOIjg40j7POfwPxyBA6d/1e4ztcAv
         2iNlQRa5+Jid4Gl/LcgfNINw76ZgHx6o5xakE7ii07QEy9IDKxAEsU/h4bvg7a0+z0O5
         8qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698675; x=1777303475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAb3AmD/SYisVB7m3EkPUkLQkRT1BrLOJ/VU7lgvkfk=;
        b=pnp6O+VMyjdE3FPNKXJmAQzaQ21NDudJNYP875VXSMKF4UXCUQpfMz9zaITd/Gs4zw
         SOoyIx+Ob1GT3aS/6BCw2pCra5g9NDbj/Yef0xeEDPtfCp8s5fgA6b0T6i1H7tiijTdJ
         wNL9kgjs6AdmULRCG8ND1AUydxyikA1g3e5FwHpWCotPHXm1CzAbNoFR0+ksD8HTAlzb
         H4D2CXIsUi/BVODKJEnb9hd6kuf8Q7hI5r7WXp8BlH8Ucg0xTm8ydy6RdxrYylPIFe2s
         8/sRut82UdzCl8BzUxn6cPEqpk+1tCWhdE54hFiogaaUcf9O/JKkpF8v0DKuRt3G1Tta
         Q/NQ==
X-Gm-Message-State: AOJu0YwnZkia+vtWg/g286ycWsTT3nYR3oPLkaIudquQuvrKQx40VS2N
	cYopvXDkF2lSPRp0ob6VpvXrtoUcpU0xlkaRZGoW3mRzuzTVPM3nVnQx/NzhI5JYGyeVZma2AV+
	GwyLYAzOezRIfd/PG+KHU2qrttOF1bPcpF+jXUXm5Rw==
X-Gm-Gg: AeBDieujR/wKqYW2KgT1JZmOCd0+cOyg2VN3TsDjgdcsla+TPjedt/10UJGeO2O+weq
	FRdzG5t1x4SsDNwDu3+jUlv+B3/Dgx89ojaA4l9sZ9PKSuZaE4aFdLxMrvDHu0B4UBec4r5KrH/
	AG6bwmH0xTPVbQo9rPqEhWGtw3hqmU4VlrG3x0cMVnw4S1eyTMiDn49KjvqAbHvTaSwROhmEZcI
	6MKIj+mMq1oPk2UBWqrYPU6fXt32rtZhdbw68LmqFO3kO5457raIV4FFpCSbgGSEam3PPcpandE
	peDVD6vbgtlkyDp9bqRWBeGpdwq1hAmBfxiyuExaBFmqUKFi0PMY4MJoI2yv+LrmoLEm6djMEMq
	Sc/2qXT7x9Vq7ara1iwxMdvVOsYDqBR0Nz5h/8IXwVmIGyVPDgffx0ka/+GZRbw6Wd5ms
X-Received: by 2002:a05:6000:61e:b0:43d:7146:ccca with SMTP id
 ffacd0b85a97d-43fe3e1e265mr23317814f8f.45.1776698674122; Mon, 20 Apr 2026
 08:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418171701.610025-1-memxor@gmail.com> <20260418171701.610025-4-memxor@gmail.com>
 <d3e3a02f-8948-4952-b0e9-6e289fe09a41@gmail.com>
In-Reply-To: <d3e3a02f-8948-4952-b0e9-6e289fe09a41@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 20 Apr 2026 17:23:55 +0200
X-Gm-Features: AQROBzCBh0DP5_z5V4umubHlEdMDECkuy4asamrCReEWHWiP3qI6t7k_IS28Cr8
Message-ID: <CAP01T74ne=kN2+C8Yxqov-2an=mMo8+OSAKXxe9Vqim1qu1WYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Request verifier warnings for
 object loads
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 15:57, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 4/18/26 6:16 PM, Kumar Kartikeya Dwivedi wrote:
> > On kernels supporting BPF_LOG_LEVEL_WARN, have libbpf request verifier
> > warnings for BPF object program loads by ORing in the warning bit.  This
> > keeps the existing log_level=0 retry semantics for verbose logs, while
> > still surfacing verifier warnings for successful loads.
> >
> > When libbpf owns the log buffer, use a small buffer for warning-only
> > loads and flush captured warnings through the print callback. Detect
> > support by probing for BPF_FEAT_VERIFIER_WARNINGS in enum bpf_features,
> > and document the updated kernel_log_level behavior.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> [...]
> > @@ -7954,7 +7960,10 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
> >
> >       ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
> >       if (ret >= 0) {
> > -             if (log_level && own_log_buf) {
> > +             if (log_level == 16 && load_attr.log_true_size && own_log_buf) {
> > +                     pr_warn("prog '%s': -- BEGIN PROG LOAD WARNINGS --\n%s-- END PROG LOAD WARNINGS --\n",
> > +                             prog->name, log_buf);
>
> I'm not sure if this block makes sense to me: we only print warnings
> banner is warnings is the only requested log type, but we print no
> banner if warnings are requested with other log level, also different
> log_levels: pr_warn() vs pr_debug().
>

With other log levels, it becomes part of regular verifier output, if
requested. By default, we want to print them on success at a higher
log level upon success so they appear, even if the user didn't request
verbose logs in the log buffer.
Since the default case only generates warnings, we change the banner,
but keep it as-is for other scenarios. Does that make sense?
