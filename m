Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFD26B098;
	Mon, 30 Mar 2026 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852400; cv=none; b=CfO4ngJwc/EDo8VZSSZYwQ1FQhp638g4XkdiiZcd8hKW5p1IL4ciLCkj717qruqz+r9q71uiRuLET2boAx9l5fPo0s6exDeZtJwSRbUq+yRJP2fO9LMFvqx1u4ZXLv6+qP5jaDjQ8U691yHAs58JQmgSH4IzM9vxOyYun6wgPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852400; c=relaxed/simple;
	bh=SR7zxWsSKRYukZRkcC+rvwKSONYGQ0d0HuqYql/cvmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfgJv0oCkUrsxyrbMBXc1CDY0tfmsK9PBylzt94FBfg+E3nFuGIzpmNMu3ZVP2UoReoN+4Z/sSNBwwu3hUUEPpXlSo1eWEiTgWtRBWET1IBWSajfgpR4sSM+zhxHBMbpUTychcwkOKpPxaAo8F/v8mhSLU40wuxt7vWsHyU8KNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YsE3893j; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YsE3893j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1774852358;
	bh=QwAwyPKEeRDtJEBiE0AKekE56B1N0I4QkoDJfGmybmM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YsE3893jy9bb1qvWru/vHbbvw2zj+slgsotPPrh1efvLhWfUB33ppznQ5uzPski9l
	 uYNqDwqxSffDYMFbuWZxiCHRKsS+XcI2xxRnVHA7w4Mf9r688JDPAFSQC5iFppM5+F
	 YSELLEwoam79GzZATF2KhhLMG9/CUlRbnTubWlWI=
X-QQ-mid: zesmtpip2t1774852351t5e113c33
X-QQ-Originating-IP: FeHKKRC4d2NU+gWTFUbxjFQwFeEBtY9LeIJ55sXmoDE=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 30 Mar 2026 14:32:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10286967731782697204
EX-QQ-RecipientCnt: 20
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	haoluo@google.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	kernel@uniontech.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	xulang@uniontech.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf 1/2] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
Date: Mon, 30 Mar 2026 14:32:27 +0800
Message-ID: <FA0A9158227E9982+20260330063228.183119-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <6b534263-62d4-4a0b-abbb-69286ef689f4@linux.dev>
References: <6b534263-62d4-4a0b-abbb-69286ef689f4@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N2E4xZExQMe2s+0U8uDvoq471+XCwzl0mWPZ0keTKlLz5Tml2IKRsiXU
	7l1/G6vGnjv9bZSNE9XjsUoazmCrdQ/fMlT9DR+4cevyK7YcSHLOrGmBtBG7U5PDNCFIyX+
	mOVMc46ggTpVmyLBbdso8q7LVsTrGuMC8qZ0f4dStHTJhf+LfJNlTRQMBUdYu73vRn+VVGc
	eBlHxwYrFULGMmHw3RtM/kHCblY1+2Kmp40Mwp8ZnW+9pu5M2NhugloV0n85v7EzKduQuy4
	ooLsDdgsQh7XTrphlBcvi+gvW6/xXTZ7CXVs+cnSPSd4hXrWbK9lgHNYp0j2Zflnys7IfgA
	/YA98RtPKBZZKf1vJTVtIg1B9SJTCy+4luSyCBlhbrmVb4DRttapeNLgAAUp5ycQbLn43up
	25twYo9DlarYKuMaHo6mPP4c1dddZ/NIsx+cQYKxm7/W+lt6STMtRuuI7uOGcXsKugtUbOQ
	kfKj8IxT5ybxhxhag+V2qyyKKObOi5mxy/wNogOdElq9vy6pAKWKCJ3AzFvlgIzr3kqrVT3
	0QJEpB+lkUw42Mgpt0LEDzdo+9Wp0Wvl6lwgXx3ajiUOKnAZCAkjtxeDxahGpsmjLMnHnq9
	Sm6Umj0TOAeaDxSywtWAPrRprD/raH2jtUsA61EwJv3ECYdOnBOfE5UnIAmze59r4Bz3Bw9
	sz37drQqjQ47OUxMyN5XnL8ucp9XHH48psbFFl2d0TF1sfcxwQ5nfBqKwuhYzfUChjpKAMK
	b3VH5kdL813XEChguZGDn+9kzfbPk4dbTP5CjLme3JkuBUtDIfCLcgG0mjKitYta4nhuTGb
	GH1Rxz5wcSREA+p+DJmqxhs6mxzN26rbdwiFZ7FBVI9PxRAe2KLRkLD/ifUP4Axnii7NPOl
	MAV4kZn3qQf90G7wmbNNFyRow5UE63lLx85hvDEzycJ/K+TH8em0xgP/h4gWL+MCYnLzgHc
	atzUxnU2id7M96k0WYITnoz6YhlvDTefC6aptSmgPCk0zj0DrtvIBWpUYbmTECmn22wd7DZ
	cwE2gtLoaOz7KRT+j+lenw4kZ1K3yftJ1kh4H29ZcDo9ge2AW6JjjcZblTa/DGmqaZQtQ0M
	Fo36TgsprEnBVtV3i7ZJ+YnCw2gXH5rrlF3WxAg4qMYPj/TZDuZFcM=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

