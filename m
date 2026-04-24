Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4282E7165
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045864; cv=none; b=OfZLu+NPDSRYTOX3Y3SVemXJp9IoidSE7cO4hOYjNWYoa6zAh9+0I3eEDjMSWtNX5hE2H5d/t26sn4hPOoF7zgdS/WpMIO1sL9bHMezSiG4JvcxT8DRApX6NPo/KZkFcc+qvAQqajfF4P4BNbPKNCgQJBNbaOnWpJmf1nA2N/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045864; c=relaxed/simple;
	bh=YjXQNV8OauYeDrdhMsU00T+1ceHJkPAvfGVjsfjyFNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyrHyM0CfZWQzdIFTmS1ATJm9uGA9tcvHtzdcaKeFLMlXu+D0OJKd0bA81UvyzkFn79MdbJ61nULiDb1mjkUwQrWzCwqs4p6VDJkcM0+8ehs9fZKKLOHIsegV1mJA5K+g1wbed70zV4iYgTID/IMAUuMwIRYQKBXWDaDaL9htrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is4EurYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is4EurYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD426C2BCB8
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045863;
	bh=YjXQNV8OauYeDrdhMsU00T+1ceHJkPAvfGVjsfjyFNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Is4EurYVIOtYQlO8kACJgD4u/Wyt6HAuKthMo5iWyndVAjM0eKQYhoDezWP98dMv4
	 cHS1RwM3B8yRIHSRs5zkDuNxrz81GAZZB2r0SDcIVL1KTQ3QUnU4FvVt1Y4r5aSkk3
	 tbii5GNch88hdmPRVnaJJVBn3iTjyuxuVRAapSsUBPovozv2I4YFa20z/2Rj5+amlK
	 +9ATb4fXpmJFY3sLOjpcETX5Y7wXqJCQ816yRhapf6srrT3zu0KekxyJSDfrMELeRI
	 7guMCML39qAOdKriWv1HMxX4x1DBKawPvEb/KMMj0+WeXfWGTsbUWhf9Dmh+CJAKsr
	 7zsJImiGdwRpw==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899a5db525cso63349396d6.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 08:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ851FKiGd1sOXG8hbhO6cJyljOSBK0vNlz9SyUBOSIj04wMeIHiZRNcwGFcshNpXesybBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/TQE2kDFSfzOO/GTQvL16bLrP6CqEqsxLkYqCjX/d107rhtk
	e8X8Ks+IoPtAQ3swIAT/ustNMtEcx0tGqpuAh5sZoJeSA9tqOFRTycsOBrsE4eyaOXajrp5hkku
	9Kjp6q52X0+FBIKbCV/7T7JV9uSJ6+SY=
X-Received: by 2002:a05:6214:4104:b0:8ac:b053:2b38 with SMTP id
 6a1803df08f44-8b0280ecdd1mr483894586d6.31.1777045862799; Fri, 24 Apr 2026
 08:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424153905.354922-1-jolsa@kernel.org>
In-Reply-To: <20260424153905.354922-1-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 08:50:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5rcXABPeOy7PFkHkO8WNyfqppGpB5ijTvmMbj7GVWfcg@mail.gmail.com>
X-Gm-Features: AQROBzD7vKe4jUX7_u1aiOXiJ_CocfrwTuDkVypGBAR-nd1KryoIhFlLRJwB_RY
Message-ID: <CAPhsuW5rcXABPeOy7PFkHkO8WNyfqppGpB5ijTvmMbj7GVWfcg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Do not release trampoline image in case off
 unregister error
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 8:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> If unregister_fentry fails we still have trampoline image attached
> to a function, so releasing it could trigger crash. Releasing the
> trampoline image only when the unregister succeeds.
>
> Cc: stable@vger.kernel.org
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

The fix looks good.

Acked-by: Song Liu <song@kernel.org>

Can we add a test case that triggers this crash without the fix?

Thanks,
Song
