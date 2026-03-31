Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D632727FC
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918735; cv=pass; b=IyC/R78unvY80NB6g2W+ruaXtlabnuBcCzE2gMi/jYRuUC+C+nhfKjoebCN2Vc74isByoZE9JmjHoS5S+nsrvLxBVIMQXm/Qt2rK6OO0CiAtl/U1IsinfNjDcTbdWjEROKi5vlXRaxT1BahZmxZvg3JU+6WWvbdj9i6gpESbMwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918735; c=relaxed/simple;
	bh=7whmtcHJsYVlFfaedpbrYZ79Lm8OrtjsIKtIxkH9zUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQrAhFaQuz2bresmQk2KORfZ0iYbgNaj0d+O2gX3RIO00Eper+JXxdtPlswsz08uLHT2XfCHRekCno2+Z/cAlHO1sQNmZ4+zRXzPfx+I6WYug3rau3oZtOjGNwjEqF/s6+0ZHGl2K1dZbyeW7agtFe9rluE/IDQmPnMP89A8Xck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWsdCwvV; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWsdCwvV"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so48686585e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774918733; cv=none;
        d=google.com; s=arc-20240605;
        b=Lek26itxm6BGIy86HDPadzl6OVtqYMh+e0fFRYQzWvupzx9hIDDgDEqKigjEgyo2Ir
         n3Ad47hnsc+LgVbSqPEM4Z/EdsjfsUs9vIv4CHoRG0mYwdU8kUkr0W8clmVrK1CADt3U
         5HQn6vCWVguqOVbVUV2VAd7yKTDhcoc+ZgncGG/cU07KOKOiNFNvqjmwd1/+qDYSbAFM
         9m53hXAvOI24mC4qN6IQLhobKNKjN7a6q3HOU02mE2Bv8n7yUt2ouH5aTABSxyk4+DUy
         z3EFA70DibU/kX1mEU7ulFd5GCujJC0qfqRQ1rcOH1evxKfojy0rqlUssMFKJeLPLNK1
         nekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7whmtcHJsYVlFfaedpbrYZ79Lm8OrtjsIKtIxkH9zUs=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=WvJc7H/Jnpw3qDKYuZZPKbBJkLhAAKhm4hHWkg4eLuIfxgdc0+jIQdeO9+obmFoWlC
         Cq1K5pzzADfVS/xhMLLt6jU7qqPv62iw2f/zFzvYmr5XmUwFOKybAkAKAHkpQD05aYcm
         bzsYiPEyC6bxX+lKgdPm8b61OyH3q/Ff5m29ys+w63onqP511IwyepDByrR6Sh13vDdZ
         75H11AJQ5hS1Kq2fVQWJE+SQn56Ksdrkt6Icp3tTwLyHalcNpkcBLQBkPbQUukhIp72l
         ZEDGTS4ucWfWFg4CXixxKHu9400JtzivuOx3KtrAWllkZ1hgZclsc1PHmHWZFpsq9ivg
         Q2AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918733; x=1775523533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7whmtcHJsYVlFfaedpbrYZ79Lm8OrtjsIKtIxkH9zUs=;
        b=XWsdCwvVas976sfCf3RijfYsLes+xNTq2b1Nm+DEMFQVLfwBXGgOoyM2yo0rQEl+YC
         MQfM7mysml0RVse7HPt2dI8tPVHA7Nm+aVFVslw9nGEJ4M9qZyqCf4CVSS066WKICM9D
         l1bAB91Ri/QthjvzTnqCAeOcDK7KUUkrdoJQacnA5asG9WH3bjDdw0KxY7GHjbHXNeUA
         nJSMH5H2XGAEdi6811AsAZsmCeQ0VQAisAW5kG0RAQ84OUBg/MbLUQR56p2+fzAnFXDi
         2Lh17HZIdLdRuP+aQE5BDXzSRbGUvKqBWjGTr1f3rztX4tAadYduKaZjCFbeBULzceq5
         BvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918733; x=1775523533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7whmtcHJsYVlFfaedpbrYZ79Lm8OrtjsIKtIxkH9zUs=;
        b=hwX/OeRykF4CUYuvX7DbmHpLhNBk9sZ4+JLJBzr6EYdQMvRC80rU9k3y4zUs7ohoXq
         Z101WJfF+8UubsfEDNq2pW4kPMaE6qBCPNRqbwgcwJXQ3glXFMEYnety6S0tirKzuH5w
         5omshEJrsKib4a2B6jhVvSAd+X1xZr8eKKVZ9rfFXGZbw2y223ZPIBbHB8wGBv3bTZ93
         0wvKhnrx1FGv8iErTnK1AmRP+lIatlVT5IggDI3+dG6d1m2QAZ3PmoZ0SucgQTP2TO2p
         CX9k8K6hI5W2JDNqiOwdCD3+q+lzUNR3wOTMpukm94PhYTVKR/hmbFTFv0PVqxdU1NkI
         QoOQ==
