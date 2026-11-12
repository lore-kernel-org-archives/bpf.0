Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484974;
	b=Bcyz1A1TwLiT7IZMTmp9qbEunGSRG9xi5SDFbCAkFNSHkBP82EaoIcPFdXz39mNPFSrZ
	 3LA4RstvUKRCpxWvyMMxs2nYEhUVOgGhkfMojfPhGr1ldcinjwX3A70CyTGHJbC9GLEUZ
	 EB3QQD/4jglJbi+1WjcicV7XG2JkOr6iWqB/LYBBdzzSiAqQGnJw63yQ2t+VJxO3Gsih9
	 TC9lMP7YwoEEx0zHK0S+Cx7BScM4mTQefSCAp7mrb6YVEObzXCkdgiSNBcoh8/B/2/TVx
	 4DcbwLv9/CDOX7Ak7dRyQW8ZMs/3dmT+8uaCHVIOgYCnlioq2ia8JM3LQgkyw+6mwWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f4QOZ/ziloNp1YzjgE4+Apo8LJ81vNJIp5Lxxwu3DGk=;
	b=5RKKv2lH53wB11D/xa402Olyoo7Wbkx7basAEWBD8qtEz0ZLhPV1RgUUtugbpywTcRTx
	 L1Mv/fGaoj1RIm1TX4gcVmvpKSM3w1+2EF0cEdm+8fGAzLzTjCenhalU1LR+dsqeh5lpH
	 bBE9qMpDlRtqp+DM2g4d+61/8kU8CE0Q8LtEVMrahbAjC6NEw+mnEUbTzZzZaIZZuW4qs
	 p7U3I2FPQ96Y19fRnCAnxhoeQ1VARhThHVcpMeDXelgxdFkLlE5TC5QfvmXCQuKTb4Giy
	 CPInzBPJ9hKS+6tECNElhjcPq9wIR/eKKNzhx84G0P5iV6rfarou6HTQCY+E4u52lUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OCaT3bl/";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B60606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17B60606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OCaT3bl/
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so2810817f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484972; x=1795089772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4QOZ/ziloNp1YzjgE4+Apo8LJ81vNJIp5Lxxwu3DGk=;
        b=OCaT3bl/FsF4u2GHgdA2lN1oedkz2/UEv8Oos3RDlLlU8ET813dd9aI1TVGoqLuZI0
         Cf3c6fY+8VCQcTHGfpyQJzRvmg4AjXLNyDipH4B+F8cQh0G092DJHFljEb4yd7nb1Mjn
         droxBfrL7V7QF8R72rr74a36DJ1cJRvw1EveftmQL3or0Zyu2flnwWc760kjJdADR9CO
         KSyBh2h8pY7CqQZCjmg25rtuUuMdf5lIbwhSjgV5kIMkoC9JUSmgEOV4A9Doap3qfC4z
         FmVB1+f+id7Ei1/YlTCj3XFJrUzCsnYTJB7tF7JVilKonM5SQA9p7pJbSHaP/duFOBWm
         zeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484972; x=1795089772;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4QOZ/ziloNp1YzjgE4+Apo8LJ81vNJIp5Lxxwu3DGk=;
        b=x6Ua9i3zhNPm2KnJ4dioqxrxmxIIXxI2ytumvTJuFgOoi1mMsbyrlY8hBwOHSHdRbz
         fs10HnHG5YvEqVv6P5Sa2IDaVmjXZCPk1Pw7B4d0o/7Soa0jZYmfV2cglwEnXKjOfvqD
         5bhbp/w2zf06TOB0noJMo1IYH8KfspO5mBM+vypxCna30U1JJEM8hw1mxnsDnXpHaT3/
         ccvlBtqKPHyhmhAgaOLGaDjxZMVpfXIq/BNwuXo03oLI+1i+uGOxfbba6X/2aWpS6ljd
         L9wTvbOGWvpbDO2uKKCGfFX2540zeJKhipeHQTt+1Mq8XJOrGYtP863Hvc/bHjkuydrT
         xlZQ==
X-Forwarded-Encrypted: i=1; AL+hErG4qxpVO9aD0acUauYPH0fv2kae5R/iovhOGJesFHnSNWO/XsANS6De8bWdu/8QuHG6xfM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jMbVSXy8dV8cMmOsj6jvUBZGz4E1hHJ1MwqEb/+UjvefTEf5O
	mJZ4oVNxdz6GSo4CnhjridWtVail5emNoyX8MntZs4XB0RBOtXV8DP/F
X-Gm-Gg: AYBFou3o9bVcgS1BG/QaCBAfxN457FaCVn2Q31kk7U+etpET7uDCUY8nNOTpB84tBEM
	ceJ+tiDt105bgQs3c+igsWJPhvlVdOBEF7A3yzmFn7bgcoY69rBCEHgl66GGkmNY6ZC2RqmInyI
	NROp2v2cxwcPkKwKx/FuXZ4rWWRdDd2TMoReQbxky/hyVYU8rhhsi2a71piSb003lUfD6OLLZ8W
	zTsrkGF1WFDucANu30Z34Sou0uwL42NzNPhk+2ws+Xvhq4/mMbHH4tPMYQ+YfUr8p26z9AVvVws
	RiCFLZNlzCA9OFm8pj/PUx/uUguqXZjlQfh8YI4NfzRZEKymnwZOZTJoRhNevzI8GVU/TfBcSDT
	bLp6MGhH7Rj23HqwA7ojaqoxoESgZedEAb7Lyj7Qh21viZnlGb3bjbIVuUMDEPbpHlQXUES+jvY
	oNZHJns0UXwMmLDuPG9XaAl29KKrl8Ckx7T+NdAavjxrvMFz6Fa1pBl+xDMcuqXiyiGPNlCGSKQ
	mxlR1+KjN1b3Kw8BMmTBKVb5ryfpn6P6suwsYHjXIE3i/sWZ1tF0tWxBRP9REe8T54ZEunm7EE3
	Nwe5gUeWp20JcB49Dbl/qz3hvUQLlTgRAcKgjNchXhxo9TUbaxVBLKngUtYO4HuT7A==
X-Received: by 2002:a05:6000:460b:b0:491:1e3f:a427 with SMTP id ffacd0b85a97d-499c898168fmr8711941f8f.42.1794484971757;
        Thu, 12 Nov 2026 04:02:51 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498367ba82csm16541261f8f.50.2026.11.12.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:02:51 -0800 (PST)
Date: Thu, 12 Nov 2026 12:02:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org,
 oleg@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bjorn@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, broonie@kernel.org, dave@stgolabs.net,
 jszhang@kernel.org, tglx@kernel.org, conor.dooley@microchip.com,
 thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk,
 rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com,
 debug@rivosinc.com, seanwascoding@gmail.com, andybnac@gmail.com,
 menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
 wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com,
 arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v10 2/9] riscv: add infrastructure for preemptible
 this_cpu operations
Message-ID: <20261112120248.5c8265e2@pumpkin>
In-Reply-To: <20261112104149.38589-3-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
	<20261112104149.38589-3-cuiyunhui@bytedance.com>
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

On Thu, 12 Nov 2026 18:41:42 +0800
Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> +/*
> + * Mark a region where the per-CPU offset and address registers may need to
> + * be rewritten by exception return after migration.  The three registers
> + * must remain distinct for the whole region.
> + */
> +#define __PCPU_GPRS_BEGIN						\
> +	__DEFINE_ASM_GPR_NUMS						\
> +	__PCPU_GPRS_ASSERT_DISTINCT					\
> +	"li %[off], " __PCPU_GPRS_VALUE "\n"				\
> +	"sh %[off], %[gprs]\n"						\
> +	REG_L " %[off], %[pcpu_offset]\n"				\
> +	"add %[addr], %[pcp], %[off]\n"
> +
> +#define __PCPU_GPRS_END							\
> +	"sh zero, %[gprs]\n"

Those are quite nasty with all the hidden variable names.
It wouldn't do any harm to pass the names though.

David
