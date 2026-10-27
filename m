Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793088842;
	b=a1webrHHqGqiyhu9oYYpaUaV2kNSpWEcojLhkZK+k8PzkofukqTcBjXoTg1zHN2yqddU
	 Q+mcehKLaBhT+dDM/wmfgODAODsq2HsR+ELMy/rPDB+AUSq9Rc83NJfTmYh0RuGc/PbCC
	 KsP4NFWMZJoi/fhlDb6w1Ll9COvZvtuuHocSOgqI6+qV1H7sVm5wyB9oQroLwH0099vHb
	 xlH96zVwAyR+sX7KHkj5lVdOCT+tS5j2zrjY/lCcxz/jna1qBVxylp3hMBo8tMWvMX7a+
	 n/COvsqG30d0qJ0wAwfSFrMBlSqUJdAR2svIarjv+s4rCH3XufD7KwhIoZKqN3mFzww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w8VOaIxB0TFBB/OhvCNXDLo6PM/lUvCeTHrTbRbZxP4=;
	b=XKjid43HSdLx6kyY33PuYTssZiNu9e+usIDkFYSm+oQE/u60xkGXthM3a4diW6LkBjPZ
	 s0y8iRc1P8HW/W0Yc3o9bg55q10vC4y75vr159EvDbFv8zjbkFeq3PpQ7FsFufmf0XAp+
	 XzPb8f53BlLyuP36zf85kxlUs8c/sZWgv2zw1bjDr8Dij6RFewinMbQkHzThYeU1z7Sqr
	 6QtmCodWRFmGQ7B2qBNfGNsGzv3Kew22eFiNKZpeGle7yYL1za7IfIQM/lsRck/M0SIWA
	 DDZDLEWPdo8/WwpEy4FGtEnCehFZEJwc1iEjUJGWqNlmNMTOe5q5UuQd6xnC3fGmloA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EbkYUlEv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20583606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 08:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20583606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EbkYUlEv
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-48ed188ee81so1927106fac.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 01:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793088840; cv=none;
        d=google.com; s=arc-20260327;
        b=j+JKnHRQMjZCy3vQmT4RIbdadNXXW+nutT0Exm5GD57XQdQgpf0J/aAyguVbVWUUT0
         r2r6ZHL+lC5kpmfJazKXynEbShgCUUjjUI2lKqa62nV9b6W5rJoBgny8EnWd8LHxYqoN
         wDdP6t8oM//mZiZpzqQevfM7ZSOQAbCBI9YJc0a9+KH+KSsu4Y5Rx0ceMLhN1+aFIAFb
         O/nqjZz4qBLnaOQ5KgaRsC6EY8naIHlZ1XpNJteYzeSaeRQRQOv63NzbInBIhdlMo3/1
         1nekNCf0JxZOv3i7nbfBcoPlkzYIh5KlY9xThJEiffAgN0xNt5nQuUal4MTDy3Vjvfw3
         AwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w8VOaIxB0TFBB/OhvCNXDLo6PM/lUvCeTHrTbRbZxP4=;
        fh=/6MfAj4BXjjvz7vnbQDZbctxvlSEnzJk7lB4LlkwlbU=;
        b=Jltj/XNMLXoci9iuzm/mJqbat3wK+PlIhZLIpU99ootzcsG7fmnUJ6Y9QtWKhC/Hzv
         KB6n4Ri6bln7QqcoOXrw/3SUKxh67xZ7bJdiKNnE/mqlF1hrv/4EEVn8a/52PAcTMGWZ
         L0mFk/07S63VYISwPXf5EKKvCDzYxp5LaUSqMo6j5AF50ytmMbN98jCBTRKMf+yWVGQR
         3kCvxkHtUb5iBxZgKmPWMptyXIlvIi4BAU5Krp5rRh9uNUxawO4kr4FagXJyfmfvmNQy
         rkvBIS2agph9MzokPWEm1hv9k363MPx4SycvxTNb7xHM63qxQ2N+8aQymyo5RodrWJbP
         jLbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793088840; x=1793693640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w8VOaIxB0TFBB/OhvCNXDLo6PM/lUvCeTHrTbRbZxP4=;
        b=EbkYUlEvI54rZurwWBXKCqht4R9252FrTxKpsmrco/FVgLTJbIBcOVOabTmv/4O1FU
         IizKxH7saDJxzpilr9W+8GW4PmsrOr402uwSpFRrIoAslfGIP+FEFnhTzOnyxRyGgVKl
         iQ9rnD8Y5RiymicdzvUuOBBhs8IuE2AlLW9Ya0yBBnT0VLa8eC8AMegTerf+/OQnPX0a
         g49GPpeyqx8AwsVvr0j73uLEvo/M7C75aQkNMRxJCxHhsiSg6wEs41BXUj+BWJlehxHL
         e7aNuGm3edpoyRl//l8XvUpBRCn9Z3IydbAq70O0FfMB4LXag8897pCCLPZjlSFcjvK+
         haew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793088840; x=1793693640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8VOaIxB0TFBB/OhvCNXDLo6PM/lUvCeTHrTbRbZxP4=;
        b=mEGf84iQbNF9wLE8/z+cfjys1LAGL+9+/pojV2+TtsOwhKHf2ViGI0zVNmstFPzyoa
         gSYg83YFqBNOatOCQzHWQGDBXSOVu07zogvkDk9+oDXiLsEtxoJMS/t3IKQdVzaYrei/
         XesbzR+wC1ukvyFZjCmEEZrO5w/oTYf5Jc8aaBTV21c+Fve+jXUlp9WDqatrGa3GsuKw
         eF14x/m4yKAyqur2KbncSa6g2Q0AiX+/j+bFAHwJ0rlF4tsk/FxfZ66lElx9Ioh9DXlQ
         Al+IcI3smYGrB4QrDafRhPtsyr5CU+vzSy3C9TTcPDphGmw2w0cxxI6dMrw68xzV5Hjo
         QbIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQ+KwdIa4NuajhVYeovh7UFmEwHPPmhFfF5TqlXsa/LMOSqGOK915pS32Z7YCanjc2jvE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA4VFdT+EAJQYEEjjL8YW2IUh2UfV8Hto1+YPlpN9wKvHDSS52
	sUmUJ1j0+3g1IE7ySOXO5PViG9SZOiioQy65HKuOYBpn1O35+SehIsF4VPXPCwKKgV9VHMhe1e/
	t78SOiuunozhXcyUv7V2yk68ilCMd8XA=
