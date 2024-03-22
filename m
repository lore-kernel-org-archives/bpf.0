Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB578B47
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135182; cv=none; b=q1MXOg9U56FJIU3Hv0rnjnN0Pu6FoJx+S9jTo3iMNg3fwseclifcC9tjuPWbdZmD820QwNdiQICjfzB6ofV5ljvFxgLzZmhWzKw039sDkaL25JJorLIJD5naktzVtzP+SJB+btht7gcttJfnC7Ovtmk3z0FqeRq3DV/ip+whxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135182; c=relaxed/simple;
	bh=RGfmVH8gpjyXoctC9K7myqhmZTThRKMnveTfRol3qdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r40tINFDKnYNx3aBkgOtan3j7yXddtHcfC3unGHSnuzAwNbgN5+2ytlBySxD7nGOp0JuACicmWSYEDsnlEi7XuBmaRXC4gRf9tIRJgELKAGIBfMPTcQN2U/+SpeJQt6nqEYvDCnPAHVG4DUaZlyc7iSMYJUIaJHQiIcK4k4vPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nzim08ae; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nzim08ae"
Message-ID: <e0dfc487-6ef3-4bd4-8562-0f557fcedd77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711135178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J9iSLz8zwVJ7f2J/rseMsii4v5TP9Fy+y3RVyWqQHw=;
	b=nzim08ae09jzg0oCvniaM5qKS26xuXdywhQDKeHeNp2fcwwUKUJz0ih1GkB8JR+hw6kKYi
	3yeJfeN9A0ZhXCcYarKuoNBRQ6TWJRsFlTya9jW69g/pLTnuDauTBJf0EkSn/uQQOyEVnN
	6ooAkKm5fJiP5xCcig5ukuMgUkU/LLY=
Date: Fri, 22 Mar 2024 12:19:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/6] libbpf: Add new sec_def "sk_skb/verdict"
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240319175401.2940148-1-yonghong.song@linux.dev>
 <20240319175412.2941149-1-yonghong.song@linux.dev>
 <CAEf4BzZTc0H=GkOZPNAuvZ17Jz8W+yqkpBW5k5Diee31ejjiLA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZTc0H=GkOZPNAuvZ17Jz8W+yqkpBW5k5Diee31ejjiLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 11:47 AM, Andrii Nakryiko wrote:
> On Tue, Mar 19, 2024 at 10:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The new sec_def specifies sk_skb program type with
>> BPF_SK_SKB_VERDICT attachment type. This way, libbpf
>> will set expected_attach_type properly for the program.
>> This will make it easier for later bpf_link based
>> APIs for sk_skb programs.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
> Seems like this was an omission and this program type is already
> supported, right? Should we apply this to libbpf regardless of BPF
> link stuff?

Yes. Feel freel to apply this if you want.

>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 3a756d61c120..7d413415d0d5 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -9312,6 +9312,7 @@ static const struct bpf_sec_def section_defs[] = {
>>          SEC_DEF("sockops",              SOCK_OPS, BPF_CGROUP_SOCK_OPS, SEC_ATTACHABLE_OPT),
>>          SEC_DEF("sk_skb/stream_parser", SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT),
>>          SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT),
>> +       SEC_DEF("sk_skb/verdict",       SK_SKB, BPF_SK_SKB_VERDICT, SEC_ATTACHABLE_OPT),
>>          SEC_DEF("sk_skb",               SK_SKB, 0, SEC_NONE),
>>          SEC_DEF("sk_msg",               SK_MSG, BPF_SK_MSG_VERDICT, SEC_ATTACHABLE_OPT),
>>          SEC_DEF("lirc_mode2",           LIRC_MODE2, BPF_LIRC_MODE2, SEC_ATTACHABLE_OPT),
>> --
>> 2.43.0
>>
>>
