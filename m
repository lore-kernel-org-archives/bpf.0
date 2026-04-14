Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937B3E63BE
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177380; cv=pass; b=Vm6B6nSyk7jMk1aa1gZccSV+DB6Hr1BbmLpUU5912c6Z1tHb1h7/uzojunZx+OW9k6YyJSuGk6L60S4b1KRWjK1Syy/JZB5jcWnM40TxeyDSGbXMYeKPimPSntUJA7Q0caKkb380T8jPo6fCINs/uw5fqdxJpN1rdtFin5OcWAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177380; c=relaxed/simple;
	bh=AnsEV6VHaHqEew+Xa56Ltrfs2MD3YtoIUeXjaty5EkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eV5IxLN3fcfJCGE01arFh6vgNhPNtRkYVhM16dhAKotrdrdAMztwl33611HHvb8AXE8g52u3S6SKY66k9yQD2KbiNYOqqJkWy+IkOl2FGVqRVfDTgBPx8wAEd6DHWLfPF040Kqeej1JCN9dgZXjNDR8y2Jyx7Q7EcJP5DawThJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUlTTsC3; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUlTTsC3"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfd96354aso3352963f8f.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177377; cv=none;
        d=google.com; s=arc-20240605;
        b=S3jHq2CawCb55MLd/tP1vDw189W5sKBtYfkbl2oMIg+9jjmjikIqjD5nxv1UIhY40d
         GrQNYbfpzMnvJ8J1fv81p++WGUpenDHlvtPRp9MDzj/1uPDpMnCkLst8mYedkNjSrn4x
         P9HlSzgJedqUA5loV29VbEiss/EGwSARzBV/exRO8QzPaB4PJ6vQuNRSkZjLPizlRF9/
         UqCS6wOLuFGNERLM86zOP86YR3X77utVHjmdLZ/PfSW+lQMF/rzur0NFQu1783e9vaZT
         PcFvdPEdZuuRnSNTqVgwscEAMrgDL78rA/uOveErAdXI1OlFbEKEqdCB5W9yZfH3bV/J
         MfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AnsEV6VHaHqEew+Xa56Ltrfs2MD3YtoIUeXjaty5EkY=;
        fh=jstbK+bGUZwbf8o2Jcu5XJlszY/wQr2TsvKfkvgWyV0=;
        b=ZQv+G+oXi8uLJY3Mya4i3T+/ngQRvqpQnKTDCJZUIEyUC7Pvl0gSH47aUarnquEOy2
         3V86Isnocvr63JeYSptHr+xW170Pek1Il68OTJSrGuD35gMxrNtR8ZiqCUjAZ9sW1YIP
         XhSzA9+ydjZ4/PD7EvUXPVnFwn5mZ9BQ9tqNH+tu4/q9H93Zwmrkzh/+PZlrxU5d9h3q
         EQKWIlBhsqXWCjgeeDiQv6nXfUrwXkTFHeynweTfmsWGd+LZfkCmSV4vAwPT+1EQbpou
         0q0/n/GhrTx4gI7TYbaRUwKlpRIealgTbC6WHLUzpJxFiIkXFQxEjtFoCwCLuaD74k/P
         tBjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177377; x=1776782177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnsEV6VHaHqEew+Xa56Ltrfs2MD3YtoIUeXjaty5EkY=;
        b=PUlTTsC3aVAA+ZyekIkeHjny6kIG/LHQHmycQcAXH+odg5/6txPL3MKJH3GJyCQkHB
         0VHbMgZt+XaHaCWA8ttAcZZRvO9ODJnXuOO+uOmKq04OuxGu3oOF05P46AdjIMAgq75p
         1g2iSwJfqj1jIgnuoynfpGVWG9myXYm/pK7dBPifH9KZ0tNoF/wBaemcMV1l1xlz8J3/
         ZWuFPRlIE6qzOnT4UWRA/IGRTHcr8Y3+4IdOq2AILgI1Oof/ygFLMrlBqux+n4oEboCa
         Je1BfpUWrlRD9q+IG7jTww/eAr705R3WQH9YwLOz0cBjR8AkMQxl/K7pKJ6lWajvDIts
         hEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177377; x=1776782177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnsEV6VHaHqEew+Xa56Ltrfs2MD3YtoIUeXjaty5EkY=;
        b=obvQjya/63qDXK5Mkcgh4+qvfXH+IORzQ/yLL1+W8GCEvGdi9RrTqNfyuQ6J/L4XRy
         xHWytAI15A2dYpaZbi77cMLXrjCNTd1wsZ2C6V2zk0ys7pkPJRKkS6jVH5uBF3TDDo6y
         +0fzm+x5KWXKsJjDY8GlHYsw3djb+3F3ybk6uwsewMF9Y2dG/DDT0HGU8o2bLQHo+QYr
         mvlxOZ4SjTxZ7ltwaKtEfcxze9nyVloBLMvPUQ0WapNli2QE84iDyOwgTpXNeKH+2Yho
         npO7CqW1Y66d02pqTDaHnID/Sz0465XvrF7zEa7yTUXYqU6uYHVBdg7vkS8Ysax/6d/m
         Db1A==
