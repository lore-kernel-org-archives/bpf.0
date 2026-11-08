Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154113;
	b=S18Nvcfj4hZfYVZ9DSrdTrQ2lS8ylXF+o8e5czAZgUIJD84ZzXFJAUL6s82NvAkmpbtd
	 x0di7IrXTItBF/T0KhTu37ATEmP1/7bSt/Fu/4fHIjOtJTDvF1Py/H2oDyjLSjbeizuma
	 npY0OMHKgkS7DeMQcqzDj9QMw+rrk8RXOZZKpl5ciidpbOA/WzXWJ8FXb9/5BTSntrwkN
	 Gc9czPtH5IQi89WKhck1uXDxXUukkT3RZD+uQQUfEPA2F/ClU91GIGsWYdDMQX8af+Pl3
	 vw+moowuEgCIAL2VG6cbJsZZVc/nYcy7seMpBcD7e0JWme9JDD7nKO14be4K0/qrnSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NOeGCapXsRsus++SJZpGsxfNcw1CzTDVFljcgsUPEu8=;
	b=JzFN5S/chRMbsy4BwXb03VwbaNiP/a4IFTDAw3xpjEWYVngNhUYXIQMxM76Hhut4zSUo
	 VZ4j+rDrOQjaRFgAmBFHscGQ5pVWxMZf4UifZMQnkK0kO+tqY5ZH405u9mIT5b/2F96hP
	 bEtVY+dwVqdf63Ib2eEsk9YoZio81Pl/b/m63pKkWutHwgOYvEp7lpYwjpMzIxbhcsdVW
	 T1lq/zpidz3ZwA7j87tT4/zOBUyHnfAmlRGP6U7BGxqRCSxZPHqZ79ot0rjVCkSyKqqj6
	 8TqxGHd+tzcZMM/vr3d8x8JHAE7uOrLIA14rbK2s5WwkqaBRabC60S/GfMYWScJVurA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGYSDAtE;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9C606A320
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 16:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C9C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGYSDAtE
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so23498a12.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794154112; x=1794758912; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOeGCapXsRsus++SJZpGsxfNcw1CzTDVFljcgsUPEu8=;
        b=aGYSDAtEdlBLfdaNDrcA4Lv8CMszBAHg16mNQpcopnzWybzcqIHqW0yCy/+4zfnM19
         W/muVidveSVd83mrRsuS+F29SJLVcWR/wjHW56T9whTSpjcAfZsl4Igbuin4y8IyS1th
         Hb6953t1MIY8NOAV83aMqqFiduQR+KT7cTbruQuaTR88m+jX/S1qv7tTcOgYnvGabmQF
         ZhKaMYT/vDudq5/iBKApAe4rSenQc0c5/ADS8fGP6ddflvI+graBxqYVJSq2OvKPwT5U
         P6E1Jt8NSbel5pMcBEpmUJYSYU4LtF0edYuUDzaZ+iImfbWwYDy6ox6O/eqnxEnUv6dp
         F3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154112; x=1794758912;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NOeGCapXsRsus++SJZpGsxfNcw1CzTDVFljcgsUPEu8=;
        b=vqngpTz7pG3auysutz/eFqJC9Ty4RaJbN07P3Rr1KBWbmGqYcZLsqymOIJJKyxv+b/
         xuzAuZyQyxRvG24R6s4Y6fgyoXDA3JGqIqiPkYEDVfOAfPpT8iL3t9DDTiNQJwkXx8ft
         4k5mAuNZNhwMnJU14bmrfV5Spvb3EXNutkLVKH71o+PNSfhH1tXTMwTBU/gZJ8CswD81
         JY1qu9IUkMJWO8IaD2/exQ4CPI0Hksd7NM2gMq1pQvIhWv443xI68A6yxa4fUo1pbeG9
         hbq2FSa/Rn5EY7itEUXSVuR5ZZjjBTfPj9RXKVvTUdJgEYowvOFyl6EWs/2eXiFrDf21
         1HSQ==
X-Forwarded-Encrypted: i=1; AL+hErGNK1wXTbUKNDFZS0cZMXkyhqVETCCns15PEvLmUkiV+BAC/4ckWMns7xnT/FgSqetlnMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YxPjRtzlQWEZ/RkZDIhp+ea17LqVD24kfjmwBcQmy+IzyZ75s
	B/5eZOgnAgTgC3naXtRcIg1Pe5I+E/bdK5l0HkeH1A1IVhZ8GEOXfbVsb89SRA==
