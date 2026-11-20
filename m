Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194178;
	b=dcXGF5tnpimmFPcBttN/NW5Ip8AiVcrs4jC/AcDiW7qfRU6n6T5hspMzwhtgwTW3Xrww
	 D/44WxuT4n/MgIZ7b7DaaFOkcaGNnI3mt+U0xUNTfNj/GJPfJ02w/WX4rZvJY/W6U9gN7
	 SYaweX3jEQ5dW9rM/HvM7itF+VNT7B5FLIx86isCCdu4riLLMbY7NFm5RPpg3u73VdBoP
	 98IHkgT9XmTodlOMHSl+bsZKyI80zld+yEh7JdqFESH6kUpUGDse+L7KkqxJH6QXJ8rPD
	 S4X0JjnK7vtgKrOy+cMtOFEUnuab/JmjaBtbhSqxms1KlvKYQUv1UX3lNSb4SNz6xWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qQuyA/wGf2rk1rRg0kIZ3chxHbc26UCUmpfAx4NpZNk=;
	b=KKlR87Dfgos5m2ULP3cR4ZxAZ7REpyPu+fQTipb+9uAudwhCtBfW33LP4V7SnBh142jm
	 KdtpiIa5tHGkEgaApkfv10HZvw4l4yutLUfaQIWBsG25HoCFOMaym3Y1V1mehZaoKlzYP
	 XmEHX2H8G/7PVOqwGgekW++kL1TV+WQrtgrppv5J6J7RqBM9GvEgzjUbeakNw8ciJbxIp
	 MFjbaL7KwcqB2z6cqB7uccSGifUsnZNvXgKuvpGBlDmJxC8AP3wA5z15BJu8SPjPqUQ9p
	 uZxqfpskzmMgTP8mMXNoG/MDhl7y6svLXu1mcQ4ZnOYcy2Qr68deb6erIGJfeoCw4kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=JAlU39S3;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA8606A33B
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 17:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2EA8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=JAlU39S3
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2416420a12.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795194171; x=1795798971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qQuyA/wGf2rk1rRg0kIZ3chxHbc26UCUmpfAx4NpZNk=;
        b=JAlU39S3dQtcfoQsIcpIuc9H/wbJsTwU1N8P6M9imBtPISC74PzNZbJVtUBdFw1nCt
         mG7UfIQx/8mobbX+ZIHcLP30gtqqz9bymMByF6rYziN60ZFp7N85DTbLaUKSrN655vjk
         fv5i90/WSThbtFaG+zBlAu234xsvGHNtjotmV4dPT0SGthL9nOnVfZBUw7ZT+wrN3bT1
         SBT83dAw7rZsSRX4Dgn5PPFU9coJV4kN5jV1mGkqHnNNVt3xPvi73ub8LDtbrVr8vnBp
         6ynyWi0oAzkodou8JRleDm8yzoV9YkVaAT+p7MOjkJW8Rn5lTBO8k6a0jcQCn5h8Qg3m
         K1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194171; x=1795798971;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQuyA/wGf2rk1rRg0kIZ3chxHbc26UCUmpfAx4NpZNk=;
        b=ZjslvZJgjyl9DhfwLvTCD+JBjxXelRNV6ljewGqF60s0FAgZgqNM2tBTA4zGCBoaEK
         dmizdBHIQlSgXkzfo5vXoZIwBASxpdwhC6Z3/7xVXPqjtGceXllJ8OZrh/URsg7OP7rv
         R5GO02Aqg5dJq+v55kWpCWwsknJzB0Akd0Yd+o2ORvEK+r8SZXklq2WjzTd5POjK3dxj
         J4F1WMoiCp+E9TTFfIk1eE5DNQMcQvKFHoVfPByWC2hZ/mlqInAN5GkWRJmypeEyFpLb
         atRntByNJ+IS+N4uuV3Ww0RiD6Nj4sK9fiq4kXmyOtrN2qVwhXunN/+kNTiYEAowSqZj
         5cvw==
