Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197174;
	b=kHLE0OBSs0x+ov890717lSt3hC3TgFBjw8aSEHpZHQbPxRPkN6dYTLD7dLo42vqDJbwC
	 Qox79WtEuejLWRzhYtUEj4dxsWeLehGkhFpFNplGmMObJNqrqLWewhtqOKd14x1H4lIr2
	 c5GQ9t5+zM2dV+5Yo5EJtzwgKM26gAIiw0AqGqa1dMw65SLOJT/XSTaJDjtkQNcSC101f
	 +RxIzZRW0MGG0XDnXC2ZGhTbyJE7697eHUQHr40t5P0K4tETaudonvBqW8394MMfQa+Ki
	 yQxzliuES9Y/40GJkWKAqIGnNddrEaB6pfsCymIuGuBWegwfTy7WRtrUx8VjHj5PsZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BH4blVO7lhv7YIvZ5PaNsfMa7mWDwoq/n8pgt0YXvZs=;
	b=n+US8cgKsihrLo9B75adAq7XuG1KgkQ1UJEjYjUbxSN64BDOh3U2xAMrC1GOOkD8iUIN
	 /NmxA17NKE4PwqzCK1wJCDgLedsGvaLU7nQDnJT+aHvapD4wG2FkdVE1MsxIzqyh0DrCq
	 mqptdDwTV+OtgnOED31XJRBuV4pIR+53hVjI93wXOdjhDlj6gf3SHZ2YinqekEw5M+8IK
	 liZdZNFXL3QUSOvB+8x21AMFJ2+U+qfwwJc2BjCs+KCLZmze2Mpoxy7yFVMAu5Qk/++ZM
	 1mNGCT2D0FLH2a02VGRNs1QajIbUoWH0gDaRo1kjN4fdYLDc7s1R3gi71HKC8pU4s+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SameDaVI;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A14606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 17:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A14606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SameDaVI
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f020d0169eso6412785ad.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 09:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197173; x=1795801973; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BH4blVO7lhv7YIvZ5PaNsfMa7mWDwoq/n8pgt0YXvZs=;
        b=SameDaVIHZHnT0teSNesvGqqOiPOOHTPvVstm5QJJqiWD3gfel0grXntcJsiSURTgq
         SJTFbvTph23cy/r0LUoNMroWkwp4Ga9a/sNTCxr9dCGuiDYuy8hh8ALSYlgcNYtJCPT5
         aT8LdJGyJWWb+fqTjbrqFbTvGj939nWOkxuBWz09uyFuaQIhDthA8HDIr5FItzBjSEoF
         gJLSl4mRcmMIFeRNGXe0iFMrSHIGiEUaBwnnegc/MrAOS/BYcuYtBuJeI3xUXTG1XVu4
         zpD1e3i0nQw71Jee7YEk7e/y5AVsAnucY36MkTl7Mqs10uVm/JjW8L+i+g8zLmMPnvh9
         0Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197173; x=1795801973;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BH4blVO7lhv7YIvZ5PaNsfMa7mWDwoq/n8pgt0YXvZs=;
        b=seuEuO2aNKzsPj2stwnfSacNwQZbvAGLamiRfXJY2gMqVFLuPtKWDzx4FiEoU5uTNY
         CrNSfZo29bBQsMiTZIztVDSHT4EcB5PgMZzMd9giRt4ySolGpWS6srJxa1ngK8yK9Wbv
         qYTdTcIglHK164PCJecE+UEU/SXxrJivTFTnGH4JKKHFCqEKgQtkinEBEOH5w7WZYCTW
         MDCU4+w8323KEF7ObHLBxIRIzo6OGXd4urrIsM4A1WeXXQJn4LW1f1/Q74paXemm/SOm
         pbFEgBUpC6IZcW/ItWPB7a/t2I7NFDe5rzv/+FXK345FxKvz5Aq9K1P3Xc7BnHvYc5VQ
         dyXg==
