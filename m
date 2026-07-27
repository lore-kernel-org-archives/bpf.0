Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174CC25B0BE
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194395; cv=none; b=n47cTansBjOuRcpmSugpT20C2PytCdG0jWd0sjI8Sy+7XMvlEzFLa+EhdgpwshOKUpkVXG42wLRKq+RFe8vpkMbXgV8bIplf/SlIUoozC5LXVsfInP083m89A7269T9lwH3/SFUxnRPKlk2z/9FvNkjrcXI6k+vMlEyMUiI2x7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194395; c=relaxed/simple;
	bh=vqZsukyfPFlCsGIHPmji0dINVoYYCORoyRlFMHwEkfE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=NotM9wYLSSru158TNr8iSny7Jeng/GgtYrOdjk2ay8GCTiogmEckCu8Stzt/pFDIgHFgLLDzeSltLjw4d3cHAjG6VFmaS6SVKM+klGfLDJ6ei8uXXddvDV16yZ8F5ruLAljtUS6DW3UL+LyjnRW8PWDyorglbxDAPTG8YiBqOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=waTGuKp2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="waTGuKp2"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84874b52eabso4382348b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785194393; x=1785799193; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04eYvslAHHNmbnCC9MM68slhst/lYwvmeA8ooU3iD0A=;
        b=waTGuKp2qSyX0xD4xnH8jQXPaqKUi//bj25Ym5gjuXrgpaFcNMb3wv2iFJZ+crmdnW
         TS0y6b5hgeVugUqzIbXbH7hvUPKq+QGwP9oaSm4YYTqVikgueBDzf5G+yB95+Xi1BKyS
         mAFV1Q4x4mxF5u9OHoKtyBv+8xpOqfJNjA+cWOzzmvl+1gz7jv+hYopXH4QrcS3ef7vb
         4CVshnt3Jo3xLLV0NJj+4UchBNToj/Cy1305sjKa+OwzEdNIEC0F/x8r2rwJDzOp8ehd
         MMoA/N7E/mCJCHsZlgOORcdhIW9+6MBPvQy4NExI4G3golvkyFqbwrpaCU/EpKpifG7k
         CNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194393; x=1785799193;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=04eYvslAHHNmbnCC9MM68slhst/lYwvmeA8ooU3iD0A=;
        b=K8BElhsYDFLyVo7yZZAam4sGenM0reCpIE4ofQifFicJqU4G0b847BzRaroYXtge48
         Oc/n6EPo7JJpAkrYSmr2s1d133nqZ7wza4oAhksuhoQzTxgktpeqJ47O2lWA/Doqu3H7
         UiTbyK9J6B+qyvbULZNc8poC5yeoGDbFOEAWRhUtC3Lz//t30iS0ABwDwEU6MlZOWL3D
         t5IhvluZSlu5ZIivuaM7RQ0saXk4sHoAVgCPUGVzupryDuJ3lujg4RX2EYfN4fDdsfxq
         HSKHoljpaICP0QvO58K6HQuZ6lOOoSOiYy0tE0CYfx2BX8LQWY4uywxrK7d4odoMAzsZ
         OR3A==
X-Forwarded-Encrypted: i=1; AHgh+Rp/1jueJ00hu9XDCZWbIoeszy5GBTsbecKUvf6QVB3TSlSGjiHSgphvd2g7IldKuHBDnKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVdP3Mxw/f2DdwLJ8o47N0+tFeumof47B5C8YE2f+bvGtq3VI
	MiUqSoaIVoE5AcP+xe0BTWEAAe6z2pLPbPV6F1XBaCvmGpZde2cns8ihVEYooR0V/Pc=
X-Gm-Gg: AR+sD13f/H8LuXu5Y4aNVzw7X1qVEp7JXAYCu9ZxyHBPAjmqUBKFv4LYJszc4JQ8QLz
	58JivFAhbd8h5E4Ar6gho9o7U7oY6TGU4x2e/h0dq/YEj175mnYdM8wK7nwjVp/zNs0ShSl6Hjx
	C73M9Ju4fwNoT/9R1ibcHQviyrprPM0lkKo96dz8nSrqUINtbMMytwzr76EiZgPEg9XaW3xLNJS
	IvwPRA5xnlF8dSo5m+sOOrKltFeQwohbS54rMQfLY2s6Zp2hMn64JP9XhO/z10hX3nMmWXlkMhX
	KQJ9ndHLUMOyOKpLrR0TxYpZhuOG6ZsiAUVlqEts/EBlk0XMLrtuptK94VqmVw1AVDXtKOJfjPX
	7ency0n8hN2DhVGLXggUKhV7rpsZPV9mHyIEFVXlML+vptz+hHq7w16ofwbJUZImz85uDWSZROc
	27hPtR5JIgq6op/cKUpoEyPeE5ly4Y4HA=
X-Received: by 2002:a05:6a00:1941:b0:845:4d71:8d15 with SMTP id d2e1a72fcca58-84e59568c44mr8650243b3a.37.1785194393420;
        Mon, 27 Jul 2026 16:19:53 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b282asm3910533a12.18.2026.07.27.16.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 16:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 19:19:51 -0400
Message-Id: <DK9QLHKY1WSN.24XILC0RTLJZM@etsalapatis.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
 <dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "kuniyu@google.com" <kuniyu@google.com>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v4 net-next 1/1] tcp: allow congestion controls to
 override TSO autosizing
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260726193802.397321-1-chia-yu.chang@nokia-bell-labs.com>
 <PAXPR07MB79842FC5D44F3964BFEDA505A3CC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB79842FC5D44F3964BFEDA505A3CC2@PAXPR07MB7984.eurprd07.prod.outlook.com>

