Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45386390CAB
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711750; cv=none; b=l4bNGJuGrPfVWZ+WjUg3Wh2qVK0c8qX7E4PYrNJx1+DQFyo1vUQjdlMVUiDS8NkJP/RhNC4ANNXKdKchaXk/W65TE4HUpdMY9UDp+reZozOmP+TLsvwX9kebp8eGRf5TQtZIfdVHyXKWgY1556U73/dZ4rWofInXv/x7BOUsygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711750; c=relaxed/simple;
	bh=gUrd+2r+CJ3+MIRtHvFv8bVXhWR3+Vlfirm5NflKs/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKfeBsm6D7QQh+0TooCZ/qUZXFdFRfzSzuMsNP+ddY17Gx28Q0YoMkJuf1+KgYQZ1f7lNeslMABOlUDGtAHZFPxsiVbggIkv1XrHAN2Fclfk4o6sCJgTruDG5inN+SMf0FbdUlz3+cGLJZS+JimqaF+MS5AWKHdnuRRiYc9TLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1W/x9tk; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1W/x9tk"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-133466cf955so1118959c88.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711748; x=1779316548; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUrd+2r+CJ3+MIRtHvFv8bVXhWR3+Vlfirm5NflKs/I=;
        b=c1W/x9tkJXXj98dkUCkQpcbm8AOT1+681olav2PXe7F14Sp/82tzsA5eOJhRBiSxT9
         1c5NGZyNAbhVtt1xAGmLHK1dmJGjel5NLYeJbYSxyUGQxsz875l35/mw7hb1JDtyVByh
         L+1G4MhEcfQsxglyRX1S4ZW/x9ZKPJExHubcPlal88hfUBJV16Pc2IlMYgGhT7P0j37q
         Madw4ZPj5JaaA9w3vGAMPC+jP0LDpWyYXEhaNKD5tL5La4YZ5RzjZAygPILSRLyv/tZh
         e3G4DwVSBvXoM7HeGq48S5JO4YU2U2f2sGdkAvMaXggJyqsJjW+o9pM/V7P97FL1WZf4
         sOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711748; x=1779316548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUrd+2r+CJ3+MIRtHvFv8bVXhWR3+Vlfirm5NflKs/I=;
        b=DrG8iRzcYZxGqAix2zz6Z3xB5p0wJWh4KobpJ/6I6GmWYJ5Tl4MLBM4NZpLL/kgpgR
         LO3JV5O51RwGNZ77K0qRVVoctRv8nfEo5t9PXjVSW4EgYp0vhc3PJl2RdfCWeqcBppEm
         7zzW3F1EVdxO0x+A61uHMQQNC7JmEdUbjkzCj99l3B+qHa+p1f35W6dM+bxEhdOK8q+i
         V22RkDQxm5EhCpcYNuFdkrTsYtPM4kqObkIS1nbcUKrbZAWlJSAA93MLUyrRlLQou1Gz
         jMtvzKAv4uSowhcqJDvt+iSdMuwZxI4tbs/G8zogzNUw2P6IR91a/kFJoC13FdOetAL9
         K0DQ==
X-Gm-Message-State: AOJu0YyDfIwwNKIzgSv4PffSLk3rAP1uYl2wxykL3KrRJ+owNmQWrpCQ
	iYW2sSBtl01C0DG4trZ2FUD5NyPt/jrlMrd7VZI9TG2e9arOsRzRSjue
X-Gm-Gg: Acq92OH0wSP/9I8z8rYZgi3aO4ECSvBqtzGqMdsupLAZELocxoeC4uLiaFNf0OoYyJ9
	O5MaodM+B8Hqyr0v/4ZtNippqLjZWc73SSWY9qGADsFAEW7LWi9DGGVj2G8uvv4miWJl3ApClW4
	koM88d4AebA94HdEJt/Wg0Da5+ahe6tpFHV8FRUKKATHqBRGg63Dqyp6Tjlr1ymXUldKjFAE6XW
	6cRIrQAFRjroMD+B8jdv91gqSMoeNUgY4Mi2fSW7KtUwC6hYtKervbdp2t84vF+kJKQJMaVTke1
	JO7pAmrPN4rCPAPEoqh7quvFhyJv5j0i63kdcXOdUYSggcig35/x0giQS2HUl95ud8nhzWVhNNV
	XgrDEaZjpojLPAOH6F/Q+j9LBFhLU60s4BkheNWHVS20O4v7zyLEREGgpP+Km4gW74rIJ2RDrEG
	RH1BV6CoxtlyGgOp9Ddw5WVT2pa0ffCZjGM1lKYFyYoKuIn6yWQAP3wX0zSe731lOY2DjA40nAp
	RRw//o=
X-Received: by 2002:a05:7022:4582:b0:128:d51a:5161 with SMTP id a92af1059eb24-1343699b60dmr3654904c88.27.1778711748302;
        Wed, 13 May 2026 15:35:48 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm1371607c88.3.2026.05.13.15.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:35:48 -0700 (PDT)
Message-ID: <f75e2c732e5ddf34863b1376722d9b727525fd1b.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 6/8] bpf: add
 bpf_list_is_first/last/empty kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao cheng <kaitao.cheng@linux.dev>, ast@kernel.org, corbet@lwn.net, 
	martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org,  Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 13 May 2026 15:35:45 -0700
In-Reply-To: <20260512055919.95716-7-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
	 <20260512055919.95716-7-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 13:59 +0800, Kaitao cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> Add three kfuncs for BPF linked list queries:
> - bpf_list_is_first(head, node): true if node is the first in the list.
> - bpf_list_is_last(head, node): true if node is the last in the list.
> - bpf_list_empty(head): true if the list has no entries.
>=20
> Currently, without these kfuncs, to implement the above functionality
> it is necessary to first call bpf_list_pop_front/back to retrieve the
> first or last node before checking whether the passed-in node was the
> first or last one. After the check, the node had to be pushed back into
> the list using bpf_list_push_front/back, which was very inefficient.
>=20
> Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
> check whether a node is the first, last, or whether the list is empty,
> without having to first retrieve the node.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
