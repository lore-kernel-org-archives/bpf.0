Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50963E9F75
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129405; cv=none; b=Kbt/X7/Vf0PlQT8wvpcTKBmK2S08EkGFLAV0C3g246bA0LDdiaTrfMa7bthjZJYT7GtP6Hmaz+il7x/f4PREUJKn8ktrPFc4gpzt2ixFSBHoPMrYWiEigsl+9e8kP9BGpYGkhcJLBmyNBfrtYRp294A0pUYmqAMGynTyCdjBMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129405; c=relaxed/simple;
	bh=2UiGpkxWJOENxagNwNXWT1UJi0xZTdx3Bai85UEa8TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf9S/Kc/Zf5pU9JqOvOxS6Kfv5dtXO1MkFjO/Ll2aW8JXeRYUzTJOE7ln740ix1Kzl/bWlQkt8LyodNfnvAFg3FeooweDYcye3J4JhRNpzaMnK/EN1FCpSCGG+XJyGauXl94tmVxnzpN0MjrLOI+mwEZWtblHn6ttwO17GxQhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LUMpaUv8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LUMpaUv8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so30597645e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773129401; x=1773734201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/T174RxQBtuXkKZ+Y9qcJr6xB7ezSpQIF7Dkf2TBCc=;
        b=LUMpaUv8e+ChwOiSBrIQdzhL61zZhOB1yLn7/1g4T9LC9YwSjaljDiSuK+bZhb8DXV
         fu3YQ/hJU6ncoG5f2alOZLUlyB4hz7dGnTOqCV84zqiE31EI7f7LdjHNBc3npB5dcoOp
         cirJ7GeTv7KjBR+BEbgw5HOkYoFdMrQWRjpXA4K2TTfLef9DFKQWgCFXf+Ml6oLeknh1
         AowFPjRzh5Q8rXM+S546kX0xZIkQ/vR/vWWQqY1wc59/67HMPF4E0XmDZmq5Ji5vpTRb
         TUFaLdJvDqewoWCnOsI85oVxujc/4rUGUgBYUNwqDZ/kyKDZ2VVspH/R/UqZA866Gxl+
         bg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773129401; x=1773734201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/T174RxQBtuXkKZ+Y9qcJr6xB7ezSpQIF7Dkf2TBCc=;
        b=XI2NByrFTJmULwR0DDihulhkk8F7h9OoeLNBStALVQGn5DYvNlOGPikG0jbjlj363f
         yNkoqPiNy1a/nm4sSLRsdp9WJNJJkruljzNt67Aie6rrDdQ/t7gVwVc7clIuPPLYiUx7
         CtPDyOhGO8IhwJ8WvAv4UHTRIViM1rlgVUdKLNBnZaLd27bmcsegYAecsH8ADYmABU3T
         WoeVVmfRkAMY8NIxxh2XLwvXN7rDMu3Xl6gh4ckhoXpvrWj+AtqR+xOqSThyuK0418O6
         PtJIa5ek24AB0WaCejSpt4rvqKjaP/R6NSN7uKdzxKndiH+l5tMpg0s6bt1Pm9X8Mm4A
         4htQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm6LzBjDMVTFIgsQyET/IX9Ni+zcVXZhcOlOuL2ZdULfXFg+XhOvz/W/xj4b3g2S69C6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IiqKsFsoiCdMurJOcEB77GI0c1VQBuP8z6gFzlhNaB1ql4P8
	RYaDcl2VR9eQ/qh0TGraCkmcyE8i9gi04zXYzcFPQpDd5X7jGVgPGx/icDJN1mD96ms=
X-Gm-Gg: ATEYQzyHLrXR4+H/9VPj02PhHm65zwox4zNWhr/05NIdTN1gdPC7fRp6iT8fF+orDMp
	sDpyAzdNEHD8yE9FZof3yZ1EgWOUda17DHnYKkS2BO5Ssk2tVgZk5MYWU8GjwsWmAkuVT4865bL
	/S62qQOKhMiQ1fAz9Ahv2O+Vi8TpYGbbXlY7TNxdzVIzJZtChu408nUGRZzHTgiyiwQWji8nqsr
	es+my+VAaZTy8ts07piAsotR7DqNb/liziAdXj5y874+2CkWoEAuMVaiDflrso/MSoQ5ATttnFw
	sIPHeYoVEu0UMT6qse4hMp42PE0ha4ZTUgoWkmBFMeDNpZGlQY4eNeIJch1fV1JASko0PWyAgiJ
	EUiaapqruz76m2oT547JIBQcJgpT7KXmBDKMFyzxvXY6nekpFLnvFxcnnkXKEi6FZP+ksM3eqtU
	orjRrhjVNfgBqChIaDmg==
X-Received: by 2002:a05:600c:3b8e:b0:485:3ae8:2231 with SMTP id 5b1f17b1804b1-4853ae824cemr122110075e9.30.1773129400681;
        Tue, 10 Mar 2026 00:56:40 -0700 (PDT)
