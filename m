Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5E31AF1B
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003136; cv=pass; b=l/SYxq0rJ1TeFiYtHevaeowimUVU0I7AtAwtNgtnK/YxfSvsl5DU7AGbABSsoIWE+e4Cuz1aCClUlyQB8fxllDKdTSB1mo7hBrihQeWUXdy2ec9/3i0e61hqY0+wAES/qJwcPWL0e5DdTuahvryQgi0Uh5S5S/Pqr9TaStPUQ1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003136; c=relaxed/simple;
	bh=milJ8z8f7jmRkxaafF+yPKkeV63g9rUp4tocQINpzgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZ7wWpJYYnQackYczIZRbdg/0MOyJTG9o9M4wyJZDpBC9k8LjUXQN+LA8xaA+YRyhJtuMGnspQ5aMWYg+n3uJGloSYGkUCzFbiEemn61TzqM92tsHT4kurZuc4xkzeTlDE/UcYb0GHrwaHZBjgYhwAQ1zCx3qknMyRCBcS3tLTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K10KXztb; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K10KXztb"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8354461da74so6217431b3a.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 14:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780003134; cv=none;
        d=google.com; s=arc-20240605;
        b=Yg0ZWQPZSs/ujkJnYYLVGLf7WEYNhaelwA0Vnr6ue+PFD/Ppep3k8jHuve02mvd/nj
         zW51QygS/DGsMOPPSBszP4jZIFV8Y+LGfayP2jq3b1MwgWyEOeC3ywCCdq4wBXkzWkaW
         nxpR9pS4HAurCRYnKs1iDIIG5T7wQWnir/vOkl4w2GhFvdXwk4d69imLThfiJXYaVzE9
         sVit5Bo2fFirO+JjXRldABLg4jiN4dJnYyrqgp/FxTg/qOBQgf88Ul2OWiy+kJcyccW5
         sqZUhKwHEYf+EL8h5HrC8oBwN/624VHgxpipswJhZrqELHzGV6nFTKSlR+tJ9EnSvzX/
         h2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lkwxBgohtbhGECJBHfnhUm6rdYNPhYZF5IiLNKtIR3g=;
        fh=BKU0ldydq+FCbtRozlQPveWLrOFkXgyGZ2zhqalHglI=;
        b=GhzZvOLal/OsCallLBZpyj2JcDMM7gDNhJrEMKjYjZCdOVsSA611tuTgXN/N4qXQrG
         Tgoi8SJ4yuO+T1USVGyliXoJ9VoJ7uUihsYMQCfsvocmArqI2xlyZs5YOyAuAIW1e40L
         tKZywRcZuhCLVlv4nqrXZOCgZRPwLijTLkK2510xJWQfPuZhP+pxx6/Cq7S+B/WgKOGQ
         xdrtWTzt7QzIZAJ94Q+Wudb3jZST9rfpSQtgsDjLjWahZADIKcAklYrEBvtIeYhCVpe2
         TSwB4MaG6O9WR+Zm7GeV6EBlDpyyDS2kGib3mb4Z3qqxcocUHkEq7y167o1Za24rwB8l
         8YNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003134; x=1780607934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkwxBgohtbhGECJBHfnhUm6rdYNPhYZF5IiLNKtIR3g=;
        b=K10KXztbplYyRPry+fetuBtSDxjs4EeRUxDYG2hYYMVzJYE5yxBLBSpfEKeZKiopKG
         BNX0YArD7HZr4QxcS2//PiLxW1yhOKvRCwgMASOXO44LR2YtxcP4w+vcNQpj5rca7EKc
         ggF9ftAjme6aXUO6ZqnGesYNCAp+3F93qwR05+xJ3RJ6WF6Y2M5pnJtyjWUZHXTm7Gaz
         T6B3c50ZXSJYijqTt312Qzx4HQfCq5iOKZtpCtbfGJk23S1J9owQ4xKnjEyjevKteyqD
         pqZA+TwH4FH7ynFaI42v6PlsJv2+KzGrq4E4IT8obCwnqbgvlXdQOFsTWBoEcIIoZR9c
         6ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003134; x=1780607934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lkwxBgohtbhGECJBHfnhUm6rdYNPhYZF5IiLNKtIR3g=;
        b=EW9G/rtF/f6886EkqKIKK+aWTU8YqND4/p6LweHLR8PeM7yMWiCWZ5VhafrEsB7WE5
         76Vkoqy1gBt8l9ZNmszDpWtN8BX41pjXjY3KQCZXcVEFrKs0U004BFD28eRbnLVbs8Ky
         G8UbLJ7+HI9wC5qLCzs58zqylNHkAAM1OFdRN9oVup0FlN/ulhpDsNhB/pwoHAuCTycs
         4K2pIWhrHKY7U9NgFE7LOup/6r6gBmVVQpgzigFhqx+UQW5Gokax8MKFcxKo8cDybTUA
         0KoWcH73tL+LZpm2Ex+9VoX8gPe8Su6wUfxZWzCjsl4e1MhyjjbDaD6bzMi/A01UPWOR
         iJMg==
