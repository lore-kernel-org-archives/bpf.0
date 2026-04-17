Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885B28F5
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442578; cv=pass; b=Gdv8ohFGX3HY/VkeuQiokVf/f2qCId+aqH/jqVTMYqJOoF4mDTKbuVzzWgQizyqTWvTg0WZwoRRyQUHuKTWX1zNtcBXdlaY3KjsKK4x9NZXyB0zjxolNpDlWUAklvr12FccJO0X/QN2GS8pNqYgmCXXKeKuUtcPTJ6+nozRi0lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442578; c=relaxed/simple;
	bh=/S1MX7hFWCG2HZ/Kc58Ecr24eV3/pqqnMT2NVXyKF04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhbDEVG9aL1K2mXzTySuZF9rT3P9iK2Ttx2bHHZzZf+xZD/WlbfP5PQmwxka42iuTWr7IQDbC9ZnwJUitMghx0gqgnSr137ka+vgD8CBDxEyJyAgqtqfD+R6F36L/3KEIlsVbOOy6rFcjFMxeeS4Udwq7PYCzVsBZFNbOCVlhhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr50m12J; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr50m12J"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-671c24f23b1so1286134a12.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776442572; cv=none;
        d=google.com; s=arc-20240605;
        b=hDgtNZv20+LlhB+QJQdK+b8xVUhiHrkEMwb2y6PrrnuvIMzN0QvniFG/80Qt7e5sb4
         d9/jUnoRv4iZoXFJ3xqDsWlP1F2PmRES0E+l3ZX2XmIJ/r5T2dcP/6DW2CsI9HxVRydq
         21KK8QowUOJ+K8xzg5i32Dqqz9/td9GCkImwIo4/4i/vjZB/kFtRGMamw0l+aVXNIMF/
         bnReSRZx22fjccB9vuMawfJ+GufCO6FJMRHk8Fekg9KfCu7nwvqdXzrfyR043pUeEIje
         PW+z4H7xYsw9tfmj4P76Y5FrBt05S84RuI0nrbJLpDHz5bi3wNPXD/kqT0H8ffI/GbBy
         9erg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rg0oN2epaXQKUu/xYYA2kKCLuyd4Q+xRX1V2ixVtkTw=;
        fh=g6NxLgah9KBfQn0+Sgi4wV/6IeF3eYh+8x6TXbw5ntc=;
        b=MVc1X3L0uM9A/h6Li20KIdBPQFZS+KHFZjgiMY2NxsiBkU6uCQXfs3REqJeEpPM+Nn
         x1iPltXwrllg5g4gP9tmlRtNLZ+rsiPYdaQj5P9CobPsiWg/qEx9KwoL8KyrAlMjiE74
         72w/+4qEixNzLTkzoSFHnuuvNufxkQ6B5cfAdIXPXoRvcZ6DBYAjZ7p/GVvcMjPDL2QU
         Zfr9dMeJqMaAwMBQCOaWlaJO9nbtw8hZx7BFKgb71s4xfIqE8h6EjCMddemL6/b8kJSD
         nOLHwHAWHlHI1bJbJSx4X2mRA7GRjmgnm9mq8vlNdTIMUW+5DWMNlechY5BWMTv+kzrG
         Jcfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776442572; x=1777047372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg0oN2epaXQKUu/xYYA2kKCLuyd4Q+xRX1V2ixVtkTw=;
        b=Jr50m12JSIZ2donZWkc7Tl+pEwphGpDD/9A2ncGmTK5tE7HYbpTNz8HBP8VcaYI90D
         aGJ0tqpyJIPlkt+slI1H5VSa3fQlWjibA6MtINlrjz9smbTgMUaVz4cD53mC5bYF6kh3
         v/EO+VXSc2vxtPtXkGdKNACQIyLOi4ruGlfyHEQJhAAHjFdT5dH+p4+Nq5T3l7RLNqmZ
         hJxUNkGJIyTo6xyg+iwdiJRVAUmBaeA2eQ6CLepwoWYmbBo8b46MikvrcilU3OCiz+S2
         epSX8dqQt2h15gMIfW3vOmRrof8Dzjf5zSzjq9DdTaX6ad9veeX5f1rO1SrwBAYEiGS2
         6xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442572; x=1777047372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rg0oN2epaXQKUu/xYYA2kKCLuyd4Q+xRX1V2ixVtkTw=;
        b=WtyrEHVoZ3Zif+KSzujO6tubia2krhrzBQp+o1Q9yLdImcWcWSVzR7qAZcrj3ZrUyB
         4tCh2b/2oH9rbJo/JIwuhXCvV16QLOVm/CgbEkFjjHRr5Er9mupGAhfKVq8W3uKSREHo
         /6KmXraAm6GBoBuly0JDe8rVyTooRSGXeEOGWiJjkwx7DHZwW2qNfGZmZUksZD3y1hJT
         USahaEoOV0Bw9BExiqH1hI5FhoAJQ1YiLsCl8gHFbQFD4/8HQ+gXAeje4OudON/x+k3s
         l0Pdg/0t64IlfafupfFaqKgNpHSrZD4+XTuEM3t2xnh0Gm03jxPbJqJVIozBWaCmJT4j
         mUVg==