On Mon Jul 27, 2026 at 4:02 AM EDT, Chia-Yu Chang (Nokia) wrote:
>> -----Original Message-----
>> From: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>=20
>> Sent: Sunday, July 26, 2026 9:38 PM
>> To: horms@kernel.org; dsahern@kernel.org; bpf@vger.kernel.org; netdev@vg=
er.kernel.org; pabeni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephe=
n@networkplumber.org; davem@davemloft.net; edumazet@google.com; andrew+netd=
ev@lunn.ch; donald.hunter@gmail.com; kuniyu@google.com; ij@kernel.org; ncar=
dwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-lab=
s.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kueh=
lewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@co=
mcast.com; vidhi_goel@apple.com
>> Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
>> Subject: [PATCH v4 net-next 1/1] tcp: allow congestion controls to overr=
ide TSO autosizing
>>=20
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>=20

Hi Chia-Yu,

Sorry for the late reply. From the BPF side we had a discussion and
concluded that going ahead with the original change to the struct_ops
without adding a union is fine. AFAIU this is the main delta between v3
and v4, in which case we can go ahead with v3.

>> Today, congestion control algorithms influence TSO sizing through the
>> min_tso_segs() callback, which provides the minimum number of segments u=
sed by tcp_tso_autosize(). However, Prague congestion control requires fine=
r control and needs to determine the final TSO segment count directly rathe=
r than only providing a minimum bound.
>> =20
>> This patch introduces TCP_CONG_EXACT_TSO_SEGS flag and extends tcp_conge=
stion_ops with an alternative tso_segs() callback. When the flag is set, th=
e congestion control algorithm supplies the final TSO segment count directl=
y and bypasses tcp_tso_autosize(). Otherwise, the existing min_tso_segs() c=
allback continues to provide the minimum segment count used by tcp_tso_auto=
size().
>>=20
>> This preserves the existing behavior of current congestion control algor=
ithms without introducing additional callbacks while enabling future algori=
thms to implement custom TSO sizing policies.
>>=20
>> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
>> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>> ---
>>  include/net/tcp.h     | 16 +++++++++++++---
>>  net/ipv4/tcp_output.c | 17 +++++++++++++----
>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/include/net/tcp.h b/include/net/tcp.h index 2c5b889530b5..8=
2cd82a19ff9 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1283,9 +1283,11 @@ enum tcp_ca_ack_event_flags {
>>  #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
>>  /* Cannot fallback to RFC3168 during AccECN negotiation */
>>  #define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
>> +/* Congestion cotnrol provides the exact TSO segment numbers  */
>> +#define TCP_CONG_EXACT_TSO_SEGS		BIT(5)
>>  #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | =
\
>>  			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
>> -			TCP_CONG_NO_FALLBACK_RFC3168)
>> +			TCP_CONG_NO_FALLBACK_RFC3168 | TCP_CONG_EXACT_TSO_SEGS)
>> =20
>>  union tcp_cc_info;
>> =20
>> @@ -1361,8 +1363,16 @@ struct tcp_congestion_ops {
>>  	/* hook for packet ack accounting (optional) */
>>  	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
>> =20
>> -	/* override sysctl_tcp_min_tso_segs (optional) */
>> -	u32 (*min_tso_segs)(struct sock *sk);
>> +	union {
>> +		/* Used when TCP_CONG_EXACT_TSO_SEGS is not set,
>> +		 * override sysctl_tcp_min_tso_segs (optional)
>> +		 */
>> +		u32 (*min_tso_segs)(struct sock *sk);
>> +		/* Used when TCP_CONG_EXACT_TSO_SEGS is set,
>> +		 * override tcp_tso_autosize (optional)
>> +		 */
>> +		u32 (*tso_segs)(struct sock *sk, u32 mss_now);
>> +	};
>> =20
>>  	/* new value of cwnd after loss (required) */
>>  	u32  (*undo_cwnd)(struct sock *sk);
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c index d7c1444=
b5e30..0de27a87c39e 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -2278,11 +2278,20 @@ static u32 tcp_tso_segs(struct sock *sk, unsigne=
d int mss_now)
>>  	const struct tcp_congestion_ops *ca_ops =3D inet_csk(sk)->icsk_ca_ops;
>>  	u32 min_tso, tso_segs;
>> =20
>> -	min_tso =3D ca_ops->min_tso_segs ?
>> -			ca_ops->min_tso_segs(sk) :
>> -			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
>> +	min_tso =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
>> +
>> +	if (ca_ops->flags & TCP_CONG_EXACT_TSO_SEGS) {
>> +		if (WARN_ON_ONCE(!ca_ops->tso_segs))
>> +			tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
>> +		else
>> +			tso_segs =3D ca_ops->tso_segs(sk, mss_now);
>> +	} else {
>> +		if (ca_ops->min_tso_segs)
>> +			min_tso =3D ca_ops->min_tso_segs(sk);
>> +
>> +		tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
>> +	}
>> =20
>> -	tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
>>  	return min_t(u32, tso_segs, sk->sk_gso_max_segs);  }
>
> Hello,
>
> I see this commit is marked as Changes Requested; however, I do not see a=
ny request yet.
>
> Could anyone let me know which specific request it is?
>
> This commit updated our previously submitted v3 https://lore.kernel.org/a=
ll/20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com/ to have no im=
pact on BPF.

>
> Thanks!
> Chia-Yu

