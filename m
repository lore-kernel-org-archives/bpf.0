Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214302;
	b=Q2GWOlKGZb6+pFZ89V6YwPCpJi4nDY6SY48Yxv4AXpzcOPi0BfaRS841qfX3zYpbgJIi
	 Fw13feja6DeiFbNTy8KR8zT/Tj2Ph58Z8FhG6THtNAWVq3wWoJcCT2H9ujsGh+9oquz1Z
	 zBM0eQmnV4IOLnijqRUjGMuECxlZGfPH3l62BfENwyutqD30JrnFgTkrx4zveBPYbUdFk
	 ww2NwiCWnh7uX/xvXUv+IzFzJPTQiPvqd8eIprcavZAr5qlfL7fLun3itm0bIFiy465MP
	 T23pm+t5Av7ojT4Ny/ZEiThnzKTVUDj/aDhCOP+7sRFChxPJ9aDBoo5DexUEka0YcWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HBeP0TSiYus+H+GGePP31NmAMp8IAFuLA0XNaEeXXiw=;
	b=Kl0ym4nLbgf5JNfC6DjtFVyRv+C6+nFjWabWex0I6ABd+dNKiCMHPLuZaJhSeM0n9Vwn
	 umKzlHEsJoibD+793WQgs66j/KvZucW4Uq8PmAxSZ/bv3NEO4P9L8XUMpNWw6hIBt6WE9
	 XUuJLqqJHLRo5a3J272MsWTBgu3GpGujDtJxG6FgBenkgbe5obPcZ2y1bGp+D0SgkT+c4
	 ltnHy3RmDq+c6+wI+Khg080Rctca38trvUocVCcOArLSS7sBsiOCmKNoTHCanmH5K1dzr
	 uunO4yfIMRxjZGDl8KQU7SgYu7SPUpCvFwtmkyALxKFZMdYTuJ816hIDzNAgYYxHAmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KSjHQFyR;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A7606BF87
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 19:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899A7606BF87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KSjHQFyR
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-679aeeddc6bso1594912d50.2
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214301; x=1793819101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HBeP0TSiYus+H+GGePP31NmAMp8IAFuLA0XNaEeXXiw=;
        b=KSjHQFyRR+anaK/fnGmAHtjEQik171LZhKrmWu3Ns46obZsve5dZLtWfXrCrMzuZUI
         LG4QoLVrLgPUSyw3GCGhOQhu7b3GTbE2slNwbVghfQ8LWImuxF1V6gLDIPkPVPZvpQLX
         1LhXCdB9QlCagXedmUtJAC98IqMbuk6D9p/vlrRRB3dr2eL5pFL8r5ss4rhBegxTIbKo
         M3U5XFw69zLirS4U6q/XRoq/XMHIKtTOUI1w5VS1HVVl5pDosD0Lr+vDmKWElubIHuL2
         duq0i5kS1U/MK+SIoqJiULYP+EgqDZLX28Z2WtdW6U5YCsbFHshoJ4t4O6pfWQ3RV+oO
         CS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214301; x=1793819101;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HBeP0TSiYus+H+GGePP31NmAMp8IAFuLA0XNaEeXXiw=;
        b=AY5imvOkzmB+6yz6FDlAnDC0g0LU4Kwo/5BTbbv/SW/n22QYERPIc06enFvPfSf9xu
         SBu0aIzgSXJR2g0gxxY/LBLGzRK6SYXTKncWwfNMadL4nWAGYM0Z9suXDOnpY+lniqK/
         qUSK1Xf7Hwuhr1gSgtiJnMBhna2dkaM9/QVISwFg8WeL4KdwPyQSF8B3b9CTF6lynIgx
         bA/O4gWGK6vY7FMOZEGcGcCCmeycLSd9ZXvqtA70rvYt9YvZQ/3aVSwa66j/pCvl/G9q
         16KlmR2CuJIR+oRWRdX4INy6EUBCyXt1UJbRKV92gYHtTLrtrG7Jufwl59KyV+VXMam+
         uNgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbqxK2OENtH9GWSTHmgQanqSubFVEctIL/tfh6cApwo6QipfYACjzmpECpgzAbMyVzKkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcMFXpXWCqsT4BDl6Q8jI7Z0uU1ewu5YvPTRR4CVi7A4Kqws9k
	fN8W4fvVcaCfC85nXCigkxwpVd0Ipgqev5tF40eCsJLFdpMZmSYOl4lD
