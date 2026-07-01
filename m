Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40C397B05
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943354; cv=none; b=mMiknT9oDIz1lcDImvJHX+D67bTEx9yxxLZsZjjZRXA2iqc1uPIZN0tuoJgXj4lNbUsZLcrieki5NuXVInViyVwnKEkWmE3YedqJo0lWmL/XyDgSgPJZTLdsQm5ZTofqzpipC2Vqe/CUIDtj9aGMqsE9kwHgBhI5sSvRyOT8akE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943354; c=relaxed/simple;
	bh=eVypLHVgpYs6tf8E01MUjLp5Ab/fWW4yiCILeVsBp1U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=uM3ya8VzlahV6nJ9hw5CZzMuJjiCWx2ytCZAm2Brmt3actQph2PDVchPi+sh3itRk09Iiv2YUBo+Z2eakq0UkYCOqhHAeq6LsQ1cUDgeXTtiJK480D3Uz60tyC2Q2xveB2iFkamTpS4W5Hnhh0TgA1WH23W1CCdxALEHeNtKE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qTzrZfzH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qTzrZfzH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6a434cabso64073385a.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782943352; x=1783548152; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLVtzWFR2dQSLkUs2HwYG25dqTS2FGwULXJdwvU+iBE=;
        b=qTzrZfzHbaUJEWLCbu/VcXgWvZONswmngMnxBrt2qS/5ZcPbLb3JmW0K/35U2V0P8l
         N8MI2n/fxVrSvevTD743mxXzeoNOj15iOHQYKrm+XnzVMN5tKQC2VPWiOTxHFzhVKdiN
         rSg2UcD996fuKUzSuKkl/fqw5wSeu/InHrvPUei3F4YAcwOZRM4wCaNSb7eAAjukpzAr
         KLLGBudhzj+MnJEEzS9TiVu4dPZE6yYYIFgDmxs2tznBHOHpDpjm5cYjRmDdk6j/nys4
         3/XA0qvld6PK7DkEhyIwYBahij8c4/byMOUf/PS/GMl1yjH/175U4mIAHfzoxsceCOga
         0XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943352; x=1783548152;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLVtzWFR2dQSLkUs2HwYG25dqTS2FGwULXJdwvU+iBE=;
        b=lKzyITE5o35AjWTHA5Z6PL2v468f/A3pzyRuXYUxHITsSXmMDg3eni+HPfa916r2Si
         PZnY/LGMRgw4zRpmC5CUNLSXDRrN+fDoAURZ/i/yvoMBklJZECQD930rAB0nCIF8sTnI
         ejgLspM16D4W7iXtq0Zi0VCILtZSg2Em+VTervV5BQBH/7JQRVGKRe3F8tvPUTYSkRY/
         KE0KpUn7MrMkCFPd2hAc0mxFBiYswVjyHl7+dZVvfyI5bZbtk61v+gafm5xIOj+juPOY
         cqPBX7jDmHXzVCIztzZuM0aNOZtendwQM1UwVC+XyKutkD+9oMOFFXnuEcaAjmSCoOlX
         xHGw==
X-Forwarded-Encrypted: i=1; AFNElJ9KngsgkJHJaMyyTyOJh62J9YfYJrti0ePqP+HhktmjbB4tfJ6heeNMyc73UCpyr+WTDGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNE9rKFd3avbgp86HJM0fKxurvLLeOYynzmdEyZvl7wlbvSx3w
	ns/MEV94IOBH3vcYKKgQ5ImSW2TWzz+jSVvRpueVCF2bvdOJMk9jWnYZ2uJVVwaXbQk=
X-Gm-Gg: AfdE7ck9VNxK6cGT9gVk3by9C0xS4Ly6sx47npz4C79kFNcW797XK1sLaIg06bgiRRz
	Mjp8wJsVvgVm22cxiEzjA7Rrt3xx+n0rI/w+bWgdMvVrlTePQuVg1ncPBpWK1adY7Yrz50jYxEj
	c4Mn/J/r42p2WY3pM59YktMyioieTaq/eU9sSpF1s1X33AYjaiEIXmIRKdUZ8sOpRSuXGSbloOV
	sT+cm5OcAyd/3c+umGKzgPEtRUX8pa7Ou2mlg7PVuD+voy49fhA8i3N8e4unPSEwlnXrAUQgN8T
	gvsnVWd4bZ9XCIS2ZsC2Qj0vaU2ux4MojZLWR0MhqDGjR/gcuiBBA/rPIQoNFEsDaXKNaomUflP
	b1KscFK2pCdmu/DOd5vRtZYWrN8kYP8wL29JR023tuRC+HU6DfQpxutGXIS/TVgqi+TrRpsx1GB
	r4AUNFXEaIBsc=
