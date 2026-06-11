Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844942DFEF
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195337; cv=none; b=MuBCECx/pFTPiFNv/spXExXquIy96u68qzBZimO82EI9PZxAsfveUfArnyNvJwLa56J2zfv8Ud2pfChiRsq1zThpFN32eh/m83HEJ70TMe0UhAbA/+RlAKE/RJ/ELImf9kbSaMNdt5PwTtdfCAnurHLjpPBRMu9IreD9emTGJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195337; c=relaxed/simple;
	bh=Dq8U4JeMLdDJZCai9rkKpCchuv1uUA+lqZN3PGfqBIk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QfUi92R/TYvHp/qccIUQjvnzQCJpHU1MFy88Ky1n9GjmuN5gMkgQUyPb3ldAulwe1SEw4bKVx7p2m06XzPG2gGTjWEnj6HkD6TcUl+16/OkgNRNMa/qsC/EvGer81QP3wpWSXCK5iQ5OaC/6ZXPGqDGkObMFiSQExEneMxikq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gO86XJ5l; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gO86XJ5l"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3074adb8fcaso173426eec.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781195336; x=1781800136; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmILQTIhg4C2xaf23uaTPKYf63Qsqb45amOoW42QXJM=;
        b=gO86XJ5lX2WhRMfkazLeKXLf7wv1CkXPx9mPNdIgUvnRG0+aMS1WTVPTkSFyz2/uju
         f+dl+CDOeVOGYozPh+AO0+g+AgA2I7Wj8aG25z9PsB5fyPphzH2PzL8g7p25qK12h4XW
         RE1fBgpAck3lEoD+tHqqnHXIFLFe91oecgiTgsV3/5L8YMOhIhmK+3xqnQ5wyeTr6DNp
         NveThIDMWV2oQieMoMTS/P4+oOR4X/CFU0JecME9HoQLWnVGGNzexXvEn+NmYX+57mMD
         8/SRfSGfQ2vSlSUKCnOoHLyi5Jb8wCP3EWlntz/vDnyKTNzvb+FWamw5uieCRTuHLSlo
         G9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195336; x=1781800136;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmILQTIhg4C2xaf23uaTPKYf63Qsqb45amOoW42QXJM=;
        b=BWXYg36kZGU/CFERvrUzUjDlviXDcw3/bYOv3kE/Zg8NSvIWhPEFirn7S5AbVIHgu/
         ipP+/nDWfdesrBRKMu/z9+599yZcXi1Dxbv8fDMPqyryz1fkSbUrZnHTs+4g+rHbd7ga
         /eKUXMZ3jI98B/y1PfB+tG0FB7Qd+2zjJl+rYn9KhLpjgzvZ8GcEPHeusVYBMh5/Bm+f
         wYdlDtYEyiQH8HU6fOiTWp5gix1gY102gbxgvfkfo8U9Jx/c81l7VVO1OjZ7VYdbj5WF
         52AYvMKwpsuetXq6MOnSs5grUYMLEkKwgbaDVhK1BLga+z3CDFr6AWfM6xsEMmSxePBT
         p26g==
X-Forwarded-Encrypted: i=1; AFNElJ+LJFyCN+7lLlQe0EgyTWjqFHzDjkW119AxP2IcNGBMc3q2pWV5KsP1rMJsjQgnntQIeQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHRCkHDfA2qhn7pF79GroBgRePIbCnBmTIwTGN+4Oh4JkPU9D
	CuHqnGTuV4VB8H8xpsxbDE20naph1xe+zOztJR3lxESMF3q8HmcXuZAdbosUNi0DSfQ=
X-Gm-Gg: Acq92OFFUPSpWvpi4mdbfUh6hVbmF5ra83BiSq0T3+iQBF8XI2BDdnFG+ebBwRo+w6n
	2pRPSL9wJbTfMKsfwNMROYX1lgE0lpvChnZI8xZoiL/wgACdSp90u/2vZoJyAabPKYZ4ppcC0rP
	h49ZAtRP8CPGbOfT9+1lMqlQzou7dvBVhwYW9Q2MASF4TYfuBd0eU+6KNwbh6hflnlRTRe6yRYp
	/HThnt4tJ2U56q4HegfvIDGg98tXPL/cmsdj4W1XOs+wrgzig3h4szmy7or5jb5Fklpnhm2lUmk
	zHRD3TnKvCuYDPTsvRh/xSepphjpop9tjnO2JyOI7YVFLstEYE3DMA1ddUZWZRuNEfbeLRPbzwP
	pSuRoAk2l4jnEdBVhHnOBHv7mI1e0InMati8ADXO0jZCmkBFusMC0QYHdOfcjUYwsz9dzmYZYJ5
	FqoYjIsyGQZWqscRM=
X-Received: by 2002:a05:7301:1292:b0:2fc:9ae6:e5a8 with SMTP id 5a478bee46e88-308049eb931mr2752590eec.20.1781195335328;
        Thu, 11 Jun 2026 09:28:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9f35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c47afbsm3701418eec.10.2026.06.11.09.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 12:28:51 -0400
Message-Id: <DJ6D1R10KDES.B0BC2FOSLNCH@etsalapatis.com>
Cc: "Weiming Shi" <bestswngs@gmail.com>, "Xiang Mei" <xmei5@asu.edu>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Shuah Khan" <shuah@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "Sechang Lim" <rhkrqnwk98@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Cong Wang" <cong.wang@bytedance.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/7] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-3-jiayuan.chen@linux.dev>

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Weiming Shi <bestswngs@gmail.com>
>
> When bpf_msg_push_data() splits a scatterlist element into head and
> tail, the tail's page offset is advanced by `start` (absolute message
> byte offset) instead of `start - offset` (byte position within the
> element). This makes rsge.offset overshoot by `offset` bytes, pointing
> to the wrong location within the page or beyond its boundary. Consumers
> of the corrupted entry either silently read wrong data or trigger an
> out-of-bounds access.
>
>  BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:=
2728)
>  Read of size 32752 at addr ffff8881042f0010 by task poc/130
>  Call Trace:
>   __asan_memcpy (mm/kasan/shadow.c:105)
>   bpf_msg_pull_data (net/core/filter.c:2728)
>   bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
>   sk_psock_msg_verdict (net/core/skmsg.c:934)
>   tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
>   sock_sendmsg_nosec (net/socket.c:727)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> To sashiko:
>
> Regarding bpf_msg_push_data() reading "copy =3D msg->sg.data[i].length" w=
ith
> i =3D=3D msg->sg.end (appending at the very end of a full/near-full ring)=
:
>
> This is pre-existing code, not touched by this series, and reproducing it=
 needs
> a narrow combination -- a pure append at the end so the loop exits with
> i =3D=3D msg->sg.end, a full/near-full ring, plus a prior push/pop histor=
y that
> leaves a stale length in the otherwise-unused end slot. A freshly built r=
ing
> zeroes that slot, so copy stays 0. We don't consider it practically repro=
ducible.
>
> Even then it's already covered: the overflow check in patch 1 ("copy + le=
n <
> copy") rejects the dangerous case, and __GFP_ZERO in patch 3 prevents any=
 data
> exposure. Not worth fixing here.
> ---
>  net/core/filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3c8f1cedb217f..3e555f276ba80 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2872,7 +2872,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
> =20
>  		psge->length =3D start - offset;
>  		rsge.length -=3D psge->length;
> -		rsge.offset +=3D start;
> +		rsge.offset +=3D start - offset;
> =20
>  		sk_msg_iter_var_next(i);
>  		sg_unmark_end(psge);

