Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2C3EBF3F
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923767; cv=pass; b=m+O90rMSpZmbSR2Dcaq6rVe+XlA6BMX+D4bwY/bfVbgqgVkV8+cEOXgWHqp7naw6lp8Zf7xowIUAgU2hK0wCMjdQhBQoONaCWY6+FO22O7iLslGAjrqfsXJDeQ2/6S26tsZfk2ZDN2Q53749kKI4SD2ecG2T5amZXct5WNHO1Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923767; c=relaxed/simple;
	bh=qlrNwdBTPBiHmIII6NewTsfdeTe+gakww2NBTJP2Qwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeE4nXE4w6OUXJt+ZjI4MUDDWzW0LQJJfi3KJUkGBIIvrQJBDd33iymqnHH7oFsOsw+rD80nS/WTdKYlIogTTocNQjnLMbYfXV0L44p8dOWyQMfvcwspgAgx1m9gg4ZP59rI+Ja5tZhFSBAP/NCMn8ejfi5cdhA+m92Z02mfdTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/2skPy3; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/2skPy3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4833115090dso1408015e9.3
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 11:16:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770923764; cv=none;
        d=google.com; s=arc-20240605;
        b=USgq+Gt3YHXyw7s0diyVZKnrgCjoD1a9q3Fnwnw4Im6BPe0CXaWexeck76x4v5HFEv
         sQ682ki3WMAA5X9uB/6mbxiNCbswYSSgBwSWBsTphIFtzz9KVYb4yvumpyQ5GbgXHQpZ
         vdfoQhH7pDKx7Onvck7y0AFJfcmbhgbEfs92NGCdaZCBQ9WxeWz9g4y9pD95d9fw3QU0
         6Cios67Odto+y5TTQY+0OoIh9hI8nmjNkrMRltiJ6t615KSA3fCDXEpEDSJItgq0AM2T
         1a61ilpLuxxS/Sx8MiLsF1xUB8d8ntgdsb50o7RqDTwHGxS+55zk3id6Yrg7GGhy9R4g
         trjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=34GBq/w9QEN1MAXl5GyaptaVmrZQSD6tth2MQtzvH/8=;
        fh=Js/lXSWFGbP9Pp7uqTii2fUX7J/w8Xa9afWubABXZtY=;
        b=R9/1xzShb9JGmrQTxR4gZp4A9sH+dusA6qIyB6MapvCeo9iMUaSZWqVY0qdtTyPgea
         xfDeUpuVNBNkJXKU96pbvosUL+4dJQgWHGHBz24ThkeWhfNfABiNOLkIV+C5vvQRgBee
         a5SSlKJs7jIQb6j4yEIVDwytRXqxlGxiD5gT6SsLujAFvEM3iQE2XDLRa9Sw9oJOpXLE
         LL1xVnjOj/1CWafL+Wbxmtls/1aZGwaUIdRc1pgz0mneRDFkhm76PyRDbNoKQjYdGg/D
         CO7xChQx1XiqFvVZBrjXAQq1iIbVVjZn5H2EVhNp+u+qdV3pQeDeQzUK74y/Qnb5zEtc
         4nqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770923764; x=1771528564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34GBq/w9QEN1MAXl5GyaptaVmrZQSD6tth2MQtzvH/8=;
        b=R/2skPy3uXvqYVtqfCJRs6dpYyqOTrYjF6iG3TokMqiZ0D1222ppXLe9FZGSAgRxkD
         mJbKwUeEqT0hUidskUQd9/v9WMd9gE5NtVmYG5lGPfoZi/i8j64ZD6FZ52G1yI0EiGIx
         xliOUyqu0TzKqbnMShW+w3ntGzTiBConyWsBwCzUym7R31d8lIW2d4s1BYP94Nay6G5T
         LqMEkgAw4E+tyIA7263bMGz/IJGBBH/ec61iZGW04j5hL/3CsXO8Wd90ybhvpNI9kX5c
         /8ul67iY23lVii5EeL6r5tY++rKRmSqpHVwlTkFaJNzk52a2Zs5EW0wIo41Nfz8N8kif
         LpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770923764; x=1771528564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34GBq/w9QEN1MAXl5GyaptaVmrZQSD6tth2MQtzvH/8=;
        b=AyMuqDYSHCUFz94C1k0s5ALIS90OHgwQ7z+2hJBSdqhhPZaM57vNSZhkP1384YxH3n
         aRshe/ske761AK1AKuEBHeyb8C/aGDNFCJYQNrNSkKyotugKa+yP+Nu/yKpPyUa4bUpa
         LIP6YuKQYRjq9OckkkG/k0C7O+Sp9kES0y6nM2g95g2hzDjoNXeWRX+O0OgTFebd2ivA
         mBtdUgJA0I8t9s0a5Mog84xwxzyJJbeGpVv8nrEPR7oWAhXuskVaRlbOHmE7PceVMkYa
         VdOWfgj23DswqU+7sDUQI6601watd+c0BOrQWYoHMIpNptdpw+SC2FUZ5pn1hFXP1zzr
         g+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXxi93o5dsqGJ5TxCHMpwDOgCeQUOUfrbQ3pYbQynNRIB1RWfYP2wq1FIyXBv44k7FBElo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmFW5sOZE4zrdmOtd0KG6aSz9c+rifWu53FX+yxdd6YaNVL/W
	8IY+zALawx0hGajOFA5+vS5UCFPH9yrWHsvmWEP4EFyDwDwZvM9Q4NiANv4tPbr9FoCy0kzrk4p
	eMSyOqomfbOSIY8k+s/6lNKLHPaMAtt8=
