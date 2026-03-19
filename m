Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628738E121
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937080; cv=none; b=lATAk4agzxm5Gau46+xtqk3WPPfhfXvpZCcwZnXELSfHIiq/SMKAi14ksfeX/G4xP7Ddnowls1SEK41CppcymNUXPMBgtBDJA8X7aTqfjWTBrjJVsNt1P/pOnxAssnricQB/t5REFmlcx4Cj4M71O8zV2BSr7LlHk/GjraRb9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937080; c=relaxed/simple;
	bh=XKiAp1DwwODDUNt3mgTzBLo9BnWUOH4i7exkuuLcN+s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q9LbIct+Jo5fRsmI7oaL5bqZh2uqAQC1zE/5ckIn9vmwOlUdA0akjrvKXzV9HtRULDqVKh5E00iLYBLm2J9OhRRwKEfk6aMXXEYAl99xLUegGhx8vw9qQtyHqpas8C8nycboPOhaUoW7UxUrS6L7amHdQXtTvkUnwbGO3tukrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=iXyUDGCo; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="iXyUDGCo"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd77786e97so117891385a.3
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773937073; x=1774541873; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld55lyS+UNJ7gvafEyeKeCDZS977J+HXiJ8/KK+leDU=;
        b=iXyUDGCoe+kIjRyxhuhBUzWXNGzcvmwnBmqVfwtDu5PVTvLWG0OmCpu2uctwdXKKQE
         h2pJIwPFwDLGvECxjmJbTl/OUa0DKz4wGpbYGHeUgEVFWazQlKpI0SvtyR3EU17ROeVY
         sIYSVhSlUeXxv0zLY+zl+gCweeME13OxbRb0MX9U+vIUPmHdNzPQgIkKzf+BPMBK6f0E
         OY+3W56Hy3/fWVPq/jOAGvD2W+Q4af+KzTrdNzGKVyO/MFkqOOn5vTDI1BPaXM7ioccF
         fc0Zt+QAbOpRjJRxP/a17iAz8Xg1t7KEN4cQL3yAvVxvJed9dhWYoHM1J3M34orL8M19
         kQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937073; x=1774541873;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ld55lyS+UNJ7gvafEyeKeCDZS977J+HXiJ8/KK+leDU=;
        b=LHLk+e0YElVVj0wQTIK4t1QJ2UGK9sZEOHd4W5TIzZh3XqE6hjrJHA7RLKk5Art8r0
         PUrKOW5pV/UFRTgb0eovZ+3FoZetKdUYfCpGSo047+qUuwnDmlNstNzdAqBLULJubq42
         lWxQYTL3Ms79SKJBgoHJJqa0YyFcyaPrVh5owE+1N231Om/virY8P1E2Go1zuJlZAmev
         Vo8Nsx+V38OpRMtPipAGIt4af6vNB2pMOwqKRn2m8RWWqulE7vOfcB9jcs0xeCzG89B1
         sfZH34g8xUgO+bFoVximVlob+tT2tcJaTX1SHP3bbbdbbni/SIN1TpyyokEv+FNfFyt9
         XwiQ==
X-Gm-Message-State: AOJu0Ywi+jcHvxhLz5xkOc3tEptehDrt+wFKxvUeuRjndIr4nPzDMluv
	vaV/Y474XYbsJ2r7ouXVM05BoYhZ9HqP9wamUg03EJt3wL3uW0EqXQYCt8d6jjvDrt0=
