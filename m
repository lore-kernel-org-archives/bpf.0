Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B047208B
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759593; cv=none; b=N59iHG3QD7y1yGg0N16tgmDwnCj7X9LDGMWL6T+iIuI9TWKS/rd7XqiUpZrJi1CSRGNa0t3oseImiTT2TO8jKOHkifbcdasGwq7SraJaRRPMPHhWuN+4aZsWePjYf0DFqGoVwkzLRpTmr7+/jeuD/1Uj180BMEl7Pm1m23UNCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759593; c=relaxed/simple;
	bh=qobQeXpRTl+w3E3Mgv+CXQ5I/Xvi/dYHDAXj8cOuJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dauPKI5+XIwKy5QQr/UjLLGzYhMvWpg4mqXHT2NpaOsIcyfTAlKkRuEJBYg6yqCW0gu6lsG4m14Sy2oJsdCfOWGwK2Cm+9rQp0HWM7/AXWXAUkwTmnt9zOaMjT+Ip+UsXrdlrIG1xeNB3JOP36VlewLzo9w4A64EDCCwO9uIYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5YsHlCJ; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5YsHlCJ"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b017a3be3so365997f8f.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790759590; x=1791364390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s9TKM9qGe17Jk+sMm66qJ+r/rf6R8Q2F3mXd7aggg48=;
        b=A5YsHlCJTveGuuwMcIg02wMWMGDawx+op2ft3BneTMnpeYWt89+kCs9CSuaCzbiiPc
         ih6EhpbBwEAxoGlL5/Ivg6CHreD0Hqz215hErRPcbFt94eeH8u2IDLs9SxRrR2Axv/Cd
         sN6/TF9WuB3tmcCgP/tq8MOCwfTzhM6Xre1Dna7OFXKPI+HiN6mU1sMR8ABoq5j6d3XU
         m3e+bJjwMWC0Trc5Lv1AhorOGD2YxekQ1wIqeUqlifH0O0IPuqTneKNJyYUKFKkkPvLy
         CHV0e/AqviseUqynkcxES+kZROEITu/pIOFCJqaNvcofcqXjLLD8REfp0tPoI8fLYm93
         WWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790759590; x=1791364390;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9TKM9qGe17Jk+sMm66qJ+r/rf6R8Q2F3mXd7aggg48=;
        b=qs5FHdcM13c2l8xinbsvBLykmMwlgJSKglX0t6q1VGcg3c090RKaLVo/4+3gDJA2zl
         m5+63WL6W/OtvLaDH3F87fDHDwg0o0de8YykuiDRQCt7zlMcv1rgmS9Iu0nuf947kl+R
         qZxm0hg3isXIBXhGpIHF6mRKAO/+1nf4kfcNsYSVD/W6psu0K4GklBCqKNqACtFoli5Y
         v3B+KXbaay+ae6B5bfBMTQIylCYBgFPzMs3kTsCm4v/uMkWfgfHzvHEecRlEE+E7pRLJ
         I+fLMD4WvR084RT5mulbVfJbqdGMlN/2iRwfXyWbpoNPiXqJbrUpKmocAjkgxBa1AiAa
         qdgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzq9MeO8jSEm8klBrWjOnb2bth7xClJBRdtZuLLeRVd8y6uU5QebHdKjnPtKuiWn/fHO68=@vger.kernel.org
X-Gm-Message-State: AFuF++nFKTcth1uX6In4+e+0RxJdiwYWkDAKa161LdBpeTql0iY/Rc47
	uK1PfsD3IuhzoU7wCiMabwfFVhQ5e3ssMRLtiXPp5q6jR1xqCl3JQZZO
X-Gm-Gg: AYBFou3pODyxnDPo3YMgXQ/vj2U4wLWw5bHSG0bO2oGL6968Xvw4S2jmMSd+pb8vT0h
	PT1A6JFuRPmV7vbA/p+V9ch0YH++Qyo9hfHzVhGZgA6b5RVvi3I8+ctMWhrUY1MCKuu6uyGkZ44
	xlNgEixmo6ewpquN2VHvvgFlni42c0RgZBlG3wTVF8BW3ze4+4rYAO4JFwumCA3IihD9ct9rP8j
	PnrCuO3iGyuDN13LAvSap1kPngvXjc7bBY33ETwEbcqBm8GUX5rbmFPasSPn9TUPsYXRnPMqt/H
	FCSnYqb/0R4AdTqKQ4ZYAlK5t6g5xHRtEB7VF11Zhh4YneC+caED6lXN5rq2962WVe7sxgBpk1Z
	P8FLPRkYa5IBSPmXOspwagm7KSRF91q+EVbZQPDi8XjvXyrbnyvbGNf//o3WcpdukJlsCOl6Eua
	+B2JhPJmn1vIyDsSDALeuci8z8NPr0g2TEvRqxWxtYfXfqzKX7uSM0g8y8nQhUC3MZZoeUrjDZA
	VF1bme2WuvhH4EyYukpxa3p6ToWvuOExXgBzRCjFE34PA==
