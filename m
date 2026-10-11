Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BD31280C
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734176; cv=pass; b=ezOZJOlI9rmpuRp2a8KBtTYTtT4PYZ+GRmMQkiRTbvUiP296nKMOZuPX2kp3B0Ige8Ix44EB0sqzeqmdD0iWgYZJGqEugc7YiGxlgwIeExqgzxic2+ta/jkRQowVg5djYqU3JFQCuiVtbJX1WD1csz1pxaM7796G/tvtfvcH3fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734176; c=relaxed/simple;
	bh=/JK+8oneyHjSUbJbc3j9nJhc1e8XAgMgQI7ekpEsvxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d34dQ5FOslHrvEQfSZvzBM1KzK6Fn7GSKlgtp/+WvceK6naiYa0gX37jk4aFRXU6mDVXipH4EBTE/6rSwEvXD6G74cTLUKJBXaY1HkswKPUI4/GzbhcWYHwX1WiCSgwn7rmY6Wp+ntOl+3kqxIlhPPrf/49iddqzCW2pfxoBdKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTWt42B5; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTWt42B5"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so1406a12.0
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 08:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791734173; cv=none;
        d=google.com; s=arc-20260327;
        b=XI5UORdSINtZkHLGMfHX4k5lQXiaxb3VA1OWM4fa7hzRrF5gDrxHi0g1waYKTBExMq
         tUQbNVixQ88pwUG9Lf7yO+2kLnTixxZBTqNYQ1kws/p+TpYT+mhr/EACUG3WmTNe0xZi
         +zSf7BK80aI7lIREXCz3gjUzrWe3nT9c8NG7zaXJBHCKhrV29zbP5qc2zcibmn513Sdr
         s1BaVe630NzwV7Do4+ohcNKHF/G6bu0lwqmlb4v5SmaQblvvHtiaQtcNZ9uiKdievwbX
         tavF264/Hwd95A6K3m9BmGc/EZ5JTE24RNEJX+qE/y06cd4ODJqUgIjE29+Fcl+l09f2
         v5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/JK+8oneyHjSUbJbc3j9nJhc1e8XAgMgQI7ekpEsvxg=;
        fh=J+0XOIl+sQO8hnrIkrdI6v7rv03nY9YVD6oPCRBNGNk=;
        b=Oc6GxIdXwe4yMqsdDShVOHu4Zg9sq+S+6lahBjXteTqkPHToXKYIPSsZ9x/sQfOP4F
         fFxSXZG0qDwjtEX19xBP3IOK0s50g7mikS0ri+SAmSgt/uCZ4egQgPdK+sYLeGjqTEut
         VS3UVzNre4ZbZnDdiwlHKGFN5uK77vnAmgZIUmXH3VeNRnfAIUNujBaWSRnF8cY6mZjT
         erj9B8t2cVO1/Sr8UhgyoiSegjuIbw2KkLRfrTFpFaNw3/BLstBKB/mtt8oMDNBxq07s
         h6jV/gijFAhd3sw+8beP1KEd3zle2ViU4VA+0Ow1F/rXficLF/PWBeMCNEF/RYTN2IDB
         ivHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791734173; x=1792338973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/JK+8oneyHjSUbJbc3j9nJhc1e8XAgMgQI7ekpEsvxg=;
        b=DTWt42B5LkI2szJVPHCoQxA+Ac9vBYc6SBWESIZtpg0A6M6a8RT8GcUSfOOWCsGs75
         1ElnUKHWQxBsMojffPmn4/7vrKZGkFGfRej6G80p5Dc8oDiPhOiPLFEzPTZleb0KB1wR
         w1MNTSyitfqoa4yQYzOclHcoYGiCdyObcXvh7WStRl6zZpJEHWljr5qkW8b7ZBtg7NQf
         qkGoifDy2ENyTHLGAu4PegXqs/yleRxehBp1GMlZDcZ8ifc6aLwbOp1mul7RMPKktwfY
         rWVBM6EijA2+WlVAK08KB7NM/7e5bhm5DSzg+AImqIB378URTIAZZ6a5zTmIRxI73JdF
         vf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791734173; x=1792338973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JK+8oneyHjSUbJbc3j9nJhc1e8XAgMgQI7ekpEsvxg=;
        b=kP4cw7uw3HZPz/UpPgdSM3NNbMZWv1++OfueubDrPxooo1p1Kjaj3AUcICWg1wXcN3
         1GvCcIF8nwQbyRiNL6Sty5pj/fr+Bh01i7DaUIHBOg9tuxJKtit8nUHyKHTPkkZYV7Gs
         J2g5pkUQka0gF0ImiIx8LxX1lKRs0UkZS0DmMAyhn3S7dpBylFseoRqMm4/+e9Kyo2Mx
         lql+eEkBAq0sbQos7Zt81NEMu2F/BOaoC23Lf+Oe8DSW/nwHA1FsPBhH/AcFzrvcaTEA
         yvyZ4wi73KOL5gcIL8QmTKtJBeP/YLqmndpHbDH5KfS0TLZo52v7zWunGJyJRGfuR2lh
         vwJA==