X-Forwarded-Encrypted: i=1; AFNElJ8Y0JNnRGd0vVsaLyljmZe0AR+ikGxtOOJ9AV2o54c8UoyOXL5zVEC/Lo7aqZk1lZKXBRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaOOzYkpDQ8SDYbCSIcTsjhOuCTLJ+7lV3+OjFn/Zac/XC9h/
	MM6mTHgNZb1+cZ5gln6lJhExc77fC/1WtnZnGcxeejUoCC5qEJdCP+OSbnb4l1AgIawk+bbXrdT
	3am/bqEn7+ZkCVa6jTfHJfzGc1nkemB8=
X-Gm-Gg: Acq92OHv9lShAmAPJIpR2swu+jZb8NRA4a9n8gM7iKZjjee/6onqGvOm36EFbfw1Vf0
	LlM3RgAtjaVgT6sFhNE/diPVKHSpoSmN16jNomxVcA4Y3AEgkIYQT5V4lbSjvTNagKjdgjdkEsc
	Etlb4w8Z9L/8Ijw02sHUOoI6D4y2Jk+AcvCvn7EAVZOD5Y+OcjbUuaIPeNj2jrLyQ59F+dp0azY
	Qg4wwUQQilhDfz9De3llNKE5bK5BzAzRqOKPCiLgKWR3ZZOKGloXjwMchEBc5Mx6C1l5+PmXBOK
	3p1eTuuNhVMyb3SyZu6drp/DHhmSoFKSA0BpDC+xv6t1
X-Received: by 2002:a05:6a00:180a:b0:835:41f3:f453 with SMTP id
 d2e1a72fcca58-8420bfe6da2mr703031b3a.17.1780003133812; Thu, 28 May 2026
 14:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522201353.1454653-1-michael.bommarito@gmail.com>
In-Reply-To: <20260522201353.1454653-1-michael.bommarito@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 May 2026 14:18:39 -0700
X-Gm-Features: AVHnY4K-8avyOBrRQKTyhFNavcgSg2K2BrekN95WJRw2-DZMwAE1SVGCNiJ0YIQ
Message-ID: <CAEf4BzZPH4uzGzGWq9puYDniJ-ZtKO-XEPgmO99w2tNNVECdPw@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: harden parse_vma_segs() path parsing
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 1:14=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> parse_vma_segs() in tools/lib/bpf/usdt.c parses /proc/<pid>/maps
> with two widthless scansets, "%s" into mode[16] and "%[^\n]"
> into line[4096]. A VMA name in maps is not limited to that local
> buffer; a deeply nested backing path can produce a maps record long
> enough to overflow the stack buffer.
>
> Bound both scansets to the declared buffer sizes ("%15s" for mode[16]
> and "%4095[^\n]" for line[4096]) and drain any residue past line[4094]
> with "%*[^\n]" before the trailing "\n". Without the drain, the residue
> of an over-long record would stay in the stream and break the next
> "%zx-%zx" parse, so the loop would exit early and silently skip later
> maps records.
>
> Also stop using sscanf(..., "%s") to peel the /proc/<pid>/root prefix
> from lib_path. Parse the pid and prefix length with "%n", check for the
> following slash, and copy the remainder with libbpf_strlcpy(). That
> removes a second unbounded stack write and preserves paths containing
> spaces.
>
> Fixes: 74cc6311cec9 ("libbpf: Add USDT notes parsing and resolution logic=
")
> Cc: stable@vger.kernel.org

dropped cc: stable, libbpf is packaged through github repo and
in-kernel libbpf usage doesn't use USDTs for anything, there is
nothing to backport

applied to bpf-next, thanks!

> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v4:
> - Carry Emil's Reviewed-by.
> - Simplify the /proc/<pid>/root prefix handling with sscanf() %n,
>   removing the unreachable snprintf() length check.
> - Initialize and check the %n output before using it, so partial
>   literal matches after the pid cannot use an unassigned offset.
> - Add a short comment for the %n return-value rule.
> - Declare the maps-line buffer as line[4096] to match the %4095
>   scanset width.
> - Reword the maps-line comment without seq_file implementation detail.
>
> v3:
> - Correct Fixes tag to the initial USDT implementation commit,
>   per BPF CI review after adding second site.
>

[...]
