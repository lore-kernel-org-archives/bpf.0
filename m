Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478C2F1FED
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119181; cv=pass; b=Hzsmg42oM6ZMoBy9Wp5oK8DJcWGeGxNY785yztUWw8xS8xlvBUTtO9VR8GL0V0JHISKfsQttEPUSDTGcpC+Th+uBh+GX5ukO45Je58KWDm9eguN+0WqY7Uux799q3klaTLrEYkkuWQ8OzkXqm8vW/rjxy+rQ69PebA5igzoh0c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119181; c=relaxed/simple;
	bh=IOh0/n2wnztbh7jI3wwYJTRSPF8heXdCfIXqfe3z7ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+bgI2SDe38Gcy1ngRIT7PhCBAl4YudR+6GzSYVhoXXstq5vy2CaN086sKnATu2pvari1RSYn76vZSRBmNRMR7mst4dE+4VVQW9ZYxag8rz+4V7Qw0z/uswmUhUFC1rlCtZtYLwB16djEhVS0QXUPbJLNTjgRvnSFyMg8fDlkPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5ebj+8y; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5ebj+8y"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b4121c40aso2073045f8f.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 11:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774119178; cv=none;
        d=google.com; s=arc-20240605;
        b=KsnNcLb41pwt8oME6x13ITsGAPA6kMg/XFxqRxykmMTi4aygCM90mQRSN5QAQJdock
         8CT2wcMR24/XinOKCpkIaMh8QQfTr9aJUDfkkj0EMno4H/PAP3l3UxgSerOHBv0vesFY
         WNNl+9MCo2KK3BzfbtxozjiLCEi3eWnQsSvcSwFg4Ft24c6qw/kFWNEsVthoc8miRhWB
         KqhyFdOw5JgWCd/jdlusrBE/K0ea5JQEfRPgs8abfW0TNg9+5gmNCSSwkf0dVmUoi8yx
         cV1TC1UeyU5daqh+9ci0Ym+7Zd+H7M9IznYExJf5OXTvkNMtNLy1AwhT10iWrwLlEsu7
         Rofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IOh0/n2wnztbh7jI3wwYJTRSPF8heXdCfIXqfe3z7ds=;
        fh=zbwWrodAJh1o6m/NjWcls6BpyZ2t3nJAEStZfEoJ+z8=;
        b=cmst2xa9QmdPbpnpbHg0d04ZDIYfHwy9IXX7KVAJHZBvAipUinOU18DyN6zMIibb0D
         2xX86GqFPmtqSKTvdHA6VS0PSEXKi0kpm0W4uGDWFE7g2URCK8npLCnsvhKmY8yu7y0v
         afJoCyEJQI0yBR7Dp0crOGB+kC+b8lvdiiVpTckZrLkLpNFQCa+GWHndHXf9aDLK+rGY
         8sIdolfQMdPjkZuZcWfGr8CGF1c55PcvMO9WsAs86lrmRGi1I+LVcImuyEQ30gSYohFt
         NRvMBC93bAMkc9//kN++YTFMUns+NBITeyDdO4LSBLVoyp7jxWBFMJnNjsQDL8c8ukj3
         uMfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774119178; x=1774723978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IOh0/n2wnztbh7jI3wwYJTRSPF8heXdCfIXqfe3z7ds=;
        b=P5ebj+8yOFDDai0epduI7YkDZo10JHR07LRn0XJc8+1Lrrj73mYLFwKvMLPr+IVUPQ
         UY8lDikxMAYZVYNqd6tWBEQl3pIx0BttYpuCSsyGgsrNtP6hgOV8x16zLBXDMw4X8mL1
         0fYMrDUYFTLfORDT9Wdr59ZbD6FFKlRI9gX3xNbfI3AyBriuzLUPh2zuN7D4Ogxcqamv
         ByLZ4ynu3ZQRdrDGdoetXRvlktn5Dmg6RAdJvsS2j1wRUcvPspvf2HvTSePrrkDsjElz
         IRjI4tk8Gxuroenvd4xHiC2LIMLC5pHNWiyENJKyslWJRxUkxVuLaFYGB4CTHjo7ts1S
         fTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774119178; x=1774723978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOh0/n2wnztbh7jI3wwYJTRSPF8heXdCfIXqfe3z7ds=;
        b=P8V70dD3V1Ch6/SGHta61wp/k/bwRjuCivumlLKjOBXycQTq0Ie7w7iIIvqFYcxP6N
         3kHn8isJ7R2o4c+7NBNEzbBlUaIyPh/BBew1v3vnu2ldGZqzEXbxqkXGxwUif2AbQvUX
         3uQmkWY1fbUf62EOrQzKPBgmuMWQTf6Q7T6jesSv7RWpLPS/72fWw3d86hC1ZnN6VMuM
         yy0zaHC0mfMF2oYMQEXoz8EcoCUnN4ytW5snPc8SKtZKYofl6FD/ktv7iG3TvDdwh0uX
         MNMpHi40x8ppIMCM/k9opbVjyrcj3j/LJ9RlQABZnsN94+YRvKs/fbIUIqff4wL735uL
         sFMg==
