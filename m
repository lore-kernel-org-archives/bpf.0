Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AF386C25
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080888; cv=pass; b=M3BTI0ie0n1n3obKGGtT5nkdu8/sHr1urIRdusArGPqMFd+TajcKY9bc1byKUQmfxj/kCTdYLRuIy+YKs+NFY4MU/LTk9bXdNvwDcDX1rDAjyFn3WAFHTJFdiX/l7QjkpULTCfqN7IsBk8eeAS4WW06/0XB7Sv4z62qT4vFvopk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080888; c=relaxed/simple;
	bh=Z6E0MXc38WsNUpI9/E+q7zdtFMGyY0/TRIM+ulMUnZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCE4oHzLM9l+0WVSX5NwFjd0F1gGViC5sfImEh1Z9iWM49l8/K5z2EagqBp7ASgm6nFcJXCCNeaCXPa4QmNANkpSWdegwIBNOgZ27jqnB1oMDXC19c8BfVSXY8VrACca1NefMnFGhjF6omUoNWKo1qGJTZakPe2Nz1u+tb5MI2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxptlgZF; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxptlgZF"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e61648f10so10331cf.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 22:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779080886; cv=none;
        d=google.com; s=arc-20240605;
        b=P+tywvtInYwKwiFOHWgbcBv3TVXgEdUR6PSgYVNBuyoUsLCq8nSyxHrMUcE6MSVkle
         Ya+9UfuaKGjxRCNT4YqI9AhVMKOlnp90aSc6qlMROFzKorJhtSeyAQlQHO2pmz1r7N/8
         i5HVRJSfNeurmrlv4rxOfHlxsJao+aq68zRM2Xupvr3MEua3acRyUCJ6i2TmrVBTT6u8
         uVMA4t+uNGEZtRuI1sYA3aX/LxaknodXjZtHIpuMvK4eW5ECBE7JYF5slcj7krSl8uMs
         a21Gmb7/I1Bcj95E7Po/mB3MjSv8rmxmeE61hKNj2LXQe+49CGQS2ii59gYX18f9+K6F
         lfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PgGO0nV6zeGKwarKeI0vOixvX+FJHU5rTim5V0Roj1s=;
        fh=Fg61oZSY3oqtIrpsVPTsd4YZk3Iqn/8DfySDlXSwRXw=;
        b=ieR1Ih+T/JCdOYLPTdsnNuPicGJ41TLz2u6uyKBBQy3J0hkZSxqMxof6uZomnN489E
         0J9gdXsDc/aGLHNcpQFFMxSJm3gzdzyi51iPXK2gegLqOOXove32w4YJ0EPler56zea1
         nB2H5fUmHsRASq7juWnq2j3txC3iqOWudzteyWU8lp0tJpSdEQ5/V72G3b0W56kk5bWm
         MKkcKX/0MsA297wyaqvbxXg0b0qFyeG2MTE1fYhTZW7UB1/wUHDoMSHRF/GmCn/xzOgo
         vtkDnbI7OAyWbfsay+1AN6xkjiG4udO6gl1Ged466sFnthNmthSLKL5D3hOIoTBnmIip
         ROpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080886; x=1779685686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgGO0nV6zeGKwarKeI0vOixvX+FJHU5rTim5V0Roj1s=;
        b=KxptlgZF3J2RjP2kA0+rshgJ//Y2dyhyaPxw9rVAq/wVX+Lhg38/L4WQ4iY/gvrpdx
         J+d38d1vidaLJPcaxvMbSJFjfvNEBtKYztVHn6TDMF4Ckg5ZroP0rdYtTnasZYkjbh9/
         3aKOk3QW+5LnnhHBez8GExoYXDnYd+2QTqgA5VYUQ8yZwexYjc1vNiFf2rlkrC/fN1wy
         +kgbafhdmOhHPniJdt4jFPuZPS4kZatJiAZRkangfgH4BBD+DvA/MmB23JTJqu+sAT2h
         oaDpUOCUii9sE7Arbc3bYmfJOKXMglm8Qkq3HzIZKtoGT03VKCHgYvwSyXm0SK0oINj1
         7GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080886; x=1779685686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PgGO0nV6zeGKwarKeI0vOixvX+FJHU5rTim5V0Roj1s=;
        b=r1NZm4VI7lIeeB9olKsLSbQ0FSKAzpUvqJeJe6y6Ld2QrL/vhtoT+Lf95hyIo9Iini
         iPvJgcXmMajCBko80suMr0XoEI/QqhLkLVWNQoYlXg4EAG9gcQ1sefkzjrheG/b0oc5/
         Td4j3P8UDuCI2qvR8RmJWPmA6SXVYgzszoqoOKjX+urACl/w7YoGl98OgObqXyVx9QaA
         +lWvr+fRMc3pDGkBAwoIq0WArfSNFGUAS0+u7GlGhgXczFqgdJ0DaS1Ssc171zsj64EO
         ObtXodu9RdZatZmbcqf1lKhAPd1OODvkguaRp/idXm3FCo65oEWUwIr7jcT4e0x6ex9z
         HTFg==
