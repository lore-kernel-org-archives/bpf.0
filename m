Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABE380FF5
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513959; cv=none; b=YgSczK9N1NE5xjejRYZNMl7Jz9jt/sbIqvyJ63zE5hf7/WbqieRl3ZR8jX+9dciR0FNyz9X0sL/Lw8nl52UCIqyGectsxe86bHQxby6HCMUVtaUU8CtPJWA7dmQgD9Ry55MNoSVCy70PQqOY3hVOKFJHCOJg9oc8DFffPQ3utzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513959; c=relaxed/simple;
	bh=SP5uETXIwc+BTie/21tZx+eDKW4hF2KAxK4NQ5wBmOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qyq5SRJNPVT3ftDXRMiV5n9fKjjYqZeHANdUrzPFwgLL4WKNcfhUHMcDW4vnczX9C9raNUTpSCy76ClSruz5jCEQdwqDz236L0xl53a7LsVswssdQX4gLmmqqmuFQnqWa6ZbLewXBb44p1KvANcWfG+BAE2DFH/1lZx+GLMiWiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsbvLtpU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsbvLtpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347B51F000E9;
	Sun, 23 Aug 2026 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787513958;
	bh=nHIvbsS0RL5PCN4yBm2H4gWtv0vOpK3GeWgTnw94ApA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YsbvLtpUH027jlumBASKQ/nCwnC5TH9L/Xmg8Lue/g7mE+sc3tU7k4sbQLN+TEi+8
	 cLAneDN0QwopPIHXgX0r6CdhqJaHgBR2xhSNbzJnNMbwHQwF96BQjDDZ1GHcNPjA7D
	 htNSQlslExJ5tlQDq5mAbKJ7kL7UGmoO/7AOGlOWwySYi9bZFcFQTlHWyNO9ls0KPe
	 6163Ru52HLEKh2+0mdZIvNxLjEVsa+pk1EjREr/JFZsuiC9EShxqFRESE9UVEMyQlt
	 Zfr4j435hZYg58p79ZnzGBJ/AeNKcBf9zHeICOs/fx+w3vJOqnatZfbXSrvOo3OBlj
	 YYZJ24WigOmDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Reject oversized stream read
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260823193202.2389715-2-memxor@gmail.com>
References: <20260823193202.2389715-1-memxor@gmail.com>
 <20260823193202.2389715-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 19:39:17 +0000
Message-Id: <20260823193918.347B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_stream_read() permanently loses successfully consumed stream d=
ata and incorrectly returns -EFAULT instead of a short read length on parti=
al copy_to_user() failures.
--

--- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Reject oversized stream read bu=
ffers ---
commit ec0075a06e269ba85371f18607bd524dfc2cb4f7
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Reject oversized stream read buffers

This patch updates bpf_prog_stream_read() to accept a u32 length and
explicitly rejects values larger than INT_MAX. This prevents oversized
lengths from becoming negative when passed to the internal signed stream
reader.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index be9ce98e94692..c8d1d0b03f180 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -196,13 +196,15 @@ static int bpf_stream_read(struct bpf_stream *strea=
m, void __user *buf, int len)
>  	return ret ? ret : len - rem_len;

[Severity: High]
This is a pre-existing issue, but does this error path permanently lose
stream data on a partial read failure?

Looking at the while loop in bpf_stream_read(), if a buffer spans multiple
elements and copy_to_user() succeeds for the first element, that element
is permanently consumed and bpf_stream_free_elem() is called.

If copy_to_user() then fails on a subsequent element, the loop breaks with
ret =3D -EFAULT. Because of the ternary return statement here, the function
unconditionally returns -EFAULT instead of the bytes already read.

Could this return a short read (len - rem_len) when some data was already
successfully copied to user space, so the caller knows those bytes were
consumed and the stream data is not silently lost?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823193202.2389=
715-1-memxor@gmail.com?part=3D1
