Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897348;
	b=ZUujHY8EfDyQUFdJo/BQ2gReAvjLvSv/vnCdj5SF3IhicuHRDPA8imsaZFSIEfjZsQYs
	 lUXmL7ZQNzFvPNYdl7I/OMFQkzWTN6avlvwJqTwkdSKC5PkUzZBr16/tFg9MepOOSz8Zs
	 KLJABby5Pj33koXtLZ0HMjfrc2JTxDawY9nBcV8XUboBhsGQs7/XYZuw6kwNb7zfOcb0I
	 ONNDgwcRYv0OOndnpcbxrf9q7/9Jmj7XS86yvPudj3z+JcRIWT6VVPLqgTWEJtBsDvgOA
	 WTBGyhSKCF7D7x/Nd0Rke78rHzXA3QuT45ig2p7TNGx0l2P2Of5GDlcqiWPsyfv7DWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IofCeiQ6JCwrlt7o+A0pBeIgYyuiwZInCjl1yfHCeTU=;
	b=x3jaFa2kFJ3KiBBSa6EaGuMuVc8j4m/73UzbHpPjqUMMlVyYtF0Lh9ApZaV/B+iLk8sv
	 qjnj7X7sFmEBwL3iiJXFBmb0ZFXvfPXTBecIZ8fV3Hf8W0UICIj1ou8J7CvfJqWJnjiz+
	 hAfIw95IS4QpAznJV+Hmw/go5cYVTFLuL7NVqKnxb9e41U8zdbJx5FIGyDb99CeD013jL
	 Jef5koLp1sn6hsknQtKc2pUWMFbkDorfpJxmtGFYquhKt0GUH/Bz2P5e8rnCVtojj/IjJ
	 kmi/ueUvaptRac+GgLwRSvnzzQCdXMQEhhiSZCCiztBQuyA8qU2ADUSDlaGb7T1PdTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=alanderk.com;
	spf=pass smtp.mailfrom=alanderk.com;
	dkim=pass header.d=alanderk.com header.i=@alanderk.com header.a=rsa-sha256 header.s=googol header.b=qSOwI09+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E9606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 16:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56E9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alanderk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alanderk.com header.i=@alanderk.com header.a=rsa-sha256 header.s=googol header.b=qSOwI09+
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490f38e9688so829470f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 08:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897346; cv=none;
        d=google.com; s=arc-20260327;
        b=I2xnaLoRCu5O8lA+Zpft53OV65sXuV8gS43qmjDj25EHMHoK2K1LNbEHY+SOHa5SLi
         V4MKaMkwjtpBnyi1sXgOlGT5pCRkAU/+y1RH70uCWRsKIoG2TFbm55Hj6ZtqKN15OJCj
         1PFF+Id4UTzSYfGKJveO6S5RovUSnPxUBKgMSMYcubOHwSQnTbbmDyLEpCObgD4miTiF
         i3SCUSxUZzt1d4vbWPdkRFxUIOoaHhn4A5i0Oc9izSqqyL2NzTSp7+rwCrj27gTXh9ue
         WM6ci3fb9HOayi9dItuv9onA60jxQAz2hhy9I71eNcFDTGoN0Bug8KgmUm7yVQ3msc5B
         KImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IofCeiQ6JCwrlt7o+A0pBeIgYyuiwZInCjl1yfHCeTU=;
        fh=9n6JoDthrjqP9cqSOlwc9nJOoMpPhoEhYjccpmUK61Q=;
        b=Hc0WIPLSFA0XyQCKOPcJAywQ9IjCkoGkZjvPlvtIXq6iksomEydMbLrIwwrW3KWLkb
         S78JkhxMv5OpD5MAibLLXaIeqjmuwA9Pp2pxAFEt3S1VP2woY58LYZyMGNP1QWKsoDxk
         cRoPWGQyb6N6f7dGCiu16e5LKp5Hj1dJME98u2vpyuQhqyl01jCoDBym8STq6VWeqSL8
         jSTalWqdNe+igEGeeUmUwis7aAVIxA6u1YHoB+UX7bCeD+2X0QBZA8miVeVQn9twk1dY
         3BEdq7AFR89LmWRxsXU0mD6B4p+O3pc975b4KwHir/G/kNt49KzSbZdEK60Y1Aj7h/mQ
         sm9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alanderk.com; s=googol; t=1793897346; x=1794502146; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IofCeiQ6JCwrlt7o+A0pBeIgYyuiwZInCjl1yfHCeTU=;
        b=qSOwI09+JE7d7rKoZkTU3eUrTNzAE9STFkM9DkSP5Ze3kh3+lGIldrds9BDVDerlYw
         pp//qNE7JkxJL9n7SS97rNb+FPrL+U++gh0zccNBXcjvS0ZIgjvaT0ub4l2dWeyo+RWZ
         Cqv1YScQhGQYy0+XyJcz2v7G0Zkt2vrkzNBiCVOyBg2nsT/fVxGjNEyZFPYcuPic8MAY
         FQ8EAZlWN935gPO0mt5Mcp7TvdPRi+uJgXfyH2E1b7WcwlhUh9x6ZOWSwrghwqktlIUJ
         /4/1d/HG1aNeX9bfvGugyY8VJ6bAAwVbhSD7dZ+72aWlA7HmPb1BZjCm0DCbrrPRMO7l
         t2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897346; x=1794502146;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IofCeiQ6JCwrlt7o+A0pBeIgYyuiwZInCjl1yfHCeTU=;
        b=cTmwqWSCxBRhPGsb4QDbqN6NnK8Jy+vv9DG5m6wzGCC1F+pB/vSDcW2C+vdecZPf/r
         Ep3MOIzLgSlVp2uh4o1uQ1Jhe1DQlpwjtpZu+klg5j32BBhgdUO8cZJFM23Io85lzijk
         wg8graS3IFeEasuOlIvZyrIcuRMA0ajJTrrCYTdHmHKToaq4PPy3Nd5J7LwRSVl4MELy
         dbv8N6RPawfFJVLgj8PYpmkhYxV5r7FCytC3AGffeQBKMoRj52cRqxHxhEkGHb3TW4X4
         ea5tPxnXE+3aYspwcbGfoSedzAjjILDZsOvzehip1S32PudB/sCNsADPoiiEL5QGPwic
         TXYA==
