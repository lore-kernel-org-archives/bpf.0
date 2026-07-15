Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3E219E8
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084541; cv=none; b=M6opDZhOfgFthqCqzh+gguQTBginM85EnZ8QgyVHqWpBa0RimAbec4BCvzeFgPX1MRdEmrX5UnUPIpjwRn84AwLJytijqtSrnC1ox79QFPJ9VGLJ8ydgVxDb9LyFOeT8vJOqKLZEqwNWxhZpk27yqGOxdU2k1ZtqatPhKxMFvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084541; c=relaxed/simple;
	bh=Pyp2DnCViCnJgUi88+R0XBfifCiYiXiV56seNpVS6sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noCo525Ma476c+Dog2/G2MVcD4nSnsk/X46cvwWDVfWVcJ9hue8/znFL+/nOQSJ6Rp+VgX8gF/HqLLlO5vln3mUnpAYMhvYVKGAWgIIHu1MW1EpBiQwcw9uARE8VVZcBAEv52pxoALxmzR8KocLY6V5fcYY+hAlC3UG98ZgTVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CgJACLJ9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CgJACLJ9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15d111ca99so488398266b.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 20:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784084536; x=1784689336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hOjABmuvBW+jCcuokYEE7Gv19LjuO15ZtZi5onZDlks=;
        b=CgJACLJ98v8bx0a5WjsLkmXa0c45JEdSrekLF6tl5Fk22ghzpLJUvgFKQNzQTq8Ifl
         /ETsYk5Eo6xIB43MhUwOTHfm6l/60rKnMk3z77HYo3eisYf7NRzZMM+qx11ZKE/B/IiZ
         vklNHjKz3M8XNO8/Ulp4B/L3Ont5OEf+hb9qmZq7FfrXmYIOgTLvsYr1mcGB8om87koA
         eNoJog5ZJsjRDPz3ZRg0hRIWoIoPBCEPrG28tjn73CcgQw9BSKK4PCVnl0TowIaMCQJl
         cKRfYR0ykvJXtO91SW3ILye1CqC2a48Lpg1PjvVqZVEEk6hLo2Llro4s7MO2IjdwzHBW
         PEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784084536; x=1784689336;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOjABmuvBW+jCcuokYEE7Gv19LjuO15ZtZi5onZDlks=;
        b=XgMq0XUUZeyuN0YR/cC23I8F9hSAoo5+lBfp5qrc0vzmi1j4yboA0TZUfFrZdiTL8j
         mFA1lrA5Gq8YnaM+lGpnZ8DFmo6Kn6pqx1zlvQdUc4ndmtWvOw4dqyqKVCM6Wn57E9u/
         hh5R9XEZPINWiF3K8tGXYdvCwSEgJCo5z/mvxf0CPmfmsrQD0f/2gtCTVg6HTJcG4iTN
         SP21/Clk9C3RmD3qdpQGMxH5nZJ/jdFMsiKTfArFLGTbiRNUYgWBUDPwpZfk5hAxQv5r
         vdKvZHje+41Ddw88RumcEfRkMgJyCROzgZFxATl8xNUEpo2/zrBJROEp0ERdZkc9Anj5
         AY9Q==
X-Gm-Message-State: AOJu0Yzj2LgmiwIrsjPxSl/e2YTUKhsBxaXIDkecJUamu+/v5DQ4HW0e
	7SPpJWpVompA+DoChER0Y6A4YtXhZMOU3YsZCGt0kIdTzhuF06O39N8NHLVZz0bd8Z4=
X-Gm-Gg: AfdE7cmxgVPzCDKDwo5wOOiCws80S/Q30lmEjI5ltMEj4o/kaQPE8fVq9ISEvaryHjK
	Z5PCA+isY87ytk1uWzt0sNbtNeQaQ41cPhWE2SxXrJbPoOhMFsNvB0gncTXq1IuxsXPSasBbxDN
	MJtMVRHBu1BP32BEJbElkrGRI2TrxFaR4n6c/VWxpCeUHWsUetw+rSGvG4aKaHRLuT2by+RuZ7U
	gnqJ0mptaO13bySnQt5TsSKIeqzA+LwEUI/HRJZZIGXicOgOjEU3PoxSBNFzOxc3YfG4ilKSfje
	bX7vDLFUBQJOf/BE+St5t1rIFq62SAllMaIq7M/c3zO6QdJtDjF4n7bp2/f0IHz6NcAy+AdJh0m
	TW2HktGc/KW1MArJ/TMoSvhf2C4Xl1EOTQCQocz3TiwDhU48ATLRfRfm6PfbWSkGqo+TDmzswzr
	RwpDwWQRUq4ufxhh3rEP1ADorkRqaclHd/
X-Received: by 2002:a17:907:f815:b0:bb7:eb68:514e with SMTP id a640c23a62f3a-c167940e66bmr67514766b.36.1784084536316;
        Tue, 14 Jul 2026 20:02:16 -0700 (PDT)
Received: from u94a (27-51-89-168.adsl.fetnet.net. [27.51.89.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39a4a7797sm7988739eaf.6.2026.07.14.20.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 20:02:14 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:02:02 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer
 offsets
Message-ID: <alb1fmxTl6-c-HJs@u94a>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
 <20260714093846.18159-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714093846.18159-3-sun.jian.kdev@gmail.com>

On Tue, Jul 14, 2026 at 02:38:46AM -0700, Sun Jian wrote:
> Add verifier coverage for constant negative offsets on PTR_TO_TP_BUFFER
> and PTR_TO_BUF pointers. Both programs adjust the buffer pointer by -8
> and access it at offset zero, so the negative effective start must be
> rejected at load time.
> 
> Switch the raw tracepoint writable attach checks from nbd_send_request
> to bpf_testmod_test_writable_bare_tp, avoiding a dependency on the NBD
> tracepoint. Keep the existing past-end case and add a case with a
> negative var_off compensated by a positive instruction offset. The
> effective start remains non-negative, so the program loads, but its
> access end exceeds the writable context size and
> bpf_raw_tracepoint_open() must return -EINVAL.
> 
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> Cc: stable@vger.kernel.org # 5.2.0
...

IMO it is slightly better to split this into two. First part would be
[1] suggested by Eduard, and the second part would be the addition of
negative offset test.

That said, I checked that with v5.2 we do have PTR_TO_TP_BUFFER and
PTR_TO_BUF support already (latter as PTR_TO_RDONLY_BUF and
PTR_TO_RDWR_BUF), so there shouldn't be a problem having these tests
back in stable.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://lore.kernel.org/bpf/3430dc0a2a141769a596ab21d7abdd86a0a804db.camel@gmail.com/2-tp-test.diff
