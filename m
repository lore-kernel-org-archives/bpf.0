Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793137573;
	b=ceQ/eubiOlCgnb/bJBXewsS5KVt2uVAiMKvYZHp35qyVY5eIGTQ1FcgH4JjlrOWJN+Iz
	 nFoq3gHU/Oxy4m+LjqZJSt98rznrs2ieOmgI40sb3rZQ9ZKvY9svOZiRhe6P566swTmci
	 ly/o8it0X+3SSyEJ508fZt+irIZZT8HgXCSO6uBXlrDIaZWsNn3XRZQRHALFqiWeH9rIG
	 4B8Shg69bbpn3RdHcCp4rBDxGMKne5mQ57NAWkLAB1KtH1CoWLKqmFjKVECbWCrlk3XwS
	 XxOhmuxpPpMEriB3idMQXrR6GSSfQw7P/wi26idS78ReiTK4r/JnCe7zNFLa6zvbVjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eVSNb0KQbTxZM+AQXhdYZUTzoSM560pyx9+jZ9Z1qdI=;
	b=Hxkx0tDiThN6d/Cd2oOVDvSnuQapHZxaSMT6dZcD5fd/yv1ZStMRQVf6L6fqB82wtyvM
	 i7zjLkXovk+dZNXYsyqN8ziYVDqC+89zBmJPlxHRRDpzeDadL709mGwY0xTc45/PvO+4o
	 4NUxNOwKARXT8q86j1LZw7fKduQ68NjAGw5oBFtzlwKXX63aPE/Ue3Xn+CflEpIQGyNEF
	 Y3gfdnyqPh8UFip2c91Mj98WWr+3kliBB4NtI4XLFJzUyx3tc85yueDOZGqVhmxWHu7PT
	 C7bUX5JYL+fWvo3cDqD6BY/dApwGqdP+L415TRnNMvJz4o26wlSwmuSJ+Y7drakb0aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wbne8OHp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC4606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3DC4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wbne8OHp
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso628325a12.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793137571; cv=none;
        d=google.com; s=arc-20260327;
        b=bWVkTnylZNcLPOCl+iglYvcya10qpE5y45HcQ+tH4fVULupn4cuCttUzhpywcRes6I
         GAcNadf1dvj6YGrduQCwtF0tl/zwg5J2QiEinEQXRsmfaVp/AoiGdL+rq3XElQy9EWa9
         9kwsKHhaXBHz4hdXQtgjz114/KHcz/4epIPbpLmMaKoMhFKBLoX92f/Z/rAv5u2bU7l8
         QQngmmFFQsdxBAaITS6UcoA7xtgl0h5flocwjo06RFQcOonj4h2XMsea2ZjzrT+h2JqW
         Iey8XnHYVbLiMi+UbFLo5C7M/d/mjQNsH/QnG4Zao9k8TViJCEObD9EwwTLZ3Ed4wGrK
         ooGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVSNb0KQbTxZM+AQXhdYZUTzoSM560pyx9+jZ9Z1qdI=;
        fh=bedKerqdB87Rqx0kM76SBbIDUZuaqH7Kd/eK7p7IdMA=;
        b=rpSLzU0hV1JTRKEfffHCB7gQDehPKVMbIE9qzaY0r3eHwLrCszfMfNQYlDYK3ln/cK
         wZ/IGKGHvaRjmBw041m1EaZk6b1GyP2O644Cny7vFSr/+wtj22lyWYKA3V06uu7tM8EG
         Ek5itv9FlBlWnyQDYLRW7XYkd0xbNHypZdCCo92UAkGfbNnGIpzlGJwi7wF6b9HAaeH/
         W/C1+ESBE02LmDKIpEYM039z8Y9A73BREyNrL+dXgNEkKW9DFnehgQHhElDYpBXVpOCF
         lwVFXwkwrtWQ3+7ezuffRGmCE+mzieqmUOLt+FNh4t2wCqK3F7YcNLvGvM4dPDQOJqka
         75QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793137571; x=1793742371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVSNb0KQbTxZM+AQXhdYZUTzoSM560pyx9+jZ9Z1qdI=;
        b=Wbne8OHp5wFBPP5dxuR8+Kp5ZHrm8v80mBFme9V3XRymOzyPXT+ANjuS8mZtAutbOt
         ODy1sui91Ycwohd+oEsUjL53uPSBpLjWgEgWbT0Ma2aK7Hvfe3g01z4xkvRH6s2A/fGZ
         +Zbv9XzVpEdyJwXjAhRmHLJ3XY730+XSfkzgh8qi4omMFnsRCwCi2Puq9v4j/9LjCquY
         7A7TovQ1C2rR2zd4geupuZI+05Cnugg1XhJ4MHSma5JAUcS+LWaaA2qCMueEuNn/BKvO
         xSW9c+bot29ZINzBkQ0CD12vMG5F6NsY2dux4jMT3EVU1twWW7mORuqkOTF0o5JB3euK
         EGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793137571; x=1793742371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVSNb0KQbTxZM+AQXhdYZUTzoSM560pyx9+jZ9Z1qdI=;
        b=XJRDUGvWLgGe14kZV083jQNjIAOpodB8EHVrveVz6IkAPNiyc2rP1j54B+lI/nge8N
         7QDJWfGk9eJ72ADGRBaaC4LA9lyupWBu/hcT6cyoCRhj990vgxxwshuPxDCgEgbE7kYl
         4cXDGHqAUHrdj6D48/RoJ/y8Oo8A9EJo3gvlMyLib83TQmDQmpjqjmLVXakyoDrAbSXL
         3yTvaSlibSM4lEc682bapfoFFjyZs15bI0QTYKBsTXagnrByH5xNyuT0WflQ7sllCtEl
         wRrOmEWkxf9CuQVK/oHVXjl0tCxIlVpOvwHlDam/s7V/qe8DIuB5KL9quM6hyy9GiWge
         iQEQ==
