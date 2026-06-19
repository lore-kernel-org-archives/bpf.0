Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF682D7DE9
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856206; cv=none; b=NDzhDGiIQr+tQB4v8hHY9zwT2ggF2ILAFTWmLtOm/p2H+89UzKTKqmkvk2/At2lpjsDbC3nSo5XLAsBFWD6/ErRfGqL7/XRDPUjs1BVoigV2fInAqCaTa3GbBwkQ8fbylBEGiX93RrLAbYKMTFqQ3XDjwYG6oMk0eARa9LmtfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856206; c=relaxed/simple;
	bh=zB4TCxIDgStDFP1rlZaKRZHke2hrvj4RkhmGkk6WUC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM0Bu/KODmu7z8KxwUmLwyXcJwT/pYXHGSvLhvC2jNDTu6oogKNSmnjZjjT8bEj1gjjCQcXxnq4snHN2Ns0KeAcvz8X5cm20mBaRbuKwoPDUaWaGniV14RO6psOn8hsXseZofqGQqOMGGrcCesSMAR6AtIeL3grzTIVX5BBTvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6+KcSfr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6+KcSfr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso13484925e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781856203; x=1782461003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kpJwL24GNas0k68J2nJFxWElqOxVpyI/1xu9RZENp00=;
        b=n6+KcSfraEgMTfhU1nMSD52t73wf191Fox8ivGsan2CAFJJyh9JoolTMEusK23HO/I
         lbT3xxPqErAZoARh39+fW6BZe5FK1LWAxy8jNJWCsB80dx1nxtIYTNeuiTdShj3NnYDz
         ms1z8rIPfzZBT3hQfMw94hwfCYuxFTwCh7AbnL0vvRrASxxxq4NccP4YcSweBZklSdxy
         muVGQVLMBHQhHfpumWoqVeTl/v+dkMbUxlPT7leVOKdzDTjDfzlZdQyBeJOQaKxfj35y
         9g+9ykIn1c68jILcHdzqXtcre7ZuVoSf2CvkDI9L3ILlwpp8Xnc3Xgz1Y0b/xuxA9lVX
         NKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781856203; x=1782461003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpJwL24GNas0k68J2nJFxWElqOxVpyI/1xu9RZENp00=;
        b=KFe3aiSmRswBxCuWx9OyJyZAJNMOHszFbbvG7IOVchnD0bUaegI8eucFRHwHPmv0qZ
         uyDL8Z4jJ1An89CAe7c525LD1iqgZQPUtzuUCW+yCCsR8XYlFH6f+YDapoaEuu/dF/1b
         MDLoKJSaeaCWVijQZ7bxSBqLhJDQFEvPsqHUNc7kR3OEjAc2iOkOt8BoJyTK2u6KqO5+
         aXzf49l0Lvs9WKsPj7PKCfmu5l4doELDz1iUSsqiuAGQVi5K9uo14iOk+UF/aQZuqLKd
         XLMK3P5CuUwhXnBRD449WKZWLXgiGTGW6eCHDT9SXUWnhtNNzQ781DUbuW1vnFVXvwah
         zgEg==
X-Forwarded-Encrypted: i=1; AFNElJ95UVgK56K6BP9KfASTawQpzCjSwaV1aWhqO0QhYg1E2e0YcUXdHgLbDVUfUBPDSnH53LU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfcu+WUFVX9BVPFqnr8Q/99GEYYQUNk0ah1vOksURHvBnGpwiA
	bn5QrRT1X8ZUI3zH591GfR4pqrLpyvVohD4CNH8h1uH1z45arWK/9HpB9h7RBXnm
