Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785200;
	b=TPUUysIwlYA/isYXpUzRQJL3W0/N3thTn5GiKVA7UQ1I3lFs6l9kRVVDQO331TsxV1Ny
	 sY84REOTJP+p4P8aI2uAacDgfSEz8I7G+c4LhRXDYMsvM58bln43yrlZ7waFGfaejGGV1
	 bM9SuhTH+RO/qN8qqN6bvzZ+8xQkEQqlO/KPOFw0empbHQjE38wuZ162g9NRPjm+1nARQ
	 Jd2+LaNA+0MpzQiypO+dF38EDoduDRMmhcPIzYA8AB9kefQT6peBZMDGugp08LefiVMPA
	 /rQg0+BfFKYlDASxVB2W/9/+UOY6x2aUrqlAN9GVlEFWynhl11ao9wLm4q+L6tg4ufg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=20xh83TZY5Uy9+3Rpue534EqUQXyz0SBbzg5tu3uVBA=;
	b=HBgy6/KQ4tlSVWW28hK3qPzjC3RvPDWJ4J/gwjMsMmLPchHAOlfBrtOqtKTx+NkA76+P
	 w5MqZumThrJX6s9ld7mWOQtMoRcEHJM+PPT8dqMO/FHyFiWsNQNU4kY3JLhJ3hOLiQsGD
	 zbzpcRa9q849eNaihVg74UgL1karr3Jzd2ICyDOMkXQZbceev90nLTOXUzN3f69QXm9Lk
	 2eEVPD7UJfVgiMjcp2SzfF6Jv4N8Qyvy3yIWJt1EZmETxkR/YYzyoIpr5QI0sva90ZL1f
	 O5CERuAA71T5b5WJ4bVpJEhRMf/Hiorf5OzEtbVdpH4APhJTjv5ivfqxDexdLJRYcPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaCpIw98;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245C606A32C
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 23:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4245C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaCpIw98
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cddac941ed1so1265567a12.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 15:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794785200; x=1795390000; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=20xh83TZY5Uy9+3Rpue534EqUQXyz0SBbzg5tu3uVBA=;
        b=VaCpIw98wKkbD9OSdh+EXoit3eBwjIoeGgt9ZEQ7/6yotVqNdI+yVTIV4nDAt39T+g
         hA3v8JQQTbZPLQ9KlTD8PQ65DMoPqKo6NEKaC+Pcs2KJvuZ3uqVAMO0/yGDR5m9WRlbk
         Ttndfl7ARxujEeM3sI+HJOzB6iemESu+bl89ewTirMDu8fwIJofahrTqRx6PxbeMoRAV
         0qpLvcKAlmapM8EW4JaHCqfNGSHmKOsIP4SQ4wrULD8oP08K88628xdIqANFCyWHjMb+
         /gp0OiNl3lkIBbKaBRcHjJK3v0sTsIEZZnnOVJ+vm/tdFHOZZKdjch4O7XBkhnujfW1q
         Vu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794785200; x=1795390000;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20xh83TZY5Uy9+3Rpue534EqUQXyz0SBbzg5tu3uVBA=;
        b=aZCKge3M15Ku3Soo6f3f2S1mDEG69FKWuUblpuZ7e9U+Hoa9K737g0NsyUNHyorlci
         tP3ZS518zrwL5A+eh0GYdhdPsjWv+uKBmAJU1KDSm3wCm5xhT3fD7cKVZRD3wEuEh7Jx
         OpnfyrGLEf9XpaHww1+Ip8nTtynMDpoNtDYU36fYqqaZvYHKdnXezbuttYw8LKbv5mj7
         znNz56cAr8L8wxKCN4z0zMYpMaaXIb1nA+9gqrDQDY3JpdS6jOQQvqaKimcbQBxAAwMg
         /CtI8EHA32KhFlhFm5p9tXbAx9CzP3BRu0uKvzYbcblFPzL6qgFwt+3ola2P+C5ZaHiJ
         Jdew==
X-Gm-Message-State: APuU4Z9PWI+j6QH6g+tSSIR03seChgP08DYF2oPdVRfbOUbrPakeuO3X
	bEA/6Od/82V/sdkCsgY5j8BEMeoPbN9YGhXperjlBAl0en5qw0QXCYyc
