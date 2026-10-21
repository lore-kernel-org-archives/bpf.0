Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551887;
	b=D0+Bg2goRYL5D0lBayOA3ze1uYKvThOmEP55dz+BEPvezY25/rPNlGnyDxbk+k+inmYF
	 1V7eRgU3IxdVA6yOombe5zluxdJbquQxNpVXyQn+mtW+2QeN5wSDQk0jCg5IzID4oTTuT
	 JEjxLd13ghO1DZBIwHCzMRF/yBFv8zsZjAHmYV7V0G/bBzaPwm3PD7Bj2YREpajp1BnNI
	 ccBrmVibmFKh6zOisljIr/EhrnBiUjXMGRQt8BuqwVQsimCl1RTzEm89ASk4HyooDWNbm
	 Uny0QGHfys9uAS1TRJXGLZdnysPN2juC5xmTSynzGs4xcCFTY0LBrOQ8gt199xfgegg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To;
	bh=rc5wrhUHr1AVoBfBDZ+r5qvZgVrRLeIPWk5f/ArMKLg=;
	b=shVKecGx5PuSVcJeZQqDGz5V8KHq2CgZorfT+BuamSj5SyA6m4zG9VcioX90Wv0b1rPQ
	 /M6r862VLpaKi8YD8ksoPs3GxH3Lvh0DHAEPmX2uDU7aBWsIEPKB/LtjsxseQCpQvY4+x
	 rruOvGFvUXkWNrE8r12asBzHJ+N6oakUdQmUGbU1bjU9ESEa1SIw+lHmSyCOWp/hL4YMw
	 3oDrJ6vU7JqB9xnBdXt4I9vieWGmacwi3TGrKdl46tr89ElERoRyHTcKdRedqUpuwoNkA
	 AcU1UxOKwnVmSa3Db+HL4umJDmRbAtsquwe0WIAxZ8khEXtbeQowrxJTbreySZIek8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PuGDi+yC;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DDD606A31C
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 03:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47DDD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PuGDi+yC
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso132537a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792551887; x=1793156687; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rc5wrhUHr1AVoBfBDZ+r5qvZgVrRLeIPWk5f/ArMKLg=;
        b=PuGDi+yC/qP1bGcg/TSJFrSAOJewAE8/w32VXn0pviJ9BU1AXHc+a3rPhPUuvSfVDm
         JR7tpDlII85BMuy9n3vyR4guPVqaMo0FxWhPE9NcoUQbhXT+7mMAI4QRfLXUIcqo5/Xs
         q6j4Gd+4w4vZcM5fGQi/8qw9VONKn+ZhsJ6qLm4IGL2EXDxGcJlYXGqZxwREBl5JaE7P
         l6vYVejnVU+p2Lwy4bfhWLOkJSbW+EYU4kJGgtyAWl+a57JCZRRlZ6MXcsMGDQJtdKfX
         UIsVQLX4CpWTz8Ys24LC4PJxBQF3aDGHBsiFJYu9VBoyLLX+g3l+ljvbGnceydfkRGMe
         hbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551887; x=1793156687;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rc5wrhUHr1AVoBfBDZ+r5qvZgVrRLeIPWk5f/ArMKLg=;
        b=jaXJEEaMkWAakVVOhbSTrX96Ha0kyAOluPA963og3KmsYHQJbRYrCOOpsLA+zwxXQI
         nj/Jlal4fsGwbnVuSxbCsSfgmz2TUMUi3+F+ulfNNJZYjmYg209Gh4koXbyG6OmUroEN
         6Ihrdw/hV0WXt0ZjWUS/B+dtWGYRvkIc0LIzUG7pPQvRPPE0Nm7HGqB8jOCy1ssLTTNf
         iPirfGRZy8MHmLxNGrM/oz4V6yDbnFrngP5Rd/ClrWc+JdY1WwA6723IFwgoIvIwHERL
         1d531ObcCcMDrTceL6X7kN0+jZHRRcxGlfem7Wsk5M2ytwbzsEfZHBV5dDQg3zTqLyfA
         unbg==
X-Gm-Message-State: AFq9FYLu19KB0lZNICMs2Z42PkC/pIj16Q4LaOThXA9lCI3rHHG7IgNa
	qJduq7jstVvsHQIVbvsr0KM8UQ1lo3B4159WKYlUDRZLEyPJ0L+Ubgkg
