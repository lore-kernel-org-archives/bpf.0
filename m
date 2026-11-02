Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642318;
	b=ie9Q3AZdT2Vi7TPJoB2vDRFQE/rcpV/w2IbhQW6Ufcn7deJUwcJu6WAiTDl/x0KBZRuO
	 2dcGldpTlPIgz/nr3l2WoyhNqrtSrMDl5rIEY+Ev38UFZg4dVWEA6eqlQ3Q5N8Yj11yQx
	 OhM08SQLV2zqTOlMM2512TK2RUobyXpdneakRoWHZlcd4Eln2kmDSnl5FSScDMuSLYARl
	 R+NMuIAEA6x82pg89NPX9X5QZrI5HuEy/+tmCSLaqHgdhDMzhVk7L9Ws1mpynO2brSAbT
	 RpPAfYxD1P7yTJsRRN4/t3S3070gXF+/P/Vexz0PIvj81uefNAJXCRlRNX3H6R/tAUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Okiwnou1thUdYIfeciy+uAmX9brOMUd6hX/JS+Jol+I=;
	b=oEBUou9MZ48IbotFR576pgXoLJdQ5i5wTOH9RxlNvs7cnMWkGMzHURN0626JK9l8C6CC
	 N2zSdO75CtJ5mR0FV/NnhuuUQ0nEuhu9UhG8bO8mslgEfzKKjO0pbKC1nQtXJv1BILNF9
	 P2wgQU0bOKqB3eOftx86EUtuYjpDks4s5zjeKI+5aoM6oGiqUrRj2emLxxJH2pT67csQt
	 xlJK7wncqcoIeMas86p8rW1/SIQL1HHaBWSIzVwRkFEkFNlcTz6rkcXs0wBQHUkcoFydM
	 zaRnBu3tEbQiBA9GYiRQMit8g8MEB+k9JZjQ09zTO8JsEe903MJnN7axCLyfQlRIrBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+rnNC+h;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225F606A5AA
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E225F606A5AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+rnNC+h
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso1087988b3a.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793642317; x=1794247117; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Okiwnou1thUdYIfeciy+uAmX9brOMUd6hX/JS+Jol+I=;
        b=v+rnNC+hS+Ivufigdvapiujk2rEOgQOmFnslLgPgd+fEUyIRNrn3ryyemo1a0V9GTB
         Xfa8H5de0auToEJlCPGAJWmskAzNUPEHbVrXZ4GcDiMrl3OCqVuy1bwon5KUQTJo3IIe
         vsDpxAfSxpUtlGQAUYgE9SAtXpUevcTIj8w7rRMZdM3QhhTmAd28iORQI8yS4hx6U/Rm
         hkESce5/12PQZedL3T2h6enx0U1a9yaMib6M+eax4GiWTiwF4FGaMnLfxqIIImf1nKli
         n203KkVJ5+B6GSet5tubJq5fdoouetVhpFDxEyKOUetclmMKFtEW/vMejdgRNvHrko4q
         WgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642317; x=1794247117;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Okiwnou1thUdYIfeciy+uAmX9brOMUd6hX/JS+Jol+I=;
        b=tdr5D4og4wwsUbQP5K2AkBHdEQiWMUII+sW08OSrFtMZcXDQPzNTuYD1/Ch3cLC76M
         Mie4YbaBvEhJSqsL3vd5/0bvkhVJXI5lhflhXwR0Sz8xcsWygJdM1HhHQn9zt+UH2s4/
         P8WuwarU5/WA/iuh5Ojme1LXaYPT14OVvIO+/OLRHUefS5Di6NvatxkffFMvhDwuChTs
         3mjk9CimAGh4aSOm3dtMfw+7O0Ok+U2JYJINpU22XUaEozwlPlatDzjLKWeWgK7Brgk6
         5MHgy8c7D8xICxOjE3q8hfxuI3DAtJHryfS/5yTgKIuC9VbZJriJEyqymDste1mEG2qj
         0ucA==
X-Forwarded-Encrypted: i=1; AKwUvBxyErcARAeUVJnBLd24NLCk+kKQRrf82KDp+j75WyOtl51m50kYOz8GrvjpCR2KxBmyfA8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/xv+CX+5Tg/1EG5XlMJw0c/wKgNw5WL9r4pGKJL50NDYswq43
	J8t2nilXGFxnOL1y7CajCDtgKJ3rJ6FGYnOVdLbLMLojO/ZmL+AN1rsm
