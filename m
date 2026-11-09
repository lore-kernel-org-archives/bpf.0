Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794196078;
	b=FgQHw0+mfjAUhOYsIJffjLH4hrIqJXj4KHQSWQS9kIS3ODKVh8PEJQChlgW3Yo1kXBmY
	 m/4Mhs9Ee6hWXT3YO5xk32/3HJ4AIxlOvY+i76ATwvznM5ru5Sqg5wN1KjuBLroE43LqJ
	 EKQbkMDHwyqW/TnHOZeBRnrrp9xvLoQr6HAh5qV1/0OUNkESvBBkuisbmVq0ExJzkLBmk
	 DRx0rNJG/3YTC1nkjgsszHROkwgJno/XP2/qL62zvIEgl3KkiVB0GFHQxgdpIXG/HExet
	 UHfSQETGCmzP7+E+FlqyFaukwn14c99xmQgC6ur9HFV6s3fZn6jOoxkfmEUDM0Wra6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=02Xm4AXZtFCOeYUfXGvoHJuZWiU3qVVXajNv+02pe2I=;
	b=l0OIVs5+P2BRinM+J+AQCbLN1gomszIhaVN/vpe3uqc85oV6jAJxoySolz55Clcw8VWH
	 mSTEiYhwQggj4ZhOkbK8qawNo4A4hiA5GPtsd71wamOXBGg3t8A7t5BBcaLrPvh9u2q0l
	 w+JGlNane98CNRPG/JXrJfVzCEltJXFMLqJDS770UgW70YGDsCpaYEKHjHJD0RKQiG4Zv
	 o7NzPyJ0YQ7WApHd+ZY2500nYL49/jYu9dA2zRLnxPzaHeAK9OjIbbC99OPiwn3evfw0G
	 TafK18OXI5VQV/5Qhsa7NMTNcgBxW9hw5KJXw1BsS/39zEZOVHfRlVUO/aaQhqQ7NmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BRK6lVn6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D75606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 03:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BRK6lVn6
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-85f34b20042so241324a34.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 19:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794196076; cv=none;
        d=google.com; s=arc-20260327;
        b=IOiLR67O7sM6pHvPqDtGdlQhM/xnQ9EkD4xgA4KDywfNXwhgK+ZGNPnLk1BITs99Nc
         eDnfEQ0mBL7jxqWnRSyVOwpWuOJ+Iqj885IRnAs8s4gjINvzTGJNKUHwf64KlUTBD3Jc
         PkP8djqDf0GVInb7E0hamsmeBM9U1W3MEbCq6C/kspm5t3Q/ZxRTehrGesEUzSbS/B/E
         i6jhY5XajV2yyhisdZP/TgDJh2GjMz2uIdNzhXp8ddVny5kWP+wEDYBAGcTrmJT4TBc2
         SpQeR6vKLXdSQ9+Bzqhe1jkTpw2uuf4xCLOfJ9wSSxZnGhd1W3uZoJKjC6/DtykHDqq5
         FpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02Xm4AXZtFCOeYUfXGvoHJuZWiU3qVVXajNv+02pe2I=;
        fh=SLtMz6pSbd0Lq87mdHFKgx19RcaVbBPx9ENZzn6AVgw=;
        b=RjcY5XuC8trEaTLyfew8EafLuVATa5Sp0N2xEr9HdE/J8Q5VPCt01FlCAcQI0GUV5M
         /lAhXLvoc5uMAuqrRqIxWo4tFlHrF9uf29ukHem9RMiXPoJZD6OKkHa+VUhF6BVJgZAg
         +iBCQnrpmkHOhH+n0/3qewvApZk0POqDEFT7HUSfWiLClMymHIwLjE6kiEh5gDAkDBsw
         dzQAy0CovJkXGfetrrOgJ4XIDhVsMlzL6Jr1q2Cq56ciaekqAqQBl479rk3iCura4vbi
         AGdvkGJbyjy+Rfu8E3wQf4j+Bs6FkfKNaWZOeqnc4YcjoMjfM0sx4r4oYm5D3QMBc2NA
         TjXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794196076; x=1794800876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02Xm4AXZtFCOeYUfXGvoHJuZWiU3qVVXajNv+02pe2I=;
        b=BRK6lVn6DBIhL6CLmwBGU5c3a0fChD+LJ776GTef3sebth8LV/cWa6RewDLR2QfloD
         i6XPg5ZLaEUxhNKfgxDjaJCkeNk8fs4qJubLyMU2BSCLZyrEELPB790zu/svYNIEYZVi
         3o/QiRWXPC8tZXewpeQfZ/1ngVOfPM4Amr17ZpWofEtzZrZAclsRWkyrm2u8RLEVmNJO
         k/16lv17+AO3LzGt0N/wOhx8d2OJ9uuf2zpS5Qz+yvqLdwCl3ai3YQONP7GVOAV/b61v
         liIS9i+EzG4wknet/JDA/2iK5XBHkEsbXmqwpLekwmAWH5SIgvVpSvK2QIAWcUVq8PS/
         N5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196076; x=1794800876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02Xm4AXZtFCOeYUfXGvoHJuZWiU3qVVXajNv+02pe2I=;
        b=rJvORnkuTP89WfsY6hFSdWnvvSNwkZanpkxvGsFFSy9IBBN1E2ltITYBrUcNf0kzrO
         mjIjsuhVjS4rcNcEvdJQQ88q/G+N2ed67ZHF5LxnhaeFEHkIh9t1S58Tb0Vp9JCoCsDl
         VeaI+LW1HfkpGJd1hghKXWPx2t4bG73PwZ6mg2NNVyQnMNe0r0LPlM0plnNwgNmaIw00
         t1NNMCjCb0EAFdgIn4m0x1F/nrENKSs1b6VDGjBHo6AXy5vVzDBCp1/J+OUGLrojIy1g
         ++alj67gVtsWItehduU2IFnvzAJ/rrFUAdx/cUQuTodneiMf4a7K//pUNv6em5kN2q2d
         qaww==
