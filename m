Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2262C3244
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699722; cv=none; b=VtSgEvXdQfwsRDmLSUGrodSnVgfqyeS0lqL8Up2biTlUVcCLHD0XHAKobgJlFUV+MdbeJZ8Ibhmkimvz20HB2QaRJuirBgKd5aAAqH43qNqs46hjJpa2mINKBuITapc4J9Av/y4zFW7ezVvM7rIod5ftnN444T++bT8bdrogwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699722; c=relaxed/simple;
	bh=RrXF+ayB7oQyneoYTDbPKY05ogqYpMZ6V7DSo2tehsc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=jaDBXb5LR6iyj7dFMppA68xPgMFKdosWYPstQZTruMWeA6RyV0V7OFzAfb7+HZ0sdo/eh/4rB2Ry68+tELpx9gWdORtdCgwt09+ng+F+AHpnMD70uMRkQCjszw5OIkgKjrXqbtLOhH97Qu7NmYgZD0tGyxd+ckmfWyIr67LwVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYxEzvxe; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYxEzvxe"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7fdb922a5so2889121a34.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699720; x=1777304520; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrXF+ayB7oQyneoYTDbPKY05ogqYpMZ6V7DSo2tehsc=;
        b=gYxEzvxecdBXlcjSOsK/Ckk83Ui9cnjQXDomKPeQkTQE9CNcg8avQYukbmoNpKfeut
         0owq2D24M4yejutDpgvaKBVMjLRZyCw/OVoiLCKFzNR5itJ6vxXh09rQ/3uBCCLF2wrN
         wAVV6tGtChOYYV/TXM1Uxom0Jrx3WXtXyb4DDVHvl1Iz53ekxHvstjHEN2RC/hnfQUfv
         qalQ2YvKbhfoR+rJZfGEOtijHehkAfv+RFKWY9M90Hc8CRR8pcZ1g/9Zt1X1C8/MDnwX
         T2VXwa3GdPH5km7j0LjCQ0kYv9iQk4TpddcdMJ+hVGXnOQtDNzkRGoCU6AoNSHhyeKf1
         CsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699720; x=1777304520;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrXF+ayB7oQyneoYTDbPKY05ogqYpMZ6V7DSo2tehsc=;
        b=hFXpU0fWK4s2OI+I7c05mNFHUwtosnJz16tvVn2PYRKh98CPeQLAHeqZ4tV74rX51y
         +GZC985YLswQiEaNxXcPkKoJNY/uzuHCwUBVXIJQV1LCb6JHiVDhJ9Azc8U6JfPKHXXH
         J6zxRQJ7nwN/KGPS1Ja/yKDOJAW6cFsnzCIkFcojzX49uJSUvUTOCpklu/P/R8hLn8US
         Dxt5IODc6qP+RbVdjFYoQa3MA4XOkzWQek4omXCTvpccxcaqSmHRNqu8PdxYp1Mm5oLy
         ZQEpFeHkYFerUg1E2SfOa1N600u+2c+zSUaq6iUH+qBl6boZdtrpcHw0e+7GkrOGTKkC
         jgrw==
X-Gm-Message-State: AOJu0Yzh7AxqXIuyL386qGB5szurGAm8t5+sM7CF2wc+nbWRxdF7+4UN
	nHLJa+qIzR6h4e7F/dzxVZuNYA3nM8Xa5U3q26iMeXBKndQ1Ecp5M2VgSdpG/w==
X-Gm-Gg: AeBDieu527GEgWbIn6HkVkLuSjhWXAyRpevn2fu6H4wN60DJmIg8ehjncpRo8Awihcb
	wD0oxJ6HDOMiqEQ0wlONbL0pQFpffeZEzfBhQuq+4UClsfDe+pEPtK2yO54e+Dfmd1Y7NSOY1H+
	FxSUlu2Fbc1NutbPCI+rO/SaVXc2TRLLOYB1uzfBzIiwkAbHqkI1WoarIGILCZ9zRybgq3Sf/LK
	+ND4PsHBeXCS2YwZxdTk9ifmcrUvWCYoCjhO0csh6n16vpZoku+hWnkkO8FJvsSdxytOMx0h5E8
	HjnGBztETm6INxszXl9kGIF85M/UqZUdX6Hma87SzbGgLVWivqUfC5vV23sc8zVeKJaB+33uD43
	8aI9eOwriH9ipie383fqhvjn7Ktt4fGsRgCLmI1vwWHiznQf3fU3xwgOq1nJMvNsXaQcXzAIScr
	HeXtB/ABXmvQk7Hv8EhIMSGvXql8ZQMPik3COCw9YAMkV0ZE3wer4yc0ub1D4WA+IEivK/aimQg
	0wmWv7kcVsVDEB0Fgi2eDMvfveD
X-Received: by 2002:a05:6830:8499:b0:7dc:c620:aa18 with SMTP id 46e09a7af769-7dcc620bbc7mr1605727a34.22.1776699719618;
        Mon, 20 Apr 2026 08:41:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc712b4easm1853762a34.23.2026.04.20.08.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 08:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 08:41:57 -0700
Message-Id: <DHY3HII4WSJS.Z7A2V8PWG22W@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin Lau" <kafai@meta.com>, "Kernel Team"
 <kernel-team@meta.com>, "Eduard" <eddyz87@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au>
 <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
 <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
 <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
 <4c0e73e1-43c3-48a3-ab89-239fed7e6c23@gmail.com>
 <aeLTlNbM1rH31D4L@gondor.apana.org.au>
 <af4b850f-ac88-4c99-8d66-00e40efbd4d7@gmail.com>
In-Reply-To: <af4b850f-ac88-4c99-8d66-00e40efbd4d7@gmail.com>

On Mon Apr 20, 2026 at 4:45 AM PDT, Mykyta Yatsenko wrote:
>
>
> On 4/18/26 1:43 AM, Herbert Xu wrote:
>> On Fri, Apr 17, 2026 at 04:16:34PM +0100, Mykyta Yatsenko wrote:
>>>
>>> Changing interface is practically not possible - this comes from the bp=
f
>>> syscall.
>>> Linked list solution: we probably can't afford it performance-wise, it'=
s not
>>> worth it to pay for the linked list maintenance in insert/delete operat=
ions,
>>> to make traversals work well.
>>=20
>> What performance penalty? The linked list is just a pair of pointers.
>>=20
>> Memory-wise it'll be two extra pointers per node.
>>=20
>> Cheers,
>
> I'm concerned about pointer chasing, when we inserting a new element to=
=20
> the list or removing existing, we'll need to update pointers of the=20
> neighboring elements. It'll be nice to measure it, of course, let me try=
=20
> to prototype it.

hold on. let's not overcomplicate things.
We only need to notice that resize happened, right?
In such case just ad generation counter and let resize increment it.
If it changed in our iterator -> ERESTARTSYS.
EAGAIN doesn't quite fit, since it implies that immediate operation can be
retried, while here the iterator need to be destroyed and recreated.
