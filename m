Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794203358;
	b=mtE7hE06aB0aM5n4M6+RpUVQrnYJ5htdoh4ngJIZfp1YzOJ5sKrUAgg7aCOipZhy50Ok
	 As+OgQaY7aHEB1JXkARspzP3+fUNXkEY3ZcGzSvnwiICWZ983X0Sn/tnfs1IygmX/hdHD
	 K3KTNyQ1x3R1gzKjKczZ7J5aR0tTewjdC7YSEyaAkd18g4TNAhlI0Al3Wbn2r9S4UobfV
	 5aqZ3bBfjgKHDPxjLcfUpFOB7jSEfFsp4zQwoun3RZGMuhH4TwIKnlGsMeo+x16aNXw5u
	 kE8+ovPcLeJgBCD3Up9Gr7NHDd5Cw8oF6zhEVSePtSKl0t4SEzoX6dVIKhrrL8KRZgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KffYBetHs8Ajm29Uu5eM47VHa8AaiRvO1sJNqwagpnE=;
	b=BUKQHLKeGjxhDvX2cf+iZbaur33y7lTyfnNIsLjwIMq7WXJFTNuz9kV8xoQgy973w+mu
	 7vaLcyJr1z8Dv1f6DWjRzkVfF7H3JviJBYha5VMZ04x3Z7vq4T7fQOqfFxcF7krDl+5ji
	 yY+KIrjEeEjQJTiTAr+yrgiKMgt/SDmETCi1bpL2in87F1W26C34uPDxCM8zzZhh06Jni
	 OWl39HLQpVc6N/hVZB1OJJfLxYRztZg8PJW7xcEQ7U8qDcMrZYmTSBpuEkTuIxf7GrgmC
	 XsHb6gzFZbl1ZanOQMzSRaBwHFiSiUmVK2Qvq6qaayxkJDqPFDEIAd0NlV9egk1J2OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Rjb06pN7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC5606A337
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 05:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BFC5606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Rjb06pN7
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-714d57774d8so301890eaf.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 21:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794203357; cv=none;
        d=google.com; s=arc-20260327;
        b=LfPHSvGTAsdD+GY8XH0dQjgf2vt0Yl1166ZjKrxTGQgk51w4XFMpoeA9VaICUiNqJd
         HyKGT/DTja/5L+1ugWEUviCg1ARE4dCDAuGzyFg0suvNoST6TxmaR/2cHQkNzDnAfgGb
         wAAOMMmvkZf7PVnkI7+LIVgNfWTyBrC7L0Z3ZoZc3ZO6sPx1VvjR6SDStg6BOJ6MM4XL
         yCgenXskbET/U8Xrl/rtOOv9d0qySXwPuuoRmlem3C0+fbSIbA5lTNRY3ZoUNQS0HxZp
         NChbuKe2zUKK1ClcgadfAjOi3pTkmSLzsDY7j2f3wDrvjsctCgASQ2tV/ZlFGl1al7ZN
         3i5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KffYBetHs8Ajm29Uu5eM47VHa8AaiRvO1sJNqwagpnE=;
        fh=GPvBw/63Tp3ctzL2tVKinAqC00Vs6vzVVGxQIXuoMsQ=;
        b=fTcHeT0MRs3mkGOFTObK2/ORx8RsA8gyU09qJbQ4veXhcuH72BZ4yteYcu4GV81yT8
         Vt7eqOvztAzM6gg/RB68TYQO1s+OcguhJjG1kars3rw0HgDDsAVMlxyPOdEmHCHhfMgz
         FHDCthbMSxT1yspef80myycReOw+Rap2Mso7SJ0M2g+SeVFZpNiXt3vPp+0Vb55nNoKs
         hS5wQE/cZ/HQZca5pbZVaS8dGdctL7cWMpg7JEkHKFuTuNxRAMJTgAvSRhegELzJW2KX
         6D1snRF/O85zoTFS9qQP3lu9WEzYbew3Gc0+FF4FAd5nSSChpxBAz538k/vqmWNrVxku
         0Hdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794203357; x=1794808157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KffYBetHs8Ajm29Uu5eM47VHa8AaiRvO1sJNqwagpnE=;
        b=Rjb06pN7tkLtuxfanMFZD9AD+eeWrYx6u0gYZZKGAt+gHGjpHDzqqY9Hk5f/gUyvhG
         iFMbGnLWPE8t51PF7zKyhy5E6SD4YPngK/qrL9lo7bYUDivK0RaqD2HFsmEDhXLNvPyu
         FC4HcZftjwlG8NyRos8CyoCZG3h27tk6DSnJC8XH/bfL4O1ceJqAYT94EL4wAU3SL68o
         bKpHDFXNdhx4CiWxKm2UbDfM8N8Zr3GT36VkzZuFHTi+kR5eiMFCC65Vr+Cb2NwmJYtC
         MOo1skP4gTONR174efquuLLRTp/cXyE94lHEh15qzFyO5JarLkNNsBBgeFSnGiy6GW87
         JJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203357; x=1794808157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KffYBetHs8Ajm29Uu5eM47VHa8AaiRvO1sJNqwagpnE=;
        b=pxy1xDDE81/AL+IWP7PJLoXA4K7WRkUWVSYlQzL6lmR71VrHRDuE3mfo94Qt/JikCF
         6QILBh9xM+MoDTlJ7pP6Wyo2OG42KvoL8FzImSc6r9pchxqWCY84OWv9svXeKcMxUCxf
         EFW2Z+UTR/LgF1hUeJr+SDk0mJUSmCJMtUCOi81SChFKa2KOhJgmPmJQpAykI78cmaV1
         rgZvqhT+/+X71Hz/ZbbJZEGSsbIFx2SGmp7R4rBgkdmJSMa+QSr2C/kqrfQp0ybw4Mzg
         guGLEAXbZRBBF7Tb1oxid7zaFD81LW1bhoECn+kvqQ1nRSruX3R0UgaokYO/Ju4O7RlM
         hokA==
