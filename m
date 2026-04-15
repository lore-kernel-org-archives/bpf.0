Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684730FC33
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269979; cv=pass; b=VupWksEMwABaDxOxEbLjZMIR8A2F6VXg394OiQfGb1ZULio0+joYyRQwWQHrTkrJOo1OFs4ps8OLozmmQ/1QlSaZ9GZt1Xo5pU4jFQMfPu46slXVkxcFUMtKYWfTMOWqAW0Pei/zpYVGEjxxUKBEFNuorJd6Ewi9sa+l/qBAZMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269979; c=relaxed/simple;
	bh=oCdsTV0XpcqBPGS4PloVavWlHEW2FTBfh6Dp6D8GJio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktKsMpfAE8LT0r5a9p33ZjV0/HA5BIA7+7ifMXJ6/6nsJwLsrSY3Jk4XSQMXNdKepKZGQYqgoHCUvikz1yPj83YCuVS8FST/ss97aXNUoHUK0nkIDD4m5EJnE0TM36heZK/I/BWYjJ+LylLmZcMULEwZ59TvV7KFhxvFn5RD3Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCPZo/IP; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCPZo/IP"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9568bae58f7so1961003241.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776269977; cv=none;
        d=google.com; s=arc-20240605;
        b=TDQZPpYVNcjOyA2Yi29m3HzEyHSQv31YAjSQIrK6qpdM0N0DYAsOOn1EBXAN70Jizh
         etLWQNu4cPoCuWK2zFe45vE5JOkNj/L1xw5yuQKvdA55LVKiqGe2oYJTsDQWGRzTUo2s
         tm7YkcpzV/zAvLk2AoaSveDLx+xznYfhxHkwFKj+NcV5aJ+rv/LD9/0MnvggmHxahkXg
         ZCZ1zRd66KG/fvPm+s3+1zS9NK2rua4i3Nnbe6O/r4M4cGITUyQLZiB0wxenyzEbvp9i
         GjbyHYvfd3UiJiTW3QJfArM4yHQHeE8Gj1VLywep7K0jWQdD7FQk2plc8CFseI913iMx
         reDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pe8hiH92iDJdEn9rbEI8ZQRlaWpVtE9fVS0ctg1t8vE=;
        fh=BZkfAmod56eUl5CfG+CPeumCuRf1UqWIbYGUdpTFNg0=;
        b=cfggwrr16lUSQhyT+Fn2y1SyP042l8ddd2feablQCztKAB7ieQC0gU0CJeKaoDf/0R
         s5fmVKW3MFvKkq/6obbpax220snr7vXtqikcGJNv6mUHmjjnb8BKdI11kRxEdyhAdvVF
         LB6YpxGbRCaSO7f/Cg8n+6CrFQdgsxZ2jopHpp2mGQyM89zimTMqFdzObkp4Cpoqg249
         hzOzqxkgYkY6z3YrxZO1NScsz1dkGFo/wgyatDyo/rvawvU1H2SRZoC89QtznI4NRR7q
         hG98FNnRDR6MIKy8pPyENaCNNY53VxMbWdvkyHrCGnqO221pyWgeqf8ZBgh7+T0GatO3
         j6Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776269977; x=1776874777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe8hiH92iDJdEn9rbEI8ZQRlaWpVtE9fVS0ctg1t8vE=;
        b=cCPZo/IPWFGG32x4wSQ5SX00XDe4pstz0BxY4qj2C6b8nXdsK7hbMQbSm+HVKNhQRu
         7c+Nm0jQisGbqjYbwOB6pJOeyqNa9RGxJB2Ox6yE1h+Puoo6/tKkrs/3TFVb/V6VJxZ+
         K1a1upMbvVt0UMNum51+wCONNHxXVopN74lurOjg2z5Sltj9oASYOAu9nRgelSZ8lLQB
         yK3ch22QOz8lRIYTYLRKfkz+bKB7oMv4/oKTKgjjId+ofCn+yagehYaYFZo0yWdhJ0/d
         YhCZZMqqk76nV+CVn0EwJW6Zl5QFJFzc+AOdeMcLfNi4Mx8z/XbfpB+DkyYjRvHaa7Co
         +hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269977; x=1776874777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pe8hiH92iDJdEn9rbEI8ZQRlaWpVtE9fVS0ctg1t8vE=;
        b=GQhl6YNcxHtPXmC5DGwiyL+EiVETMCKlTOpuhSdnrKxI6VCdA9+UpltEnEIlW7+70x
         LLpMk2tDZ/vVquQOwpAXXllzgTeBHdXZOHd3SNUs8wiOpzRcX7jlr7xtQ6YTT3/5AMsQ
         G605VNgMrcdHfH9SzqdW2KmB7EIx99MMgyISk7Od1qVGEFAPTRLHPEsC2j5JO/qK8RX6
         LNdfrnf+IUs0ZJGgYchdvtVgTixgcvgOpidri0zwEli60m3Hrxl0OFL0uv4dEswhaoNp
         X+aiMySAIi5Mb1RzRsoZDTveyQvnuTif+55zKk7Z0Y8CX+mp4guYO0xHVgc9XE+fGjHb
         6Ieg==
