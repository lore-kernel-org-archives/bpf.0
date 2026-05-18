Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F3376490
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124366; cv=none; b=JY36rXHK9sC/9SLx9UsHIXIRmzRLZEcotTBpYOQ2lgZ0KvdBg0jKQumtPL+W3MIBgwaJqcWoQ/y67Yoiby+AuD/0svu9PHCgjj95QBcnhVQZqiPPQ6QCODQy05PJsVITrk0zTKZb0qW6Khteujx99h/zsEKBaxH+avS5pHkJxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124366; c=relaxed/simple;
	bh=E/4WeoAntZmDMnfV7zG8H+Yk5WfL6D2Nd73+uPfhq8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeAuNaUnSFmzm8B2OL+YxtcKZHRNKuFm1xid7q00Mjl/wCfeUXIg2wPL7VVdjI4NZjrKXWNWqSVuPeB6BaB6EOcT5OjNUPVBl+SZi6kvJO3A/b4tV0pvdeSsYatbl0qM2LPU5OcOtvFTtqViifmLKtAuUHsmWVxuuTCaPCVZkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4EL8kaM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4EL8kaM"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c80167f5716so1024755a12.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779124365; x=1779729165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyPh44NnAjI+9jKQI9q0bPTcCqGC6CGNFE37YibG8X8=;
        b=n4EL8kaM25ok1aD7Z6MfP131lwBI1fSwMwFI7zd7kPPFfXVL2aay7ccb28Ga6P3Sny
         Rx/8vF6NQW6DKtJRAi7RhsKgkKpvs/zWeSZfqJUTTa2f8dv+m8fpd/ckcwpAUK0yEdHf
         kvS0nyUnYXOrYf0e+mmqWkA+/XEPwqWoHwWh/Kzo44ae7QCnkQYfECpdDVTnEJMEQJM8
         INl2Jco7eEev2HaOhj0XG6J8Tvyf6+zWptO8HkxwnecuFhXJaQULs8/+VA2oBNOpPH3x
         lz6H++lhN80uy8oSnmhQZhOKXN0YlCfRHrQoXxl2wjO8o1Rtrv4/xMmrokZSGn0gH/0U
         IGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124365; x=1779729165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyPh44NnAjI+9jKQI9q0bPTcCqGC6CGNFE37YibG8X8=;
        b=Fvk9FpFT8PB+3DhCJUG5P4CwWj7M9QgzeuIVb/zZXm4AQ7pSc1muIyh8dlsgLU1Sc4
         K0/mInyDk65rwOICcicsp1/zmlpwyrAO8ypIHYP6tXcyyfe5Qj7CIS/6TI/CG7JQFAYo
         fGjTqYxiRAWBBem08Ge3ZBYLY83lWnUV0OXCEJmz0v2cvYuieGyPhPR9fXoI8MCbVV7u
         pBThi0DWNnPOCO/sIDOnjLf5PL65iQ3yh4N96tnSPA2+vLhaaSF3T4ohK/Kgs2cTlaa8
         ooG2Uabt1XYKNPcenUYPlSwE8vKMS5F6KxQxy7qDdK6LkcWL+tby53+LxVf0pTgD1obW
         B92g==
X-Forwarded-Encrypted: i=1; AFNElJ/c9tMskDQinv/WvC5q0EbZTc6k1ioZlw+VLX33rgA0g2nk8W0x8TQ2eMt93FEQ/OaOUZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgsCKNh/JsrWNBhVEBLXZc2QAXjYuKG0it6/z0K4CxP+7RDuZ2
	oWyryI5j96qRJhUiNLDucSA0+Jl1V6J3MFIq3v1Z6Lal+0hMnrZraFuf
X-Gm-Gg: Acq92OGnT+QVcnUeiwEMjAugMsldi+sqbXObEhbYL93JywlvIP9oNaI65W959Um5qe8
	unEnA6q+yn+aaEIcYgWj0tOQGCGVJGu3fGV1s6PjStvyxvYIDASo7QsYqeucn/ypnhs5LWILyqH
	Xe+9/g0AamgQk1Ag/0KzDr47Chy8ibiSWs5PfF9xcpBc9dKn+r4iUSdLr7+RKy+EymJBhu1LlUp
	iczTSrsfcGn2QTO9OssYSaD1BcUSNIUFUKTP5ubNDgHKZ32pWjfKN9I7K9hifyjDzmBF4iv+CnL
	SOp7ijjFWrCrBlVTWmO/HkBCKbLfVo9l0by8Fl92OoLIPLDqWHi9DXIitqiu+ZcJml3id/5bucN
	yTCzOZf89CvSAnZZUSiGuuQ/lOS2+9MuCvY8x5mAsJeWRt5N3yDm0ncIYbzP3lnLblZEUQ/Nu3T
	nMB//eq+G8t9bO6BiYmSWTm14waBJW75YmfQ==
X-Received: by 2002:a05:6a20:734a:b0:398:6bb5:54c4 with SMTP id adf61e73a8af0-3b22e815a13mr17993040637.5.1779124364750;
        Mon, 18 May 2026 10:12:44 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7f202sm14646616b3a.43.2026.05.18.10.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:12:44 -0700 (PDT)
Date: Tue, 19 May 2026 01:12:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	marscheng@google.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: Re: [PATCH bpf-next v3] m68k, bpf: Add initial BPF JIT compiler
 support
Message-ID: <agtIiKuoTlp-4XAO@google.com>
References: <20260511212756.3163955-1-visitorckw@gmail.com>
 <87h5oc4jpf.fsf@igel.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5oc4jpf.fsf@igel.home>

Hi Andreas,

On Tue, May 12, 2026 at 07:32:44PM +0200, Andreas Schwab wrote:
> On Mai 11 2026, Kuan-Wei Chiu wrote:
> 
> > +
> > +			emit_16(ctx, 0x4a80 | d_lo);			/* tst.l d_lo */
> > +			emit_16(ctx, 0x6b04);				/* bmi.s .+6 */
> > +			emit_16(ctx, 0x7000 | (d_hi << 9));		/* moveq #0, d_hi */
> > +			emit_16(ctx, 0x6002);				/* bra.s .+4 */
> > +			emit_16(ctx, 0x70ff | (d_hi << 9));		/* moveq #-1, d_hi */
> 
> I think this could be "tst.l d_lo; smi d_hi; extb.l d_hi".
> 
Sorry for the late reply, and thanks for the review.

This makes sense.
I initially kept things simple to focus on correctness first, but since
you pointed it out, I will include this optimization in the next
respin.

Thanks!

Regards,
Kuan-Wei
