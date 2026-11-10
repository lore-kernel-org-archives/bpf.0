Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315680;
	b=LqRv3VK9ctlmU2Gat7KEvtBHJutFXPvGhoNsf2JBvon/g0qOkkPMMiBlamk4/PjM5+8z
	 o4H4FAnf+gj5tyNmqYxTzmfswca68pZEICSsX4U4AnMP6PcuQI7UvNLdzK6PFCIvn4FO0
	 e7gWdoU08/zbN7/imUvYsC5Ezzgfu+U26B46RY735I+jsk2mOnKRESyr53dZMN59fsDUX
	 xyRUEkpGwYqehugvWpZfmFZYPhcyN0gPiOK/M+vkhy0JjXsrHXeDZlfPq2C+vAnoTmIsf
	 rgowuzcfiKs9PoVMX6USU1IxYfP7xikrnMaFXrgVUSfuwvlObP65wJ98ZH75NzDbA0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315680;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uy1ycf/eSX2O23rO7hPaiWZXda5bV9zKCWMm/nVq++c=;
	b=0niNY5uygD3nPnKHru7zMSeDERCMqkLRKFwfgydx3F4t8l6pkw5RbXdW/pyiQeLxAwxg
	 mKF3g4T72CSvq2bfu9IgOos3OgKCWRo6kYddqkHxOi+lbmeHjpJg18C2Gr7121I5yuPfK
	 Mt/NVKwgIi02DQgJH/3gkrLqXncPHpizH2ITqDNxqF9bAo5wrUt28RCOL0JEuQ+Yw5nRZ
	 kgPKXaZZHm/DEvXsiqM6W7eyMdHk+571Mogk1Jsix7bSRx81AEOmQR6yaF4G2heZq8l8Q
	 LmKDxLryyCYsM1TnCnmMnWaQi+vZZeBTnZbhAzaHYjjoKnfbtHZXg+nG31O0i2yND2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecKnUQb6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C5606A7C0;
	Tue, 10 Nov 2026 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecKnUQb6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DBE1F0089F;
	Tue, 10 Nov 2026 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315680;
	bh=uy1ycf/eSX2O23rO7hPaiWZXda5bV9zKCWMm/nVq++c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ecKnUQb6D9tCB3Jqs1iR8BfTm6WD5wrjIEGcBAyphWdQQxebUR3I6pkURfxse87SX
	 4Xrgmf8UTe2tJTCEkUIP27ZdG2a11Y7tIrxCijEWa4kdnsukv1XHXwn0bInyaQu/Hg
	 FMGg0hHkd62OqOEBom6ddqpZI0/+v9qBBe4SYHtTGn2ZsfneHQgikpiYxt8zpftcz4
	 uQTDwykhpri6K5E7JZ+697N6ZomKE79k7FjJBvAXobczrqKAu0wpey17/InkYuNYAB
	 QKfPEVogIq+pVgGFiy1H6jmZAL/U+WTSHw1s8ddpxgbi3L1giUFxccOijQ756Z8rPi
	 qjxASNETNxyNA==
Message-ID: <sashiko-outbox-207067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] tools/sched_ext: scx_userland: Reject batch size 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261110125001.4167503-10-cui.tao@linux.dev>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
 <20261110125001.4167503-10-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:01:19 +0000
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
- [Low] tools/sched_ext: NULL optarg passed to fprintf() in
  pre_bootstrap()
--

commit 0b3057c6e52c8c9370246141c70182a7501b6c0e
Author: Tao Cui <cuitao@kylinos.cn>

tools/sched_ext: scx_userland: Reject batch size 0

This commit rejects a zero batch size in pre_bootstrap() to prevent a
livelock when -b 0 is passed on the command line.

> diff --git a/tools/sched_ext/scx_userland.c b/tools/sched_ext/scx_userlan=
d.c
> index b16b6db5f3650..cbd511685449f 100644
> --- a/tools/sched_ext/scx_userland.c
> +++ b/tools/sched_ext/scx_userland.c
> @@ -364,6 +364,11 @@ static void pre_bootstrap(int argc, char **argv)
>  		}
>  	}
> =20
> +	if (!batch_size) {
> +		fprintf(stderr, "Invalid batch size %s\n", optarg);
> +		exit(1);
> +	}

[Severity: Low]
Does this pass a NULL optarg to fprintf()?  Because this check runs after
the while ((opt =3D getopt(...)) !=3D -1) loop finishes, the final getopt()
call has already reset optarg to NULL, which prints "(null)" on glibc and
causes a NULL pointer dereference on libcs such as musl.  Checking
!batch_size inside case 'b' while optarg still points to the argument (or
printing batch_size with %u) would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110125001.4167=
503-1-cui.tao@linux.dev?part=3D9