X-Gm-Gg: AZuq6aLNT/9if9SR4IN9l5DegjOgTO5Q/aGWwD2GKIzBrHCz1hnLrezBWth55L//3+U
	/VwhV5Lv5L+z+IUSkzg7f3CjS4ucP76NKxg50fWIpE6o++K1T+WDqsFFbMroQG4R0GBMlDoR/4o
	hcI6ExMcOT44thNOy3d0IVypzSJEpQYJSlAjKOgRk2QicTktmmRK85CBXqmc4dDesl7ibCdS6TR
	y1ydvMntel/r/BX3jsLSaH8tkB1xfKN/TXrLvZpdZazywgAqFjvyXhf7gmfgNDss10G1yDWKY4H
	qDxY1XhcPTBhyFDoJtAlcDKZYE8hEpcOhlXfaZDJQ+t+YVpYI4o8aDRjyuTjovB3IgESmnfMmIR
	MwCLBKVUn
X-Received: by 2002:a05:600c:4f0b:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-48370cc979bmr3868275e9.0.1770923764039; Thu, 12 Feb 2026
 11:16:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206093410.160622-1-harry.yoo@oracle.com> <20260206093410.160622-8-harry.yoo@oracle.com>
In-Reply-To: <20260206093410.160622-8-harry.yoo@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Feb 2026 11:15:52 -0800
X-Gm-Features: AZwV_QheBogDYj3hjqCT8mZg95VywPTWK4lWyWbkX01r20D5GbhYKN4gZGkX0C8
Message-ID: <CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] mm/slab: make kfree_rcu_nolock() work with sheaves
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:35=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
>         } else {
> +               if (unlikely(!allow_spin)) {
> +                       /* call_rcu() does not support NMI context */
> +                       rcu_sheaf->size--;
> +                       local_unlock(&s->cpu_sheaves->lock);
> +                       goto fail;

As a first step it's ok, but we need to make call_rcu() work too.
Shouldn't be too hard. It protects itself with local_irq_save,
so if (irqs_disabled()) defer to irq_work and call_rcu there
or guard reentrance into __call_rcu_common() with per-cpu busy counter.
rcu_head can be reused to form list of objects to be processed in irq work.
