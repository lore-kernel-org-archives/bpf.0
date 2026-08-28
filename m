Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6D53E0B
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875502; cv=pass; b=CuexTvl9aORmOD2mKjqLTJkTnLtCoREWsB0NOm8uE8mkt/j7SHMn/THd+IXemu8iPZBQ9PHnfV6jP2G9NZMi4r9SdBjEj3JKK+5kZedcBK0eli+2ghQoj7AJVU1T7SqarUhDs1C15lMQW4qQ8RD+OL/hKwOH8kZl10a2BT4XZSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875502; c=relaxed/simple;
	bh=PFyr2Yax0psAjbVNGRDUr1d6xTY3B4cnOPN1BhDgrd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVd+HALpG+v9v9iRp8iOg+REqkhBKM+18DnqR0isARQcJR9r1iurYzut4MvtD6/+d/IL9o43kDqjohoj4DUYXulSnbmrtnaL2ypc7zrcn7NJocHWWqbI9mx99im00g/zv+wr4wkM8jHfiv5pd0SUjf6hrEu3gqzIhoMZkpTJle0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7a4nifx; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7a4nifx"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8557c3f270eso42727b3a.3
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 17:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787875500; cv=none;
        d=google.com; s=arc-20260327;
        b=mO/nmSiETX/iuKvSCfv13jyROb9i7o3zqiuWy3zWNarofYEBtNE1KrgYW3nBXqR1se
         1Mp1pgyW40ORClwNZC4Tyn9S13AY8k5Vy6Y1RhIo0Qom/bdbOZy4JcjMXmkDAs4DvutI
         TjI8zD4MEDpSmj6jfvRhfQNsfHlHs9F5zWQcw5/PAP9nUJZFy/uy1Wkf3BBSOoXtcOeW
         y4QQl1H8XfxH7hBwjTM7kyo1v6ogt7CUTKPtvo/1epVXy0oLda/h/o8F2bAhBmn3sLRu
         COKsndSA0iMrmYkhUYc6anidoBsJnIg2NLy287BpEqXSyIGHg0S9dwoBZcQ3sepeIX66
         pwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yPMW9cNcy0b0Gxn9756IDFDtVnIcdjZAJDlCv5e1zT0=;
        fh=9WjxP9HuH0w/1a0RXLksyIbGARtDLoodiXxXQ/jG+Pg=;
        b=DJmONSUUopOophMq7wQDAdllcNABCft3IS0j8xdoYhKrz42vV/mqHn3CWT4EOPGwui
         BUXuEl0MeXD7DmSr4lDybyxZxoLYXeJ5GCfGrA0kJedszEsvSIu6XoVCDgR18wmbO4xK
         AGrVKwN/Re+gUP7u8pHrCW3EUO2tgSxpL04WEnjdzfW1MIYub9nh9tHf9SHA3vyMfkpP
         VcABTmW4lYHYj11gEnMD3cv7cVt//tJNWvx8X8B5MRo4fVBddQovSyiOL+ROvp6yAxRx
         Kg9JBzg3d3WeApPTQnSQpYaaTnApegc9wJH+tYbYaqXjUEAhcZ0bkAPa1p9IP6aURv4J
         ++Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787875500; x=1788480300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yPMW9cNcy0b0Gxn9756IDFDtVnIcdjZAJDlCv5e1zT0=;
        b=k7a4nifxqJ1hE3gMfPYwb05fzwmsB0oWkzDMau3cwCaQNfnYPz8mQRW74VDY7/AL0i
         w5tvACJF7CD9AIBrl/GE//9O3mE4ffwqPWmX/kmyaq7EYONLaG7TT8HrblxODDvkc9QP
         tCymoBN+2/ly4v0HSwsr1DVUTKOL2SXeb3W8IfGKEVoc1bm3NUAOX9LVyu8kRqZu9cv/
         Zt3QYBQGsqKe7X2IZ7otRwHgHw/xlBkyrrcqoa53dUgiRc1W1ASz5aVGKe851NtO+0vQ
         JevwzzgE40VSwS07a64pm0aAxbzetUNFs/b97wiAdml2mtCaGFgHSn0N9IQ3hKqFbvCi
         9vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787875500; x=1788480300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPMW9cNcy0b0Gxn9756IDFDtVnIcdjZAJDlCv5e1zT0=;
        b=IsbdjTeeHb1UnZLBlcM6Ve0QcBnOSAri8zUPjUOa+tYX9mJbZwLd/2dcjHmsLtab5e
         fZ2DKBPxmq6qqd0cmx/u84bMD6Ybly/7jAMMoKXGIejqXnOWD5ulfWWfLNqV9i1mPto5
         U0dXakorTyUzc+G9fQoolbW1d5sJLDsCSV1vd9gIHOUcuFTWqICm5Xwf9y6crYABoDDW
         3qh5+TJ28W0rRUraFnh1aRQqSKWE7jTJuIJcYH2DT62+PNNLMN1ydZ6f2EMXA9CaXh9y
         AtZD+WunGjOaKdzlVJnsPU/vVvkDx05Id0wAY0fPoEAI1yQCstK/j05Ek9QaPFdkXm6G
         5HoQ==
