Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793136817;
	b=tnA+rApOFjJBOL4qPcu8v18PfVqdPjQvqbMUQ3lpeooKMT8Pw+BzOupP0MfDqE39rPBK
	 OHRRFX1y+inOHx/3l/8Dn99vIu92Ofb0GEJahEi8kcAWx75dfwzCQQ3Bs26+S9Gehkjhd
	 +0Vw836/LtuB0hrCbQ6hMZgJpXjLIxv3th4WtAloVgARgiDjVxWLkXODUGsx8yrYKYQCK
	 ZbNMd1I8G+6hSX69Ox5sLiUnZ6FWGhEZvynQsxfpBRZCcRyo2BiqR6caQE/kz9NOoe/Qd
	 aIZap7YDKWt32O6kAL1byzfsrXfdGw0lyhVtFmH6ixJ9I1aAeboKUdzoLfphMXJ03gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=L4jBWIH9k+0zevALV8MhMLgH9N4lxeP/UYSIcVzTvic=;
	b=Vc+cWmVAvgVpKXHJwnZu+ExhoCIIxDhgJs0gWjHLojp4nRo8Hc1B1NU96fHCsdQKKKTZ
	 Ci4TABq7TEh1eKjzwcCMT3sGc3OHGnrSMEwcuuTkjDhHBSS1S/qzDmiKv8BgL30RCaX1D
	 nS0rf+5pElDSCFn9QVtNvyqptqMCMhkmMxB2d4By9Oem87ozJE6wF8ttV4FGlRC/rrE21
	 JwFIO0Mg1eWUiQ5EsxEsFsl3O9a3wv+PMJjnbmJLKIMIhjfJSKR5UTUXVQHXkbYN0hVtC
	 5EMEBeeqG/DKUVbqdnRQJLkU1EntcXm2lOWj/wCSAdfz9J2WbK+l108TFbGW7xl3rmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g7sJnt3w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5F606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21E5F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g7sJnt3w
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c43fbcb4393so45310666b.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793136815; cv=none;
        d=google.com; s=arc-20260327;
        b=XM/3P3vXu6GIn8Yt9GTUwQz5pG6AKijCp5koviJPnKedlTBut7hg7QojO78WrVxBII
         ItMyTaQ2WwR8iJfVHDfvvI0GpE/V5wKeki8O9LnRvm7/5jz2i558ZpVmV+68ZhJzRnam
         yyboMMtIs4u73UQcidW1iialhjxI8RLkuXUt3TGuxelzvxNvm+3uVpIt5nhsO+o/wNn4
         3tslpZlFV/F5c7tt5L7DoAjvihqFmBfQchp0IIX1mzE3/I6xftQTA2DlCslbKiH42/7a
         X54dryz+fPtvCoB+qRVtKMQDf6EE3kBNpJwzxN5MQiyoRAgjmf9d0Myp48HfLtFJ6V+G
         6Pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L4jBWIH9k+0zevALV8MhMLgH9N4lxeP/UYSIcVzTvic=;
        fh=RCVR/15ge6vr2KrpqjhycYicY7qEqDYPuPiQhi2Pegs=;
        b=exAiaOosu+nB0vk3isByQe7BN+tebIhugSawhvmQ3iV5HR6AV0QQre295PDDo2WsKd
         qDeMXvmpCnTRQpk/e8M0v1wwrfaf3hBnszbXD9PF8eDTJ5dbtvukgHhpQZNSTDfpvpyD
         N3MZN9MBUfPVqIpZrAmMJxkz4nrutWMleSMDpxFav3IC1qtY6G2+FAs/nnRx0AgoULC6
         SidofiibmVJFN/UNLEg9iQ5j/YV6BU47UEmJDC3Fz5yT8vnfRe13oTNPFd0t/rTIKC6D
         SItfIPmmPlc50mBXqMabaBm/SmJ3F8+Xa/0RsdrObuYblQjZ1tMFGyf6UPFGN6ThLvC4
         /XQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793136815; x=1793741615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L4jBWIH9k+0zevALV8MhMLgH9N4lxeP/UYSIcVzTvic=;
        b=g7sJnt3wPEA2XZ1mAxKwQvnescy/AmvEeggYBV/bXD3MuIPFGWm+VsYptXHbKr61hf
         4FARY3QXaMPrBKchcQp6zZCpKuI/KiCtA21MlAlJWGy2Kd9S3keQy0aRcUWfbZq0cN6O
         t+ZUnNAzQq8AqLVI+7wo+FVX0HtqrVKwSFypfrpl5HPN5xyi3yim1BdvxmiRypr4LfqY
         icHq1yhYo+CH2xebKoxORy5HUyL1KoPxjFvTXCArpeID1YiAuC25SDJHunNWK9AmqdIU
         Y4R0H7+oxgo+7Mw4vZpkb/AlAZHlVFwc006lV1hywQyMv9pBorAhHkU4CzX47qiQSyVs
         5QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136815; x=1793741615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4jBWIH9k+0zevALV8MhMLgH9N4lxeP/UYSIcVzTvic=;
        b=dKOUpeF+aWhybNExuIKW91bNxWajHkrMaj5JpIVdwmWq9iZYx7lzWT3sROuiLkO5n2
         L5Ety9/wmX11ZnMBNLE6HGJxPcxbWRRzznZTz+udZiaK+ZRhZXu4ZL/xe3NkZxTyclry
         U09VaPM8m04OVHwVzuriAPYqiK3XGO6qDU4QTNMvNvOS31guSahzPOav24rlGvvgPTTf
         CsMSRDZS7Rg1mUgt5s96aLwJRGDujv9yct3SE4UUAb9FvFlrZfkasZ6797YpRaffHkux
         Zf1AWF0JIzRoQ7Oxw21xyMl79dCrAuJ7LEbX3kNEnbMlasZT3r6yjGKN8O3pysJ1Z8kC
         CqHg==