X-Forwarded-Encrypted: i=1; AL+hErFAby8666jK6KP7x0QcQyIMqBnrz7s1PQe+mo0bb8bAzxZjFPHonod/7fYkrJBhl2Ot5k0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SRJ3liOQnyHEcvQjNK1/8gxr1F81TOxOxwaJZG0XqrlpEJWEb
	U7XrVtUGwU0urFuIKUrGFZ+eju+qXo4Ld8E4bwFTlq7EjhnmZhAlPPCis8zDX8MlYc6k8vCBgmw
	DVa9DaXE0LM9iZ20SfetsgSKpNiJV8eoa5obOlTcrgw==
X-Gm-Gg: AYBFou1AhZCIhXBk+EuLPYsVu3R1tCDYpr3qhcCdUkz+x92l485y2HXtGbKUtKGqToa
	l3doVQdDBfIdpWjbMbDRzF1u5jTuNYwvmeNTEO7dwKG7mgkFA4QehQN+godOWc0PWRkX33IQfrI
	eGkjJpZT4vQEcioa1vIJShrJCvsjFylOcI4Q9MlrahBfs9JEEJAvMN8xp2ZWlRJwi59LfoEPAev
	6s4Nn+e7ndwrDIFyIlFnGHKst3RTWmzO3X1msxv5yziEfm6/FZk5ZGjdBuQ9kPVVfrKPhWx9+WK
	tHS7vWI9We+vjRfi0N6uhjRFRcARDGpLQtvovCiwcJCp243YiRmG4x1+js9UYgc7Ydtck9Laf8s
	qg5rHdpNczOMHAJqDj7XEWxAA8SD4c2Qcm7FZltiCq0w=
X-Received: by 2002:a05:6830:3115:b0:81e:abb6:7498 with SMTP id
 46e09a7af769-85f5082de7dmr2762199a34.23.1794196075840; Sun, 08 Nov 2026
 19:47:55 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
 <20261108110406.97495-2-cuiyunhui@bytedance.com> <20261108213254.67805ef0@pumpkin>
In-Reply-To: <20261108213254.67805ef0@pumpkin>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 9 Nov 2026 11:47:43 +0800
X-Gm-Features: AclHuK9B61ylAVcWnUjeFJuyJwDuHE_2RuMPKX9QRnbJ_mu0Y53s1C9cYNJl2lY
Message-ID: <CAEEQ3w=5QwwvMJFJkpS51APoBjhed6oriCkvcieRdUFWrKtmSg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/3] riscv: implement this_cpu operations
To: David Laight <david.laight.linux@gmail.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, 
	seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, 
	cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, dave@stgolabs.net, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Nov 9, 2026 at 5:33=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun,  8 Nov 2026 19:04:04 +0800
> Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>
> > RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
> > operations use generic implementations that disable local interrupts.
> >
> > Implement RISC-V-specific this_cpu operations with preemption disabled
> > to keep accesses on the current CPU.
>
> Have you looked at some of the schemes (I think arm64 has the latest,
> but also s390) that do most per-cpu ops without disabling preemption.
> In particular they save the pre-emption check when pre-emption
> is enabled.
>
> Basically the code tells the scheduler which register contains the
> per-cpu data so that it can be 'magically' flipped during a context
> switch.

Many thanks for pointing this out and suggesting this optimization. This
is a very useful suggestion. In the common case no preemption or migration
occurs, so the preemption bookkeeping and reschedule check are unnecessary
overhead.

Implementing this scheme for RISC-V will require additional changes beyond
the current series. If this series is otherwise acceptable, I would like
to land the current this_cpu_* support first and then prepare a follow-up
series using this approach.

Thanks,
Yunhui

>
> David
