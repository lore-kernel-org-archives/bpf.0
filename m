Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B731E841
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724859; cv=none; b=WcIjz+UU0Ck0fdgf2doPF7ejP1deCLGgVe5NHcQOQENuUA7ukaYgUNsjJiTqYDTtiSg1sdqO6AFQc/h6mkSqxVYLKySHgTyOrflA/w/Qb8UJlAX88A/sRJtLHSDhJplNFD/zsMpC59q597CUkPs70PY6Pg+2sEYl8238V60twgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724859; c=relaxed/simple;
	bh=V12ASciSa9z17EEHyojZHfiANVo6NJO3YJFnNUsbwcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iTCggkeMYYARc4blrjEbFEuf7r1hD0hsXQIo+7mzB0ykpsE+DAP1nTkOERMwR7XsOjAwXZ4C6Zconil6GDofZQp8BqTv7p2krKGlWW9wxBEyw2mRvAwN7hQ0YBc/+mHst805t9jH1o2hOheigDwT+JB9unPChjShz98TLpsG/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWuroo8p; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWuroo8p"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-495437bb891so12011615e9.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785724854; x=1786329654; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y09hJ5Io2GpptPqETZD+Irw+fm7ptkyY3J5ec/RiLWU=;
        b=nWuroo8pFIWSz1ZrXbzjpDwycJyt8w0e+L70/V2vdhNGZ6m0OoMDlVSFdSbnXU1Be3
         S2jjXF143epaLOOHnSwlA0sjzFCGwt0vPqeEIns+EnupnUzDPzMsgWq4X9JqXB1R1LI6
         qknMRGMSd/hXBoy//G2k7sBr3Ka5pzGhtOfzrMWJ7sKwzd81/1dugdnMYH12BqpywSow
         0OE2awBSxlFCJtlPMhuHHHy4dpjaZiwjAQfrFmyJThgptr00fw8zwblwtB0Kj5b61Wa7
         uk9MvcIitkP1hxVEZRCvVQFvPTYRYIlXzBkcItpbNFbAOOqyM+yYQz9hytZkuDxIpLrh
         sDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785724854; x=1786329654;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y09hJ5Io2GpptPqETZD+Irw+fm7ptkyY3J5ec/RiLWU=;
        b=mXa+98/odLncU5Ox0V9WTIRcH4IIjF3sx/wWNQeI4CNlkPZMLGQwkPfHMvUnhPFSrB
         gVwIix2lIPkRJ7YhYGivJM7XVeYWB1/cw9/7iBlR3ddHoFJeGm37ABSHtxlXCQfsJ+Ui
         6REk6Z2knWwnRKOAxSzxfQQcmRv9hlFJ/do3JRg+ufhueas0soL82jh/YMQvzV7Fdlqs
         Bghp0YMVejrO8NzZEb/euKMaL+b7bE3LPHEYIaUEPr0cgJflKLPGF4RdvJ4ReAjxbFR+
         QcmaEWncxC4FjqLvJJDQ5VpDig5AB6YLz1FX23CC7wm5GsLSNsbmEbq3reB6NMQnm+aF
         fK1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoYizjdrCYeaojt+wfsOPNT2N8GmyGQi0SCV/pe2ShRLyme6/F37V8ZXQksgpTXTCulT5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztxbza+RvLCW389Rf2RLE0IJR/sfXbJnPWRfw7rkKkqEi7QO6O
	nWqTzC39t5g0EzbSr89Ejsfya/ydUMFwiU+Rlf8K4AAvw1wFAQgHhlUlU8xgCu6Q