X-Forwarded-Encrypted: i=1; AFNElJ/wczLGUMjpj5jwA4fWHxLwZCPd7akqH5FEpONI4W7hR9eaGn8uBIGrwssbSMIwFB0otBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdVLLdB9wj3yjOYzkhnC/viRMKtD1rXzSGUa1dZ7ggFKMceGTb
	Gt03xvQlSMrDYe5a7KO1DX+psKsTe/vylFzamBHapATcuUte6QM2xfUgXoW6YHChg1WVB2ITwuc
	hUMx85/NgBGTIy0P5iO/JmHwQGtthUwLcous7DD06
X-Gm-Gg: Acq92OG1lFSKzMTnEyy/ZpQvf2VaKArlQOS02OUXQQCWhNNde/LXWHvE6m99RP2jBOW
	zaRPxLSKtIDSixvtr7qwZ1NbdjQVXGJemaqzu1SkuKsBYb+/WGoLz1A+ck/aimOJUhZXZUxlQ9l
	9G/Zzry4aR3q6jj6rZlpEVHCH0dWn9DAFckGePuVwwA0hzQweRJ0w/RbsnSVpvoEbA5HjvxwIUb
	bfOspVyMIkbMBzWCeiXHHxV7bkFdRZAQEvwehtqA1RepdJP5LB4byOrKlIUX3BnKCnQUKGsEGl0
	Uj00EgFtEzCmkmZKrzEVDnkQr6MGeL6NCh8NqMUtOrFiVpQcSpC1p4P33ypn
X-Received: by 2002:a05:622a:5d4:b0:516:4f62:85eb with SMTP id
 d75a77b69052e-51679462c6emr13074271cf.22.1779080885212; Sun, 17 May 2026
 22:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-1-yuyanghuang@google.com> <CAADnVQ+Mc81ciE+6i4Mvg5h=fRNq6460w0-NAw_bU12oaBWruQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Mc81ciE+6i4Mvg5h=fRNq6460w0-NAw_bU12oaBWruQ@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Mon, 18 May 2026 14:07:29 +0900
X-Gm-Features: AVHnY4Id0O4-8DzVSPeGl5IFxiRysVVNPFTf9XpoWx4UkzENJhMEoOAWU_Sb_Xw
Message-ID: <CADXeF1FvFrT4i_=3Z4USRV5XnOzhk92M7ahvcs6LyA9j_tWU9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Align syscall writeback behavior with
 user-declared size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>The whole thing sounds like a user space bug.

Could you please clarify why you consider this a userspace bug?

From our perspective, this is a binary backward compatibility issue.
An older binary compiled against older UAPI headers has no way of
knowing about newer fields. If it passes size =3D 40 (the correct size
at the time), the kernel violates the ABI contract by writing beyond
that declared size.

> Please demonstrate a case where this issue is seen by using libbpf APIs.

Our old project does not use libbpf; we interface directly with the
raw BPF syscall.

For example, our Android net_test  suite uses this legacy 40-byte
Python ctypes struct layout:

  # legacy 40-byte layout (pre-revision field)
  BpfAttrProgQuery =3D cstruct.Struct(
    "bpf_attr_prog_query", "=3DIIIIQI4xQ",
    "target_fd attach_type query_flags attach_flags prog_ids_ptr
prog_cnt prog_attach_flags"
  )
  # Invoked via: syscall(__NR_bpf, BPF_PROG_QUERY, &attr, 40)

As shown in the original discussion thread, without this fix, a newer
kernel unconditionally writes the optional revision field at offset
56. Since copy_to_user doesn't fault on adjacent mapped memory, this
silently corrupts 8 bytes of the caller's heap (corrupting the Python
interpreter).

This size-gating pattern in this patch should be identical to the
pattern introduced by commit 47a71c1f9af0 in btf.c.

I am not 100% sure but, it seems running a binary statically linked
with an older libbpf version (or directly using raw BPF syscalls)
might face a similar issue? Do we expect those binaries to be broken
in the newer kernel version?


On Mon, May 18, 2026 at 12:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 15, 2026 at 12:15=E2=80=AFAM Yuyang Huang <yuyanghuang@google=
.com> wrote:
> >
> > The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input, bu=
t
> > several commands write outputs back to userspace unconditionally. If th=
e
> > caller passes a short buffer, this can lead to out-of-bounds writes,
> > potentially overwriting adjacent userspace memory.
>
> The whole thing sounds like a user space bug.
> Please demonstrate a case where this issue is seen
> by using libbpf APIs.