X-Forwarded-Encrypted: i=1; AL+hErElJAcfJ6yBRw2+1BZlRpHL+ouwPXGgKmoswz7wKmUKB+TPAATlxKaw6O7lhus5dyCF4rY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PM43lwgbrMduLqomhea1zaCpQl5nvMg3pUcdpcZMqImaS2xKK
	i04yU4QAsrA6UqDOj+xMahT5BkDbHU1T2KMLUIUrrBLmIsUZW9svROokWZyXpwlRlPLTw2M36Ot
	woEHohyWKOSGELAmv5mItU9VQMDfj4z9qO0dJ0APJAg==
X-Gm-Gg: AYBFou3sZVCAHQ8qQ5eGftluQytRqqzYwCWuqHZbDMYE7IPZx5G4v4NazEp8UPMYusS
	kgXvvdAWEeQb1DaZfO9xm7Nbm/aKomdnmVJ0DFS0vqY6rBW6IPXxbNeccqMeGxXr3MY9WsBmu0A
	o1Faed9+CUbwwmuy+q5yD4+YWQcQLEnt2gj8Jy09CMk+hEzQGkGWD9FZJ1nUmLLzGns6/dwALrB
	aW0g0FdLfkFH+UwfwYmlj5T8jVUg+ZXh30PVChHET6znpj7KltPzjlixMuidHiGuECA2MZBtcmn
	ZEubOPecO3qsFNQCchOc9F2ZxwKZ+q/wJ9/3v6tK9hyRnugJPVpkEwY4dlAUF/OaNifrVOO1mCt
	CYIT7yOcrGhmVB7LBZGRqKs5CMWtEg8O23VojfZmkkr0=
