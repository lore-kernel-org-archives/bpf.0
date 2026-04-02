Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BE36C0CB
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153713; cv=pass; b=A1l0OEe1Lp9HrsrQU4zPG6pbF+9kIp+HvyqSCRYQpkdlnd4k0OC6HkNWDt/I/ta/JdYQZya8piEOUdSBW2PUIksr5DM+T95e/mAx3BLG2PEXp95Tuywf/jDUhUtq3m7zkUykikTwoVF7EAq/vrX9+xe7dk7iy9CRNl7wk86P0gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153713; c=relaxed/simple;
	bh=Sn4LT39O9NSgJAy7nat8kIE5WLTDW2VUZ5FpZsLriZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TF1W8L/HXjZvAgjCmJQrgvsJi5cgAjWynbmLRfF75TZIuF9yqPUkjPqMLHbetRPQ2jDAOGrAxx4nYhIDe5KwfBPxUxhHo+ovmV8ELGSVKXX1ibLVJGPU6hIT5gdowHsNRC2Ed1oHsxfHR1Kjoi7DjTIc+e6P5O77XhEVxK1UqeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/+ygeJm; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/+ygeJm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso16573515e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 11:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775153710; cv=none;
        d=google.com; s=arc-20240605;
        b=OgJ/Xjgu74CzeteTlrdoqG324WfZQMlQxsZWAAHjbpiAR1oHzNCYt1S8xOqyGNTSJX
         IxNomdlXmbn8fyPbhNko+ig8455H70EVx4tmyr2Cv8otgN3nlINiYkpsDYtgakraQizA
         rir/TRfKael2FBDWAqnVzkISfsdOcM5HLeYpF9er0q3tigmZyly76gTEpEzFyoCBKJHa
         HrDyiCUI8/BzWEkQeDtB/gl7WjwYLjZh+qRP3bZtFHzyX63TSPt8xgqYQS+jupdXYuAl
         KUJzfc3WDsa+hZAO1Scm/oQkJghgvO0F8ZnCZ2Dc/Iv5e2FU+xNxAkcGTC8Xe3haMAZd
         K6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tvtbj/pfnSFbmaQEY4ut9E3uKs4A0zJrB8Fz4YhGcl0=;
        fh=NOxaJS6zY55rIduo62IXas68SdPmVWDpxUXOwvam1dU=;
        b=dD6oESxZZCApQLQ2EkqBoDDXRujgIoGcgnQ/xP3W1R7gooj6Kpeikvtfnr+3ZcX8VN
         4/uF6YQszDv5vUpa9giH1D9IG1FYE8Ludm/xZjSPRT5v/PS1UITz5pUumQwScdjwr8Pl
         wL2tI7Eb84KAF35i1tf5hWzoojwLX89ilAazeQzfTacEXMo7J8DhZ3UTT/oJ4G4UMV3N
         166bLRRBfLeRhMqV3CoANARjk3asSzSOnv18CVA6U2AxRdFIfqzIlUHb/h88x9nNEBXN
         K+H0vquiqD5i8VJRdo3Rv9KZjRQj7/FBWK09jkJ/FIb6nQp8U8LSps5+M7h4yBH2prky
         OLTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775153710; x=1775758510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvtbj/pfnSFbmaQEY4ut9E3uKs4A0zJrB8Fz4YhGcl0=;
        b=U/+ygeJmWBrrV1wFhpvevLEgVtVYYDISW/mx31gBo7sgRV8ZQan36zNuAg1YqqMUKE
         jWehhhyt5kmerrKXLyHnwihPmNWyKDd5BUWI/f41jwPrRHTiqnjEXa9tMnaMD5HOxtbz
         4d08FiN1Y0eiXnPqIH6dIN/d076J5/a72G0f/VNKjZrDbXWzf5h0DyyBVUgTQQMhygsi
         3W0O/RUGY3dWwJ03zyjmgpdCdHqaD14VMDNc1vPlee+bnKZBrHBk/kmLudiJjWohuexj
         II03b1mLtz7W+4DCN15ocXOB5ZkiFdYrWXZEHb0LJZjxFQl/ma4WEsde1Pfz3seWzYuN
         p2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775153710; x=1775758510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvtbj/pfnSFbmaQEY4ut9E3uKs4A0zJrB8Fz4YhGcl0=;
        b=iWa4jgTA60tJJnHNEpt3h57L1lFrdHW08hwrwu1xzJGwRt2eMxXobObGj4sljvRisY
         Y9Tc7apMDqGxlVtAAbWUR+y8o0M+YKsqZWsLZmhgnRTHduPIfysXoJ8i00P86Oo7HPC7
         jmyMwngTW0Hl9l8Opth52Jrr3AmM99nE48PwG6lbAZRs4jlL/4AdqEBr2VzZ3fMj2dgr
         fk/2CEzNIC3e8CTUAYjXNendnls2FeEq32gyYNyCVgvIaWS0xGsdX8vlvAVpfiD53OPI
         cxkswEZpFxu9VSRmuF/7Jr9Ig1Q35QbA9LgEGYqrotASVKudATP1hJvtbJHYD5y56mni
         BHzA==
