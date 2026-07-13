Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4212384CC1
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941109; cv=pass; b=U8wwUVwFceVk436JZzEqtOqbGAd45522l1+mwlPtb2zxnrwNBVxGA3xl8DOg9txts5EN22rNFCyTqb3ke6zsoT2u9Ac54DSng5FIMsmHmOUFYuK7J0L+gDbFRb52jzBPCOeAd6PGaxa3l+uA8pSeF9j6Xnxzfj21JWkQzXgTPm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941109; c=relaxed/simple;
	bh=reE3ZIiA8bR6q5vWMypk5waJeiVnZpjysUAdSkXjsNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5gP1vz2ZoyAEWVIZUwdJNmvWr6r4UMy480qW7ZsMbqlp0i3Rglz9qNfmULl98qo9WeFC8Ab3+fMEUXMm8b/HYQoElLE0CNOsvCcFFvKUU2MVKSrbFIL4qywyYwOkPD3g+ykl/8PrtrvhLxw1ZY+me37zEwguNn16kXlHyQLePw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYZD8Ipk; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYZD8Ipk"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81e9d8f3289so5513757b3.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 04:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783941106; cv=none;
        d=google.com; s=arc-20260327;
        b=ZRQ/IR/gk5+qs+xboAMNQt6YoVfbig8yJS/NLCUIe4T4+QnGUUBfDH9e7hYDEnnhSt
         +USUs5wnl/NsFdDiN4lOKJg9e8NLHGkWV3xHlcOtAjz7fe2yAuVjjLtPNIv+U8sAgd2g
         f5AySSUuIE9sy/rrjlup7Vq9aIQky6FrvO5nxNkbslpYp6YNZ1DBvM00hjrh/2fFEH8C
         p48vc0AbN2N2f8PXJtzUhBtSc1e2yPptzA4pa66P+HFba+58F0sbGAdQLbyTqtkTzfpP
         zR7iorz4ds7ZlvnQTBxr9mjJ4yphZNN9t0e1AsLyn9W+72BC+wWQbunOPOwwIdVcmUB8
         xepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4NrvnEAuHaG+ihZe9SM0nCZuvqTV6eJwGbpjBAxoUPw=;
        fh=W1EEHDJumm8Lx+TiY3+5Gjv9D4BPbCKRc4oF4/3AzxI=;
        b=DoDl64OAQWrqAmybqj9lTDZ6u4W1+BIHrEr8fQAj8/xb+V7GpCWB7CcZSWgfe8eNYL
         r2tFM09owbSwAmF8TqHk1M2t7Bf4wCTPnuc5waSXM9U0MllfIaYQv+sjc2KiQKwTQfiG
         o2l6hOlerXU8yG0sE7I32PS9taAiBj2sUHT2dn+3M/pBe/M/jL5+Ff8G8KF3CJlbT6wZ
         eMpGmgAsclM+wgwWYG4muwVHxQ1aBqx+HWfP2c3O3de0b2h9Miy+QOznRu9wKouavs77
         zT3DsaKwuRBaQDdFK188LADlwHWtjRFc8u9ZsGs49z1kZ59wjdAy+wrnPnVgFyXN1RFD
         +bGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783941106; x=1784545906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4NrvnEAuHaG+ihZe9SM0nCZuvqTV6eJwGbpjBAxoUPw=;
        b=pYZD8IpkIku5UfEhVJQng/Q1qEXvvtb2iK8nw37pweh8Ltf+ZZxc68k8hxEYUYF0pi
         RizImnTmB1kQGK9fBAOyttojIzSK/d7qyqFG6GXvoCxTXBpyYWSSsE9B0X7yDqs2VyUP
         dGaJ9lkLm4jMCgH7Kd/qiffWZOkkchzMS9n3z4MFUpFkV/qfqjh6pyBJvOyap6fK2ERF
         fnqmVy9Tej7SftkJYfpqwtkDPD+kSK/gf6LELkEY1tylKpFT5p6kMZboOdwqOmnUkPRQ
         r7OV40yvkusjO4nLOiTHz7vOS9NV5Fu8w458bYOSy3Vl4kTd05FbA34Zq8sLam9flMkz
         JcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941106; x=1784545906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4NrvnEAuHaG+ihZe9SM0nCZuvqTV6eJwGbpjBAxoUPw=;
        b=FAcEbvf18FKS0PPp3AXVd2jlZ5hkgxJ5R/nMHuoCP49WWJVLfKhx24U2Kq2/wUu7Nx
         o73NqFmB5wsAjBAEMfl5Zyp+Hfo4T5t+6TROsFCP2aD35j7osbpugG4YLSVThJosZmQH
         r7k/fjLAm0CyBeERKtbjYzdUmkN4lYamJ1bmQyQpz6wmCvMxw2oaSlrnUEut8RJPveqz
         /OHHIxosoQUfqyGUKQipQQ/hUSoLedUu87BJjrrexw83ggU6AUqLeyoJsraSTqGddN92
         /6Q3cCmnPmLwTzUfCMwMSm8i9qPAAspUaLxt5GUmwJOhJ7Jt/frvtfGdd7ifqnDgLox6
         ReeA==
