Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BAF38D6AD
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369931; cv=pass; b=iUrC2uYFcqitW6W+cj/Fd7fgidPLedhU9xCmTyC6kNb00QxmWW7dM1BU7ZrLt3ZfaSBf/qq8lt9hwYASDbZTObBW/cdtLsED13NjCxsFXHDBt0eHZ5mM6Iv5o1ggPjZODkQXKYc7E86K5dFxBBOfGQqKpnqoGVWDGARb8MYylPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369931; c=relaxed/simple;
	bh=5ZUIycxrMKAOlvF8lXrqSJU3zKFIkqviMI18K5Zwmxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncyZA9blqy2ycKXIPVeuXTwfbv4Jo7+vfDAPpegR/4Lr7RqkkQrIpOYHW6oYZhvMmctdf3sJjy7jJ4XS5ZnG56AznGup4hq9BPnryl3hWgPrY9uL4vhhtqYo27sIVKqoo33bkq5RjbzbHrhbjvSeluE9nngbRm9VzvQSbJAJRI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSpCJFDp; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSpCJFDp"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9841aecf72so455752966b.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369926; cv=none;
        d=google.com; s=arc-20240605;
        b=giUFF3hbGCKy65rmeBARGjX4YIQWXp+Q4/EUrpGWtA3RmOCZL3jnZc6ya8Bocc9oYC
         NI6qFwwYYhCCl/EKvObdr92RVEjGTh4NNJCJvvVqqC4m13fuqVy8aMhrKLRmXzm3Bzzb
         qUk/CLc7oduD2KaTP9Vblev/5k3vnMDXrb4Lj/zOVIXu2XZLaEzaDQ7JWIZs09KMmGkR
         e8OHL00WAheBLWNiPIyuPDtwWuMLtzdLnQ9A06DLatm9uMHgyNmzA/Ft79iv9gpg+aCH
         6g212MW/sYnXJvc8kOflpODEdKO6AfJOJBRQyxysAR+xZmY+wfFh6LO/aqgri+lACXhu
         ZFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/YQinh1RXyENEr5bN/5LCEqxUgVxBoV2ucPL3SO/bg=;
        fh=E82q4Pf/iB9DWtnLzWEi6jE2wEqjNN2rmN/5jEVDQ9E=;
        b=gIGmGumN/4xFkmFjOxbgb70nCJ9owlCctwfMgRPYeGzBjYOP+CrJjFBGsd/CIcsAt4
         c9aOhN2xd8SzcW25sq7vJo1qc4hV0W24kGgcXOhuogaYb8d3Yak7MaGlTeQ5Dx9uQO69
         DuFpaq8/KPk5PCOQVlDElVNCCNJNSBAYP1kYpfyrhRAr50XPJrSdsTUBxsPIdJBnllYS
         nsYne+CM0Fr4BzHMiEXLjZVkpeJCGoofAXkgiu1DWDjY2jZKcROQ2VvKoE6vpOgycohM
         Hm2Ae5eFIH0On4kbyvF2TZBEk3v3he+9CWsykcqeA17Z7Aur4h8KftS79GE6Uda0qxbI
         diAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774369926; x=1774974726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/YQinh1RXyENEr5bN/5LCEqxUgVxBoV2ucPL3SO/bg=;
        b=kSpCJFDpXzc6RPQceX1WsDKfa1TfwvU0fU5i1OosR52+n4UdJtk5i7zv8Sfv2M1vFF
         EPZtx9uhTb9J20fTaahmWrBalrZboxAr+CdRkLnAgVgpBRR26kG53cyNz9CIto+n3B5q
         yTZycibKgQHYu0e4/yHsxvPRzM39rojiX2emwJk999oz65zvpvTd6OWUcMgZiKKEOLHT
         /pgrBI7kjbgi6zN+6LZtoeJI356Hw2J6tKZw6xkWwVNX86T4yvVlPl0dA3D1LwOlc+IU
         ZtCI0XYUvhjbsHvCVGRv/mh+TGvZCjk2Pmtcpd5EMntcV/0CE3/80zTjPJYOn5jxCog6
         Fafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369926; x=1774974726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/YQinh1RXyENEr5bN/5LCEqxUgVxBoV2ucPL3SO/bg=;
        b=fpQFo7+YU4TUkGTBNr6Q7VN2GPFIkgX41iZY4Om8o9iR4/qvoz2ClorgyC2t9VHHgd
         98M7ytzbZjOZX1YyyrY4eWV4yaDbPdRd4buRALI1j2JUIAZdUYFyu7BYbWDLnrl+PAPH
         BQFKIHdGp7VomhyzC1IFmHY5n3gf9Vd7hLT0yqfmyQ9Icj2hXewvH54wfM79m+yoT7Z3
         hhX7bfViRtweHaTr9VEyGpimAtr18cZHaCkLdUKtfJCNNO7xZm7FhZoFuHACt0eiCGau
         +E4137otQTJpezZOiQZY6gek+iVgNcGqzFr8I6ZWZsx+lMCbHqaUXVLMXKfp2wMJz1j5
         o5jw==
