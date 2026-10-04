Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2493EB105;
	Sun,  4 Oct 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138160; cv=none; b=h07dJ3MPW38uARwmlEuOpJx6KgEdD1BS6z/k1x1yi9NNYZ1+m+EkMflOJ4pU1/0BWqmJsLvoAH3sR4Pvt7vYJoCmQaW+tac6n2ARz8rg8EBr36fA3b19VdFW7aReXQXXuRQdQm8OINDyfhNVB6sscPXKUekUnFAccZvWds/LNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138160; c=relaxed/simple;
	bh=45LFbBSya6acv2El62U3c+MMKUFAjzx6vOn87uaGYBk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SPeZTjAVl68BYVUCxkU4fm49tvoAqQnWUehQlsqV7/HTLg2z+h9BpfQRlNOxrh8Q7RluxzP8QuVlr3BXbmfK71xwqOCfKRONbkVuUmsYvSHxDCvlVmCvBpo4dxhrBPy3nyws/gXtB2WiqCcQ9p+kmIlU8ndnj7s6PMbhcq4L02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=mcmmBy54; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="mcmmBy54"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lyxtMOR60vEEsgEoCbWQ9+m2UQFGn2NRsPcpgpljIy8=; b=mcmmBy54TsIVZ32H3ohw6GLgZ3
	aIBmHSqSwzpAuymNS1VW5Ui8fRNczyhJL3sJ72+kNcn3p/OxDslD31Hkx2VcBayj6OLF7SrW/YYmz
	h6WSV7hF6/tIrO7H3tF1rfwYjFDaTnUTIX12sCYUDughQMIdRsVNAfMsal/ql1kFBF+rLT3WcZyHk
	rhORTx/3F7anQvV8B0DEHlVIhpOYBCJtkJB1xZTj8IcG+wqr7lQbv/yFnR3XpGnXU4Mdv6bJN4ZEa
	VwSe7DHZFNgWQt+eAAHmQRXhXZ7fDe6Osur8vJ64JCenO+EN9NA3Tmoyg8VVYyBCjpmIyRYZsiZ8g
	jsjeE6qg==;