X-Gm-Gg: AfdE7ckcFXRhVG4+W3oxGab8RKzk9bAKWCQvOD+6CU1x/DpY3EMdb6GoaHNgmNpknRz
	bBVctiUeq8REBJrJIyUtNdS5Df7XygQUr2iUK5/NxSivBUmYX69njn+Pd8OlADHDJankdxbwqq4
	k9Uhnk/nYM8wrYW0Tw4XlE7JOFYR2T2xDzN60h/d8uTD034RAcZS+0q5tHmKhiEm33NzQE2PSu5
	GZ8qyW8EfnZqi3SZpCyWSW8VZ6uIaEFKTUVE0FmHS/FSva92+q7uXuM9FPk0eq4auPWXCzZK1ep
	G1vPJtZ448zBwHriLE/aFSwKZ4f2TntIRa4GLSJ3ThIL76bF1vKw89JJvpFZzCtWIYaFekvlzSO
	2r4QaLHcuOL1lQdNrvKbOUAF+PNFS67GMj62UvxarWKI2Q++UZ5Oan9+avJXMRQRVYv51RY4nI9
	Q+vylGLCP2Xvs0bkQt4slWC5QbiKY/gaPOubZpSDVGsJfempJiWKhBtwxDrhweqYdACqTfcd/Px
	j7q6vTMV4h7YonubtA/SYVO1g2Bwfd4VzvlALoNxcKAJ8WN86kqXfrnq9GZnBlAq1nLzuBf7jQ/
	Kl9ZPKDvqgSxxQXkAY+S3sfF28O+5ufG
X-Received: by 2002:a05:600c:4583:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-49240a44b63mr31293065e9.13.1781856202842;
        Fri, 19 Jun 2026 01:03:22 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e002f165db642aa45e9.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2f16:5db6:42aa:45e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fe8esm55234915e9.13.2026.06.19.01.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 01:03:21 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:03:19 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
Message-ID: <ajT3x2H0swzg4yhm@mail.gmail.com>
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
 <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
 <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
 <ajOv_oOd1zInaW1b@mail.gmail.com>
 <CABFUUZHCr=4kb7kSaaPGpc4nkyn32i-svD9v7ONF+TYrrQ-xaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZHCr=4kb7kSaaPGpc4nkyn32i-svD9v7ONF+TYrrQ-xaQ@mail.gmail.com>

On Thu, Jun 18, 2026 at 06:45:18PM +0800, sun jian wrote:
> On Thu, Jun 18, 2026 at 4:44 PM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> >
> > On Wed, Jun 17, 2026 at 10:19:52PM +0800, sun jian wrote:
> > > On Wed, Jun 17, 2026 at 6:31 PM <bot+bpf-ci@kernel.org> wrote:

[...]

> > > I tried reusing pkt_v4 and the existing TC program, but they do not fit
> > > the skb case this test is trying to cover.
> > >
> > > For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in the
> > > linear area are rejected before bpf_test_finish(). With pkt_v4 and a
> > > linear area of ETH_HLEN, the test fails with -EINVAL before reaching the
> > > partial copy-out path. If the linear area is increased enough to pass the
> > > IPv4 check, pkt_v4 is too small to both trigger the old
> > > copy_size - frag_size path and verify that the copied prefix spans the
> > > linear data and the first fragment. pkt_v6 has the same issue: after
> > > making the IPv6 header linear, only 20 bytes remain in frags.
> > >
> > > The existing test_pkt_access program has its own packet-access coverage
> > > goals and is not just a pass-through carrier. With such a short linear
> > > area or small packet fixture, it can fail before the test hits the
> > > bpf_test_finish()'s partial copy-out path. A pass-through TC program is
> > > therefore a better fit, because it keeps the test focused on the
> > > bpf_test_finish() copy-out semantics.
> >
> > If we're keeping tc_pass_prog() then can't we use pkt_v4 and get rid of
> > init_pkt?
> >
> 
> pkt_v4 is too small to construct a meaningful nonlinear skb with a stable
> linear/frag split while still exercising the partial copy-out boundary in
> bpf_test_finish().
> 
> With pkt_v4, we either do not reach a fragmented layout, or lose control over
> the linear/frag boundary needed to exercise the regression path.

I think I'm missing something. Why can't we use pkt_v4 with
tc_pass_prog() and a linear area of ETH_HLEN? That would leave 42 bytes
of non-linear area, so a SHORT_OUT_LEN of 30 should work to trigger the
bug, no?

> 
> This test uses a 9000B packet so it does not depend on small-packet
> allocation details. Smaller packets might work depending on allocation
> state, but 9000B reliably gives us a non-linear skb with page frags and a
> stable linear/frag boundary for the copy-out regression.
> 
> init_pkt() is needed to ensure deterministic byte content across both linear
> and fragmented regions so that the memcmp-based validation is stable.
> 
> Thanks,
> Sun Jian
> 
> 
> > >
> > > For XDP, this object does not have an existing xdp.frags pass-through
> > > program, so the small XDP frags program is needed to cover the other
> > > caller of the shared bpf_test_finish() path.
> > >
> > > Thanks,
> > > Sun Jian