X-Received: by 2002:a05:6820:160b:b0:6d8:bba5:6589 with SMTP id
 006d021491bc7-7170f303df1mr1702563eaf.48.1794203356632; Sun, 08 Nov 2026
 21:49:16 -0800 (PST)
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
 <CAEEQ3w=5QwwvMJFJkpS51APoBjhed6oriCkvcieRdUFWrKtmSg@mail.gmail.com> <avFN7LbSK0q1gsB6@xhacker>
In-Reply-To: <avFN7LbSK0q1gsB6@xhacker>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 9 Nov 2026 13:49:05 +0800
X-Gm-Features: AclHuK-yA93Gg5bVt8kCNssew6sQnM_Z05Rmq56zAts1z3WwIhtyQX6D4YptSkY
Message-ID: <CAEEQ3wmViZNwxXr8q477yHjtABStEJecCHS8=5s_UAk1hYgyfw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/3] riscv: implement this_cpu operations
To: Jisheng Zhang <jszhang@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, 
	cl@gentwo.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bjorn@kernel.org, 
	pulehui@huawei.com, puranjay@kernel.org, thuth@redhat.com, 
	ajones@ventanamicro.com, ben.dooks@codethink.co.uk, rkrcmar@ventanamicro.com, 
	samuel.holland@sifive.com, zong.li@sifive.com, conor.dooley@microchip.com, 
	tglx@kernel.org, debug@rivosinc.com, seanwascoding@gmail.com, 
	andybnac@gmail.com, menglong8.dong@gmail.com, cyrilbur@tenstorrent.com, 
	wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	qingfang.deng@siflower.com.cn, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, dave@stgolabs.net, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Mon, Nov 9, 2026 at 12:57=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Mon, Nov 09, 2026 at 11:47:43AM +0800, yunhui cui wrote:
> > Hi David,
> >
> > On Mon, Nov 9, 2026 at 5:33=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Sun,  8 Nov 2026 19:04:04 +0800
> > > Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > >
> > > > RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
> > > > operations use generic implementations that disable local interrupt=
s.
> > > >
> > > > Implement RISC-V-specific this_cpu operations with preemption disab=
led
> > > > to keep accesses on the current CPU.
> > >
> > > Have you looked at some of the schemes (I think arm64 has the latest,
> > > but also s390) that do most per-cpu ops without disabling preemption.
> > > In particular they save the pre-emption check when pre-emption
> > > is enabled.
> > >
> > > Basically the code tells the scheduler which register contains the
> > > per-cpu data so that it can be 'magically' flipped during a context
> > > switch.
> >
> > Many thanks for pointing this out and suggesting this optimization. Thi=
s
> > is a very useful suggestion. In the common case no preemption or migrat=
ion
> > occurs, so the preemption bookkeeping and reschedule check are unnecess=
ary
> > overhead.
> >
> > Implementing this scheme for RISC-V will require additional changes bey=
ond
> > the current series. If this series is otherwise acceptable, I would lik=
e
> > to land the current this_cpu_* support first and then prepare a follow-=
up
> > series using this approach.
>
> Hi Yunhui and David,
>
> During the merge window but before rc1, I implemented a riscv POC
> following arm64's preemptible this cpu scheme. Each operation records
> its per-cpu pointer, offset and address registers. Exception entry saves
> and clears this state, and a noinstr c helper repairs the saved offset
> and address registers on exception return after any migration.
>
> However, my PoC is based on current percpu offset.
>
> I planed to sent it out last Sunday, but then I found Yunhui sent
> his percpu series(which is up to v9, I didn't know this before) on Sat.
> So I hold on the sending.
>
> Now would it make sense to rebase the PoC on Yunhui's series patch2 and
> patch3, especially the percpu offset optimization? I can post an RFC
> with this rebased implementation.
>

Given the substantial effort already invested in bringing this series
to v9, my original plan was to land the current implementation first
and add the preemptible scheme as a follow-up.

However, if the consensus is to move directly to the preemptible scheme,
I will implement this scheme in the next revision, building on the
cached percpu offset introduced in patch 2.

Thanks,
Yunhui

> Thanks
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
