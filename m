Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FEC3264EF
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363860; cv=pass; b=ZcL3Ty1IEep8AAO7lLVWK2zR7DdgtRrG+WZOqq7LpmPftjxeTfgTn23BrmX0otCnH+pqbSxEh8kNCtyDZgOOCgnBL+E20B3wdJEyJqFwej7ym0J2AIXm4fjmvx2r1SVzr6nmSwah3YVdeprpKgmKN0u1UBAMYczi2CU3CNrthp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363860; c=relaxed/simple;
	bh=3n66akwPL5aH75TB6OiseSZhlNEcpu5V8jrnFridO/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuWHV3Ern7hsKc9pYTA8JtMlENp+5YgUF5F4excFc7vVVF7taWAq2ai39da7eWVgtte2n21Xz+DOswkncVzJpwxEhnRjdInyiXlK4dHQq4roItJAgnmLQ/Yxi+cbSzDnDS38evGWmf2bzawQi93oCRBErVeo8nLr4atj1Fn7aww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3D7LOuS; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3D7LOuS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so4017716f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 07:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363858; cv=none;
        d=google.com; s=arc-20240605;
        b=MO8st4TTqYjdZ5JjPo+CS+28y/mBd27FqyOI9l8q3f5I5bwwvSrnc5Jt9+UkeqVnBj
         QkHYeeGAr+qPRn7nHLBmm/SXCPZm6yoHLTeDLA3N+m72G3q3H6m0oGnpBWWAzKAD7KyN
         EQlqD9zkbBcYGp6cXOarLPhgvdrEVhEa9geWPpp4VyNJAmmipdfXDmZkINEJDR9cmQlz
         LBEixnIxmADiV0qyo0uPInxzflyLw9Bdv12Vn9cZj+50+groOo4+xh20NUaZFtBp0caN
         eie9jGygF5kDZRiBTYaoBmY7RXjXpNNxeyvfTYLiDz7l8CuYhTbnioGD9F4jyahLCjnX
         A5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OVDnf3LS1Zy+J4cELDWzZkJKr0472zSbdgFTuK1Jc+I=;
        fh=3MRPOFf/7dhJa/blx9JwXnoNNAsYAFJubQUY4GBQbY4=;
        b=W8Cb/gpVX0rK77jN/BbN1qMWuvyeeLVNIZ5DwQohGRYmP6sNKpjWEx8R9FZY4XDCHw
         UxKoHo8au1CJFXLQDRc9bs5gh89aKPyNxXcfY1B8WMNqQQ42vXP5B3oqcuzuj6vrjw91
         0BjtSdOdIasFwamq91XzsDhRsElrIvRtQbAMjmuHQ10kYu5zS6O25Gf9L6OS0Ju/5Ot5
         pQorOhtY4RuvJqFJhWWA9acgsFI6tO0hyegWH80tCMgySkTB/glp7d2hyt/JserYWzEm
         fP9LdoSkY04ROYCwT1BSu4T+AVYUHTJ7KdJ81DLi8DAZwx5dEjOxEVQQ/JUt6cSYR9TW
         +vig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363858; x=1774968658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVDnf3LS1Zy+J4cELDWzZkJKr0472zSbdgFTuK1Jc+I=;
        b=f3D7LOuSKSy/VLEGL33L2EmOjyTUGx4WEXmVEyf16nFhWUIi/PGwJKBKHLtCNjCDRH
         lBvH5bdjjWxKhn1iUCLnzS2ihSuw/oF9m83gStwk5B9hyaOm46pwabNo7SuICLF2xPUc
         +SOH48A+dodvp7CuDviU71KW1mfRpF5861gvQ3IYPje/ntpJBRg6N5h2GGCLM2wrj/vV
         +GezvMSCNSLoBc/EKL+B/oWlAxlp3rHUMkRyqd8bFlgp/azohQL1CYhZjWXE1NfRzaGM
         MnG6z8NHMOGagKHmvP35GRc3ATRKMyXZn9jaXSIpaaqVZpB+JYQL2CDbEm/PU9OAm6Uf
         sWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363858; x=1774968658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVDnf3LS1Zy+J4cELDWzZkJKr0472zSbdgFTuK1Jc+I=;
        b=LnnPsl9vOc0KQFFy/kaezSBHopC1Il0AzdjfIXtnrXpHdC+NQlHBGkUWt+Z5ui4b3x
         q6/sZks8up0PrPZP/Z86ZM0hT+RuwOWUtxRL00sPmB8Et3MHkecmY8hkOyk3L3XlYg+y
         FjWgszBnGVd1VIyUwbh2WTVgTTWCyldBo99pHCBlQrvvBJiNlVQpQ2nEl8fdkAYL114M
         Z+G/paYBZ3cD9JiT10/fD+hRlwoWd4O+PwfuCGV0xVeo6l6dG52aqINSFGNQkBg/mP/h
         YGvMbCyKZNz43Ngyo76z8vNYW5/yLzj0omNOXRDmqRc1xgrtZBoVjfY85Et7aeQiFYNY
         FDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9rMdIBeTdeBiGjWJVXCMUGx25XLTN/VPlyl9CdjF+ynKGN5VfaJycydqqfFjqOySW9RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39afCyOycOjzPBzUzBO0FDGkQ5mdsDL1UrngiL5CEY5viYXGu
	ggv0Gofv6May1bBq0RXXkMMqNfghuTxNCGxk636yBr/lF9l0I2dYVZEHKETorhfZrOUhxRoASDq
	Jt5PuUMVo5FWqjNZN4MVIqRnShOgnVtw=
