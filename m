Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318793;
	b=yFHzVsO67y9lF9gRMNj9Vnt+XCD1kdKQkRg1dZm+5N2kDsIuEQa59kGrMP++8s+pwsJE
	 MiZUqoag/U3+4AkDNx/BJApBs99AO+3ZZWALuvzEFVl/+dNWL9PNWbKirBlf+PqHEBhqn
	 MkEcoTZL829yqVcR4wR9Wvv3KfXNkbtaPt3nmeyDepVfaHWulI2MO1WLy7gXX4KgI9YHm
	 qN8YUmgUNVEnv2PAc+tbnL9E6OOb1DAZJcGfISRm6ziYkUtsTsGBNO3TslUwk+CWNwGVo
	 jw47s4Aao228OZkI5A1ebwmkFdT5O5oHoFlsSeyEVRfj95nf7gv5cGLzyJfmX+axJCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=d4NSCnrsDvRbwBgqs2GERpu46FtgR0tNjhD+8taDJQk=;
	b=zi+JwuKBeGtdcrwauhvIKKisiM6nCVv46fdVzzmtzDe7YQzV7/vxchcSvyALPnxPqmna
	 bcU1t0EMDpA+AJ9Z8a6vp9irj44zRoNSJUL2r67NMxIjEaCqnM+PKWaxuaGYnWsZX63xZ
	 bvE9vX5srJiRTM+NgLYF61vogX+9fpNUdpehK77Gx1kmRULbw+LibIGI7iyVax38wuQ9U
	 3niWEd5xhma7CaAj8cKcxKtitwBwZvlHkw8Thw4Jhw35ZCgJqtsl2C3S2JH2005JDqR8t
	 2T9rp/voFgJNCm9uQEhc9Tqzpda+/NcvF1oOvZUO2zf6BDcXQj5yivt+fKdTWUn2daA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teLs5hGE;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B84606A321
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B84606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teLs5hGE
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so21871095e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318791; x=1794923591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d4NSCnrsDvRbwBgqs2GERpu46FtgR0tNjhD+8taDJQk=;
        b=teLs5hGEycwkTQHU/tkdfRWfHUVLf8FvNrr1j6fIqA8AwZspd3ALDl77yFSJq3YWmz
         5fQTLeLFDFyKbnoHpEegpwvsXpoPDpyRRax1A5+FUymd+p62uImzs0BFrmhahhf71Uhi
         WF1VAuaQDa0HA5WqfsNkFapOLbnjQFyrvAMMs0SjV5+1oI7cv0cxDMV/v8/rZmFg/DKN
         4KNU1U8uOBxIpPBlAEx1R7Nrt5D01mpXSNl6RYSWYKrcSaT1/iq35lsE5xKDjn7BJFGI
         aZUy+7uHSH3zyXuR0I9VOLLmcJmgMpna9rTxgF0of3s57PdOZJIQ+CIgrsFbScZCLUH5
         X3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318791; x=1794923591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4NSCnrsDvRbwBgqs2GERpu46FtgR0tNjhD+8taDJQk=;
        b=OJwJwhSjkYq8c5KRIofioQrRmOjdtL6WYKp+WHFV+s3i94SD0FD0KFJb/l5TnfxO7g
         jnSqk3x5sqhJw3kshda+JM5wg1yVbbXnwVjeJwz8IHDLKQfAsdpN77l7Do/cBfberZcY
         FGzw0o9hMYrim9/HkIqLxk9IbBFFtbGvmxuAJ15FUQvIc9XtZLcubDNgayzayfnuDvXo
         9HUjAU/o/SIsmkbjmd7qxgZZ5N6npWd1x8K5MlCCEmvscaMpCKKTevd+vd8IoxxgVbd5
         Fo2j6yb9kwU/Lj4zB1XiZaiTisMIeofMuXHIeOz4qVPM3YMGk6C5ZVZfKM4EHu7wPpz0
         AVaQ==
X-Forwarded-Encrypted: i=1; AL+hErEwpfRjRNUEZniBBUT+ujr0lXdzKb4zJ5rwMcAaE1QuVkYoKZxf90zrfyNwrBznq0u37Mc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vE8A5ajGHPJUNzMBS4JN0aemWETaek8+y28s3EM5XztorXxxH
	nQFHCPkE288WZqyJj4kFbLA5qVDuKmusOFk0QvxVxuEcBueiSmhGw0Eu
