Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87A2253FC
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538169; cv=none; b=ec58G2BYFpWD+yWF/Fz68ovxQ2ZUkzTR2FzoSiB/hU2m3XGCps2+1QW2FTLOfo+KORYauBNHsxH4BYAXsdV67tM28QHeaTvlAusEroBj9iXZwnTu3lyBaC8FtGI+83DdwW03Vz+1I1SoXskKR3u0djnJW65Ezl4+FEbu4QgGRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538169; c=relaxed/simple;
	bh=JN9Wo9Nm+A505/B5A8UegDIzE6n1kXxbD4fQzt9sr9U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XUgUV6dts8BVADOXfeyIN7DX/tOpfQWQj2DfuBbak/rqNeagHWTn+LkYB5ga9sc9jO5aoWJE0ilmL5OfYymFlpzyIuNH4nqn3bBDjcQ8Xu2l2xEQTqlHrLYhw48nB3T1NjvQZZbmAmDuQBlLJiSJg3jYRsd6tA1bgjXPHIc3SA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSAQo0lG; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSAQo0lG"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso332258b3a.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538167; x=1790142967; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JN9Wo9Nm+A505/B5A8UegDIzE6n1kXxbD4fQzt9sr9U=;
        b=TSAQo0lG14qlzSQ8nTzArg6aEVsrMKtNncYdiuI8oQ79RLMeF7QJyEujTZ6eB3omCE
         h10xBbS5pXFD2h5k2+genWZKBzMLlP6UPSJwRnbZGvH10HnNpxbFSQaUhPI6TdMRHFUu
         aCv5aW1UMteHulTLnyYN4tqeKmJ2fjgU4HsHc9ayXr9W7YULCJ4cT+EYYiDXlkKzeLoZ
         dImpOVYswwXdGafXlzAZa/eHY73NXhc75+RtuJPdRopcNmN/l74Z05GejHM/C6s2rSZi
         E6z+XbaDJd/H4+w/zTMzrtOj15x07wEIyt1BD5VizRmWB62NuhbJvozQgTJR9hiVPkTf
         aTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538167; x=1790142967;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JN9Wo9Nm+A505/B5A8UegDIzE6n1kXxbD4fQzt9sr9U=;
        b=YZiq183/6GkDIgG7IR/cedwErlY+D13yb1OgD45wynoSKOBs6Mqdqx1rXnVhwgWY1t
         BFVkCdvazoEPws3mOxaVhS5Vm7EPc81umxPMPyGHw8zXMxdai94NDlf0NazzK37znhaY
         d0qFgyZxJjS4gE1kP5jIHgO9HQKmw9j/zsx1+k+cvF1UZYlGi9vx4Yqw1dIH2kPyDFym
         xEQxExQ9OkM+3dUaBMeSf2hQZ8FEtNJluuGlzJ9gpIUnK5o0aLRiY4xXd4urdrXfgXA+
         zzQJVFRu8lTcVuhKcIGwuodDm2FbW47ntzUguYBgeGvyKDPfzGVPEnf6ggJLI+HSL1/P
         vO0A==
X-Forwarded-Encrypted: i=1; AKwUvBxKyNhVib5WFyWjXVBXAq/E9Y5SKiOBjb+O+5wzjKNx114ZgIZgXldogSyB7VIBhKfG4TE=@vger.kernel.org
X-Gm-Message-State: AFuF++kebjLQRK80cTYMhf8cJ1afDd5gXWS5D9VQKtPDmt576suGsDp+
	A5AeQK0KXXK/0y4p3Tutqr0UUdcDoZ6orIqyLQPzHb4sLqiwiMIWfut3
X-Gm-Gg: AYBFou34hsQJJl9mhc3fIq1P1lgnATi33yhcRW4YrXeCwLDA/1ynqbV40I3f6AA7JtC
	tOC64IACInG/cbpxatenMTJkx/3/PnnccCm9JH7YZvNRMVtOkRSg6GO/UzhEgkZ9j/g2Pan6pEg
	13z9v/gHS7L3dEI8a9fkvUZRS9VViWW/j8yHLjXQwLbEAPY0zrDmhKW9EkOTokojn9g15k6we8R
	qgB90ozeBPwcSxbc3E6nAWR8ycamzyb6DSI+YdrlAl4rp9vsWos9MRmVrToHYdKy2VYfzyqTVwc
	wHUyFItf65uOJniSSrZzeYe2mOMkiB6BmVnx5nviZaQ750aJD3TXaISc9Mn1EdoDoK8FuRIYao9
	Vw/vD1Boe6NgR+qqxFmRZcpjgbbm5yJnG3FhJg84eV+LCDPmBH/pSn4FTl2QkgUDQFrEE1xhzNS
	ncwdWFTdFKE/xpDmtp2p6CFN1Wz7LUkSmz16z3UJMI4picEZhmu09y0gwfqw5jItRYSZWAAcBA8
	DmKLiNAefr649rBKGjL54WjXYPUpWpcvny/1LQ8QnDDr9jqqM6djJ6iU8+ZdvlmwdqTan5PQ+J6
	WcAt+y/SzMJ0PqL+moDMzBqvRxEwzAvC7zAT59/a8rJkDduc5ttOibk/
X-Received: by 2002:a05:6a00:6088:b0:857:73e2:9106 with SMTP id d2e1a72fcca58-87239aa08b2mr2729686b3a.22.1789538166849;
        Tue, 15 Sep 2026 22:56:06 -0700 (PDT)
