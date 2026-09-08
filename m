Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563459E33D
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893331; cv=pass; b=kJi2cvjdiMLdXZIaT0JDo/tMAoqM+5k4zBx3dEWNJD9qeqVkfHI3e52FngWrYzZlcjAjzV1qU1a9b3WFmuh3t3M8zUuRwkG6ZJ0EAICu1RYilWyVt8l3uEM4BuVLvaxANgo6LHSltG3cLiVqYV8SHcQdVrLzK3dISi9IksTPEkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893331; c=relaxed/simple;
	bh=xeyGsqtviOZ4IoCR11vbrRZ8b0zYh4NgXM0SsGuBA2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvqJLiMc3FV5/zH5YYXrSj8CfHS6h06Pfhd+d+5Z+onk1cONWRpitekTi+jsZngvAuvzOX+JQ9lhyZz+ekVU3333fERmfAzcs+/fhmucdfYii3PAqC7dufj1jHLCp2l7Ng+4pStF+/3C5+CgYuh67NFuKJ3XhRwWzdQWu4xqXqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=sRdfvg2E; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="sRdfvg2E"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-861feb6d61bso45843657b3.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 11:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788893325; cv=none;
        d=google.com; s=arc-20260327;
        b=ekS1RqxnTCknmC924r2j5FtAzdHyQMBI1C0GHJWFnQ1Wsf9foB+TU2W16GCS562+fi
         k7tjO9EPOu5eVyq1n0wuxX9nWsWNYzTvMlD2DZsOV3UjxiBePExULpM/ivg5FRmJSxxh
         pHTu2BjHy7lBiZSIduUBureNQBoFOCcLFmFiXWYfbmkutB4Bep2MPSM5E9o7Doig2xZh
         dmrCapQoPIKVUT7SOOGQwxlyCviAvu8wvkbtfWjc52WyRRR3NNeB+UaMiMmjooBKe7pp
         KNZEbsd3oiIQTv/YSM8yPLyTGamfR/OgI13FACePq9N21Y7nkzbsOkasTJEVjEd9570o
         FJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ark7vZ+YqenlnLaYF736Nj8MmLUQwg4Qt7JLPT3KUXo=;
        fh=5bG9Ph3wKY1cq0b9UgO3oml+l2PwNGRHDr56ATb400I=;
        b=rpO3z24hPpsYDtyWqnU9MvVoDNEJiWwDjimMfV5346MoCN8u2uBXNfvtpfLnQQzgKj
         ANOew0M2QVXF6Dl77VQ93r8VmCa1N8UPfXsnhiRNr2QP3bwQEbSJTid/8tF9o8sA2A38
         lBn1rtbs4Kpqqk3qTcRqnGJlppCXJc81X8eMarDd84fE22RLe7F5QYsgbIK4FP/TrTsQ
         vihXSCjURsCa42CibpQjvqq0npd1flqCiFd8dBhgGAqhDM5wA3L8yzPW0xPis6cBwzOg
         Ryc4KIp7SU12c7BTZw/pfUGh+Cn89HqKdI0O7KiEZfCqcR3qB3HBO901hsTOiODgc1on
         AZmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788893325; x=1789498125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ark7vZ+YqenlnLaYF736Nj8MmLUQwg4Qt7JLPT3KUXo=;
        b=sRdfvg2ETFRhix/QTka2FfeaIJ5GPUBZ27/0EgiDS7Z1fQ+BYBHHqiWkKQRT7meBT6
         2x47JFMviK5IS79+4bHbVua6U3KkipiATu3bIo639Ldp+Z4pfUObRMilErA52VwW3i9j
         fV0OmIy4R1RwUGer+p76eMESFmAlpipKMANWYsKyb3bwZzeZK4+KGgIWyd6q5wMAa62o
         B0lSzhbd2iVGDEX95ljrqrnQG+CcE4lzUC1zsmH1nyx+BUGq6QEqmbr8R+YqRuL8B31b
         ktKNrtqtqULPMHECbJvjURhpaiFZivb6d3iS70eK1YKwivlWz5dhACTdkjQYD4FRcjod
         PvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788893325; x=1789498125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ark7vZ+YqenlnLaYF736Nj8MmLUQwg4Qt7JLPT3KUXo=;
        b=UaB3OaUZwKvnYMhY3cvYcC+fqovHJerPRxm+ewWaxhm/K5aodxCyX7skgr+LNgKdcc
         yKh7GFL4lj1IQjEqRc5g0WP5WRUZ2vrRB5R0OWJn0oaJcU2ZkG/fgLmpa/HCe3W7svj9
         3PCfXCn8Oxy862snTd4RgDUVokqJwHgBk4WNLGCETrIg0umO9Te7JwIbDaVB3PzpI0vw
         MdgT906jSOtVJDjPNjEFOjZ+QXfSHbNjWfV76Sv9Z6DCsX9ffQa/krsFm7c+eC4/sP/M
         mXNYB7Ia9vp+pIsKbH8fJHyfa38vEkwONmJxT0NPZ+Aml8PtdRaC5HWhqRGND4XawVHn
         LRPA==
