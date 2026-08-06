Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948613A6EE3;
	Thu,  6 Aug 2026 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980234; cv=none; b=YoTKkJckI/l9TQygKZJlvi3SNMOIq2OKdbo3VJ8XdbvpOQOyJx+2DKn5RzKqFdd2WVdBzgN5IMNq+OrARR9SdYNIlwTJ9SgJXw1bSkWG9x5RKSaQwJSDPeSgfHaQxuzDLs5rC9rktLL8CZVxTJd5nqun936rMuRXgamu1SQeMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980234; c=relaxed/simple;
	bh=7VFiNn1oZ2iK8gf2yzawo4CN+GIVXO/Dy++cb6o1OFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzGpGBI4LzwKaXQFqTMNQCu0qeRxgunuNl7Cr5u1ucuPUQ7cVo7+tSUcDCNLzZcZBF0pf1WW2+gajNtrJpfpDI+m9KgEv9rki4QdJW+MSX8abVQs2ThdavUmtdZnci9OevUFa/UOBRMqWKcTYtRlzgYflTOsP3SSYrj71agUlu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AntI640x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AntI640x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8A61F000E9;
	Thu,  6 Aug 2026 01:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785980233;
	bh=OXMsYRbH+7jzznhDVgVDDek71MXeU29a607Dm+q8CVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AntI640xXF2r8EClsgndc+AamwRa7pN10H/Y+qCA5h+HOoYiK3I+EUkdW7Sed2Psx
	 QwV+W2qotVUky/grOuAuO8Q0DWS/lTLN5DTv8rFqend3/Zqr1LszbihB/1uYKoyPLn
	 txdlr/LB7vvjodT7ndtt51Z8/nW/BB8b+rkN61GjzLro5ePsH7MOy/1FWlsf4H+onF
	 xVBBNWnEeh2uj8EEoj/eYJNBI+TVbfp0ivNoh5+IydAz8PHpHb9SZBb7q5iN9Y5cQ9
	 ITIviGGa1o5vchpteE8qxLN/4LUuF95tweYMUkLsKnE7dJ1Y94nxBsVRAyMQn7NlM0
	 5b6E+4by0v02g==
Date: Wed, 5 Aug 2026 18:37:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, nktgrg@google.com, maolson@google.com,
 thostet@google.com, jacob.e.keller@intel.com, debarghyak@google.com,
 kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/15] gve: simplify reset logic
Message-ID: <20260805183711.2f31aa2d@kernel.org>
In-Reply-To: <20260803184630.3813311-10-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
	<20260803184630.3813311-10-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 18:46:24 +0000 Harshitha Ramamurthy wrote:
> -static void gve_trigger_reset(struct gve_priv *priv);
> -
> -static void gve_teardown_device_resources(struct gve_priv *priv)
> +/**
> + * Request the device to release any allocated shared resources.
> + *
> + * If any part of the teardown step fails, the failure is documented, but is
> + * otherwise ignored. It is expected that a device reset is triggered
> + * immediately after tearing down device resources, which would clear any
> + * lingering state on the device.
> + */
> +static void gve_teardown_control_plane_resources(struct gve_priv *priv)
>  {

Triggers a warning on W=1 builds:

Warning: drivers/net/ethernet/google/gve/gve_main.c:705 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Request the device to release any allocated shared resources.