X-Forwarded-Encrypted: i=1; AJvYcCUBdsTXfUGkfkzDlivQgxfQ6AUVuAT9Ai6U4y+SAXWIGF0BCs/jflUmwQxlpQ2wrCWczSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Uukb8P4q39vYQV/sA6eqb5Zj1uDQTKaVkaJd2B04oxRTgEN3
	/EU3oT64FXpJDy7OBduLOPAkbFFCf3Xda/C5mVSgKPDTQsghQmXr6ilzOnwL/k2Lz543AByzCwL
	7ldkyzeT/8A0BYIwSSYT3li5yMSyAcTU=
X-Gm-Gg: ATEYQzwD/srrLHp55cZpWPTQcdJNWaN1SgsQS1Cqq+DNRBZvVk0mWTpo0dcnsk1UVR+
	tv3H3DhKrGDQXP02BYi9H16oIhTH4DL098+UhXh1PO0QBUVMYbVGHyHpxDuz3ha4Yv2lVfJ1lAa
	E0B+vZ0bybro59DggePr8W/56C9DqmBR170sT7A2f8r5iscQSuaMQhUYg99oaJd5RoQ/CIbFtRy
	oWpBQOr3OT86PdTGlqP/xbW42QxRiIo36C+HfaWTZm+nO9AENQEU31VU3ncwNlmbu46Ut55O6Pr
	xg855b5LGS+Y6QvnbkepSEH20vk1CWNS1qSBuR6kUrlUEvuiRTfPk7MNIR/1P8ZaofQ353/zN+1
	D6MAWMu+EN0gkcuCbDAM4kY5odQ==
X-Received: by 2002:a05:600c:3acb:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-4889972b76amr738535e9.13.1775153709443; Thu, 02 Apr 2026
 11:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401001130.it.781-kees@kernel.org>
In-Reply-To: <20260401001130.it.781-kees@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 11:14:58 -0700
X-Gm-Features: AQROBzA0whlgw33SO7-FIcOvrodFQ31yM_rEB-MHu0JHEguOX2LrpV09lIUze-k
Message-ID: <CAADnVQJ+uSCvtpv4A33YeRi=_LCnZRaxB_ejVgdxPDO5u3+oeg@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Sun Jian <sun.jian.kdev@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 5:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> BPF is the last user of the deprecated[1] strncpy() in the kernel.
> Replace it with a length check via strnlen() on the source followed
> by memcpy(). Normally strscpy() would be used in this case, but
> skel_internal.h is shared between kernel and userspace tools, and
> strscpy() is not available in the userspace build context.
>
> The source map_name is a NUL-terminated C string (the only caller
> passes the "__loader.map" 12 character string literal). The destination
> attr.map_name is char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr,
> ultimately passed to the bpf() syscall.
>
> The bpf(BPF_MAP_CREATE) syscall, through bpf_obj_name_cpy(), requires a
> NUL terminator within this 16-byte array, rejecting names that use all 16
> bytes. Valid names are therefore at most 15 characters, but this wasn't
> being checked via the skel_map_create() path. Add a matching check and
> refuse 16+ character strings early, as they would be refused later by
> bpf_obj_name_cpy().
>
> The attr is pre-zeroed with memset() at the top of the function, so
> the last byte of attr.map_name is always NUL, meaning the memcpy()
> of just the non-NUL characters from the source will always produce a
> NUL-terminated destination string.
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Suggested-by: Sun Jian <sun.jian.kdev@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v4: Reformat commit log slightly, confirm last user of strnlen in -next
>  v3: https://lore.kernel.org/lkml/20260324161605.make.168-kees@kernel.org=
/
>  v2: https://lore.kernel.org/lkml/20260324053036.it.906-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20260324040535.work.851-kees@kernel.org=
/
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: sun jian <sun.jian.kdev@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: <bpf@vger.kernel.org>
> ---
>  tools/lib/bpf/skel_internal.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 6a8f5c7a02eb..2d38c387f43c 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -236,6 +236,7 @@ static inline int skel_map_create(enum bpf_map_type m=
ap_type,
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_ha=
sh_size);
>         union bpf_attr attr;
> +       size_t map_name_len;
>
>         memset(&attr, 0, attr_sz);
>
> @@ -243,7 +244,12 @@ static inline int skel_map_create(enum bpf_map_type =
map_type,
>         attr.excl_prog_hash =3D (unsigned long) excl_prog_hash;
>         attr.excl_prog_hash_size =3D excl_prog_hash_sz;
>
> -       strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> +       /* attr.map_name must be NUL-terminated, like bpf_obj_name_cpy() =
*/
> +       map_name_len =3D strnlen(map_name, sizeof(attr.map_name));
> +       if (map_name_len =3D=3D sizeof(attr.map_name))
> +               return -EINVAL;
> +       memcpy(attr.map_name, map_name, map_name_len);

this is plain ugly and inefficient.
Just #ifdef kernel and use strscpy in that branch.

pw-bot: cr
