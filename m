Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC159346AC1
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769140553; cv=pass; b=sFg2shSZDANF6dKrDKxuzJ9ouKZ3ZdrmiF7X3+/hOw30w2iGsIB0+16n/AV0Nw5AwM2x1+Nho7/kbLibCqnhkpDXXvFqfkIFrxBpqnOayRv1NGMgRKiGf8n9tYMtbuCt8Q7K/7FPgxVVzi5amkcNvBA2kTwsc4N51diY/i1i2+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769140553; c=relaxed/simple;
	bh=r9jHNWMSvfTiZP6TKyMQXs/9znXBmvFyE7ShBNFhg68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DW/SFK85dsbirUQON8+qxF+r1fe596npd9X655E3RbNzf4vUDRH8XjSIAYM/qyktOHUTS3PgWnppHmmh1ogcSKPyw9/9DWng3AABeYlAvn9kaVemQy2xPiqNNIaE8h1VBJqRuRHrGdBJMpgULNPr+k+BeZKgnhdAxmNvSTTIaaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr283itV; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr283itV"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43591b55727so1578129f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 19:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769140541; cv=none;
        d=google.com; s=arc-20240605;
        b=P3nAlU31m43zRf/DeclHI4l4wzld7G7w/Puq1kVQir4Z8epXbGFCogOytM582VIRBu
         gpFG8JJd6PrNJoeyDgntyOLGwzFBF2nbSkHxulaIspnSwjNfz7q2drOLLiMuBoxRHIyo
         Gb6yNzb+l6uYo3NcTBN8mDw3OUmZdwdpvCnNwJaTmnfYJjiPuMmKdY5pszus6oadnEkG
         SlsP0QsD/L4rpQSXtzDIGOX8UWV+xHTmVIj3u4lj//lxUcwr9KrSfBskubIETmnEbOfb
         68TCxSyxMjKzJihLpMjhdC0qxkG5QBEehFI9YLXvjJz9AQL9P/facna/sBWcxIZkKiDn
         MwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLUC+i+ADen7EDXOxfQZCpoTM8xhG1CfD72IdTQT+yM=;
        fh=Qwi4bkM/TcZNakyBIOP2hHL6j49r9ebjziY5QnZErxA=;
        b=Uns/OyLLemrj54ZjxGe/hVsDrtZG2WPbDotLN4xOZ4O6hMm2KgJt/rpILArzAsswQG
         fn6CDHIoDrtzcSQkXgf8LDCh7+U7e3XIyQPQ5NOHv8k8BrE9OUqwelI4uudjKKh/94hz
         +5k0i+tuOniHtGpgjwyYiDq5qTLSbyjQCFxT+f+khoK7syxV2YkonjxpwE9BLkX0EaNl
         edNy6LOpHHAzQ1aZ/KFyIKOUs7GFbM3pqEk7GL5R1860J8igSEQZ+Qq+uoOrwTt0m3v8
         b8qQGsKNi6N+uTouLaYPR6MyKBEHNI1fbdCfPQ1WYXGceJxBEuIN8B8s6zk3OeA/KC8v
         veXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769140541; x=1769745341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLUC+i+ADen7EDXOxfQZCpoTM8xhG1CfD72IdTQT+yM=;
        b=Wr283itVQA/08aWtrCdvA/5rHxNYisE4bHuEllFQE4LnL1o+9MCovBMtwrEw1sCY4g
         hcsizIuKM6VKVLrCnRsq8fKb+9o4MTonWjtmRHcX5Yd9rjS3eAJUqv3ldWQ8PNQHfrb9
         Y3tNVZTTQVDtrpnR8SxgaAoJclF+UgMDmmpqNIOOVljRDNUcIN6c70tJvLPGsgXToAl1
         4eJI8X5TfcS6qB3RNr0FdTh1IzB1RAxkiipzlUZUqkIRrs1Dvz1z4Xeda0lU1gpjkGUR
         Y6qmptXFtnLTUQkmr8fWXs+/YUndG1jsTxSVFlmzmlvWMaSDSIIGn2x77KxUtOPOm/SR
         RzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769140541; x=1769745341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oLUC+i+ADen7EDXOxfQZCpoTM8xhG1CfD72IdTQT+yM=;
        b=TJHVX/6P+NZy2fftm+bKFvDVAYRo8aSl4BHH19BtJJeem37yoOtDh5gBfndKDTWe+m
         qspid/Dem/dPOal/h/9G8sj7DyClN2pNeh8f1cfOTZ4UUyn+1UGEOnIwXtnewxeeR1Zl
         hnycsdFr/h8Fb9SerPCEpzOn3OhBsGscmYXPQ6ZNb5u0XfmtXVKRs6K5/stDw27zYY6I
         vIN9CQZdOU7l4Gs0bYIZIWZX5L85WaXHc7s6eyjlxg1k0v2FXVEWEfI5ZGSqGj6PMtHy
         ZcEbpn9LK9qMpAImn4h2MNI81MNhbrKxvGi08WE2jer+ZF/9ZLWJPu2FtFohB/HKmY+/
         SxOw==
X-Gm-Message-State: AOJu0YyT8k62N5ZeeZ/o4odDnKJcSGV2CU8h0XmWzW4qJ+swfx5DdAS1
	+tlZZX5/eIOSGApbPn6UqQkl6bi/NYmnqdWMtsnmmoTh3l7YSjFsX2MUejcAIPgeeX1BU3qnBOI
	y8S0vJ1R3ngAh+TmZpgNjzjh1SVvI3mw=
X-Gm-Gg: AZuq6aKMEBdua3k3MEGUUCYiGLY/k4WHk9HHqtWYG0xpqurSr0QZdXIYmelPJFrkeqo
	kIj47nVWY7gqsPppS+qy4BEqSWxjIMRoGYvFwsZEDtDCp6qgcIwemU+15oew6DS34zUQjn2S7Xb
	LJ96oIXpJQZbLn+52yfe2RSgvqWpDVpapLxlcZoxEVb0jhbKzNKn+WyzRHOcF2FNmsciA/NBoKf
	T3sGalkwTnGa8fumw0hDlFP7o7i4bXzutoQ8w8yG9wrefU1smbnTRag7l0OwdSs2FPrjMETVzRi
	fEbKZSq2S1n8b3LS+QTSMecK8OTs7qj9MBEUysEm6fbT2M8E+8elQ5FUXCFxQe7kooLdkigXNF5
	E0HxQXBQSDPkRow==
X-Received: by 2002:a5d:64c5:0:b0:435:a0ca:bdc9 with SMTP id
 ffacd0b85a97d-435b161bf3cmr2680572f8f.44.1769140541425; Thu, 22 Jan 2026
 19:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123032445.125259-1-leon.hwang@linux.dev> <20260123032445.125259-3-leon.hwang@linux.dev>
In-Reply-To: <20260123032445.125259-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 19:55:30 -0800
X-Gm-Features: AZwV_QgqHod6Vo7nyP7nHa4qnphQWjyMdvjVdCTjYDN8Z6Yuxj1TGy-HCaBPn3c
Message-ID: <CAADnVQJLz+nMHCZXUgy2MOxwFczEHNbG8ZUgfZeUY4yXFUKcNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 7:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
> +static int probe_bpf_syscall_common_attrs(int token_fd)
> +{
> +       int ret;
> +
> +       ret =3D probe_sys_bpf_ext();
> +       return ret > 0;
> +}

When you look at the above, what thoughts come to mind?

... and please don't use ai for answers.
