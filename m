Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF53392C3C
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913272; cv=none; b=S+VlBfShuur06S271e6+22dBxsa1gQRiC1UqtYIKqv5cY/F0P6wbXl3spcuDLPmsCD8GcpCLOTgPEYfB3ExFYudu8FPsRB9uGtNm001qViGuYNPSIMKZ8BsUKTB4h0LVE0iIp3NOOk8gwjfvumWb/VkZJ5mNcJKFwnLEnoZCDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913272; c=relaxed/simple;
	bh=1y3sIRO+i9mMyJAEIpsi5HHAo6pg1KHpSiMVhy4nVYk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NlwpZJfJAAP5M44eUVXJL0Uww2FlqxprOj6Q8O2ifSTphgL2Z2OLMe5dl/iBST+5lElu8/BAwvSJlxadLTogAl8TwPjs/dMLAfAyvhsz0Kvvn397woUZqJo7Ywjy7/keb8JQanyPABBVoHOGBfFuBs8//Oip3Nlt9o9bXt5QUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g/W15PpL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g/W15PpL"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso70517765e9.0
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 11:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772913267; x=1773518067; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRapRrMQzfVb1zc8bjuWvKtij1EZN6NyZd+CGQgeUqY=;
        b=g/W15PpLYwevvKhlFNQMj8vDmrLs6bnDdNjvdRwldmaau4ruLQ9TG6xRkiyCHqzwu6
         7xFUqz4O8LyQanSHBuiWo5moUnQsBGP7NumZQvshTWRcersdQLEgMQem5MXec3g2KLZI
         nWTobCt3XFoaHPgaYl8IegcnrhaEUmcjC3bsCuWSwc7PAUdqoQ78SlW+ERyacZrv6QOh
         E9+7kFyRdE7mpDtH0Z1yQKuR1m8J07glTMHtNjVBtuHeoQYVQFsJhfcPD9Zt66Q7SFqe
         /34ts4qxVxFdb8tQQfhehHrEOpjd/vzPwrEwpJ6+1l8psaJ4vH2GDlArRnkIvLPN4H6r
         478g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772913267; x=1773518067;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRapRrMQzfVb1zc8bjuWvKtij1EZN6NyZd+CGQgeUqY=;
        b=sGvv11G6YJKE/Q25bnAYYRWDQsT+lSEKo19YkPZkxHoMdWAzQPKAtXF7OoFOESHcru
         sSwRdbVDhL3Q9f6o/MaWdIHYkdcjDrSSePVFSOV1RkwdVys9A0kMh2l304FYMVjZx7ub
         pv8FMw3sGUHwoyZuon91ZqF2WWOzvxj7/wO5SvwyMOqljUDbnxejRuX6xMcMwczGUTWs
         DzUPY24KkQa1SQT7UOkBllbsHYOq7WkzAj4ADBKwlNu/scZa7L4qDkQeLXlxASWRdBp8
         hUzDCu4pmDip+lBIfaBBNNuswPkcDvfAvDEByIsZEidoFgxpQpc16SXzmiue2WyTZJEU
         b1ng==
X-Forwarded-Encrypted: i=1; AJvYcCWACNqsRph75SSl9U1F6OnFQhu+WJJKMrgeuuy1SzyzCaMEXbPrtHbZj44/9r6MwMIIKk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYAOnUHF1sBnAI9HSdldIIJXB8H5ZUQyluvVqD6l0w/1j9UwS
	Ih8iYT11mO8+8Rmzh7+SuI81aWoO3fqQzQxF6xzMqALQPWLpmqoXjN05OJNH/GWhr0Q=
X-Gm-Gg: ATEYQzy/U9YmDISdovD8NNqXOFRfQ4ynXE2HMAvTrOdxOWscN3afJgbtJ45RWWJVGun
	FIV1O9cu2+qKXsyBmk1XD0ZiFbg0zOqwEqCbx01H48av32fmTDxaV7klT3kO8krmzsA9iSH9NVI
	hahz9s1HwApjAukL9rGnaYK4RzSdVAYHA/kpNirzjpXKQgjuZaDT6psDdahljWV8hKCvBJigWt+
	JqqGfm1dT6MMj90VUOYkb8udbKWCsukJCkFhBIWC14zU3lAnaogi0GlamnZ1AJgzcr/nOkBh9bP
	oQ40v9JXAZesrzYSpcyi/CNtKuE5l0H2Yy84GP5Si+X3b+tdXT1plW7WSkO64LVgOwTui/liCYg
	T4Ehbv/jP2bx1wCq2i44qeWVIJb4cw/iA7qhA8rl+xELIFY5A786+Pm3WpfztXnDTR/0bpgz+Mp
	6e2/FdTgUljw==
X-Received: by 2002:a05:600c:3e0b:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-4851ee6a3fcmr176036785e9.1.1772913267309;
        Sat, 07 Mar 2026 11:54:27 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b57ec19sm5145450241.14.2026.03.07.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 11:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Mar 2026 16:54:22 -0300
