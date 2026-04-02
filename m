Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8353EF0DD
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170833; cv=none; b=VVDjr6BuXUFyvhvFZZyVcu+yR9uascjM52lkp95e2TSoa74vYC2ZvA8nCWFfOWQelFUa3XvPPEZSsU/tt1LdM5TnPnxyP+5hOCSetuNMUf73szAUDz9ac5oQBGGYTFB+tksYlPqXLCxiV/d5wPEHqCCVp2axiZO3XvJwbV7Vh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170833; c=relaxed/simple;
	bh=UNP/i09LPDrr5ofwIWjeoZzvRploUuqwNY48RB4hwgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/9oPJE2+FNI3/xRJAQRicRRhb6aGk7zPHf09jlxyKu1XfP7Z1J/kHQVSCQCKr72WE4LMkZumonlXqgbm4lcgCFursoEdL0zE9fmLNAAeI+onxqonS8igwD+rt4cub8YP9AVccRb55VyyeukEYHWLEsCdBjnobtECaRZy8RrpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnMDDQpl; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnMDDQpl"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c5b3d8eab1so441882eec.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775170829; x=1775775629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yd3zShC3yJuODpByZ8XJoFDD8uo8tECYjo5Z5kbc02I=;
        b=RnMDDQplJFelTDLkVqWYULFg4HJqfJYxcSmeq76s0gdV/9iJn6pjKLpNyL7MW+tYlN
         39vLpNRUGW8/2WVX7xuxh0NBrulzo9XlK5bYAH3GdqaHRm/+q1rzcRq/5IFoID5tDw+W
         plbuSbJCfdaqHiKl4HTMx17jIypgGSusMKnRzlqWedgW1KucD6frpZ+EAOpd+PYv/l72
         N6H+lYDVwRF3CKeWv4yOutGQjCz4KRNqERvba2LBSscQaC2QXvRBp8To+A+SKLCm+ALx
         6/iCJMvYP34UMMp23ZInHsZyjs8dZPBaH6zIlokcx/JXl2uwfOWlSYdd2HKY/DGKiEx/
         ut2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170829; x=1775775629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd3zShC3yJuODpByZ8XJoFDD8uo8tECYjo5Z5kbc02I=;
        b=riLIinPBCXagv8uyn4c40hQjWXHRJOf9fb8v2g3Yv7IBN5C/Gd/ZidVU3YHLU2yA2v
         vWjZvrxIFFGlOO5uXWHkSQtdr7cDrdWFiDXgPQJzib8VhJkVsXjQHeXXFAhQuDHKSXDw
         oL8OqKvYZiHQUeVofevQRFmpNLTYvLw9LmJ4NGGs1iIY378eTmgY+PT5jS2uvOfnwcmB
         xPnGBiirbsDF+fW0718nh+86ybFV5vzPtgWikqKe/iVIJXqv1+lDQu82jeZjXoW2a5mq
         6E2mGsO5MMpsdMzr/YW3ChmINspjc/oJ9gpZbArqpPjkN1EMGoG0IV1WAPJknRloLBlV
         dFmA==
X-Forwarded-Encrypted: i=1; AJvYcCUJkXJ5ggnhHfTVyXqHbu5Tb5C7NNVv6UWXAXJ824w41PiITKNLJ/ASZb1DA9ZAnSqzkAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAQ345qhu+WUVbAa2op6DLrjEaC7Z8Wzm23Rhh+qESssW7Ohb
	N+1nsFklwNh2IY8A1eF4y3MwQJ7k8VqGUDXTHK44Fp+Na2ncyu4fvS0=
X-Gm-Gg: AeBDiesgwv82BXGDIJcytFKP10UqOQl4FZ1O3SaJJPvA/lys8vMgU7PIoUwT0iSFXm2
	pqckmqok6RFWVSb/g4/s38PGnZejYsmdPfWzU9lNQv2E/MqhgwLYKifE47wK1llLasPEGViURMK
	9rDdJhQSV0LSppgOV+VZzhOdUE+1OEzAjM/ZCB5DLsjWog4VvsW7U4WevVQ1f/D1AiO15EFanqK
	a2v+bZvmIMd4xb1a5zTF/RtUB/w15nZ2A84Ud4Y/Vg4/9Z+u+ZSXhaflRy4rdhPQKiBkJ9oASbh
	tHT0YWsHqB/8fgpb8uG97H7A+7fV4TZ1M3huIneRU/wY4UGhTuna3X5n0a/HeFhqge9cfs4Pm5X
	TEWHT24UhHP0vkDsIA+oLfQ0mFwOK/LW8UiTZ9SOUXUV6FtJgouinXkKx4aDuf+PArVg2AgrOGQ
	NixjNGjR2AzBKfyxsinuNdlvqEIkE+r8XcJtK+EtXe0GyAEj1+JacwCIMGlvAEZKgQdOysSRbHu
	riGjiWY5umaOlHH4+r34eSJKk4/
X-Received: by 2002:a05:7301:2b07:b0:2ca:f181:9b17 with SMTP id 5a478bee46e88-2cbfca5c3dfmr519556eec.33.1775170828604;
        Thu, 02 Apr 2026 16:00:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cae9e9esm3403523eec.23.2026.04.02.16.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:00:28 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:00:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, metze@samba.org,
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/4] net: call getsockopt_iter if available
Message-ID: <ac71Czwqzsyw0Lyd@mini-arch>
References: <20260401-getsockopt-v2-0-611df6771aff@debian.org>
 <20260401-getsockopt-v2-2-611df6771aff@debian.org>
 <ac1I_CMr43XTpvHj@mini-arch>
 <ac1Pzt4tpt73SkC6@gmail.com>
 <ac1fjvVDfatpXwPY@mini-arch>
 <ac6MAdYyuPGsB4am@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac6MAdYyuPGsB4am@gmail.com>

