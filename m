Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE7401A2E
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566320; cv=none; b=SoZRZPcaOk/kXOaXzEqFWKGuAbZoFPx4SHYpsKp8HkAXTiAxfGXbC9eMLmWlxOxukp7ZfcR4WExzeoi9NvTAWV2GWyu0ZJmV4ceFLRVMpbhxOXHQJzUgH0sNFeQ4dSj0CIkAvtyg8qdF+MErZuUli8bDPibdFQS+el7I2pgr1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566320; c=relaxed/simple;
	bh=Qfj1VzO8VilQP3tSYCf68+ld4mpz1ee2xOxvMHOwFHw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kShacAlBUd18oscsYtppsjgaigO02J1jJxWkNV7IcRSJJI+46li6XnzwSdB+TBtgoA1stZEqLq5CqpHaZgGnSHEl//aqPlUNDWWLlDQDb9KTy6SEBGOiJ2JGIhPbh9m/cjnyAG3ZXLNEW7O2jHCIXiLDiWyZj5mvmkUyUo8uskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ9a2RzS; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ9a2RzS"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b1b766bf01so851852eaf.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566317; x=1789171117; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ccOCDWIkCpy2i1PlX07Jf62/1wwrww9fzlMZ7/BsuZw=;
        b=KJ9a2RzSkY+vLnloyQwwbhM57D8/WGm2+rN+G18PXyyJM3DaQ0PsY8OMKaqPJdfWax
         TYq+AQNFmVtKchr0ImW05HcZ35B7PF3vuklupuru2hVbWhP5bcqyZ4bRbEm+uCxSz2kQ
         qVSiQcckrDJgn+lYeZCwefHj9hfCaop/VrzIrjy9MzPUUel40R7I2FAZjdw5JRmno2Ll
         IhkCRZKwec4kMgmfKFRwZmQv1Cn5DVyvnoF6u0wrm3zTqZ4gyEdayLpmEU7MvXQ8frsN
         UkAZ3EkzurfSskMz/xsv8p1w9GbvzGYuUfSQlmJMS+RfF6P0BYoJZMFcXxYscmIoSM/s
         uwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566317; x=1789171117;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ccOCDWIkCpy2i1PlX07Jf62/1wwrww9fzlMZ7/BsuZw=;
        b=cjefHnQdOg7GkGbJzjlhiNnYVVz4bRuqoor21Bo11iiWfHKke+vQiCjxCWfUQ67cgU
         TlCzU5w+aGe4J5cl/mcuTRDcYduijBqzmgYGZ63QZWMiNDbtma7eEh0Vmv21WKjENXGC
         uK7EvIC3zGQnJin4NT30m7y/vqIBLH8dvRR8Rz0kx4Au5kjcw+TBFk8JPvzrKQbp0dd2
         gf1Q3eyBVD+W4dUpMUqG8BAMGzkxpG2rVt0Pytm6o3oUQB6xCYjsxJPF53qc05CikAJM
         BHEMGg7x5thizGE5iM73RdlvDP2hfAppbHcGTH1A8/3oiUxVpNxvUiViLiBhLrG2gmI+
         JH4A==
X-Forwarded-Encrypted: i=1; AKwUvBx3xINl5bUT1dLycrgxXTRXN3EP5Rh4D9vEDXV0apEj5EKKIbmIau1ioBWLt83/tHAow2A=@vger.kernel.org
X-Gm-Message-State: AFuF++k1mA20Qc51Uiw8Ipx1/zVG57YHV1dM9Ub/CXa79UgE4pwiPsIN
	kBu2LutdcXOUIRySFgZ/uMXtGHRueNvDBHOgXu1i931Z1urTxluJ4Nz7
X-Gm-Gg: AYBFou3IMzx2X73b637zShG3C3EorEGfJ/ip9dKk5ntAFCiKmL7ApHjYU9YotzshHhy
	+nyEZnKn8SMnyrAXoFOAYIr8osd0Bgfv0nVie4tMeJgXs09xtevvMleVj7Wvl9Tbwcsszb1enJs
	cHHlEJWO17elWokUiDe9VRRr26dhOvr01UV++HSXnREKVC8jWLTgvNzqwBXeUor/2/aM662kvjR
	7kTooMq/ewMXy/t8TEtGz479eTbGzKl2A2gXeMn/CdCE3etivGMcl0JMHyGIrvOMYFB/mAsnbKN
	AD9MEUne1XE7r+EPQ8hRRcTwLS1/6KlFR9M7k3+kVB0Z/ZtvPIY6dvmB7IXkQDrPRSF1u10Hf8f
	NAgqaPfECzwada4o0070oLYVaFUMgp3CXqD8xSac7SaxijpgbTDn76OqNKiQURja7iIV/G2TZPF
	gsZufs/bGyRZ/qr5OEUdi65rPbo4j2XfKTFAZZFv+o9YRHd9lXaJEU4clos9awIAxVkLa/7YR6G
	sj119DIBmZwdKjy8hrAq4kwxnMb1e111CWSuXctay+e6PLIxapHPhM=
X-Received: by 2002:a05:6820:80f:b0:6b1:4250:6a43 with SMTP id 006d021491bc7-6b6fd2ce67fmr6721953eaf.17.1788566317356;
        Fri, 04 Sep 2026 16:58:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:13::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dcb85a61sm5122781eaf.8.2026.09.04.16.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 16:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 16:58:36 -0700
Message-Id: <DL6XUEHAJN3Z.20UKZKTLHI2XZ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 07/12] bpf, x86: Place kfunc arguments per the
 SysV calling convention
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev>
In-Reply-To: <20260904051033.3979978-1-yonghong.song@linux.dev>

On Thu Sep 3, 2026 at 10:10 PM PDT, Yonghong Song wrote:
> The JIT hands each eightbyte the BPF calling convention passes an
> argument in to the argument position of the same number, registers first,
> so the two conventions agree unless the kernel one places an argument
> somewhere else. Compute where SysV wants each eightbyte, and move the
> ones that differ before the call.
>
> SysV disagrees over an argument that the registers left cannot hold: it
> moves the whole of it to the stack and leaves the registers to the
> arguments that follow, while the BPF convention splits it and keeps
> filling slots in order. So for
>
>   u64 f(u64 a, u64 b, u64 c, u64 d, u64 e, struct pair s);
>
> the BPF convention puts s in the last argument register and the first
> stack slot, while SysV puts it wholly on the stack. Add an argument after
> s and it takes the register s vacated, which makes the moves a cycle, so
> one value at a time waits in RAX, dead before a call.
>
> The outgoing argument area is sized for both conventions, as SysV can put
> on the stack an argument the BPF slots kept in a register, and
> bpf_jit_supports_kfunc_arg_slot() can now answer yes to any placement.

What is SysV ? This change is about x86-64 ABI.
How come BPF calling convention diverged from x86-64?
Maybe we should adjust bpf side instead.
Looks like next patch is doing the same shift/move dance for arm64
which is a sign that we got it wrong on bpf side.
It needs to match x86/arm64.

pw-bot: cr
