Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BA140E5F
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635839; cv=none; b=PXQTjoMJOhnNNxoA/VaF8QdZWwqkIBjd0QROqoAAcoAUfSKLw8kqfaG4Kt88HgvsBrSusDep1ktLX+qHgxAlh6mppSvgamNfzRt84FM+dMSX/2MVuIF/DLIpOIGCA97AfM4LWx/oaD6XciioAWm8czUIfNGaE6IbBeD5tebMYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635839; c=relaxed/simple;
	bh=HohdmjZkiHuE1KS2EkyaMJ+BgdeTcr/OPu72LzgASFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjNDfKtQ+fdY412LDXUE1nn3IlHaZfo3x4pKD4Kb1wR0ZmxeSuFTVIyjw8dMEF6yDq8zDEEG81fA9J0fTlbhxkNgRMy2Tg0QaPZwQjC7A2Q9fEcghw0GYI2jHNWFh/zRLooewaaB10Hsou/uoRCGHdi15NymxPkYi59IYOXE3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V3Kifcou; arc=none smtp.client-ip=95.215.58.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V3Kifcou"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HohdmjZkiHuE1KS2EkyaMJ+BgdeTcr/OPu72LzgASFQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787635835; v=1; x=1788240635;
 b=V3KifcoudgO9cit7gle/5wcwbd6EX2uOHM2+CnJuQ2yGLwfnscKSUcsMe2FRudevJNzwY2pk
 DYWrj9gw7C4yIdg9DbW6rrhJjKFRyF21X5td4sQPyYHDG5ANIbRr4vbEz5RaqMJ47osnxjzihUO
 Vqg5f2JDdw/uEJMDEdSw/5xs=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 8351410957924eb3;
	Tue, 25 Aug 2026 05:30:35 +0000
X-Mizu-Trace-ID: 8351410957924eb3
X-Migadu-Flow: FLOW_OUT
Message-ID: <22d83e2e-e732-4549-9bfa-fee38f7c6143@linux.dev>
Date: Tue, 25 Aug 2026 13:30:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cgroup
 link update
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org
References: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
 <b380f7e7-2e0e-4c8c-9a70-e6a577d268cf@linux.dev>
 <CAEf4BzYM+b4E5S6ZCDcpEaw2uvdNPDVUdTgxUxkvCdM86DkubQ@mail.gmail.com>
 <68358803-57c9-4a89-9da3-fb5e12547e0f@linux.dev>
 <CAEf4BzaBxRuU_W=UDoy9EB53PvPWdsEAo0=mV4E-N-bmZ1gs5w@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaBxRuU_W=UDoy9EB53PvPWdsEAo0=mV4E-N-bmZ1gs5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/8/26 04:10, Andrii Nakryiko wrote:
> On Sun, Aug 23, 2026 at 10:04 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 22/8/26 03:35, Andrii Nakryiko wrote:
>>> On Fri, Aug 21, 2026 at 3:26 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>> [...]
>>>>
>>>> Any issue of checking CAP_NET_ADMIN for BPF_LINK_UPDATE?
>>>>
>>>> If no, checking CAP_NET_ADMIN for BPF_LINK_UPDATE looks okay.
>>>>
>>>
>>> Why do we need extra capability checks during LINK_UPDATE if we
>>> already performed the check during LINK_CREATE? If you pass link fd to
>>> some process that doesn't have CAP_NET_ADMIN, but has link fd and
>>> another validated prog fd, they should be able to update the
>>> underlying program without extra checks, IMO.
>>>
>> What if a pinned link is updated by non-CAP_NET_ADMIN users? I (LLM)
>> verified the case by the selftest [1]. Is this case allowed intentionally?
> 
> I (human) think that yes, it's allowed by checking CAP_NET_ADMIN on
> initial LINK_CREATE for a given target and program (which fixes
> program type), and after that FD ownership can be transferred and BPF
> program can atomically be updated by whoever has that link FD (and new
> program's FD).

Got it. Thanks for the explanation.

> 
> But Leon, show a bit more respect to humans next time, please.

Sorry about that. Understand your concern.

Thanks,
Leon

> [...]
