Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826732;
	b=uxTsN7xjP/Zr1WcO6Pt/HFm5w6if1skVXyO8ZqXFFRPTzM+OIsjtGcf00cWTgNoHE0Gz
	 yDwLgLX3vxKgPcpC+KJZ1I8tIJ/duewo2dnokuWd6sDBcCNz2cUmX0A3fIT9sWowJKhdy
	 gKK2Ick2F97dY0qD8iURITURCddBeay286rdcY5rPvbufLLRjZRpdaCa0tbGdKQm1+NmT
	 2P7RIRJ1b+sU9wz+3kSn//m6w+4iiCE+P/Ed1PzKKAUvCO+Ts6NRwPxOSgoYZxQW1iAiq
	 tcW+UqpzNlgAgztlWjOg0HtbncBjT/7g9UPlWo3ADrSUuX6BrnOD7+BwDkt70q+JfOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zJCUPJzDGMi7/m5Ob7nLHW2RF/EysBxW/BZZah9AN+I=;
	b=XS4zPznwDbpkN9corkVhpMJRfG1VMuZUxeAxc4WeBiW/oztbF10GDTm3i3GcM1jx1LiS
	 u2kTN9RbUN6RZ2OyDKOzB/x+RY93ctNa6z0GQ5m+UXOW/jn/WZd6K6BT9KapmyvKxHXfF
	 6Ln22cFwZjfMODwDFMAypo15Upd2FoOmlCclhNx3FTgx7MjhW6tTjktlU+JBo2LeDS2v/
	 +FuzPq0nL8HvilbzBz5YorekRQM5gxVgKbNrMIS0Kt21LyHxGJwSfGB+CdBMdwlADevM3
	 3jpKdVuY0vFQaT/JltSdlcByB7hzDhUOGDExo2pvh5ZfnmSdJtZnynh32sKMropSWgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b0ZPfNFR;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F523606D81F
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F523606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b0ZPfNFR
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e4831c028so1105223f8f.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826731; x=1794431531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJCUPJzDGMi7/m5Ob7nLHW2RF/EysBxW/BZZah9AN+I=;
        b=b0ZPfNFREiBj5JLGtok34KV1SORMvvOx+kvze8escwGnLRZIpzWMPIzFsiYCxvUvE9
         Nr/hw6ydHQSvXuiPPxtyDONmv867wu9NzFFLyRtVdbI1w26ZxqiZw+jlAMPtNXFx1aoz
         fgDnRLVcryL76SRa5O8EalfKRw7AwB9mlCNC1tC+bRc93J8zf+F/phNCca8grXYMaTl4
         EHhuBUTnZ5ledfSOi3m+bnn6HRO7xrnDEcOYxUhE1cqyFM+hu82locee76ervkPGCDj+
         Sumh5JH0Uur1EvTF2AoakrchsHfEBm0T6CxIARdjJL9PdqqVpYfbzpoCSAlsRk4SNNCs
         7bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826731; x=1794431531;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJCUPJzDGMi7/m5Ob7nLHW2RF/EysBxW/BZZah9AN+I=;
        b=FWSQRpYmMOcYeLR2AwpAH0gj+ztxmAL0S/iTl7BxwFRPpBqF11NnPM7E3v7g3xhe5J
         697hw5gu7TmF0918T/i6wQQIBeHwuTRuyugyNcix/s0Lj+xYN9VD+XIfrFwfCGA9d7lr
         LH/DSlwGlARxtJtlZKu9PCQpsB+zCvKGOzbb+f4V6kOs/2wEzTQMp6Zt6vaAIrb8K0c8
         CyrYeuY3evrJ307s5PJbjLgO4SbIOhjux31ZxnDbyqZoU7U8aaxbFgJe1QDJdFJ807ok
         z2rRgF+71w0U6h7x8V0G/B7eYPGMUybqR4V5ZKMi6DpwCoGxmTeGg0Txg77Vcqv3uAwK
         pAxg==