X-Forwarded-Encrypted: i=1; AKwUvBwCcFFeAPAF4Ihk/BCpEZHJSqmQiU9pTrjNPSQObjX+M+cl6p+sk8B2+bc4etVfhJcXcXM=@vger.kernel.org
X-Gm-Message-State: APuU4Z96/NqrL/Pc7TVtEVkZvH+aontSu+uQzo/zcm1DJhCKc2yypup7
	eWg7q2zoGseNuuQB8UUmnN8xWxqoths47laORi6Eh4ZRbxjySlWh9CEDPJcGMNMFkJ/JM8E05Bb
	k/q1liQcKNOYT/2qMJCK5Copd0TdgckzBUXWiKOrxug==
X-Gm-Gg: AYBFou2M5CqGAWoJPaHTsGz3BCjE42Hat2uVYaUfXtS+Uix8w9HKBrZod+FZnnt+AW7
	bBbeE47WxpQbCGv4fVf41W3TzK6tcgMZOXAz4uxGW76bwty5bmPNHtgJJM2c51C9qK3u2w4rStK
	ku1eqzNuTZRKxGfshS/sFMLWg1czbA22yKUhO5bC7SbXD3xbQ60KypISlJzK9VPDyWFaQqSoQpE
	IjDfT4d82stsGjFP9nS5WMqZKPWljKIb3NZz5InD7v6WAU3CRQkyR1T4wgM62Y+ZW/q4HBi07Ry
	0Sph81hyCHlANCJCTmjCrARsonT5rpXWzL9sEaeZDTc5q3lWRsI1gQuF/W1T5XcNMbuhVzieu/t
	umTiD6pDMg2tzCuMvjTXb0rVI80VGuDYjt5lKFzZ7lWbqwsoy
X-Received: by 2002:a05:6000:4a1c:b0:490:1395:9b00 with SMTP id
 ffacd0b85a97d-4911906d26fmr6264775f8f.10.1793897346089; Thu, 05 Nov 2026
 08:49:06 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261010005227.976-1-linux@alanderk.com> <87dfc1f8-6ef4-424c-a48d-62e935eeeb28@kernel.org>
In-Reply-To: <87dfc1f8-6ef4-424c-a48d-62e935eeeb28@kernel.org>
From: Alan Derk <linux@alanderk.com>
Date: Thu, 5 Nov 2026 07:48:54 -0900
X-Gm-Features: AclHuK8vKOu24Bc8kFqanAhzIarNQKxJATur1LwcU5SeZGjflO0j-bEqaeTReYM
Message-ID: <CAPLSpGbV5RTSuMZPX=UgzniPtoT7jup7pCGw_Rt2tqiejKXmng@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 0/2] dwarf_loader: Fix --lang_exclude on merged CUs
To: Alan Maguire <almagui@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 4, 2026 at 7:38 AM Alan Maguire wrote:
> Thanks for doing this work! Sorry for the delay in getting to it, I'm
> looking at the patches now.

Of course. Please take your time on the review. And thanks for the
background on the Rust BTF work.

> We've been working on a solution; essentially, the idea is to detect
> such cases and fix up the type graph in pahole using a new
> "rust_bindgen_replace" feature so that the final BTF does not have to
> carry such duplicates. It will only run for Rust CUs, [...]

Patches 1-2 are general --lang_exclude fixes (both reproducers are
C++/C). The Kconfig follow-up keeps --lang_exclude=rust, so it is a
stopgap: Rust stays out of BTF, as it does without LTO, until
rust_bindgen_replace brings Rust types in. I realize it may not be
worth it, though it would -- if I understand correctly -- unblock RUST with
LTO and BTF in the meantime.

To check how this series of patches fits with your branch, I applied it on
top of pahole-next-btf-rust (b5e46f8; it applies cleanly) and tried both on
the 7.2.9 kernels I tested the series on (x86_64 ThinLTO, full LTO
and distributed ThinLTO, arm64 ThinLTO) and a non-LTO x86_64 build,
booting each in qemu and loading rust_minimal, rust_print and
kobject-example:

- With kbuild's flags (--lang_exclude=rust), the branch alone fails to
  build the Rust sample modules on the LTO kernels, as patch 1
  describes. With the series on top, all five kernels build, boot and
  load the three modules with BTF.
- With rust_bindgen_replace and nothing excluded, the series changes
  nothing: vmlinux and module BTF are byte-identical with and without
  it.

One thing I noticed along the way, since it's the merged-CU language
that patch 1 deals with: under LTO the merged CU has one language,
taken from its first CU (a C or asm file for vmlinux), so
cu__is_rust() is false and rust_bindgen_replace doesn't run on
vmlinux. Without LTO it replaced 564 types as expected.

Cheers,
Alan