On 04/02, Breno Leitao wrote:
> Hello Stanislav,
> 
> On Wed, Apr 01, 2026 at 11:10:22AM -0700, Stanislav Fomichev wrote:
> > So maybe something like this is better to communicate your long term intent?
> > 
> > 	} else if (ops->getsockopt_iter) {
> > 		optval = sockptr_to_iter(optval)
> > 		optlen = sockptr_to_iter(optlen)
> > 		do_sock_getsockopt_iter(...) /* does not know what sockpt_t is */
> > 	}
> > 
> > ?
> > 
> > Then your new do_sock_getsockopt_iter is sockptr-free from the beginning
> > and at some point we'll just drop/move those sockptr_to_iter calls?
> 
> Sure, that would work as well. It would look like the following, from my
> current implemention:
> 
> +static int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
> +                             sockptr_t optlen, struct kvec *kvec)
> +{
> +       int koptlen;
> +
> +       if (copy_from_sockptr(&koptlen, optlen, sizeof(int)))
> +               return -EFAULT;
> +
> +       if (optval.is_kernel) {
> +               kvec->iov_base = optval.kernel;
> +               kvec->iov_len = koptlen;
> +               iov_iter_kvec(&opt->iter_out, ITER_DEST, kvec, 1, koptlen);
> +               iov_iter_kvec(&opt->iter_in, ITER_SOURCE, kvec, 1, koptlen);
> +       } else {
> +               iov_iter_ubuf(&opt->iter_out, ITER_DEST, optval.user, koptlen);
> +               iov_iter_ubuf(&opt->iter_in, ITER_SOURCE, optval.user,
> +                             koptlen);
> +       }
> +       opt->optlen = koptlen;
> +
> +       return 0;
> +}
> +
>  int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>                        int optname, sockptr_t optval, sockptr_t optlen)
>  {
> @@ -2366,15 +2390,31 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
> 
> +       } else if (ops->getsockopt_iter) {
> +               struct kvec kvec;
> +               sockopt_t opt;
> +
> +               err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
> +               if (err)
> +                       return err;
> +
> +               err = ops->getsockopt_iter(sock, level, optname, &opt);
> +
> +               /* Always write back optlen, even on failure. Some protocols
> +                * (e.g. CAN raw) return -ERANGE and set optlen to the
> +                * required buffer size so userspace can discover it.
> +                */
> +               if (copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
> +                       return -EFAULT;
> +       } else if (ops->getsockopt) {
> ....
> 
> > I hope this way it will be easier to review protocol handler changes.
> > 
> > For example, looking at your AF_PACKET patch, you won't have to care
> > about flipping the source and doing the revert. Most/all of the changes will
> > be simple:
> > - s/get_user(len, optlen)/len = opt->optlen/
> > - s/put_user(len, optlen)/opt->optlen = len/
> > - s/copy_from_user(xxx, optval, len)/copy_from_iter(xxx, len, &opt->iter_in)/
> > - s/copy_to_user(optval, xxx, len)/copy_to_iter(xxx, len, &opt->iter_out)/
> 
> That is, in fact, a great proposal. It will make the protocol changes review
> way easier.
> 
> This is what I have right now.
> 
> 	typedef struct sockopt {
> 		struct iov_iter iter_out;
> 		struct iov_iter iter_in;
> 		int optlen;
> 	} sockopt_t;
> 
> 
> And then, the drivers change would be as simple as:
> 
>  static int packet_getsockopt(struct socket *sock, int level, int optname,
> -                            char __user *optval, int __user *optlen)
> +                            sockopt_t *opt)
>  {
>         int len;
>         int val, lv = sizeof(val);
> @@ -4065,8 +4066,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
>         if (level != SOL_PACKET)
>                 return -ENOPROTOOPT;
> 
> -       if (get_user(len, optlen))
> -               return -EFAULT;
> +       len = opt->optlen;
> 
>         if (len < 0)
>                 return -EINVAL;
> @@ -4115,7 +4115,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
>                         len = sizeof(int);
>                 if (len < sizeof(int))
>                         return -EINVAL;
> -               if (copy_from_user(&val, optval, len))
> +               if (copy_from_iter(&val, len, &opt->iter_in) != len)
>                         return -EFAULT;
>                 switch (val) {
>                 case TPACKET_V1:
> @@ -4171,9 +4171,8 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
> 
>         if (len > lv)
>                 len = lv;
> -       if (put_user(len, optlen))
> -               return -EFAULT;
> -       if (copy_to_user(optval, data, len))
> +       opt->optlen = len;
> +       if (copy_to_iter(data, len, &opt->iter_out) != len)
>                 return -EFAULT;
>         return 0;
> 
> This is not fully tested yet, but, in case you want to see how this looks like
> so far, I have it in https://github.com/leitao/linux/tree/b4/getsockopt_v3.
> 
> I will submit a newer version after I am done with the testing.
> 
> Thanks for the insights,
> --breno

LGTM, thanks!
