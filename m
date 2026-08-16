Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED9301709
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786910556; cv=none; b=JR2SzBtqg/Dv12XVOrhExUM2ut91QFBziBEx8MYIG4vEZnZKymjSmrYB0uzDmXMhbl45sC5px9ABNJfKC8PZ1CwbG3yqw39xDPJbO49dGNSUZcPh+5CYAHqwjWYK4rPwQHrDklup+7x/6AxzSbjKeipnANK3hPCECmaqpweQpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786910556; c=relaxed/simple;
	bh=5fXCKp+x8AhLYl9EaFhjGQYm2BV6wPExzQ7wZJ3mdxI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cafGTuxzf6q7K+I6YrDwVikyFNOY0z0NC4Z8/Vb0QxGD3+u1UZ5taScKqOnlZY64JTnaqHBIVCuPx09flxAwG4b2yXw6gwp+kEZ9FQ5YsXRdnMMWW271UwrnP/Aw0RKize+6iSkYeOgAbdUJqnD5y3tfA5Vvmzam/GFWJiRrdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqRm22pa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqRm22pa"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2024523a91.3
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786910554; x=1787515354; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cWuRoIVXZmjo5xbqWIO1LTpo5HT4cgKxUkP5oCyeY7Q=;
        b=XqRm22paiD/9lFIbynp5RKYqCi2r0eTDKMNAa5foQmxmxpKXLMwVara7b3uiqukcrJ
         7YdHpHTV0gHx3MKQvSgpbKFxZGeuXj6Tvlp3GotmAILqtbQKUsmX87fEW83T8rVME4BP
         VOiYwvHw5lhwxg4Trci/4aCY7TrUu79ZtesYDoAPeIpB0pgfUTWT5z+VdDAaywQ2SsSL
         mDjW7wbJP4bbly4bJm2FaMidLW3ksAGo2xd2AZX3HhjxW5mxFkEardNu10bccYnCTCac
         zFTxXHtHaLDMdqErAZ64gIYzcKfMRXI0/BVCFyPvTgv4RgE1j8XZpAUukpjODHEAXyKq
         VLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786910554; x=1787515354;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWuRoIVXZmjo5xbqWIO1LTpo5HT4cgKxUkP5oCyeY7Q=;
        b=pw7cpK8DdiLtkK+vGuFC/cCZW1W6xBBRfjWVTNyPXge6+rv7ZLvcDnNZT1u82QznXm
         dfhyr2H1YU1Y5MJZnJmcWXSyEZXvXP5LqzyUc6gc0Jy/87rn3BkzZcDfNyLKE93b073E
         JEsF5SOZ3eRvV4ERf5dOuORi5078LkCn0aBQmrxki98+vjk9kvxXGrs9KeSRzck4+G78
         MBvvgLH0UMi29oQSfH1COcCmreUK8r3q/r3+7z73W/ivWZmthXUTgQtcWm/3r57mon1e
         JePggJdGrO0UB0EygHL6uuYX3ls9y/+8LQ+doBhr9Qzud31pbr6sBrMM2THnbwZYv+cC
         Jxpg==
X-Forwarded-Encrypted: i=1; AHgh+RoUmae7C0vaOMEqPv8aYufuNl34sP2oL3TrnrIEHtXocp1oUY3ad6qLMdIIdRNpESN3/nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwFY2WQBvX79nE0cyaLuFDq21P5Ygu+sfUobMs81UYFDAeA7k
	3f9u0mcse+uap01HoTB/ClXTDMjTuLBBTTUR0vnYkTegll4IsfNvS27hyPVhQA==