X-Gm-Gg: AR+sD11LQx9lhppZCBP4/DEeVEnqZIjZ98Qoc/NgzIHQ3IobLkqI8Urkj+v994jPPez
	oqaO1DMKFGFyiTDyLjM2jDW7b5zEzSkqH++7r+sVjgGWA2A1Kc85X4jsuvZ5Kg2N7q8G1NrqBqO
	/zykAPDuZKnrRriWj4V5OH/ZD6swLe6TUkoS9HEGEmR4/DPxyYEvOIDwqkODu8xplLW4WJ98nie
	Oz3WsrXWHNO8X+KE7uEHQtdamFAgWq8x+Fbv2zyPVg0P41XJle2wzRj3VIw1mP7Pf0IwxroJWoT
	Ix3IfYUxv8V3mqG7kTnoVEPKZNN/PYrPcQjpJUbdUnhyg8WChfD+rur0QzMcQjUiKRSN4RuMudi
	MXHVN90cYObdiPjFxtBdb1+HrcQxbGx2NSKQiBrT1Xi/9cXfaujcxt0jXCFQxANuoq7pQwllPdu
	vFnpNqdCqFLr0h/PBllzYNaUKjScnaIac4NpESrrlgrOAfr7JLHm1Op4fh/Cp0tb5ZMy8S1mhS4
	paTzwB6vwX4qU28oBIk7Yw6VsT3pVMdEIsWTGoPiUuKb2gu8JYRtH/O+fOqtFkTnd3sKH6+Tm2J
	sD1PmIdF2Ky5QJT1Dhhp8mCBVoM=
X-Received: by 2002:a05:600c:2d14:b0:493:e686:6134 with SMTP id 5b1f17b1804b1-4980f00bfd5mr110879745e9.7.1785724854222;
        Sun, 02 Aug 2026 19:40:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm30089527f8f.27.2026.08.02.19.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 19:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 04:40:50 +0200
Message-Id: <DKEYMNC99ODB.23WY3OTYMSHYR@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <pulehui@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: roll back stream capacity when
 allocation fails
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jianlin Shi" <shijianlin11@foxmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
 <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
In-Reply-To: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>

On Mon Jul 20, 2026 at 7:13 AM CEST, Jianlin Shi wrote:
> bpf_stream_push_str() accounts the string length before allocating a
> stream element. If the allocation fails, the length remains charged even
> though no element is queued and therefore cannot be released by a reader.
> Repeated failures can exhaust the stream capacity permanently until the
> BPF program is freed.
>
> Roll back the capacity charge when creating the stream element fails.
>
> Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
> ---

Sorry about the delay. This particular fix is correct, but I'd prefer if we
could refactor bpf_stream_release_capacity() to accept length as its second
parameter and then use it here, to drop dependency on 'elem'. That also bet=
ter
mirrors the consume side.

As for other Sashiko concerns, since you will respin, you can append more
patches to the series.

Regarding the three issues pointed out by Sashiko in reply to v2, they all =
look
valid to me. For the staging leak, ss->len should only be increased after
__bpf_stream_push_str() succeeds. We shoulf fix that.

On the read side, account for any bytes successfully copied before a fault =
and
return that byte count, returning -EFAULT only when no bytes were copied. S=
o a
partial buffer which allows copying some bytes successfully and fails the r=
est,
we should return the partial count of bytes copied.

For oversized formatted output, keeping the current behavior of dropping th=
e
message seems reasonable, but -ENOMEM is misleading. Since the formatter's
return value excludes the trailing NUL and a value greater than or equal to
MAX_BPRINTF_BUF indicates truncation, please reject such lengths with -E2BI=
G,
preferably before charging stream capacity. This also fixes the boundary ca=
se
where a length of MAX_BPRINTF_BUF currently copies the trailing NUL into th=
e
stream.

So use the actual formatted length, capped at MAX_BPRINTF_BUF - 1 (vscnprin=
tf()
for the staged path), so oversized messages are truncated without copying t=
he
trailing NUL.

Please also add selftests for such cases. For the partial unmapped buffer, =
you
could map a page and pass a buffer straddling the page boundary, such that =
we
take a fault when copying into the remainder.

pw-bot: cr

> v2:
> - Retarget to bpf-next as suggested by Pu Lehui.
>
>  kernel/bpf/stream.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index be9ce98e9..4b8a74b91 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -79,7 +79,14 @@ static int bpf_stream_push_str(struct bpf_stream *stre=
am, const char *str, int l
>  {
>  	int ret =3D bpf_stream_consume_capacity(stream, len);
>
> -	return ret ?: __bpf_stream_push_str(&stream->log, str, len);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __bpf_stream_push_str(&stream->log, str, len);
> +	if (ret)
> +		atomic_sub(len, &stream->capacity);
> +
> +	return ret;
>  }
>
>  static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, s=
truct bpf_prog_aux *aux)

