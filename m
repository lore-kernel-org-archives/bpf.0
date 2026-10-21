Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541150;
	b=mPT9slWEDsZOPpsxx/kWcXfIzidy3CaHOFgPENwCq7GeC+oPKThkB+XumHT3ZcU6r/DK
	 s2ePp8hUF1hvzuCPsVKzz4+/7u6nH0dJglu3QD10F44YXsX7bUXd2yG6fdQ/snXKYNIYP
	 YY9d23/VPwmY7uXL3QLznxAI/FQg1ndn61iZrjoRJm99J8lxy4M/NXEt4RsGra2V7z1dE
	 4/6ZdhwXI2LRc4TvQy8FLbm+YmuNnXhMGv3AfUt1WuHyO71Ya4LodT9MdW2MgwYTsGAu9
	 M54ejUhwWYi3yerGSV1abqQFjZwakKBTRopIJydgds848xNXLtwkDAwipxouGqv6CGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=N8q5LZyzvsp3HuEskvY/uwzRjIYax2VBZZ0FBFZ6v8Y=;
	b=tm0ztV0aHPb5Ch03ILvt5ykzGfug//PWJX+aTqwMX1+auAedKji4kk8575H0sYN7c1JE
	 V8kBojrKskcbdEL97YxCfMIaOg0FfSG7CPzfaH+N6TbwsaaSj6o0dnxX3h6G7pSWqxA7a
	 HxWm/wPa2gcrtts/eBIoZfYWjROQRFf2BtuceiFeYc5dZ9D0i09RFeD7ljCprgozhvNRX
	 C0iK5WAcYP5IuyylS0V4wt+Gj+fzgdFdbuiuxx9vOwN3NuVYWnUPZOPLc2LgmcYSJDE82
	 jUBjmpkvlwH/b2+3htmdK16MDKeGogINp/nrl+wLaSP9Z61qbVjVQH35quAYKZ9Ts1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFdJEX0B;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A1606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320A1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFdJEX0B
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso31658a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541149; x=1793145949; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N8q5LZyzvsp3HuEskvY/uwzRjIYax2VBZZ0FBFZ6v8Y=;
        b=QFdJEX0BJ8DL+ttAmEPTPqvBHkp+5l2Zur9grPMmDCTYgmjPumarz+7l6Qrs6RPhJ+
         MkQOG7ai5fAQsedN46LllXKz7z9+WOv4uZLSpb0TatFae8Qh/DmRZyyT9heWAGnQcJqN
         068b4Vnq6N2pkrUX4lXD0AmrbARMONDlYgR7dipFBli58dWRYKuEmQLjvrCzpUSoylwA
         Ay0keoVOWTQlUa7nFszWqSHDTnV8EfRURC/uzemd+UFFnQxdos2TmD+xQUJ0V9Vkuglm
         zxH2ukBRAifv1DP4TRA/9BMWNfr7zVE5FsrJUYnySsqr2MhbnbQzCv4JgcoVNh16Gu6m
         20nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541149; x=1793145949;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8q5LZyzvsp3HuEskvY/uwzRjIYax2VBZZ0FBFZ6v8Y=;
        b=BwwyXMYH4inprPW/VIxpmvn8l7h7L3EBzVTyedGJjT/uK9xq/3+2E3RT2OHvCOMRfh
         PG08Y4dbkdC1qQHMCdAShP6dtbkELmzqrKQoRUx5gWWfliGFVGFV9Bjyq1KoOqN2zgTM
         KqDEx7QiHGhc7CeSE5CP54ji9MKIqsS7J5zFF3g1JHBqxpORCs721hc8IX8oYMmAP9u0
         ZNlt9zn/X0u40ECvvVugHQxLwHdKc2ZRKmLffmK10xseKU1O9661DQLje4wi1m0ATvfp
         AVKN5O8wHzWH0ZDrX/RcQa/eh3whug4xrCPjigDDSyeX2PcmKuyQKbm0UdxxoAxKaKQ/
         nJdA==
X-Forwarded-Encrypted: i=1; AKwUvByRFViCkWjXMruYiLbReDjhRM/rv4ItYZ8JXRYx37nMyJTck8nwJ5acbirZnDgv3SM3tyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOEfR5HZ1G7uAcryhkxpcvTY5YRsbgsYL2jn5VkARGaE0XwI6A
	AcmIgQYUvPZt5EU2FR8xBBeQ1YLFfYPoSmfiAEX6+/CW22V3ETF8kPQz
X-Gm-Gg: AYBFou3yzAjD02yZ1aGoCse/NFbdwaLo8B3iah1+K1luNizoGRr/dVy570GcJkoDBIS
	fpdxdTGhZUXxOzQ887QsPM2g1UOmjWKLjLyDOFtX78qtRZBzUgpg8JeiASgZYmSTbgWCLZiBQ4C
	7wAjedfycGBogsWgcsAnT6+o5w0OeB4Gzlv/g3lXLZevsDJ9BSblgM4yJxEJN9r9msi4W1wYp/2
	BPvz7Ncf4X1fLaqFJ4C3ZqRZA2ujXYGdfQyilUY+3ToRjFqC5i1i4/5X/cG/8yFV4TiU8OIyqlu
	DhtbEXF1olZPsBZlOOp5KZTX/7XroaiP4h9ABvmzVp3gVk599AGJqLCnnBF8DodMP2XAhVck/f1
	3R8XJURs6OJ05/U2BxTt6rtZBTciwUyGZHc4PiQ7BYfDJhlUbKpcuQIVYjsMW09RLrnTEwBmkLe
	h0tqxzy/VoPJWkesP9PtXOJ5ntFMpB9Vesh5vS4nxyFWUoS8QqyaR+3A4PXYszFolgp4JcSMl97
	voUf4GMj2+G5HhkVvWRaaM61cCTcO1IeXnImMa5iehT1LNGFkr6q3ms6Imsk6dFzb0dhLhbjlLp
	GPhnywBIybePqSnH1v/7+AaZn/qK1Y6ute2m09SyurcymSe/tIPXvtxNt5AHlw==
X-Received: by 2002:a17:90b:4acd:b0:3aa:f4af:1e16 with SMTP id 98e67ed59e1d1-3ad86b0c705mr405238a91.7.1792541149462;
        Tue, 20 Oct 2026 17:05:49 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8085ede9sm1452069a91.0.2026.10.20.17.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:05:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:05:48 +0000
Message-Id: <DMA2SZ5PRG4N.3I51MHSTWUUTS@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <ameryhung@gmail.com>, <yonghong.song@linux.dev>,
 <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Track borrowed iterator results by
 default
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>, <bpf@vger.kernel.org>
In-Reply-To: <20260927120406.1041915-2-xyx2021@mail.ustc.edu.cn>
References: <20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn> <20260927120406.1041915-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Sun, Sep 27, 2026 at 05:04 AM Xu Yunxiang <xyx2021@mail.ustc.edu.cn> wrote:
> Propagate the source lifetime through trusted field loads and dynptr
> constructors so their descendants remain in the invalidation graph.

The field load part is not about iterators.
check_ptr_to_btf_access() now sets parent_id of a trusted field to
the reference id of the pointer it was loaded from, so

  file = bpf_get_task_exe_file(task);
  inode = file->f_inode;
  bpf_put_file(file);
  ino = inode->i_ino;

is rejected after this patch.
Explain in commit log.

pw-bot: cr
