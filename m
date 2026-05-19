Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4D366DA3
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223937; cv=none; b=UeoIyAN/UGUOOLARGf+HdjiM5AESG2BeUdwqd/NfYuWiWm2lSZvpontjMcZzQ1MDdauHztyc9YQMm1i+eEYLHS70J1Wcg8jzWf+hyFmiBIX6bvF1v4JCnj4butOLqK8TjWbh02MAggjhA5u2I8zG2uR8G/avAQWPW1mfbP0wrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223937; c=relaxed/simple;
	bh=O6UUVc8/qwx4AhK6eb6l02eEwuHIk15KKMY4RV8PDh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJycvvm+ekBVDKoVLREhh3tAdULyr5hX3Jde6v8nkOg5XUofXkC4vcix6OT4notLvQ0RzPcYF3grblqf5hfZFI7A56UbDR6QUMNQw85dKfl50JgBMjrF1eQqSx/v2QNJvf9qFUeplZ2EZxMrRjltHc0swm6Qc/2yHNGdKtmVlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmHPVEbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmHPVEbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5128F1F0089B
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779223936;
	bh=FldXbR4WV1J9OtRxuOsHJrP2sECDfbhN7iY+bsxo9E0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dmHPVEbbwpFVo1i3aVijRREIUUbbwG5ErwHc1VKFUoi83kAhvQL9XrxDDp0FGTrb1
	 dOohws3BBQrfdD433Y3j/0nFykQpCfjnlwYFX6z66GV7ipNQ6XXpw+wEyMc5Leu26I
	 X02ibMqg1If8xnaiWKYHf0yZwJRDxaaRbHjJ7qOZstgcuEyTk7L0CdNjzsTScj1DJM
	 BEvID8R3vjfptUZYvzn4JTDNf5iofgvKEXkPLOqnZa8104Z4/dHhRkwp1GQ+uWCC4S
	 LP+FVF4HnyFGU2A0x0dnmrETK6ittrzOFaUTXZx1WnIES5bALw2gZ0K8dqyBCLvvGx
	 Yut7oI9fKUcMQ==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9116861f004so962397385a.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:52:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+8CcQb9OaqngmK1jSQoPPTKX9X+phsmVZ/5AHAtHyVxk/3iOq8e2OqjsQtR+fWBL9skuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi6yKJWQfGYRN8k8qD1gP3mMXuxPnz61dCWKqyq38vnv06pNza
	bJHk4uIsSuGu0M7qmIjnfLp288TUcmHKn4AkMEOrS3UBErNDzew+997PWtMR+iw6dK2QoKE90CF
	hmA00CIPQvPehkgdeTtI04+NBd+jT7wI=
X-Received: by 2002:a05:620a:7087:b0:8ee:3715:2127 with SMTP id
 af79cd13be357-911cfbd198dmr3200284185a.38.1779223935558; Tue, 19 May 2026
 13:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203858.1342507-1-arnd@kernel.org>
In-Reply-To: <20260519203858.1342507-1-arnd@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 19 May 2026 13:52:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW60EONo84VkYbYsLHdAPzpfZ+ig8z=+M6NEhiNj_--qtQ@mail.gmail.com>
X-Gm-Features: AVHnY4KblHrGhpRv3EhU7FCzsCUSJzd7BPOW6JMAkFIow78IptdPVE9AMEcmbIE
Message-ID: <CAPhsuW60EONo84VkYbYsLHdAPzpfZ+ig8z=+M6NEhiNj_--qtQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: avoid padding in struct bpf_common_attr
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:39=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building linux/bpf.h with -Wpadded shows an unintentionally
> added portion of padding because of the 64-bit alignment:
>
> ./usr/include/linux/bpf.h:1510:1: error: padding struct size to alignment=
 boundary with 4 bytes [-Werror=3Dpadded]
>
> Avoid this by adding explicit padding.
>
> Fixes: f28771c0691b ("bpf: Extend BPF syscall with common attributes supp=
ort")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/linux/bpf.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index cc4c0b62cdfa..0f0ec00cae4a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1507,6 +1507,7 @@ struct bpf_common_attr {
>         __u32 log_size;
>         __u32 log_level;
>         __u32 log_true_size;
> +       __u32 __pad;
>  };

Can we instead add "__attribute__((aligned(8)));" here?

Thanks,
Song

>
>  #define BPF_OBJ_NAME_LEN 16U
> --
> 2.39.5
>
