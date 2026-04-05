Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7417A30A
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775425548; cv=none; b=sO7GbsU2vX4NE3bEFnnoOX+bibn9fGtkMBmdwSfmUugzQ07440jAOgkrQzsbnpABhgpTgxKYGQ1sQaO3JDriiEx4KPX5xgEQeUODFbM7p/qwHr1jU5A583xCnmXI/OlBcWtVpXsfOLkA1fJf/1qIfwCtHLc3gLc0riL8mSUpO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775425548; c=relaxed/simple;
	bh=Nuh5W6Dif1FcQuPWLzM1kFOsFdJJQjg6/xAFrToGiIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIjz5oCv4YXlBHNXBqw7IssiW/iqqGbZOzuJc8CQqgJA38nvZpExwCgl3povXXH7kK6WC4LKImbVk3/Z+oWdoYn/HOkC7lqF4cIASx7kRv51dFODmRNfUfxVDl505WFei/9SiPMK1wYy2Wuv00UuX8o4b95EW2WCKP0iu8BvZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fYH8wH6r; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fYH8wH6r"
Message-ID: <8b6c9b74-b132-4746-aced-a1fbb8f71885@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775425544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7Q59gLIjHQtgAVWEvB23qA4/yMcSHSeqQV6Kq7EJTc=;
	b=fYH8wH6rgZ3Mbge8f6SW5uCZomcJpO1AzP5G9yIAhNqEZNSBmYgRJiRdCqVj+sZBAZ7Qcu
	K4ZjDlFVu5QC1SofTViKW9XtlDrW9Ew2k5E+dR/aAsvJ8zfn6nQ+bEkZCpZ2YSxroFlOJY
	gthSI0nQqIVcpa4s1VgDTElg0qm5XVQ=
Date: Sun, 5 Apr 2026 14:45:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] bpf, doc: Improve MOV/MOVSX documentation and add
 examples
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@gcc.gnu.org,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, void@manifault.com
References: <20260403164040.73269-1-vineet.gupta@linux.dev>
 <20260403164040.73269-3-vineet.gupta@linux.dev>
 <CAADnVQKOzLwz+V7CNgOYRZ+UykMrR-=OGMg0DjX_NM6B8dSr1g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <CAADnVQKOzLwz+V7CNgOYRZ+UykMrR-=OGMg0DjX_NM6B8dSr1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/4/26 20:33, Alexei Starovoitov wrote:
> On Fri, Apr 3, 2026 at 9:41 AM Vineet Gupta <vineet.gupta@linux.dev> wrote:
>>   - Add missing form {MOV, K, ALU}.
>>
>>   - Add some assembly (pseudo-C) snippets.
>>
>>   - Rearrange: MOV content comes before MOVSX.
>>
>>   - MOVSX content itself rearranged: canonical sign extension variant
>>     for {8,16,32}-> 64 moved ahead of the special variant which only
>>     sign extends to 32 and zeroes out the upper bits.
>>
>>   - Remove the hyphen '-' in "sign-extension" to make grep hit all
>>     instances with one pattern.
>>
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>> ---
>> Changes since v2:
>>   - Fixed RST markup for asm example "w5 = w9"
>>   - Added asm example "w5 = (s8)w9" for {MOVSX, X, ALU}
>> ---
>>   .../bpf/standardization/instruction-set.rst   | 49 +++++++++++++++----
>>   1 file changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
>> index 96181565906f..863a0cc22a75 100644
>> --- a/Documentation/bpf/standardization/instruction-set.rst
>> +++ b/Documentation/bpf/standardization/instruction-set.rst
>> @@ -414,25 +414,54 @@ etc. This specification requires that signed modulo MUST use truncated division
>>
>>      a % n = a - n * trunc(a / n)
>>
>> -The ``MOVSX`` instruction does a move operation with sign extension.
>> -``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
>> -32-bit operands, and zeroes the remaining upper 32 bits.
>> -``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
>> -operands into 64-bit operands.  Unlike other arithmetic instructions,
>> -``MOVSX`` is only defined for register source operands (``X``).
>> +For move operations, the ``MOV`` instruction has a few different forms.
>> +
>> +``{MOV, X, ALU64}`` means::
>> +
>> +  dst = src
>> +
>> +e.g. ``r1 = r2``
>>
>>   ``{MOV, K, ALU64}`` means::
>>
>>     dst = (s64)imm
>>
>> -``{MOV, X, ALU}`` means::
>> +e.g. ``r1 = -4``
>> +     ``r5 = 9282009``
>> +
>> +``{MOV, K, ALU}`` means::
>> +
>> +  dst = (u32)imm
>> +
>> +e.g. ``w1 = -4``
>> +     ``w5 = 7302004``
>> +
>> +``{MOV, X, ALU}`` has zero extension semantics (upper 32 bits are zeroed)::
>>
>>     dst = (u32)src
>>
>> +e.g. ``w5 = w9``
>> +
>> +The ``MOVSX`` instruction does a move operation with sign extension and has
>> +a couple of forms.
>> +
>> +``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
>> +operands into 64-bit operands.
>> +
>> +e.g. ``r1 = (s8)r2``
>> +
>> +The ``{MOVSX, X, ALU}`` form has slightly different semantics: it
>> +:term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
>> +32-bit operands, and zeroes the remaining upper 32 bits (similar to ``MOV``).
> This reads too conversational. This is a spec. It's supposed to be dry.

Perhaps there is some extra commentary in this part which can be toned down.

But I think the actual asm examples are warranted for, considering this 
is an ISA doc. Just capturing the abstract operations doesn't give the 
full picture, specially since this is considered single source of truth 
for the ISA.

e.g. consider dst = (u32)(s32)(s8)src
I tried to feed this to assemblers, but neither llvm/gnu can grok it 
since the actual insn is WN = (s8)wM

> Overall I'm not sure it's an improvement.
> Only (MOV, K, ALU) worth adding.
> Please cc David Vernet in the future patches and bpf @ ietf.
>
> I feel that both patches are wiki or faq material than IETF spec.

Thx,
-Vineet
