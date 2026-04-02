Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65C3A3E96
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172425; cv=none; b=pHWdQKK1LhdqykHAqe0SOVzM3JHTmEDcoMovVWiVh1hSSSR5zOZYnAF0+QhkKqZgdwwNE2XcB2QH6VRY+3iTYGwOmUUzv+PJGfzAVolv7KXHPt9J1DLYZJ0/bS/z0/N4imnI7onlZf2DTsEU2KlOsDXqUfZ+w54uKs76utaNGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172425; c=relaxed/simple;
	bh=R1fH6lsPGec/gbhk4c+BM2Ro7Lz/kCPNN6TFlkPO00c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIYSQRwgOlJFvcWt2F56Gw24Z9UCZRXSt5J7VLcFaHs1FFe+T6LXBsySkqt0Y4RamAqxHtARoxhS0DZns2+clX8LCZlpw7GvPEcz3dCMa4JZvmbxwGA1Jnj3Vt4MAmLsXVCbxD8h266YXR7i+IJQkluO9Ej+s7W8S5b/FbPFkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LHjwAm9c; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LHjwAm9c"
Message-ID: <72a624c9-28c2-44df-a61f-30b37366304a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775172420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KgikkTW01GbbTmfOZZ7Qz6n5pgpt79Z1QhtF/2zluc=;
	b=LHjwAm9cnwO2asjpotwFVRpQwQfCmmFnae8xqBI0gtN6/tnCzWHsb5pAAftAYwfK/Xy1ym
	zePGEU0bNvyCgGvj+xRQUjUYuhzTjq/dNW6cysU49e+5S9XF1sgwappHql50G1kklCXEeR
	+JYe45eHM6StRM/7lpIC83ZheTo3LGk=
Date: Thu, 2 Apr 2026 16:26:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 07/10] bpf,x86: Implement JIT support for stack
 arguments
Content-Language: en-GB
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012803.3920450-1-yonghong.song@linux.dev>
 <CAMB2axMGn8wWTWDiDQUTAS5A2Ey0FGMxEu-FryvaLAv_UBhrTA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAMB2axMGn8wWTWDiDQUTAS5A2Ey0FGMxEu-FryvaLAv_UBhrTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/2/26 3:26 PM, Amery Hung wrote:
> On Wed, Apr 1, 2026 at 6:28 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> [...]
>
>>                  case BPF_JMP | BPF_CALL: {
>> +                       int off, base_off, n_stack_args, kfunc_stack_args = 0, stack_args = 0;
>> +                       u16 outgoing_stack_args = stack_arg_depth - incoming_stack_arg_depth;
>>                          u8 *ip = image + addrs[i - 1];
>>
>>                          func = (u8 *) __bpf_call_base + imm32;
>> @@ -2449,6 +2549,29 @@ st:                      if (is_imm8(insn->off))
>>                          }
>>                          if (!imm32)
>>                                  return -EINVAL;
>> +
>> +                       if (src_reg == BPF_PSEUDO_CALL && outgoing_stack_args > 0) {
>> +                               n_stack_args = outgoing_stack_args / 8;
>> +                               base_off = -(prog_stack_depth + incoming_stack_arg_depth);
>> +                               ip += push_stack_args(&prog, base_off, n_stack_args, 1);
>> +                       }
>> +
>> +                       if (src_reg != BPF_PSEUDO_CALL && insn->off > 0) {
>> +                               kfunc_stack_args = insn->off;
>> +                               stack_args = kfunc_stack_args > 1 ? kfunc_stack_args - 1 : 0;
>> +                               base_off = -(prog_stack_depth + incoming_stack_arg_depth);
>> +                               ip += push_stack_args(&prog, base_off, kfunc_stack_args, 2);
>> +
>> +                               /* mov r9, [rbp + base_off - 8] */
>> +                               off = base_off - 8;
>> +                               if (is_imm8(off)) {
>> +                                       EMIT4(0x4C, 0x8B, 0x4D, off);
>> +                                       ip += 4;
>> +                               } else {
>> +                                       EMIT3_off32(0x4C, 0x8B, 0x8D, off);
>> +                                       ip += 7;
>> +                               }
>> +                       }
> Do we need to make sure RSP is 16-byte aligned before passing arg
> through stack per x86-64 ABI?

Good question. Without this patch set, looks like bpf jit here does not enforce 16 byte
aligned. IIUC, 16 byte aligned requirement will be necessary for some special
SSE/AVX/128-bit XMM etc. The bpf jit does not really emit them, so I guess it is okay?

>
>>                          if (priv_frame_ptr) {
>>                                  push_r9(&prog);
>>                                  ip += 2;
>> @@ -2458,6 +2581,14 @@ st:                      if (is_imm8(insn->off))
>>                                  return -EINVAL;
>>                          if (priv_frame_ptr)
>>                                  pop_r9(&prog);
>> +                       if (stack_args > 0) {
>> +                               /* add rsp, stack_args * 8 */
>> +                               EMIT4(0x48, 0x83, 0xC4, stack_args * 8);
>> +                       }
>> +                       if (src_reg == BPF_PSEUDO_CALL && outgoing_stack_args > 0) {
>> +                               /* add rsp, outgoing_stack_args */
>> +                               EMIT4(0x48, 0x83, 0xC4, outgoing_stack_args);
>> +                       }
>>                          break;
>>                  }
>>
>> --
>> 2.52.0
>>
>>

