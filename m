Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3C126BF1
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784246425; cv=none; b=DjrNo3aBIFv4k8K9fojOLN7guwzKMdzy+xTaGLBMaKPNs17CWwVpD+OAM5QaxdVNPi5dBwjMZopBHcITM1cTkCdkHB02c3a8+t7NlEXm0jUBRAG9OVlBcL9sCC0WpCgLdAKr8I9FNl+ao3HdPG9hDAdz37lD/WRJ5wbfF3dUCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784246425; c=relaxed/simple;
	bh=FV85GGmpsMCgQRdgB+CrI5AgR1SLQ/WZQpZKMtsu4bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7G6/oEtx7NL0jgHB3GDXFj7zhJyz7LVwIvuLU+rjhsoUqxpbZFvw5buNYvya2JsXl/Zf+Pb2ycxD8EznqURiMEJKhGZQHanrN/rkMzC54vRrGKxsGNNNcY9Pc2SgZdruWCvmdxtaqQpDHdcrJH/q/d33m9uC+2QBPTmotCU+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Exefbbpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Exefbbpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB671F00A3A
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784246424;
	bh=FV85GGmpsMCgQRdgB+CrI5AgR1SLQ/WZQpZKMtsu4bo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Exefbbpqy3YyEfdH1P+9gYzaypWqBPZqykrD8AKDkJKoi73NuAzazSbQlpiBQleEA
	 JmRZ6NBieN02ck5ZBzS5vmaF5k2R8wuoor1QB6tPk1JHVEEDGFhs/kfA7GxSZhkRoy
	 BHO+yyP8XZJWzQhPV1Y2rjab6gmrxcFn7LSeDyH3lq2BkzTUase7+En8LDQ1GqtPGd
	 X6mWShYA2KkCAJ6tvxqE7oBGpFBzhmDNWIt45t70P+mpXQ+oGgNGhgjRSYEDVQNF+q
	 wwTmkqb/FVvRk41QOEhJJKYo9cy0IBzBSUw+ZclacCp2iSiAz+c9JJKO9wZOlnT7YI
	 RONFy94swonRg==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so29154116d6.2
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 17:00:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp4UBpIDY2rrNhe1wj84rLIoKbxoH3f/k+bL80WhWtTV3JLlsUR63hGlv7DuGW2OwdJR/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipOz7m+tMYpXZMllx7t7a8qJjWrpEBYmXqEhX+sbPDL30iSHH
	92tRpOA8PsOMtV/eOpDhUfVBgM07NNPS6gZ0gxcrovopQJo3afl3CT2xlvZWpFqeAb7dzT4HcQm
	8pu7OUZb6Dl461UjnktPTBAINUyhot5c=
X-Received: by 2002:ad4:5d67:0:b0:8f2:4100:8613 with SMTP id
 6a1803df08f44-907782676a1mr4803936d6.0.1784246423346; Thu, 16 Jul 2026
 17:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
In-Reply-To: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 16 Jul 2026 17:00:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
X-Gm-Features: AUfX_mwAx0Gvsvjh_SQkCp6O_MY-GsUz9YxEaRc2ch7UfOgTpRKa2aDJgIpD2nU
Message-ID: <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for
 BPF allocations
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	"H. Peter Anvin" <hpa@zytor.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 12:51=E2=80=AFAM Mike Rapoport (Microsoft)
<rppt@kernel.org> wrote:
>
> Hi,
>
> BPF allocations of executable memory on x86 are essentially read-only. Mo=
st
> paths that call bpf_jit_alloc_exec() immediately make it ROX with
> set_memory_rox().
>
> The code generation, at least on x86, uses separately allocated writable
> buffers and then updates the actual text memory with text_poke().
>
> These patches do several small adjustments to how BPF allocates executabl=
e
> memory and enable EXECMEM_ROX_CACHE for BPF allocations on x86.

After this set, we are still using bpf_prog_pack_alloc() from x86 code. I t=
hink
the goal is to eventually remove bpf_prog_pack_alloc(). What's our plan for
the next steps (toward removing bpf_prog_pack_alloc)?

Thanks,
Song
