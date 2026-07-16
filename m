Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D322D47E9
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784242885; cv=none; b=ugr1f3/HuxkXK6JV/8AwyA+rgdU90LoEGq5ZpZFRKM1R1Tg/FnGWfSyMI8X8dLwn1OQj09w9pvegajws9DhgMXBTZ7ipqUkrMj4BX+ICNHk54NMb7H+axrEKN5Y2pkhD9gzAXb9Kt3wq1ronAvl82EkiraNlblLIYqB6QXfhdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784242885; c=relaxed/simple;
	bh=bDX3+wffRV7PxmPLycy16u9ynIhU07YpqI3xFHl2iAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7C1xDKV2jY+PwdqO1oxhHGLXP9mzElFIkA5E0PYz9B7B9JW3TBDpASLsrnuF/8busY/5GXuMfJs1Cc2zw+UzUz96hzFIv1wRbuDEAIURhNnaoMJvLpWZnuq9EMqn8qWEtI9v2bkVwBwXI4EAWTu91/VDpZ2Pj8YjGv88T4XBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=Wwv/aH5t; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="Wwv/aH5t"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a6f026675so354647b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1784242883; x=1784847683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wyGjYfYZ0w+7WbZ59KK/1C1iYXN2+xrcuEWLzFLAWmA=;
        b=Wwv/aH5tNEB65gqsWcnD+jgaMxsUkcc9qexD913PMY2MbtcaoQSuvNfdMkVLYfFzF7
         Crx3cmwfUQSTlQhrHBR7ofHxXY6fwRZxjiOwXeZ9NoWjSqqJ7FdgTEYcuTXZAxnhXXeY
         ktDRI0Z+Oqr/TqY7k9JabXAAFCp1NBqZTXkskQJL6cPOvBbBCkigwkUA906/xuKoqQpq
         Deqi2xxNdY3B89lGlMa2nH0ZyAftAlXjWsGuBekQcYdxhtTbqoOpwrp06g7r4IFapb4s
         lc8QyB4JhDSrBwBB7SyIZJchMesaM+1DJQMOrIfZnbwAswg0LNgq24wQ+JeoJUsK15S6
         7vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784242883; x=1784847683;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wyGjYfYZ0w+7WbZ59KK/1C1iYXN2+xrcuEWLzFLAWmA=;
        b=kRitUvNHKYEbml0NV5xeyGsRILJeaAYqnW04tR0VEhPzIag4InL6Qscz7wVlrkAw2E
         Ni8ahjOP+8MA3BQ0qynO8RjI3TU6oeNNb8Ym+Z92/CeBFVBbRg7YOh4uJM68AFkEBCrA
         KGgxNPzKZXY1acVhc1ycICP5+WStuxzk3TEa6R07WijQ4XTvXMHm8tAhH2rebmgm0R6c
         cVR9xDQp4S89X4NX1A8m8Ych9DHDzOmBCGd6gH2EnIjPuB2BZ4FOVRun9ol67VSHW6oe
         S0+6CLpbtunclaiQDVmK3MC5vd3HeYzrO97H/GRcxKy1kmm+ZL67qunqCMofqZyjrvDK
         tk9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqOjPYXM75ERR/1l5putQ21P4535VKk+cUOr6qdAMK6p74KRDsYWDrPWgRTq6tzpFADf7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3LK9fv7A5Or9V0ueZoEr1dhEsZ7Eam1O8luVZsdMySXS5+Zo
	uyvndZev0MiNoIQrFo6RF1nz8VqoIU2XPvMmKyrmPUzMiUWOwoS1SU3/EvS0J9fPnJg=