X-Gm-Gg: ATEYQzzFo7YPvDWg4/IN4TS79dg1W6bKyyxBGyv9bjLGlM/qZKGeHED405KoWX71sso
	kWm7WFWQNjZzZFWmfloh0H5+S5VeVdfX4wcYOR0sPyV0ryQKgdeeGYKKQwFFnsfDfI2RgUkzT0v
	i51BThL79qJjoyP/8bHarbhCl4ljI3PgrYzzQFHhvlJNRutqSME6zr2T3d35hQ2CogDeerLLxNQ
	kao1cJjpfaHVm3j9NdnzCiAbu2/M+GLIYTK51F9a9f4M7GP2bKI6si6kLClDIWlHbfuyVNKOU9e
	ZhxbZZon7sVzk5R+qXTo63K8MxoIT9u1MhmHOV3LQAnwPpQ2Hv3ly1vqSy1gJe75SDDh8p9q0ZO
	1a35wVZ5ifcgl1M2DyAvg0TJvSaOL1JUZRO9nSRQFUfQOyuAsSRUg17JNM26GV3gmGCkSO651ZN
	oOZB5B3VnHQumOPqm5jQ49FIA=
X-Received: by 2002:a05:620a:4709:b0:8ca:2baa:6656 with SMTP id af79cd13be357-8cfad2eab27mr1171304085a.55.1773937072730;
        Thu, 19 Mar 2026 09:17:52 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad1e1fbbsm493643485a.42.2026.03.19.09.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 09:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 12:17:50 -0400
Message-Id: <DH6W7K2SLPYB.PCO7FQ6CR1YZ@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 2/8] bpf: refactor __bpf_list_del to take
 list node pointer
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Chengkaitao" <pilgrimtao@gmail.com>, <martin.lau@linux.dev>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <chengkaitao@kylinos.cn>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
 <20260316112843.78657-3-pilgrimtao@gmail.com>
In-Reply-To: <20260316112843.78657-3-pilgrimtao@gmail.com>

On Mon Mar 16, 2026 at 7:28 AM EDT, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Refactor __bpf_list_del to accept (head, struct list_head *n) instead of
> (head, bool tail). The caller now passes the specific node to remove:
> bpf_list_pop_front passes h->next, bpf_list_pop_back passes h->prev.
>
> Prepares for introducing bpf_list_del(head, node) kfunc to remove an
> arbitrary node when the user holds ownership.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cb6d242bd093..e87b263c5fe6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2426,9 +2426,10 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf=
_list_head *head,
>  	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
>  }
> =20
> -static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, =
bool tail)
> +static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
> +					    struct list_head *n)
>  {
> -	struct list_head *n, *h =3D (void *)head;
> +	struct list_head *h =3D (void *)head;

Note: The cast to void then back to list_head is necessary to avoid an
"incompatible pointer types" error.

>  	struct bpf_list_node_kern *node;
> =20
>  	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
> @@ -2439,7 +2440,6 @@ static struct bpf_list_node *__bpf_list_del(struct =
bpf_list_head *head, bool tai
>  	if (list_empty(h))
>  		return NULL;
> =20
> -	n =3D tail ? h->prev : h->next;

The new code reads n _before_ we check if the list is initialized. So the n=
 we
are passing from the caller may well be NULL. However, __bpf_list_del()
will in that case now a) call INIT_LIST_HEAD(() to properly set up
prev/next, b) call list_empty() on the newly initialized list and exit
without ever reading the NULL passed by the caller.

This is kind of counterintuitive: We are passing essentially a garbage
value to __bpf_list_del that we thankfully end upi ignoring. Can you
move the init check logic into the top-level kfuncs to make sure the
list_head we're passing to __bpf_list_del is always valid? You can also
just init the list and return NULL in that case - we know it's empty.

>  	node =3D container_of(n, struct bpf_list_node_kern, list_head);
>  	if (WARN_ON_ONCE(READ_ONCE(node->owner) !=3D head))
>  		return NULL;
> @@ -2451,12 +2451,16 @@ static struct bpf_list_node *__bpf_list_del(struc=
t bpf_list_head *head, bool tai
> =20
>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_hea=
d *head)
>  {
> -	return __bpf_list_del(head, false);
> +	struct list_head *h =3D (void *)head;
> +
> +	return __bpf_list_del(head, h->next);
>  }
> =20
>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head=
 *head)
>  {
> -	return __bpf_list_del(head, true);
> +	struct list_head *h =3D (void *)head;
> +
> +	return __bpf_list_del(head, h->prev);
>  }
> =20
>  __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *h=
ead)