X-Forwarded-Encrypted: i=1; AL+hErEY9lgEPyegeIFJemvie/3TLK4oaPhRB3m+5+pCyq/JE2XmhdilafxmiPxkHXlHNsWoaCc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tPq9epAMRFSwco0ht6Ge8ZxYK6t7p/i5weTFsFM7WTdhuPp/b
	r55EFQwivtzMkcNDJHX4V0eMaghTtCTfH99fcF5AQmXcbE82ReLVOQyT
X-Gm-Gg: AZFdTZfFSNaQKaKMLkf0eHp2beLEymrlysFKVFR7wTPoU4Fn6d0+b5R4FJgXxPcQgs5
	1WvKvkukcXj+hWVEyXjEX9RmPz+l9AkI9PetNNnrearbx2aFiBnG5wHuCOl7OWBQ6ktfFI1xQ1q
	C04KSHl9T3IT4CpNHx/QG/Tthhempc77wMLgELQomIlzwUbYZ/pP2IpyjABFgg6sx5KMEH4Eiua
	je54XydAF0iqPlOnLZGFE1/6xiUPvpuHAJee1lY1boziZdor57NJRg3xDFh50pFdGNDbSEioZW9
	aGUjdzQxYXEH4UZnVlmMpxy0S/axByZ88yD3NxkKhwNLGMS7vA/tyCu/xBMYx1OV0HQl72nVnK7
	R5LcQAb+w0rssVPUtVWoiAXLvoC4eV7jwTgNMUsCiq4QT1YYXDWvm+53fC9ZzRCwTRZQCkHFg6C
	oysy2q6w1kPNUBxjYXJRZ2qD1NZ6AEMP0QWgJyZMmLYBgLZRRkNcvtzeEupY3KhjB/OWv1WbJMd
	9mI5614FgsDw1odojtwW+oP6PO5bmh9rl3sa55gnA3Flk+mNyskNxPfn8dhiuFDWVXkG7jDAf4H
	hl3Ubtcsbj5oanfq0fYEutTklf2oHLlU1dJRV+6nv/oiLU2+MEHz6EYgJlgnsEu9ORH9fRj+5OY
	B/9/aTUwCLJ11PKemZD0b1wQdxfsjps4cmQ==
X-Received: by 2002:a17:90b:4d0a:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3b41c8fe860mr3506076a91.26.1795197173128;
        Fri, 20 Nov 2026 09:52:53 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad47091sm5190333a91.10.2026.11.20.09.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 09:52:52 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 17:52:52 +0000
Message-Id: <DN08ABWGIAWE.3SYT0JSL0HJW9@gmail.com>
Subject: Re: [PATCH bpf-next 21/49] bpf: Compare states by join_key, then by
 value
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-224719@kernel.org>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com> <20261120074430.2704488-22-alexei.starovoitov@gmail.com> <sashiko-outbox-224719@kernel.org>
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

On Fri, Nov 20, 2026 at 12:22 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +		/* it can be filled into a register that is unreadable */
>> +		if (old_type == STACK_SPILL && old_slot->spilled_ptr.type == NOT_INIT &&
>
> [Severity: High]
> Can this leak a spilled pointer when !env->allow_ptr_leaks?

No. Patch 25 adds the join that makes such a spill, and it makes
__is_pointer_value() true for NOT_INIT.
So the atomic insn fails with "leaking pointer from stack off".
Patch 47 has this prog as a test: unreadable_atomic().

>> +		    memcmp(&a->refs[i].ptr, &b->refs[i].ptr, sizeof(u64)))
>
> [Severity: Medium]
> On 32-bit architectures, does passing &refs[i].ptr with sizeof(u64) to
> memcmp() in same_refs() and bpf_hash64() in bpf_hash_join_key() overread the
> 4-byte void *ptr union member?

Not a bug. The union has 8 bytes on 32-bit too, and the compare is for
all of it: parent_id and ctx_arg, or ptr.
memcmp() in fortify-string.h checks __struct_size(), not __member_size().
realloc_array() zeroes a new entry, so the 4 bytes after ptr are 0.