X-Gm-Gg: AfdE7ck9FTreJBRH/wrW2eQtI7BiQtzVwb5gjWmRA9QzQRObu7XZWaKLs3WTEGGOOZx
	xW/h2GJlAt+zIw+9YZn/p7xUndSV8sVU84I1XwrWVf9CBjv5RtlL7xorzRR5xjgAyrEQpSeSwd0
	PWWeWmt1FIMfe9073yoIpxXb03Cs/D9jpxwrquX98CAP5XCP//z1hrGECJysMp+EpgbUZsOzpK1
	H5wsoim1aHThMwA+YtJCiaGA53XRZHGu8EQixFh1Kn8ZaDxailQec1ivr7eT1JSHgQoSU6lsl/o
	Rb06AoaXOUPgSxSEkrto6yQo21Akz4q5hkIyatL+L/guqdPcRsQVqTRuGpPJrUef0cbzlXZLbbh
	Mcaz8LE5YFvEMIsRlYN0/HJMOqOO3u4hZp9fmeoD9iTl9Ynhda7l+/0vfRdhKaA==
X-Received: by 2002:a17:90b:5588:b0:381:cef1:11b2 with SMTP id 98e67ed59e1d1-38e4b550a72mr37011a91.7.1784242882764;
        Thu, 16 Jul 2026 16:01:22 -0700 (PDT)
Received: from t14 ([2001:5a8:47ec:d700:5ca:1606:20e7:441d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd42b2c0bsm13474872c88.8.2026.07.16.16.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 16:01:22 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:01:20 -0700
From: Jordan Rife <jordan@jrife.io>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net] bpf: tcp: fix double sock release on batch realloc
Message-ID: <2shuri6mxofmo7ijmzb5frge3gc72n5p25ksoobdunlqlbfs2g@rprbuqbs6vhu>
References: <20260713233230.3553593-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713233230.3553593-1-xmei5@asu.edu>

On Mon, Jul 13, 2026 at 11:32:30PM +0000, Xiang Mei (Microsoft) wrote:
> bpf_iter_tcp_batch() releases the current batch via
> bpf_iter_tcp_put_batch(), which drops the socket refs and rewrites
> each slot with the socket cookie, then grows the batch. cur_sk/end_sk
> are kept for bpf_iter_tcp_resume(), but on realloc failure the function
> returns ERR_PTR() before resume runs, leaving cur_sk < end_sk over
> slots that now hold cookies rather than sock pointers.
> bpf_iter_tcp_seq_stop() then calls bpf_iter_tcp_put_batch() again and
> dereferences a cookie as a struct sock.
> 
> Empty the batch on the failure path so stop() does not release it
> again. The sockets were already freed by the first
> bpf_iter_tcp_put_batch(), so nothing leaks, and a later read() rescans

Since bpf_iter_tcp_batch returns an ERR_PTR in this case iteration
wouldn't continue on a subsequent read, but otherwise the fix makes
sense to me.

> the bucket from the start instead of skipping it. The sibling
> GFP_NOWAIT failure path still holds real socket references and is left
> for stop() to release.
> 
>   BUG: KASAN: null-ptr-deref in __sock_gen_cookie
>   Read of size 8 at addr 0000000000000059 by task exploit
>    ...
>    __sock_gen_cookie (net/core/sock_diag.c:28)
>    bpf_iter_tcp_put_batch (net/ipv4/tcp_ipv4.c:2918)
>    bpf_iter_tcp_seq_stop (net/ipv4/tcp_ipv4.c:3270)
>    bpf_seq_read (kernel/bpf/bpf_iter.c:205)
>    vfs_read (fs/read_write.c:572)
>    ksys_read (fs/read_write.c:716)
>    do_syscall_64
>    entry_SYSCALL_64_after_hwframe
>   Kernel panic - not syncing: Fatal exception
> 
> Fixes: cdec67a489d4 ("bpf: tcp: Make sure iter->batch always contains a full bucket snapshot")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  net/ipv4/tcp_ipv4.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 209ef7522508..dd3ed62704f9 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3141,8 +3141,11 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
>  	bpf_iter_tcp_put_batch(iter);
>  	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
>  					 GFP_USER);
> -	if (err)
> +	if (err) {
> +		iter->cur_sk = 0;
> +		iter->end_sk = 0;
>  		return ERR_PTR(err);
> +	}
>  
>  	sk = bpf_iter_tcp_resume(seq);
>  	if (!sk)
> -- 
> 2.43.0
> 

Reviewed-by: Jordan Rife <jordan@jrife.io>
