Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C42475F7
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771555839; cv=pass; b=JjK2WF3avyT11L7JKGQ7k3yYQ1cosqXAfIXd45zABdwU4obrREpPzycUyFOFgljd3gj6NVb1E9O8cJ5kL45gjB6oNXNRmUKDYFvIs9/5lTlOlWsljZeYQDhIquHti2MF1LcktxT+NGlRBMwtlM7iLHHMmhYUcuahcyco6UKN0Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771555839; c=relaxed/simple;
	bh=WGkcUsi7EGnl3/8mhh9WdxbBOAznNWUOL1dYLWbm4FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evVbZILLSWe3d5b4d2zOURguRupk9fSmqCX4myj7TvFvXIlUoAB/7GInZ1VBGF6Uw/MRVxQQQj1znwemIUFTiYcc59niFWsxCvvOuCH4q8fz9Im42LZijYXdYQ7v5gMvjAKOo1HYAvkbb8rkOE6CVr1YloaUQGDHRATsiTUgvgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkTrhqFW; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkTrhqFW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362197d174so1022209f8f.3
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 18:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771555836; cv=none;
        d=google.com; s=arc-20240605;
        b=Mj4ACnN6koJ1EDVl4o+Ao7+ABFAmUGEoOL/tOHN3g0fAQ9PaHZ8qbz+mlKtlTMIC/9
         9GPRURgtC+kiIUYbSgb5E1tmyQ23am48Ybe+X2pFE+0YOFlvNsaIA232ETJfzD9KP5yf
         H0v3d8s4Pq1bTmg00x0wBAZVVKFllKMu+3FnWbiiDbTOpDuJfC0EqRJtoeu2VpYH4y4G
         kZYyHZXaIasTKaFuND8tpJGgO0fUfU21YIEZ5mQvzssaFDpvaWdHZzFhzdjUJZ3WsMbY
         eoaw/Ffnk0VX75B+OKoS+tkCsg6aC30uVcwTWivZHLj3MVrS/S9CSjQ6c2afRbALLkeV
         cwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=//4TvN505NNuNnrj6p7kVS0Ee18l5lpIvo3njUSZ+Is=;
        fh=Xq/hZ8BVsJmzewSXZvpvwe6kS628ndTMURHzpODm8gE=;
        b=eq3RkGxQkMfEo8hLLLvTKCxD4H+Y1N3yjH4ubedmQKAFzNB/ec3Ucvoq0xE6Z5mt1/
         l+IR1u7L03lai3RpRKLHUiiQig9MDxb33XD7J6R87w/Hgx4k7xVeeoA7YaNYa2uxJ7oQ
         iefBYfxUuuuk8ZLflp8zjMpwYeEoL7b1Y1mU7jJK3g4vXnLSxeysZElrIcfgCoL74DU9
         e1qv9bsIR8hixrVSeMPqFJJMohMg/GEMxg1ZHxTxIJLYjhHmRvaja0rT+LGr2TIPj9ov
         vCuhUArCXt5nc5zAzEiG1pmiYOqau3uT9DQNkn0qjPEyQAwNR2cfkMaWz6Hx6b5CG4PD
         j+EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771555836; x=1772160636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//4TvN505NNuNnrj6p7kVS0Ee18l5lpIvo3njUSZ+Is=;
        b=kkTrhqFWS7QsKFHMsDCmrp7ten7i+zsN0cH6lLsrDVEgsaFZ8RAlj5Mpu+SGu08gdT
         iWdjyKewEdV2fzi/Eit36ZAwZIKlhYyW4fT12gqudpv81Pi34U8pMQhaFTm4j8hTbSMc
         Iickq/5tglPLsezGxgVanNDjSciCErAZwRBofytigGkcPt0otk/Wn8HCsMIwcLrqmstr
         d8DR0HakSkwSowD4Y08L7R52w33U6qXyH2PhnkmlW37ZnpDxss27RoBj6qhQtUCDEXpp
         sYT+b4JPNTvKj+qSunMml6JI0ARdHnr1222PnCOQHIzi5s11ixOoFQJY6Fqo1pXCRbNl
         NExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771555836; x=1772160636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=//4TvN505NNuNnrj6p7kVS0Ee18l5lpIvo3njUSZ+Is=;
        b=ogkxCzGM2m27KYc+84T+jDe8Ey7W885Lr6JiyoOJVHlGLFAxKkE13j12UVP3TdwIZZ
         0HyGcVWCFvV3fWfgEMXjXyeDBJal1gremrNkcNQQB+PilOHCqC0Z9lEpKji6kSJLjAW3
         ndg+7Adwzm3xwh0qI2SITlBKzQM3EOlZR4hYKpvtY5T2dtgBPbDbdRdVOy1YzWreBjsH
         ISfmbv9XHFr9bOo8qOudofAdocYX2R+ELrlmG7eiXrBqdwaUxlvBKctuJCD5Rv5Env5i
         Ax5HZpFuHaboH0IsztDiKtQyPigXKWIloYBzU6WZgFc8efJomy1mctv4cJEfu7qjO9dc
         Oo0w==