X-Gm-Gg: AYBFou1I4yboFgJjKmig3yVqm3fYQG7z0Dr6G5nGQWYZbL0pkt6QTHOXw8/HulbYMgJ
	tiAoywyXEGKubYkCsjxtIpQpVHWWGAxY59feWrXOd3PnoW0lWHpAuXpc+iptvVignhJ4DVktP8c
	mIqjYSjcMvRMQFqjZMTsL344623Yhp+Zx62xneCfYBCc2S07CEH4dnLZxEm1pM//1WMJZ4DCqmP
	qGd5wk1vxVwfvSJmJ32oeSd3IfG060lhBVctrZlE+O+CeQ8HBFdCPvS8cPTMPAckNPJGu1uQkFn
	/ugVqP5NkKG7QC+dywtxtMvDhVIMv6j0zuwMUrGEpRJ7b9VxbBUiWtildFokBvFEeMqwSyWkJzy
	H+x9hafXN4C+AMbWhzlEVL4KsYNtf09HzliwxLB63gj6Qe41oqKL9neTucE3ZPB56oBYRs7kc5w
	PxJN0Wwg2f+SA8RUKmBP4vwBr3c9dS9cDWmpPczwoLPgB8Rn+qcbPL9kzaFLwQ4xnBL+wqZud/p
	lQPemLAVeZCooW7ccPNLG31SzET3jxciJP2ZSyNV3Hvvn5sFRcOCKVmF/E9tUW2Jjh2j//FVS7l
	YtZBojcYseb0BMA5ZM+Uugj2TmgvO9wQmApThfypF5B7f1+/l0vQ/F0txQ/y24vgqlVijvI7DQZ
	quyRboSIo6Eg2F24J+DpAcX/zldv0RqwN46gL8kV0e4UyjQBEpr5yKxWxUOpudGCCAZWc
X-Received: by 2002:a05:690e:2061:b0:672:d32d:999 with SMTP id 956f58d0204a3-67a7b9b9f21mr1560991d50.14.1793214301294;
        Wed, 28 Oct 2026 12:05:01 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a803cdd1asm1434191d50.4.2026.10.28.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:05:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:04:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 dev@openvswitch.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ren Wei <weir@nebusec.ai>
Message-ID: <willemdebruijn.kernel.3177102d5612b@gmail.com>
In-Reply-To: <20261028122703.2093730-5-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
 <20261028122703.2093730-5-edumazet@kernel.org>
Subject: Re: [PATCH net v2 4/5] openvswitch: use eth_type_trans_careful() in
 internal_dev_recv()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> OVS actions like pop_eth followed by pop_mpls(ETH_P_TEB) or pop_nsh
> can expose an inner Ethernet header which is not in the linear part
> of the skb. Output to an internal port then crashes in eth_type_trans():
> 
>   flow: in_port(0),eth(),eth_type(0x8847),mpls(lse=0x00010140)
>   actions: pop_eth,pop_mpls(0x6558),0
>   # AF_PACKET SOCK_RAW on dp0: eth / mpls / eth / 4096 bytes of payload
> 
>   kernel BUG at include/linux/skbuff.h:2839!
>   RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
>   Call Trace:
>    internal_dev_recv (net/openvswitch/vport-internal_dev.c:202) openvswitch
>    do_execute_actions (net/openvswitch/actions.c:1296) openvswitch
>    ovs_execute_actions (net/openvswitch/actions.c:1606) openvswitch
>    ovs_dp_process_packet (net/openvswitch/datapath.c:310) openvswitch
>    ovs_vport_receive (net/openvswitch/vport.c:448) openvswitch
>    internal_dev_xmit (net/openvswitch/vport-internal_dev.c:42) openvswitch
>    dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
>    __dev_queue_xmit (net/core/dev.c:5066)
>    packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
> 
> Use eth_type_trans_careful(), and drop the packet if the Ethernet
> header can not be pulled. This covers all OVS actions at the consumer,
> instead of fixing each producer.
> 
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Aaron Conole <aconole@redhat.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