Received: from localhost (ec2-16-145-69-213.us-west-2.compute.amazonaws.com. [16.145.69.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201f07a19sm619968b3a.53.2026.09.15.22.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 05:56:05 +0000
Message-Id: <DLGIC44OPLOE.XHJ1NP8XKPIQ@gmail.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <eddyz87@gmail.com>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <tangyazhou518@outlook.com>,
 <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Add UHMUL and SHMUL instructions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
 <20260902070534.2141812-2-tangyazhou@zju.edu.cn>
 <DL9CGP0NFZ37.25Y31VZH6PKPQ@gmail.com>
 <94eba3a8-6bca-432b-859b-d14e608d34f2@zju.edu.cn>
 <DLD0Y0CFA97S.3RC5RTORRYY9N@gmail.com>
 <4147c261-7518-4700-9ca5-12c020256aca@zju.edu.cn>
 <59e754a2-6158-485c-93b9-6f60d9f57528@zju.edu.cn>
In-Reply-To: <59e754a2-6158-485c-93b9-6f60d9f57528@zju.edu.cn>

On Tue Sep 15, 2026 at 11:48 AM UTC, Yazhou Tang wrote:
>
>
> On 9/14/26 16:36, Yazhou Tang wrote:
> >=20
> >=20
> > On 9/12/26 11:40 AM, Alexei Starovoitov wrote:
> >> On Tue Sep 8, 2026 at 1:30 AM PDT, Yazhou Tang wrote:
> >>>
> >>>
> >>> On 9/8/26 3:51 AM, Alexei Starovoitov wrote:
> >>>> On Wed Sep 2, 2026 at 12:05 AM PDT, Yazhou Tang wrote:
> >>>>> From: Tianci Cao <ziye@zju.edu.cn>
> >>>>>
> >>>>> Define UHMUL and SHMUL as BPF_ALU64 BPF_MUL variants selected by in=
sn->off.
> >>>>> UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product,=
 while
> >>>>> SHMUL returns the high 64 bits of a signed product. Keep off =3D=3D=
 0 as the
> >>>>> existing low-half multiplication, and assign off =3D=3D 1 and off =
=3D=3D 2 to
> >>>>> UHMUL and SHMUL, respectively.
> >>>>>
> >>>>> These operations are inspired by the UHMUL and SHMUL instructions
> >>>>> introduced as part of the PQR instruction class in Solana sBPF[1].
> >>>>>
> >>>>> The encoding and immediate semantics differ from current sBPF.
> >>>>>
> >>>>> 1. Solana sBPF assigns these operations dedicated opcodes in the BP=
F_PQR
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 class, whereas this implementation selects=
 them through the offset
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 field of BPF_MUL.
> >>>>>
> >>>>> 2. Solana sBPF initially sign-extended the immediate operand of UHM=
UL,
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 but later changed unsigned PQR immediates,=
 including UHMUL, to be
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 zero-extended[2].
> >>>>
> >>>> Why did you switch to zero-extend ?
> >>>> Sounds odd to do zero extend just for these ops.
> >>>
> >>> Sorry, I wasn't clear. This patch does not zero-extend the UHMUL imme=
diate.
> >>>
> >>> Both UHMUL and SHMUL follow the existing BPF_ALU64 convention and
> >>> sign-extend the 32-bit immediate to 64 bits first. The zero-extension
> >>> I mentioned refers only to current Solana sBPF behavior. I'll clarify
> >>> this in the respin.
> >>
> >> My question was "why in Solana you switched to zero-extend?"
> >=20
> > I wasn't involved in that Solana change.
> >=20
> > https://github.com/solana-labs/rbpf/pull/642
> >=20
> > In Solana BPF, PQR is a separate instruction class for product, quotien=
t,
> > and remainder operations. PR #642 mentioned above changed the treatment=
 of
> > 32-bit immediates for all three 64-bit unsigned PQR operations (UHMUL,
> > UDIV, and UREM) from sign-extension to zero-extension. This appears to
> > have been a broader convention change for unsigned PQR operations, rath=
er
> > than something specific to UHMUL.
> >=20
> > I couldn't find the design reason documented in the PR, though. I'll tr=
y
> > to ask the author about it.
>
> I asked Alexander Mei=C3=9Fner, the author of the Solana BPF change. He c=
onfirmed
> that zero-extension was an intentional ISA design choice rather than a fi=
x
> for a particular compatibility issue.
>
> He gave two main reasons.
>
> 1. First, for explicitly unsigned instructions such as UHMUL/UDIV/UREM,
> treating the 32-bit immediate as an unsigned value was considered more
> intuitive. For example, with an encoded immediate of 0xffffffff, zero-
> extension gives 0x00000000ffffffff (2^32 - 1), while sign-extension gives
> 0xffffffffffffffff (2^64 - 1). Similarly, 0x80000000 becomes 2^31 with
> zero-extension, rather than 2^64 - 2^31 with sign-extension.
>
> 2. Second, zero-extension gives the continuous unsigned range [0, 2^32 - =
1].
> With sign-extension, the upper half of the immediate encoding instead
> represents values in [2^64 - 2^31, 2^64 - 1], while values in [2^31, 2^32=
 - 1]
> cannot be represented directly. The Solana BPF design considered the rang=
e
> provided by zero-extension more useful for unsigned operations.
>
> For Linux, given that the existing ALU64 UDIV/UMOD instructions with
> immediate operands sign-extend the 32-bit immediate to 64 bits and then
> use the resulting value as an unsigned operand, I'm inclined to do the
> same for UHMUL for consistency.

Agree. I think it's better to be consistent, since inconsistency in
imm32 encoding will cause quite a bit of headache to compilers to special
case these instructions.

