Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D54B3CA4B9;
	Tue, 14 Jul 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052383; cv=none; b=rKJsJxS8TN8ZeBTKNzI1ctjlP+INsbkfCq4vVgU1URC25vGHKSyCz16Lc1NoXiODaQoTwm5s1YZBgzuP4D4O61RE7cHPtwV6o+FRNvDqGICMuTi6FhNHn22jNiXVELDDFSkk1y12BPDaHnst7sWjEnoDrdX40+m3m9BaSnzYb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052383; c=relaxed/simple;
	bh=I4vFO55K1s9+271KQFTCPFyP2QEfRBU94YL8Fjlva8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZM8BorNbQW4fOlpVal9BR1ivQ9F3F454g0Tmv1uOOlfUJk5+JpoMRHE2742AbsCfTHntv2RmRz3bZ/e6wyNAsUsFaYYB0vzApQkikJNH6/B6DjrDZEnkBs4C6rpP9UESryKgHuODqxPPWUJ+Th81m2lwP6RcA/NnBFv+L4rQ8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=mMSDxHOI; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="mMSDxHOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=FIj06gQZO2J73HIo/WORiPffzOUtPsehf5
	3MLXgA94k=; b=mMSDxHOI0HaJ7JlBoM5Erp+l/MMFHGcEo/kd08i8zquad2hE3n
	95PWMZKRGJ0V+tdcCsiy1PZDzEVyTpCdTKmhIR1IBohcnKDwz/5To7zNp/g1XXZ7
	JvJMZ65tQSMvrE72a7BNvzVQKIWi2w02GCqWT6HArTebXt10oH+AigeIs=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAXwZNlelZq_PPtAg--.1090S2;
	Wed, 15 Jul 2026 02:05:52 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyy23@mails.tsinghua.edu.cn,
	daniel@iogearbox.net,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: Check byte type when validating helper stack reads
Date: Tue, 14 Jul 2026 18:05:11 +0000
Message-Id: <20260714180512.3910011-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <77e5d785ca08a5fa57c661d9494f4551d0b55425.camel@gmail.com>
References: <77e5d785ca08a5fa57c661d9494f4551d0b55425.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAXwZNlelZq_PPtAg--.1090S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWrJFW3GFy3Jw4rWrWxJFb_yoW5Ww4UpF
	4rGw13Wr1kXrZ7C3ZIvF4xta4rGrZ5JFy5uFs5WryUCry5uryaqFWfKrW5CFnrCr1vqayF
	yF4Sq398ua98AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUrhL8U
	UUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

On Mon, 2026-07-13 at 21:22 +0000, Eduard Zingerman wrote:
> Sorry, could you please explain again what's wrong with the original check?
> Here it is:
>
>                 if (bpf_is_spilled_reg(&state->stack[spi]) &&
>                     (state->stack[spi].spilled_ptr.type == SCALAR_VALUE || env->allow_ptr_leaks)) {
>                         ... accepted ...
>                 }
>
> And it says: if there is a register spill at 'spi':
> - always allow access if the spilled register is scalar
> - when allow_ptr_leaks is true, allow access when spilled
>   register is either scalar or pointer.
>
> The goal here is to avoid leaking pointers, and pointers are always 8-bytes.

You're right that this block is a pointer-leak check, and a scalar spill
can't leak a pointer -- so the fix isn't justified on those grounds. The
invariant it targets is the other one this function enforces: rejecting
reads of uninitialized stack when !allow_uninit_stack.

The block just above already gates that:

  /* verifier.c:6780 */
  if ((*stype == STACK_ZERO) ||
      (*stype == STACK_INVALID && env->allow_uninit_stack)) { ... goto mark; }

For a CAP_BPF-only load allow_uninit_stack is false, so a STACK_INVALID
byte should reach the -EACCES below. allow_ptr_leaks and allow_uninit_stack
are both keyed on CAP_PERFMON today but are separate flags; reads-of-invalid
is independent of pointer leaks. The existing fix for the related
producer-side bug, 69772f509e08 ("bpf: Don't mark STACK_INVALID as
STACK_MISC in mark_stack_slot_misc"), frames it the same way:

  "we should not upgrade STACK_INVALID to STACK_MISC when allow_ptr_leaks
   is false, since invalid contents shouldn't be read unless the program
   has the relevant capabilities."

After a 1-byte scalar spill to fp-8, save_register_state() marks only the
covered byte STACK_SPILL; the sibling fp-7 goes to mark_stack_slot_misc(),
which (verifier.c:1234) won't promote STACK_INVALID. So slot_type[7]
(fp-8) is STACK_SPILL and slot_type[6] (fp-7) is STACK_INVALID. When the
helper walk reaches fp-7, the uninit gate above fails correctly, but the
spill block accepts it anyway -- bpf_is_spilled_reg() tests
slot_type[BPF_REG_SIZE-1], the fp-8 sibling, not the fp-7 byte being checked.

The patch makes the fast path cover only bytes it actually marked, so the
invalid sibling falls through to the -EACCES the upper gate chose for it.
It's the consumer-side counterpart to 69772f509e08 (producer side) and its
direct-read selftest f513c3635078: the direct read was already covered, the
helper-argument path was not.

Runtime: for a CAP_BPF-only load, passing fp-7 as the value to
bpf_map_update_elem() after the spill to fp-8 exports a byte the program
never wrote. A direct read of fp-7 rejects; only the helper path accepts.

The commit message should say this rather than just restating the mechanism
-- I'll send a v2. Happy to move the fix elsewhere if you'd prefer.