X-Gm-Gg: AYBFou02Muu/IWzzM8HBZKJT4fd6teg7oedy+nqtE7NXoj48gu8x9VZMaf7BiYZqSkw
	WkSwb0dpco6MFK/fEjBz0HFccpbAyeA1eDD0lPH1AyBV8d/UHGzaUz95Rp3xG8Jwii2c8iONN7O
	CnMRtIGbmPDy8KCvZcrltDVXOH4QpVTr0yg4/SraA5p1/XkGSkzzCcxXgTz/zyo7KENbXU2pvBz
	w2/dEJzoZt1uI1eiVB/lWaG2pm5DNy46hstDHi2gM2fhXIvE/XqUZkZ0WiGCxI0XQ2ohS+lAiOl
	bZQCCVGfW+HP2LaDduzNB1KGrbq8od04REjSOEA+qCnoaHw5ZZeruzN491AYcJ9rf7D+ihdR3bs
	MmJXyvbOKT27gsqkwDHTyqpTBp/2cDVST0DRPwe5SW32GZNU/bfg2+RLaUPpI1MsvkWG4cIhLzx
	28kOFGAm00EqQnvuk/VpnJip0HxooUD3vPevhK+7A0NSQLNHAz8p1BL0yA0fx8svBGyKbdZ4dph
	vuZ0BjSeHso9LB2w4x8s6uGSfX8PSZzVRl7WyeHCLGEVnaI0gedshChXDqvOzOq/4ZOTZGCgWPI
	S2AdRHXFrdNWqAH5kKiipCXBnvlHHoj91CBveiKDqZpYfOCRtg/YufZQvsYCyW2fgMc+ifWJgw2
	p+Er4Wt/dIjQ5yZZ/jdLekMtZDLAn8JoBYA==
X-Received: by 2002:a17:90b:2e06:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b1b07e1cd4mr8163612a91.6.1794785199420;
        Sun, 15 Nov 2026 15:26:39 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3f09b92sm6832094a91.4.2026.11.15.15.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 15:26:39 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 23:26:38 +0000
Message-Id: <DMW695ICRVGM.2YJJUJQ12T0V6@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf-next v3 0/8] bpf, sockmap: Restrict iter-context
 sockmap updates to sockmap iterators
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Eric Dumazet"
 <edumazet@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>, "Jakub
 Sitnicki" <jakub@cloudflare.com>, "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Stanislav Fomichev" <sdf@fomichev.me>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
 <DMV5NLOEYFGF.C7ITHCRCNA7P@gmail.com>
 <e8f1736e-3f13-4f92-ad69-8b166c41e68a@rbox.co>
In-Reply-To: <e8f1736e-3f13-4f92-ad69-8b166c41e68a@rbox.co>

On Sun Nov 15, 2026 at 11:10 PM UTC, Michal Luczaj wrote:
> On 11/14/26 19:45, Alexei Starovoitov wrote:
>> On Sat Nov 7, 2026 at 5:58 PM UTC, Michal Luczaj wrote:
>>> Follow-up to Sashiko's report [1] and the decision to restrict which
>>> iterator may perform sockmap updates [2]. Series started short: remove
>>> about-to-be-stale test, restrict updates, add a negative test. Then it
>>> expanded: mark bpf_iter__sockmap::sk as PTR_TRUSTED, restrict
>>> bpf_sock_destroy() callers to iter/{tcp,udp}, few little tweaks.
>>>
>>> [1]: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
>>> [2]: https://msgid.link/87echn2fhd.fsf@cloudflare.com
>>>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> Changes in v3:
>>> - Drop RFC prefix
>>> - Update bpf_iter_reg::feature docs
>>> - Fix tcp_request_sock BTF build error
>>> - Restrict allowed callers of bpf_sock_destroy() to iter/{tcp,udp} (Ale=
xei)
>>> - Link to v2: https://patch.msgid.link/20261102-sockmap-update-limit-it=
er-v2-0-e96a63c43b39@rbox.co
>>=20
>> Sorry for the delay. Applied.
>
> No problem, thanks.
>
> To follow up on bpf_iter__unix::unix_sk, looks like there's a single help=
er
> that will become unusable from iter/unix (once plain-PTR_TO_BTF_ID is
> gone): bpf_get_socket_cookie(). PTR_TRUSTED then?

I have a patch that 'forks' bpf_get_socket_cookie() into two helpers.
One for trusted and one for untrusted.

Also have a patch set that removes legacy ptr_to_btf_id for good.
Hopefully will send today or tomorrow.

