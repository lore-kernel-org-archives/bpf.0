Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829539BFF2
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932008; cv=none; b=ExqY1hje0Tn7Cbjq+FmriilDvbXbMDIdccvjJxwQrCH1MyrenhJ/bZY+acJjwVwZlM6COYXGbzuXjSC+9Y9FgoB/LAkjYbU9QLvBVRocf8Iz8xo1SOQuoAcEHI4sWUi0KrCWFeM8ipiUBtRvpam8TYptgzH59CKgK6EIdZGw7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932008; c=relaxed/simple;
	bh=zpZx/8GKHBXgDfwh+pwBktW/ySFc9U22KLT7noierXA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Lt2JuiUAvUIJYc5DB0OhGoElPej3C3bAodWz+DUKtI+veKgHDu9XAwoPkYvoWKHmb/NMFNXXSfY3WNqf7SllgucZfgp+5QrQLItxP8+E14fAehtM7YEp13ZiZuUvR16O7/MwRoAhEonFDvYetJzEib1PMoblfpOu+M4ZGnVJi6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk+5JXqu; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk+5JXqu"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a149bfb2a8so562564eaf.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782932006; x=1783536806; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpZx/8GKHBXgDfwh+pwBktW/ySFc9U22KLT7noierXA=;
        b=Gk+5JXquQ6SVEb/naOIAnJ5/7tCBaMvlp7ke8fR7pl08Vhl9PlK4yk9LWS78WAKawD
         eu+T0fXLFZ/IItR+f28tKvEXhDobK/dOtP4LJrjwnXMpD1vDUoDFP1ssHGp6ALzlena3
         Sf5s/5wD7yBDi/hjsrt2GgRLZ1E7MuS6DQSn4/curbmLWDpt+Vs8t0TxA85+3kJm9Vjn
         23YLHRbyQGPVrrNMfGFW8ht7Cij44nDXRxJUBvEKPqmDcEVn4AAWALIwGjdzQZXD+VHg
         hqi1IJSIQlaWuXCQ/+TZ3pOblQrFUy2OTVe8yt4Ggw0tL5uWbEKke3T6x3f5QAQl1Q4x
         tQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782932006; x=1783536806;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpZx/8GKHBXgDfwh+pwBktW/ySFc9U22KLT7noierXA=;
        b=PP2oYOL0+tzhENsOI+eHO+uHhRC/MiT131hP6ejG9e5CW5TZ0/D+Md/piYRpjSHGIV
         eHA8urofzXBQ72SyZuwDASRMzUBXautXw+Pj0H8XgiPQq1bQkKxtBu7x4zl98C/Jf2G0
         i0TGKPb+APvAHw7rELBg6Pyin2CULTW15DvtPisHG47YBvjvr0hs4yn5c5r0qrq/FmDJ
         3eus9nZnKdC7JWX3IIaxjSfb2BOzhaEd/OKIjKZFnFPR/eEiraU9xnQFVKxPGq46XqWZ
         UcBohIZbaovpPPEgb3GcFwR9fSqhQfEHn5kuKLpEw666DvEFGStsguOBXAA6PuoV5hjZ
         j3rw==
X-Forwarded-Encrypted: i=1; AFNElJ8Qsf9g4lbZ0Ka4BRbhzXpquws7Ym3Qs/whKHLlnU5JPItyJLoatQy462CyXFN0QgZV8ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KEc/mjfTKtN9Xs6AO/8JZbHApbCB6OfzdVnLAfgcSGsf2hTr
	oCXBJvfo+kDEEnCXRkmv3dZZYNAo+5pn/RT3xd7xh4O7wpNdvD2/kYzR
X-Gm-Gg: AfdE7clsZNhyKUoCGbHsgOdgmjy7g19ajZ9SRuXMG52xFoq0svfNqcEXCoqUrULcW7X
	FurOOT6DcjfckDlsNNlZHRQw7FVGBD/+XzcBtbWYJpvHAEKiAbZIyvKKjxYFfsXrUXej6zruo9X
	swKTsC/n+o141jc2rk4KzEA+bd/BKy/gHigk212rcb1v2gkjDafnwVKp0acIt+unZ7gRp1avJYf
	ow2th5IVn4CE+EVZndnK5mA9El8dyAEPJ2p+dg/oHYgCRVIpxYwkJs13TtCEhdP9Szb1yAQZ/+I
	Ub4ZlJXOCfmHmIEv+cfPrhYbAgZE1u0TMe5AoMltwn91JNBjAMv8IYSmBdFgQSPomBLPoRBud4K
	4dslcJbwawTfMLOZKlT3FVnlpVUnxP23WXPtf5/2T/C3ai5TgCHkdsiYehIoJFJ22Zp+AQTfbew
	p5EIjwNduPKTXyUbipx7X3qa8xn0oKNlDDqv3U5MB++9EzMOMYUzPOKuEWTJCIee/BSgXgf/oHx
	4y5c4Q=
X-Received: by 2002:a4a:ee0a:0:b0:6a1:57aa:289d with SMTP id 006d021491bc7-6a309a031e0mr1581503eaf.30.1782932006353;
        Wed, 01 Jul 2026 11:53:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe841573sm582006fac.4.2026.07.01.11.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 11:53:25 -0700
Message-Id: <DJNGNBR6I841.3Q0PGODYNDSFK@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
X-Mailer: aerc
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291354144.1566898.14374948740441958770.stgit@devnote2>
 <DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
 <20260701144726.0a5f2204@gandalf.local.home>
In-Reply-To: <20260701144726.0a5f2204@gandalf.local.home>

On Wed Jul 1, 2026 at 11:47 AM PDT, Steven Rostedt wrote:
> On Wed, 01 Jul 2026 11:41:26 -0700
> "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>
>> Nack.
>> I really don't like it.
>
> So the nack is mostly your opinion and not technical?
>
>> There were days in the past when the kernel generating bpf directly was =
appealing.
>> These days are gone. Performance improvements for fetchargs is not a goo=
d reason
>
> Why is performance *not* a good reason?
>
>> to add all this complexity and bypass verifier checks.
>
> The code lives in the kernel. What reason is there to add verification
> checks? The point of verification is because we don't trust user space. W=
hy
> do we not trust the kernel?
>
>> bpf insns should come from user space.
>
> Why?

because I see this patchset as pointless kernel bloat with the "help" of bp=
f.
Hence the nack to avoid dragging bpf into this.

Call it philosophical disagreement if you like.
