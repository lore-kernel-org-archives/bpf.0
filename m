Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AC417BE7
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052992; cv=none; b=JuTaAxVZ1ERhxMTk40Ff8ODPnTypj3/Pff9ZIJjisB2igG1+/PdbciXdN4rw9Ol1RPkfaSjuZMaEk3FcHr4VzisqkH+O6g3J4p0kNnv3yYWScaNWwLaxmM/aUNxu0LZGYbZaZXr4QO66WjOyoVLExELCD9KPafNf8OoDEfICu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052992; c=relaxed/simple;
	bh=hIljgCSsXh/p3svvug1v/D+MXs0XzrFD1w8GnaxDtyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDARLJ6Sje/BSrK3gx2LMhr0KCtSpFaVLSf8pml0/Tiunp/6U3fO0krbemLKKwhESQMPE4PPBt2znhoSPDkUh0630tsNqcVOorqBg4vrhn2fUMPdEyHXyaPnQ7TsSFJXQUPY0N5NEd3HtzDmcLIwls/j4X0JpIz+h38F8gzjCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sleFoFWb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sleFoFWb"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8487088510aso4547065b3a.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784052991; x=1784657791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M4ANFsp313QLwA+WwxkhGeYupYp6HRdxaXxq16sMgtc=;
        b=sleFoFWb7ETHm38xuc7giMYC8Lo2aCa11qJD4pyY4nmVtjoJcit9FnckPHTr0AgEOV
         Ly44UDuIxX5B7eYt2WF2eHOdJBgEi4hlE2TID7vh/ra73s4BXNtNizlEFULiFaTuJ7u9
         kcn9VbtPOZAWNi3behDCcQ/eGttTHmqtnD/9+NC4EB2a8XyY/XgK2foamfEBPAxjwUbG
         hBkPKoqqoFSa+Q4xvyggWca/ZExAeSni/ieqQWuuGBzHM5tzX9ia1NsmVcx5Sd8UuMGl
         hDdSw5Ry6mH+9OkQR5QQYwe0LKRtB20wUQotrn5fF7EfvKhPaADKku4QGWV1PPQgyitj
         yW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052991; x=1784657791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4ANFsp313QLwA+WwxkhGeYupYp6HRdxaXxq16sMgtc=;
        b=QyfrfBqqJxu0s2P2eCa+2H9NrvT5ffrV21BA3gzakGOavW8pNnvZCPEhG8zVDvlnvq
         14/uKCgECCoYx58xcUGoMZwDMqqEDiPiBQntNKWLZLNTbnLriRlTlBV2ANI4mAKGAVhQ
         QvaH+Jdwe6UESpgJG2oFaiNQrQ36yjp3CsdCjIfVkpFv0eGF3E0x/A7bE0klZw+4w2lC
         3c7l8gxhYwM27/JYMMr6BvrYJsyST/JbwTRjhf4gvqEUyONSpX0KvIOAch39Jg54ooU1
         NRtR5z8v52EzKSaAywfd3THRvd9q2iqmgs7zJt35b02DLflCy7fM/AjZ7YUa04RckwlB
         bV1g==
X-Forwarded-Encrypted: i=1; AHgh+RpGn0e16m3MhKMIt5q7YSKl7UR8rGlcXkvNH5c2JwoqBWe7owpu9KCIRgauQTDYaoivfsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJYHyt+h7y8Krukum7fWezLa233BtnIS8lblMKARmxrZ/idH6
	5J2UQWXm9I23QJMxXGni/jCH4dT0iP+qFqYioky0WnlGYJj/4Xxxuy9i
