Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703580;
	b=QngO04Zur3W1jnTNORwuMjoYMNc/KJZOr+M03eGONFoIStA6Pmn+WhwlXd176ESAUcq7
	 tK5IpXvs9Fr3C5/UMWwmzmU+RfTZuNEsoOxgtJzRArJliINH626pNak4v8u3RMrN+wUVG
	 LeFylXNyJqZ9+Yku3xeeQWPNuipMaoOciiVoYIRybuKp0B/oZJG2/crsdief18OJuacyA
	 3hBsAOzu1oUDZPwPLwcvCHbZhVB4aBXulfKYiCZ4YvCUCZiZtuDc/YwLHPxqnZpJmW66A
	 V2u8Ms++KLVfmaxGSjEa66H/iOT2G6J9x++4qmIGp5cDQuOuBNeOw4ka46UrcAvkYZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=dNB1mnKPKeMJ/SMSzjMxKWB4upzMQxhzI2dJe9ubtz4=;
	b=AhVzLVRMrO0JPDc/ck6PrhbT6/q+ECF+i4piu5DLky0nyfk5cIaS9Pu+bIiqZZnmmq0s
	 PgUpCT1ZqqR+YHlobD3h28Y8lUNmtHdRh4eY9U1TltTo230NKq5gDYgFF0NqVqCgFpoPi
	 wmIzHxUMSQITiy1whtAP3pQTKr5XG6Bi1vmexfgS1OpXsOECs22oAl2kPeXtwgqYCTeXB
	 Zn1UWS3z3VWLvc6nrenYCbxPQVyJ8LRGNiAbTx6eJsoUXO24CCRAZjlxwRyQOAUAA17sU
	 azTIMVOtDmO8KwynrmjbZFW6GN6wnviNCuMo1a4Zh2/li+E3RL0MI4jCv5PWxIp+HPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MBgoEXYz;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594D606A327
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1594D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MBgoEXYz
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4aa5833c263so6829067f8f.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795703572; x=1796308372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNB1mnKPKeMJ/SMSzjMxKWB4upzMQxhzI2dJe9ubtz4=;
        b=MBgoEXYz6BNX7OqmN/vW4PSmX/XRk5mIvJ5KRIxN32+e1h9bmKbTdzabWQkmquA5Jm
         9q5H9UxGaHcKqkBij3B9UA2jTdd6X5aAD7LwtBIWi9eCOzSLPxYECDgfAY6aF6aqTiw8
         LdVUg++BjOPHuznHBug508/ImNwDtKtYN+XuQdaKAcnxQ8YV+FNFpdK93x1bfvReD/xT
         xTjdmkeTpupletvH9EpzMsZkibRDY621LvzT3c8Gfp1dWxTBvKbAbNMhHT7Q75STOlQC
         o1N/FDbI803QKKAbMNBXes+Df9+n2s0TfFm7Aqt91OhUWFL7wQv5b8LyDU348UH9f7h/
         a6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703572; x=1796308372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dNB1mnKPKeMJ/SMSzjMxKWB4upzMQxhzI2dJe9ubtz4=;
        b=CotMHqZ9q/NJ0bG2WTTZcgaDm405S/idlT1wJlxm6PRjOAJVPSBdPHyUIAPitmdCUv
         an4VZ0pcuSWZUywZnPk4pSKVUOzr1jHcnRAjZchVzsYi949c+ScvaW7dnd+lkdSvguXf
         lYKsU3xrD6wOeVRyy95SJkNF0R8iGrW68eSpP6dyBDL1wUrQnjQdDFDyCKOklDyUBtlC
         VscgMgCQlYONwkjR36+P6RK+d4tT67wilE29+cD1ZEPfcgT/jWXquNeCfcYKF+VqlDec
         ppqpj+emfXrCKJ0iyle8IStqF4We1TjrATdlNWjImHi1ag9Py73yZescNmVFGFaBOb/P
         vGsA==
X-Gm-Message-State: APuU4Z+TVlvJDt1lFxyh6WPPPadOjIyCi2Rva6c62hn83ps4CL9WIFmu
	n1eovlnDzuBtOjE7q5aZjj6CxWU8GT/b5mCX8zpHCvuFFVFKFeFK41sjzBELOw==