X-Gm-Message-State: AOJu0YxpeRvq9Q+mg/oMk82ZnkTWLcPY6pB0cYQkgojjrApC2+BeGPAB
	+kRnumomN/Tickybte3GAZUGmadh8E70mJN4pwjaRev90HbvuWUbYNh5ioprDWE1CH5NZn4OeDj
	7SAX+eaVuVXtPerwtwrhpnX4D0PoasUw=
X-Gm-Gg: AfdE7cmuSa9JMj7O+f7mvLJdNtZ73MiqZ9NTd5XfyOhJtfjkl8GEg0xBFJ6KlH1Avns
	6YcZspP6o3X/0aKwR6oCKROfHytNecJgebIAQi6MD2mwhtAsh1efAAhKcj2wAADVOi18W8IGBUi
	vOMqGHfaVCrv0ujH8MDWRu2NOe0jRX+NiHodFqxuNDcy6wtLfCPCXsknVmoksh73yId9jd+1eCG
	d156t2msArSfg3m1YIgu/4LJXj7hNBSnOruH63YOK9Py9PX8ZEy/BG7BKx3FnVlcEaL3K0CEAtF
	X5ce3Fp2Gi+yz4yJxNULyaTpexUnRfAiRkxv3HQb
X-Received: by 2002:a05:690c:620b:b0:80c:85c6:898e with SMTP id
 00721157ae682-81e901ac70amr62178667b3.61.1783941105949; Mon, 13 Jul 2026
 04:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713063513.215781-1-shung-hsi.yu@suse.com>
In-Reply-To: <20260713063513.215781-1-shung-hsi.yu@suse.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 13 Jul 2026 19:11:34 +0800
X-Gm-Features: AUfX_mwt6y9dWHTw1akM5JZlx25bW7epDzcN33A1C37dw0beEB9vA4ospeyhCn8
Message-ID: <CABFUUZG5++CQ+CoVaVgXGEPn0CwAz5JciBwk+xcRQh01frC3GQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for raw_tp_writable_reject_nbd_invalid
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Mullins <mmullins@mmlx.us>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 2:35=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
>
> The raw_tp_writable_reject_nbd_invalid test relies on availability of the
> nbd_send_request tracepoint, which is only present if the selftest kernel=
 is
> built with CONFIG_BLK_DEV_NBD=3Dy and the kernel built from current BPF s=
elftests
> config lacks.
>
> Without it, the bpf_raw_tracepoint_open() call always returns with -2, le=
aving
> raw_tp_writable_reject_nbd_invalid test always passing without exercising=
 the
> checks bpf_probe_register().
>
> Cc: <stable@vger.kernel.org> # 5.2.0
> Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> Not sure if fixes tag is the right thing to use here, so use the cc
> stable tag instead to get this config change propogated to other stable
> branches to make stable BPF CI's job easier.
> ---
>  tools/testing/selftests/bpf/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index adb25146e88c..e1797bd87904 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -1,4 +1,5 @@
>  CONFIG_BLK_DEV_LOOP=3Dy
> +CONFIG_BLK_DEV_NBD=3Dy
>  CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
>  CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3D1
>  CONFIG_BPF=3Dy
> --
> 2.54.0
>

I tested this on bpf/master at 7cbd0c4cebe4. With the patch
applied, CONFIG_BLK_DEV_NBD=3Dy and the nbd_send_request
tracepoint was present. raw_tp_writable_reject_nbd_invalid
passed, and strace showed BPF_RAW_TRACEPOINT_OPEN failing
with EINVAL rather than ENOENT.

Tested-by: Sun Jian <sun.jian.kdev@gmail.com>