X-Gm-Gg: AYBFou1NSjbRo5gwMgSmg/s120Eu3IUH+8160poCj3NhvZvMANj3s8kNfzbArdb6X1S
	ZtStUawwpsbiGZTLyJx3vm+ts8xSsdxTcxH7Coy5TzPus2Wt1bqBAW9gPyp6cjkipQiLjyYgcLh
	p5UisnoTjAGuLfciDLy4RhyUD4rgDVtscDm+imxld0gJN7Ej+rAmxIjwAm5wfnDxw7NCin5x9aB
	fF9DBNlBR3RN42M05/32vBp9CaN4iyfNeajXf20fGPOv3XiLv0d+KEtMEYqrmPmEblNZiNQgdy4
	0iUNsNO2Ns/spgn7wtzvGEljSEkb/q1vdrAR+MDim13+1tYSyRBhP3i+HqB6KKVyNUpoX2zDdWe
	gwxmstfMpKc/rENKnj+Av+bkQRcFq44/QyhyGdbzZtSt/DHdDYo12Jz+2CWw30uZBCImWyQsnXe
	1jyxcKqucW2toUUr7E/jzX9B66gr2BQMjl6hzrp+bAjmnDS3f4CUweBNj/g1wdqPVzYzwfhIJam
	Wze2XhOvW7cYCpg6ARelDxK2pYP1uFRNay85bOuc2Lvywdv1Qhjn17QqORIEhuQhfzHyFZsDZ1Z
	shdDPTGx8IiLb5UVvIsB/fsWCqq8tjOE8Ws9QDMadI9tGMYDeruXzwZVg9TOsE813PLNgHykL6a
	eET1QGEsf/6XvfQwA9zpSveST0Qo3mhKm6A==
X-Received: by 2002:a05:6a00:10c5:b0:89f:b415:5f0f with SMTP id d2e1a72fcca58-8a9c02bb42cmr8571876b3a.50.1793642317184;
        Mon, 02 Nov 2026 09:58:37 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963d6acsm2326853b3a.18.2026.11.02.09.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:58:36 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 17:58:36 +0000
Message-Id: <DMKX4WVWG2FZ.O4KZQEIOSRA9@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf 1/2] bpf: Use dedicated workqueue for freeing BPF
 programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261102073439.6822-2-emil@etsalapatis.com>
References: <20261102073439.6822-1-emil@etsalapatis.com> <20261102073439.6822-2-emil@etsalapatis.com>
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

On Sun, Nov 01, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> BPF free workers can exhaust a CPU's system workqueue active slots while
> waiting for pack_mutex. The worker holding pack_mutex then waits for a
> vmalloc purge helper on that same queue, which cannot run until a slot
> is freed.

This doesn't apply to bpf tree.
Commit 4eaf4d71b91a ("bpf: Keep the symbols of a program until it has
ended") moved bpf_jit_free() into bpf_prog_free_images().
bpf_prog_free_deferred() queues it with
queue_rcu_work(system_percpu_wq, &aux->rwork).
So with this patch the pack_mutex waiters are still on system_percpu_wq.

__bpf_tramp_image_put_deferred() has the same problem.
It runs from schedule_work(), and arch_free_bpf_trampoline() calls
bpf_prog_pack_free().

Let's move all three to the new wq in one patch?

> Fixes: 6b88aaec81db ("x86/bpf: Enable EXECMEM_ROX_CACHE for BPF allocations")

The ROX cache is not the cause.
Without it bpf_jit_free_exec() is vfree() of a VM_FLUSH_RESET_PERMS area.
vm_reset_perms() calls _vm_unmap_aliases() and gets to the same
flush_work(), also under pack_mutex.
That's every arch with bpf_prog_pack since
commit 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock").

> +	bpf_prog_free_wq = alloc_workqueue("bpf_prog_free", WQ_UNBOUND, 0);

0 means 1024. That's up to 1024 kworkers that sleep on pack_mutex.
max_active = 1 like cgroup_bpf_destroy_wq ?

pw-bot: cr
