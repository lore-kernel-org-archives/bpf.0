Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944353905EA
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237586; cv=none; b=p7w45YBt17XBBpM/jnJbTLPUS8SUfM5T+w17Eq+qoQtKRUs/AkdhTeg58uIZlOdaEZmNESvUnifCMn+MVlK7xgAb0NWjsOhIKO2CsHA06pOF7IplO+D++bsl2ermKIoVvmpRhU2UjSeLOd9GFup36wjncrHCmfC5cgJunwTE2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237586; c=relaxed/simple;
	bh=MOM0X/HE9EIYp7E3FDuk9szXnF9l0FFHi4Ujj/B3gGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVFEiZVFyDMBo/YXtRbkaVxWUhWq7Yy+c5VNXJ579FH3LfkYXYdVw0XpNS1z0s1Lc/pg0UUzioyP7igM1ZWMtfkwlU9/vyaDbRDeyF2EQ0ivDKL8AXFNqEYywKtctxZbLJxWeYNxlprFAf1v/GiLJih780Fn+FB30eWBdroHIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C31/aLkY; arc=none smtp.client-ip=95.215.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C31/aLkY"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MOM0X/HE9EIYp7E3FDuk9szXnF9l0FFHi4Ujj/B3gGU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791237582; v=1; x=1791842382;
 b=C31/aLkY075scH5PyBqH/5bWgHKyhwA90ArzLbdjsdcN6WRZFbn3HCdYFM9wNyj+6ctnnlmM
 JnQL9uRfN+jDNcUs5H/v1ZjDE3oA59ChrI+J8P79npxmseCkDF4oaVedx62NFuCgeyuJoQEm3NL
 TqCwbLcCoMJ5d0luHHsgZ55g=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b5aa8c9e380aff7b;
	Mon, 05 Oct 2026 21:59:42 +0000
X-Mizu-Trace-ID: b5aa8c9e380aff7b
X-Migadu-Flow: FLOW_OUT
Message-ID: <4e4f9d51-f7f4-4bc3-95a0-27f661a08286@linux.dev>
Date: Mon, 5 Oct 2026 14:59:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Destroy callee-local dynptrs on
 subprog return
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 sashiko-bot@kernel.org
References: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
 <20260927120422.1042107-2-xyx2021@mail.ustc.edu.cn>
 <CAMB2axPnwisOQtXymBA5jBTFNEhhummfU7xamvkMBSVC-HssJw@mail.gmail.com>
 <DLUBFR28IPJM.I3TIXG4RISTD@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DLUBFR28IPJM.I3TIXG4RISTD@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/2/26 4:29 AM, Alexei Starovoitov wrote:
> On Mon Sep 28, 2026 at 4:48 AM UTC, Amery Hung wrote:
>> On Sun, Sep 27, 2026 at 5:04 AM Xu Yunxiang <xyx2021@mail.ustc.edu.cn> wrote:
>>>
>>> A data slice is valid only while the specific dynptr that produced it
>>> remains valid. prepare_func_exit() copies a subprogram return value into
>>> the caller and then frees the callee state without applying the normal
>>> destruction semantics to dynptrs in the callee stack.
>>>
>>> A callee can therefore derive a slice from a local dynptr, return or spill
>>> the slice into its caller, and then let the dynptr disappear with the
>>> callee frame. The slice retains the id of a dynptr that is no longer in the
>>> verifier state, so the verifier continues to accept accesses through it.
>>>
>>> Before the object relationship refactor, bpf_dynptr_data() slices from
>>> referenced dynptrs also carried the shared reference id, allowing a later
>>> release to catch some of these escaped slices. The refactor made those
>>> slices precise children of their source dynptr and exposed the missing
>>> teardown as an accepted stale access even after the shared resource is
>>> released.
>>>
>>> Add destroy_dynptrs_in_stack_slots() to apply the existing dynptr teardown
>>> to an inclusive range of stack slots. Reuse it for dynptr initialization,
>>> variable-offset stack writes, and the entire callee stack before freeing
>>> the frame. The teardown rejects losing the last dynptr for a referenced
>>> resource and invalidates the dynptr and all its descendants, including
>>> slices held in the caller. Propagate errors through prepare_func_exit().
>>>
>>> Reuse the existing teardown API and diagnostic. Update the affected
>>> callback test expectation in this change so the commit remains test-clean.
>>>
>>> Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel.org
>>> Suggested-by: Amery Hung <ameryhung@gmail.com>
>>> Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A9u-HhxY3UDA@mail.gmail.com
>>> Link: https://lore.kernel.org/r/CAMB2axMmrTb+UZ84UD48MwMtXbk1s9bWtreU3AOfjzU0fPT0BA@mail.gmail.com
>>> Assisted-by: LLM
>>> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
>>
>> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>>
>> Just a note: this series addresses a related but distinct problem from
>> Ihor’s work [0]. This series handles descendants escaping from
>> callee-local stack dynptrs, while Ihor’s handles helper-owned callback
>> arguments whose lifetime ends when the callback returns.
>>
>> [...]
>>
>>> @@ -11675,6 +11683,12 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>>                 }
>>>         }
>>>
>>> +       /* Invalidate callee-local dynptrs and their slices before the frame goes away. */
>>> +       err = destroy_dynptrs_in_stack_slots(env, callee, 0,
>>> +                                            callee->allocated_stack / BPF_REG_SIZE - 1);
>>> +       if (err)
>>> +               return err;
>>> +
>>
>> Conceptually, Ihor’s frame-reference mechanism could subsume this
>> cleanup if every local dynptr had a separate frame-ownership
>> relationship. The current parent_id cannot express that directly
>> because dynptrs already use it for object and shared-resource
>> ancestry.
>> Supporting both would require another ownership edge or field, rather
>> than simply assigning parent_id to the REF_TYPE_FRAME id.
>>
>> [0] https://lore.kernel.org/r/20260922010333.1226537-1-ihor.solodrai@linux.dev
> 
> 
> I feel it's ok to apply as-is or should we defer until Ihor's fix?

Let's apply this fix as is.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

It can probably be backported, and there are no conflicts with what
I'm doing.

The REF_TYPE_FRAME change is a more long-term thing, not easily
backportable. And it's not ready to land yet, so no reason to wait.

Thanks.

> 
> pw-bot: cr

