Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC273BF69D
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782512444; cv=none; b=c7GOASXYKFv4+pBFfF3iw3zNof1pPsh2eXy8MaunEefN89inrrnYVBUzTYTmBWsag+aJ7QtVXbSQLx2/kjxRfUWEv8hcFukOiOocwYwlFDN5NARjauraHbDh6nu5yf/Z6aCgbqkz2iHqgNbvt1w6wKrpV0oRJyD19oOi4QHzo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782512444; c=relaxed/simple;
	bh=thPGL7uRo/2HzUJFgnx7YqyT1JviNUojRclx/SbtywM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7yudo19bYSwP9krcRdUv2QEyFiL7rLG6RwGNap26VhOFodbk+mRwOvY/8s1BPjRXFFQQonOBj66l1AWFZFYT6aHXoZfblxdmjDzCvTVpssTBRzMs7EeHXi5qlwL6Z4VuJizsyT98lNEfLPk31AJPm/2CyuGgMNKtrGw7DZXeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OecdhoDQ; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OecdhoDQ"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30c99ccb1afso1513846eec.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782512442; x=1783117242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rjHzRwZSz30dinLgqV6749iLHAxrchS05v62XyW/Tgo=;
        b=OecdhoDQuQWdsn8Fso3amimWMbeuqRhDzxv00N1rfsw8TfvxBQHnqiNMFcNlXhhymG
         Q0dphSNjFW03cF06OgI8zpWM9sjRe9tLdkBnTx4AI5TJ4DUaqgoshN+rQSjGDiPjvKVO
         d7djzp4v+LEVv7bsS7jUfrMSX/3DBtgABpzTNgrdTVnr/oDG0k1Hx1ek+QP+9B3omsXt
         7zjqWSEJm8a6t9M/x6OLLBKjRe1sJ7rrohMyV7fhOPvDLkT/Lt6cJtnfFCzkbeiaMVMp
         9g0ZTWM8JJNyinLATyEzUGuzPnGytacaXAXBzBnOecmpWxJbL/3VG1xulLINdqAQ/OSu
         zKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782512442; x=1783117242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjHzRwZSz30dinLgqV6749iLHAxrchS05v62XyW/Tgo=;
        b=iwatqFdxRv9GTOddJ9cW0H0SPQzbTePC4fgw/jsc8RAgfHUiJHGrKllRovlJT/BKjh
         tHVI5c8qFG5s61KV84pEEAqfof0pNB24dcLZ6IWKphPolbw26hhjnQlLHsl03JJskWZG
         yi9Dty4+Y69Z4iRcvw2gfw9VHuz2kKFbT2FRHGs+yY+unD1NMhSS2OgetCdjhuXUEgWF
         mh94tvDHxAm2bniZMblXZT21Xv8UnpoWCWU5ZAQEq0Kn+MJAP5yAlYLkvMgA7h9NXvDb
         Q3w9lGitnIQ3Wzw6s6U0NsFon0CuysrfMmyrnHremg949R+txlIn655s97dZkQ8pe+MC
         6r2w==
X-Forwarded-Encrypted: i=1; AHgh+Rq+DKaK7mRRT7b9AJT2hus2Zm2TzGKZvm1Fb+FxV5oAnzI54slBcJSaM+UpGRgOG6tFdfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlIPEOO95RAKgJCcr0fs6Mqobu0hi7+3Rlv/zEpVJUiWxn/+w6
	V/Aha/IrxAgd2RSHVf3CmBA8MCcuTDHD2N6eXIJC+qk5NyaTlhd2Zokj