X-Gm-Message-State: AFuF++nSx77QJppBf53XtpXWU/+GvS71jskZTJ+ItPaBmvWUi21mT3XI
	6drRufuwhternpvpI+DLnXSFrMhTG69q1ILnr5dJ9Yn5x+tTx6EwIdg/ZbfsFJjVOnXNvo/dvhW
	MHE0Vet7GiYGY7w9KnpZYU0xBllgVjnxbfg==
X-Gm-Gg: AR+sD1268F2c24HtP9PMUf0qWWFiAp1q3NAemPhXAqnspL+2QE9K0tNxHX6y7x7F5i6
	Bug1MdR1sSdorCsADeGirZ9KuKGZdeVF1NsyhbVt9NFuA4tEj/H4ZHGSnOLGnDnGkZbuuuyou7f
	u7EOu3x18aZXc6YyUXdx3e4/8e5+z1GbZvtqMvVSTSqPkUGzifZm1Fc8XqFnMrV/561jJlyfokG
	hIgC9UYVxhfZrCKCawGmjytdRCSzveZ8LuQLQPhvpslCtUJ9NR598yR4XoWaHz8/iG0k2Kcd76F
	52j/xsXcQr1j4mGVcJVdwRyXVdru9G34gPPd5sJuZ5vyhT080h5RS8CVnVXeSX1nACPUFxmfqHE
	Sn2NDMp1dIoP9MzWjSOh4frhbTw==
X-Received: by 2002:a05:6a00:3309:b0:835:6388:655d with SMTP id
 d2e1a72fcca58-8562ba7dae0mr6302793b3a.14.1787875500260; Thu, 27 Aug 2026
 17:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
 <20260824083327.1708560-1-chenyuan_fl@163.com> <20260824083327.1708560-2-chenyuan_fl@163.com>
In-Reply-To: <20260824083327.1708560-2-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 17:04:47 -0700
X-Gm-Features: AcwNN1UBYnS7FD610auS33NR1yghL6FPy5aMSeXhTY-PLjZTBWjuSmerZRMWxYg
Message-ID: <CAEf4BzYLUTO+6bcp8X8M_wbc=JaxZMo4PZCgS0e-t=8zMO9tSQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix queue/stack map u32 index overflow
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, Yuan Chen <chenyuan@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:34=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> The queue/stack map addresses elements[] with the product of a u32
> head/tail index and value_size, but the storage itself is allocated in
> 64-bit arithmetic.  When max_entries * value_size reaches or exceeds
> U32_MAX, the product wraps and push/peek/pop operate on the wrong
> element, corrupting map data and leaking stale values to user space.
> max_entries =3D=3D U32_MAX would also make the u32 capacity counter
> qs->size (max_entries + 1) wrap to 0 and permanently break the map.
>
> The original bound check was removed by commit a37fb7ef24a4 ("bpf:
> Eliminate rlimit-based memory accounting for queue_stack_maps maps"),
> which deleted the bpf_map_charge_init() call and with it the
> U32_MAX - PAGE_SIZE check that had earlier been moved into
> bpf_map_charge_init() by c85d69135a91.  Oversized queue/stack maps can
> therefore be created again.
>
> Restore the bound in queue_stack_map_alloc_check() with a single
> comparison that rejects any max_entries/value_size combination whose
> element storage would reach or exceed U32_MAX bytes, keeping the u32
> index multiplication overflow-free and the capacity counter valid.
>
> Fixes: a37fb7ef24a4 ("bpf: Eliminate rlimit-based memory accounting for q=
ueue_stack_maps maps")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
> v4: simplify the bound to a single division-based comparison as
>     suggested by Andrii Nakryiko; this also rejects max_entries =3D=3D U3=
2_MAX
>
>  kernel/bpf/queue_stack_maps.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
> index c1c9dee4dcdd..0d9e0b807a50 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -59,6 +59,15 @@ static int queue_stack_map_alloc_check(union bpf_attr =
*attr)
>                  */
>                 return -E2BIG;
>
> +       /*
> +        * The u32 head/tail index is multiplied by value_size to address
> +        * elements[], and qs->size (max_entries + 1) is stored in a u32.
> +        * Bound max_entries so neither the product nor the capacity
> +        * counter can wrap (this also rejects max_entries =3D=3D U32_MAX=
).
> +        */

nit: drop the comment, it took me longer to read it than looking at
the code would


> +       if (attr->max_entries >=3D U32_MAX / attr->value_size)
> +               return -E2BIG;
> +
>         return 0;
>  }
>
> --
> 2.43.0
>
