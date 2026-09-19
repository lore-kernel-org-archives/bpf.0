Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930723218BA
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860117; cv=none; b=fQEXzkgewLlfkjAPcL0pi+HRJE/IsypRvBJ9/fmbX9fDJqKa0nNxbgMs0Hq0DI34jRDtSQnrtcJl6hzeZ7tqw8xrgkwYQYLWehwfZwk7AX/THtshWgPaHriZ0lrgBkaniM8cf+Ko+jZeGG881OA4nJnGUEh6110ViOFOOUxU2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860117; c=relaxed/simple;
	bh=Dz9Pg/RisBylqu21YuBa+QNZhpaAG0yys7Xa/DGJtIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYPcEbMh9wSsTZuSAL8+KG4ta3YmVFjbH093++q1Bu2NKl1QA6fz5Hmal2ffTioIeGLJqqmFWWDykYnX6aLjfJeh45LfOqyq79uH5hXbCJzcejkXJSlxIwrNbBIoU5tDlVdROR9J4vO7BpUc2NYChKbQzZypxVyhqmfR4yLUdng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoQpOaeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoQpOaeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E21F000FF
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 23:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789860116;
	bh=M2emGDt6ZD/PlD99DnGeYO2tV70JoaEZig2v2GPbr3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NoQpOaeQ8eRPAsoWhljliNHLMkQ3/VkCPq6Mf60ggXZAQjaDGR6EPOhCbZRKkA6zP
	 8JBQFtSBywHZeSqZfLnBOH5Zx/p5FjaAKlGGTY1dvS0QJqFV0QxptDo0/2tkHVhsp6
	 C89emFqbNAmUG8VoLQ1KAD1/IJfvIgrDMhgX9EPcwrrJj8CBMkZDJGL/d8kv/1XWij
	 Loos/gXqaRuxQl84fpy6qp6QCz2U0IHfuQmZMaZOQpZHAlcd5HWlvCPlcShakGYqut
	 cwl4F1iAQgnFHslRlVMhk+RJaYI9PkSU3wF6CxecEhBKkk3x+3DUvGsJ9WX0A3N8V1
	 JcOYmO4jYetTg==
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcc3e14so7413606d6.0
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 16:21:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxblBDmBthwaNZrzgXar8jBDF88g5/1FammtOUTjwwTYESbJU7W2kW1Oj56o28trCahX2c=@vger.kernel.org
X-Gm-Message-State: AFuF++mV2MfVGU6DGqoFKXZGtD7tJcBSijkcrsIYE8xhhcLu5T46cmGA
	cdqg89vTlL3kGeofJjJ6gtCYw39OPe98oPYizcqeSrvJeIUBDHC6ih8tpANj7LESr4Wo2/3vu+D
	XEFw37+CcaB9j1Njo4CG2puVKBq98wmM=
X-Received: by 2002:a05:620a:4416:b0:93b:d7a4:9d4d with SMTP id
 af79cd13be357-93bf5770d59mr363723285a.32.1789860115649; Sat, 19 Sep 2026
 16:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789714023.git.zhuhui@kylinos.cn> <02f0a8dc45a840d7801ec17e0c1168f7dacf9b73.1789714023.git.zhuhui@kylinos.cn>
 <b115ece2-33a1-412e-ac25-38f339a13599@gmail.com> <aq2bo5Q-YUj7lkxn@linux.dev> <CAGsJ_4wauwY1-xRdM4aVb7FkSttKYzsKsWH4pF4i=Sspri0-jw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wauwY1-xRdM4aVb7FkSttKYzsKsWH4pF4i=Sspri0-jw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 20 Sep 2026 07:21:44 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yXMcPASKtOBZWnyN1ztoGFoGjChT3N25UrFL9QovAdGw@mail.gmail.com>
X-Gm-Features: AcwNN1U1j2QcyV3XRNhP_V-Q0Z2asX8-vPO3_K_IxjKnLVixdgROQw93LqTOeL0
Message-ID: <CAGsJ_4yXMcPASKtOBZWnyN1ztoGFoGjChT3N25UrFL9QovAdGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 6:36=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
[...]
> > > Related to the previous comment, you treat the special values as part=
 of
> > > the range. It works currently, but creates a layout dependency on the
> > > enum. I think it would be more future-proof if you did:
> > >
> > > if (swappiness !=3D -1 && swappiness !=3D SWAPPINESS_ANON_ONLY) {
> > >       if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
> > >               return -EINVAL;
> > > }
> > >
> > > The previous comments I brought up are now resolved, so assuming you'=
ll
> > > make the changes above you can include:
> > >
> > > Reviewed-by: JP Kobryn <jp.kobryn@linux.dev>
> >
> > Hui, please make these changes and just send this patch in next version=
.
>
> Hi JP and Shakeel,
>
> This feels a bit weird to me, since 0=E2=80=93201 are all valid
> swappiness values.
>
> 201 (`SWAPPINESS_ANON_ONLY`) is just as valid a swappiness value
> as 200. In contrast, -1 is a different story, as it indicates
> completely different semantics.
>
> If 201 is treated as a special value, then 0 (`MIN_SWAPPINESS`)
> should be treated the same way for MGLRU, since 0 means file-only
> reclaim there. This isn't the case for CLRU, where swappiness 0
> can still reclaim anon folios.
>
> If possible, I'd vote for keeping Hui's current code :-)

On second thought, you might be right, as there could theoretically be a
case where `SWAPPINESS_ANON_ONLY` is not defined as
`MAX_SWAPPINESS + 1`, but as, for example, 400 or some other value.

That said, I find `MAX_SWAPPINESS` and `SWAPPINESS_ANON_ONLY` really
weird. Somehow, I feel `MAX_SWAPPINESS` should be
`SWAPPINESS_ANON_ONLY`, since 201 is actually the maximum valid
swappiness value, rather than 200.

For the change suggested by JP, I think it is right if we don't clean up
`MAX_SWAPPINESS` and `SWAPPINESS_ANON_ONLY` properly.

With the change suggested by JP,

Reviewed-by: Barry Song <baohua@kernel.org>
