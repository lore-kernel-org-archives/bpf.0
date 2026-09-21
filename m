Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4A33A9E8
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982933; cv=none; b=mzvDC01MmAh5YfHGUgvBuLGF8f8LWnkSijm8advD6FnHeuNA3U06RG47/8j41WCKX8KW0xUJ8cqZo3HIx2unXpmdzpv+AwhUJoQfqKEs/U4vQ1IxpRGVkVBcmD3j4V9mlDy+IgNgRpOJCzu7Nn1x4OZU44I27KMH8ePr97jlImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982933; c=relaxed/simple;
	bh=soObqg1EAW5LTZo5GTibZbkZdzGiogQLWMrL4HawB/E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ljV5x3BZgmu8EzD5st0UonZA0v8ycNeiO9I0AT6hHD2UMmcsDQ3e/EuTVNEcRAjLESQI2U8ud0NI4g3WaXSL4uXNjqs9W02TR4E4cgsRV+iuoiRSroORCgUiSNps5mxPAaibVvBLHRiNX7WcPKtS9mWnG2PUVzr9Q3mGcmE+V68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbHgHeL2; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbHgHeL2"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-484392e3450so260209f8f.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789982930; x=1790587730; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=soObqg1EAW5LTZo5GTibZbkZdzGiogQLWMrL4HawB/E=;
        b=TbHgHeL2Evr3+fZ/ZaNUA1363mR8FIhhYkkGOfn0LvuUWHUvwSjuVDa9xyg7UjWFal
         40PA+aqubojb6CpEFKVP1qHTK1oKT6oJwvzRE+n2QRq5MjWPDiRXMlEWPg+9RdaOlkz7
         v76i/G5AC+SPMrcZp6ftmz0l7bzA9S7tqJGW7jO3v35LDE3klc3/2CRGfIS3bmlisMG6
         Slqdo+p7rxPxxktWPK5FkpXKtGHJm061fkw6Ve7060Od/1y8BwkdwO0FewwEmRfwKuMs
         4tNp4Zz4KK2H7Tv8xKwhOO/gDY+HJXvo2uEEBBkPeUdIUSfW2ZfjZ4WNcPofwFiSrnMa
         6gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789982930; x=1790587730;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=soObqg1EAW5LTZo5GTibZbkZdzGiogQLWMrL4HawB/E=;
        b=v+4JV4yDJfGj9p5GIr2T8cdKm+tm20Yfo13kD4+/WgenhKPtqKuzeq+dDfc3qSPjbZ
         WHx+psGUF1hOqpPKUu63JPxGOcyFGHY+3J68ruae6rsi6hBiqSBRpDl4gZrT0+pOYdLM
         Cuq85OXcQyh6drMgs4sqfyT7WGk6Z9+5I/xHn2Rzt9HL4A3EYLn0MIhE9BdpLK2oHtch
         lawyUI6G1MdOm/uYsMDMfXyCHspCQOxhbzcfubPA8EiD+xSauiLiJSl3F6R06D8eqMBZ
         dNSXJlF8SKZXeKijgpd85P3/LGgjKUQbrU4wt76pxKo0aJTVStnuqHq0cVjoR/NmkZjB
         dzyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDQSvk/hnZyZrS+J1kExq2m657UHeAWIuC36OkXxsKbkFMuxZhfLieBmY+TnThNH7So1o=@vger.kernel.org
X-Gm-Message-State: AFuF++ltIEOog4LHj7hj/QQjGNs13530k3ASH0w1S9V579SNRLDDdEC0
	NErC+fBA7vyAUHXaQxQGgbP9Ew2xz1Jhcdxc32jzOzkV0mjIGNWt4L+MlmBfkHsQ
X-Gm-Gg: AYBFou2xZTgxpoX4yHwECnst8qXhPGbSXHBmpMM51Yg9Inqp7v9JetmNEN8WpR7UFp+
	OPL7N3w9VTC7Uqbr87wo4+EWLuvsyr/QzF+lpqv/vmE/9eKzKVMhUEqF0ZfnWu87XRYH2wP7yMG
	gkMJ6gfvvzRa2NFWB6uERKnvtUBsFC3EHxh18xtoHU4l0+BnhkS+IgsigHRb/T806PKKrctKUKr
	zpZv81QsGK8kTeDeo6/4vezCMP71UFQWURPxeTDynbXN6ZSLaembpGKcum2b4HEeBMNbsKjHb6Y
	akrsFXbp0/PeBz4+xkKMRxyYB7D+vx2V6ot0Xk/GQVHIwlvqRqC3aDPKce2w81QJKQgqybCcQoT
	Lvm5SCdha8m2cQYO/NYnvtmAzPDHr1WuG/cako0rIw4AUG5VIFlSNIojigk3wNAB+n9JjFV9cL3
	o9J+u326gZe9IRL7kKEh7b5T4N9EoDZjX5JXwk3A0USRjPamhEkFU3jc68JTlsI0iU6Z+9XrL7I
	8T/wxEr5D/13Xdxz9FAXvz6NE4nElhurqjhA0wFr/SjMmecOP18yWNe1UbE0ZwRQJQrzsyXxlla
	nnEZlcFnq43kQ//1Rpa8hdyAKzYwoipF9TJgYg==
X-Received: by 2002:a05:600c:468a:b0:49e:7c8c:bc77 with SMTP id 5b1f17b1804b1-49fc4fae7acmr161080065e9.7.1789982929752;
        Mon, 21 Sep 2026 02:28:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d174sm226211475e9.11.2026.09.21.02.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 11:28:48 +0200
Message-Id: <DLKVZP748QOP.1VIVZ564W1X4G@gmail.com>
Subject: Re: [PATCH bpf-next v8 0/9] selftests/bpf: restructure the Makefile
 as a layered build
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>

On Mon Sep 21, 2026 at 9:58 AM CEST, Mykola Lysenko wrote:
> The BPF selftests Makefile has grown to ~1,100 lines, with much of the
> complexity concentrated in the DEFINE_TEST_RUNNER double-expansion
> machinery: the per-runner rules are written in $$-escaped make and
> eval'd once per flavor, so the rules that actually run never appear in
> the source and are easy to break for one flavor while testing another.
>

Applied, for any other comments let us do it as follow ups, if necessary.

> [...]