X-Forwarded-Encrypted: i=1; AJvYcCXBCtBZkCmGl5hPJRZCeObX75TBslNkTmGLMpp9263HLh238H/FVPBtbU5UN8LI6KDLUwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzGEWf+JD6VKbJTi6RHbEDSGOR4b1O2ZUSNwqARmtj6RvO2E2
	dnpSSWitWDuC0AZOBqKAZFOsNdoyKFi/7Mjl75yto2yrL0BbROQOsh2qKx3aAccTVK3zwVz7mVV
	Tqy7IPkkZcxPUEqdbA/hJVWHr8glrqSA3WA==
X-Gm-Gg: AZuq6aJV5kz9h9bbO5lDzks8SyXSyiTSvFxMJcC/RFsvfswAWBS9hgzy9RygZx+j6VI
	QcV5UqwHOL/Y77wuNtxTBFkB/0dCQ9LVRghzzE/G65oiTaUmIx0/6wFpQklX3Z1qn10ou+LLetz
	IvZzMYo+uFjNWopcje7pFCXwVzzQMU9jYGxtxBECohu85MJC2rEx7EsowjBtRNbD2fodP+uySk+
	6O89wZhrSIdpDuWVqa4iZvYauNPV+fCyf6YetYF02agKah6cFajPAcStz2BWPy+QHmkP3QCZfXl
	75Ya0v4LF21HwvRhCZgpjBEZGfm8lgoFkbiac4YTapWML0BadfXq5RGmRDE/RtOBPhvD2jctI7Z
	3PbAD7liHHEPuAQRdWulGqAjavOuzUDNQlSgG
X-Received: by 2002:a05:600c:8b77:b0:483:6d4e:9811 with SMTP id
 5b1f17b1804b1-48398ae6736mr142110645e9.31.1771555835677; Thu, 19 Feb 2026
 18:50:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aY3+Raf8eZqipCd6@e129823.arm.com> <CAADnVQ+D7v+sGFFyTfSxFSEEcnGV111NeSaVtASYHfP-mDnV4w@mail.gmail.com>
 <aY4Vipl+4rGa+u6D@e129823.arm.com> <CAADnVQ+ad1Eu34hS21HNLgzA5eeFHMvQmoC33xKpP0z247MaHA@mail.gmail.com>
 <aY74MqGV4A+kwsQM@e129823.arm.com> <CAADnVQKAv+MRNrK=2MmEFKcB0FkmtG2pchdp35xo1ya-ujqVHg@mail.gmail.com>
 <9c7a5db754143f59bdb2129616d2a23495d4b3b9.camel@HansenPartnership.com>
In-Reply-To: <9c7a5db754143f59bdb2129616d2a23495d4b3b9.camel@HansenPartnership.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 18:50:24 -0800
X-Gm-Features: AaiRm510k0AJv93e_6kEPHNHD651Rror5rKfPW512B9wpfkVqt4fKVcueOPO-KM
Message-ID: <CAADnVQJuYDgbwvZa9zuUXcPoHRp25n5NYutbEsv6F-NzeK4oDg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] eBPF isolation with pkeys
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, david@kernel.org, ryan.roberts@arm.com, 
	kevin.brodsky@arm.com, sebastian.osterlund@intel.com, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 6:27=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2026-02-13 at 13:37 -0800, Alexei Starovoitov wrote:
> > On Fri, Feb 13, 2026 at 2:10=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.co=
m>
> > wrote:
> > >
> > > Hi Alexei,
> > >
> > > > On Thu, Feb 12, 2026 at 10:03=E2=80=AFAM Yeoreum Yun
> > > > <yeoreum.yun@arm.com> wrote:
> [...]
> > > > > That is correct =E2=80=94 this is a verifier bug.
> > > > > However, the concern is that such a bug can lead to a security
> > > > > incident. Not only root, but also users with CAP_BPF who are
> > > > > allowed to load eBPF programs could potentially trigger
> > > > > additional security issues through such bugs.
> > > >
> > > > Again. They are not security issues. cap_bpf is effectively root.
> > > > Just like cap_perfmon in tracing space is a root.
> > >
> > > The argument is not about whether the verifier bug is a security
> > > issue per se.  The point is that relying solely on privilege
> > > boundaries (e.g., root-only loading) does not eliminate the impact
> > > of a verifier bug. Therefore, leveraging hardware isolation to
> > > further constrain the blast radius is a defense-in-depth measure.
> >
> > I hate the reasoning that bpf somehow needs this hw feature.
> > It's not. Look for other use cases for pkey.
>
> That's a bit of a short sighted attitude and also you're looking at it
> in the wrong way: hardware, correctly designed, should always be
> looking at ways to help software.  eBPF may not "need" this in the same
> way qemu doesn't need the VMX accelerations ... it's just more secure
> and efficient when they're in use.  After all, if the kernel had said
> "no" to VMX in 2006, KVM would never have existed, we'd have been stuck

This is a false analogy. Virtualization extensions were added
because virtualization software already existed and had shortcomings
that CPU designers wanted to address.
Here pkey was added to differentiate one ISA to another and
now cpu folks are desperately looking for a use case.
Maybe it exists, but it's definitely not bpf.