Received: from [::1] (port=54566 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xDQr5-00000004b8k-3ZBi;
	Sun, 04 Oct 2026 20:22:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 04 Oct 2026 20:22:35 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf, x86: Sign-extend narrow signed kfunc returns
In-Reply-To: <fe9ae59b603848f59757086c6309aec9@oss.cyber.gouv.fr>
References: <20260823203944.2084994-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DKYHCWYCB5XV.3MSN6ZJGOW2R7@gmail.com>
 <fe9ae59b603848f59757086c6309aec9@oss.cyber.gouv.fr>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <05edf76be7fac5ebe902d78d672d454c@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-08-26 16:20, Jérémy Jean wrote:
> Hello Alexei,
> 
> On 2026-08-26 03:22, Alexei Starovoitov wrote:
>> On Sun Aug 23, 2026 at 1:39 PM PDT, Jérémy Jean wrote:
>>> bpf_res_spin_lock() returns a 32-bit int. On failure, the verifier
>>> models R0 as a signed 64-bit value in [-MAX_ERRNO, -1].
>>> 
>>> On x86-64, returning -EDEADLK writes 0xffffffdd to EAX and clears the
>>> upper half of RAX. Since the JIT leaves the native return value 
>>> as-is,
>>> BPF sees 0x00000000ffffffdd instead of the sign-extended
>>> 0xffffffffffffffdd. A 64-bit signed comparison therefore treats the
>>> value as positive, while the verifier treats it as -35.
>>> 
>>> As a result, a signed comparison against zero can take one path 
>>> during
>>> verification and another at run time. With rqspinlock aliases, this 
>>> can
>>> lead to unmatched bpf_res_spin_unlock() calls, corrupting the per-CPU
>>> rqspinlock state and unbalancing the preemption count.
>> 
>> Is that a theory? I'm pretty sure we have selftests for negative
>> error codes from res_spin_lock.
> 
>> I'm pretty sure we have selftests for negative
>> error codes from res_spin_lock.
> 
> As far as I could checked, this is not entirely covered: when the
> returned 32-bit signed int is a negative integer in %eax
> (0xffffffdd), it is later mapped to 64-bit register r0, which clears
> the 32 MSB as its value is taken from %rax, and this makes the
> negative error code a large 32-bit value stored in r0
> (0x00000000ffffffdd). When writing raw BPF, one could check the
> return code using r0 instead of w0, and this would introduce a
> mismatch with the verifier that sees a real negative value.
> 
> In my understanding, the current selftests do not exactly verify this?
> 
>> Pls craft a selftest if the issue is real.
> 
> Below is an attempt for a selftest. I got help from an LLM to write
> the BPF instructions, and then try my best to shrink it but it is a
> bit long; hope that's okay. The point is to craft the check on r0
> manually after the call to bpf_res_spin_lock(), and forces the branch
> taken to be different between the verifier and the jitted code.
> 
> The need for raw BPF instructions is required as the compilation from
> C correctly uses w0 for the check. I added comments to emphasize this.
> 
> SEC("?tc")
> __arch_x86_64
> __load_if_JITed()
> __success
> __retval(0)
> __naked int res_spin_lock_return_sign_extension(void)
> {
>   asm volatile ("                                                       
> \
>   *(u32 *)(r10 - 4) = 0;                                                
> \
>   r2 = r10;                                                             
> \
>   r2 += -4;                                                             
> \
>   r9 = r2;                                                              
> \
>   r1 = %[arrmap] ll;                                                    
> \
>   call %[bpf_map_lookup_elem];                                          
> \
>   if r0 == 0 goto out_%=;                                               
> \
>   r6 = r0;                                                              
> \
>   /* Adversarial setup: give one map value two verifier pointer IDs. */ 
> \
>   r2 = r9;                                                              
> \
>   r1 = %[arrmap] ll;                                                    
> \
>   call %[bpf_map_lookup_elem];                                          
> \
>   if r0 == 0 goto out_%=;                                               
> \
>   r7 = r0;                                                              
> \
>   r8 = 0;                                                               
> \
>   r1 = r6;                                                              
> \
>   call %[bpf_res_spin_lock];                                            
> \
>   if w0 != 0 goto out_%=;                                               
> \
>   r1 = r7;                                                              
> \
>   call %[bpf_res_spin_lock];                                            
> \
>   /* Adversarial check: treat the negative int return as 64-bit R0. */  
> \
>   if r0 s< 0 goto unlock_%=;                                            
> \
>   r8 = 1;                                                               
> \
>   if r0 != 0 goto unlock_%=;                                            
> \
>   r1 = r7;                                                              
> \
>   call %[bpf_res_spin_unlock];                                          
> \
> unlock_%=:                                                              
> \
>   r1 = r6;                                                              
> \
>   call %[bpf_res_spin_unlock];                                          
> \
>   r0 = r8;                                                              
> \
>   exit;                                                                 
> \
> out_%=:                                                                 
> \
>   exit;                                                                 
> \
> "  :
>  : __imm(bpf_map_lookup_elem),
>    __imm(bpf_res_spin_lock),
>    __imm(bpf_res_spin_unlock),
>    __imm_addr(arrmap)
>  : __clobber_all);
> }
> 
> When I run the selftest (I used 9328b3b03bdc), I get:
> 
> #1/1     res_spin_lock_failure/res_spin_lock_arg:OK
> #1/2     res_spin_lock_failure/res_spin_lock_AA:OK
> #1/3     res_spin_lock_failure/res_spin_lock_cond_AA:OK
> #1/4     res_spin_lock_failure/res_spin_lock_mismatch_1:OK
> #1/5     res_spin_lock_failure/res_spin_lock_mismatch_2:OK
> #1/6     res_spin_lock_failure/res_spin_lock_irq_mismatch_1:OK
> #1/7     res_spin_lock_failure/res_spin_lock_irq_mismatch_2:OK
> #1/8     res_spin_lock_failure/res_spin_lock_ooo:OK
> #1/9     res_spin_lock_failure/res_spin_lock_ooo_irq:OK
> (..snip..)
> #1/10    res_spin_lock_failure/pin_lock_return_sign_extension:FAIL
> #1/11    res_spin_lock_failure/res_spin_lock_ooo_unlock:OK
> #1/12    res_spin_lock_failure/res_spin_lock_bad_off:OK
> #1/13    res_spin_lock_failure/res_spin_lock_var_off:OK
> #1/14    res_spin_lock_failure/res_spin_lock_no_lock_map:OK
> #1/15    res_spin_lock_failure/res_spin_lock_no_lock_kptr:OK
> 
> If you confirm this is not yet covered in the selftests, I can send a
> two-commit patch (one with the previous patch, one with the selftest).
> 
> Regards,
> Jérémy

Hello,

I believe this still needs patching.
Did anyone have some time to check?

Thanks,
Jérémy
