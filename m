Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229493;
	b=dgVsqObXxTVfRvtvli/jUp0IqbkyaQN3Y/tONyG+bXlXiIm5wUqB5LZWvzvdaWyXxmsA
	 ayB6fcIWifsf8sri4mnzXhfOuHn92FRuPA7RAR0bGLjKvT+OlnWVpS5uW1k9Mpvdt/uwp
	 pMAQTNUW7GFXX58jm4nQuZCKi9/26R1zoBpzBQoYnON4ldhrvOBrJToaCHRtggxC6Ao8/
	 D8SBM+UF2cAJKuoLZTJkqkTYeaO2KayYwDYvJU6CHztHAxII6HYzXdhhYqjLMuPYUquUZ
	 8GP1nwpnhg/cGm45kJ2uGNmxYpEv4Hv4JzfjF3ryxI/Sh553qXZB7zkdHE7QTfDZceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=V6AbWD+Qg2sAj80uwGcxzlirL7Nk8T9JdNmNHXSXbg0=;
	b=t/vMv+YSSYpZhWwWK8AGFy2tMPLWY5CWOFSfveDdQT8JV+C2KqOffQLwmei70OJ9m7St
	 baroUyCl8VozrncRCGph9MUOCfdDLDaSRFgLF1Lo6vm5eH50NmbHk38n4qrL05ULpQgtX
	 xHvF7vba6SdX6QrTFCrtHAktcg5k8astmzWHAElWBBYG9hicbYYw1dlJSDnx5AET9ZH58
	 1hdtrTCmdwFhzSge67W8ozFLkakTDAEb/kV1fczjOJSHbkDuzyZAPz8bORGgxOPzChaPc
	 Unv+UlAU3nvSFA1sZQ9QAtUQ94hfYUn9pGCEbSRYWxGZ9e5mcJjj0LZ0BMU5vhMF5UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UkFxN4Vt;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CB606A326
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B30CB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UkFxN4Vt
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4322d310e7so114362866b.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794229491; x=1794834291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6AbWD+Qg2sAj80uwGcxzlirL7Nk8T9JdNmNHXSXbg0=;
        b=UkFxN4VtGOd3hCw+c76+jA17SsoX02K9yzGXJIuKIJay5Sa5KOvWDx+IuhykVNny/s
         qW7a7TogwQ1o92ztf7YPHP24UXGeZUPsx0HURdbTQfXRx4DbtzQcVof4w+xn7+WZ7GM2
         xT8xYSgnoDoa22RmAbGUfXia1TC2wl7ZUFSAr4r097zJ26q8mPk8+kACJ6RkWInrLHGD
         mcktcz76qegYz9MwrP8JCSiKydQ+LwzBobKAq0x/rBWXACDRj0vTHPmPwAaIcxf/wbdk
         cCkTnKYqsXLVw1FxQmZPiXAF6p9sjmxejisODf2HMxDbzMRfLn8zsM/2rztZYKuuXpEH
         x68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229491; x=1794834291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V6AbWD+Qg2sAj80uwGcxzlirL7Nk8T9JdNmNHXSXbg0=;
        b=RYM34wW9O91btxK27Hk8l/Gj4k2kOJ6iD40oBf1azt0ElGfVrGcSz4H8UcQb6F6Q5s
         TbYzL0vWza+h7Bs/rTHiBpcfYFauTFfISCQ37QKXmm+rZ+PamSW3PngNofTyoRRiI0x/
         0KULWv4OBwMwI6f6W86d8WIfHjFQGUA5h5uaypp/XrGwFouU6rdJZ1l+RKoL6LKvgYAZ
         i9ruCXQjrj4XU+c7z6paSJHFj9yUdtnqylh7krbK6ZuLfoGEs52yHwg/ZT3wUO9+YGg7
         EiZqD1HdfqTWfqGcj88Tx2eTyqZCtdqxtkrC3NpKViiczEv3CHtf00ZYHFdLgs6nkyHk
         66vw==
X-Gm-Message-State: APuU4Z/xEW6vKO3zaUtqspZxywwrpau9y2OYBPm31rAN6Y8Qv983yNbd
	uCI60LJYKeGUKrFU7ycoKLSW1IEAQwzzi5eleQu3lcybWOhHtN7/NMao
