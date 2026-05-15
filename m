Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669453815EE
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848352; cv=none; b=nypwFheEnzdfIsUj11WM9pFOyGFrQT0hNSSbV9lzZer515muIjG4NcSLyhIdW9fs9cNKmUwFzN6I98g/uTqu7dOdT8zU41ZxsnHlrR9HatioRQquSyB69syOtbiqUoWnnN5eRFZgaUyE0FklL/i+pH2KDZSNnxuW3wi9P0ez2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848352; c=relaxed/simple;
	bh=9qiW8jLTXB7HgqG8p85Qhc3V34gmb8FsDi1lb42ax8o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmKKDbBOwMOrbzT1cCe89yxcHOtSiz08+OxjGz9B8TJHfipzVq1rIdZ6r1vcNwSoQxSgJMBr/AFXeic7eEIwVqjhsVW/mRFCskgOkNMpA4jSoRJxX74PNlPbBLlLStdrW4voN99gU+8IFardiy3cl6/2edWpssBbKY/K3M5D0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgQYIvbt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgQYIvbt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488d2079582so91894535e9.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848350; x=1779453150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cpESQlvkruWQLk+pk+4QFPvhWMc3LnzyhCFUTg6s8Q=;
        b=RgQYIvbtRqvBrnKb0nN3Q+msm8zm+V6xQqS5LhKpb7mAWwskyxFBiWklivC9Hp4kBT
         ot+N+jsHE8c9US8b+dkQJov3XgsVof9bLxLs6KVvtbvlKYsPNq+VMFEHe8sdj1cs5W7n
         sJZF0QkK1NhVMS7sSxoDa0Vrny/c0Dzp2lcmBa2AHaHa3Qw6FI/DXr75TxvHV5FW8X3A
         fM9rgLYZ44SgjQgMMIhlp5jMP3xROUAmZEitq7CkbvCD2zqRo2mBdbZYzm5MpKLsQp8w
         AU2Gb/fKP4vMDB6uJCkIs4xv6rPi73BDkUWm1IW8CM9HwIL6ww+W7Ho9JEizjMzLMHry
         PaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848350; x=1779453150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cpESQlvkruWQLk+pk+4QFPvhWMc3LnzyhCFUTg6s8Q=;
        b=sMu3eNiN+lYuLky27e6uqtaJdWnBFzpPQHT6O/wiJkt+BQM2/YWP96tMejF4cFsB4X
         JNjWVRuXcAV0Khe99uzHBaiY5xniY8LzW4wCD/XYxsp3BmCFolu6D0R3tQmxfQkQJ+ax
         vJpAoN+Hni0vqrJ3S/0rH6Gvgwq81PTzpcrCS6P9rBAfq3YVuANFPg4zJaIXBvG9E35A
         pXCZpReRZ3OMsSYkm9auMxWqLlVZjP11bIO1jx+StmACb2hgC/Pa5XU3fqjKCHCpnYEG
         MG15ayDQ1GziRFAmSmqOzVzS8++H0H9ibkXt2DAV+7TzRo9W1lZpBAR0cpA8NO7umqCd
         OjzQ==
X-Gm-Message-State: AOJu0YwC9M7IAzXlQaZddDsOYBIeokWTVoGsMf9paujSsQ1RNcDNS6U9
	c/gvWYAadiOEMvHthVlAHPK1Fv3aDU8eadMzAnJnMp+pZ6CtJWZBVBrQM/7UxwFX
X-Gm-Gg: Acq92OF0rdNwLJdlBkQt9LaJDrgYo4g5T0ncJm3B0ZnhC5MMRP9HFnuiTvx7+m8ittm
	8a+EsLDrKUpFDjoV5dKChY1vgwukoKYoO1QaM9pjADj20lTXzSpAGb18sL0taYHFOSNIxUAx4So
	uSD01LF6NNytdh1LgLT5lq3sqTX6HKj/Ylou9etGoxAnfcaocOn1RCIk9c9tgvoKAny2qkssVXw
	7ajEHd2D5Rg6oHUEpOfMCEMXHvq1LHIWHDPY+jgsQ4Si8KnLP0fSIZjKwtXgJfeYqp5NihHxFiS
	93ElO3vEF6gMnztx+3Q0ieu39SQYHK4CBy4ptGDfONBx7T1eGTs3WwlIyaJwfyfRm3Y7ig+8dbZ
	NdTpAzLcfSHxyKPsRnJt6MzexFM+beu0aNbJ2Xg+fGaSWpEr8Fyj5HHb/Npu0+TNKXBTBZsadzt
	UnXORRNOiepbX5+n8WMRtkZcc+0w==