Received: from u94a ([2401:e180:8d01:1fb3:e42c:360:78fd:1fec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d3871sm12808100b3a.60.2026.03.10.00.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:56:39 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:56:31 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
Message-ID: <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
References: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
 <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>

On Mon, Mar 09, 2026 at 10:53:50PM -0700, Eduard Zingerman wrote:
> On Mon, 2026-03-09 at 18:30 -0700, Eduard Zingerman wrote:
> > On Mon, 2026-03-09 at 18:07 -0700, Eduard Zingerman wrote:
> > [...]
> > 
> > > Of-course, I might have some bugs in the test definition, but in case
> > > the definition is correct, I think I'm inclined to agree with Ihor
> > > here. If we can't mathematically prove that the sequence converges in
> > > a fixed number of steps, putting a loop on top of it seem to be a
> > > reasonable thing to do.

Got some evidence that 3 may be just the magic number (of course,
assuming no bug in test definition, as well as the representativeness
caveat; will try to further cross-check mine with [1][2]).

More below.

> > > [1] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle
> > > [2] https://github.com/eddyz87/deduce-bounds-verif
> > > 
> > > [...]
> > 
> > Pushed an update to the test to check if new bounds are tighter than
> > old bounds (instead of equivalent). Still get a failure log:
> > 
[...]
> 
> I added back third round of __reg_deduce_bounds():
> 
>   diff --git a/deduce_bounds_new.c b/deduce_bounds_new.c
>   index b0bd8c8..dc498b2 100644
>   --- a/deduce_bounds_new.c
>   +++ b/deduce_bounds_new.c
>   @@ -326,4 +326,5 @@ void reg_bounds_sync_new(struct bpf_reg_state *reg)
>    {
>           __reg_deduce_bounds(reg);
>           __reg_deduce_bounds(reg);
>   +       __reg_deduce_bounds(reg);
>    }
> 
> And run cbmc with the following assertions (see [1]):
> 
> 	assert(a.smin_value == b.smin_value);
> 	assert(a.smax_value == b.smax_value);
> 	assert(a.umin_value == b.umin_value);
> 	assert(a.umax_value == b.umax_value);
> 	
> 	assert(a.s32_min_value == b.s32_min_value);
> 	assert(a.s32_max_value == b.s32_max_value);
> 	assert(a.u32_min_value == b.u32_min_value);
> 	assert(a.u32_max_value == b.u32_max_value);
> 
> This failed quickly with an example, showing different results for old
> and new orderings, new being tighter.
> 
> And then with the following assertion:
> 
> 	bool old_better = a.smin_value < b.smin_value ||
> 			  a.smax_value > b.smax_value ||
> 			  a.umin_value < b.umin_value ||
> 			  a.umax_value > b.umax_value ||
> 			  a.s32_min_value < b.s32_min_value ||
> 			  a.s32_max_value > b.s32_max_value ||
> 			  a.u32_min_value < b.u32_min_value ||
> 			  a.u32_max_value > b.u32_max_value;
> 	assert(!old_better);
> 
> This finished in 20 minutes claiming successful verification.
> Hence, I conclude that new ordering is strictly better than the old
> ordering if there are three rounds of deductions.
> 
> I suggest we should keep three rounds of deductions and adopt the new
> ordering (or play with orderings some more to choose which one is
> better under 3 rounds).

Agree that perhaps we still need to keep 3 rounds of deduction after
poking at this further.

I tried to run an updated cbmc script[a], manually editing the file to
change the number of __reg_deduce_bounds calls made, and check whether
an extra call would further change reg_state. For
__reg_deduce_bounds_old, it needs 3 calls to pass verification, and for
__reg_deduce_bounds_new, it still needs 3.

Gist below:

  static void reg_bounds_sync_new_loop(struct bpf_reg_state *current) {
  	struct bpf_reg_state next;
  	int i;
  	__update_reg_bounds(current);
  	/* Taking any call away from below make verification fails */
  	__reg_deduce_bounds_new(current);
  	__reg_deduce_bounds_new(current);
  	__reg_deduce_bounds_new(current);
  	/* Try to see if an extra round of __reg_deduce_bounds_new further
  	 * changes anything.
  	 */
  	{
  		next = *current;
  		__reg_deduce_bounds_new(&next);
          /* check equivalence */
  		assert(next.var_off.value == current->var_off.value);
  		...
  	}
  	__reg_bound_offset(current);
  	__update_reg_bounds(current);
  }

On a quick glimpse, 2 rounds of __reg_deduce_bounds_new do seems to come
closer to a fix-point than 2 rounds of __reg_deduce_bounds_old. However,
for the following case it fails to converge in 2 rounds. Counter-example
generated with [b].

Input:

  actual=8
  reg.var_off.value=0
  reg.var_off.mask=0xfffffffffffffff8
  reg.umin_value=1
  reg.umax_value=0xffffffffffffffe9
  reg.smin_value=-23
  reg.smax_value=24
  reg.u32_min_value=8
  reg.u32_max_value=0x80000008
  reg.s32_min_value=-24
  reg.s32_max_value=23
  
After 2 rounds of __reg_deduce_bounds_new:

  current.var_off.value=0
  current.var_off.mask=24
  current.umin_value=8
  current.umax_value=23
  current.smin_value=8
  current.smax_value=23
  current.u32_min_value=8
  current.u32_max_value=24
  current.s32_min_value=8
  current.s32_max_value=23

After 3 rounds of __reg_deduce_bounds_new:
  
  next.var_off.value=0
  next.var_off.mask=24
  next.umin_value=8
  next.umax_value=23
  next.smin_value=8
  next.smax_value=23
  next.u32_min_value=8
  next.u32_max_value=23 <--- different
  next.s32_min_value=8
  next.s32_max_value=23

a: https://github.com/shunghsiyu/reg_bounds_sync-review/tree/reg_deduce_bounds-convergence
b: https://github.com/shunghsiyu/reg_bounds_sync-review/blob/reg_deduce_bounds-convergence/reg_deduce_bounds_new-counter-example.c

> [1] https://github.com/eddyz87/deduce-bounds-verif/tree/experiment