X-Forwarded-Encrypted: i=1; AJvYcCWkkZ5+0zf2l2bGmFTP3dbNfJFpabpHb476NFrpwLJPM6A9rXzL1vPSECN5SFvluPBqSOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrjpW4rkj9D6VPC4UVjyPp2VYPewQqwp4i4Ztu3bWpWc6upLu
	b+RshxydL7mz8VrtVT3PyN8/b/hD7guhIYt536yeHCTdw4RpiFlUGkGE76EVoJAwemkROP3IJrc
	jeMwS68rIbkp0XWMyqhb2/iFvDTIYQ6k=
X-Gm-Gg: ATEYQzxfg0GKbVKNtmsnK3jIbgi5oKY4CV95s//3KD4rwa4+RyLOQ+W0xBNcFwUQhVO
	yUOxOEeSJrntZ+STAH6tR9qdsBn1mM82auBLwwV4wo5s7P/MdQhQjMbSTjBOwP3ozK56aU62vMO
	WtYY6tNJpiHRYi/fl7O8BQwKweUgrICQCS+hybSzJIRustS0SR+8LINv8oL9Y3UPZc47CcSwqiS
	mj0lVWVyV1Rz6qTgIctdXBfScvWXUqsOWT27SOtuh3grDsM8ZTWMhUIN13EddUXlDn0HSj0jeAJ
	sZkQC3uMHKMLBMAS5LF6b4UwM9xlXxWM+nZSmxFj3j20iq+ErhGVz8B6OGOfx8g0Qco6ztwximG
	hZtzIkCKQs8lwBy3VXkwLvcyU0515xd81c8aK
X-Received: by 2002:a17:907:c15:b0:b97:ce8f:b9db with SMTP id
 a640c23a62f3a-b9a3f16ffe9mr5582166b.10.1774369926021; Tue, 24 Mar 2026
 09:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324161605.make.168-kees@kernel.org>
In-Reply-To: <20260324161605.make.168-kees@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 09:31:54 -0700
X-Gm-Features: AaiRm51a6uDGyTaXvEuCLyNLx57Mveqr_0gcySl4Ob9761Ht2CtD87CQ1CT8XDA
Message-ID: <CAADnVQJC8-GREm1FR4Aoj6KsTepFCxK-0O+ZKyxx6--zj4XiQA@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, sun jian <sun.jian.kdev@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:16=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Replace the deprecated[1] strncpy() with strnlen() on the source
> followed by memcpy(). Normally strscpy() would be used in this case,
> but skel_internal.h is shared between kernel and userspace tools, and
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
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v3: instead of truncation, refuse the long length (test appears to have =
been a flake)
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

and now you keep spamming without waiting for replies.
nack.

pw-bot: cr