X-Forwarded-Encrypted: i=1; AFNElJ/5ZXeNyDFJuL+dCLQJ9PtQ8oz3JENfEZ7oUzWaU7tyc79EdCCEnx5JhGZ2qlZCrSBgSgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Kd4TzmgIJghO4K1goAzlVEh5K01g90tkg0HkctjyD1kpj4rT
	NaDVg+73im5vDQUtgxb1SWOyLriggDzsHpOY/N5UVsI2ICmTc/AeX+7Lty4wZJfnMXZtu8vvzjK
	6L6UpkFrrIkmRaHK4eWkjSCodoMXPQJU=
X-Gm-Gg: AeBDiesa9dILhW/rkAUYoocwEPWw/GOr+zg4Rubh/u8h3EDKoIuhvQyxNxckeeIfzAw
	KZEveEaLywkfAEdaxmbTUb2oJNFOh//pzeQ+KHU0aO5x8xJ1apqKOjXo0cJBOXPqhfS69eUFWxt
	8q2UoSs2xjAe9BcacL+M10KafCQTX5M9IXHrrLJwytf55qQOlsQvxjaQHo1NbxwVRNmwcNMK/tN
	MscOX3yFtN/W9boI36Ux3gwgFv995t6DxmWwmF1G1jBb7KCLogil+/jD8n76wep5LQfje7TaHbu
	cg7OJn+JAnnwCSY6iQtpmL7IZuR6bYv8mzxX9wb+qWbtLByeI3Lq/xWEMBuKjKOy6Ilt/fnwSRb
	dpAhSvrILarNdE58w8IM7C1xiFA==
X-Received: by 2002:a05:6000:1a86:b0:43d:6e0:9458 with SMTP id
 ffacd0b85a97d-43d642c08b5mr27685966f8f.39.1776177376758; Tue, 14 Apr 2026
 07:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com> <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
In-Reply-To: <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:36:05 -0700
X-Gm-Features: AQROBzD11iC8gAKSEnmD0t_Id88yG4ZENQr7azgzst5W9dho6pOaDHcgJ_Mytlo
Message-ID: <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 6:13=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Andrey, thanks for the prompt review !
>
> On Tue Apr 14, 2026 at 12:19 AM CEST, Andrey Konovalov wrote:
> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Found=
ation)
> > <alexis.lothore@bootlin.com> wrote:
> >>
>
> [...]
>
> >> +#ifdef CONFIG_KASAN_GENERIC
> >> +void __asan_load1(void *p);
> >> +void __asan_store1(void *p);
> >> +void __asan_load2(void *p);
> >> +void __asan_store2(void *p);
> >> +void __asan_load4(void *p);
> >> +void __asan_store4(void *p);
> >> +void __asan_load8(void *p);
> >> +void __asan_store8(void *p);
> >> +void __asan_load16(void *p);
> >> +void __asan_store16(void *p);
> >> +#endif /* CONFIG_KASAN_GENERIC */
> >
> > This looks ugly, let's not do this unless it's really required.
> >
> > You can just use kasan_check_read/write() instead - these are public
> > wrappers around the same shadow memory checking functions. And they
> > also work with the SW_TAGS mode, in case the BPF would want to use
> > that mode at some point. (For HW_TAGS, we only have kasan_check_byte()
> > that checks a single byte, but it can be extended in the future if
> > required to be used by BPF.)
>
> ACK, I'll try to use those kasan_check_read and kasan_check_write rather
> than __asan_{load,store}X.

No. The performance penalty will be too high.
hw_tags won't work without corresponding JIT work.
I see no point sacrificing performance for aesthetics.
__asan_load/storeX is what compilers emit.
In that sense JIT is a compiler it should emit exactly the same.
