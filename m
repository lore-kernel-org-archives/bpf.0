Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793185258;
	b=c4jeVx9Zji2srmHaD5nPA2ybnaGJxAt+hu5prWxz6jH1PcQKQsCGX7lFV4lxrkRjOJZ0
	 XLzYs85YbUhLzTzZtQW3HsRTqO1l0YNYnghT6/IpzQ43aLrcv/P2chTPqGAeSVpKDCSP0
	 8X0o9Ag631hMxDAUNfDwBtI8KLpAJ0yxJ4+YTxg7eVrtFGJvd7tQXBXuAPJVn/7F6PdEb
	 SCXxXn/bO1yw+ePRCZg0F7PkgbJWzvUAEjgg4VjqgNMkSclu9BLEHnkuy8vW1Wj/vT3q0
	 GIPbybzG5Ms/QzAcw6gXPGeIAcH7sfhlDGgbO+jyVXsNZDTYHgJu5tCFh5kvJNp9g/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=IeSxBAd8x5bprjGrf/TJXdjLW3ORxdW828S6D90xodc=;
	b=KM3ZnLPgKhm/C2Nzsbnx6YDXfvaA44BnC1+29BZH+GElL8SoqD/qzectJq1d0c1I7jTz
	 SgCFZKsV+nKVYNoiViAMyUfFChctCg7QocndqQ7WKTGvY8U1UKkeKLBDh3Xg+WAts932P
	 YL40ZX+YMUyyRSB8gyaY9ih4d4xvsig2ckVaW65OEeTcDsXvnJJK0NnYaQYF+6N0u0Adh
	 BipZKX9d5nCFYqGKlQqNCyuk5Btn0TJEhzDwwU4fOBSBTOqB0l/Y1GFC/f3gA7IP3eo39
	 xZRcj4D6AZF1ITkEjTxvb2BvcbTg+W0bgnN3qgudoDdKpNb9KGMyYrn3HNwVeb4yoWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tV1ybIHX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.65
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA4606A337
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6DA4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tV1ybIHX
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-48df388215cso229441f8f.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793185256; cv=none;
        d=google.com; s=arc-20260327;
        b=DlspgHRA5fic0Eyj1flWKRC2qJkFRAWCOI1hwl4xMp6IF3yTWR4SZYS0OpwHWQKWV2
         qLKKXoWv0AXlp24H7qwHLvEjM4c6xMRNQ7ByGWRCNVvHaxAbDkKnl3s6wyktuYIyXZK1
         zXdGnvYox2XNiI8vS991ehZxpZiTN8VgiUVzh3HENGrETBephjx5VoV+T7ImxYw+B1UD
         uwhY485LaIuzJ6klRcqn3SQDJAVO0PU49ibon0e7vDNWv19vEIQTrU2MVBDPMkYQIH5X
         YA6qSDiZmu+NEKphI7C7Vho7VIEmUAam5OS+68K6y+52aXXCTFVXZh7KNfDEYdRqFjbi
         +kgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IeSxBAd8x5bprjGrf/TJXdjLW3ORxdW828S6D90xodc=;
        fh=nK4o+E/nKAvNbzKwQovufHGBef//cfTPEviVumPIXzA=;
        b=CzZh5J2yEoTlkv8yrefJkYR2hfFe50bHD8jkwUl2s94kMaiG4kwNQCMLjNBURL67mC
         QIHgL1FOH2nVrl7pAM+bdgVj+QY3+XUdRzIIN8ZUTXxPGQsOtT3c0I/cM41Q3/cPfMWc
         TNMzZB7H007g204XABRuCFZWjB9vmr6lDgBhBVR2I3rQbRsTq+8hczACoy9Wa0k3Ng6K
         FQeqq0QluEfF+wzdVZJO2ZGczZXuN8shdSkAJNowRqDu6N/sEn7bk6N4e8B4mHz17TTS
         FqwbtucCy9iHLbmwVMuoCorKfy50QGPHIE0haPhlygMAtIyPQwQ4LYLgKRg1ph0LhUDa
         gp+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793185256; x=1793790056; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeSxBAd8x5bprjGrf/TJXdjLW3ORxdW828S6D90xodc=;
        b=tV1ybIHX9fX0Jx3QL0hD7fiuKDmgVTF9W5kLjfyQ7763DMbXv1Qr1HPC6dGGTQxfq4
         zfoBkpwjFsFhUAdhsjWTQ7LEAC0B6YGsFFJ8iDjPMnWzWwEk3YypKH03KH1hVYyE00o1
         bwOOxX/MpliXo5iNpC2ySot8s4S559P9oyBPAA3F7v2jKQSR3bVZr+8qeZVlyt7ZJyNN
         Dr6/vGaoJTThc+Nz15xDFaDHLpAAqXUgIIcXviH8mP2DrmC4DyoqXdNxL52WgWqfi1FC
         EtHSEnVWtHgKXTcYv6Bz/1HOsekUQk1JhhiB9tNo522fAuLtyNFziWA5QvhIEGFDHMJT
         PGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793185256; x=1793790056;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IeSxBAd8x5bprjGrf/TJXdjLW3ORxdW828S6D90xodc=;
        b=UNmSoajyidHUTQjaB77TDIFFRS0+oo6hCs8oKxnXEaV1jPuFl1iij7WrueZwQpoOcF
         gtcjBYG50yS2uZpOpJhwKnto/cmVjek3bwzbJYHVf0/yi6VxrwNlF0/WnPKNHod0eSu6
         WMpX3N/rw7eodwC8wfZ+VSCNt4e5psrr1doDb1PbmdHGGRKn2KR5+KKUIJScZtIsIJby
         Jxer428YSGV5doYGLWCp0YjFE9steVzRlxnTftZwZ44bVrnWj5on2IV2N4hkJur6o+ET
         gCRAnS5oct4/EdR15KwceFymoja2jsh5eY9BVKOsjOjkywT453cYZK+Z1sESWPsgseYq
         PxYA==