X-Gm-Message-State: APuU4Z+nA+5Sw2wAC3tjGBk3Y+F/2VmFek5f1wPlWudIDtx0c7PrHApy
	DfaHTku8nJlSL0QuUh4xqalf+jQP7qgYJ5m8bSh8P+jFi4YR5B95r3SC4tsRCLkU3MI=
X-Gm-Gg: AZFdTZfuvDntSML36MBV/XZvRNmq4GjH4LV1oyXV6mGqwx8HF+I8OWSEMIKj9QgTmES
	HC+ApgUMqUgeIgGtXY4cbMStrL4uBdbrqA1Q3zGD50IfNNAZZiGHj+yCCKimEtcLu0YaeOBsNs0
	2bIKhgqTrXLaQP8a+JFYoNHcHHv7oMSzo4EnQM3bzNmO0FrU+PKGuRND3s0LfMzwryGqVLoTBO4
	BFoWpjYZeeRNyWngfNn2AOVPhqrWN3Mk1pDow+g0gXI3QNYv8A2DxwHgnuMlOV5aDKlQ90CfeMC
	tg/ZkRhAcopWOtQy7LP0d+o6bBRszJCh+fb/b8rFHv/ESJvsePszbpTqeQiIX064+dKn+B1EsF4
	/xD/IJjjXLiMehhf7bQ/y0m/Dw2hU7adGeAdxE2lZBK3l0C5LH7OwLMakc2UCUOLMS5mdC1J3e/
	FTaQyVXR9MSy870z+iNOXXgRm8YZSBUWC49CCGEr/9b4spXjNzWVkRMHit7ScLugwjiwD6/gx36
	jqXxUCq5GdtHePpqMaf+PuTR2hDEyJdXGs+oHAtpaOvd7LaxA9cgqbbWA+DO3tDaNghJaH9y4Ab
	ICr3jAPJOdXhyPCSII2PLSeO5RIyRM2atv7Lt1H3VsVRF6M21wAUo0+60P4=
X-Received: by 2002:a05:6402:3717:b0:6b5:5ee4:c9d8 with SMTP id 4fb4d7f45d1cf-6ba37ea91ccmr3044788a12.32.1795194170694;
        Fri, 20 Nov 2026 09:02:50 -0800 (PST)
