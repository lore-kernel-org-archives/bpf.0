Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98333372A
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782632097; cv=none; b=H9gsC+kv8ksElJG3Mq1AiBvpekNLfkNakrpoG1i9oRUs4lTYk4jLa7x7Di1BuWp+CvSrgiCSD87PapI5W7Vhttlg91czGVvqfXuV1P/VP37AqJ6NPkKit1UYDCzEKR61k2vMLdO23e7LZhDEEPHnys4fmAx+Bl3SALOWBF45G+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782632097; c=relaxed/simple;
	bh=EV8iC9i6Gy9ckKT7DkWM9xWacu6PAtfwN5tasg0SZVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngg9Orx5fdOxR70XVNHIj7htwUMMvfx3YvGrhAdeuug5CXhMrS1INRTwv3JRQTbU7yUDoYw1UKEkwK1OWM6IdnVcZljfN8lIaP6ebRk0FZB4z4XSr+7RC7Jtvu01eCPvoBWEFtkXqdIe/OdJj55dTCM1D9kFN4ye+P95Tf1BIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKHB573e; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKHB573e"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13809223fd4so2833716c88.1
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782632094; x=1783236894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vledIumPthBBbn2WzmCtAqEFwAG6SWS4TJU6ZxwEn40=;
        b=oKHB573ejPdUdQCoJvdQCIumBBpn4SJjQrB16z78AnsCJie07bAtUcXsI4GQrLErXq
         VbQdV58QNAM4PNvFDn74QjrKGqLqxjcV9NXl20R2os1VBDFhIuXMbSINWSsFHkvsyxl8
         7W+l5cHt+x8tD4R8isJA9Mh8WYa6TZ9vNJ5TkyKBhdEOq3O60/8MPytTP/BtRszyyJo4
         RD3b69FDr3PLqUY7HbTzHVB1zcaTgKikhcA3DXf5E6EFGvx/Zqo3qay5lZ3nl9xopdQT
         qxGajDNGvwnucpCiY9Xz4PTVH+FQ6BOxCWtEMJaapD7cAl7OGWygVBU2UpcdFNFdww61
         oOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782632094; x=1783236894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vledIumPthBBbn2WzmCtAqEFwAG6SWS4TJU6ZxwEn40=;
        b=QS2QvW4Ja0mfK6mKZBgT3/8VTm0QbcdV7eC7Ujckd7e2hxdT2PtdRwCEsuteJA4iPU
         EfUiOpV/A/MlohNdYMYMip05oeJvZyXMKO/XJY2TLkEqTvPiVbfVY7bqX2NGPSXhg4L6
         V/eFKG67JXEN/o/9ot5xbSQpKlpeIWhTzvlN3/YXshNIWbOgJ42LYnac/zqV8f8PGLkO
         6KqwTjqFsH6cfp7gvt+AFeflqJ2zVRUle/zZphW5KM92bxAKJ039FG8A4Av4YrTDSTAh
         2g5E1/t3gfn4AIumnm42oUPXWnDlTM7LsHjbL1oSL/yNJgG0n7BjxYkQT9dNA/bgHRO3
         4d8g==
X-Forwarded-Encrypted: i=1; AFNElJ845iorUTWfIgN30Sx/m4rTgo1m6z3+0KUxjotDK30WtsgWaUKHZYPXvGDccbma5BcYYJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZjVgY4ILqD/HUrSmEBtElAvbwPS6MVnVNe5VfIlDFWslU8Pt
	O6i/6Idz+jBUoTirJASyT9/WITHNcRPc/H4lCU71oflwz4K0QRozEUqk
X-Gm-Gg: AfdE7ckVzeVzyKN3DO22MveRyFDnxCUnt7xwujhSXDQ3Mb2DxiuDNajFx/PONQJBmZ6
	mHyJpvnJvvOPe7EggXZTWi+1/hmAYkyDKmXbwAq73ckofK5YVye8iV2yjuWCJUrZBOWUkIf8PP+
	dphAVl4pd5HKv6OfxljE440FAxCrVT5EzmlsgvRyxP9oqCLMFsK953B8CewknPgLpJ7wXXzFUxR
	d8wFj5aEeanjOXeCtJZLetmsjwkEWlHYTriFZN7ddbPmfXomMguzvYyXTB0WUp5mELy+Q7soeW1
	d7ps6mDgWcFc8ufz4MOani/YmEIdmAgvEVQW/0pj2G6oG31YA3bZRJ6S7YxmvFs1A34fOI41ue2
	BZNkJBpqWv0fdAyCofTlNm9J/jlUA4ZY65ktX0pVXt+nMJ58P3oJLGS+KrKcflB1GPUbK5G3yTk
	XI0CJVA4Gs/+qlFSZObNksskFYvUn0
