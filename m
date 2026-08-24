Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E1375F97
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547904; cv=none; b=P57LAr/ridOo4wkunEB9BLZW9uAw66uOMeyxZrHO7BJfCgtMqaQc3tsarGtI794n1d1/kd1JsH0N6iiYt80oncRM8bYiOFAHbjqyrEflpUgtWGs0DBTPHH/xnUNwwHsMB8kqvRnma5GpMsyuZ9P3Yu49F86rc0dBd12DGuVTLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547904; c=relaxed/simple;
	bh=sQ5CTBEkL0QV6AeY7W294YZ8qRnhcLxVgll+bCNt4t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hchpv4WPVFpZaAcdE6bShOTfZVIxZANMgcZLoaEu7BwZWKZcJLYk2/wnwBqyvy+KsrsckPBkht2EpTkVlJ4VDi6KgzU60UTO6qjaBsbu+Ao3QjkFX/nilquBgcXx2srZRyz0AhYqVypP00ckVNivqfXpKyqDGLtO71ldJRva7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GrFWMEM9; arc=none smtp.client-ip=95.215.58.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GrFWMEM9"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sQ5CTBEkL0QV6AeY7W294YZ8qRnhcLxVgll+bCNt4t0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787547899; v=1; x=1788152699;
 b=GrFWMEM9SBPE3mOy5WqDHxZg/dlJFa928dwhuGOqGLDABVWnUQIPrgKwvm7mJlzOwCx7xs1R
 8cNc2+9ywhJ+JQZz24rdIMbwAFXhMKTK4p/114QxlUKyVYBBCoWFYr/YzJBnPwISvqcqlv0IwmL
 4CS/4/9+JI/uiwSiT9rrw6iY=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 6e53a539a124c5d0;
	Mon, 24 Aug 2026 05:04:49 +0000
X-Mizu-Trace-ID: 6e53a539a124c5d0
X-Migadu-Flow: FLOW_OUT
Message-ID: <68358803-57c9-4a89-9da3-fb5e12547e0f@linux.dev>
Date: Mon, 24 Aug 2026 13:04:38 +0800
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
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYM+b4E5S6ZCDcpEaw2uvdNPDVUdTgxUxkvCdM86DkubQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/8/26 03:35, Andrii Nakryiko wrote:
> On Fri, Aug 21, 2026 at 3:26 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>>
>> Any issue of checking CAP_NET_ADMIN for BPF_LINK_UPDATE?
>>
>> If no, checking CAP_NET_ADMIN for BPF_LINK_UPDATE looks okay.
>>
> 
> Why do we need extra capability checks during LINK_UPDATE if we
> already performed the check during LINK_CREATE? If you pass link fd to
> some process that doesn't have CAP_NET_ADMIN, but has link fd and
> another validated prog fd, they should be able to update the
> underlying program without extra checks, IMO.
> 
What if a pinned link is updated by non-CAP_NET_ADMIN users? I (LLM)
verified the case by the selftest [1]. Is this case allowed intentionally?

[1] https://github.com/Asphaltt/bpf/commits/bpf/link-update-issue/v1/

Thanks,
Leon

