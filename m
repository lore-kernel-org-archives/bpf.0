Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F830FC03
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559866; cv=pass; b=rAkebU8th/M72jkeYT1u1EG6NTvia5x2Rdye/Oi3vA4+j/23l729JH7HWhRdaOGBEm+eizNu5Ly39s/gXg/YaT2uiDTvij/CODHXgu/yXqG714lvPjWrE9OknHyxULrKeTOpZJxiSnTa+r+Q+A+RybF7hDFCYjJkc94B+03shjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559866; c=relaxed/simple;
	bh=rEcITMB4+0LkfIr7lkfRl3YhQcJNmnW0NYCfnXkoG9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl/bGFKLWhYlG1FYizEWcH10nfr30ARDNQCOHRyMMa5pWGv+WYz7KsI47GBxw8M7r1R+W8FipV1bcP4J60TPskOYc2Qj8WnLSSyBVueVPmxdACqXN0PDbEb0zDyJab3FLEpsBxndU5f1hM9QaGC9iT6ZZds88Li++T+YokAtD8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZxlPSuL; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZxlPSuL"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4585a116a4aso1373349f8f.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 21:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778559864; cv=none;
        d=google.com; s=arc-20240605;
        b=AHvOOfcoJ571ze26fwrLHYuuXo0sqvycsDtGAp9/Niill3nD2cFb9oKtaFoutVZwyT
         PvhmjhrmwnbssSfB44jGO44rvNkKYJvFWAFqbekA+ojSmYsDcRba7oVRbMkxoqsezcXH
         IALW0IlKr/DLvt1p3ycL8chbWYANSWCkYin5S30vEBsN+zMfKNjV8TCK/ZIp1UWN5tod
         xWizVf4XpZU6Cd493fTh5mdlEpDDhUWRzp9Z57XS1qT+H3O/NymiT9udXVI/Ib43UOp7
         +zM97WDQG/CN6RklyrYJr/z0B3MPDx7zL3X559SM1zVxsUK8Rua4k2Z8BTQEpxRHmxf8
         jdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rEcITMB4+0LkfIr7lkfRl3YhQcJNmnW0NYCfnXkoG9s=;
        fh=RyqipNHBaWg9nhbVp9+lscb7868L+ArtVMHPGEOrWh8=;
        b=MAh+PIyZKC58QOGRzbqkNJ5/a6CJWudRMe8aiOggbAsEU5ET/v+f9fqek+PXyrAn/s
         zWlSUhiw8Hycfl1OkK3aVUBoor51H8WCzhnJJ7Ph2IQJs0rQIoQCs4eHZ/60P5JU05eX
         hcaysxD3/aaynjc+n3mqb62CaOiD/JMdGLwu9nVPvELjqWbc7YVsep47N/nmBuHTiSug
         LaHZjvHAPD5fBt72xlQXto65OuNoawKPFefjGS67/hU8OOO7AXv13XwOmiBtS3QMke3n
         enqvNeWcDxuHdnB+h+8SS+dSFisNa4KsTcdlj6glm38iDI1JSscMEDlpP8YELv5/x3QL
         hjgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778559864; x=1779164664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEcITMB4+0LkfIr7lkfRl3YhQcJNmnW0NYCfnXkoG9s=;
        b=AZxlPSuL/UXRhshdZImKkiDQXMLRCChliWAecEpmpRIK9nski+2bafHQDnOivoXZbN
         9vznxwqwTAJk/YYJMSP83e3kV/m2kR01NptQOv8V8PJqWYj5fU+eDX2JBgE/6AJsFbWB
         pQQk1DRqBTgkojJFd+M9r9jCP88NLAJVjeQnTffS6+YTL9kOVSo1GDLeTOGxq3gCceFZ
         D4OykhYT1wkL6rHEySRkPSMigCHwljJLDGj+lDIvbXr9FNGxdPqz2wHXgEaH0O/L3pW0
         gJB/NKwi72kmvssfWJKozrbm/5z+tuqoFRLNVlJV8W61ks/emo4e8wKKq6YXklym2eGT
         VDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778559864; x=1779164664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rEcITMB4+0LkfIr7lkfRl3YhQcJNmnW0NYCfnXkoG9s=;
        b=ADBne+gEGX1Dwr5r1le2iT+2pjvGc4FLC2mDcJ90WsODqPRIEmDvRl89OEbOwXKRPP
         KCRPmcT7oNH7wviZCd0jSoitMQ111dyXe+l2bHkScy/oF8shCdqVDSN/XYL1wPSQkx1Y
         trcce4b1NjsCXMLwYSpQyLR3JQXP0xgbcmny24oiVvPJVFQN+kQs7YwCoWlPHwNquhKr
         yfg6kaRkKE9/WrNiL5xi91VdIdrhb5t0/A0CJOBmcOUr8AFWyTOZAdCdyWdYGaO4+8L8
         KGKGVpJFaWNTeTYno1OwbcKijc5x0PR5nPIIskWTRnPr0uIMB32QraY/0jU7frN61xOw
         yIag==