X-Gm-Gg: AYBFou1JOA3RmaDc3u89vzAta1n1II7gAaabcl9kapGtWdPkO/GvLo7jtS2lDTmx/o+
	Yf5wczVQf0GyHQpKqFr0iuma1hH5OHkciYgRmWZLz3gWDX2KoD2m5+NifRsW4FICYE8mhjELlIL
	RPQersAe8H5OtSfs6E+2XOTz2z6WLwh2cR4ZEdMObOeADuFCK2XFmMeFlkZn+rayaEt+YgPcmHv
	/+nb2WZ/I6w3YHkW2hAdCqTfhTs0XLwnuKst81kiokPHn4IgFzbVlRdPuH9wu+bc9bm56nAPfI5
	KJHNQ5UZcLXXO+HZzrJA72y517TD4T0beKIAWUetJqzaYFhlUumWgLM8fYSROkq7WKSS7KgkQ9F
	5OFpUre8aXX+H9QemwCp7ovZNFS03RDGLx/t2vvSiYu89SLVgp2etZMMzhKdSs2kTKi+r+Qu80k
	foqQJDr5Qx6YDaFdbYcShrU6Sv/TBFGaSraBrElpDEyE0ApqqpH8oBt19VQTX9+Z/hiyVg36XHw
	hJKxFwcvT//rB72Ap6jtIBIsIysAACBh6AuhW4m5umdfpB342SkM7PNYn9ZVabueVEznHsami7w
	y10zQH84IPKxfli2/XOenKVmbs1vBW5Qy4CVX9qhrXiy/vFze11tzlW/nCf00CaURjC2vLWesfX
	ahdvshQ==
X-Received: by 2002:a17:90b:288e:b0:3ac:2788:cab1 with SMTP id 98e67ed59e1d1-3ad86ed22f9mr629222a91.30.1792551886548;
        Tue, 20 Oct 2026 20:04:46 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8035883bsm1999788a91.15.2026.10.20.20.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:04:45 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 03:04:44 +0000
Message-Id: <DMA6LZFMAQ3X.2YOXSMADL3LQ5@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Add syscall common attrs support
 for xdp link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Leon Hwang" <leon.hwang@linux.dev>
Cc: <bpf@vger.kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Hangbin Liu"
 <liuhangbin@gmail.com>, "Martin Karsten" <mkarsten@uwaterloo.ca>, "Masashi
 Honma" <masashi.honma@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261020152804.39863-1-leon.hwang@linux.dev>
 <20261020152804.39863-3-leon.hwang@linux.dev>
 <20261020182553.534c8d6e@kernel.org>
In-Reply-To: <20261020182553.534c8d6e@kernel.org>

On Wed Oct 21, 2026 at 1:25 AM UTC, Jakub Kicinski wrote:
> On Tue, 20 Oct 2026 23:28:00 +0800 Leon Hwang wrote:
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -97,6 +97,7 @@
>>  #include <linux/kthread.h>
>>  #include <linux/bpf.h>
>>  #include <linux/bpf_trace.h>
>> +#include <linux/bpf_verifier.h>
>>  #include <net/net_namespace.h>
>>  #include <net/sock.h>
>>  #include <net/busy_poll.h>
>> @@ -10771,7 +10772,8 @@ static const struct bpf_link_ops bpf_xdp_link_lo=
ps =3D {
>>  	.update_prog =3D bpf_xdp_link_update,
>>  };
>> =20
>> -int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og)
>> +int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og,
>> +			struct bpf_verifier_log *log)
>>  {
>>  	struct net *net =3D current->nsproxy->net_ns;
>>  	struct bpf_link_primer link_primer;
>> @@ -10784,6 +10786,7 @@ int bpf_xdp_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
>>  	dev =3D dev_get_by_index(net, attr->link_create.target_ifindex);
>>  	if (!dev) {
>>  		rtnl_unlock();
>> +		bpf_log(log, "Invalid target_ifindex.\n");
>>  		return -EINVAL;
>>  	}
>> =20
>> @@ -10812,6 +10815,8 @@ int bpf_xdp_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
>>  	if (err) {
>>  		link->dev =3D NULL;
>>  		bpf_link_cleanup(&link_primer);
>> +		if (extack._msg)
>> +			bpf_log(log, "%s\n", extack._msg);
>>  		trace_bpf_xdp_link_attach_failed(extack._msg);
>>  		goto out_put_dev;
>>  	}
>
> No, this is silly. We shouldn't be spreading bpf_verifier.h includes
> around, and making core networking code use bpf_log().
>
> Add an extack to this API and for the extack -> bpf_log() conversion
> in the caller or some "boundary crossing" helper.

Tnis will be a trivial refactor in the follow up.

