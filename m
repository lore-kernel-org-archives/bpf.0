Received: from mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42157480DCA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504780; cv=none; b=He/t9wdZi20W+gASXbECKoXjtgGMMis5Ae87KkJUY6pcfrms8lIfAjkkL6D+W1K7Ynmn/PD/T7R897NB8W6bNbr1lmVRnS6HoMECRAEVHczBuVUEvpw04Y1tLTK2vrNvY2VvE/1ajQ7kUmMnzJH4I8BqrHhhYSN4yv9ZHXDQyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504780; c=relaxed/simple;
	bh=HycSpdLfCzkvJeOFsWOpSXwUrSmZ9dlRks1sdhs0BJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQkynCsuSZjIWktSjm6ah5EWubWaDER8j+MbfRDITPqTyrou0dCvTX8uQ0EnLlu5UFw/ATMibDpT8wGDGBuwmzyRC9x4RO9FtXmhHz3cCKQpIOiuMX4sHoXV6t55FgoK982F33Ykh2zqLb34Tb5BD4g/5DUsO+s4jNPu0VnvU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LFIMnOd1; arc=none smtp.client-ip=91.218.175.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LFIMnOd1"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HycSpdLfCzkvJeOFsWOpSXwUrSmZ9dlRks1sdhs0BJ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789504776; v=1; x=1790109576;
 b=LFIMnOd13DwFE59r5aJ+R3NnUktMnoFZ1KJn4lVSJHruFTQkBLP818NmorIuVkkc7UDgFX+E
 7Tr5QDrA4njZa/7ih5PL3uzy+qrKZlji62pFFbP8a9FWZwoNHmmvyCMk7lkZrYjPGfl+S3kj96t
 j04y6FXKBNwsZ9DvkC+J56F4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 61440f76a88ab040;
	Tue, 15 Sep 2026 20:39:36 +0000
X-Mizu-Trace-ID: 61440f76a88ab040
X-Migadu-Flow: FLOW_OUT
Message-ID: <d5d78882-2c68-4fec-b061-7642f3f2871f@linux.dev>
Date: Tue, 15 Sep 2026 13:39:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 07/13] bpf: track low-32 scalar equality
 across sign-extending movs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-8-vineet.gupta@linux.dev>
 <DLDKPDWY833W.1QJX9MTD6SZG5@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DLDKPDWY833W.1QJX9MTD6SZG5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/12/26 12:09 PM, Alexei Starovoitov wrote:
> On Thu Sep 10, 2026 at 9:46 AM PDT, Vineet Gupta wrote:
>> The zero-extending mov records that dst shares src's low 32 bits. A 32-bit
>> sign extension shares them too -- it keeps the low half and fills the high
>> half from bit 31 -- so the same link applies, with a different rule for
>> rebuilding the high bits:
>>
>>    r6 = ...              /* full 64-bit unknown */
>>    r7 = (s32)r6          /* 32-bit sign-extending mov */
>>    if w6 == -1 goto ...  /* taken: r6's low 32 bits are all ones */
>>    ...                   /* r7 is -1, not deduced today */
>>
>> Add SUBREG_SEXT alongside SUBREG_ZEXT, and sext_32_to_64() alongside
>> zext_32_to_64() to drive the reconstruction. Both work from the base's
>> 32-bit range, which is what a 32-bit compare narrows.
>> coerce_reg_to_size_sx() cannot serve here: it reads smin/smax, which
>> straddle after such a compare and collapse to the full field range.
>>
>> tnum_sext() is the counterpart to tnum_cast(). Unlike a tnum_range() over
>> the new bounds it keeps the known low bits.
>>
>> The enum has room for the third value, so bpf_reg_state stays 80 bytes.
>>
>> Unlike the zero-extending arm, a self-mov can form a link here, but only
>> when src is already linked: r0 = (s32)r0 is how a sign-extended int return
>> lands. On an unlinked register there is nothing to link to, and minting an
>> id would leave the register describing itself.
>>
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>> ---
>> v2: was RFC 5/6.
>>   - no forward declaration (Eduard)
>>   - src renamed known_reg (Eduard)
>>   - sext_32_to_64() and tnum_sext() rather than reusing
>>     coerce_reg_to_size_sx(); the sync path needs the base's 32-bit range,
>>     see the cover letter
>>   - tnum_sext() keeps the known low bits a tnum_range() would drop (Eduard)
>>   - a self-mov links only when src already has an id, narrower than the RFC
>>
>>   include/linux/bpf_verifier.h |  1 +
>>   include/linux/tnum.h         |  3 +++
>>   kernel/bpf/log.c             |  2 ++
>>   kernel/bpf/tnum.c            | 15 ++++++++++++
>>   kernel/bpf/verifier.c        | 47 +++++++++++++++++++++++++++++++++---
>>   5 files changed, 65 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index f1b01059c5da..920c9490ecc8 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -53,6 +53,7 @@ enum bpf_add_const {
>>   enum bpf_subreg {
>>   	SUBREG_NONE = 0,
>>   	SUBREG_ZEXT,		/* high bits are zero (32-bit zero-extending mov) */
>> +	SUBREG_SEXT,		/* high bits repeat bit 31 (32-bit sign-extending mov) */
> If my earlier suggestion to model SUBREG_ZEXT as add_const32 with delta == 0
> works, then sign extension could be:
>
> enum bpf_add_const {
>         ADD_CONST_NONE = 0,
>         ADD_CONST_32,    /* delta was added with a 32-bit ALU op */ /* works as ZERO_EXTEND when delta == 0 */
>         ADD_CONST_64,    /* ... with a 64-bit ALU op */
>         SIGN_EXTEND_32, 	/* delta has to be == 0 */
> };

If we were to go that route sure, but no point if we are not doing that.

Also keeping them together makes add_const and sext mutually exclusive. 
Today they are but what if in future we were to implement the following.

w7 = w6      /* r7 gets SUBREG_ZEXT */
w7 += 4      /* r7 also gets ADD_CONST_32, delta 4 */

> and if we really want to we can track movsx 8 and 16 too.
> Which might be an overkill.

Indeed.
Eduard and I discussed this in the off line review before RFC. gcc 
currently doesn't seem to generate these a lot so maybe leave this for 
future.

Thx,
-Vineet
