Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256E29AAFA
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771018675; cv=pass; b=F34wWBmbiwLKtWEjI2xsC+C4tbEf4grxRlqXEeXEAIt3oVth0rv/jkAFHpkCkLhBl0oSvlczNmsYG/1/oafoCgqMbTb0xYx6sHOhZRKKeRt5QSlfHBuRsdJCILrMtpfUyswLR7s+toNk2z+wbCb1EKcJk2yZDDKoXCMSUsUqWWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771018675; c=relaxed/simple;
	bh=tAebdrN++Y2EnmNfW1amoyyvQNZKFQ6F8CEb0AZIRSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmieXiDyHSBrSKD15FuZdOq/ciR65wYd1F+95GRvFDwkwgjNVxqFZtXasBcNKs5/u6zYJJPKrEYUQlLso1Mf397ayKtaqTrMSAUgeL5O3HMjVJDMZf8Z8+zjThxT7FTdQ97GfnMVhgfXDAjv+NZsK8fIQACTq/n3yGjWY0XvjKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs0zKy++; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs0zKy++"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43770c94dfaso1562292f8f.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 13:37:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771018671; cv=none;
        d=google.com; s=arc-20240605;
        b=dlWkOSGhbNY4DmJGxxkKNIUAyIrOqFO9IQGkK2WucPISdja5yBvT1XAAFqQnRlz6gE
         nsWVks0EBVCqhvc53NBZJ+8IgyWNqIrebqHk2+V5/qBtsQaFkU83siGb+D8jZpW+DCDa
         IIRK53GHu8SP027KEAgbvgITCU9ZokeWE6cF9ZRQqEOyxejn7uiq8gK/yRvirJRs+dFu
         /PKaarD7R147k9aArm9oAnV72BIi8+bRjt8oZd28hYdqFv4ST3nYqqveAj9IIpxhrPu9
         vWHIJfXfQ4/JCcFAkOZHxomnHHsOPnc4f5iScGLMyjk1kr6Eo+6fuoK6uYp/lStCZb5F
         wUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tGNTntAipGaFdyX8UZHJ7UbS6vmkvLFLq8n4JuySALg=;
        fh=n4in3RUxZ+fmZfGN/CvNj4rt3Mr4EIzNjpOeHAVY9g8=;
        b=C1Vje1rPoA63/wCek6SarfsjCI2TjkeFL5jkxZAGqegg9t3gfwIPUKQhrUL7gBlN+A
         jFWXRKWkWcriFlCLNdoILFUULtJ2LI3yNzdZkNveJmDZCwGTWEj1rWKO0HL1YgRuFdiR
         nzIcF8NB8NIXJSPNn9/CDTAS8/Gxz/G/cOr9xll2aQdqHJquur1PAH5VBw9TOqe4OhZl
         X8Q/3+xw3wiO5EaBLNfwL4cMxSFqBhau+VG/yibqaAmRXVn7R64RtOf2eGMP/mJpDCWU
         HIk46AP3+Jtb0b9rrBElNdNFMv1rE92CUPsdQLgVCPUJMBaXAsxK8XSXF4cMlPblxCvU
         IoOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771018671; x=1771623471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGNTntAipGaFdyX8UZHJ7UbS6vmkvLFLq8n4JuySALg=;
        b=Cs0zKy++U/DTX/vjpk/N6aglHjCthv0gjv0FtkU7h4dYdZzgEH02pFAInj98w1EFsf
         Kks79b90W3CKTALUzTrWgVV0XLfJ77q3h7LB/0DiE5ey6F2o/9h/7kFr7Rynv7+HezbB
         uT0s66DoV8xsDBr7XBYd1bq+uLEID0rZLAURpN3NK3rmtyOO9oweTjEJfruqZK2BIlA8
         DeQKPBn/yKa1szSHq343UlIncXQylhxBU6hQasjRKUYhAttwfLUCpyvk0+eZbWxqqQoK
         ++Ut8MuTVZZCz6ztwFZZPBVG3Li3VBgQbiqwh4h9JB5DzsGxS4LExoIzQko6nrM4svgk
         Sk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771018671; x=1771623471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGNTntAipGaFdyX8UZHJ7UbS6vmkvLFLq8n4JuySALg=;
        b=M5SKtGLdXL0TYnxQ2bzGAidUX+/GOjelmSwPtGvoeqO9XeH8E29mx1531MKok4uYb9
         t9JDcnWPGh63eIWOimYdO2DqLskiOEoBswAE7ZnarzBl7abKctOVQ47Pw/yeegfrdHON
         PDJDGsjmN6swuZC/mPXmMKZX/1XplTF4SC/Bq0jl2yz7spWTMirc/1062AeS5boirhBO
         aMdYYmIxPY6BSb7m6GdImNFE0Pk4erugPfShDxI2RBzhjZlJi3tlSC7rjTs8O9vFeTnS
         vqhDKE4Fl4Z2tRYBjVv7AI0kac6SozUsUdzo67yfRbObLg4XRLXBpQDvcswNG5ax6Co+
         DV9w==
X-Forwarded-Encrypted: i=1; AJvYcCVEOKEhLimJa5i/EcE2eWZ5qLnAfJxQRB+Pt8+rDBQs6bJyrF/MhPyrGRIyRE5oWOZR0IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYqSYpKUnPq2QvB7w6So2zBG5jwdgqmjlcCeMiWMrp1f+3KrN
	nyIA/PBF3bJ3EAAYkLK4B+Z9pHbvX3qL6fP7pHMXqyeN2zPgruSIlSl5gyunPwaXGUlatbBBB4T
	5kfA4ymUvtlLwjSLGCuSmdcy3RW0sFhs=
