Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7BB380FD7
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250305; cv=none; b=P9hhma4z4dwtTS/pnb7zzKV2L7U5PCIaAcmPrKR71DDFKi2lHY94yOx+E2B0TQWF1/DWHgkF4Arq44/UR0liEwIr555UIm7Dl42jsLrqpw/IR6Mcq6hQsXDxbIuScV6M3/BtRLxH/VD3OKHMHvYj8t57ndtJJqPdtiHjGCNI9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250305; c=relaxed/simple;
	bh=K4UZF6ThbeKC5oc671xPMUh/DHFlqpd5c7dTJ8pzq5w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbpHGeWrNFGrSdClnjojAz5mJlNZA63TdW++KfDDrYgX/QM5+E0ob8EVgM3/bC4ACpECvHiqcWiO2G+aULj2IP4eu/R2VxhocKrJsPkg/Hah7yKKjkbRWjm9TKY7hMEvorYi1ypUNVvEjiPi2/zWbXUIuSBaE5qW/hhuzza57eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoZEqm6V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoZEqm6V"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495437bb891so6252005e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788250302; x=1788855102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q1wsWo0+bHbeVA+4aZjel/63TQcKF5t0tkxqh6Apz00=;
        b=HoZEqm6VGMkijOiIsK8XqlK202NqxTL9E4+lal5Tdp58K9KfZNh4ykEtX4AiPMvl6L
         xJAHw+kq4C9jxyzJdB0kMk3d0jGK2ngV7ynnXpfjo77IcXD/m1zzqAlhOvyk+soSfBep
         MB9Bx/S91+7NGcZHHyfi0pN74ABcxBn6t2xKfOlu0AXLaa3wIhcXs+8GSGwUTmmlfXxT
         GkiLbhlprp8A7SRy6v2Q4yT/lVBm74PaltOXvjxE7v2I16F/kgA61JLamdIB2UfLFCtw
         3zQhi0AWhxmuHcXhe8JGyjRgOLye67HxIzXAa3uiXlmhf/UuSucX4ZAg7XAO2OcLjtF1
         6kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788250302; x=1788855102;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1wsWo0+bHbeVA+4aZjel/63TQcKF5t0tkxqh6Apz00=;
        b=rOJoZFro7nVs7+3ocNFPbmUlRxx8iFTSTKyqLR8HtCE0c9mn/LiPxvVV05vAG6BG/z
         Ena196f03U7zJDKLSfRALohzSBZp8u/DYZCJPCK7X1s93bQjuJ6YBZBJ8Yw31N2X5eiL
         o1+UEM9wF90HrbE2G1HNYm2t8SMrYuVplUJH2R2Cg2gdTz+IugPwWaWALyMaA7HzTHyZ
         5Sd6hR3zmqtsyc0rGJNRXD0EvkYo5yOwdcJHT8WhPOxb8bSKwfEIPVnizqxblXp+OT15
         U6loCv6OVlApeY6DDNnQB3Y0paLxnI+YfeHP8wT6PxwyMltX5KhKsy3gs2fGkUlTrsS3
         AMCg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4u9uRTNeFrfUmoGtiW/Izsjpu7QG6XCsPDEFkLIqf8oCCLSfLEi8OC2SKGYMS7c+9fpU=@vger.kernel.org
X-Gm-Message-State: AFuF++ngSt3x9SEgc2o0jI06sySWm2mRm0lFIDdn6OikuS+CixFbpadI
	1gZhw23CWVAJXvi5855rVuWnVRcSkILZY4kO7Zt0I3FxGbL+GTWAekXv
X-Gm-Gg: AR+sD12GJDmR3sIPZY29wxzkY8D3sh+hb8m2cJLdmf4maCzFxLa6ukym67kwnH+FCqO
	9ZnzQzKujg2a+KgLQbpuykbcwXdlK1RP1I4N2tEGIYhhZAadFqbRfMJ5189XtLZR321dvLa9XA4
	tkQvUbons3U0/kn1lh72+SEUSv9GX1q00X30XyW2uawMWmSoiPtYk1f3EhYjh6vPocKlDnXFFJ4
	7etJWilLlDnsgjT20Qi5Pj4AKqhc5gtu+IS9mkc6K41VjpQtr5yivUvUjFcg1MH3yuuinbx7W7L
	45lKBYxRxD5PfhL7De47zwgOxuKN69lKaMQaBHxL4UZbwosFkI1u6ZFEEn4YcHeOlNUFAeUwArT
	2fP3aSVSF4QYYGfqQZQAqs3uaJT+JYBOhcD9ZOiT/tnWites1Aj0sI8ZFv2mNLb/Wtcf5BKR9Bl
	/3cj+e9ishfjsiNvjXTh3soC4RNQ+q+T+/Aj+llu5VpEn1qQ8R
X-Received: by 2002:a05:600c:705:b0:49c:d8f1:ec60 with SMTP id 5b1f17b1804b1-49cdd735316mr38936415e9.8.1788250301787;
        Tue, 01 Sep 2026 01:11:41 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d78444sm3643306f8f.25.2026.09.01.01.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:11:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 1 Sep 2026 10:11:39 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, rppt@kernel.org,
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/3] bpf, x86: Introduce JIT emission context
Message-ID: <apaIuxCD3HyZeiDN@krava>
References: <20260831114614.157277-3-jolsa@kernel.org>
 <d3b30565c015a75c09b1b79b4684bf3399f8db42f0aad1d5faaf3267ba817f0d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3b30565c015a75c09b1b79b4684bf3399f8db42f0aad1d5faaf3267ba817f0d@mail.kernel.org>

On Mon, Aug 31, 2026 at 12:54:35PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 5922bb4728aad..eff0523161c3e 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> 
> [ ... ]
> 
> > @@ -947,10 +898,9 @@ static void bpf_tail_call_direct_fixup(struct bpf_prog *prog)
> >  	}
> >  }
> >
> > -static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
> > +static void emit_mov_imm32(struct jit_emit_context *jit, bool sign_propagate,
> >  			   u32 dst_reg, const u32 imm32)
> >  {
> > -	u8 *prog = *pprog;
> >  	u8 b1, b2, b3;
> >
> >  	/*
> > @@ -984,14 +934,12 @@ static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
> >  		EMIT1(add_1mod(0x40, dst_reg));
> >  	EMIT1_off32(add_1reg(0xB8, dst_reg), imm32);
> >  done:
> > -	*pprog = prog;
> >  }
> 
> Does this break the build? Removing the trailing '*pprog = prog;' leaves
> the 'done:' label as the last thing in the function body, with no statement
> after it. C11 and C17 require a labeled-statement to be 'identifier ':'
> statement', where a closing brace is not a statement. Labels at the end of
> a compound statement were only legalized in C23 (N2508). The kernel builds
> with '-std=gnu11' (per the top-level Makefile), so GCC will reject this with
> 'error: label at end of compound statement' and Clang with 'error: expected
> statement' when using any currently supported minimum toolchain. Only GCC
> >= 11 silently accepts it (downgrading to a pedwarn that's off without
> -Wpedantic), which is why the breakage can hide on a modern build host.
> 
> The function has two 'goto done;' statements earlier (the sign-propagate
> path and the imm32 == 0 path), so the label cannot simply be dropped. Could
> the label be given a statement, such as 'done:\n\treturn;' or 'done:\n\t;',
> or could the two gotos be replaced with 'return;' and the label removed?

yea, I overlooked that, we can simple replace goto with return

jirka
