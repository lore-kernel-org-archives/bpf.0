Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618B395AC3
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050234; cv=none; b=rweNYEZwV6klN9mg9qMeJHZyBBClBtXsj7A1wa2A6BWQCHnaGHEryMIAVVXCBZ8YGqImexwCc5u1HS2Ymu4rb5nWWnywmrStHeeaZkbMHSY8HauisrV9VIbAwihuyG6QL6nxh/g4itaAgi779mZZyyPUTctr6phZ14yARr8pO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050234; c=relaxed/simple;
	bh=x6IqzZGzDOcmkZdPQMowpnr+NPIX3MnRXi8w9czJqwg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbu8aCGZP/03JyO6HJR06TODCOxwl+ELWjbxqf5YQorxmYnsgvAfFl8Y27X2tnAz5ggA7MfBzNHOHw3JpnzM4CgWrfuuMSb64kM70PJ2RHKV8WozN6dpmcXtl5EBWfGtnTTYgfsIqKmEgMp1ZYAsgSdI7kH68wmE8d4E2tdUpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFS9voAn; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFS9voAn"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso3091428a91.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790050233; x=1790655033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x6IqzZGzDOcmkZdPQMowpnr+NPIX3MnRXi8w9czJqwg=;
        b=aFS9voAnjF1aGT6JWPmtoQMKoPo8KqA0/ldphS33GUeaGy+2WEqHxD1Emykmov2ceW
         8Cwmj2RIBPKX36RNESgQVr0u1BHY41WXIRvVFg+NAeh2TAqWwwEuyVavPvDodYt+ieQq
         tCqHWco4Jf69gsIjHs9uZDcJoSUnkdicd3RtG7dq85Jc3nug/gvZRJTl+5POlMP7bbEx
         i/MLgHdVCDniIuOm++sSGU6LYdB9o7RPmNii8q/QuPaHRkPdiEunNmF1ovMoiaWlCZQZ
         oHgpsGXeQC8nmQD2bm/4GCGKzu7z4d2l1uUZDLY1zmpaTVW8z4545R7E7lfc97CRPeb+
         dYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790050233; x=1790655033;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6IqzZGzDOcmkZdPQMowpnr+NPIX3MnRXi8w9czJqwg=;
        b=J75Hb8CCB7oiiNSCsdun841kVtZsqe6ExU9UfQjcJma/G2NiiwgvKBxaaJYzMWFBf6
         i40Q79pwzN15jsmBVrI/vYuLGstnidGuW0HHpIlS/9umnd9rNf2KF3owEyg7dYF01feq
         2cSEUPodZhEfFI3oqyu6x2s03xKq2jzJIIfMMp/pvGG/m5PVW7bqZu60AQBlmHZHr5xD
         6Faqj9RndVkyKqM79LbPDA5pcGEfnOntQz94pObi9oud9vSC0GIcmm2Yoep1mIdqv91g
         1q0g4r1A/+GQotrImciRv+m4n7wEVUO+2UDkpwXQG22AuGdsqKPLsEbWooWvIcwutpgF
         ZK3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwt6d+3AHCwAi2UGJx6sknZBBdGlr/ohFaXKKWppt9AgFD1E3HPYdSqkYtkBQVdcTLjAhY=@vger.kernel.org
X-Gm-Message-State: AFuF++m0Ig+jXL+G/LKCaxNiTNLjzhgSWyeDNfrcanx9rs/zSylElT01
	2bVe0RnQr7JX/RgeLKREOutPGGm5K8xvD/3W6ZwGlQah78BYUtxdJNda