X-Forwarded-Encrypted: i=1; AKwUvBz4PyrK0Ytq9kWq55scfnrK1fADZQjA2ojTlg6CyN0phgXQrDvNlXN5SiUuh7LweVMQf+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAVGwx1GaYuAvEp1rITvNNIIwx14vEye9DvK7/bUr1jisYik+y
	Uz3mnE1iY+LI8VEA1jdJRTIMIy0i4AZlFFZ04U7FEzxJv46WIHE2t36ZLCsQe1BlZq8pfuFnhr+
	IA+lor08zq7rRit81dUgsRGdIlixwPLboDk0kNEhW
X-Gm-Gg: AYBFou1K8OAS9JjoVzPd+1cpeec1f5JLACCqGxRUOAQq6B11Z+2zSr7OJW094234Ygm
	bKORfK9UV6qB6eeilKfK7UyEa1v/hOq/vx8IgOFUnhrotFExBYGXH959Pp4bpPWRuh8ZAfIU/un
	GQbja5dnjaoCpZnhU75r5uwZm2KmC0Co5w+Djz0VBxBvPX02zc2u4S1ihmspQOIWFQNlPm+eJws
	TtScp630uqeEScU95AiBoh2eL3exHq0H0lpQh4WVXt6FcRt+KDJHUoudpMh9mBwZsDQgf7lm4ON
	1q7zif/cCt2THqprScdJk7aHHN2J8OYD5dCUkVnUb+83WmzlPW0LTeHBiqLPAC2p
X-Received: by 2002:a05:6402:548f:b0:6aa:b72b:d762 with SMTP id
 4fb4d7f45d1cf-6b198823fcfmr54337a12.1.1791734172609; Sun, 11 Oct 2026
 08:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010083935.3274178-1-almasrymina@google.com> <20261010083935.3274178-7-almasrymina@google.com>
In-Reply-To: <20261010083935.3274178-7-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Oct 2026 08:56:01 -0700
X-Gm-Features: AclHuK9SxZyeBfW-6W6d1kton3R7TtfUwblUvnT30CCIbrIv1iqXLpJDIRaE5ao
Message-ID: <CAHS8izP58-H+bGw+4RJazukywpeDX5jMKaH9coMwcXh-mFa7AQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 6/6] net: kunit: test netmem, page_pool, and
 skb frag refcounting
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Cc: Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Michael Grzeschik <mgr@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Petr Machata <petrm@nvidia.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 1:39=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Verify that non-pp (page._refcount / binding->ref) and page_pool
> (pp_ref_count) references stay balanced without cross-counter leaks or
> underflows across regular pages, page_pool pages, non-pp net_iovs, and
> page_pool net_iovs with both pp_recycle=3D0 and pp_recycle=3D1.
>
> Cover get/put_net_iov(), get/put_netmem(), napi_pp_get/put_page(),
> skb_netmem_ref/unref(), skb_frag_ref/unref(), pskb_copy(),
> skb_zerocopy(), skb_shift(), skb_split(), skb_release_data() (clones,
> unclone ordering, pskb_extract(), and skb_morph()), and skb_segment().
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

This patch introduced warnings in patchwork:

Documentation/.renames.txt: warning: ignored by one of the .gitignore files
Documentation/.renames.txt: warning: ignored by one of the .gitignore files
ERROR: modpost: net/core/net_test.ko: symbol 'skb_shift' undefined!
make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
make[2]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:2179: modpost] Error =
2
make[1]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:248: __sub-make] Erro=
r 2
make: *** [Makefile:248: __sub-make] Error 2
New errors added
--- /tmp/tmp.UjTzqx5Cgh 2026-10-10 05:13:14.877336904 -0400
+++ /tmp/tmp.2YswE6nv11 2026-10-10 05:13:32.781257136 -0400
@@ -1,0 +2,5 @@
+ERROR: modpost: net/core/net_test.ko: symbol 'skb_shift' undefined!
+make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
+make[2]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:2179: modpost] Error=
 2
+make[1]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:248: __sub-make] Err=
or 2
+make: *** [Makefile:248: __sub-make] Error 2
Per-file breakdown

We're not instructed to pw-bot: cr our patches on patchwork errors for
non-sashiko failures, but it seems the maintainers will want this
fixed anyway, so i'll pw-bot: cr myself and let me know if you don't
want that.

pw-bot: cr

--=20
Thanks,
Mina