X-Forwarded-Encrypted: i=1; AJvYcCWytnfXDYGXmuK8z3HNvNxCazEtEpRTCpIJKRCn8oiZ+BErRwV2JRUQR80TkOBczu1cQsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJsRBi5c7MzHTCz4zXkkI8R7Fw6uBNdc6sZOOOy+tZ5ks6Dsh
	C/hnLuHAj8uOcu6+Wps+izs/du+IK+r5TZTa53elrAqfKzGNCSuqpMErcBKEyAuGuSm4dEMXLB1
	VQjXD4dw8HhqBS81DipS1o5s6tk3O4J4=
X-Gm-Gg: ATEYQzxBzwOaA3fJDaXgAfRkmJ1/pt5wpQtV4kXhCqTyj7SETBgtqmjbyApQoh1HlJu
	Ul4H0l1N0bXQemkZl0A0bIwazaFyfxIrc2WDrigu6/+oeFYH5m6UjB3OhIrgnfo8tEJnOpLDdge
	KDReI4VMJeXWSQM2c42OMG9czuD5N5d8x6j1xLCLD6AavZw0w6FQrtK+i2xTFyyLQNbQFrl3fAM
	zmrHh/Ia2NMR6uRtqhKA9XgWiMLXZr858Dq3YCfUnjSvDBt9VAPNw/QFtrJffU+zIY8KIoDzjz5
	puID1Z+4AexYbdPqkV+v+fNmCy72zhEOV71aqk7AKc8yv05oiD51MG+mH0Y=
X-Received: by 2002:a5d:5d02:0:b0:43b:45d1:f44f with SMTP id
 ffacd0b85a97d-43b64281799mr12535478f8f.41.1774119178339; Sat, 21 Mar 2026
 11:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320000809.643798-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260320000809.643798-1-ihor.solodrai@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 21 Mar 2026 19:52:22 +0100
X-Gm-Features: AaiRm50d62VH5y7b-3ojOKFGxQKI_fMfXNs7fEtswSsZCYuuT-C_8srVCLdHmBQ
Message-ID: <CAP01T74oJvKwM84DoOE714ffb-seXBQSAM4J-68WbM+=EEh+bA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix exception exit lock checking for subprogs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 01:08, Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>
> process_bpf_exit_full() passes check_lock = !curframe to
> check_resource_leak(), which is false in cases when bpf_throw() is
> called from a static subprog. This makes check_resource_leak() to skip
> validation of active_rcu_locks, active_preempt_locks, and
> active_irq_id on exception exits from subprogs.
>
> At runtime bpf_throw() unwinds the stack via ORC without releasing any
> user-acquired locks, which may cause various issues as the result.
>
> Fix by setting check_lock = true for exception exits regardless of
> curframe, since exceptions bypass all intermediate frame
> cleanup. Update the error message prefix to "bpf_throw" for exception
> exits to distinguish them from normal BPF_EXIT.
>
> Fix reject_subprog_with_rcu_read_lock test which was previously
> passing for the wrong reason. Test program returned directly from the
> subprog call without closing the RCU section, so the error was
> triggered by the unclosed RCU lock on normal exit, not by
> bpf_throw. Update __msg annotations for affected tests to match the
> new "bpf_throw" error prefix.
>
> The spin_lock case is not affected because they are already checked [1]
> at the call site in do_check_insn() before bpf_throw can run.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/verifier.c?h=v7.0-rc4#n21098
>
> Assisted-by: Claude:claude-opus-4-6
> Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