X-Received: by 2002:a05:620a:4489:b0:92e:5fe2:fd35 with SMTP id af79cd13be357-92e7b368d85mr406755685a.32.1782943351824;
        Wed, 01 Jul 2026 15:02:31 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80162220sm58215185a.25.2026.07.01.15.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 15:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 18:02:29 -0400
Message-Id: <DJNKO3H4C8CK.YM204DS9PVSN@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Varun R
 Mallya" <varunrmallya@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf, sockmap: disallow update and
 delete from tc, xdp, socket_filter and flow_dissector
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-2-rhkrqnwk98@gmail.com>
In-Reply-To: <20260630145410.3648099-2-rhkrqnwk98@gmail.com>

On Tue Jun 30, 2026 at 10:54 AM EDT, Sechang Lim wrote:
> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
> sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
> write. That gives the order stab->lock -> sk_callback_lock.
>
> The reverse order comes from the SK_SKB stream parser.
> sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
> verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
> __tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
> deletes from the sockmap and takes stab->lock:
>
>   WARNING: possible circular locking dependency detected
>   ------------------------------------------------------
>   syz.9.8824 is trying to acquire lock:
>   (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:42=
1
>   but task is already holding lock:
>   (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skms=
g.c:1173
>
>   -> #1 (clock-AF_INET){++.-}-{3:3}:
>          _raw_write_lock_bh
>          sock_map_del_link net/core/sock_map.c:167
>          sock_map_unref net/core/sock_map.c:184
>          sock_map_update_common net/core/sock_map.c:509
>          sock_map_update_elem_sys net/core/sock_map.c:588
>          map_update_elem kernel/bpf/syscall.c:1805
>
>   -> #0 (&stab->lock){+.-.}-{3:3}:
>          _raw_spin_lock_bh
>          __sock_map_delete net/core/sock_map.c:421
>          sock_map_delete_elem net/core/sock_map.c:452
>          bpf_prog_06044d24140080b6
>          tcx_run net/core/dev.c:4451
>          sch_handle_egress net/core/dev.c:4541
>          __dev_queue_xmit net/core/dev.c:4808
>          ...
>          tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>          strp_data_ready net/strparser/strparser.c:402
>          sk_psock_strp_data_ready net/core/skmsg.c:1174
>          tcp_data_queue net/ipv4/tcp_input.c:5661
>
>   Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>     rlock(clock-AF_INET);
>                                  lock(&stab->lock);
>                                  lock(clock-AF_INET);
>     lock(&stab->lock);
>
>    *** DEADLOCK ***
>
> A tc, xdp, socket_filter or flow_dissector program has no reason to
> update or delete a sockmap, and redirect does not go through here. Drop
> them from may_update_sockmap() so the verifier rejects it. It also
> closes the matching sockhash inversion.
>
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/verifier.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271cd0..83ea3b33ff67 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8488,12 +8488,7 @@ static bool may_update_sockmap(struct bpf_verifier=
_env *env, int func_id)
>  		if (func_id =3D=3D BPF_FUNC_map_delete_elem)
>  			return true;
>  		break;
> -	case BPF_PROG_TYPE_SOCKET_FILTER:
> -	case BPF_PROG_TYPE_SCHED_CLS:
> -	case BPF_PROG_TYPE_SCHED_ACT:
> -	case BPF_PROG_TYPE_XDP:
>  	case BPF_PROG_TYPE_SK_REUSEPORT:
> -	case BPF_PROG_TYPE_FLOW_DISSECTOR:
>  	case BPF_PROG_TYPE_SK_LOOKUP:
>  		return true;
>  	default:

