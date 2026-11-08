Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173578;
	b=ZJXBkJfERajjRZu/+TB+IUDtHUW1y/519yVAEwINC2prLn8fIW68mXhQibHl8hjij6pZ
	 pgDw8i32cZqGIKDcGQNcKyC1JWmDuzjPMQv+RtocoF1xxff0jpb7yEh4qI0lq0Ya6yxJ1
	 micUSvfO+pZf2ST+F89JnPw7AtanuPGxunOLuRdDOvQdDKi9U8UJupWsjGhr6JcPMuyk/
	 1TrIV9M1oeQXfznZwD3dHq9XRD+Zpz0sai8KhABNXQInB45eCxphPyZe0OTa84O/YrjnP
	 GwLCT3cnOaz0Ck8Nw+GJauACbR06N+Bf3srcr54YRkXoLrX5Ma7ETjERmMrsgKJqU+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2zV+j1o90j03z3/bSKQRAMr2OAwRnzRNXDWN23pKxKc=;
	b=xzJ04v8GecShNOeJJUUBuhN4TcN7izN4W3jB07/qXW960SgiBaix7AImfd+kM6s6GD21
	 wefEYn44NJ8NSdUzYyv4C/VpMN+XskFSrXP/yqUz0LvMH5HTBpHLb0AhyxcU48rXkOvwt
	 R7llbNX4vGPcOVqMLHG0QMe4d+ANgYNuqk93+BOZPS40Zvod417wAkqtGaFY+Sa1JmbF+
	 e8UcVDv83RB6bW8YwtniT0L10GQa06121FcOtrqlbCQTQi0A+CAWtjCHR/J3rThEML8mL
	 s2AO9qQMEFVshhXTRRKBI8jQXrundgec0LmD8Vh9r1puqehZfWMoptbZk5nO6dvdI6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1thKR+m;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D86606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 21:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D86606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1thKR+m
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3edaso182160f8f.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 13:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173576; x=1794778376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2zV+j1o90j03z3/bSKQRAMr2OAwRnzRNXDWN23pKxKc=;
        b=g1thKR+m3D3E2+c4hjI7QL3t50zazlEow2f3cU3NWSOcbViKGU+bFhuwrFyNJLKhd2
         zHYXQnPFcPXe+OTWCNJAX5Doukw0IgV0+hx6/2omnjkeERyku7Qd1BPmTfG2Ec2vQYCj
         jBrOKkbpvQg6C2Qm/j7T6X8EjF/sd57iirCc6AnfscRPrdsjvNwASYBi0OE8oqXwYdCi
         zJl7umWLxRBDsqPH+gl3WB/UhcHVkpQHMEdZEB7hHpJ+Hv7UTPn8Nlv6LyoVls54rMcg
         mIo87yVqR5TSb6XzD5jEPo2n6Qli47aCR0sHQax0ubMztuUql/507jGMoGih3Wy2gIqR
         MqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173576; x=1794778376;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zV+j1o90j03z3/bSKQRAMr2OAwRnzRNXDWN23pKxKc=;
        b=GVeCB/k1QahlZpQOJnICqeNNUSp2TDSz+e8VKquzUX4OguOF3n3rTWagmT56Kx2LtT
         n19p5vSrbfzbxdT6N7PP3RxhZfGKQyudZekkYKgE7o9mYAoAQ8YVQZXmuHnuM5ahWYZQ
         WWDsTj7wV5Ye+SREKSdhSfC/rrbf5Lk3XYYrq1+05s1krXKdV1Uh0Djre3qGU8gD+uwY
         nppPDeCq7Qo3FYpNAleOH1mY3ZKHRh0xBJnQXsjT992Y/b9kzTN67ih9qI8ApHdfGyVH
         Fz8Z1/3FzVaXlfpxmgsnoVcHfT1f4N6lwAdbbmi6gFm44mGkxLK/Fbz2x4NtLPAdtwuG
         v09g==
X-Forwarded-Encrypted: i=1; AL+hErEgbyRygxL2wb6Wss2DIatkv5hAzZ7x5dgPhP3feDjhLz14uJLHgWBhmFoHPtnvxkg8Nf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ePnoq0QL2sE8/v/14UpK7eHM1LqlbePk2lg8bTdd6r+rLm9iH
	LyGEc20IMgKgxhFeogOrEyS4UdQ0WBjmUxaXqK8VNDP3uy4qoqzwx50E
X-Gm-Gg: AYBFou3p/S4e9yPbPUgRtHNLud/kIxCCA1iVFgdhK4+eaYIovotzgp13lM5UqcpGrdg
	iAWMbRU2Ll+4tM70S2ZArElEYP6EStcZimd3qFeKU8TELQNATW/TnzodaUtpff6hjVzBfS2a2OA
	LUcFZFg2yqU+tlP7WBfDkbLg+zVto718vEvKSZsFK9vrYxozeigki3pL7/97DtmxwnrwGZWknBc
	FtRb1O3ukejak5NkPoF/qnPgyHcnG/t8P5pANPjzNKp/9IZ39N7Qw3rdPqPhao0luhlNTet6Fmk
	dKu2JHlJgXVCw3WC9VjTzpjal2jPT/WS+C28Y4wtpEH/+DKH4STWHHNmSXcq1xYsyWoudVa+L1j
	HdHyLuqOC+GNYbb4vHsYaTzFdwqxM8TXyQ3L/bh91FdKpueDYQzPfHl9jXAK97qs+MXUVlO1xlT
	4HMPQgSSpIo4+dD4AFUE0xbJyalZKPA16A6kNqtZaP3zqr8sVfy/vi3TqzfS4k/4WNJNZ1Bdf+Q
	ta3oeJLNfRvq22WBKnct1KxI+FZZlzGNL2y2ENmD4cWhwS4mdNIt0VUhZbAfg3xUdcFmgDESSwO
	XvHiexW8Iqf/dH9NeDTeARlaB6sPR1J2r1mcnmVHUggE4Gf47kJjISbVmDqM6bZt
X-Received: by 2002:a05:6000:26c8:b0:48f:bbb5:61c2 with SMTP id ffacd0b85a97d-4958852d3b8mr5479500f8f.4.1794173576292;
        Sun, 08 Nov 2026 13:32:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597371cc4sm5861840f8f.36.2026.11.08.13.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:32:56 -0800 (PST)
Date: Sun, 8 Nov 2026 21:32:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bjorn@kernel.org,
 pulehui@huawei.com, puranjay@kernel.org, thuth@redhat.com,
 ajones@ventanamicro.com, ben.dooks@codethink.co.uk,
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
Subject: Re: [PATCH v9 1/3] riscv: implement this_cpu operations
Message-ID: <20261108213254.67805ef0@pumpkin>
In-Reply-To: <20261108110406.97495-2-cuiyunhui@bytedance.com>
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
	<20261108110406.97495-2-cuiyunhui@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Nov 2026 19:04:04 +0800
Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
> operations use generic implementations that disable local interrupts.
> 
> Implement RISC-V-specific this_cpu operations with preemption disabled
> to keep accesses on the current CPU. 

Have you looked at some of the schemes (I think arm64 has the latest,
but also s390) that do most per-cpu ops without disabling preemption.
In particular they save the pre-emption check when pre-emption
is enabled.

Basically the code tells the scheduler which register contains the
per-cpu data so that it can be 'magically' flipped during a context
switch.

David