X-Received: by 2002:a05:6000:40db:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45e5c6137f0mr5428485f8f.42.1778848349668;
        Fri, 15 May 2026 05:32:29 -0700 (PDT)
Received: from krava ([2a00:102a:4039:3341:dfc:8dc0:b9c5:81b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a666fsm12903333f8f.36.2026.05.15.05.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:32:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 May 2026 14:32:28 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 4/7] selftests/bpf: Change uprobe syscall tests to use
 nop10
Message-ID: <agcSXAxizchfA84v@krava>
References: <20260514135342.22130-5-jolsa@kernel.org>
 <20260514205136.CEE0EC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514205136.CEE0EC2BCB3@smtp.kernel.org>

On Thu, May 14, 2026 at 08:51:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Multiple test validation checks use hardcoded, incorrect byte lengths when comparing instruction sequences, leaving trailing bytes unverified.
> --
> 
> commit ca88e95623000540d5b706ce364d5b5abf75b4c1
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Change uprobe syscall tests to use nop10
> 
> This commit updates the uprobe syscall tests to reflect that optimized
> uprobes are now placed on top of 10-byte nop instructions rather than
> 5-byte nop instructions.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 955a37751b52d..c2e9e549c737d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> [ ... ]
> > @@ -388,14 +388,16 @@ static int find_uprobes_trampoline(void *tramp_addr)
> [ ... ]
> > -static void *find_nop5(void *fn)
> > +static void *find_nop10(void *fn)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < 10; i++) {
> > -		if (!memcmp(nop5, fn + i, 5))
> > +	for (i = 0; i < 128; i++) {
> > +		if (!memcmp(nop10, fn + i, 9))
> 
> Is this memcmp() checking enough bytes? The nop10 sequence is 10 bytes long,
> but this only compares the first 9 bytes, leaving the final byte unverified.

yep, should be 10.. leftover from nop9 infatuation

> 
> >  			return fn + i;
> >  	}
> >  	return NULL;
> > @@ -420,7 +422,8 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
> >  	ASSERT_EQ(skel->bss->executed, executed, "executed");
> >  
> >  	/* .. and check the trampoline is as expected. */
> > -	call = (struct __arch_relative_insn *) addr;
> > +	ASSERT_OK(memcmp(addr, lea_rsp, 4), "lea_rsp");
> 
> Does this memcmp() skip verifying the displacement byte? The lea_rsp array
> is 5 bytes long, and the 0x80 (-128) byte proves the red zone is bypassed
> correctly. Comparing only 4 bytes seems to miss this detail.

should be 5

> 
> > +	call = (struct __arch_relative_insn *)(addr + 5);
> >  	tramp = (void *) (call + 1) + call->raddr;
> >  	ASSERT_EQ(call->op, 0xe8, "call");
> >  	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> [ ... ]
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index 69759b27794d7..be34c4087ff56 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> [ ... ]
> > @@ -271,17 +271,17 @@ static void subtest_optimized_attach(void)
> >  	__u8 *addr_1, *addr_2;
> >  
> >  	/* usdt_1 USDT probe has single nop instruction */
> > -	addr_1 = find_instr(usdt_1, nop1_nop5_combo, 6);
> > -	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
> > +	addr_1 = find_instr(usdt_1, nop1_nop10_combo, 6);
> 
> Should this length parameter be updated to match the new array size? The
> nop1_nop10_combo array was increased to 11 bytes, but find_instr() is still
> being called with length 6.

should be 11

> 
> >  	addr_1 = find_instr(usdt_1, nop1, 1);
> >  	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
> >  		return;
> >  
> > -	/* usdt_2 USDT probe has nop,nop5 instructions combo */
> > -	addr_2 = find_instr(usdt_2, nop1_nop5_combo, 6);
> > -	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
> > +	/* usdt_2 USDT probe has nop,nop10 instructions combo */
> > +	addr_2 = find_instr(usdt_2, nop1_nop10_combo, 6);
> 
> Could this cause the test to miss verifying the full sequence? It looks like
> it is still passing 6 instead of 11 for the updated nop1_nop10_combo array.

should be 11, will fix

jirka
