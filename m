Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677B3CCFA5
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714364; cv=none; b=XRvmHoqA4NxyL6Lk27qxaw5IcVMu+MzKmlBt+bzvpuGkWuHgdqYg9LcQnOOxrmWNSfj4RgVY+bl6DrbdhaQZtwTrPZCZmVaFbqIH36Tr5mbzktLHi9JYXcq7piEAfqQyMtURXmOtP3fNnSGo9+ied4yz0Vfm4HDv904Gy/1fhjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714364; c=relaxed/simple;
	bh=OvXrKzh6MXKJbe492xCBxiHB9QStXwZgAkK3MODf83o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jMBFAt+EVfGY4DbnsDf1AM9iJRqNed7cIv5haSMpKRM620ix091WI2lZHTKqaZRMZYHC3EbJAQw6zm5EuQKRyw8w+AcIcB9sMwXlTtfakaq20Jvkcj7IL8qMm6xypIKfb5V5AW1ZMLXC80oscGLOjssSnj1b2Elq4Ju/nnzQj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVqvz5pK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVqvz5pK"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a46ebe2beso34270567b3.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714362; x=1777319162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRIdQoM5qk/CrQSoqc5ffDH7C7ZF2CT4OYbyaV3UOOs=;
        b=PVqvz5pKFZfIIxRVe6Yk3d6n1F0GwD4RXKMNmy897596rn3SgsVnG8KIziBLLE0PsC
         I9s7h0mAXKlJ8wO71D2BDZQx2QLeocAWpuDtOnzf+AXpstr1KYGYQbvET1om8kDWPAdX
         YmR6KYJ/qRDnM/iAkU3Ne8DJ2Z7fJrfOHjQ6MqAHLYWXBPQlTiMTtwx6ASHxc24QJgv9
         IjFkgezwes4XtxsayvlAhbT/qY6EmoBjyBPHwYflseev4ERJI8ynBlx/nQI1eQ0+hIuk
         781e1hQ8mmouhrtZnyoldtIFiJGQ843F9GhP4QI3tXDPWYlKSK4DRuJFKVfnMwi5KbDy
         b5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714363; x=1777319163;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRIdQoM5qk/CrQSoqc5ffDH7C7ZF2CT4OYbyaV3UOOs=;
        b=EOoCOHGTEiAYNXMcej0oBzBCVsKX4sg1/HIy7CdmslyVVqKWZRBCmzbu9yfsnUP91O
         63vxHzR0q/ij1/F1jiGn5y7aB49UJzAR6s8TTAx9zrsggALfpBZE0aVCgisbx7+GjLAj
         KVsTvw78kRM1gmTGaxB80V9SPuHoRhWIORHGI9dNsoLDyjEiy7mVgxRIsjLL3BZcHjVi
         avBw/eyvJ4bJ/KRjoAU+yKxwyFjfkn6Jeac1X9zz0z5hXTDFKHV1TIcbzfRJrdpAzmhO
         b8pnBGcdkdlCQ3uhbw/apGeJbkKjw9GiRC5dt6FdQfYfqcllDrtCCZifnpUZ6YvQbB1j
         tlqg==
X-Forwarded-Encrypted: i=1; AFNElJ8IHSDcuuv6ptu2m/Ga0pJjOI5zdVvybkwoiT6LCFGHpC8IbPsVM9JVp1QBlJLgFz8CjbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiyIGXc5g3AyC8JYW777qEonaePpo/lg/jjVyvTBZDNZgdiTl
	Fn/mYOskZrA4836DpPsDUG1YM3tNXIeV6MMkDUMKiGviwe0FRVtwY8T1
X-Gm-Gg: AeBDies1B3hDuQB6jtzz5H/FlgMMc9/QN7pgxC0LaGp3h6ze5y/hOuFQanq7HY7iOT7
	JXeZuEo2DQikO7OimoHl3lXmNKoUyUpO73dmL+EziB2eexiWljqb/tTHP5HtBdozp/KCBRFhg5L
	MZVm7CMv2YjDjlEoULHbevjxOd/7UPzkFz+sW2Z8Cm6H7JD+8c8G4MI6YK8cSRKtszrv5Cpr59Z
	SwA/ARSfh8zyeDQ6CFBg2/j03yMROdgpRMd3b3Dn6+MU6TRpEXjyS1kDbOG6Zv+nCGwkP82p99D
	hfZpG0o658ZpNuUvGjg9GBZUnKHfX4xP6huKJbWobO/3DEdAXd9uWT4kt74kVqOx4HMisdnb+El
	7qnowL3c3GRY0ggmYUQ3uhTfTk7eDW4R7Yo1UnxahV0FD0lbTyQ/ALL0Mus4vRwdaBoIMnlzBMp
	2gHEDeN9UAwgUTX/lpepMgJhNEKvY/pG7FicvNq3YdwYxpZlg37CruhAUGF7LLyxEqJ7WHkyHt4
	gpSveXdBf+CiAwDW9hD/EenJw==
X-Received: by 2002:a05:690c:4990:b0:7ba:99bb:d4ae with SMTP id 00721157ae682-7ba99bbe028mr135603117b3.34.1776714362661;
        Mon, 20 Apr 2026 12:46:02 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b1e55sm47723417b3.37.2026.04.20.12.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:46:02 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:46:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.29253753e6c97@gmail.com>
In-Reply-To: <20260420104051.1528843-6-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-6-nhudson@akamai.com>
Subject: Re: [PATCH v5 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nick Hudson wrote:
> On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
> according to the decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6
> 
> When all tunnel-related GSO bits are cleared, also clear
> skb->encapsulation.
> 
> Handle the ESP inside a UDP tunnel case where encapsulation should remain
> set.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
