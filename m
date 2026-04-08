Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB82361DB5
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674060; cv=none; b=jkf/3MJNw5qEQH2qZ4ovwejHh/cgmTl/6Y0uJaWHg6x7Auv+UN3PocykxWDb2yvVA05xC8Mp0sl3H3V/5xyELgBG/E/7pI893kuitxp4vjY/yovmm6N8iXWw9VXzImgI61opqxH5txkIO1/V0hhgxyDW+9G8bEQ1bfewZ8CQR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674060; c=relaxed/simple;
	bh=XQ9mUXgeJtAWD8Ph4WLgBtVkzWECTE74E42yPV4it+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na1Z819BAPyYQU97kIYZNPBC8SCononGi3W23f2XK7xQmcTJvIyhOxvvnEKL22lA4Db8BiQ8Qz4UdAaMcewN730mTlV762Tn8GOFoRuN7DPc3DzIzZcUp4+zR0eZ22a1oHf1Rd+GldW2YyHANBnySS39Ys5sf1WvDJQgNSY5Sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BhQyJULv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BhQyJULv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+9tUL4NVnFdbjpvWtjrafN30YzBBBSjbVaUtOSnGVEk=; b=BhQyJULvYC1W+kvv/UQK+4HMcS
	eUYQ4+VTl/nTsgSI7F7bIjyaeIGqxgDgOAoiWB1mkDQTorUGExLuBRE8ZZEk4VcmGjrw0DBIx1fSm
	9RaNM4yXVWgFgmaEdhmFF4QNUlzucPbug9ch3q1CDYdgu0hqMQr5Nq+HeF4RrpK40KLvLe47lsgXP
	5Ro/PI58QASbqqP86GWlGmZyozWZCJEOZN9fgvrW9CKgx9OvTT8zn0uFbOCFt1olig4UveGddyWLS
	QK8FO+FCrZjC5NL0aeQI1QkkVFjedfmtyflTF6z5eEHXUl4Vb/Y6hyquOXQaqOoW6bG3iyRwKi4pR
	G63JxOVQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAXw5-000OnT-38;
	Wed, 08 Apr 2026 20:47:34 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAXw4-000NN5-28;
	Wed, 08 Apr 2026 20:47:33 +0200
Message-ID: <be657e28-fed8-4deb-93b1-252890da8c53@iogearbox.net>
Date: Wed, 8 Apr 2026 20:47:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf: Fix ld_{abs,ind} failure path analysis
 in subprogs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Eduard <eddyz87@gmail.com>, STAR Labs SG <info@starlabs.sg>
References: <20260408153712.523124-1-daniel@iogearbox.net>
 <20260408153712.523124-2-daniel@iogearbox.net>
 <CAADnVQ+tLKiH2a_1mOFZ7aZ3jN+9_vLxOxxPqqBc8QEYUwCgVg@mail.gmail.com>
 <a4190f97-b171-4a7f-9722-9e7bc73a57ca@iogearbox.net>
 <CAADnVQKuAXW3T3spcYFSc7SVbbBHGfbiV=XR0QdNfuJtCbG5fA@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAADnVQKuAXW3T3spcYFSc7SVbbBHGfbiV=XR0QdNfuJtCbG5fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27965/Wed Apr  8 08:24:37 2026)

On 4/8/26 7:47 PM, Alexei Starovoitov wrote:
> On Wed, Apr 8, 2026 at 10:04 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 4/8/26 6:20 PM, Alexei Starovoitov wrote:
>>> On Wed, Apr 8, 2026 at 8:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>
>>>> Usage of ld_{abs,ind} instructions got extended into subprogs some time
>>>> ago via commit 09b28d76eac4 ("bpf: Add abnormal return checks."). These
>>>> are only allowed in subprograms when the latter are BTF annotated and
>>>> have scalar return types.
>>>>
>>>> The code generator in bpf_gen_ld_abs() has an abnormal exit path (r0=0 +
>>>> exit) from legacy cBPF times. While the enforcement is on scalar return
>>>> types, the verifier must also simulate the path of abnormal exit if the
>>>> packet data load via ld_{abs,ind} failed.
>>>>
>>>> This is currently not the case. Fix it by having the verifier simulate
>>>> both success and failure paths, and extend it in similar ways as we do
>>>> for tail calls. The success path (r0=unknown, continue to next insn) is
>>>> pushed onto stack for later validation and the r0=0 and return to the
>>>> caller is done on the fall-through side.
>>>>
>>>> Fixes: 09b28d76eac4 ("bpf: Add abnormal return checks.")
>>>> Reported-by: STAR Labs SG <info@starlabs.sg>
>>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>>> ---
>>>>    kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++--
>>>>    1 file changed, 30 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index db009d509ade..46f55ea6684e 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -18357,6 +18357,22 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>>>           mark_reg_unknown(env, regs, BPF_REG_0);
>>>>           /* ld_abs load up to 32-bit skb data. */
>>>>           regs[BPF_REG_0].subreg_def = env->insn_idx + 1;
>>>> +       /*
>>>> +        * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=0
>>>> +        * which must be explored by the verifier when in a subprog.
>>>> +        */
>>>> +       if (env->cur_state->curframe) {
>>>> +               struct bpf_verifier_state *branch;
>>>> +
>>>> +               branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
>>>> +               if (IS_ERR(branch))
>>>> +                       return PTR_ERR(branch);
>>>> +               mark_reg_known_zero(env, regs, BPF_REG_0);
>>>> +               err = prepare_func_exit(env, &env->insn_idx);
>>>> +               if (err)
>>>> +                       return err;
>>>> +               env->insn_idx--;
>>>
>>> similar code in check_helper_call() for tail_call
>>> also does mark_reg_scratched() and clear_all_pkt_pointers()
>>> which are missing here.
>>
>> The clear_all_pkt_pointers() is only relevant for the cases where we
>> modify/pull/push skb data, but in ld_{abs,ind} we either read skb
>> packet data directly in linear section or via skb_copy_bits.
>>
>> I'll add the mark_reg_scratched(env, BPF_REG_0). Not sure how much
>> this really suits to move into a common helper: the tail call case
>> calls clear_all_pkt_pointers() and marks r0 unknown right after
>> push_stack(), the ld_{abs,ind} case does not clear the packet
>> pointers and marks r0 as known 0. imo its fine to leave it separate.
> 
> Ahh. Known zero vs unknown. I missed that. Makes sense.
> 
> btw what is the point of env->insn_idx--; ?
> This and tail_call case are doing it, but why?

The prepare_func_exit() sets env->insn_idx to the caller's return
site (aka the insn after the subprog call). do_check_insn() does
env->insn_idx++ at the end of the function to tell "we're done
processing this insn". So we need the env->insn_idx-- otherwise
we're overshooting/skipping validation by one insn.

Thanks,
Daniel