X-Gm-Gg: AYBFou1R8vLU9oPL/v//qDvaa+RGS/EZ8a1mRwQD9uG08a1u4nascFL/7h+Pvfn3avo
	1+B5/8JAdI9PEuptOZkLoQwlHq83IVrLALtiFc8YcT/SQlWKIR6dxN6iN9+cTDSrUOaYuHhMhZm
	2dHGyjZZgKNJ+Opof0a5qe/zYzgUvq8eLqe6kaeg8SJjMy4Ptr6HyArwJ9cjbgQFLumoxaOFgiq
	8kFp21DIl6AQkKFjX2W8GAxa7eiFJjoWLc0UD826RoJ13s+wofFmM4YyX5Rb0PR+QKcAvJlfHgr
	2wAK3vuIskhSrKRXqyv+KpXFCAMzAHgUFYwN+xMbeZ28XPnlgYPcPkhiEQxzjPPqo40DDiXNzil
	nKzKK8ct4NlclUTTvuRO+zK7U1vsDObTfGDomlx5y1y1/+3sCFxRyasqzR2Eff3Icil20BilF4E
	1cgwfa7IfuopsZBsY6W66xVH+kM6f6eWhAW/PEKiBX4ItsGcK4iO7J3kFs8p/ibMK5r61Pu7GBK
	7O3nMY4EkxXz13KTtw+4rU+OCERnxvidNBlieDrq5dov+vfTMQmTLDXKj88VWGfgxH8xlitT563
	lvHWQyhORUBxOy4/rEHAx9EsmVeV5RSxSlp8hK9QQMfTZkWCj4JEaveeZJzJGYVTEAMkbf+eRg+
	WOrW6bq8Vy/e/b7qzMd+EZ/+r0K5vhmHPljU=
X-Received: by 2002:a17:90b:184c:b0:3b0:a4d1:6d7a with SMTP id 98e67ed59e1d1-3b12d33d28amr1278110a91.31.1794154112257;
        Sun, 08 Nov 2026 08:08:32 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm7405174a91.10.2026.11.08.08.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 08:08:31 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 16:08:31 +0000
Message-Id: <DMPYJW83DBZV.2HJY5R042YSW2@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Keep one basic block in the level 1
 log and print the way to it
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-203594@kernel.org>
References: <20261108053937.4134138-1-alexei.starovoitov@gmail.com> <20261108053937.4134138-3-alexei.starovoitov@gmail.com> <sashiko-outbox-203594@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Nov 07, 2026 at 10:02 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> @@ -2883,6 +2886,7 @@ static struct flow_state *flow_new_state(struct bpf_verifier_env *env, int prev_
>>  	s->seq = ++flow->seq;
>> +	s->from = flow->from;
>
> [Severity: Medium]
> Does flow_find_state() look up the caller's basic block with a callee sequence
> number after a call to a static subprogram that is verified on its own?
[...]
> If verification later fails in the caller, bpf_flow_print_way() steps back to
> call_idx carrying the callee's seq in from.  When multiple states were kept at
> the caller's basic block, s->seq == seq never matches in flow_find_state(),
> so it falls back to list_last_entry() and prints the wrong state and incoming
> edge for the caller.

Not a bug. It's a limitation.
When the seq is not at that insn flow_find_state() takes the last state
there. With one state at the insn that's the right one.
With several states the way can show the edge of another state.
The way is a help for the reader. Nothing depends on it.
Level 2 has all states.

>> +		if (level1) {
>> +			bpf_vlog_reset(&env->log, log_pos);
>> +			env->prev_linfo = NULL;
>> +		}
>
> [Severity: Low]
> Should this also reset env->prev_log_pos = 0 when rewinding env->log?

No. Not from this patch.
Inside a function every prev_log_pos is larger than log_pos.
The rewind cannot make them equal.
The case that you describe is the first block of a global function.
The log is at log_pos already and this bpf_vlog_reset() does nothing.
prev_log_pos is stale there without the patch too: do_check_common()
does bpf_vlog_reset(&env->log, 0) after the previous function.
The two have to match to the byte, and a newline is all that is lost.
