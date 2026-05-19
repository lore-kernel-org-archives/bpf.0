Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4603BE644
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223034; cv=pass; b=pz5OtU1c5Tm78AFxwb7KZnH3DuzVp8RhuB+Hss3jhKSEn0ND8R11LTRri9DkaNr5kjrrNK9LySo0vO1wKx0NEwdPwirhzbAld4BZIdMswkFKbzelli68283ZVTnTM/7PYuCL+I//IcXdc4QBI0oRYaz9WlPiAuvqkuvekdq1LeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223034; c=relaxed/simple;
	bh=htugnVr6bWMsd4UVaZ444F0i7bjcPWVsMZk2kiyMsEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvVuleeE+lBUfqttVtUwZTbqmNTbE1gyob+TJY+NeCh8iAdcCXwOtdbEf5EVN34kefF5nkDwHBVfVTSzoRONZH1BjkqbY1vX1tatj/QwwQx/mO77PlhlsNFLorZroAwi+wtk9yiG8KxdYiK+1Q44WZJ56c+it3kfH/shmBIhW8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCEqmXbx; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCEqmXbx"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbd23bc684so2195207a34.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779223030; cv=none;
        d=google.com; s=arc-20240605;
        b=FoyyBJhvD2rc2tce+/xAl4Txf1JCPfWxsr1dxHkJcgrauD6aNq4Q1q0+b5d4s6F7Vk
         l8V+kijKSzR75uz4M33kuRaIAE4xtBNNPZfEz/qUw9WNPHu5Kf8pME7GUPjCEocT3Uzg
         sIPPdhkgEj0/qWnH/CBuYQGUEx6YjIHTJkHU/vYjmS2UlWVPBW/AYyWXPAEAQNwVRRCA
         h1iB//hBXg7tGkERIHDpnI4VhWHtKy9rnEg2MDKK1esSl980IfRR+hUMEdnznGAkef97
         EWu7uHj0kJD25yVJtAQBIPyJG513HeO6CIeZ+v/gPdll9dQ3QHNm6PL+awKCkGUmiL9b
         D+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXfLHzJ3Nl1qL/yosx+NOUbJbIUhHr1gcXJ5Ci4SfGU=;
        fh=dDrO9LpWpmHliXqldfWdgg0f/dkPTrvWShnOp4LpyVs=;
        b=k7BEKkxKNQy16LCeczMeWPzBMSwCY24/qfH/wwV6/3WdRnimQK6ELe/bd2U5YcKlXc
         8ypTORyHcfR1aYnkKdLj744ZiQgtYbEZn+z91hnVBzmabPyaIWBDGGLunbUQEsfCWlTE
         zCvigkgaEyrWYTnDBx0TgHk9AXobVXBNcvZ6rIDSuty6hNY7fRnaZ8pc+g13zg/zg8S9
         V6M8rrtjs5mvVyrbwap+osQd7T+HJZJtAR6yvnl/hKTIobkbsHnb+evD+9oNpmyLQob4
         j1B8RNuVYI3yVNRngU3/4Wf8ZzTbWekYUQciUAqMzWt6Ggm2zqqasTu4PIGaBh760iF3
         L78Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779223030; x=1779827830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXfLHzJ3Nl1qL/yosx+NOUbJbIUhHr1gcXJ5Ci4SfGU=;
        b=GCEqmXbx+aCn8GRMU+SxvcBkApZ29Pb0B60U5okOrVXIQW7B87/sonm/QTXrypt9OI
         caJTLB2/eZWZCoGggRYQDloLPTwmkzRe55l1Uj18PWIOzOoRtudiA3av8z38I4hn8pCZ
         s8tYMTZX2f8K55614WwK86d46xAyw3vl1BNnx+JX1Mpf1c4ZNsO6kNQFzjaArQKi0A1E
         r7uT43wcUisc/PWA4/4CTeFrF4hu4AHCsNYD02KP5eIq1tzBFEZ4Lc573915rKM5us86
         yTLbvhsFK5qECID0jhbKH2EZxRMT5r88QgzY9psnuiZhdSeD1n2KG75O2NyWXOnE+2YI
         wBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223030; x=1779827830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXfLHzJ3Nl1qL/yosx+NOUbJbIUhHr1gcXJ5Ci4SfGU=;
        b=JAPrNhRlzpbQWBj7o22RBg1RDS1ya725J1DpKFZ0U3BgmVT8dNT0vj2KZiIEMRxdhP
         zZeOXazG9d27HpjUEay8JId+qNWR8dDmhRiF9dYc5/fUBny//bSVxch4JS4hB3k3lOzM
         UF9RFtUIdE/QbzUZ0hihmwrIAjEMuhl80qT1PzXZaeokAv3xooM1gNWjOr+WPiS0/YBV
         lEmN933kf2fmQQ3n6ucbhrpi3eTWo//PosNN8EJas5Etz+hCg8ApNCiJJVnjlmE1zbF+
         hdYPub4KE83r4JOyr+cN0+/g5KWZw/k7qax6nsg5/wZUJKqnkgwV5m6ezYqmKMtOtsaT
         jTJA==
