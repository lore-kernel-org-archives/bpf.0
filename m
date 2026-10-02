Received: from mta0.migadu.com (out-70.mta0.migadu.com [91.218.175.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374649B1E7
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949592; cv=none; b=H+XEMYSY4CLvydDhf6QWJfVFPlfuFnybT8f45Ask5KYPze2A3Jw28rGBdw1z9NjQvbHknx4uwj8/UUfBDxGyJqYYz4eKF4QETaehZpoGPnXHUP4x5/Cr5PslFgDwaQUCqvP4Ctu3YjkyhbCwc9TXY0G85eFPeGqYQ+N05GQhTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949592; c=relaxed/simple;
	bh=OVRHodOou3p5ApMLB0Mqi/H+Mqtef861PTeuOygMVtA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=skCJPBOO6XyidkjvF+n66i2PhFwQWk8CzbZtG5p5dv26XZk5EqzluI8hR7xcaQJsAQRuw999shbCamAill3aqd5ibJ2VGeR1KRbmOw3hnCxWzNIIMzD2igv+Sq2qtwFCj2ZjmSSw7ElTCotjTlDuuvHJuo828YWbacIvDilzj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MJvJPh+a; arc=none smtp.client-ip=91.218.175.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MJvJPh+a"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OVRHodOou3p5ApMLB0Mqi/H+Mqtef861PTeuOygMVtA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790949588; v=1; x=1791554388;
 b=MJvJPh+aMJWC8Ck0g8P4reAMGqnG9Gfr7JXX4vgwgHe69tVNC4hB59sC99L2Nxvorly/Zjwf
 p5aw4yJbvE+pSHYmckKbR73x66ZN8nD2bTc2UiHkP++BBeWAgS2UQelezIm1sRevTg/usInatQd
 3hPyP137MLUGzDF9KYtCnSa8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 67bf14ff651fffc5;
	Fri, 02 Oct 2026 13:59:48 +0000
X-Mizu-Trace-ID: 67bf14ff651fffc5
X-Migadu-Flow: FLOW_OUT
Message-ID: <81cf1bec-0e88-468b-b7b1-992aa92cff80@linux.dev>
Date: Fri, 2 Oct 2026 14:59:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vineet Gupta <vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality
 across zero-extending movs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-4-vineet.gupta@linux.dev>
 <DLDKI0ZXYI7H.1XQZZE2RCU7IF@gmail.com>
 <4ab75099-0e95-4fee-81da-6f4198e3e6a0@linux.dev>
 <CAADnVQ+N9tzBJ0Bbvp8_8QvR+QcCP4ej5CgV_kRHt=iw4BANSQ@mail.gmail.com>
 <202c45e2-58ba-4ad5-a234-c90703031f91@linux.dev>
 <CAADnVQ+Si9Au8J_j2nt+ZzFq6WPaz8hpmh0n=_dFysZmSOeipA@mail.gmail.com>
 <ff18ccb77a554000a030199e8c1fbb7d8d298e18.camel@gmail.com>
 <DLL84IMPTRQF.3DOQQTN2KCAEW@gmail.com>
 <e9aad352ba82dadd97a17867108b5db1865fa38d.camel@gmail.com>
 <DLL8Q69N7BUD.1HI0MKU2M2UGE@gmail.com>
 <951923920747d8dcba3d56ca8858e106d9c7ba4e.camel@gmail.com>
 <DLLBVIU33MLC.ITFPYGMFKWUT@gmail.com>
 <f4a616cf9241589fd093bbd0b34e8c8a162d579a.camel@gmail.com>
 <DLLCIL3RGVY1.H5A4OEASW5OF@gmail.com>
Content-Language: en-US
In-Reply-To: <DLLCIL3RGVY1.H5A4OEASW5OF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/26 11:25 PM, Alexei Starovoitov wrote:
> On Mon Sep 21, 2026 at 10:17 PM UTC, Eduard Zingerman wrote:
>> On Mon, 2026-09-21 at 21:55 +0000, Alexei Starovoitov wrote:
>>> On Mon Sep 21, 2026 at 7:44 PM UTC, Eduard Zingerman wrote:
>>>>>>>> Where:
>>>>>>>> - id == 0 => no id link
>>>>>>>> - full => all 64-bits of the register are identical to
>>>>>>>>            all 64-bits of a scalar value `id' (let's call it X).
>>>>>>>>            ∀ rA{.id == X, .link == full}, rB{X,full} => rA == rB
>>>>>>>> - zext => lower 32-bits of the register are identical to
>>>>>>>>            lower 32-bits of a scalar value X,
>>>>>>>>            upper 32-bits of the register are null.
>>>>>>>>            ∀ rA{.id == X, .link == ?}, rB{X,zext} => rA % 32 == rB % 32
>>>>>>>> - sext => lower 32-bits of the register are identical to
>>>>>>>>            lower 32-bits of a scalar value X,
>>>>>>>>            upper 32-bits of the register are either 0 or 1,
>>>>>>>>            depending on the bit 31 value.
>>>>>>>>            ∀ rA{.id == X, .link == ?}, rB{X,sext} => sext(rA % 32) == sext(rB % 32)
>>>>>>> hmm.
>>>>>>> there is also 32-bit link with delta, right?
>>>>>> My point is that delta is independent of 32-bit/64-bit property.
>>>>>> `delta' can be used to propagate in both directions:
>>>>>> - full 64 bit -> 32 bit sign/zero-extened
>>>>>> - 32 bit sign/zero-extened -> full 64-bit
>>>>> both? how ?
>>>>> I was under impression that in 32-bit domain delta is one way.
>>>>> rX = ...
>>>>> wY = wX
>>>>> wY += 5
>>>>>
>>>>> if wY == 10
>>>>> We cannot do -5 to rX
>>>> Why?
>>>> It is still valid to transfer r32 and tnum_subreg knowledge from wY to rX.
>>>>
>>>>    wY + 5 == rX % 32 + 5 => hence rX % 32 knowledge can be recovered.
>>>>
>>>> If rX itself had some delta, e.g.:
>>>>
>>>>    rX = ...
>>>>    rX += 7
>>>>    wY = wX
>>>>    wY += 5
>>>>
>>>> Then it would still be possible:
>>>>
>>>>    wY + 5 == (rX - 7) % 32 + 5 = rX % 32 - 2.
>>>>
>>>> Again, in case of this direction, only lower 32-bits of the 'full'
>>>> register can be inferred.
>>> Ok, so we're argeeing that it's not 'full' in your above definition.
>>> Your enum id_link_kind needs a 4th category : apply-delta-to-lower-32bit-...
>>> and it's not bi-directional.
>> It's not really a category, it's just a direction in a sync function:
>> - if known_reg is 'full' -> sync to sext/zext register recovers lower
>>    32-bits and infers upper
>> - if known_reg is sext/zext -> sync to 'full' register recovers only
>>    lower 32-bits and keeps upper untouched (counting on cross-domain
>>    bounds sync logic).
>> - 'full' -> 'full' and 'sext/zext' -> 'sext/zext' syncs are trivial.
>>
>>> rX = ...
>>> wY = wX
>>> wY += 5
>>> if wY == 10
>>> here can apply -5 to lower 32-bit of rX only.
>>>
>>> rX = ...
>>> wY = wX
>>> wY += 5
>>> if rX == 10
>>> here can apply +5 to lower 32-bit of wY _and_ do zero extend into full rY.
>>>
>>> I don't see a value of 'zext' kind alone that doesn't do 'add delta'.
>> Exactly, that's why I suggest this as a completely orthogonal encoding.
>> Effectively for an abstract scalar value X it would encode whether
>> the particular register is:
>> - X + delta
>> - zext(X + delta)
>> - sext(X + delta)
> ahh. it wasn't clear to me that 'zext' you're proposing does '+ delta'.
> Now I see that your zext is the same as apply-delta-to-lower-32bit-and-zext
> as I was talking about all along.

So to close the loop on this v3 will support the above three forms: 
add_const:2 and subreg_ext:1merge into one {none,

And just to recap, we will be adding two features:
  - adding the sext with delta
  - reverse syncing of low 32 bits

Thx,
-Vineet