X-Received: by 2002:a05:7022:f694:b0:138:637:6227 with SMTP id a92af1059eb24-139dba0a865mr13084203c88.11.1782632094282;
        Sun, 28 Jun 2026 00:34:54 -0700 (PDT)
Received: from computer ([2a09:bac5:3b4a:8aa::dd:15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139e42338f9sm19928106c88.0.2026.06.28.00.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 00:34:53 -0700 (PDT)
Date: Sun, 28 Jun 2026 13:04:42 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, bjorn@kernel.org,
	alex@ghiti.fr, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	puranjay@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/3] riscv, bpf: Add support for BPF exceptions
Message-ID: <akDOkptnqJt9LDtj@computer>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
 <20260621144259.288135-3-varunrmallya@gmail.com>
 <b6e8c677-5fff-4de1-8483-fc23361898dc@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6e8c677-5fff-4de1-8483-fc23361898dc@huawei.com>

On Tue, Jun 23, 2026 at 10:11:57AM +0800, Pu Lehui wrote:
> 
> We don't need to duplicate code. Please merge it.

Making this change in the next version!

> > +
> > +		if (!aux->exception_cb && aux->exception_boundary) {
> > +			/*
> > +			 * Boundary program: allocate the frame and save the
> > +			 * full callee-saved set, capturing the caller's values.
> > +			 */
> > +			emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
> > +			for (i = 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
> > +				emit_sd(RV_REG_SP, store_offset,
> > +					rv_exception_csave_regs[i], ctx);
> > +				store_offset -= 8;
> > +			}
> > +			emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
> > +		} else {
> > +			/*
> > +			 * Exception callback, reuse the boundary program's
> > +			 * frame, whose frame pointer is passed in a2. Setting
> 
> something confused—why is it A2? I feel like I missed something.

bpf_throw() invokes the exception callback as 
bpf_exception_cb(cookie, sp, bp, 0, 0) , whose 3rd argument (which,
according to RISC-V's calling convention resides in A2) is the boundary
prog's frame pointer. Since this else branch handles
the callback, it expects A2 to have the frame pointer. The arm
implementation does something very similar with emit(A64_MOV(1, A64_FP, A64_R(2)), ctx)
where A64_R(2) is the third arg.

> > +			 * SP = FP - stack_adjust lines the epilogue's loads up
> > +			 * with the registers the boundary saved.
> > +			 */
> > +			emit_mv(RV_REG_FP, RV_REG_A2, ctx);
> > +			emit_addi(RV_REG_SP, RV_REG_FP, -stack_adjust, ctx);
> > +		}
> > +
> > +		goto tail_setup;
> > +	}
> > +
> >   	if (seen_reg(RV_REG_RA, ctx))
> >   		stack_adjust += 8;
> >   	stack_adjust += 8; /* RV_REG_FP */
> > @@ -2082,6 +2173,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
> >   	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
> > +tail_setup:
> >   	if (bpf_stack_adjust)
> >   		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
> > @@ -2157,3 +2249,13 @@ bool bpf_jit_supports_fsession(void)
> >   {
> >   	return true;
> >   }
> > +
> > +bool bpf_jit_supports_exceptions(void)
> > +{
> > +	/*
> > +	 * bpf_throw() unwinds by walking the frame-pointer chain from inside
> > +	 * the kernel back into the BPF frames (see arch_bpf_stack_walk()), so
> > +	 * exceptions require the frame-pointer unwinder to be enabled.
> > +	 */
> > +	return IS_ENABLED(CONFIG_FRAME_POINTER);
> 
> riscv select ARCH_WANT_FRAME_POINTERS, so this will always true

I checked that the kernel compiled even when I turned
CONFIG_FRAME_POINTER explicitly off, so not gating this
would be a mistake, right ? ARCH_WANT_FRAME_POINTERS makes
CONFIG_FRAME_POINTER user selectable and makes it default to
true, but it's not always true. What does force it is PERF_EVENTS=y but if
that too is turned off, then CONFIG_FRAME_POINTER can also be turned
off.

Thanks for the review!!
- Varun
> > +}