X-Gm-Gg: AZFdTZcaQQpWz2ZoBPH7hS/3otwI++slgip813+h6bWahym2fpvNnvPdBRAzjXJuCls
	WXeW7io47MyQJyI9yk+K3AZ1q61ZaTh1FxW2bingMkUwZHvpP/5AlAJYUvBfdSIU/jUkNBFxseg
	1MHP9+CVSqen/FTZQTovALqjGy65I8fRby+F1GRrSYCaIf8wdve8hAGnWYhnwPey2fMLxCdAuBw
	QwCLhkWnKQ3o+xC+qoB/VDICHOzlq8F9K4kW6XfWLZ8cn2qVx3tRpk38wnW6cykjOHmYSdnGBvh
	ZnBKNz19mw+mSJSp8eIw0aRhSyrCQ3B9OWn1ebkMf2ZzzebChwOAKYncUdgoomVKL/aavt5FnvR
	EX8H+ghuhXBWUNs99nuy0bhxU+8bOvvSrf+QTWgWWNGlgt12yeiI//KgxIt3mb/aR2GAxqlNZ4W
	09ajh0AlBht1oTGSz9YfucDNDbR5PLbSzukuuVh/rZrMtJFE66u9JrCFcYBBgF5xicj2E4O6b5h
	Y1/9qkFU9nKOZZtiGWizub9mzA3CUn3Ztmzy7CvURymcVByg0bBq+6llDgPHpWKJ7MRi8Y9lfyB
	Z6HQZ3UPPwr5Xn53rnObgQBkKz4LTBskXw7ZbA==
X-Received: by 2002:a05:600c:848a:b0:4bb:6626:5a25 with SMTP id 5b1f17b1804b1-4bb88813462mr365525275e9.20.1795703572435;
        Thu, 26 Nov 2026 06:32:52 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm600501465e9.1.2026.11.26.06.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:32:51 -0800 (PST)
Date: Thu, 26 Nov 2026 14:44:29 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 4/7] resolve_btfids: Exclude a set of
 functions by name
Message-ID: <awhFzc36w88ke3qL@mail.gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
 <20261126142915.1106330-5-a.s.protopopov@gmail.com>
 <sashiko-outbox-235699@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-235699@kernel.org>

On 26/11/26 02:26PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] bpf: missing Fixes: trailer for fmodret_tag() function exclusion
>   fix
> --
> 
> commit 2fc421479a0ddf21d6c174ca83ce8384475f3b9a
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> > resolve_btfids: Exclude a set of functions by name
> >
> > ftrace reads the code it patches with copy_from_kernel_nofault(). A
> > program which makes it fail breaks the detach of fentry on x86:
> >
> >   unregister_fentry()
> >     update_ftrace_direct_del()    returns 0
> >       ftrace_replace_code()       ftrace_bug(), no text poke
> >         ftrace_verify_code()      -EFAULT
> >     bpf_tramp_image_put()         the function still calls the freed image
> >
> > On arm64 ftrace reads and writes the code with aarch64_insn_read()
> > and aarch64_insn_patch_text_nosync(), which calls
> > aarch64_insn_write(). They are traceable without KPROBES. The same
> > holds for them. Two more functions break BPF after a skip:
> >
> >   target                         error    after the skip
> >   -----------------------------  -------  ---------------------------------
> >   copy_to_kernel_nofault()       -EFAULT  arm64, with KPROBES too:
> >                                           __aarch64_insn_write() fails.
> >                                           ftrace_bug(), no text poke.
> >                                           text_poke_memcpy() ignores it.
> >                                           bpf_arch_text_copy() returns dst.
> >                                           The new prog is all BRK insns
> >   tracepoint_probe_unregister()  -ENOENT  bpf_raw_tp_link_release() ignores
> >                                           it. __bpf_trace_run() reads the
> >                                           freed link
> >
> > Do not tag these six.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [Severity: Low]
> Since this fixes unsafe bpf_fmodret_retval tagging in fmodret_tag(), should
> it include a Fixes: tag?
> 
>   Fixes: 4dd950adacad ("resolve_btfids: Tag the functions that return errors")

Same. Will add it if another version will be needed.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261126142915.1106330-1-a.s.protopopov@gmail.com?part=4