X-Gm-Message-State: AOJu0YxrDxe8NfIvjgqDiqgj300nTRkEIE2vWUpgWiU6MwPbTzTHvZdP
	0I6xwjKmsz8zG5sjI+czByMMfD947bivTeRhzD+eY4Jh5ow3Jbpe/iDgS2MwaBF/IArZOLHDWg/
	XYUBQyis63qwJIFd3vhhmdGNrgCOsDm0=
X-Gm-Gg: ATEYQzy9G4C/qYDcM159If8S2hy5SphRQBDRSc43c8v5uUUSZIGU2mERvp3BZ7Cjcl0
	gGqSABJiCYXR+s64qiRA+DAEoyx0/LCKcqG37mdQbnQ+FIQsJ80QsFrWq3FaJ7EnkV8N5l0Tg6O
	4+sQf/HS7o8yR/PrPX54stTa+w2gjC4RjqR8LnaUcmZmc8BedZOJLdu28RVFCILQkWTYG0GlHWH
	NE/tMCNV1x6lDQn5mIxoTp9hbVZtJ7Zt/+1cfLBQb34X1u0DOFBF2vbA+84CIw3zHSRIh+rVMJO
	HgnSHThwc4taDNXQzL5BlDDpjzgRD/wz7cv/cFfpDR1FUrCdrsP4/am6qhmY
X-Received: by 2002:a05:600c:4205:b0:488:7784:d06 with SMTP id
 5b1f17b1804b1-48877840d50mr19410765e9.31.1774918732556; Mon, 30 Mar 2026
 17:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com> <20260330-kmalloc_special-v2-1-c90403f92ff0@meta.com>
In-Reply-To: <20260330-kmalloc_special-v2-1-c90403f92ff0@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 31 Mar 2026 02:58:16 +0200
X-Gm-Features: AQROBzD4qdQnkzBhUZ5Q-JQTYx1JdU1Fbf-kukJZwpc6Ljpn8TKuK4lS4gJylkk
Message-ID: <CAP01T74DWLiwxbrh56LqMDZBbnDejLOwjeaT8seGKMFA-VdAmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Migrate bpf_task_work to kmalloc_nolock
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 00:28, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace bpf_mem_alloc/bpf_mem_free with
> kmalloc_nolock/kfree_rcu for bpf_task_work_ctx.
>
> Replace guard(rcu_tasks_trace)() with guard(rcu)() in
> bpf_task_work_irq(). The function only accesses ctx struct members
> (not map values), so tasks trace protection is not needed - regular
> RCU is sufficient since ctx is freed via kfree_rcu. The guard in
> bpf_task_work_callback() remains as tasks trace since it accesses map
> values from process context.
>
> Sleepable BPF programs hold rcu_read_lock_trace but not
> regular rcu_read_lock. Since kfree_rcu
> waits for a regular RCU grace period, the ctx memory can be freed
> while a sleepable program is still running. Add scoped_guard(rcu)
> around the pointer read and refcount tryget in
> bpf_task_work_acquire_ctx to close this race window.
>
> Since kfree_rcu uses call_rcu internally which is not safe from
> NMI context, defer destruction via irq_work when irqs are disabled.
>
> For the lost-cmpxchg path the ctx was never published, so
> kfree_nolock is safe.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
