Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365A19AD5C
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776035889; cv=pass; b=DliJEwqpA/z+VA7tHiBzLVF+EdRi6UQKDUZODIfQhOISKWGvVq1lP/5icibB9wphr9ovuejffGcoP62aVUyOeU3DIE79tf/+eLAHv1yMFIXydSepmxgMGtMw/zK7cmXb0iFgZXJssMQRkBf6ldMrxE4MwgiWIJf8XLvTJfGrOPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776035889; c=relaxed/simple;
	bh=T1Emvgx7G33FlFzqYTI2/IwckMwtMJHCggHS4dHUwNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmpy6syiN7+SJaZzpFptmjakM1tJoatHmlmBoAQinukxyXsIj+NBzAH82nGmts2detLum7jbgUo1UsI2hPbiefktvoNAAQWXfiyzVR5TCAnWtiVktT59Aq1874dQTtLP6/s7lR9J5qxTB7x6uFGI0xBnQ/ZRRbFKcKCybY0H0hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJwQfvj6; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJwQfvj6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d734223e4so422372f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776035887; cv=none;
        d=google.com; s=arc-20240605;
        b=gro3zKB5FnF6C3nNBN6v32n9yfh3V7XNBHTb25ib9xnMaMxDJQq3RYrD0Eby6CEcLP
         ybOS4o7wMbzncnPnVVJL15W2UQvZR2DQLYjM+jDUboM7CjadwmMxwOVru2YoOc8RJ8Dd
         3GK3nIMYI5y0l/PlJtQXLnTd6qM/Zpa9ASaKJw19+CSCRCnXurNw7JWc0qbQBg4vt54i
         yadGA0t6WJA0xOAZx8/R4sLDa9B200YBPALgjpL6UaDz1hwgyE24sk5cb+nEO9IaJ/OD
         90MRQkYYgG4BHrTQtC7d40IZjkq9wih1DzEHjQD6F4ke0RLdjVSNM1+ekMlc+npb4IhG
         qVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBpIGdpi7y5J6d2ZGjs7KLbq185URk8J9tRJtfPwI0c=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=OJ27hnb9tjkOJZ8j7iJVIgPNMQ6EwxnAPJmhX3qpQr5dogqXxv5ou4gmRTvuUoBvgJ
         eMEk05/Cl/PBc+SMtGEggpAvQA1/eFGuO5q4U/A3BuHc72vD5I/edc7rdqbjCTkMPsQG
         g8H7i+tTVMCQN0FughCOH3wwBi69NTWgstR4uoPoM7EpiY4MNWEYzRsF1aGgtBnCvV9y
         jQt9q9RJYaSGbF2j3hFX5ftTSlrV7kY5x6DSsrsK1ku3oGV4kyrj37/Qy/ZLME2l7Uus
         f5A7ccMp1Edwn3nNOh8sNLh3gB9HtX2InmpWeiM0KiSWtARCRPsqGIfq2eGhkPmV6ZtJ
         8cBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776035887; x=1776640687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBpIGdpi7y5J6d2ZGjs7KLbq185URk8J9tRJtfPwI0c=;
        b=dJwQfvj6AyWx/q6Sf91KnoWhiCbqCpeVlGveYriEQ7Kj/aRmt9sGZZTuazzR0oEN1/
         5/mmpeL7Zlikvu2bjNMmUp3P7//xT06KYyjM2cr8Nk1f3nC9o0NMDl9sW6yYatLdvTeP
         zhU+SG4A2YO+41ysh/pfpAnF2RLey5y5ExchY6sCLNwZ0QUS1N03zjDASRQe2nMyitWC
         6XJQsk0t4LOP85/BsK4FFUpLOSgpulQrGNXFBpCoLfAJ54K2pLrbH6EOmqqhB7epnVMR
         +DfQO6wnDWu6LvT83enUtL9Oah8l2/6izrdn/ZdP5vlwgo94v2t4Ct3jO6HDD+jMcMb+
         bhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776035887; x=1776640687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBpIGdpi7y5J6d2ZGjs7KLbq185URk8J9tRJtfPwI0c=;
        b=pd5XzammkF/kO0UK8Q3kBJv0LJ6PyGXyKckejhhiZHHh18/YvgL5RNfr2rRLq+2BPB
         LDuwDmSULfMEmol63fI2f+mxqq7iMo8nX6SwTsM5hu8ujUvRe1UQ5bHh6eOZc58F6zX4
         Fv+Rfhec5EnAocIIdnJmz1mAw5C04Gs7n2DjnajNFMAm/Ga9s3wpzWhxnsk7ZTt5hq/2
         jjXl/5XzM+i+itx7wzU/9NaxZ43okYgaunIjpfaBplg8TCwG5FLVrEO6SMOQ0E5eIh94
         YwHEVJtPIWPBc1+040BBnzwKxoKlF0M41FKGIC0y9PSAHU+33a8Or+F2SdSteOLo1M/K
         zuIQ==
X-Gm-Message-State: AOJu0YyG9J2s3FuYiUz3204mFNTjkRWfXm1mi1GLuc/eo2Pzctu49Iek
	MySxD+cmNth4s09dh1RjgSIS2JFupFB1JXWf6SkFk4/jHWfBqLxLwzqf6npnoPK1jgnYNt4Kp36
	vJgE7D920ac9WEpAAVYja7kuuDsm8Jz+5Mw==
X-Gm-Gg: AeBDietiHp/2Urb4IqKDXO3jEKf92Ew48FfZQQHnppw9CpwORCxtlx7UUhA7QsKwWKB
	XvcHXmVfu8JZ21coG6PU67oPJUXZ+F+25ik5gLCPgftKq5qOpcuPFKu13v1Vw9E7e55RJYmjwtv
	y0XJckZyvziaeOiwocebaPPZ5QQvqcIW/SKTqTKpuiv2z3jQgaJ8bqoLIgotwX+Zzbgrr/IvIzQ
	32qj8ZG7UdGu88itk3z0RE9J+YjsgmWyXwv4iU6zhHBiRwtIiCsEHmqNcW3jqAzMVVREb/xzSoo
	wkUAqaB2Mqmq6zwjxc0HcfYcTVzSIt4ZSwpV/J78kMQzVJgR/S1rBFpQWGzSXXkrznJgWOc/W+A
	MbjP4bA1lIyBo3YMbEX51Q6szxg==
X-Received: by 2002:a05:6000:2609:b0:43d:c06:bcd7 with SMTP id
 ffacd0b85a97d-43d595d8724mr21052019f8f.26.1776035886629; Sun, 12 Apr 2026
 16:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-13-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-13-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:17:55 -0700
X-Gm-Features: AQROBzABRSAzMwX23jGkBm2mPxInyP4rI6V24-iX9AFWaR9YCR-OTuLtBoWMcw4
Message-ID: <CAADnVQJumCinzc8pdUGkxHjqn-=ewRvLaCgfC9-JG1jNZ23=yw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 13/18] selftests/bpf: Support resizable
 hashtab in test_maps
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Parameterize existing htab tests (test_hashmap, test_hashmap_sizes,
> test_hashmap_walk, htab_map_batch_ops) by map type so they run
> against BPF_MAP_TYPE_RHASH as well. Relax ordering and exact-count
> assertions where rhashtable resize makes them non-deterministic.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/map_tests/htab_map_batch_ops.c   |  22 +++-
>  tools/testing/selftests/bpf/test_maps.c            | 127 +++++++++++++++=
+-----
>  2 files changed, 114 insertions(+), 35 deletions(-)

drop test_maps changes. It's quite obsolete. We probably should delete it.
