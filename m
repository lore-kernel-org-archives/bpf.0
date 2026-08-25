Received: from mail-ed2-f10.google.com (mail-ed2-f10.google.com [74.125.228.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB740B0E1
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660345; cv=none; b=S+ax1+xxbcpRvH5UrtEjKHsWAPgJlNYAnr8anA805um3f3LK8wbTu2fFcjrnLplJrlYAd1nUzEn/Zjv9/d7M25tB5AcRuq8BAvSt2S8bOKxxI3zgohcZNhEb1mNLitIi2EfNveSLkciqhGu1ah+l+F/WzkjbEv9g8klXKWlFUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660345; c=relaxed/simple;
	bh=mVICIx8iHVbUHaOnIrJj5bmDTF04frjHbViKLPOs06U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qruws3Tzh++9De52C278MCow9JSWWJ6kM4wwlp9ba1XSnkQskY3/7dKbQXCtx/JuCaequlwlG7Mx9yKQJJ77pnD102Hw/hADasOPhlYmJrYJgPsmRhLlLIo+H9KWeAtHQUaFloeGOenZgX3R4bWyd5YNMF4J+UwZLLFzEXJfR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDSF5S4a; arc=none smtp.client-ip=74.125.228.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDSF5S4a"
Received: by mail-ed2-f10.google.com with SMTP id 4fb4d7f45d1cf-6a369630924so2996270a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787660338; x=1788265138; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YI7RkJ5V/hc4ImDGCLyb2VCMTEJ8NjIvVXF+7qI7PnQ=;
        b=bDSF5S4aRAb5PyRQ/S6KRNXbt+pefor/9/+0s1SFjFGhxEbBrupVJE2urpQb5QzMIy
         TbSJLRnhQcP+XsDZQzM/Z4jmzPgvxF7hOP23WtO+bWkLbONKnalOMxMswycHDl0sgtGC
         RzY/bd56JrnelgRQYduLFTNE1xiYPnUOv+ducKDJ/qD6KyxaPolOiehKRiZzJFtu3KZf
         lmOtM8sCB7hpGYbDWcF/hCf3gQdSqzPdbmpZe3ERqTOInSIg/Emau5Q9SbY8cw0ycchh
         RmnVzTVdxVBovHb/URtE1B8kHHsg2zksjj4MLDSGeJw7+VqIvr8/Aeek4vvhgSYj7K7G
         BnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660338; x=1788265138;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YI7RkJ5V/hc4ImDGCLyb2VCMTEJ8NjIvVXF+7qI7PnQ=;
        b=WhD9tED2LxLNIZyUZoEfxb3t7OwYYHwHybhXifdTHhLvcv/GY+EOJKRje2cwi4lwrK
         9kwLJ+2OZHgcZm0NeLd2wYkNPhxugSeh6AwPNkGx8ISaCqcg83FhuHRGaq2oaQ6snHPU
         nxlN2ivWHovaZUd5/w2sFP+I6WPjMaIDiUL7XVgvoJOhTAKDOztqYi2Zz4cDHzyFvryx
         Pq+YQJtFN5YBruSlQAEMogSJnuEjvp1ka8uSVX8tfU9Wx/aWYc2t387Qw56KTv1UwpAs
         5277Max/oeZgjUWnAwzNgXaNweVd7eiGMRn5nW7/PDRfnUotbcozqN5VeVBKV6qcU3LT
         A0UQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4cRmWazM0ngfLxJfKOxaZBuwNXO11YboFsrNq1YIxmyhASpHnM85l+5OeWdoSwnMczGs=@vger.kernel.org
X-Gm-Message-State: AFuF++l7wEOcr+HYeSR+tyeadeQe+XY/JGJt2byUwIiG7zNRZg3HZhFL
	AspWhduvy2Io4fBNK9/1UOD3KOZXUkM3BKaYBEnSQIaiQzRrGQxsEys5
X-Gm-Gg: AR+sD10dA1O5/c3oS6fWXagci2ljkO74wzFdQuxr7RRde5xe0vLkcotysKOaJGzgt8e
	ZQ6G9RXUdZYxBThs411Eedt2NjD3h98ZRr9b5v6hhfrL+3VBOGTXZu7ubNu/cVZcDfMnk1yWYTc
	1HobvkdePHBTkx232z61gyh1PtUNbTlzHE9V7xSQN8HNF4yA3arv1ebdfKmkxt+qB04WfTExWv3
	DNCLnLjybnBY1qC2SpXFiSeHpg4WOyihZjPNZx0TfbdWXgDUafnXdn+sqrg7mBYGm1U5TKu1LYh
	QmP3F/8IxsEqVSk7NrhEAC4hqRBuy0YtAthbQA1Va/Y3m8eFADzarBy5WN0M+f2F16XhNe55NuD
	xoW+eDHmbLLy3zIme7XsEA4UHOtG0BJtyssKYQsjwUrGASO2rWlNQYKzZrNRP9r7CHqqWDp8TgS
	12UnflAoLrhw7ICNRHSH/pQSks9ZLJ8U9O/v/UBnFFyFfG8vFxgWYHBhj31oNKmWrhQ6aYCNDPV
	tdl4HrIMdz08dpgxBcO2vEHP0d+UeB5j4jARq3/VefgI2hTjTkqml6bmhuXkQr9UF0AmpTqDr76
	HfXFB0jnt5Yyx54bZfvPKn4tTpID2ZuXN5B7iA==
X-Received: by 2002:a17:906:ef06:b0:c20:768:af62 with SMTP id a640c23a62f3a-c24920d7131mr2768374366b.22.1787660337493;
        Tue, 25 Aug 2026 05:18:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962a3c13sm1833208266b.26.2026.08.25.05.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 14:18:56 +0200
Message-Id: <DKY0P97XUIG1.1AOV8WFUW5Z0H@gmail.com>
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>, <bpf@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix stream capacity leak and spurious
 -ENOSPC in bpf_stream_stage_commit
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260825113948.85020-1-ahemadkhawar123@gmail.com>
In-Reply-To: <20260825113948.85020-1-ahemadkhawar123@gmail.com>

On Tue Aug 25, 2026 at 1:39 PM CEST, Khawar Ahemad wrote:
> bpf_stream_stage_commit() accounts the staged string length against
> the stream capacity via bpf_stream_consume_capacity() before
> detaching the queued elements with llist_del_all().
>
> If no elements are returned by llist_del_all() (for instance, when
> the staging list was empty or failed to allocate elements), the
> function returns early without releasing the consumed capacity.
> Because no elements are queued into stream->log, no reader will ever
> pop or release this capacity, leading to a permanent capacity leak.
>
> Furthermore, if ss->len is 0, bpf_stream_consume_capacity() is invoked
> needlessly and fails with -ENOSPC if the stream is currently at
> capacity, spuriously rejecting a zero-byte commit.
>
> Fix both issues by:
> 1. Returning early if ss->len is 0.
> 2. Rolling back the consumed capacity with bpf_stream_release_capacity()
>    if llist_del_all() returns NULL.
>
> Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
> Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
> ---

Completely unnecessary.

pw-bot: cr

>  kernel/bpf/stream.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 7a5c3ac867..3ad58c8284 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -350,15 +350,21 @@ int bpf_stream_stage_commit(struct bpf_stream_stage=
 *ss, struct bpf_prog *prog,
>  	if (!stream)
>  		return -EINVAL;
>
> +	if (!ss->len)
> +		return 0;
> +
>  	ret =3D bpf_stream_consume_capacity(stream, ss->len);
>  	if (ret)
>  		return ret;
>
>  	list =3D llist_del_all(&ss->log);
> -	head =3D tail =3D list;
> -
> -	if (!list)
> +	if (!list) {
> +		bpf_stream_release_capacity(stream, ss->len);
>  		return 0;
> +	}
> +
> +	head =3D list;
> +	tail =3D list;
>  	while (llist_next(list)) {
>  		tail =3D llist_next(list);
>  		list =3D tail;

