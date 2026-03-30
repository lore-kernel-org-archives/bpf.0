Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8481D5CD1
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906758; cv=none; b=WJYJZpzjVtM3e3xccuD4fg0oPQ6/0o0P7CY2crYnti4RB9HdhWnBrAGXbxrYxbTjd1dQMVUzFNSpD9yUM9F8znL7jq7yuagD+zo68j5t54Lg4wHvKQoyga6WDF4ZzRxhDYMoiA+fycB4hAGXYpHfV8FGtNNcspm9nufdI1OW+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906758; c=relaxed/simple;
	bh=M2zL8UVQsrb23MA2vQ0lmirbrYiQPwp5BJ5xd2QsClU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Na6ZTGaai1XQYTwaMNTl2knoYDBMfHWDyPlIpLLBPRrEtGESYeG+80KiaBhEU2+X8DbV0wa+o8OmzoW2y1Ymrg8ZUhCTRCuF7yPxWtdpMcAENkt9aScR9VRWzwlab9K/O3g244CDTH/h8a9weyhPN4SxL/ZBtH2LwlfnThTJjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZSZkgjm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZSZkgjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5601AC2BCB1
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 21:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774906758;
	bh=M2zL8UVQsrb23MA2vQ0lmirbrYiQPwp5BJ5xd2QsClU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qZSZkgjmVEW6AHVlRAmaTm07qO051VGfHjD0tuajiRf35JwsALGe198xomTXE86/3
	 C88d0KUVplbwB/ZPIabLIW56JHQHRK8WDQHhn5cSEz+2NAmoXMhTgYk3zMwdV8vw/v
	 wv9MhtifdjJI3kia2vwcd9mSQuu2g2915IvconNta4AuIGkBhF1eilhjIxxZ4+Hyus
	 YyTWTjt0f385lWMeWqEQ+rVEcebcr3laqbmmzFLdIneH6SDtJhfSAqsD0KaH08ZPRj
	 4fTAYNANutK7LwxQkveux41ofXOAQ1xkdn+qk+902Jug7kQ+1EeN7CEPMFpOuXRzmU
	 CrvIT2CXroppg==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a176112e7bso16508576d6.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:39:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYTCXsGr/B9Pj/c2/D8D0fTL15Ytspw9NzIuNVsEOPfWzeNC6J31zHQm7V6FBuVznf2fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2PiHAm4pLu/GMZ4TuSwjiKSbGht0+79igqPgT8RHvIQhHYpCx
	uFyO7PqEZavLZdTBmpxo1PqDRNDmrIRCPLWHfmjh7gcRH7VtLh2aVlV2csxAVn+g9Q+3y2SNWjg
	8e7H4TjXcxWFcyIup7llgDa9Ertj/5bQ=
X-Received: by 2002:a05:6214:1d25:b0:8a1:6529:5ac2 with SMTP id
 6a1803df08f44-8a16538a0a4mr68608516d6.13.1774906757514; Mon, 30 Mar 2026
 14:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330210344.3073712-1-jolsa@kernel.org>
In-Reply-To: <20260330210344.3073712-1-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 30 Mar 2026 14:39:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW76Z_yiVGOjL6v77o5p6OAqXKOsQ1KZq8KWpj83XMvLAA@mail.gmail.com>
X-Gm-Features: AQROBzABFMBpe48Y2mARTXzN2lGvH2KlYSApEYeyDxVTHoK9f31vqIu2sBTaoyg
Message-ID: <CAPhsuW76Z_yiVGOjL6v77o5p6OAqXKOsQ1KZq8KWpj83XMvLAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix block device hooks names
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 2:05=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Use proper names for block device hooks names.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Fixes: 46df585fcff7 ("bpf: classify block device hooks appropriately")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/bpf/acrVKUy_EPiFFmV9@krava/T/#m7c7906a1ff=
4029e29185aec3266dbf5c8996dbf7
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>