X-Forwarded-Encrypted: i=1; AKwUvByqkCdwYUDvn8Wb3qpoil8n0Q2AyVs4f/TtQ1/QHD0drJi5Tpc1+ENRYipUh84z9VVedAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY039QWBtdQ4LT3AMZLNE9PjIqiSBKJd5AnqMtWWINpT0bQ72s
	AmC41rhCM8B91UnGY0Yp2shklEHCihzY0bZP4LHAOR+XCRjbo3YAZmeM/yWiQXT3mmNfh5PEGIJ
	XU8lQZenP8PS+al6MWHfSueYOUyzF4JIXRj9gmgRk
X-Gm-Gg: AYBFou1I+iMz+UdclriW3hDwkUGavNLeODHeScsxeBLzAsZ1dFBVfg7AV7V4tgHVSLU
	umyvtcKH6W3gc+3SJlAu1HWPZC2CUaIwEoH0ZZcRjSRm6zOUcT7eq/582tVZzdOJgtnv+OL8HNm
	FB7Iiqpd9y5SC/r0YT4FMlW0do40ni6PJ0KEX4IeW7aHCOjbwfCaU8YN9ds88cfIQAWCBluFFiA
	olVUZ90tgZQx9aSmC8cOU2M2SxpkUI/tf09hQIQKIkKGYFb4mGCSYS4wuY2x/XBgHofqxOCPcnW
	8/foMTx7MHc+zT4th+W3PqPm7vYh6jA5NPlu1ZlK8mPiuCrOuuCAPllFeRu6RmM+rIiLAT2dXrb
	5RtfmfwNqKFStfhy5KZjq2Bwel7BkCUKtHCsSQMUXY8H+d224Fniv1oKGOjtMh4wBSPM=
X-Received: by 2002:a17:907:6e8f:b0:c41:4c20:5a80 with SMTP id
 a640c23a62f3a-c49be03be8amr44212466b.44.1793136815046; Tue, 27 Oct 2026
 14:33:35 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <94b36a91-4fe8-480e-a49a-23a81cdcdc60@infradead.org>
In-Reply-To: <94b36a91-4fe8-480e-a49a-23a81cdcdc60@infradead.org>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 14:33:23 -0700
X-Gm-Features: AclHuK_RVByZe0xeoKYD7y86VR2bYrI5dalonw-UmAvCLqjMUtZYQFJax9TZsKU
Message-ID: <CAG2KctpaX3Hgbnw4iXqrddYPJoqtVBFq2QO7tvEzhHDjgU_KAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 4:29=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 10/22/26 5:16 PM, Samuel Wu wrote:
>
> ...
> > ---
> >  include/uapi/linux/fs.h |  41 +++++++++++++
> >  kernel/kallsyms.c       | 132 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 173 insertions(+)
> >
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 34c6f219462a..b43f227dad0e 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -674,6 +674,47 @@ struct procmap_query {
> >       __u64 build_id_addr;            /* in */
> >  };
> >
> > +/* /proc/kallsyms ioctl */
> > +#define KALLSYMS_QUERY       _IOWR(PROCFS_IOCTL_MAGIC, 18, struct kall=
syms_query)
> ...
>
>
> Documentation/userspace/ioctl/ioctl-number.rst doesn't seem to know
> about PROCFS_IOCTL_MAGIC and what range of @nr values that it uses.
>
> Please update it.
>

Thanks for the catch Randy! In v3, I'll add a 'f' 10-12 entry for
PROCFS_IOCTL_MAGIC (PAGEMAP_SCAN, PROCMAP_QUERY, KALSYMS_QUERY) to
Documentation/userspace/ioctl/ioctl-number.rst.