X-Gm-Gg: ATEYQzzXXO83O/MWi6jpoo+1QSw3wNtesQaGG6xKZZhzATBW/kneFQxhq9OBqpn5L81
	GIuO0gvv8eEnUNHoGb8Ejq99dFcoANj6TabfkzP7gt9cQmvEoxtxtPtY0vQ8RJJ3YqvZWg4dMbE
	xilJRpuMMpnFtVtPaeyT2vtCzyrQQfb9n7PEbHN/DMsoGHSiDx8MPceS+I6HE0/F1Ba2GBD6fzL
	RVHvjtsE+t2HIqmcEUDVyA75ih0OQzyojH9UDEunuVCN/JhgOXU/0wESzyiFOtMroDf7NfDNpi7
	zZEgRXZVg+i9NeAncqrBUs3V/mbiiIHpl9xbmRs8NiJUfMB89gQOkxJzuefyMYsdnlyn6Ae/0QL
	sV+HLR7Z+6+Jyw/p/ZaDanLIO7wHlIx14DwT9
X-Received: by 2002:a5d:5450:0:b0:43b:8023:8b2 with SMTP id
 ffacd0b85a97d-43b80232811mr4547485f8f.45.1774363857554; Tue, 24 Mar 2026
 07:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324053036.it.906-kees@kernel.org>
In-Reply-To: <20260324053036.it.906-kees@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 07:50:44 -0700
X-Gm-Features: AQROBzBrEbGkOPmrzb0Te4EzLdynK4wKlfwGXuHnnrrTxceVeo39F1XZrtWmaho
Message-ID: <CAADnVQ+XmbLJ2LCeBjun463V3CJriXsSiTrCTS55aikx06RNgg@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:30=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Replace the deprecated[1] strncpy() with strnlen() on the source
> followed by memcpy(). Normally strscpy() would be used in this case,
> but skel_internal.h is shared between kernel and userspace tools, and
> strscpy() is not available in the userspace build context.
>
> The source map_name is a NUL-terminated C string (the only caller
> passes a 12 character string literal). The destination attr.map_name is
> char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr, passed to the bpf()
> syscall. The kernel's bpf_obj_name_cpy() requires a NUL terminator within
> the 16-byte field, rejecting names that use all 16 bytes. Valid names
> are therefore at most 15 characters.
>
> The attr is pre-zeroed with memset() at the top of the function,
> so the byte at position 15 is always NUL. The copy is bounded to
> sizeof(attr.map_name) - 1 (15 bytes) to guarantee NUL-termination is
> preserved. This is safe because the kernel would reject a 16-byte
> unterminated name anyway, and the only in-tree caller passes
> "__loader.map" (12 characters).
>
> While the original strncpy() would have copied a full 16 bytes from an
> overlong name (producing an unterminated field that the syscall rejects),
> but this shouldn't be a reachable state. Forcing truncation to 15 bytes,
> however, seemed to induce a (unrelated?) BPF selftest failure:
> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/683004=
40546
>
> Allow the literal to exceed 15 characters and exactly reproduce the
> original strncpy() behavior (potentially lacking a NUL termination).
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: don't force truncation
>  v1: https://lore.kernel.org/lkml/20260324040535.work.851-kees@kernel.org=
/
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  tools/lib/bpf/skel_internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 6a8f5c7a02eb..8702d6612978 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -243,7 +243,8 @@ static inline int skel_map_create(enum bpf_map_type m=
ap_type,
>         attr.excl_prog_hash =3D (unsigned long) excl_prog_hash;
>         attr.excl_prog_hash_size =3D excl_prog_hash_sz;
>
> -       strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> +       memcpy(attr.map_name, map_name,
> +              strnlen(map_name, sizeof(attr.map_name)));

wont-fix.

pw-bot: cr