X-Gm-Gg: AYBFou1QLoe1sgWCH010aQK4YkVLewfpDXLoju9bNFKAeKbkHJCZziM1eeDbMU6jmEu
	tLViSZ58ZIRWxVI4uGH9kkoI0TtHc7ypg4Uf7wdfjLDg4AQ6NxHmlrDi9XN46qfvtc//5FB4H/P
	prTxzr/q3QSE9CQX7qgLjfw27Zixb1uWcEbhdvE9t1NtDdgRnavPx8RvLQw+Xo209QdiwAj2Y4G
	tPipSFW5M1v37JQR6s2MeZXIVXKBix58tH/OpIJ9NMnInjEFGbIYY2bKPwRdEDjhVBhhoBB6+Fk
	O8tMMW9EDmoTnLRi/DAjk7lpxy+obYVPH1FQW0oqXxhAoAAZ/en1l6NtxZoCElEZ5YDGE4fXgZ1
	rsgVU6jA9j/AHyb7a5OH0alY8V2Lt2RW63Aq/vw==
X-Received: by 2002:a05:6870:148d:b0:49d:ff8c:2070 with SMTP id
 586e51a60fabf-4a83f64f8a1mr5440798fac.62.1793088839941; Tue, 27 Oct 2026
 01:13:59 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016081006.26069-1-yangtiezhu@loongson.cn>
 <20261016081006.26069-4-yangtiezhu@loongson.cn> <CAEyhmHQe5T6Ai0LXiJnwXzBgy_Xu5=upeqWHbMz7J3X6QntWBA@mail.gmail.com>
 <b5c793ec-c951-930f-fc9d-06de6f49ac9e@loongson.cn>
In-Reply-To: <b5c793ec-c951-930f-fc9d-06de6f49ac9e@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 27 Oct 2026 16:13:48 +0800
X-Gm-Features: AclHuK98IjpjRz-E6wrGUKQi5ueh0VkowRqNb6vJZLkdRKcKoBwQRts6NLE8Z_U
Message-ID: <CAEyhmHQkJzTjmYfocSqoFYBJ4Q8bq6D=Rojce3EbCAJLWEQSww@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] LoongArch: BPF: Optimize 32-bit operations using
 native instructions
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 12:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> On 2026/10/27 =E4=B8=8A=E5=8D=8810:02, Hengqi Chen wrote:
> > On Fri, Oct 16, 2026 at 4:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >> Currently, the LoongArch BPF JIT emits numerous redundant zero and sig=
n
> >> extensions across 32-bit operations, bloating the final JIT image size
> >> and also leading to runtime overhead, particularly in the division and
> >> modulo operations. Thus, it is necessary to optimize 32-bit operations
> >> by emitting LoongArch native 32-bit word instructions.
>
> ...
>
> >> +               if (cpu_has_div32) {
> >> +                       if (!off)
> >> +                               emit_insn(ctx, divwu, dst, dst, src);
> >> +                       else
> >> +                               emit_insn(ctx, divw, dst, dst, src);
> >
> > For ALU32 SDIV, off !=3D 0, it seems like there is a overflow in S32_MI=
N / -1.
> > verifier_sdiv.c has related test cases but annotate with
> > __arch_x86_64, so it is not run on LoongArch.
>
> After enabling the signed division and modulo overflow tests for
> LoongArch, here are the test results:
>
> $ sudo ./test_progs -t verifier_sdiv | grep "MIN/-1"
> #731/121 verifier_sdiv/SDIV64, overflow r/r, LLONG_MIN/-1:OK
> #731/123 verifier_sdiv/SDIV64, overflow r/i, LLONG_MIN/-1:OK
> #731/125 verifier_sdiv/SDIV32, overflow r/r, INT_MIN/-1:OK
> #731/127 verifier_sdiv/SDIV32, overflow r/i, INT_MIN/-1:OK
> #731/129 verifier_sdiv/SMOD64, overflow r/r, LLONG_MIN/-1:OK
> #731/131 verifier_sdiv/SMOD64, overflow r/i, LLONG_MIN/-1:OK
> #731/133 verifier_sdiv/SMOD32, overflow r/r, INT_MIN/-1:OK
> #731/135 verifier_sdiv/SMOD32, overflow r/i, INT_MIN/-1:OK
>
> That is to say, the current jit code is no problem.
>

Great.

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> Thanks,
> Tiezhu
>
