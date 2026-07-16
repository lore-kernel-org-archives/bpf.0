Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD932BF4B
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202190; cv=pass; b=OrZM6XSZKl17jFfL6E3YQUqHwuXwcJiTnw9C9XKtH5LWJNPU1tYjlLCNyhc4jjXcbhJ2YjbX1Xs7oVGDY6Rm7GX+v+T5KyfY1m6vBmzxMOPyh9VGryXwtNJ3GD2wWOA13sPi7S0iQNKfeD3O811XOesKeau4/3FMT8uvxpop5iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202190; c=relaxed/simple;
	bh=7jX2el78Z4qXDp5GUOiAEV/a6gDt+AMIIngnAQWH+kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9Jd1jKVlPgOlX+vLgT0c6suF7mLQCQq/vHNH0BORLZxEDy2XrASbfZdQNJz4DTZKG5XYFgruQk388x/uHZPMK6tV5jpgmu21/aMeKvJlz+Qeh6zpUTIeZfwz2wYuaDAczkHBqGCbYMl3IQtR8GWvJqB2yCGcXosKk9cK6KyK9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4Ws9QlA; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4Ws9QlA"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so6663358a91.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 04:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784202189; cv=none;
        d=google.com; s=arc-20260327;
        b=AIqv+jFx2kXM06v4Hc0+kGneoFrxBce1/i4PR+rKIEWRQF5F1Rl6JD9EX7YJHHD1Zl
         XuxISw15HRkyh3ULsh0ZVN9YgeIBdKOkqiQ5UdbnbtgQS7Bvu3YQiDUIRkuu/iVV9Tv1
         Fvj6IvM7AKHrYA+0tpyKtKiAs2udfFsEUSWwcbNHqPpHhfribaiKzh9u5aB9GmnAaFWK
         scz5zKS6D0UThHf5FA4rpfY7ZZyWoe1rnXiU7H/uXuTjZpaQb4dWByfKOIEqpb1aWnWa
         zgKo9VCI6nGiSWVQSVTrnudaQp7SNWB0evGHs4tmjrqrWti97m+frkB+nmV66SZqgy6+
         Cv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JovS+rCQDfsh3cyPYuCXkkxVWrghph9UOjUZsNYKjQE=;
        fh=WKM3p1xrp1sCnDrya9uBLHlQvqYiuC0jpJHChxZU3S8=;
        b=N/2OsEMFM7cYO8Vj2PLzxMbXGyBmyDgxhmzLtzXrUioMtozOg2sQo0zNqgak23WZI2
         DbFaOqkTLf1D4+2L9bTaJspn4mfZVLvhhku8HOJbBUyTtH5Nt28gFDdR2tIrLTLazswv
         Cm3tJKhanBSe597aIdeSmcMfC5b2oFCBVE5PfL44VFVE1r5a5/T9NpNVI6EcsrPtWS5w
         OPK8znB80nQ3t0DzTKhEwE52XhF7UJHK6+qcj5EKXmjQYWAzPWmoGdLa4oWO5JzL3VCj
         eOsuEbaK1V1kpQLL3Bo0d3n21t47pj0UPe00V48+Qa9TTRZFT5c7jSxCoo/IoWW/OBo7
         bSnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784202189; x=1784806989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JovS+rCQDfsh3cyPYuCXkkxVWrghph9UOjUZsNYKjQE=;
        b=G4Ws9QlAKJ6gwBc9bvgszGegrSMMbj6E6awWqmGUAwDLGpzGJoYIZzMT/fVIscYYhw
         Octym6FzDGvanIyqUOhfvBKKOHA+3Z1BWgnSyHkGbH3bUR53hacdjJoEdOzQYQ6RnkFd
         p4ZZpc8T8D5xTH0peraI8GA4BN59RoL1gtntn6ap0MozNOeHrfUihLu8siJvtFrfLPZv
         3f7EIXTPOmdxEbuuWFBK6MXcfVJk6F7Nr0rRfBrlOqUYZzgS/xpXS8anpwMXLjaLGw8d
         XDO3fMWyJ/gmD3iXlE4CydaRErPQNDfO8EreXYkVzRrQRaAjJnqzI2wkwqwOGgeqMRxi
         XQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784202189; x=1784806989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JovS+rCQDfsh3cyPYuCXkkxVWrghph9UOjUZsNYKjQE=;
        b=A/nqPrRFIG35eoMB0rM4orK/OhXPdz8L71/VmjMGK6B5QR4UMqW1uE+AnEE33bqkMf
         ptOlzYwTtKCtas2hzeMkaO6GirrXC61dg+FhK7zqDC5lsKjPpTw8NfIf0hnTX8YzEg6G
         RZ8h6KdbUbXmUfiReJc9RKCdZI4XwcKaa+/WiYjf+iE58sS7js2CFvDo2QQ7fIbDtEVY
         yWGAHKkk4HUUvWntxyUoq2gzKZjgDTIiftnkkMGZXPyzu7rtU1/imwRqpjuDS/UwwEzh
         O1i0O/opWGvIdl7HIoe1QzSZDcGLxy+x8ZaR0AOdgvQUYXthglzzKZ3Te38uugqMS+y7
         DjLw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/W8+17Beg4rjxGvl3YxYgyrry5FJUGBa681l3xZNQgxFBPN2jdKj0Vc1bj/8wf1edkDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa12m5CFch74QkE0RimVTTO9Tv0Z4qi/mgXxzrGehPtBth+AV0
	lnRB4hBlGemnHes+w5BK2CAiMx3QClSE/UVuHWczNU0JLOnLJu8d2FAkHpsLjd9m8ihdfxeNoFS
	b7ixunImkCuaZy3Qo2i1kqroXyRQ8Coc=
