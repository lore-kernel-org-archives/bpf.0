Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD3153BF3
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178041; cv=none; b=INOaXw3ssbWjeI85R2MT0cEs3qPgqqSqXyfBO6ozRJxggKpXr54pV6M5SYetOlBBnhauDjWM6vHu5WvYJv0ZpNFI+WSfMSTA7FBHT7x046mAdwSKBFkVI+g4U26Cg30jRpX82HfCiJudfCnM/U21uxe4+RfHz0i4ssZww8yJUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178041; c=relaxed/simple;
	bh=V054xP61X0vGaL/+EaU5RyoIWjJS4xPB2W3UtrfjGUA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eHfZON/OXSc3hf4jA9KLmJ/dU5GMDw9+Tfunt286RpOV+kJaKshGRzo8rwa85Vqk6wW0hEQPeZczdslkLsGA4zkZTowUOuuBnPARBD6Exnor6VrhREGtWB0V/BFJ40PJlmB3bjG14VO3udTPM8/wvtdcStavE8LC2z19+HhPNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=q7olM8UA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="q7olM8UA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hdSg7j3s6s7iJVzpZ6gy50o7G5UWqCY9rpkccaJqW/8=; b=q7olM8UA1ujAFSdSCQXR+p/SXk
	cY4SwNfQyYTMoWnLNqZQewHqBBPOYSTFiLBLNeHe8Kpnvr/Hm02Z25Oj6FSzqVCpqJJk1vSxIau5J
	QK9nY96jr2qk5NQbaF+LxZNbbS5yh3OAHBExMBgihvrYSh0ID8c7Gs0+I6b7AQtZXCqhHZRWcu6oD
	xmkHT2JJ2yzmc9DEFlgetgIJJstNN0zwhrEKU+7SeaWEr24dggK2D1YbYi/D5t8tlUI2BnQfCTx2z
	S4FScA3I1CQC5lZZqYW802wY8IfgBkET6fzp2UrnNdEKVpn+A+7FjscyzoLMUQN4BTVN4cpKPNSOS
	03dPL/Rg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs7if-000E0q-BH; Wed, 03 Apr 2024 23:00:29 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs7ie-008jQ1-2K;
	Wed, 03 Apr 2024 23:00:28 +0200
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
To: Arnd Bergmann <arnd@arndb.de>, Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20240403123303.1452184-1-aspsk@isovalent.com>
 <18d8417d-835c-4279-9f84-abdc56fa19fb@app.fastmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <728951fe-ccd5-49d2-1584-fc97e2c2266e@iogearbox.net>
Date: Wed, 3 Apr 2024 23:00:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <18d8417d-835c-4279-9f84-abdc56fa19fb@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

On 4/3/24 10:09 PM, Arnd Bergmann wrote:
> On Wed, Apr 3, 2024, at 14:33, Anton Protopopov wrote:
>> The struct bpf_fib_lookup is supposed to be of size 64. A recent commit
>> 59b418c7063d ("bpf: Add a check for struct bpf_fib_lookup size") added
>> a static assertion to check this property so that future changes to the
>> structure will not accidentally break this assumption.
>>
>> As it immediately turned out, on some 32-bit arm systems, when AEABI=n,
>> the total size of the structure was equal to 68, see [1]. This happened
>> because the bpf_fib_lookup structure contains a union of two 16-bit
>> fields:
>>
>>      union {
>>              __u16 tot_len;
>>              __u16 mtu_result;
>>      };
> 
> This union was introduced three years ago, so fixing it now means
> another incompatible ABI change. While you clearly change it back
> to what it should have been the entire time, it's not obvious that
> this is the correct thing to do after three years.
> 
> I do wonder to what degree we still want to care about OABI
> at all. As I mentioned, I stopped testing it myself because it
> is no longer relevant to most people, and there are probably
> a number of other ABI issues.
> 
>> which was supposed to compile to a 16-bit-aligned 16-bit field. On the
>> aforementioned setups it was instead both aligned and padded to 32-bits.
>>
>> Declare this inner union as __attribute__((packed, aligned(2))) such
>> that it always is of size 2 and is aligned to 16 bits.
> 
> I think you probably want 32-bit alignment for the structure,
> to keep the ABI unchanged on all other architectures.

Fwiw, on x86 nothing should change on this regard, see below pahole dump
before/after. I think similar might be true for other archs as otherwise
we should have seen a kbuild bot complaint on hitting the size assert.

So it seems at this point only for the reported case of AEABI=n ... if it
is no longer relevant to most people, I'd think the likelihood of such
users and users who utilize this specific helper is even smaller. But we
could queue it to bpf-next to give it some time.

Before patch:

struct bpf_fib_lookup {
         __u8                       family;               /*     0     1 */
         __u8                       l4_protocol;          /*     1     1 */
         __be16                     sport;                /*     2     2 */
         __be16                     dport;                /*     4     2 */
         union {
                 __u16              tot_len;              /*     6     2 */
                 __u16              mtu_result;           /*     6     2 */
         };                                               /*     6     2 */
         __u32                      ifindex;              /*     8     4 */
         union {
                 __u8               tos;                  /*    12     1 */
                 __be32             flowinfo;             /*    12     4 */
                 __u32              rt_metric;            /*    12     4 */
         };                                               /*    12     4 */
         union {
                 __be32             ipv4_src;             /*    16     4 */
                 __u32              ipv6_src[4];          /*    16    16 */
         };                                               /*    16    16 */
         union {
                 __be32             ipv4_dst;             /*    32     4 */
                 __u32              ipv6_dst[4];          /*    32    16 */
         };                                               /*    32    16 */
         union {
                 struct {
                         __be16     h_vlan_proto;         /*    48     2 */
                         __be16     h_vlan_TCI;           /*    50     2 */
                 };                                       /*    48     4 */
                 __u32              tbid;                 /*    48     4 */
         };                                               /*    48     4 */
         __u8                       smac[6];              /*    52     6 */
         __u8                       dmac[6];              /*    58     6 */

         /* size: 64, cachelines: 1, members: 12 */
};

After patch:

struct bpf_fib_lookup {
         __u8                       family;               /*     0     1 */
         __u8                       l4_protocol;          /*     1     1 */
         __be16                     sport;                /*     2     2 */
         __be16                     dport;                /*     4     2 */
         union {
                 __u16              tot_len;              /*     6     2 */
                 __u16              mtu_result;           /*     6     2 */
         } __attribute__((__aligned__(2)));               /*     6     2 */
         __u32                      ifindex;              /*     8     4 */
         union {
                 __u8               tos;                  /*    12     1 */
                 __be32             flowinfo;             /*    12     4 */
                 __u32              rt_metric;            /*    12     4 */
         };                                               /*    12     4 */
         union {
                 __be32             ipv4_src;             /*    16     4 */
                 __u32              ipv6_src[4];          /*    16    16 */
         };                                               /*    16    16 */
         union {
                 __be32             ipv4_dst;             /*    32     4 */
                 __u32              ipv6_dst[4];          /*    32    16 */
         };                                               /*    32    16 */
         union {
                 struct {
                         __be16     h_vlan_proto;         /*    48     2 */
                         __be16     h_vlan_TCI;           /*    50     2 */
                 };                                       /*    48     4 */
                 __u32              tbid;                 /*    48     4 */
         };                                               /*    48     4 */
         __u8                       smac[6];              /*    52     6 */
         __u8                       dmac[6];              /*    58     6 */

         /* size: 64, cachelines: 1, members: 12 */
         /* forced alignments: 1 */
} __attribute__((__aligned__(4)));

Thanks,
Daniel
