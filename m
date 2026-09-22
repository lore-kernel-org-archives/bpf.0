Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED24A6887
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057597; cv=none; b=mZvRPGI0DT/WNeKz2O6d07+bApC29LiRUm32BA3iH1a2cZXJPs47wJTmr8E43of1w4hXUEOtzG61wXhwKF7GlX5mDldnnz+gl/wvW0EwrkyyN43yUjTohVcicTGjvxG/hOGanXxmDdSob+5LORQqM0RLJkjaLgnFmQqNhtwHGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057597; c=relaxed/simple;
	bh=OmlUKj/ulZo6jjnsRsp3aCysDEXAdhwMqxnmMiR2oGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFzM0Jgamsc4ummTVzM55+EXEFrcDild0PuckMmhFQIp6qvw/bcFQGeEtP4XPtMFDm2ZUhy0kHfbDQD/jh3JY7a1KqbRT+DQEdE6kVJRSxoiVGG1n6up1ktrFC0NB9QeaN1OSYcCgAZKXWlK0fjF3Sw4JwAnpihRGTIGAlrL4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d0Y7/6ll; arc=none smtp.client-ip=95.215.58.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d0Y7/6ll"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OmlUKj/ulZo6jjnsRsp3aCysDEXAdhwMqxnmMiR2oGY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790057590; v=1; x=1790662390;
 b=d0Y7/6llTmF7IRliH1O2KdHfiHLDlPWbdRFmQnca4n4yR5RzHNd9pszM5y4kT7tBOqfi1Q42
 WnrsgbxCYhJYFa/nbLXsT+A3yswGgEooLSIF5qitA5a+QUIzTZBWRRo+kWKwYq8t0vvUzP5pXBM
 F2xMPkb35eRPu7ZRcC4Z0jLY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9466fae14cfb5157;
	Tue, 22 Sep 2026 06:13:10 +0000
X-Mizu-Trace-ID: 9466fae14cfb5157
X-Migadu-Flow: FLOW_OUT
Message-ID: <ddb3c0eb-2a95-4af8-a9b9-a0624d38a7bc@linux.dev>
Date: Mon, 21 Sep 2026 23:13:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/6] bpf: Scope callback arguments to their
 frame
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Nicholas Carlini <npc@anthropic.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
 <DLLGYV7DI406.JRNDNAZ4S29I@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DLLGYV7DI406.JRNDNAZ4S29I@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-21 6:55 p.m., Alexei Starovoitov wrote:
> On Mon, Sep 21, 2026 at 06:03 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> 
>> Neither has a local fix: both arguments point into a helper's own
>> frame, with nothing longer-lived to anchor them to.
> 
> It's the same problem as a pointer to callee's stack.
> check_stack_write_fixed_off() deals with it like this:
>    if (state != cur && reg->type == PTR_TO_STACK) {
>            verbose(env, "cannot spill pointers to stack into stack frame of the caller\n");
>            return -EINVAL;
>    }
> CONST_PTR_TO_DYNPTR wasn't spillable before 7.3, so nothing depends
> on parking it in the caller's frame. Reject it there too ?
> and then no need for REF_TYPE_FRAME complexity?

If we focus on the nasty bpf_user_ringbuf_drain() bug specifically,
then yes, check_stack_write_fixed_off() change patches it:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d62c0f74cff5..f261423e9282 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3668,7 +3668,8 @@ static int check_stack_write_fixed_off(struct 
bpf_verifier_env *env,
                         verbose(env, "invalid size of register spill\n");
                         return -EACCES;
                 }
-               if (state != cur && reg->type == PTR_TO_STACK) {
+               if (state != cur && (reg->type == PTR_TO_STACK ||
+                                    reg->type == CONST_PTR_TO_DYNPTR)) {
                         verbose(env, "cannot spill pointers to stack 
into stack frame of the caller\n");
                         return -EINVAL;
                 }

However it doesn't cover some of the new test cases:
   - user_ringbuf_callback_park_data_slice
   - user_ringbuf_callback_park_kfunc_slice
   - user_ringbuf_callback_park_clone
   - user_ringbuf_callback_park_clone_then_slice

(not counting the diag message diff)

The original suggestion that came with the bug report was a
cb_dynptr_id field in bpf_func_state set up in
set_user_ringbuf_callback_state() and read in prepare_func_exit() to
release it there.

The cb_dynptr_id seemed way too specific, I didn't like it. So I've
tried to figure out a feasible generalization of the problem, and came
to "verifier can't track a lifetime of a ref tied to a frame", and
then to this series.

I think we need to decide whether the REF_TYPE_FRAME is a useful
mechanism in principle, and whether it's sufficiently generic. It at
least covers the cases in this series and more.

For example AI also flagged for me parking the vma argument
(PTR_TO_BTF_ID) of the bpf_find_vma() callback. It's low severity,
which is why I excluded that from the series, but "reject a reg type"
wouldn't work there AFAIU (we would break many legitimate programs).

Opinions?