Message-Id: <DGWTAT5RG00Q.3OB5QRCWISVA5@suse.com>
Subject: Re: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Cc: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, "David Ahern" <dsahern@kernel.org>, "Jay Vosburgh"
 <jv@jvosburgh.net>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Hangbin Liu"
 <liuhangbin@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>, "Jakub Kicinski"
 <kuba@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-g0a16d1784be2
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
 <20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
 <20260305182521.0ca7313c@kernel.org>
 <b3477010-6fdd-4bec-8951-152b12bf56e6@suse.de>
 <20260306183914.4b13a03d@kernel.org>
 <691d5589-46ea-4947-9510-bfd9d991ed02@suse.de>
In-Reply-To: <691d5589-46ea-4947-9510-bfd9d991ed02@suse.de>

On Sat Mar 7, 2026 at 4:27 AM -03, Fernando Fernandez Mancera wrote:
> On 3/7/26 3:39 AM, Jakub Kicinski wrote:
>> On Fri, 6 Mar 2026 10:58:44 +0100 Fernando Fernandez Mancera wrote:
>>>>> +	if (unlikely(!ipv6_stub->nd_tbl))
>>>>> +		goto out_drop;
>>>>
>>>> So neither Fernando nor you checked whether this code can be built
>>>> as a module? ipv6_mod_enabled() should work just fine
>>>
>>> I checked it. If IPV6=3Dm this is not fine.
>>>
>>> ld: vmlinux.o: in function `bpf_out_neigh_v6':
>>> filter.c:(.text+0x3231d60): undefined reference to `ipv6_mod_enabled'
>>=20
>> Guess I got it backwards :/ Should we add this to the series?
>>=20

Nice, thank you!

>
> No worries.
>
>> -->8--------
>> Subject: ipv6: move the disable_ipv6_mod knob to core code
>>=20
>> Make sure disable_ipv6_mod itself is not part of the IPv6 module,
>> in case core code wants to refer to it. We will remove support
>> for IPv6=3Dm soon, this change helps make fixes we commit before
>> that less messy.
>>=20
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>
> Ricardo could you add it and check if it is fine? FWIW; I am sending=20
> today the series removing IPV6=3Dm after some testing to net-next tree.

Will do!

>
> Thanks,
> Fernando.
>
>>   include/linux/ipv6.h | 7 ++++++-
>>   net/ipv4/af_inet.c   | 6 ++++++
>>   net/ipv6/af_inet6.c  | 8 --------
>>   3 files changed, 12 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
>> index 443053a76dcf..e5b6853d517a 100644
>> --- a/include/linux/ipv6.h
>> +++ b/include/linux/ipv6.h
>> @@ -333,7 +333,12 @@ struct tcp6_timewait_sock {
>>   };
>>  =20
>>   #if IS_ENABLED(CONFIG_IPV6)
>> -bool ipv6_mod_enabled(void);
>> +extern int disable_ipv6_mod;
>> +
>> +static inline bool ipv6_mod_enabled(void)
>> +{
>> +        return disable_ipv6_mod =3D=3D 0;
>> +}
>>  =20
>>   static inline struct ipv6_pinfo *inet6_sk(const struct sock *__sk)
>>   {
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index babcd75a08e2..f1944e8fd9d3 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -124,6 +124,12 @@
>>  =20
>>   #include <trace/events/sock.h>
>>  =20
>> +/* Keep the definition of IPv6 disable here for now, to avoid annoying =
linker
>> + * issues in case IPv6=3Dm
>> + */
>> +int disable_ipv6_mod;
>> +EXPORT_SYMBOL(disable_ipv6_mod);
>> +
>>   /* The inetsw table contains everything that inet_create needs to
>>    * build a new socket.
>>    */
>> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
>> index 0b995a961359..03c175cbbdb6 100644
>> --- a/net/ipv6/af_inet6.c
>> +++ b/net/ipv6/af_inet6.c
>> @@ -86,8 +86,6 @@ struct ipv6_params ipv6_defaults =3D {
>>   	.autoconf =3D 1,
>>   };
>>  =20
>> -static int disable_ipv6_mod;
>> -
>>   module_param_named(disable, disable_ipv6_mod, int, 0444);
>>   MODULE_PARM_DESC(disable, "Disable IPv6 module such that it is non-fun=
ctional");
>>  =20
>> @@ -97,12 +95,6 @@ MODULE_PARM_DESC(disable_ipv6, "Disable IPv6 on all i=
nterfaces");
>>   module_param_named(autoconf, ipv6_defaults.autoconf, int, 0444);
>>   MODULE_PARM_DESC(autoconf, "Enable IPv6 address autoconfiguration on a=
ll interfaces");
>>  =20
>> -bool ipv6_mod_enabled(void)
>> -{
>> -	return disable_ipv6_mod =3D=3D 0;
>> -}
>> -EXPORT_SYMBOL_GPL(ipv6_mod_enabled);
>> -
>>   static struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
>>   {
>>   	const int offset =3D sk->sk_prot->ipv6_pinfo_offset;