X-Gm-Message-State: AFq9FYIryKnONtsXgq7bQeuPSd/Z4WNYF2sd3QvUdpHwR2VA12NOWM5n
	Lk07CidaI+KQaACMH3DS07H/HJ5tIu4CyuJ/KFRC+H68q3adKggEq+iWmUU6N0HQsh+UVtoR5Z9
	MoJxqpAaT57VSlLQS27DM84SnzqH31Uo=
X-Gm-Gg: AYBFou3J46+UCO9zNzvgUBOIQjbEdMzl0p/Hj7ZtRNn1aJxxPTu9gPT33eyCSIWtPRV
	XNhR1U0ouMFe396zCc+jgPeBcVX2u0kmmk6e86bA3RmlWPKbTKVrNlVE14cwAc2/zHatFoQhVVc
	Wht1MC4VHzVb9tP0gcmZ+Bv1M2qHpUjm00xm9xLnFtu//inq1Mls6nQGOM1RuGUo7FmbFJHZpAt
	J64eyPUyLgKK2LMtOo0znxLVCcAM+Bei0TE9k16F7FG/EABNcjNC0fe4Ol+QrL2a/33CEZC1ehR
	TaIk8pKc+h5RoxvFiZus5iP+Hwcdm7riwdaQscnjxjtlX+lwtePvVLH6jmLruOS82twRUsVS/5i
	yoDtm3k09HHcZQmq9rCdW/BwxV24RSoaXKgxT2D7/wlxLaXD1AFNKTo64BXehNhYtFbl+52hrA0
	P2snXkq8hNlb/J4G/SS3ILDWG2bvsqH1z0S96HWhEPdWJn7CYjskErehkIEPI4lRHcmRVrNEZSO
	hFILlw0YHerkpCY
X-Received: by 2002:a05:6000:2608:b0:48e:3fc:e393 with SMTP id
 ffacd0b85a97d-48e5d58cbd1mr4540602f8f.6.1793185254967; Wed, 28 Oct 2026
 04:00:54 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-27-alexei.starovoitov@gmail.com> <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>
 <DMF694XH2TJO.P59A31VE6GWP@gmail.com> <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com>
 <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com> <CAP01T74C4bBZntDNLrCxe02prWiF3pnUfYMFTUU6-44O0zbnPA@mail.gmail.com>
 <DMG76G7GIPN7.HQJKZIE5J8R6@gmail.com>
In-Reply-To: <DMG76G7GIPN7.HQJKZIE5J8R6@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Oct 2026 12:00:16 +0100
X-Gm-Features: AclHuK95SFxYeYe1iGMdfX3au-t04quMMCPFYgt4EDgTIkAav0X85EpZh57TThs
Message-ID: <CAP01T75pOz8Nj_YG13quoVeniq6908sY5og4RadfM9-tz5j7PQ@mail.gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 05:47, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue Oct 27, 2026 at 8:23 PM UTC, Kumar Kartikeya Dwivedi wrote:
> >
> > There are other ways to address this, like ensuring r1 holds fully
> > formed pointer pointing into arena at the point of dereference. I
> > don't think we sufficiently explored alternatives to this problem,
> > which is much broader than just stack and arena mismatch, e.g. ringbuf
> > memory buffer and arena memory buffer as same argument to the same
> > function has similar problem. The other approach would be testing the
> > value and deciding the form of access based on that. There must be
> > some way to distinguish arena ptr from other kernel ptrs at runtime.
>
> agree. there is likely another option.
> Please find one.
> but I was working on this since March and what you see is the best
> I could come up with.
> Once you find it I will be more than happy to delete this approach.
> Until then we have to move forward.

Sigh. This is not a good response. If you do not want to have a
discussion, what is the point of posting patches and asking for
feedback?
