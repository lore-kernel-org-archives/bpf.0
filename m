Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245072C11E4
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940348; cv=none; b=kpeMpNFR4iHazwkSEbAesiP4FLh5fZ6DHchZrdSiO/FN9/M6vnmGwrUeyG8JIklQwmrBg+e9fff9vqnDzKM9/GRW5TEqezmJstl3gLa0WPTdiCVphIxsHWyqmrmh9YmkmwFovOZVdFAeBiKuXJL6aUFtWTC1Hd7grUhhpv7uAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940348; c=relaxed/simple;
	bh=PhWu0asTybkDcO/nIytv29/vVGV777oc+iv+YZCX3Po=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VpUO3izObqEcW9pLoBYLra3PKZf1AoJl2jwpiFllceylH55aSAFLToNQySJODhwjerngHbKKUGthgFKrJFDpKciOse+0kLggRD9OSbvL39QMu46vSHUVcV9WxGvnCN0N1KMRL6JTaI5rwS2Suk/4BBKYv+UjGAe/eIajQG/yRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SwZgnm1t; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SwZgnm1t"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfbe05683so6930511cf.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782940346; x=1783545146; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ugCTwUEiFWSOAAZ9ZKycXOr74BRTGYQOGuhcwzpQp4=;
        b=SwZgnm1tgjFNxo71Eue/RFSsHyXq3hPx14AyQX0VUjI4dXZF4r3HZYh4difEpEgD3v
         Klr0/hMYwH+nvH6ZZynZB268vrAmHi0v3/mLoHiJm5Q/bSFVteJnqnbbePryaYvTcwrc
         Eu7vWzKHWa8jXS5REikkFPf1SQtaPtpY+4JcQn2yg/RarcCO96o/x6+/g5Ahy/2nzB3i
         mhuam+HAAFE1kEfFz7+hFXwjAFd082DpimT/bW8xoZj8V5Dwaz2limMOKLUcOisv6WxS
         wp2UprUB6lZaUDGBAEeC4ez0amVd1x4K48QUa212AQDTvllZYbB5lzEzFqavaIh8zpKy
         Fnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940346; x=1783545146;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ugCTwUEiFWSOAAZ9ZKycXOr74BRTGYQOGuhcwzpQp4=;
        b=PJl4zPME8/UUZihAladDWgrs4SeJTBIxz4tOz2v0n0mBmzfQVCepj+2PKFl3xOutZe
         G8BUGW5zhWCOEGMkT5RX+k/axrKdZD6MU8EW4FHMLelkUDS7nMsRh5zjcuXwv/nPDfiV
         BEPcJx/bkOsNEGduNKwmSbylwC21dTZgktr58htAJRvB22R7o42DqIHwoouSjJL3+ebm
         aFLfYR7zxZCwjbGyuwElVEt4E1s+b8IBguPUKzesjokVDLFETZ9ttiA8s9RckjRs1yQt
         N5WnaZblCTatyalMKjO/tdzAhgeL6e0qNqjxlQJeEfuJ9uYkuku5zLUVC/Vn5hUmC1M0
         IafA==
X-Forwarded-Encrypted: i=1; AFNElJ+CiFXMVZ8KvN4T72q6qgaIt8UGn1GxRsyjVlVro0gT7ODWxVOa/tsCUSv2rJnBxzlg83I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAWJxA30YfyYASIeINceTnVX249lV9/XvpR0vn8cx+AnnNyVq
	6ugyP7zm+4pwyROkQkCc9NMqn0rFqkwOEtMqJfDy0+g2+qSnIH7WqdTPWNBEwWZnX1k=
X-Gm-Gg: AfdE7cnMPPyARjpPOCLUL9mKqr4tBQy31iuqY3ygD2F38eNvLA+lFoWugx81K/29XoI
	fsrsDWY+1+xCCDIPSkIsMnNA3tHS43mbhmvDn5enUDKeODGkhrfh0edYItMRJQcrqFs561q6y0R
	/TL3+36wembGOM69s6yUtUvgSGBO8ye6+fZgJzVgEenHX6briMjxnGMSMCMhLvGSvHlqPmpchWm
	WXKqK7Qqt4ZbjqIkDGJLY6IqjV3zKPr8dyMpgHqHs1ps/SqWplHTp0XrZ8HqcM5jd+sk5h7pDVA
	IocReVQkeE143M/yTiQvoSd6D/c0WKioJ1E/4cSwYOByDiqUYvxQXdm1z0igTWc1rsZITfB3qI4
	nHLItS2/eU/Yqv1e7Rp+Ri3QAaV9nbYFtnJ+3mRjpOpqmLmrZLCHGuoKMWGTY4jpF3B8xIDLR1Y
	7XjVXkEFhrUlY=
X-Received: by 2002:ac8:5c81:0:b0:51c:161e:25a9 with SMTP id d75a77b69052e-51c26b5023emr46891721cf.62.1782940346045;
        Wed, 01 Jul 2026 14:12:26 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724be503sm7479146d6.45.2026.07.01.14.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 14:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 17:12:24 -0400
Message-Id: <DJNJLQZIR0N9.2V69YW14LMS49@etsalapatis.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject arena frees below the arena
 base
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
 <2a3747e64898cc7dda6578279cb5688f7029f658.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <2a3747e64898cc7dda6578279cb5688f7029f658.1782813442.git.chenyy23@mails.tsinghua.edu.cn>

On Tue Jun 30, 2026 at 6:12 AM EDT, Yiyang Chen wrote:
> bpf_arena_free_pages() accepts scalar arena addresses. The runtime
> masks the address to the low 32 bits and reconstructs a full user
> address from the arena base before returning the range to the arena
> free tree.
>
> When the scalar value is below the low 32 bits of the arena base,
> full_uaddr falls below user_vm_start. The existing upper-end clipping
> then turns this into an out-of-range free-tree offset. A later
> allocation can reuse that offset and return an address below the arena
> mapping.
>

This seems reasonable, my understanding is that this happens because
neither arena start nor end actually has to be aligned at a 4GiB
boundary, while the underlying kernel mapping does span the full
32 bits. AFAICT this bug returns an address that is not actually
mapped into userspace and is inaccessible from it, correct?

If the above is correct, feel free to add:
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>


> Reject such frees before computing the clipped range.
>
> Fixes: 317460317a02a ("bpf: Introduce bpf_arena.")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/arena.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef5..e28e83bed8c51 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -693,6 +693,8 @@ static void arena_free_pages(struct bpf_arena *arena,=
 long uaddr, long page_cnt,
>  	uaddr &=3D PAGE_MASK;
>  	kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
>  	full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
> +	if (full_uaddr < arena->user_vm_start)
> +		return;
>  	uaddr_end =3D min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SH=
IFT));
>  	if (full_uaddr >=3D uaddr_end)
>  		return;

