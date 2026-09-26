Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78AF3A3E78
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790408709; cv=none; b=fIiPraWjzM0aXlAdpX7kiNrJUSFRMmjQb4U6yURQo7YTJyt/pRP1GQXcFMoPq795zWEDEnCE0chH5mRpfmvx2jis06Z+QR2+WN4uzG0OggFMJKV0RzxeZei1cMad5bnrssDkgo3KaPmWEU/TliC7QzJW2NjM3Uo44Rnlee+4x5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790408709; c=relaxed/simple;
	bh=ABbBkCwR1L/1FDbrX2Y39wbgpE5rQTRqAmD8tEgS8EM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=iVsNWqHBi8bDO55jHRwLbZSXMXBWnZWwqrVDYy0wGiUhwRpqd5hZSDzt+hSguC2vC6h8pImkJBO2qvrY1A8xkzHm+u5WXQvmbhAVxIxpV2GDfT//VWOQRZaZPwu6U95dI9XgAuXdrq+Nq8aKXO+IAm7nHWU1TPmQZwkOV4vutkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdJXl6Lq; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdJXl6Lq"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1017504a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790408707; x=1791013507; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LCtZEcIvPL3Lbhp/UPKAeuQpnUZP+5WCOvYmqhIHVAE=;
        b=bdJXl6Lqu8/jJCbTAR8TIuq6Mm9idIyDw6zmpRlxvfOMiQfpm8dKXh1ezzbcvYuYAr
         HRQqN3Y+jVWbQhsbKfm+rJ9R55hObUw90kvF6vT6rjhjtbhzs4m0/qlTuGKNS2PDG1UR
         JMnHgBQ8Pzx3V1hwSzTAiMSoaFyZeWBVfkQazxaHOEL0A3yYJnCnyaQlJlYwawIOVhov
         W/uVHUJoVHUMs/ZsUPqwcLDA2WIFv4gFA+wzMx2sn8xP72V9GIAXBds/YNNsrRVpnwQR
         +BMHhppQ4fCT7Y5RHgXQZtc9zyEwb3eV32bjSfjB5TJ1iwaK+kvGWGOo0Go5EL7rW8Ej
         Tmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790408707; x=1791013507;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCtZEcIvPL3Lbhp/UPKAeuQpnUZP+5WCOvYmqhIHVAE=;
        b=Sfkp/Mfx5tLPTYlaImZ6APA3ppJlrdZy1xCmmnmggIesejP4ooOR585LW5vaHipjnU
         CdXbrikQKyp8H1Hwvy3W1TwQAu1liRzjiD759jrlwPvHElfd3mf1iOAPRphr5R5PTlsw
         lEw+N5XXBhLJz3Z2NquLxfWlAzYz+WZuRJK6d0Piv3FYZeOthbFOS9iS+/zelnZoouOY
         xkYGfS4o6um1YPKhS6RJER0SUzDtDzy9y+HMdqJGFRby9qZLv2wLy/oOLy4oJgAAdos9
         5S87N9vLv05NcgsSS7mLi/AguJbpHhJy51aBvbIiEGyIpS8beXv6+u9tef9NP+B1/vlI
         oTjw==
X-Forwarded-Encrypted: i=1; AKwUvBx/+DJU6sodR4njA0yMJmRT+NktkYgYOglPHKcBwmuovmw9NuHL1bZhPEuDh06F4X/ON9A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCYhF2DSLXwViph6WitIxHB0t7/+3nuH4QCCPbBVtlHMg46sSm
	vpu8my/Sq0Rg5v26WB+CmTQCSvcKnfczaQ2qzsRtP3hXnVxI4q8FYdON
X-Gm-Gg: AYBFou3N7HfyIGLt7Vh+dHW1pDUvop6Ay2n/jOyep24LPO+rMKoJ77MK4T5Zs1jWxmF
	1qeER/bQiTOIJKrCDX9VJ5yO5IvXIY+kI5FImG/HQ4r5+V9RaG5FxA+gA0RJDsZkeDDl0f/ooNI
	adbpC+7GracRaRRnmUFBoM1hPYuEryVJK5vwYcqKeK/lM+Cy6kRq7G6dn6DNtUwc+TG5dVtnWtX
	Upxyuzeg5Cb7S7kiqfpYpGRgVIl7isB0s2WUKTA4/cfSVc2JpJukHQKBqZAbpUhASc4oUIgvNbv
	/+7cXSRtxX/u8zSM5YzzzLcSWSmnG/nFkBg0kUE4jELRPEgZQsPb2OxKo9JhIXYdSIlwiJ40nhw
	kTxtd4rEEaCEjun+288GdRMx8YWBN+Enpl7LFOw0XdKZbc/+0KZW9+WJPud1UQaFT9Ayxoz7E1e
	y57yUoYdjkKQ1yG07FdPSRLcgq8G6UHMf1Ndl0wJcQZThXYRYkpVIWm/sLYvqGjB8SzC8rgigwT
	QSzXDGeGKYgElgCfZbJzrzovu6MW3zie0J5Qv/up3KBAhbeCSqgN+vZr3rzj9mUAPI50cQY+QQP
	AHp9rS8yyt4rjP8=
X-Received: by 2002:a17:90a:c08:b0:3a0:b3f3:a2df with SMTP id 98e67ed59e1d1-3a0b3f3a396mr2867019a91.13.1790408706906;
        Sat, 26 Sep 2026 00:45:06 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589bbfsm8695818a91.9.2026.09.26.00.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 00:45:04 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 07:45:02 +0000
Message-Id: <DLP2WZASF7LP.18SWCONJDR4LV@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, "Alan Maguire"
 <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo"
 <arnaldo.melo@gmail.com>, <dwarves@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <kernel-team@fb.com>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: Trust the entry value
 register over the first location entry
In-Reply-To: <20260925213619.2187751-1-yonghong.song@linux.dev>
References: <20260925213619.2187751-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 02:36 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> DW_OP_entry_value(DW_OP_regN) says the parameter still holds the value regN
> had on entry to the function, so regN is by definition the register the
> parameter was passed in.  That is better evidence than the first location
> list entry, so prefer it.

my bot is saying that this is not quite the case.

gcc 13 -O2 for

long f6(long a, long b)
{
	b = a;
	ext();
	ext();
	return 0;
}

describes 'b' as:
  [0x40, 0x44): DW_OP_reg4 RSI
  [0x44, 0x4c): DW_OP_reg5 RDI
  [0x4c, 0x59): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value

pahole encodes f6() today. With this patch loc_reg of 'b' becomes RDI,
RSI is expected, and f6() is dropped.

> +	if (entry_value_reg != PARAMETER_UNKNOWN_REG && !parameter__has_piece_info(parm))
> +		parm->loc_reg = entry_value_reg;

This fixes only the functions where clang happened to emit
an entry value. clang -O2 for

bool g_lazy(struct task *p, bool lazy)
{
	rcu_lock();
	__atomic_store_n(&p->lazy, lazy, __ATOMIC_RELAXED);
	rcu_unlock();
	return lazy;
}

describes 'lazy' as:
  [0x09, 0x1e): DW_OP_reg3 RBX
  [0x1e, 0x21): DW_OP_reg0 RAX

low_pc is 0. There is no entry value, so g_lazy() is still dropped.
With 'int lazy' the list starts at low_pc with RSI.
Looks like clang loses the entry range for every bool arg.