X-Received: by 2002:a05:600c:3144:b0:4a0:1c0e:b136 with SMTP id 5b1f17b1804b1-4a01c0ec65fmr5393095e9.29.1790759589700;
        Wed, 30 Sep 2026 02:13:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174d5191sm41766015e9.3.2026.09.30.02.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:13:08 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:13:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: jim.cromie@gmail.com, Andrew Morton <akpm@linux-foundation.org>, Petr
 Mladek <pmladek@suse.com>, Zhen Lei <thunder.leizhen@huawei.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Andrey Grodzovsky
 <andrey.grodzovsky@crowdstrike.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v7 3/3] kallsyms: Unroll 24-bit sequence reconstruction
 in get_symbol_seq()
Message-ID: <20260930101307.4477e264@pumpkin>
In-Reply-To: <202609292329.87EE58BCF8@keescook>
References: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
	<20260929-ksyms-tune-v7-3-be568ceef41e@gmail.com>
	<202609292329.87EE58BCF8@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 23:56:12 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Sep 29, 2026 at 12:07:32PM -0600, Jim Cromie via B4 Relay wrote:
> > Mark get_symbol_seq() as static inline and unroll the 3-byte extraction
> > into direct byte shifts: (p[0] << 16) | (p[1] << 8) | p[2]. This
> > eliminates loop induction variable maintenance and allows the compiler
> > to generate direct loads and constant shifts.  
> 
> So... did you actually see any difference in the output binary? This is
> such a small loop I'd expect every compiler to both inline and unroll
> it already. *time passes* I've checked; I was mostly right. :)
> 
> It's already inlined and unrolled by the compilers, but GCC weirdly
> didn't see through the array math:
> 
>   At -O2 GCC (and Clang, mostly the same) on x86_64:
> 
>   before                                  after
>   lea    (%rax,%rax,2),%eax               lea    (%rax,%rax,2),%edx
>   mov    %rax,%rdx                        movslq %edx,%rdx
>   movzbl seqs(%rax),%eax                  movzbl seqs(%rdx),%eax
>   lea    0x1(%rdx),%ecx                   movzbl seqs+2(%rdx),%ecx
>   add    $0x2,%edx                        movzbl seqs+1(%rdx),%edx
>   movzbl seqs(%rcx),%ecx                  shl    $0x10,%eax
>   shl    $0x8,%eax                        shl    $0x8,%edx
>   movzbl seqs(%rdx),%edx                  or     %ecx,%eax
>   or     %ecx,%eax                        or     %edx,%eax
>   shl    $0x8,%eax
>   or     %edx,%eax
> 
> So it's actually the loss of the "+ i" part that does it.

A quick 'register dependency chain count' gives the old as 7 and the
new as 6.
The annoying 'movslq' might be removable by making the parameter
either 'unsigned int' or 'long' (and might go away if the function
in inlined).

> 
> > -static unsigned int get_symbol_seq(int index)
> > +static inline unsigned int get_symbol_seq(int index)
> >  {
> > -	unsigned int i, seq = 0;
> > +	const u8 *p = &kallsyms_seqs_of_names[3 * index];
> >  
> > -	for (i = 0; i < 3; i++)
> > -		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
> > -
> > -	return seq;
> > +	return (p[0] << 16) | (p[1] << 8) | p[2];
> >  }  
> 
> I'm on the fence about readability, but I think it's improved.

Ditto.
There might be a get_unaligned_be24() but that doesn't help readability.

The code would be better if the value were host-endian.
gcc 16+ then uses a 16bit read for two of the bytes.
That also lets the table be defined as:
	extern struct { unsigned int v:24; } kallsyms_seqs_of_names[];
so that accesses can just be kallsyms_seqs_of_names[n].v
(Although even gcc 16 seems to do three reads in that case.)

If the cpu supports misaligned accesses you can do a 32bit read
and an 8bit shift.

David

> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 

