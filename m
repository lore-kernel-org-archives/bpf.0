Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2437419A
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502700; cv=none; b=f3mlV0XnMs0iHmbFDcaFiBBte83hTCRiVSX1zE+WsnATcRE4BqdCMcmeKW+oD7WJIYjn5gcoI+IeqMJSqkLQbG1J35rUFzUTYHfuqlZbkksc6Cx3HHHCIS8K/GmVsWVqfDA24a9uvJtrIY8ncxFdSDWDSebSw5tcytajw5k6uj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502700; c=relaxed/simple;
	bh=QR9xC+LbZjTEcw2B3g6RGPgRmzHv4fIjmH/+ye7UnDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3SlWx3sAEzB9bTVrwjOe+f7Mfu7Tu3MytSj7tHunST/W9oJJUEJj/oqjQS+vdK4UUGUl+yTOjJJzS4Jsme246l576y4sh5VTDzv7escDmH5D/SyEVnCpM/R2CR/nAclRrJmCgAKP1GS6XTpO77jJNjuK4HGtK2jFbULNRGsFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bm5NO3tr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bm5NO3tr"
Message-ID: <f38608e1-4e85-4bc4-8872-c9ecf38e5d7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772502686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6veD8qM4F+WyZg576UBUjZ2Qmn0u8K3QCi47PEsWrI=;
	b=Bm5NO3trAPfude3N6WDHXMoo5/emzVqA759MZb7U4Ltx4YakxOrYeuBn5F/zsr8qmw538h
	Pvgjz5Y+vsWw7ahEeJjuB+JU++N4PnCPLfZo55eb/ypkGWnJ5NWLnmfQsZcZ/A3leEt8Sw
	S83EC/8fTfoiwKGlHYh7+RS/u8VNsWY=
Date: Mon, 2 Mar 2026 17:51:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific
 lock
To: Michal Luczaj <mhal@rbox.co>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemb@google.com>, Cong Wang <cong.wang@bytedance.com>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
 <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
 <CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com>
 <c4eaead1-ad69-42f0-9699-5f2d555a7693@rbox.co>
 <a2f2c260-38e8-4ba3-8655-cffbee046259@linux.dev>
 <b75bbc3f-85fd-4209-9ce1-3bf685ba62ff@rbox.co>
 <d122ed8b-ebfb-4d59-96ce-10c361e76676@linux.dev>
 <1022fcaf-ca38-43d2-84cb-f66a504335e1@rbox.co>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <1022fcaf-ca38-43d2-84cb-f66a504335e1@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/24/26 7:28 AM, Michal Luczaj wrote:
> On 2/23/26 22:43, Martin KaFai Lau wrote:
>>
>> On 2/11/26 2:02 AM, Michal Luczaj wrote:
>>>> It should also be helpful to be consistent with tcp/udp iter and use
>>>> lock_sock() instead of lock_sock_fast() in bpf_iter_unix_seq_show().
>>> OK, I'll tweak that in v3.
>>
>> Hi, Michal. Are you planning to send v3 soon? I don't think the
>> sock_owned_by_user for the non-tracing prog needs to be addressed in the
>> same set.
> 
> Yes, I'm working on it. Sorry for the delay, I'm taking my sweet time to
> come up with a selftest.
> 
> I think I can neatly fit the sock_owned_by_user()-related stuff in this
> series, but let me know if you'd rather have it separately. Whichever way,
> I don't mind.

I think sock_owned_by_user() is not related to the AF_UNIX's sockmap 
fix. If it is not, it's better to separate it. I think one thing at a 
time is easier to review.

If they are related somewhat or it's easier to review them together, see 
if it makes sense to structure them in a way such that the AF_UNIX's 
sockmap-related fixes and tests are at the beginning of the patch set so 
that they can be applied first if others need more discussion.

Regarding the "Keeping sparse annotations in 
sock_map_sk_{acquire,release}() required some
hackery...". Maybe just remove the annotations?
[ btw, from commit 5b63d0ae94cc, the sparse support is removed and it
   depends solely on clang now (?). If it is the case, what does clang do
   on the "sock_or_unix_lock"? ]