X-Gm-Gg: AfdE7cmyclm9J1m71uO9ZA9qO9DXlgcHbSYVntKE4pz6VP1fwqikFCIOmI9cdP467pa
	Kb+8S1iraKvLI0NAGdLUS05b+tYC37XEnyNd735qe+KyY97C0tYN4jxXvPNZp+3idSDH72uMJQo
	PgF7kTGrQC85ZsQpZVpZFnEWyluPb9obfh6lqrORRKMCm6R3AXcv2MDiKd/cGSq3sJ+AuzT/j7/
	cQKIkuu1vvJIRyfp1zLjxyZQ3SD2j1k2xx6CBesG3J/UQdqwm3JKdlURawUZ4WwLgz8+JNai7Fy
	X7195OW9SqaA0pfkKCp/6Vq5J88G9gp/X3iu7SXTNVmD6F5OWAt6nefJKs71WT2kA9WYsrWBRpK
	Tx4OPVqczSk4aDpzqWl+kyRt95Wi6UqoPJ3kv/XFe9nK+9jCiv0IR+G7+LnrLdrSDnu8nD3KCnI
	g9MiluaDXnsTTwx2rcZy2E
X-Received: by 2002:a05:6a00:4fc6:b0:848:7cbc:7a0e with SMTP id d2e1a72fcca58-84a5140f2e9mr4300084b3a.11.1784052990589;
        Tue, 14 Jul 2026 11:16:30 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bfbc3sm1855945b3a.33.2026.07.14.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:16:29 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:16:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Nnamdi Onyeyiri <nnamdio@gmail.com>
Cc: nnamdi.onyeyiri@squarepoint-capital.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, edumazet@google.com, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data()
 causing unexpected EAGAIN in recvfrom()
Message-ID: <alZ8nmJlkhguOG5v@john-p8>
References: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ak_rR-Skd8Mvn4mH@localhost.localdomain>

On Thu, Jul 09, 2026 at 07:43:56PM +0100, Nnamdi Onyeyiri wrote:
>Hi,
>
>We've encounted what appears to be a bug with bpf when invoking recvfrom() on
>an ipv4 tcp socket that has been added to a sockmap.  It results in unexpected
>EAGAIN errors, that we've diagnosed as the result of spurious wakeups from
>tcp_msg_wait_data().
>
>This has been confirmed to still be present on the mainline kernel, and I have
>written a reproducer at: https://github.com/Nnamdi/recvfrom_sockmap_eagain/
>
>Attched is a patch that we found resolved this using kpatch locally.  It just
>causes spurious wakups to go round the loop again.  I'd like to get a sense of
>whether this is expected behaviour, or really is a bug, in which case, is this
>the correct fix?

If its breaking/changing applications I think its a bug. Can you submit
the patch below? We had something similar with ioctl FIONREAD behavior
as well that was recently fixed.

Thanks,
John

>
>Thanks,
>Nnamdi.
>
>----8<----
>From 0e0c342363b2e435297ab1feda402cde6ad54525 Mon Sep 17 00:00:00 2001
>From: Nnamdi Onyeyiri <nnamdio@gmail.com>
>Date: Thu, 9 Jul 2026 13:06:33 +0100
>Subject: [PATCH] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
>
>recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
>when they have a receive timeout configured.  however, adding a blocking
>ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
>sporadically.
>
>this happens when tcp_msg_wait_data() wakes spuriously (returning 0) in which
>case, if no receive timeout is configured, we loop again instead of returning
>-EAGAIN.
>
>Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
>---
> net/ipv4/tcp_bpf.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>index cc0bd73f3..38fd391ff 100644
>--- a/net/ipv4/tcp_bpf.c
>+++ b/net/ipv4/tcp_bpf.c
>@@ -317,6 +317,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> 		}
> 		if (data && !sk_psock_queue_empty(psock))
> 			goto msg_bytes_ready;
>+		if (!data && timeo == MAX_SCHEDULE_TIMEOUT)
>+			goto msg_bytes_ready;
> 		copied = -EAGAIN;
> 	}
> out:
>@@ -390,6 +392,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 			sk_psock_put(sk, psock);
> 			return tcp_recvmsg(sk, msg, len, flags);
> 		}
>+		if (!data && timeo == MAX_SCHEDULE_TIMEOUT)
>+			goto msg_bytes_ready;
> 		copied = -EAGAIN;
> 	}
> 	ret = copied;
>-- 
>2.52.0
>
