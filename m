Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D937BE63
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320879; cv=none; b=pjD7ou0J5gBmA6piqlwKpXTbCW8X75m9bvGVcFL7rsZVksAQFYZPaCp/rTOBHKX6b05xLYjTjgIu66cnwqK/4p+0565p+UPvqhoFOuAChg1HH+DfMDa0iyW7AIEvFiJkdjXraxXoGXzsCav9pkk73yWcB+ekJkSxMpa41LPL7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320879; c=relaxed/simple;
	bh=X8caLbf7VqM/HUny6jQVmEvKfAvjcQdyohYFfe5hNww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kseJ0HXKxdiVvwpmULWyrNkTkhPfIpBgyIZIry5EX8Jmm1mkPthhfFHCsYr+Bx5cCg0tCmBkBmanCzdxgMlxKFnpDx3iGuWXFIsj2WAEnBKoO+bjXSYUN9JLNin4SuZ8o01yalMlLZMIVB07y7xBzzp/1G8YBsUQ0UkD8w+i6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WzjldJ3z; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WzjldJ3z"
Message-ID: <a8d7cd87-81ad-4f98-9dbd-64876dd20459@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780320866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnGI9YHRJnJNK6E7eJ2SMEcHpx+aVb70uazVy8mgK6E=;
	b=WzjldJ3zTijskKJcuM+oSqk8nWvCIjCLVoP7lmhBXG7pAh0eH0pmbea/PXPKCKdXN7+ykI
	hhbb6jo1tePpCZUdnveerFjzrzFRExozu0fJzDkpz62ZfrkzVvpPkJkCBrlh+sqLh3RMD8
	mTxjsLOysl3zqeIzFqzRRmvU8PLiSUU=
Date: Mon, 1 Jun 2026 21:34:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/4] bpf: Fix TOCTOU issue in lwt
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Peter Oskolkov <posk@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260529151351.69911-1-leon.hwang@linux.dev>
 <20260529151351.69911-2-leon.hwang@linux.dev>
 <CAADnVQLh7VEKAtckzz=XOVPT8ovpDQshvPPCWHDQu2OWQx27_w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLh7VEKAtckzz=XOVPT8ovpDQshvPPCWHDQu2OWQx27_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/6/1 08:44, Alexei Starovoitov wrote:
> On Fri, May 29, 2026 at 8:14 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Sashiko pointed out [1]:
>> The hdr pointer passed to bpf_lwt_push_ip_encap() can point to concurrently
>> mutable memory such as a BPF map value.
>>
>> So, the memory of hdr pointer can be updated after skb_postpush_rcsum().
>>
>> To fix it, memcpy() the hdr to a local buffer, which will be used for the
>> following checks and updates.
>>
>> [1] https://lore.kernel.org/bpf/20260525150010.CDEBA1F000E9@smtp.kernel.org/
>>
>> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  net/core/lwt_bpf.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index f71ef82a5f3d..8009e427851f 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
>>
>>  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>>  {
>> +       u8 buff[LWT_BPF_MAX_HEADROOM];
> 
> extra 256 bytes of stack to partially close a hypothetical issue
> is not worth it.
> Ignore such AI complaints.
> Not every "bug" needs a fix.
> If a malicious bpf user wants to crash the kernel they will
> find a way to do so. Especially with agents.
> We cannot realistically close all of the holes.
> Right now the priority is to fix the issues that normal
> users can hit and not bots.
> 

Ack.

Will focus on the fix for encapsulating VxLAN in lwt.

Thanks,
Leon