X-Gm-Message-State: AFuF++lbszIghZI9ra+NKA0rSlwSs/5G2EUnLcR9/nwM311L6a5AqHbB
	xTtiI1DzgKUwJLIi1o673P7t15253k57tNb6LddPe7hKvAcj1kT6R0iRQ3c3VKqsMQNTTT7gmVU
	HirF+qIZDkwwT/JZx+ynaSJvX0CJ4rO3EXj9oyKqUudn57cM5A7Gfulc=
X-Gm-Gg: AYBFou1bdcxxKyXSBGcR+USUZ6farQbjMNXYZgZGvUOX8yKbBJZ2kzBmLG6ccK8y8qw
	DaJnwF5TLUQ33+7GXqA8tm9NSXP44Q59C2KVYGGylc03kx2kEBEcGP6F2x4vTdAuhtlKM3669Af
	PsKO1V8PYkiPD+qL2CneiAb9Q/r4s6Kl2XID1r6reYwdzIK+cSEasWMqBNJC22Ben1zvsFFoYcZ
	BlK6/Gz6p88nYsbeweeVy7QgxuSxu+m/grYL64DZ77UPtMH5tHeMV8bni+TbqXBJotedMojwMWX
	inZOR9JK9bp/iIYim23cJT2CjZuy9naTxEHSVhKs2kuZ
X-Received: by 2002:a05:690c:802:b0:81f:3556:bc27 with SMTP id
 00721157ae682-8712a8f4b12mr116019427b3.27.1788893325137; Tue, 08 Sep 2026
 11:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830093514.4105972-1-memxor@gmail.com> <20260830093514.4105972-5-memxor@gmail.com>
In-Reply-To: <20260830093514.4105972-5-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 14:48:34 -0400
X-Gm-Features: AcwNN1V6oQRqnxYN6eLJpoJUoep2A3gWT4DUC_SZz5QPZxDy9yuBDKPYXYUJnq8
Message-ID: <CABFh=a7FYmod_AGJxZ-i1Oi2CT265rqSHC17ZrGk3qbCw-JO+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/6] libbpf: Add bpf_prog_stream_open()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Expose the BPF_PROG_STREAM_OPEN command through a low-level libbpf wrappe=
r.
> The options structure carries stream open flags, including non-blocking
> mode, while leaving room for future extensions.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
>  tools/lib/bpf/bpf.h      | 24 ++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 44 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 96819c082c77..5186f6245879 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1464,6 +1464,25 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream=
_id, void *buf, __u32 buf_len,
>         return libbpf_err_errno(err);
>  }
>
> +int bpf_prog_stream_open(int prog_fd, __u32 stream_id,
> +                        const struct bpf_prog_stream_open_opts *opts)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_stream_=
open);
> +       union bpf_attr attr;
> +       int fd;
> +
> +       if (!OPTS_VALID(opts, bpf_prog_stream_open_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.prog_stream_open.prog_fd =3D prog_fd;
> +       attr.prog_stream_open.stream_id =3D stream_id;
> +       attr.prog_stream_open.flags =3D OPTS_GET(opts, flags, 0);
> +
> +       fd =3D sys_bpf_fd(BPF_PROG_STREAM_OPEN, &attr, attr_sz);
> +       return libbpf_err_errno(fd);
> +}
> +
>  int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
>                               struct bpf_prog_assoc_struct_ops_opts *opts=
)
>  {
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 7534a593edae..860c5644ec1e 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -758,10 +758,34 @@ struct bpf_prog_stream_read_opts {
>   *
>   * @return The number of bytes read, on success; negative error code, ot=
herwise
>   * (errno is also set to the error code)
> + *
> + * For blocking reads and polling, prefer **bpf_prog_stream_open**.
>   */
>  LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *=
buf, __u32 buf_len,
>                                     struct bpf_prog_stream_read_opts *opt=
s);
>
> +struct bpf_prog_stream_open_opts {
> +       size_t sz;
> +       __u32 flags;
> +       size_t :0;
> +};
> +#define bpf_prog_stream_open_opts__last_field flags
> +
> +/**
> + * @brief **bpf_prog_stream_open** opens a file descriptor for a BPF str=
eam of
> + * a given BPF program.
> + *
> + * @param prog_fd FD for the BPF program whose BPF stream is to be opene=
d.
> + * @param stream_id ID of the BPF stream to be opened.
> + * @param opts optional options, can be NULL. BPF_F_STREAM_NONBLOCK requ=
ests a
> + * non-blocking descriptor.
> + *
> + * @return A new stream FD, on success; negative error code, otherwise (=
errno
> + * is also set to the error code)
> + */
> +LIBBPF_API int bpf_prog_stream_open(int prog_fd, __u32 stream_id,
> +                                   const struct bpf_prog_stream_open_opt=
s *opts);
> +
>  struct bpf_prog_assoc_struct_ops_opts {
>         size_t sz;
>         __u32 flags;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 08ab2ea881fb..a89e10811a73 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
>
>  LIBBPF_1.8.0 {
>         global:
> +               bpf_prog_stream_open;
>                 bpf_program__attach_tracing_multi;
>                 bpf_program__clone;
>                 btf__find_by_name_kind_own;
> --
> 2.53.0
>
