Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BEE33F8D6
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024267; cv=none; b=gXMlhNZzk+JSlyGxgANn6STVTP76oDejb56ZLrxmXbG8hjKKMmQ4TKfb68yq78gCEcWdw1gos9tuQ68Fz9LkjYukpiDumAwqvTYqJ5m/uOrTkydSsNRUW/k/5bpE0R510bCn0FOUXN9Hl7LQGUZvNJ9t51DODrBSWWlOdCJ9SvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024267; c=relaxed/simple;
	bh=DELOhScVjbwId/MdKt6ptHNY2BsteSM1Zj+A8Y5mtoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHf9hsCl0xq07KoTGZgVihvkUtr8L0HoDvwBvC0PfmIoNqMybB+7uPkwVa8YpjmvsZunyeAhqd1oO5EZMA0e2G7hvYEC59PWS85SdKUvq8E365eWWRK632d4CYLYaxWJnRSQBOZsik36cIBLQ6JdhwE/Vvy5Bu3BpwsQbWNh2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx8hIaeU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx8hIaeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B07C16AAE
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769024266;
	bh=DELOhScVjbwId/MdKt6ptHNY2BsteSM1Zj+A8Y5mtoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jx8hIaeUXk4AAhEKssyTtKXUe5ny8/JOtEUAVjg9Ok/fyT25xD5kRYJfRoP2qfiHo
	 6E0Hwxkw85A1GZTtCz1MOGtdzTEV3FS85bvOO/W+X4XAGTQE+l8kyStSNPhOWMC1BF
	 m/0AZt7h/zVFwlyVxRdHvoNiQZvupZ6OHe0hFxxjcVnleJWwykHJl1ZuQnw8VSTvFk
	 EcdPj3CASVEyOKtyKwjjhoPjGPT/7LN2Xsat5vODi35BnGtaUP8A6OWCYxvmLzz6q9
	 i+Ac3MTdE/Zi7vfYOwzO1H06+K3pNpPaS2RiRXV3qlI+Gvtz5eokcbsOZUh8KMtYoO
	 woIvhmQcivyaQ==
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50150bc7731so2351441cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 11:37:46 -0800 (PST)
X-Gm-Message-State: AOJu0YyA4rIJhnjQRKY2wyY4Q0E0h4B2XQbt49hYMOrTu/ZQMYBmNJfX
	zTN4ztkrwvyGwq/iMJNiWgzMHl4N2jaNSpUWJgpXO3r4wa9eiArTrL2DhcMN6l64vmxPkyQx0rJ
	PBddQ6WHbYM929q4O/h5jIZ+xdOv0qJo=
X-Received: by 2002:a05:622a:3d2:b0:4ee:275c:28db with SMTP id
 d75a77b69052e-502a1f2207bmr251984501cf.40.1769024266022; Wed, 21 Jan 2026
 11:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cde02506-a9ff-465f-a720-637b9033d017@redhat.com>
In-Reply-To: <cde02506-a9ff-465f-a720-637b9033d017@redhat.com>
From: Song Liu <song@kernel.org>
Date: Wed, 21 Jan 2026 11:37:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6JWxRwakLjWA3CXnCxTLnJfhZf1zLFGVxafS0Uz54_DA@mail.gmail.com>
X-Gm-Features: AZwV_QiHdtfTxV6xxZNe5lnP-pY6Kuvfdg-hc4aZEt-r4GxqidaSqZXtLt1MfsA
Message-ID: <CAPhsuW6JWxRwakLjWA3CXnCxTLnJfhZf1zLFGVxafS0Uz54_DA@mail.gmail.com>
Subject: Re: [RFC] selftests/bpf: Running test_progs with distro configs
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 7:03=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> Hi,
>
> I know this has been discussed multiple times already but I'd still like
> to open the topic again.
>
> We struggle to run BPF selftests, especially test_progs, on distros
> whose configuration is different from what is in
> tools/testings/selftests/bpf/config. While the tests usually compile
> fine, many test cases fail because some required config option is not
> set (for instance CONFIG_FUNCTION_ERROR_INJECTION required for sleepable
> tracing programs, which is often not enabled on enterprise systems).
> This makes processing the tests output much harder.
>
> One possible solution would be to maintain our own DENYLIST but I can
> imagine that the same problem affects other distro folks. So, I'm
> wondering if the community would be interested in some solution which
> could live inside the upstream repo. Obviously, I don't want any
> complicated solution which would require a lot of maintenance and would
> bit-rot over time. So, I'm thinking something like introducing
> CONFIG_DENYLIST which would contain "config:testcase" pairs and a couple
> of lines of code to test_progs runner which would parse the file and
> automatically skip the given test cases if the required config is not
> enabled.

I think this is probably the best idea, but it still requires some work to
keep the list up to date. I guess it is possible to use some automation
here.

Thanks,
Song

> Last, let me briefly mention our motivation. BPF selftests are
> practically the only comprehensive test suite for kernel eBPF as well as
> for libbpf and bpftool. Running them regularly on distro kernels can not
> only help find bugs in distro kernels and packages but also reveal
> upstream bugs which are not caught in upstream testing (b/c we test on
> different arches, different hardware, etc.).
>
> Before staring implementing an RFC, I'm curious to hear what other
> people think about this.
>
> Thanks!
> Viktor
>
>
