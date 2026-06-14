Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61258BE9
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781402364; cv=none; b=kSEPGlA5kzBszsEJpMOPLez1SubMPME1dIu+6aZY/WdveXAvAPN5uOeml75bHyqiolrKcKLHM4D74VWc6dOE5+KEVPfKKZZubgiXNpiqzfQMUp0ry3+PtgyzPul4c/UqJdlqi4wN6OYh/TLauyPWxpZ6aRpzcTBTmo0apMN+C+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781402364; c=relaxed/simple;
	bh=64ycfqUQF3hDlD22szamPn6bsGLecriwVe1eHgm73Eg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YwWHI8LgNJvnez587o2eAnkUqVc6F6mvaeb2OfznMrcfiI/w2KOrLt/u/BfIl8Vd/7hLM8OIbuGhZdAIB456YN2ZFW2wQL3PD+ckbnWVIdW2G64pqbF3UcdxvPPwCI2AaRq54Sm8rrBIfdCEXLsasKjpHSYFPdY+APW+DTiemXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a43Jd8B2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a43Jd8B2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC301F000E9;
	Sun, 14 Jun 2026 01:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781402363;
	bh=bRoGoyiBjtFo+2/C8UPMPgTABIV4/KRyTAnt4egLOos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a43Jd8B2hC68P3KLbadeXBM0Z6/nwfZnHHTwHuJxBtsl6hpvPklr9Pmus0xNAWxg1
	 yB3Z02BY1AIw/IBOHgDryIWp7sZBXfokvRee9iA6fR6uf+qTZx4NF3eIejqJP1n9BX
	 eY6IQsl1lCjUMX3mV7Lxdsty+R+t3ORf6rcmCn0USio9NFb6mquB7maDrA5LraE2Is
	 Cs+QfhrtkfioZS/Quj+QQPkTmiB917ReKKNAsT0Mc5vvh66l0iJjktOne4UIUfO2ca
	 ZkvEfL0lKt3uvGtzXvG0tcDbe6voHQ4JDPULwmDxLdblacdQjpUkwnWmrO9iLTBm0x
	 vfkVhf9BL1Mxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 4/6] libbpf: ringbuf: Use compiler atomics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tamir Duberstein" <tamird@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-4-e623481cb724@kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-4-e623481cb724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 01:59:22 +0000
Message-Id: <20260614015923.3BC301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit monitoring applications using the BPF ring buffer on a 64-b=
it kernel will permanently stall after processing 4GB of events due to an u=
nsigned long pointer type mismatch for producer/consumer positions.
--

commit b302f5c853774170c0ab9e37b85abcc4d647ac3b
Author: Tamir Duberstein <tamird@kernel.org>

libbpf: ringbuf: Use compiler atomics

This commit replaces architecture-specific smp_* helpers with portable comp=
iler
atomics for shared memory accesses in the consumer-side ring buffer code.

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index b7adce37b5196..1c24a83f59d5c 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
[ ... ]
> @@ -284,14 +284,16 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
>  				err =3D r->sample_cb(r->ctx, sample, len);
>  				if (err < 0) {
>  					/* update consumer pos and bail out */
> -					smp_store_release(r->consumer_pos,
> -							  cons_pos);
> +					__atomic_store_n(r->consumer_pos,
> +							 cons_pos,
> +							 __ATOMIC_RELEASE);
>  					return err;
>  				}
>  				cnt++;
>  			}
> =20
> -			smp_store_release(r->consumer_pos, cons_pos);
> +			__atomic_store_n(r->consumer_pos, cons_pos,
> +					 __ATOMIC_RELEASE);

[Severity: High]
This isn't a bug introduced by this patch, but does this write to
consumer_pos safely handle a 32-bit userspace application running on a
64-bit kernel?

In the kernel, struct bpf_ringbuf defines consumer_pos and producer_pos as
unsigned long, which are 64 bits. However, in libbpf's struct ring,
consumer_pos is mapped as an unsigned long pointer, which is only 32 bits
in a 32-bit userspace environment.

When the 32-bit user process updates consumer_pos via __atomic_store_n(), it
only overwrites the lower 32 bits of the 64-bit value on little-endian
systems. Once the true consumer position exceeds 4GB, the userspace 32-bit
value wraps to 0. Writing 0 to the lower 32 bits while the upper 32 bits
remain 0 causes the kernel to see consumer_pos drop to 0, while the 64-bit
producer_pos continues climbing past 4GB.

This causes the kernel's bpf_ringbuf_has_space() to see a delta larger than
the ring buffer mask, incorrectly treating the buffer as completely full and
permanently dropping all subsequent events for that buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-bpf-ringbu=
f-fixes-v1-0-e623481cb724@kernel.org?part=3D4