>>> This is fixing the src side of the "copy_map_value_long(map, dst, src)".
>>> The src could also be from a skb? What is the value_size that the
>>> verifier is checking for bpf_map_update_elem?
>>
>> The value_size checked by verifier is exactly the size with which
>> the map is defined, i.e., not the size rounded up to 8-byte by kernel
>
>If the verifier ensures only 4-bytes, I am not sure if the helper should
>read 8-bytes.
>
>> As for bpf_map_update_elem->..->copy_map_value_long, 'src' couldn't be from
>> 'skb' which mismatches the expected ptr-type of 'bpf_map_update_elem',
>> I've tried codes like these:
>>
>> 1. bpf_map_update_elem(&lru_map, &key, skb, BPF_ANY);
>> 2. bpf_map_update_elem(&lru_map, &key, skb->sk, BPF_ANY);  // null checked
>> 3. bpf_map_update_elem(&lru_map, &key, skb->flow_keys, BPF_ANY);
>>
>> All these ptrs mismatch the expected ptr-type, which can be detected by the verifier.
>> The verifier complains with msg like 'R3 type=ctx expected=fp, pkt, pkt_meta, map_key,
>> map_value, mem, ringbuf_mem, buf, trusted_ptr'
>
>I meant the __sk_buff->data. Take a look at how skb->data can be used in
>the selftests. __sk_buff->data may not have readable bytes rounded up to
>8. Just one example that the src cannot always be fixed by allocating more.
>
>From looking at git history on pcpu_init_value, the issue should be
>introduced in commit d3bec0138bfb.

Apologies, I missed that point. The 'src' could indeed be from a 'skb'.
Here is my test code:

SEC("cgroup_skb/ingress")
int trigger_oob_skb(struct __sk_buff *skb)
{
	__u32 key = 0;
	void *data, *data_end;
	// try to adjust offset to trigger OOB
	int data_len, offset = 64;

	data = (void *)(long)skb->data;
	data_end = (void *)(long)skb->data_end;

	if (data + offset > (char *)data_end)
		return 1;

	data_len = (char *)data_end - (char *)data;
	bpf_printk("data: %lx, len: %d, skb len: %d, skb: %lx",
		(unsigned long)data, data_len, skb->len, (unsigned long)skb);
	// the verifier rejects  using data_end - 4, so data + offset - 4 used instead.
	bpf_map_update_elem(&lru_pcpu_map, &key, data + offset - 4, BPF_ANY);

	return 1;
}

I've tried for several days, to adjust 'offset' to match the 'data_end', but couldn't
reproduce this OOB since there seems to be always a 'tail room' after the 'data_end'.
I've checked how the buffer of a 'skb' is alloced, take driver 'e1000' for example,
it has many complicated round-up operations, in my test, when I send a UDP package
with payload size less than 210, the alloced buffer size of a skb seems to be always
448, I've also checked the validity of its KASAN shadow memory, it also says 448. when
I go on increasing the payload size(over 210), for example, 211, the buffer size grows
sharply, I haven't found out when the 'data_end' reaches the 'tail end' yet, different
NIC driver may behave differently on the 'tail room'?

So, for now, I'm not quite sure if the skb->data is affected by this OOB, but I will
keep on testing and digging into the skb code.

>The cover letter did not reach the bpf list and patchwork — something is
>wrong with the reply-to. In general, avoid reply-to for multiple
>patches. This makes the thread unmanageable. The revision number is also
>missing in the subject.
>
>Please read submitting-patches.rst before posting again, in particular
>"The canonical patch format" and "In-Reply-To" sections. Test it with
>your inbox first.

As for the patch format, I've reviewed the doc you mentioned, thanks for the correction, 
I will resend the patch series as v3 in a new thread if I make it clear that the skb->data
is not affected by this OOB, or, just make a new fix patch since the former patch can't
work once and for all. In my opinion, 'pcpu_init_value' shouldn't read 8 bytes if it has
no guarantee that the 'src' is rounded up to 8-bytes.