X-Gm-Message-State: AOJu0YxSElMAEPrwKC4zhoyDkbyjp7QCq0NO0GJ0jepUR4G+RVGO5QUf
	KYwmLy8LhQYllqd/rsxoMvjOvmyx8/v88sqVVzSgQTqD//BY6L9DMm6u4de+oJelmfXJdl4px8M
	8abZggiumGfm96nzv6Zz90T2epftr0DNl/w==
X-Gm-Gg: Acq92OFb1FJtSbAlCdD1a+UWTzmPy62MkStMhm9t2K44jsTDkbngo/TKEbU4ZLbv35t
	kTsXhJYBkzw/q+z1aZ0fT870Fil6qEQ06q9RS1eQ9YqpBOx9tQ8VVM+4fTmV3P42OrXpHGfvb66
	GvKW/m+xX6f5nd1Q9NDfJ30kmxz/duxgRuzx5R7qLFng8uUEODRXQ4mq/rQF/Nq3Qhlavrnpf42
	VpTMhE/diVa/eTw8I+UiL7wqb0Ad3kc1K6Uf2HvSx2mrO18tqbI6vQn+exbrQlIM6WThm+8t2Ia
	FlFA9ACjWksKdQOEv/S6
X-Received: by 2002:a05:6830:6183:b0:7dc:d99c:c441 with SMTP id
 46e09a7af769-7e4f2a35e29mr14629843a34.8.1779223030488; Tue, 19 May 2026
 13:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519200933.30752-1-kpsingh@kernel.org>
In-Reply-To: <20260519200933.30752-1-kpsingh@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 19 May 2026 13:36:57 -0700
X-Gm-Features: AVHnY4LPN8VfF45a-heGGbUIRiWnCUIj4kQ8mbzBKF0UnixzMc1_AlqaWC5qx0w
Message-ID: <CAMB2axN86YUT66kxyrdW=OeznFZ=YApKVLUBWaZ_Q0r29YsV0w@mail.gmail.com>
Subject: Re: [PATCH] bpf: reject NULL data/sig in bpf_verify_pkcs7_signature
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, Xianrui Dong <dongxianrui1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:09=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> __bpf_dynptr_data() can return NULL (FILE dynptrs, any non-contiguous
> backing). bpf_verify_pkcs7_signature() forwards the pointer to
> verify_pkcs7_signature() unchecked, causing a NULL deref in
> asn1_ber_decoder() reachable from a sleepable BPF LSM at lsm.s/bpf.
>
> NULL-check both pointers and reject with -EINVAL. Mirrors the guards
> already in kernel/bpf/crypto.c.
>
> Fixes: 865b0566d8f1 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
> Reported-by: Xianrui Dong <dongxianrui1@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  kernel/bpf/helpers.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c266..b5314c9fed3c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4241,8 +4241,13 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct =
bpf_dynptr *data_p,
>
>         data_len =3D __bpf_dynptr_size(data_ptr);
>         data =3D __bpf_dynptr_data(data_ptr, data_len);
> +       if (!data)
> +               return -EINVAL;
> +
>         sig_len =3D __bpf_dynptr_size(sig_ptr);
>         sig =3D __bpf_dynptr_data(sig_ptr, sig_len);
> +       if (!sig)
> +               return -EINVAL;
>
>         return verify_pkcs7_signature(data, data_len, sig, sig_len,
>                                       trusted_keyring->key,
> --
> 2.53.0
>
>