X-Gm-Gg: AYBFou3xgYAu8xJYK1q5O1tWiE807PF11VM0tnLyEMGzgHJTjtXx6Ape2mV+rMAGrqc
	pQdI50qBtMAqCTmNOR+PoAbcFqe+DJGSdpn/WYbZAxhCzc7y+Zsrkn0vuhfdeZdYLDKY7nXn+5i
	lBKE3icsiYA0g6wr2XUfnaes2PiXNnTHqnvvizW5QdWSZffP3FpCAXMmfdPXGxJxYHcz9YmXbCv
	cm7/+3oSHs0jSpdPiIUiHQvUWXcUHDsShciWAwGeaYhaHbJpJHKq7YG7gN1kAGAqzYBZ4zBFj0g
	ngDdmVVppddE4He/GBFfFqISIfTNi/Zs+qoyE5qCQJcJVIxklf1XBvXnVJrUBCcii+QgGgHCFSn
	lKsr59J09EzWl+vprPo8jEwBdKQgAZVHYB/REzxu5DTLIctqOYqOR64kUgPVhqrA354LxhDSK8m
	Fc6ifrDOzryBHOAvAwO4nr8ykMcYsjp46szp9PJtxrmcowmjSIl285f9S+9nLdwbLK3V9AaoEss
	ywdbBQriJmR7qPUd65H7malmFPiwCBbryyNSA7LVMWe+MKWRs7x2uUMHg9uPKgpNSgekrYCzPpk
	FQO1fgRUkglwPNrPkHoWaD//6npYPkL2dY00BA==
X-Received: by 2002:a05:600c:8b66:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4ba02351009mr49636755e9.31.1794318791044;
        Tue, 10 Nov 2026 05:53:11 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2c5asm104797705e9.5.2026.11.10.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:53:10 -0800 (PST)
Date: Tue, 10 Nov 2026 14:04:41 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v2 bpf-next 11/18] bpf: Follow PHIs in bpf_scan_ir
Message-ID: <avMkeelRyvo-Bzuf@mail.gmail.com>
References: <20261109170550.141443-12-a.s.protopopov@gmail.com>
 <8ab81e05089b4f5ec1ecb1bea9e6dc5cc2953a67f16e9369db005c2f3f3ee242@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab81e05089b4f5ec1ecb1bea9e6dc5cc2953a67f16e9369db005c2f3f3ee242@mail.kernel.org>

On 26/11/09 05:42PM, bot+bpf-ci@kernel.org wrote:
> > bpf: Follow PHIs in bpf_scan_ir
> 
> TL;DR: Nits only: in bpf_scan_ir.cpp, isErrnoRange() duplicates
> errnoConstant()'s errno check, so the range is defined twice; also a comment
> style nit.
> 
> > diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
> > --- a/scripts/llvm-plugins/bpf_scan_ir.cpp
> > +++ b/scripts/llvm-plugins/bpf_scan_ir.cpp
> 
> [ ... ]
> 
> > @@ -34,9 +36,40 @@ namespace {
> >  
> >  static constexpr int MaxErrno = 4095;
> >  
> > +// is Range in [-4095, 0) ?
> > +static bool isErrnoRange(const ConstantRange &Range)
> > +{
> > +	unsigned Width = Range.getBitWidth();
> > +
> > +	if (Width != 32 && Width != 64)
> > +		return false;
> > +
> > +	auto L = APInt(Width, 0) - APInt(Width, MaxErrno);
> > +	auto R = APInt(Width, 0);
> > +	return !Range.isEmptySet() && ConstantRange(L, R).contains(Range);
> > +}
> > +
> 
> this isn't a bug, but could singleErrno() and errnoConstant() share one
> check?
> 
> isErrnoRange() has a single caller, singleErrno(), which only passes it a
> range that getSingleElement() already showed to hold exactly one value.
> For that input the width check, the isEmptySet() test and the wrapped
> ConstantRange containment do the same thing as errnoConstant() below
> (width of 32 or 64, then N >= -MaxErrno && N < 0), so the errno range is
> now defined in two places, and the !Range.isEmptySet() test can never
> fail.
> 
> For example, errnoConstant() could call
> singleErrno(ConstantRange(C->getValue()), N), or singleErrno() could test
> the sign-extended element against MaxErrno directly.
> 
> Also, the "// is Range in [-4095, 0) ?" comment is the only function-level
> comment in the file using // rather than /* */, and it hardcodes -4095
> where the code uses MaxErrno.

Yes, thanks, will fix

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554

