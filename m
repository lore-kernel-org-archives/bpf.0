Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2262D47AF;
	Tue, 29 Apr 2025 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970799; cv=none; b=iOzZT7oean4fSLhXa/jsbxf5A3ImzJYBWqXq15ARLJoigmWQoiO0FkbXrzImEwN5KEqS62Keg0UnCwlLtE0iS7xVCcKXsleQBILsbKC2aB23t8fAegJRZOgfGfATLR3VAznKBEGZzV4Oq+XQCkAfPzzCjKNLSqujwZ33vzWKSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970799; c=relaxed/simple;
	bh=POfxadEkvYP12YbI4Fyv1KnzR9RyFXtL2BGRJZ1OFL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiAfnJXr1b94RMEKiAcSXmC7nJkQ73npII3vq/J5yl1pdhlp5gJPQ4mhf/Dy1y5svik6GWTXDz4VxWnjDd76QE+Z/F8eUc1PXaQrVmGmfg+WzBHS1zoFj7rEly7y9Tm1LwW3tvpMPlW+GL8Zpu33SnR5MdT/tzX78HbeNvTr1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn96014/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn96014/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39149bccb69so5511379f8f.2;
        Tue, 29 Apr 2025 16:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745970795; x=1746575595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POfxadEkvYP12YbI4Fyv1KnzR9RyFXtL2BGRJZ1OFL4=;
        b=Jn96014/v3nysw1vEhRSJYmRwAc5RWPJLKdjbMjd0ERie2k1x50sRaggqxsuC6kTFg
         zYb/CHQVA+Dx3QwO0gDoAGfAjGsI5B2kQgzOk7lFpxm1jY+O+24/MV3NZGAbYcEOwuJM
         gLYdO11/iwLyCFcX3eJbm0knEW5lEQPptNP33l8euzSNct3bQP6zvsgkKxqfaIRmOhzG
         DnikxUoStRft0AvkHHAbRfpUCRh7UW6iAua8rFnwr3baNsuPH9fyHtDKKJe7XrFPCfhH
         7sLbpdmd+cx5JF11DnQgU9w18AXyV32z9qAYMgf2FbVD+83Wp6qUDzeL0gpaMduwRaAk
         vKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745970795; x=1746575595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POfxadEkvYP12YbI4Fyv1KnzR9RyFXtL2BGRJZ1OFL4=;
        b=CXHdoqdLDbaJ7iXCQOrcj4PEWgoyNacAzzuaf6gRqBbSaoUCGhQaCLlO5SNMinBFJZ
         WlYLtRub/ez4vfM7TDrshdTV2U2czGQryCxYD3aw9x4/epxw4doxCEwKpCakmjVefHvu
         bZZhUaspGhADaCe6IZ0Qj1+LYZ97PHo2aTje4/o8vy/ZxFEwyDgdXNa2OEMiRzjzo/gL
         rDumlAuFQeCPZDYlW3i25hDLKczQ9jcRRlvEKtj2oh5N1E6Hsl4Uo1keIYfUqrUMVJ2x
         2A+E+Ze7CGFFnAlWp1iY41YwgUorurlQiL2BGG8enihuQE9FXahyilmMpUQv30P0iTEi
         V5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUDliGNQT+DbSgeqOEpIcpKqNtgRSZ8L+9P1mzaW2Zc867IyRF7c/ANpj8tbUyhDbd95iTauaKAkJCAJqLus36E@vger.kernel.org, AJvYcCVjfK7o/OTOEV6Gp/1+kVB2l1RwgCRaZUTgPuA/YkyU4nbTD+BIUE1cFeNfInDHPAP4dt6WG8cS@vger.kernel.org, AJvYcCWWzHIe0+LMxj3kBpOYZ8lMxZ01rH7KrLJ39xQRZqZJ2fbi1eNc0z01IegtJ4ENuHk9i0PDYY2ue/Rvydne@vger.kernel.org, AJvYcCWwxiDHRCAKuNdIET6bJrR/+EEHTEHBajrCDxCWjNvaJVMhql+IZ9s9C7tWbNn6BjMsWIS+imAsIrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF13oab2XP0bcMperZPMlsHBqtepTsGRjReJ5biyuJ876tdCkm
	J9Fwg83bFHriNpmX0zGP7STOlNM8sRbFOTaFobSgiWqeE+1ioyocyBRfWsOAB2S7/+Qas6wm5o2
	qUqH5T9nPgOlDmQgPq/iDsZQC6zY=
X-Gm-Gg: ASbGncsQpBB2IQnu4ZnpknAEiGJTGNxh5hEOEPOIsK0+rwRdAK/KcX/VKPNipwr+m11
	lDXyi3HwMcRl7Jqn0VpuJ4pe2MbDiwN7hfJAWGa/hEgAG2wid7mdfqarFtl56GOAdxBw/DUWnld
	v+nVWyj5FRA86njY2Vj4vOekN+AmgcCM6aa1TZZg==
X-Google-Smtp-Source: AGHT+IHfQ7021Wi0Od483NxBRwOwlGT8tEpRShkiNypqzqZYLsetUGmXm5nnqFTtQjliYCEyubmVfYYLFsJBvNrlXbI=
X-Received: by 2002:a5d:584a:0:b0:39c:2c38:4599 with SMTP id
 ffacd0b85a97d-3a08f7a48f6mr963346f8f.48.1745970795091; Tue, 29 Apr 2025
 16:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428081744.52375-1-jiayuan.chen@linux.dev>
 <CAADnVQLiqHUVZQ7MdqAfnUK+01D5fSt6sDR5nzon83w39ZBohA@mail.gmail.com> <6cc9ccc1339839559710efe94bbd1d61289bdaaf@linux.dev>
In-Reply-To: <6cc9ccc1339839559710efe94bbd1d61289bdaaf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 16:53:04 -0700
X-Gm-Features: ATxdqUGehvH5TBOumxUn713AmXG-enA239BN9cFJ0Osp5Y0ndJxOfXZNQviCb_E
Message-ID: <CAADnVQJWx9NJPGSrTv=WAwp9Zf8eHGNFwpC5BX5CYjMWBcWoAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf, sockmap: Improve performance with
 CPU affinity
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Jiayuan Chen <mrpre@163.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 4:47=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> >
> > This looks to me like an artificial benchmark.
> > Surely perf will be higher when wq is executed on free cpu.
> > In production all cpus likely have work to do, so this whole
> > approach 'lets ask wq to run on that cpu' isn't going to work.
> > Looks like RPS helps. Use that. I think it will scale and work
> > better when the whole server is loaded.
> > pw-bot: cr
> >
>
> Hi Alexei, you're right for requests coming from a remote host, all CPUs
> are running; in cloud-native scenarios where Sidecars are widely used,
> they access each other through loopback, but for requests accessing each
> other through loopback, the wq (workqueue) will definitely run on the CPU
> where the client is located (based on the implementation of loopback and =
wq).
> Since the Sidecar itself is bound to a CPU, which means that in actual
> scenarios, the CPU bound to the gateway (reverse proxy) program using soc=
kmap
> cannot be fully utilized.
>
> Enabling RPS can alleviate the sockmap issue, but it will introduce an ex=
tra
> software calculation, so from a performance perspective, we still expect =
to
> have a solution that can achieve the highest performance.

And I think it's wrong to optimize for performance of one particular setup.
An API that picks a cpu is difficult to get right.
Too easy to make performance worse.
