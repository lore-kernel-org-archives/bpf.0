Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B63E8C7D
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208613; cv=none; b=QU27U6J/jx3f/u6SxlIDAQNZYJ20GOujacvoXuEVwiYV2lj574FKkoecElyFGziON3jiBm3e4M0v4/7zPriK5Dsquvz7lMpHSizVnfBA8B4xM4R4ugC6OEq18hZX1+ioZpcwqMOmkFByCvF6WLjvcrPQ5d0TNuVFtcXXqhP5rHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208613; c=relaxed/simple;
	bh=ZUtUU8w3n1Ps+0zwZM+YcPHrIvjLtPw1rNq3K3A3tpg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0cbs+mk7Y0nd4i6GhTGQsSxx5AHDz8mEr0aKtC+0VBOnvrtBW7QPIZ98B8tEtqRsxXhz8dB7gMqu2I1FC4R8flIi8bOfxlK3E1lDKbywBDm3T+vul8O+jx79negB9AGNWnVs4PwHKeXxtiMAAiExe9C7pyYvSzw9GZJea7iPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igsbuvq8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igsbuvq8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806bf39419so4973625e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 04:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770208612; x=1770813412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cmvHSszd0IlLpvYredQUSiRYBuWhyTBWjd5dWUF7dDw=;
        b=Igsbuvq8qQSvGFE/RJyabwtmp/5NWxYmDJ7yugFitx1God5CgdtDSNzkJT/w/A8r3T
         oex6L1acC6cRbU9Y/vUhNOnzdKAmtQH1tUtKm7rqr0sSwI3ID7xZgBdophD9Dp5HBkiX
         kvaH3yeMP1PmSRJEC73mtSIbsXUxSli2euC0bH3UfGhV6JTZCh1v5kBUKdb8RyA+mNGQ
         iC4RtiHy6dDFmjMeVG/dDMELakkw+XQDuu94PTbH3H8gpO2EkKxAxQc3eldD3ugfqEeL
         6BsnKD+cmyuTUXqBkpMBH/6xXovd9xA/11XlvaOHCb/OqfacpqwgMQqNqfz9yYymdTBw
         gCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770208612; x=1770813412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmvHSszd0IlLpvYredQUSiRYBuWhyTBWjd5dWUF7dDw=;
        b=JXCWKDOZwoSQAtvKNlJbZJu/mdQqSFBVf4o3QvfuSMRTT8XUiTuF2vtINI+kh04xNQ
         UUMYzlvpSEjhsm98WssS8on/LnHrZ5LsxAHgg2Q94+HOLCZfDgGQ5svr2Kj5zkj7dN5i
         5RoBp4gHbsADWwj4pl+9oB+8qO44w/Ht8jcxIgIsXbxAa3LGcHKS0ygg/WO9hYgaX6PB
         tDq3BK+MEqugTc4gUfTLQub2QN+BfaLrGDsiJbPNSr7qNOt1GKSNEen7TkALKpYQEI4+
         fh6BL43VbS8jYrC3eWO0KCRKDGhBMHNa0f9475ybzoxRLdX8ylXlMTw1zajmhTzgAGQF
         /jRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZEoXqNC8RUgIYO376eMUV/10BBZMm4T7B9QRPQO0+qUTafvSq/CbYAEztglhMsqGjEmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtn+cxkx4EtOTCCBMZmDeqUMDZtd7RCfGaUCNpDRxEn68HxPl4
	6CSFlS7BLnqdVEbs7mzpvNMINQEdZ0qrGd7cFGnqw1b49x/AZfe17Ynb
X-Gm-Gg: AZuq6aLl2dppT3cgmmQ6j5xOgCj308KOYHDkm8h1w1JTNJ9qKkEVyllPVc2cNPAg/v9
	7cSYsilLA074QrGcpQKRJh5uhQ2/3IMY2Qaj1LssS5EYnTyQccOqmTihFciBKa/+twzi+1oL/2f
	BH8yM7EVW4yc9jUiuprlmRzf9PfrgsJOjapz0wYgeCYMZ0BWVhAEQ1iec4MkxobT1/HDMxAXFXZ
	0ew7egCti3QYXPd2x2NfpeYmJH0fdYZE3vXD7oEXmaFtfe5VxDzg7U0AEiNaTxss7g5xxtfPXkO
	VFkV4rM7ii/x6ogSquYRk7Xy+crEdbIoAd7sDXWZhL9Ab5y0G4zo+XRbIYM7Z9EEDPi0gUUK+ZX
	4mgkJsmtcFffY2IEqWFEFaw8JGj0JH/4pyfGpx4+8ZrmrfmcaYPPwbh0lG2NU
X-Received: by 2002:a05:600c:6209:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4830eb6540dmr35302075e9.15.1770208611368;
        Wed, 04 Feb 2026 04:36:51 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831088ce39sm57168165e9.9.2026.02.04.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:36:51 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Feb 2026 13:36:49 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
Message-ID: <aYM9YUl6xf9I2x4c@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>

On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> On Tue, Feb 3, 2026 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > as an option to Meglong's change [1] I'm sending proposal for tracing_multi
> > link that does not add static trampoline but attaches program to all needed
> > trampolines.
> >
> > This approach keeps the same performance but has some drawbacks:
> >
> >  - when attaching 20k functions we allocate and attach 20k trampolines
> >  - during attachment we hold each trampoline mutex, so for above
> >    20k functions we will hold 20k mutexes during the attachment,
> >    should be very prone to deadlock, but haven't hit it yet
> 
> If you check that it's sorted and always take them in the same order
> then there will be no deadlock.
> Or just grab one global mutex first and then grab trampolines mutexes
> next in any order. The global one will serialize this attach operation.
> 
> > It looks the trampoline allocations/generation might not be big a problem
> > and I'll try to find a solution for holding that many mutexes. If there's
> > no better solution I think having one read/write mutex for tracing multi
> > link attach/detach should work.
> 
> If you mean to have one global mutex as I proposed above then I don't see
> a downside. It only serializes multiple libbpf calls.

we also need to serialize it with standard single trampoline attach,
because the direct ftrace update is now done under trampoline->mutex:

  bpf_trampoline_link_prog(tr)
  {
    mutex_lock(&tr->mutex);
    ...
    update_ftrace_direct_*
    ...
    mutex_unlock(&tr->mutex);
  }

for tracing_multi we would link the program first (with tr->mutex)
and do the bulk ftrace update later (without tr->mutex)

  {
    for each involved trampoline:
      bpf_trampoline_link_prog

    --> and here we could race with some other thread doing single
        trampoline attach

    update_ftrace_direct_*
  }

note the current version locks all tr->mutex instances all the way
through the update_ftrace_direct_* update

I think we could use global rwsem and take read lock on single
trampoline attach path and write lock on tracing_multi attach,

I thought we could take direct_mutex early, but that would mean
different order with trampoline mutex than we already have in
single attach path

or just sort those btf ids

jirka