X-Gm-Gg: AYBFou23w/q2JrHvjVQ1Dr5hPNmUK65LFMWQslqYBhuQghP1RDVNOoAv1xKnGMZ0aGk
	hWuUr1sy53uX/5AInJ05NFPwufqN7F2UpKRSbf3+5dXXmVCjsqiB59labw94kWRTtjPczPDE3aT
	H+LrRAmp1lxvQk8++KtaSGETlT1llRokibhQQaneh+LTs2glVI4X3JSsjfM8aKjVoEdvLDt4+Y5
	fIsH4irOJW3sK6wTGm2KpR/U+JNOsNRpu0HIxyLpXgih9WOZrJAakA8CiLAKmYOeOT9I9jxiR8X
	eINctdUhfwGgjB6LrTaMuTpW7tUemOp01yya7NsAzJLDhOS6P5QzEWulptBi/0eBQIgfkOEwYDE
	NoBK4FOhmEfJMkNt1ORNOjv9Jd462y2LEldOZJz3I2rEkKcbAY/YaK5YRt2z6Jrb2afdMLTLGvW
	ocOqkJMdqzjxx2X5/TcOFlLMzVhBD5I93DpO7gffCS+87eF9CQmq+Wx+iV3nFrKYmgqn5ACdKnI
	pqlDzCbYgp0OvaJL9WEqy91bQ==
X-Received: by 2002:a17:90b:3c8d:b0:3a0:42a9:9c81 with SMTP id 98e67ed59e1d1-3a042a99ff9mr6980146a91.17.1790050232804;
        Mon, 21 Sep 2026 21:10:32 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5cdb48sm784466a91.17.2026.09.21.21.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:10:32 -0700 (PDT)
Message-ID: <ee80f5d0bdd82cd9dff80502a4c19d3d6130615e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 06/20] bpf: Explore the landing pads no call
 site reaches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Mon, 21 Sep 2026 21:10:29 -0700
In-Reply-To: <e9c4cc88-15f1-4cdd-ada4-adac5ac289e0@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210104.1718697-1-yonghong.song@linux.dev>
	 <cfed0048af0a603a4e71894e8a36c5ae2cf6bb66.camel@gmail.com>
	 <e9c4cc88-15f1-4cdd-ada4-adac5ac289e0@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 20:32 -0700, Yonghong Song wrote:
>=20
>=20
> On 9/21/26 4:58 PM, Eduard Zingerman wrote:
> > On Mon, 2026-09-21 at 14:01 -0700, Yonghong Song wrote:
> > > A cleanup record need not cover a call an exception can unwind out of=
: a
> > > frontend is free to emit a region around a helper or an ordinary kfun=
c,
> > > both nounwind here. Nothing marks a call site then, and that record's
> > > landing pad is reached by nothing at all -- leaving bpf_check_cfg() t=
o
> > > refuse the program over code its own frontend had no way not to emit:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 0: call bpf_preempt_disable
> > > =C2=A0=C2=A0=C2=A0 1: call bpf_preempt_enable=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 record =3D { begin =3D 1, end =3D 2, pad =3D 4 }
> > > =C2=A0=C2=A0=C2=A0 2: r0 =3D 0
> > > =C2=A0=C2=A0=C2=A0 3: exit
> > > =C2=A0=C2=A0=C2=A0 4: r1 =3D pads_ran ll=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 landing pad
> > > =C2=A0=C2=A0=C2=A0 6: r2 =3D *(u64 *)(r1 + 0)
> > > =C2=A0=C2=A0=C2=A0 7: r2 |=3D RAN_NOUNWIND_REC
> > > =C2=A0=C2=A0=C2=A0 8: *(u64 *)(r1 + 0) =3D r2
> > > =C2=A0=C2=A0=C2=A0 9: call bpf_unwind_resume
> > > =C2=A0=C2=A0 10: exit
> > >=20
> > > The range [1,2) holds one call, and it is a kfunc, so an exception ca=
nnot
> > > come out of it. cleanup_mark_call_sites() marks nothing, nothing push=
es an
> > > edge to 4, and 4 through 10 are reachable from nothing: "unreachable =
insn
> > > 4". The pad is dead, which is correct -- no exception can ever arrive=
 at it
> > > -- but the program is fine and has to load.
> > >=20
> > > Walk every pad the table names that the edges did not reach, the way =
the
> > > walk is already re-seeded at an exception callback. From there the pa=
d is
> > > code like any other: do_check() never enters it, because no call site
> > > dispatches to it, so the dead code sweep removes it along with everyt=
hing
> > > else that was not reached.
> > >=20
> > > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > > ---
> > Yonghong, have you observed such dead code being generated by rustc?
> > It is a bit surprising, tbh.
>=20
> The above code is with inline asm. rustc won't be able to generate such=
=20
> code.

I'd say we shouldn't include such mechanics only for testing.
What kinds of tests would require it?