X-Gm-Gg: AYBFou39FUZGLCDGcNrRBcCr/V4IfwawFT+Nj7yC/YuHVREkpvg2srPHvUBr4574Z5M
	qKf0OzelgEKCzWPOm5+U+DuAX219LaqHPUYjflY38miQvjxbvOm4W7tYd8b8nP1asIHRKLEKLEi
	qJLcQ+iLA0L1HJx/6xNONCzLKypXK5k+B3tnM0GS3kAoiGkLkYb3OaYVefqTLEdL044O82nLgSJ
	qMgziTYf5aT8lA7ysiIjkf9JhTt5yn7K+nUl+9F3LprnIZdaZrHECkDfBDDXb/2TxWyJuVHsNQy
	gLY3CNTTZO5hhbqrjxBa2uGYSZ73UAOaoTlbrQVhmfAPxiirw/j604gsOvjZbDZcC7+z4zoXt+N
	fQb23JNF7qjReyVjqZgB8MlQ248ALYY7X3arTe/bMeG8pQpvWe6ntEZtiSo/PKEnBEKmJ7KFeFz
	5XTu0TEiP5g6KW0/iD+9mi5DYtI5hVq7DGQgk0801GSY1BaMRlIpPASbH2cQ7VebdteZq4579VS
	TSDPBACtL9109FoBtRCq1eAQ6FgujL8fDblB4mwL51oV59shMBZ/nVhu4FP0n1vZmKrDO/cBvcj
	NNgfkZsxZZLzKtJ9bZqqJL8K9s3bALGXAhMP
X-Received: by 2002:a17:907:72c8:b0:c42:3a77:80e5 with SMTP id a640c23a62f3a-c4d6d79aa5dmr268451766b.29.1794229490710;
        Mon, 09 Nov 2026 05:04:50 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a9789a6sm172690266b.66.2026.11.09.05.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:04:50 -0800 (PST)
Date: Mon, 9 Nov 2026 13:16:24 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 13/18] bpf: Check the return values of
 fmod_ret programs on found targets
Message-ID: <avHHqNh9jAYWZuP6@mail.gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
 <20261106210314.1767267-13-a.s.protopopov@gmail.com>
 <sashiko-outbox-202293@kernel.org>
 <avHHMqdiCgT79XWT@mail.gmail.com>
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
In-Reply-To: <avHHMqdiCgT79XWT@mail.gmail.com>

On 26/11/09 01:14PM, Anton Protopopov wrote:
> On 26/11/06 09:17PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found no new issues
> > in this patch, but noticed 1 related pre-existing issue it does not
> > introduce:
> > - [Critical] bpf: use-after-free in check_helper_call() [1]
> > --
> > 
> > commit f5e3bd12bcf921a0d31fb8a40c17694ea46d4300
> > Author: Anton Protopopov <a.s.protopopov@gmail.com>
> > 
> > bpf: Check the return values of fmod_ret programs on found targets
> > 
> > This commit parses the "bpf_fmodret_retval:" BTF decl tag on fmod_ret
> > target functions and verifies that attached fmod_ret programs only return
> > 0 or one of the specified error values, while disallowing tail calls and
> > freplace extensions on such programs.
> > 
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 1b58a1796a2e4..71fbb30e4d768 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -13338,6 +13338,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > >  	}
> > >  
> > >  	if (func_id == BPF_FUNC_tail_call) {
> > > +		/*
> > > +		 * The program which a tail call jumps to returns for this one,
> > > +		 * and a program array does not check the values it may return.
> > > +		 */
> > > +		if (env->prog->aux->fmodret_retvals) {
> > > +			verbose(env, "tail calls are not allowed in fmod_ret programs with restricted return values\n");
> > > +			return -EINVAL;
> > > +		}
> > >  		if (env->cur_state->curframe) {
> > >  			struct bpf_verifier_state *branch;
> > >  
> > 
> > [Severity: Critical]
> > This problem wasn't introduced by this patch, but in check_helper_call(),
> > can passing an RCU-protected or iterator-yielded pointer to a pointer-cast
> > helper such as bpf_skc_to_tcp_sock() drop its lifetime constraints on
> > regs[BPF_REG_0] [1]?
> > 
> > kernel/bpf/verifier.c:check_helper_call() {
> > 	...
> > 	if (is_ptr_cast_function(func_id) &&
> > 	    find_reference_state(env->cur_state, meta.ref_obj.id)) {
> > 		...
> > 		regs[BPF_REG_0].type &= ~PTR_MAYBE_NULL;
> > 		regs[BPF_REG_0].id = meta.ref_obj.id;
> > 	}
> > 	...
> > }
> > 
> > RET_PTR_TO_BTF_ID initializes regs[BPF_REG_0] without propagating MEM_RCU or
> > parent_id from the input argument, and the cast block above only runs when
> > find_reference_state() finds an acquired reference.  Because RCU-protected
> > and iterator-yielded pointers are tracked via MEM_RCU or parent_id rather
> > than a reference state, regs[BPF_REG_0] is left as an unconstrained
> > PTR_TO_BTF_ID.  When the iterator advances or bpf_rcu_read_unlock() is
> > called, the parent pointer is invalidated while the cast pointer remains
> > trusted, allowing a use-after-free.
> 
> Not related to this patchset.
> 
> The bug itself looks real, I think it requires a follow up,
> will try to not forget to send it.

(If it's actually reproducible.)

> > [1] https://sashiko.dev/#/bug/linux-97cfbde4-a454-41bd-bdcf-b13a51d2adaa
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20261106205523.1765622-1-a.s.protopopov@gmail.com?part=13