X-Forwarded-Encrypted: i=1; AFNElJ/Uyo1dFrDiSONXwoL+uiiRqnTIboVSpb2P0hSIPaaKDbbuwZusLgXdFeHCVAhPFcKQke8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCUl1Ba8awPqT/gOnAGRtLU73KzxByviNZJKcEzat/s9XCYb1
	1ViYeWIv2H5efcmKIeg7KEJjAgxak4kA3eNsGTHu591LbKa0lTA9stcCa2Plb1hDtvzkCYlUdgq
	vigC4/lO/o4Spq87IAl1aiHacihtWd/Q=
X-Gm-Gg: Acq92OFpKIwl22IDp452j5W4UjesD8529VWOU1yMcUDhSRRGwiomfzlURtAJkcrUNPo
	OCys5RJCzyOZy1S6dt1IRo3Wvpn4o1TgSzE52XxEBqHHW4jqJa8IlPiE45jxfHZlDJwJjc7vjo3
	HF5W8PCnrkgv2JWgMXfCUi8LtS+jQYJkbeZ9vTJQNIGsrkkbOXAP99+yQNsAHFX/Pg0am/VpPBR
	Evf9Ynx/OOuRVuOOJ/U5LJ8F9VVTH/uKuC0ugam9JGr8kNsLGAv4KHPhXl1oiiU2JYqJlSJlUFB
	U7vhE9OyQtys1gqiPC2pjAEK7OQTAbN074P5fdtWFcSKlq+CTt2s0bzICCu0le2NSv7QPZCksxt
	GPBBcEKdCEDagBUPOl7tijOAqtfHsZEqjXJG3
X-Received: by 2002:a5d:588b:0:b0:44b:7ec9:2d76 with SMTP id
 ffacd0b85a97d-4515b056d5fmr43891510f8f.7.1778559863458; Mon, 11 May 2026
 21:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com> <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
 <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com> <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
In-Reply-To: <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 May 2026 21:24:12 -0700
X-Gm-Features: AVHnY4JbmRmoLiyIrtTCPPrLDOfNzNQqeFWDcIXyHeMkB4ngpaEfYyyARPA0-E8
Message-ID: <CAADnVQKfMHUZ8YzLkWW--f1G_+mx6bKdvVHUMArYsb+6-esWCA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct
 kernel access
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 8:49=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 12 May 2026 at 05:25, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
> > >
> > > If not, the best course to me seems to be to make the flag behavior
> > > default, and just rely on ASan (and Rust in the future) to prevent an=
y
> > > memory safety issues, and drop the stream based feedback on fault,
> > > etc.
> >
> > Agree that this needs to be new default without new uapi flags.
> > How about we tweak the idea further.
> > Let all arena pages be unmapped initially. bpf progs will fault
> > on them and will be reported via bpf_streams.
> > But we also prepare one "scratch page". Let's use this name,
> > since "garbage page" reads too dirty.
> > When kernel faults we populate pte with that scratch page
> > and let the kernel code retry.
> > To implement it the page_fault_oops() can have a callback
> > into bpf/arena helper similar to kfence_handle_page_fault.
> > If fault address is in arena, do kfence_unprotect()-like.
>
> Interesting idea. So I guess this page remains mapped once kernel
> faults on it. I guess we can still reset it to NULL if we alloc and
> free a page at the same address, so it's just a drop-in to prevent
> further faults inside the kernel, since emulating instructions is ugly
> and we're not using asm wrappers that have fixup labels etc. If we end
> up allocating and freeing something at the same address it will likely
> get reset to NULL (that would be ideal). But even if this happens in
> parallel we may fault again and then will just fix up the NULL pte
> with scratch page again. We can likely also preserve fault reporting
> into streams when such scratch pages are brought in.

Yep. All makes sense.
The hope is that faults from kfuncs should be rare
compared to faults from regular arena bugs.
So the stuck scratch page shouldn't happen often and
faults on unmapped will still be seen most of the time.