X-Gm-Message-State: AOJu0Yz2WL6SyS9VQ7j7KeGjVl8fuqMfZSIqNmA76rSiKjBmYjFI60uG
	bdYqyiLGgvgm5e2Q3cLMIPMCAG4QRoL8QfFtcJfGoov4nRyZCbWicgC23eyaecRyO5T9/tvIITT
	q30ENI+cltMQ/Bu/Sjr+xu08w0oJeZ3Q=
X-Gm-Gg: AeBDievxYc0w2eKEU7JdzVj4q/WE7C/o5YopOyKNE6hqcPwcTcRm/tRIwcpyjpq4szg
	dNkdRsC9bnb5Ait8vnQXTkSkzG8gYpsY+5e6Dxat+YkgHBn2dssHVYlP9sw5e96zLOpxqR1u4LK
	LV6eTMmK1ZXrbFnngrRVq4YBq39NUjF9koMvPEyFByMrrxpGNQBeuLVUZ2Dj63G18A/9TAf5o3s
	aLsUTYZOkjyriBCvI6vr4O1nOObopEPKsPp9cQ2hdZnu/EKGagKsAINkifRDyTHXPg48su0NfGl
	5hGuSy4NQtDbQJmarRApwNgAoF9otaT0qQ==
X-Received: by 2002:a05:6402:e9a:b0:66e:5662:2121 with SMTP id
 4fb4d7f45d1cf-672bfd97db0mr1561945a12.7.1776442571826; Fri, 17 Apr 2026
 09:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417143353.838911-1-puranjay@kernel.org> <DHVJQQK6L83L.13DDK8BJXQFXG@etsalapatis.com>
In-Reply-To: <DHVJQQK6L83L.13DDK8BJXQFXG@etsalapatis.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Apr 2026 17:15:58 +0100
X-Gm-Features: AQROBzBjCH6yI4luRGFxAmDN4mPMah_9N3qt_y4EIPs50-Y3lY9b84xdqDfp8KM
Message-ID: <CANk7y0iuchsy56KFAjhKMghH4M5D7d57o3b4anNHTmD_am79WA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] arm32, bpf: Reject BPF-to-BPF calls and
 callbacks in the JIT
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Jonas Rebmann <jre@pengutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 4:48=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Fri Apr 17, 2026 at 10:33 AM EDT, Puranjay Mohan wrote:
> > The ARM32 BPF JIT does not support BPF-to-BPF function calls
> > (BPF_PSEUDO_CALL) or callbacks (BPF_PSEUDO_FUNC), but it does
> > not reject them either.
> >
> > When a program with subprograms is loaded (e.g. libxdp's XDP
> > dispatcher uses __noinline__ subprograms, or any program using
> > callbacks like bpf_loop or bpf_for_each_map_elem), the verifier
> > invokes bpf_jit_subprogs() which calls bpf_int_jit_compile()
> > for each subprogram.
> >
> > For BPF_PSEUDO_CALL, since ARM32 does not reject it, the JIT
> > silently emits code using the wrong address computation:
> >
> >     func =3D __bpf_call_base + imm
> >
> > where imm is a pc-relative subprogram offset, producing a bogus
> > function pointer.
> >
> > For BPF_PSEUDO_FUNC, the ldimm64 handler ignores src_reg and
> > loads the immediate as a normal 64-bit value without error.
> >
> > In both cases, build_body() reports success and a JIT image is
> > allocated. ARM32 lacks the jit_data/extra_pass mechanism needed
> > for the second JIT pass in bpf_jit_subprogs(). On the second
> > pass, bpf_int_jit_compile() performs a full fresh compilation,
> > allocating a new JIT binary and overwriting prog->bpf_func. The
> > first allocation is never freed. bpf_jit_subprogs() then detects
> > the function pointer changed and aborts with -ENOTSUPP, but the
> > original JIT binary has already been leaked. Each program
> > load/unload cycle leaks one JIT binary allocation, as reported
> > by kmemleak:
> >
> >     unreferenced object 0xbf0a1000 (size 4096):
> >       backtrace:
> >         bpf_jit_binary_alloc+0x64/0xfc
> >         bpf_int_jit_compile+0x14c/0x348
> >         bpf_jit_subprogs+0x4fc/0xa60
> >
> > Fix this by rejecting both BPF_PSEUDO_CALL in the BPF_CALL
> > handler and BPF_PSEUDO_FUNC in the BPF_LD_IMM64 handler, falling
> > through to the existing 'notyet' path. This causes build_body()
> > to fail before any JIT binary is allocated, so
> > bpf_int_jit_compile() returns the original program unjitted.
> > bpf_jit_subprogs() then sees !prog->jited and cleanly falls
> > back to the interpreter with no leak.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> The Fixes tag is a bit unrelated since it's for x64 but the original
> commit that adds the file (ddecdfcea0ae8 ?) is so far back it probably
> doesn't matter.

That fixes tag commit has verifier changes too:

-- 8< --

+               }
+       }
+       for (i =3D 0; i <=3D env->subprog_cnt; i++) {
+               old_bpf_func =3D func[i]->bpf_func;
+               tmp =3D bpf_int_jit_compile(func[i]);
+               if (tmp !=3D func[i] || func[i]->bpf_func !=3D old_bpf_func=
) {
+                       verbose(env, "JIT doesn't support bpf-to-bpf calls\=
n");
+                       err =3D -EFAULT;
+                       goto out_free;
+               }
+               cond_resched();
+       }
+

-- >8 --


This call to bpf_int_jit_compile() is where the memory leak was
introduced, before this commit, there was no memory leak.