X-Forwarded-Encrypted: i=1; AKwUvBzXZhYQdt1mm4hOVMUBt3n6LjIbob/P5scJuPd8RH88dPla0rVe4cY7XDx1/9M+KI0vG7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EIiYbWSZPNTB+bE7JJwUanNDCDiScBqRrbyUYDYlMGqCrgLqy
	WZ0D6kgB5LTjyw8I0wjr/5ZJK2hK+zLgAPWgTdJrmQq9J8W0U9Ih0cy/
X-Gm-Gg: AYBFou10+x+Dn+PzI3AVWYzSZo7uYoJBUEPdjcXBJGBEXpkxGJu33m38moeDEgAenWL
	RA+M1i/+qg8hP0LmrvU71SlroL1vcbdLmLMaxhudA3eTVw8QYOhK98be+bDnaA7AKcp1zSjI7gC
	GGHSBJWfoHUH1a0SGmG0Ew5lVO65lc4Hj0e/bJhwB1T1jtWJOzGu2Q9WL6dnMso6G49KM8MHp3+
	Wc1WOJBJVGjZjmXvl6KYhqepSRcnt03zu84+VMCrL1TKniLUpYQ60TigUwUKgDskRQlq/JVPYPI
	5uxoS7XvnI32Z2rBlYDVeLjnR2odWmcBOQq/KMAC8MSkwQwaLCW+fRvyjPFAvYvRk4Pl7PtPk/p
	cSDgf7UziNjMKoUkR191ax0osD+wh+HKfuk8Y2cSPbovPDC8D4bOmoAfxVrAbVduJ4xQ7IGP+Dz
	wIFphdpH0yA7Btkg4LezmWHdEgDfAL1CgQBqqDQIJWmqVMIDmtTvZo24yU0PItgBf6xyUoOZrAI
	bm7GKPhOwEGinpu1jJdl350hwkO6X7LhTFV0LjruUo2GsID6F5qUIGg7TkjSe3nak9ZIw7ggPzW
	BwsgfXpS2sr8BS8=
X-Received: by 2002:a5d:5d13:0:b0:48e:47e6:fdfb with SMTP id ffacd0b85a97d-48e6e302699mr32449578f8f.13.1793826730893;
        Wed, 04 Nov 2026 13:12:10 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm6173320f8f.6.2026.11.04.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:12:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Nov 2026 22:12:08 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-mm@kvack.org, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, ljs@kernel.org, john.fastabend@gmail.com,
	nierro92@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 6/8] selftests/bpf: Test user memory page exec
Message-ID: <auufqLgICAPhcHrj@krava>
References: <20261103075916.100050-7-jolsa@kernel.org>
 <f140cba1c8d3bbefc759df505554da49c4ffea61ed0684ddb9f1d3c6effa529e@mail.kernel.org>
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
In-Reply-To: <f140cba1c8d3bbefc759df505554da49c4ffea61ed0684ddb9f1d3c6effa529e@mail.kernel.org>

On Tue, Nov 03, 2026 at 08:39:47AM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test user memory page exec
> 
> TL;DR: Nit only: in user_mem.c selftest, the bpf_copy_to_user() ksym
> declaration names its second parameter src__srcptr, which may not match the
> kernel prototype's src and isn't a recognised verifier suffix.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
> > --- a/tools/testing/selftests/bpf/progs/user_mem.c
> > +++ b/tools/testing/selftests/bpf/progs/user_mem.c
> 
> [ ... ]
> 
> > @@ -10,10 +10,13 @@ char _license[] SEC("license") = "GPL";
> >  
> >  extern unsigned long bpf_user_anon_mmap(unsigned long len, unsigned long prot) __ksym;
> >  extern int bpf_user_munmap(unsigned long addr, unsigned long len) __ksym;
> > +extern int bpf_copy_to_user(void *unsafe_ptr__ign, const void *src__srcptr,
> > +			    u32 src__sz, u64 flags) __ksym;
> 
> This isn't a bug, but should the second parameter be named src, as in the
> kernel prototype of bpf_copy_to_user()?
> 
> The __srcptr suffix looks like a verifier annotation, but the verifier does
> not recognise it, and it sits between unsafe_ptr__ign and src__sz, which are
> real suffixes.

yep, leftover from previous change, will remove

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41602296728

