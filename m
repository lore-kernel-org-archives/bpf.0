Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574123;
	b=JRAKFLfj/kY3x/WAwFm6ZboZ7B8VYBG/+l9cIGbvRMGeBwJWT3y09YbKWLLfTaC2Snc4
	 O7LW8qv0ot0WWtF763iz0kjNg/I8ctAZhbYZvgy6SoIl0ijJ+Fe1YREUlInMXufmIpe3U
	 bIa9QFSir3uVO+VztPNu43IvXL/SV9v1/yK6BOLxEuhdEVD0LeqvXCkrkQKSFjn6YzIk3
	 ERbvZ7N3lT79gU+gKnS758nqSabrA0o5P+CSWKWexkA+ClivR2SR6FeSObAtvWEqFkKS3
	 aSmGEwdaKiZnY1uFLNsCMfG+NFPBER9qyMpmkD81jyVIX6lbd23wAyVEyIoizDiHZLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oinvwTnVk0HKWlZ+Khqz/c9/Lfzv7wAx/tcxNu+TnLY=;
	b=VQYFOGD2lCGwIwmzaJ7FqDNuKTbW1LDXfsm+PWkPI9HLRbMpdO6hrqucRifR1ZcPLs8Z
	 Re8Ug8kxFvOOnLuy0lCgIx/6XArZ1aRgVKr4EtfMA7b8EVg/Ai9T5YRkdS7dsCGFbmOf0
	 Fjw0vb7cf0yG5A63E4vYP6IMEJWPOuLNKrezGpL6OBPNMlwWuSper1D9zpbUeShMIVVAP
	 GsJewL6z6QWgL7mn6RekTmjsghYYJRPsTooFE9Zo0xKCpuarYVV3PuSOB144OczqUJYCK
	 RJAwDWqxlPs44m95DbFoMTzrgW1f0q94Zte1WKBIxHjcDCZ9aZBP9Io3y6JRZsLNPcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMNQuaFD;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F3606A32E
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD8F3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMNQuaFD
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so13188425e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 04:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794574121; x=1795178921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oinvwTnVk0HKWlZ+Khqz/c9/Lfzv7wAx/tcxNu+TnLY=;
        b=mMNQuaFDYqXNBxXRJJ3HFxcLfboah3kVPuToPqwcxZPSAjaxOzFrCwA4tnA2OpGKaP
         HGGO7Qnu2dSJMXIahKeTlzwxE423ToXSey5VPTQb97mB1f6QHbrjqO16krVO3t5wXn9I
         n0RUu9QTPHhdVb/2phA3pfKufAldI0ZgCDTG6eg6v3vPDdtGIjLfcsJKLT4APROCb1Rw
         LL190l6lLZX7RNAAz1K8PLZtqgNiDnkirWpivCk2G1vmqGzBXq2sgP1dDERzjzIFPQ6C
         41F1dsMdGWLwJfKmfvhyD7ORvIMOTg+pt3jXSaqq+V/EYFFE0cm+DhfJeuAXFvB2fQkU
         geFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574121; x=1795178921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oinvwTnVk0HKWlZ+Khqz/c9/Lfzv7wAx/tcxNu+TnLY=;
        b=NA0blKBcQYE6weQZc4tkPwv/T9cAK4q2tvBNJ1Ce4bOgRG2ppmOFss2TIE9BdoJlVD
         jsxBhiw7ZZuOVWHcSALS1bLHguE1nZuE+/+dbOlVncOjEhHytkOyeFor5Bwyr8KuIoVP
         Mbqm+9v4yRaxQltbE9R5wX8QemHg8Z0zzoPbW4Aj/DgQwWiT1DysuHCE7mpu45voqRaB
         ggG1KFjBrtROi+YseKlEx2ztI9ZUSHsITpxrp+YgmKwMUMFL1P+RGIl9qsT6lcKE6kew
         Twf9K2x83Ge+9in7UqfZKL6+gDbgR03vSla/j7KquSXl8pg3Neylqo0a92PICX1nM4LU
         CZnw==
X-Gm-Message-State: APuU4Z8b3cvE/FF2KP5rZUu2wbSXxuDDFTaL3dxp0YvI18gUlmBT1AUi
	nyMyBrn/x+D1A2mLWtp8z/Wsc/cUruAJFOIQTh50AHS+FnbiQ/S6B021
