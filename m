Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5706341ACA
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241804; cv=none; b=UrSaXr0PNYQrCIHtA35RMGNaV3VW3ZGIdfi6k6Oh56o38T00u/rZSLxaV6Q1Vop3n/HLbh0g7PZcxJfv1uWFuGEdO/eSOnxT0gcIuTc8CUXPWN0VXI4ILrqax50SL9mYAmH93UFGaS5vxtJVt/mvi0H6ewku9aHKMQyG88Ktmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241804; c=relaxed/simple;
	bh=yZNZkSiQKOTxKk58c8jqGMDP5Fd/eZyK3vJIf7WNTsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/TBRi5m2JMnnXrZUlJTXzQpSCOIQzE+smzEzBMTS9jP73QrqcIT168nWkE98vV9cZJ84G6bXKjGrPVvM23luC5OWw2m8Y3Y5ZLkuovSSw5KzHxppsNrQ+lR5fzV7Xgj3ePc3uITvuyGoBNdwQ+IUGQ6ztIiBq2d1PmXjpnnv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMcweP11; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMcweP11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E543C4CEF7
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775241804;
	bh=yZNZkSiQKOTxKk58c8jqGMDP5Fd/eZyK3vJIf7WNTsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TMcweP113MOGlxe0gV0M35r1f878silVcfDUKUvN03HwN0JmTzm6gMwX3yM4ybFLL
	 eE4fkuEhlDOux0GVXWBqqwIWuC8pOdk3q3/xDxWy9tfyqpt+j1l7vKM0awMmukLiWv
	 euUQ5WdKl0unpYbkJp63MuxFKQt6yN38zO3vnk0HyB7I91OE2BN2WYFblNlqAI6Pu9
	 NUwMTIBGJ6oXbqb97XXsDCr3oh/nLx9lA3ZPlVWHjm6c8tpRQlQVXoSedTs0ajXBy5
	 itWs8i9CVJ+3qCd4XNENpTS70Ye2Vy7THAVKbZ+MbMaVDPc6uVAB5bAXk99/ZcLWCr
	 GGB/8PKZsLRPg==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a23f802e0cso35912916d6.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:43:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YxYo803WTpXMtYhedJ+bZGx2Q6HXFNd9PJQJal3CXy4QCZtlwyk
	Jwfklkcxlx/7/Fh7YawQdgjDWFkCdYjxWtneCRNCtj0zGQt5i1obq/2sDoFqRoM7DikU1RcCb5Y
	5Fx7AFga2Myp+zkieBrKdEEOK8uOpAQA=
X-Received: by 2002:a05:6214:1948:b0:89c:5e6e:7774 with SMTP id
 6a1803df08f44-8a704bb9fddmr69319646d6.51.1775241803463; Fri, 03 Apr 2026
 11:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403042720.18862-1-emil@etsalapatis.com> <20260403042720.18862-3-emil@etsalapatis.com>
In-Reply-To: <20260403042720.18862-3-emil@etsalapatis.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Apr 2026 11:43:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5uUoOZvUppR0eEum=JZ-nKVmxRyNgoEphDDJx=VKkNVw@mail.gmail.com>
X-Gm-Features: AQROBzAuJpHPTXD-5iamc9wKbv2qC2h_s4OvHL9m2XntioJ_EeMEmQUg8q36fxg
Message-ID: <CAPhsuW5uUoOZvUppR0eEum=JZ-nKVmxRyNgoEphDDJx=VKkNVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] selftests/bpf: Add test for scalar/arena
 pointer addition
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com, 
	daniel@iogearbox.net, eddyz87@gmail.com, Emil Tsalapatis <etsal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:28=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add a selftest that ensures scalar +=3D ptr_to_arena instructions
> are accepted by the verifier.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Song Liu <song@kernel.org>