X-Gm-Gg: AfdE7ckgL1d7+A2wiJEChZBUOekpJ9c4yTiaHtSU3P91OFm67Wgn0MRB3vqYWg7ZWmz
	dN3/33dh3nxKXF+WeL9LGq8rgjvgIXZMsWgJf0KUguw8Dw2YS0ODJzktvVDq79qorUeV+tJcbDw
	XYrq4Vj4KC7RayYO4I4rD8sYN7u+1yzghslDsr4Era96U0UX6IMUl/+QCsKKrO/LJQsmauI1Rfj
	O1tWsJ/Ki8Y+sYBF0tEtu54HX7gr1aTF0MLPm3U6AxBc5F9sLQCmkS5wUmI2XqBxQ27YomxnJE8
	PANR0/jmmhLbjAqwPyjM3eoK1ne3ayRhr4RLM6NpBxSbpbyzPI3BEKlHgy7+QWshKbbix/+Bu2s
	/Aw==
X-Received: by 2002:a17:90b:3842:b0:387:e0cb:7f4 with SMTP id
 98e67ed59e1d1-38e17fa8e74mr11239037a91.40.1784202188739; Thu, 16 Jul 2026
 04:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-2-maciej.fijalkowski@intel.com> <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
 <ali/sIjljiNm9RmI@boxer>
In-Reply-To: <ali/sIjljiNm9RmI@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 13:42:28 +0200
X-Gm-Features: AUfX_mxN1Ir_5WiSskAyAn49z75NXsXgLWgUizzsp6h8K925OgrttctYn20cySg
Message-ID: <CAL+tcoBGJDC-Kx=qvxoQtd4BUPCDBv00Gta1SOvejx9nNvVo3w@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/6] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 1:25=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 01:22:24PM +0200, Jason Xing wrote:
> > On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This patch is inspired by the check[1] from sashiko. It says when
> > > overflow happens, the address of cq to be published is invalid.
> > > Actually the severer thing is the whole process of publishing the
> > > address of cq in this particular case is not right: it should truely
> > > publish the address and advance the cached_prod in cq as long as it
> > > reads descriptors from txq.
> > >
> > > The following is the full analysis.
> > > xsk_drop_skb() is called in three places, which all discard a partial=
ly
> > > built multi-buffer skb:
> > > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAG=
S
> > > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
> > >    the TX ring prevents the partial packet from completing
> > > 3) xsk_release(): socket close while xs->skb holds an incomplete pack=
et
> > >
> > > In all three cases, the TX descriptors for the already-processed frag=
s
> > > have been consumed from the TX ring (xskq_cons_release), and CQ slots
> > > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> > > which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> > > the buffer addresses never appear in the completion queue, userspace
> > > permanently loses track of these buffers.
> > >
> > > Fix this by letting consume_skb() trigger the existing xsk_destruct_s=
kb
> > > destructor, which already submits buffer addresses to the CQ via
> > > xsk_cq_submit_addr_locked().
> > >
> > > Note that cancelling the descriptors back to the TX ring (via
> > > xskq_cons_cancel_n) is not a appropriate option because an oversized
> > > packet that always exceeds MAX_SKB_FRAGS would be retried indefinitel=
y,
> > > which is an obviously deadlock bug in the TX path.
> > >
> > > Also move the desc->addr assignment in xsk_build_skb() above the
> > > overflow check so that the current descriptor's address is recorded
> > > before a potential -EOVERFLOW jump to free_err, consistent with the
> > > zerocopy path in xsk_build_skb_zerocopy().
> > >
> > > [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kern=
el.org/
> > >
> > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx =
path")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > Maciej, maybe your tag is missing here?
>
> IIRC this has been taken as-is from your patchset. The next one has been
> touched in few ways and I included my co-developed tag there.

Yep, I mean maybe you can simply drop your reviewed-by or acked-by tag
here if you approve.

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
