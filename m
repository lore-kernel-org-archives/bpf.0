Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660444;
	b=d4am8GmZ1lVBF14AVmUQRysmUVN7qNbvMYR5UBRRmXsXxqMDuKk+PB7Ubk4WbcJFU/lL
	 dh+GLv3SpzYhKMQc5Rha0YFyo4jqx5ixbb0/ptHIhl8O1Y3bZPZ2YBuZmLX3+IASKQds9
	 XSNXaQQ43VCBoKAtaJv+cU36l/1Q9yW1AGy5oxZW9Fvks0C561dcc4My3Q9JQsUnl5P5X
	 ABr9274EThrVMEMbnYkh/F4T+bkd68/g30f38np4pD+Vn+aZ0/iio7/Q0TdcUDIMEBesn
	 RAKeQVkpIl8rhFjM/W9zVaQljf2dyk5UQkdVsr2aVwQvHmGlZRVlVClGKKdyGjUsTdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660444;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uoRYXrb0bLWGbbyNiTO8PbuEE8hQFiJ3OTSVKggz134=;
	b=AJZ8Dli17D01lMl1EBpZNIsfb8pW4g81tOW0r3PNZuRS2gvtWGt6KXj5K2Ufhw1RgqYf
	 Us/h7dphaARZ3ZZJKdy56d9dlNSRZhPWYwPshX1UN4W6Wv+B5N4fBXusE0RyMk8mtC/Rw
	 KAJkpzzQr4mgXmZgYQT/uqiOismY5XZZtYlHXteFgzq51k/TKIhRGQZ2Y96KvyqQCNPUu
	 cHJrEBrbWXNIo1smSnvsDuHG845+AVRERzGtbF6iMfXMZRCYdnBdEpuROvQAiJ64CUaQj
	 E23x87xQF6V3lzrd/HQ5q8RCw1jZ3UJRmdOT+FnTHANq7tEmrqO7EN2WjbdS6KvYZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2X3uzX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC80606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2X3uzX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E40D1F000C4;
	Sat, 14 Nov 2026 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794660443;
	bh=uoRYXrb0bLWGbbyNiTO8PbuEE8hQFiJ3OTSVKggz134=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=V2X3uzX3VE7oc897E3izBaBkZ23aJR18h/c11Bk/KEPYHO3Kl8dZCdv7/VknByTKq
	 6uak8l/3SyCzgp9KAbx2Dw0jVo2Fi8E7ijRvd5zVe1GfIF3iQ93CJjVnxjwS06hEJm
	 Ud0Y0Gijx5aAqdcDcXY6nkIifOJTEQhnpqkAQcmJbXF/0JrGLmBzVG3oFx38zBVwwo
	 xx2fU0JiQYxePPrCFEXu0Dece2s8lWrnbLX6/My2doketj7jZc194+FtvB5tscll0y
	 SUqqPT66DTrijLnxaEELBSzIlsP+GBbti+mTfsB9E7kqkWde7VwKvjdQQuh9iKbXTi
	 qI2OTl67tolNA==
Message-ID: <sashiko-outbox-214511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf, tcx: Skip RCU synchronization when the
 entry was newly created
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Wu" <shijing.wuqi@linux.alibaba.com>, bpf@vger.kernel.org
In-Reply-To: <20261114124039.111360-1-shijing.wuqi@linux.alibaba.com>
References: <20261114124039.111360-1-shijing.wuqi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 12:47:23 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: multi-line comment style in tcx_prog_attach() and
  tcx_link_prog_attach()
--

commit 2e14928eb20fcdc45d5b96fe78599b9ad93e5381
Author: Qi Wu <shijing.wuqi@linux.alibaba.com>

bpf, tcx: Skip RCU synchronization when the entry was newly created

This commit skips calling tcx_entry_sync() in tcx_prog_attach() and
tcx_link_prog_attach() when the tcx_entry was newly created and never
published to RCU readers.

> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> index 02db0113b8e7c..7652069271e0c 100644
> --- a/kernel/bpf/tcx.c
> +++ b/kernel/bpf/tcx.c
> @@ -42,7 +42,11 @@ int tcx_prog_attach(const union bpf_attr *attr, struct=
 bpf_prog *prog)
>  	if (!ret) {
>  		if (entry !=3D entry_new) {
>  			tcx_entry_update(dev, entry_new, ingress);
> -			tcx_entry_sync();
> +			/* A newly created entry was never published, so
> +			 * there are no inflight RCU users to wait for.
> +			 */
> +			if (!created)
> +				tcx_entry_sync();
>  			tcx_skeys_inc(ingress);
>  		}
>  		bpf_mprog_commit(entry);
> @@ -156,7 +160,11 @@ static int tcx_link_prog_attach(struct bpf_link *lin=
k, u32 flags, u32 id_or_fd,
>  	if (!ret) {
>  		if (entry !=3D entry_new) {
>  			tcx_entry_update(dev, entry_new, ingress);
> -			tcx_entry_sync();
> +			/* A newly created entry was never published, so
> +			 * there are no inflight RCU users to wait for.
> +			 */
> +			if (!created)
> +				tcx_entry_sync();
>  			tcx_skeys_inc(ingress);
>  		}
>  		bpf_mprog_commit(entry);

[Severity: Low]
This isn't a bug, but BPF code uses the multi-line comment style where the
opening /* is on its own line and the comment text starts on the next line.
Could both comments in tcx_prog_attach() and tcx_link_prog_attach() be
formatted that way?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114124039.1113=
60-1-shijing.wuqi@linux.alibaba.com?part=3D1