X-Forwarded-Encrypted: i=1; AKwUvByLWqfiVBT/J88rgARpQ6ephlbWLAXniEfA3TyBYyYQ6n9REeaIkbpCpg11JtahQ4FSVIM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgKfmr9u4G2Uw/Yws9tKZIpffj75i6e8e2XviBtU34cNgntutY
	GmjWn7EKV1LEdMXY2Jtze6NWDCrmj/UYxyd0ByXN58K8il7EMFwT/dx9cpA7QENfM8/TSmRYJiy
	6zaUvEeR1lpZT8ihe+XWvWqL/SpOXJ51AZzffsnfE
X-Gm-Gg: AYBFou1gtjzxzk9keuUYOBD5fC9A6wSGyIHieaiuHsu32W32l+fJUzTaY3e0uybPED3
	SaDhAQQACrzLNMZD6NFa+/TAyhVeuI+XGE0R8AsVo2fbgh4ngNDaJAY+DS4B540wrb3XVkZOhbe
	wuvm+RXVP/TbvXiT7JLhmAqNLhbskC5vCBY7uxZe1tvD3oQr8tUy3gKz6bj8gcXObp6AYFGWM/1
	QuBTj+R6E+qOkS21doN6SXs1hdRMbLNDl7IHN60q9SBLUaFHkMWoIP39hjtoPvGHlzmeGorgytg
	dtvx1/+Z9/J3+fnmTwXI9V2HsGcUQEmUoH+MT8L8QqbMgheh2QIGTkp8nF1dFXJYbjq/m2AN7OT
	19aCpOzAWXG6EY/GgGZwz49A/Oy6LrmoWxoYA20Y94N4fl2014U1xDJs1KTeatNz2ta0=
X-Received: by 2002:a17:906:794a:b0:c36:7579:fe6d with SMTP id
 a640c23a62f3a-c49bdf3769bmr41163366b.11.1793137570881; Tue, 27 Oct 2026
 14:46:10 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-12-wusamuel@google.com> <90371d2279a5eb08966a82325922e1f15eb93560d4019f5c9020956cadb4120a@mail.kernel.org>
In-Reply-To: <90371d2279a5eb08966a82325922e1f15eb93560d4019f5c9020956cadb4120a@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 14:45:59 -0700
X-Gm-Features: AclHuK8QaCDsAbnjPaGufNN4kMFz5cqAaOc_WFmJQjgBqVdaEIaSp_a56eCEZoc
Message-ID: <CAG2KctpuWLxdxB+LzrBO8eGsL2E0m_DphcG4cauB0cHuEDEoRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
To: bot+bpf-ci@kernel.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, andrii@kernel.org, 
	eddyz87@gmail.com, ihor.solodrai@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:

[...]

> Would it work to fall back to libbpf_kallsyms_parse() for typeless extern=
s
> that are still unresolved after the ioctl pass?  That only costs extra ti=
me
> when a symbol is actually missing.  Alternatively, the kernel query could
> match the .llvm. suffix for data symbols.  I did not find a fix for this =
in
> the rest of the series.

Yes, for strong externs. In v3, if a strong extern returns -ENOENT,
I'll fallback to /proc/kallsyms to scanning .llvm.<hash> suffix,
keeping the same semantics as before.

Weak misses must default to zero without falling back to a scan.
Otherwise, all objects marked __weak would pay the full /proc/kallsyms
scanning cost. This is a slight semantic change, as a weak symbol with
a ThinLTO-renamed static now resolves to zero. However, this is the
behavior of the light skeleton (gen_loader.c), so perhaps it's
acceptable. I'll note this in the v3 commit message.

[...]

> Should the fallback cover any error other than -EADDRNOTAVAIL (and other
> real lookup errors), or at least -EACCES as well, with a pr_warn() for th=
e
> errors that are not handled?

I'll update v3 to log pr_warn() and return on open() failure or lookup
errors. And then I think I should reset partial state and fall back to
/proc/kallsyms on ENOTTY, EPERM, EACCES, and EOPNOTSUPP.