X-Gm-Gg: AYBFou2vzw7f+2StYl7GRvLN0rqfOKsN+hPy1MIFCaAftXZeyNg2eBvmWYDkw6RdhjT
	fE/P//9nKSspjlZHKJ7/6RDzvyx+YYZiNBzRvKDZ6rOHBCD77/+Y5Nb6PrpvL7nSjw9RkxH+vxm
	+Ds1wBphPd7Jge+bWaCdmUrizTEj5pWDUncN59lTcQkpXcJPwMglx/LVBY1Une9mEpTbXd0IHw7
	JajvGmTf211wzdPG6hbPGbHYDZ0y/OFFOBnitkiav3GdRrRkbb1FZlc0VqBls0hniL8bgcf7ox6
	anQ+MzEN0Eqk8pB7mXjnGE+rBOFFREmEr1slOFuKKaM3E87qbqu8LkCir9w7n6jM4RAq4/lJfzc
	bsUqa2nRAIkPsyXXgWmfYuOcfYnq5gD8JyDYoLaE9j77Kdh8OlyIzC+pfX/Gt+kchXamwURbdQx
	q2ereyfXb93aXWEOG+f1Wlp+8EEpGP6QdSf3mgBfofdjKFhcuo6v3IGfplICt5FIV2T8KktNhbp
	XESu+ziZqGVOkLbqyTKlBWpE3LB+nZzrfIySoQko2lJpg3iwzpI6iML3Z65aN+MTxodSHdYROv3
	MTzDZs20ws7m/FYpKAAG6/7vNnQT3GsnxZq0pQ==
X-Received: by 2002:a05:600c:8819:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4bb55a6ad4emr45735995e9.20.1794574121018;
        Fri, 13 Nov 2026 04:48:41 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb566220edsm80990195e9.0.2026.11.13.04.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:48:40 -0800 (PST)
Date: Fri, 13 Nov 2026 13:00:16 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH v2 bpf-next 00/13] bpf: fmod_ret for each function that
 returns errors
Message-ID: <avcJ4OWW99bwMlCP@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>

On 26/11/13 05:08AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> In short: with CONFIG_BPF_FMODRET_SCAN=y the build tags the functions that
> return errors, 12633 of them. A program with CAP_BPF and CAP_PERFMON can
> attach to one, skip a call and return one of its errors. It reads the
> arguments as untrusted pointers. No file of net, fs or mm changes. Test:
> one skipped call per function, 4401 functions of net, fs, mm. With this set
> 1 function in 180 then damages the kernel. A deny list by name can take
> those out.
> 
> 1. What for?
> BPF can keep user space away from a security bug in the rest of the kernel
> until the fixed kernel runs. An fmod_ret program attaches to a function on
> the way to the bug and fails the bad call:
>   SEC("fmod_ret/vfs_fallocate")    return len > MAX_LEN ? -EFBIG : 0;
>   err = vfs_fallocate(..) --> program
>                                returns 0      --> call it, err = its result
>                                returns -EFBIG --> skip it, err = -EFBIG
> Such a program needs targets in net, fs and mm. Today it has 1000 syscall
> entries, the security hooks and about 20 other functions. Of 417 fixes of
> one year that add a failing check to a function, the fixed function is a
> target: today 1 %, Anton's v3 (4) 17 %, this set 50 %.

The main reason for the difference is that my plugin was way more conservative
in "what is a clean path to error". However, given numbers, and how this is
supposed to be operated, more relaxed filter seems better. Authors of fmodret
programs are supposed to weight the consequences: forbid running a vulnerable
code vs. "leak resource", "lock one core", etc. Also, in many cases this should
be possible to fmodret upper the call stack, thus avoiding a problematic
attachment.

We can have a bit more targets via functions returning ERR_PTR(-errno), plus
maybe stuff like "if (err == -EINVAL) goto out", but maybe it was simpler
at IR (see 'bpf: Follow PHIs in bpf_scan_ir' in v3). All this is follow-ups.

For this series I don't see blockers, a few comments I had in individual patches.

One nit I've just remebered: why to tag functions which aren't attachable?
My old code stripped them out, they only take space and will be rejected
in any case.

I've also tested v2 on my x86.

> 2. What is a target?
> [...]
