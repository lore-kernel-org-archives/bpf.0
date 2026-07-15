Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398A381B1F
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089395; cv=none; b=rgVGcjgqgeuQJYQI2I1nq/eLDK7MRoRkSlUdS7pMY1kjKGCp+qsirc1rvpy/wWmGYq/nHz6dOqW2VBYLCSeaSHKGKQWOn5871uuuBGNm5HAmphKbWCsevUmDuQGOAJMpc3KLyKbmqJNuGKcpIAuclwlsRi9ctUzjReAhnc7S2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089395; c=relaxed/simple;
	bh=nRGiWmzutTFBlWxT7RhGNC4LR1gdkt6wb5eEfsbNXvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNC7JTs/hEISazWJw1Hp+UOVPyr9In/mURF94OK9R7mWOYnbM0dEdogPZoFRNZ6/PCMT1ejo9jwWq6gRfxxxtDrRiQM2e5zUn8zqqea2WKYI40D0w6ekH70jjVvDwI+tAIYZXzQBdsxt44fGYtO7K0m1TKuoEUG9kS/+akr+Jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hCPWJuzh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hCPWJuzh"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c16794450aeso42935666b.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 21:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784089392; x=1784694192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A8gjEPJozoIK3oIGIMdnB2AurGwUu6lRM9Hh3qkq73A=;
        b=hCPWJuzhkqTPVY5hcYgGPWCdHkiJCIJ27LUpn+HNg3Iqkt5aX08mHnM45Za6Y6bwBH
         LgvUPxuGbponcoXN972MgI+BEOv4ESRGVKiKJw1uOFUE02QwIUJO8Ryo5aqZKWo6Y94O
         HeI2YBt1vw3tZevHxWk0DKP7KR8/v5AaaHNDPF9KcHm1+vv9mPvIaBnLZGYrMLLSVqj6
         0K/zpkYSVSc7yUfwbIq+c8gvA3IsnVEo096hW7TWNfvN28VMkOSUbcHuhWIOWu0KodmG
         xMVzccaK4m+FPqLu/4lWRe4AbdvVdByxU1EVU2bGUwpU8bXQB5fJclURA6jKF29b/fhz
         iVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784089392; x=1784694192;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8gjEPJozoIK3oIGIMdnB2AurGwUu6lRM9Hh3qkq73A=;
        b=Tteh2+rvNzqUSiQqEnjIbkxdKpm+LSHLbphv/0UwH5w6pP2V8EvRY6sJFcJhpzz1IY
         bMVAlrmAiARI1oSt3nmAuNcxCAThXcUYd7iiP3gGDCRYfc7yx5HcsMh6RfFRtIKQccoS
         Y48tsILOmnLVHi+t1NuJ0lxmq0eYJP5TbZ3Tc8XYq/gxzYzXOyoWriGGgqyODxFBnYLV
         ESRm5nFpFPpkmU8/t6ybqlNM3nbwC38UkF3TwCLD5monc/bzjkAvR5C71L0/u5FvTN+O
         wP/YG8oSVEgrtDSLdteX3jr1CY4gxkocVFUc7KS5QkGKdXR58qqOhJbYVtoea4KfG4EY
         h7Zw==
X-Gm-Message-State: AOJu0YxLU6Uskj9EhbWZ9gMPxUkcorImvtNfyCGkcr13WOO/zEcn4vMC
	Iq8bzHuG7eodAbNedfI+2SXpqgY0KJqFwPToSSe77gS+1JnqWXITgAld+GR0Jv/gjBY=
X-Gm-Gg: AfdE7cngmAXWHetwdWhhPxbu+HnWZBRhGvyyp9Z+pWVgW8DTve65q0S5INVK6RuvHNr
	YZzkaDoM/caI6uiBdctnpTeSdrMFpqAgxQmbwpTeE/LjlLwaYbapdavXQBmPbfjuZYY40Ob9uGx
	u+jC3WB98XfPmGvJ+5BfLTJ1uf9csQC975WbEJdUi+fYvsL6Zc54YLRRdm7XLHvywkBQ9s96bLH
	svauhxvT7Yrzrh1EzrbsMDXZikb/3JWh9NbBLeRUZTiClGceiv3CCIm0+vM6GM29JevIcuD0hWV
	L4Zq8FPklTpxY6dS53oZKONiyufkTkCq4BV2ZpDUTyiKN/170S0UItkX6/QhOjDAWX4doqTY+ws
	mq7DU/lhIFaUV8l3uj85Un2LkgVY7X32VknjvfQTbaMZ04NpZqKPzu7yRYLP8c548Ke/iFKx3g2
	jgwf9w6quqMp5TD70cflG5AnlOkLRnoRhDT+bWVyfdy5E=
X-Received: by 2002:a17:907:60d0:b0:c16:16b1:4201 with SMTP id a640c23a62f3a-c16618b2bc2mr352647766b.47.1784089392273;
        Tue, 14 Jul 2026 21:23:12 -0700 (PDT)
Received: from u94a (27-51-89-168.adsl.fetnet.net. [27.51.89.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cebec91c92sm50468875ad.56.2026.07.14.21.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 21:23:11 -0700 (PDT)
Date: Wed, 15 Jul 2026 12:23:03 +0800
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
Message-ID: <alcKV2MXI_5dsaez@u94a>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
 <20260714093846.18159-3-sun.jian.kdev@gmail.com>
 <alcGgfNM94zgydlK@u94a>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alcGgfNM94zgydlK@u94a>

On Wed, Jul 15, 2026 at 12:15:07PM +0800, Shung-Hsi Yu wrote:
> On Tue, Jul 14, 2026 at 02:38:46AM -0700, Sun Jian wrote:
> > Add verifier coverage for constant negative offsets on PTR_TO_TP_BUFFER
> > and PTR_TO_BUF pointers. Both programs adjust the buffer pointer by -8
> > and access it at offset zero, so the negative effective start must be
> > rejected at load time.
> [...]
> > +	const struct bpf_insn negative_var_off_program[] = {
> > +		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
> > +		/* make var_off negative, but keep the effective access offset non-negative */
> > +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
> > +		/* one byte beyond the end of the writable context */
> > +		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6,
> > +			    sizeof(struct bpf_testmod_test_writable_ctx) + 8),
> > +		BPF_EXIT_INSN(),
> > +	};
> 
> Come to think of it, perhaps we can add another one that test one byte
> *before* the start of the writable context?
> 
> I understand that it won't even reach the attachment phase because after
> your 1st patch is applied, access to effective negative offset of will
> be rejected at load time, but the one that tried to access one byte
> before the start of writable context was what that triggered KASAN, and
> would be useful to have it as a regression test.

I really should proof-read more before I send... 

Since the "effective access offset non-negative" should be rejected, it
would not make refactoring harder, sorry. What I said below in the last
email is wrong.

Anyway, still recommend adding a regression test that test access to one
byte before the start of writable context.

> Or alternatively simply change negative_var_off_program[] to be the one
> that test access *before* the start of context. I am not even sure if
> the compiler generate such pattern; if it doesn't, then this test would
> make future refactoring harder without much benefit.
> 
> [...]
