Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759B2DEA7B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859909; cv=none; b=M0RHQbtdbUhDfs4tWnwt27I0QoVVw68w7c+8LQmKPXIWxOri+cylmZ06ttbFp7v02PP++2zt5+WcYP7RedSJxVYe4IaHx5Xyo+AG5DDOeLMzo9JLF17Er5iGJS9CT8PCF+KiuuVyN/3BNMqQERU6cqK+08w18cNfj8/bgDd7QJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859909; c=relaxed/simple;
	bh=afubjmtK6J69d9gjWzx00ieDaqApuKhjmcImG5ymlNQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=AZywS7KFXBYkcKHNzefR+QwC8Sc7473EKZHNyd4Yg5vH7c3GLXVRRj5xFl8eg6eAzKTACaAQvRo9FK2hL0eBJjg8xb23SrLNLV3kXudI4udcnqf0FCMduur/kIJ3EtN+0aNXrpPZi+Fq0Ku06C4F+HRhth5zqeg+6yJccy8qvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxqgL+89; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxqgL+89"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1666356a91.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789859907; x=1790464707; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sUuoRL2/TITlGn0R3prNUIqDwgNFzk2wNFbE6aU/ybs=;
        b=JxqgL+89t+ENA8TbE3a9gpcPYolq0+DKEIYpBu7SK/0p1F0V/dRsYEeZBBYKWHP+gm
         qciIgVyuXllKAeHHMxGWtIF6546WUBGjvus1rS68gpmTWJSythf/kj9HNtpUpxP/pD89
         bHO0eErW9C29GVzCHHvQJCwTQwdHL8/Da7Li6gzw75mt/GkarUIJdmq9aZeepWyWvCjD
         pc4a0bni3Z0sK/+i6o8+m/etYsS0B+SSHLJPPmGLWugoyg/1gbZLTzBZnmAWc2n2zIei
         O0kfnWJjyZROzQR8kBuYot6au+sOO9VACQkOCQIgEO4/g+A0EJWlOtkwc40mZH8YyKUN
         2P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789859907; x=1790464707;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUuoRL2/TITlGn0R3prNUIqDwgNFzk2wNFbE6aU/ybs=;
        b=SIwNlMTaqpKmN928nv/gkCjekWNxCEmfSW7/QKIFMd1M8+b+r8WauFLOcawvvR1PGz
         fNohGV1MsY7jbT7ck4yk506F5lgfy5lUSHaA88J3b4b7QiyrljIIhzoahTx4yQCmofmY
         +Z7K710jzfxT9Lt/wE5lJYBNm7xESXQl2m7uO2hmQEkBZD1cWe4bBaSylUhxM4D0l3Pz
         KSRAvAX+HPb3JyID1yOb34w/Lh4YxYWzBSiu+P77ULM70Od6AKURODr32zBqS9gSGkjy
         lUPF++YZ6xj0HRv+iQNd+fINA5lAKN8OfqJExhVSmWEEHkszlS365/ZVAJfrv/dAQn2q
         40Pg==
X-Forwarded-Encrypted: i=1; AKwUvBw4CzqWi5ZyvL1hM5RIbqY8lKR0mHsZ8m7v5Yv1SRsLzrv0UIOcZjQXcJYgAvooPTwKm30=@vger.kernel.org
X-Gm-Message-State: AFuF++kphL6tAxUhXOY3I1TNrBB6b3sS7LVh2kIXzDutJt30FiDb/lI4
	L0ksT11LzDoclHfKKR9W4kMcSvdIyIlZ2x9x5lva1WAHSeNN+Ee52cxW
X-Gm-Gg: AYBFou2g16NrLCvfV4mJ3dITaXCuYgKaMoSG34/4oo8vautOePzu6Y1f7tdJYwN8S/3
	JeqxHmX6SP2UyDXUyqJVgFuqgJaF5P2Fu7J7Fd2QusWzcOyCO1lEFefJ5Lt3DQEZt1oY+/C/UAv
	uI1gLUkwEwyidj7u2Szoho6jC504gCCzV542hcDRj9P44fRlrNy8VyTYAQJBR7hAbP+jgv6WIp2
	YAyhLIkabj95897EWVVxPq/GXSqhkks/R2gVyqeM79t9HHYozdF95tqz10nNvw6VeXNE2TicaGa
	UTKJctve5fEhtvApouI3xnu7K7k7zor09//gqILgPn8pLgRPCW/n86lcJG5OB/z2p6lzDj0TfZy
	9dx+e3ayW1uumzD8MxgDyR4jHSJQTeAyeIrUSrCf2rOHgEQsStY6H7LFFH/YB2Jt7+7UrhjhIV8
	r81qv8WCycY26TneXe6PE7Jxzb0ECiB2xa9e+B/jp9c1n81b0koRzTep38fJtm1tu02oYbKV7bE
	O7+2Zlfyq/kZefyjXG7u2+KDs6K4OiJtRDwFAHZQyswdqgiMrfz+ARvW/oczbwz4J+X8ByBOuxm
	zCq5
X-Received: by 2002:a17:90b:2d47:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-39e54c9c7b7mr11531713a91.19.1789859907264;
        Sat, 19 Sep 2026 16:18:27 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c164c18sm6403791a91.1.2026.09.19.16.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 16:18:26 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 23:18:26 +0000
Message-Id: <DLJODTPSL3IT.1LQ0SJ80PGO1M@gmail.com>
Cc: "Willem de Bruijn" <willemb@google.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: reject unset network_header for SKF_NET_OFF in
 cBPF load helper
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hui Peng" <benquike@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
In-Reply-To: <20260919203517.2581484-1-benquike@gmail.com>
References: <20260919203517.2581484-1-benquike@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 19, 2026 at 08:35 PM Hui Peng <benquike@gmail.com> wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -231,8 +231,14 @@ static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int off
>  	if (likely(offset >= 0))
>  		return offset;
>
> -	if (offset >= SKF_NET_OFF)
> +	if (offset >= SKF_NET_OFF) {
> +		if (skb_mac_header_was_set(skb) ?
> +		    skb->network_header < skb->mac_header :
> +		    (skb_network_offset(skb) < 0 ||
> +		     (!skb->protocol && !skb->network_header)))
> +			return INT_MIN;

No. network_header == 0 is a valid value when there is no headroom and
skb->protocol says nothing about it.

When netlink_dump() had this problem it was fixed by
skb_reset_network_header() after skb_reserve(). See
commit 99c07327ae11 ("netlink: reset network and mac headers in netlink_dump()").

pw-bot: cr