X-Gm-Gg: AfdE7ck1zEfE/tLjl+y1aZOtHAEOmBdYZu0QqH5VheA8L954k2aPDG9ZN8TfHMpNghJ
	DbKz7PFDlZDO5f3Lw6mB/opwyGW+ZoPkPY++cbKWWBabhEryGsTRK6SD/3/och2PruKK10cvrhT
	CDeWyHcC46eq6nVMZdeh0iMt7SWyvgbjN5UD5wR1f38HNw+iWDKBPd3xWjQlBTIQkYD0TtJJOhJ
	4mW8sMzSMO4BPYAkcX/8tmGZtfDAU1/jJM3kySbZuXGow8mK0fOv0VSUy4Pg5Zq8Y67C9l0G28i
	nROQHQnCMo9Oif7mSfPI0BrOctVsm/ct0QHtUDNih/um7tS9vlyia8GMDIOA3XNkPmJy091wYFx
	31+zos3pro1hny485QK1ONZeSMqJNOIpNoorLoh1YvC3Q7SXLVCK+uKMgDt8j/AIB4oReKTg8TT
	bRLhTK9slXqNpdvQL/r37ynXY2jpPfC+GuR6nmXiUURkr0yjp4ZcW/hx2nfwMBSQFyMKWuPA==
X-Received: by 2002:a05:7300:1903:b0:304:819f:5029 with SMTP id 5a478bee46e88-30c84d109cbmr7151279eec.2.1782512442111;
        Fri, 26 Jun 2026 15:20:42 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c002:b4e0:8df9:2e4a? ([2620:10d:c090:500::1:11ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cac87dcsm24435824eec.31.2026.06.26.15.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 15:20:41 -0700 (PDT)
Message-ID: <30d2edf636f25e16e7ea61bc1d549c915b38b356.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/15] bpf: Make struct_ops tasks_rcu grace
 period optional
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, kuniyu@google.com, 
	kerneljasonxing@gmail.com, kernel-team@meta.com
Date: Fri, 26 Jun 2026 15:20:39 -0700
In-Reply-To: <20260623175006.3136053-3-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
	 <20260623175006.3136053-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-23 at 10:49 -0700, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> bpf_struct_ops_map_free() currently waits for both a regular RCU grace
> period and a tasks RCU grace period for every struct_ops map through
> synchronize_rcu_mult(call_rcu, call_rcu_tasks).
>=20
> A regular RCU grace period is still required for all struct_ops maps
> because the struct_ops trampoline ksyms requires a rcu grace period
> (take a look at the list_del_rcu in __bpf_ksym_del).
> Add a map_free_pre_rcu() callback so the struct_ops map can remove
> ksyms before bpf_map_put() wait for the regular rcu grace period.
>=20
> The tasks RCU grace period is only needed by tcp_congestion_ops.
> Add free_after_tasks_rcu_gp only to struct bpf_struct_ops instead
> of the bpf_map.
>=20
> When CONFIG_TASKS_RCU=3Dn, synchronize_rcu_tasks() is the same as
> synchronize_rcu(). Since all struct_ops maps now complete a regular RCU
> grace period before bpf_struct_ops_map_free() runs, skip the extra
> synchronize_rcu_tasks() call in this case.
>=20
> This cleanup prepares for a later patch that needs to support
> free_after_mult_rcu_gp.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -997,24 +1006,8 @@ static void bpf_struct_ops_map_free(struct bpf_map =
*map)
> =20
>  	bpf_struct_ops_map_dissoc_progs(st_map);
> =20
> -	bpf_struct_ops_map_del_ksyms(st_map);
> -
> -	/* The struct_ops's function may switch to another struct_ops.
> -	 *
> -	 * For example, bpf_tcp_cc_x->init() may switch to
> -	 * another tcp_cc_y by calling
> -	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> -	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> -	 * and its refcount may reach 0 which then free its
> -	 * trampoline image while tcp_cc_x is still running.
> -	 *
> -	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> -	 * to finish. bpf-tcp-cc prog is non sleepable.
> -	 * A rcu_tasks gp is to wait for the last few insn
> -	 * in the tramopline image to finish before releasing
> -	 * the trampoline image.
> -	 */
> -	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> +	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
> +		synchronize_rcu_tasks();

As far as I understand, this removes the synchronize_rcu_tasks()
for qdisk, sched_ext, smc and hid struct ops. As far as I can tell,
each one of them employs separate means to guarantee that there won't
be any pending BPF trampolines referring to the image being freed here.
So, the change appears to be safe.

> =20
>  	__bpf_struct_ops_map_free(map);
>  }

[...]