X-Forwarded-Encrypted: i=1; AFNElJ+jtLVTi2PdWqGFG7Vkc3PvymTvvba/TY50Z/L2P6gqDoGms5311isXnPmtKuyR0/ltFkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xsOEcvkHqgTNeo3DB4k+CNn4fyavbFUtwP5PnxjPixW5Tlsg
	M30MsdYj40q86EgoCye+xtSctmyFu/iIbf/tGT8Ow2rj4PJzgkvnU+sOxc+5dsFeviKtwEJ3WbL
	bl+xFiIrKgGG2VHLY3uCxXjcM4TrxGw4=
X-Gm-Gg: AeBDievQDNXPqCYb2WxKicaI681YTZ8zPzKzZv+NhcBpjFBsfFRH31qJP0uyMCsP5e3
	/g72cbY4z58Fjx1iwjTgsJeH05jawVaErIctB5EJ7RNDkiK57dYM+L0n6MBxjYXedtKGDxf7Y2G
	OmbwKxcgbp7ueERPB58T1L41PhaONEO1BnjI/xIMZvsU4XVWEVmcJENWQKkaFssq+KJsMe/F1ij
	vro4o7SN/lny8HfoptF+W3fQQO9Zm196bmg+LNjqQ4TINpRTl8x/1PHZ8lz06idMRKUxLapub15
	44fuPWcO1FUt/cJxp2ttvjmyUYIRtWwOE/Y2njB58w==
X-Received: by 2002:a05:6102:291e:b0:602:b037:4de8 with SMTP id
 ada2fe7eead31-609fe8a45fbmr11074385137.4.1776269977334; Wed, 15 Apr 2026
 09:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410124035.297632-1-koike@igalia.com> <16990d86263fb24079e6f0b476a8854ec2366932.camel@gmail.com>
In-Reply-To: <16990d86263fb24079e6f0b476a8854ec2366932.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Wed, 15 Apr 2026 12:19:21 -0400
X-Gm-Features: AQROBzAHpPLL-UpJJSlWpMh9yg39zfQN9ywasn8deAfHRBG1cOH1fWflcIcxyFU
Message-ID: <CAM=Ch07+xVRHvRJBqQukCrU-br=HHyFWbdjbP+vOB6XKaOOYag@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Helen Koike <koike@igalia.com>, paul.chaignon@gmail.com, shung-hsi.yu@suse.com, 
	andrii@kernel.org, yonghong.song@linux.dev, ast@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 3:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-04-10 at 09:40 -0300, Helen Koike wrote:
> > Unify handling of signed and unsigned using circular range logic.
[...]

> Hi Helen, Harishankar, Shung-Hsi, Paul,
>
> I think this algorithm is correct and covers all cases discussed earlier.
> I also prepared simple correctness check using cbmc in [1].
> It shows that for any valid input register state deduce_bounds_64_from_32
> does not loose any values (check_soundness() function in [1], which valid=
ates).
> It also shows that there exist invalid input register state,
> such that deduce_bounds_64_from_32() "fixes" it to be valid
> (check_invalid_preserved() function in [1], which produces a counter-exam=
ple).

IIUC, this patch enhances the new deduce_bounds_64_from_32, while
also having the property that it "maintains invalid input register states".

> Now, the question is whether we want check_invalid_preserved() to hold.
> Harishankar is working on an extension to simulate_both_branches_taken()
> checking for additional cases of invariant violation.
> Disagreement between 64-bit and 32-bit ranges is one of such violations.
> The logic in deduce_bounds_64_from_32() can be extracted as "intersect"
> function producing a signal describing if intersection actually exist.
> So, the question is for Harishankar, would you like to have such
> "intersect" function?

I  think using the new reg_bounds_intersect() "intersection checks"
introduced in [1] to exit early in sync is still useful because
the other sub-sync function might still "fix" the bounds

[1] https://lore.kernel.org/bpf/20260415160728.657270-2-harishankar.vishwan=
athan@gmail.com/T/#u

> [...]