Received: from ehlo.thunderbird.net ([149.62.207.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm1350503a12.18.2026.11.20.09.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 09:02:50 -0800 (PST)
Date: Fri, 20 Nov 2026 19:02:46 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, Paul Chaignon <paul@isovalent.com>,
 Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>,
 netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_bpf-next_3/8=5D_bpf=3A_allow_bpf=5Fsk=5F?=
 =?US-ASCII?Q?assign_on_tc_egress_with_refcounted_sockets?=
User-Agent: K-9 Mail for Android
In-Reply-To: <awB1eao9nFgiTn8A@devvm16445.scu0.facebook.com>
References: <20261119142231.2612515-1-razor@blackwall.org> <20261119142231.2612515-4-razor@blackwall.org> <awB1eao9nFgiTn8A@devvm16445.scu0.facebook.com>
Message-ID: <9225E9DA-5AC8-456B-BB69-5626E7304C78@blackwall.org>
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
Content-Transfer-Encoding: quoted-printable

On November 20, 2026 6:31:08 PM GMT+02:00, Stanislav Fomichev <sdf=2Ekernel=
@gmail=2Ecom> wrote:
>On 11/19, Nikolay Aleksandrov wrote:
>> From: Daniel Borkmann <daniel@iogearbox=2Enet>
>>=20
>> bpf_sk_assign() has been limited to tc ingress because the assigned
>> socket may be a SOCK_RCU_FREE listener held without a refcount, relying
>> on the current RCU read-side section for its lifetime=2E That assumptio=
n
>> breaks on egress where the skb can sit in a qdisc across grace periods=
=2E
>> However, the helper is also useful on the egress path, for example to
>> attribute forwarded traffic to a specific established socket for qdisc
>> flow classification (fq, fq_codel), cgroup accounting, or SO_PRIORITY
>> propagation=2E Established sockets are refcounted and therefore safe to
>> pin on an skb that may be queued=2E
>>=20
>> Allow TC egress to assign full refcounted sockets, taking an skb-owned
>> reference after orphaning any previous send-side owner=2E Preserve it
>> across redirects, classic BPF verdicts and netem delay=2E Reject decryp=
ted
>> egress skbs to preserve the original TLS transmit owner=2E
>>=20
>> Using sock_pfree_ref as a destructor encodes the refcount state so:
>>=20
>>   - sock_pfree_ref releases the refcount on drop (unlike sock_pfree
>>     which skips non-refcounted sockets)=2E
>>   - skb_sk_is_prefetched recognizes both destructors so ip_rcv_core
>>     still skips the skb_orphan on the receive side=2E
>>   - skb_steal_sock sets refcounted=3Dtrue for sock_pfree_ref so the
>>     transport layer calls sock_put after consuming the socket=2E
>>   - skb_do_redirect only orphans sock_pfree + !sk_is_refcounted (the
>>     true no-refcount case from ingress), preserving sock_pfree_ref
>>     sockets across redirects=2E
>>=20
>> The refcount_inc_not_zero cost per bpf_sk_assign call is negligible
>> relative to the BPF program and the sk_lookup that precedes it, and
>> does not affect the UDP early demux path which continues to use
>> sock_pfree without a refcount=2E
>>=20
>> Handle reference-only ownership in TLS software fallback and Chelsio
>> record reconstruction without sk_wmem_alloc charges or lost references=
=2E
>>=20
>> Software GSO splitting after assignment is unsupported, including qdisc=
,
>> device/driver/tunnel fallback and netkit peer-side NFQUEUE segmentation=
=2E
>> Segments can lose the selected socket; intact GSO and assignment after
>> segmentation remain supported=2E Ordinary loopback and veth peer NAPI/G=
RO
>> preparation can also discard the assignment, even without GSO=2E
>>=20
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox=2Enet>
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall=2Eorg>
>> ---
>> CC: Ayush Sawal <ayush=2Esawal@chelsio=2Ecom>
>> CC: Andrew Lunn <andrew+netdev@lunn=2Ech>
>> CC: David S=2E Miller <davem@davemloft=2Enet>
>> CC: Eric Dumazet <edumazet@kernel=2Eorg>
>> CC: Jakub Kicinski <kuba@kernel=2Eorg>
>> CC: Paolo Abeni <pabeni@redhat=2Ecom>
>> CC: Alexei Starovoitov <ast@kernel=2Eorg>
>> CC: Daniel Borkmann <daniel@iogearbox=2Enet>
>> CC: Andrii Nakryiko <andrii@kernel=2Eorg>
>> CC: Eduard Zingerman <eddyz87@gmail=2Ecom>
>> CC: Kumar Kartikeya Dwivedi <memxor@gmail=2Ecom>
>> CC: Martin KaFai Lau <martin=2Elau@linux=2Edev>
>> CC: Song Liu <song@kernel=2Eorg>
>> CC: Yonghong Song <yonghong=2Esong@linux=2Edev>
>> CC: Jiri Olsa <jolsa@kernel=2Eorg>
>> CC: Emil Tsalapatis <emil@etsalapatis=2Ecom>
>> CC: Ihor Solodrai <ihor=2Esolodrai@linux=2Edev>
>> CC: John Fastabend <john=2Efastabend@gmail=2Ecom>
>> CC: Stanislav Fomichev <sdf@fomichev=2Eme>
>> CC: Simon Horman <horms@kernel=2Eorg>
>> CC: Kuniyuki Iwashima <kuniyu@google=2Ecom>
>> CC: Willem de Bruijn <willemb@google=2Ecom>
>> CC: Jamal Hadi Salim <jhs@mojatatu=2Ecom>
>> CC: Jiri Pirko <jiri@resnulli=2Eus>
>> CC: Sabrina Dubroca <sd@queasysnail=2Enet>
>> CC: Paul Chaignon <paul@isovalent=2Ecom>
>> CC: Alasdair McWilliam <alasdair=2Emcwilliam@isovalent=2Ecom>
>> CC: netdev@vger=2Ekernel=2Eorg
>>=20
>>  =2E=2E=2E/chelsio/inline_crypto/ch_ktls/chcr_ktls=2Ec |  5 ++++-
>>  include/uapi/linux/bpf=2Eh                      |  8 ++++---
>>  net/core/filter=2Ec                             | 22 +++++++++++++----=
--
>>  net/core/sock=2Ec                               |  4 ++++
>>  net/sched/act_bpf=2Ec                           |  4 +++-
>>  net/tls/tls_device_fallback=2Ec                 |  5 +++--
>>  tools/include/uapi/linux/bpf=2Eh                |  8 ++++---
>>  7 files changed, 39 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_kt=
ls=2Ec b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls=2Ec
>> index 4d645771596a=2E=2E796497e9d3b9 100644
>> --- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls=2Ec
>> +++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls=2Ec
>> @@ -1669,7 +1669,10 @@ static void chcr_ktls_copy_record_in_skb(struct =
sk_buff *nskb,
>>  	nskb->truesize +=3D record->len;
>>  	nskb->sk =3D skb->sk;
>>  	nskb->destructor =3D skb->destructor;
>> -	refcount_add(nskb->truesize, &nskb->sk->sk_wmem_alloc);
>> +	if (nskb->destructor =3D=3D sock_pfree_ref)
>> +		sock_hold(nskb->sk);
>> +	else
>> +		refcount_add(nskb->truesize, &nskb->sk->sk_wmem_alloc);
>>  }
>> =20
>>  /*
>> diff --git a/include/uapi/linux/bpf=2Eh b/include/uapi/linux/bpf=2Eh
>> index 62de0919db72=2E=2E45e3018fb2ae 100644
>> --- a/include/uapi/linux/bpf=2Eh
>> +++ b/include/uapi/linux/bpf=2Eh
>> @@ -4611,7 +4611,9 @@ union bpf_attr {
>>   *		**bpf_clone_redirect**\ () or other methods outside of BPF may
>>   *		interfere with successful delivery to the socket=2E
>>   *
>> - *		This operation is only valid from TC ingress path=2E
>> + *		This operation is valid from TC ingress and egress paths=2E
>> + *		On egress, only full refcounted sockets are accepted=2E
>> + *		Software GSO segmentation after assignment is unsupported=2E
>>   *
>>   *		The *flags* argument must be zero=2E
>>   *	Return
>> @@ -4623,8 +4625,8 @@ union bpf_attr {
>>   *
>>   *		**-ENETUNREACH** if the socket is unreachable (wrong netns)=2E
>>   *
>> - *		**-EOPNOTSUPP** if the operation is not supported, for example
>> - *		a call from outside of TC ingress=2E
>> + *		**-EOPNOTSUPP** if the socket is unhashed, or TC egress uses
>> + *		a non-full or non-refcounted socket or a decrypted packet=2E
>>   *
>>   * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, =
u64 flags)
>>   *	Description
>> diff --git a/net/core/filter=2Ec b/net/core/filter=2Ec
>> index 1ad57a371534=2E=2Efeeb752f7a00 100644
>> --- a/net/core/filter=2Ec
>> +++ b/net/core/filter=2Ec
>> @@ -2559,14 +2559,17 @@ int skb_do_redirect(struct sk_buff *skb)
>>  	if (unlikely(!dev))
>>  		goto out_drop;
>> =20
>> +#ifdef CONFIG_INET
>>  	/*
>> -	 * Prefetched sockets may borrow a listener under RCU=2E Orphan them
>> -	 * before redirects that can outlive this section=2E Peer ingress
>> -	 * stays in the same RCU section=2E
>> +	 * Prefetched listeners may be borrowed under RCU=2E Drop borrowed
>> +	 * assignments before redirects that can outlive this section=2E
>> +	 * Peer ingress stays in the same RCU section=2E
>>  	 */
>> -	if (skb_sk_is_prefetched(skb) &&
>> +	if (skb->destructor =3D=3D sock_pfree &&
>> +	    !sk_is_refcounted(skb->sk) &&
>>  	    (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
>>  		skb_orphan(skb);
>> +#endif
>>  	if (flags & BPF_F_PEER) {
>>  		dev =3D skb_get_peer_dev(dev);
>>  		if (unlikely(!dev ||
>> @@ -8115,21 +8118,26 @@ static const struct bpf_func_proto bpf_tcp_gen_=
syncookie_proto =3D {
>> =20
>>  BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u6=
4, flags)
>>  {
>> +	bool egress =3D !skb_at_tc_ingress(skb);
>> +	bool refcounted;
>> +
>>  	if (!sk || flags !=3D 0)
>>  		return -EINVAL;
>> -	if (!skb_at_tc_ingress(skb))
>> +	if (egress && (!sk_fullsock(sk) || !sk_is_refcounted(sk) ||
>> +		       skb_is_decrypted(skb)))
>>  		return -EOPNOTSUPP;
>> +	refcounted =3D egress || sk_is_refcounted(sk);
>>  	if (unlikely(dev_net(skb->dev) !=3D sock_net(sk)))
>>  		return -ENETUNREACH;
>>  	if (sk_unhashed(sk))
>>  		return -EOPNOTSUPP;
>> -	if (sk_is_refcounted(sk) &&
>> +	if (refcounted &&
>>  	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>>  		return -ENOENT;
>> =20
>>  	skb_orphan(skb);
>>  	skb->sk =3D sk;
>> -	skb->destructor =3D sock_pfree;
>> +	skb->destructor =3D egress ? sock_pfree_ref : sock_pfree;
>> =20
>>  	return 0;
>>  }
>
>
>[=2E=2E]
>
>> diff --git a/net/core/sock=2Ec b/net/core/sock=2Ec
>> index 3b1f60eaa73e=2E=2Ef4ec58a86056 100644
>> --- a/net/core/sock=2Ec
>> +++ b/net/core/sock=2Ec
>> @@ -2818,6 +2818,10 @@ static bool can_skb_orphan_partial(const struct =
sk_buff *skb)
>>   */
>>  void skb_orphan_partial(struct sk_buff *skb)
>>  {
>> +#ifdef CONFIG_INET
>> +	if (skb->destructor =3D=3D sock_pfree_ref)
>> +		return;
>> +#endif
>>  	if (skb_is_tcp_pure_ack(skb))
>>  		return;
>> =20
>> diff --git a/net/sched/act_bpf=2Ec b/net/sched/act_bpf=2Ec
>> index 06d8f78b7368=2E=2Ea0918fe9a71a 100644
>> --- a/net/sched/act_bpf=2Ec
>> +++ b/net/sched/act_bpf=2Ec
>> @@ -54,8 +54,10 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *sk=
b,
>>  	}
>>  	if (unlikely(!skb->tstamp && skb->tstamp_type))
>>  		skb->tstamp_type =3D SKB_CLOCK_REALTIME;
>> -	if (skb_sk_is_prefetched(skb) && filter_res !=3D TC_ACT_OK)
>> +#ifdef CONFIG_INET
>> +	if (skb->destructor =3D=3D sock_pfree && filter_res !=3D TC_ACT_OK)
>>  		skb_orphan(skb);
>> +#endif
>> =20
>>  	/* A BPF program may overwrite the default action opcode=2E
>>  	 * Similarly as in cls_bpf, if filter_res =3D=3D -1 we use the
>
>Maybe it's just me, but I don't think all these unrolled =3D=3D
>sock_pfree{,_ref} checks are readable=2E Can we at least have new
>skb_sk_is_prefetched-like wrappers to do these? With clear
>names/comments/intent?

Yeah, generally this approach is problematic because the Tx path explodes =
with changes to
understand the new destructor=2E
In v2 I'll take a different approach and narrow the scope with only netkit=
 support and limited so skbs cannot be put on Tx path, so there will be no =
need to teach the Tx paths about it=2E


