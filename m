Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C31D5ABA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017474; cv=none; b=umugWBmixALRqcwzbd1+CT04u+o0MN0qnbnk82p0d57dfcQQenQZ0L+Dp3ShEAF4RJvFiNsrqS19nQiJeiHcRYz1eUK8pzuoSWTiWZ3SLT09KchyHqb7kgfp/XRtqpbOi7DgRQM1XrIwtk2rfVE1PI4j267VEX+/btCM7mD3AbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017474; c=relaxed/simple;
	bh=RP++oaAENCDfdPEBn0eleqFM3JOYSMJrMeHuCLOSiaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtfV+c5vObp97tdvc5GXyR2Viwji7t6o8OxwB/+4+m2c4umIpcxYkNZPGPswCMPlAf7AWmvM+JmucrBzaNBugsACjFFwX4LnyicxLktaIq8LnSW4V7MJqcJRwfXirahjaqqGomcA4csQUbUnZeQoRq+aSk7472T5WEZ55nRLp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXaqBm/y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXaqBm/y"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82985f42664so2093465b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773017472; x=1773622272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyUeO1XqBZxXrzuRGXceTat8xeWAmoV2Pi1+QZtQ4ME=;
        b=bXaqBm/yotArpy56WlkAN21Igl1IxGuBySrTkY2YM5f51n4TOnclOEuITgihMEt1GK
         Z9fn9U/VW5Cixo+HVYjBm+vzJvyYx7QDjlgQQrwDKJK8Ok9/SK5JPgDSje8lvhNjjDhd
         3HWGwoeb9tJ9k3XS34trmDvCss7cXVVWdK/FvxKeZDH2qn3NJEssv7j7vE37dBtB0T9x
         1DvKTZ8ydttoKMNNB+uEn/RFJobRNAkqGRRFzuqVG2f5ylDHPzDSO4TV+yEwf/UrG9y1
         +la8cigHY3/L4eHhuiTl1v4Hvpk2EBvhcdBo5CcQfes1K9EHe1v1sSP/atGuACaZfadH
         xIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773017472; x=1773622272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyUeO1XqBZxXrzuRGXceTat8xeWAmoV2Pi1+QZtQ4ME=;
        b=e51G98vbuE0CVV55ksr4ZA2fLZheVgIoxj8f8EP3oQ3pI76qpqTPOBciuden9AXBxK
         S3oNfeSntvW+DoDBnosBm9jLn4blisx53xnoJ7WNWFCwGjKIbpCyQhLRjlLkPC8lQgDu
         lUrOfgKzCZmXzlkAGIPzURDR8bocP2ahhSsedGt8l5m9Vky5UB+Pvzj1Yj9BbQ1KRtf6
         dtWog9MMT6U/14nB9MkwqMPf4ahTHkVzIG9ExTuKd7sBRo3BSpXNbXmrejBhELj9XnXc
         1KbTgqxipwX40nx3K7FbDzTxmI1rYnmryzqNRAEdLU6koN593ts4AMplsXhJoQ/ScwEe
         FTCA==
X-Forwarded-Encrypted: i=1; AJvYcCUMacn+laqpX6WeK4XRmo4YvumOyUmBHG4A15+yfXls0vr5TScx5/f2x3xxbpc8iNT2lHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq06CyhV7uzqfwZW6rRsrS8A1nh0y2fX5dZX9jqqL1ydEzLVs+
	JwlqDRa9wNgNTI2HrVnYkODQQjw1yzHssWQ+ZIon3FQPAcpDeczSdVhO
