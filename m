Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703486;
	b=jjaZj34HnTuGUWC2XMR6B/eXNRu4x6ZfS+LFP9Gy8K41eBNFA0bnalaeNUCPHFMIKsDB
	 pTsN8cr4WxOP/v+9x6fVJZU6503QLrFL5SWC/FMcDpr3za9r0JRhSHQTJ5jEkWlrneb4x
	 M0WJmVKwbdTmitBNmO4JwI1TlNgmYU2sPt3A6KAtjriH03bf8p5C6saNWrzVvj0YWd/Jx
	 aso6SUovCS+nGFl8FRO0tuU7FxSrYpm88CC6LT9GAl13TROVI3O/eS5gPE9mfcC+pULRP
	 ixBkEGko4LBVCiDG2xykcGOcAQ21CCVbuuqsEIH9B4NVlKOiWvT3i45HrTqpmzfzKng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=KTJ3uXdDrmXkUBWLJ3C8ElaGH6mAEKbpJmzM8ieOWYc=;
	b=ZurvpDHbc579QbhBO5QjQ2nKoVpBVo25xJpTCYU+7JlDef5jw8g6oWoJmi7u1/MPdzDy
	 c91yil+7j1oZlXNiyDst7fs6atTqEsqDE5+uLOgOPvnps0jWT8sJwPTvHnv+tPUMkZTV/
	 7zwlbPUfQhABCtXThWK07PDufI3h+lSops+dlgD0Y2Hn6p1r9BP+Ef22QRvy0YXL8hCa+
	 j+1p6iptN8esujRGG265aQ8xzcs6pA8+pnG8G4/toVUzJZygEojkCCCQnXCEk+tlWJ4ti
	 cKvnm2jBjiTk+0Ll/JzrQca2+wziBc7e3KLld6zo3yg8oKVaNs644PAV9e+La6VEjJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QfbfUufa;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08476606A69B
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08476606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QfbfUufa
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so4187121f8f.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795703474; x=1796308274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KTJ3uXdDrmXkUBWLJ3C8ElaGH6mAEKbpJmzM8ieOWYc=;
        b=QfbfUufaZ410v1UGNdOAr4OWJqZKQRNCa6jcgWJyl+ZJiAHjwpaj+05E0Raduj6Ncg
         z4Zo18BO7UnWj5+HwzH2+F9HP2PGn2WRVLMF5IqECTwvD8jqgxk3Sdg41QL8lZcYLq7S
         4BRX5q4N3+bQUp5vSUHwYrONx4gBZcE6KOBTAzhaiCD2yTzL6LOHXXcT6oQpNmE56iyH
         4OSLx3rk+gXdjgG++LmiToF9EizECXkgz1bu8bVfbBfYBxXQKej7N965tD8vvjhtaNTg
         vQGLKjjHVy2ooGhPG9R4SEQVh7jHEbE70n5FKK2ND7hyMSpyoZMmumIi/FP4KaZ+uWJ3
         u4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703474; x=1796308274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KTJ3uXdDrmXkUBWLJ3C8ElaGH6mAEKbpJmzM8ieOWYc=;
        b=wsF2MnMFEe7rAXAiqGmTuK/FUqks/Dk+oi5XAdhlrnD20TRE0mBHsQ9P1N3bV1c+kG
         qQAuouxC0ZxjKgCDDQ+FXcEetsAK9bzN6pz7mB/r1P+8MqjnnyemjWLBLaebxemf984g
         K5AT3kA0Q+KL12cI1HjLwrotGSX6djt+JK38lqvNzTAYJonvZt+wQQmtylruEBrJ+RCd
         vA9RQzMpQBVH5CqmVDvdruyJpG5RZ1b1kxmw/Kyhma5d5CwSpBI2wfzSm1oHMwTzRZkJ
         LJZZhar/+DJCXhipgwrZcUYiAokxsla9JJf/aMcJUcKP42C+Gle4MtpZvixH8Z1fcXA7
         h/EA==
X-Gm-Message-State: APuU4Z9dI+RaHqAViyHRGTN9zLGGw/41es9AS5YYj4WXhGFuJuQIn2S8
	Sq1/rL49rPQS3Fwz3vPQI+GYlelZZQc24i77nBawPWSVNqGxxaUvqDNP
X-Gm-Gg: AZFdTZda6DWXDTGAXt+GoT3y7V+jCny776U0LzqsIA1kuzp5Cmhknwuh40MiRc7TALR
	0q9s8TTR0bBT7XAnSlw+djQYemNDY5gPJ/rX6Siw0lQ1wEclATNJuBe0iqKPmrxiiDDYKdeGNOX
	5ikUpzu+OB1PsVhsyAgZn+tOiieoCquAwp0P+qT8pFRtq/FaKvcnEXe3LpU4XwgLsXQglC9eFsl
	fOo3dTYyQkYTtv0YIP3SdiB5WsxtbKe3Alxp83zbqPQuB/tZ6VlO9az9puWq7IzsF/ztpWryOlB
	4NjbDg1GFEjTBv6329cTI8/e9p6wU1BxU4O+7mcT7XRNximv4FO+mER3u8/XDKDIScyLTm1GfK6
	j1eJJmlkp2DwoXXL0NtOnL76uAjaZcrcjALLtpFFJF2dwMYluyrkCFsnacs4wiik0m7HYtiR9Pj
	kmOUtHb3K2gdiyYg+IyEhxcxACEK0WiyjX4z36hu+8KBE1ZvK//WinHqKXp2brkqdIFFGiHW3Sj
	uEr6ZeK/UbyaMCCiCzPhrt62MXKc3pljj3EU+iK02RXDQ2jXtsJ/uBt2fh2oa5dlhcV3HV2ldWb
	HPbarLv96FziRm7GLYA7CPUfxgPRzWNJ6Hhk9Q==
X-Received: by 2002:a05:6000:4b1e:b0:4a7:150e:cfe5 with SMTP id ffacd0b85a97d-4abb46bc772mr38698916f8f.42.1795703474305;
        Thu, 26 Nov 2026 06:31:14 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad6403fdbbsm32157631f8f.15.2026.11.26.06.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:31:13 -0800 (PST)
Date: Thu, 26 Nov 2026 14:42:50 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 2/7] resolve_btfids: Do not tag functions
 which work on BPF objects
Message-ID: <awhFakVOoCYNR0T-@mail.gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
 <20261126142915.1106330-3-a.s.protopopov@gmail.com>
 <sashiko-outbox-235703@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-235703@kernel.org>

On 26/11/26 02:27PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] resolve_btfids: missing Fixes trailer for fmodret_tag() BPF type
>   exclusion
> --
> 
> commit 22ec6a5284d69e95482c5c70ca4fae778848a0da
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> > resolve_btfids: Do not tag functions which work on BPF objects
> >
> > A program on tracing_iter_filter() which returns -EACCES makes the
> > verifier miss that a global subprog throws. A function which takes or
> > returns a bpf_* or btf_* type, or struct btf, works for BPF itself:
> > for the verifier, a link or a map. Do not tag it.
> >
> > __sys_bpf() loses its tag. A program can still deny a bpf command on
> > the syscall, which is on the error injection list, or on a
> > security_bpf*() hook.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [Severity: Low]
> This fixes the tagging of internal BPF functions in fmodret_tag().  Should
> the commit message include a Fixes tag:
> 
>   Fixes: 4dd950adacad ("resolve_btfids: Tag the functions that return errors")

I can add it if robots continue to complain, but I am not really
seeing why.  What will this tag signal?

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261126142915.1106330-1-a.s.protopopov@gmail.com?part=2
