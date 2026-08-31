Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD843B42EB;
	Mon, 31 Aug 2026 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169133; cv=none; b=lZtsevxk9gRxvODpaOXD1BCc54h0eqiZVAslkvvb/d5tY27Fu7nil6V3DIx+E7viGGpb8pDRy+OAeA3IhtjniAcGLAyeZ6ceNKGjiwKi9lYANomN6XaT/ra3J1dZ7rcsWt/6I+E+XdXrcK6nvZTd6HfwUjL8zP+2jVAuoYPcP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169133; c=relaxed/simple;
	bh=wAa3IvOHsnHEgsWCDikMyBbhcgdh4M6ot9GIHvpGZek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CG2Tl3tHJrsnAV2OuSlsEsJwKzdz6sGHv7d9zeVv2vnIUCV5aMw5oyuM9KU8bazffl87SjBsGCh4wzTUQX9LA++K6h8lmzxhsuiFmW+kLPC0+rF4HyG/mKytVrYEI01F8QLrOExQr2buxsmR+ycf+v8GoKH2M92DWAhjDazwPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNKhtE8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNKhtE8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9D51F000E9;
	Mon, 31 Aug 2026 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169132;
	bh=OFphn4x5PlgB7JyIPyj4yiTxpOVVPS0uVDVsQpDG1dA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNKhtE8WTrPsNR93RD/6l1dQsjANrp4xjKj94jWCH2UDU090XiMy/rta2H5x9TGyX
	 L4XR9nMR8WtPrzXF0NNbjn+7+yEwttk2/mS5jiDOWOOZMdRUAAQdpS5a+sWgdQQh+0
	 k1W09TSFdSsR665bORSFQMCqtU01v219psQDxW1eiAJ6wlDYqcI8YafQ0GsN+IB4Hi
	 UCC7nN5rmaRbTfRNxr16dzSZi2NtKzT0HrPV+dM9r3Q/KgEoW9CrWgNZoLc5SrjyP2
	 Rqc1AMJ0QeQUcdfZg/7VgDnx6CgvnAvk80CVIIHImT3UyYGAqDZybMIX9+As74Pbr9
	 GAQL+thzFEOnQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 15/20] tools/rv: Copy stripped bpf_atomic.h from
 libarena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260831090524.106845-16-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-16-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:38:51 +0000
Message-Id: <20260831093851.BC9D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `smp_mb()` macro performs an atomic read-modify-write on an =
uninitialized local stack variable `__val`, which will be rejected by the B=
PF verifier on non-x86 architectures, breaking the tool completely.
--

commit 8906134488c74fb8663c6c7d837a2ee2c7d3ebb4
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Copy stripped bpf_atomic.h from libarena

This commit adds bpf_atomic.h to tools/verification/rv/bpf_monitors,
providing atomic read/write macros like READ_ONCE() and try_cmpxchg(). It
is a stripped down copy of the version currently present in
selftests/bpf/libarena.

> diff --git a/tools/verification/rv/bpf_monitors/bpf_atomic.h b/tools/veri=
fication/rv/bpf_monitors/bpf_atomic.h
> new file mode 100644
> index 0000000000000..f834ea91c9d34
> --- /dev/null
> +++ b/tools/verification/rv/bpf_monitors/bpf_atomic.h
> @@ -0,0 +1,105 @@

[ ... ]

> +#define smp_mb()                                 \
> +	({                                       \
> +		volatile unsigned long __val;    \
> +		__sync_fetch_and_add(&__val, 0); \
> +	})

[Severity: Medium]
Will this macro cause the BPF verifier to reject the program on non-x86
architectures?

Because __val is an uninitialized local stack variable, the
__sync_fetch_and_add() instruction performs a read-modify-write on
uninitialized memory. The BPF verifier strictly enforces that memory read
by atomic instructions is initialized.

Since the variable evaluates as STACK_INVALID, the verifier will block the
monitor program with an invalid read from stack error. Should __val be
initialized to zero before the atomic fetch-and-add?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D15
