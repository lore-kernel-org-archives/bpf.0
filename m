Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7736366079
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774144283; cv=none; b=p88JDwHEULix+TLxSWZIbnGzh2u5cmsuq47TNRYB1Jr1qmIkHZDMt5FWfkBQe6ueUNxXwJgjCa4h62WCY4qZ2pXBpx6YmXoK311SSE+X3QAGWteMi6UE+sR8kw+n+JPLdkbP825KDv/jEOS61o3KMv8xk3cusLVE989gpkobQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774144283; c=relaxed/simple;
	bh=3wV6qzVpAsYqJwaSyznGfPODWqEYhsWXQFQvbz/io+Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=egwtKAB8+cfd+5QxNO7PBNo0tgbU+Q8sCJkWyqoAlpZ7O32QboO+h1yj/RQp4GAy59SV6wXiuUd8+DRMrzAROFo4cx3flOlebYoR8/ToSB08DTeUa996s1hGVv7A1iccaazqY1V2dmKgz1vyvRzLfjSYheqIagGgHRx4qOBRK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=yxfpjZlN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="yxfpjZlN"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50917e02472so21499111cf.2
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 18:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774144280; x=1774749080; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PspDfyNJnO+7FZv30/IIcadDyXG1kBEYdchAYPVdXh4=;
        b=yxfpjZlNT2/o1/+xxVx9eP8H9SBIS8E+R50spOGBtVgAOGniiafvSg6V0932RF8FGG
         soA6pEHS58GRoEq1zPqZbyObVxzFtJ+7Pp3itqtaYsrGNGT48RaNAB3BEeKh1DzUI6xy
         /eIMdPxAPE1+8WfIK7KO0F4OXkU/diNAAVzen29pjoYq8ihxUVD8FLgga/vJdsdpErdZ
         Lxdl8w8nEKX50y/418DfSOFSeYwh2AtEXxRBNkaptOPpml9RyC+qQ5ZcBrCkTXoNu5GQ
         kE/EVQNrY8OdTRsrzfpmacStVKmL6bmc3qsNr+E3FPExIPusjto9jfrl6BlVkeMESlix
         GIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774144280; x=1774749080;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PspDfyNJnO+7FZv30/IIcadDyXG1kBEYdchAYPVdXh4=;
        b=URx5V+JCBTGqGRT/rubtvgVwCWLnRcwegugCkPqT1b2eRlrW0142mM+xrLgxCG2qrD
         z+PwzYhhvUShzkw22mKcIU1GT3rsuZof6yV7WDHvqogDAYwdwGMh1rGhRsmHNXW62RB8
         743o1wB+GxCVTrUuMsgn+pQbVs4IbqlGbgeRu7BDGdrXkQIM+3LWhzaQ+BQo8uaHg9ol
         Wk1XcGSOVoH355C7GYB/p8ZsTs3W8joV5yb6JSR3eqEfHlxBZCHm7YbEY5dnFscyfDnu
         d7GNX9Greb77cOc5PglI18/377t4rX4r+lnp4I9bwVs7Xx45163GCyDmHMLKQEzZzixD
         kOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvSpkmovUqhV5XUqM84YFeCNs0yPVOGpw3RUsD/r6eU/GclecJmUlSCHTWlcc4Ift9WJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHoENGFnmveFKzondGL93CQIiNOiRx6GJa+Joz6RPEq+tiWIBs
	hxapxxxXsFwTGyMNhg6+MgyswJ1euprSMxe6rBGQ/Vt0nC/sE+MNb2DnVdUmqbdIDfg=
X-Gm-Gg: ATEYQzzYiyaxby6BXpxgjTwB+1VG6z2GU3dToesPoDFtNnf+84GAM5A6JmTJaQ/bIqc
	0AHY6Zh8rQS40MB8+Kkwed4xeed97Y5a1pmP8PK6G4O9pBT6DH8rwqTcWEWgOZ0RV60QMITg4wW
	zBK/I9unvIcUiAmDQLZh2dXSivNW8I9atFdP2IlLRyzI1RqhdOnXN6IuTx5/ZvN2VwU/2lmbrR6
	fuGTFf0UfTK17zR43R5jK/6ZmZCJGtKJfYQXXrEXoo0WaAp552+3Xs3fVJ/K1UymNNcuvakA/J0
	BQSwa12rXPamYAu/0CRTAZ3Xqp2HSY0bL1Bmo1iqyq7mvh0cvYyBOdED+GResacwD5Pj56o97F/
	psR2h3DJEJmumSWVnfaPQg0EgdAQX82akx2gsNHh3nn2LfcL03b9aaM0/gp9hF6x7YlZdNlLcqX
	wz29NPAi44b+x0emwsL3mlDwU=
X-Received: by 2002:ac8:5d4e:0:b0:509:26f4:64f5 with SMTP id d75a77b69052e-50b37512ed6mr129658601cf.48.1774144279741;
        Sat, 21 Mar 2026 18:51:19 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36cb3c91sm54518171cf.4.2026.03.21.18.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 18:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 21:51:17 -0400
Message-Id: <DH8XNPJ8LC2K.5SQUBA8FZ9YW@etsalapatis.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test access to ringbuf position
 with map pointer
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Menglong Dong" <menglong8.dong@gmail.com>, <ast@kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260320084155.288417-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260320084155.288417-1-dongml2@chinatelecom.cn>

On Fri Mar 20, 2026 at 4:41 AM EDT, Menglong Dong wrote:
> Add the testing to access the bpf_ringbuf with the map pointer.
> "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> 128 bytes in the ringbuf to test the producer_pos, which should be
> "128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.
>
> It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> prog with the consumer and producer position.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Once Jiri's feedback is addressed feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One nit below.

> ---
>  .../testing/selftests/bpf/progs/map_ptr_kern.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/tes=
ting/selftests/bpf/progs/map_ptr_kern.c
> index efaf622c28dd..c3fa57ec430b 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -647,21 +647,39 @@ static inline int check_devmap_hash(void)
>  	return 1;
>  }
> =20
> +struct bpf_ringbuf {
> +	unsigned long consumer_pos;
> +	unsigned long producer_pos;
> +} __attribute__((preserve_access_index));
> +
>  struct bpf_ringbuf_map {
>  	struct bpf_map map;
> +	struct bpf_ringbuf *rb;
>  } __attribute__((preserve_access_index));
> =20
>  struct {
>  	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +	__uint(max_entries, 1 << 10);
>  } m_ringbuf SEC(".maps");
> =20
>  static inline int check_ringbuf(void)
>  {
>  	struct bpf_ringbuf_map *ringbuf =3D (struct bpf_ringbuf_map *)&m_ringbu=
f;
>  	struct bpf_map *map =3D (struct bpf_map *)&m_ringbuf;
> +	struct bpf_ringbuf *rb;
> +	void *ptr;
> =20
>  	VERIFY(check(&ringbuf->map, map, 0, 0, page_size));
> =20
> +	ptr =3D bpf_ringbuf_reserve(&m_ringbuf, 128, 0);
> +	VERIFY(ptr);
> +
> +	bpf_ringbuf_discard(ptr, 0);
> +	rb =3D ringbuf->rb;
> +	VERIFY(rb);
> +	VERIFY(rb->consumer_pos =3D=3D 0);

Nit: Can you repeat here the explanation from the cover letter=20
as to why this is 128 + 8?

> +	VERIFY(rb->producer_pos =3D=3D 128 + 8);
> +
>  	return 1;
>  }

> =20