X-Gm-Gg: ATEYQzwTdQhBc3uHN3226YcNHxCvP/ObZ8O5gL/R7svCcd8+Hsmd6TE/SqiEi8N1nHk
	Dy+3XB4H04F/3hhnYI4rKcY0K8sJ+BoPNmxGPlHSAGXGAHqpnFw4IHpw+ow0Jn/O0eDTjVmIKs7
	osYStpqLWTdZpufxaC6k47+5qk/IfNjNg2hXSkCVMjOuaHsZJzNbwH8FDg5mZZkG2aJzWQIF5Sl
	REWvN1qlCfOlTQaYS0oJaAQh6OGWCiDivNityROcY+hzIF47c3JPYtEABLWXduI+7v9n042L/d4
	8Z58d1Owt09XQYlGGveH5yAj95dYzpCJA8aiWArKDwzGCVx95lKI+RQZYR8gkj1qtDktnquwCx4
	ByNktgulJb558I94jtl3g67abwCE1veh7vdNdfUl3BE0JTyc7BodrotR9eqpGZmYupIb64avRg4
	3S76HbD1EFk+bx5l9qbs7qanVXeaY=
X-Received: by 2002:a05:6a00:3cd6:b0:81f:4566:ccde with SMTP id d2e1a72fcca58-829a2dc33c8mr8984256b3a.20.1773017472211;
        Sun, 08 Mar 2026 17:51:12 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636a92sm8405090b3a.1.2026.03.08.17.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:51:11 -0700 (PDT)
Date: Mon, 9 Mar 2026 00:50:59 +0000
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
Subject: Re: [PATCH net v4 2/4] net: bonding: Fix nd_tbl NULL dereference
 when IPv6 is disabled
Message-ID: <aa4Zc3fbvDXor1jn@fedora>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
 <20260307-net-nd_tbl_fixes-v4-2-e2677e85628c@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-2-e2677e85628c@suse.com>

On Sat, Mar 07, 2026 at 05:50:54PM -0300, Ricardo B. Marlière wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. If bonding ARP/NS validation is enabled, an IPv6
> NS/NA packet received on a slave can reach bond_validate_na(), which
> calls bond_has_this_ip6(). That path calls ipv6_chk_addr() and can
> crash in __ipv6_chk_addr_and_flags().
> 
>  BUG: kernel NULL pointer dereference, address: 00000000000005d8
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  RIP: 0010:__ipv6_chk_addr_and_flags+0x69/0x170
>  Call Trace:
>   <IRQ>
>   ipv6_chk_addr+0x1f/0x30
>   bond_validate_na+0x12e/0x1d0 [bonding]
>   ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
>   bond_rcv_validate+0x1a0/0x450 [bonding]
>   bond_handle_frame+0x5e/0x290 [bonding]
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   __netif_receive_skb_core.constprop.0+0x3e8/0xe50
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? update_cfs_rq_load_avg+0x1a/0x240
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? __enqueue_entity+0x5e/0x240
>   __netif_receive_skb_one_core+0x39/0xa0
>   process_backlog+0x9c/0x150
>   __napi_poll+0x30/0x200
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   net_rx_action+0x338/0x3b0
>   handle_softirqs+0xc9/0x2a0
>   do_softirq+0x42/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x62/0x70
>   __dev_queue_xmit+0x2d3/0x1000
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? packet_parse_headers+0x10a/0x1a0
>   packet_sendmsg+0x10da/0x1700
>   ? kick_pool+0x5f/0x140
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? __queue_work+0x12d/0x4f0
>   __sys_sendto+0x1f3/0x220
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x101/0xf80
>   ? exc_page_fault+0x6e/0x170
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   </TASK>
> 
> Fix this by checking ipv6_mod_enabled() before dispatching IPv6 packets to
> bond_na_rcv(). If IPv6 is disabled, return early from bond_rcv_validate()
> and avoid the path to ipv6_chk_addr().
> 
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 14ed91391fcc..33fb5f168cef 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3377,7 +3377,7 @@ int bond_rcv_validate(const struct sk_buff *skb, struct bonding *bond,
>  	} else if (is_arp) {
>  		return bond_arp_rcv(skb, bond, slave);
>  #if IS_ENABLED(CONFIG_IPV6)
> -	} else if (is_ipv6) {
> +	} else if (is_ipv6 && likely(ipv6_mod_enabled())) {
>  		return bond_na_rcv(skb, bond, slave);
>  #endif
>  	} else {
> 
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