X-Gm-Gg: AZuq6aL0YoEU6NJpm4OLco7JJQRyoAAE1P6RR80736jliHjjC/j3vsQsQdtCuBuLjlg
	z7nd1+URUCbrtzbDLg2p1Qbk861MeqzOsCkyyIWwOlBXPu4yoXMfqITUy64BGhCqkPIcJFNQGf7
	EeKj7HtbKjeeokKUn4JLVSlTp6iFEmkjhArfh5sEBfUsHX96GFhua+dCkVQtkmZvUdO89pvqQ0F
	0257GNhmtzBpRT96Eo8y0SibSaH5XJBwyVR6dZQ3IxqA+rMl+6HLqjtLLp/P1DHZAR/pPIwa7If
	Cb3158Yshc7+LTVok9ooGkzF6306heguepLrOJqpVWmtYxN+TKWXPuXO00MdnjV8VjoxJkduaor
	ij/IcK0P+jsg9KPqp1UwfmqxojQ==
X-Received: by 2002:a05:6000:310d:b0:437:7589:100c with SMTP id
 ffacd0b85a97d-4379793f40dmr6215492f8f.58.1771018670782; Fri, 13 Feb 2026
 13:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aY3+Raf8eZqipCd6@e129823.arm.com> <CAADnVQ+D7v+sGFFyTfSxFSEEcnGV111NeSaVtASYHfP-mDnV4w@mail.gmail.com>
 <aY4Vipl+4rGa+u6D@e129823.arm.com> <CAADnVQ+ad1Eu34hS21HNLgzA5eeFHMvQmoC33xKpP0z247MaHA@mail.gmail.com>
 <aY74MqGV4A+kwsQM@e129823.arm.com>
In-Reply-To: <aY74MqGV4A+kwsQM@e129823.arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Feb 2026 13:37:39 -0800
X-Gm-Features: AaiRm53dkt1PoQISalig28Fltlt3-YYJ6sDHOyTEu5Ru6hEECJfSFjcsAFUNZqA
Message-ID: <CAADnVQKAv+MRNrK=2MmEFKcB0FkmtG2pchdp35xo1ya-ujqVHg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] eBPF isolation with pkeys
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, david@kernel.org, 
	ryan.roberts@arm.com, kevin.brodsky@arm.com, sebastian.osterlund@intel.com, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 2:10=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> Hi Alexei,
>
> > On Thu, Feb 12, 2026 at 10:03=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.c=
om> wrote:
> > >
> > > Hi Alexei,
> > >
> > > > On Thu, Feb 12, 2026 at 8:24=E2=80=AFAM Yeoreum Yun <yeoreum.yun@ar=
m.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > I would like to propose the topic of eBPF isolation with pkeys at=
 the
> > > > > upcoming LSF/MM/BPF summit.
> > > > >
> > > > >
> > > > > Background
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Today, eBPF programs provide powerful capabilities to extend kern=
el
> > > > > functionality without requiring modifications to the kernel itsel=
f.
> > > > > These capabilities are largely enabled by the eBPF verifier, whic=
h
> > > > > enforces memory safety and other constraints to protect the kerne=
l.
> > > > >
> > > > > However, vulnerabilities in the verifier have repeatedly demonstr=
ated that
> > > > > eBPF programs can also become a serious attack surface.  In sever=
al cases,
> > > > > flaws in verifier logic have allowed malicious eBPF programs to b=
ypass
> > > > > safety guarantees and compromise kernel security.
> > > >
> > > > eBPF was restricted to root for many years, so the above is simply =
not true.
> > > >
> > > > > Representative CVEs include:
> > > > >
> > > > >      - CVE-2020-8835   [1]
> > > > >      - CVE-2021-3490   [2]
> > > > >      - CVE-2022-23222  [3]
> > > > >      - CVE-2023-2163   [4]
> > > >
> > > > None of them are security issues. They're just bugs.
> > > > Like all those found by syzbot.
> > > >
> > > > > An RFC series is planned for around Q2 2026, and the experimental
> > > > > implementations for eBPF isolation with pkey and pkey-aware memor=
y
> > > > > allocators have already been completed internally.  Using these
> > > > > implementations, we verified that eBPF programs running under iso=
lation
> > > > > successfully execute several sched_ext applications provided by
> > > > > tools/sched_ext, as well as some bpf kselftest cases.
> > > >
> > > > The stated goal is wrong, hence not interested in patches
> > > > or discussion at lsfmm.
> > > >
> > > > arm has a nice hw feature. Sure, but this is not a place to apply i=
t.
> > >
> > > That is correct =E2=80=94 this is a verifier bug.
> > > However, the concern is that such a bug can lead to a security incide=
nt.
> > > Not only root, but also users with CAP_BPF who are allowed to
> > > load eBPF programs could potentially trigger additional security issu=
es
> > > through such bugs.
> >
> > Again. They are not security issues. cap_bpf is effectively root.
> > Just like cap_perfmon in tracing space is a root.
>
> The argument is not about whether the verifier bug is a security issue
> per se.  The point is that relying solely on privilege boundaries
> (e.g., root-only loading) does not eliminate the impact of a verifier bug=
.
> Therefore, leveraging hardware isolation to further constrain
> the blast radius is a defense-in-depth measure.

I hate the reasoning that bpf somehow needs this hw feature.
It's not. Look for other use cases for pkey.
