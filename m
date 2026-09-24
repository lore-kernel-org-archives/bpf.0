Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB594119F9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269780; cv=none; b=dlpB+vOqThm2wEdEmp6N9FMB/OXYuS6Nnj8nghl1drwftsE/lVFToC/4TLMW9MCmawESZebcGxW2xfXHoXzRky9+npGAWo109CanJrqvqAsv1/vhGBjuiGcLFEQaMCiSeunVR4BO68sFqp+1faV5jsD7fB9m7GHbbl/lYarBdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269780; c=relaxed/simple;
	bh=7pzohy9sT4rBMz0HEJ+QrxsCwJ0UjQm8fXl5CtM/1mM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kAQ0KNdkEcsS3VLPHtxpnCEf5kUZWQRRpttSW3EbPKsPhUaq/E1vcoLD0lzuzPMVwpUNBudAGLtojJ2/cEphgJVeblsZ2Fgi+H8N4wpQxeRebrb8H4JZcus+wF4kFiSP6wvahyQsOxP8SzcPxsaVicZxwEe6UEHwRRUuznAIRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1Wpu+Bw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1Wpu+Bw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702E71F000FF;
	Thu, 24 Sep 2026 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269779;
	bh=dA+vG88fkQktkh0wFfH9mwhRA7a75kQtb3tGiw5MNHQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=I1Wpu+BwU+2bqhiwOGXQSC6M+Ba3+jZzagI/sVfMUprW0bWP4zf26qzcS37M+RS/G
	 2Ngi/XOg9pk9wmpLZh+ORETLR3KZpgkz0Xjq4wq2MjMEoPhraMBS3j9VwElYjJ+lOo
	 PTwM5dcnUOueekT2NGlGIReehaJ73GfvQb2DrN14rRsGCE3pgd4VDpjKsmF0BsrrHs
	 gOxba1JT/Jf27A0pfOWSwAPN6o+b1ByWxiTBPQjcAnGD/Ba3MsBoD6+SHAnbuhcWdC
	 THX97MKhH1sgAAQUTLlibVVWzkpQo94xoGBJ/b+42aaPX95t02z3lbURxwuO1eT79/
	 N/1WeTsyK0cSQ==
Content-Type: multipart/mixed; boundary="===============3564292154833326797=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <606148ca7628d48c0b8499e976a6995ab05eea9e0d3c80c9523b02e66193b1fa@mail.kernel.org>
In-Reply-To: <20260924162609.1746610-2-puranjay@kernel.org>
References: <20260924162609.1746610-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Look at frame 0 when telling async callback entries apart
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 17:09:37 +0000 (UTC)

--===============3564292154833326797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> push_async_cb() sets in_async_callback_fn and async_entry_cnt on the
> callback's own frame, which is frame 0 of the fresh state it starts, and
> setup_func_entry() copies neither, so a subprog called by the callback
> carries neither.

Is the attribution here accurate? Looking at the verifier code,
push_async_cb() doesn't directly set either field. It kzalloc()s frame 0
and calls init_func_state() on it, which initializes callsite, frameno,
subprogno, callback_ret_range and registers.

async_entry_cnt is actually set by push_callback_call() after
push_async_cb() returns:

    callee = async_cb->frame[0];
    callee->async_entry_cnt = state->frame[0]->async_entry_cnt + 1;

And in_async_callback_fn is set by the set_callee_state_cb() callbacks:
set_timer_callback_state(), set_task_work_schedule_callback_state() and
set_rcu_callback_state(), each with:

    callee->in_async_callback_fn = true;

> The two other readers are already correct: check_return_code() reads
> frame[0], and the one in do_check() is reached only after an early return
> for curframe != 0.

Doesn't this leave out print_verifier_state()? In kernel/bpf/log.c, it reads
the flag:

    if (state->in_async_callback_fn)
        verbose(env, " async_cb");

print_verifier_state() only affects log output and reads the flag from the
frame it is printing, so leaving it unchanged is fine. The reader credited to
do_check() is actually in process_bpf_exit_full(), which do_check_insn()
calls.

Would naming the functions that actually set the fields
(push_callback_call() and the set_*_callback_state() callbacks) and covering
the log.c reader make the changelog more accurate? The conclusions in the
message hold, and the fix itself is correct, but for a subtle verifier change
it would help to have the attribution match the code.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36029511690
--===============3564292154833326797==--
