Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438628;
	b=3DnHAoF4lEUrWhmK2AWTeoQhWLC8Kv2gq7SSPxyy/0U+z/qKkDld8abDlSuHt3cSE7ya
	 EUoEjfk3fIwVbkh3mvGFAKn5SdCojXc4uvuNTY4Bw/XYeILMzIAycaCw5q6jCyyZBSQHN
	 tSKEjNZAOg8U2zgCEuSvsZ1BWXAFVWut13HpTt25sKqqkW86Gtq6BFr5s9SaUVFmMZ/P5
	 II8T6cXQQszog73Cgi/uubi/4JD4Q0E7yCL6jKYUhleh0Ir3UTCxUXfXsHIzhXdyDfymo
	 LrrXGF7Id66v9+TFkr0YZ08bDzvzigtasS81vEiOTtu5KrFGLQYl4/hcQbh/dscqWmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CozIl/nMLzShLCc13DpVZQu/fWHZTEKCUOFKOb0MjSA=;
	b=5DMDWBDoHHS/l3S64i/1wth8YPlMfhb2K3GumBUnQoV0UVm7w+Mob3vZsiwqtOdQnY9f
	 zz/jFGueCvFnbRPyrNCImyJuKaHgnBnU6Gj3iMru6cPiqG1Zv2T9NyQmFPfLKs6nswtkK
	 EunBERzFsweYj1xG5rVQxnCSZCslKZ6jxPcqkgGp/12vcGPeBvhwRo8gNaqDOJZGflzHc
	 pP9IAp+FoJiPzA5pjprLX/DeDnd0JV8E74Dcr773QeZIcHLcnB8vUiq+TsD4+qqGLuiBc
	 TeDO1UTCrKAvlKjQPkyzKUD4QMGvcPLXRHBVAlvLq7maP5HT8aaJGJTjm3Iv+QiN3TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O87i8GVc;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E827606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E827606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O87i8GVc
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so2711489f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438627; x=1796043427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CozIl/nMLzShLCc13DpVZQu/fWHZTEKCUOFKOb0MjSA=;
        b=O87i8GVcp2rY4oL5wP+87gFKFjwahk7pR4foZm6HCuDUGX5vA2H5zrUbu6AbGWrcwE
         V57Y1P06JQjuEXHTs4gwPjZronptVBRKQADW9co9FpImSZtsjvKFvaYHaA7xZ+ZA0ZrG
         EZDTEHiRBqh3xR7/8cd4HmcxDIOSmJzYo0qcuxsp8gBebJU7V00FLXxa05zgXyiOE0UD
         CMxfTUdry0bbXaGFr+Lkw2XSbI1fsbR0ZbuCrw/UPVX5uNIG+qjEGTJ2eEOdBduxC/CW
         aBr6T/phVOyB6W9uljyqyMIMpPOO1VAmBAQBpJ5c8t3ZLPMTU/j0uacJW3Eqa+XnIRiQ
         K3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438627; x=1796043427;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CozIl/nMLzShLCc13DpVZQu/fWHZTEKCUOFKOb0MjSA=;
        b=PiVzHeJUaA0g5Mu6GZbNAZCmL3k8CkbGMTRV9bwKVx5km24vz6xWeunds6sE3b1VIj
         3AumGZF/MUbV+50gf2paelJvnPeCSL6T4P/sRA57QTbS1k4QLbaxhUtFOPR4Y9CpxoT2
         CsHNnBgsJBdWAUOS7T9Um7vl7HOeMD7q+TXnhRZQXLxulQeS0VngBSKnVfIhNbqt12Rx
         vwrGHSyGCAmZxry4Gkhoi9LrbQ7XnQbzV9i4J1KqPHsUix+SrWaJxebazWinhtyJNyES
         Lxno+j0/7byNO5+m6iD/L2+SriGxbYSH9c2JG1JTMJbMY+xSdWto79GogbVDVCS7ilb7
         yarw==
X-Forwarded-Encrypted: i=1; AL+hErFokpkioE87hIg/IKFvhSaKRJjjhol1YgfPcvL9Mi1fVa1cix7L5cM5cFJWHBSWLExNZis=@vger.kernel.org
X-Gm-Message-State: APuU4Z+brM7GDch05PwPofOmrG4FaXM0Ry86rbF2EK8G4Ot/k1VaK+PB
	X0kExMjJLBq0AOwfZUB1jBoqXVcuKzGynwPFFQPfIh9Vvd3LqJ1Rn6Kh
X-Gm-Gg: AZFdTZf2W+d0HcAOI50qDX1/Qdb1WGic/T9ztFwsL429kmpF4a+oYhvnLtOu4SwBq3I
	PwkZ3UwQHymwPQDEr52UmRp7nKML0S9xDiX0wHe0G90a2LljlQFEEze3yZpyPUXFs2v1o3+SRBY
	T7oKz65jHZ+ngY2hLrsxn+ysepwveCn08yhdC/HgmXaw6m0piFwpib0aaw+OILZXadjMPMvuRQy
	N8mTET9P3bgbdP+rWTcIK34SGAB/NUkVa5WIytVjmBTtWdfb2Iirz0FwD9TnSMCLTQ9oVoLO1Se
	rdOpfrIwpPFQt/gccHutS/9+F7ZbCGawgGn6CB7o9V5v0AH5+U/bJQd32VT2Wbjvfha0n51Aa5f
	70bwC5bxKDhrpbVoOTV+Bo9QVtFARDeiia6FOsdhjm2wpyZRoLENIph+xUPmV+pVWXtQjE0LRS3
	lTungu5mipsPIasechhEK4l36OpbgFZTdBHVBO+lKDWrHogGaJHM/dJhcHyOAH/b99Q3l47gY/Z
	OJfdF2XAzVg5JraimYRhUSy41FQuqMxb08/ISip79WolvjcI2+GeUhJ/sW3PX7e5MP4YY0de5ln
	UefRJJAXK6yIS6TorSLaBDOZtxeQ6UdZwS/Bkw==
X-Received: by 2002:a05:6000:4617:b0:48d:f464:6989 with SMTP id ffacd0b85a97d-4abb18cbe2cmr22485211f8f.27.1795438626537;
        Mon, 23 Nov 2026 04:57:06 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb41f4sm21305484f8f.7.2026.11.23.04.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:57:06 -0800 (PST)
Date: Mon, 23 Nov 2026 13:08:51 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, lsm: Make bpf_lsm_get_retval_range()
 return void
Message-ID: <awQ642Ko94a255rT@mail.gmail.com>
References: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev>
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
In-Reply-To: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev>

On 26/11/20 04:28AM, Jose Fernandez (Anthropic) wrote:
> With CONFIG_BPF_FMODRET_SCAN=y, fmod_ret programs can attach to tagged
> functions, so a program on bpf_lsm_get_retval_range() can make it fail
> for an LSM hook that returns a value. get_func_retval_range() then
> reports no range, and do_refine_retval_range() and check_helper_call()
> ignore the error and use a range the call did not set.
> 
> The function fails only for a void hook, which every caller but
> get_func_retval_range() already rules out. Check for a void hook there
> and make the function return void, so resolve_btfids no longer tags
> it and no fmod_ret program can attach to it.
> 
> Fixes: bc45414d1690 ("bpf: Allow fmod_ret on tagged functions and check the return value")
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

The change looks ok, makes sense for this function.

I am not sure if the topic should be 'bpf, lsm',
I see no lsm part here. Otherwise,

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

> ...
