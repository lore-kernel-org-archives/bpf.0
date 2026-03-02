Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2F1AF0BB
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772414732; cv=none; b=P9M9v6vKx8z7dIF4CESoB3lXWYNUWjC5xapZ94eEhiEqmsMRXQ48kOQrgyj39P4RghQyDTVUDpGuJDZYVaNmL/mWWfzUy00rLY0zk/PdvU6pBQV143xCH93ObGqEq4Q2rzIXvH/lV3xZC7WuyKxe0exhm5BiXGxe9V/xEVu17xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772414732; c=relaxed/simple;
	bh=c11Ik9Wu6rWFx89nAQqqQ2uqdevqJ9lypkYRGm4U544=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRmq7fdaHJlFpJYtNFc5ttgjdKKmlHS4VRZU3yjt5FAAgSKjsAEJO8Cd4tnejJaXLHT8oTb7dRh9D3DZXoDdd5OM9/bJjzMWSGceQIxLyvorlxWvTfnT0EkpgCpYxpOAF9jQ4z8/Ok4l/GUr81nfyzdcBUOC4A5tFdu6SJ4qLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXQlEh/b; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXQlEh/b"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824a6f2d816so1637885b3a.3
        for <bpf@vger.kernel.org>; Sun, 01 Mar 2026 17:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772414730; x=1773019530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+sFBMEk2xP6V4+icz7JQnrewXI0dluunX//sXy6N9A=;
        b=KXQlEh/bqncMUZ6FfhyPSJNoVdjCn8xshLuSlgei+EWeZ9dS4pChkP86mFWJVQ9Gw2
         eflMZBUdMec+YYYJKxjNhGchSZy3fHnJPj4yNFS9NkewUrBesJ9CtCY23n2MO1gALQPM
         Ff+kG3H2EBO3irVsipqA5ViOwOrPbg94plqOSxcbIA4IwwUwnqCYTABu2zZQFOCbSKPA
         AoOwEn9yMIGThJNC1mMmlpqQ11juBakmfGBxR71jRWCB/Qps8Hr4cBWNhR4SPLBqY0O5
         le1Q1vVOAzDc8OFnPFNpHs1hNnzAX+RQSTxgrbqMH3ablUcvOwWQS6vxA5zW2swJo+Ht
         pKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772414730; x=1773019530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+sFBMEk2xP6V4+icz7JQnrewXI0dluunX//sXy6N9A=;
        b=pRsLZYYBsapiUzIjZheopBaPAI2PtCYYBzR7gngX6fh22Es7TsbD34tBuopPfJB1Or
         PNL960ewIlz2d+swOe0wCCkc5VDRyTnd9o/gGsjuCwB+EmXqAtwh16mHu32nRVLmok7R
         SWxkrtrneMLBBHAcaODMHFuZgYH7I6rnrb7CtrwodWfL4rLZhyrUu+cVzbpziefisWZN
         GEwBxInezBcC6jDk4Doc3AVJyVsPLqQNCN42MKd+kqR4i9YpNvM1cU8rwMMExz4GiBUv
         m5ALaVwGV+lQT3oEqxS3ggB36gGYdKFi/IsSvh7rU2oVkVTxO59/o+tPyZ60XnrqHmI7
         F4+w==
X-Forwarded-Encrypted: i=1; AJvYcCU7EZsXq68Rsy6Tlh7WfaHVpviAUAYD6EzEl4PXS+ZSW/kl1wH8lj/aF9UzRtnc/q2KSgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQehlESFER40PelK+5ayT8Y9yaUd5a2YRL5jzU/sf2dM57jAm
	NOnaZ3laFfXmSXcW8qPnOO44dWE+tPC5DZobsRECWoZVBskV+kyY7SNN
X-Gm-Gg: ATEYQzxrCf+PWCRUwoiNzRKzFwvxkKlQBmR3gxsKtmB3ypkVmZUVQ2ghR1MBa5sMemt
	Dzv8NRHL2XJFO9CaRwa+Ed7uxcWwo80xvxBmgjU0MY5t8vI3LE1z6egl9/cO7HzFfCZRu52OKap
	Ea8LC/byp/IxILZ9b0SEKks0WXP0eETQqB4KMe0Rnev2BshD6NdR5b64QTHFwOUq3+yc9xm72xi
	O8LvRIfHnPC5W7Q7/kYjhfnCxbg36PGKayzZQB6ywtQM8GqSPIr7lBkRog63V6rB+Dw2apLqvU6
	dtIrP0TbCQs+ZKuxN/fgwOaR7pd1ghhGphZZlEI9vEATWAquzJvVlpz+/fR8z/N/KrwrMB054zs
	eX/22ZGfjwgbl+zHCpkFrHam0hKa6oTLDVIDsoThkyeuxfI1z6F5E08NyuLPki3o/X73l/3sYee
	8h1EsgiLuGJtCAB3ZSyIJ23xjxbHoMIR3c7pk2jw==
X-Received: by 2002:a05:6a00:909e:b0:81f:4046:1490 with SMTP id d2e1a72fcca58-8274da06b33mr8806359b3a.44.1772414730092;
        Sun, 01 Mar 2026 17:25:30 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e4csm11200214b3a.15.2026.03.01.17.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 17:25:29 -0800 (PST)
Date: Mon, 2 Mar 2026 01:25:07 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: bonding: Fix nd_tbl NULL dereference when
 IPv6 is disabled
Message-ID: <aaTm8ydbxRe0jbPk@fedora>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
 <20260228-net-nd_tbl_fixes-v1-3-2b2a274df9bb@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228-net-nd_tbl_fixes-v1-3-2b2a274df9bb@suse.com>

On Sat, Feb 28, 2026 at 02:46:28PM -0300, Ricardo B. Marlière wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never

If it's booting without ipv6 module, maybe we can use ipv6_mod_enabled() to
stop ns validation early. e.g

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a1de08ee3815..be9e01ddd6ac 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3372,7 +3372,7 @@ int bond_rcv_validate(const struct sk_buff *skb, struct bonding *bond,
        } else if (is_arp) {
                return bond_arp_rcv(skb, bond, slave);
 #if IS_ENABLED(CONFIG_IPV6)
-       } else if (is_ipv6) {
+       } else if (is_ipv6 && ipv6_mod_enabled()) {
                return bond_na_rcv(skb, bond, slave);
 #endif
        } else {

Thanks
Hangbin
