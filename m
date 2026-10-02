Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DD35676B
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928228; cv=none; b=oByFQXroQnCqJPF6GiK0103gz7hfAsZ+r8925jOVZ+JEsVYjr3a8f5C0YZcd3+vxwxN0co4vKkWh6IWRmR9ywsm3jJJIbnNoXYOzoeAyDz0/jqPYz3VdS/YcSLNtnljisTzGtsJqd1rDay+2eBAZjFY5X6+BM+IIGBNnalPm1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928228; c=relaxed/simple;
	bh=CE54ArF9CfZSFzFjBXuY+9dl8X+yjhtgmfmzwiHATzM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pANhQei6Yf1leGgOkCBXOqx5pWK8Br5QnGMPNKZ66UUl9B2OhwD1kXs4Aris04C/ih6t8JpshRJXRmc5fjG7fF7VXdv+EHDKi+EQ5zde47KCKa4JfsylPXoMTB29VyyAjsYfRolHV9AKSxKokZvOlNciXRX/D8PA0Yl9Eyv2ZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ds3++d5y; arc=none smtp.client-ip=95.215.58.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ds3++d5y"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CE54ArF9CfZSFzFjBXuY+9dl8X+yjhtgmfmzwiHATzM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790928212; v=1; x=1791533012;
 b=Ds3++d5yfDk3weHdTLBg3OgvNzweIJnH6GRoSyfTW1ra7WqtBBSuaC1czrtFxSira0HEyujf
 Y8HxXqfT27CknSgNDgx89MZxLDRzOu9z7WQUTgayBxIIWxxmgFdjrK+ah3ev8EZrxRsZTpkjLXO
 vzfCowrKNNGEbhnXRi904XKc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3000c729e5b3d0a9;
	Fri, 02 Oct 2026 08:03:32 +0000
X-Mizu-Trace-ID: 3000c729e5b3d0a9
X-Migadu-Flow: FLOW_OUT
Message-ID: <4fc25ca5-bd57-4df0-a8e1-cf6bb9ba2fcb@linux.dev>
Date: Fri, 2 Oct 2026 09:03:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vineet Gupta <vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-2-vineet.gupta@linux.dev>
 <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com>
 <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev>
 <DLH1MDZPU5G0.228555JR34D3N@gmail.com>
 <76ca0a2e-dd9a-41c9-90e4-5fd3c9171172@linux.dev>
 <CAADnVQKKWBV+pFMAStB_-POKveeO83RiXU+VKeua3odSu-Xrmg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKKWBV+pFMAStB_-POKveeO83RiXU+VKeua3odSu-Xrmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/26 5:36 PM, Alexei Starovoitov wrote:
> On Wed, Sep 16, 2026 at 2:24 PM Vineet Gupta<vineet.gupta@linux.dev> wrote:
>> On 9/16/26 2:02 PM, Alexei Starovoitov wrote:
>>> On Tue Sep 15, 2026 at 1:17 AM UTC, Vineet Gupta wrote:
>>>> Back when I started, keeping it NFC made more sense. But with all the
>>>> nuances discovered in the process, I'm inclined to drop the NFC stance
>>> What is NFC ?
>> non functional change aka refactoring.
>> Like I said when I started I wanted to keep the id / flag breakout
>> purely non functional. But given that splitting it does change one thing
>> (mentioned below) - I'm dropping NFC attribution.
>>
>>>> and make functional changes - there's at least one which is the
>>>> following accepted pre-series and now rejected.
>>>>
>>>>          old {r2.id=A+delta32}         vs cur {r2.id=B+delta64}
>>> that's a red flag, no? The refactoring patch shouldn't have
>>> any changes to selftest and veristat numbers?
>>> Unless I'm missing it again.
>> Yes understood except that it is no longer refactoring.
> NFC is gcc probably lingvo? In kernel people just put in the commit
> log "No functional changes", so it's easier for humans and for AI
> to review patches.
> So pls skip such unusual tags in the future,

Yes keeping kernel's existing conventions makes sense, although LLMs 
understand what NFC is.

> but keep the first patch as "No functional change".

Just to rehash since the meaning of first has moved significantly.

1. Now the first change (patch 1/x and its test 2/x )  is no longer the 
compound id conversion, but coerce_reg_to_size_sx / 
coerce_subreg_to_size_sx change to fix the errno range case, as 
suggested by you. It is a functional change, with following improvement:

    === VERDICT CHANGES: 3 ===
        mov32sx_s8_negative_range     failure -> success
        mov64sx_s32_negative_range    failure -> success
        mov64sx_s8_negative_range     failure -> success

    === total_insns:  0 changed among 1242 both-passing, 0 worse ===
    === total_states: 0 changed among 1242 both-passing, 0 worse ===

2. The second change (3/x and its test 4/x) is accumulating add_const 
deltas (w3 = w0; w3 -=1). This makes the 32-bit link with delta special 
handling of zext unnecessary so its a prereq for the series.

3. I guess you are referring to the patch to convert compound id to 
broken out id + flags (5/x ) is also technically a functional change - 
due to the state comparison behavior improvement that fell out of the 
seemingly mechanical conversion and is clearly called out now. However I 
verified it in isolation (on top of 4 prior of course) and there are no 
veristat or selftest changes with it (just a cosmetic name change due to 
base_id -> id)

    === VERDICT CHANGES: 0 ===
    === total_insns:  0 changed among 1247 both-passing, 0 worse ===
    === total_states: 0 changed among 1247 both-passing, 0 worse ===


I presume that is what you were asking for ?

Thx,
-Vineet