X-Gm-Gg: AR+sD136Ef70kOps/u37Ye2myQCmJIMfibYrzLgrDZf3nTwmmM0AR8gYKLIE7MdHc/3
	D/vq6HQdAbWePtqDfN/wVlpvnsREMHZNidwCGHbB/dx/h+QO8YfWyW6qhoZ0ksL1jZsjARmDVNn
	I3fPm3lKVScLtGi8hhjLS0KuI3oVLoqQinLXtMSZlP0uUk+O+8O95eLqAnVna7NeQMMmLxwjRxg
	Ne6ratO7stiC749j1IAWUfZPIO9O/fFTuv7CbNS5EDzGk6bjD5UZwAyNzDK64AMJatHDVaB+TU7
	0IlAyYYOa2OqXFF/75mh7dRtVxtRseTYfLXdEkQyvX5aqLR1AIDjbueXC5zGrPc/xU7SrK9qys4
	B722kaSM+EYG64BRwEwXREbQwDHEwGVgsjR9GdXj1dJ18Mf7qoKnTLdbcOtUV2cwFBMTpUfVYs4
	L0EpjjyVOcwYULyiCtTVHLX1jL1Na8D6bO+CLiiU0L1koR0mmn6gXDK1mC0YBlfRt7qsmx1ivtu
	EjcHMWmP12YSrh4
X-Received: by 2002:a17:90b:28ce:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-3933b891cc4mr21390343a91.10.1786910553977;
        Sun, 16 Aug 2026 13:02:33 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e142dbsm2267586a91.1.2026.08.16.13.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 13:02:33 -0700 (PDT)
Message-ID: <57ff07cb2c6872b335fb1b4d82179c1a496e8253.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Reject a store through a fault
 prone pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Sun, 16 Aug 2026 13:02:30 -0700
In-Reply-To: <9b30b735a7df1584042a4dbed4d8f2f54cf2f395.camel@gmail.com>
References: <20260814215301.709827-1-daniel@iogearbox.net>
		 <20260814215301.709827-3-daniel@iogearbox.net>
	 <9b30b735a7df1584042a4dbed4d8f2f54cf2f395.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 12:54 -0700, Eduard Zingerman wrote:
> On Fri, 2026-08-14 at 23:52 +0200, Daniel Borkmann wrote:
> > check_ptr_to_btf_access() allows the program to store before the defaul=
t
> > BTF access path gets to reject a non read access. ac65c710cc64 ("bpf:
> > Reject writes through untrusted BTF pointers") closed that for a
> > PTR_UNTRUSTED pointer, but a bare PTR_TO_BTF_ID may fault on a derefere=
nce
> > just the same and is let through.
> >=20
> > A BPF_LDX gets the BPF_PROBE_MEM rewrite in bpf_convert_ctx_accesses()
> > and a bad address is handled, but a BPF_STX does not and cannot, there
> > is no probed store to rewrite. The store is emitted as a plain one with=
out
> > an exception table entry and a bad address panics the kernel.
> >=20
> > A bpf_qdisc program can reach this, bpf_qdisc_btf_struct_access() permi=
ts a
> > write to Qdisc::limit and Qdisc::next_sched is a plain struct Qdisc poi=
nter
> > which the walk turns into the compat type:
> >=20
> > =C2=A0 struct Qdisc *next =3D sch->next_sched;
> >=20
> > =C2=A0 next->limit =3D 1000;
> >=20
> > =C2=A0 BUG: kernel NULL pointer dereference, address: 0000000000000014
> > =C2=A0 RIP: 0010:bpf_prog_c6e14e7f32c8e325_bpf_fifo_enqueue+0x3a/0x12b
> > =C2=A0 Code: [...] bf e8 03 00 00 <89> 7e 14 41 8b 7f 14 [...]
> > =C2=A0 Kernel panic - not syncing: Fatal exception in interrupt
> >=20
> > Fix by widen the check to bpf_may_fault_on_deref() so that it covers bo=
th.
> >=20
> > Fixes: 27ae7997a661 ("bpf: Introduce BPF_PROG_TYPE_STRUCT_OPS")
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> > =C2=A0v1 -> v2:
> > =C2=A0=C2=A0 - new patch
> >=20
> > =C2=A0kernel/bpf/verifier.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2e6992569187..6610e2437047 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5789,7 +5789,7 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
> > =C2=A0		return -EACCES;
> > =C2=A0	}
> > =C2=A0
> > -	if (atype !=3D BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)) {
> > +	if (atype !=3D BPF_READ && bpf_may_fault_on_deref(reg->type)) {
>=20
> The change is correct, but it appears that the if condition could be
> simplified as just 'atype !=3D BPF_READ'.
> The function is named check_ptr_to_btf_access() and it is only called
> when reg->type =3D=3D PTR_TO_BTF_ID.

Nah, scratch that, callers check base type.
Sorry for the noise.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
